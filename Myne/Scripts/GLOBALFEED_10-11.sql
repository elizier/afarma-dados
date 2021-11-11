


select public.myneglobalfeed(30,0)


CREATE OR REPLACE FUNCTION public.findmyneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in


select uuid_generate_v4(), 'POST' as type, a.data as data
FROM (
	SELECT (jsonb_build_object('owner', a.owner_id) || jsonb_build_object('viewbyday', v.viewbyday))
	|| (a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) as data,
	ROW_NUMBER() OVER(
    PARTITION BY a.owner_id
    ORDER BY v.viewbyday desc
)
	FROM (
		SELECT (
				CASE 
					WHEN a.owner_id = 'DON''T HAVE'
						THEN NULL
					ELSE a.owner_id
					END
				) AS owner_id
			,(jsonb_build_object('type', coalesce(a.type, 'NULL')) || jsonb(a.data)) AS data_owner
			,f.data AS data_slave
		FROM (
			SELECT f.OWNER AS owner_id
				,m.type
				,f.data
			FROM PUBLIC.myneresourceinformation m
			CROSS JOIN lateral findresourcedata(m.mri) AS f
			where m.type = 'POST'
			) a
		LEFT JOIN (
			SELECT f.OWNER
				,(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) AS data
			FROM PUBLIC.myneresourceinformation m
			CROSS JOIN lateral findresourcedata(m.mri) AS f
			) f ON f.OWNER = cast(a.data ->> 'id' AS VARCHAR)
		WHERE a.type = 'POST'
		) a
	LEFT JOIN (
		SELECT p.id AS post_id
			,-- a.accountability_id,
			(coalesce(cast(a.VIEWS AS DOUBLE PRECISION), 0) / 
			(case when (DATE_PART('day', now() - p.createdate)) = 0 then 1 else (DATE_PART('day', now() - p.createdate)) end))
			AS viewbyday
		FROM post p
		LEFT JOIN (
			SELECT f.OWNER AS post_id
				,--cast(f.data ->> 'id' AS VARCHAR) as accountability_id,
				cast(f.data ->> 'views' AS VARCHAR) AS VIEWS
			FROM post p
			CROSS JOIN lateral findresourcebyowner(p.id) AS f
			WHERE f.type = 'ACCOUNTABILITY'
			) a ON a.post_id = p.id
		ORDER BY viewbyday DESC
		) v ON v.post_id = cast(a.data_owner ->> 'id' AS VARCHAR)
	GROUP BY a.owner_id
		,a.data_owner
		,v.viewbyday
	ORDER by row_number, v.viewbyday desc
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









--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


select uuid_generate_v4(), 'POST' as type, a.data as data
FROM (
	SELECT (jsonb_build_object('owner', a.owner_id) || jsonb_build_object('viewbyday', v.viewbyday))
	|| (a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) as data,
	ROW_NUMBER() OVER(
    PARTITION BY a.owner_id
    ORDER BY v.viewbyday desc
)
	FROM (
		SELECT (
				CASE 
					WHEN a.owner_id = 'DON''T HAVE'
						THEN NULL
					ELSE a.owner_id
					END
				) AS owner_id
			,(jsonb_build_object('type', coalesce(a.type, 'NULL')) || jsonb(a.data)) AS data_owner
			,f.data AS data_slave
		FROM (
			SELECT f.OWNER AS owner_id
				,m.type
				,f.data
			FROM PUBLIC.myneresourceinformation m
			CROSS JOIN lateral findresourcedata(m.mri) AS f
			where m.type = 'POST'
			) a
		LEFT JOIN (
			SELECT f.OWNER
				,(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) AS data
			FROM PUBLIC.myneresourceinformation m
			CROSS JOIN lateral findresourcedata(m.mri) AS f
			) f ON f.OWNER = cast(a.data ->> 'id' AS VARCHAR)
		WHERE a.type = 'POST'
		) a
	LEFT JOIN (
		SELECT p.id AS post_id
			,-- a.accountability_id,
			(coalesce(cast(a.VIEWS AS DOUBLE PRECISION), 0) / 
			(case when (DATE_PART('day', now() - p.createdate)) = 0 then 1 else (DATE_PART('day', now() - p.createdate)) end))
			AS viewbyday
		FROM post p
		LEFT JOIN (
			SELECT f.OWNER AS post_id
				,--cast(f.data ->> 'id' AS VARCHAR) as accountability_id,
				cast(f.data ->> 'views' AS VARCHAR) AS VIEWS
			FROM post p
			CROSS JOIN lateral findresourcebyowner(p.id) AS f
			WHERE f.type = 'ACCOUNTABILITY'
			) a ON a.post_id = p.id
		ORDER BY viewbyday DESC
		) v ON v.post_id = cast(a.data_owner ->> 'id' AS VARCHAR)
	GROUP BY a.owner_id
		,a.data_owner
		,v.viewbyday
	ORDER by row_number, v.viewbyday desc
	limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
	) a
	
	
	
	
	
	
CREATE OR REPLACE FUNCTION public.findmyneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in


SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'POST' AS type
	,jsonb_build_object('user', f.user_data || jsonb_build_object('profile_image', p.data)) || f.post_data AS data
FROM (
	SELECT f.user_id
		,jsonb_build_object('user', f.user_data) AS user_data
		,f.post_data || jsonb_build_object('nested', array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) AS post_data
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
		where f.type = 'POST') f
	LEFT JOIN lateral findresourcebyowner(cast(f.post_data ->> 'id' AS VARCHAR)) p ON true
	WHERE f.user_id notnull
		AND f.user_id != 'DON''T HAVE'
	GROUP BY f.user_id
		,f.post_data
		,f.user_data
	) f
LEFT JOIN lateral findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE') p ON true
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in	
	
	
	select g.id, g.type, g.data from public.globalfeed g
limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)

	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


select findmyneglobalfeed(10,0)
	
	
	