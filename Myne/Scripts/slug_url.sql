select m.type from myneresourceinformation m where replace(m.mri,'mri::','') = :mri_id 

select findresourcebyowner
(
(
select u.id from myneuser u where u.slug = :slug
)
)


select u.id from myneuser u where u.slug = :slug


select cast(uuid_generate_v4() as varchar) as id, r.type, to_json(r.data || jsonb_build_object('nested', array_agg(r.nested))) as data from
(select m.type, m.createdate, jsonb_build_object('type', f.type) || jsonb(f.data) as data, jsonb_build_object('type', r.type) || jsonb(r.data) as nested from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type, m.createdate from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
where
 m."type" = coalesce(nullif(:type_,'NULO'), m."type")
and replace(mr.mri,'mri::','') = :user_id
group by  m.mri, mr.mri, m.type, m.createdate
order by m.createdate desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral public.findresourcedata(m.mri) as f
left join lateral public.findresourcebyowner(m.mri) as r on true
where m.owner notnull and m.owner = replace(:user_id,'mri::','') and f.owner = m.owner) r
group by r.data, r.type, r.createdate
order by r.createdate desc

select public.findprofilebyslug(:slug, :type_ , :itens_by_page , :page)


CREATE OR REPLACE FUNCTION public.findprofilebyslug(slug_ character varying, type_ character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
     user_id character varying;
begin
	
user_id := (select u.id from myneuser u where u.slug = slug_);
   


 	FOR resource_t in

 	
select cast(uuid_generate_v4() as varchar) as id, r.type, to_json(r.data || jsonb_build_object('nested', array_agg(r.nested))) as data from
(select m.type, m.createdate, jsonb_build_object('type', f.type) || jsonb(f.data) as data, jsonb_build_object('type', r.type) || jsonb(r.data) as nested from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type, m.createdate from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
where
 m."type" = coalesce(nullif(type_,'NULO'), m."type")
 and m."type" in ('POST', 'INSIGHT', 'PURCHASE', 'PROFILE_IMAGE')
and replace(mr.mri,'mri::','') = user_id
group by  m.mri, mr.mri, m.type, m.createdate
order by m.createdate desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral public.findresourcedata(m.mri) as f
left join lateral public.findresourcebyowner(m.mri) as r on true
where m.owner notnull and m.owner = replace(user_id,'mri::','') and f.owner = m.owner) r
group by r.data, r.type, r.createdate
order by r.createdate desc

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;





select
	f.*,
	r.data
from
	(
	select
		replace(m.mri, 'mri::', '') as mri,
		replace(mr.mri, 'mri::', '') as owner,
		m.type,
		m.createdate
	from
		public.myneresourceinformation m
	left join ownerresources o on
		o.slave = m.id
	left join myneresourceinformation mr on
		o.owner = mr.id
	where
		m."type" = coalesce(nullif(:type_, 'NULO'), m."type")
		and replace(mr.mri, 'mri::', '') = :user_id
	group by
		m.mri,
		mr.mri,
		m.type,
		m.createdate
	order by
		m.createdate desc
	limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral public.findresourcedata(m.mri) as f
left join lateral public.findresourcebyowner(m.mri) as r on
	true
where
	m.owner notnull
	and m.owner = replace(:user_id, 'mri::', '')
	and f.owner = m.owner


select findmyproducts('6a49706d-9be8-44bc-95a7-d8994150dc9b', null)

-- run as superuser:

create extension pg_cron;

-- optionally, grant usage to regular users:

GRANT USAGE ON SCHEMA cron TO username;



