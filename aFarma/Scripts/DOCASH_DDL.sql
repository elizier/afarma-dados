-- config.actionurl definition

-- Drop table

-- DROP TABLE config.actionurl;

CREATE TABLE config.actionurl (
	id int8 NOT NULL,
	active bool NULL,
	description varchar(255) NOT NULL,
	CONSTRAINT actionurl_pkey PRIMARY KEY (id)
);


-- config.environment definition

-- Drop table

-- DROP TABLE config.environment;

CREATE TABLE config.environment (
	id int8 NOT NULL,
	description varchar(255) NOT NULL,
	production bool NULL,
	CONSTRAINT environment_pkey PRIMARY KEY (id)
);


-- docash.banco definition

-- Drop table

-- DROP TABLE docash.banco;

CREATE TABLE docash.banco (
	id int8 NOT NULL,
	codigo varchar(255) NOT NULL,
	nome varchar(255) NOT NULL,
	CONSTRAINT banco_pkey PRIMARY KEY (id)
);


-- docash.bandeiracartao definition

-- Drop table

-- DROP TABLE docash.bandeiracartao;

CREATE TABLE docash.bandeiracartao (
	id int8 NOT NULL,
	nome varchar(255) NOT NULL,
	CONSTRAINT bandeiracartao_pkey PRIMARY KEY (id)
);


-- docash.cliente definition

-- Drop table

-- DROP TABLE docash.cliente;

CREATE TABLE docash.cliente (
	id int8 NOT NULL,
	bloqueado bool NOT NULL,
	consultorid int8 NULL,
	identificador varchar(255) NULL,
	nome varchar(255) NOT NULL,
	statusanamlese bool NOT NULL,
	CONSTRAINT cliente_pkey PRIMARY KEY (id)
);


-- docash.faseanamlese definition

-- Drop table

-- DROP TABLE docash.faseanamlese;

CREATE TABLE docash.faseanamlese (
	id int8 NOT NULL,
	botname varchar(255) NULL,
	descricao varchar(255) NOT NULL,
	videourl varchar(255) NULL,
	CONSTRAINT faseanamlese_pkey PRIMARY KEY (id)
);


-- docash.forma_movimentacao_financeira definition

-- Drop table

-- DROP TABLE docash.forma_movimentacao_financeira;

CREATE TABLE docash.forma_movimentacao_financeira (
	id int8 NOT NULL,
	nome varchar(255) NOT NULL,
	CONSTRAINT forma_movimentacao_financeira_pkey PRIMARY KEY (id)
);


-- docash.mensagem definition

-- Drop table

-- DROP TABLE docash.mensagem;

CREATE TABLE docash.mensagem (
	id int8 NOT NULL,
	conteudo varchar(255) NULL,
	"data" timestamp NULL,
	destino varchar(255) NULL,
	origem varchar(255) NULL,
	origemcliente bool NOT NULL,
	sid varchar(255) NULL,
	status varchar(255) NULL,
	CONSTRAINT mensagem_pkey PRIMARY KEY (id)
);


-- docash.parceiro definition

-- Drop table

-- DROP TABLE docash.parceiro;

CREATE TABLE docash.parceiro (
	id int8 NOT NULL,
	codigo varchar(255) NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	telefone int4 NULL,
	CONSTRAINT parceiro_pkey PRIMARY KEY (id)
);


-- escolafinanceira.asset definition

-- Drop table

-- DROP TABLE escolafinanceira.asset;

CREATE TABLE escolafinanceira.asset (
	id int8 NOT NULL,
	active bool NOT NULL,
	createdate timestamp NULL,
	fileurl varchar(255) NULL,
	"free" bool NOT NULL,
	highlighturl varchar(255) NULL,
	iconurl varchar(255) NULL,
	"name" varchar(255) NULL,
	publicationdate timestamp NULL,
	spotlighturl varchar(255) NULL,
	summary varchar(255) NULL,
	"type" int4 NULL,
	videourl varchar(255) NULL,
	CONSTRAINT asset_pkey PRIMARY KEY (id)
);


-- escolafinanceira.autor definition

