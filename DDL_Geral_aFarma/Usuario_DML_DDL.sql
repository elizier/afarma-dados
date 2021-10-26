-- afarma.usuario definition

-- Drop table

-- DROP TABLE afarma.usuario;

CREATE TABLE afarma.usuario (
	id varchar(36) NOT NULL,
	aceitetermo bool NULL,
	ativo bool NOT NULL,
	codigo_cad_senha varchar(255) NULL,
	codigoind varchar(36) NULL,
	cpf varchar(255) NULL,
	dataaceite timestamp NULL,
	datanascimento timestamp NULL,
	devicetoken varchar(255) NULL,
	email varchar(255) NOT NULL,
	nome varchar(255) NULL,
	senha varchar(255) NULL,
	telefone varchar(255) NULL,
	casarepousoid varchar(36) NULL,
	enderecoid varchar(36) NULL,
	perfilid int8 NULL,
	CONSTRAINT uk_dybreyjoos4set6h0jmv7bn3h UNIQUE (codigoind),
	CONSTRAINT usuario_pkey PRIMARY KEY (id),
	CONSTRAINT fk2av48pbev16sf0t08mt82eohg FOREIGN KEY (casarepousoid) REFERENCES afarma.casarepouso(id),
	CONSTRAINT fk6fi3jljkemk7mf93aw7k8yv4w FOREIGN KEY (perfilid) REFERENCES afarma.perfil(id),
	CONSTRAINT fkmt8f4h1rurnvpj56t2lk1dkmb FOREIGN KEY (enderecoid) REFERENCES afarma.endereco(id)
);


INSERT INTO afarma.usuario
(id, aceitetermo, ativo, codigo_cad_senha, codigoind, cpf, dataaceite, datanascimento, devicetoken, email, nome, senha, telefone, casarepousoid, enderecoid, perfilid)
VALUES
(
	uuid_generate_v4(),
	true,
	true,
	'',
	'',
	'111.111.111-11',
	now(),
	now(),
	'',
	'bezerra@afarma.app.br',
	'Derick Bezerra',
	'1234',
	'',
	'',
	(select e.id from endereco e where e.lat = -23.0215992836864),
	3
);

