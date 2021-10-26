select name, comment, default_version, installed_version
from pg_available_extensions
where name = 'pg_cron';

create extension if not exists pg_cron;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SELECT * FROM pg_stat_statements limit 1


select
  cron.schedule(
    'cron-merge', -- name of the cron job
    '* 22 * * *', -- every minute
    $$
    
    --Delete Merge
    
    delete from public.product;
    
     --Insert 1 (2min)

insert into public.product
SELECT *
        FROM 
                dblink('dbname=postgres port=5432 host=crawler-afarma-1.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2020',
                'SELECT * from public.product p')
            AS s (id uuid,
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
	retencao_receita varchar(255));
	

--Insert 2 (1min40s)

insert into public.product
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

insert into public.product 
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

insert into public.product
SELECT p.id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
p.implementation, p.indication, p.name, p.photo, p.price, p.updated_date, p.url, p.related_products, p.active_ingredient, p.retencao_receita, 
p.cron 
        FROM 
                dblink('dbname=postgres port=5432 host=afarma-crawler-0.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2020',
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

insert into public.product
SELECT uuid_generate_v4() as id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
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

--insert 6

insert into public.product
SELECT uuid_generate_v4() as id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
p.implementation, p.indication, p.name, p.photo, p.price, p.updated_date, p.url, p.related_products, p.active_ingredient, p.retencao_receita, 
p.cron 
        FROM 
                dblink('dbname=postgres port=5432 host=afarma-crawller-elizier.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2020',
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
	

    $$
  );
  
 CREATE OR REPLACE PROCEDURE public.update_merge()
 LANGUAGE plpgsql
AS $procedure$
begin
	
      
    --Delete Merge
    
    delete from public.product;
    
     --Insert 1 (2min)

insert into public.product
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

insert into public.product
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

insert into public.product 
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

insert into public.product
SELECT p.id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
p.implementation, p.indication, p.name, p.photo, p.price, p.updated_date, p.url, p.related_products, p.active_ingredient, p.retencao_receita, 
p.cron 
        FROM 
                dblink('dbname=postgres port=5432 host=afarma-crawler-0.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2020',
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

insert into public.product
SELECT uuid_generate_v4() as id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
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

--insert 6

insert into public.product
SELECT uuid_generate_v4() as id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
p.implementation, p.indication, p.name, p.photo, p.price, p.updated_date, p.url, p.related_products, p.active_ingredient, p.retencao_receita, 
p.cron 
        FROM 
                dblink('dbname=postgres port=5432 host=afarma-crawller-elizier.ctaih4y3js5d.sa-east-1.rds.amazonaws.com
                user=postgres password=afarma2020',
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

    commit;
end;$procedure$
;

 call public.update_merge()