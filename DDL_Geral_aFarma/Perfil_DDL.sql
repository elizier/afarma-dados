
-- afarma.perfil definition

-- Drop table

-- DROP TABLE afarma.perfil;

CREATE TABLE afarma.perfil (
	id int8 NOT NULL,
	identificador varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT perfil_pkey PRIMARY KEY (id)
);