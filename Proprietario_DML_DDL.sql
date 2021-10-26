
-- afarma.proprietario definition

-- Drop table

-- DROP TABLE afarma.proprietario;

CREATE TABLE afarma.proprietario (
	id varchar(36) NOT NULL,
	documentoidentidade varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT proprietario_pkey PRIMARY KEY (id)
);

INSERT INTO afarma.proprietario
(id, documentoidentidade, nome)
VALUES
(uuid_generate_v4(), 'Documento', 'Proprietário 1');
