-- afarma.pedidoporstatusdto definition

-- Drop table

-- DROP TABLE afarma.pedidoporstatusdto;

CREATE TABLE afarma.pedidoporstatusdto (
	id varchar(36) NOT NULL,
	contagem int8 NULL,
	mesreferencia varchar(255) NULL,
	status varchar(255) NULL,
	CONSTRAINT pedidoporstatusdto_pkey PRIMARY KEY (id)
);
