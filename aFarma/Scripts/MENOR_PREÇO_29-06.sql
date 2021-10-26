------------Cálculo substituindo o item que a loja não possui pelo valor médio



(select 
mp.concorrente, 
mp.nome_1, mp.ean_1, mp.quantidade_1, (case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end) as "valor_1", 
mp.nome_2, mp.ean_2, mp.quantidade_2, (case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end) as "valor_2", 
mp.nome_3, mp.ean_3, mp.quantidade_3, (case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end) as "valor_3", 
(((case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end)*:quantidade1)+
((case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end)*:quantidade2)+
((case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end)*:quantidade3)) as "total"
from
(
select mp.*, p.precomedio as "precomedio_3" from 
(
select mp.*, p.precomedio as "precomedio_2" from 
(
select mp.*, p.precomedio as "precomedio_1" from 
(select 
d.concorrente,
(select p.nome from afarma.produto p where p.ean = :ean1) as "nome_1", :ean1 as "ean_1", :quantidade1 as "quantidade_1",
(case when a.valor_1 isnull then 0 else a.valor_1 end),
(select p.nome from afarma.produto p where p.ean = :ean2) as "nome_2", :ean2 as "ean_2", :quantidade2 as "quantidade_2",
(case when b.valor_2 isnull then 0 else b.valor_2 end),
(select p.nome from afarma.produto p where p.ean = :ean3) as "nome_3", :ean3 as "ean_3", :quantidade3 as "quantidade_3",
(case when c.valor_3 isnull then 0 else c.valor_3 end)
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1",
round(cast((:quantidade1*a.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean = (case when 
(select p.grupo_id from afarma.produto p where p.ean = :ean1) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a  ) a
on a.loja = c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2",
round(cast((:quantidade2*b.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean2) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) b  ) b
on b.loja = c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3",
round(cast((:quantidade3*d.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean3) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) d  ) d
on d.loja = c.concorrente) c
where a.concorrente = d.concorrente and b.concorrente = d.concorrente and c.concorrente = d.concorrente ) mp
left join afarma.produto p 
on p.ean = mp.ean_1) mp
left join afarma.produto p 
on p.ean = mp.ean_2) mp
left join afarma.produto p
on p.ean = mp.ean_3) mp )

union all 

(select 
'aFarma', 
max(mp.nome_1) as "nome_1",
(case when (select p.grupo_id from afarma.produto p where p.ean = :ean1) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end) as "ean_1",
:quantidade1 as "quantidade_1", mp.precomedio_1,
max(mp.nome_2) as "nome_2",
(case when (select p.grupo_id from afarma.produto p where p.ean = :ean2) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end) as "ean_2",
:quantidade2 as "quantidade_2", mp.precomedio_2,
max(mp.nome_3) as "nome_3",
(case when (select p.grupo_id from afarma.produto p where p.ean = :ean3) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end) as "ean_3",
:quantidade3 as "quantidade_3", mp.precomedio_3,
((min(mp.total) - coalesce(:desconto,0))*(1-(coalesce(cast(:percentual as double precision),0))/100))
from 
(select 
mp.concorrente, 
mp.nome_1, mp.ean_1, mp.quantidade_1, (case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end) as "valor_1", mp.precomedio_1,
mp.nome_2, mp.ean_2, mp.quantidade_2, (case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end) as "valor_2", mp.precomedio_2,
mp.nome_3, mp.ean_3, mp.quantidade_3, (case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end) as "valor_3", mp.precomedio_3,
(((case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end)*:quantidade1)+
((case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end)*:quantidade2)+
((case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end)*:quantidade3)) as "total"
from
(
select mp.*, p.precomedio as "precomedio_3" from 
(
select mp.*, p.precomedio as "precomedio_2" from 
(
select mp.*, p.precomedio as "precomedio_1" from 
(select 
d.concorrente,
(select p.nome from afarma.produto p where p.ean = :ean1) as "nome_1", :ean1 as "ean_1", :quantidade1 as "quantidade_1",
(case when a.valor_1 isnull then 0 else a.valor_1 end),
(select p.nome from afarma.produto p where p.ean = :ean2) as "nome_2", :ean2 as "ean_2", :quantidade2 as "quantidade_2",
(case when b.valor_2 isnull then 0 else b.valor_2 end),
(select p.nome from afarma.produto p where p.ean = :ean3) as "nome_3", :ean3 as "ean_3", :quantidade3 as "quantidade_3",
(case when c.valor_3 isnull then 0 else c.valor_3 end)
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1",
round(cast((:quantidade1*a.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean = (case when 
(select p.grupo_id from afarma.produto p where p.ean = :ean1) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a  ) a
on a.loja = c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2",
round(cast((:quantidade2*b.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean2) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) b  ) b
on b.loja = c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3",
round(cast((:quantidade3*d.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean3) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) d  ) d
on d.loja = c.concorrente) c
where a.concorrente = d.concorrente and b.concorrente = d.concorrente and c.concorrente = d.concorrente ) mp
left join afarma.produto p 
on p.ean = mp.ean_1) mp
left join afarma.produto p 
on p.ean = mp.ean_2) mp
left join afarma.produto p
on p.ean = mp.ean_3) mp ) mp
group by 
mp.precomedio_1, mp.precomedio_2, mp.precomedio_3)


------------Cálculo pegando o menor valor item a item e subtraindo R$1 no fim (sem total calculado com valor médio)


select 
mp.concorrente, 
mp.nome_1, mp.ean_1, mp.quantidade_1, (case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end) as "valor_1",
mp.nome_2, mp.ean_2, mp.quantidade_2, (case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end) as "valor_2",
mp.nome_3, mp.ean_3, mp.quantidade_3, (case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end) as "valor_3",
mp.total
from
(
select mp.*, p.precomedio as "precomedio_3" from 
(
select mp.*, p.precomedio as "precomedio_2" from 
(
select mp.*, p.precomedio as "precomedio_1" from 
(
(select 
d.concorrente,
(select p.nome from afarma.produto p where p.ean = :ean1) as "nome_1", :ean1 as "ean_1", :quantidade1 as "quantidade_1",
(case when a.valor_1 isnull then 0 else a.valor_1 end),
(select p.nome from afarma.produto p where p.ean = :ean2) as "nome_2", :ean2 as "ean_2", :quantidade2 as "quantidade_2",
(case when b.valor_2 isnull then 0 else b.valor_2 end),
(select p.nome from afarma.produto p where p.ean = :ean3) as "nome_3", :ean3 as "ean_3", :quantidade3 as "quantidade_3",
(case when c.valor_3 isnull then 0 else c.valor_3 end),
round((:quantidade1*coalesce(a.valor_1,0)+:quantidade2*coalesce(b.valor_2,0)+:quantidade3*coalesce(c.valor_3,0))::numeric,2) as "total"
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1",
round((:quantidade1*a.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean = (case when 
(select p.grupo_id from afarma.produto p where p.ean = :ean1) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a  ) a
on a.loja = c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2",
round((:quantidade2*b.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean2) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) b  ) b
on b.loja = c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3",
round((:quantidade3*d.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean3) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) d  ) d
on d.loja = c.concorrente) c
where a.concorrente = d.concorrente and b.concorrente = d.concorrente and c.concorrente = d.concorrente )

union all 

(select 
'aFarma', 
'-', :ean1 as "ean_1",:quantidade1 as "quantidade_1", '0',
'-', :ean2 as "ean_2",:quantidade2 as "quantidade_2", '0',
'-', :ean3 as "ean_3",:quantidade3 as "quantidade_3", '0',
round(
(((min((mp.valor_1)*:quantidade1)+min((mp.valor_2)*:quantidade2)+min((mp.valor_3)*:quantidade3))-coalesce(:desconto,0))*(1-(coalesce(:percentual::double precision,0))/100))
::numeric,2)
from 
(
select 
d.concorrente,
a.nome_1, a.ean_1, a.quantidade_1, (case when a.valor_1 = 0 then null else a.valor_1 end),
b.nome_2, b.ean_2, b.quantidade_2, (case when b.valor_2 = 0 then null else b.valor_2 end),
c.nome_3, c.ean_3, c.quantidade_3, (case when c.valor_3 = 0 then null else c.valor_3 end)
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1",
round((:quantidade1*a.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean1) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a  ) a
on a.loja = c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2",
round((:quantidade2*b.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean2) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) b  ) b
on b.loja = c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3",
round((:quantidade3*d.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean3) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) d  ) d
on d.loja = c.concorrente) c
where a.concorrente = d.concorrente and b.concorrente = d.concorrente and c.concorrente = d.concorrente 
) mp)
) mp
left join afarma.produto p 
on p.ean = mp.ean_1) mp
left join afarma.produto p 
on p.ean = mp.ean_2) mp
left join afarma.produto p 
on p.ean = mp.ean_3) mp




