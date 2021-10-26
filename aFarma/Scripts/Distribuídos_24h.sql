

--AFARMA
select p.id as pedido_id, l.id as loja_id, a.id as alerta_id, l.apelido, l.razaosocial, p.datapedido
from afarma.pedido p, afarma.distribuicao_alerta da, afarma.alerta a, afarma.loja l
where p.id=a.pedido_id and a.id=da.alerta_id and da.loja_id=l.id and
extract(day from (now()-p.datapedido)) <=1 and p.status='DISTRIBUIDO'
and l.id=coalesce(:loja_id,l.id)




--POPULAR
select p.id as pedido_id, l.id as loja_id, a.id as alerta_id, l.apelido, l.razaosocial, p.datapedido
from public.pedido p, public.distribuicao_alerta da, public.alerta a, public.loja l
where p.id=a.pedido_id and a.id=da.alerta_id and da.loja_id=l.id and
extract(day from (now()-p.datapedido)) <=1 and p.status='DISTRIBUIDO'
and l.id=coalesce(:loja_id,l.id)



