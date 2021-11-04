
SELECT replace(:user_id, 'mri::', '') as id, 
(select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(:user_id, 'mri::', '')) as type, a.data from
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






update myneresourceinformation set type = upper(replace(class_, 'etc.bda.myne.negocio.entity.', ''))
where "type" isnull


update myneresourceinformation set class_ = 'etc.bda.myne.negocio.entity.S3File'
where class_ isnull

select findfeedbyuser(:user_id, :itens_by_page, :page)

select findmynefeed(:user_id, :itens_by_page, :page)

select findresourcedata('23629e56-f782-486e-97af-1ae8923a1c9c')


select s.id as owner, p.id, p.createdate, p.description, p.title, p.cancomment from
(select i.id, o.slave from
(select distinct(i.id) from
(
(
select r.from_id as id
from public.userrelation r
where r.to_id = :user_id
and r.type = 'MENTOR')
union all
(
select r.from_id as id
from public.userrelation r
where r.to_id = :user_id
and r.type = 'PARTNER')
union all
(select r.to_id 
from public.userrelation r
where   r.from_id = :user_id
and r.type = 'FOLLOWER')
union all 
(select :user_id)
) i) i, myneresourceinformation m, ownerresources o
where replace(m.mri,'mri::','') = i.id and o.owner = m.id and (o.type = 'USER_POST' )
) s
left join 
myneresourceinformation m on m.id = s.slave
left join 
post p on replace(m.mri, 'mri::', '') = p.id




select img.owner_id, img.data as profile_image, p.data as post from
(SELECT f.OWNER AS owner_id
,m.type
,f.data
FROM PUBLIC.myneresourceinformation m
CROSS JOIN lateral findresourcedata(m.mri) AS f
where m.type = 'PROFILE_IMAGE') img
left join 
(SELECT f.OWNER AS owner_id
,m.type
,f.data
FROM PUBLIC.myneresourceinformation m
CROSS JOIN lateral findresourcedata(m.mri) AS f
where m.type = 'POST') p
on img.owner_id = p.owner_id
where img.owner_id in 
(select distinct(i.id) from
(
(
select r.from_id as id
from public.userrelation r
where r.to_id = :user_id
and r.type = 'MENTOR')
union all
(
select r.from_id as id
from public.userrelation r
where r.to_id = :user_id
and r.type = 'PARTNER')
union all
(select r.to_id 
from public.userrelation r
where   r.from_id = :user_id
and r.type = 'FOLLOWER')
union all 
(select :user_id)
) i)








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
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createDate', o."createDate") || jsonb_build_object('description', o.description) || jsonb_build_object('fileName', o."fileName") || jsonb_build_object('fileType', o."fileType") || jsonb_build_object('s3url', o.s3url)) AS profile_image
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
(select a.id as accountability_id from accountability a
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


select now()