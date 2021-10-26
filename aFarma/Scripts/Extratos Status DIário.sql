select u.nome, u.telefone, p.datapedido, p.status, left(p.id, 8) as "Pedido", p.motivorejeicao,
(case when p.loja_id=da.loja_id then concat('*',l.apelido) else l.apelido end) as "Loja"
from pedido p, usuario u, cesta c, distribuicao_alerta da, alerta a, loja l 
where c.cliente_id= u.id and p.cesta_id = c.id and p.id=a.pedido_id and a.id=da.alerta_id and da.loja_id =l.id 
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
and extract(day from (now()-p.datapedido)) <=3
group by u.nome, u.telefone,p.datapedido, p.status, p.id, l.razaosocial,l.nomefantasia, da.loja_id, l.id, p.id, c.id,a.id, p.motivorejeicao
order by datapedido desc;

