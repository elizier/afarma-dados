-- afarma.categoria definition

-- Drop table

-- DROP TABLE afarma.categoria;

CREATE TABLE afarma.categoria (
	id varchar(36) NOT NULL,
	categoria varchar(255) NULL,
	CONSTRAINT categoria_pkey PRIMARY KEY (id)
);
