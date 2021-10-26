CREATE OR REPLACE FUNCTION public.requestrelation(:user_request character varying, :user_to_follow character varying, :relation_type character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

	insert into public.userrelation 
select * from 
(
select uuid_generate_v4(), :relation_type as relation, :user_request as from , r.id as to , now() as date from 
(select 
(case when (select u.id from public.userrelation u where u.from_id = :user_request and u.to_id = :user_to_follow and u.type = :relation_type) isnull then
(case when (select u.id from public.relationrequest u where u.from_id = :user_request and u.to_id = :user_to_follow and u.type = :relation_type and u.status = 'REQUESTED') isnull then 
(case when (select m.id from public.myneuser m where m.accountvisibility = 'PUBLIC' and m.id = :user_to_follow
and :user_to_follow != :user_request and :relation_type = 'FOLLOWER') notnull 
then (select :user_to_follow ) 
else null end)
else null end)
else null end)
as id) r
) r
where r.to notnull;

insert into public.relationrequest 
select * from 
(
select uuid_generate_v4(), :relation_type as relation, :user_request as from , r.id as to , now() as date, 'REQUESTED' as stat from 
(select
(case when (select u.id from public.userrelation u where u.from_id = :user_request and u.to_id = :user_to_follow and u.type = :relation_type) isnull then
(case when (select u.id from public.relationrequest u where u.from_id = :user_request and u.to_id = :user_to_follow and u.type = :relation_type and u.status = 'REQUESTED') isnull then
(case when (select m.id from public.myneuser m where (m.accountvisibility = 'PRIVATE' or :relation_type != 'FOLLOWER') 
and m.id = :user_to_follow and :user_to_follow != :user_request) notnull 
then (select :user_to_follow ) 
else null end)
else null end)
else null end)
as id) r
) r
where r.to notnull;

select
(case when (select u.id from public.userrelation u where u.from_id = :user_request and u.to_id = :user_to_follow and u.type = :relation_type) isnull then
(case when (select u.id from public.relationrequest u where u.from_id = :user_request and u.to_id = :user_to_follow and u.type = :relation_type and u.status = 'REQUESTED') isnull then
(case when (select m.id from public.myneuser m where m.accountvisibility = 'PUBLIC' and m.id = :user_to_follow
and :user_to_follow != :user_request and :relation_type = 'FOLLOWER') notnull then 'ACCEPTED'
else 'REQUESTED' end)
else 'ALREADY REQUESTED' end )
else 'ALREADY RELATED' end )
into retorno;

return retorno;

end;
$function$
;

select uuid_generate_v4(), r.*, u.createdate, 'ACCEPTED' as status  from 
(select u.type, u.from_id, u.to_id from userrelation u
except 
select r.type, r.from_id, r.to_id from relationrequest r ) r
left join userrelation u
on r.type = u.type and r.from_id = u.from_id and r.to_id = u.to_id 



select (case when (select r.status from relationrequest r where r.id = :requestid) != 'REQUESTED' 
then 'ALREADY_RESPONDED'
else (case when :status_ = 'ACCEPTED' then 'ACCEPTED' else 'DENIED' end ) end )
into retorno;
	
update relationrequest set status = :status_  where id = :requestid;

insert into userrelation 
select * from 
(select uuid_generate_v4(), r.type, r.from_id, r.to_id, now() from
(select (case when 
(select u.id from userrelation u ,
(select r.from_id, r.status, r.to_id, r.type from relationrequest r where r.id = :requestid and r.status = 'ACCEPTED') r
where u.from_id = r.from_id and u.to_id = r.to_id and u.type = r.type) isnull 
then (select :requestid)  else null end) as id) i, relationrequest r
where r.id= i.id) r;


insert into userrelation 
select * from 
(select uuid_generate_v4(), 'FOLLOWER', r.from_id, r.to_id, now() from
(select (case when 
(select u.id from userrelation u ,
(select r.from_id, r.status, r.to_id, r.type from relationrequest r where r.id = :requestid and r.status = 'ACCEPTED' and r.type = 'PARTNER' ) r
where u.from_id = r.from_id and u.to_id = r.to_id and u.type = 'FOLLOWER' ) isnull 
then (select :requestid)  else null end) as id) i, relationrequest r
where r.id= i.id) r;






----------------------------------------------



CREATE OR REPLACE FUNCTION public.removeRelations(fromUser character varying , toUser character varying, "type" character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin


select (case when (select r.id from relationrequest r 
where r.from_id = :fromuser and r.to_id =  :touser and r.type = :type and r.status = 'ACCEPTED' limit 1) notnull then 'DELETED' 
when (select r.id from relationrequest r 
where r.from_id = :fromuser and r.to_id =  :touser and r.type = :type and r.status = 'DELETED' limit 1) notnull then 'ALREADY_DELETED' 
else 'RELATION_NOT_FOUND')
into retorno;
	
update  relationrequest set status = 'DELETED'  where id = 
(select r.id from relationrequest r where r.from_id = :fromuser and r.to_id =  :touser and r.type = :type and r.status = 'ACCEPTED' limit 1);

delete from userrelation where id =
(select u.id from relationrequest r, userrelation u
where u.from_id = r.from_id and u.to_id = r.to_id and u.type = r.type and 
r.from_id = :fromuser and r.to_id =  :touser and r.type = :type and r.status = 'DELETED' limit 1);

return retorno;


end;
$function$
;


e823079e-c537-499c-9c16-72f3d3060ec7	55f59dc6-9158-437b-ac40-981d30ca3b3f	2021-09-08 20:30:37	REQUESTED

select findfeedbyuser('55f59dc6-9158-437b-ac40-981d30ca3b3f', 10,1)
select findrelatedposts('55f59dc6-9158-437b-ac40-981d30ca3b3f', 10)