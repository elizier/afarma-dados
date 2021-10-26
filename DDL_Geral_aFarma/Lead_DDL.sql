-- afarma."lead" definition

-- Drop table

-- DROP TABLE afarma."lead";

CREATE TABLE afarma."lead" (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	nome varchar(255) NULL,
	recorrente bool NULL,
	telefone varchar(255) NULL,
	CONSTRAINT lead_pkey PRIMARY KEY (id)
);