-- afarma.loja_vendedor definition

-- Drop table

-- DROP TABLE afarma.loja_vendedor;

CREATE TABLE afarma.loja_vendedor (
	loja_id varchar(36) NOT NULL,
	vendedor_id varchar(36) NOT NULL,
	CONSTRAINT fk5xju9dneutvjxpa98nrk6aeti FOREIGN KEY (vendedor_id) REFERENCES afarma.vendedor(id),
	CONSTRAINT fk8iycvdf65hn6sm62vs5x7n5jf FOREIGN KEY (loja_id) REFERENCES afarma.loja(id)
);



INSERT INTO afarma.loja_vendedor
(loja_id, vendedor_id)
VALUES
(
	(select l.id from loja l where l.cnpj = '42.219.002/0001-16'),
	(select v.id from vendedor v where v.nome = 'Vendedor 1')
);

