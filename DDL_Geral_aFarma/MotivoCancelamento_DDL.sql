-- afarma.motivocancelamento definition

-- Drop table

-- DROP TABLE afarma.motivocancelamento;

CREATE TABLE afarma.motivocancelamento (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	CONSTRAINT motivocancelamento_pkey PRIMARY KEY (id)
);