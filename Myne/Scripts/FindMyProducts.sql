CREATE OR REPLACE FUNCTION public.findmyproducts(user_id character varying, type_ character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'PRODUCT' AS "type"
	,p.data
FROM (
	SELECT jsonb_build_object('user', jsonb_build_object('user', p.user) || jsonb_build_object('profile_image', i.data)) || p.product_data AS data
	FROM (
		SELECT p.user
			,p.product_data || jsonb_build_object('nested', array_agg(p.nested)) AS product_data
		FROM (
			SELECT jsonb(u.data) AS user
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS product_data
				,jsonb_build_object('type', s.type) || jsonb(s.data) AS nested
			FROM findresourcebyowner(user_id) f
			LEFT JOIN lateral findresourcebyowner(cast(f.data ->> 'id' AS VARCHAR)) AS s ON true
			LEFT JOIN lateral findresourcedata(user_id) AS u ON true
			WHERE f.type = 'PRODUCT'
				AND cast(f.data ->> 'productType' AS VARCHAR) = coalesce(type_, cast(f.data ->> 'productType' AS VARCHAR))
			) p
		GROUP BY p.user
			,p.product_data
		) p
	LEFT JOIN lateral findresourcebyowner(user_id) AS i ON true
	WHERE i.type = 'PROFILE_IMAGE'
	) p


loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


select public.findmyproducts(:user_id, :type)


select findmyneglobalfeed(10,0)





update public.s3file
set s3url = 'https://images-na.ssl-images-amazon.com/images/I/81pXbTDkkCL.jpg'
where id = 'c617d215-2b04-4854-b5cc-5072a9e64ddd'