-- afarma.departamento definition

-- Drop table

-- DROP TABLE afarma.departamento;

CREATE TABLE afarma.departamento (
	id varchar(36) NOT NULL,
	backgroundcolor varchar(255) NULL,
	departamento varchar(255) NULL,
	image bytea NULL,
	CONSTRAINT departamento_pkey PRIMARY KEY (id)
);

INSERT INTO afarma.departamento
(id, backgroundcolor, departamento, image)
VALUES
	(uuid_generate_v4(), '', 'BELEZA', ?),
	(uuid_generate_v4(), '', 'HIGIENE E CUIDADOS PESSOAIS', ?),
	(uuid_generate_v4(), '', 'SAUDE E BEM ESTAR', ?),
	(uuid_generate_v4(), '', 'DERMOCOSMETICOS', ?),
	(uuid_generate_v4(), '', 'MEDICAMENTOS', ?),
	(uuid_generate_v4(), '', 'MUNDO INFANTIL', ?);
