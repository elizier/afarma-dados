-- afarma.itenscot definition

-- Drop table

-- DROP TABLE afarma.itenscot;

CREATE TABLE afarma.itenscot (
	id varchar(36) NOT NULL,
	cotacao varchar(255) NULL,
	ean varchar(255) NULL,
	quantidade int4 NOT NULL,
	CONSTRAINT itenscot_pkey PRIMARY KEY (id),
	CONSTRAINT fkl0gr312akbsfsdd93hhro68ti FOREIGN KEY (cotacao) REFERENCES afarma.registrocotacao(id)
);