------------Cálculo pegando o menor valor item a item e subtraindo R$1 no fim (com total calculado com valor médio)



(select 
mp.concorrente, 
mp.nome_1, mp.ean_1, mp.quantidade_1, (case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end) as "valor_1", 
mp.nome_2, mp.ean_2, mp.quantidade_2, (case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end) as "valor_2", 
mp.nome_3, mp.ean_3, mp.quantidade_3, (case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end) as "valor_3", 
(((case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end)*:quantidade1)+
((case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end)*:quantidade2)+
((case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end)*:quantidade3)) as "total"
from
(
select mp.*, p.precomedio as "precomedio_3" from 
(
select mp.*, p.precomedio as "precomedio_2" from 
(
select mp.*, p.precomedio as "precomedio_1" from 
(select 
d.concorrente,
(select p.nome from afarma.produto p where p.ean = :ean1) as "nome_1", :ean1 as "ean_1", :quantidade1 as "quantidade_1",
(case when a.valor_1 isnull then 0 else a.valor_1 end),
(select p.nome from afarma.produto p where p.ean = :ean2) as "nome_2", :ean2 as "ean_2", :quantidade2 as "quantidade_2",
(case when b.valor_2 isnull then 0 else b.valor_2 end),
(select p.nome from afarma.produto p where p.ean = :ean3) as "nome_3", :ean3 as "ean_3", :quantidade3 as "quantidade_3",
(case when c.valor_3 isnull then 0 else c.valor_3 end)
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1",
round(cast((:quantidade1*a.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean = (case when 
(select p.grupo_id from afarma.produto p where p.ean = :ean1) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a  ) a
on a.loja = c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2",
round(cast((:quantidade2*b.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean2) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) b  ) b
on b.loja = c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3",
round(cast((:quantidade3*d.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean3) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) d  ) d
on d.loja = c.concorrente) c
where a.concorrente = d.concorrente and b.concorrente = d.concorrente and c.concorrente = d.concorrente ) mp
left join afarma.produto p 
on p.ean = mp.ean_1) mp
left join afarma.produto p 
on p.ean = mp.ean_2) mp
left join afarma.produto p
on p.ean = mp.ean_3) mp )

union all 

(select 
'aFarma', 
max(mp.nome_1) as "nome_1",
(case when (select p.grupo_id from afarma.produto p where p.ean = :ean1) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end) as "ean_1",
:quantidade1 as "quantidade_1", mp.precomedio_1,
max(mp.nome_2) as "nome_2",
(case when (select p.grupo_id from afarma.produto p where p.ean = :ean2) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end) as "ean_2",
:quantidade2 as "quantidade_2", mp.precomedio_2,
max(mp.nome_3) as "nome_3",
(case when (select p.grupo_id from afarma.produto p where p.ean = :ean3) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean3)) end) as "ean_3",
:quantidade3 as "quantidade_3", mp.precomedio_3,
(((((min(mp.valor_1))*:quantidade1)+
((min(mp.valor_2))*:quantidade2)+
((min(mp.valor_3))*:quantidade3)) - coalesce(:desconto,0))*(1-(coalesce(cast(:percentual as double precision),0))/100))
from 
(select 
mp.concorrente, 
mp.nome_1, mp.ean_1, mp.quantidade_1, (case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end) as "valor_1", mp.precomedio_1,
mp.nome_2, mp.ean_2, mp.quantidade_2, (case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end) as "valor_2", mp.precomedio_2,
mp.nome_3, mp.ean_3, mp.quantidade_3, (case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end) as "valor_3", mp.precomedio_3,
(
((case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end)*:quantidade1)+
((case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end)*:quantidade2)+
((case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end)*:quantidade3)
) as "total"
from
(
select mp.*, p.precomedio as "precomedio_3" from 
(
select mp.*, p.precomedio as "precomedio_2" from 
(
select mp.*, p.precomedio as "precomedio_1" from 
(select 
d.concorrente,
(select p.nome from afarma.produto p where p.ean = :ean1) as "nome_1", :ean1 as "ean_1", :quantidade1 as "quantidade_1",
(case when a.valor_1 isnull then 0 else a.valor_1 end),
(select p.nome from afarma.produto p where p.ean = :ean2) as "nome_2", :ean2 as "ean_2", :quantidade2 as "quantidade_2",
(case when b.valor_2 isnull then 0 else b.valor_2 end),
(select p.nome from afarma.produto p where p.ean = :ean3) as "nome_3", :ean3 as "ean_3", :quantidade3 as "quantidade_3",
(case when c.valor_3 isnull then 0 else c.valor_3 end)
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1",
round(cast((:quantidade1*a.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean = (case when 
(select p.grupo_id from afarma.produto p where p.ean = :ean1) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a  ) a
on a.loja = c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2",
round(cast((:quantidade2*b.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean2) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) b  ) b
on b.loja = c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3",
round(cast((:quantidade3*d.valor) as numeric),2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id = pc.concorrente_id and pc.ean = p.ean and
p.ean = (case when (select p.grupo_id from afarma.produto p where p.ean = :ean3) = (select d.id 
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end)
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) d  ) d
on d.loja = c.concorrente) c
where a.concorrente = d.concorrente and b.concorrente = d.concorrente and c.concorrente = d.concorrente ) mp
left join afarma.produto p 
on p.ean = mp.ean_1) mp
left join afarma.produto p 
on p.ean = mp.ean_2) mp
left join afarma.produto p
on p.ean = mp.ean_3) mp ) mp
group by 
mp.precomedio_1, mp.precomedio_2, mp.precomedio_3)