-- Drop table

-- DROP TABLE escolafinanceira.autor;

CREATE TABLE escolafinanceira.autor (
	id int8 NOT NULL,
	email varchar(255) NULL,
	"name" varchar(255) NULL,
	picture varchar(255) NULL,
	CONSTRAINT autor_pkey PRIMARY KEY (id)
);


-- gestao.configuracao definition

-- Drop table

-- DROP TABLE gestao.configuracao;

CREATE TABLE gestao.configuracao (
	id int8 NOT NULL,
	ativo bool NOT NULL,
	chave varchar(255) NULL,
	"data" timestamp NULL,
	mobile bool NOT NULL,
	valor varchar(255) NULL,
	CONSTRAINT configuracao_pkey PRIMARY KEY (id)
);


-- gestao.funcionalidade definition

-- Drop table

-- DROP TABLE gestao.funcionalidade;

CREATE TABLE gestao.funcionalidade (
	id int8 NOT NULL,
	acao varchar(255) NULL,
	identificador varchar(255) NULL,
	nome varchar(255) NULL,
	recurso varchar(255) NULL,
	CONSTRAINT funcionalidade_pkey PRIMARY KEY (id)
);


-- gestao.pagseguroboleto definition

-- Drop table

-- DROP TABLE gestao.pagseguroboleto;

CREATE TABLE gestao.pagseguroboleto (
	id int8 NOT NULL,
	currency varchar(255) NULL,
	extraamount varchar(255) NULL,
	itemamount1 varchar(255) NULL,
	itemdescription1 varchar(255) NULL,
	itemid1 varchar(255) NULL,
	itemquantity1 varchar(255) NULL,
	notificationurl varchar(255) NULL,
	paymentmethod varchar(255) NULL,
	paymentmode varchar(255) NULL,
	receiveremail varchar(255) NULL,
	reference varchar(255) NULL,
	senderareacode varchar(255) NULL,
	sendercpf varchar(255) NULL,
	senderemail varchar(255) NULL,
	senderhash varchar(255) NULL,
	sendername varchar(255) NULL,
	senderphone varchar(255) NULL,
	shippingaddresscity varchar(255) NULL,
	shippingaddresscomplement varchar(255) NULL,
	shippingaddresscountry varchar(255) NULL,
	shippingaddressdistrict varchar(255) NULL,
	shippingaddressnumber varchar(255) NULL,
	shippingaddresspostalcode varchar(255) NULL,
	shippingaddressstate varchar(255) NULL,
	shippingaddressstreet varchar(255) NULL,
	shippingcost varchar(255) NULL,
	shippingtype varchar(255) NULL,
	CONSTRAINT pagseguroboleto_pkey PRIMARY KEY (id)
);


-- gestao.pagsegurocartaocredito definition

-- Drop table

-- DROP TABLE gestao.pagsegurocartaocredito;

CREATE TABLE gestao.pagsegurocartaocredito (
	id int8 NOT NULL,
	billingaddresscity varchar(255) NULL,
	billingaddresscomplement varchar(255) NULL,
	billingaddresscountry varchar(255) NULL,
	billingaddressdistrict varchar(255) NULL,
	billingaddressnumber varchar(255) NULL,
	billingaddresspostalcode varchar(255) NULL,
	billingaddressstate varchar(255) NULL,
	billingaddressstreet varchar(255) NULL,
	creditcardholderareacode varchar(255) NULL,
	creditcardholderbirthdate varchar(255) NULL,
	creditcardholdercpf varchar(255) NULL,
	creditcardholdername varchar(255) NULL,
	creditcardholderphone varchar(255) NULL,
	creditcardtoken varchar(255) NULL,
	currency varchar(255) NULL,
	extraamount varchar(255) NULL,
	installmentquantity varchar(255) NULL,
	installmentvalue varchar(255) NULL,
	itemamount1 varchar(255) NULL,
	itemdescription1 varchar(255) NULL,
	itemid1 varchar(255) NULL,
	itemquantity1 varchar(255) NULL,
	nointerestinstallmentquantity varchar(255) NULL,
	notificationurl varchar(255) NULL,
	paymentmethod varchar(255) NULL,
	paymentmode varchar(255) NULL,
	receiveremail varchar(255) NULL,
	reference varchar(255) NULL,
	senderareacode varchar(255) NULL,
	sendercpf varchar(255) NULL,
	senderemail varchar(255) NULL,
	senderhash varchar(255) NULL,
	sendername varchar(255) NULL,
	senderphone varchar(255) NULL,
	shippingaddresscity varchar(255) NULL,
	shippingaddresscomplement varchar(255) NULL,
	shippingaddresscountry varchar(255) NULL,
	shippingaddressdistrict varchar(255) NULL,
	shippingaddressnumber varchar(255) NULL,
	shippingaddresspostalcode varchar(255) NULL,
	shippingaddressstate varchar(255) NULL,
	shippingaddressstreet varchar(255) NULL,
	shippingcost varchar(255) NULL,
	shippingtype varchar(255) NULL,
	CONSTRAINT pagsegurocartaocredito_pkey PRIMARY KEY (id)
);


