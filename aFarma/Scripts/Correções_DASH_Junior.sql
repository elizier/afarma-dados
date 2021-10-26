-- Total de pedidos

select p.id, p.datapedido, u.nome from pedido p, usuario u, cesta c where coalesce(p.cesta_alterada_id,p.cesta_id)=c.id
and u.id=c.cliente_id and u.telefone != '24999063796' and u.telefone != '21999526957'
and u.telefone !='21999536969' and lower(u.nome) not like '%derick bezerra%'
and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957'
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123'
and p.status='REJEITADO'
and extract(month from p.datapedido)='4';

--Total de Clientes


select count(*) from (select uuid_generate_v4() as "Id", translate(UPPER(u.nome), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "Nome",
replace(replace(u.cpf,'-',''),'.','' )as "Documento",
translate(UPPER(e.cidade), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "Cidade", 
translate(UPPER(e.bairro), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "Bairro", replace(e.cep,'-','') as "CEP",
replace(replace(replace(replace(u.telefone,')', ''), '(', ''),'-',''),' ', '') as "Telefone",  u.email as "Email",
cast(u.dataaceite as date) as "Data de Cadastro"
from usuario u, endereco e, endereco_usuario n
where u.id = n.usuario_id and n.endereco_id = e.id and u.perfilid = '2' and u.ativo = true
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957'
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123'
group by u.nome, replace(replace(u.cpf,'-',''),'.',''),
translate(UPPER(e.cidade), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),
translate(UPPER(e.bairro), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),
replace(e.cep,'-',''), replace(replace(replace(replace(u.telefone,')', ''), '(', ''),'-',''),' ', ''),  u.email, u.dataaceite) as "filtro";


--***Produto mais pedido***--
select filtro.concat from
(Select r.nome,count(p.id), concat(r.nome,' ','-',' ',count(p.id),' ','pedidos')
FROM cesta c, pedido p, item_cesta i, itemprodutocesta t, produto r, usuario u where
 u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123'
and p.cesta_id = c.id and c.cliente_id = u.id and  c.id =i.cesta_id and i.item_id = t.id and t.produto_id = r.id
and p.loja_id != ''group by r.nome order by count(p.id) desc limit 1) as filtro;

--Local com mais pedidos

select filtro.local from (select translate(UPPER(concat(e.bairro,'-',e.cidade)), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as Local , count(p.id)
from pedido p, endereco e, cesta c, usuario u, loja l where coalesce (p.cesta_alterada_id ,p.cesta_id )=c.id
and c.cliente_id =u.id and p.endereco_id = e.id and p.endereco_id != ''
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and l.id=p.loja_id
group by translate(UPPER(e.cidade), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'), 
translate(UPPER(e.bairro), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'), translate(UPPER(concat(e.bairro,'-',e.cidade)), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
order by count(p.id) desc
limit 1) as filtro;

--Pedido por status por mês

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


--Pedido por status nos ultimos 3 dias

select u.nome, u.telefone, p.datapedido, p.status, left(p.id, 8) as "Pedido",
(case when p.loja_id=da.loja_id then concat('*',l.apelido) else l.apelido end) as "Loja (*loja que atendeu)", l.razaosocial,
r.dataemissaoreceita as "Data da receita"
from pedido p, usuario u, cesta c, distribuicao_alerta da, alerta a, loja l, pedido_receita pr, receita r
where c.cliente_id= u.id and p.cesta_id = c.id and p.id=a.pedido_id and a.id=da.alerta_id and da.loja_id =l.id
and pr.pedido_id=p.id and pr.receita_id=r.id 
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and p.status = 'ENTREGUE'
and extract(day from (now()-p.datapedido)) <=3
group by u.nome, u.telefone,p.datapedido, p.status, p.id,
l.razaosocial,l.nomefantasia, da.loja_id, 
l.id, p.id, c.id,a.id,
p.motivorejeicao, r.dataemissaoreceita
order by datapedido desc;

select l.nomefantasia, l.razaosocial, l.apelido, u.telefone 
from usuario u, loja l, loja_usuario lu
where lu.loja_id=l.id and lu.usuario_id=u.id and l.active=true and u.telefone!='' and l.apelido!='MODERNA'
group by l.nomefantasia, l.razaosocial, l.apelido, u.telefone 
order by l.apelido asc;

select u.nome, u.telefone, p.datapedido, p.status, left(p.id,8) as "Pedido", l.apelido
from pedido p, cesta c, usuario u, loja l
where 
c.cliente_id=u.id and coalesce(p.cesta_alterada_id, p.cesta_id)=c.id and l.id =p.loja_id 
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and p.status = 'ENTREGUE'
order by p.datapedido desc

--Pedido Entregue


select u.nome, u.telefone, p.datapedido, p.status, left(p.id, 8) as "Pedido",l.apelido, r.dataemissaoreceita 
from pedido p, usuario u, cesta c, loja l, pedido_receita pr, receita r
where c.cliente_id= u.id and p.cesta_id = c.id and p.loja_id=l.id 
and pr.pedido_id=p.id and pr.receita_id=r.id 
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and p.status = 'DISTRIBUIDO'
and extract(day from (now()-p.datapedido)) <=7
group by u.nome, u.telefone,p.datapedido, p.status, p.id, l.razaosocial,l.nomefantasia, l.id, p.id, c.id,r.dataemissaoreceita  
order by datapedido desc;

select *from pedido p, usuario u, 

select * from usuario u, pedido p, cesta c where coalesce(p.cesta_alterada_id,p.cesta_id)=c.id and c.cliente_id=u.id
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'

select p.id, UPPER(u.nome), u.telefone, u.cpf, p.datapedido, p.status from pedido p, cesta c, usuario u 
where coalesce(p.cesta_alterada_id,p.cesta_id)=c.id and c.cliente_id=u.id and
u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and extract(month from (p.datapedido)) =4;

select u.nome, u.perfilid from usuario u
where u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.perfilid='2';

select * from pedido p where p.status ='REJEITADO'

select pedido.status as status, count(pedido.id) as contagem,  
				translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/') as mesReferencia ,  
				(EXTRACT(MONTH FROM pedido.datapedido)) as Mes, (EXTRACT(YEAR FROM pedido.datapedido)) as Ano, RANK() Over(ORDER BY count(pedido.id) DESC) AS id   
				from pedido   
				where  
				pedido.status = 'ENTREGUE' 
				--and  translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/') = '4'
				group by pedido.status, translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/'), (EXTRACT(MONTH FROM pedido.datapedido)), (EXTRACT(YEAR FROM pedido.datapedido))  
				order by  
				(EXTRACT(YEAR FROM pedido.datapedido)),  
				(EXTRACT(MONTH FROM pedido.datapedido)),  
				translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/');




(select   pedido.status as "Status", count(pedido.id) as "Contagem",
 translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/') as "Data",
 (EXTRACT(MONTH FROM pedido.datapedido)) as "Mês", (EXTRACT(YEAR FROM pedido.datapedido)) as "Ano"
from pedido, usuario u, cesta
where coalesce(pedido.cesta_alterada_id,pedido.cesta_id)=cesta.id and cesta.cliente_id=u.id and lower(pedido.observacao) not like '%teste%' 
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957'
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123'
--[[and {{status}} ]]
--[[ and  translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/') = {{data}} ]]
group by pedido.status, translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/'), (EXTRACT(MONTH FROM pedido.datapedido)), (EXTRACT(YEAR FROM pedido.datapedido))
order by
 (EXTRACT(YEAR FROM pedido.datapedido)),
 (EXTRACT(MONTH FROM pedido.datapedido)),
 translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/'))

union all

(select 'Total', count(pedido.id) ,
 translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/') as "Data",
 (EXTRACT(MONTH FROM pedido.datapedido)) as "Mês", (EXTRACT(YEAR FROM pedido.datapedido)) as "Ano"
from pedido, usuario u, cesta
where coalesce(pedido.cesta_alterada_id,pedido.cesta_id)=cesta.id and cesta.cliente_id=u.id and lower(pedido.observacao) not like '%teste%'
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com' 
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957'
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123'
--[[ and  translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/') = {{data}} ]]
group by translate(to_char((CAST(pedido.datapedido AS DATE)), 'MM-YYYY'),'-','/'),(EXTRACT(MONTH FROM pedido.datapedido)), (EXTRACT(YEAR FROM pedido.datapedido)));


select * from pedido p where lower(p.observacao) like '%teste%';

select * from usuario where usuario.email like '%bezerra%';


select l.razaosocial, l.apelido, u.telefone, u.email, u.senha 
from loja l, usuario u, loja_usuario lu
where lu.loja_id=l.id and lu.usuario_id=u.id and l.active=true and l.apelido!='MODERNA'
order by l.apelido asc;

select * from loja l, endereco e where l.endereco_id=e.id and l.apelido='9 DOSE CERTA';




select left(p.id,8) as "Pedido", p.datapedido as "Data", u.nome as "Cliente", u.telefone, l.apelido, l.razaosocial, p.status,
r.dataemissaoreceita as "Data da Receita"
from loja l, distribuicao_alerta da, alerta a, cesta c, usuario u, pedido p, pedido_receita pr, receita r
where coalesce(p.cesta_alterada_id, p.cesta_id)=c.id and c.cliente_id=u.id and a.pedido_id=p.id and da.alerta_id=a.id 
and da.loja_id=l.id and pr.pedido_id=p.id and pr.receita_id=r.id  and 
u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and p.status='DISTRIBUIDO'
and extract(day from (now()-p.datapedido)) <=3;



select left(p.id,8) as "Pedido", p.datapedido as "Data", u.nome as "Cliente", u.telefone, l.apelido, l.razaosocial, p.status,
r.dataemissaoreceita as "Data da Receita"
from loja l, distribuicao_alerta da, alerta a, cesta c, usuario u, pedido p, pedido_receita pr, receita r
where coalesce(p.cesta_alterada_id, p.cesta_id)=c.id and c.cliente_id=u.id and a.pedido_id=p.id and da.alerta_id=a.id 
and da.loja_id=l.id and pr.pedido_id=p.id and pr.receita_id=r.id  and 
u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123' 
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and left(p.id,8)='ace68338'
--and p.status='DISTRIBUIDO'
--and extract(day from (now()-p.datapedido)) <=3;

select * from pedido p , receita r, pedido_receita pr where p.id=pr.pedido_id and  pr.receita_id=r.id and 
(left(p.id,8)='843269c1' or left(p.id,8)='24f73620')


select left(p.id,8) as "pedido", p.status, u.nome, u.telefone, p.datapedido, p.motivorejeicao, r.dataemissaoreceita, r.image , d.image 
from usuario u, cesta c, pedido p, loja l, pedido_receita pr, receita r, usuario_documentos ud, documento d
where coalesce(p.cesta_alterada_id,p.cesta_id)=c.id and c.cliente_id=u.id and ud.usuario_id=u.id and ud.documento_id=d.id 
and pr.pedido_id=p.id and pr.receita_id=r.id 
--and p.status='FORA_DA_AREA_DE_ATENDIMENTO' 
and u.usuarioteste=false 
and l.id=p.loja_id
--and l.id='0447af6b-2f52-4f08-90da-f240efeda494'
--and extract(day from (now()-p.datapedido)) <=5
and left(p.id,8)='d3028267'
group by left(p.id,8), p.status, u.nome, u.telefone, p.datapedido, p.motivorejeicao, r.dataemissaoreceita, r.image , d.image
order by p.datapedido desc


select left(p.id,8), u.nome, p.status, p.datapedido, pr.nome, i.quantidade 
from usuario u, pedido p, itemprodutocesta i, item_cesta ic, cesta c, produto pr 
where p.cesta_id=c.id and c.cliente_id=u.id and c.id=ic.cesta_id  and ic.item_id =i.id and i.produto_id=pr.id
and c.cliente_id=231

select extract(month from p.datapedido)::int as "mes", extract(year from p.datapedido)::int as "ano",  count(p.id)
from 
usuario u,
pedido p,
cesta c
where c.cliente_id=u.id and coalesce(p.cesta_alterada_id,p.cesta_id)=c.id 
and u.usuarioteste=false and u.perfilid=2
group by  extract(month from p.datapedido), extract(year from p.datapedido)
order by  extract(month from p.datapedido), extract(year from p.datapedido)


select concat('Razão Social: ',l.razaosocial), concat('Apelido: ',l.apelido), concat('Email: ',l.email), concat('Senha: ',l.senha),
concat('Telefone: ',l.telefone)
from ((select l.cnpj, l.apelido, l.razaosocial, u.email, u.senha, u.telefone
from loja l, usuario u, loja_telefone lt, loja_usuario lu, telefone t
where u.id=lu.usuario_id and lu.loja_id=l.id and lu.usuario_id=u.id and lu.loja_id=l.id 
and l.active=true and l.cnpj!='00.000.000/0001-91' and l.cnpj!='11.000.000/0001-91'
group by l.cnpj, l.apelido, l.razaosocial, u.telefone, u.nome, u.email, u.senha
union all
select l.cnpj, l.apelido, l.razaosocial, u.email, u.senha, concat(t.ddd,t.numero)
from loja l, usuario u, loja_telefone lt, loja_usuario lu, telefone t
where lt.loja_id=l.id and lt.telefone_id=t.id and lu.usuario_id=u.id and lu.loja_id=l.id 
group by l.cnpj, l.apelido, l.razaosocial,concat(t.ddd,t.numero), u.email, u.senha)
order by cnpj asc) l
where l.telefone!=''
group by l.cnpj, l.apelido, l.razaosocial, l.telefone, l.email, l.senha
order by l.cnpj asc








