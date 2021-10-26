-- afarma.rede definition

-- Drop table

-- DROP TABLE afarma.rede;

CREATE TABLE afarma.rede (
	id varchar(36) NOT NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT rede_pkey PRIMARY KEY (id)
);

INSERT INTO afarma.rede
(id, email, nome)
VALUES
(
	uuid_generate_v4(),
	'afarma@afarma.com.br',
	'aFarma'
	);
