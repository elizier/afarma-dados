	



CREATE OR REPLACE FUNCTION afarma.cotacaoiaidetalhadodesconto(cotid character varying, descontoitem double precision)
 RETURNS SETOF afarma.ctitemdetalhado
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.ctitemdetalhado%ROWTYPE;
BEGIN

 	FOR itens in


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
					,i.url
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
									,pc.valor, pc.url
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
												WHERE r.id = cotid
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
														WHERE r.id = cotid
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
						GROUP BY i.cotacao
							,i.ean
						) m ON m.ean = i.ean
					) i
				) i
			)
		
		UNION ALL
		
		(
			SELECT i.*
				,((i.precomedio-(descontoitem)) * i.quantidade)
			FROM (
				SELECT 'aFarma' AS loja
					,i.cotacao
					,i.ean
					,i.quantidade
					, 'https://www.afarma.app.br' as url
					,po.precomedio
				FROM (
					SELECT i.*
						,pc.valor, pc.url
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
									WHERE r.id = cotid
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
			GROUP BY i.loja
				,i.cotacao
				,i.ean
				,i.quantidade
				,i.url
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
	,i.url
	,i.valor
	,i.total
	
		loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;



select afarma.cotacaoiaidetalhadodesconto(:cotid, 0.01);









--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

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
					,i.url
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
									,pc.valor, pc.url
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
												WHERE r.id = :cotid
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
														WHERE r.id = :cotid
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
					, 'https://www.afarma.app.br' as url
					,po.precomedio
				FROM (
					SELECT i.*
						,pc.valor, pc.url
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
									WHERE r.id = :cotid
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
			GROUP BY i.loja
				,i.cotacao
				,i.ean
				,i.quantidade
				,i.url
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
	,i.url
	,i.valor
	,i.total
	