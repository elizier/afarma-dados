--PRODUTOS_ALL_ILPI

-- Extension: pg_trgm

-- DROP EXTENSION pg_trgm;



select p.ean, count(p.ean) from
(
select p.* from
(
(select p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo, p.categoria_id, p.marca_id, p.photo_id,
p.departamento_id, p.principioativo_id, p.precomedio, p.produto_tsv  from
(select max(pr.id) as id, max(pr.contraindicacao) as contraindicacao, max(pr.descricao) as descricao, pr.ean as ean, max(pr.indicacao) as indicacao,
pr.nome as nome, length(pr.nome), '' as photo, max(pr.categoria_id) as categoria_id, max(pr.marca_id) as marca_id, max(pr.photo_id) as photo_id,
max(pr.departamento_id) as departamento_id, max(pr.principioativo_id) as principioativo_id, min(nullif(pc.valor,0)) as precomedio, max(pr.produto_tsv) as produto_tsv 
from afarma.produtocrawler pr, afarma.produtoconcorrente pc
where pr.ean=pc.ean and pr.ean not in (select distinct(gr.ean) from genericos_ref gr)
group by pr.ean, pr.nome
) p , (select pc.ean, max(length(pc.nome)) from afarma.produtocrawler pc group by pc.ean) l,
(select distinct(e.ean) from public.ean_ref e where e.ean notnull and e.ean!='DIVERSOS') e
where l.max=p.length and l.ean=p.ean and e.ean=p.ean
group by p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo, p.categoria_id, p.marca_id, p.photo_id,
p.departamento_id, p.principioativo_id, p.precomedio, p.produto_tsv ) 
union all
(select max(pr.id), max(pr.contraindicacao), max(pr.descricao), max(pr.ean), max(pr.indicacao), gg.nome, '' as photo, max(pr.categoria_id), max(pr.marca_id),
'69d460dc-c484-4cf6-b18b-3bd102acfd7a' as photo_id, max(pr.departamento_id), max(pr.principioativo_id), min(nullif(pc.valor,0)) as precomedio, max(pr.produto_tsv)
from afarma.produtocrawler pr, public.generico_grupo gg, public.genericos_ref gr, afarma.produtoconcorrente pc
where pr.ean=pc.ean and pr.ean=gr.ean and gr.grupo=gg.grupo and pr.ean in (select distinct(gr.ean) from genericos_ref gr ) 
group by gg.nome)
) p
, afarma.produtoconcorrente pc
where p.ean=pc.ean and p.precomedio notnull and
pc.concorrente_id in (select ce.concorrente_id from afarma.concorrentes_estados ce where ce.uf = :estado)
group by p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo, p.categoria_id, p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.precomedio, p.produto_tsv
order by p.nome) p
group by p.ean
order by count desc

delete from public.ean_ref 
-- PRODUTOS_ALL_ILPI_BY_CRITERIA

select p.* from
(
(select max(pr.id) as id, max(pr.contraindicacao) as contraindicacao, max(pr.descricao) as descricao, pr.ean as ean, max(pr.indicacao) as indicacao,
max(pr.nome) as nome, '' as photo, max(pr.categoria_id) as categoria_id, max(pr.marca_id) as marca_id, max(pr.photo_id) as photo_id,
max(pr.departamento_id) as departamento_id, max(pr.principioativo_id) as principioativo_id, min(nullif(pc.valor,0)) as precomedio
from afarma.produtocrawler pr, afarma.produtoconcorrente pc
where pr.ean=pc.ean and pr.ean not in (select distinct(gr.ean) from genericos_ref gr) 
group by pr.ean)
union all
(select max(pr.id), max(pr.contraindicacao), max(pr.descricao), max(pr.ean), max(pr.indicacao), gg.nome, '' as photo, max(pr.categoria_id), max(pr.marca_id),
'69d460dc-c484-4cf6-b18b-3bd102acfd7a' as photo_id, max(pr.departamento_id), max(pr.principioativo_id), min(nullif(pc.valor,0)) as precomedio
from afarma.produtocrawler pr, public.generico_grupo gg, public.genericos_ref gr, afarma.produtoconcorrente pc
where pr.ean=pc.ean and pr.ean=gr.ean and gr.grupo=gg.grupo and pr.ean in (select distinct(gr.ean) from genericos_ref gr) 
group by gg.nome)
) p, afarma.produtoconcorrente pc 
where p.ean=pc.ean and p.precomedio notnull and
(p.nome @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | ')))
or upper(unaccent(p.nome)) like concat('%',upper(unaccent(:busca)),'%')) and 
pc.concorrente_id in (select ce.concorrente_id from afarma.concorrentes_estados ce where ce.uf = :estado)
group by p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo,
p.categoria_id, p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.precomedio
order by (similarity(upper(unaccent(p.nome)), upper(unaccent(:busca)))) desc

UPDATE
    afarma.produto
SET
    produto_tsv = b.tsv
FROM
 (
  select (to_tsvector('portuguese',upper(unaccent(b.nome_produto))) || to_tsvector('portuguese',upper(unaccent(b.categoria))) || 
  to_tsvector('portuguese',upper(unaccent(b.marca))) || to_tsvector('portuguese',upper(unaccent(b.departamento))) || 
  to_tsvector('portuguese',upper(unaccent(b.principioativo))) || to_tsvector('portuguese',upper(unaccent(b.grupo)))) as "tsv", 
  b.ean as "ean_tsv", b.categoria_id, b.marca_id,
  b.departamento_id, b.principioativo_id, b.grupo_id, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo
 from  
 (  
 select  
 b.*, d.nome as "grupo"  
 from  
 (select  
 b.*, d.nome as "principioativo"  
 from  
 (select  
 b.*, d.nome as "departamento"  
 from  
 (select  
 b.*, d.nome as "marca"  
 from  
 (select   
 b.*, d.nome as "categoria"  
 from   
 (
select p.nome, c.categoria , m.marca , d.departamento , pa.descricao
from afarma.produtocrawler p, afarma.categoria c, afarma.marca m, afarma.departamento d, afarma.principioativo pa
where p.categoria_id=c.id and p.departamento_id=d.id and p.marca_id=m.id or p.principioativo_id=pa.id
group by p.nome, c.categoria , m.marca , d.departamento , pa.descricao 
 ) b  
 left join afarma.dominio d  
 on d.id = b.categoria_id) b  
 left join afarma.dominio d  
 on d.id = b.marca_id) b  
 left join afarma.dominio d  
 on d.id = b.departamento_id) b  
 left join afarma.dominio d  
 on d.id = b.principioativo_id) b  
 left join afarma.dominio d  
 on d.id = b.grupo_id  
 ) b
 group by b.nome_produto, b.ean, b.categoria_id, b.marca_id,
  b.departamento_id, b.principioativo_id, b.grupo_id, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo ) b
  where b.ean_tsv=ean;

 
select (to_tsvector('portuguese',upper(unaccent(b.nome))) || to_tsvector('portuguese',upper(unaccent(b.principioativo))) || 
  to_tsvector('portuguese',upper(unaccent(b.marca)))) --|| to_tsvector('portuguese',upper(unaccent((case when b.descricao isnull or b.descricao='' then descricao else b.descricao end))))) 
  as tsv,
  b.ean
  from (
select pc.descricao, pc.nome, pc.ean, pa.descricao as principioativo, m.marca
from afarma.produtocrawler pc, afarma.principioativo pa, afarma.marca m
where m.id=pc.marca_id and pa.id=pc.principioativo_id
) b



update afarma.produtocrawler
set produto_tsv=''
