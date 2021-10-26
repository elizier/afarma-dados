-- afarma.loja_usuario definition

-- Drop table

-- DROP TABLE afarma.loja_usuario;

CREATE TABLE afarma.loja_usuario (
	loja_id varchar(36) NOT NULL,
	usuario_id varchar(36) NOT NULL,
	CONSTRAINT fkd2btut98mnog7s3hy7vojvta0 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fki5r4jc09oeemu6ooyq8un2bog FOREIGN KEY (usuario_id) REFERENCES afarma.usuario(id)
);

INSERT INTO afarma.loja_usuario
(loja_id, usuario_id)
VALUES
(
	(select l.id from loja l where l.cnpj = '42.219.002/0001-16'),
	(select u.id from usuario u where u.email = 'bezerra@afarma.app.br')
);
