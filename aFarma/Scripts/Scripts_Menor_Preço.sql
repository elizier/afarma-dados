--Padrão cálculo distância

  select * from  
		(  
		select l.nomeFantasia, l.raioEntrega, l.id,  l.apelido, 
			( 
			6378.137 *  
			acos( 
			cos(radians(round(:latitude,4))) * cos(radians(le.lat)) *  
			cos(radians(le.lng) - radians(round(:longitude,4)) ) +  
			sin(radians(round(:latitude,4))) * sin(radians(le.lat))  
			) 
		) as distance  
		from afarma.loja  l  
		inner join afarma.endereco le on l.endereco_id = le.id where l.active = true  
	) td  
	where td.distance <= td.raioEntrega 

--Menor preço dentro dos requisitos
select
CASE
    WHEN d.id = n.id THEN  n.id
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.id
    ELSE n.id
    end as id,
CASE
    WHEN d.id = n.id THEN  n.Loja
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.Loja
    ELSE n.Loja
    end as Loja,
CASE
    WHEN d.id = n.id THEN  n.precoean1
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.precoean1
    ELSE n.precoean1
    end as precoean1,
CASE
    WHEN d.id = n.id THEN  n.quantidadeean1
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.quantidadeean1
    ELSE n.quantidadeean1
    end as quantidadeean1,
CASE
    WHEN d.id = n.id THEN  n.descontoean1
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.descontoean1
    ELSE n.descontoean1
    end as descontoean1,
CASE
    WHEN d.id = n.id THEN  n.precoean2
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.precoean2
    ELSE n.precoean2
    end as precoean2,
CASE
    WHEN d.id = n.id THEN  n.quantidadeean2
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.quantidadeean2
    ELSE n.quantidadeean2
    end as quantidadeean2,
CASE
    WHEN d.id = n.id THEN  n.descontoean2
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.descontoean2
    ELSE n.descontoean2
    end as descontoean2,
CASE
    WHEN d.id = n.id THEN  n.precoean3
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.precoean3
    ELSE n.precoean3
    end as precoean3,
CASE
    WHEN d.id = n.id THEN  n.quantidadeean3
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.quantidadeean3
    ELSE n.quantidadeean3
    end as quantidadeean3,
CASE
    WHEN d.id = n.id THEN  n.descontoean3
    WHEN n.valortotalcesta > d.valortotalcesta THEN d.descontoean3
    ELSE n.descontoean3
    end as descontoean3,
CASE
    WHEN d.id = n.id THEN  n.valortotalcesta
    WHEN n.valortotalcesta > d.valortotalcesta THEN (n.valortotalcesta-0.01)
    ELSE n.valortotalcesta
    end as MelhorValorPossivel
    into temp table Teste
from
(select l.id,l.nomefantasia as "loja",
x.preco as "precoean1", 3 as "quantidadeean1", x.percentualdesconto as "descontoean1",
y.preco as "precoean2", 2 as "quantidadeean2", y.percentualdesconto as "descontoean2",
z.preco as "precoean3", 7 as "quantidadeean3", z.percentualdesconto as "descontoean3",
(((x.preco*((100-x.percentualdesconto)/100))*3.00)+((y.preco*((100-y.percentualdesconto)/100))*2.00)+((z.preco*((100-z.percentualdesconto)/100))*7.00)) as "valortotalcesta",
distance
from
(select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
 where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true
 and p.ean = '007898133131400') x,
 (select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
 where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true
 and p.ean = '008435137735150') y,
 (select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
 where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true
 and p.ean = '007899014622987') z,
 ( 
	select l.nomefantasia, l.id as lojaId,
		(6378.137 * 
		acos(
				cos(radians(round(-22.8590880078906,4))) * cos(radians(le.lat)) * 
				cos(radians(le.lng) - radians(round(-43.10141016541225,4)))+
				sin(radians(round(-22.8590880078906,4))) * sin(radians(le.lat)) 
			)
		) as "distance"
	from cadastro.loja l 
	inner join cadastro.endereco as le on l.endereco_id = le.id where l.active = true 
) as tabela_distancia,
 cadastro.loja l, venda.produto p, venda.produto_loja o
 where l.id = o.loja_id and o.ean = p.ean and z.cnpj = l.cnpj and x.cnpj = l.cnpj and y.cnpj = l.cnpj and distance <= 10000 and tabela_distancia.lojaId=l.id 
 group by l.id, l.nomefantasia, x.preco, y.preco, z.preco, x.percentualdesconto, y.percentualdesconto, z.percentualdesconto, distance
 order by valortotalcesta asc, l.guelta desc, distance asc
 limit 1) d,

