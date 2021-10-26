
SELECT uuid_generate_v4() as id,--replace(user_id, 'mri::', '') as id, 
(select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(user_id, 'mri::', '')) as type, a.data from
	(
	SELECT 
	jsonb_build_object('owner',coalesce(a.owner_id, 'NULL')) ||  jsonb_build_object('owner_type',coalesce(m.type, 'NULL'))  
	 || jsonb(a.data) as data
	FROM (
		SELECT a.owner_id
			,(a.data_owner || jsonb_build_object('nested', array_agg(a.data_slave))) AS data
		FROM (
			SELECT a.owner_id
				,(jsonb_build_object('type', coalesce(a.type, 'NULL')) || jsonb(a.data)) AS data_owner
				,f.data AS data_slave
			FROM (
				SELECT f.OWNER AS owner_id
					,m.type
					,f.data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				) a
			LEFT JOIN (
				SELECT f.OWNER
					,(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) AS data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				) f ON f.OWNER = cast(a.data ->> 'id' AS VARCHAR)
			) a
		WHERE cast(a.data_owner ->> 'id' AS VARCHAR) IN (
				SELECT f.id
				FROM findfeedbyuser(:user_id, :itens_by_page, :page) f
				)
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	
ORDER BY cast(a.data ->> 'createdate' AS TIMESTAMP) desc, cast(a.data ->> 'description' AS varchar) desc) a


select findmynefeed('6d17dbd1-cbc5-40d6-bb48-e2543d58570e', 5,0)

select u.id AS user_id
											,u.accountname
											,u.active
											,u.createdate
											,u.devicetoken
											,u.email
											,u.name
											,u.slug
											,u.usertype
											,u.visibility
											from
											
(select distinct(u.user_id)
from
(
(select u.from_id as user_id
from public.userrelation u
where u.type ='FOLLOWER'
and u.to_id = :user_id)
union all
(select u.to_id as following
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
(select u.from_id as pupil
from public.userrelation u
where u.type ='PUPIL'
and u.to_id = :user_id)
) u) mu, myneuser u
where 
u.id = mu.user_id




select cast(uuid_generate_v4() as varchar) as  id, (select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(:user_id, 'mri::', '')) as type, row_to_json(u.*) as data from
(
select jsonb_build_object('user', u.user_data) || u.post as data  from 
(
select u.user_data, u.post_data || jsonb_build_object('nested', array_agg(u.data))  as post from
(
select  jsonb(u.user_data) as user_data, jsonb(u.post_data) as post_data, jsonb_build_object('type', p.type) || jsonb(p.data) as data from
(SELECT row_to_json(u.*) as user_data, jsonb_build_object('type', p.type) || jsonb(p.data) as post_data, cast(p.data ->> 'createdate' AS TIMESTAMP) as createdate_post, cast(p.data ->> 'id' AS varchar) as id_post
FROM (
	select u.id, row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createdate', o.createdate) || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype) || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname
			,u.active
			,u.createdate
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
				,max(s.createdate) AS createdate
				,max(s.description) AS description
				,max(s.filename) AS filename
				,max(s.filetype) AS filetype
				,max(s.s3url) AS s3url
				,o.user_id
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
				FROM (
					SELECT u.user_id
						,o.slave AS id
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
						FROM (select distinct(u.user_id) as user_id
from
(
(select u.from_id as user_id
from public.userrelation u
where u.type ='FOLLOWER'
and u.to_id = :user_id)
union all
(select u.to_id as following
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
(select u.from_id as pupil
from public.userrelation u
where u.type ='PUPIL'
and u.to_id = :user_id)
) u) u
							,myneresourceinformation m
						WHERE replace(m.mri, 'mri::', '') = u.user_id
						) u
					LEFT JOIN ownerresources o ON u.mri_id = o.OWNER
						AND o.type = 'USER_PROFILE_IMAGE'
					) pi
				LEFT JOIN myneresourceinformation m ON pi.id = m.id
				) o
			LEFT JOIN s3file s ON o.s3_id = s.id
			GROUP BY o.user_id
			) o
	WHERE o.user_id = u.id
	) u
cross join lateral findresourcebyownerandtype(u.id, 'POST') as p
order by cast(p.data ->> 'createdate' AS TIMESTAMP) desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) u
cross join lateral findresourcebyowner(u.id_post) as p) u
group by u.user_data, u.post_data) u
) u
;





select cast(uuid_generate_v4() as varchar) as  id, 'POST' as type, row_to_json(u.*) as data from
(
select jsonb_build_object('user', u.user_data) || u.post as data  from 
(
select u.user_data, u.post_data || jsonb_build_object('nested', array_agg(u.data))  as post from
(
select  jsonb(u.user_data) as user_data, jsonb(u.post_data) as post_data, jsonb_build_object('type', p.type) || jsonb(p.data) as data from
(SELECT json_build_object('user',u.user ,'profile_image',u.profile_image)  as user_data, jsonb_build_object('type', p.type) || jsonb(p.data) as post_data, cast(p.data ->> 'createdate' AS TIMESTAMP) as createdate_post, cast(p.data ->> 'id' AS varchar) as id_post
FROM (
	select o.post_id, u.id, row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createdate', o.createdate) || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype) || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname
			,u.active
			,u.createdate
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
				,max(s.createdate) AS createdate
				,max(s.description) AS description
				,max(s.filename) AS filename
				,max(s.filetype) AS filetype
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
(select a.id as accountability_id from accountability a
order by "views" desc
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
;

select p.post_id,  (a.views)/(DATE_PART('day', now() - po.createdate)) as viewbyday from
(select replace(m.mri, 'mri::', '') as post_id, o.slave from myneresourceinformation m, ownerresources o
where m.id = o.owner and m."type" = 'POST' and o."type" = 'POST_ACCOUNTABILITY') p,
myneresourceinformation m, accountability a, post po where po.id = p.post_id
and p.slave = m.id and replace(m.mri, 'mri::', '') = a.id


select findresourcedata('15a8f1f7-aa88-4355-b156-45aa7309dc72')

15a8f1f7-aa88-4355-b156-45aa7309dc72
f9553f3b-94bd-4f00-8146-c9aef41a831a
6e9ab606-f502-4da5-b61b-78fbd1fb41b9
3dc8a3c4-623e-454e-b5d7-4af24dd11d52
23629e56-f782-486e-97af-1ae8923a1c9c

select public.findmyneglobalfeed(5, 0)


select replace(m.mri, 'mri::', '') as user_id, a.post_id from
(select a.owner, replace(m.mri, 'mri::', '') as post_id, a.accountability_id from  
(select o.owner, a.accountability_id from myneresourceinformation m,
(select a.id as accountability_id from accountability a
order by "views" desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) a, ownerresources o
where replace(m.mri, 'mri::', '') = a.accountability_id and o.slave = m.id
and o.type = 'POST_ACCOUNTABILITY') a, myneresourceinformation m
where a.owner = m.id ) a, ownerresources o,  myneresourceinformation m
where a.owner = o.slave and o.owner = m.id
