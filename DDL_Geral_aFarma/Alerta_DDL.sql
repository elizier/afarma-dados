-- afarma.alerta definition

--TESTE_MUDANÇA_GIT

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