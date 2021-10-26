-- afarma.produto definition

-- Drop table

-- DROP TABLE afarma.produto;

CREATE TABLE afarma.produto (
	id varchar(36) NOT NULL,
	contraindicacao varchar(255) NULL,
	descricao varchar(255) NULL,
	ean varchar(255) NULL,
	indicacao varchar(255) NULL,
	lojapromocao varchar(255) NULL,
	nome varchar(255) NULL,
	precomedio float8 NULL,
	categoria_id varchar(36) NULL,
	departamento_id varchar(36) NULL,
	grupo_id varchar(36) NULL,
	marca_id varchar(36) NULL,
	photo_id varchar(36) NULL,
	principioativo_id varchar(36) NULL,
	CONSTRAINT produto_pkey PRIMARY KEY (id),
	CONSTRAINT fk5cxb8e5gu3n2p6fngryqadr9t FOREIGN KEY (photo_id) REFERENCES afarma.photo(id),
	CONSTRAINT fk6lga45feiaeoljmlj8poje5yd FOREIGN KEY (departamento_id) REFERENCES afarma.dominio(id),
	CONSTRAINT fk770abs3iotndhmurdf5yhcjr7 FOREIGN KEY (marca_id) REFERENCES afarma.dominio(id),
	CONSTRAINT fk91liwnkojapf24vvcbmlhuip1 FOREIGN KEY (grupo_id) REFERENCES afarma.dominio(id),
	CONSTRAINT fkf4bxap8gam3bi2g0n9x1uc0e4 FOREIGN KEY (categoria_id) REFERENCES afarma.dominio(id),
	CONSTRAINT fkngj8i0y8uom9ft3d5dc76lt3q FOREIGN KEY (principioativo_id) REFERENCES afarma.dominio(id)
);
