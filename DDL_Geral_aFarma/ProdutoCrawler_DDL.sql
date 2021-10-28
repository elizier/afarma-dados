-- afarma.produtocrawler definition

-- Drop table

-- DROP TABLE afarma.produtocrawler;

CREATE TABLE afarma.produtocrawler (
	id varchar(36) NOT NULL,
	contraindicacao varchar(10240) NULL,
	descricao varchar(10240) NULL,
	ean varchar(10240) NULL,
	indicacao varchar(10240) NULL,
	nome varchar(10240) NULL,
	categoria_id varchar(36) NULL,
	departamento_id varchar(36) NOT NULL,
	marca_id varchar(36) NULL,
	photo_id varchar(36) NULL,
	principioativo_id varchar(36) NULL,
	produto_tsv tsvector NULL,
	CONSTRAINT produtocrawler_pkey PRIMARY KEY (id)
);


-- afarma.produtocrawler foreign keys

ALTER TABLE afarma.produtocrawler ADD CONSTRAINT fkamfmr7j1eatbljs7s093m0mtt FOREIGN KEY (photo_id) REFERENCES afarma.photo(id);
ALTER TABLE afarma.produtocrawler ADD CONSTRAINT fkb7mikdij11onlogwu120ht5kh FOREIGN KEY (departamento_id) REFERENCES afarma.departamento(id);
ALTER TABLE afarma.produtocrawler ADD CONSTRAINT fkojfoi6s0nxhrqc79m511ax0mu FOREIGN KEY (marca_id) REFERENCES afarma.marca(id);
ALTER TABLE afarma.produtocrawler ADD CONSTRAINT fksu0q8dnhupn9aqum3yd3n2c8p FOREIGN KEY (categoria_id) REFERENCES afarma.categoria(id);