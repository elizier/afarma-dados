
select cast(uuid_generate_v4() as varchar) as  id, (select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(:user_id, 'mri::', '')) as type, u.data as data from
(
select u.createdate_post, jsonb_build_object('user', u.user_data) || u.post as data  from 
(
select u.createdate_post, u.user_data, u.post_data || jsonb_build_object('nested', array_agg(u.data))  as post from
(
select  u.createdate_post, jsonb(u.user_data) as user_data, jsonb(u.post_data) as post_data, jsonb_build_object('type', p.type) || jsonb(p.data) as data from
(SELECT row_to_json(u.*) as user_data, jsonb_build_object('type', p.type) || jsonb(p.data) as post_data, cast(p.data ->> 'createDate' AS TIMESTAMP) as createdate_post, cast(p.data ->> 'id' AS varchar) as id_post
FROM (
	select u.id, row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createDate', o."createDate") || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o."fileName") || jsonb_build_object('filetype', o."fileType") || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM 
		(
			SELECT o.*, u.data
			FROM 
				 (
					SELECT u.user_id
						,to_jsonb(o.data) as data
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
						FROM (select distinct(u.user_id) as user_id
from
(
(select u.to_id as user_id 
from public.userrelation u
where u.type ='FOLLOWER'
and u.from_id = :user_id)
union all
(select u.from_id as partner
from public.userrelation u
where u.type ='PARTNER'
and u.to_id = :user_id)
union all
(select u.from_id as mentor
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = :user_id)
union all 
(select :user_id)
) u) u
							,myneresourceinformation m
						WHERE replace(m.mri, 'mri::', '') = u.user_id
						) u
					LEFT join lateral public.findresourcebyowner(u.user_id) o ON true
						where (o.type = 'PROFILE_IMAGE' or o.type isnull)
					
					) o
			cross join lateral findresourcedata(o.user_id) as u) o
	WHERE o.user_id = u.id
	) u
cross join lateral findresourcebyownerandtype(u.id, 'POST') as p
) u
cross join lateral findresourcebyowner(u.id_post) as p) u
group by u.user_data, u.post_data, u.createdate_post) u
) u
order by createdate_post desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)

select cast(uuid_generate_v4() as varchar) as id, cast(:resource as varchar) as type, to_json(f.data) as data from
(select jsonb_build_object('type', o.type) || to_jsonb(o.data) || f.nested as data from
(select f.owner, jsonb_build_object('nested', array_agg(f.data)) as nested from
(select f.owner, jsonb_build_object('type', f.type) || to_jsonb(f.data)	as data 
from findresourcebyowner(:resource) f) f
group by f.owner) f 
cross join lateral findresourcedata(f.owner) as o ) f


select findmyneresource('7a217f2b-7fcd-46b0-91e7-aa88c4b36f1c')


select findmyneglobalfeed(10,0)

3c4732e9-d1f0-4df6-b841-5277fe71a647









select cast(uuid_generate_v4() as varchar) as  id, 'POST' as type, u.data from
(
select jsonb_build_object('user', u.user_data) || u.post as data  from 
(
select u.user_data, u.post_data || jsonb_build_object('nested', array_agg(u.data))  as post from
(
select  jsonb(u.user_data) as user_data, jsonb(u.post_data) as post_data, jsonb_build_object('type', p.type) || jsonb(p.data) as data from
(SELECT json_build_object('user',u.user ,'profile_image',u.profile_image)  as user_data, jsonb_build_object('type', p.type) || jsonb(p.data) as post_data, cast(p.data ->> 'createdate' AS TIMESTAMP) as createdate_post, cast(p.data ->> 'id' AS varchar) as id_post
FROM (
	select o.post_id, u.id, row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createDate', o."createDate") || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o."fileName") || jsonb_build_object('filetype', o."fileType") || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname as "accountName"
			,u.active
			,u.createdate as "createDate"
			,u.devicetoken
			,u.email
			,u.name
			,u.slug
			,u.usertype
			,u.visibility
		FROM myneuser u
		) u
		,(
			SELECT max(s.id) AS s3_id
				,max(s.createdate) AS "createDate"
				,max(s.description) AS description
				,max(s.filename)  as "fileName"
				,max(s.filetype) as "fileType"
				,max(s.s3url) AS s3url
				,o.user_id, o.post_id
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id, pi.post_id
				FROM (
					SELECT u.user_id
						,o.slave AS id, u.post_id
					FROM (select m.id as mri_id, replace(m.mri, 'mri::', '') as user_id, a.post_id from
(select a.owner, replace(m.mri, 'mri::', '') as post_id, a.accountability_id from  
(select o.owner, a.accountability_id from myneresourceinformation m,
(select a.id as accountability_id, a.views from accountability a
order by "views" desc, id desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) a, ownerresources o
where replace(m.mri, 'mri::', '') = a.accountability_id and o.slave = m.id
and o.type = 'POST_ACCOUNTABILITY') a, myneresourceinformation m
where a.owner = m.id ) a, ownerresources o,  myneresourceinformation m
where a.owner = o.slave and o.owner = m.id) u
					LEFT JOIN ownerresources o ON u.mri_id = o.OWNER
						AND o.type = 'USER_PROFILE_IMAGE'
					) pi
				LEFT JOIN myneresourceinformation m ON pi.id = m.id
				) o
			LEFT JOIN s3file s ON o.s3_id = s.id
			GROUP BY o.user_id, o.post_id
			) o
	WHERE o.user_id = u.id
	) u
cross join lateral findresourcedata(u.post_id) as p
) u
cross join lateral findresourcebyowner(u.id_post) as p) u
group by u.user_data, u.post_data) u
) u
