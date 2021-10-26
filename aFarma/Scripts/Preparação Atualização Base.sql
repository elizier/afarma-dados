-- public.product definition

-- Drop table

-- DROP TABLE public.product;

CREATE TABLE public.product_prov (
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
	"name" varchar(2048) NOT NULL,
	photo bytea NULL,
	price float4 NOT NULL,
	related_products _text NULL,
	retencao_receita varchar(255) NULL,
	updated_date timestamp NULL,
	url varchar(10240) NOT NULL,
	cron varchar(14) NULL
);




(select p.ean from 
((select max(pr.name) as name, pr.ean, max(upper(pr.brand)) as brand from public.product_ref pr where pr.grupo = 'NÃO POSSUI'
group by pr.ean)
union all
(select max(gr.name) as name, gr.ean, max(upper(gr.brand)) as brand from public.genericos_ref gr 
group by gr.ean)) p
)
except
(select p.ean from public.product_prov p)


--group by pp.id, pp.active_ingredient, pp.brand, pp.category, pp.contraindication, pp.created_date, pp.department, pp.description, pp.ean,
---pp.implementation, pp.indication, pp.name, pp.photo, pp.price, pp.related_products, pp.retencao_receita, pp.url, pp.cron ) p

--select max(pp.id), max(pp.active_ingredient), max(pp.brand), max(pp.category), max(pp.contraindication), max(pp.created_date), max(pp.department), 
--max(pp.description), pp.ean, pp.implementation, max(pp.indication), max(pp.name), max(pp.photo), pp.price, pp.related_products, pp.retencao_receita, max(pp.updated_date), pp.url, pp.cron 

select p.ean1, count((p.ean1)) from
(select * from public.product_prov pp,
(select pp.implementation, pp.ean as ean1, max(pp.updated_date) from public.product_prov pp where pp.ean in 
(select p.ean from 
((select pr.name, pr.ean, pr.brand from public.product_ref pr where pr.grupo = 'NÃO POSSUI')
union all
(select max(gr.name), gr.ean, gr.brand from public.genericos_ref gr 
group by gr.ean, gr.brand)) p
order by p.name)
group by pp.ean, pp.implementation) p 
where p.implementation=pp.implementation and p.ean1=pp.ean and p.max=pp.updated_date ) p
group by p.ean1

select * from usu






select count(u.id) from public.usuario u where u.usuarioteste=false
and u.perfilid=2 and extract(month from u.dataaceite)=6





select pp.* from public.product_prov pp,
(select pp.ean, pp.implementation, max(pp.updated_date)
from public.product_prov pp
group by pp.ean, pp.implementation) p
where pp.ean=p.ean and pp.implementation=p.implementation and pp.updated_date=p.max


select p.id, p.active_ingredient, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
p.implementation, p.indication, p.name, p.photo, p.price, p.updated_date, p.url, p.related_products, p.active_ingredient, p.retencao_receita 
p.cron 
from public.product p where p.ean in
((select p.ean from public.product p )
except
(select pp.ean from public.product_prov pp ))



-- Insert 6 (10min)

insert into public.product_prov
select p.id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
p.implementation, p.indication, p.name, p.photo, p.price, p.updated_date, p.url, p.related_products, p.active_ingredient, p.retencao_receita,
p.cron 
FROM 
 dblink('dbname=postgres port=5432 host=crawler-merge.ctaih4y3js5d.sa-east-1.rds.amazonaws.com user=postgres password=afarma2021',
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
	cron varchar(14)),
(
select pp.ean, pp.implementation, max(pp.updated_date) as updated_date from 
(
select *
FROM 
 dblink('dbname=postgres port=5432 host=crawler-merge.ctaih4y3js5d.sa-east-1.rds.amazonaws.com user=postgres password=afarma2021',
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
	cron varchar(14))
) pp
group by pp.ean, pp.implementation) pp
where pp.ean=p.ean and pp.implementation=p.implementation and pp.updated_date=p.updated_date;


