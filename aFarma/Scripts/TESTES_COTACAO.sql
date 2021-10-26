select pg_cancel_backend(18071);

8546
8553
10418
10419
8552
8548

select r.* from pg_stat_activity r where r.backend_type='client backend'
order by r.query_start asc;

select afarma.cotacao('A',10,20)

-- Selecionar itens genérico na VIEW que possuem valor em todas as lojas (selecionado: 7896181927839 )
select * from public.produtos_all_otimizado_ilpi_rj po where po.ean in
(select pc.ean--, count(pc.ean)
from afarma.produtoconcorrente pc
where pc.ean in (select distinct(gr.ean) from genericos_ref gr where gr.ean notnull)
group by pc.ean
having count(pc.ean)=3)

--Selecionar itens na VIEW que possuem valor em todas as lojas (selecionado: 7896641800313)  7500435144384
select * from public.produtos_all_otimizado_ilpi_rj po where po.ean in
(select pc.ean--, count(pc.ean)
from afarma.produtoconcorrente pc
where pc.ean not in (select distinct(gr.ean) from genericos_ref gr where gr.ean notnull)
group by pc.ean
having count(pc.ean)=3)

-- Selecionar itens genérico na VIEW que possuem valor em uma loja (selecionado: 7899547531251)
select * from public.produtos_all_otimizado_ilpi_rj po where po.ean in
(select pc.ean--, count(pc.ean)
from afarma.produtoconcorrente pc
where pc.ean in (select distinct(gr.ean) from genericos_ref gr where gr.ean notnull)
group by pc.ean
having count(pc.ean)=1)

--Selecionar itens na VIEW que possuem valor em uma loja (selecionado: 7896012880180)
select * from public.produtos_all_otimizado_ilpi_rj po where po.ean in
(select pc.ean--, count(pc.ean)
from afarma.produtoconcorrente pc
where pc.ean not in (select distinct(gr.ean) from genericos_ref gr where gr.ean notnull)
group by pc.ean
having count(pc.ean)=1)


insert into afarma.itenscot values ('D', '7898148298587', 20), ('D', '7500435144384', 10),
('D', '7899547531251', 5), ('D', '7896012880180', 1);

