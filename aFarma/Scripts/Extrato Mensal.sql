-- Resumo mensal

select l.id, l.razaosocial as "Raz„oo Social",  
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


--*Detalhado di√°rio

select  LEFT(p.id,8) as "pedido", p.datapedido as "Data do Pedido", EXTRACT(MONTH FROM p.datapedido) as "mes", EXTRACT(year FROM p.datapedido) as "ano",
l.razaosocial as "Raz„o Social", l.apelido, l.cnpj, u.nome as "Cliente", u.telefone as "Telefone do Cliente", concat(i.quantidade,' un de ',r.nome) as "Produtos",
(i.quantidade*ip.valorunitario) as "Valor", pr.percentual, ((i.quantidade*ip.valorunitario*pr.percentual)/100) as "Repasse"
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l, loja_percentual lp, percentualrepasse pr
where c.id=(coalesce(p.cesta_alterada_id,p.cesta_id))
and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id and l.id=lp.loja_id and lp.percentual_id =pr.id 
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.usuarioteste!=true
and p.status='ENTREGUE'
and EXTRACT(MONTH FROM p.datapedido)= :mes
and replace(replace(replace(l.cnpj,'.',''),'/',''),'-','') = coalesce(replace(replace(replace(:cnpj,'.',''),'/',''),'-',''), replace(replace(replace(l.cnpj,'.',''),'/',''),'-','')) -- coment·vel 
group by LEFT(p.id,8), p.datapedido, u.nome,l.razaosocial, l.nomefantasia, p.status,
l.cnpj, (i.quantidade*ip.valorunitario), pr.percentual, ((i.quantidade*ip.valorunitario*pr.percentual)/100), i.quantidade,r.nome ,
p.horaentrega, p.dataentrega, l.apelido , u.telefone 
order by l.cnpj asc;


SELECT * 
FROM crosstab( 'select LEFT(p.id,8), subject, evaluation_result from evaluations where extract (month from evaluation_day) = 7 order by 1,2') 
     AS final_result(Student TEXT, Geography NUMERIC,History NUMERIC,Language NUMERIC,Maths NUMERIC,Music NUMERIC);
--Di·rio

select left(p.id,8) as "Pedido", p.datapedido as "Data", u.nome as "Cliente", u.telefone, l.apelido, l.razaosocial, p.status,
r.dataemissaoreceita as "Data da Receita"
from loja l, cesta c, usuario u, pedido p, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip
where coalesce(p.cesta_alterada_id, p.cesta_id)=c.id and c.cliente_id=u.id 
and pr.pedido_id=p.id and pr.receita_id=r.id  and l.id=p.loja_id and
--u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
--and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
--and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
--and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
--and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
--and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
--and 
u.usuarioteste =false and
p.status='ENTREGUE'
and EXTRACT(MONTH FROM p.datapedido)=5;

select p.id as "Pedido", p.datapedido as "Data", u.nome as "Cliente", u.telefone, l.apelido, l.razaosocial, p.status from loja l, cesta c, usuario u, pedido p 
where coalesce(p.cesta_alterada_id, p.cesta_id)=c.id and c.cliente_id=u.id and l.id=p.loja_id
and p.status='ENTREGUE' and u.usuarioteste=false
and EXTRACT(MONTH FROM p.datapedido)=4

select (10::double precision/100)
