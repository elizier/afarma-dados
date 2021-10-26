update produto set quantidadeobrigatoria = '1';

insert into loja_usuario values
('64d67037-1c83-4858-bae6-b4d6f833ceb5','209'),
('57898d48-e428-4238-b746-0b27b1427e2a','213'),
('b83d0375-20a9-4f1d-a387-e6579fa58ea0','206'),
('ec7f9372-dc33-465d-9d27-8365d9dfa8be','211'),
('d6039d8c-b495-4af8-86c0-4aee9c5b5d49','200');

update produto set quantidadeobrigatoria ='6' where id =	'04c0ad91-8fb1-4e8b-a092-d965b5c76b51';
update produto set quantidadeobrigatoria ='3'	where id =	'80f49c6e-ea55-48c6-a9ab-1bc814abbfba';
update produto set quantidadeobrigatoria ='3'	where id =	'a60b53a1-a312-4dcb-97a5-9aa6161c468a';
update produto set quantidadeobrigatoria ='3'	where id =	'c0c7b69d-44c5-4239-9e8c-73af138628ec';
update produto set quantidadeobrigatoria ='3'	where id =	'c10d4692-89cb-4bb0-a7c5-4a59dc995923';
update produto set quantidadeobrigatoria ='3'	where id =	'd67e8304-d13c-4edd-a0d2-3347884992de';
update produto set quantidadeobrigatoria ='3'	where id =	'7bb3f3c0-7a40-454c-9890-8310dfffa370';
update produto set quantidadeobrigatoria ='3'	where id =	'a3029f6b-977f-4820-ab23-84c9b5b487d3';
update produto set quantidadeobrigatoria ='3'	where id =	'1f027ba7-7c44-4e67-8e83-68723f2b6d7b';
update produto set quantidadeobrigatoria ='3'	where id =	'8ae83c4b-8841-49a2-a353-5aee7a904174';
update produto set quantidadeobrigatoria ='3'	where id =	'8cb9ef38-9cd2-4c71-9478-89c4927b53b1';
update produto set quantidadeobrigatoria ='3'	where id =	'972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111';
update produto set quantidadeobrigatoria ='3'	where id =	'cb16e64f-6480-4b39-8fc8-037931840fde';
update produto set quantidadeobrigatoria ='3'	where id =	'6cef0393-d85b-4d6f-aef7-75c8498f998e';
update produto set quantidadeobrigatoria ='3'	where id =	'7c8a73e2-cd17-4b5d-bf18-50decc247b63';
update produto set quantidadeobrigatoria ='3'	where id =	'08bbac7e-8c4e-49c9-8612-daa266f1f03f';
update produto set quantidadeobrigatoria ='3'	where id =	'0a5fac9a-e87c-459e-b0b4-75468360c511';
update produto set quantidadeobrigatoria ='6'	where id =	'bf133a6d-88d9-4473-942e-59e874dc0a47';
update produto set quantidadeobrigatoria ='6'	where id =	'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc';
update produto set quantidadeobrigatoria ='6'	where id =	'da1d7783-8bb8-4141-97f7-0f1e197b94ae';
update produto set quantidadeobrigatoria ='6'	where id =	'251d163c-13f8-44d1-ab79-50dadc187d54';
update produto set quantidadeobrigatoria ='6'	where id =	'f2d2a379-2769-4a96-9a56-b356000ff1d8';
update produto set quantidadeobrigatoria ='6'	where id =	'43f10888-3a2d-4243-9257-0fd087cb5a2b';
update produto set quantidadeobrigatoria ='6'	where id =	'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3';
update produto set quantidadeobrigatoria ='6'	where id =	'eedaf752-a511-42f4-b04a-df6f8396fe39';
update produto set quantidadeobrigatoria ='1'	where id =	'4dffec2f-f279-4ffb-bf98-1efdbcae66d0';
update produto set quantidadeobrigatoria ='1'	where id =	'4ea0f719-ebc4-41ac-abaf-7c0c042cfa95';
update produto set quantidadeobrigatoria ='1'	where id =	'e9bf387e-c74c-4b2b-8def-53bd77402904';
update produto set quantidadeobrigatoria ='6'	where id =	'f9a2feaa-d9aa-482b-931a-5275e23dc4a3';



