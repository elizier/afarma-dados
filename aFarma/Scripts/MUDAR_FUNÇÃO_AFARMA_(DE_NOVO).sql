
CREATE OR REPLACE FUNCTION afarma.cotacaoiaidesconto(cotid character varying, descontoitem double precision)
 RETURNS SETOF afarma.ctitem
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.ctitem%ROWTYPE;
BEGIN

 	FOR itens in


SELECT uuid_generate_v4()
	,i.*
FROM (
	(
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
							WHEN i.valor < i.segundomenor * 0.80
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
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = :cotid)
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
											WHERE i.cotacao = :cotid
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
			,sum(i.total) AS totalporloja
		FROM (
			SELECT i.cotacao
				,i.ean
				,min(i.quantidade * (i.valor-(:descontoitem))) AS total
			FROM (
				SELECT i.concorrente
					,i.cotacao
					,i.ean
					,i.quantidade
					,(
						CASE 
							WHEN i.valor isnull
								THEN i.precomedio
							WHEN i.valor < i.segundomenor * 0.80
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
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = :cotid)
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
											WHERE i.cotacao = :cotid
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
			GROUP BY i.cotacao
				,i.ean
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
	
SELECT afarma.cotacaoiaidesconto(:cotid, 10)
	
-- 2228f00c-c429-4949-a80b-aadf23996268
	
	
	

	
	
	
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@







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
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = :cotid)
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
											WHERE i.cotacao = :cotid
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
						
						
						
						
						
(select uuid_generate_v4() as id, 
mp.concorrente as loja,  
(case when mp.grupo_0 isnull then mp.nome_0 else mp.grupo_0 end) as a0nome_0, 
 mp.ean_0 as ean_0, mp.quantidade_0 as qtde_0, 
(case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7898148297269' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) as "a0valor_0",  
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7898148297269' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_0" , cast(gr.nome_grupo as varchar) as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7898148297269') as "nome_0", (case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7898148297269' and p.ean=gr.ean limit 1) isnull then '7898148297269' when (select afarma.menor_preco_grupo_crawler('7898148297269')) isnull then '7898148297269' else (select afarma.menor_preco_grupo_crawler('7898148297269')) end) as "ean_0", 1 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", a0.ean as "ean_0", 1 as "quantidade_0", a0.valor as "valor_0", 
round(cast((1 * a0.valor) as numeric),2) 
from  
(select c.concorrente, 
(case when pc.ean in (select distinct(gr.ean) from public.genericos_ref gr)  
then (select gr.nome_grupo from public.genericos_ref gr where gr.ean=(select afarma.menor_preco_grupo_crawler('7898148297269')) limit 1) 
else p.nome end), 
p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produtocrawler p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
pc.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7898148297269' and p.ean=gr.ean limit 1) isnull then '7898148297269' 
when (select afarma.menor_preco_grupo_crawler('7898148297269')) isnull then '7898148297269' 
else (select afarma.menor_preco_grupo_crawler('7898148297269')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a0  ) a0 
on a0.loja = c.concorrente) a0 where 
a0.concorrente = d.concorrente 
) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_0 
left join public.genericos_ref gr 
 on gr.ean=p.ean) mp 
group by mp.concorrente, 
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0) 
 
 
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 
CREATE OR REPLACE FUNCTION afarma.detalhecotitem(ean_cot character varying, quantidade double precision)
RETURNS afarma.itemjson
 LANGUAGE plpgsql
AS $function$
declare
   itemcotdetalhe afarma.itemjson;
begin
     
BEGIN
 	
select (
SELECT uuid_generate_v4() AS id
	,row_to_json(i.*) as data
FROM (
	SELECT ean_cot AS ean
		,array_agg(i.data) AS data
	FROM (
		SELECT row_to_json(i.*) AS data
		FROM (
			SELECT i.*
			FROM (
				SELECT i.*
					,p.segundomenor
				FROM (
					SELECT i.*
						,po.precomedio
					FROM (
						SELECT i.*
							,nullif(pc.valor,0 ) as valor
							,pc.url
						FROM (
							SELECT *
							FROM (
								SELECT c.concorrente as loja
									,c.id AS concorrente_id
								FROM afarma.concorrentes_estados ce
									,afarma.concorrente c
								WHERE c.id = ce.concorrente_id
								) c
							CROSS JOIN (
								SELECT i.cotacao
									,(
										CASE 
											WHEN i.ean isnull
												THEN ean_cot
											ELSE i.ean
											END
										) AS ean
									,i.quantidade
								FROM (
									SELECT afarma.menor_preco_grupo_crawler(ean_cot) AS ean
										,(
											SELECT uuid_generate_v4()
											) AS cotacao
										,quantidade AS quantidade
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
	) i
	)
 
into itemcotdetalhe;
		
return itemcotdetalhe;

end;

$function$

;
 



CREATE OR REPLACE FUNCTION afarma.detalhecotitem(ean_cot character varying, quantidade double precision)
 RETURNS SETOF afarma.itemjson
 LANGUAGE plpgsql
AS $function$
declare
   generico_ean afarma.itemjson%ROWTYPE;
begin
	
CREATE OR REPLACE FUNCTION afarma.detalhecotitem(ean_cot character varying, quantidade double precision)
 RETURNS SETOF afarma.itemjson
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.itemjson%ROWTYPE;
BEGIN

 	FOR itens in
	
	select (
SELECT uuid_generate_v4() AS id
	,row_to_json(i.*) as data
FROM (
	SELECT ean_cot AS ean
		,array_agg(i.data) AS data
	FROM (
		SELECT row_to_json(i.*) AS data
		FROM (
			SELECT i.*
			FROM (
				SELECT i.*
					,p.segundomenor
				FROM (
					SELECT i.*
						,po.precomedio
					FROM (
						SELECT i.*
							,nullif(pc.valor,0 ) as valor
							,pc.url
						FROM (
							SELECT *
							FROM (
								SELECT c.concorrente as loja
									,c.id AS concorrente_id
								FROM afarma.concorrentes_estados ce
									,afarma.concorrente c
								WHERE c.id = ce.concorrente_id
								) c
							CROSS JOIN (
								SELECT i.cotacao
									,(
										CASE 
											WHEN i.ean isnull
												THEN ean_cot
											ELSE i.ean
											END
										) AS ean
									,i.quantidade
								FROM (
									SELECT afarma.menor_preco_grupo_crawler(ean_cot) AS ean
										,(
											SELECT uuid_generate_v4()
											) AS cotacao
										,quantidade AS quantidade
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
	) i
	)

loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


CREATE OR REPLACE FUNCTION afarma.detalhecotitem(ean_cot character varying, quantidade double precision)
 RETURNS SETOF  afarma.itemjson
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t afarma.itemjson%ROWTYPE;
BEGIN

 	FOR resource_t in


SELECT uuid_generate_v4() AS id
	,row_to_json(i.*) as data
FROM (
	SELECT ean_cot AS ean
		,array_agg(i.data) AS data
	FROM (
		SELECT row_to_json(i.*) AS data
		FROM (
			SELECT i.*
			FROM (
				SELECT i.*
					,p.segundomenor
				FROM (
					SELECT i.*
						,po.precomedio
					FROM (
						SELECT i.*
							,nullif(pc.valor,0 ) as valor
							,pc.url
						FROM (
							SELECT *
							FROM (
								SELECT c.concorrente as loja
									,c.id AS concorrente_id
								FROM afarma.concorrentes_estados ce
									,afarma.concorrente c
								WHERE c.id = ce.concorrente_id
								) c
							CROSS JOIN (
								SELECT i.cotacao
									,(
										CASE 
											WHEN i.ean isnull
												THEN ean_cot
											ELSE i.ean
											END
										) AS ean
									,i.quantidade
								FROM (
									SELECT afarma.menor_preco_grupo_crawler(ean_cot) AS ean
										,(
											SELECT uuid_generate_v4()
											) AS cotacao
										,quantidade AS quantidade
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
	) i


 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


select afarma.detalhecotitem(:ean_cot, :quantidade)

select p.* from afarma.produtoconcorrente p,
(select p.ean, count(p.ean) from afarma.produtoconcorrente p where p.ean in (select distinct(r.ean) from public.ean_ref r)
group by p.ean
order by count desc) a
where p.ean = a.ean and a.count = 3
and p.dataatualizacao between  TO_TIMESTAMP(
    '2021-09-01',
    'YYYY-MM-DD'
) and now()

