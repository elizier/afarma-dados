CREATE OR REPLACE FUNCTION public.insertadmindata()
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

insert into myneuser(id,accountname,active,createdate,email,name,password,usertype,visibility,method)
values (uuid_generate_v4(), 'MYNE_SYSTEM_USER', true, now(),
'sender@myne.net.br', 'System User','duBl4ck@pw', 'USER', 'PRIVATE', 'Myne');

select 'DONE' into retorno;

return retorno;


end;
$function$
;

select public.insertadmindata()

select listresourcesbytype(resource_type character varying, itens_by_page integer, page integer) -- listar resources por tipo com paginação

select findmyneresource(resource character varying) --  listar recursos por owner

select public.myneglobalfeed(itens_by_page integer, page integer) -- feed aberto e paginado

select public.findmynefeed(user_id character varying, itens_by_page integer, page integer) -- feed do usuário paginado

select public.myneresearch(research character varying, user_id character varying) -- pesquisa por tags e/ou usuário

select public.listresourcesbytype('POST',0,0)


CREATE OR REPLACE FUNCTION listresourcesbytype(resource_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

 	
select uuid_generate_v4() as id, resource_type as type, jsonb_agg(a.data) from (
SELECT row_to_json(a.*) as data
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
	GROUP BY a.owner_id
		,m.type
	) a
	) a
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


CREATE OR REPLACE FUNCTION public.findmyneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

 	select uuid_generate_v4(), 'POST' as type, a.data from ( 
select json_agg(a.data) as data
FROM (
	SELECT (jsonb_build_object('owner_id', a.owner_id) || jsonb_build_object('viewbyday', v.viewbyday))
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
	
	) a) a
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

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




CREATE OR REPLACE FUNCTION public.findmynefeed(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in


select a.id, a.type, row_to_json(a.*) as data  from (
SELECT replace(user_id, 'mri::', '') as id, 
(select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(user_id, 'mri::', '')) as type,
	jsonb_agg(a.data) as data from
	(
	SELECT 
	jsonb_build_object('owner_id',coalesce(a.owner_id, 'NULL')) ||  jsonb_build_object('owner_type',coalesce(m.type, 'NULL'))  
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
				FROM findfeedbyuser(user_id, itens_by_page, page) f
				)
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	
ORDER BY cast(a.data ->> 'createdate' AS TIMESTAMP) desc, cast(a.data ->> 'description' AS varchar) desc) a
) a
	
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


CREATE OR REPLACE FUNCTION public.findmyneresource(resource character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
select a.id, a.type, row_to_json(a.*) from (
select replace(resource, 'mri::', '') as id, 
(select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(resource, 'mri::', '')) as type,
(jsonb_build_object('owner', a.owner_id) || jsonb_build_object('owner_type', a.type) || a.data) as data
FROM ( 
	SELECT (case when a.owner_id = 'DON''T HAVE' then null else a.owner_id end) as owner_id
		,m.type
		,a.data AS data
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
	GROUP BY a.owner_id, a.data
		,m.type
	) a
	) a
	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


CREATE OR REPLACE FUNCTION public.listresourcesbytype(mri_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

 	
select uuid_generate_v4() as id, mri_type as type, jsonb_agg(a.data) from (
SELECT row_to_json(a.*) as data
FROM (
	SELECT (case when a.owner_id = 'DON''T HAVE' then null else a.owner_id end) as owner_id
		,m.type as owner_type
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
				where m.type = mri_type
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
	) a
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;
