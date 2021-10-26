
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