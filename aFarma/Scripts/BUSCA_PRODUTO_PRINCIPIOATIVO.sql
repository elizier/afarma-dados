--Busca sem departamento

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
(
(select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) or upper(p.nome) like upper(:busca))
and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id)
and d.tipo_id = t.id and p.descricao !=  'GENERICO'
group by 
p.id, p.ean, p.nome, p.descricao)
union all
(select g.* from
(select cast(uuid_generate_v4() as varchar),g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id,
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , vm.avg from 
(
select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca, max(g.photo_id) as "photo_id", 
(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id",
(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id",
(case when max(g.contraindicacao) isnull then 'NÃO POSSUI' else max(g.contraindicacao) end) as "contraindicacao",
(case when max(g.indicacao) isnull then 'NÃO POSSUI' else max(g.indicacao) end) as "indicacao"
from
(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id",
g.marca, max(g.photo_id) as "photo_id", 
(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') then null else g.departamento_id end) as "departamento_id", 
(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id", 
(case when g.contraindicacao = 'NÃO POSSUI' then null else g.contraindicacao end) as "contraindicacao",
(case when g.indicacao = 'NÃO POSSUI' then null else g.indicacao end) as "indicacao"
from
(select g.* from 
(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') as "marca", p.photo_id,
p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio
from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') and 
(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id)
and t.id = d.tipo_id) g
right join 
(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'NÃO IDENTIFICADO') f
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
select d.nome, (case when avg(nullif(pc.valor,0)) isnull then 0 else avg(nullif(pc.valor,0)) end) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d
where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'NÃO IDENTIFICADO'
and p.grupo_id = d.id and pc.ean = p.ean 
group by d.nome
) vm
on vm.nome = g.nome
) g, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) or upper(g.nome) like upper(:busca))
and  (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id))
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
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio



-- BUSCAS com departamento


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
(
(select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) or upper(p.nome) like upper(:busca))
and
d.id = :id_departamento
and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id)
and d.tipo_id = t.id and p.descricao !=  'GENERICO'
group by 
p.id, p.ean, p.nome, p.descricao)
union all
(select g.* from
(select cast(uuid_generate_v4() as varchar),g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id,
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , vm.avg from 
(
select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca, max(g.photo_id) as "photo_id", 
(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id",
(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id",
(case when max(g.contraindicacao) isnull then 'NÃO POSSUI' else max(g.contraindicacao) end) as "contraindicacao",
(case when max(g.indicacao) isnull then 'NÃO POSSUI' else max(g.indicacao) end) as "indicacao"
from
(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id",
g.marca, max(g.photo_id) as "photo_id", 
(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') then null else g.departamento_id end) as "departamento_id", 
(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id", 
(case when g.contraindicacao = 'NÃO POSSUI' then null else g.contraindicacao end) as "contraindicacao",
(case when g.indicacao = 'NÃO POSSUI' then null else g.indicacao end) as "indicacao"
from
(select g.* from 
(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') as "marca", p.photo_id,
p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio
from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') and 
(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id)
and t.id = d.tipo_id) g
right join 
(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'NÃO IDENTIFICADO') f
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
select d.nome, (case when avg(nullif(pc.valor,0)) isnull then 0 else avg(nullif(pc.valor,0)) end) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d
where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'NÃO IDENTIFICADO'
and p.grupo_id = d.id and pc.ean = p.ean 
group by d.nome
) vm
on vm.nome = g.nome
) g, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) or upper(g.nome) like upper(:busca))
and  (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id)
and
d.id = :id_departamento)
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
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio


-- Busca só pelo departamento


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
( 
(select p.* 
from afarma.produto p, afarma.dominio d, afarma.tipodominio t  
where 

 d.id = :id_departamento 
and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 
and d.tipo_id = t.id and p.descricao !=  'GENERICO' 
group by  
p.id, p.ean, p.nome, p.descricao) 
union all 
(select g.* from 
(select cast(uuid_generate_v4() as varchar),g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id, 
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , vm.avg from  
( 
select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 
g.marca, max(g.photo_id) as "photo_id",  
(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id", 
(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id", 
(case when max(g.contraindicacao) isnull then 'NÃO POSSUI' else max(g.contraindicacao) end) as "contraindicacao", 
(case when max(g.indicacao) isnull then 'NÃO POSSUI' else max(g.indicacao) end) as "indicacao" 
from 
(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id", 
g.marca, max(g.photo_id) as "photo_id",  
(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",  
(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",  
(case when g.contraindicacao = 'NÃO POSSUI' then null else g.contraindicacao end) as "contraindicacao", 
(case when g.indicacao = 'NÃO POSSUI' then null else g.indicacao end) as "indicacao" 
from 
(select g.* from  
(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') as "marca", p.photo_id, 
p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio 
from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') and  
(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 
and t.id = d.tipo_id) g 
right join  
(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'NÃO IDENTIFICADO') f 
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
select d.nome, (case when avg(nullif(pc.valor,0)) isnull then 0 else avg(nullif(pc.valor,0)) end) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d 
where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'NÃO IDENTIFICADO' 
and p.grupo_id = d.id and pc.ean = p.ean  
group by d.nome 
) vm 
on vm.nome = g.nome 
) g, afarma.dominio d, afarma.tipodominio t  
where 
 (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id) 
and 
d.id = :id_departamento) 
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
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, 
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio 


-- Todo produto

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
( 
	(select p.* 
	from afarma.produto p, afarma.dominio d, afarma.tipodominio t  
	where 
	--(upper(d.nome) like upper(:busca) or upper(p.nome) like upper(:busca)) and 
	--d.id = :id_departamento 
	--and  
	(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 
	and d.tipo_id = t.id and p.descricao !=  'GENERICO' 
	group by  
	p.id, p.ean, p.nome, p.descricao) 
union all 
	(select g.* from 
	(select cast(uuid_generate_v4() as varchar),g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id, 
	g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , vm.avg from  
	( 
	select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 
	g.marca, max(g.photo_id) as "photo_id",  
	(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id", 
	(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id", 
	(case when max(g.contraindicacao) isnull then 'NÃO POSSUI' else max(g.contraindicacao) end) as "contraindicacao", 
	(case when max(g.indicacao) isnull then 'NÃO POSSUI' else max(g.indicacao) end) as "indicacao" 
	from 
	(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id", 
	g.marca, max(g.photo_id) as "photo_id",  
	(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",  
	(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",  
	(case when g.contraindicacao = 'NÃO POSSUI' then null else g.contraindicacao end) as "contraindicacao", 
	(case when g.indicacao = 'NÃO POSSUI' then null else g.indicacao end) as "indicacao" 
	from 
	(select g.* from  
	(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') as "marca", p.photo_id, 
	p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio 
	from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'NÃO IDENTIFICADO') and  
	(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 
	and t.id = d.tipo_id) g 
	right join  
	(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'NÃO IDENTIFICADO') f 
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
	select d.nome, (case when avg(nullif(pc.valor,0)) isnull then 0 else avg(nullif(pc.valor,0)) end) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d 
	where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'NÃO IDENTIFICADO' 
	and p.grupo_id = d.id and pc.ean = p.ean  
	group by d.nome 
	) vm 
	on vm.nome = g.nome 
	) g, afarma.dominio d, afarma.tipodominio t  
	where 
	 (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id) 
	and 
	(upper(d.nome) like upper(:busca) or upper(g.nome) like upper(:busca)) and 
	d.id = :id_departamento) 
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
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, 
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio 




SELECT name, brand, ean, category, department, implementation, price, contraindication, indication, description,  url, related_products, active_ingredient, retencao_receita
FROM public.product;









