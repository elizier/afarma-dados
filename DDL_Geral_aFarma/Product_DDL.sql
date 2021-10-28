-- public.product definition

-- Drop table

-- DROP TABLE public.product;

CREATE TABLE public.product (
	id uuid NOT NULL,
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
	name varchar(2048) NOT NULL,
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







	

