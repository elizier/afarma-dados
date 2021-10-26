-- afarma.paciente definition

-- Drop table

-- DROP TABLE afarma.paciente;

CREATE TABLE afarma.paciente (
	id varchar(36) NOT NULL,
	active bool NOT NULL,
	cpf varchar(255) NOT NULL,
	nome varchar(255) NOT NULL,
	CONSTRAINT paciente_pkey PRIMARY KEY (id)
);
