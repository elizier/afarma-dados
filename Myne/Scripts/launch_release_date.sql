--post

ALTER TABLE public.post ALTER COLUMN createdate TYPE timestamp with time zone USING createdate::timestamp with time zone;

ALTER TABLE public.post ADD releasedate timestamp with time zone NULL;

update public.post set releasedate = createdate ;

ALTER TABLE public.post ALTER COLUMN releasedate SET NOT NULL;

ALTER TABLE public.post ALTER COLUMN releasedate SET DEFAULT now();

--product

ALTER TABLE public.product ALTER COLUMN createdate TYPE timestamp with time zone USING createdate::timestamp with time zone;

ALTER TABLE public.product ADD releasedate timestamp with time zone NULL;

update public.product set releasedate = createdate ;

ALTER TABLE public.product ALTER COLUMN releasedate SET NOT NULL;

ALTER TABLE public.product ALTER COLUMN releasedate SET DEFAULT now();

--insight

ALTER TABLE public.insight ALTER COLUMN createdate TYPE timestamp with time zone USING createdate::timestamp with time zone;

ALTER TABLE public.insight ADD releasedate timestamp with time zone NULL;

update public.insight set releasedate = createdate ;

ALTER TABLE public.insight ALTER COLUMN releasedate SET NOT NULL;

ALTER TABLE public.insight ALTER COLUMN releasedate SET DEFAULT now();

-- Launch json

select public.findmylaunchs(:user_id,
'NULO')

create or replace
function public.findmylaunchs(user_id character varying,
type_ character varying)
 returns setof mynejsontype
 language plpgsql
as $function$
   declare
      resource_t public.mynejsontype%ROWTYPE;

begin

 	for resource_t in
 	
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
				replace(m.mri, 'mri::', '') = coalesce(user_id, replace(m.mri, 'mri::', ''))
				and m.type = 'USER') m
		left join ownerresources o on
			m.id = o.owner
		left join myneresourceinformation mr on
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
			mr.type = 'LAUNCH'
			and cast(f.data ->> 'launchtype' as varchar) = coalesce(nullif(type_, 'NULO'), cast(f.data ->> 'launchtype' as varchar)) ) l
	group by
		launch_data,
		l.user_data,
		l.product_data,
		l.profile_image
		) l
group by
	l.launch_data,
		l.user_data


loop
		return next resource_t;
end loop;

return;
end;

$function$
;



select public.myneresearch('matheus', 'USER', 10,0)



select * from ownerresources o where ((o.slave in ('2f9c281e-ca83-4778-b262-7f3a7445d56f',
'69a4380c-892b-4c90-9798-cbca8ae68c37')) or (o."owner" in ('2f9c281e-ca83-4778-b262-7f3a7445d56f',
'69a4380c-892b-4c90-9798-cbca8ae68c37')))

select * from ownerresources o where o.slave = '69a4380c-892b-4c90-9798-cbca8ae68c37' or o."owner" = '69a4380c-892b-4c90-9798-cbca8ae68c37'





