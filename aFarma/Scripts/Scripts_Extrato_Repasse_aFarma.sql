--**Apuração Mensal por Loja pelo venda**--
(SELECT l.razaosocial as "Loja", l.cnpj as "CNPJ", EXTRACT(MONTH FROM v.datavenda) as "Mês", EXTRACT(YEAR FROM v.datavenda) as "Ano", count(v.id) as "Número de vendas",
Sum(v.total) as "Valor Total Vendido", r.percentual as "Percentual de Repasse",  ((r.percentual/100)*sum(v.total)) as "Repasse aFarma"
FROM loja l, venda v, loja_percentual p, percentualrepasse r
where v.loja_id = l.id and v.loja_id != '' and l.id != '' and l.id = p.loja_id and p.percentual_id = r.id
GROUP BY l.razaosocial, l.cnpj, (EXTRACT(MONTH FROM v.datavenda)), (EXTRACT(YEAR FROM v.datavenda)), r.percentual 
ORDER BY (EXTRACT(MONTH FROM v.datavenda)) asc, (EXTRACT(YEAR FROM v.datavenda)) asc, sum(v.total) asc)

union all 

(select 'Total','-',EXTRACT(MONTH from now()), EXTRACT(YEAR FROM now()), count(v.id),sum(v.total),(100*(select sum(t.repasse) from (SELECT l.razaosocial as "Nome da Loja", l.cnpj as "CNPJ", (CAST(v.datavenda AS DATE)) as "Data da Venda", sum(v.total) , r.percentual as "Percentual de Repasse",  ((r.percentual/100)*sum(v.total)) as "repasse"
FROM venda v, loja l, loja_percentual p, percentualrepasse r
where v.loja_id = l.id and l.id = p.loja_id and p.percentual_id = r.id 
and  l.id != ''
group by l.razaosocial,l.cnpj, CAST(v.datavenda AS DATE), v.total, r.percentual ) t)/(sum(v.total))) , (select sum(t.repasse) from (SELECT l.razaosocial as "Nome da Loja", l.cnpj as "CNPJ", (CAST(v.datavenda AS DATE)) as "Data da Venda", sum(v.total) , r.percentual as "Percentual de Repasse",  ((r.percentual/100)*sum(v.total)) as "repasse"
FROM venda v, loja l, loja_percentual p, percentualrepasse r
where v.loja_id = l.id and l.id = p.loja_id and p.percentual_id = r.id 
and  l.id != ''
group by l.razaosocial,l.cnpj, CAST(v.datavenda AS DATE), v.total, r.percentual ) t) from  venda v);

select u.nome, p.id, p.datapedido,p.observacao , l.razaosocial from pedido p, loja l, cesta c, usuario u
where p.loja_id= l.id AND p.status ='ENTREGUE' and c.cliente_id =u.id and (p.cesta_id = c.id or p.cesta_alterada_id =c.id )
and u.nome not like 'Luís Fernando%'
group by u.nome, p.id, p.datapedido,p.observacao , l.razaosocial
order by P.datapedido  DESC;


(SELECT l.razaosocial as "Nome da Loja", l.cnpj as "CNPJ", (CAST(v.datavenda AS DATE)) as "Data da Venda", sum(v.total) , r.percentual as "Percentual de Repasse",  ((r.percentual/100)*sum(v.total)) as "Repasse"
FROM venda v, loja l, loja_percentual p, percentualrepasse r
where v.loja_id = l.id and l.id = p.loja_id and p.percentual_id = r.id 
and  l.id != ''
group by l.razaosocial,l.cnpj, CAST(v.datavenda AS DATE), v.total, r.percentual 
order by l.razaosocial,l.cnpj, CAST(v.datavenda AS DATE), v.total asc)

union all 

(select 'Total','-',now(), sum(v.total),(100*(select sum(t.repasse) from (SELECT l.razaosocial as "Nome da Loja", l.cnpj as "CNPJ", (CAST(v.datavenda AS DATE)) as "Data da Venda", sum(v.total) , r.percentual as "Percentual de Repasse",  ((r.percentual/100)*sum(v.total)) as "repasse"
FROM venda v, loja l, loja_percentual p, percentualrepasse r
where v.loja_id = l.id and l.id = p.loja_id and p.percentual_id = r.id 
and  l.id != ''
group by l.razaosocial,l.cnpj, CAST(v.datavenda AS DATE), v.total, r.percentual ) t)/(sum(v.total))) , (select sum(t.repasse) from (SELECT l.razaosocial as "Nome da Loja", l.cnpj as "CNPJ", (CAST(v.datavenda AS DATE)) as "Data da Venda", sum(v.total) , r.percentual as "Percentual de Repasse",  ((r.percentual/100)*sum(v.total)) as "repasse"
FROM venda v, loja l, loja_percentual p, percentualrepasse r
where v.loja_id = l.id and l.id = p.loja_id and p.percentual_id = r.id 
and  l.id != ''
group by l.razaosocial,l.cnpj, CAST(v.datavenda AS DATE), v.total, r.percentual ) t) from  venda v) ;

--Extrato por outro caminho

--*Geral Mensal
select LEFT(p.id,8) as "pedido", p.datapedido as "Data", u.nome as "Cliente",l.razaosocial as "Razão Social",  
l.nomefantasia as "NomeFantasia", p.status, l.cnpj, sum(i.quantidade*ip.valorunitario) as "Valor", pr.percentual, (((sum(i.quantidade*ip.valorunitario))*(pr.percentual))/100)
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l, loja_percentual lp, percentualrepasse pr
where c.id=(coalesce(p.cesta_alterada_id,p.cesta_id))
and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id and l.id=lp.loja_id and lp.percentual_id =pr.id 
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and u.telefone!='24999134517'
and LOWER(u.nome) not like LOWER('%TESTE%') and EXTRACT(MONTH FROM p.datapedido)='4' and p.status='ENTREGUE' and pr.status =true
group by LEFT(p.id,8), p.datapedido, u.nome,l.razaosocial, l.nomefantasia, p.status, l.cnpj, pr.percentual 
order by l.razaosocial asc, p.datapedido asc, u.nome asc;


