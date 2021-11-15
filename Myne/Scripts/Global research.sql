 
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
