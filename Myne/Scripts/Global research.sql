 
select findmylearning(:user_id, 'NULO') 

select r.*, t.tag , t.tag_tsv 
case when r.type = 'POST' then cast(r.data ->> 'title' as varchar)
when r.type = 'USER' then concat(cast(r.data ->> 'name' as varchar), cast(r.data ->> 'accountName' as varchar) from 
(select
	cast(r.data ->> 'id' as varchar) as id1, cast(r.data ->> 'type' as varchar) as "type" , r.data
from
	(
	select
		cast(uuid_generate_v4() as varchar) as id,
		cast('RESEARCH' as varchar) as type,
		to_json(r.data) as data
	from
		(
		select
			jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
		from
			(
			select
				r.owner,
				array_agg(ro.data),
				r.data_post,
				r.data as data_slave
			from
				(
				select
					r.owner,
					r.data_post,
					jsonb_build_object('nested', array_agg(r.data_slave)) as data
				from
					(
					select
						rd.owner,
						jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
						jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave
					from
						(
						select
							replace(m.mri, 'mri::', '') as resource_id
						from
							myneresourceinformation m
						where
							m.type = 'POST'
						order by
							random()
						limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
					cross join lateral findresourcedata(m.resource_id) as rd
					cross join lateral findresourcebyowner(m.resource_id) as ro) r
				group by
					r.owner,
					r.data_post) r
			left join lateral findresourcebyowner(r.owner) ro on
				true
			where
				ro.type = 'PROFILE_IMAGE'
				or ro.type isnull
			group by
				r.owner,
				r.data_post,
				r.data) r
		cross join lateral findresourcedata(r.owner) as ro) r
	group by
		r.data
union all
	select
		cast(uuid_generate_v4() as varchar) as id,
		cast('RESEARCH' as varchar) as type,
		to_json(r.data) as data
	from
		(
		select
			jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data
		from
			(
			select
				replace(m.mri, 'mri::', '') as resource_id
			from
				myneresourceinformation m
			where
				m.type = 'USER'
			order by
				random()
			limit coalesce(
ceil( 
:itens_by_page *
(cast( (select count(*) from myneresourceinformation m where m."type" = 'USER') as float)/
cast( (select count(*) from myneresourceinformation m where m."type" = 'POST') as float)))
, 5)
offset coalesce(:page, 0) * coalesce(
ceil( 
:itens_by_page *
(cast( (select count(*) from myneresourceinformation m where m."type" = 'USER') as float)/
cast( (select count(*) from myneresourceinformation m where m."type" = 'POST') as float)))
, 5)
) m
		cross join lateral findresourcedata(m.resource_id) as rd
		left join lateral findresourcebyowner(m.resource_id) ro on
			true
		where
			ro.type isnull
			or ro.type = 'PROFILE_IMAGE'
) r
	group by
		r.data
) r ) r
left join myneresourceinformation m on replace(m.mri, 'mri::', '') = r.id1
left join resourcetag rt on m.id = rt.resource 
left join tag t on rt.tag = t.id 
order by
	random()
	
	
	
	
	
	
	

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv)--, similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id --and
--t.tag_tsv @@
--to_tsquery('portuguese',(select replace(unaccent(trim(:research)),' ',' | ')))
and m.type = 'POST'
group by t.id , m.mri
--order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r

union all

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json(r.data) as data from
(select jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv)--, similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and m.type = 'USER' --and
--t.tag_tsv @@
--to_tsquery('portuguese',(select replace(unaccent(trim(:research)),' ',' | ')))
group by t.id , m.mri
--order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE') r

union all

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv)--, similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id --and --m.type = :type and
--t.tag_tsv @@
--to_tsquery('portuguese',(select replace(unaccent(trim(:research)),' ',' | ')))
and m.type = 'PRODUCT'
group by t.id , m.mri
--order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r;


