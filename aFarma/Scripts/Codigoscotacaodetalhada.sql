select cotacaoiai('8e8b92ae-e4b7-49db-91a3-d9c2c216fdff')
select cotacaodetalhado('8e8b92ae-e4b7-49db-91a3-d9c2c216fdff')
('7896422506229',
'7896422506229',
'7896422506229',
'7896004715841',
'7896004715841',
'7896714201177',
'7896181909705',
'7891058001865')

[5:20 PM, 12/08/2021] Matheus Branco: select r.* from pg_stat_activity r where r.backend_type='client backend'
order by r.query_start asc;
[5:23 PM, 12/08/2021] Matheus Branco: select pg_cancel_backend(id);

select afarma.menor_preco_grupo_crawler('7896714234434')



select
(case when
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = '7896714234434')
and gr.ean=pc.ean and pc.valor!=0
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) isnull then 
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = '7896714234434')
and gr.ean=pc.ean and pc.valor!=0
group by gr.ean 
order by precomedio asc
limit 1) p )
else 
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = '7896714234434')
and gr.ean=pc.ean and pc.valor!=0
group by gr.ean 
order by precomedio desc
limit 2) p
offset 1) end)






---------------------------------------------


		
	SELECT uuid_generate_v4()
	,i.*
FROM (
	SELECT (
			CASE 
				WHEN po.nome isnull
					THEN gr.nome_grupo
				ELSE po.nome
				END
			) AS nome
		,i.*
	FROM (
		(
			SELECT i.*
				,(i.valor * i.quantidade) AS total
			FROM (
				SELECT (
						CASE 
							WHEN i.valor = i.valorminimo
								THEN CONCAT (
										i.concorrente
										,'*'
										)
							ELSE i.concorrente
							END
						) AS concorrente
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
						,m.valorminimo
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
											AND ce.uf = (
												SELECT r.uf
												FROM afarma.registrocotacao r
												WHERE r.id = :id
												)
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
												WHERE i.cotacao = :id
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
					LEFT JOIN (
						SELECT i.cotacao
							,i.ean
							,min(i.valor) AS valorminimo
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
													AND ce.uf = (
														SELECT r.uf
														FROM afarma.registrocotacao r
														WHERE r.id = :id
														)
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
														WHERE i.cotacao = :id
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
						) m ON m.ean = i.ean
					) i
				) i
			)
		
		UNION ALL
		
		(
			SELECT i.*
				,(i.precomedio * i.quantidade)
			FROM (
				SELECT 'aFarma' AS loja
					,i.cotacao
					,i.ean
					,i.quantidade
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
								AND ce.uf = (
									SELECT r.uf
									FROM afarma.registrocotacao r
									WHERE r.id = :id
									)
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
									WHERE i.cotacao = :id
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
			GROUP BY i.loja
				,i.cotacao
				,i.ean
				,i.quantidade
				,i.precomedio
			)
		) i
	LEFT JOIN (
		SELECT max(po.nome) AS nome
			,po.ean
		FROM PUBLIC.produtos_all_otimizado_ilpi_rj po
		GROUP BY po.ean
		) po ON po.ean = i.ean
	LEFT JOIN PUBLIC.genericos_ref gr ON gr.ean = i.ean
	) i
GROUP BY i.nome
	,i.concorrente
	,i.cotacao
	,i.ean
	,i.quantidade
	,i.valor
	,i.total