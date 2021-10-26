-- afarma.pedido definition

-- Drop table

-- DROP TABLE afarma.pedido;

CREATE TABLE afarma.pedido (
	id varchar(36) NOT NULL,
	codigoind varchar(255) NULL,
	dataentrega timestamp NULL,
	datapedido timestamp NULL,
	formapagamento varchar(255) NULL,
	horaentrega timestamp NULL,
	ilpi bool NULL,
	motivocancelamento varchar(255) NULL,
	motivorejeicao varchar(255) NULL,
	observacao varchar(255) NULL,
	origempedido varchar(255) NULL,
	status varchar(255) NULL,
	troco float8 NOT NULL,
	valortotaldopedido float8 NULL,
	cesta_id varchar(36) NULL,
	cesta_alterada_id varchar(36) NULL,
	endereco_id varchar(36) NULL,
	loja_id varchar(36) NULL,
	CONSTRAINT pedido_pkey PRIMARY KEY (id)
);
