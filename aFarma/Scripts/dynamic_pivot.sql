SELECT id, identificador, nome
FROM public.perfil;
\crosstabview

update usuario set email = lower(email);


select l.nomefantasia, l.raioentrega, e.lat, e.lng, concat(e.tipo ,' ',e.logradouro ,' ',e.numero ,' ',e.complemento ,' ',e.cidade ,'-',e.uf )
from loja l, endereco e 
where l.endereco_id = e.id and l.active = true;

select * from loja l, endereco e where e.id = l.endereco_id and l.id ='d6039d8c-b495-4af8-86c0-4aee9c5b5d49';

SHOW TIMEZONE;
select now();

update loja set raioentrega = 3 where raioentrega = 2;

select * from loja;

-------------------------------------------------------------------------------------------------------------------

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



select u.nome, concat(ca.produto1,ca.produto2,ca.produto3,ca.produto4,ca.produto5,ca.produto6,ca.produto7,ca.produto8),
(DATE_PART('day', (now()) - (max(p.datapedido)))) as "ultimopedido", max(p.datapedido),
(DATE_PART('day', (now()) - (max(p.datapedido))))
from  usuario u, pedido p, cesta c, pedido_receita pr, receita r, item_cesta ic, itemprodutocesta ip,
(SELECT * 
FROM crosstab( 'select c.id, 1 as "produto", co.concat
from cesta c, item_cesta ic, itemprodutocesta i, produto p,
			  (select c.id, p.nome, i.quantidade,concat(i.quantidade, p.nome)
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

select LEFT(p.id,8) as "pedido", p.datapedido, l.razaosocial as "Razão Social",  
l.nomefantasia as "NomeFantasia", l.cnpj, l.apelido, u.nome as "Cliente", pr.produtoscesta
from  usuario u, pedido p, cesta c, loja l,
(select ca.cesta, concat(
ci.q1, (case when ci.q1 isnull and ca.produto1 notnull then '1 un de ' when ci.q1 notnull and ca.produto1 notnull then ' un de ' else '' end), ca.produto1, (case when ca.produto2 isnull then '' else ' & ' end),
ci.q2, (case when ci.q2 isnull and ca.produto2 notnull then '1 un de ' when ci.q2 notnull and ca.produto2 notnull then ' un de ' else '' end), ca.produto2, (case when ca.produto3 isnull then '' else ' & ' end),
ci.q3, (case when ci.q3 isnull and ca.produto3 notnull then '1 un de ' when ci.q3 notnull and ca.produto3 notnull then ' un de ' else '' end), ca.produto3, (case when ca.produto4 isnull then '' else ' & ' end),
ci.q4, (case when ci.q4 isnull and ca.produto4 notnull then '1 un de ' when ci.q4 notnull and ca.produto4 notnull then ' un de ' else '' end), ca.produto4, (case when ca.produto5 isnull then '' else ' & ' end),
ci.q5, (case when ci.q5 isnull and ca.produto5 notnull then '1 un de ' when ci.q5 notnull and ca.produto5 notnull then ' un de ' else '' end), ca.produto5, (case when ca.produto6 isnull then '' else ' & ' end),
ci.q6, (case when ci.q6 isnull and ca.produto6 notnull then '1 un de ' when ci.q6 notnull and ca.produto6 notnull then ' un de ' else '' end), ca.produto6, (case when ca.produto7 isnull then '' else ' & ' end),
ci.q7, (case when ci.q7 isnull and ca.produto7 notnull then '1 un de ' when ci.q7 notnull and ca.produto7 notnull then ' un de ' else '' end), ca.produto7, (case when ca.produto8 isnull then '' else ' & ' end),
ci.q8, (case when ci.q8 isnull and ca.produto8 notnull then '1 un de ' when ci.q8 notnull and ca.produto8 notnull then ' un de ' else '' end), ca.produto8
) as "produtoscesta"
from
(SELECT * 
FROM crosstab( 'select c.id, 1 as "produto", co.concat
from cesta c, item_cesta ic, itemprodutocesta i, produto p,
			  (select c.id, p.nome, i.quantidade,concat(p.nome)
			  from cesta c, item_cesta ic, itemprodutocesta i, produto p
			  where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id ) co
where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id and co.id=c.id
group by c.id, co.concat order by 1,2 ') 
     AS final_result("cesta" VARCHAR, "produto1" TEXT, "produto2" TEXT,
					 "produto3" TEXT, "produto4" TEXT, "produto5" TEXT,
					 "produto6" TEXT, "produto7" TEXT, "produto8" TEXT)) ca
left join
(SELECT * 
FROM crosstab( 'select c.id, 1 as "produto", co.concat
from cesta c, item_cesta ic, itemprodutocesta i, produto p,
			  (select c.id, p.nome, i.quantidade,concat(i.quantidade)
			  from cesta c, item_cesta ic, itemprodutocesta i, produto p
			  where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id ) co
where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id and co.id=c.id
group by c.id, co.concat order by 1,2 ') 
     AS final_result("cesta" VARCHAR, "q1" TEXT, "q2" TEXT,
					 "q3" TEXT, "q4" TEXT, "q5" TEXT,
					 "q6" TEXT, "q7" TEXT, "q8" TEXT)) ci
					 on ci.cesta=ca.cesta) pr
where u.id = c.cliente_id and c.id = coalesce(p.cesta_alterada_id, p.cesta_id) 
and p.status='ENTREGUE' and l.id=p.loja_id and u.usuarioteste!=true
and pr.cesta=c.id
and EXTRACT(MONTH FROM p.datapedido)= :mes
and replace(replace(replace(l.cnpj,'.',''),'/',''),'-','') = coalesce(replace(replace(replace(:cnpj,'.',''),'/',''),'-',''), replace(replace(replace(l.cnpj,'.',''),'/',''),'-',''))
order by l.cnpj, p.datapedido asc;


CREATE EXTENSION IF NOT EXISTS tablefunc;

select c.id, 1 as "produto", co.concat
from cesta c, item_cesta ic, itemprodutocesta i, produto p,
			  (select c.id, p.nome, i.quantidade,concat(p.id,i.quantidade)
			  from cesta c, item_cesta ic, itemprodutocesta i, produto p
			  where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id ) co
where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id and co.id=c.id
group by c.id, co.concat order by 1,2 
\crosstabview 



CREATE FUNCTION dynamic_pivot(central_query text, headers_query text)
 RETURNS refcursor AS
$$
DECLARE
  left_column text;
  header_column text;
  value_column text;
  h_value text;
  headers_clause text;
  query text;
  j json;
  r record;
  curs refcursor;
  i int:=1;
BEGIN
  -- find the column names of the source query
  EXECUTE 'select row_to_json(_r.*) from (' ||  central_query || ') AS _r' into j;
  FOR r in SELECT * FROM json_each_text(j)
  LOOP
    IF (i=1) THEN left_column := r.key;
      ELSEIF (i=2) THEN header_column := r.key;
      ELSEIF (i=3) THEN value_column := r.key;
    END IF;
    i := i+1;
  END LOOP;

  --  build the dynamic transposition query (based on the canonical model)
  FOR h_value in EXECUTE headers_query
  LOOP
    headers_clause := concat(headers_clause,
     format(chr(10)||',min(case when %I=%L then %I::text end) as %I',
           header_column,
	   h_value,
	   value_column,
	   h_value ));
  END LOOP;

  query := format('SELECT %I %s FROM (select *,row_number() over() as rn from (%s) AS _c) as _d GROUP BY %I order by min(rn)',
           left_column,
	   headers_clause,
	   central_query,
	   left_column);

  -- open the cursor so the caller can FETCH right away
  OPEN curs FOR execute query;
  RETURN curs;
END 
$$ LANGUAGE plpgsql;

SELECT dynamic_pivot(
       'SELECT city,year,SUM(raindays) 
          FROM rainfall GROUP BY city,year
          ORDER BY 1',
       'SELECT DISTINCT year FROM rainfall ORDER BY 1'
     ) AS cur
     

SELECT dynamic_pivot('select c.id, 1 as "produto", co.concat
from cesta c, item_cesta ic, itemprodutocesta i, produto p,
			  (select c.id, p.nome, i.quantidade,concat(p.id,i.quantidade)
			  from cesta c, item_cesta ic, itemprodutocesta i, produto p
			  where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id ) co
where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id and co.id=c.id
group by c.id, co.concat order by 1,2 ','select distinct concat(co.concat,'') from (select c.id, p.nome, i.quantidade,concat(p.id,i.quantidade)
			  from cesta c, item_cesta ic, itemprodutocesta i, produto p
			  where c.id = ic.cesta_id and ic.item_id = i.id and p.id=i.produto_id ) co order by 1') AS cur

			  
			  select * from usuario where right(telefone,4)='8000';
			 
			  select p.id,p.status,p.datapedido,u.id,u.nome from pedido p, cesta c, usuario u  where p.cesta_id=c.id and c.cliente_id=u.id order by datapedido desc;
			  
			 insert into loja_usuario values('d6039d8c-b495-4af8-86c0-4aee9c5b5d49', '200');
			 
			
			select * from pedido p ;
			
		select * from usuario u where u.nome like '%alice%'
		
select u.nome, u.telefone, p.datapedido, p.status, left(p.id, 8) as "Pedido", l.razaosocial as "Loja"
from pedido p, usuario u, cesta c, distribuicao_alerta da, alerta a, loja l 
where c.cliente_id= u.id and p.cesta_id = c.id and p.id=a.pedido_id and a.id=da.alerta_id and da.loja_id =l.id
and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969' and p.status = 'ENTREGUE'
and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.email !='matheuslimabranco@outlook.com' and u.email != 'matheuslimabranco@mail.com'
and u.email != 'CLIENTE_EXCLUIDO' and u.email !='usuarioteste123@gmail.com' and lower(u.nome) not like '%derick bezerra%'
and u.telefone != '24999063796' and u.telefone != '21999526957'
and u.telefone !='21999536969' and lower(u.nome) not like '%user test%' and lower(u.nome) not like '%teste%'
and u.nome!='ERIKA GUARNIERI VENTURA RIBEIRO DOS SANTOS'
and u.nome!='Ronaldo Santana prod' and u.nome!='JJJJ' and u.nome!='Elizier Sabino dos Santos Junior'
and u.nome!='guilherme' and u.nome!='teste' and u.nome!='Usuario Teste 123'
--and extract(day from (now()-p.datapedido)) <=3
group by u.nome, u.telefone,p.datapedido, p.status, p.id, l.razaosocial,l.nomefantasia 
order by datapedido desc;

select * from pedido p 
select p.id, u.nome from pedido p, usuario u, cesta c where coalesce(p.cesta_alterada_id,p.cesta_id)=c.id
and u.id=c.cliente_id and u.telefone != '24999063796' and u.telefone != '21999526957' and u.telefone !='21999536969'


(select   pedido.status as "Status", count(pedido.id) as "Contagem", (CAST(pedido.datapedido AS DATE)) as "Data",
concat((EXTRACT(MONTH FROM pedido.datapedido)),'/',(EXTRACT(YEAR FROM pedido.datapedido))) "Mês",
RANK() Over(ORDER BY pedido.datapedido DESC) AS "id"
from pedido
where 1=1
group by pedido.status, (CAST(pedido.datapedido AS DATE)), concat((EXTRACT(MONTH FROM pedido.datapedido)),'/',(EXTRACT(YEAR FROM pedido.datapedido)))
order by (CAST(pedido.datapedido AS DATE)))

union all

(select 'Total', count(pedido.id) as "Contagem", (CAST(pedido.datapedido AS DATE)) as "Data",
concat((EXTRACT(MONTH FROM pedido.datapedido)),'/',(EXTRACT(YEAR FROM pedido.datapedido))) "Mês",
RANK() Over(ORDER BY pedido.datapedido DESC) AS "id"
from pedido
where 1=1
group by (CAST(pedido.datapedido AS DATE)), concat((EXTRACT(MONTH FROM pedido.datapedido)),'/',(EXTRACT(YEAR FROM pedido.datapedido))));

select p.id, p.datapedido from pedido p where p.status='REJEITADO' order by p.datapedido asc

----------------------------------------------------------------------------------------------------------------------------------


select UPPER(u.nome), u.email, u.senha, l.apelido, u.telefone
from usuario u, loja l,loja_usuario lu
where u.id=lu.usuario_id and lu.loja_id=l.id
group by u.nome, l.apelido ,u.telefone,u.email, u.senha, u.id
order by u.id asc;












