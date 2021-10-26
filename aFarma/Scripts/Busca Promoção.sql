--Listando Produtos dentro do raio 

 select p.id, p.nome, p.ean, p.descricao, p.categoria_id,
 p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao, p.indicacao, p.precomedio 
 from  
	( 
	select id from  
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
	order by distance asc 
) l,  
afarma.promocao pc, afarma.produto p 
where l.id=pc.loja_id and pc.produto_id =p.id and now() between pc.datainicial and pc.datafinal
group by p.id, p.nome, p.ean, p.descricao, p.categoria_id,
 p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao, p.indicacao, p.precomedio 

 
 -- Id da loja que vai vender a promoção, adquirido após a escolha do primeiro produto 

 
 	select pc.loja_id, count (distinct(pc.produto_id)), l.distance 
	from  
	( 
		select distinct(pc.loja_id), l.distance 
		from afarma.promocao pc,  
		( 
			select td.id, td.distance from  
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
			order by distance asc 
		) l 
		where 
		pc.produto_id=:produtoId and 
		l.id=pc.loja_id  
	) l, afarma.promocao pc 
	where pc.loja_id=l.loja_id and now() between pc.datainicial and pc.datafinal 
	group by pc.loja_id, l.distance 
	order by count (distinct(pc.produto_id)) desc, l.distance asc 
	--limit 1 

 
 
 -- Listagem de produtos em promoção no raio, vendidos por uma determinada loja, após botar um produto na cesta 

 select p.id, p.nome, p.ean, p.descricao, p.categoria_id,
 p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao, p.indicacao, p.precomedio from 
( 
	select pc.loja_id, count (distinct(pc.produto_id)), l.distance 
	from  
	( 
		select distinct(pc.loja_id), l.distance 
		from afarma.promocao pc,  
		( 
			select td.id, td.distance from  
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
			order by distance asc 
		) l 
		where pc.produto_id=:produtoId and l.id=pc.loja_id  
	) l, afarma.promocao pc 
	where pc.loja_id=l.loja_id 
	group by pc.loja_id, l.distance 
	order by count (distinct(pc.produto_id)) desc, l.distance asc 
	limit 1 
) l, afarma.promocao pc, afarma.produto p  
where l.loja_id=pc.loja_id and pc.produto_id=p.id and now() between pc.datainicial and pc.datafinal 



select p.id, p.nome, p.ean, p.descricao, p.categoria_id,

 p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao, p.indicacao, p.precomedio, pc.loja_id as lojaPromocao 

 from ( 

	select id from (  

		select l.nomeFantasia, l.raioEntrega, l.id,  l.apelido, 

			( 

			6378.137 *  

			acos( 

			cos(radians(round(:latitude,4))) * cos(radians(le.lat)) *  

			cos(radians(le.lng) - radians(round(:longitude,4)) ) +  

			sin(radians(round(:latitude,4))) * sin(radians(le.lat))  ) ) as distance  

		from afarma.loja  l  

		inner join afarma.endereco le on l.endereco_id = le.id where l.active = true ) td  

	where td.distance <= td.raioEntrega 

	order by distance asc ) as j,  

 afarma.promocao pc, afarma.produto p 

 where j.id=pc.loja_id and pc.produto_id =p.id and now() between pc.datainicial and pc.datafinal 

 group by p.id, p.nome, p.ean, p.descricao, p.categoria_id,

 p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao, p.indicacao, p.precomedio, pc.loja_id 
 
 
 
 
 -------------------------------------------------------------------
 
  select p.id, p.nome, p.ean, p.descricao, p.categoria_id, p.marca_id, p.photo_id, p.departamento_id, p.principioativo_id, p.grupo_id, p.contraindicacao, p.indicacao, p.precomedio, pc.loja_id as lojaPromocao from 

( 

	select pc.loja_id, count (distinct(pc.produto_id)), l.distance 

	from  

	( 

		select distinct(pc.loja_id), l.distance 

		from afarma.promocao pc,  

		( 

			select td.id, td.distance from  

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

			order by distance asc 

		) l 

		where pc.loja_id=:loja_id and l.id=pc.loja_id  

	) l, afarma.promocao pc 

	where pc.loja_id=l.loja_id and pc.loja_id=:loja_id

	group by pc.loja_id, l.distance 

	order by count (distinct(pc.produto_id)) desc, l.distance asc 

	limit 1 

) l, afarma.promocao pc, afarma.produto p  

where l.loja_id=pc.loja_id and pc.produto_id=p.id and now() between pc.datainicial and pc.datafinal  

select l.*, e.* from afarma.loja l, afarma.endereco e
where e.id=l.endereco_id ;



