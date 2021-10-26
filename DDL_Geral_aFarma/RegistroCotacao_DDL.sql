-- afarma.registrocotacao definition

-- Drop table

-- DROP TABLE afarma.registrocotacao;

CREATE TABLE afarma.registrocotacao (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	status varchar(255) NULL,
	uf varchar(255) NULL,
	CONSTRAINT registrocotacao_pkey PRIMARY KEY (id)
);