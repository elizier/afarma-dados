-- afarma.totalizadordto definition

-- Drop table

-- DROP TABLE afarma.totalizadordto;

CREATE TABLE afarma.totalizadordto (
	id varchar(36) NOT NULL,
	total int8 NULL,
	CONSTRAINT totalizadordto_pkey PRIMARY KEY (id)
);