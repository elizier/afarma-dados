-- afarma.repasse definition

-- Drop table

-- DROP TABLE afarma.repasse;

CREATE TABLE afarma.repasse (
	id varchar(36) NOT NULL,
	datafinal timestamp NULL,
	datainicial timestamp NULL,
	efetuado bool NOT NULL,
	valorrepasse float8 NULL,
	valortotalvendas float8 NULL,
	percentual_id varchar(36) NOT NULL,
	loja_id varchar(36) NULL,
	CONSTRAINT repasse_pkey PRIMARY KEY (id),
	CONSTRAINT fk6aer7qm1nal5nldssrq8lp8uo FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fkssux5h39bxxmcysxoqx4yhh15 FOREIGN KEY (percentual_id) REFERENCES afarma.percentualrepasse(id)
);