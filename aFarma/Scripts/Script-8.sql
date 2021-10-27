select pg_cancel_backend(11450);


select * from pg_stat_activity r
order by r.query_start asc;

select r.* from pg_stat_activity r where r.backend_type='client backend'
order by r.query_start asc;

select * from pg_stat_activity

select * from log_statement_stats

SELECT * FROM pg_stat_activity WHERE wait_event IS NOT NULL AND backend_type = 'client backend';




delete from afarma.produtoconcorrente where id in
(select pc.id from 
(
select pc.* from (
select pc.* from
(
select p.ean, p.concorrente, p.valor, count(concat(p.ean,p.concorrente)) from afarma.produtoconcorrente p
group by p.ean, p.concorrente, p.valor 
having count(concat(p.ean,p.concorrente)) >1
) pc, public.product p 
where pc.ean = p.ean and pc.concorrente = p.implementation
and p.price = pc.valor) p , afarma.produtoconcorrente pc
where 
pc.ean = p.ean and pc.concorrente = p.concorrente
and p.valor = pc.valor and pc.id not in
(
select pc.id from (
select max(id) as id, pc.ean from (
select pc.* from (
select pc.* from
(
select p.ean, p.concorrente, p.valor from afarma.produtoconcorrente p
group by p.ean, p.concorrente, p.valor 
having count(concat(p.ean,p.concorrente)) >1
) pc, public.product p 
where pc.ean = p.ean and pc.concorrente = p.implementation
and p.price = pc.valor) p , afarma.produtoconcorrente pc
where 
pc.ean = p.ean and pc.concorrente = p.concorrente
and p.valor = pc.valor) pc
group by pc.ean) pc) ) pc
) --pc




insert into afarma.produtoconcorrente
select uuid_generate_v4(), p.dataatualizacao, p.ean, p.url, p.valor, p.concorrente_id, p.produto_id, p.concorrente
from (
select max(p.produto_id) as produto_id, p.nome, p.ean, p.concorrente, p.valor, p.concorrente_id, p.url, p.dataatualizacao
from (
select
pc.*, c.id as concorrente_id, p.url, p.updated_date as dataatualizacao, pr.id as produto_id
from
(
select max(pc.nome) as nome, pc.ean, pc.implementation as concorrente, pc.price as valor from
(select max(p.length),  p.ean, p.implementation, p.price 
from 
(
select p.*, LENGTH(p.nome) from
(
select  pc.nome, p.ean, p.implementation, p.price from
afarma.produtocrawler pc
left join 
(
select p.ean, p.implementation, p.price from public.product p
except
select pc.ean, pc.concorrente, pc.valor from afarma.produtoconcorrente pc) p
on pc.ean = p.ean) p
where p.ean notnull
) p
group by  p.ean, p.implementation, p.price ) p,
(
select p.*, LENGTH(p.nome) from
(
select  pc.nome, p.ean, p.implementation, p.price from
afarma.produtocrawler pc
left join 
(
select p.ean, p.implementation, p.price from public.product p
except
select pc.ean, pc.concorrente, pc.valor from afarma.produtoconcorrente pc) p
on pc.ean = p.ean) p
where p.ean notnull
) pc
where pc.length=p.max and pc.ean=p.ean and pc.implementation=p.implementation
group by pc.ean, pc.implementation, pc.price) pc , afarma.concorrente c, public.product p, afarma.produtocrawler pr
where pc.ean = p.ean and pc.concorrente = p.implementation and pc.concorrente = c.concorrente
and pc.concorrente != 'DROGASIL' and pr.nome=pc.nome) p
group by p.nome, p.ean, p.concorrente, p.valor, p.concorrente_id, p.url, p.dataatualizacao) p;





select
(case when
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select gr.grupo from genericos_ref gr where gr.ean='7898569763534')
and gr.ean=pc.ean
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) isnull then '7898569763534'
else 
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select gr.grupo from genericos_ref gr where gr.ean='7898569763534')
and gr.ean=pc.ean
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) end)




CREATE OR REPLACE FUNCTION afarma.menor_preco_grupo(ean_generico character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   generico_ean varchar;
begin
	
	select
(case when
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = ean_generico)
and gr.ean=pc.ean
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) isnull then 
(select ean_generico)
else 
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = ean_generico)
and gr.ean=pc.ean
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) end)

into generico_ean;
   
   return generico_ean;
end;
$function$
;



