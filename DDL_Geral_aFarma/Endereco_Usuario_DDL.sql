
-- afarma.endereco_usuario definition

-- Drop table

-- DROP TABLE afarma.endereco_usuario;

CREATE TABLE afarma.endereco_usuario (
	usuario_id varchar(36) NOT NULL,
	endereco_id varchar(36) NOT NULL,
	CONSTRAINT fk48fht49aqu03oky1pqu7ug99y FOREIGN KEY (usuario_id) REFERENCES afarma.usuario(id),
	CONSTRAINT fkitvilkgun2i21jblrk2iiofqa FOREIGN KEY (endereco_id) REFERENCES afarma.endereco(id)
);


INSERT INTO afarma.endereco_usuario
(usuario_id, endereco_id)
VALUES
(
	(select u.id from usuario u where u.email = 'bezerra@afarma.app.br'),
	(select e.id from endereco e where e.lat = -23.0215992836864)
);
