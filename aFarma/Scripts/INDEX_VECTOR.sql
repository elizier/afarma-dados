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
select p.nome as "nome_produto", p.ean, p.categoria_id, p.marca_id, p.departamento_id, p.principioativo_id, p.grupo_id, d.nome from afarma.produto p, afarma.dominio d 
where p.categoria_id=d.id or p.departamento_id=d.id or p.grupo_id=d.id or p.marca_id=d.id or p.principioativo_id=d.id
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
  where b.ean_tsv=ean
  
  select count(distinct(g.ean)) from public.genericos_ref g
  
ALTER TABLE tv_series ADD "document_vectors" tsvector;
 
CREATE INDEX idx_fts_prod_vec ON afarma.produto USING gin(produto_tsv);

CREATE INDEX mater_idx_fts_prod_vec_ilpi ON public.produtos_all_otimizado_ilpi_rj USING gin(produto_tsv);
 
 
ALTER TABLE afarma.produto ADD "produto_tsv" tsvector;
select uuid_generate_v4()

select unaccent(p.nome) from afarma.produto p

select p.* from afarma.produto p
where to_tsvector('portuguese',upper(unaccent(p.nome))) @@
to_tsquery('portuguese',(select replace(concat((select chr(39)),unaccent(upper(trim(:busca))),(select chr(39))),' ',' | ')))
select p.* from afarma.produto p
where to_tsvector('portuguese',(p.nome)) @@
to_tsquery('portuguese',(select replace(concat((select chr(39)),trim(:busca),(select chr(39))),' ',' | ')))
select to_tsvector('portuguese',(p.nome)), to_tsquery('portuguese',(select replace(concat((select chr(39)),trim(:busca),(select chr(39))),' ',' | ')))
from afarma.produto p where upper(p.nome) like upper('%dipirona%')

like '%DIPIRONA|COMPRIMIDO%'
 (select concat((select chr(39)),translate(unaccent(upper(trim(:busca))),' ',' / '),(select chr(39))))
 select replace(concat((select chr(39)),unaccent(upper(trim(:busca))),(select chr(39))),' ',' / ')
 
select p.* from afarma.produto p where to_tsvector(p.nome) @@ to_tsquery('fiction | theory');

SELECT * FROM afarma.produto p WHERE p.nome SIMILAR TO 'rivotril'

select concat('%(',translate(unaccent(upper(trim(:busca))),' ','|'),')%')
select * from afarma.produtocrawler pc

select ASCII('aaaaaaa')

select chr(39)
from 

ALTER TABLE afarma.produtocrawler
DROP COLUMN produto_tsv;

ALTER materialized view public.produtos_all_ilpi_otimizado_rj ALTER COLUMN produto_tsv TYPE tsvector USING produto_tsv::tsvector;

ALTER TABLE afarma.produtos_all_ilpi_otimizado_rj ALTER COLUMN produto_tsv tsv (10240,10240)

update afarma.produtocrawler set produto_tsv=''





select * from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ po
where (po.produto_tsv @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | ')))
or upper(unaccent(po.nome)) like concat('%',upper(unaccent(:busca)),'%'))
order by (similarity(upper(unaccent(po.nome)), upper(unaccent(:busca)))) desc

delete from afarma.produtoconcorrente where concorrente_id = '6ff0e219-a075-4379-94e6-10fe18248c33' 





select current_timestamp, now()




