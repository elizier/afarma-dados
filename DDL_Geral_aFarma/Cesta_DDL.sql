-- afarma.cesta definition

-- Drop table

-- DROP TABLE afarma.cesta;

CREATE TABLE afarma.cesta (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	valortotaldacesta float8 NULL,
	cliente_id varchar(36) NULL,
	cotacao_id varchar(36) NULL,
	CONSTRAINT cesta_pkey PRIMARY KEY (id)
);
