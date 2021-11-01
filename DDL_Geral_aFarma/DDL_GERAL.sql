-- DROP SCHEMA afarma;

CREATE SCHEMA afarma AUTHORIZATION postgres;
-- afarma.banner definition

-- Drop table

-- DROP TABLE afarma.banner;

CREATE TABLE afarma.banner (
	id varchar(36) NOT NULL,
	image varchar(255) NOT NULL,
	url varchar(255) NULL,
	CONSTRAINT banner_pkey PRIMARY KEY (id)
);


-- afarma.categoria definition

-- Drop table

-- DROP TABLE afarma.categoria;

CREATE TABLE afarma.categoria (
	id varchar(36) NOT NULL,
	categoria varchar(255) NULL,
	CONSTRAINT categoria_pkey PRIMARY KEY (id)
);


-- afarma.concorrente definition

-- Drop table

-- DROP TABLE afarma.concorrente;

CREATE TABLE afarma.concorrente (
	id varchar(36) NOT NULL,
	concorrente varchar(255) NULL,
	CONSTRAINT concorrente_pkey PRIMARY KEY (id)
);


-- afarma.concorrentes_estados definition

-- Drop table

-- DROP TABLE afarma.concorrentes_estados;

CREATE TABLE afarma.concorrentes_estados (
	id varchar(36) NOT NULL,
	concorrente_id varchar(36) NOT NULL,
	uf varchar(2) NOT NULL,
	CONSTRAINT concorrentes_estados_pkey PRIMARY KEY (id)
);


-- afarma.cotacaodto definition

-- Drop table

-- DROP TABLE afarma.cotacaodto;

CREATE TABLE afarma.cotacaodto (
	id varchar(36) NOT NULL,
	loja varchar(255) NULL,
	total float8 NOT NULL,
	CONSTRAINT cotacaodto_pkey PRIMARY KEY (id)
);


-- afarma.cotacaojsondto definition

-- Drop table

-- DROP TABLE afarma.cotacaojsondto;

CREATE TABLE afarma.cotacaojsondto (
	id varchar(36) NOT NULL,
	line varchar(50000) NULL,
	CONSTRAINT cotacaojsondto_pkey PRIMARY KEY (id)
);


-- afarma.departamento definition

-- Drop table

-- DROP TABLE afarma.departamento;

CREATE TABLE afarma.departamento (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	backgroundcolor varchar(255) NULL,
	departamento varchar(255) NULL,
	image bytea NULL,
	CONSTRAINT departamento_pkey PRIMARY KEY (id)
);


-- afarma.departamento_de_para definition

-- Drop table

-- DROP TABLE afarma.departamento_de_para;

CREATE TABLE afarma.departamento_de_para (
	id varchar NOT NULL DEFAULT uuid_generate_v4(),
	departamento_afarma_id varchar(10240) NULL,
	departamento_afarma varchar(10240) NULL,
	departamento_xpto_id varchar(10240) NULL,
	departamento_xpto varchar(10240) NULL
);


-- afarma.departamento_xpto definition

-- Drop table

-- DROP TABLE afarma.departamento_xpto;

CREATE TABLE afarma.departamento_xpto (
	id varchar NOT NULL DEFAULT uuid_generate_v4(),
	departamento varchar(10240) NULL
);


-- afarma.documento definition

-- Drop table

-- DROP TABLE afarma.documento;

CREATE TABLE afarma.documento (
	id varchar(36) NOT NULL,
	image bytea NULL,
	CONSTRAINT documento_pkey PRIMARY KEY (id)
);


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


-- afarma.entregador definition

-- Drop table

-- DROP TABLE afarma.entregador;

CREATE TABLE afarma.entregador (
	id varchar(36) NOT NULL,
	documentoidentidade varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT entregador_pkey PRIMARY KEY (id)
);


-- afarma.farmaceutico definition

-- Drop table

-- DROP TABLE afarma.farmaceutico;

CREATE TABLE afarma.farmaceutico (
	id varchar(36) NOT NULL,
	documentoidentidade varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT farmaceutico_pkey PRIMARY KEY (id)
);


-- afarma.filtrodto definition

-- Drop table

-- DROP TABLE afarma.filtrodto;

CREATE TABLE afarma.filtrodto (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	CONSTRAINT filtrodto_pkey PRIMARY KEY (id)
);


-- afarma.itemparacotacao definition

-- Drop table

-- DROP TABLE afarma.itemparacotacao;

CREATE TABLE afarma.itemparacotacao (
	id varchar(36) NOT NULL,
	ean varchar(255) NULL,
	quantidade int4 NULL,
	CONSTRAINT itemparacotacao_pkey PRIMARY KEY (id)
);


-- afarma."lead" definition

-- Drop table

-- DROP TABLE afarma."lead";

CREATE TABLE afarma."lead" (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	nome varchar(255) NULL,
	recorrente bool NULL,
	telefone varchar(255) NULL,
	CONSTRAINT lead_pkey PRIMARY KEY (id)
);


-- afarma.marca definition

-- Drop table

-- DROP TABLE afarma.marca;

CREATE TABLE afarma.marca (
	id varchar(36) NOT NULL,
	marca varchar(255) NULL,
	CONSTRAINT marca_pkey PRIMARY KEY (id)
);


-- afarma.motivocancelamento definition

-- Drop table

-- DROP TABLE afarma.motivocancelamento;

CREATE TABLE afarma.motivocancelamento (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	CONSTRAINT motivocancelamento_pkey PRIMARY KEY (id)
);


-- afarma.motivorejeicao definition

-- Drop table

-- DROP TABLE afarma.motivorejeicao;

CREATE TABLE afarma.motivorejeicao (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	CONSTRAINT motivorejeicao_pkey PRIMARY KEY (id)
);


-- afarma.paciente definition

-- Drop table

-- DROP TABLE afarma.paciente;

CREATE TABLE afarma.paciente (
	id varchar(36) NOT NULL,
	active bool NOT NULL,
	cpf varchar(255) NOT NULL,
	nome varchar(255) NOT NULL,
	CONSTRAINT paciente_pkey PRIMARY KEY (id)
);


-- afarma.pedidoporstatusdto definition

-- Drop table

-- DROP TABLE afarma.pedidoporstatusdto;

CREATE TABLE afarma.pedidoporstatusdto (
	id varchar(36) NOT NULL,
	contagem int8 NULL,
	mesreferencia varchar(255) NULL,
	status varchar(255) NULL,
	CONSTRAINT pedidoporstatusdto_pkey PRIMARY KEY (id)
);


-- afarma.pedidosatuaisdto definition

-- Drop table

-- DROP TABLE afarma.pedidosatuaisdto;

CREATE TABLE afarma.pedidosatuaisdto (
	id varchar(36) NOT NULL,
	apelido varchar(255) NULL,
	cliente varchar(255) NULL,
	dataemissaoreceita varchar(255) NULL,
	datapedido varchar(255) NULL,
	motivorejeicao varchar(255) NULL,
	pedido varchar(255) NULL,
	razaosocial varchar(255) NULL,
	status varchar(255) NULL,
	telefone varchar(255) NULL,
	CONSTRAINT pedidosatuaisdto_pkey PRIMARY KEY (id)
);


-- afarma.percentualrepasse definition

-- Drop table

-- DROP TABLE afarma.percentualrepasse;

CREATE TABLE afarma.percentualrepasse (
	id varchar(36) NOT NULL,
	percentual float8 NULL,
	status bool NULL,
	CONSTRAINT percentualrepasse_pkey PRIMARY KEY (id)
);


-- afarma.perfil definition

-- Drop table

-- DROP TABLE afarma.perfil;

CREATE TABLE afarma.perfil (
	id int8 NOT NULL,
	identificador varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT perfil_pkey PRIMARY KEY (id)
);


-- afarma.photo definition

-- Drop table

-- DROP TABLE afarma.photo;

CREATE TABLE afarma.photo (
	id varchar(36) NOT NULL,
	"path" varchar(255) NULL,
	CONSTRAINT photo_pkey PRIMARY KEY (id)
);


-- afarma.principioativo definition

-- Drop table

-- DROP TABLE afarma.principioativo;

CREATE TABLE afarma.principioativo (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	CONSTRAINT principioativo_pkey PRIMARY KEY (id)
);


-- afarma.produto_afarma definition

-- Drop table

-- DROP TABLE afarma.produto_afarma;

CREATE TABLE afarma.produto_afarma (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	ean varchar(10240) NULL,
	nome varchar(10240) NULL,
	valor float8 NOT NULL,
	photo_id varchar(36) NULL,
	ean_similar varchar(10240) NULL,
	active bool NOT NULL DEFAULT true,
	produto_tsv tsvector NULL,
	CONSTRAINT produtoafarma_pkey PRIMARY KEY (id),
	CONSTRAINT produtoafarma_unique UNIQUE (ean)
);


-- afarma.produto_departamentos definition

-- Drop table

-- DROP TABLE afarma.produto_departamentos;

CREATE TABLE afarma.produto_departamentos (
	id varchar NOT NULL DEFAULT uuid_generate_v4(),
	produto_id varchar(10240) NULL,
	departamento_id varchar(10240) NULL
);


-- afarma.proprietario definition

-- Drop table

-- DROP TABLE afarma.proprietario;

CREATE TABLE afarma.proprietario (
	id varchar(36) NOT NULL,
	documentoidentidade varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT proprietario_pkey PRIMARY KEY (id)
);


-- afarma.receita definition

-- Drop table

-- DROP TABLE afarma.receita;

CREATE TABLE afarma.receita (
	id varchar(36) NOT NULL,
	crm varchar(255) NULL,
	dataemissaoreceita varchar(255) NULL,
	descricao varchar(255) NULL,
	image bytea NULL,
	image2 bytea NULL,
	image3 bytea NULL,
	CONSTRAINT receita_pkey PRIMARY KEY (id)
);


-- afarma.rede definition

-- Drop table

-- DROP TABLE afarma.rede;

CREATE TABLE afarma.rede (
	id varchar(36) NOT NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT rede_pkey PRIMARY KEY (id)
);


-- afarma.registrocotacao definition

-- Drop table

-- DROP TABLE afarma.registrocotacao;

CREATE TABLE afarma.registrocotacao (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	status varchar(255) NULL,
	uf varchar(255) NULL,
	CONSTRAINT registrocotacao_pkey PRIMARY KEY (id)
);


-- afarma.rejeicaodto definition

-- Drop table

-- DROP TABLE afarma.rejeicaodto;

CREATE TABLE afarma.rejeicaodto (
	id varchar(36) NOT NULL,
	bairro varchar(255) NULL,
	cidade varchar(255) NULL,
	loja varchar(255) NULL,
	motivo varchar(255) NULL,
	telefone varchar(255) NULL,
	ultimopedido varchar(255) NULL,
	usuario varchar(255) NULL,
	CONSTRAINT rejeicaodto_pkey PRIMARY KEY (id)
);


-- afarma.sumariopedidodto definition

-- Drop table

-- DROP TABLE afarma.sumariopedidodto;

CREATE TABLE afarma.sumariopedidodto (
	id varchar(36) NOT NULL,
	bairro varchar(255) NULL,
	cidade varchar(255) NULL,
	quantidade int8 NULL,
	CONSTRAINT sumariopedidodto_pkey PRIMARY KEY (id)
);


-- afarma.telefone definition

-- Drop table

-- DROP TABLE afarma.telefone;

