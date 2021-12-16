select cast(uuid_generate_v4() as varchar) as id, cast('POST' as varchar) as "type",
	p.post_data || jsonb_build_object('nested', array_agg(p.post_resource)) || p.user_data || t.tag as data
from
	(
	select
		jsonb_build_object('type', 'POST', 'id', pd.id, 'createDate', pd.createdate, 'description', pd.description, 'releaseDate', pd.releasedate, 'title', pd.title, 'canComment', pd.cancomment) as post_data,
		jsonb_build_object('type', pr.type) || jsonb(pr.data) as post_resource,
		jsonb_build_object('user', jsonb_build_object('user', jsonb_build_object('type', ud.type) || jsonb(ud.data)) || 
jsonb_build_object('profile_image', jsonb_build_object('type', ur.type) || jsonb(ur.data))) as user_data
	from
		(
		select
			u.id as user_id,
			o.slave as mri_id_slave,
			mr.createdate,
			replace(mr.mri, 'mri::', '') as post_id,
			mr.type as slaves_type
		from
			(select distinct(id) from (
			select
				r.to_id as id
			from
				relationrequest r
			where
				r.status = 'ACCEPTED'
				and
(r.type = 'FOLLOWER'
					or r.type = 'PUPIL'
					or r.type = 'PARTNER')
				and r.from_id = :user_id
				union all
				select :user_id) u) u
		left join myneresourceinformation m on
			replace(m.mri, 'mri::', '') = u.id
		left join ownerresources o on
			m.id = o."owner"
		left join myneresourceinformation mr on
			mr.id = o.slave
		where
			(o."type" = 'USER_POST' )
		order by
			mr.createdate desc,
			mr.id asc
		limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) u
	left join post as pd on pd.id = u.post_id
	left join lateral findresourcedata(u.user_id) as ud on
		true
	left join lateral findresourcebyowner(u.post_id) as pr on
		true
	left join lateral findresourcebyownerandtype(u.user_id,
		'PROFILE_IMAGE') as ur on
		true
		where DATE_PART('day', now() - pd.releasedate) >= 0 )
p
left join (select m.id, jsonb_build_object('tags', string_to_array(m.tag, ' ')) as tag from
(select replace(m.mri, 'mri::', '') as id, string_agg(t.tag, ' ')  
as tag from myneresourceinformation m 
left join resourcetag r on r.resource = m.id
left join tag t on r.tag = t.id
where m."type" = 'POST'
group by m.id) m) t on t.id = cast(p.post_data ->> 'id' as varchar)
group by
	p.post_data,
	p.user_data,
	t.tag
	
	
select findmyposts(:user_id, 5, 0)


select cast(uuid_generate_v4() as varchar) as id, cast('POST' as varchar) as "type",
	p.post_data || jsonb_build_object('nested', array_agg(p.post_resource)) || p.user_data as data
from
	(
	select
		jsonb_build_object('type', 'POST', 'id', pd.id, 'createDate', pd.createdate, 'description', pd.description, 'releaseDate', pd.releasedate, 'title', pd.title, 'canComment', pd.cancomment) || t.tag as post_data,
		jsonb_build_object('type', pr.type) || jsonb(pr.data) as post_resource,
		jsonb_build_object('user', jsonb_build_object('profile_image', jsonb_build_object('type', ur.type) || jsonb(ur.data)) || 
jsonb_build_object('user', jsonb_build_object('type', ud.type) || jsonb(ud.data))) as user_data
	from
		(
		select
			u.id as user_id,
			o.slave as mri_id_slave,
			mr.createdate,
			replace(mr.mri, 'mri::', '') as post_id,
			mr.type as slaves_type
		from
			(select :user_id as id) u
		left join myneresourceinformation m on
			replace(m.mri, 'mri::', '') = u.id
		left join ownerresources o on
			m.id = o."owner"
		left join myneresourceinformation mr on
			mr.id = o.slave
		where
			(o."type" = 'USER_POST' and 
			mr."type" = 'POST')
		order by
			mr.createdate desc,
			mr.id asc
		limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) u
	left join post as pd on pd.id = u.post_id
	left join lateral findresourcedata(u.user_id) as ud on
		true
	left join lateral findresourcebyowner(u.post_id) as pr on
		true
	left join lateral findresourcebyownerandtype(u.user_id,
		'PROFILE_IMAGE') as ur on
		true
	left join (select m.id, jsonb_build_object('tags', string_to_array(m.tag, ' ')) as tag from
(select replace(m.mri, 'mri::', '') as id, string_agg(t.tag, ' ')  
as tag from myneresourceinformation m 
left join resourcetag r on r.resource = m.id
left join tag t on r.tag = t.id
where m."type" = 'POST'
group by m.id) m) t on t.id = u.post_id)
p
group by
	p.post_data,
	p.user_data

order by
	cast(p.post_data ->> 'createDate' as timestamp with time zone) desc