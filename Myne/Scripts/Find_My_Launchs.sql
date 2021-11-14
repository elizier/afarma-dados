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
			and cast(f.data ->> 'launchtype' as varchar) = coalesce(nullif(:type_, 'NULO'), cast(f.data ->> 'launchtype' as varchar)) ) l
	group by
		launch_data,
		l.user_data,
		l.product_data,
		l.profile_image
		) l
group by
	l.launch_data,
		l.user_data
		
				