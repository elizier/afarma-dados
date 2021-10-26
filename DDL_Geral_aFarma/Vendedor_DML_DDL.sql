-- afarma.vendedor definition

-- Drop table

-- DROP TABLE afarma.vendedor;

CREATE TABLE afarma.vendedor (
	id varchar(36) NOT NULL,
	documentoidentidade varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT vendedor_pkey PRIMARY KEY (id)
);


INSERT INTO afarma.vendedor 
(id, documentoidentidade, nome) 
VALUES
(uuid_generate_v4(), 'Documento 1', ' Vendedor 1'),
(uuid_generate_v4(), 'Documento 2', ' Vendedor 2');
