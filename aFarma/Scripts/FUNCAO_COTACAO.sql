DROP TYPE afarma.ctitemdetalhado;

CREATE TYPE afarma.ctitemdetalhado AS (
	id varchar,
	nome varchar,
	concorrente varchar,
	cotacao_id varchar,
	ean varchar,
	quantidade integer,
	valor numeric (10,5),
	total numeric (10,5));


CREATE OR REPLACE FUNCTION afarma.cotacaodetalhado(cotid varchar)
 RETURNS SETOF afarma.ctitemdetalhado
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.ctitemdetalhado%ROWTYPE;
BEGIN

 	FOR itens in
			
	SELECT uuid_generate_v4(), i.*
	from 
	(select (case when po.nome isnull then gr.nome_grupo else po.nome end) as nome
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
	
			
			--------
			
		/* 
       
		   
 		--calculando o valor
		(case when mp.valor = 0 then mp.precomedio 
			when min(mp.valor) < ((select p.valor from afarma.produtoconcorrente p where p.ean=item.ean ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(percentual as double precision))/100)) then precomedio 
			else mp.valor end) as "valor",  
		(
		--calculando o preço médio
		((case 
			when mp.valor = 0 then mp.precomedio 
			when min(mp.valor)<((select p.valor from afarma.produtoconcorrente p where p.ean = item.ean ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(percentual as double precision))/100)) then precomedio 
			else mp.valor end) * item.quantidade )) as "precomedio" 
		from afarma.produtoconcorrente p
			
		( select 
			mp.*, 
			p.precomedio as "precomedio",
			d.nome as "nome" from  
				(select  d.concorrente as "loja",
				(select p.nome from afarma.produto p where p.ean = item.ean) as "nome",
				p.ean as "ean", 
				p.quantidade as "quantidade", 
				(case when a.valor isnull then 0 else a.valor end) as "valor" from  afarma.concorrente d,  
				
				(select c.concorrente, a.* from afarma.concorrente c )
				left join 
				(select a.concorrente as "loja", a.nome as "nome", item.ean as "ean", item.quantidade as "quantidade", a.valor as "valor", 
				round(cast((item.quantidade * a.valor) as numeric),2) as "total" ) 
				0 as total,
				(select c.concorrente as "loja", p.nome as "nome", p.ean as "ean", p.marca_id, p.descricao, pc.valor 
				from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
				where 
				c.id = pc.concorrente_id and 
				pc.ean = p.ean and  
				p.ean = (
					case when (select p.grupo_id from afarma.produto p where p.ean = item.ean) = (select d.id from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome = 'NÃO IDENTIFICADO') then item.ean 
						 when (select afarma.menor_preco_grupo(item.ean)) isnull then item.ean 
						 else (select afarma.menor_preco_grupo(item.ean)) end) and 
				(c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO') a  ) a on a.loja = c.concorrente) a  
								where a.concorrente = d.concorrente ) mp
								left join afarma.produto p  on p.ean = mp.ean 
								left join afarma.dominio d  on d.id = p.grupo_id)) mp 
								group by mp.concorrente, mp.nome, mp.ean, mp.quantidade, mp.valor, mp.precomedio, mp.grupo
 
		*/
		loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;