CREATE TABLE afarma.telefone (
	id varchar(36) NOT NULL,
	ddd varchar(255) NULL,
	ddi varchar(255) NULL,
	numero varchar(255) NULL,
	CONSTRAINT telefone_pkey PRIMARY KEY (id)
);


-- afarma.tipodominio definition

-- Drop table

-- DROP TABLE afarma.tipodominio;

CREATE TABLE afarma.tipodominio (
	id varchar(36) NOT NULL,
	nome varchar(255) NULL,
	CONSTRAINT tipodominio_pkey PRIMARY KEY (id)
);


-- afarma.totalizadordescricaodto definition

-- Drop table

-- DROP TABLE afarma.totalizadordescricaodto;

CREATE TABLE afarma.totalizadordescricaodto (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	total int8 NULL,
	CONSTRAINT totalizadordescricaodto_pkey PRIMARY KEY (id)
);


-- afarma.totalizadordto definition

-- Drop table

-- DROP TABLE afarma.totalizadordto;

CREATE TABLE afarma.totalizadordto (
	id varchar(36) NOT NULL,
	total int8 NULL,
	CONSTRAINT totalizadordto_pkey PRIMARY KEY (id)
);


-- afarma.usuariodto definition

-- Drop table

-- DROP TABLE afarma.usuariodto;

CREATE TABLE afarma.usuariodto (
	id varchar(36) NOT NULL,
	bairro varchar(255) NULL,
	cep varchar(255) NULL,
	cidade varchar(255) NULL,
	datacadastro varchar(255) NULL,
	documento varchar(255) NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	telefone varchar(255) NULL,
	CONSTRAINT usuariodto_pkey PRIMARY KEY (id)
);


-- afarma.vendedor definition

-- Drop table

-- DROP TABLE afarma.vendedor;

CREATE TABLE afarma.vendedor (
	id varchar(36) NOT NULL,
	documentoidentidade varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT vendedor_pkey PRIMARY KEY (id)
);


-- afarma.versao definition

-- Drop table

-- DROP TABLE afarma.versao;

CREATE TABLE afarma.versao (
	id int8 NOT NULL,
	active bool NOT NULL,
	vapp varchar(255) NULL,
	CONSTRAINT versao_pkey PRIMARY KEY (id)
);


-- afarma.casarepouso definition

-- Drop table

-- DROP TABLE afarma.casarepouso;

CREATE TABLE afarma.casarepouso (
	id varchar(36) NOT NULL,
	active bool NOT NULL,
	cnpj varchar(255) NOT NULL,
	nome varchar(255) NOT NULL,
	enderecoid varchar(36) NULL,
	CONSTRAINT casarepouso_pkey PRIMARY KEY (id),
	CONSTRAINT fkc6btd6h6fetqmulg8sjo9u6nu FOREIGN KEY (enderecoid) REFERENCES afarma.endereco(id)
);


-- afarma.casarepouso_paciente definition

-- Drop table

-- DROP TABLE afarma.casarepouso_paciente;

CREATE TABLE afarma.casarepouso_paciente (
	casa_repouso_id varchar(36) NOT NULL,
	paciente_id varchar(36) NOT NULL,
	CONSTRAINT uk_mtevlgk4uo99trgxge435ngnn UNIQUE (paciente_id),
	CONSTRAINT fk7s6db20v46osf3stn9ewjshpu FOREIGN KEY (paciente_id) REFERENCES afarma.paciente(id),
	CONSTRAINT fksbg6hsotsgkh9gthuvog09f2u FOREIGN KEY (casa_repouso_id) REFERENCES afarma.casarepouso(id)
);


-- afarma.casarepouso_telefones definition

-- Drop table

-- DROP TABLE afarma.casarepouso_telefones;

CREATE TABLE afarma.casarepouso_telefones (
	casa_repouso_id varchar(36) NOT NULL,
	telefone_id varchar(36) NOT NULL,
	CONSTRAINT fkfmwrxeogf0eyo34js0g4qq29m FOREIGN KEY (casa_repouso_id) REFERENCES afarma.casarepouso(id),
	CONSTRAINT fkhbkp0kwo9qamw9ors62q3c3w3 FOREIGN KEY (telefone_id) REFERENCES afarma.telefone(id)
);


-- afarma.dominio definition

-- Drop table

-- DROP TABLE afarma.dominio;

CREATE TABLE afarma.dominio (
	id varchar(36) NOT NULL,
	nome varchar(255) NULL,
	tipo_id varchar(36) NULL,
	CONSTRAINT dominio_pkey PRIMARY KEY (id),
	CONSTRAINT fk16vyeo68ng6h5n14phsb708uj FOREIGN KEY (tipo_id) REFERENCES afarma.tipodominio(id)
);


-- afarma.entregador_documento definition

-- Drop table

-- DROP TABLE afarma.entregador_documento;

CREATE TABLE afarma.entregador_documento (
	entregador_id varchar(36) NOT NULL,
	documento_id varchar(36) NOT NULL,
	CONSTRAINT fk157sb4thxa34cnm7gd6hvhljt FOREIGN KEY (entregador_id) REFERENCES afarma.entregador(id),
	CONSTRAINT fkqiwi88jo5mgh9iat3ulq0hdax FOREIGN KEY (documento_id) REFERENCES afarma.documento(id)
);


-- afarma.itenscot definition

-- Drop table

-- DROP TABLE afarma.itenscot;

CREATE TABLE afarma.itenscot (
	id varchar(36) NOT NULL,
	cotacao varchar(255) NULL,
	ean varchar(255) NULL,
	quantidade int4 NOT NULL,
	CONSTRAINT itenscot_pkey PRIMARY KEY (id),
	CONSTRAINT fkl0gr312akbsfsdd93hhro68ti FOREIGN KEY (cotacao) REFERENCES afarma.registrocotacao(id)
);


-- afarma.lead_itenscotados definition

-- Drop table

-- DROP TABLE afarma.lead_itenscotados;

CREATE TABLE afarma.lead_itenscotados (
	lead_id varchar(36) NOT NULL,
	item_id varchar(36) NOT NULL,
	CONSTRAINT fk1odb0t7o27m8l73foom5x5cx8 FOREIGN KEY (item_id) REFERENCES afarma.itemparacotacao(id),
	CONSTRAINT fkjuskovjuiyrps626sh4wyerht FOREIGN KEY (lead_id) REFERENCES afarma."lead"(id)
);


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


-- afarma.loja_entregador definition

-- Drop table

-- DROP TABLE afarma.loja_entregador;

CREATE TABLE afarma.loja_entregador (
	loja_id varchar(36) NOT NULL,
	entregador_id varchar(36) NOT NULL,
	CONSTRAINT fk672ceqyfxmvj7yq0ojlmldopt FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fki8uy47qtegkljh4pmj80c59xl FOREIGN KEY (entregador_id) REFERENCES afarma.entregador(id)
);


-- afarma.loja_percentual definition

-- Drop table

-- DROP TABLE afarma.loja_percentual;

CREATE TABLE afarma.loja_percentual (
	loja_id varchar(36) NOT NULL,
	percentual_id varchar(36) NOT NULL,
	CONSTRAINT fk2jlmmiesxhbe2thwfsd5pvf79 FOREIGN KEY (percentual_id) REFERENCES afarma.percentualrepasse(id),
	CONSTRAINT fkdw9vvl8b9ox141qx0kmeun91i FOREIGN KEY (loja_id) REFERENCES afarma.loja(id)
);


-- afarma.loja_proprietario definition

-- Drop table

-- DROP TABLE afarma.loja_proprietario;

CREATE TABLE afarma.loja_proprietario (
	loja_id varchar(36) NOT NULL,
	proprietario_id varchar(36) NOT NULL,
	CONSTRAINT fk35lgsvc2fng5t4xcw912abfng FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fks303okakm65vh3tqs2acln8xm FOREIGN KEY (proprietario_id) REFERENCES afarma.proprietario(id)
);


-- afarma.loja_telefone definition

-- Drop table

-- DROP TABLE afarma.loja_telefone;

CREATE TABLE afarma.loja_telefone (
	loja_id varchar(36) NOT NULL,
	telefone_id varchar(36) NOT NULL,
	CONSTRAINT fk2ehymhfxs3v1hbp1i65e8vxcp FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fknugdjjfhx9mkji9h2k1s9x2dq FOREIGN KEY (telefone_id) REFERENCES afarma.telefone(id)
);


-- afarma.loja_vendedor definition

-- Drop table

-- DROP TABLE afarma.loja_vendedor;

CREATE TABLE afarma.loja_vendedor (
	loja_id varchar(36) NOT NULL,
	vendedor_id varchar(36) NOT NULL,
	CONSTRAINT fk5xju9dneutvjxpa98nrk6aeti FOREIGN KEY (vendedor_id) REFERENCES afarma.vendedor(id),
	CONSTRAINT fk8iycvdf65hn6sm62vs5x7n5jf FOREIGN KEY (loja_id) REFERENCES afarma.loja(id)
);


-- afarma.paciente_documentos definition

-- Drop table

-- DROP TABLE afarma.paciente_documentos;

CREATE TABLE afarma.paciente_documentos (
	paciente_id varchar(36) NOT NULL,
	documento_id varchar(36) NOT NULL,
	CONSTRAINT uk_do7o4tlkwxllaotmr3fbjx5j2 UNIQUE (documento_id),
	CONSTRAINT fkbke5jml057aghtcvvu5c06d82 FOREIGN KEY (paciente_id) REFERENCES afarma.paciente(id),
	CONSTRAINT fkp99pn1yxurf4v743inb6wlv4r FOREIGN KEY (documento_id) REFERENCES afarma.documento(id)
);


-- afarma.paciente_receitas definition

-- Drop table

-- DROP TABLE afarma.paciente_receitas;

CREATE TABLE afarma.paciente_receitas (
	paciente_id varchar(36) NOT NULL,
	receita_id varchar(36) NOT NULL,
	CONSTRAINT uk_63os0i5j3giynd7cxql4urfya UNIQUE (receita_id),
	CONSTRAINT fk23u16q30kqkjv5u2ypfll1tyc FOREIGN KEY (paciente_id) REFERENCES afarma.paciente(id),
	CONSTRAINT fkrpnro1teco5jbpdb0krtnbbrs FOREIGN KEY (receita_id) REFERENCES afarma.receita(id)
);


-- afarma.produto definition

-- Drop table

-- DROP TABLE afarma.produto;

CREATE TABLE afarma.produto (
	id varchar(36) NOT NULL,
	contraindicacao varchar(10240) NULL,
	descricao varchar(10240) NULL,
	ean varchar(255) NULL,
	indicacao varchar(10240) NULL,
	lojapromocao varchar(255) NULL,
	nome varchar(10240) NULL,
	precomedio float8 NULL,
	categoria_id varchar(36) NULL,
	departamento_id varchar(36) NULL,
	grupo_id varchar(36) NULL,
	marca_id varchar(36) NULL,
	photo_id varchar(36) NULL,
	principioativo_id varchar(36) NULL,
	produto_tsv tsvector NULL,
	CONSTRAINT produto_pkey PRIMARY KEY (id),
	CONSTRAINT fk5cxb8e5gu3n2p6fngryqadr9t FOREIGN KEY (photo_id) REFERENCES afarma.photo(id),
	CONSTRAINT fk6lga45feiaeoljmlj8poje5yd FOREIGN KEY (departamento_id) REFERENCES afarma.dominio(id),
	CONSTRAINT fk770abs3iotndhmurdf5yhcjr7 FOREIGN KEY (marca_id) REFERENCES afarma.dominio(id),
	CONSTRAINT fk91liwnkojapf24vvcbmlhuip1 FOREIGN KEY (grupo_id) REFERENCES afarma.dominio(id),
	CONSTRAINT fkf4bxap8gam3bi2g0n9x1uc0e4 FOREIGN KEY (categoria_id) REFERENCES afarma.dominio(id),
	CONSTRAINT fkngj8i0y8uom9ft3d5dc76lt3q FOREIGN KEY (principioativo_id) REFERENCES afarma.dominio(id)
);


