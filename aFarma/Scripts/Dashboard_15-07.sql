--Total de usuários cadastrados por perído

select count(u.id) from afarma.usuario u
where u.usuarioteste=false and u.ativo= true
and u.perfilid=2
and extract ( day from u.dataaceite) between coalesce(:diainicial,1) and coalesce(:diafinal,31)
and extract ( month from u.dataaceite) between coalesce(:mesinicial,1) and coalesce(:mesfinal,12)
and extract ( year from u.dataaceite) between coalesce(:anoinicial,1) and coalesce(:anofinal,4000)

select count(u.id) from afarma.usuario u
where u.usuarioteste=false and u.ativo= true
and u.perfilid=2
and cast(u.dataaceite as date) between :datainicial and
:datafinal;

--Total de usuários cadastrados acumulado.

select count(u.id) from afarma.usuario u
where u.usuarioteste=false and u.ativo= true
and u.perfilid=2 

--Total de usuários cadastrados por mes

select extract (month from u.dataaceite) as mes, extract ( year from u.dataaceite) as ano,
count(u.id) as usuarios from afarma.usuario u
where u.usuarioteste=false and u.ativo= true
and u.perfilid = 2
group by
extract ( month from u.dataaceite),
extract ( year from u.dataaceite)
order by mes asc, ano asc

--Total de pedidos por período (mes/dia) e por status

select p.datapedido, p.status, sum(p.count) as total from
(
select cast(p.datapedido as date), p.status, count (p.id) 
from afarma.pedido p, afarma.cesta c, afarma.usuario u
where coalesce(p.cesta_alterada_id, p.cesta_id)=c.id
and c.cliente_id=u.id and u.usuarioteste=false
group by p.datapedido, p.status
) p
group by p.datapedido, p.status 
order by p.status asc, p.datapedido asc


-- Pedidos entregues por período/região com informação do cliente e da farmacia


select left(p.id,8), cast(p.datapedido as date), p.status, Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf, u.nome as Cliente, l.apelido as Loja, l.razaosocial, l.cnpj 
from afarma.pedido p, afarma.cesta c, afarma.usuario u, afarma.loja l, afarma.endereco e
where coalesce(p.cesta_alterada_id, p.cesta_id)=c.id and p.loja_id=l.id and p.endereco_id =e.id 
and c.cliente_id=u.id and u.usuarioteste=false 
and p.status='ENTREGUE'
group by p.id, p.status, e.bairro, e.cidade, e.uf, u.nome, l.apelido, l.razaosocial, l.cnpj 
order by p.datapedido asc


-- Pedidos rejeitados por período/região com informação do cliente e da farmacia

select left(p.id,8), cast(p.datapedido as date), p.status, Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf, u.nome as Cliente, l.apelido as Loja, l.razaosocial, l.cnpj 
from afarma.pedido p, afarma.cesta c, afarma.usuario u, afarma.loja l, afarma.endereco e
where coalesce(p.cesta_alterada_id, p.cesta_id)=c.id and p.loja_id=l.id and p.endereco_id =e.id 
and c.cliente_id=u.id and u.usuarioteste=false 
and p.status='REJEITADO'
group by p.id, p.status, e.bairro, e.cidade, e.uf, u.nome, l.apelido, l.razaosocial, l.cnpj 
order by p.datapedido asc


-- Motivo dos pedidos rejeitados

select left(p.id,8), cast(p.datapedido as date), p.status, u.nome as Cliente, l.apelido as Loja , p.motivorejeicao 
from afarma.pedido p, afarma.cesta c, afarma.usuario u, afarma.loja l
where coalesce(p.cesta_alterada_id, p.cesta_id)=c.id and p.loja_id = l.id 
and c.cliente_id=u.id --and u.usuarioteste=false 
and p.status='REJEITADO'
group by p.id, p.status, u.nome,  l.apelido
order by p.datapedido asc

--Ranking de produtos mais pedidos
select  pr.nome, sum(ip.quantidade) as quantidadePedida
from afarma.pedido p, afarma.cesta c, afarma.item_cesta ic, afarma.itemprodutocesta ip, afarma.produto pr
where coalesce(p.cesta_alterada_id,p.cesta_id)=c.id and c.id = ic.cesta_id and ic.item_id = ip.id and ip.produto_id = pr.id 
group by pr.nome
order by quantidadePedida desc

