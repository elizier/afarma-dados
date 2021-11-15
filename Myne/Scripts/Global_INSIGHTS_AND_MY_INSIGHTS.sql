select r.* from pg_stat_activity r where r.backend_type = 'client backend' order by r.query_start asc


select pg_cancel_backend(25793)

25794
23328

select product_page('b00b1808-2387-4c90-b68c-ebc762825032')

25794
23328
25793

select
	cast(uuid_generate_v4() as varchar) as id,
	cast('INSIGHT' as varchar) as "type",
	json(i.data)
from
	(
	select
		i.user || jsonb_build_object('insight', array_agg(i.insight)) as data
	from
		(
		select
			i.user,
			i.insight_data || jsonb_build_object('nested', array_agg(i.insight_slave)) as insight
		from
			(
			select
				jsonb_build_object('type', ud.type) || jsonb(ud.data) ||
jsonb_build_object('profile_image', jsonb_build_object('type', pf.type) || jsonb(pf.data)) as user ,
				jsonb_build_object('type', ui.type) || jsonb(ui.data) as insight_data,
				jsonb_build_object('type', id.type) || jsonb(id.data) as insight_slave
			from
				(
				select
					u.user_id
				from
					(
					select
						distinct(replace(m.mri, 'mri::', '')) user_id
					from
						myneresourceinformation m,
						ownerresources o
					where
						o."type" = 'USER_INSIGHT'
						and o."owner" = m.id
 ) u
				order by
					random()
				limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) u
			left join lateral findresourcedata(u.user_id) as ud on
				true
			left join lateral findresourcebyownerandtype(u.user_id,
				'PROFILE_IMAGE') as pf on
				true
			left join lateral findresourcebyownerandtype(u.user_id,
				'INSIGHT') as ui on
				true
			left join lateral findresourcebyowner(cast(ui.data ->> 'id' as varchar)) as id on
				true) i
		group by
			i.user,
			i.insight_data) i
	group by
		i.user) i







select findmyneinsightsbyrelation('55f59dc6-9158-437b-ac40-981d30ca3b3f', 'NULO', 10 ,0)

select myneresearch('luis', 'USER', 20,0)

select cast(uuid_generate_v4() as varchar) as id, cast('POST' as varchar) as "type",
	p.post_data || jsonb_build_object('nested', array_agg(p.post_resource)) || p.user_data as data
from
	(
	select
		jsonb_build_object('type', 'POST', 'id', pd.id, 'createDate', pd.createdate, 'description', pd.description, 'releaseDate', pd.releasedate, 'title', pd.title, 'canComment', pd.cancomment) as post_data,
		jsonb_build_object('type', pr.type) || jsonb(pr.data) as post_resource,
		jsonb_build_object('user', jsonb_build_object('profile_image', jsonb_build_object('type', ur.type) || jsonb(ur.data)) || 
jsonb_build_object('profile_image', jsonb_build_object('type', ud.type) || jsonb(ud.data))) as user_data
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
		true)
p
group by
	p.post_data,
	p.user_data