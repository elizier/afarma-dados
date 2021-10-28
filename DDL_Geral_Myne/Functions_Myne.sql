-- Agregate tsvector

CREATE AGGREGATE tsvector_agg(tsvector) (
   STYPE = pg_catalog.tsvector,
   SFUNC = pg_catalog.tsvector_concat,
   INITCOND = ''
);



CREATE OR REPLACE FUNCTION public.finddata(resource character varying)
 RETURNS SETOF jsonresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresult%ROWTYPE;
BEGIN

 	FOR resource_t in

SELECT uuid_generate_v4(), row_to_json(a.*)
FROM (
	SELECT (case when a.owner_id = 'DON''T HAVE' then null else a.owner_id end) as owner_id
		,m.type
		,array_agg(a.data) AS data
	FROM (
		SELECT a.owner_id
			,(a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) AS data
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
				where cast(f.data ->> 'id' as varchar) = replace(resource, 'mri::', '')) a
			LEFT JOIN (
				SELECT f.OWNER
					,(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) AS data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				) f ON f.OWNER = cast(a.data ->> 'id' AS VARCHAR)
			) a
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	GROUP BY a.owner_id
		,m.type
	) a
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.finddata(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.finddata(varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.findfeedbyuser(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF feedresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.feedresult%ROWTYPE;
BEGIN

 	FOR resource_t in

 	
 	select * from
	(select 
	cast(data ->> 'id' as varchar) as id, 
	cast(data ->> 'createdate' as timestamp) as createdate,
	cast(data ->> 'description' as varchar) as description ,
	cast(data ->> 'title' as varchar) as title
	from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
group by  m.mri, mr.mri, m.type) m
cross join lateral public.findresourcedata(m.mri) as f
where m.type = 'POST' and m.owner notnull and m.owner in 
(select distinct(i.id) from
(
(
select r.from_id as id
from public.userrelation r
where r.to_id = user_id
and r.type = 'MENTOR')
union all
(select r.to_id 
from public.userrelation r
where   r.from_id = user_id
and r.type = 'FOLLOWER')
union all 
(select user_id)
) i)
order by cast(data ->> 'createdate' as timestamp) desc, cast(data ->> 'description' as varchar) asc) f
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findfeedbyuser(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findfeedbyuser(varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findfeedbyuserdata(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF jsonresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresult%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
 	
select uuid_generate_v4(), json_agg(a.*) from (
SELECT 
	row_to_json(a.*) AS post
FROM (
	SELECT (jsonb_build_object('owner_id', coalesce(a.owner_id, 'NULL')) || jsonb_build_object('owner_type', coalesce(m.type, 'NULL')) || a.data) AS data
	FROM (
		SELECT a.owner_id
			,(a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) AS data
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
				FROM findfeedbyuser(user_id, itens_by_page, page) f
				)
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	) a
ORDER BY cast(a.data ->> 'createdate' AS TIMESTAMP) desc, cast(a.data ->> 'description' AS varchar) desc) a
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findfeedbyuserdata(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findfeedbyuserdata(varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findmynefeed(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select cast(uuid_generate_v4() as varchar) as  id, (select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(user_id, 'mri::', '')) as type, u.data as data from
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
				,max(s.filename) AS "fileName"
				,max(s.filetype) AS "fileType"
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
(select u.to_id as user_id 
from public.userrelation u
where u.type ='FOLLOWER'
and u.from_id = user_id)
union all
(select u.from_id as partner
from public.userrelation u
where u.type ='PARTNER'
and u.to_id = user_id)
union all
(select u.from_id as mentor
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = user_id)
union all 
(select user_id)
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
) u
cross join lateral findresourcebyowner(u.id_post) as p) u
group by u.user_data, u.post_data, u.createdate_post) u
) u
order by createdate_post desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)

	
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmynefeed(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmynefeed(varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findmynegalaxy(user_id character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select user_id as id, 'USER_GALAXY' as type, row_to_json(r.*) as data from 
(
select a.follower, b.following, c.partner, d.mentor, e.pupil from
(select CAST(count(u.id)AS varchar(50)) as follower
from public.userrelation u
where u.type ='FOLLOWER'
and u.to_id = user_id) a,
(select CAST(count(u.id)AS varchar(50)) as following
from public.userrelation u
where u.type ='FOLLOWER'
and u.from_id = user_id) b,
(select CAST(count(u.id)AS varchar(50)) as partner
from public.userrelation u
where u.type ='PARTNER'
and u.to_id = user_id) c,
(select CAST(count(u.id)AS varchar(50)) as mentor
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = user_id) d,
(select CAST(count(u.id)AS varchar(50)) as pupil
from public.userrelation u
where u.type ='PUPIL'
and u.to_id = user_id) e
) r


loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmynegalaxy(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmynegalaxy(varchar) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findmyneglobalfeed(int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmyneglobalfeed(int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findmyneinsights(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'INSIGHT' AS type
	,to_json(r.data)
FROM (
	SELECT r.user || jsonb_build_object('insight', array_agg(r.data)) AS data
	FROM (
		SELECT r.user
			,r.insight || jsonb_build_object('nested', array_agg(r.slave)) AS data
		FROM (
			SELECT to_jsonb(h.data) || jsonb_build_object('relation', r.relation) || jsonb_build_object('profile_image', jsonb(g.data)) AS user
				,jsonb_build_object('type', i.type) || jsonb(i.data) AS insight
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS slave
			FROM (
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWING' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWING'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWING'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				UNION ALL
				
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				UNION ALL
				
				(
					SELECT *
					FROM (
						SELECT u.from_id
							,'MENTOR'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) a limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				) r
			CROSS JOIN lateral findresourcebyowner(r.to_id) AS i
			CROSS JOIN lateral findresourcebyowner(cast(i.data ->> 'id' AS VARCHAR)) AS f
			LEFT JOIN lateral findresourcebyowner(r.to_id) AS g ON true
			CROSS JOIN lateral findresourcedata(r.to_id) AS h
			WHERE i.type = 'INSIGHT'
				AND g.type = 'PROFILE_IMAGE'
			) r
		GROUP BY r.user
			,r.insight
		) r
	GROUP BY r.user
	) r
	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmyneinsights(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmyneinsights(varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findmynerelatedposts(post_id character varying, qtde integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select r.id, 'POST' as type,  r.data from 
	(select r.id, jsonb_build_object('nested', array_agg(r.nested)) || r.post as data from 
	(select f.id, jsonb_build_object( 'type', r.type) || jsonb(r.data) as nested,  to_jsonb( f.data) as post from
	(select cast(data ->> 'id' as varchar) as id, r.data from 
findresourcebyowner((select r.owner from findresourcedata(replace(post_id,'mri::','')) r)) r
where r.type = 'POST'
and cast(data ->> 'id' as varchar) != replace(post_id,'mri::','')
order by cast(data ->> 'createdate' as timestamp) desc
limit qtde) f
cross join lateral findresourcebyowner(f.id) as r ) r
group by r.id, r.post) r

	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmynerelatedposts(varchar,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmynerelatedposts(varchar,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findmynerelations(user_from character varying, user_to character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
select uuid_generate_v4() as id, 'USER_RELATIONS' as type,
json_build_object('from_id', u.from_id , 'type', u."type", 'to_id', u.to_id, 'status', u.status) as data
from relationrequest u 
where u.from_id = coalesce((case when user_from = 'a' then null else user_from end), u.from_id)
and u.to_id = coalesce((case when user_to = 'a' then null else user_to end), u.to_id)
and u.status != 'DELETED' and u.status != 'DENIED'
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)



loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmynerelations(varchar,varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmynerelations(varchar,varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findmyneresource(resource character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 
 	select cast(uuid_generate_v4() as varchar) as id,  (select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(resource, 'mri::', '')) as type, 
 	to_json(f.data) as data from
(select jsonb_build_object('owner_id', o.owner) || jsonb_build_object('type', o.type) || to_jsonb(o.data) || f.nested as data from
(select f.owner, jsonb_build_object('nested', array_agg(f.data)) as nested from
(select f.owner, jsonb_build_object('type', f.type) || to_jsonb(f.data)	as data 
from findresourcebyowner(resource) f) f
group by f.owner) f 
cross join lateral findresourcedata(f.owner) as o ) f

	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmyneresource(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmyneresource(varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.findrelatedposts(mri character varying, qtdepost integer)
 RETURNS SETOF feedresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.feedresult%ROWTYPE;
BEGIN

 	FOR resource_t in

	select cast(data ->> 'id' as varchar) as id, 
	cast(data ->> 'createdate' as timestamp) as createdate,
	cast(data ->> 'description' as varchar) as description ,
	cast(data ->> 'title' as varchar) as title
	from 
findresourcebyowner((select r.owner from findresourcedata(replace(mri,'mri::','')) r)) r
where r.type = 'POST'
and cast(data ->> 'id' as varchar) != replace(mri,'mri::','')
order by cast(data ->> 'createdate' as timestamp) desc
limit qtdepost

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findrelatedposts(varchar,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findrelatedposts(varchar,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findresourcebyowner(resource character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

select f.* from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
group by  m.mri, mr.mri, m.type) m
cross join lateral public.findresourcedata(m.mri) as f
where m.owner notnull and m.owner = replace(resource,'mri::','') and f.owner = m.owner
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findresourcebyowner(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findresourcebyowner(varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.findresourcebyownerandtype(resource character varying, type_ character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

select f.* from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner = mr.id
group by  m.mri, mr.mri, m.type) m
cross join lateral public.findresourcedata(m.mri) as f
where m.owner notnull and m.owner = replace(resource,'mri::','') and f.owner = m.owner and m.type = type_
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findresourcebyownerandtype(varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findresourcebyownerandtype(varchar,varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.findresourcedata(resource character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
     mri_type character varying;
    mri_id character varying;
BEGIN
mri_id := replace(resource,'mri::','');
  mri_type := (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = mri_id limit 1);
   


 	FOR resource_t in

	select (case when l.owner isnull then 'DON''T HAVE' else l.owner end) as owner,
	(select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = mri_id limit 1) as type,  uuid_generate_v4() as id, r.* from 
(select
(case when (mri_type) = 'USER'
   then (select row_to_json(u) from (select u.id, u.accountname as "accountName", u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from public.myneuser u where u.id= mri_id) u)
   when (mri_type) = 'POST'
    then (select row_to_json(p) from (select p.id, p.createdate as "createDate", p.description, p.title, p.cancomment as "canComment" from public.post p where p.id= mri_id order by p.createdate desc) p)
     when (mri_type) = 'SITE'
   then (select row_to_json(s) from  (select * from public.site s where s.id= mri_id) s)
   when (mri_type) = 'PHONE'
   then (select row_to_json(p) from (select * from public.phone p where p.id= mri_id) p)
    when (mri_type) = 'ACCOUNTABILITY' 
   then (select row_to_json(a) from (select * from public.accountability a where a.id= mri_id) a)
   when (mri_type) = 'INSIGHT'
   then (select row_to_json(i) from (select * from public.insight i where i.id= mri_id) i)
    when (mri_type) = 'COMMENT' 
   then (select row_to_json(c) from (select c.id, c.createdate as "createDate", c.text from public.comment c  where c.id = mri_id) c)
   when (mri_type) = 'ADDRESS'
   then (select row_to_json(a) from (select * from public.address a where a.id= mri_id) a)
   else (select row_to_json(s) from (select s.id, s.createdate as "createDate", s.description, s.filename as "filename", s.filetype as "filetype", s.s3url, s.solicitacaoid from public.s3file s where s.id= mri_id) s)
   end) as resourcedata) r,
  (select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
group by  m.mri, mr.mri, m.type) l
where r.resourcedata ->> 'id' = l.mri

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findresourcedata(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findresourcedata(varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.listmynerelations(user_id_ character varying, relation_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	--FOR resource_t in

--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
IF relation_type = 'FOLLOWER' then
	RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
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
									AND r.to_id = user_id_
									AND r.type = 'FOLLOWER'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
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

elsif relation_type = 'FOLLOWING' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
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
								WHERE u.user_id = r.to_id
									AND r.from_id = user_id_
									AND r.type = 'FOLLOWER'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
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

elsif relation_type = 'MENTOR' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
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
									AND r.to_id = user_id_
									AND r.type = 'MENTOR'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
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

elsif relation_type = 'PARTNER' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
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
								WHERE u.user_id = r.to_id
									AND r.from_id = user_id_
									AND r.type = 'PARTNER'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
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

elsif relation_type = 'PUPIL' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
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
									AND r.to_id = user_id_
									AND r.type = 'PUPIL'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
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
	
	end IF ;
  
 
--loop
		--RETURN NEXT resource_t;
	
   --END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.listmynerelations(varchar,varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.listmynerelations(varchar,varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.listresourcesbytype(resource_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

 	
select uuid_generate_v4() as id, resource_type as type, row_to_json(a.*) as data
FROM (
	SELECT (case when a.owner_id = 'DON''T HAVE' then null else a.owner_id end) as owner_id
		,m.type as owner_type
		,a.data
	FROM (
		SELECT a.owner_id
			,(a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) AS data
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
				where m.type = resource_type
				) a
			LEFT JOIN (
				SELECT f.OWNER
					,(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) AS data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				) f ON f.OWNER = cast(a.data ->> 'id' AS VARCHAR)
			) a
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
	) a
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.listresourcesbytype(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.listresourcesbytype(varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.myneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select f.id, f.type, f.data from  public.findmyneglobalfeed( itens_by_page, page) f

	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.myneglobalfeed(int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.myneglobalfeed(int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.myneresearch(research character varying, user_id character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

 select uuid_generate_v4() as id, 'POST' as type, to_json(research)  as data

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.myneresearch(varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.myneresearch(varchar,varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.myneresearch(research character varying, research_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN


IF research_type = 'POST' then
	RETURN query
	
select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data  from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and 
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
and m.type = 'POST'
group by t.id , m.mri
order by similarity desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r;




elsif research_type = 'USER' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json(r.data) as data from
(select jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and --m.type = :type and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
group by t.id , m.mri
order by similarity desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE') r;


elsif research_type isnull then

RETURN query


select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
and m.type = 'POST'
group by t.id , m.mri
order by similarity desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r

union all

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json(r.data) as data from
(select jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and m.type = 'USER' and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
group by t.id , m.mri
order by similarity desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE') r;

end IF ;
  
 

  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.myneresearch(varchar,varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.myneresearch(varchar,varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.removerelations(fromuser character varying, touser character varying, type_ character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

SELECT (
		CASE 
			WHEN (
					SELECT r.id
					FROM relationrequest r
					WHERE r.from_id = fromuser
						AND r.to_id = touser
						AND r.type = type_
						AND r.status = 'ACCEPTED' limit 1
					) notnull
				THEN 'DELETED'
			WHEN (
					SELECT r.id
					FROM relationrequest r
					WHERE r.from_id = fromuser
						AND r.to_id = touser
						AND r.type = type_
						AND r.status = 'DELETED' limit 1
					) notnull
				THEN 'ALREADY_DELETED'
			ELSE 'RELATION_NOT_FOUND'
			END
		)
into retorno;

UPDATE relationrequest
SET status = 'DELETED'
WHERE id = (
		SELECT r.id
		FROM relationrequest r
		WHERE r.from_id = fromuser
			AND r.to_id = touser
			AND r.type = type_
			AND r.status = 'ACCEPTED' limit 1
		);

DELETE
FROM userrelation
WHERE id = (
		SELECT u.id
		FROM relationrequest r
			,userrelation u
		WHERE u.from_id = r.from_id
			AND u.to_id = r.to_id
			AND u.type = r.type
			AND r.from_id = fromuser
			AND r.to_id = touser
			AND r.type = type_
			AND r.status = 'DELETED' limit 1
		);

RETURN retorno;


end;
$function$
;

-- Permissions

ALTER FUNCTION public.removerelations(varchar,varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.removerelations(varchar,varchar,varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.requestrelation(user_request character varying, user_to_follow character varying, relation_type character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

SELECT (
		CASE 
			WHEN (
					SELECT u.id
					FROM PUBLIC.userrelation u
					WHERE u.from_id = user_request
						AND u.to_id = user_to_follow
						AND u.type = relation_type
					) isnull
				THEN (
						CASE 
							WHEN (
									SELECT u.id
									FROM PUBLIC.relationrequest u
									WHERE u.from_id = user_request
										AND u.to_id = user_to_follow
										AND u.type = relation_type
										AND u.status = 'REQUESTED'
									) isnull
								THEN (
										CASE 
											WHEN (
													SELECT m.id
													FROM PUBLIC.myneuser m
													WHERE m.visibility = 'PUBLIC'
														AND m.id = user_to_follow
														AND user_to_follow != user_request
														AND relation_type = 'FOLLOWER'
													) notnull
												THEN 'ACCEPTED'
											ELSE 'REQUESTED'
											END
										)
							ELSE 'ALREADY_REQUESTED'
							END
						)
			ELSE 'ALREADY_RELATED'
			END
		)
into retorno;

INSERT into PUBLIC.userrelation
SELECT *
FROM (
	SELECT uuid_generate_v4()
		,'FOLLOWER' AS relation
		,user_request AS
	"from"
		,r.id AS to
		,now() AS DATE
	FROM (
		SELECT (
				CASE 
					WHEN (
							SELECT u.id
							FROM PUBLIC.userrelation u
							WHERE u.from_id = user_request
								AND u.to_id = user_to_follow
								AND u.type = relation_type
							) isnull
						THEN (
								CASE 
									WHEN (
											SELECT u.id
											FROM PUBLIC.relationrequest u
											WHERE u.from_id = user_request
												AND u.to_id = user_to_follow
												AND u.type = relation_type
												AND u.status = 'REQUESTED'
											) isnull
										THEN (
												CASE 
													WHEN (
															SELECT m.id
															FROM PUBLIC.myneuser m
															WHERE m.visibility = 'PUBLIC'
																AND m.id = user_to_follow
																AND user_to_follow != user_request
																--AND relation_type = 'FOLLOWER'
															) notnull
														THEN (
																case when (select u.id from userrelation u where u.from_id = user_request
																and u.to_id = user_to_follow and u.type = 'FOLLOWER' limit 1) isnull 
																then (select user_to_follow) else null end
																)
													ELSE NULL
													END
												)
									ELSE NULL
									END
								)
					ELSE NULL
					END
				) AS id
		) r
	) r
WHERE r.to notnull;

INSERT into PUBLIC.relationrequest
SELECT *
FROM (
	SELECT uuid_generate_v4()
		,relation_type AS relation
		,user_request AS
	FROM
		,r.id AS to
		,now() AS DATE
		,'REQUESTED' AS stat
	FROM (
		SELECT (
				CASE 
					WHEN (
							SELECT u.id
							FROM PUBLIC.userrelation u
							WHERE u.from_id = user_request
								AND u.to_id = user_to_follow
								AND u.type = relation_type
							) isnull
						THEN (
								CASE 
									WHEN (
											SELECT u.id
											FROM PUBLIC.relationrequest u
											WHERE u.from_id = user_request
												AND u.to_id = user_to_follow
												AND u.type = relation_type
												AND u.status = 'REQUESTED'
											) isnull
										THEN (
												CASE 
													WHEN (
															SELECT m.id
															FROM PUBLIC.myneuser m
															WHERE (
																	m.visibility = 'PRIVATE'
																	OR relation_type != 'FOLLOWER'
																	)
																AND m.id = user_to_follow
																AND user_to_follow != user_request
															) notnull
														THEN (
																SELECT user_to_follow
																)
													ELSE NULL
													END
												)
									ELSE NULL
									END
								)
					ELSE NULL
					END
				) AS id
		) r
	) r
WHERE r.to notnull;

INSERT into PUBLIC.relationrequest
SELECT r.*
FROM (
	SELECT uuid_generate_v4()
		,r.*
		,u.createdate
		,'ACCEPTED' AS status
	FROM (
		SELECT u.type
			,u.from_id
			,u.to_id
		FROM userrelation u
		
		EXCEPT
		
		SELECT r.type
			,r.from_id
			,r.to_id
		FROM relationrequest r
		) r
	LEFT JOIN userrelation u ON r.type = u.type
		AND r.from_id = u.from_id
		AND r.to_id = u.to_id
	) r;

RETURN retorno;

end;
$function$
;

-- Permissions

ALTER FUNCTION public.requestrelation(varchar,varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.requestrelation(varchar,varchar,varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.responserelationrequest(requestid character varying, status_ character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

SELECT (
		CASE 
			WHEN (
					SELECT r.STATUS
					FROM relationrequest r
					WHERE r.id = requestid
					) != 'REQUESTED'
				THEN 'ALREADY_RESPONDED'
			ELSE (
					CASE 
						WHEN status_ = 'ACCEPTED'
							THEN 'ACCEPTED'
						ELSE 'DENIED'
						END
					)
			END
		)
into retorno;

UPDATE relationrequest
SET status = (select 
(case when (select r.status from relationrequest r where r.id = requestid) = 'DENIED' then 'DENIED'
when (select r.status from relationrequest r where r.id = requestid) = 'ACCEPTED' then 'ACCEPTED' 
else  status_ end))
WHERE id = requestid;

INSERT into userrelation
SELECT *
FROM (
	SELECT uuid_generate_v4()
		,r.type
		,r.from_id
		,r.to_id
		,now()
	FROM (
		SELECT (
				CASE 
					WHEN (
							SELECT u.id
							FROM userrelation u
								,(
									SELECT r.from_id
										,r.status 
										,r.to_id
										,r.type
									FROM relationrequest r
									WHERE r.id = requestid
										AND r.status = 'ACCEPTED'
									) r
							WHERE u.from_id = r.from_id
								AND u.to_id = r.to_id
								AND u.type = r.type
							) isnull
						THEN (case when (
									SELECT r.id
									FROM relationrequest r
									WHERE r.id = requestid
										AND r.status = 'DENIED'
									) ISNULL 
									then requestid 
						else NULL end )
					ELSE NULL
					END
				) AS id
		) i
		,relationrequest r
	WHERE r.id = i.id
	) r;

INSERT into userrelation
SELECT *
FROM (
	SELECT uuid_generate_v4()
		,'FOLLOWER'
		,r.from_id
		,r.to_id
		,now()
	FROM (
		SELECT (
				CASE 
					WHEN (
							SELECT u.id
							FROM userrelation u
								,(
									SELECT r.from_id
										,r.status
										,r.to_id
										,r.type
									FROM relationrequest r
									WHERE r.id = requestid
										AND r.status = 'ACCEPTED'
										AND (r.type = 'PARTNER' or r.type = 'PUPIL' or r.type = 'MENTOR')
									) r
							WHERE u.from_id = r.from_id
								AND u.to_id = r.to_id
								AND u.type = 'FOLLOWER'
							) isnull
						THEN (case when (
									SELECT r.id
									FROM relationrequest r
									WHERE r.id = requestid
										AND r.status = 'DENIED'
									) ISNULL 
									then requestid 
						else NULL end 
								)
					ELSE NULL
					END
				) AS id
		) i
		,relationrequest r
	WHERE r.id = i.id
	) r;

RETURN retorno;

end;
$function$
;

-- Permissions

ALTER FUNCTION public.responserelationrequest(varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.responserelationrequest(varchar,varchar) TO postgres;
