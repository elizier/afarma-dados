
-- afarma.endereco definition

-- Drop table

-- DROP TABLE afarma.endereco;

CREATE TABLE afarma.endereco (
	id varchar(36) NOT NULL,
	bairro varchar(255) NULL,
	cep varchar(255) NULL,
	cidade varchar(255) NULL,
	complemento varchar(255) NULL,
	descricao varchar(255) NULL,
	googleplaceid varchar(255) NULL,
	lat numeric(19, 2) NULL,
	lng numeric(19, 2) NULL,
	logradouro varchar(255) NULL,
	numero varchar(255) NULL,
	tipo varchar(255) NULL,
	uf varchar(255) NULL,
	CONSTRAINT endereco_pkey PRIMARY KEY (id)
);

INSERT INTO afarma.endereco(
	id,
	bairro,
	cep,
	cidade,
	complemento,
	descricao,
	googleplaceid,
	lat,
	lng,
	logradouro,
	numero,
	tipo,
	uf
	)
VALUES (
	uuid_generate_v4(),
	'Recreio dos Bandeirantes',
	'22790851',
	'Rio de Janeiro',
	'Bloco 001 Loja 0114',
	'Loja aFarma',
	'EltBdi4gZGFzIEFtw6lyaWNhcywgMjAwMDcgLSBSZWNyZWlvIGRvcyBCYW5kZWlyYW50ZXMsIFJpbyBkZSBKYW5laXJvIC0gUkosIDIyNzkwLTcwMywgQnJhemlsIjISMAoUChIJ1xZT8BPomwARIu__mSCEnvgQp5wBKhQKEgktCdVcYN2bABEkx2kFTbQatg',
	-23.0215992836864,
	-43.49921363330207,
	'Av das Américas',
	'20007',
	'AVENIDA',
	'RJ'
	);
