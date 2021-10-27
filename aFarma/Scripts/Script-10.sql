
select p.max as "nome", p.ean, de.descricao, 
(case when ca.categoria_id isnull then 
(select d.id from dominio d where d.nome = 'N√O IDENTIFICADO' and d.tipo_id = (select t.id from tipodominio t where t.nome = 'CATEGORIA'))
else ca.categoria_id end),
(case when ma.marca_id isnull then 
(select d.id from dominio d where d.nome = 'N√O IDENTIFICADO' and d.tipo_id = (select t.id from tipodominio t where t.nome = 'MARCA'))
else ma.marca_id end) ,
(case when ph.photo_id isnull then 
'01873bab-49a3-42c6-a69c-5deb235ed38d'
else ph.photo_id end),
(case when dp.departamento_id isnull then 
(select d.id from dominio d where d.nome = 'N√O IDENTIFICADO' and d.tipo_id = (select t.id from tipodominio t where t.nome = 'DEPARTAMENTO'))
else dp.departamento_id end), 
(case when pa.id isnull then 
(select d.id from dominio d where d.nome = 'N√O IDENTIFICADO' and d.tipo_id = (select t.id from tipodominio t where t.nome = 'PRINCIPIO ATIVO'))
else pa.id end) as "principioativo_id",
(case when gr.grupo_id isnull then 
(select d.id from dominio d where d.nome = 'N√O IDENTIFICADO' and d.tipo_id = (select t.id from tipodominio t where t.nome = 'GRUPO'))
else gr.grupo_id end) , 
(case when ci.max isnull then 
'N√O POSSUI'
else ci.max end) as "contraindicacao", 
(case when ic.max isnull then 
'N√O POSSUI'
else ic.max end) as "indicacao", 
(case when vm.avg isnull then 
'0'
else vm.avg end) as "precomedio"
from 
((select max(gr.name), gr.ean from public.genericos_ref gr
group by gr.ean)
union all
(select max(pr.name), pr.ean from  public.product_ref pr
group by pr.ean)) p
left join
--principioativo
((select r.nome, r.ean, 
 max( case when dm.id isnull then (select d.id from afarma.dominio d where d.nome='N√O IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='PRINCIPIO ATIVO')) else dm.id end) as id
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.product_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produtocrawler p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome
group by r.nome, r.ean)
union all
(select r.nome, r.ean, 
 max( case when dm.id isnull then (select d.id from afarma.dominio d where d.nome='N√O IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='PRINCIPIO ATIVO')) else dm.id end) as id
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produtocrawler p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome
group by r.nome, r.ean)) pa
on p.ean = pa.ean
left join 
--departamento
((select pr.name, pr.ean, max(dm.id) as "departamento_id"
from public.product_ref pr, afarma.dominio dm, afarma.tipodominio t, afarma.produtocrawler p, afarma.departamento de
where pr.ean=p.ean and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
and pr.ean!='DIVERSOS' 
group by pr, name, pr.ean)
union all 
(select x.max, x.ean, max(dm.id) from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x, 
afarma.dominio dm, afarma.tipodominio t, afarma.produtocrawler p, afarma.departamento de
where translate (UPPER(x.max),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=Upper(p.nome) 
and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
group by x.max, x.ean)) dp
on dp.ean = p.ean
left join
--categoria
((select pr.name, pr.ean, d.id as "categoria_id"
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.category=d.nome and t.nome='CATEGORIA' and t.id=d.tipo_id and pr.ean!='DIVERSOS')
union all
(select  x.max, x.ean, d.id from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d, public.product_ref pr, public.generico_grupo gg
where x.max=gr.name and pr.grupo= cast(gg.grupo as varchar) and gg.grupo=gr.grupo and gg.nome=pr.name
and unaccent(upper(pr.category)) = d.nome and d.tipo_id=t.id and t.nome='CATEGORIA'
group by x.max, x.ean, d.id)) ca
on p.ean = ca.ean
left join
--descricao
((select pr.name, pr.ean, pr.description as "descricao" 
from public.product_ref pr
where pr.ean!='DIVERSOS'
group by pr.name, pr.ean, pr.description)
union all 
(select max(gr.name), gr.ean, 'GENERICO' as "descricao"
from public.genericos_ref gr
group by gr.ean
order by max(gr.name) asc)) de
on p.ean = de.ean
left join
--marca
((select pr.name, pr.ean, d.id as "marca_id"
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.brand=d.nome and t.nome='MARCA' and t.id=d.tipo_id and pr.ean!='DIVERSOS')
union all
(select x.max, x.ean, max(d.id) 
from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d
where gr.name=x.max and UPPER(gr.brand)=UPPER(d.nome) and d.tipo_id=t.id and t.nome='MARCA'
group by x.max, x.ean
order by x.max asc)) ma
on p.ean = ma.ean
left join
--grupo
((select pr.name, pr.ean, (select d.id from afarma.dominio d where d.nome='N√O IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='GRUPO')) as "grupo_id" 
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.ean!='DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, d.id 
from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x,
public.genericos_ref gr, public.generico_grupo gg, afarma.tipodominio t, afarma.dominio d, public.product_ref pr
where gg.nome= d.nome and gr.name=x.max and gr.grupo=gg.grupo and t.id=d.tipo_id and t.nome='GRUPO'
group by x.max, x.ean, d.id
order by x.max asc)) gr
on gr.ean = p.ean left join
--foto
((select pr.name, pr.ean, max(p.photo_id) as "photo_id" from afarma.produtocrawler p, public.product_ref pr 
where translate (UPPER(pr.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=p.nome and pr.ean!= 'DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, max(p.photo_id) from
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x left join afarma.produtocrawler p
on translate (UPPER(x.max),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') =p.nome
group by x.max, x.ean)) ph
on ph.ean = p.ean
left join
--valormedio&menorpreco
((select pr.name, pr.ean, (case when avg(nullif(pc.valor,0)) isnull then 0 else  avg(nullif(pc.valor,0)) end) as "avg"
from public.product_ref pr, afarma.produtoconcorrente pc
where pr.ean!='DIVERSOS' and pr.ean=pc.ean 
group by pr.name, pr.ean)
union all
(select x.max, x.ean, (case when avg(nullif(pc.valor,0)) isnull then 0 else  avg(nullif(pc.valor,0)) end) as "avg" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, public.genericos_ref gr, afarma.produtoconcorrente pc
where x.max=gr.name and gr.ean=pc.ean
group by x.max, x.ean)) vm
on p.ean = vm.ean
left join
--contraindicacao
((select pr.name, pr.ean, (case when 
max(case when LENGTH(pc.contraindicacao)<12 then 'N√O POSSUI' else pc.contraindicacao end)
isnull then 'N√O POSSUI'
else max(case when LENGTH(pc.contraindicacao)<12 then 'N√O POSSUI' else pc.contraindicacao end) end)
from afarma.produtocrawler pc, public.product_ref pr where pr.ean=pc.ean and pr.ean!='DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, 
(case when 
max(case when LENGTH(pc.contraindicacao)<12 then 'N√O POSSUI' else pc.contraindicacao end)
isnull then 'N√O POSSUI'
else max(case when LENGTH(pc.contraindicacao)<12 then 'N√O POSSUI' else pc.contraindicacao end) end)
from (select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, afarma.produtocrawler pc, public.genericos_ref gr 
where x.ean=gr.ean and  gr.ean=pc.ean
group by x.max, x.ean)) ci
on p.ean = ci.ean
left join
--indicacao
((select pr.name, pr.ean, (case when 
max(case when LENGTH(pc.indicacao)<6  then 'N√O POSSUI'
when pc.indicacao='\R\N\R\N†' then 'N√O POSSUI'
when pc.indicacao='<DIV ID=\' then 'N√O POSSUI'
when pc.indicacao='†\R\N\R\N†' then 'N√O POSSUI'
when pc.indicacao='<P STYLE=\' then 'N√O POSSUI' else pc.contraindicacao end)
isnull then 'N√O POSSUI'
else max(case when LENGTH(pc.indicacao)<12 then 'N√O POSSUI' else pc.indicacao end) end)
from afarma.produtocrawler pc, public.product_ref pr where pr.ean=pc.ean and pr.ean!='DIVERSOS'
group by pr.name, pr.ean) 
union all
(select x.max, x.ean, (case when 
max(case when LENGTH(pc.indicacao)<6  then 'N√O POSSUI'
when pc.indicacao='\R\N\R\N†' then 'N√O POSSUI'
when pc.indicacao='<DIV ID=\' then 'N√O POSSUI'
when pc.indicacao='†\R\N\R\N†' then 'N√O POSSUI'
when pc.indicacao='<P STYLE=\' then 'N√O POSSUI' else pc.contraindicacao end)
isnull then 'N√O POSSUI'
else max(case when LENGTH(pc.indicacao)<12 then 'N√O POSSUI' else pc.indicacao end) end)
from (select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, afarma.produtocrawler pc, public.genericos_ref gr 
where x.ean=gr.ean and gr.ean=pc.ean and gr.ean!='DIVERSOS'
group by x.max, x.ean)) ic
on p.ean = ic.ean
where 
p.ean in (select p.ean from (((select distinct(gr.ean) from public.genericos_ref gr
)
union all
(select distinct(pr.ean) from  public.product_ref pr where pr.grupo='N√O POSSUI'
))
except 
(select distinct(p.ean) from afarma.produto p )) p )
group by p.max, p.ean, de.descricao, ca.categoria_id, ma.marca_id, dp.departamento_id, pa.id, gr.grupo_id, ph.photo_id,
vm.avg, ci.max, ic.max
order by p.max asc



CREATE OR REPLACE FUNCTION afarma.cotacao(cotid character varying, percentual double precision, desconto double precision)
 RETURNS SETOF afarma.cotacaotitem
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.cotacaotitem%ROWTYPE;
BEGIN

 	FOR itens in

SELECT cast(uuid_generate_v4() as varchar) as id
	,i.*
FROM (
	(
		SELECT i.concorrente
			,i.cotacao as cotacao_id
			,ROUND(CAST(sum(i.total) AS numeric),2) AS total
		FROM (
			SELECT i.*
				,(i.quantidade * i.valor) AS total
			FROM (
				SELECT i.concorrente
					,i.cotacao
					,i.ean
					,i.quantidade
					,(
						CASE 
							WHEN i.valor isnull
								THEN i.precomedio
							WHEN i.valor < i.segundomenor * 0.20
								THEN i.segundomenor
							ELSE i.valor
							END
						) AS valor
				FROM (
					SELECT i.*
						,p.segundomenor
					FROM (
						SELECT i.*
							,po.precomedio
						FROM (
							SELECT i.*
								,pc.valor
							FROM (
								SELECT *
								FROM (
									SELECT c.concorrente
										,c.id AS concorrente_id
									FROM afarma.concorrentes_estados ce
										,afarma.concorrente c
									WHERE c.id = ce.concorrente_id
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = cotid)
									) c
								CROSS JOIN (
									SELECT i.cotacao
										,(
											CASE 
												WHEN i.menor isnull
													THEN i.ean
												ELSE i.menor
												END
											) AS ean
										,i.quantidade
									FROM (
										SELECT *
										FROM (
											SELECT i.ean
												,i.cotacao
												,i.quantidade
											FROM afarma.itenscot i
											WHERE i.cotacao = cotid
											) i
										CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
										) i
									) i
								) i
							LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
								AND pc.concorrente_id = i.concorrente_id
							) i
						LEFT JOIN (
							SELECT pc.ean
								,avg(nullif(pc.valor, 0)) AS precomedio
							FROM afarma.produtoconcorrente pc
							GROUP BY pc.ean
							) po ON po.ean = i.ean
						) i
					LEFT JOIN (
						SELECT p.ean
							,min(p.valor) AS segundomenor
						FROM (
							SELECT pc.ean
								,pc.valor
								,p.min
							FROM afarma.produtoconcorrente pc
							LEFT JOIN (
								SELECT pc.ean
									,min(pc.valor)
								FROM afarma.produtoconcorrente pc
								GROUP BY pc.ean
								) p ON pc.ean = p.ean
							) p
						WHERE p.valor > p.min
						GROUP BY p.ean
						) p ON p.ean = i.ean
					) i
				) i
			) i
		GROUP BY i.concorrente
			,i.cotacao
		)
	
	UNION ALL
	
	(
		SELECT 'aFarma'
			,i.cotacao
			,((min(i.totalporloja) - (coalesce(desconto, 0))) * ((100 - (cast(coalesce(percentual, 0) AS FLOAT))) / (100)))
		FROM (
			SELECT i.concorrente
				,i.cotacao
				,sum(i.total) AS totalporloja
			FROM (
				SELECT i.*
					,(i.quantidade * i.valor) AS total
				FROM (
					SELECT i.concorrente
						,i.cotacao
						,i.ean
						,i.quantidade
						,(
							CASE 
								WHEN i.valor isnull
									THEN i.precomedio
								WHEN i.valor < i.segundomenor * 0.20
									THEN i.segundomenor
								ELSE i.valor
								END
							) AS valor
					FROM (
						SELECT i.*
							,p.segundomenor
						FROM (
							SELECT i.*
								,po.precomedio
							FROM (
								SELECT i.*
									,pc.valor
								FROM (
									SELECT *
									FROM (
										SELECT c.concorrente
											,c.id AS concorrente_id
										FROM afarma.concorrentes_estados ce
											,afarma.concorrente c
										WHERE c.id = ce.concorrente_id
											AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = cotid)
										) c
									CROSS JOIN (
										SELECT i.cotacao
											,(
												CASE 
													WHEN i.menor isnull
														THEN i.ean
													ELSE i.menor
													END
												) AS ean
											,i.quantidade
										FROM (
											SELECT *
											FROM (
												SELECT i.ean
													,i.cotacao
													,i.quantidade
												FROM afarma.itenscot i
												WHERE i.cotacao = cotid
												) i
											CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
											) i
										) i
									) i
								LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
									AND pc.concorrente_id = i.concorrente_id
								) i
							LEFT JOIN (
								SELECT pc.ean
									,avg(nullif(pc.valor, 0)) AS precomedio
								FROM afarma.produtoconcorrente pc
								GROUP BY pc.ean
								) po ON po.ean = i.ean
							) i
						LEFT JOIN (
							SELECT p.ean
								,min(p.valor) AS segundomenor
							FROM (
								SELECT pc.ean
									,pc.valor
									,p.min
								FROM afarma.produtoconcorrente pc
								LEFT JOIN (
									SELECT pc.ean
										,min(pc.valor)
									FROM afarma.produtoconcorrente pc
									GROUP BY pc.ean
									) p ON pc.ean = p.ean
								) p
							WHERE p.valor > p.min
							GROUP BY p.ean
							) p ON p.ean = i.ean
						) i
					) i
				) i
			GROUP BY i.concorrente
				,i.cotacao
			) i
		GROUP BY i.cotacao
		)
	) i
	
	
		loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;





83e6d83d-47b3-46b1-b0c2-abae624e5149