-- gestao.pagsegurorecorrente definition

-- Drop table

-- DROP TABLE gestao.pagsegurorecorrente;

CREATE TABLE gestao.pagsegurorecorrente (
	id int8 NOT NULL,
	billingaddresscity varchar(255) NULL,
	billingaddresscomplement varchar(255) NULL,
	billingaddresscountry varchar(255) NULL,
	billingaddressdistrict varchar(255) NULL,
	billingaddressnumber varchar(255) NULL,
	billingaddresspostalcode varchar(255) NULL,
	billingaddressstate varchar(255) NULL,
	billingaddressstreet varchar(255) NULL,
	creditcardholderareacode varchar(255) NULL,
	creditcardholderbirthdate varchar(255) NULL,
	creditcardholdercpf varchar(255) NULL,
	creditcardholdername varchar(255) NULL,
	creditcardholderphone varchar(255) NULL,
	creditcardtoken varchar(255) NULL,
	paymentmethod varchar(255) NULL,
	plan varchar(255) NULL,
	reference varchar(255) NULL,
	senderareacode varchar(255) NULL,
	sendercpf varchar(255) NULL,
	senderemail varchar(255) NULL,
	senderhash varchar(255) NULL,
	sendername varchar(255) NULL,
	senderphone varchar(255) NULL,
	shippingaddresscity varchar(255) NULL,
	shippingaddresscomplement varchar(255) NULL,
	shippingaddresscountry varchar(255) NULL,
	shippingaddressdistrict varchar(255) NULL,
	shippingaddressnumber varchar(255) NULL,
	shippingaddresspostalcode varchar(255) NULL,
	shippingaddressstate varchar(255) NULL,
	shippingaddressstreet varchar(255) NULL,
	CONSTRAINT pagsegurorecorrente_pkey PRIMARY KEY (id)
);


-- gestao.perfil definition

-- Drop table

-- DROP TABLE gestao.perfil;

CREATE TABLE gestao.perfil (
	id int8 NOT NULL,
	identificador varchar(255) NULL,
	nome varchar(255) NULL,
	CONSTRAINT perfil_pkey PRIMARY KEY (id)
);


-- config.environmentpath definition

-- Drop table

-- DROP TABLE config.environmentpath;

CREATE TABLE config.environmentpath (
	id int8 NOT NULL,
	description varchar(255) NOT NULL,
	environment int4 NULL,
	url varchar(255) NOT NULL,
	environmentid int8 NOT NULL,
	CONSTRAINT environmentpath_pkey PRIMARY KEY (id),
	CONSTRAINT fkispha5oeb09pjo504d5rfsk0o FOREIGN KEY (environmentid) REFERENCES config.environment(id)
);


-- config.mobileappconfig definition

-- Drop table

-- DROP TABLE config.mobileappconfig;

CREATE TABLE config.mobileappconfig (
	id int8 NOT NULL,
	environment int4 NULL,
	"version" varchar(255) NOT NULL,
	environmentid int8 NOT NULL,
	CONSTRAINT mobileappconfig_pkey PRIMARY KEY (id),
	CONSTRAINT fkpllhjf28j75kbe2p44n2vxc8 FOREIGN KEY (environmentid) REFERENCES config.environment(id)
);


