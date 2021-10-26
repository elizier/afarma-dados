--Busca sem departamento

select b.*, avg(pc.valor) as "precomedio"
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
select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) or upper(p.nome) like upper(:busca))
and  (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and d.tipo_id=t.id 
group by 
p.id, p.ean, p.nome, p.descricao) b
left join afarma.dominio d
on d.id=b.categoria_id) b
left join afarma.dominio d
on d.id=b.marca_id) b
left join afarma.dominio d
on d.id=b.departamento_id) b
left join afarma.dominio d
on d.id=b.principioativo_id) b
left join afarma.dominio d
on d.id=b.grupo_id
) b, afarma.produtocrawler p, afarma.produtoconcorrente pc
where p.ean=b.ean and pc.produto_id=p.id 
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id
;


-- BUSCAS com departamento
select b.*, avg(pc.valor) as "precomedio"
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
select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) or upper(p.nome) like upper(:busca)) and
d.id=:id_departamento--pode comentar
and  (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and d.tipo_id=t.id 
group by 
p.id, p.ean, p.nome, p.descricao) b
left join afarma.dominio d
on d.id=b.categoria_id) b
left join afarma.dominio d
on d.id=b.marca_id) b
left join afarma.dominio d
on d.id=b.departamento_id) b
left join afarma.dominio d
on d.id=b.principioativo_id) b
left join afarma.dominio d
on d.id=b.grupo_id
) b, afarma.produtocrawler p, afarma.produtoconcorrente pc
where p.ean=b.ean and pc.produto_id=p.id 
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id
;

-- Busca só pelo departamento

select b.*, avg(pc.valor) as "precomedio"
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
select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
d.id=:id_departamento--pode comentar
and  (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and d.tipo_id=t.id 
group by 
p.id, p.ean, p.nome, p.descricao) b
left join afarma.dominio d
on d.id=b.categoria_id) b
left join afarma.dominio d
on d.id=b.marca_id) b
left join afarma.dominio d
on d.id=b.departamento_id) b
left join afarma.dominio d
on d.id=b.principioativo_id) b
left join afarma.dominio d
on d.id=b.grupo_id
) b, afarma.produtocrawler p, afarma.produtoconcorrente pc
where p.ean=b.ean and pc.produto_id=p.id 
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id
;

-- Todo produto

select b.*, avg(pc.valor) as "precomedio"
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
select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) or upper(p.nome) like upper(:busca)) and
d.id=:id_departamento--pode comentar
and  (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and d.tipo_id=t.id 
group by 
p.id, p.ean, p.nome, p.descricao) b
left join afarma.dominio d
on d.id=b.categoria_id) b
left join afarma.dominio d
on d.id=b.marca_id) b
left join afarma.dominio d
on d.id=b.departamento_id) b
left join afarma.dominio d
on d.id=b.principioativo_id) b
left join afarma.dominio d
on d.id=b.grupo_id
) b, afarma.produtocrawler p, afarma.produtoconcorrente pc
where p.ean=b.ean and pc.produto_id=p.id 
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, avg(pc.valor)
;

-- Busca só pelo departamento

