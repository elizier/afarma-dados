select row_to_json(p.*) from
(select p.createdate, p.description, p.title, f.*
from public.post p cross join lateral public.findresourcebyowner(p.id) as f) p


select findfeedbyuser('55f59dc6-9158-437b-ac40-981d30ca3b3f',10,0)

select public.findresourcebyownerandtype('55f59dc6-9158-437b-ac40-981d30ca3b3f', 'POST')

select public.findresourcebyowner('df4c9062-e930-4c2a-b452-53892e820276')


select row_to_json(u.*) from (select * from myneuser) u


select json_object_agg('POST', p.data) from
(SELECT row_to_json(p.*) as data
FROM (
	SELECT p.id AS post_id
		,p.createdate
		,p.description
		,p.title
		,json_object_agg(p.type, p.data) AS content
	FROM (
	select p.*, f.owner, coalesce(f.type, 'NULL') as type, f.data from post p left join
		(SELECT f.*
		FROM PUBLIC.post p
		CROSS JOIN lateral PUBLIC.findresourcebyowner(p.id) AS f
		) f 
		on p.id = f.owner) p
	GROUP BY p.id, p.OWNER
		,p.createdate
		,p.description
		,p.title
	ORDER BY p.createdate DESC
		,p.OWNER
	) p
	) p
	
-------------------------------------

	
select json_object_agg('POST', p.data) from
(SELECT row_to_json(p.*) as data
FROM (
	SELECT p.id AS post_id
		,p.createdate
		,p.description
		,p.title
		,--json_object_agg(p.type, p.data) AS content
		array_agg(p.data) AS content
	FROM (
	select p.*, f.owner,
	(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) as data from post p left join
		(SELECT f.*
		FROM PUBLIC.post p
		CROSS JOIN lateral PUBLIC.findresourcebyowner(p.id) AS f
		) f 
		on p.id = f.owner) p
	GROUP BY p.id, p.OWNER
		,p.createdate
		,p.description
		,p.title
	ORDER BY p.createdate DESC
		,p.OWNER
	) p
	) p

	select array_agg(a.data_slave) from
(select  f.* from public.myneresourceinformation m  cross join lateral findresourcedata(m.mri) as f) a
left join
(select f.*, m.* from
	(select f.owner, jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data) from 
	public.myneresourceinformation m  cross join lateral findresourcedata(m.mri) as f) m
	cross join lateral findresourcedata(m.owner) as f) f
	
	
	
	--=============================================================================================
	
	select row_to_json(a.*)  
	from
	(select a.owner_id as id, m.type , array_agg(a.data) as data from
	(select a.owner_id, (a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) as data  from
	(select a.owner_id, (jsonb_build_object('type', coalesce(a.type, 'NULL')) || jsonb(a.data)) as data_owner, f.data as data_slave from
(select f.owner as owner_id, m.type, f.data from public.myneresourceinformation m  cross join lateral findresourcedata(m.mri) as f) a
left join
(select f.owner, (jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) as data
from public.myneresourceinformation m  cross join lateral findresourcedata(m.mri) as f) f
on f.owner = cast(a.data ->> 'id' as varchar)) a
group by a.owner_id, a.data_owner) a
left join public.myneresourceinformation m
on m.mri = concat('mri::', a.owner_id)
group by a.owner_id, m.type) a


SELECT uuid_generate_v4(), row_to_json(a.*)
FROM (
	SELECT a.owner_id AS id
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
	GROUP BY a.owner_id
		,m.type
	) a
	
--================================================================================================
	
select findresourcedata('05e262ea-7137-4f4f-b4d3-201ae0fc3051')
	
	
	select m.*
	from public.myneresourceinformation m,
	(select replace(m.mri, 'mri::', '') from public.myneresourceinformation m
	except
	select cast(data ->> 'id' as varchar) as id from
	(select  f.* from public.myneresourceinformation m  cross join lateral findresourcedata(m.mri) as f) m) p
	where concat('mri::',p.replace) = m.mri 
	
	
	
	
	
	
	
	
	
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

select public.finddata('472a4d73-9bfd-4ac4-a5e5-bc39352b761e')


select o.* from accountability a, myneresourceinformation m, ownerresources o
where a.id = translate(m.mri, 'mri::', '') and m.id = o.slave

select p.id as post_id,-- a.accountability_id,
 (coalesce(cast(a.views as double precision),0)/DATE_PART('day', now() - p.createdate)) as viewbyday from post p
