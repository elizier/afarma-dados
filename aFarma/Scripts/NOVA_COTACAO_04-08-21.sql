-- Cotação menor preço

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
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = :id)
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
			) i
		GROUP BY i.concorrente
			,i.cotacao
		)
	
	UNION ALL
	
	(
		SELECT 'aFarma'
			,i.cotacao
			,((min(i.totalporloja) - (coalesce(:desconto, 0))) * ((100 - (cast(coalesce(:percentual, 0) AS FLOAT))) / (100)))
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
											AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = :id)
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
				) i
			GROUP BY i.concorrente
				,i.cotacao
			) i
		GROUP BY i.cotacao
		)
	) i
	
	
-- Cotação item a item
	
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
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = :id)
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
				,min(i.quantidade * i.valor) AS total
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
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = :id)
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
			) i
		GROUP BY i.cotacao
		)
	) i
	
	-- Cesta detalhada
	
	SELECT uuid_generate_v4(), i.*
	from 
	(select (case when po.nome isnull then gr.nome_grupo else po.nome end) as nome
	,i.*
FROM (
	(
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
	left join public.genericos_ref gr 
	on gr.ean = i.ean) i group by i.nome, i.concorrente, i.cotacao, i.ean, i.quantidade, i.valor, i.total
	
	
	
	
	----
	SELECT uuid_generate_v4()
	,po.nome
	,i.concorrente,
	i.cotacao,
	i.ean,
	i.quantidade,
	i.valor,
	i.total
FROM (
	(
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