-- config.mobilepaths definition

-- Drop table

-- DROP TABLE config.mobilepaths;

CREATE TABLE config.mobilepaths (
	mobileappid int8 NOT NULL,
	environmentpathid int8 NOT NULL,
	CONSTRAINT fkanjhlwy1rd4tk4aloxjxuwkt FOREIGN KEY (environmentpathid) REFERENCES config.environmentpath(id),
	CONSTRAINT fkfyb1nodvwd62eadnncngeuf5o FOREIGN KEY (mobileappid) REFERENCES config.mobileappconfig(id)
);


-- config.userconfig definition

-- Drop table

-- DROP TABLE config.userconfig;

CREATE TABLE config.userconfig (
	id int8 NOT NULL,
	active bool NULL,
	cpf varchar(255) NULL,
	email varchar(255) NULL,
	environment int4 NULL,
	"key" varchar(255) NULL,
	"name" varchar(255) NULL,
	environmentid int8 NOT NULL,
	CONSTRAINT userconfig_pkey PRIMARY KEY (id),
	CONSTRAINT fk28m440pma7iemxpoh3pqkmx5v FOREIGN KEY (environmentid) REFERENCES config.environment(id)
);


-- config.userpaths definition

-- Drop table

-- DROP TABLE config.userpaths;

CREATE TABLE config.userpaths (
	userid int8 NOT NULL,
	environmentpathid int8 NOT NULL,
	CONSTRAINT fkcrggifqihd7r2ugkmc0p1vofj FOREIGN KEY (environmentpathid) REFERENCES config.environmentpath(id),
	CONSTRAINT fkk0mrsvealps9lr1ljqa7o4sxl FOREIGN KEY (userid) REFERENCES config.userconfig(id)
);


-- docash.anamlese definition

-- Drop table

-- DROP TABLE docash.anamlese;

