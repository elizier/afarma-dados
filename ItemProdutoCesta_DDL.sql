-- afarma.itemprodutocesta definition

-- Drop table

-- DROP TABLE afarma.itemprodutocesta;

CREATE TABLE afarma.itemprodutocesta (
	id varchar(36) NOT NULL,
	quantidade int4 NOT NULL,
	produto_id varchar(36) NULL,
	produtopromocao_id varchar(36) NULL,
	CONSTRAINT itemprodutocesta_pkey PRIMARY KEY (id),
	CONSTRAINT fk7151bwe3cxl36uu8bk2l87fo0 FOREIGN KEY (produtopromocao_id) REFERENCES afarma.produto(id),
	CONSTRAINT fkt0agrq9acnmxxhooyowq7qyr2 FOREIGN KEY (produto_id) REFERENCES afarma.produto(id)
);