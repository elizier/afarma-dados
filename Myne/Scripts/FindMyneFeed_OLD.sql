CREATE OR REPLACE FUNCTION public.findmynefeed(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

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

	
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;
