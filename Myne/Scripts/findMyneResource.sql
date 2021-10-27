CREATE OR REPLACE FUNCTION findmyneresource(resource character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN



 	FOR resource_t in
 	
select cast(uuid_generate_v4() as varchar) as id, a.type, row_to_json(a.*) from (
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


select public.findmyneresource('ac06ba65-e689-414a-a8cd-12e7384b3803')





CREATE OR REPLACE function public.findmyneresource(resource character varying)
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
(select o.owner, f.data  from (select resource as owner) o left join 
(select f.owner, jsonb_build_object('type', f.type) || to_jsonb(f.data)	as data 
from findresourcebyowner(resource) f) f on o.owner = f.owner
) f
group by f.owner) f 
cross join lateral findresourcedata(f.owner) as o ) f

	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


 
 	select cast(uuid_generate_v4() as varchar) as id,  (select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(:resource, 'mri::', '')) as type, 
 	to_json(f.data) as data from
(select jsonb_build_object('owner_id', o.owner) || jsonb_build_object('type', o.type) || to_jsonb(o.data) || f.nested as data from
(select f.owner, jsonb_build_object('nested', array_agg(f.data)) as nested from
(select o.owner, f.data  from (select :resource as owner) o left join 
(select f.owner, jsonb_build_object('type', f.type) || to_jsonb(f.data)	as data 
from findresourcebyowner(:resource) f) f on o.owner = f.owner
) f group by f.owner) f
cross join lateral findresourcedata(f.owner) as o ) f

select findresourcedata('09b44836-e333-4d5e-bf61-3fce37f62af4')
select findresourcebyowner('2d3b457f-9090-40e0-884c-193a2957103e')
select findmyneresource('3262146d-5c25-4741-8522-82b58109ccbe')