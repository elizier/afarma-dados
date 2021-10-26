-- public.product definition

-- Drop table

-- DROP TABLE public.product;

CREATE TABLE public.product (
	id uuid NOT NULL,
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
	price float4 NOT NULL,
	updated_date timestamp NOT NULL,
	url varchar(10240) NOT NULL,
	related_products _text NULL,
	active_ingredient varchar(10240) NULL,
	retencao_receita varchar(255) NULL,
	cron varchar(14) NULL,
	CONSTRAINT product_pkey PRIMARY KEY (id)
);

-------------------------------------------------------------------------------------------
CREATE EXTENSION dblink;

--Insert 1 (2min)

insert into product 
SELECT *
        FROM 
                dblink('dbname=postgres port=5432 host=crawler-afarma-1.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2020',
                'SELECT * from public.product p')
            AS s(id uuid,
	brand varchar(10240),
	category varchar(10240),
	contraindication varchar(10240),
	created_date timestamp,
	department _text,
	description varchar(10240),
	ean varchar(255),
	"implementation" varchar(255),
	indication varchar(10240),
	"name" varchar(2048),
	photo bytea,
	price float4,
	updated_date timestamp,
	url varchar(10240),
	related_products _text,
	active_ingredient varchar(10240),
	retencao_receita varchar(255),
	cron varchar(14));
	

--Insert 2 (1min40s)

insert into product 
SELECT *
        FROM 
                dblink('dbname=postgres port=5432 host=afarma-crawler-3.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2020',
                'SELECT * from public.product p')
            AS s(id uuid,
	brand varchar(10240),
	category varchar(10240),
	contraindication varchar(10240),
	created_date timestamp,
	department _text,
	description varchar(10240),
	ean varchar(255),
	"implementation" varchar(255),
	indication varchar(10240),
	"name" varchar(2048),
	photo bytea,
	price float4,
	updated_date timestamp,
	url varchar(10240),
	related_products _text,
	active_ingredient varchar(10240),
	retencao_receita varchar(255),
	cron varchar(14));

--Insert 3 (1min30s)

insert into product 
SELECT *
        FROM 
                dblink('dbname=postgres port=5432 host=afarma-crawler-2.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2020',
                'SELECT * from public.product p')
            AS s(id uuid,
	brand varchar(10240),
	category varchar(10240),
	contraindication varchar(10240),
	created_date timestamp,
	department _text,
	description varchar(10240),
	ean varchar(255),
	"implementation" varchar(255),
	indication varchar(10240),
	"name" varchar(2048),
	photo bytea,
	price float4,
	updated_date timestamp,
	url varchar(10240),
	related_products _text,
	active_ingredient varchar(10240),
	retencao_receita varchar(255),
	cron varchar(14));
	

--Insert 4 (1min)

insert into product 
SELECT p.id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
p.implementation, p.indication, p.name, p.photo, p.price, p.updated_date, p.url, p.related_products, p.active_ingredient, p.retencao_receita, 
p.cron 
        FROM 
                dblink('dbname=postgres port=5432 host=afarma-crawler-0.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2021',
                'SELECT * from public.product p')
            AS p (id uuid,
            active_ingredient varchar(10240),
	brand varchar(10240),
	category varchar(10240),
	contraindication varchar(10240),
	created_date timestamp,
	department _text,
	description varchar(10240),
	ean varchar(255),
	"implementation" varchar(255),
	indication varchar(10240),
	"name" varchar(2048),
	photo bytea,
	price float4,
	related_products _text,
	retencao_receita varchar(255),
	updated_date timestamp,
	url varchar(10240),
	cron varchar(14));
	
--Insert 5 (3min)

insert into product 
SELECT p.id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
p.implementation, p.indication, p.name, p.photo, p.price, p.updated_date, p.url, p.related_products, p.active_ingredient, p.retencao_receita, 
p.cron 
        FROM 
                dblink('dbname=postgres port=5432 host=afarmapopular-prod.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarmapopular',
                'SELECT * from public.product p')
            AS p (id uuid,
	brand varchar(10240),
	category varchar(10240),
	contraindication varchar(10240),
	created_date timestamp,
	department _text,
	description varchar(10240),
	ean varchar(255),
	"implementation" varchar(255),
	indication varchar(10240),
	"name" varchar(2048),
	photo bytea,
	price float4,
	updated_date timestamp,
	url varchar(10240),
	related_products _text,
	active_ingredient varchar(10240),
	retencao_receita varchar(255),
	cron varchar(14));
	