select i.*, m.avg from
select ce.concorrente_id, i.* from afarma.concorrentes_estados ce cross join
(SELECT 
			uuid_generate_v4() as "id", 
			pc.concorrente_id,
			p.nome as "nome",
			item.quantidade as "quantidade", 
			pc.valor as "valor"
		FROM 
			afarma.produtoconcorrente pc,
			afarma.produto p,
			afarma.dominio d
		where 
			pc.ean = item.ean and
			p.ean = item.ean
		group by p.nome ,  valor, pc.concorrente_id ) i
		on i.concorrente_id=ce.concorrente_id 
		left join 
		(select pc.ean, avg(nullif(pc.valor,0)) from afarma.produtoconcorrente pc group by pc.ean) m
		on m.ean = i.ean
		 insert into 
		
		 
		 select uuid_generate_v4(), i.* from
		(
		 (
		 select  i.concorrente, i.cotacao, sum(i.total) as totalporloja from 
		 (
		 select i.*, (i.quantidade*i.valor) as total from 
		(
		select i.concorrente, i.cotacao, i.ean, i.quantidade,
		(case when i.valor isnull then i.precomedio 
		when i.valor<i.segundomenor*0.20 then i.segundomenor
		else i.valor end) as valor
		from (
		select i.*, p.segundomenor from 
		(
		select i.*, po.precomedio from
		(
		select i.*, pc.valor from 
		(
		select * from
		(
		select c.concorrente, c.id as concorrente_id
		from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and  ce.uf = :uf 
		) c
		cross join
		(select i.cotacao, (case when i.menor isnull then i.ean else i.menor end) as ean, i.quantidade from
		(select * from
		(select i.ean, i.cotacao, i.quantidade from afarma.itenscot i where i.cotacao = :id
		) i
		CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) as menor
		) i
		) i
		) i
		left join 
		afarma.produtoconcorrente pc
		on pc.ean = i.ean and pc.concorrente_id=i.concorrente_id
		) i
		left join 
		(
		select pc.ean, avg(nullif(pc.valor,0)) as precomedio from afarma.produtoconcorrente pc group by pc.ean
		) po 
		on po.ean = i.ean
		) i 
		left join
		(
		select p.ean, min(p.valor) as segundomenor  from 
		(
		select pc.ean, pc.valor, p.min
		from afarma.produtoconcorrente pc
		left join 
		(
		select pc.ean, min(pc.valor) from afarma.produtoconcorrente pc group by pc.ean
		) p
		on pc.ean=p.ean
		) p 
		where p.valor>p.min
		group by p.ean
		) p
		on p.ean=i.ean
		) i
		) i
		) i 
		group by i.concorrente, i.cotacao
		)
		union all
		(
		 select  'aFarma', i.cotacao, sum(i.total) as totalporloja from 
		 (
		 select i.cotacao, i.ean, min(i.quantidade*i.valor) as total from 
		(
		select i.concorrente, i.cotacao, i.ean, i.quantidade,
		(case when i.valor isnull then i.precomedio 
		when i.valor<i.segundomenor*0.20 then i.segundomenor
		else i.valor end) as valor
		from (
		select i.*, p.segundomenor from 
		(
		select i.*, po.precomedio from
		(
		select i.*, pc.valor from 
		(
		select * from
		(
		select c.concorrente, c.id as concorrente_id
		from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and  ce.uf = :uf 
		) c
		cross join
		(select i.cotacao, (case when i.menor isnull then i.ean else i.menor end) as ean, i.quantidade from
		(select * from
		(select i.ean, i.cotacao, i.quantidade from afarma.itenscot i where i.cotacao = :id
		) i
		CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) as menor
		) i
		) i
		) i
		left join 
		afarma.produtoconcorrente pc
		on pc.ean = i.ean and pc.concorrente_id=i.concorrente_id
		) i
		left join 
		(
		select pc.ean, avg(nullif(pc.valor,0)) as precomedio from afarma.produtoconcorrente pc group by pc.ean
		) po 
		on po.ean = i.ean
		) i 
		left join
		(
		select p.ean, min(p.valor) as segundomenor  from 
		(
		select pc.ean, pc.valor, p.min
		from afarma.produtoconcorrente pc
		left join 
		(
		select pc.ean, min(pc.valor) from afarma.produtoconcorrente pc group by pc.ean
		) p
		on pc.ean=p.ean
		) p 
		where p.valor>p.min
		group by p.ean
		) p
		on p.ean=i.ean
		) i
		) i group by  i.cotacao, i.ean
		) i 
		group by  i.cotacao
		)
		) i
		
		select ((100-(cast(coalesce(:percentual,0) as float)))/(100))
		
		
		
		
		
		
		select p.* from 
		(select pc.ean, pc.valor, p.segundomenor from afarma.produtoconcorrente pc
		left join 
		(select p.ean, min(p.valor) as segundomenor  from (
		select pc.ean, pc.valor, p.min
		from afarma.produtoconcorrente pc
		left join 
		(select pc.ean, min(pc.valor) from afarma.produtoconcorrente pc group by pc.ean) p
		on pc.ean=p.ean) p where p.valor>p.min
		group by p.ean) p 
		on pc.ean=p.ean) p, public.produtos_all_otimizado_ilpi_rj po where p.valor<0.20*p.segundomenor and po.ean = p.ean
		
		
		select afarma.menor_preco_grupo_crawler((select i.ean from afarma.itenscot i where i.cotacao='D'))
		
		update afarma.itenscot set ean='7896641800313' where id='a33dd078-46b5-45a7-9f80-5e93ee33ec9c'
		
		
		
		
		------------------------VAMO Trabalhar
		
		SELECT *
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
					AND ce.uf = :uf
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
				FROM (
					SELECT *
					FROM (
						SELECT i.ean
							,i.cotacao
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
	
	
	update afarma.itenscot set cotacao = '4554960c-c224-4c97-96a4-da619fdd69d9' where cotacao = 'D'
	insert into afarma.registrocotacao values ('ab6bab94-ae31-4e8d-8fec-1f0bb10c3c36', 'teste1', '', now()),
('4840b206-5a52-4f89-839e-5bb486888a38', 'teste2', '', now()),
('9fd34f70-11c1-4c24-b5de-3ddd1af9c38d', 'teste3', '', now()),
('4554960c-c224-4c97-96a4-da619fdd69d9', 'teste4', '', now())





select uuid_generate_v4(), i.* from
		(
		 (
		 select  'aFarma', i.cotacao, sum(i.total) as totalporloja from 
		 (
		 select i.cotacao, i.ean, min(i.quantidade*i.valor) as total from 
		(
		select i.concorrente, i.cotacao, i.ean, i.quantidade,
		(case when i.valor isnull then i.precomedio 
		when i.valor<i.segundomenor*0.20 then i.segundomenor
		else i.valor end) as valor
		from (
		select i.*, p.segundomenor from 
		(
		select i.*, po.precomedio from
		(
		select i.*, pc.valor from 
		(
		select * from
		(
		select c.concorrente, c.id as concorrente_id
		from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and  ce.uf = :uf 
		) c
		cross join
		(select i.cotacao, (case when i.menor isnull then i.ean else i.menor end) as ean, i.quantidade from
		(select * from
		(select i.ean, i.cotacao, i.quantidade from afarma.itenscot i where i.cotacao = :id
		) i
		CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) as menor
		) i
		) i
		) i
		left join 
		afarma.produtoconcorrente pc
		on pc.ean = i.ean and pc.concorrente_id=i.concorrente_id
		) i
		left join 
		(
		select pc.ean, avg(nullif(pc.valor,0)) as precomedio from afarma.produtoconcorrente pc group by pc.ean
		) po 
		on po.ean = i.ean
		) i 
		left join
		(
		select p.ean, min(p.valor) as segundomenor  from 
		(
		select pc.ean, pc.valor, p.min
		from afarma.produtoconcorrente pc
		left join 
		(
		select pc.ean, min(pc.valor) from afarma.produtoconcorrente pc group by pc.ean
		) p
		on pc.ean=p.ean
		) p 
		where p.valor>p.min
		group by p.ean
		) p
		on p.ean=i.ean
		) i
		) i group by  i.cotacao, i.ean
		) i 
		group by  i.cotacao
		)
		union all
		(
		select 'aFarma', i.cotacao, ((min(i.totalporloja) - (coalesce(:desconto,0)))*((100-(cast(coalesce(:percentual,0) as float)))/(100))) from
		(
		select i.concorrente, i.cotacao, sum(i.total) as totalporloja from 
		 (
		 select i.*, (i.quantidade*i.valor) as total from 
		(
		select i.concorrente, i.cotacao, i.ean, i.quantidade,
		(case when i.valor isnull then i.precomedio 
		when i.valor<i.segundomenor*0.20 then i.segundomenor
		else i.valor end) as valor
		from (
		select i.*, p.segundomenor from 
		(
		select i.*, po.precomedio from
		(
		select i.*, pc.valor from 
		(
		select * from
		(
		select c.concorrente, c.id as concorrente_id
		from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and  ce.uf = :uf 
		) c
		cross join
		(select i.cotacao, (case when i.menor isnull then i.ean else i.menor end) as ean, i.quantidade from
		(select * from
		(select i.ean, i.cotacao, i.quantidade from afarma.itenscot i where i.cotacao = :id
		) i
		CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) as menor
		) i
		) i
		) i
		left join 
		afarma.produtoconcorrente pc
		on pc.ean = i.ean and pc.concorrente_id=i.concorrente_id
		) i
		left join 
		(
		select pc.ean, avg(nullif(pc.valor,0)) as precomedio from afarma.produtoconcorrente pc group by pc.ean
		) po 
		on po.ean = i.ean
		) i 
		left join
		(
		select p.ean, min(p.valor) as segundomenor  from 
		(
		select pc.ean, pc.valor, p.min
		from afarma.produtoconcorrente pc
		left join 
		(
		select pc.ean, min(pc.valor) from afarma.produtoconcorrente pc group by pc.ean
		) p
		on pc.ean=p.ean
		) p 
		where p.valor>p.min
		group by p.ean
		) p
		on p.ean=i.ean
		) i
		) i
		) i 
		group by i.concorrente, i.cotacao
		) i group by i.cotacao 
		)
		) i
		
		update afarma.registrocotacao set uf='RJ'
		
		select afarma.cotacao('1d725448-91f1-4cca-9827-6666aef82696',0,1)
		
		select afarma.cotacaoiai('1d725448-91f1-4cca-9827-6666aef82696')
		
		select afarma.cotacaodetalhado('f9d9f89e-b430-451e-939d-3e2a75cccb80')
		
		insert into afarma.itenscot values ('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7896082900351','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7899026401747','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7891040005819','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7891142205100','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7891010248772','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7891350016000','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','748945121205','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7897975695545','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7896016802874','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7896422504133','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','3282770206074','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7899095204720','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7891268148053','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7896342416066','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7899095203266','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7898946495652','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7899105922361','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7896931419249','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7891721000638','5'),
('ef5cb53b-0d7c-42d8-bb8e-64fdf6956dd6','7897595903372','5');

DROP TYPE afarma.ctitem;

CREATE TYPE afarma.ctitem AS (
	id varchar,
	loja varchar,
	nome varchar,
	ean varchar,
	quantidade int4,
	valor numeric(10,2),
	precomedio numeric(10,8),
	total numeric(10,2));

		
		
		select po.ean, count(po.ean) from public.produtos_all_otimizado_ilpi_rj po  group by po.ean order by count desc
		
		
		