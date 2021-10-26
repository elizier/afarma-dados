
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


				