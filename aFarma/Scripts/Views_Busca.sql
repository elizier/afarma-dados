--view Produto_All

drop materialized view PRODUTOS_ALL_OTIMIZADO_RJ

create materialized view PRODUTOS_ALL_OTIMIZADO_RJ as
(select b.*, p.produto_tsv ,
min(nullif(pc.valor,0)) as precomedio from 
(( 
select p.id, p.nome, p.ean, p.photo_id, p.descricao, p.precomedio as precomedio1, p.lojapromocao, ( select d.id 
   from afarma.dominio d, afarma.tipodominio t 
   where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='CATEGORIA')  as categoria_id, 
 ( select d.id 
   from afarma.dominio d, afarma.tipodominio t 
   where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='MARCA') as marca_id, ( select d.id 
   from afarma.dominio d, afarma.tipodominio t 
   where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='DEPARTAMENTO') as departamento_id, ( select d.id 
   from afarma.dominio d, afarma.tipodominio t 
   where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='PRINCIPIO ATIVO') as principioativo_id, ( select d.id 
   from afarma.dominio d, afarma.tipodominio t 
   where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='GRUPO') as grupo_id, cast('-' as varchar) as indicacao, cast('-' as varchar) as contraindicacao 
	from afarma.produto p 
where 
 p.descricao !=  'GENERICO' 
	group by p.id, p.nome, p.ean, p.photo_id, p.descricao, p.contraindicacao, p.indicacao, p.precomedio, p.lojapromocao 
	) 
union all 
( 
	select max(p.id), (select d.nome from afarma.dominio d where p.grupo_id=d.id) as "grupo", max(p.ean), max(p.photo_id), max(p.descricao), 
	(case when avg(nullif(pc.valor,0)) isnull then 0 else avg(nullif(pc.valor,0)) end), 
	p.lojapromocao, ( select d.id 
				   from afarma.dominio d, afarma.tipodominio t 
	where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='CATEGORIA')  as categoria_id, 
				 ( select d.id 
				   from afarma.dominio d, afarma.tipodominio t 
				   where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='MARCA') as marca_id, ( select d.id 
				   from afarma.dominio d, afarma.tipodominio t 
				   where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='DEPARTAMENTO') as departamento_id, ( select d.id 
				   from afarma.dominio d, afarma.tipodominio t 
				  where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='PRINCIPIO ATIVO') as principioativo_id, ( select d.id 
				  from afarma.dominio d, afarma.tipodominio t 
				  where d.tipo_id=t.id and d.nome='NÃO IDENTIFICADO' and t.nome='GRUPO') as grupo_id, '-' as indicacao, '-' as contraindicacao 
from afarma.produto p, 
afarma.produtoconcorrente pc 
where 
pc.ean=p.ean and 
p.descricao =  'GENERICO' 
group by grupo, p.lojapromocao 
)) b, afarma.produto p, afarma.produtoconcorrente pc, afarma.concorrente c, afarma.concorrentes_estados ce 
where p.ean=b.ean and b.precomedio1 != 0 and pc.ean=p.ean and pc.valor > 0 and 
pc.concorrente_id=c.id and c.id=ce.concorrente_id and ce.uf = 'RJ'
group by b.id, b.nome, b.ean, b.photo_id, b.descricao, b.contraindicacao, b.indicacao, b.precomedio1, b.lojapromocao, 
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, p.produto_tsv 
order by b.nome)


CREATE EXTENSION unaccent
	SCHEMA "public"
	VERSION 1.4;

select *
from public.produtos_all_otimizado_RJ po

select * from public.produtos_all_otimizado_rj po
where (po.produto_tsv @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | ')))
or upper(unaccent(po.nome)) like concat('%',upper(unaccent(:busca)),'%'))
order by (similarity(upper(unaccent(po.nome)), upper(unaccent(:busca)))) desc 

select po.*
from public.produtos_all_otimizado_RJ po, afarma.produto_departamentos pd
where pd.produto_id=po.id and pd.departamento_id = :id_departamento
group by po.id, po.nome, po.ean, po.photo_id, po.descricao, po.precomedio1, 
po.lojapromocao, po.categoria_id, po.marca_id, po.departamento_id, po.principioativo_id, po.grupo_id,
po.indicacao, po.contraindicacao, po.produto_tsv, po.precomedio 

select po.*
from public.produtos_all_otimizado_RJ po, afarma.produto_departamentos pd
where pd.produto_id=po.id and pd.departamento_id = :id_departamento
and (po.produto_tsv @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | ')))
or upper(unaccent(po.nome)) like concat('%',upper(unaccent(:busca)),'%'))
group by po.id, po.nome, po.ean, po.photo_id, po.descricao, po.precomedio1, 
po.lojapromocao, po.categoria_id, po.marca_id, po.departamento_id, po.principioativo_id, po.grupo_id,
po.indicacao, po.contraindicacao, po.produto_tsv, po.precomedio 
order by (similarity(upper(unaccent(po.nome)), upper(unaccent(:busca)))) desc


--view Produto_All ILPI


drop materialized view PRODUTOS_ALL_OTIMIZADO_ILPI_RJ;