-- Resumo mensal

select l.razaosocial as "Raz�oo Social",  
l.nomefantasia as "NomeFantasia", l.cnpj, l.apelido , sum(i.quantidade*ip.valorunitario) as "Valor", pr.percentual, (((sum(i.quantidade*ip.valorunitario))*(pr.percentual))/100) as "Repasse %Venda",
count(distinct(p.id)) as "Quantidade de pedidos", '0.5' as "Repasse por pedido", (count(distinct(p.id))*0.5) as "Repasse Pedido", ((count(p.id)*0.5)+(((sum(i.quantidade*ip.valorunitario))*(pr.percentual))/100)) as "Repasse Total"
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l, loja_percentual lp, percentualrepasse pr
where c.id=(coalesce(p.cesta_alterada_id,p.cesta_id))
and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id and l.id=lp.loja_id and lp.percentual_id =pr.id 
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and u.telefone!='24999134517'
and LOWER(u.nome) not like LOWER('%TESTE%') and p.status='ENTREGUE' and pr.status =true and
EXTRACT(MONTH FROM p.datapedido)= :mes
and replace(replace(replace(l.cnpj,'.',''),'/',''),'-','') = replace(replace(replace(:cnpj,'.',''),'/',''),'-','') -- coment�vel
group by l.razaosocial, l.nomefantasia, l.cnpj, pr.percentual, l.apelido 
order by l.razaosocial asc;


--*Detalhado diário
select LEFT(p.id,8) as "pedido", p.datapedido as "Data do Pedido", p.dataentrega as "Data da Entrega", u.nome as "Cliente",l.razaosocial as "Raz�o Social", l.cnpj, concat(i.quantidade,' un de ',r.nome) as "Produtos",(i.quantidade*ip.valorunitario) as "Valor", pr.percentual, ((i.quantidade*ip.valorunitario*pr.percentual)/100) as "Repasse"
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l, loja_percentual lp, percentualrepasse pr
where c.id=(coalesce(p.cesta_alterada_id,p.cesta_id))
and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id and l.id=lp.loja_id and lp.percentual_id =pr.id 
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and u.telefone!='24999134517'
and LOWER(u.nome) not like LOWER('%TESTE%') and p.status='ENTREGUE'
and EXTRACT(MONTH FROM p.datapedido)= :mes
and replace(replace(replace(l.cnpj,'.',''),'/',''),'-','') = replace(replace(replace(:cnpj,'.',''),'/',''),'-','') -- coment�vel 
group by LEFT(p.id,8), p.datapedido, u.nome,l.razaosocial, l.nomefantasia, p.status,
l.cnpj, (i.quantidade*ip.valorunitario), pr.percentual, ((i.quantidade*ip.valorunitario*pr.percentual)/100), i.quantidade,r.nome ,
p.horaentrega, p.dataentrega
order by cnpj asc, l.nomefantasia asc,p.datapedido asc;

-- Pedido por status
select * from (select u.nome, u.telefone, p.datapedido, p.status, left(p.id, 8) as "pedido", p.motivorejeicao,
--(case when p.loja_id=da.loja_id then concat('*',l.apelido) else l.apelido end) as "Loja"
l.apelido
from pedido p, usuario u, cesta c,
--distribuicao_alerta da, alerta a,
loja l 
where c.cliente_id= u.id and coalesce(p.cesta_alterada_id,p.cesta_id) = c.id and 
--p.id=a.pedido_id and a.id=da.alerta_id and da.loja_id =l.id
p.loja_id=l.id
and u.telefone != '24999063796' and u.telefone != '21999526957'and u.nome !='Matheus Teste' and u.nome!= 'Derick Bezerra'
and u.nome not like '%Elizier Sabino%'
and u.telefone !='21999536969' and u.nome not like '%User Test%' 
and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957'
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123'
and p.status = 'DISTRIBUIDO'
and extract(day from (now()-p.datapedido)) <=60
--and EXTRACT(month from p.datapedido) = 5
group by u.nome, u.telefone,
--p.datapedido, 
p.status, p.id, l.razaosocial,l.nomefantasia, 
--da.loja_id, 
l.id, p.id, c.id,
--a.id,
p.motivorejeicao
order by datapedido desc) s
right join 
(select LEFT(p.id,8) as "pedido", p.datapedido as "Data", u.nome as "Cliente",l.razaosocial as "Razão Social",  
l.nomefantasia as "NomeFantasia", p.status, l.cnpj, sum(i.quantidade*ip.valorunitario) as "Valor", pr.percentual, (((sum(i.quantidade*ip.valorunitario))*(pr.percentual))/100)
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l, loja_percentual lp, percentualrepasse pr
where c.id=(coalesce(p.cesta_alterada_id,p.cesta_id))
and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id and l.id=lp.loja_id and lp.percentual_id =pr.id 
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and u.telefone!='24999134517'
and LOWER(u.nome) not like LOWER('%TESTE%') 
--and EXTRACT(MONTH FROM p.datapedido)='4' 
and p.status='DISTRIBUIDO' and pr.status =true
group by LEFT(p.id,8), p.datapedido, u.nome,l.razaosocial, l.nomefantasia, p.status, l.cnpj, pr.percentual 
order by l.razaosocial asc, p.datapedido asc, u.nome asc) b 
on b.pedido=s.pedido;


