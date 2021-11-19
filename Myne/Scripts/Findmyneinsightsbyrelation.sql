CREATE OR REPLACE FUNCTION public.findmyneinsights(user_id character varying, itens_by_page integer, page integer, relation_type character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	--FOR resource_t in

--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
IF relation_type = 'FOLLOWING' then
	RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,cast('INSIGHT' as varchar) AS type
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
				
					SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWER' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
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
	) r;

elsif relation_type = 'PARTNER' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,cast('INSIGHT' as varchar) AS type
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
							,'PARTNER' as relation
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
	) r;

elsif relation_type = 'MENTOR' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,cast('INSIGHT' as varchar) AS type
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
				
				
				
					SELECT *
					FROM (
						SELECT u.from_id as to_id
							,'MENTOR' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) a limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					
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
	) r;


elsif relation_type = 'NULO' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,cast('INSIGHT' as varchar) AS type
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
	) r;
	
	end IF ;
  
 
--loop
		--RETURN NEXT resource_t;
	
   --END LOOP;
  
  	
   RETURN;

END;

$function$
;







CREATE OR REPLACE FUNCTION public.findmyneinsights(user_id character varying, itens_by_page integer, page integer, relation_type character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	--FOR resource_t in

--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
IF relation_type = 'FOLLOWING' then
	RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWER' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						)) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;

elsif relation_type = 'PARTNER' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(
					SELECT *
					FROM (
						SELECT u.to_id
							,'PARTNER' as relation
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
						) 
					) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;

elsif relation_type = 'MENTOR' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(
				
				
				
					SELECT *
					FROM (
						SELECT u.from_id as to_id
							,'MENTOR' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) a 
					
				) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;


elsif relation_type = 'NULO' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid != user_id
group by
i.user_data, i.userid) i
order by random();
	
	end IF ;
  
 
--loop
		--RETURN NEXT resource_t;
	
   --END LOOP;
  
  	
   RETURN;

END;

$function$
;