(select   cast(r.resource ->> 'id' as varchar) as id, cast(r.resource ->> 'createDate' as timestamp) as createdate,
cast(r.resource ->> 'type' as varchar) as type , lower(cast(r.resource ->> 'title' as varchar)) as tag, to_tsvector('portuguese', lower(cast(r.resource ->> 'title' as varchar))),
r.resource || jsonb_build_object('user',r.user) as data from
(select r.resource,  (case when r.owner_slave isnull then r.user else r.user || r.owner_slave end) as user from
(select
	r.resource || jsonb_build_object('nested', array_agg(r.resource_slave)) as resource, jsonb_build_object('user', r.owner) as user,
(case when r.owner_slave isnull then null
else jsonb_build_object('profile_image', r.owner_slave) end ) as owner_slave
from
	(
	select
		jsonb_build_object('type', r.type) || jsonb(r.data) as resource,
		jsonb_build_object('type', s.type) || jsonb(s.data) as resource_slave,
		jsonb_build_object('type', o.type) || jsonb(o.data) as owner,
		jsonb_build_object('type', os.type) || jsonb(os.data) as owner_slave
	from
		myneresourceinformation m
	left join lateral findresourcedata(replace(m.mri, 'mri::', '')) as r on
		true
	left join lateral findresourcebyowner(replace(m.mri, 'mri::', '')) as s on
		true
	left join lateral findresourcedata(r.owner) as o on
		true
	left join lateral findresourcebyownerandtype(r.owner,
		'PROFILE_IMAGE') as os on
		true
	where
		o.type = 'USER'
		and  (m."type" = 'POST')) r
group by
	r.resource,
	r.owner,
	r.owner_slave) r) r
	group by
r.resource,
r.user)

union all 

(
	select cast(r.data ->> 'id' as varchar) as id, cast(r.data ->> 'createDate' as timestamp) as createdate,
	cast(r.data ->> 'type' as varchar) as type, lower(concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'accountName' as varchar))) as tag,
	to_tsvector('portuguese', lower(concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'accountName' as varchar)))) ,
		jsonb_build_object('type', r.type) || jsonb(r.data) ||
		jsonb_build_object('profile_image', jsonb_build_object('type', s.type) || jsonb(s.data)) as resource_slave
	from
		myneresourceinformation m
	left join lateral findresourcedata(replace(m.mri, 'mri::', '')) as r on
		true
	left join lateral findresourcebyownerandtype(replace(m.mri, 'mri::', ''),'PROFILE_IMAGE') as s on
		true
	where
		m."type" = 'USER')
		
union all 


(select cast(r.resource ->> 'id' as varchar) as id, cast(r.resource ->> 'createDate' as timestamp) as createdate,
cast(r.resource ->> 'type' as varchar) as type, lower(concat(cast(r.resource ->> 'name' as varchar), ' ', cast(r.resource ->> 'productType' as varchar))) as tag,
to_tsvector('portuguese', lower(concat(cast(r.resource ->> 'name' as varchar), ' ', cast(r.resource ->> 'productType' as varchar)))),
r.resource || jsonb_build_object('nested', array_agg( r.resource_slave)) ||
jsonb_build_object('user', jsonb_build_object('user', r.owner) || jsonb_build_object('profile_image', r.owner_slave)) as data from 
(
	select
		jsonb_build_object('type', r.type) || jsonb(r.data) as resource,
		jsonb_build_object('type', s.type) || jsonb(s.data) as resource_slave,
		jsonb_build_object('type', o.type) || jsonb(o.data) as owner,
		jsonb_build_object('type', os.type) || jsonb(os.data) as owner_slave
	from
		myneresourceinformation m
	left join lateral findresourcedata(replace(m.mri, 'mri::', '')) as r on
		true
	left join lateral findresourcebyowner(replace(m.mri, 'mri::', '')) as s on
		true
	left join lateral findresourcedata(r.owner) as o on
		true
	left join lateral findresourcebyownerandtype(r.owner,
		'PROFILE_IMAGE') as os on
		true
	where
		o.type = 'USER'
		and m."type" = 'PRODUCT'
		) r
		group by r.resource, r.owner, r.owner_slave)

select 


select findmyneglobalfeed(5,0)


select public.findmyneinsightsbyrelation('55f59dc6-9158-437b-ac40-981d30ca3b3f', 'MENTOR', 10, 0)

select p.id from post p
except
select r.id from global.research r


select product_page('5def8be8-cc94-46ac-ae11-67e9594ed7f6')



select
	cast(uuid_generate_v4() as varchar) as id,
	'PRODUCT' as "type",
	p.product_data || jsonb_build_object('owner', array_agg(p.owner)) || jsonb_build_object('nested', p.nested) as data