(select count(usuario.id) as "Contagem",
 translate(to_char((CAST(usuario.dataaceite AS DATE)), 'MM-YYYY'),'-','/') as "Data",
 (EXTRACT(MONTH FROM usuario.dataaceite)) as "Mês", (EXTRACT(YEAR FROM usuario.dataaceite)) as "Ano"
from usuario
where 1=1
[[and {{status}} ]]
[[ and  translate(to_char((CAST(usuario.dataaceite AS DATE)), 'MM-YYYY'),'-','/') = {{data}} ]]
group by  translate(to_char((CAST(usuario.dataaceite AS DATE)), 'MM-YYYY'),'-','/'), (EXTRACT(MONTH FROM usuario.dataaceite)), (EXTRACT(YEAR FROM usuario.dataaceite))
order by
 (EXTRACT(YEAR FROM usuario.dataaceite)),
 (EXTRACT(MONTH FROM usuario.dataaceite)),
 translate(to_char((CAST(usuario.dataaceite AS DATE)), 'MM-YYYY'),'-','/'))

union all

(select 'Total', count(usuario.id) ,
 translate(to_char((CAST(usuario.dataaceite AS DATE)), 'MM-YYYY'),'-','/') as "Data",
 (EXTRACT(MONTH FROM usuario.dataaceite)) as "Mês", (EXTRACT(YEAR FROM usuario.dataaceite)) as "Ano"
from usuario
where 1=1
[[ and  translate(to_char((CAST(usuario.dataaceite AS DATE)), 'MM-YYYY'),'-','/') = {{data}} ]]
group by translate(to_char((CAST(usuario.dataaceite AS DATE)), 'MM-YYYY'),'-','/'),(EXTRACT(MONTH FROM usuario.dataaceite)), (EXTRACT(YEAR FROM usuario.dataaceite))
order by (EXTRACT(YEAR FROM usuario.dataaceite)),
 (EXTRACT(MONTH FROM usuario.dataaceite)),
 translate(to_char((CAST(usuario.dataaceite AS DATE)), 'MM-YYYY'),'-','/'));


select * from pedido p order by p.cesta_id asc

update usuario set senha='CLIENTE_EXCLUIDO' where id='258';

----------------------------------------------------------------------------

--***Inserts Na Produção***
--Moderna Rua da conceição
update usuario set nome = 'admin.drogariarrdemageltdame' where email = 'admin.drogariarrdemageltdame';
update usuario set email = 'admin.rrdeparada@drogariasconceito.com.br	' where nome = 'admin.drogariarrdemageltdame';

update endereco set googleplaceid = 'ChIJcRX-1cSDmQARdARCOsPAcnM' where id = '5f5c1c7f-c73e-40ff-9f69-b441aab02897';
update loja set endereco_id = '5f5c1c7f-c73e-40ff-9f69-b441aab02897' where id = '081f88e9-e929-4380-b849-c005877c3183';

update usuario set enderecoid = '5f5c1c7f-c73e-40ff-9f69-b441aab02897' where id = '8';
update usuario set enderecoid = '5f5c1c7f-c73e-40ff-9f69-b441aab02897' where id = '9';

insert into rede values(uuid_generate_v4(),'drogariaconceito@afarma.com.br', 'Conceito');

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf)
values (uuid_generate_v4() ,
'Parada Modelo',
'25943548',
'Guapimirim',
'Loja 1, Quadra 11, Lote 13',
'',
'ChIJa2zFgV6wmQARY1ZI2x_4v-M',
'-22.547114081788482',
'-42.98542630262764',
'Rio-Friburgo',
'197',
'ESTRADA',
'RJ');

update endereco set lng='-42.98492711833748' where googleplaceid='ChIJa2zFgV6wmQARY1ZI2x_4v-M'; -42.98492711833748
update loja set razaosocial = 'CONCEITO - P.MODELO' where cnpj='09.436.621/0001-97';


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id, active)
values (uuid_generate_v4(),
'09.436.621/0001-97',
'78496401',
'',
'DROGARIA MODERNA',
'5',
'Drogaria Moderna',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJa2zFgV6wmQARY1ZI2x_4v-M'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
(select rede.id from rede where rede.email='drogariaconceito@afarma.com.br'),
true);
update loja set 

insert into usuario (id, dataaceite, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid, aceitetermo)
values (
nextval('usuario_id_seq'),
now(),
true,
'000.000.000-01',
now(),
'usuario.rrdeparada@drogariasconceito.com.br	',
'usuario.drogariarrdemageltdame',
'1234567890',
'2136304455',
(select e.id from endereco e where e.googleplaceid = 'ChIJa2zFgV6wmQARY1ZI2x_4v-M'),
'3',
true
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '09.436.621/0001-97'),
	(select u.id from usuario u where email = 'usuario.rrdeparada@drogariasconceito.com.br	')
	);


