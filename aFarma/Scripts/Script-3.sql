select b.*, (similarity(upper(unaccent(p.nome)), upper(unaccent(:busca)))) from 
(( 
select p.id, p.nome, p.ean, p.photo_id, p.descricao, p.precomedio, p.lojapromocao, ( select d.id 
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
)) b, afarma.produto p 
where p.ean=b.ean and b.precomedio != 0 and 
(p.produto_tsv @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | '))) 
or upper(unaccent(p.nome)) like concat('%',upper(unaccent(:busca)),'%')) 
order by (similarity(upper(unaccent(p.nome)), upper(unaccent(:busca)))) desc 







select r.* from pg_stat_activity r where r.backend_type='client backend'
order by r.query_start asc;
select pg_cancel_backend(22633);