from
	(
	select
		p.product_data,
		p.owner_data as owner,
		array_agg(p.nested) as nested
	from
		(
		select
			p.product_data,
			p.owner_data,
			(case
				when p.file = cast('{"nested": [null]}' as jsonb) then p.product_resources
				else p.product_resources || p.file
			end) as nested
		from
			(
			select
				p.product_data,
				p.owner_data,
				p.product_resources,
				jsonb_build_object('nested', array_agg(p.file_data)) as file
			from
				(
				select
					jsonb_build_object('type', pr.type) || to_jsonb(pr.data) as product_data,
					(case
						when ow.data isnull then jsonb_build_object(lower(o.type), to_jsonb(o.data))
						else jsonb_build_object(lower(o.type), to_jsonb(o.data)) || jsonb_build_object(lower(ow.type), to_jsonb(ow.data))
					end) as owner_data,
					jsonb_build_object('type', pw.type) || to_jsonb(pw.data) as product_resources,
					jsonb_build_object('type', s3.type) || to_jsonb(s3.data) as file_data
				from
					findresourcedata(:product_id) as pr
				left join lateral findresourcedata(pr.owner) as o on
					true
				left join lateral findresourcebyownerandtype(pr.owner,
					'PROFILE_IMAGE') as ow on
					true
				left join lateral findresourcebyowner(:product_id) as pw on
					true
				left join lateral findresourcebyowner(cast(pw.data ->> 'id' as varchar)) as s3 on
					true) p
			group by
				p.product_data,
				p.owner_data,
				p.product_resources) p) p
	group by
		p.product_data,
		p.owner_data) p
group by
	p.product_data,
	p.nested

select public.product_page(:product_id)
	
