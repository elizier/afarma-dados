
--PRINCIPAL
select  
(case
when :type = 'FOLLOWERS'
then
--Followers
(select row_to_json(u.*) as relation from 
(
select row_to_json(u.*) as user , row_to_json(s.*)  as profile_img
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u, s3file s, 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(select u.user_id, o.slave as id, u.order from myneresourceinformation m,
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.from_id 
and r.to_id = :user_id
and r.type = 'FOLLOWER') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) u, ownerresources o 
where replace(m.mri, 'mri::','') = u.user_id and m.id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id and s.id = o.s3_id
order by o.order asc
) u)

when :type = 'FOLLOWING'
then
--Following
(select row_to_json(u.*) as relation from 
(
select row_to_json(u.*) as user , row_to_json(s.*)  as profile_img
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u, s3file s, 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(select u.user_id, o.slave as id, u.order from myneresourceinformation m,
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.to_id 
and   r.from_id = :user_id
and r.type = 'FOLLOWER') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) u, ownerresources o 
where replace(m.mri, 'mri::','') = u.user_id and m.id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id and s.id = o.s3_id
order by o.order asc
) u)

when :type = 'MENTORS'
then
--Mentors
(select row_to_json(u.*) as relation from 
(
select row_to_json(u.*) as user , row_to_json(s.*)  as profile_img
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u, s3file s, 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(select u.user_id, o.slave as id, u.order from myneresourceinformation m,
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.from_id 
and r.to_id = :user_id
and r.type = 'MENTOR') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) u, ownerresources o 
where replace(m.mri, 'mri::','') = u.user_id and m.id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id and s.id = o.s3_id
order by o.order asc
) u)

when :type = 'PARTNERS'
then
--Partners
(select row_to_json(u.*) as relation from 
(
select row_to_json(u.*) as user , row_to_json(s.*)  as profile_img
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u, s3file s, 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(select u.user_id, o.slave as id, u.order from myneresourceinformation m,
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.from_id 
and r.from_id = :user_id
and r.type = 'PARTNER') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) u, ownerresources o 
where replace(m.mri, 'mri::','') = u.user_id and m.id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id and s.id = o.s3_id
order by o.order asc
) u)
else (select row_to_json(t.*)  from (select '' as relation) t)
end)

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@







create or replace function example(x integer[])
  returns table (y integer) 
as 
$$
begin
  if length(x, 1) = 1 then  
     return query 
       select * from  example_1(x[1]);
  elsif length(x, 1) = 2 then 
     return query 
       select * from  example_2(x[1], x[2]);
  elsif length(x, 1) = 3 then 
     return query 
       select * from  example_2(x[1], x[2], x[3]);
  end if;
$$ 
language plpgsql;

select listmynerelations(:user_id, 'MENTORS', 5, 0)

CREATE OR REPLACE FUNCTION public.listmynerelations( user_id_ character varying, relation_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	--FOR resource_t in

  if relation_type = 'FOLLOWERS' then  
     return query 
       select user_id_, relation_type, row_to_json(u.*) as relation from 
(
select row_to_json(u.*) as user , row_to_json(s.*)  as profile_img
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u, s3file s, 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(select u.user_id, o.slave as id, u.order from myneresourceinformation m,
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.from_id 
and r.to_id = user_id_
and r.type = 'FOLLOWER') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) u, ownerresources o 
where replace(m.mri, 'mri::','') = u.user_id and m.id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id and s.id = o.s3_id
order by o.order asc
) u;

  elsif relation_type = 'FOLLOWING' then 
  
     return query 
      select user_id_, relation_type, row_to_json(u.*) as relation from 
(
select row_to_json(u.*) as user , row_to_json(s.*)  as profile_img
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u, s3file s, 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(select u.user_id, o.slave as id, u.order from myneresourceinformation m,
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.to_id 
and   r.from_id = user_id_
and r.type = 'FOLLOWER') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) u, ownerresources o 
where replace(m.mri, 'mri::','') = u.user_id and m.id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id and s.id = o.s3_id
order by o.order asc
) u;

  elsif relation_type = 'MENTORS' then 
  
     return query 
       select user_id_, relation_type, row_to_json(u.*) as relation from 
(
select row_to_json(u.*) as user , row_to_json(s.*)  as profile_img
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u, s3file s, 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(select u.user_id, o.slave as id, u.order from myneresourceinformation m,
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.from_id 
and r.to_id = user_id_
and r.type = 'MENTOR') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) u, ownerresources o 
where replace(m.mri, 'mri::','') = u.user_id and m.id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id and s.id = o.s3_id
order by o.order asc
) u;

  elsif relation_type = 'PARTNERS' then 
  
     return query 
       select user_id_, relation_type, row_to_json(u.*) as relation from 
(
select row_to_json(u.*) as user , row_to_json(s.*)  as profile_img
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u, s3file s, 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(select u.user_id, o.slave as id, u.order from myneresourceinformation m,
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.from_id 
and r.from_id = user_id_
and r.type = 'PARTNER') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) u, ownerresources o 
where replace(m.mri, 'mri::','') = u.user_id and m.id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id and s.id = o.s3_id
order by o.order asc
) u;

  end if;
  
 
--loop
		--RETURN NEXT resource_t;
	
   --END LOOP;
  
  	
   RETURN;

END;

$function$
;