(select l.id, l.nomefantasia as "loja",
a.preco as "precoean1", 3 as "quantidadeean1", a.percentualdesconto as "descontoean1",
b.preco as "precoean2", 2 as "quantidadeean2", b.percentualdesconto as "descontoean2",
c.preco as "precoean3", 7 as "quantidadeean3", c.percentualdesconto as "descontoean3",
(((a.preco*((100-a.percentualdesconto)/100))*3.00)+((b.preco*((100-b.percentualdesconto)/100))*2.00)+((c.preco*((100-c.percentualdesconto)/100))*7.00)) as "valortotalcesta",
distance
from
(
 select l.cnpj, o.preco, 0 as "percentualdesconto" from cadastro.loja l, venda.produto p, venda.produto_loja o 
 where l.id = o.loja_id and o.ean = p.ean and l.active=true and o.active = true
and p.ean = '007898133131400'
) a,
 (
 select l.cnpj, o.preco, 0 as "percentualdesconto" from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active=true and o.active = true
and p.ean = '008435137735150'
) b,
 (
 select l.cnpj, o.preco, 0 as "percentualdesconto" from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active=true and o.active = true
and p.ean = '007899014622987'
) c,
( 
	select l.nomefantasia, l.id as lojaId,
		(6378.137 * 
		acos(
				cos(radians(round(-22.8590880078906,4))) * cos(radians(le.lat)) * 
				cos(radians(le.lng) - radians(round(-43.10141016541225,4)))+
				sin(radians(round(-22.8590880078906,4))) * sin(radians(le.lat)) 
			)
		) as "distance"
	from cadastro.loja l 
	inner join cadastro.endereco as le on l.endereco_id = le.id where l.active = true 
) as tabela_distancia,
 cadastro.loja l, venda.produto p, venda.produto_loja o
 where l.id = o.loja_id and o.ean = p.ean and c.cnpj = l.cnpj and a.cnpj = l.cnpj and b.cnpj = l.cnpj and distance <= 10000 and tabela_distancia.lojaId=l.id 
 group by l.id, l.nomefantasia, a.preco, b.preco, c.preco, a.percentualdesconto, b.percentualdesconto, c.percentualdesconto, distance
 order by valortotalcesta asc, l.guelta desc, distance asc
  limit 1) n
;

select * from Teste;

--Menores 3 preços Sem desconto
 
select l.id, l.nomefantasia as "loja",
a.preco as "precoean1", 3 as "quantidadeean1", a.percentualdesconto as "descontoean1",
b.preco as "precoean2", 2 as "quantidadeean2", b.percentualdesconto as "descontoean2",
c.preco as "precoean3", 7 as "quantidadeean3", c.percentualdesconto as "descontoean3",
(((a.preco*((100-a.percentualdesconto)/100))*3.00)+((b.preco*((100-b.percentualdesconto)/100))*2.00)+((c.preco*((100-c.percentualdesconto)/100))*7.00)) as "valortotalcesta",
distance
from
(
 select l.cnpj, o.preco, 0 as "percentualdesconto" from cadastro.loja l, venda.produto p, venda.produto_loja o 
 where l.id = o.loja_id and o.ean = p.ean and l.active=true and o.active = true
and p.ean = '007898133131400'
) a,
 (
 select l.cnpj, o.preco, 0 as "percentualdesconto" from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active=true and o.active = true
and p.ean = '008435137735150'
) b,
 (
 select l.cnpj, o.preco, 0 as "percentualdesconto" from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active=true and o.active = true
and p.ean = '007899014622987'
) c,
( 
	select l.nomefantasia, l.id as lojaId,
		(6378.137 * 
		acos(
				cos(radians(round(-22.8590880078906,4))) * cos(radians(le.lat)) * 
				cos(radians(le.lng) - radians(round(-43.10141016541225,4)))+
				sin(radians(round(-22.8590880078906,4))) * sin(radians(le.lat)) 
			)
		) as "distance"
	from cadastro.loja l 
	inner join cadastro.endereco as le on l.endereco_id = le.id where l.active = true 
) as tabela_distancia,
 cadastro.loja l, venda.produto p, venda.produto_loja o
 where l.id = o.loja_id and o.ean = p.ean and c.cnpj = l.cnpj and a.cnpj = l.cnpj and b.cnpj = l.cnpj and distance <= 10000 and tabela_distancia.lojaId=l.id 
 group by l.id, l.nomefantasia, a.preco, b.preco, c.preco, a.percentualdesconto, b.percentualdesconto, c.percentualdesconto, distance
 order by valortotalcesta asc, l.guelta desc, distance asc
  limit 3;
  
 -- Menores 3 preços com desconto

 select l.id,l.nomefantasia as "loja",
