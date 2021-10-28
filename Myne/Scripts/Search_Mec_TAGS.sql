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





{"resource_id":"61707c79-4381-4ab5-bac0-1bf6a908eab7","id":"bb52c338-fc7a-4d10-b630-61fadd5bd31c","tsvector_agg":"'matheus':2 'matheust':1 'test':3","similarity":0.53333336}



(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(:myne_search)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and 
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(:myne_search)),' ',' | ')))
and m.type = 'PRODUCT'
group by t.id , m.mri
order by similarity desc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) p











select to_tsvector('portuguese', unaccent('"cachorro", "gato", "papagaio"'))








CREATE OR REPLACE FUNCTION public.myneresearchfeed(research character varying, research_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

	
	public.myneresearch()
