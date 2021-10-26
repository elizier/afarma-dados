-- afarma.itemparacotacao definition

-- Drop table

-- DROP TABLE afarma.itemparacotacao;

CREATE TABLE afarma.itemparacotacao (
	id varchar(36) NOT NULL,
	ean varchar(255) NULL,
	quantidade int4 NULL,
	CONSTRAINT itemparacotacao_pkey PRIMARY KEY (id)
);
