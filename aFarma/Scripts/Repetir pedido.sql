select u.id, concat(ca.produto1,ca.produto2,ca.produto3,ca.produto4,ca.produto5,ca.produto6,ca.produto7,ca.produto8),
(DATE_PART('day', (now()) - (max(p.datapedido)))) as "ultimopedido", max(p.datapedido),
(DATE_PART('day', (now()) - (max(p.datapedido))))
from  usuario u, pedido p, cesta c, pedido_receita pr, receita r, item_cesta ic, itemprodutocesta ip,
(SELECT * 
FROM crosstab( 'select c.id, 1 as "produto", co.concat
from cesta c, item_cesta ic, itemprodutocesta i, produto p,
			  (select c.id, p.nome, i.quantidade,concat(p.id,i.quantidade)
			  from cesta c, item_cesta ic, itemprodutocesta i, produto p
			  where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id ) co
where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id and co.id=c.id
group by c.id, co.concat order by 1,2 ') 
     AS final_result("cesta" VARCHAR, "produto1" TEXT, "produto2" TEXT,
					 "produto3" TEXT, "produto4" TEXT, "produto5" TEXT,
					 "produto6" TEXT, "produto7" TEXT, "produto8" TEXT)) ca
where u.id = c.cliente_id and c.id = p.cesta_id and c.id = ic.cesta_id 
--and p.status='ENTREGUE'
and ic.item_id = ip.id and pr.pedido_id = p.id and pr.receita_id = r.id
and ca.cesta=c.id
group by u.id, ca.cesta, concat(ca.produto1,ca.produto2,ca.produto3,ca.produto4,ca.produto5,ca.produto6,ca.produto7,ca.produto8)
order by ca.cesta;
