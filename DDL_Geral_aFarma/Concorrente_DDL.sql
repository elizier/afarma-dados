-- afarma.concorrente definition

-- Drop table

-- DROP TABLE afarma.concorrente;

CREATE TABLE afarma.concorrente (
	id varchar(36) NOT NULL,
	concorrente varchar(255) NULL,
	CONSTRAINT concorrente_pkey PRIMARY KEY (id)
);



INSERT INTO afarma.concorrente
(id, concorrente)
VALUES
(uuid_generate_v4(), 'RAIA'),
(uuid_generate_v4(), 'PACHECO'),
(uuid_generate_v4(), 'VENANCIO');