CREATE OR REPLACE FUNCTION public.product_page(product_id character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   declare
      resource_t public.mynejsontype%ROWTYPE;

begin

 	for resource_t in	
 	
select cast(uuid_generate_v4() as varchar) as id, cast('PRODUCT' as varchar) as  "type", 
	p.product_data || 
jsonb_build_object('user', jsonb_build_object('user', p.user_data) || jsonb_build_object('profile_image', p.profile_image)) ||
jsonb_build_object('nested', array_agg(p.module_data)) as "data"
from
	(
	select
		p.product_data,
		p.product_slave,
		p.user_data,
		p.profile_image,
		(case
			when cast(p.module_file as varchar) = '{"nested": [null]}' then p.product_slave
			else p.product_slave || p.module_file
		end) as module_data
	from
		(
		select
			p.product_data,
			p.product_slave,
			p.user_data,
			p.profile_image,
			jsonb_build_object('nested' , array_agg(p.module_file)) as module_file
		from
			(
			select
				replace(m.mri, 'mri::', ''),
				jsonb_build_object('type', p.type) || jsonb(p.data) as product_data,
				jsonb_build_object('type', pr.type) || jsonb(pr.data) as product_slave ,
				jsonb_build_object('type', o.type) || jsonb(o.data) as user_data,
				jsonb_build_object('type', ot.type) || jsonb(ot.data) as profile_image,
				(case
					when ms.data isnull then null
					else jsonb_build_object('type', ms.type) || jsonb(ms.data)
				end) as module_file
			from
				myneresourceinformation m
			left join lateral findresourcedata(replace(m.mri, 'mri::', '')) as p on
				true
			left join lateral findresourcebyowner(replace(m.mri, 'mri::', '')) as pr on
				true
			left join lateral findresourcedata(p.owner) as o on
				true
			left join lateral findresourcebyownerandtype(p.owner,
				'PROFILE_IMAGE') as ot on
				true
			left join lateral findresourcebyowner(cast(pr.data ->> 'id' as varchar)) as ms on
				true
			where
				m.type = 'PRODUCT'
				and o.type = 'USER'
				and replace(m.mri, 'mri::', '') = product_id ) p
		group by
			p.product_data,
			p.product_slave,
			p.user_data,
			p.profile_image) p) p
group by
	p.product_data,
	p.user_data,
	p.profile_image
	
	loop
		return next resource_t;
end loop;

return;
end;

$function$
;

update global.research set ts_vector = 'USER' where "type" isnull
select  * from global.research r 



CREATE OR REPLACE FUNCTION public.checkpurchase(user_id character varying , product character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
begin 
	
select (case when p.product_id isnull then false else true end) as purchase from
(select o.slave, replace(m.mri, 'mri::', '') as user_id  from myneresourceinformation m, ownerresources o 
where replace(m.mri, 'mri::', '') = user_id and o."owner" = m.id and o."type" = 'USER_PURCHASE') up
left join
myneresourceinformation m on m.id = up.slave
left join purchase p on replace(m.mri, 'mri::', '') = p.id
where p.product_id = product
into purchased;

   return purchased;

END;

$function$
;

select public.checkpurchase(:user_id, :product_id)



CREATE OR REPLACE FUNCTION public.checkpurchase(user_id character varying , product character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
   purchased boolean;
begin
	
	select (case when p.product_id isnull then false else true end) as purchase from
(select o.slave, replace(m.mri, 'mri::', '') as user_id  from myneresourceinformation m, ownerresources o 
where replace(m.mri, 'mri::', '') = user_id and o."owner" = m.id and o."type" = 'USER_PURCHASE') up
left join
myneresourceinformation m on m.id = up.slave
left join purchase p on replace(m.mri, 'mri::', '') = p.id
where p.product_id = product

into purchased;
   
   return purchased;
end;
$function$
;



(select m.id from myneresourceinformation m, ownerresources o, purchase p 
where replace(m.mri, 'mri::', '') = p.id and p.product_id = :product_id and o.slave = m.id)


select public.findmylaunchs(:user_id , :type_ )




select
	cast(uuid_generate_v4() as varchar) as id,
	'LAUNCH' as "type",
	l.launch_data || jsonb_build_object('nested', array_agg(l.product_data)) || l.user_data as data
from
	(
	select
		l.launch_data,
		l.product_data || jsonb_build_object('nested', array_agg(l.product_nested)) as product_data,
		jsonb_build_object('user', jsonb_build_object('user', l.user_data) || jsonb_build_object('profile_image', l.profile_image)) as user_data
	from
		(
		select
			jsonb_build_object('type', f.type) || to_jsonb(f.data) as launch_data,
			jsonb_build_object('type', ow.type) || to_jsonb(ow.data) as user_data,
			jsonb_build_object('type', ro.type) || to_jsonb(ro.data) as product_data,
			jsonb_build_object('type', rf.type) || to_jsonb(rf.data) as profile_image,
			jsonb_build_object('type', pn.type) || to_jsonb(pn.data) as product_nested
		from
			(
			select
				m.id
			from
				myneresourceinformation m
			where
				replace(m.mri, 'mri::', '') = coalesce(:user_id, replace(m.mri, 'mri::', ''))
				and m.type = 'USER') m
		left join ownerresources o on
			m.id = o.owner
		left join (select * from myneresourceinformation mr where mr.type = 'LAUNCH') mr on
			o.slave = mr.id
		left join lateral findresourcedata(replace(mr.mri, 'mri::', '')) as f on
			true
		left join lateral findresourcedata(f.owner) as ow on
			true
		left join lateral findresourcebyowner(cast(f.data ->> 'id' as varchar)) as ro on
			true
		left join lateral findresourcebyownerandtype(cast(ow.data ->> 'id' as varchar),
			'PROFILE_IMAGE') as rf on
			true
		left join lateral findresourcebyowner(cast(ro.data ->> 'id' as varchar)) as pn on
			true
		where
			--mr.type = 'LAUNCH'
			--and 
			cast(f.data ->> 'launchType' as varchar) = coalesce(nullif(:type_, 'NULO'), cast(f.data ->> 'launchType' as varchar)) ) l
	group by
		launch_data,
		l.user_data,
		l.product_data,
		l.profile_image
		) l
group by
	l.launch_data,
		l.user_data
		
		
		
select f.* from	
(select replace(m.mri, 'mri::', '') as resource_id from myneresourceinformation m) m
left join lateral findresourcedata(m.resource_id) as f on true
where f.type = 'LAUNCH'
		
		

select m.id from myneresourceinformation m
			where
				replace(m.mri, 'mri::', '') = coalesce(:user_id, replace(m.mri, 'mri::', ''))
				and m.type = 'USER'

				
select * from product p where now() > p.releasedate cast('2021-11-15 10:35:00.000 -0300' as timestamp with time zone)



select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data  from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:research)))
from tag t, myneresourceinformation m, resourcetag r , post p
where 
 m.id = r.resource and r.tag = t.id and 
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(:research)),' ',' | ')))
and m.type = 'POST' and replace(m.mri,'mri::','') = p.id and now() > p.releasedate
group by t.id , m.mri
order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r;