-- afarma.produtocrawler definition

-- Drop table

-- DROP TABLE afarma.produtocrawler;

CREATE TABLE afarma.produtocrawler (
	id varchar(36) NOT NULL,
	contraindicacao varchar(10240) NULL,
	descricao varchar(10240) NULL,
	ean varchar(10240) NULL,
	indicacao varchar(10240) NULL,
	nome varchar(10240) NULL,
	categoria_id varchar(36) NULL,
	departamento_id varchar(36) NOT NULL,
	marca_id varchar(36) NULL,
	photo_id varchar(36) NULL,
	principioativo_id varchar(36) NULL,
	produto_tsv tsvector NULL,
	CONSTRAINT produtocrawler_pkey PRIMARY KEY (id),
	CONSTRAINT fkamfmr7j1eatbljs7s093m0mtt FOREIGN KEY (photo_id) REFERENCES afarma.photo(id),
	CONSTRAINT fkb7mikdij11onlogwu120ht5kh FOREIGN KEY (departamento_id) REFERENCES afarma.departamento(id),
	CONSTRAINT fkojfoi6s0nxhrqc79m511ax0mu FOREIGN KEY (marca_id) REFERENCES afarma.marca(id),
	CONSTRAINT fksu0q8dnhupn9aqum3yd3n2c8p FOREIGN KEY (categoria_id) REFERENCES afarma.categoria(id)
);


-- afarma.promocao definition

-- Drop table

-- DROP TABLE afarma.promocao;

CREATE TABLE afarma.promocao (
	id varchar(36) NOT NULL,
	datafinal timestamp NULL,
	datainicial timestamp NULL,
	loja_id varchar(36) NULL,
	produto_id varchar(36) NULL,
	CONSTRAINT promocao_pkey PRIMARY KEY (id),
	CONSTRAINT fk4ynhwac9jxw969w9ofru1uw9u FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fkrh9pn023ukm40vydnasptf8d7 FOREIGN KEY (produto_id) REFERENCES afarma.produto(id)
);


-- afarma.proprietario_documento definition

-- Drop table

-- DROP TABLE afarma.proprietario_documento;

CREATE TABLE afarma.proprietario_documento (
	proprietario_id varchar(36) NOT NULL,
	documento_id varchar(36) NOT NULL,
	CONSTRAINT fk9r7tcg8imrctunodxgmb6nfg4 FOREIGN KEY (documento_id) REFERENCES afarma.documento(id),
	CONSTRAINT fkju1r7j5kpq3y6yoa6mxinfblt FOREIGN KEY (proprietario_id) REFERENCES afarma.proprietario(id)
);


-- afarma.rede_lojas definition

-- Drop table

-- DROP TABLE afarma.rede_lojas;

CREATE TABLE afarma.rede_lojas (
	rede_id varchar(36) NOT NULL,
	loja_id varchar(36) NOT NULL,
	CONSTRAINT fk5tcrcn03ig8w7f9ejgx0y7jdg FOREIGN KEY (rede_id) REFERENCES afarma.rede(id),
	CONSTRAINT fkopeecdqxox6wx4av0uj4dh3b9 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id)
);


-- afarma.repasse definition

-- Drop table

-- DROP TABLE afarma.repasse;

CREATE TABLE afarma.repasse (
	id varchar(36) NOT NULL,
	datafinal timestamp NULL,
	datainicial timestamp NULL,
	efetuado bool NOT NULL,
	valorrepasse float8 NULL,
	valortotalvendas float8 NULL,
	percentual_id varchar(36) NOT NULL,
	loja_id varchar(36) NULL,
	CONSTRAINT repasse_pkey PRIMARY KEY (id),
	CONSTRAINT fk6aer7qm1nal5nldssrq8lp8uo FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fkssux5h39bxxmcysxoqx4yhh15 FOREIGN KEY (percentual_id) REFERENCES afarma.percentualrepasse(id)
);


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

-- Table Triggers

create trigger update_codigo_ind after
insert
    on
    afarma.usuario for each row execute function usuario_codigo_ind();


-- afarma.vendedor_documento definition

-- Drop table

-- DROP TABLE afarma.vendedor_documento;

CREATE TABLE afarma.vendedor_documento (
	vendedor_id varchar(36) NOT NULL,
	documento_id varchar(36) NOT NULL,
	CONSTRAINT fk7qhmcb0vlqrirys2i5tufih3o FOREIGN KEY (documento_id) REFERENCES afarma.documento(id),
	CONSTRAINT fkrnvhio3g0uhhf7tf2gd1b9q9t FOREIGN KEY (vendedor_id) REFERENCES afarma.vendedor(id)
);


-- afarma.endereco_usuario definition

-- Drop table

-- DROP TABLE afarma.endereco_usuario;

CREATE TABLE afarma.endereco_usuario (
	usuario_id varchar(36) NOT NULL,
	endereco_id varchar(36) NOT NULL,
	CONSTRAINT fk48fht49aqu03oky1pqu7ug99y FOREIGN KEY (usuario_id) REFERENCES afarma.usuario(id),
	CONSTRAINT fkitvilkgun2i21jblrk2iiofqa FOREIGN KEY (endereco_id) REFERENCES afarma.endereco(id)
);


-- afarma.itemprodutocesta definition

-- Drop table

-- DROP TABLE afarma.itemprodutocesta;

CREATE TABLE afarma.itemprodutocesta (
	id varchar(36) NOT NULL,
	quantidade int4 NOT NULL,
	produto_id varchar(36) NULL,
	produtopromocao_id varchar(36) NULL,
	CONSTRAINT itemprodutocesta_pkey PRIMARY KEY (id),
	CONSTRAINT fk7151bwe3cxl36uu8bk2l87fo0 FOREIGN KEY (produtopromocao_id) REFERENCES afarma.produto(id),
	CONSTRAINT fkt0agrq9acnmxxhooyowq7qyr2 FOREIGN KEY (produto_id) REFERENCES afarma.produto(id)
);


-- afarma.loja_usuario definition

-- Drop table

-- DROP TABLE afarma.loja_usuario;

CREATE TABLE afarma.loja_usuario (
	loja_id varchar(36) NOT NULL,
	usuario_id varchar(36) NOT NULL,
	CONSTRAINT fkd2btut98mnog7s3hy7vojvta0 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id),
	CONSTRAINT fki5r4jc09oeemu6ooyq8un2bog FOREIGN KEY (usuario_id) REFERENCES afarma.usuario(id)
);


-- afarma.procuracao definition

-- Drop table

-- DROP TABLE afarma.procuracao;

CREATE TABLE afarma.procuracao (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	imageprocuracao bytea NULL,
	pacienteid varchar(36) NULL,
	usuarioid varchar(36) NULL,
	CONSTRAINT procuracao_pkey PRIMARY KEY (id),
	CONSTRAINT fk25h9nqyddhnwbuabbajiy8l69 FOREIGN KEY (pacienteid) REFERENCES afarma.paciente(id),
	CONSTRAINT fkah9r57kshucg9qd0gr4gikb3s FOREIGN KEY (usuarioid) REFERENCES afarma.usuario(id)
);


-- afarma.produtoconcorrente definition

-- Drop table

-- DROP TABLE afarma.produtoconcorrente;

CREATE TABLE afarma.produtoconcorrente (
	id varchar(36) NOT NULL,
	dataatualizacao timestamp NULL,
	ean varchar(255) NULL,
	url varchar(10240) NULL,
	valor float8 NULL,
	concorrente_id varchar(36) NOT NULL,
	produto_id varchar(36) NOT NULL,
	concorrente varchar(255) NULL,
	CONSTRAINT produtoconcorrente_pkey PRIMARY KEY (id),
	CONSTRAINT fk5oqv18t6pu8wl7v8pwb7n87cw FOREIGN KEY (produto_id) REFERENCES afarma.produtocrawler(id),
	CONSTRAINT fkrufiectuu75gs63ktxgx3dn34 FOREIGN KEY (concorrente_id) REFERENCES afarma.concorrente(id)
);


-- afarma.receita_produto definition

-- Drop table

-- DROP TABLE afarma.receita_produto;

CREATE TABLE afarma.receita_produto (
	receita_id varchar(36) NOT NULL,
	item_id varchar(36) NOT NULL,
	CONSTRAINT fkdohphs8dby6cp059yx5g5yq8b FOREIGN KEY (receita_id) REFERENCES afarma.receita(id),
	CONSTRAINT fksjavq09rl26bhvwowfhi909wv FOREIGN KEY (item_id) REFERENCES afarma.itemprodutocesta(id)
);


-- afarma.paciente_procuracao definition

-- Drop table

-- DROP TABLE afarma.paciente_procuracao;

CREATE TABLE afarma.paciente_procuracao (
	paciente_id varchar(36) NOT NULL,
	procuracao_id varchar(36) NOT NULL,
	CONSTRAINT uk_n19byqlaybfhdv483aghhopbo UNIQUE (procuracao_id),
	CONSTRAINT fk934ecaadbyhw91fylj1yyn9ke FOREIGN KEY (paciente_id) REFERENCES afarma.paciente(id),
	CONSTRAINT fks2t84rck4h1m1txww5cyx9g9n FOREIGN KEY (procuracao_id) REFERENCES afarma.procuracao(id)
);


-- afarma.alerta definition

-- Drop table

-- DROP TABLE afarma.alerta;

CREATE TABLE afarma.alerta (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	hora timestamp NULL,
	loja_id varchar(36) NULL,
	pedido_id varchar(36) NULL,
	CONSTRAINT alerta_pkey PRIMARY KEY (id)
);


-- afarma.alertapedidorecorrente definition

-- Drop table

-- DROP TABLE afarma.alertapedidorecorrente;

CREATE TABLE afarma.alertapedidorecorrente (
	id varchar(36) NOT NULL,
	dataalerta timestamp NULL,
	statusenvio bool NULL,
	pedido_inicial_id varchar(36) NULL,
	CONSTRAINT alertapedidorecorrente_pkey PRIMARY KEY (id)
);


-- afarma.cesta definition

-- Drop table

-- DROP TABLE afarma.cesta;

CREATE TABLE afarma.cesta (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	valortotaldacesta float8 NULL,
	cliente_id varchar(36) NULL,
	cotacao_id varchar(36) NULL,
	CONSTRAINT cesta_pkey PRIMARY KEY (id)
);


-- afarma.cotacaosql definition

-- Drop table

-- DROP TABLE afarma.cotacaosql;

CREATE TABLE afarma.cotacaosql (
	id varchar(36) NOT NULL,
	"data" timestamp NULL,
	"sql" varchar(255) NULL,
	cesta_id varchar(36) NULL,
	CONSTRAINT cotacaosql_pkey PRIMARY KEY (id)
);


-- afarma.distribuicao_alerta definition

-- Drop table

