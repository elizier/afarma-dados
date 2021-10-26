-- afarma.pedidosatuaisdto definition

-- Drop table

-- DROP TABLE afarma.pedidosatuaisdto;

CREATE TABLE afarma.pedidosatuaisdto (
	id varchar(36) NOT NULL,
	apelido varchar(255) NULL,
	cliente varchar(255) NULL,
	dataemissaoreceita varchar(255) NULL,
	datapedido varchar(255) NULL,
	motivorejeicao varchar(255) NULL,
	pedido varchar(255) NULL,
	razaosocial varchar(255) NULL,
	status varchar(255) NULL,
	telefone varchar(255) NULL,
	CONSTRAINT pedidosatuaisdto_pkey PRIMARY KEY (id)
);