--Ranking de produtos mais vendidos
select  pr.nome, sum(ip.quantidade) as quantidadePedida
from afarma.pedido p, afarma.cesta c, afarma.item_cesta ic, afarma.itemprodutocesta ip, afarma.produto pr
where coalesce(p.cesta_alterada_id,p.cesta_id)=c.id and c.id = ic.cesta_id and ic.item_id = ip.id and ip.produto_id = pr.id 
and p.status='ENTREGUE'
group by pr.nome
order by quantidadePedida desc

-- Ranking de regiões com mais/menos pedidos

select Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf, count (p.id) as pedidos
from afarma.pedido p, afarma.endereco e
where p.endereco_id=e.id 
group by Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf
order by pedidos asc limit 10

select Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf, count (p.id) as pedidos
from afarma.pedido p, afarma.endereco e
where p.endereco_id=e.id 
group by Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf
order by pedidos desc limit 10

-- Valor total vendido por período
 
select p.datapedido, sum(p.sum) from 
(
select cast(p.datapedido as date), sum(p.valortotaldopedido) from afarma.pedido p, afarma.endereco e
where p.endereco_id=e.id 
and extract ( day from p.datapedido) between coalesce(:diainicial, 1) and coalesce(:diafinal,31)
and extract ( month from p.datapedido) between coalesce(:mesinicial,1) and coalesce(:mesfinal,12)
and extract ( year from p.datapedido) between coalesce(:anoinicial, 0) and coalesce(:anofinal,4000)
group by p.datapedido ) p
group by p.datapedido
order by p.datapedido asc

-- Valor total vendido por região


select Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf, sum(p.valortotaldopedido) from afarma.pedido p, afarma.endereco e
where p.endereco_id=e.id 
and extract ( day from p.datapedido) between coalesce(:diainicial, 1) and coalesce(:diafinal,31)
and extract ( month from p.datapedido) between coalesce(:mesinicial,1) and coalesce(:mesfinal,12)
and extract ( year from p.datapedido) between coalesce(:anoinicial, 0) and coalesce(:anofinal,4000)
group by Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf 

-- Valor total repasse por região

select Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf, sum(p.valortotaldopedido) as totalvendido, 0.05 as percentualrepasse,
count(p.id) as qtdepedidos, 0.5 as valorrepasse, ((sum(p.valortotaldopedido)*0.05)+(count(p.id)*0.5)) as totalrepasse
from afarma.pedido p, afarma.endereco e
where p.endereco_id=e.id 
and extract ( day from p.datapedido) between coalesce(:diainicial, 1) and coalesce(:diafinal,31)
and extract ( month from p.datapedido) between coalesce(:mesinicial,1) and coalesce(:mesfinal,12)
and extract ( year from p.datapedido) between coalesce(:anoinicial, 0) and coalesce(:anofinal,4000)
group by Upper(unaccent(e.bairro)), Upper(unaccent (e.cidade)), e.uf 

-- Valor total repasse por período
select p.datapedido, sum(p.totalvendido) as totalvendido, p.percentualrepasse, sum(p.qtdepedidos), p.valorrepasse, sum(p.totalrepasse)
from
(
select cast(p.datapedido as date), sum(p.valortotaldopedido) as totalvendido, 0.05 as percentualrepasse,
count(p.id) as qtdepedidos, 0.5 as valorrepasse, ((sum(p.valortotaldopedido)*0.05)+(count(p.id)*0.5)) as totalrepasse
from afarma.pedido p, afarma.endereco e
where p.endereco_id=e.id 
and extract ( day from p.datapedido) between coalesce(:diainicial, 1) and coalesce(:diafinal,31)
and extract ( month from p.datapedido) between coalesce(:mesinicial,1) and coalesce(:mesfinal,12)
and extract ( year from p.datapedido) between coalesce(:anoinicial, 0) and coalesce(:anofinal,4000)
group by p.datapedido
) p
group by p.datapedido, p.percentualrepasse, p.valorrepasse
order by p.datapedido asc