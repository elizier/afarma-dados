-- afarma.loja_telefone definition

-- Drop table

-- DROP TABLE afarma.loja_telefone;

CREATE TABLE afarma.loja_telefone (
	loja_id varchar(36) NOT NULL,
	telefone_id varchar(36) NOT NULL,
	CONSTRAINT fk2ehymhfxs3v1hbp1i65e8vxcp FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fknugdjjfhx9mkji9h2k1s9x2dq FOREIGN KEY (telefone_id) REFERENCES afarma.telefone(id)
);



INSERT INTO afarma.loja_telefone
(loja_id, telefone_id)
VALUES
(
	(select l.id from loja l where l.cnpj = '42.219.002/0001-16'),
	(select t.id from telefone t where concat(t.ddd, t.ddi, t.numero) = '2155991301002')
);