-- DROP TABLE afarma.distribuicao_alerta;

CREATE TABLE afarma.distribuicao_alerta (
	alerta_id varchar(36) NOT NULL,
	loja_id varchar(36) NOT NULL
);


-- afarma.item_cesta definition

-- Drop table

-- DROP TABLE afarma.item_cesta;

CREATE TABLE afarma.item_cesta (
	cesta_id varchar(36) NOT NULL,
	item_id varchar(36) NOT NULL
);


-- afarma.loja_pedido definition

-- Drop table

-- DROP TABLE afarma.loja_pedido;

CREATE TABLE afarma.loja_pedido (
	loja_id varchar(36) NOT NULL,
	pedido_id varchar(36) NOT NULL
);


-- afarma.pedido definition

-- Drop table

-- DROP TABLE afarma.pedido;

CREATE TABLE afarma.pedido (
	id varchar(36) NOT NULL,
	codigoind varchar(255) NULL,
	dataentrega timestamp NULL,
	datapedido timestamp NULL,
	formapagamento varchar(255) NULL,
	horaentrega timestamp NULL,
	ilpi bool NULL,
	motivocancelamento varchar(255) NULL,
	motivorejeicao varchar(255) NULL,
	observacao varchar(255) NULL,
	origempedido varchar(255) NULL,
	status varchar(255) NULL,
	troco float8 NOT NULL,
	valortotaldopedido float8 NULL,
	cesta_id varchar(36) NULL,
	cesta_alterada_id varchar(36) NULL,
	endereco_id varchar(36) NULL,
	loja_id varchar(36) NULL,
	CONSTRAINT pedido_pkey PRIMARY KEY (id)
);


-- afarma.venda definition

-- Drop table

-- DROP TABLE afarma.venda;

CREATE TABLE afarma.venda (
	id varchar(36) NOT NULL,
	dataentrega timestamp NULL,
	datavenda timestamp NULL,
	tipoentrega int4 NULL,
	total float8 NOT NULL,
	endereco_id varchar(36) NULL,
	entregador_id varchar(36) NULL,
	loja_id varchar(36) NULL,
	pedido_id varchar(36) NULL,
	vendedor_id varchar(36) NULL,
	CONSTRAINT venda_pkey PRIMARY KEY (id)
);


-- afarma.alerta foreign keys

ALTER TABLE afarma.alerta ADD CONSTRAINT fk7soe1f0dvunnrik2whd41k336 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);
ALTER TABLE afarma.alerta ADD CONSTRAINT fkk2ca97dclkptty65yhwp72bam FOREIGN KEY (pedido_id) REFERENCES afarma.pedido(id);


-- afarma.alertapedidorecorrente foreign keys

ALTER TABLE afarma.alertapedidorecorrente ADD CONSTRAINT fks31f3v8lj6k73ul0q1oa0l4y1 FOREIGN KEY (pedido_inicial_id) REFERENCES afarma.pedido(id);


-- afarma.cesta foreign keys

ALTER TABLE afarma.cesta ADD CONSTRAINT fkjw0b181se462ub7ckctukln4s FOREIGN KEY (cotacao_id) REFERENCES afarma.cotacaosql(id);
ALTER TABLE afarma.cesta ADD CONSTRAINT fko49usnik8smrfa1ucwwro25es FOREIGN KEY (cliente_id) REFERENCES afarma.usuario(id);


-- afarma.cotacaosql foreign keys

ALTER TABLE afarma.cotacaosql ADD CONSTRAINT fkq595f3igy2mdsbdrb7dlcy4ds FOREIGN KEY (cesta_id) REFERENCES afarma.cesta(id);


-- afarma.distribuicao_alerta foreign keys

ALTER TABLE afarma.distribuicao_alerta ADD CONSTRAINT fkb24umxengh1g4bs1v9qmsvc64 FOREIGN KEY (alerta_id) REFERENCES afarma.alerta(id);
ALTER TABLE afarma.distribuicao_alerta ADD CONSTRAINT fkn5qbqmmrr7pnnsumudv38rnkk FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);


-- afarma.item_cesta foreign keys

ALTER TABLE afarma.item_cesta ADD CONSTRAINT fkb3h3sv2gd7w9l8wiarwbvw4nb FOREIGN KEY (item_id) REFERENCES afarma.itemprodutocesta(id);
ALTER TABLE afarma.item_cesta ADD CONSTRAINT fktq9s7cgrjyhpgdo1triop4b7l FOREIGN KEY (cesta_id) REFERENCES afarma.cesta(id);


-- afarma.loja_pedido foreign keys

ALTER TABLE afarma.loja_pedido ADD CONSTRAINT fkc5jgrirne7e828rq9mrs8kt57 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);
ALTER TABLE afarma.loja_pedido ADD CONSTRAINT fkllkn385wuf56adr9sw47653a0 FOREIGN KEY (pedido_id) REFERENCES afarma.pedido(id);


-- afarma.pedido foreign keys

ALTER TABLE afarma.pedido ADD CONSTRAINT fk5plmsxy4s1bvlf1aeolsu9m2d FOREIGN KEY (cesta_id) REFERENCES afarma.cesta(id);
ALTER TABLE afarma.pedido ADD CONSTRAINT fk6a4snne4m674sewarh8gf72sw FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);
ALTER TABLE afarma.pedido ADD CONSTRAINT fk6wdba1avarar4rikh5v6rke1l FOREIGN KEY (endereco_id) REFERENCES afarma.endereco(id);
ALTER TABLE afarma.pedido ADD CONSTRAINT fke2o14y204r47x07r2id68qc3a FOREIGN KEY (cesta_alterada_id) REFERENCES afarma.cesta(id);


-- afarma.venda foreign keys

ALTER TABLE afarma.venda ADD CONSTRAINT fk296brvvpok33jrtv7dem8qse2 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);
ALTER TABLE afarma.venda ADD CONSTRAINT fk9w726k9pcn21t7f9n6tqvlo0p FOREIGN KEY (pedido_id) REFERENCES afarma.pedido(id);
ALTER TABLE afarma.venda ADD CONSTRAINT fkay1rxv2k23nky2kgkfp3tseqx FOREIGN KEY (entregador_id) REFERENCES afarma.entregador(id);
ALTER TABLE afarma.venda ADD CONSTRAINT fkm41ogg6f23qj5d1dquauo81d3 FOREIGN KEY (endereco_id) REFERENCES afarma.endereco(id);
ALTER TABLE afarma.venda ADD CONSTRAINT fkrbtidqm7plo38vfqqkil0wy1c FOREIGN KEY (vendedor_id) REFERENCES afarma.vendedor(id);



CREATE OR REPLACE FUNCTION afarma.cotacao(cotid character varying, percentual double precision, desconto double precision)
 RETURNS SETOF afarma.cotacaotitem
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.cotacaotitem%ROWTYPE;
BEGIN

 	FOR itens in

SELECT cast(uuid_generate_v4() as varchar) as id
	,i.*
FROM (
	(
		SELECT i.concorrente
			,i.cotacao as cotacao_id
			,ROUND(CAST(sum(i.total) AS numeric),2) AS total
		FROM (
			SELECT i.*
				,(i.quantidade * i.valor) AS total
			FROM (
				SELECT i.concorrente
					,i.cotacao
					,i.ean
					,i.quantidade
					,(
						CASE 
							WHEN i.valor isnull
								THEN i.precomedio
							WHEN i.valor < i.segundomenor * 0.20
								THEN i.segundomenor
							ELSE i.valor
							END
						) AS valor
				FROM (
					SELECT i.*
						,p.segundomenor
					FROM (
						SELECT i.*
							,po.precomedio
						FROM (
							SELECT i.*
								,pc.valor
							FROM (
								SELECT *
								FROM (
									SELECT c.concorrente
										,c.id AS concorrente_id
									FROM afarma.concorrentes_estados ce
										,afarma.concorrente c
									WHERE c.id = ce.concorrente_id
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = cotid)
									) c
								CROSS JOIN (
									SELECT i.cotacao
										,(
											CASE 
												WHEN i.menor isnull
													THEN i.ean
												ELSE i.menor
												END
											) AS ean
										,i.quantidade
									FROM (
										SELECT *
										FROM (
											SELECT i.ean
												,i.cotacao
												,i.quantidade
											FROM afarma.itenscot i
											WHERE i.cotacao = cotid
											) i
										CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
										) i
									) i
								) i
							LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
								AND pc.concorrente_id = i.concorrente_id
							) i
						LEFT JOIN (
							SELECT pc.ean
								,avg(nullif(pc.valor, 0)) AS precomedio
							FROM afarma.produtoconcorrente pc
							GROUP BY pc.ean
							) po ON po.ean = i.ean
						) i
					LEFT JOIN (
						SELECT p.ean
							,min(p.valor) AS segundomenor
						FROM (
							SELECT pc.ean
								,pc.valor
								,p.min
							FROM afarma.produtoconcorrente pc
							LEFT JOIN (
								SELECT pc.ean
									,min(pc.valor)
								FROM afarma.produtoconcorrente pc
								GROUP BY pc.ean
								) p ON pc.ean = p.ean
							) p
						WHERE p.valor > p.min
						GROUP BY p.ean
						) p ON p.ean = i.ean
					) i
				) i
			) i
		GROUP BY i.concorrente
			,i.cotacao
		)
	
	UNION ALL
	
	(
		SELECT 'aFarma'
			,i.cotacao
			,((min(i.totalporloja) - (coalesce(desconto, 0))) * ((100 - (cast(coalesce(percentual, 0) AS FLOAT))) / (100)))
		FROM (
			SELECT i.concorrente
				,i.cotacao
				,sum(i.total) AS totalporloja
			FROM (
				SELECT i.*
					,(i.quantidade * i.valor) AS total
				FROM (
					SELECT i.concorrente
						,i.cotacao
						,i.ean
						,i.quantidade
						,(
							CASE 
								WHEN i.valor isnull
									THEN i.precomedio
								WHEN i.valor < i.segundomenor * 0.20
									THEN i.segundomenor
								ELSE i.valor
								END
							) AS valor
					FROM (
						SELECT i.*
							,p.segundomenor
						FROM (
							SELECT i.*
								,po.precomedio
							FROM (
								SELECT i.*
									,pc.valor
								FROM (
									SELECT *
									FROM (
										SELECT c.concorrente
											,c.id AS concorrente_id
										FROM afarma.concorrentes_estados ce
											,afarma.concorrente c
										WHERE c.id = ce.concorrente_id
											AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = cotid)
										) c
									CROSS JOIN (
										SELECT i.cotacao
											,(
												CASE 
													WHEN i.menor isnull
														THEN i.ean
													ELSE i.menor
													END
												) AS ean
											,i.quantidade
										FROM (
											SELECT *
											FROM (
												SELECT i.ean
													,i.cotacao
													,i.quantidade
												FROM afarma.itenscot i
												WHERE i.cotacao = cotid
												) i
											CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
											) i
										) i
									) i
								LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
									AND pc.concorrente_id = i.concorrente_id
								) i
							LEFT JOIN (
								SELECT pc.ean
									,avg(nullif(pc.valor, 0)) AS precomedio
								FROM afarma.produtoconcorrente pc
								GROUP BY pc.ean
								) po ON po.ean = i.ean
							) i
						LEFT JOIN (
							SELECT p.ean
								,min(p.valor) AS segundomenor
							FROM (
								SELECT pc.ean
									,pc.valor
									,p.min
								FROM afarma.produtoconcorrente pc
								LEFT JOIN (
									SELECT pc.ean
										,min(pc.valor)
									FROM afarma.produtoconcorrente pc
									GROUP BY pc.ean
									) p ON pc.ean = p.ean
								) p
							WHERE p.valor > p.min
							GROUP BY p.ean
							) p ON p.ean = i.ean
						) i
					) i
				) i
			GROUP BY i.concorrente
				,i.cotacao
			) i
		GROUP BY i.cotacao
		)
	) i
	
	
		loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION afarma.cotacaodetalhado(cotid character varying)
 RETURNS SETOF afarma.ctitemdetalhadonovo
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.ctitemdetalhadoNOVO%ROWTYPE;
BEGIN

 	FOR itens in


	SELECT cast(uuid_generate_v4() as varchar) as id
	,i.*
