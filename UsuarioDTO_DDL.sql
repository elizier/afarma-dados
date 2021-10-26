-- afarma.usuariodto definition

-- Drop table

-- DROP TABLE afarma.usuariodto;

CREATE TABLE afarma.usuariodto (
	id varchar(36) NOT NULL,
	bairro varchar(255) NULL,
	cep varchar(255) NULL,
	cidade varchar(255) NULL,
	datacadastro varchar(255) NULL,
	documento varchar(255) NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	telefone varchar(255) NULL,
	CONSTRAINT usuariodto_pkey PRIMARY KEY (id)
);
