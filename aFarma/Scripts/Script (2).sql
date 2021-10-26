--public static final String PRODUTOS_ALL = 
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

	(select g.*, '' from 

	(select cast(uuid_generate_v4() as varchar),g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id, 

	g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , vm.avg from  

	( 

	select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 

	g.marca, max(g.photo_id) as "photo_id",  

	(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id", 

	(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id", 

	(case when max(g.contraindicacao) isnull then 'N√O POSSUI' else max(g.contraindicacao) end) as "contraindicacao", 

	(case when max(g.indicacao) isnull then 'N√O POSSUI' else max(g.indicacao) end) as "indicacao" 

	from 

	(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id", 

	g.marca, max(g.photo_id) as "photo_id",  

	(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",  

	(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",  

	(case when g.contraindicacao = 'N√O POSSUI' then null else g.contraindicacao end) as "contraindicacao", 

	(case when g.indicacao = 'N√O POSSUI' then null else g.indicacao end) as "indicacao" 

	from 

	(select g.* from  

	(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') as "marca", p.photo_id, 

	p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio 

	from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') and  

	(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

	and t.id = d.tipo_id) g 

	right join  

	(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO') f 

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

	where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO' 

	and p.grupo_id = d.id and pc.ean = p.ean  

	group by d.nome 

	) vm 

	on vm.nome = g.nome 

	) g, afarma.dominio d, afarma.tipodominio t  

	where 

	 (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id) 

	--and 

	--(upper(d.nome) like upper(:busca) or upper(g.nome) like upper(:busca)) and 

	--d.id = :id_departamento
	) 

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

group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, b.lojapromocao, 

b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio 
order by b.nome ASC

-------------------------------------------------------------------

--public static final String PRODUTOS_BY_DEPARTAMENTO = 

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

b.departamento_id, b.principioativo_id, b.grupo_id, b.contraindicacao, b.indicacao, b.precomedio, b.lojapromocao from

( 

(select p.* 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd  

where 


 pd.produto_id=p.id and pd.departamento_id = :id_departamento 

and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

and d.tipo_id = t.id and p.descricao !=  'GENERICO' 

group by  

p.id, p.ean, p.nome, p.descricao) 

union all 

(select g.*, '' from 

(select max(vm.id) as "id" ,g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , avg(nullif(vm.avg,0)) from  

( 

select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 

g.marca, max(g.photo_id) as "photo_id",  

(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id", 

(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id", 

(case when max(g.contraindicacao) isnull then 'N√O POSSUI' else max(g.contraindicacao) end) as "contraindicacao", 

(case when max(g.indicacao) isnull then 'N√O POSSUI' else max(g.indicacao) end) as "indicacao" 

from 

(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id", 

g.marca, max(g.photo_id) as "photo_id",  

(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",  

(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",  

(case when g.contraindicacao = 'N√O POSSUI' then null else g.contraindicacao end) as "contraindicacao", 

(case when g.indicacao = 'N√O POSSUI' then null else g.indicacao end) as "indicacao" 

from 

(select g.* from  

(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') as "marca", p.photo_id, 

p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') and  

(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

and t.id = d.tipo_id) g 

right join  

(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO') f 

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

where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO' 

and p.grupo_id = d.id and pc.ean = p.ean  

group by d.nome, p.id 

) vm 

on vm.nome = g.nome 

group by g.nome, g.ean,g.descricao, g.categoria_id, g.marca, g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao

) g, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd  

where 

 (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id) 

and 

pd.produto_id=g.id and pd.departamento_id = :id_departamento 

) 


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

group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, b.lojapromocao, 

b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio 

order by b.nome asc

------------------------------------------------------
--public static final String PRODUTOS_BY_CRITERIA_AND_DEPARTAMENTO = 

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

from afarma.produto p, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd 

where 

(upper(d.nome) like upper(:busca) or upper(p.nome) like upper(:busca)) 

and 

pd.produto_id=p.id and pd.departamento_id = :id_departamento 

and  (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id) 

and d.tipo_id=t.id and p.descricao!='GENERICO' 

group by  

p.id, p.ean, p.nome, p.descricao) 

union all 

(select g.*, '' from 

(select vm.id ,g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , vm.avg from 

( 

select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 

g.marca, max(g.photo_id) as "photo_id", 

(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome='DEPARTAMENTO' AND t.id=d.tipo_id and d.nome='N√O IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id", 

(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome='PRINCIPIO ATIVO' AND t.id=d.tipo_id and d.nome='N√O IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id", 

(case when max(g.contraindicacao) isnull then 'N√O POSSUI' else max(g.contraindicacao) end) as "contraindicacao", 

(case when max(g.indicacao) isnull then 'N√O POSSUI' else max(g.indicacao) end) as "indicacao" 

from 

(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id", 

g.marca, max(g.photo_id) as "photo_id", 

(case when g.departamento_id=(select d.id from afarma.tipodominio t, afarma.dominio d where t.nome='DEPARTAMENTO' AND t.id=d.tipo_id and d.nome='N√O IDENTIFICADO') then null else g.departamento_id end) as "departamento_id", 

(case when g.principioativo_id=(select d.id from afarma.tipodominio t, afarma.dominio d where t.nome='PRINCIPIO ATIVO' AND t.id=d.tipo_id and d.nome='N√O IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id", 

(case when g.contraindicacao='N√O POSSUI' then null else g.contraindicacao end) as "contraindicacao", 

(case when g.indicacao='N√O POSSUI' then null else g.indicacao end) as "indicacao" 

from 

(select g.* from 

(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome='MARCA' AND t.id=d.tipo_id and d.nome='N√O IDENTIFICADO') as "marca", p.photo_id, 

p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id!=(select d.id from afarma.tipodominio t, afarma.dominio d where t.nome='GRUPO' AND t.id=d.tipo_id and d.nome='N√O IDENTIFICADO') and 

(d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id) 

and t.id=d.tipo_id) g 

right join 

(select d.nome from afarma.dominio d where d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='GRUPO') and d.nome!='N√O IDENTIFICADO') f 

on f.nome=g.nome) g 

group by g.grupo_id, g.nome, g.ean, g.descricao, 

g.marca, g.departamento_id, g.principioativo_id, g.contraindicacao, g.indicacao) g 

where g.nome!='' 

group by 

 g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 

g.marca 

) g 

left join 

( 

select p.id, d.nome, (case when avg(nullif(pc.valor,0)) isnull then 0 else avg(nullif(pc.valor,0)) end) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d 

where d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='GRUPO') and d.nome!='N√O IDENTIFICADO' 

and p.grupo_id=d.id and pc.ean=p.ean 

group by d.nome, p.id 

) vm 

on vm.nome=g.nome 

) g, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd 

where 

(upper(d.nome) like upper(:busca) or upper(g.nome) like upper(:busca)) 

and  (d.id=g.categoria_id or d.id=g.departamento_id or d.id=g.grupo_id  or d.id=g.principioativo_id) 

and 

pd.produto_id=g.id and pd.departamento_id = :id_departamento) 

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

group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, b.lojapromocao, 

b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio 





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

b.departamento_id, b.principioativo_id, b.grupo_id, b.contraindicacao, b.indicacao, b.precomedio, b.lojapromocao from

( 

(select p.* 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd  

where 


 pd.produto_id=p.id and pd.departamento_id = :id_departamento 

and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

and d.tipo_id = t.id and p.descricao !=  'GENERICO' 

group by  

p.id, p.ean, p.nome, p.descricao) 

union all 

(select g.*, '' from 

(select max(vm.id) as "id" ,g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , avg(nullif(vm.avg,0)) from  

( 

select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 

g.marca, max(g.photo_id) as "photo_id",  

(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id", 

(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id", 

(case when max(g.contraindicacao) isnull then 'N√O POSSUI' else max(g.contraindicacao) end) as "contraindicacao", 

(case when max(g.indicacao) isnull then 'N√O POSSUI' else max(g.indicacao) end) as "indicacao" 

from 

(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id", 

g.marca, max(g.photo_id) as "photo_id",  

(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",  

(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",  

(case when g.contraindicacao = 'N√O POSSUI' then null else g.contraindicacao end) as "contraindicacao", 

(case when g.indicacao = 'N√O POSSUI' then null else g.indicacao end) as "indicacao" 

from 

(select g.* from  

(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') as "marca", p.photo_id, 

p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') and  

(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

and t.id = d.tipo_id) g 

right join  

(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO') f 

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

where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO' 

and p.grupo_id = d.id and pc.ean = p.ean  

group by d.nome, p.id 

) vm 

on vm.nome = g.nome 

group by g.nome, g.ean,g.descricao, g.categoria_id, g.marca, g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao

) g, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd  

where 

 (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id) 

and 

pd.produto_id=g.id and pd.departamento_id = :id_departamento 

) 


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

group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, b.lojapromocao, 

b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio 

order by b.nome asc





---------------------



--public static final String PRODUTOS_BY_DEPARTAMENTO_BY_CRITERIA = 

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

b.departamento_id, b.principioativo_id, b.grupo_id, b.contraindicacao, b.indicacao, b.precomedio, b.lojapromocao from

( 

(select p.* 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd  

where 

(translate(upper(d.nome),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') 
like translate(upper(:busca),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') 
or 
translate(upper(p.nome),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') 
like translate(upper(:busca),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) 

and 

 pd.produto_id=p.id and pd.departamento_id = :id_departamento 

and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

and d.tipo_id = t.id and p.descricao !=  'GENERICO' 

group by  

p.id, p.ean, p.nome, p.descricao) 

union all 

(select g.*, '' from 

(select max(vm.id) as "id" ,g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , avg(nullif(vm.avg,0)) from  

( 

select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 

g.marca, max(g.photo_id) as "photo_id",  

(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id", 

(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id", 

(case when max(g.contraindicacao) isnull then 'N√O POSSUI' else max(g.contraindicacao) end) as "contraindicacao", 

(case when max(g.indicacao) isnull then 'N√O POSSUI' else max(g.indicacao) end) as "indicacao" 

from 

(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id", 

g.marca, max(g.photo_id) as "photo_id",  

(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",  

(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",  

(case when g.contraindicacao = 'N√O POSSUI' then null else g.contraindicacao end) as "contraindicacao", 

(case when g.indicacao = 'N√O POSSUI' then null else g.indicacao end) as "indicacao" 

from 

(select g.* from  

(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') as "marca", p.photo_id, 

p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') and  

(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

and t.id = d.tipo_id) g 

right join  

(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO') f 

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

where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO' 

and p.grupo_id = d.id and pc.ean = p.ean  

group by d.nome, p.id 

) vm 

on vm.nome = g.nome 

group by g.nome, g.ean,g.descricao, g.categoria_id, g.marca, g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao

) g, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd  

where 

 (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id) 

and 

(translate(upper(d.nome),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') 
like translate(upper(:busca),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') 
or 
translate(upper(g.nome),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') 
like translate(upper(:busca),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

and 

pd.produto_id=g.id and pd.departamento_id = :id_departamento 

) 


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

group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, b.lojapromocao, 

b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio 

order by b.nome asc


-- BY CRITERIA


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

b.departamento_id, b.principioativo_id, b.grupo_id, b.contraindicacao, b.indicacao, b.precomedio, b.lojapromocao from

( 

(select p.* 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd  

where 

(afarma.replace_special_char(upper(d.nome::varchar)) like afarma.replace_special_char(upper(:busca::varchar))
or 
afarma.replace_special_char(upper(p.nome::varchar)) like afarma.replace_special_char(upper(:busca::varchar)))



and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

and d.tipo_id = t.id and p.descricao !=  'GENERICO' 

group by  

p.id, p.ean, p.nome, p.descricao) 

union all 

(select g.*, '' from 

(select max(vm.id) as "id" ,g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , avg(nullif(vm.avg,0)) from  

( 

select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id, 

g.marca, max(g.photo_id) as "photo_id",  

(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id", 

(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id", 

(case when max(g.contraindicacao) isnull then 'N√O POSSUI' else max(g.contraindicacao) end) as "contraindicacao", 

(case when max(g.indicacao) isnull then 'N√O POSSUI' else max(g.indicacao) end) as "indicacao" 

from 

(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id", 

g.marca, max(g.photo_id) as "photo_id",  

(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",  

(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",  

(case when g.contraindicacao = 'N√O POSSUI' then null else g.contraindicacao end) as "contraindicacao", 

(case when g.indicacao = 'N√O POSSUI' then null else g.indicacao end) as "indicacao" 

from 

(select g.* from  

(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') as "marca", p.photo_id, 

p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio 

from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') and  

(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id) 

and t.id = d.tipo_id) g 

right join  

(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO') f 

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

where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO' 

and p.grupo_id = d.id and pc.ean = p.ean  

group by d.nome, p.id 

) vm 

on vm.nome = g.nome 

group by g.nome, g.ean,g.descricao, g.categoria_id, g.marca, g.photo_id, g.departamento_id, 

g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao

) g, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd  

where 

 (d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id) 

and 

(afarma.replace_special_char(upper(d.nome::varchar)) like afarma.replace_special_char(upper(:busca))
or 
afarma.replace_special_char(upper(g.nome::varchar)) like afarma.replace_special_char(upper(:busca)))

) 


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

group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, b.lojapromocao, 

b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio 

order by b.nome asc



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
b.departamento_id, b.principioativo_id, b.grupo_id, b.contraindicacao, b.indicacao, b.precomedio, b.lojapromocao from
(
(select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd
where
(translate(upper(d.nome),'·‡‚„‰Â¡¬√ƒ≈¿ÈËÍÎ…»ÏÌÓÔÏÃÕŒœÃÛÙıˆÚ“”‘’÷˘˙˚¸Ÿ⁄€‹Á«Ò—˝›',
'aaaaaaAAAAAAeeeeEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnNyY')
like translate(upper(:busca),'·‡‚„‰Â¡¬√ƒ≈¿ÈËÍÎ…»ÏÌÓÔÏÃÕŒœÃÛÙıˆÚ“”‘’÷˘˙˚¸Ÿ⁄€‹Á«Ò—˝›',
'aaaaaaAAAAAAeeeeEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnNyY')
or
translate(upper(p.nome),'·‡‚„‰Â¡¬√ƒ≈¿ÈËÍÎ…»ÏÌÓÔÏÃÕŒœÃÛÙıˆÚ“”‘’÷˘˙˚¸Ÿ⁄€‹Á«Ò—˝›',
'aaaaaaAAAAAAeeeeEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnNyY')
like translate(upper(:busca),'·‡‚„‰Â¡¬√ƒ≈¿ÈËÍÎ…»ÏÌÓÔÏÃÕŒœÃÛÙıˆÚ“”‘’÷˘˙˚¸Ÿ⁄€‹Á«Ò—˝›',
'aaaaaaAAAAAAeeeeEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnNyY'))
and  (d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id)
and d.tipo_id = t.id and p.descricao !=  'GENERICO'
group by
p.id, p.ean, p.nome, p.descricao)
union all
(select g.*, '' from
(select max(vm.id) as "id" ,g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id,
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , avg(nullif(vm.avg,0)) from
(
select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca, max(g.photo_id) as "photo_id",
(case when max(g.departamento_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.departamento_id) end) as "departamento_id",
(case when max(g.principioativo_id) isnull then (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') else max(g.principioativo_id) end) as "principioativo_id",
(case when max(g.contraindicacao) isnull then 'N√O POSSUI' else max(g.contraindicacao) end) as "contraindicacao",
(case when max(g.indicacao) isnull then 'N√O POSSUI' else max(g.indicacao) end) as "indicacao"
from
(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id",
g.marca, max(g.photo_id) as "photo_id",
(case when g.departamento_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'DEPARTAMENTO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.departamento_id end) as "departamento_id",
(case when g.principioativo_id = (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'PRINCIPIO ATIVO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') then null else g.principioativo_id end) as "principioativo_id",
(case when g.contraindicacao = 'N√O POSSUI' then null else g.contraindicacao end) as "contraindicacao",
(case when g.indicacao = 'N√O POSSUI' then null else g.indicacao end) as "indicacao"
from
(select g.* from
(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'MARCA' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') as "marca", p.photo_id,
p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio
from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id !=  (select d.id from afarma.tipodominio t, afarma.dominio d where t.nome = 'GRUPO' AND t.id = d.tipo_id and d.nome = 'N√O IDENTIFICADO') and
(d.id = p.categoria_id or d.id = p.departamento_id or d.id = p.grupo_id or d.id = p.marca_id or d.id = p.principioativo_id)
and t.id = d.tipo_id) g
right join
(select d.nome from afarma.dominio d where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO') f
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
where d.tipo_id = (select t.id from afarma.tipodominio t where t.nome = 'GRUPO') and d.nome !=  'N√O IDENTIFICADO'
and p.grupo_id = d.id and pc.ean = p.ean
group by d.nome, p.id
) vm
on vm.nome = g.nome
group by g.nome, g.ean,g.descricao, g.categoria_id, g.marca, g.photo_id, g.departamento_id,
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao
) g, afarma.dominio d, afarma.tipodominio t, afarma.produto_departamentos pd
where
(d.id = g.categoria_id or d.id = g.departamento_id or d.id = g.grupo_id  or d.id = g.principioativo_id)
and
(translate(upper(d.nome),'·‡‚„‰Â¡¬√ƒ≈¿ÈËÍÎ…»ÏÌÓÔÏÃÕŒœÃÛÙıˆÚ“”‘’÷˘˙˚¸Ÿ⁄€‹Á«Ò—˝›',
'aaaaaaAAAAAAeeeeEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnNyY')
like translate(upper(:busca),'·‡‚„‰Â¡¬√ƒ≈¿ÈËÍÎ…»ÏÌÓÔÏÃÕŒœÃÛÙıˆÚ“”‘’÷˘˙˚¸Ÿ⁄€‹Á«Ò—˝›',
'aaaaaaAAAAAAeeeeEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnNyY'))
or
translate(upper(g.nome),'·‡‚„‰Â¡¬√ƒ≈¿ÈËÍÎ…»ÏÌÓÔÏÃÕŒœÃÛÙıˆÚ“”‘’÷˘˙˚¸Ÿ⁄€‹Á«Ò—˝›',
'aaaaaaAAAAAAeeeeEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnNyY')
like translate(upper(:busca),'·‡‚„‰Â¡¬√ƒ≈¿ÈËÍÎ…»ÏÌÓÔÏÃÕŒœÃÛÙıˆÚ“”‘’÷˘˙˚¸Ÿ⁄€‹Á«Ò—˝›',
'aaaaaaAAAAAAeeeeEEiiiiiIIIIIoooooOOOOOuuuuUUUUcCnNyY'))
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
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo, b.lojapromocao,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio
order by b.nome asc


select p.ean 
	--into generico_ean
	from afarma.produto p, public.product pr
	where p.grupo_id=(select p.grupo_id from afarma.produto p
	where p.ean='7896523227092') and pr.price!=0 
	and pr.ean=p.ean 
	order by pr.price asc
	limit 1
	offset 1;
	return generico_ean;
	
select afarma.menor_preco_grupo('7891058001636');