FROM (
	SELECT (
			CASE 
				WHEN po.nome isnull
					THEN gr.nome_grupo
				ELSE po.nome
				END
			) AS nome
		,i.*
	FROM (
		(
			SELECT i.*
				,(i.valor * i.quantidade) AS total
			FROM (
				SELECT (
						CASE 
							WHEN i.valor = i.valorminimo
								THEN CONCAT (
										i.concorrente
										,'*'
										)
							ELSE i.concorrente
							END
						) AS concorrente
					,i.cotacao
					,i.ean
					,i.quantidade
					,i.url
					,(
						CASE 
							WHEN i.valor isnull
								THEN i.precomedio
							WHEN i.valor < i.segundomenor * 0.80
								THEN i.segundomenor
							ELSE i.valor
							END
						) AS valor
				FROM (
					SELECT i.*
						,m.valorminimo
					FROM (
						SELECT i.*
							,p.segundomenor
						FROM (
							SELECT i.*
								,po.precomedio
							FROM (
								SELECT i.*
									,pc.valor, pc.url
								FROM (
									SELECT *
									FROM (
										SELECT c.concorrente
											,c.id AS concorrente_id
										FROM afarma.concorrentes_estados ce
											,afarma.concorrente c
										WHERE c.id = ce.concorrente_id
											AND ce.uf = (
												SELECT r.uf
												FROM afarma.registrocotacao r
												WHERE r.id = cotid
												)
										) c
									CROSS JOIN (
										SELECT i.cotacao
											,(
												CASE 
													WHEN i.menor isnull
														THEN i.ean
													ELSE i.menor
													END
												) AS ean
											,i.quantidade
										FROM (
											SELECT *
											FROM (
												SELECT i.ean
													,i.cotacao
													,i.quantidade
												FROM afarma.itenscot i
												WHERE i.cotacao = cotid
												) i
											CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
											) i
										) i
									) i
								LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
									AND pc.concorrente_id = i.concorrente_id
								) i
							LEFT JOIN (
								SELECT pc.ean
									,avg(nullif(pc.valor, 0)) AS precomedio
								FROM afarma.produtoconcorrente pc
								GROUP BY pc.ean
								) po ON po.ean = i.ean
							) i
						LEFT JOIN (
							SELECT p.ean
								,min(p.valor) AS segundomenor
							FROM (
								SELECT pc.ean
									,pc.valor
									,p.min
								FROM afarma.produtoconcorrente pc
								LEFT JOIN (
									SELECT pc.ean
										,min(pc.valor)
									FROM afarma.produtoconcorrente pc
									GROUP BY pc.ean
									) p ON pc.ean = p.ean
								) p
							WHERE p.valor > p.min
							GROUP BY p.ean
							) p ON p.ean = i.ean
						) i
					LEFT JOIN (
						SELECT i.cotacao
							,i.ean
							,min(i.valor) AS valorminimo
						FROM (
							SELECT i.concorrente
								,i.cotacao
								,i.ean
								,i.quantidade
								,(
									CASE 
										WHEN i.valor isnull
											THEN i.precomedio
										WHEN i.valor < i.segundomenor * 0.80
											THEN i.segundomenor
										ELSE i.valor
										END
									) AS valor
							FROM (
								SELECT i.*
									,p.segundomenor
								FROM (
									SELECT i.*
										,po.precomedio
									FROM (
										SELECT i.*
											,pc.valor
										FROM (
											SELECT *
											FROM (
												SELECT c.concorrente
													,c.id AS concorrente_id
												FROM afarma.concorrentes_estados ce
													,afarma.concorrente c
												WHERE c.id = ce.concorrente_id
													AND ce.uf = (
														SELECT r.uf
														FROM afarma.registrocotacao r
														WHERE r.id = cotid
														)
												) c
											CROSS JOIN (
												SELECT i.cotacao
													,(
														CASE 
															WHEN i.menor isnull
																THEN i.ean
															ELSE i.menor
															END
														) AS ean
													,i.quantidade
												FROM (
													SELECT *
													FROM (
														SELECT i.ean
															,i.cotacao
															,i.quantidade
														FROM afarma.itenscot i
														WHERE i.cotacao = cotid
														) i
													CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
													) i
												) i
											) i
										LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
											AND pc.concorrente_id = i.concorrente_id
										) i
									LEFT JOIN (
										SELECT pc.ean
											,avg(nullif(pc.valor, 0)) AS precomedio
										FROM afarma.produtoconcorrente pc
										GROUP BY pc.ean
										) po ON po.ean = i.ean
									) i
								LEFT JOIN (
									SELECT p.ean
										,min(p.valor) AS segundomenor
									FROM (
										SELECT pc.ean
											,pc.valor
											,p.min
										FROM afarma.produtoconcorrente pc
										LEFT JOIN (
											SELECT pc.ean
												,min(pc.valor)
											FROM afarma.produtoconcorrente pc
											GROUP BY pc.ean
											) p ON pc.ean = p.ean
										) p
									WHERE p.valor > p.min
									GROUP BY p.ean
									) p ON p.ean = i.ean
								) i
							) i
						GROUP BY i.cotacao
							,i.ean
						) m ON m.ean = i.ean
					) i
				) i
			)
		
		UNION ALL
		
		(
			SELECT i.*
				,((i.precomedio/*-(descontoitem)*/) * i.quantidade)
			FROM (
				SELECT 'aFarma' AS loja
					,i.cotacao
					,i.ean
					,i.quantidade
					, 'https://www.afarma.app.br' as url
					,po.precomedio
				FROM (
					SELECT i.*
						,pc.valor, pc.url
					FROM (
						SELECT *
						FROM (
							SELECT c.concorrente
								,c.id AS concorrente_id
							FROM afarma.concorrentes_estados ce
								,afarma.concorrente c
							WHERE c.id = ce.concorrente_id
								AND ce.uf = (
									SELECT r.uf
									FROM afarma.registrocotacao r
									WHERE r.id = cotid
									)
							) c
						CROSS JOIN (
							SELECT i.cotacao
								,(
									CASE 
										WHEN i.menor isnull
											THEN i.ean
										ELSE i.menor
										END
									) AS ean
								,i.quantidade
							FROM (
								SELECT *
								FROM (
									SELECT i.ean
										,i.cotacao
										,i.quantidade
									FROM afarma.itenscot i
									WHERE i.cotacao = cotid
									) i
								CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
								) i
							) i
						) i
					LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
						AND pc.concorrente_id = i.concorrente_id
					) i
				LEFT JOIN (
					SELECT pc.ean
						,avg(nullif(pc.valor, 0)) AS precomedio
					FROM afarma.produtoconcorrente pc
					GROUP BY pc.ean
					) po ON po.ean = i.ean
				) i
			GROUP BY i.loja
				,i.cotacao
				,i.ean
				,i.quantidade
				,i.url
				,i.precomedio
			)
		) i
	LEFT JOIN (
		SELECT max(po.nome) AS nome
			,po.ean
		FROM PUBLIC.produtos_all_otimizado_ilpi_rj po
		GROUP BY po.ean
		) po ON po.ean = i.ean
	LEFT JOIN PUBLIC.genericos_ref gr ON gr.ean = i.ean
	) i
GROUP BY i.nome
	,i.concorrente
	,i.cotacao
	,i.ean
	,i.quantidade
	,i.url
	,i.valor
	,i.total
	
		loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION afarma.cotacaoiai(cotid character varying)
 RETURNS SETOF afarma.cotacaotitem
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.cotacaotitem%ROWTYPE;
BEGIN

 	FOR itens in


SELECT uuid_generate_v4()
	,i.*
FROM (
	(
		SELECT i.concorrente
			,i.cotacao as cotacao_id
			,ROUND(CAST(sum(i.total) AS numeric),2) AS total 
		FROM (
			SELECT i.*
				,(i.quantidade * i.valor) AS total
			FROM (
				SELECT i.concorrente
					,i.cotacao
					,i.ean
					,i.quantidade
					,(
						CASE 
							WHEN i.valor isnull
								THEN i.precomedio
							WHEN i.valor < i.segundomenor * 0.80
								THEN i.segundomenor
							ELSE i.valor
							END
						) AS valor
				FROM (
					SELECT i.*
						,p.segundomenor
					FROM (
						SELECT i.*
							,po.precomedio
						FROM (
							SELECT i.*
								,pc.valor
							FROM (
								SELECT *
								FROM (
									SELECT c.concorrente
										,c.id AS concorrente_id
									FROM afarma.concorrentes_estados ce
										,afarma.concorrente c
									WHERE c.id = ce.concorrente_id
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = cotid)
									) c
								CROSS JOIN (
									SELECT i.cotacao
										,(
											CASE 
												WHEN i.menor isnull
													THEN i.ean
												ELSE i.menor
												END
											) AS ean
										,i.quantidade
									FROM (
										SELECT *
										FROM (
											SELECT i.ean
												,i.cotacao
												,i.quantidade
											FROM afarma.itenscot i
											WHERE i.cotacao = cotid
											) i
										CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
										) i
									) i
								) i
							LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
								AND pc.concorrente_id = i.concorrente_id
							) i
						LEFT JOIN (
							SELECT pc.ean
								,avg(nullif(pc.valor, 0)) AS precomedio
							FROM afarma.produtoconcorrente pc
							GROUP BY pc.ean
							) po ON po.ean = i.ean
						) i
					LEFT JOIN (
						SELECT p.ean
							,min(p.valor) AS segundomenor
						FROM (
							SELECT pc.ean
								,pc.valor
								,p.min
							FROM afarma.produtoconcorrente pc
							LEFT JOIN (
								SELECT pc.ean
									,min(pc.valor)
								FROM afarma.produtoconcorrente pc
								GROUP BY pc.ean
								) p ON pc.ean = p.ean
							) p
						WHERE p.valor > p.min
						GROUP BY p.ean
						) p ON p.ean = i.ean
					) i
				) i
			) i
		GROUP BY i.concorrente
			,i.cotacao
		)
	
	UNION ALL
	
	(
		SELECT 'aFarma'
			,i.cotacao
			,sum(i.total) AS totalporloja
		FROM (
			SELECT i.cotacao
				,i.ean
				,min(i.quantidade * (i.valor-(/*descontoitem*/ 1))) AS total
			FROM (
				SELECT i.concorrente
					,i.cotacao
					,i.ean
					,i.quantidade
					,(
						CASE 
							WHEN i.valor isnull
								THEN i.precomedio
							WHEN i.valor < i.segundomenor * 0.80
								THEN i.segundomenor
							ELSE i.valor
							END
						) AS valor
				FROM (
					SELECT i.*
						,p.segundomenor
					FROM (
						SELECT i.*
							,po.precomedio
						FROM (
							SELECT i.*
								,pc.valor
							FROM (
								SELECT *
								FROM (
									SELECT c.concorrente
										,c.id AS concorrente_id
									FROM afarma.concorrentes_estados ce
										,afarma.concorrente c
									WHERE c.id = ce.concorrente_id
										AND ce.uf = (select r.uf from afarma.registrocotacao r where r.id = cotid)
									) c
								CROSS JOIN (
									SELECT i.cotacao
										,(
											CASE 
												WHEN i.menor isnull
													THEN i.ean
												ELSE i.menor
												END
											) AS ean
										,i.quantidade
									FROM (
										SELECT *
										FROM (
											SELECT i.ean
												,i.cotacao
												,i.quantidade
											FROM afarma.itenscot i
											WHERE i.cotacao = cotid
											) i
										CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
										) i
									) i
								) i
							LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
								AND pc.concorrente_id = i.concorrente_id
							) i
						LEFT JOIN (
							SELECT pc.ean
								,avg(nullif(pc.valor, 0)) AS precomedio
							FROM afarma.produtoconcorrente pc
							GROUP BY pc.ean
							) po ON po.ean = i.ean
						) i
					LEFT JOIN (
						SELECT p.ean
							,min(p.valor) AS segundomenor
						FROM (
							SELECT pc.ean
								,pc.valor
								,p.min
							FROM afarma.produtoconcorrente pc
							LEFT JOIN (
								SELECT pc.ean
									,min(pc.valor)
								FROM afarma.produtoconcorrente pc
								GROUP BY pc.ean
								) p ON pc.ean = p.ean
							) p
						WHERE p.valor > p.min
						GROUP BY p.ean
						) p ON p.ean = i.ean
					) i
				) i
			GROUP BY i.cotacao
				,i.ean
			) i
		GROUP BY i.cotacao
		)
	) i
	
	
	loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION afarma.cotacaoiaidetalhado(cotid character varying)
 RETURNS SETOF afarma.ctitemdetalhado
 LANGUAGE plpgsql
