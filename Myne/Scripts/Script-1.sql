select r.* from pg_stat_activity r where r.backend_type='client backend'
order by r.query_start asc;


select pg_cancel_backend(id);


select public.listmynerelations('3c4732e9-d1f0-4df6-b841-5277fe71a647', 'FOLLOWER', 10,0)

select myneglobalfeed(10,0)

select findmynefeed('51259dab-9dab-431d-b471-e46430ef32f4', 10, 0)


select findfeedbyuser('55f59dc6-9158-437b-ac40-981d30ca3b3f', 10, 0)

select findrelatedposts('4b8b0ab3-90c2-434f-baed-88285aa76154', 5)




select findresourcebyowner((select r.owner from findresourcedata(replace(:post_id,'mri::','')) r))

select removerelations('46769164-abf0-41da-8e91-30eb4aa69cc6', 'd70a1876-7003-4e75-a3d2-5fc6a0727652', 'FOLLOWER')




select findmynegalaxy('3c4732e9-d1f0-4df6-b841-5277fe71a647')


SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	:relation_type AS type
	,row_to_json(u.*) AS relation
FROM (
	SELECT row_to_json(u.*) AS user
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
				,o.
			ORDER
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
					,pi.
				ORDER
				FROM (
					SELECT u.user_id
						,o.slave AS id
						,u.
					ORDER
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
							,u.
						ORDER
						FROM (
							SELECT u.user_id
								,ROW_NUMBER() OVER (
									ORDER BY cast(count.data ->> 'followers' AS INTEGER) DESC
										,count.id ASC
									) AS
							ORDER
							FROM (
								SELECT u.*
								FROM PUBLIC.userrelation r
									,(
										SELECT u.id AS user_id
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
								WHERE u.user_id = r.from_id
									AND r.to_id = :user_id
									AND r.type = 'FOLLOWER'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
							) u
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
				,o.
			ORDER
			) o
	WHERE o.user_id = u.id
	ORDER BY o.
	ORDER ASC
	) u;
								

select :user_id as id, 'USER_GALAXY' as type, row_to_json(r.*) as data from 
(
select a.follower, b.following, c.partner, d.mentor, e.pupil from
(select CAST(count(u.id) AS varchar(50)) as follower
from public.userrelation u
where u.type ='FOLLOWER'
and u.to_id = :user_id) a,
(select CAST(count(u.id)AS varchar(50)) as following
from public.userrelation u
where u.type ='FOLLOWER'
and u.from_id = :user_id) b,
(select CAST(count(u.id)AS varchar(50)) as partner
from public.userrelation u
where u.type ='PARTNER'
and u.to_id = :user_id) c,
(select CAST(count(u.id)AS varchar(50)) as mentor
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = :user_id) d,
(select CAST(count(u.id)AS varchar(50)) as pupil
from public.userrelation u
where u.type ='PUPIL'
and u.to_id = :user_id) e
) r







select cast(uuid_generate_v4() as varchar) as "user_id_",--user_id_, 
       :relation_type as type, row_to_json(u.*) as relation from 
   (select   u.user , row_to_json(s.*) as profile_img  from
(
select row_to_json(u.*) as user, o.s3_id 
from (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u,
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(
select u.user_id, o.slave as id, u.order from 
(select u.user_id, m.id as mri_id, u.order from 
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.from_id 
and r.to_id = user_id_
and r.type = 'PUPIL') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) u, myneresourceinformation m  
where replace(m.mri, 'mri::','') = u.user_id) u
 left join ownerresources o
on u.mri_id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
where o.user_id=u.id
order by o.order asc
) u
left join s3file s on u.s3_id = s.id ) u;





  
select cast(uuid_generate_v4() as varchar) as "user_id_",--user_id_, 
       :relation_type as type, row_to_json(u.*) as relation from 
   (select  row_to_json(u.*) as user, (jsonb_build_object('id', o.s3_id) ||
   jsonb_build_object('createdate', o.createdate) || jsonb_build_object( 'description', o.description)
   || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype)
   || jsonb_build_object('s3url', o.s3url) ) as profile_image  from
   (select u.id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u,
(
select max(s.id) as s3_id, max(s.createdate) as createdate, max(s.description) as description, 
max(s.filename) as filename, max(s.filetype) as filetype, max(s.s3url) as s3url, o.user_id, o.order
from 
(select pi.user_id, replace(m.mri, 'mri::','') as s3_id, pi.order from 
(
select u.user_id, o.slave as id, u.order from 
(select u.user_id, m.id as mri_id, u.order from 
(
select u.user_id, ROW_NUMBER() OVER(
    order by cast(count.data ->> 'followers' AS integer) desc, count.id asc
) as order from
(select u.*
from public.userrelation r, (select u.id as user_id, u.accountname, u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from myneuser u) u
where u.user_id = r.to_id 
and   r.from_id = :user_id_
and r.type = 'FOLLOWER') u cross join lateral public.findmynegalaxy(u.user_id) as count
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) u, myneresourceinformation m  
where replace(m.mri, 'mri::','') = u.user_id) u
 left join ownerresources o
on u.mri_id = o.owner and o.type = 'USER_PROFILE_IMAGE') pi
left join myneresourceinformation m on pi.id = m.id ) o
left join 
s3file s on o.s3_id = s.id 
group by o.user_id , o.order
) o
where o.user_id=u.id
order by o.order asc
) u;






CREATE OR REPLACE FUNCTION public.findmynerelatedposts(post_id varchar, qtde integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select cast(data ->> 'id' as varchar) as id, 'POST' as type, r.data from 
findresourcebyowner((select r.owner from findresourcedata(replace(post_id,'mri::','')) r)) r
where r.type = 'POST'
and cast(data ->> 'id' as varchar) != replace(post_id,'mri::','')
order by cast(data ->> 'createdate' as timestamp) desc
limit qtde

	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;



SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	:relation_type AS type
	,row_to_json(u.*) AS relation
FROM (
	SELECT row_to_json(u.*) AS user
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
				,o.
			ORDER
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
					,pi.
				ORDER
				FROM (
					SELECT u.user_id
						,o.slave AS id
						,u.
					ORDER
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
							,u.
						ORDER
						FROM (
							SELECT u.user_id
								,ROW_NUMBER() OVER (
									ORDER BY cast(count.data ->> 'followers' AS INTEGER) DESC
										,count.id ASC
									) AS
							ORDER
							FROM ( *************) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
							) u
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
				,o.
			ORDER
			) o
	WHERE o.user_id = u.id
	ORDER BY o.
	ORDER ASC
	) u;
