-- afarma.marca definition

-- Drop table

-- DROP TABLE afarma.marca;

CREATE TABLE afarma.marca (
	id varchar(36) NOT NULL,
	marca varchar(255) NULL,
	CONSTRAINT marca_pkey PRIMARY KEY (id)
);