AS $function$
   DECLARE
      itens afarma.ctitemdetalhado%ROWTYPE;
BEGIN

 	FOR itens in


	SELECT uuid_generate_v4()
	,i.*
FROM (
	SELECT (
			CASE 
				WHEN po.nome isnull
					THEN gr.nome_grupo
				ELSE po.nome
				END
			) AS nome
		,i.*
	FROM (
		(
			SELECT i.*
				,(i.valor * i.quantidade) AS total
			FROM (
				SELECT (
						CASE 
							WHEN i.valor = i.valorminimo
								THEN CONCAT (
										i.concorrente
										,'*'
										)
							ELSE i.concorrente
							END
						) AS concorrente
					,i.cotacao
					,i.ean
					,i.quantidade
					,i.url
					,(
						CASE 
							WHEN i.valor isnull
								THEN i.precomedio
							WHEN i.valor < i.segundomenor * 0.80
								THEN i.segundomenor
							ELSE i.valor
							END
						) AS valor
				FROM (
					SELECT i.*
						,m.valorminimo
					FROM (
						SELECT i.*
							,p.segundomenor
						FROM (
							SELECT i.*
								,po.precomedio
							FROM (
								SELECT i.*
									,pc.valor, pc.url
								FROM (
									SELECT *
									FROM (
										SELECT c.concorrente
											,c.id AS concorrente_id
										FROM afarma.concorrentes_estados ce
											,afarma.concorrente c
										WHERE c.id = ce.concorrente_id
											AND ce.uf = (
												SELECT r.uf
												FROM afarma.registrocotacao r
												WHERE r.id = cotid
												)
										) c
									CROSS JOIN (
										SELECT i.cotacao
											,(
												CASE 
													WHEN i.menor isnull
														THEN i.ean
													ELSE i.menor
													END
												) AS ean
											,i.quantidade
										FROM (
											SELECT *
											FROM (
												SELECT i.ean
													,i.cotacao
													,i.quantidade
												FROM afarma.itenscot i
												WHERE i.cotacao = cotid
												) i
											CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
											) i
										) i
									) i
								LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
									AND pc.concorrente_id = i.concorrente_id
								) i
							LEFT JOIN (
								SELECT pc.ean
									,avg(nullif(pc.valor, 0)) AS precomedio
								FROM afarma.produtoconcorrente pc
								GROUP BY pc.ean
								) po ON po.ean = i.ean
							) i
						LEFT JOIN (
							SELECT p.ean
								,min(p.valor) AS segundomenor
							FROM (
								SELECT pc.ean
									,pc.valor
									,p.min
								FROM afarma.produtoconcorrente pc
								LEFT JOIN (
									SELECT pc.ean
										,min(pc.valor)
									FROM afarma.produtoconcorrente pc
									GROUP BY pc.ean
									) p ON pc.ean = p.ean
								) p
							WHERE p.valor > p.min
							GROUP BY p.ean
							) p ON p.ean = i.ean
						) i
					LEFT JOIN (
						SELECT i.cotacao
							,i.ean
							,min(i.valor) AS valorminimo
						FROM (
							SELECT i.concorrente
								,i.cotacao
								,i.ean
								,i.quantidade
								,(
									CASE 
										WHEN i.valor isnull
											THEN i.precomedio
										WHEN i.valor < i.segundomenor * 0.80
											THEN i.segundomenor
										ELSE i.valor
										END
									) AS valor
							FROM (
								SELECT i.*
									,p.segundomenor
								FROM (
									SELECT i.*
										,po.precomedio
									FROM (
										SELECT i.*
											,pc.valor
										FROM (
											SELECT *
											FROM (
												SELECT c.concorrente
													,c.id AS concorrente_id
												FROM afarma.concorrentes_estados ce
													,afarma.concorrente c
												WHERE c.id = ce.concorrente_id
													AND ce.uf = (
														SELECT r.uf
														FROM afarma.registrocotacao r
														WHERE r.id = cotid
														)
												) c
											CROSS JOIN (
												SELECT i.cotacao
													,(
														CASE 
															WHEN i.menor isnull
																THEN i.ean
															ELSE i.menor
															END
														) AS ean
													,i.quantidade
												FROM (
													SELECT *
													FROM (
														SELECT i.ean
															,i.cotacao
															,i.quantidade
														FROM afarma.itenscot i
														WHERE i.cotacao = cotid
														) i
													CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
													) i
												) i
											) i
										LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
											AND pc.concorrente_id = i.concorrente_id
										) i
									LEFT JOIN (
										SELECT pc.ean
											,avg(nullif(pc.valor, 0)) AS precomedio
										FROM afarma.produtoconcorrente pc
										GROUP BY pc.ean
										) po ON po.ean = i.ean
									) i
								LEFT JOIN (
									SELECT p.ean
										,min(p.valor) AS segundomenor
									FROM (
										SELECT pc.ean
											,pc.valor
											,p.min
										FROM afarma.produtoconcorrente pc
										LEFT JOIN (
											SELECT pc.ean
												,min(pc.valor)
											FROM afarma.produtoconcorrente pc
											GROUP BY pc.ean
											) p ON pc.ean = p.ean
										) p
									WHERE p.valor > p.min
									GROUP BY p.ean
									) p ON p.ean = i.ean
								) i
							) i
						GROUP BY i.cotacao
							,i.ean
						) m ON m.ean = i.ean
					) i
				) i
			)
		
		UNION ALL
		
		(
			SELECT i.*
				,((i.precomedio/*-(descontoitem)*/) * i.quantidade)
			FROM (
				SELECT 'aFarma' AS loja
					,i.cotacao
					,i.ean
					,i.quantidade
					, 'https://www.afarma.app.br' as url
					,po.precomedio
				FROM (
					SELECT i.*
						,pc.valor, pc.url
					FROM (
						SELECT *
						FROM (
							SELECT c.concorrente
								,c.id AS concorrente_id
							FROM afarma.concorrentes_estados ce
								,afarma.concorrente c
							WHERE c.id = ce.concorrente_id
								AND ce.uf = (
									SELECT r.uf
									FROM afarma.registrocotacao r
									WHERE r.id = cotid
									)
							) c
						CROSS JOIN (
							SELECT i.cotacao
								,(
									CASE 
										WHEN i.menor isnull
											THEN i.ean
										ELSE i.menor
										END
									) AS ean
								,i.quantidade
							FROM (
								SELECT *
								FROM (
									SELECT i.ean
										,i.cotacao
										,i.quantidade
									FROM afarma.itenscot i
									WHERE i.cotacao = cotid
									) i
								CROSS JOIN lateral afarma.menor_preco_grupo_crawler(i.ean) AS menor
								) i
							) i
						) i
					LEFT JOIN afarma.produtoconcorrente pc ON pc.ean = i.ean
						AND pc.concorrente_id = i.concorrente_id
					) i
				LEFT JOIN (
					SELECT pc.ean
						,avg(nullif(pc.valor, 0)) AS precomedio
					FROM afarma.produtoconcorrente pc
					GROUP BY pc.ean
					) po ON po.ean = i.ean
				) i
			GROUP BY i.loja
				,i.cotacao
				,i.ean
				,i.quantidade
				,i.url
				,i.precomedio
			)
		) i
	LEFT JOIN (
		SELECT max(po.nome) AS nome
			,po.ean
		FROM PUBLIC.produtos_all_otimizado_ilpi_rj po
		GROUP BY po.ean
		) po ON po.ean = i.ean
	LEFT JOIN PUBLIC.genericos_ref gr ON gr.ean = i.ean
	) i
GROUP BY i.nome
	,i.concorrente
	,i.cotacao
	,i.ean
	,i.quantidade
	,i.url
	,i.valor
	,i.total
	
		loop
		RETURN NEXT itens;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION afarma.menor_preco_grupo(ean_generico character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   generico_ean varchar;
begin
	
	select
(case when
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = ean_generico)
and gr.ean=pc.ean
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) isnull then 
(select ean_generico)
else 
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = ean_generico)
and gr.ean=pc.ean
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) end)

into generico_ean;
   
   return generico_ean;
end;
$function$
;

CREATE OR REPLACE FUNCTION afarma.menor_preco_grupo_crawler(ean_generico character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   generico_ean varchar;
begin
	
	select
(case when
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = ean_generico)
and gr.ean=pc.ean
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) isnull then 
(select ean_generico)
else 
(
select p.ean from 
(
select gr.ean, avg(nullif(pc.valor,0)) as precomedio
from public.genericos_ref gr, afarma.produtoconcorrente pc
where gr.grupo = (select distinct(gr.grupo) from genericos_ref gr where gr.ean = ean_generico)
and gr.ean=pc.ean
group by gr.ean 
order by precomedio asc
limit 2) p
offset 1) end)

into generico_ean;
   
   return generico_ean;
end;
$function$
;


-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

-- DROP TYPE gtrgm;

CREATE TYPE gtrgm (
	INPUT = gtrgm_in,
	OUTPUT = gtrgm_out,
	ALIGNMENT = 4,
	STORAGE = plain,
	CATEGORY = U,
	DELIMITER = ',');

-- DROP SEQUENCE public.perfil_id_seq;

CREATE SEQUENCE public.perfil_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.versao_id_seq;

CREATE SEQUENCE public.versao_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;-- public.citem definition

-- Drop table

-- DROP TABLE public.citem;