INSERT INTO public.usuario(id, dataaceite, ativo,  cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid, aceitetermo)
values (
nextval('usuario_id_seq'),
now(),
true,
'000.000.000-01',
now(),
'admin.drogariarrdemageltdame',
'admin.rrdeparada@drogariasconceito.com.br	',
'1234567890',
'+552430768001',
(select e.id from endereco e where e.googleplaceid = 'ChIJa2zFgV6wmQARY1ZI2x_4v-M'),
'1',
true
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '09.436.621/0001-97'),
	(select u.id from usuario u where email = 'admin.rrdeparada@drogariasconceito.com.br	')
	);


select u.nome, u.telefone, p.datapedido, p.status, left(p.id, 8) as "Pedido", p.motivorejeicao
(case when p.loja_id=da.loja_id then concat('*',l.nomefantasia) else l.nomefantasia end) as "Loja",
l.id as "lojaid", p.id as "pedidoid", c.id as "cestaid", a.id as "alertaid"
from pedido p, usuario u, cesta c, distribuicao_alerta da, alerta a, loja l 
where c.cliente_id= u.id and p.cesta_id = c.id and p.id=a.pedido_id and a.id=da.alerta_id and da.loja_id =l.id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and p.status = 'ENTREGUE'
and extract(day from (now()-p.datapedido)) <=3
group by u.nome, u.telefone,p.datapedido, p.status, p.id, l.razaosocial,l.nomefantasia, da.loja_id, l.id, p.id, c.id,a.id, p.motivorejeicao
order by datapedido desc;



select left(p.id,8) as "Pedido", p.status
from loja l, pedido p, cesta c, usuario u, item_cesta ic, itemprodutocesta i, produto r,itemprodutopopular ip
where p.cesta_id =c.id and c.id =ic.cesta_id and ic.item_id =i.produto_id and i.produto_id = r.id
and p.loja_id = l.id and u.id = c.cliente_id 


--Check Extrato Mensal
select * from (select LEFT(p.id,8) as "pedido", p.datapedido as "Data", u.nome as "Cliente",l.razaosocial as "Razão Social",
l.nomefantasia as "NomeFantasia", p.status, r.nome , i.quantidade, (i.quantidade*ip.valorunitario) as "Valor"
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l
where (p.cesta_id = c.id  or p.cesta_alterada_id = c.id ) and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and u.telefone!='24999134517'
and LOWER(u.nome) not like LOWER('%TESTE%') and EXTRACT(MONTH FROM p.datapedido)='3' and p.status='ENTREGUE'
group by LEFT(p.id,8) , i.quantidade, p.datapedido, u.nome,l.razaosocial, l.nomefantasia, p.status, r.nome, (i.quantidade*ip.valorunitario)
order by p.status, p.datapedido asc, u.nome asc) c

left join venda v on left(v.pedido_id,8)=c.pedido ;

select * from (select LEFT(p.id,8) as "pedido", p.datapedido as "Data", u.nome as "Cliente",l.razaosocial as "Razão Social",
l.nomefantasia as "NomeFantasia", p.status, l.cnpj, sum(i.quantidade*ip.valorunitario) as "Valor"
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l
where c.id=(coalesce(p.cesta_alterada_id,p.cesta_id))
and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and u.telefone!='24999134517'
and LOWER(u.nome) not like LOWER('%TESTE%') and EXTRACT(MONTH FROM p.datapedido)='3' and p.status='ENTREGUE'
group by LEFT(p.id,8), p.datapedido, u.nome,l.razaosocial, l.nomefantasia, p.status, l.cnpj
order by p.status, p.datapedido asc, u.nome asc) c
left join venda v on left(v.pedido_id,8)=c.pedido ;

select LEFT(p.id,8) as "pedido", p.datapedido as "Data", u.nome as "Cliente",l.razaosocial as "Razão Social",
l.nomefantasia as "NomeFantasia", p.status, l.cnpj, sum(i.quantidade*ip.valorunitario) as "Valor"
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l
where c.id=(coalesce(p.cesta_alterada_id,p.cesta_id))
and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and u.telefone!='24999134517'
and LOWER(u.nome) not like LOWER('%TESTE%') and EXTRACT(MONTH FROM p.datapedido)='3' and p.status='ENTREGUE'
group by LEFT(p.id,8), p.datapedido, u.nome,l.razaosocial, l.nomefantasia, p.status, l.cnpj
order by p.status, p.datapedido asc, u.nome asc

