
-- afarma.receita definition

-- Drop table

-- DROP TABLE afarma.receita;

CREATE TABLE afarma.receita (
	id varchar(36) NOT NULL,
	crm varchar(255) NULL,
	dataemissaoreceita varchar(255) NULL,
	descricao varchar(255) NULL,
	image bytea NULL,
	image2 bytea NULL,
	image3 bytea NULL,
	CONSTRAINT receita_pkey PRIMARY KEY (id)
);