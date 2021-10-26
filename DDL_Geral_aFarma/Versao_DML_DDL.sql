-- afarma.versao definition

-- Drop table

-- DROP TABLE afarma.versao;

CREATE TABLE afarma.versao (
	id int8 NOT NULL,
	active bool NOT NULL,
	vapp varchar(255) NULL,
	CONSTRAINT versao_pkey PRIMARY KEY (id)
);

INSERT INTO afarma.versao 
(id, active, vapp)
VALUES
(1, true, 'v3.00');