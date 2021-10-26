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
	id varchar(36) NOT NULL,
	backgroundcolor varchar(255) NULL,
	departamento varchar(255) NULL,
	image bytea NULL,
	CONSTRAINT departamento_pkey PRIMARY KEY (id)
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
	photo bytea NULL,
	CONSTRAINT photo_pkey PRIMARY KEY (id)
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
	contraindicacao varchar(255) NULL,
	descricao varchar(255) NULL,
	ean varchar(255) NULL,
	indicacao varchar(255) NULL,
	lojapromocao varchar(255) NULL,
	nome varchar(255) NULL,
	precomedio float8 NULL,
	categoria_id varchar(36) NULL,
	departamento_id varchar(36) NULL,
	grupo_id varchar(36) NULL,
	marca_id varchar(36) NULL,
	photo_id varchar(36) NULL,
	principioativo_id varchar(36) NULL,
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
	contraindicacao varchar(255) NULL,
	descricao varchar(255) NULL,
	ean varchar(255) NULL,
	indicacao varchar(255) NULL,
	nome varchar(255) NULL,
	categoria_id varchar(36) NULL,
	departamento_id varchar(36) NOT NULL,
	marca_id varchar(36) NULL,
	photo_id varchar(36) NULL,
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
	url varchar(255) NULL,
	valor float8 NULL,
	concorrente_id varchar(36) NOT NULL,
	produto_id varchar(36) NOT NULL,
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