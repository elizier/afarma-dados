-- afarma.concorrente definition

-- Drop table

-- DROP TABLE afarma.concorrente;

CREATE TABLE afarma.concorrentes_estados (
	id varchar(36) NOT NULL,
	concorrente_id varchar(36) NOT NULL,
	uf varchar(2) NOT NULL,
	CONSTRAINT concorrentes_estados_pkey PRIMARY KEY (id)
);