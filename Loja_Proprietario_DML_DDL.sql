-- afarma.loja_proprietario definition

-- Drop table

-- DROP TABLE afarma.loja_proprietario;

CREATE TABLE afarma.loja_proprietario (
	loja_id varchar(36) NOT NULL,
	proprietario_id varchar(36) NOT NULL,
	CONSTRAINT fk35lgsvc2fng5t4xcw912abfng FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fks303okakm65vh3tqs2acln8xm FOREIGN KEY (proprietario_id) REFERENCES afarma.proprietario(id)
);



INSERT INTO afarma.loja_proprietario
(loja_id, proprietario_id)
VALUES
(
	(select l.id from loja l where l.cnpj = '42.219.002/0001-16'),
	(select p.id from proprietario p where p.nome = 'Proprietário 1')
);