select LEFT(p.id,8) as "pedido", p.datapedido as "Data", u.nome as "Cliente",l.razaosocial as "Razão Social",
l.nomefantasia as "NomeFantasia", p.status, sum(i.quantidade*ip.valorunitario) as "Valor"
from pedido p, cesta c, item_cesta ic, itemprodutocesta i, produto r, itemprodutopopular ip, usuario u, loja l
where (p.cesta_id = c.id  or p.cesta_alterada_id = c.id ) and u.id=c.cliente_id and p.origempedido !='TESTE' and c.id=ic.cesta_id and ic.item_id=i.id
and i.produto_id=r.id and ip.produto_id = r.id and ip.uf='RJ' and l.id=p.loja_id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and u.telefone!='24999134517'
and LOWER(u.nome) not like LOWER('%TESTE%') and EXTRACT(MONTH FROM p.datapedido)='4' and p.status='ENTREGUE'
group by LEFT(p.id,8), p.datapedido, u.nome,l.razaosocial, l.nomefantasia, p.status
order by p.status, p.datapedido asc, u.nome asc;



select * from pedido
left join venda v on v.pedido_id=pedido.id
where pedido.status ='ENTREGUE' and pedido.origempedido !='TESTE';

select * from usuario u where u.nome like '%Paulo Ce%';

select * from pedido p where p.status='ENTREGUE' and p.origempedido!='TESTE';

select * from usuario u where u.id='248';

select * from endereco e where e.id ='bc4c8389-6245-4f87-a9bf-78439f9615a2';


select SUM((r.percentual/100)*(v.total))  as "Repasse aFarma"
FROM venda v, loja l, loja_percentual p, percentualrepasse r
where v.loja_id = l.id and l.id = p.loja_id and p.percentual_id = r.id and  l.id != '' and r.status = true;


--**Apuração Mensal por Loja**--
SELECT l.razaosocial as "Loja", l.cnpj as "CNPJ", EXTRACT(MONTH FROM v.datavenda) as "Mês", EXTRACT(YEAR FROM v.datavenda) as "Ano", count(v.id) as "Número de vendas",
Sum(v.total) as "Valor Total Vendido", r.percentual as "Percentual de Repasse",  ((r.percentual/100)*sum(v.total)) as "Repasse aFarma"
FROM loja l, venda v, loja_percentual p, percentualrepasse r
where v.loja_id = l.id and v.loja_id != '' and l.id != '' and l.id = p.loja_id and p.percentual_id = r.id 
GROUP BY l.razaosocial, l.cnpj, (EXTRACT(MONTH FROM v.datavenda)), (EXTRACT(YEAR FROM v.datavenda)), r.percentual 
ORDER BY (EXTRACT(MONTH FROM v.datavenda)) asc, (EXTRACT(YEAR FROM v.datavenda)) asc, sum(v.total) asc ;

update pedido set status = 'ENTREGUE' where id='0208a796-5132-49f4-af8d-d65306fa66a9';
select * from pedido where pedido.id='0208a796-5132-49f4-af8d-d65306fa66a9';

select u.id, u.nome, u.email from usuario u where u.id<190 and u.perfilid='2';

update endereco set tipo=upper(tipo);
select from endereco_usuario e where e.usuario_id = 130
insert into endereco_usuario values ('130','bc4c8389-6245-4f87-a9bf-78439f9615a2');

insert into distribuicao_alerta values ('031f5fa1-2dff-47e5-88b5-a941945fa97f','');

delete from distribuicao_alerta  where loja_id='95d68bda-9208-4bc8-99ce-645f3f0ae909';

select l.razaosocial, l.nomefantasia, u.nome, u.devicetoken, u.telefone
from loja_usuario lu, loja l, usuario u
where u.id=lu.usuario_id and lu.loja_id =l.id 

select * from usuario u where u.telefone like '%8000';

insert into loja_usuario values ('b1a9010b-e6e4-43dd-9d01-8d0e6d2ee8c6','159');

update usuario set devicetoken = null where id='159';

select p.status, count(p.status) as "Quantidade em Março" from pedido p where (EXTRACT(MONTH FROM p.datapedido))=3
group by p.status ;

select * from pedido p where (EXTRACT(MONTH FROM p.datapedido))=3 ;

select p.id as "Pedido id", p.datapedido, p.motivorejeicao, d.loja_id ,l.razaosocial, p.loja_id
from pedido p, loja l, alerta a, distribuicao_alerta d
where p.id like '5d58d09d%' and a.pedido_id =p.id and a.id=d.alerta_id and d.loja_id = l.id ;

select * from pedido p, loja l where p.datapedido =

select (now()-(cast(3 as day)));

select * from usuario u, pedido p, cesta c where c.id=coalesce(p.cesta_alterada_id,p.cesta_id) and u.id=c.cliente_id and u.nome=''
