-- afarma.cotacaojsondto definition

-- Drop table

-- DROP TABLE afarma.cotacaojsondto;

CREATE TABLE afarma.cotacaojsondto (
	id varchar(36) NOT NULL,
	line varchar(50000) NULL,
	CONSTRAINT cotacaojsondto_pkey PRIMARY KEY (id)
);
