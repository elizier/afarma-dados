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
	(uuid_generate_v4(), '', 'BELEZA', null),
	(uuid_generate_v4(), '', 'HIGIENE E CUIDADOS PESSOAIS', null),
	(uuid_generate_v4(), '', 'SAUDE E BEM ESTAR', null),
	(uuid_generate_v4(), '', 'DERMOCOSMETICOS', null),
	(uuid_generate_v4(), '', 'MEDICAMENTOS', null),
	(uuid_generate_v4(), '', 'MUNDO INFANTIL', null),
	(uuid_generate_v4(), '', 'NÃO IDENTIFICADO', null);
