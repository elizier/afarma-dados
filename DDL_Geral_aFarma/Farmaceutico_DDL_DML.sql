-- afarma.farmaceutico definition

-- Drop table

-- DROP TABLE afarma.farmaceutico;

CREATE TABLE afarma.farmaceutico (
	id varchar(36) NOT NULL,
	documentoidentidade varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT farmaceutico_pkey PRIMARY KEY (id)
);


INSERT INTO afarma.farmaceutico
(id, documentoidentidade, nome)
VALUES
(
	uuid_generate_v4(),
	'Documento 1',
	'Farmaceutico 1'
	);
