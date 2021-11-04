bcc0e691-4602-479c-96b4-3603f24cbfd6

select findmyneglobalfeed(10,0)

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



cast(f.data ->> 'id' AS varchar) 


select cast(uuid_generate_v4() as varchar) as id, 'POST' as type, f.post_data || jsonb_build_object('user', jsonb_build_object('user', f.user_data) || jsonb_build_object('profile_image', array_agg(jsonb_build_object('type', u.type) || to_jsonb(u.data)))) ||
jsonb_build_object('nested',array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) as data
from
(select a.accountability_id, f.owner as user_id, to_jsonb(u.data) as user_data, jsonb_build_object('type', f.type) || to_jsonb(f.data) as post_data from
(
select a.id as accountability_id from accountability a
order by "views" desc, id desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) a
left join lateral findownerdata(a.accountability_id) f on true
left join lateral findresourcedata(f.owner) u on true) f
left join lateral findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE') u on true
left join lateral findresourcebyowner(cast(f.post_data ->> 'id' AS varchar)) p on true
where f.user_id notnull and f.user_id != 'DON''T HAVE'
group by f.user_id, f.post_data, f.user_data



ownerresources o
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



SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'POST' AS type
	,f.post_data || jsonb_build_object('user', jsonb_build_object('user', f.user_data) || jsonb_build_object('profile_image', array_agg(jsonb_build_object('type', u.type) || to_jsonb(u.data)))) || jsonb_build_object('nested', array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) AS data
FROM (
	SELECT a.accountability_id
		,f.OWNER AS user_id
		,to_jsonb(u.data) AS user_data
		,jsonb_build_object('type', f.type) || to_jsonb(f.data) AS post_data
	FROM (
		SELECT a.id AS accountability_id
		FROM accountability a
		ORDER BY "views" DESC
			,id DESC limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
		) a
	LEFT JOIN lateral findownerdata(a.accountability_id) f ON true
	LEFT JOIN lateral findresourcedata(f.OWNER) u ON true
	) f
LEFT JOIN lateral findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE') u ON true
LEFT JOIN lateral findresourcebyowner(cast(f.post_data ->> 'id' AS VARCHAR)) p ON true
WHERE f.user_id notnull
	AND f.user_id != 'DON''T HAVE'
GROUP BY f.user_id
	,f.post_data
	,f.user_data
	

	
	
	
	
CREATE OR REPLACE FUNCTION public.findmyneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in


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
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)) a, ownerresources o
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

	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;





SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'POST' AS type
	,f.post_data || jsonb_build_object('user', jsonb_build_object('user', f.user_data) || jsonb_build_object('profile_image', array_agg(jsonb_build_object('type', u.type) || to_jsonb(u.data)))) || jsonb_build_object('nested', array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) AS data
FROM (
	SELECT a.accountability_id
		,f.OWNER AS user_id
		,to_jsonb(u.data) AS user_data
		,jsonb_build_object('type', f.type) || to_jsonb(f.data) AS post_data
	FROM (
		SELECT a.id AS accountability_id
		FROM accountability a
		ORDER BY "views" DESC
			,id DESC limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
		) a
	LEFT JOIN lateral findownerdata(a.accountability_id) f ON true
	LEFT JOIN lateral findresourcedata(f.OWNER) u ON true
	) f
LEFT JOIN lateral findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE') u ON true
LEFT JOIN lateral findresourcebyowner(cast(f.post_data ->> 'id' AS VARCHAR)) p ON true
WHERE f.user_id notnull
	AND f.user_id != 'DON''T HAVE'
GROUP BY f.user_id
	,f.post_data
	,f.user_data
	

	
delete from s3file where id in
(select b.s3_id from 
(
select m.id as id_f, min(cast(f.data ->> 'createDate' AS timestamp)) as "date_f" from myneuser m
left join lateral findresourcebyownerandtype(m.id, 'PROFILE_IMAGE') as f on true
where f.data notnull
group by m.id
having count(m.id)>1
) a,
(
select m.id, cast(f.data ->> 'id' AS VARCHAR) as s3_id, cast(f.data ->> 'createDate' AS timestamp) as "date" from myneuser m
left join lateral findresourcebyownerandtype(m.id, 'PROFILE_IMAGE') as f on true
where f.data notnull
) b
where a.id_f = b.id and a.date_f = b.date)

delete from ownerresources where slave in
(select m.id from myneresourceinformation m,
(select replace(m.mri, 'mri::', '') as id from myneresourceinformation m where m."type" = 'PROFILE_IMAGE'
except
select s.id from s3file s) s
where s.id = replace(m.mri, 'mri::', ''))

delete from myneresourceinformation where id in
(select m.id from myneresourceinformation m,
(select replace(m.mri, 'mri::', '') as id from myneresourceinformation m where m."type" = 'PROFILE_IMAGE'
except
select s.id from s3file s) s
where s.id = replace(m.mri, 'mri::', ''))




select cast(uuid_generate_v4() as varchar) as id, 'POST' as type,
jsonb_build_object('user', f.user_data || jsonb_build_object('profile_image', p.data)) || f.post_data as data from
(select f.user_id,  jsonb_build_object('user', f.user_data) as user_data, f.post_data || jsonb_build_object('nested', array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) AS post_data
FROM (
	SELECT a.accountability_id
		,f.OWNER AS user_id
		,to_jsonb(u.data) AS user_data
		,jsonb_build_object('type', f.type) || to_jsonb(f.data) AS post_data
	FROM (
		SELECT a.id AS accountability_id
		FROM accountability a
		ORDER BY "views" DESC
			,id DESC limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
		) a
	LEFT JOIN lateral findownerdata(a.accountability_id) f ON true
	LEFT JOIN lateral findresourcedata(f.OWNER) u ON true
	) f
LEFT JOIN lateral findresourcebyowner(cast(f.post_data ->> 'id' AS VARCHAR)) p ON true
WHERE f.user_id notnull
	AND f.user_id != 'DON''T HAVE'
GROUP BY f.user_id
	,f.post_data
	,f.user_data
	) f
	LEFT JOIN lateral findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE') p ON true
	



