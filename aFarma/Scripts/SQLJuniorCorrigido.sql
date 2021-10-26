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
	WHEN d.id = n.id THEN  n.precoProduto_ean1 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.precoProduto_ean1 
	ELSE n.precoProduto_ean1 
	end as precoProduto_ean1, 
CASE 
	WHEN d.id = n.id THEN  n.qtde_ean1 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.qtde_ean1 
	ELSE n.qtde_ean1 
	end as quantidade_ean1, 
CASE 
	WHEN d.id = n.id THEN  n.percentualdesconto_ean1 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.percentualdesconto_ean1 
	ELSE n.percentualdesconto_ean1 
	end as desconto_ean1, 
CASE 
	WHEN d.id = n.id THEN  n.precoProduto_ean2 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.precoProduto_ean2 
	ELSE n.precoProduto_ean2 
	end as precoProduto_ean2, 
CASE 
	WHEN d.id = n.id THEN  n.qtde_ean2 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.qtde_ean2 
	ELSE n.qtde_ean2 
	end as quantidade_ean2, 
CASE 
	WHEN d.id = n.id THEN  n.percentualdesconto_ean2 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.percentualdesconto_ean2 
	ELSE n.percentualdesconto_ean2 
	end as desconto_ean2, 
CASE 
	WHEN d.id = n.id THEN  n.precoProduto_ean3 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.precoProduto_ean3 
	ELSE n.precoProduto_ean3 
	end as precoProduto_ean3, 
CASE 
	WHEN d.id = n.id THEN  n.qtde_ean3 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.qtde_ean3 
	ELSE n.qtde_ean3 
	end as quantidade_ean3, 
CASE 
	WHEN d.id = n.id THEN  n.percentualdesconto_ean3 
	WHEN n.valortotalcesta > d.valortotalcesta THEN d.percentualdesconto_ean3 
	ELSE n.percentualdesconto_ean3 
	end as desconto_ean3, 
CASE 
	WHEN d.id = n.id THEN  n.valortotalcesta 
	WHEN n.valortotalcesta > d.valortotalcesta THEN (n.valortotalcesta-0.01) 
	ELSE n.valortotalcesta 
	end as MelhorValorPossivel 
	into temp table tempTable_pedido_id
from 
(select l.id,l.nomefantasia as "loja", 
select_ean1.preco as precoProduto_ean1, 3 as qtde_ean1, select_ean1.percentualdesconto as percentualdesconto_ean1,
select_ean2.preco as precoProduto_ean2, 2 as qtde_ean2, select_ean2.percentualdesconto as percentualdesconto_ean2,
select_ean3.preco as precoProduto_ean3, 7 as qtde_ean3, select_ean3.percentualdesconto as percentualdesconto_ean3,
( (( select_ean1.preco * ((100-select_ean1.percentualdesconto)/100)) * 3) + (( select_ean2.preco * ((100-select_ean2.percentualdesconto)/100)) * 2) + (( select_ean3.preco * ((100-select_ean3.percentualdesconto)/100)) * 7) ) as "valortotalcesta", 
 distance 
 from 
(select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true and p.ean = '007898133131400') as select_ean1, 
(select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true and p.ean = '008435137735150') as select_ean2, 
(select l.cnpj, o.preco, o.percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active = true and l.guelta = true and o.active = true and p.ean = '007899014622987') as select_ean3, 
( 
		select l.nomefantasia, l.id as lojaId, 
			(6378.137 *  
			acos( 
					cos(radians(round(-22.85908800789059824865034897811710834503173828125,4))) * cos(radians(le.lat)) * 
					cos(radians(le.lng) - radians(round(-43.1014101654122470108632114715874195098876953125,4)))+ 
					sin(radians(round(-22.85908800789059824865034897811710834503173828125,4))) * sin(radians(le.lat))  
				) 
			) as "distance" 
		from cadastro.loja l  
		inner join cadastro.endereco as le on l.endereco_id = le.id where l.active = true 
	) as tabela_distancia, 
cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean 
and select_ean1.cnpj = l.cnpj 
and select_ean2.cnpj = l.cnpj 
and select_ean3.cnpj = l.cnpj 

and distance <= 10000  and tabela_distancia.lojaId=l.id 
group by l.id, l.nomefantasia, 
select_ean1.preco, select_ean1.percentualdesconto, 
select_ean2.preco, select_ean2.percentualdesconto, 
select_ean3.preco, select_ean3.percentualdesconto, 
distance 
order by valortotalcesta asc, l.guelta desc, distance asc 
limit 1 ) d,
(select l.id,l.nomefantasia as "loja", 
select_ean1_0.preco as precoProduto_ean1, 3 as qtde_ean1, select_ean1_0.percentualdesconto as percentualdesconto_ean1,
select_ean2_1.preco as precoProduto_ean2, 2 as qtde_ean2, select_ean2_1.percentualdesconto as percentualdesconto_ean2,
select_ean3_2.preco as precoProduto_ean3, 7 as qtde_ean3, select_ean3_2.percentualdesconto as percentualdesconto_ean3,
( (( select_ean1_0.preco * ((100-select_ean1_0.percentualdesconto)/100)) * 3) + (( select_ean2_1.preco * ((100-select_ean2_1.percentualdesconto)/100)) * 2) + (( select_ean3_2.preco * ((100-select_ean3_2.percentualdesconto)/100)) * 7) ) as "valortotalcesta", 
 distance
 from 
(select l.cnpj, o.preco, 0 as percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active = true and o.active = true and p.ean = '007898133131400') select_ean1_0, 
(select l.cnpj, o.preco, 0 as percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active = true and o.active = true and p.ean = '008435137735150') select_ean2_1, 
(select l.cnpj, o.preco, 0 as percentualdesconto from cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean and l.active = true and o.active = true and p.ean = '007899014622987') select_ean3_2, 
( 
		select l.nomefantasia, l.id as lojaId, 
			(6378.137 *  
			acos( 
					cos(radians(round(-22.85908800789059824865034897811710834503173828125,4))) * cos(radians(le.lat)) * 
					cos(radians(le.lng) - radians(round(-43.1014101654122470108632114715874195098876953125,4)))+ 
					sin(radians(round(-22.85908800789059824865034897811710834503173828125,4))) * sin(radians(le.lat))  
				) 
			) as "distance" 
		from cadastro.loja l  
		inner join cadastro.endereco as le on l.endereco_id = le.id where l.active = true 
	) as tabela_distancia, 
cadastro.loja l, venda.produto p, venda.produto_loja o 
where l.id = o.loja_id and o.ean = p.ean 
and select_ean1_0.cnpj = l.cnpj 
and select_ean2_1.cnpj = l.cnpj 
and select_ean3_2.cnpj = l.cnpj 

and distance <= 10000  and tabela_distancia.lojaId=l.id 
group by l.id, l.nomefantasia, 
select_ean1_0.preco, select_ean1_0.percentualdesconto, 
select_ean2_1.preco, select_ean2_1.percentualdesconto, 
select_ean3_2.preco, select_ean3_2.percentualdesconto, 
distance 
order by valortotalcesta asc, l.guelta desc, distance asc 
limit 1) n
;

select * from tempTable_pedido_id;