x.preco as "precoean1", 3 as "quantidadeean1", x.percentualdesconto as "descontoean1",
y.preco as "precoean2", 2 as "quantidadeean2", y.percentualdesconto as "descontoean2",
z.preco as "precoean3", 7 as "quantidadeean3", z.percentualdesconto as "descontoean3",
(((x.preco*((100-x.percentualdesconto)/100))*3.00)+((y.preco*((100-y.percentualdesconto)/100))*2.00)+((z.preco*((100-z.percentualdesconto)/100))*7.00)) as "valortotalcesta",
distance
into temp table Teste
from
(select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
 where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true
 and p.ean = '007898133131400') x,
 (select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
 where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true
 and p.ean = '008435137735150') y,
 (select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
 where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true
 and p.ean = '007899014622987') z,
 ( 
	select l.nomefantasia, l.id as lojaId,
		(6378.137 * 
		acos(
				cos(radians(round(-22.8590880078906,4))) * cos(radians(le.lat)) * 
				cos(radians(le.lng) - radians(round(-43.10141016541225,4)))+
				sin(radians(round(-22.8590880078906,4))) * sin(radians(le.lat)) 
			)
		) as "distance"
	from cadastro.loja l 
	inner join cadastro.endereco as le on l.endereco_id = le.id where l.active = true 
) as tabela_distancia,
 cadastro.loja l, venda.produto p, venda.produto_loja o
 where l.id = o.loja_id and o.ean = p.ean and z.cnpj = l.cnpj and x.cnpj = l.cnpj and y.cnpj = l.cnpj and distance <= 10000 and tabela_distancia.lojaId=l.id 
 group by l.id, l.nomefantasia, x.preco, y.preco, z.preco, x.percentualdesconto, y.percentualdesconto, z.percentualdesconto, distance
 order by valortotalcesta asc, l.guelta desc, distance asc
 limit 3;

select * from Teste;

---------------------------------------------------------------------------------------------------------
select * from ((select c.concorrente as "Loja",
a.nome, :ean1 as "Ean 1",:quantidade1 as "Quantidade 1", a.valor,
e.nome, :ean2 as "Ean 2",:quantidade2 as "Quantidade 2", e.valor,
i.nome, :ean3 as "Ean 3",:quantidade3 as "Quantidade 3", i.valor,
round(cast((:quantidade1*a.valor+:quantidade2*e.valor+:quantidade3*i.valor) as numeric),2) as "total"
from concorrente c,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from produtoconcorrente pc, produtocrawler p, concorrente c
where c.id=pc.concorrente_id and pc.produto_id=p.id and p.ean=:ean1 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from produtoconcorrente pc, produtocrawler p, concorrente c
where c.id=pc.concorrente_id and pc.produto_id=p.id and p.ean=:ean2 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) e,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from produtoconcorrente pc, produtocrawler p, concorrente c
where c.id=pc.concorrente_id and pc.produto_id=p.id and p.ean=:ean3 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) i
where a.concorrente=c.concorrente and e.concorrente=c.concorrente and i.concorrente=c.concorrente)

union all

(select 'aFarma', 
'-', :ean1 as "Ean 1",:quantidade1 as "Quantidade 1", '0',
'-', :ean2 as "Ean 2",:quantidade2 as "Quantidade 2", '0',
'-', :ean3 as "Ean 3",:quantidade3 as "Quantidade 3", '0',
round(cast((min(m.total)-0.01) as numeric),2) from 
(select c.concorrente,
a.nome, :ean1 as "Ean 1",:quantidade1 as "Quantidade 1", a.valor,
e.nome, :ean2 as "Ean 2",:quantidade2 as "Quantidade 2", e.valor,
i.nome, :ean3 as "Ean 3",:quantidade3 as "Quantidade 3", i.valor,
(:quantidade1*a.valor+:quantidade2*e.valor+:quantidade3*i.valor) as "total"
from concorrente c,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from produtoconcorrente pc, produtocrawler p, concorrente c
where c.id=pc.concorrente_id and pc.produto_id=p.id and p.ean=:ean1 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from produtoconcorrente pc, produtocrawler p, concorrente c
where c.id=pc.concorrente_id and pc.produto_id=p.id and p.ean=:ean2 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) e,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from produtoconcorrente pc, produtocrawler p, concorrente c
where c.id=pc.concorrente_id and pc.produto_id=p.id and p.ean=:ean3 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) i
where a.concorrente=c.concorrente and e.concorrente=c.concorrente and i.concorrente=c.concorrente) m)) x
order by x.total desc;

select a.implementation, avg(a.price) from (select p.implementation, p.ean, p.price from
(select p.ean, count(p.ean) from public.product p
group by p.ean
having count(p.ean)=3) c, public.product p where c.ean=p.ean) a
group by a.implementation;
