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

7e508234-9623-456c-9c23-b70b351721a6	NÃO IDENTIFICADO	af673c7f-b1fe-4699-bc7f-cf45b28b0409
6d3ad24b-ba9e-4c80-a827-6ba00fd9ca29	NÃO IDENTIFICADO	60f5eb50-bcd5-4cf3-833f-e7cc243cc02c
da11f19a-89c0-48d1-a333-4d896c73c3a1	NÃO IDENTIFICADO	a4eab175-18b3-453f-a3b1-656b32740953
c5ca785c-ef18-4def-83dd-274eddfbb737	NÃO IDENTIFICADO	f8db5ab4-cf16-4ca6-8183-183f35ae28f3
377d7463-277e-4e76-b02d-72bec35c52bb	NÃO IDENTIFICADO	4c65f533-cd56-4ea7-939d-066d5d88ad2d


INSERT INTO afarma.dominio
(id, nome, tipo_id)
VALUES
(uuid_generate_v4(), 'NÃO IDENTIFICADO', (select id from afarma.tipodominio t where t.nome = 'PRINCIPIO ATIVO')),
(uuid_generate_v4(), 'NÃO IDENTIFICADO', (select id from afarma.tipodominio t where t.nome = 'MARCA')),
(uuid_generate_v4(), 'NÃO IDENTIFICADO', (select id from afarma.tipodominio t where t.nome = 'CATEGORIA')),
(uuid_generate_v4(), 'NÃO IDENTIFICADO', (select id from afarma.tipodominio t where t.nome = 'DEPARTAMENTO')),
(uuid_generate_v4(), 'NÃO IDENTIFICADO', (select id from afarma.tipodominio t where t.nome = 'GRUPO'));

