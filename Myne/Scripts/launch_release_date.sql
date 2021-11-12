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

select
	f.data as launch_data,
	ow.data as user_data,
	ro.data as nested,
	rf.data as profile_image
from
	(
	select
		m.id
	from
		myneresourceinformation m
	where
		replace(m.mri, 'mri::', '') = coalesce(:user_id, replace(m.mri, 'mri::', ''))) m
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
where
	mr.type = 'LAUNCH'



select public.myneresearch('matheus', 'USER', 10,0)









