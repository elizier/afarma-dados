
CREATE TYPE afarma.ctitem AS (
	id varchar,
	loja varchar,
	nome varchar,
	ean varchar,
	quantidade int4,
	valor numeric(10,2),
	precomedio numeric(10,8),
	total numeric(10,2));

CREATE TYPE afarma.ctitemdetalhado AS (
	id varchar,
	nome varchar,
	concorrente varchar,
	cotacao_id varchar,
	ean varchar,
	quantidade integer,
	valor numeric (10,5),
	total numeric (10,5));