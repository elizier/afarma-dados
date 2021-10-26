
-- afarma.receita_produto definition

-- Drop table

-- DROP TABLE afarma.receita_produto;

CREATE TABLE afarma.receita_produto (
	receita_id varchar(36) NOT NULL,
	item_id varchar(36) NOT NULL,
	CONSTRAINT fkdohphs8dby6cp059yx5g5yq8b FOREIGN KEY (receita_id) REFERENCES afarma.receita(id),
	CONSTRAINT fksjavq09rl26bhvwowfhi909wv FOREIGN KEY (item_id) REFERENCES afarma.itemprodutocesta(id)
);