create materialized view PRODUTOS_ALL_OTIMIZADO_ILPI_RJ as
(
select p.*, t.produto_tsv, '' as lojapromocao from
(select max(p.id) as id, max(p.contraindicacao) as contraindicacao , max(p.descricao) as descricao, p.ean, max(p.indicacao) as indicacao,
max(p.nome) as nome, max(p.photo) as photo, max(p.categoria_id) as categoria_id , max(p.marca_id) as marca_id , max(p.photo_id) as photo_id,
max(p.departamento_id) as departamento_id , max(p.principioativo_id) as principioativo_id , max(p.precomedio) as precomedio from 
((select p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo, p.categoria_id, p.marca_id, p.photo_id,
p.departamento_id, p.principioativo_id, p.precomedio  from
(select max(pr.id) as id, max(pr.contraindicacao) as contraindicacao, max(pr.descricao) as descricao, pr.ean as ean, max(pr.indicacao) as indicacao,
pr.nome as nome, length(pr.nome), '' as photo, max(pr.categoria_id) as categoria_id, max(pr.marca_id) as marca_id, max(pr.photo_id) as photo_id,
max(pr.departamento_id) as departamento_id, max(pr.principioativo_id) as principioativo_id, min(nullif(pc.valor,0)) as precomedio
from afarma.produtocrawler pr, afarma.produtoconcorrente pc
where pr.ean=pc.ean and pr.ean not in (select distinct(gr.ean) from genericos_ref gr)
group by pr.ean, pr.nome
) p , (select pc.ean, max(length(pc.nome)) from afarma.produtocrawler pc group by pc.ean) l,
(select distinct(e.ean) from public.ean_ref e where e.ean notnull and e.ean!='DIVERSOS') e
where l.max=p.length and l.ean=p.ean and e.ean=p.ean
group by p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo, p.categoria_id, p.marca_id, p.photo_id,
p.departamento_id, p.principioativo_id, p.precomedio ) 
union all
(select max(pr.id) as id, max(pr.contraindicacao), max(pr.descricao), max(pr.ean), max(pr.indicacao), gg.nome, '' as photo, max(pr.categoria_id), max(pr.marca_id),
'69d460dc-c484-4cf6-b18b-3bd102acfd7a' as photo_id, max(pr.departamento_id), max(pr.principioativo_id), min(nullif(pc.valor,0)) as precomedio
from afarma.produtocrawler pr, public.generico_grupo gg, public.genericos_ref gr, afarma.produtoconcorrente pc
where pr.ean=pc.ean and pr.ean=gr.ean and gr.grupo=gg.grupo and pr.ean in (select distinct(gr.ean) from genericos_ref gr ) 
group by gg.nome) 
) p, afarma.produtoconcorrente pc
where p.ean=pc.ean and p.precomedio notnull and p.ean!='7896026640619' and
pc.concorrente_id in (select ce.concorrente_id from afarma.concorrentes_estados ce where ce.uf = 'RJ')
group by p.ean) p 
left join (select p.id, p.produto_tsv from afarma.produtocrawler p) t
on t.id=p.id );


select * from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ po where po.precomedio notnull
and upper(unaccent(po.nome)) not like (upper(unaccent('Compacto')) and upper(unaccent('esmalte')) 
and upper(unaccent('almofada')) and upper(unaccent('pincel')) and upper(unaccent('batom')) and upper(unaccent('Babador'))
and upper(unaccent('Unha')))

select * from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ po
where (po.produto_tsv @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | ')))
or upper(unaccent(po.nome)) like concat('%',upper(unaccent(:busca)),'%'))
order by (similarity(upper(unaccent(po.nome)), upper(unaccent(:busca)))) desc

---------------------

          WHERE ce.uf::varchar = 'RJ'::varchar)) and  upper(unaccent(p.nome::varchar)) not like upper(unaccent('Compacto'::varchar)) 
          and  upper(unaccent(p.nome::varchar)) not like upper(unaccent('esmalte':: varchar))
and  upper(unaccent(p.nome::varchar)) not like  upper(unaccent('almofada'::varchar))
and  upper(unaccent(p.nome::varchar)) not like upper(unaccent('pincel'::varchar))
and  upper(unaccent(p.nome::varchar)) not like upper(unaccent('batom'::varchar))
and  upper(unaccent(p.nome::varchar)) not like upper(unaccent('Babador'::varchar))
and  upper(unaccent(p.nome::varchar)) not like  upper(unaccent('Unha'::varchar))
GROUP BY p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo, p.categoria_id, p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.precomedio, p.produto_tsv

  CREATE EXTENSION IF NOT EXISTS "unaccent";
 
 
 delete from 
 
 
 select * from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ po
			where (po.produto_tsv @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | ')))
			or upper(unaccent(po.nome)) like concat('%',upper(unaccent(:busca)),'%'))

			
update afarma.dominio set id = d.dep_id from
(select d.id as dep_id, dm.nome as dominio, dm.id as dom_id
from afarma.departamento d, afarma.dominio dm
where d.departamento = dm.nome and dm.tipo_id = 'af673c7f-b1fe-4699-bc7f-cf45b28b0409') d 
where id = d.dom_id

delete from afarma.produto 
			
			
select concat(pc."implementation", '_',left(pc.id,8),pc.ean ), pc.url from public.product_comparacao pc
