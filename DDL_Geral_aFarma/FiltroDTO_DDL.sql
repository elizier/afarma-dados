-- afarma.filtrodto definition

-- Drop table

-- DROP TABLE afarma.filtrodto;

CREATE TABLE afarma.filtrodto (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	CONSTRAINT filtrodto_pkey PRIMARY KEY (id)
);