CREATE OR REPLACE FUNCTION public.tagpostinsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


insert into tag(tag, tag_tsv) select a.tag1, a.to_tsvector from
(select p.title  as tag1 , to_tsvector('portuguese', unaccent(p.title))
from myneresourceinformation m, post p
where replace(m.mri, 'mri::', '') = p.id
except
select t.tag, t.tag_tsv from tag t) a;

insert into resourcetag(resource, tag) select a.id, a.tag_id from
(select m.id, t.id as tag_id 
from myneresourceinformation m, post p, tag t 
where replace(m.mri, 'mri::', '') = p.id and p.title = t.tag
except
select r.resource, r.tag from resourcetag r) a;

RETURN NEW;

END;

$function$
;

create trigger insertposttag after
insert
    on
    public.post for each row execute function tagpostinsert()




CREATE OR REPLACE FUNCTION public.checkpurchase(user_id character varying, product character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   declare
      resource_t public.mynejsontype%ROWTYPE;

begin

 	for resource_t in
 

	select cast(uuid_generate_v4() as varchar) as id,
	'PURCHASE' as type, json_build_object('purchased', (case when p.product_id isnull then 'false' else 'true' end)) as purchase from
(select o.slave, replace(m.mri, 'mri::', '') as user_id  from myneresourceinformation m, ownerresources o 
where replace(m.mri, 'mri::', '') = user_id and o."owner" = m.id and o."type" = 'USER_PURCHASE') up
left join
myneresourceinformation m on m.id = up.slave
left join purchase p on replace(m.mri, 'mri::', '') = p.id
where p.product_id = product

loop
		return next resource_t;
end loop;

return;
end;

$function$
;





select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and --m.type = :type and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(:research)),' ',' | ')))
and m.type = 'PRODUCT'
group by t.id , m.mri
order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r;


select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data  from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri, 'mri::', '') from myneresourceinformation m  where m.type = 'POST') m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r;


SELECT public.findmyneglobalinsights( :itens_by_page , :page)


select public.myneresearch('ebook', 'produto', 10000, 0)



select cast(r.data ->> 'id' as varchar) as id,  cast(r.data ->> 'createDate' as timestamp with time zone) as createdate,
'PRODUCT' as "type", concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'productType' as varchar)) as tag,
to_tsvector(concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'productType' as varchar))) as ts_vector,
cast(r.data ->> 'releaseDate' as timestamp with time zone) as releasedate, f.owner,
to_json( r.data) as data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri, 'mri::', '') as resource_id from myneresourceinformation m where m.type = 'PRODUCT') m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r
left join findresourcedata(cast(r.data ->> 'id' as varchar)) as f on true
left join myneresourceinformation m on f.owner = replace(m.mri, 'mri::', '')
where m.type = 'USER' 

union all


select cast(r.data ->> 'id' as varchar) as id,  cast(r.data ->> 'createDate' as timestamp with time zone) as createdate,
 cast('USER' as varchar) as type, concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'accountName' as varchar)) as tag,
to_tsvector(concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'accountName' as varchar))) as ts_vector,
null as releasedate, '' as owner,
to_json(r.data) as data from
(select jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri, 'mri::', '') as resource_id from myneresourceinformation m where m.type = 'USER') m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE') r 

union all

select cast(r.data ->> 'id' as varchar) as id,  cast(r.data ->> 'createDate' as timestamp with time zone) as createdate,
cast('POST' as varchar) as type, concat(cast(r.data ->> 'title' as varchar)) as tag,
to_tsvector(cast(r.data ->> 'title' as varchar)) as ts_vector, cast(r.data ->> 'releaseDate' as timestamp with time zone) as releasedate,
f.owner,
to_json( r.data) as data  from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri, 'mri::', '') as resource_id from myneresourceinformation m  where m.type = 'POST') m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r
left join findresourcedata(cast(r.data ->> 'id' as varchar)) as f on true
left join myneresourceinformation m on f.owner = replace(m.mri, 'mri::', '')
where m.type = 'USER' ;












