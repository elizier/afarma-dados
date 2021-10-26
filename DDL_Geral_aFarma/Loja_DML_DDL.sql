-- afarma.loja definition

-- Drop table

-- DROP TABLE afarma.loja;

CREATE TABLE afarma.loja (
	id varchar(36) NOT NULL,
	active bool NULL,
	apelido varchar(255) NULL,
	cnpj varchar(255) NOT NULL,
	inscricaoestadual varchar(255) NULL,
	inscricaomunicipal varchar(255) NULL,
	nomefantasia varchar(255) NULL,
	raioentrega int4 NULL,
	razaosocial varchar(255) NULL,
	tipo varchar(255) NULL,
	endereco_id varchar(36) NULL,
	farmaceutico_id varchar(36) NULL,
	rede_id varchar(36) NULL,
	CONSTRAINT loja_pkey PRIMARY KEY (id),
	CONSTRAINT uk_2lh3kimogdpqpn19l97w07ps UNIQUE (cnpj),
	CONSTRAINT fk6614xlynapkyovuxxguoh2hwm FOREIGN KEY (endereco_id) REFERENCES afarma.endereco(id),
	CONSTRAINT fkar8gdr1o7pl920ps7v9m6u4ac FOREIGN KEY (rede_id) REFERENCES afarma.rede(id),
	CONSTRAINT fktibjofl8gkx3soq7xsam5ixmc FOREIGN KEY (farmaceutico_id) REFERENCES afarma.farmaceutico(id)
);


INSERT INTO afarma.loja
(id, active, apelido, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
VALUES
(
	uuid_generate_v4(),
	true, 
	'afarma',
	'42.219.002/0001-16',
	'12.099.08-8',
	'1.314.492-3',
	'AFARMA', 
	100,
	'AFARMA A DROGARIA DA ILPI LTDA',
	'FRANQUIA',
	(select e.id from endereco e where e.lat = -23.0215992836864),
	(select f.id from farmaceutico f where f.nome = 'Farmaceutico 1'),
	(select r.id from rede r where r.email = 'afarma@afarma.com.br'));


