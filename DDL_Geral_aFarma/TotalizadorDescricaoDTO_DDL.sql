-- afarma.totalizadordescricaodto definition

-- Drop table

-- DROP TABLE afarma.totalizadordescricaodto;

CREATE TABLE afarma.totalizadordescricaodto (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	total int8 NULL,
	CONSTRAINT totalizadordescricaodto_pkey PRIMARY KEY (id)
);