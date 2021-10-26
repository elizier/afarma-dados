-- afarma.rejeicaodto definition

-- Drop table

-- DROP TABLE afarma.rejeicaodto;

CREATE TABLE afarma.rejeicaodto (
	id varchar(36) NOT NULL,
	bairro varchar(255) NULL,
	cidade varchar(255) NULL,
	loja varchar(255) NULL,
	motivo varchar(255) NULL,
	telefone varchar(255) NULL,
	ultimopedido varchar(255) NULL,
	usuario varchar(255) NULL,
	CONSTRAINT rejeicaodto_pkey PRIMARY KEY (id)
);