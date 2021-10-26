
-- afarma.produtoconcorrente definition

-- Drop table

-- DROP TABLE afarma.produtoconcorrente;

CREATE TABLE afarma.produtoconcorrente (
	id varchar(36) NOT NULL,
	dataatualizacao timestamp NULL,
	ean varchar(255) NULL,
	url varchar(255) NULL,
	valor float8 NULL,
	concorrente_id varchar(36) NOT NULL,
	produto_id varchar(36) NOT NULL,
	CONSTRAINT produtoconcorrente_pkey PRIMARY KEY (id),
	CONSTRAINT fk5oqv18t6pu8wl7v8pwb7n87cw FOREIGN KEY (produto_id) REFERENCES afarma.produtocrawler(id),
	CONSTRAINT fkrufiectuu75gs63ktxgx3dn34 FOREIGN KEY (concorrente_id) REFERENCES afarma.concorrente(id)
);