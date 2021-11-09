(SELECT * FROM accountability a 
order by a."views" desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) a


select m.id , m."type" , replace(m.mri, 'mri::', '') as mri from myneresourceinformation m 
where (m."type" = 'POST' or  m."type" = 'IMAGE' or  m."type" = 'VIDEO' or  m."type" = 'ACCOUNTABILITY' or m."type" = 'COMMENT')



select findmyproducts(:user,null)

CREATE OR REPLACE FUNCTION 
 RETURNS public.mynejsontype
 LANGUAGE plpgsql
AS $function$
declare
   password_key varchar;
begin

CREATE OR REPLACE FUNCTION public.password_recovery(user_email character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in


select cast(uuid_generate_v4() as varchar) as id, u.nome as type, to_json(jsonb_build_object('password',
(case when u.password = 'PROVIDED BY OAUTH'
then 'Your password could not be recovered.' else u.password end)))
as "data"
FROM myneuser u WHERE u.email = user_email

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;





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
			FROM findresourcebyowner(:user_id) f
			LEFT JOIN lateral findresourcebyowner(cast(f.data ->> 'id' AS VARCHAR)) AS s ON true
			LEFT JOIN lateral findresourcedata(:user_id) AS u ON true
			WHERE f.type = 'PRODUCT'
				AND cast(f.data ->> 'productType' AS VARCHAR) = coalesce(nullif(:type_,'NULO'), cast(f.data ->> 'productType' AS VARCHAR))
			) p
		GROUP BY p.user
			,p.product_data
		) p
	LEFT JOIN lateral findresourcebyowner(:user_id) AS i ON true
	WHERE i.type = 'PROFILE_IMAGE'
	) p

select public.findresourcedata('9a989993-2e30-46d0-ac99-82d66b0792d4')

select row_to_json(u) from (select u.id, u.accountname as "accountName", u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from public.myneuser u where u.id= :mri_id) u


select (case when l.owner isnull then 'DON''T HAVE' else l.owner end) as owner,
	(select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = mri_id limit 1) as type,  uuid_generate_v4() as id, r.* from 
(select row_to_json(u) from
(select u.id, u.accountname as "accountName", u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility
from public.myneuser u where u.id= :mri_id) u) r
,
  (select replace(m.mri,'mri::','') as mri , m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
group by  m.mri, mr.mri, m.type) l
where r.resourcedata ->> 'id' = l.mri



insert into myneresourceinformation (class_, mri, "type") select 'etc.bda.myne.negocio.entity.User', concat('mri::', m.id), 'USER'
from
(select m.id from myneuser m
except 
select replace(m.mri, 'mri::', '') as id from myneresourceinformation m where m.type = 'USER') m









select * from purchase p 


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
			FROM findresourcebyowner(:user_id) f
			LEFT JOIN lateral findresourcebyowner(cast(f.data ->> 'id' AS VARCHAR)) AS s ON true
			LEFT JOIN lateral findresourcedata(:user_id) AS u ON true
			WHERE f.type = 'PRODUCT'
				AND cast(f.data ->> 'productType' AS VARCHAR) = coalesce(nullif(:type_,'NULO'), cast(f.data ->> 'productType' AS VARCHAR))
			) p
		GROUP BY p.user
			,p.product_data
		) p
	LEFT JOIN lateral findresourcebyowner(:user_id) AS i ON true
	WHERE i.type = 'PROFILE_IMAGE'
	) p
	
	
select findmylearning(:user_id, :type_)	
	
CREATE OR REPLACE FUNCTION public.findmylearning(user_id character varying, type_ character varying)
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
	SELECT jsonb_build_object('nested', array_agg(p.product_nested) || p.purchase_data || p.launch_data) || jsonb_build_object('user', jsonb_build_object('profile_image', p.profile_image) || jsonb_build_object('user', p.user)) || p.product_data AS data
	FROM (
		SELECT cast(f.data ->> 'product_id' AS VARCHAR) AS product_id
			,cast(f.data ->> 'launch_id' AS VARCHAR) AS launch_id
			,jsonb_build_object('type', p.type) || jsonb(p.data) AS product_nested
			,jsonb_build_object('type', f.type) || (jsonb(f.data) - 'product_id' - 'launch_id') AS purchase_data
			,jsonb_build_object('type', 'LAUNCH') || (
				CASE 
					WHEN jsonb(l.data) isnull
						THEN jsonb_build_object('data', NULL)
					ELSE jsonb(l.data)
					END
				) AS launch_data
			,jsonb_build_object('type', pd.type) || jsonb(pd.data) AS product_data
			,jsonb_build_object('type', ph.type) || jsonb(ph.data) AS profile_image
			,jsonb(u.data) AS "user"
		FROM (
			SELECT m.id
			FROM PUBLIC.myneresourceinformation m
			WHERE m.mri = CONCAT (
					'mri::'
					,user_id
					)
			) m
		LEFT JOIN ownerresources o ON m.id = o.OWNER
		LEFT JOIN myneresourceinformation mr ON mr.id = o.slave
		LEFT JOIN lateral findresourcedata(replace(mr.mri, 'mri::', '')) AS f ON true
		LEFT JOIN lateral findresourcebyowner(cast(f.data ->> 'product_id' AS VARCHAR)) AS p ON true
		LEFT JOIN lateral findresourcedata(cast(f.data ->> 'launch_id' AS VARCHAR)) AS l ON true
		LEFT JOIN lateral findresourcedata(cast(f.data ->> 'product_id' AS VARCHAR)) AS pd ON true
		LEFT JOIN lateral findresourcebyowner(pd.OWNER) AS ph ON true
		LEFT JOIN lateral findresourcedata(pd.OWNER) AS u ON true
		WHERE o.type = 'USER_PURCHASE'
			AND ph.type = 'PROFILE_IMAGE'
			AND cast(pd.data ->> 'productType' AS VARCHAR) = coalesce(nullif(type_, 'NULO'), cast(pd.data ->> 'productType' AS VARCHAR))
		) p
	GROUP BY p.purchase_data
		,p.user
		,p.profile_image
		,p.launch_data
		,p.product_data
	) p


loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


