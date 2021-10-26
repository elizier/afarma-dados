-- afarma.casarepouso definition

-- Drop table

-- DROP TABLE afarma.casarepouso;

CREATE TABLE afarma.casarepouso (
	id varchar(36) NOT NULL,
	active bool NOT NULL,
	cnpj varchar(255) NOT NULL,
	nome varchar(255) NOT NULL,
	enderecoid varchar(36) NULL,
	CONSTRAINT casarepouso_pkey PRIMARY KEY (id),
	CONSTRAINT fkc6btd6h6fetqmulg8sjo9u6nu FOREIGN KEY (enderecoid) REFERENCES afarma.endereco(id)
);