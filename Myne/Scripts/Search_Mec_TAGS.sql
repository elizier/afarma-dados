select p.* from afarma.produto p
where to_tsvector('portuguese',upper(unaccent(p.nome))) @@
to_tsquery('portuguese',(select replace(concat((select chr(39)),unaccent(upper(trim(:busca))),(select chr(39))),' ',' | ')))
select p.* from afarma.produto p
where to_tsvector('portuguese',(p.nome)) @@
to_tsquery('portuguese',(select replace(concat((select chr(39)),trim(:busca),(select chr(39))),' ',' | ')))
select to_tsvector('portuguese',(p.nome)), to_tsquery('portuguese',(select replace(concat((select chr(39)),trim(:busca),(select chr(39))),' ',' | ')))
from afarma.produto p where upper(p.nome) like upper('%dipirona%')

select * from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ po
where (po.produto_tsv @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | ')))
or upper(unaccent(po.nome)) like concat('%',upper(unaccent(:busca)),'%'))
order by (similarity(upper(unaccent(po.nome)), upper(unaccent(:busca)))) desc

select m.id from myneresourceinformation m
where (m."type" = 'POST' or m."type" = 'PRODUCT' or m."type" = 'INSIGHT')



update tag set tag_tsv = t.tsv
from (select t.id as id1, t.tag, to_tsvector('portuguese', unaccent(t.tag)) as tsv
from tag t where t.tag_tsv isnull) t
where t.id1 = id
'MATHEUS BORRACHA GAMING'
select public.myneresearch('MATHEUS BORRACHA GAMING', null,10,0)

CREATE OR REPLACE FUNCTION public.myneresearch(research character varying, research_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN


IF research_type = 'POST' then
	RETURN query
	
select cast(uuid_generate_v4() as varchar) as id,  'POST' as type, r.data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(myne_search)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and 
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(myne_search)),' ',' | ')))
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

select cast(uuid_generate_v4() as varchar) as id,  'RESEARCH' as type,
jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:busca)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and --m.type = :type and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(:busca)),' ',' | ')))
group by t.id , m.mri
order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE'


elsif research_type isnull then

RETURN query


select cast(uuid_generate_v4() as varchar) as id,  'RESEARCH' as type, to_json( r.data) as data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:busca)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and --m.type = :type and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(:busca)),' ',' | ')))
and m.type = 'POST'
group by t.id , m.mri
order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r

union all


select cast(uuid_generate_v4() as varchar) as id, 'USER' as type,  to_json(r.data) from 
(select jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:busca)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and m.type = 'USER' and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(:busca)),' ',' | ')))
group by t.id , m.mri
order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE') r;


end IF ;
  
 

  
  	
   RETURN;

END;

$function$
;




select to_tsquery('portuguese', unaccent(concat((select chr(39)),trim(:busca),(select chr(39)))))

select replace()

CREATE AGGREGATE tsvector_agg(tsvector) (
   STYPE = pg_catalog.tsvector,
   SFUNC = pg_catalog.tsvector_concat,
   INITCOND = ''
);



select to_tsvector('portuguese', unaccent('"cachorro", "gato", "papagaio"'))


select public.findmynefeed('51259dab-9dab-431d-b471-e46430ef32f4',10,0)













select public.findmynerelations('55f59dc6-9158-437b-ac40-981d30ca3b3f',null, 10, 0)






































select cast(uuid_generate_v4() as varchar) as  id, (select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(:user_id, 'mri::', '')) as type, u.data as data from
(
select  u.createdate_post, jsonb_build_object('user', u.user_data) || u.post as data  from 
(
select  u.createdate_post, u.user_data, u.post_data || jsonb_build_object('nested', array_agg(u.data))  as post from
(
select  u.createdate_post, jsonb(u.user_data) as user_data, jsonb(u.post_data) as post_data, jsonb_build_object('type', p.type) || jsonb(p.data) as data from
(SELECT row_to_json(u.*) as user_data, jsonb_build_object('type', p.type) || jsonb(p.data) as post_data, cast(p.data ->> 'createDate' AS TIMESTAMP) as createdate_post, cast(p.data ->> 'id' AS varchar) as id_post
FROM (
	select u.id, row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createDate', o."createDate") || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype) || jsonb_build_object('s3url', o.s3url)) AS profile_image
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
				,max(s.filename) AS filename
				,max(s.filetype) AS filetype
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
and u.from_id = :user_id)
union all
(select u.from_id as partner
from public.userrelation u
where u.type ='PARTNER'
and u.to_id = :user_id)
union all
(select u.from_id as mentor
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = :user_id)
union all 
(select :user_id)
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
group by u.user_data, u.post_data,  u.createdate_post) u
) u
order by u.createdate_post desc

select findmynefeed('c43e32cb-3de3-4725-8ab3-452db932ec07', 50, 0)
select findmyneglobalfeed(50,0)

select public.findmynerelations(null, null, null, null)

CREATE OR REPLACE FUNCTION public.findmynerelations(user_from character varying, user_to character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
select uuid_generate_v4() as id, 'USER_GALAXY' as type,
json_build_object('from_id', u.from_id , 'type', u."type", 'to_id', u.to_id) as data
from userrelation u 
where u.from_id = coalesce(user_from, u.from_id) and u.to_id = coalesce(user_to, u.to_id)
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)



loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


select public.findmynerelations('d3b54cf3-a37a-4cf7-8e96-cd1764411e2b','51259dab-9dab-431d-b471-e46430ef32f4',100,0)


select uuid_generate_v4() as id, 'USER_RELATIONS' as type,
json_build_object('from_id', u.from_id , 'type', u."type", 'to_id', u.to_id, 'status', u.status) as data
from relationrequest u 
where u.from_id = coalesce((case when :user_from = 'a' then null else :user_from end), u.from_id)
and u.to_id = coalesce((case when :user_to = 'a' then null else :user_to end), u.to_id) 
and u.status != 'DELETED' and u.status != 'DENIED'
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)


