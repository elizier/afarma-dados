-- afarma.motivorejeicao definition

-- Drop table

-- DROP TABLE afarma.motivorejeicao;

CREATE TABLE afarma.motivorejeicao (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	CONSTRAINT motivorejeicao_pkey PRIMARY KEY (id)
);