select afarma.menor_preco_grupo_crawler('7897595610096');
select afarma.menor_preco_grupo_crawler('7896112110347');
select afarma.menor_preco_grupo_crawler('7898148301287');
select afarma.menor_preco_grupo_crawler_teste('7899547504842');
select afarma.menor_preco_grupo_crawler_teste('7898148290772');
select afarma.menor_preco_grupo_crawler_teste('7896714234434');
select afarma.menor_preco_grupo_crawler_teste('7898148290512');
select afarma.menor_preco_grupo_crawler_teste('7896714213309');
select afarma.menor_preco_grupo_crawler_teste('7896422519304');
select afarma.menor_preco_grupo_crawler_teste('8902220108141');
select afarma.menor_preco_grupo_crawler_teste('7896422519366');
select afarma.menor_preco_grupo_crawler_teste('7897076913463');
select afarma.menor_preco_grupo_crawler_teste('8902220114906');
select afarma.menor_preco_grupo_crawler_teste('7899547512731');
select afarma.menor_preco_grupo_crawler_teste('7896714225753');
select afarma.menor_preco_grupo_crawler_teste('7896422522670');
select afarma.menor_preco_grupo_crawler_teste('7897076912183');
select afarma.menor_preco_grupo_crawler_teste('7896004708959');
select afarma.menor_preco_grupo_crawler_teste('7896004723365');
select afarma.menor_preco_grupo_crawler_teste('7898216371181');
select afarma.menor_preco_grupo_crawler_teste('7896714234564');
select afarma.menor_preco_grupo_crawler_teste('7898148297269');
select afarma.menor_preco_grupo_crawler_teste('7896422522670');
select afarma.menor_preco_grupo_crawler_teste('7898148296729');
select afarma.menor_preco_grupo_crawler_teste('7898148301720');
select afarma.menor_preco_grupo_crawler_teste('7898216367467');
select afarma.menor_preco_grupo_crawler_teste('7896714228853');
select afarma.menor_preco_grupo_crawler_teste('7896422517843');
select afarma.menor_preco_grupo_crawler_teste('7897595606280');
select afarma.menor_preco_grupo_crawler_teste('65985');
select afarma.menor_preco_grupo_crawler_teste('7898569763534');
select afarma.menor_preco_grupo_crawler_teste('7899095243866');
select afarma.menor_preco_grupo_crawler_teste('7898569760458');
select afarma.menor_preco_grupo_crawler_teste('7898216366309');
select afarma.menor_preco_grupo_crawler_teste('7897595632623');
select afarma.menor_preco_grupo_crawler_teste('7898148299010');



CREATE OR REPLACE FUNCTION afarma.menor_preco_grupo_crawler_antigo(ean_generico character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   generico_ean varchar;
begin
	select (
	case 
	when
	(select p.ean 
	from public.genericos_ref gr,
	(select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p
	where p.ean=gr.ean and gr.grupo=(select gr.grupo from public.genericos_ref gr
	where gr.ean=ean_generico limit 1) and p.precomedio notnull
	order by p.precomedio asc
	limit 1
	offset 1) isnull 
	then 
	(select p.ean 
	from public.genericos_ref gr,
	(select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p
	where p.ean=gr.ean and gr.grupo=(select gr.grupo from public.genericos_ref gr
	where gr.ean=ean_generico limit 1) and p.precomedio notnull
	order by p.precomedio asc
	limit 1)
	else
	(select p.ean 
	from public.genericos_ref gr,
	(select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p
	where p.ean=gr.ean and gr.grupo=(select gr.grupo from public.genericos_ref gr
	where gr.ean=ean_generico limit 1) and p.precomedio notnull
	order by p.precomedio asc
	limit 1
	offset 1)
	end
	)
	into generico_ean
   ;
   
   return generico_ean;
end;
$function$
;



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

DROP TYPE afarma.ctitemdetalhado;

CREATE TYPE afarma.ctitemdetalhado AS (
	id varchar,
	nome varchar,
	concorrente varchar,
	cotacao_id varchar,
	ean varchar,
	quantidade int4,
	url varchar,
	valor numeric(10,5),
	total numeric(10,5));
	

CREATE OR REPLACE FUNCTION afarma.cotacaodetalhado(cotid character varying)
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

	
	
CREATE OR REPLACE FUNCTION afarma.cotacaodetalhadoiai(cotid character varying)
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
	LEFT JOIN PUBLIC.genericos_ref gr ON gr.ean = i.ean
	) i
GROUP BY i.nome
	,i.concorrente
	,i.cotacao
	,i.ean
	,i.quantidade
	,i.valor
	,i.total
	
			
			
		loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;









select afarma.cotacaodetalhado('85740b01-29f4-4074-9174-9900ff6f838b')





