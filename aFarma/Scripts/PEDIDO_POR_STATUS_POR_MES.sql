--PEDIDO POR STATUS POR MES

(select y.status, y.data, count(y.status) as "Quantidade de pedidos" from (select translate(to_char((CAST(p.datapedido AS DATE)), 'MM-YYYY'),'-','/') as "data",
extract(month from p.datapedido) as "mes", extract ( year from p.datapedido) as "ano", p.status 
from pedido p, cesta c, usuario u 
where coalesce (p.cesta_alterada_id ,p.cesta_id )=c.id
and c.cliente_id =u.id
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
group by p.datapedido , p.status
order by p.datapedido asc) y
group by y.data, y.status, y.ano, y.mes
order by y.ano asc, y.mes asc)
union all
(select  'Total' ,z.data, sum(z.sum) from (select y.data, y.mes, y.ano, sum(y.count) from (select translate(to_char((CAST(p.datapedido AS DATE)), 'MM-YYYY'),'-','/') as "data",
extract(month from p.datapedido) as "mes", extract ( year from p.datapedido) as "ano", p.status, count(p.id)
from pedido p, cesta c, usuario u 
where coalesce (p.cesta_alterada_id ,p.cesta_id )=c.id
and c.cliente_id =u.id
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
group by p.datapedido , p.status
order by p.datapedido asc) y
group by y.data, y.status, y.ano, y.mes
order by y.ano asc, y.mes asc) z
group by z.data, z.ano, z.mes
order by z.ano asc, z.mes asc);