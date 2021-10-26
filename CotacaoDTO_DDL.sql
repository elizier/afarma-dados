-- afarma.cotacaodto definition

-- Drop table

-- DROP TABLE afarma.cotacaodto;

CREATE TABLE afarma.cotacaodto (
	id varchar(36) NOT NULL,
	loja varchar(255) NULL,
	total float8 NOT NULL,
	CONSTRAINT cotacaodto_pkey PRIMARY KEY (id)
);