CREATE TABLE public.citem (
	id varchar(36) NOT NULL,
	concorrente varchar(255) NULL,
	cotacao_id varchar(255) NULL,
	total float8 NULL,
	CONSTRAINT citem_pkey PRIMARY KEY (id)
);


-- public.citemdetalhado definition

-- Drop table

-- DROP TABLE public.citemdetalhado;

CREATE TABLE public.citemdetalhado (
	id varchar(36) NOT NULL,
	concorrente varchar(255) NULL,
	cotacao_id varchar(255) NULL,
	ean varchar(255) NULL,
	nome varchar(255) NULL,
	quantidade float8 NOT NULL,
	total float8 NOT NULL,
	url varchar(255) NULL,
	valor float8 NOT NULL,
	CONSTRAINT citemdetalhado_pkey PRIMARY KEY (id)
);


-- public.ean_ref definition

-- Drop table

-- DROP TABLE public.ean_ref;

CREATE TABLE public.ean_ref (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	ean varchar(10240) NULL,
	nome varchar(10240) NULL
);


-- public.generico_grupo definition

-- Drop table

-- DROP TABLE public.generico_grupo;

CREATE TABLE public.generico_grupo (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	grupo varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT generico_grupo_un UNIQUE (grupo)
);


-- public.genericos_ref definition

-- Drop table

-- DROP TABLE public.genericos_ref;

CREATE TABLE public.genericos_ref (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	grupo varchar(255) NULL,
	"name" varchar(10240) NULL,
	ean varchar(255) NULL,
	brand varchar(255) NULL,
	nome_grupo varchar NULL
);


-- public.ilpi definition

-- Drop table

-- DROP TABLE public.ilpi;

CREATE TABLE public.ilpi (
	id varchar(36) NOT NULL,
	cnpj varchar(255) NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	pessoacontato varchar(255) NULL,
	telefone varchar(255) NULL,
	CONSTRAINT ilpi_pkey PRIMARY KEY (id)
);


-- public.product definition

-- Drop table

-- DROP TABLE public.product;

CREATE TABLE public.product (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	active_ingredient varchar(10240) NULL,
	brand varchar(10240) NULL,
	category varchar(10240) NULL,
	contraindication varchar(10240) NULL,
	created_date timestamp NOT NULL,
	department _text NULL,
	description varchar(10240) NULL,
	ean varchar(255) NULL,
	"implementation" varchar(255) NOT NULL,
	indication varchar(10240) NULL,
	"name" varchar(2048) NOT NULL,
	photo bytea NULL,
	pathimage varchar NULL,
	price float4 NOT NULL,
	related_products _text NULL,
	retencao_receita varchar(255) NULL,
	updated_date timestamp NOT NULL,
	url varchar(10240) NOT NULL,
	CONSTRAINT product_pkey PRIMARY KEY (id),
	CONSTRAINT ukojskdxmdefkuhlt9i0389ehl7 UNIQUE (ean, implementation)
);


-- public.product_comparacao definition

-- Drop table

-- DROP TABLE public.product_comparacao;

CREATE TABLE public.product_comparacao (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	"name" varchar(10240) NULL,
	ean varchar(255) NULL,
	marca varchar(10240) NULL,
	url varchar(10240) NULL,
	"implementation" varchar(10240) NULL
);


-- public.product_ref definition

-- Drop table

-- DROP TABLE public.product_ref;

CREATE TABLE public.product_ref (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	"name" varchar(255) NULL,
	ean varchar(255) NULL,
	brand varchar(255) NULL,
	grupo varchar(255) NULL,
	category varchar(255) NULL,
	description varchar(10240) NULL,
	CONSTRAINT product_ref_pkey PRIMARY KEY (id)
);


-- public.totalizadordto definition

-- Drop table

-- DROP TABLE public.totalizadordto;

CREATE TABLE public.totalizadordto (
	id varchar(36) NOT NULL,
	total int4 NOT NULL,
	CONSTRAINT totalizadordto_pkey PRIMARY KEY (id)
);


-- public.totalizadormesdto definition

-- Drop table

-- DROP TABLE public.totalizadormesdto;

CREATE TABLE public.totalizadormesdto (
	id varchar(36) NOT NULL,
	ano varchar(255) NULL,
	mes varchar(255) NULL,
	total int4 NOT NULL,
	CONSTRAINT totalizadormesdto_pkey PRIMARY KEY (id)
);


-- public.totalizadorporstatusdto definition

-- Drop table

-- DROP TABLE public.totalizadorporstatusdto;

CREATE TABLE public.totalizadorporstatusdto (
	id varchar(36) NOT NULL,
	nome varchar(255) NULL,
	status varchar(255) NULL,
	total int4 NOT NULL,
	CONSTRAINT totalizadorporstatusdto_pkey PRIMARY KEY (id)
);


-- public.produtos_all_otimizado_ilpi_rj source

CREATE MATERIALIZED VIEW public.produtos_all_otimizado_ilpi_rj
TABLESPACE pg_default
AS SELECT p.id,
    p.contraindicacao,
    p.descricao,
    p.ean,
    p.indicacao,
    p.nome,
    p.photo,
    p.categoria_id,
    p.marca_id,
    p.photo_id,
    p.departamento_id,
    p.principioativo_id,
    p.precomedio,
    t.produto_tsv,
    ''::text AS lojapromocao
   FROM ( SELECT max(p_1.id) AS id,
            max(p_1.contraindicacao) AS contraindicacao,
            max(p_1.descricao) AS descricao,
            p_1.ean,
            max(p_1.indicacao) AS indicacao,
            max(p_1.nome::text) AS nome,
            max(p_1.photo) AS photo,
            max(p_1.categoria_id) AS categoria_id,
            max(p_1.marca_id) AS marca_id,
            max(p_1.photo_id) AS photo_id,
            max(p_1.departamento_id) AS departamento_id,
            max(p_1.principioativo_id) AS principioativo_id,
            max(p_1.precomedio) AS precomedio
           FROM ( SELECT p_2.id,
                    p_2.contraindicacao,
                    p_2.descricao,
                    p_2.ean,
                    p_2.indicacao,
                    p_2.nome,
                    p_2.photo,
                    p_2.categoria_id,
                    p_2.marca_id,
                    p_2.photo_id,
                    p_2.departamento_id,
                    p_2.principioativo_id,
                    p_2.precomedio
                   FROM ( SELECT max(pr.id::text) AS id,
                            max(pr.contraindicacao::text) AS contraindicacao,
                            max(pr.descricao::text) AS descricao,
                            pr.ean,
                            max(pr.indicacao::text) AS indicacao,
                            pr.nome,
                            length(pr.nome::text) AS length,
                            ''::text AS photo,
                            max(pr.categoria_id::text) AS categoria_id,
                            max(pr.marca_id::text) AS marca_id,
                            max(pr.photo_id::text) AS photo_id,
                            max(pr.departamento_id::text) AS departamento_id,
                            max(pr.principioativo_id::text) AS principioativo_id,
                            min(NULLIF(pc_1.valor, 0::double precision)) AS precomedio
                           FROM afarma.produtocrawler pr,
                            afarma.produtoconcorrente pc_1
                          WHERE pr.ean::text = pc_1.ean::text AND NOT (pr.ean::text IN ( SELECT DISTINCT gr.ean
                                   FROM genericos_ref gr))
                          GROUP BY pr.ean, pr.nome) p_2,
                    ( SELECT pc_1.ean,
                            max(length(pc_1.nome::text)) AS max
                           FROM afarma.produtocrawler pc_1
                          GROUP BY pc_1.ean) l,
                    ( SELECT DISTINCT e_1.ean
                           FROM ean_ref e_1
                          WHERE e_1.ean IS NOT NULL AND e_1.ean::text <> 'DIVERSOS'::text) e
                  WHERE l.max = p_2.length AND l.ean::text = p_2.ean::text AND e.ean::text = p_2.ean::text
                  GROUP BY p_2.id, p_2.contraindicacao, p_2.descricao, p_2.ean, p_2.indicacao, p_2.nome, p_2.photo, p_2.categoria_id, p_2.marca_id, p_2.photo_id, p_2.departamento_id, p_2.principioativo_id, p_2.precomedio
                UNION ALL
                 SELECT max(pr.id::text) AS id,
                    max(pr.contraindicacao::text) AS max,
                    max(pr.descricao::text) AS max,
                    max(pr.ean::text) AS max,
                    max(pr.indicacao::text) AS max,
                    gg.nome,
                    ''::text AS photo,
                    max(pr.categoria_id::text) AS max,
                    max(pr.marca_id::text) AS max,
                    '69d460dc-c484-4cf6-b18b-3bd102acfd7a'::text AS photo_id,
                    max(pr.departamento_id::text) AS max,
                    max(pr.principioativo_id::text) AS max,
                    min(NULLIF(pc_1.valor, 0::double precision)) AS precomedio
                   FROM afarma.produtocrawler pr,
                    generico_grupo gg,
                    genericos_ref gr,
                    afarma.produtoconcorrente pc_1
                  WHERE pr.ean::text = pc_1.ean::text AND pr.ean::text = gr.ean::text AND gr.grupo::text = gg.grupo::text AND (pr.ean::text IN ( SELECT DISTINCT gr_1.ean
                           FROM genericos_ref gr_1))
                  GROUP BY gg.nome) p_1,
            afarma.produtoconcorrente pc
          WHERE p_1.ean::text = pc.ean::text AND p_1.precomedio IS NOT NULL AND p_1.ean::text <> '7896026640619'::text AND (pc.concorrente_id::text IN ( SELECT ce.concorrente_id
                   FROM afarma.concorrentes_estados ce
                  WHERE ce.uf::text = 'RJ'::text))
          GROUP BY p_1.ean) p
     LEFT JOIN ( SELECT p_1.id,
            p_1.produto_tsv
           FROM afarma.produtocrawler p_1) t ON t.id::text = p.id
WITH DATA;


-- public.produtos_all_otimizado_rj source