select b.*
--, avg(pc.valor) as "precomedio"
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
((
select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
d.tipo_id=t.id
and  (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and p.descricao!='GENERICO'
group by 
p.id, p.ean, p.nome, p.descricao)
union all 
(select g.* from
(select cast(uuid_generate_v4() as varchar),g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id,
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , vm.avg from 
(
select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca, max(g.photo_id) as "photo_id", 
(case when max(g.departamento_id) isnull then '6c2114a8-3c86-42a0-8521-7792d7476e0c' else max(g.departamento_id) end) as "departamento_id",
(case when max(g.principioativo_id) isnull then 'b0e56162-2370-45a4-9fd9-04278b89a152' else max(g.principioativo_id) end) as "principioativo_id",
(case when max(g.contraindicacao) isnull then 'NÃO POSSUI' else max(g.contraindicacao) end) as "contraindicacao",
(case when max(g.indicacao) isnull then 'NÃO POSSUI' else max(g.indicacao) end) as "indicacao"
from
(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id",
g.marca, max(g.photo_id) as "photo_id", 
(case when g.departamento_id='6c2114a8-3c86-42a0-8521-7792d7476e0c' then null else g.departamento_id end) as "departamento_id", 
(case when g.principioativo_id='b0e56162-2370-45a4-9fd9-04278b89a152' then null else g.principioativo_id end) as "principioativo_id", 
(case when g.contraindicacao='NÃO POSSUI' then null else g.contraindicacao end) as "contraindicacao",
(case when g.indicacao='NÃO POSSUI' then null else g.indicacao end) as "indicacao"
from
(select g.* from 
(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, '5cf99e52-80e8-4012-9b3b-23f9b6cde239' as "marca", p.photo_id,
p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio
from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id!='12106d91-393e-4d0e-8591-5b51ccc6d1be' and 
(d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and t.id=d.tipo_id) g
right join 
(select d.nome from afarma.dominio d where d.tipo_id='58629662-c75f-493e-ac8b-6f1a59769286' and d.nome!='NÃO IDENTIFICADO') f
on f.nome=g.nome) g
--where g.principioativo_id!='b0e56162-2370-45a4-9fd9-04278b89a152' 
group by g.grupo_id, g.nome, g.ean, g.descricao,
g.marca, g.departamento_id, g.principioativo_id, g.contraindicacao, g.indicacao) g
where g.nome!=''
group by
 g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca
) g
left join
(
select d.nome, avg(nullif(pc.valor,0)) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d
where d.tipo_id='58629662-c75f-493e-ac8b-6f1a59769286' and d.nome!='NÃO IDENTIFICADO'
and p.grupo_id=d.id and pc.ean=p.ean 
group by d.nome
) vm
on vm.nome=g.nome
) g, afarma.dominio d, afarma.tipodominio t 
where
--(upper(d.nome) like upper(:busca) or upper(g.nome) like upper(:busca)) and
(d.id=g.categoria_id or d.id=g.departamento_id or d.id=g.grupo_id  or d.id=g.principioativo_id))) b
left join afarma.dominio d
on d.id=b.categoria_id) b
left join afarma.dominio d
on d.id=b.marca_id) b
left join afarma.dominio d
on d.id=b.departamento_id) b
left join afarma.dominio d
on d.id=b.principioativo_id) b
left join afarma.dominio d
on d.id=b.grupo_id
) b, afarma.produtocrawler p, afarma.produtoconcorrente pc
where p.ean=b.ean and pc.produto_id=p.id 
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio
;



--Busca Produto Generico


--Busca sem departamento

select b.*
--, avg(pc.valor) as "precomedio"
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
and  (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and d.tipo_id=t.id and p.descricao!='GENERICO'
group by 
p.id, p.ean, p.nome, p.descricao)
union all
(select g.* from
(select cast(uuid_generate_v4() as varchar),g.nome, g.ean,g.descricao, g.categoria_id, g.marca as "marca_id", g.photo_id, g.departamento_id,
g.principioativo_id, g.grupo_id, g.contraindicacao, g.indicacao , vm.avg from 
(
select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca, max(g.photo_id) as "photo_id", 
(case when max(g.departamento_id) isnull then '6c2114a8-3c86-42a0-8521-7792d7476e0c' else max(g.departamento_id) end) as "departamento_id",
(case when max(g.principioativo_id) isnull then 'b0e56162-2370-45a4-9fd9-04278b89a152' else max(g.principioativo_id) end) as "principioativo_id",
(case when max(g.contraindicacao) isnull then 'NÃO POSSUI' else max(g.contraindicacao) end) as "contraindicacao",
(case when max(g.indicacao) isnull then 'NÃO POSSUI' else max(g.indicacao) end) as "indicacao"
from
(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id",
g.marca, max(g.photo_id) as "photo_id", 
(case when g.departamento_id='6c2114a8-3c86-42a0-8521-7792d7476e0c' then null else g.departamento_id end) as "departamento_id", 
(case when g.principioativo_id='b0e56162-2370-45a4-9fd9-04278b89a152' then null else g.principioativo_id end) as "principioativo_id", 
(case when g.contraindicacao='NÃO POSSUI' then null else g.contraindicacao end) as "contraindicacao",
(case when g.indicacao='NÃO POSSUI' then null else g.indicacao end) as "indicacao"
from
(select g.* from 
(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, '5cf99e52-80e8-4012-9b3b-23f9b6cde239' as "marca", p.photo_id,
p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio
from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id!='12106d91-393e-4d0e-8591-5b51ccc6d1be' and 
(d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and t.id=d.tipo_id) g
right join 
(select d.nome from afarma.dominio d where d.tipo_id='58629662-c75f-493e-ac8b-6f1a59769286' and d.nome!='NÃO IDENTIFICADO') f
on f.nome=g.nome) g
--where g.principioativo_id!='b0e56162-2370-45a4-9fd9-04278b89a152' 
group by g.grupo_id, g.nome, g.ean, g.descricao,
g.marca, g.departamento_id, g.principioativo_id, g.contraindicacao, g.indicacao) g
where g.nome!=''
group by
 g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca
) g
left join
(
select d.nome, avg(nullif(pc.valor,0)) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d
where d.tipo_id='58629662-c75f-493e-ac8b-6f1a59769286' and d.nome!='NÃO IDENTIFICADO'
and p.grupo_id=d.id and pc.ean=p.ean 
group by d.nome
) vm
on vm.nome=g.nome
) g, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) or upper(g.nome) like upper(:busca))
and  (d.id=g.categoria_id or d.id=g.departamento_id or d.id=g.grupo_id  or d.id=g.principioativo_id))
) b
left join afarma.dominio d
on d.id=b.categoria_id) b
left join afarma.dominio d
on d.id=b.marca_id) b
left join afarma.dominio d
on d.id=b.departamento_id) b
left join afarma.dominio d
on d.id=b.principioativo_id) b
left join afarma.dominio d
on d.id=b.grupo_id
) b
--, afarma.produtocrawler p, afarma.produtoconcorrente pc where (p.ean=b.ean or b.ean='DIVERSOS') and pc.produto_id=p.id 
group by b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo,
b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, b.indicacao, b.contraindicacao, b.photo_id, b.precomedio
;



