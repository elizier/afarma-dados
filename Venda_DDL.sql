-- afarma.venda definition

-- Drop table

-- DROP TABLE afarma.venda;

CREATE TABLE afarma.venda (
	id varchar(36) NOT NULL,
	dataentrega timestamp NULL,
	datavenda timestamp NULL,
	tipoentrega int4 NULL,
	total float8 NOT NULL,
	endereco_id varchar(36) NULL,
	entregador_id varchar(36) NULL,
	loja_id varchar(36) NULL,
	pedido_id varchar(36) NULL,
	vendedor_id varchar(36) NULL,
	CONSTRAINT venda_pkey PRIMARY KEY (id)
);
