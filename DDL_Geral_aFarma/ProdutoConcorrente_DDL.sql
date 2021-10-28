-- afarma.produtoconcorrente definition

-- Drop table

-- DROP TABLE afarma.produtoconcorrente;

CREATE TABLE afarma.produtoconcorrente (
	id varchar(36) NOT NULL,
	dataatualizacao timestamp NULL,
	ean varchar(255) NULL,
	url varchar(10240) NULL,
	valor float8 NULL,
	concorrente_id varchar(36) NOT NULL,
	produto_id varchar(36) NOT NULL,
	concorrente varchar(255) NULL,
	CONSTRAINT produtoconcorrente_pkey PRIMARY KEY (id)
);