left join 
(select f.owner as post_id, --cast(f.data ->> 'id' AS VARCHAR) as accountability_id,
cast(f.data ->> 'views' as varchar) as views from post p 
cross join lateral findresourcebyowner(p.id) as f
where f.type = 'ACCOUNTABILITY') a on a.post_id = p.id
order by viewbyday desc















	SELECT row_to_json(a.*)
	FROM (
		SELECT (jsonb_build_object('owner_id', a.owner_id) || jsonb_build_object('viewbyday', v.viewbyday)) as viewbyday, (a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) AS data
		FROM (
			SELECT (case when a.owner_id = 'DON''T HAVE' then null else a.owner_id end) as owner_id
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
				where a.type = 'POST'
			) a
			left join
			(select p.id as post_id,-- a.accountability_id,
 (coalesce(cast(a.views as double precision),0)/DATE_PART('day', now() - p.createdate)) as viewbyday from post p
left join 
(select f.owner as post_id, --cast(f.data ->> 'id' AS VARCHAR) as accountability_id,
cast(f.data ->> 'views' as varchar) as views from post p 
cross join lateral findresourcebyowner(p.id) as f
where f.type = 'ACCOUNTABILITY') a on a.post_id = p.id
order by viewbyday desc) v on v.post_id = cast(a.data_owner ->> 'id' as varchar)
		GROUP BY a.owner_id
			,a.data_owner
			,v.viewbyday
			order by v.viewbyday desc
		) a

		
		
CREATE OR REPLACE FUNCTION public.findfeedbyuserdata(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF jsonresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresult%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
SELECT uuid_generate_v4()
	,row_to_json(a.*) AS data
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
				) f ON f.OWNER = cast(a.data - >> 'id' AS VARCHAR)
				--where cast(a.data ->> 'id' AS VARCHAR) in (select f.id from findfeedbyuser(:user_id, :itens_by_page, :page) f)
			) a
		WHERE cast(a.data_owner - >> 'id' AS VARCHAR) IN (
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
ORDER BY cast(a.data - >> 'createdate' AS TIMESTAMP) DESC
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

select f.id from findfeedbyuser(:user_id, :itens_by_page, :page) f


select public.findfeedbyuserdata(:user_id, :itens_by_page, :page)


select uuid_generate_v4(), array_agg( a.*) as data  from (
	SELECT (jsonb_build_object('owner_id', coalesce(a.owner_id, 'NULL')) || jsonb_build_object('owner_type', coalesce(m.type, 'NULL')) || a.data) as data
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
				--where cast(a.data ->> 'id' AS VARCHAR) in (select f.id from findfeedbyuser(:user_id, :itens_by_page, :page) f)
			) a
			where cast(a.data_owner ->> 'id' AS VARCHAR) in (select f.id from findfeedbyuser(:user_id, :itens_by_page, :page) f)
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)order by cast(a.data ->> 'createdate' AS timestamp) desc) a
		
			
			
			
			
select findglobalfeeddata('.')
select public.finddata(
			





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
				FROM findfeedbyuser(:user_id, :itens_by_page, :page) f
				)
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	) a
ORDER BY cast(a.data ->> 'createdate' AS TIMESTAMP) desc) a
			
			
			
			
			
	
	=============================
	
	
	CREATE OR REPLACE FUNCTION public.findresourcedata(resource character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

	select (case when l.owner isnull then 'DON''T HAVE' else l.owner end) as owner, r.* from 
(select
(select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) as type,  uuid_generate_v4() as id,
(case when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'USER'
   then (select row_to_json(u) from (select * from public.myneuser u where u.id= replace(resource,'mri::','')) u)
   when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'POST'
    then (select row_to_json(p) from (select * from public.post p where p.id= replace(resource,'mri::','') order by p.createdate desc) p)
     when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'SITE'
   then (select row_to_json(s) from  (select * from public.site s where s.id= replace(resource,'mri::','')) s)
   when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'PHONE'
   then (select row_to_json(p) from (select * from public.phone p where p.id= replace(resource,'mri::','')) p)
    when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'ACCOUNTABILITY' 
   then (select row_to_json(a) from (select * from public.accountability a where a.id= replace(resource,'mri::','')) a)
   when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'ADDRESS'
   then (select row_to_json(a) from (select * from public.address a where a.id= replace(resource,'mri::','')) a)
   else (select row_to_json(s) from (select * from public.s3file s where s.id= replace(resource,'mri::','')) s)
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


select public.findresourcedata('c43e32cb-3de3-4725-8ab3-452db932ec07')
