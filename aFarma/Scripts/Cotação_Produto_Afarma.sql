


-- DROP TABLE afarma.registrocotacao_afarma;

CREATE TABLE afarma.registrocotacao_afarma (
	id varchar(36) NOT null default uuid_generate_v4(),
	"data" timestamp NULL,
	email varchar(255) NULL,
	nome varchar(255) NULL,
	status varchar(255) NULL,
	uf varchar(255) NULL,
	CONSTRAINT registrocotacao_pkey_afarma PRIMARY KEY (id)
);


-- Drop table

-- DROP TABLE afarma.itenscot_afarma;

CREATE TABLE afarma.itenscot_afarma (
	id varchar(36) NOT null default uuid_generate_v4(),
	cotacao varchar(255) NULL,
	id_produto varchar(36) NULL,
	quantidade int4 NOT NULL,
	CONSTRAINT itenscot_afarma_pkey PRIMARY KEY (id),
	CONSTRAINT itenscot_afarma_fkey FOREIGN KEY (cotacao) REFERENCES afarma.registrocotacao_afarma(id)
);


select * from public.cotacaodetalhado_afarma('64968fbc-943f-460c-8036-98f7fd48e9f8')

select * from public.cotacao_afarma('64968fbc-943f-460c-8036-98f7fd48e9f8')