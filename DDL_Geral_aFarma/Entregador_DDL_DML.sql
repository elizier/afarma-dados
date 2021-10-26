-- afarma.entregador definition

-- Drop table

-- DROP TABLE afarma.entregador;

CREATE TABLE afarma.entregador (
	id varchar(36) NOT NULL,
	documentoidentidade varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT entregador_pkey PRIMARY KEY (id)
);


INSERT INTO afarma.entregador
(id, documentoidentidade, nome)
VALUES
(uuid_generate_v4(), 'Documento', 'Entregador 1');
