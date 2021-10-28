-- afarma.departamento_de_para definition

-- Drop table

-- DROP TABLE afarma.departamento_de_para;

CREATE TABLE afarma.departamento_de_para (
	id varchar NOT NULL DEFAULT uuid_generate_v4(),
	departamento_afarma_id varchar(10240) NULL,
	departamento_afarma varchar(10240) NULL,
	departamento_xpto_id varchar(10240) NULL,
	departamento_xpto varchar(10240) NULL
);