select * from afarma.produto p where p.grupo_id ='12106d91-393e-4d0e-8591-5b51ccc6d1be';



select g.*, vm.avg from 
(
select g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca, max(g.photo_id) as "photo_id", 
(case when max(g.departamento_id) isnull then '6c2114a8-3c86-42a0-8521-7792d7476e0c' else max(g.departamento_id) end) as "departamento_id",
(case when max(g.principioativo_id) isnull then 'b0e56162-2370-45a4-9fd9-04278b89a152' else max(g.principioativo_id) end) as "principioativo_id",
(case when max(g.contraindicacao) isnull then 'NÃO POSSUI' else max(g.contraindicacao) end) as "contraindicacao",
(case when max(g.indicacao) isnull then 'NÃO POSSUI' else max(g.indicacao) end) as "indicacao"
from
(select g.grupo_id, g.nome, g.ean, g.descricao, max(g.categoria_id) as "categoria_id",
g.marca, max(g.photo_id) as "photo_id", 
(case when g.departamento_id='6c2114a8-3c86-42a0-8521-7792d7476e0c' then null else g.departamento_id end) as "departamento_id", 
(case when g.principioativo_id='b0e56162-2370-45a4-9fd9-04278b89a152' then null else g.principioativo_id end) as "principioativo_id", 
(case when g.contraindicacao='NÃO POSSUI' then null else g.contraindicacao end) as "contraindicacao",
(case when g.indicacao='NÃO POSSUI' then null else g.indicacao end) as "indicacao"
from
(select g.* from 
(select p.id, d.nome, 'DIVERSOS' as "ean", p.descricao, p.categoria_id, 'DIVERSOS' as "marca", p.photo_id,
p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao , p.indicacao, p.precomedio
from afarma.produto p, afarma.dominio d, afarma.tipodominio t where p.grupo_id!='12106d91-393e-4d0e-8591-5b51ccc6d1be' and 
(d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and t.id=d.tipo_id) g
right join 
(select d.nome from afarma.dominio d where d.tipo_id='58629662-c75f-493e-ac8b-6f1a59769286' and d.nome!='NÃO IDENTIFICADO') f
on f.nome=g.nome) g
--where g.principioativo_id!='b0e56162-2370-45a4-9fd9-04278b89a152' 
group by g.grupo_id, g.nome, g.ean, g.descricao,
g.marca, g.departamento_id, g.principioativo_id, g.contraindicacao, g.indicacao) g
where g.nome!=''
group by
 g.grupo_id, g.nome, g.ean, g.descricao, g.categoria_id,
g.marca
) g
left join
(
select d.nome, avg(nullif(pc.valor,0)) from afarma.produto p, afarma.produtoconcorrente pc, afarma.dominio d
where d.tipo_id='58629662-c75f-493e-ac8b-6f1a59769286' and d.nome!='NÃO IDENTIFICADO'
and p.grupo_id=d.id and pc.ean=p.ean 
group by d.nome
) vm
on vm.nome=g.nome;





select count(distinct(g.nome)) from

select d.nome , count(p.id) from afarma.dominio d, afarma.produto p where p.descricao='GENERICO' and p.grupo_id=d.id
group by d.nome


select COUNT(*) from public.product p where p.implementation='PACHECHO'



select id, 'levenshtein' as coluna, (6+LEVENSHTEIN(upper(descricao), upper(:descricao))) as ordem, descricao as descricao
from advance.produtoharmonizado 
where LEVENSHTEIN(upper(descricao), upper(:descricao)) < 3
union all 
select id, 'similaridade1' as coluna, (9 + (SIMILARITY(upper(descricao),upper(:descricao))*-1)) as ordem, descricao as descricao
from advance.produtoharmonizado 
where SIMILARITY(upper(descricao),upper(:descricao)) > 0.5
union all 
select id, 'similaridade2' as coluna, (10 + (SIMILARITY(upper(descricao),upper(:descricao))*-1)) as ordem, descricao as descricao
from advance.produtoharmonizado 
where upper(:descricao) % ANY(STRING_TO_ARRAY(upper(descricao),' '));



select p.id, 'levenshtein' as coluna, (6+LEVENSHTEIN(upper(p.nome), upper(:descricao))) as ordem, p.nome as descricao
from afarma.produto p
where LEVENSHTEIN(upper(p.nome), upper(:descricao)) < 3
union all 
select p.id, 'similaridade1' as coluna, (9 + (SIMILARITY(upper(p.nome),upper(:descricao))*-1)) as ordem, p.nome as descricao
from afarma.produto p
where SIMILARITY(upper(p.nome),upper(:descricao)) > 0.5
union all 
select p.id, 'similaridade2' as coluna, (10 + (SIMILARITY(upper(p.nome),upper(:descricao))*-1)) as ordem, p.nome as descricao
from afarma.produto p
where upper(:descricao) % ANY(STRING_TO_ARRAY(upper(p.nome),' ')) ;



select
  show_trgm('postgras') as tri1, -- {"  p"," po","as ",gra,ost,pos,ras,stg,tgr}
  show_trgm('postgres') as tri2, -- {"  p"," po","es ",gre,ost,pos,res,stg,tgr}
  similarity('postgras','postgres'), -- 0.5
  'postgras' % 'postgres' -- TRUE

  CREATE EXTENSION pg_trgm;
 
 select 'loja_id' as "tipo" , l.id from afarma.loja l where upper(l.nomefantasia) like upper('%moderna%')
 union all
  select 'vendedor_id', cast(uuid_generate_v4() as varchar)
 union all
  select 'entregador_id', cast(uuid_generate_v4() as varchar);
 
 
 INSERT INTO afarma.endereco
(id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf)
VALUES('2d5f2d8d-d71b-47e0-be90-5b11efc78168', 'Centro', '24020082', 'Niterói', 'Lojas 102 a 105', 'Drogaria Moderna da Rua da Conceição, esquina com Maestro Felício Toledo', 'ChIJLSxdgsODmQARrcMXD1qaiBM', -22.89000000, -43.12000000, 'DA CONCEIÇÃO', '95', 'RUA', 'RJ');

INSERT INTO afarma.farmaceutico
(id, documentoidentidade, nome)
VALUES('3864977b-85e8-4403-b307-f2d4f3d884b1', 'Documento de Identidade não informado', 'Farmacêutico Padrão 1');

INSERT INTO afarma.rede
(id, email, nome)
VALUES('57f04b9d-e74c-4b38-b407-b26cc880b1fb', 'moderna@afarma.com.br', 'Moderna');


 INSERT INTO afarma.loja
(id, active, apelido, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id, tipoafarma)
VALUES('b1a9010b-e6e4-43dd-9d01-8d0e6d2ee8c6', true, 'MODERNA', '04.779.685/0002-58', '77.285.431', '3026306', 'DROGARIA MODERNA', 5, 'Drogaria Moderna', 'FRANQUIA', '2d5f2d8d-d71b-47e0-be90-5b11efc78168', '3864977b-85e8-4403-b307-f2d4f3d884b1', '57f04b9d-e74c-4b38-b407-b26cc880b1fb', 'AFARMA_AFARMAPOPULAR');


delete from afarma.usuario where id_popular notnull;


