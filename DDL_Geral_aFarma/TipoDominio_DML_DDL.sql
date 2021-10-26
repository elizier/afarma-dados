-- afarma.tipodominio definition

-- Drop table

-- DROP TABLE afarma.tipodominio;

CREATE TABLE afarma.tipodominio (
	id varchar(36) NOT NULL,
	nome varchar(255) NULL,
	CONSTRAINT tipodominio_pkey PRIMARY KEY (id)
);

INSERT INTO afarma.tipodominio
(id, nome)
VALUES
(
	uuid_generate_v4(),
	'CATEGORIA'
),
(
	uuid_generate_v4(),
	'MARCA'
),
(
	uuid_generate_v4(),
	'DEPARTAMENTO'
),
(
	uuid_generate_v4(),
	'PRINCIPIO ATIVO'
),
(
	uuid_generate_v4(),
	'GRUPO'
);
