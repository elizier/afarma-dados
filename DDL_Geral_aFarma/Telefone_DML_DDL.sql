-- afarma.telefone definition

-- Drop table

-- DROP TABLE afarma.telefone;

CREATE TABLE afarma.telefone (
	id varchar(36) NOT NULL,
	ddd varchar(255) NULL,
	ddi varchar(255) NULL,
	numero varchar(255) NULL,
	CONSTRAINT telefone_pkey PRIMARY KEY (id)
);

INSERT INTO afarma.telefone
(id, ddd, ddi, numero)
VALUES
(
	uuid_generate_v4(),
	'21',
	'55',
	'991301002'
	);
