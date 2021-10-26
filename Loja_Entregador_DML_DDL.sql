-- afarma.loja_entregador definition

-- Drop table

-- DROP TABLE afarma.loja_entregador;

CREATE TABLE afarma.loja_entregador (
	loja_id varchar(36) NOT NULL,
	entregador_id varchar(36) NOT NULL,
	CONSTRAINT fk672ceqyfxmvj7yq0ojlmldopt FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fki8uy47qtegkljh4pmj80c59xl FOREIGN KEY (entregador_id) REFERENCES afarma.entregador(id)
);


INSERT INTO afarma.loja_entregador
(loja_id, entregador_id)
VALUES
(
	(select l.id from loja l where l.cnpj = '42.219.002/0001-16'),
	(select e.id from entregador e where e.nome = 'Entregador 1')
);