CREATE TABLE docash.anamlese (
	id int8 NOT NULL,
	"data" timestamp NOT NULL,
	resposta varchar(255) NULL,
	status bool NOT NULL,
	clienteid int8 NULL,
	faseid int8 NULL,
	CONSTRAINT anamlese_pkey PRIMARY KEY (id),
	CONSTRAINT fkhydox9s3ox9aet1icsyxmui FOREIGN KEY (faseid) REFERENCES docash.faseanamlese(id),
	CONSTRAINT fkk9gb8tl9oyeux2kfvsqq1ii0r FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.cartaocredito definition

-- Drop table

-- DROP TABLE docash.cartaocredito;

CREATE TABLE docash.cartaocredito (
	id int8 NOT NULL,
	datavencimento timestamp NULL,
	descricao varchar(255) NULL,
	limite float4 NULL,
	bancoid int8 NULL,
	bandeiraid int8 NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT cartaocredito_pkey PRIMARY KEY (id),
	CONSTRAINT fk6b8vn4wl1n7h8a19oe4spgnsm FOREIGN KEY (bandeiraid) REFERENCES docash.bandeiracartao(id),
	CONSTRAINT fkb9ct2bym84lhalfsswdm4l5y7 FOREIGN KEY (bancoid) REFERENCES docash.banco(id),
	CONSTRAINT fkojhw33jhydj28bcbpvvf454gp FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.contaareceber definition

-- Drop table

-- DROP TABLE docash.contaareceber;

CREATE TABLE docash.contaareceber (
	id int8 NOT NULL,
	datavencimento timestamp NOT NULL,
	descricao varchar(255) NOT NULL,
	recebida bool NOT NULL,
	valor float8 NOT NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT contaareceber_pkey PRIMARY KEY (id),
	CONSTRAINT fk9apy7gi3ueu9ujhlr8j5vy9yt FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.contabancaria definition

-- Drop table

-- DROP TABLE docash.contabancaria;

CREATE TABLE docash.contabancaria (
	id int8 NOT NULL,
	agencia varchar(255) NOT NULL,
	conta varchar(255) NOT NULL,
	bancoid int8 NOT NULL,
	clienteid int8 NOT NULL,
	padrao bool NOT NULL,
	CONSTRAINT contabancaria_pkey PRIMARY KEY (id),
	CONSTRAINT fk5b2mh46upm8hwusn4xiw35nkx FOREIGN KEY (bancoid) REFERENCES docash.banco(id),
	CONSTRAINT fkteb75f3yfjm2t3aevojtxmyj5 FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.dadobancario definition

-- Drop table

-- DROP TABLE docash.dadobancario;

CREATE TABLE docash.dadobancario (
	id int8 NOT NULL,
	"data" timestamp NULL,
	saldo float4 NULL,
	contaid int8 NOT NULL,
	CONSTRAINT dadobancario_pkey PRIMARY KEY (id),
	CONSTRAINT fk1yx5ymgmw1k6fahpess0nsi09 FOREIGN KEY (contaid) REFERENCES docash.contabancaria(id)
);


-- docash.dependente definition

-- Drop table

-- DROP TABLE docash.dependente;

CREATE TABLE docash.dependente (
	id int8 NOT NULL,
	nome varchar(255) NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT dependente_pkey PRIMARY KEY (id),
	CONSTRAINT fkangf2gqbfi1bo778dcm2ckp6i FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.divida definition

-- Drop table

-- DROP TABLE docash.divida;

CREATE TABLE docash.divida (
	id int8 NOT NULL,
	descricao varchar(255) NULL,
	rendimento float4 NULL,
	valor float4 NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT divida_pkey PRIMARY KEY (id),
	CONSTRAINT fk9q2mfo0dts8wpktp0ejxagi1c FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.financiamento definition

-- Drop table

-- DROP TABLE docash.financiamento;

CREATE TABLE docash.financiamento (
	id int8 NOT NULL,
	descricao varchar(255) NULL,
	juros float4 NULL,
	mesesrestantes int4 NULL,
	valor float4 NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT financiamento_pkey PRIMARY KEY (id),
	CONSTRAINT fkmdm3blsobyyl7pml1p1usyexl FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.investimento definition

-- Drop table

-- DROP TABLE docash.investimento;

CREATE TABLE docash.investimento (
	id int8 NOT NULL,
	descricao varchar(255) NULL,
	rendimento float4 NULL,
	valor float4 NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT investimento_pkey PRIMARY KEY (id),
	CONSTRAINT fksbk61s9lxvorq2f0n87v2lpqm FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.patrimonio definition

-- Drop table

-- DROP TABLE docash.patrimonio;

CREATE TABLE docash.patrimonio (
	id int8 NOT NULL,
	descricao varchar(255) NULL,
	valor float4 NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT patrimonio_pkey PRIMARY KEY (id),
	CONSTRAINT fk669vnufrkgyor3p25w7nkwsdw FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.planejamento definition

-- Drop table

-- DROP TABLE docash.planejamento;

CREATE TABLE docash.planejamento (
	id int8 NOT NULL,
	anotacoes varchar(255) NULL,
	ativo bool NULL DEFAULT true,
	descricao varchar(255) NULL,
	diabase int4 NULL,
	fim timestamp NULL,
	inicio timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	previsaoreceita float8 NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT planejamento_pkey PRIMARY KEY (id),
	CONSTRAINT ukn2wbcr1vblmt77qoquludp21l UNIQUE (clienteid, inicio, fim),
	CONSTRAINT fk4lua0brrigdby8uo12hy6ao00 FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.renda definition

-- Drop table

-- DROP TABLE docash.renda;

CREATE TABLE docash.renda (
	id int8 NOT NULL,
	ativa bool NOT NULL,
	descricao varchar(255) NULL,
	valor float4 NULL,
	clienteid int8 NOT NULL,
	CONSTRAINT renda_pkey PRIMARY KEY (id),
	CONSTRAINT fksr8b616n3rxbb0l95py6o3t8e FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- escolafinanceira.asset_autor definition

-- Drop table

-- DROP TABLE escolafinanceira.asset_autor;

CREATE TABLE escolafinanceira.asset_autor (
	asset_id int8 NOT NULL,
	autor_id int8 NOT NULL,
	CONSTRAINT fk1ar7upqx4nagxv0iowufsqy57 FOREIGN KEY (autor_id) REFERENCES escolafinanceira.autor(id),
	CONSTRAINT fksvluyf09ijrb682d9c9k28yvm FOREIGN KEY (asset_id) REFERENCES escolafinanceira.asset(id)
);


-- gestao.perfil_funcionalidade definition

-- Drop table

-- DROP TABLE gestao.perfil_funcionalidade;

CREATE TABLE gestao.perfil_funcionalidade (
	id_perfil int8 NOT NULL,
	id_funcionalidade int8 NOT NULL,
	CONSTRAINT fkkjqx4b6mhu4r7u0ud2b8859f8 FOREIGN KEY (id_funcionalidade) REFERENCES gestao.funcionalidade(id),
	CONSTRAINT fkrck2i79b7ydyn87kuryo3e8j5 FOREIGN KEY (id_perfil) REFERENCES gestao.perfil(id)
);


-- gestao.usuario definition

-- Drop table

-- DROP TABLE gestao.usuario;

CREATE TABLE gestao.usuario (
	id int8 NOT NULL,
	codigo_cad_senha varchar(255) NULL,
	cpf varchar(255) NULL,
	email varchar(255) NULL,
	extra varchar(255) NULL,
	nome varchar(255) NULL,
	senha varchar(255) NULL,
	telefone varchar(255) NULL,
	telegram varchar(255) NULL,
	clienteid int8 NULL,
	avatar bytea NULL,
	CONSTRAINT usuario_pkey PRIMARY KEY (id),
	CONSTRAINT fkio1bxm58t9ativvvltd7yrlr4 FOREIGN KEY (clienteid) REFERENCES docash.cliente(id)
);


-- docash.caixa definition

-- Drop table

-- DROP TABLE docash.caixa;

CREATE TABLE docash.caixa (
	id int8 NOT NULL,
	ativo bool NOT NULL,
	atualizacao timestamp NOT NULL,
	saldo float8 NULL,
	tipo int4 NOT NULL,
	clienteid int8 NOT NULL,
	contaid int8 NULL,
	CONSTRAINT caixa_pkey PRIMARY KEY (id),
	CONSTRAINT fk5a03doyweobo8fhmx0w8o9u0m FOREIGN KEY (clienteid) REFERENCES docash.cliente(id),
	CONSTRAINT fkop05ynrnbya09bt0qkqpxpwit FOREIGN KEY (contaid) REFERENCES docash.contabancaria(id)
);


-- gestao.fotousuario definition

-- Drop table

-- DROP TABLE gestao.fotousuario;

CREATE TABLE gestao.fotousuario (
	id int8 NOT NULL,
	"path" varchar(255) NULL,
	usuario_id int8 NULL,
	CONSTRAINT fotousuario_pkey PRIMARY KEY (id),
	CONSTRAINT fk7kudjrvbs0vmhbeaodw4xo2kd FOREIGN KEY (usuario_id) REFERENCES gestao.usuario(id)
);


-- gestao.pagseguro definition

-- Drop table

-- DROP TABLE gestao.pagseguro;

CREATE TABLE gestao.pagseguro (
	id int8 NOT NULL,
	code varchar(255) NULL,
	"data" timestamp NULL,
	erro varchar(255) NULL,
	idpagseguro int8 NULL,
	link varchar(255) NULL,
	status varchar(255) NULL,
	tipo varchar(255) NULL,
	xmlretorno varchar(255) NULL,
	clienteid int8 NULL,
	usuarioid int8 NULL,
	idstatus int4 NULL,
	CONSTRAINT pagseguro_pkey PRIMARY KEY (id),
	CONSTRAINT fk1lmf860vl293kv8pdgonmr8f0 FOREIGN KEY (clienteid) REFERENCES docash.cliente(id),
	CONSTRAINT fkmi1wjnl19ss1gtbvk9kly3qd0 FOREIGN KEY (usuarioid) REFERENCES gestao.usuario(id)
);


-- gestao.perfil_usuario definition

-- Drop table

-- DROP TABLE gestao.perfil_usuario;

CREATE TABLE gestao.perfil_usuario (
	id_usuario int8 NOT NULL,
	id_perfil int8 NOT NULL,
	CONSTRAINT fkamnmwhe6qkh4iuwoi246opghc FOREIGN KEY (id_usuario) REFERENCES gestao.usuario(id),
	CONSTRAINT fkq7mj70a3g1v018vot19eho3dx FOREIGN KEY (id_perfil) REFERENCES gestao.perfil(id)
);


-- docash.classificacao_movimentacao_financeira definition

-- Drop table

-- DROP TABLE docash.classificacao_movimentacao_financeira;

CREATE TABLE docash.classificacao_movimentacao_financeira (
	id int8 NOT NULL,
	nome varchar(255) NOT NULL,
	planejamentopadrao bool NOT NULL DEFAULT true,
	receita bool NOT NULL DEFAULT false,
	grupoid int8 NULL,
	tipoid int8 NULL,
	CONSTRAINT classificacao_movimentacao_financeira_pkey PRIMARY KEY (id)
);


-- docash.contaapagar definition

-- Drop table

-- DROP TABLE docash.contaapagar;

CREATE TABLE docash.contaapagar (
	id int8 NOT NULL,
	datavencimento timestamp NOT NULL,
	descricao varchar(255) NOT NULL,
	quitada bool NOT NULL,
	valor float8 NOT NULL,
	clienteid int8 NOT NULL,
	tipoid int8 NULL,
	CONSTRAINT contaapagar_pkey PRIMARY KEY (id)
);


-- docash.movimentacao_caixa definition

-- Drop table

-- DROP TABLE docash.movimentacao_caixa;

CREATE TABLE docash.movimentacao_caixa (
	id int8 NOT NULL,
	tipo int4 NOT NULL,
	valor float4 NOT NULL,
	caixaid int8 NOT NULL,
	movimentacao_financeira_id int8 NULL,
	"data" timestamp NOT NULL DEFAULT now(),
	CONSTRAINT movimentacao_caixa_pkey PRIMARY KEY (id)
);


-- docash.movimentacao_financeira definition

-- Drop table

-- DROP TABLE docash.movimentacao_financeira;

CREATE TABLE docash.movimentacao_financeira (
	id int8 NOT NULL,
	"data" timestamp NOT NULL,
	descricao varchar(255) NOT NULL,
	valor float4 NOT NULL,
	classificacao_movimentacao_financeira_id int8 NULL,
	clienteid int8 NOT NULL,
	forma_movimentacao_financeira_id int8 NULL,
	CONSTRAINT movimentacao_financeira_pkey PRIMARY KEY (id)
);


-- docash.planejamento_classificacao definition

-- Drop table

-- DROP TABLE docash.planejamento_classificacao;

CREATE TABLE docash.planejamento_classificacao (
	id int8 NOT NULL,
	indispensavel bool NULL DEFAULT false,
	margem float4 NULL,
	valor float4 NULL,
	classificacao_movimentacao_financeira_id int8 NOT NULL,
	planejamento_id int8 NOT NULL,
	tipo_movimentacao_financeira_id int8 NULL,
	CONSTRAINT planejamento_classificacao_pkey PRIMARY KEY (id),
	CONSTRAINT uke5u1lsxpa7fdjawgibnx3xvwo UNIQUE (planejamento_id, classificacao_movimentacao_financeira_id)
);


-- docash.planejamento_tipo definition

-- Drop table

-- DROP TABLE docash.planejamento_tipo;

CREATE TABLE docash.planejamento_tipo (
	id int8 NOT NULL,
	margem float4 NULL,
	valor float4 NULL,
	planejamento_id int8 NOT NULL,
	tipo_movimentacao_financeira_id int8 NOT NULL,
	CONSTRAINT planejamento_tipo_pkey PRIMARY KEY (id),
	CONSTRAINT ukjt5svtvxqo1ur2ycrvkkhi0st UNIQUE (planejamento_id, tipo_movimentacao_financeira_id)
);

CREATE TABLE docash.tipo_movimentacao_financeira (
	id int8 NOT NULL,
	margempadrao float4 NULL,
	nome varchar(255) NOT NULL,
	valorpadrao float4 NULL,
	CONSTRAINT tipo_movimentacao_financeira_pkey PRIMARY KEY (id)
);

-- docash.classificacao_movimentacao_financeira foreign keys

ALTER TABLE docash.classificacao_movimentacao_financeira ADD CONSTRAINT fkqsh33is3mgyh2m6xwcekt63vj FOREIGN KEY (grupoid) REFERENCES docash.classificacao_movimentacao_financeira(id);
ALTER TABLE docash.classificacao_movimentacao_financeira ADD CONSTRAINT fksl7eyvie7vw224snssw2perl4 FOREIGN KEY (tipoid) REFERENCES docash.tipo_movimentacao_financeira(id);


-- docash.contaapagar foreign keys

ALTER TABLE docash.contaapagar ADD CONSTRAINT fkrfodphqmwme4hf8rw5tdwphf3 FOREIGN KEY (clienteid) REFERENCES docash.cliente(id);
ALTER TABLE docash.contaapagar ADD CONSTRAINT fkth07199m8f6x2a2cb2s1b5lv9 FOREIGN KEY (tipoid) REFERENCES docash.tipo_movimentacao_financeira(id);


-- docash.movimentacao_caixa foreign keys

ALTER TABLE docash.movimentacao_caixa ADD CONSTRAINT fkdkcqmwui6j8fghy89givesg8d FOREIGN KEY (caixaid) REFERENCES docash.caixa(id);
ALTER TABLE docash.movimentacao_caixa ADD CONSTRAINT fkqo9btufivpnbnma954nshm7xn FOREIGN KEY (movimentacao_financeira_id) REFERENCES docash.movimentacao_financeira(id);


-- docash.movimentacao_financeira foreign keys

ALTER TABLE docash.movimentacao_financeira ADD CONSTRAINT fk7cml9b5q8xpx85b4qggsk9n2y FOREIGN KEY (forma_movimentacao_financeira_id) REFERENCES docash.forma_movimentacao_financeira(id);
ALTER TABLE docash.movimentacao_financeira ADD CONSTRAINT fkdk51wwsloouu0yoespkv5ma3b FOREIGN KEY (classificacao_movimentacao_financeira_id) REFERENCES docash.classificacao_movimentacao_financeira(id);
ALTER TABLE docash.movimentacao_financeira ADD CONSTRAINT fkpb7iphupw2f09f8fmqb87phre FOREIGN KEY (clienteid) REFERENCES docash.cliente(id);


-- docash.planejamento_classificacao foreign keys

ALTER TABLE docash.planejamento_classificacao ADD CONSTRAINT fk36mmoyy8843mlul6ylnlm9ja4 FOREIGN KEY (planejamento_id) REFERENCES docash.planejamento(id);
ALTER TABLE docash.planejamento_classificacao ADD CONSTRAINT fkjcw7j907ccjg4bt7sn5p9i8rn FOREIGN KEY (tipo_movimentacao_financeira_id) REFERENCES docash.tipo_movimentacao_financeira(id);
ALTER TABLE docash.planejamento_classificacao ADD CONSTRAINT fks03r1e48nk4ch1xjrcm58anfs FOREIGN KEY (classificacao_movimentacao_financeira_id) REFERENCES docash.classificacao_movimentacao_financeira(id);


-- docash.planejamento_tipo foreign keys

ALTER TABLE docash.planejamento_tipo ADD CONSTRAINT fk52u0kofoklmj2519cwvcqxh21 FOREIGN KEY (tipo_movimentacao_financeira_id) REFERENCES docash.tipo_movimentacao_financeira(id);
ALTER TABLE docash.planejamento_tipo ADD CONSTRAINT fkji25o2nc72jhvi7f48x8epjkg FOREIGN KEY (planejamento_id) REFERENCES docash.planejamento(id);





