


select l.id, l.razaosocial as "Razãoo Social",  
l.nomefantasia as "NomeFantasia", l.cnpj, l.apelido , sum(i.quantidade*ip.valorunitario) as "Valor", pr.percentual, (((sum(i.quantidade*ip.valorunitario))*(pr.percentual))/100) as "Repasse %Venda",
count(distinct(p.id)) as "Quantidade de pedidos", '0.5' as "Repasse por pedido", (count(distinct(p.id))*0.5) as "Repasse Pedido", ((count(p.id)*0.5)+(((sum(i.quantidade*ip.valorunitario))*(pr.percentual))/100)) as "Repasse Total"
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l, loja_percentual lp, percentualrepasse pr
where c.id=(coalesce(p.cesta_alterada_id,p.cesta_id))
and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id and l.id=lp.loja_id and lp.percentual_id =pr.id 
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id and
p.status='ENTREGUE' and pr.status =true and
u.usuarioteste!=true and
EXTRACT(MONTH FROM p.datapedido)= :mes
and replace(replace(replace(l.cnpj,'.',''),'/',''),'-','') = coalesce(replace(replace(replace(:cnpj,'.',''),'/',''),'-',''), replace(replace(replace(l.cnpj,'.',''),'/',''),'-',''))
group by l.id, l.razaosocial, l.nomefantasia, l.cnpj, pr.percentual, l.apelido 
order by l.razaosocial asc;




--Extrato

select left(p.id, 8) as "pedido", p.datapedido , l.razaosocial, l.apelido, l.cnpj, u.nome, u.telefone, p.valortotaldopedido as "valor"
from loja l, usuario u, cesta c, pedido p
where l.id=p.loja_id and c.id=p.cesta_id and c.cliente_id=u.id 
--and p.status='ENTREGUE'
order by p.datapedido asc

--REJEITADO
select left(p.id, 8) as "pedido", p.datapedido , l.razaosocial, l.apelido, u.nome, u.telefone, p.motivorejeicao 
from loja l, usuario u, cesta c, pedido p
where l.id=p.loja_id and c.id=p.cesta_id and c.cliente_id=u.id 
and p.status='REJEITADO'
order by p.datapedido asc

--DISTRIBUIDO

select left(p.id, 8) as "pedido", p.datapedido , l.razaosocial, l.apelido, u.nome, u.telefone
from loja l, usuario u, cesta c, pedido p, alerta a, distribuicao_alerta da 
where  c.id=p.cesta_id and c.cliente_id=u.id and p.id=a.pedido_id and a.id = da.alerta_id and da.loja_id=l.id 
and p.status!='REJEITADO' and p.status!='ENTREGUE'
order by p.datapedido asc

--
--ENTREGUE
select left(p.id, 8) as "pedido", p.datapedido , l.razaosocial, l.apelido, u.nome, u.telefone, p.motivorejeicao 
from loja l, usuario u, cesta c, pedido p
where l.id=p.loja_id and c.id=p.cesta_id and c.cliente_id=u.id 
and p.status='ENTREGUE'
order by p.datapedido asc

--QUANTIDADE USUARIOS
select cast(extract(month from u.dataaceite) as int) as "mes", 
cast(extract(year from u.dataaceite) as int) as "ano", count(u.id) as "usuarios" 
from usuario u 
where u.id_popular isnull
group by extract(month from u.dataaceite), extract(year from u.dataaceite)
order by mes, ano

