select b.*
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
(select b.id, b.nome, b.ean, b.descricao, b.categoria_id, b.marca_id, b.photo_id,
b.departamento_id, b.principioativo_id, b.grupo_id, b.contraindicacao, b.indicacao, 
(case when b.precomedio isnull then 0 else b.precomedio end), b.lojapromocao from 
(
(select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd 
where
(p.produto_tsv @@ to_tsquery('portuguese',(select replace(concat((select chr(39)),unaccent(upper(trim('%dipir%'))),(select chr(39))),' ',' | '))) 
or upper(unaccent(p.nome)) like upper(unaccent('%dipir%'))) 
and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id)
and d.tipo_id = t.id and p.descricao !=  'GENERICO'
group by
p.id, p.ean, p.nome, p.descricao)
union all
 ( select g.id, g.nome, i.max as "ean", g.descricao, g.categoria_id, g.marca_id, g.photo_id, g.departamento_id,  
 g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao, g.avg, '' as "lojapromo" , '' as "tsv"  
 from  
(select g.*, '' from
(select max(vm.id) as "id" ,g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id,
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , avg(nullif(vm.avg,0)) from
(
select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca, max(g.photo_id) as "photo_id",
(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N�O IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id",
(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N�O IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id",
(case when max(g.contraindicacao) isnull then 'N�O POSSUI' else max(g.contraindicacao) end) as "contraindicacao",
(case when max(g.indicacao) isnull then 'N�O POSSUI' else max(g.indicacao) end) as "indicacao"
from
(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id",
g.marca, max(g.photo_id) as "photo_id",
(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N�O IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",
(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N�O IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",
(case when g.contraindicacao = 'N�O POSSUI' then null else g.contraindicacao end) as "contraindicacao",
(case when g.indicacao = 'N�O POSSUI' then null else g.indicacao end) as "indicacao"
from
(select g.* from
(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'N�O IDENTIFICADO') as "marca", p.photo_id,
p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio
from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'N�O IDENTIFICADO') and
(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id)
and t.id = d.tipo_id
and (p.produto_tsv @@ to_tsquery('portuguese',(select replace(concat((select chr(39)),unaccent(upper(trim('%dipir%'))),(select chr(39))),' ',' | '))) 
or upper(unaccent(p.nome)) like upper(unaccent('%dipir%')))) g 
 right join
(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N�O IDENTIFICADO') f
on f.nome = g.nome) g
group by g.grupo_id, g.nome, g.ean, g.descricao,
g.marca, g.departamento_id, g.principioativo_id, g.contraindicacao, g.indicacao) g
where g.nome !=  ''
group by
g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca
) g
left join
(
select p.id, d.nome, (case when avg(nullif(pc.valor,0)) isnull then 0 else avg(nullif(pc.valor,0)) end) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d
where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N�O IDENTIFICADO'
and p.grupo_id = d.id and pc.ean = p.ean
group by d.nome, p.id
) vm
on vm.nome = g.nome
group by g.nome, g.ean,g.descricao, g.categoria_id, g.marca, g.photo_id, g.departamento_id,
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao
) g, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd
where
(d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id)) g
 	left join  
 	(select d.nome, max(p.ean) from afarma.dominio d, afarma.produto p where p.grupo_id=d.id group by d.nome) i  
 	on  
 	g.nome=i.nome )  
) b
group by b.id, b.nome, b.ean, b.descricao, b.categoria_id, b.marca_id, b.photo_id,
b.departamento_id, b.principioativo_id, b.grupo_id, b.contraindicacao, b.indicacao, b.precomedio, b.lojapromocao) b
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
where b.precomedio!=0 
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, b.lojapromocao,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio
order by b.nome asc
