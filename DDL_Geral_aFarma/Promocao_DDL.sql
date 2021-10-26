
-- afarma.promocao definition

-- Drop table

-- DROP TABLE afarma.promocao;

CREATE TABLE afarma.promocao (
	id varchar(36) NOT NULL,
	datafinal timestamp NULL,
	datainicial timestamp NULL,
	loja_id varchar(36) NULL,
	produto_id varchar(36) NULL,
	CONSTRAINT promocao_pkey PRIMARY KEY (id),
	CONSTRAINT fk4ynhwac9jxw969w9ofru1uw9u FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fkrh9pn023ukm40vydnasptf8d7 FOREIGN KEY (produto_id) REFERENCES afarma.produto(id)
);
