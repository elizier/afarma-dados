-- afarma.sumariopedidodto definition

-- Drop table

-- DROP TABLE afarma.sumariopedidodto;

CREATE TABLE afarma.sumariopedidodto (
	id varchar(36) NOT NULL,
	bairro varchar(255) NULL,
	cidade varchar(255) NULL,
	quantidade int8 NULL,
	CONSTRAINT sumariopedidodto_pkey PRIMARY KEY (id)
);