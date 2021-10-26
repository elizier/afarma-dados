-- afarma.cotacaosql definition

-- Drop table

-- DROP TABLE afarma.cotacaosql;

CREATE TABLE afarma.cotacaosql (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	"sql" varchar(255) NULL,
	cesta_id varchar(36) NULL,
	CONSTRAINT cotacaosql_pkey PRIMARY KEY (id)
);