-- afarma.percentualrepasse definition

-- Drop table

-- DROP TABLE afarma.percentualrepasse;

CREATE TABLE afarma.percentualrepasse (
	id varchar(36) NOT NULL,
	percentual float8 NULL,
	status bool NULL,
	CONSTRAINT percentualrepasse_pkey PRIMARY KEY (id)
);