CREATE MATERIALIZED VIEW public.produtos_all_otimizado_rj
TABLESPACE pg_default
AS SELECT b.id,
    b.nome,
    b.ean,
    b.photo_id,
    b.descricao,
    b.precomedio1,
    b.lojapromocao,
    b.categoria_id,
    b.marca_id,
    b.departamento_id,
    b.principioativo_id,
    b.grupo_id,
    b.indicacao,
    b.contraindicacao,
    p.produto_tsv,
    min(NULLIF(pc.valor, 0::double precision)) AS precomedio
   FROM ( SELECT p_1.id,
            p_1.nome,
            p_1.ean,
            p_1.photo_id,
            p_1.descricao,
            p_1.precomedio AS precomedio1,
            p_1.lojapromocao,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'CATEGORIA'::text) AS categoria_id,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'MARCA'::text) AS marca_id,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'DEPARTAMENTO'::text) AS departamento_id,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'PRINCIPIO ATIVO'::text) AS principioativo_id,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'GRUPO'::text) AS grupo_id,
            '-'::character varying AS indicacao,
            '-'::character varying AS contraindicacao
           FROM afarma.produto p_1
          WHERE p_1.descricao::text <> 'GENERICO'::text
          GROUP BY p_1.id, p_1.nome, p_1.ean, p_1.photo_id, p_1.descricao, p_1.contraindicacao, p_1.indicacao, p_1.precomedio, p_1.lojapromocao
        UNION ALL
         SELECT max(p_1.id::text) AS max,
            ( SELECT d.nome
                   FROM afarma.dominio d
                  WHERE p_1.grupo_id::text = d.id::text) AS grupo,
            max(p_1.ean::text) AS max,
            max(p_1.photo_id::text) AS max,
            max(p_1.descricao::text) AS max,
                CASE
                    WHEN avg(NULLIF(pc_1.valor, 0::double precision)) IS NULL THEN 0::double precision
                    ELSE avg(NULLIF(pc_1.valor, 0::double precision))
                END AS avg,
            p_1.lojapromocao,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'CATEGORIA'::text) AS categoria_id,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'MARCA'::text) AS marca_id,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'DEPARTAMENTO'::text) AS departamento_id,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'PRINCIPIO ATIVO'::text) AS principioativo_id,
            ( SELECT d.id
                   FROM afarma.dominio d,
                    afarma.tipodominio t
                  WHERE d.tipo_id::text = t.id::text AND d.nome::text = 'N√O IDENTIFICADO'::text AND t.nome::text = 'GRUPO'::text) AS grupo_id,
            '-'::character varying AS indicacao,
            '-'::character varying AS contraindicacao
           FROM afarma.produto p_1,
            afarma.produtoconcorrente pc_1
          WHERE pc_1.ean::text = p_1.ean::text AND p_1.descricao::text = 'GENERICO'::text
          GROUP BY (( SELECT d.nome
                   FROM afarma.dominio d
                  WHERE p_1.grupo_id::text = d.id::text)), p_1.lojapromocao) b,
    afarma.produto p,
    afarma.produtoconcorrente pc,
    afarma.concorrente c,
    afarma.concorrentes_estados ce
  WHERE p.ean::text = b.ean::text AND b.precomedio1 <> 0::double precision AND pc.ean::text = p.ean::text AND pc.valor > 0::double precision AND pc.concorrente_id::text = c.id::text AND c.id::text = ce.concorrente_id::text AND ce.uf::text = 'RJ'::text
  GROUP BY b.id, b.nome, b.ean, b.photo_id, b.descricao, b.contraindicacao, b.indicacao, b.precomedio1, b.lojapromocao, b.categoria_id, b.marca_id, b.departamento_id, b.principioativo_id, b.grupo_id, p.produto_tsv
  ORDER BY b.nome
WITH DATA;



CREATE OR REPLACE FUNCTION public.dblink(text, text, boolean)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_record$function$
;

CREATE OR REPLACE FUNCTION public.dblink(text)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_record$function$
;

CREATE OR REPLACE FUNCTION public.dblink(text, boolean)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_record$function$
;

CREATE OR REPLACE FUNCTION public.dblink(text, text)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_record$function$
;

CREATE OR REPLACE FUNCTION public.dblink_build_sql_delete(text, int2vector, integer, text[])
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_build_sql_delete$function$
;

CREATE OR REPLACE FUNCTION public.dblink_build_sql_insert(text, int2vector, integer, text[], text[])
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_build_sql_insert$function$
;

CREATE OR REPLACE FUNCTION public.dblink_build_sql_update(text, int2vector, integer, text[], text[])
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_build_sql_update$function$
;

CREATE OR REPLACE FUNCTION public.dblink_cancel_query(text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_cancel_query$function$
;

CREATE OR REPLACE FUNCTION public.dblink_close(text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_close$function$
;

CREATE OR REPLACE FUNCTION public.dblink_close(text, boolean)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_close$function$
;

CREATE OR REPLACE FUNCTION public.dblink_close(text, text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_close$function$
;

CREATE OR REPLACE FUNCTION public.dblink_close(text, text, boolean)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_close$function$
;

CREATE OR REPLACE FUNCTION public.dblink_connect(text, text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_connect$function$
;

CREATE OR REPLACE FUNCTION public.dblink_connect(text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_connect$function$
;

CREATE OR REPLACE FUNCTION public.dblink_connect_u(text, text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT SECURITY DEFINER
AS '$libdir/dblink', $function$dblink_connect$function$
;

CREATE OR REPLACE FUNCTION public.dblink_connect_u(text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT SECURITY DEFINER
AS '$libdir/dblink', $function$dblink_connect$function$
;

CREATE OR REPLACE FUNCTION public.dblink_current_query()
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED
AS '$libdir/dblink', $function$dblink_current_query$function$
;

CREATE OR REPLACE FUNCTION public.dblink_disconnect(text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_disconnect$function$
;

CREATE OR REPLACE FUNCTION public.dblink_disconnect()
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_disconnect$function$
;

CREATE OR REPLACE FUNCTION public.dblink_error_message(text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_error_message$function$
;

CREATE OR REPLACE FUNCTION public.dblink_exec(text, text, boolean)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_exec$function$
;

CREATE OR REPLACE FUNCTION public.dblink_exec(text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_exec$function$
;

CREATE OR REPLACE FUNCTION public.dblink_exec(text, text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_exec$function$
;

CREATE OR REPLACE FUNCTION public.dblink_exec(text, boolean)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_exec$function$
;

CREATE OR REPLACE FUNCTION public.dblink_fdw_validator(options text[], catalog oid)
 RETURNS void
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/dblink', $function$dblink_fdw_validator$function$
;

CREATE OR REPLACE FUNCTION public.dblink_fetch(text, text, integer, boolean)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_fetch$function$
;

CREATE OR REPLACE FUNCTION public.dblink_fetch(text, integer)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_fetch$function$
;

CREATE OR REPLACE FUNCTION public.dblink_fetch(text, integer, boolean)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_fetch$function$
;

CREATE OR REPLACE FUNCTION public.dblink_fetch(text, text, integer)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_fetch$function$
;

CREATE OR REPLACE FUNCTION public.dblink_get_connections()
 RETURNS text[]
 LANGUAGE c
 PARALLEL RESTRICTED
AS '$libdir/dblink', $function$dblink_get_connections$function$
;

CREATE OR REPLACE FUNCTION public.dblink_get_notify(OUT notify_name text, OUT be_pid integer, OUT extra text)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_get_notify$function$
;

CREATE OR REPLACE FUNCTION public.dblink_get_notify(conname text, OUT notify_name text, OUT be_pid integer, OUT extra text)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_get_notify$function$
;

CREATE OR REPLACE FUNCTION public.dblink_get_pkey(text)
 RETURNS SETOF dblink_pkey_results
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_get_pkey$function$
;

CREATE OR REPLACE FUNCTION public.dblink_get_result(text)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_get_result$function$
;

CREATE OR REPLACE FUNCTION public.dblink_get_result(text, boolean)
 RETURNS SETOF record
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_get_result$function$
;

CREATE OR REPLACE FUNCTION public.dblink_is_busy(text)
 RETURNS integer
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_is_busy$function$
;

CREATE OR REPLACE FUNCTION public.dblink_open(text, text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_open$function$
;

CREATE OR REPLACE FUNCTION public.dblink_open(text, text, boolean)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_open$function$
;

CREATE OR REPLACE FUNCTION public.dblink_open(text, text, text)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_open$function$
;

CREATE OR REPLACE FUNCTION public.dblink_open(text, text, text, boolean)
 RETURNS text
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_open$function$
;

CREATE OR REPLACE FUNCTION public.dblink_send_query(text, text)
 RETURNS integer
 LANGUAGE c
 PARALLEL RESTRICTED STRICT
AS '$libdir/dblink', $function$dblink_send_query$function$
;

CREATE OR REPLACE FUNCTION public.gin_extract_query_trgm(text, internal, smallint, internal, internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_extract_query_trgm$function$
;

CREATE OR REPLACE FUNCTION public.gin_extract_value_trgm(text, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_extract_value_trgm$function$
;

CREATE OR REPLACE FUNCTION public.gin_trgm_consistent(internal, smallint, text, integer, internal, internal, internal, internal)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_trgm_consistent$function$
;

CREATE OR REPLACE FUNCTION public.gin_trgm_triconsistent(internal, smallint, text, integer, internal, internal, internal)
 RETURNS "char"
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_trgm_triconsistent$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_compress(internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_compress$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_consistent(internal, text, smallint, oid, internal)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_consistent$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_decompress(internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_decompress$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_distance(internal, text, smallint, oid, internal)
 RETURNS double precision
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_distance$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_in(cstring)
 RETURNS gtrgm
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_in$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_options(internal)
 RETURNS void
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE
AS '$libdir/pg_trgm', $function$gtrgm_options$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_out(gtrgm)
 RETURNS cstring
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_out$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_penalty(internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_penalty$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_picksplit(internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_picksplit$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_same(gtrgm, gtrgm, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_same$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_union(internal, internal)
 RETURNS gtrgm
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_union$function$
;

CREATE OR REPLACE FUNCTION public.set_limit(real)
 RETURNS real
 LANGUAGE c
 STRICT
AS '$libdir/pg_trgm', $function$set_limit$function$
;

CREATE OR REPLACE FUNCTION public.show_limit()
 RETURNS real
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$show_limit$function$
;

CREATE OR REPLACE FUNCTION public.show_trgm(text)
 RETURNS text[]
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$show_trgm$function$
;

CREATE OR REPLACE FUNCTION public.similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity$function$
;

CREATE OR REPLACE FUNCTION public.similarity_dist(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity_dist$function$
;

CREATE OR REPLACE FUNCTION public.similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity_op$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_commutator_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_commutator_op$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_dist_commutator_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_dist_commutator_op$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_dist_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_dist_op$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_op$function$
;

CREATE OR REPLACE FUNCTION public.unaccent(regdictionary, text)
 RETURNS text
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

CREATE OR REPLACE FUNCTION public.unaccent(text)
 RETURNS text
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

CREATE OR REPLACE FUNCTION public.unaccent_init(internal)
 RETURNS internal
 LANGUAGE c
 PARALLEL SAFE
AS '$libdir/unaccent', $function$unaccent_init$function$
;

CREATE OR REPLACE FUNCTION public.unaccent_lexize(internal, internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 PARALLEL SAFE
AS '$libdir/unaccent', $function$unaccent_lexize$function$
;

CREATE OR REPLACE FUNCTION public.usuario_codigo_ind()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN



     
UPDATE
    afarma.usuario 
SET
    codigoind=ci.concat
FROM
   (select cod.identificador, concat(translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), '·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),cod.codigo)
from
(select max(i.id) as "identificador", (max(cast(i.substring as integer))+1) as "codigo" from 
 (select u.id, u.nome,
 translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), '·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),
 u.codigoind, substring(u.codigoind FROM '[0-9]+') from usuario u
 where u.perfilid='2'
 order by id asc) i) cod, usuario u where u.id=cod.identificador and (u.codigoind isnull or u.codigoind='' or u.codigoind=null)) ci 
WHERE
    id = ci.identificador;



RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v1()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v1mc()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1mc$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v3(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v3$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v4()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v4$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v5(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v5$function$
;

CREATE OR REPLACE FUNCTION public.uuid_nil()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_nil$function$
;

CREATE OR REPLACE FUNCTION public.uuid_ns_dns()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_dns$function$
;

CREATE OR REPLACE FUNCTION public.uuid_ns_oid()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_oid$function$
;

CREATE OR REPLACE FUNCTION public.uuid_ns_url()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_url$function$
;

CREATE OR REPLACE FUNCTION public.uuid_ns_x500()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_x500$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity_commutator_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_commutator_op$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity_dist_commutator_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_dist_commutator_op$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity_dist_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_dist_op$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_op$function$
;






