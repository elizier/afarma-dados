-- afarma.produto_afarma definition

-- Drop table

-- DROP TABLE afarma.produto_afarma;

CREATE TABLE public.produto_afarma_previo (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	ean varchar(10240) NULL,
	nome varchar(10240) NULL,
	valor float8 NOT NULL,
	photo_id varchar(36) NULL,
	ean_similar varchar(10240) NULL,
	active bool NOT NULL DEFAULT true,
	produto_tsv tsvector NULL,
	busca_similar varchar(255) NULL,
	CONSTRAINT produtoafarma_pkey PRIMARY KEY (id),
	CONSTRAINT produtoafarma_unique UNIQUE (ean)
);



--Adicionar diferentes

insert into afarma.produto_afarma(nome, valor) select p.nome, p.valor from
(select p.nome, p.valor from public.produto_afarma_previo p,
(select p.nome from public.produto_afarma_previo p
except
select p.nome from afarma.produto_afarma p) pr
where pr.nome = p.nome) p


--Atualizar referências

update afarma.produto_afarma set busca_similar = p.busca_similar1 from
(select pap.nome as nome1, pap.busca_similar as busca_similar1 from public.produto_afarma_previo pap ) p
where p.nome1 = nome

-- Atualizar lista de produtos ativos

update afarma.produto_afarma set active = false from
(select p.nome as nome1 from afarma.produto_afarma p
except
select p.nome from public.produto_afarma_previo p) p
where p.nome1 = nome


--Atualizar Vetor de busca

update afarma.produto_afarma set produto_tsv = p.to_tsvector from
(select p.nome as nome1, to_tsvector('portuguese', unaccent(concat(replace(p.nome, ',','.') ,' ', replace(p.busca_similar, ',','.'))))
from afarma.produto_afarma p) p
where p.nome1 = nome


--Busca Produto_afarma

CREATE OR REPLACE FUNCTION public.produtos_afarma_research(research character varying)
 RETURNS SETOF afarma.ctitem_json
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t afarma.ctitem_json%ROWTYPE;
BEGIN

select pa.*, similarity(research, concat(pa.nome,' ', pa.busca_similar)) from afarma.produto_afarma pa 
where
(pa.produto_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
or similarity(research, concat(pa.nome,' ', pa.busca_similar)) > 0.1)
and pa.active = true
order by similarity(research, concat(pa.nome,' ', pa.busca_similar)) desc;

   return ;

END;

$function$
;

