CREATE OR REPLACE PROCEDURE public.insert_log_trigger()
 LANGUAGE plpgsql
AS $procedure$
begin
	
    INSERT INTO public.log_trigger(id, log)
	select uuid_generate_v4(), now();

    --commit;
end;$procedure$
;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- afarma.log_trigger definition

-- Drop table

-- DROP TABLE afarma.log_trigger;

CREATE TABLE public.log_trigger (
	log timestamp(0) NOT NULL DEFAULT now(),
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	CONSTRAINT log_trigger_pk PRIMARY KEY (id)
);

call public.insert_log_trigger()

select concat('curl -X GET "http://ec2-54-207-70-22.sa-east-1.compute.amazonaws.com:8080/api/crawlerSchedule/run?schedule%20id=',cs.id,'" -H "accept: /"') 
from crawler_schedule cs
offset 1593


CREATE OR REPLACE FUNCTION public.update_merge(parm character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
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

select parm into retorno;

return retorno;

end;
$function$
;

select cast(concat(current_date ,' ', current_time) as timestamp)
select now(), current_date , current_time
update public.log_trigger set log_fim = cast(concat(current_date ,' ', current_time) as timestamp)
where id = '4b581fb8-1c43-4d18-9770-35cb42932079' 

select public.update_merge('26-08-2021')


select r.* from pg_stat_activity r where r.backend_type='client backend'
order by r.query_start asc;

select public.update_base('28-08-21')

CREATE OR REPLACE FUNCTION public.update_base(parm character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin
	
--	select cast(uuid_generate_v4() as varchar) as proc_id
--into id_trans;

	 INSERT INTO public.log_trigger(id, log)
	select uuid_generate_v4() , now();

   
    --insert into public.product

insert into public.product
(select p.id, p.brand, p.category, p.contraindication, p.created_date, p.department, p.description, p.ean,
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
where pp.ean=p.ean and pp.implementation=p.implementation and pp.updated_date=p.updated_date 
and pp.ean in 
(
(select distinct(p.ean)
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
	cron varchar(14)))
	except
	(select distinct(p.ean) from public.product p)
	))
;



--Atualizar preÁo 2.0
update public.product set price=p.preco, updated_date=p.date
from
(select p.concorrente, p.ean1, max(p.preco) as preco, p.date from 
(select p.concorrente, p.ean1, pr.preco, p.date from
(
select p.implementation as concorrente, p.ean as ean1,  max(p.updated_date) as date
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
	group by p.ean, p.implementation) p,
	(
select p.implementation as concorrente, p.ean as ean1, p.price as preco, max(p.updated_date) as date
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
	group by p.ean, p.implementation, p.price) pr
	where pr.date=p.date and pr.ean1=p.ean1 and p.concorrente=pr.concorrente) p
	group by p.date, p.concorrente, p.ean1) p
	where p.concorrente=implementation and p.ean1=ean;
	
	
	
--Insert Categoria

insert into afarma.categoria select uuid_generate_v4(), g.translate from 
((select distinct(translate (UPPER(p.category),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p)
except
(select g.categoria from afarma.categoria g)) g;


--MARCA

insert into afarma.marca select uuid_generate_v4(), m.translate from 
((select distinct(translate (UPPER(p.brand),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p )
except
(select m.marca from afarma.marca m)) m;


--DEPARTAMENTOS


insert into afarma.departamento_xpto select uuid_generate_v4(), d.translate from
((select distinct(translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p)
except
(select d.departamento from afarma.departamento_xpto d)) d;

UPDATE afarma.departamento_de_para 
SET departamento_xpto_id = y.id
FROM (
    select x.id, d.departamento_xpto as "xptodepara", x.departamento
    from afarma.departamento_de_para d, afarma.departamento_xpto x
    where d.departamento_xpto=x.departamento) y
WHERE 
    departamento_xpto = y.departamento;

insert into afarma.departamento_de_para select z.id_nao_identificado, z.dep_nao_identificado, z.id, z.departamento from 
(select 'e4559d0f-3898-4a32-a423-fc7a95e50d75' as "id_nao_identificado", 'N√O IDENTIFICADO' as "dep_nao_identificado",s.id , s.departamento
from (select d.departamento_xpto, x.departamento, x.id
from afarma.departamento_de_para d
right join afarma.departamento_xpto x on d.departamento_xpto=x.departamento where d.departamento_xpto isnull) s, afarma.departamento_xpto t, afarma.departamento p
where s.departamento_xpto isnull
group by s.id , s.departamento) z;


--FOTO

insert into afarma.photo select uuid_generate_v4() , p.photo
from 
((select distinct(p.photo) from public.product p)
except
(select p.photo from afarma.photo p)) p;


--PRINCIPIO ATIVO

insert into afarma.principioativo select uuid_generate_v4(), pa.active_ingredient from 
((select distinct(p.active_ingredient) from product p where p.active_ingredient != '')
except 
(select pa.descricao from afarma.principioativo pa)) pa ;


--PRODUTO CRAWLER

insert into afarma.produtocrawler
select (cast(uuid_generate_v4() as varchar)), y.contraindicacao, y.descricao,y.ean,y.indicacao, translate (UPPER(y.nome),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'), '',y.categoria,y.marca,(cast(y.photo as varchar)),y.departamento,
y.principioativo , '' as produto_tsv 
from 
(select
m.contraindicacao,
m.descricao, m.ean,
m.indicacao,
m.nome,
cast(m.photo as varchar),
m.categoria,
m.marca,
m.departamento,
n.principioativo
from  (select
translate (UPPER(p.contraindication),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "contraindicacao",
translate (UPPER(p.description),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "descricao",
translate (UPPER(p.ean),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "ean",
translate (UPPER(p.indication),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "indicacao",
p.name as "nome",
f.id as "photo",
c.id as "categoria",
m.id as "marca",
d.id as "departamento",
p.active_ingredient
from
public.product p,
afarma.marca m,
afarma.categoria c,
afarma.photo f,
afarma.departamento_xpto dx,
afarma.departamento_de_para dp,
afarma.departamento d
where 
translate(UPPER(p.brand),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = m.marca 
and 
translate(UPPER(p.category),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = c.categoria
and
translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=dx.departamento
and 
dx.departamento=dp.departamento_xpto 
and 
dp.departamento_afarma_id=d.id 
and
f.photo=p.photo
and 
translate (UPPER(p.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') in 
((select translate (UPPER(p.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') from public.product p)
except 
(select pc.nome from afarma.produtocrawler pc))
) m
left join
( select p.ean, p.name as "nome", a.id as "principioativo", a.descricao
from product p
left join afarma.principioativo a
on a.descricao=p.active_ingredient) n 
on (n.nome=m.nome and n.ean=m.ean and n.descricao=m.active_ingredient)) y
 ;


update afarma.produtocrawler set produto_tsv=p.tsv from
(select p.id as id1, (to_tsvector('portuguese',upper(unaccent(p.nome))) || to_tsvector('portuguese',upper(unaccent(p.categoria))) || 
  to_tsvector('portuguese',upper(unaccent(p.marca))) || 
  to_tsvector('portuguese',upper(unaccent((case when p.descricao isnull then 'sem principio ativo' else p.descricao end))))) as tsv from 
  (
select p.id, p.nome, c.categoria, m.marca, pa.descricao from afarma.produtocrawler p
left join
afarma.categoria c
on c.id=p.categoria_id 
left join afarma.marca m
on m.id = p.marca_id 
left join afarma.principioativo pa
on pa.id=p.principioativo_id ) p ) p
where id=p.id1
;

 
--CONCORRENTE

--insert into afarma.concorrente select c.id, c.concorrente  from
--(select uuid_generate_v4() as id, c.concorrente 
--from
--(
--select distinct(p.implementation) as concorrente from public.product p 
--except
--select distinct(c.concorrente) from afarma.concorrente c
--) c ) c;


-- CONCORRENTE ESTADOS

--insert into afarma.concorrentes_estados select c.id, c.concorrente_id, c.uf  from
--(select uuid_generate_v4() as id, c.concorrente_id, 'SP' as uf
--from
--(
--select distinct(c.id) as concorrente_id from afarma.concorrente c
--except
--select distinct(c.concorrente_id) from afarma.concorrentes_estados c) c ) c


-- PRODUTO CONCORRENTE

insert into afarma.produtoconcorrente
select uuid_generate_v4(), y.data,y.ean,y.url,y.valor,y.concorrente_id,y.produto, y.concorrente
from 
(select
p.updated_date as "data",
translate (UPPER(p.ean),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "ean",
p.url as "url",
p.price as "valor",
c.id as "concorrente_id",
c.concorrente as "concorrente",
k.id as "produto"
from public.product p, afarma.concorrente c, afarma.produtocrawler k, afarma.photo f
where 
translate(UPPER(p.implementation),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = c.concorrente 
and translate(UPPER(p.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') =k.nome
and f.id=k.photo_id and f.photo=p.photo
and 
p.ean in
((select translate (UPPER(p.ean),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') from public.product p)
except 
(select pc.ean from afarma.produtoconcorrente pc))
) y
;


insert into afarma.produtoconcorrente
select uuid_generate_v4(), p.dataatualizacao, p.ean, p.url, p.valor, p.concorrente_id, p.produto_id, p.concorrente
from (
select max(p.produto_id) as produto_id, p.nome, p.ean, p.concorrente, p.valor, p.concorrente_id, p.url, p.dataatualizacao
from (
select
pc.*, c.id as concorrente_id, p.url, p.updated_date as dataatualizacao, pr.id as produto_id
from
(
select max(pc.nome) as nome, pc.ean, pc.implementation as concorrente, pc.price as valor from
(select max(p.length),  p.ean, p.implementation, p.price 
from 
(
select p.*, LENGTH(p.nome) from
(
select  pc.nome, p.ean, p.implementation, p.price from
afarma.produtocrawler pc
left join 
(
select p.ean, p.implementation, p.price from public.product p
except
select pc.ean, pc.concorrente, pc.valor from afarma.produtoconcorrente pc) p
on pc.ean = p.ean) p
where p.ean notnull
) p
group by  p.ean, p.implementation, p.price ) p,
(
select p.*, LENGTH(p.nome) from
(
select  pc.nome, p.ean, p.implementation, p.price from
afarma.produtocrawler pc
left join 
(
select p.ean, p.implementation, p.price from public.product p
except
select pc.ean, pc.concorrente, pc.valor from afarma.produtoconcorrente pc) p
on pc.ean = p.ean) p
where p.ean notnull
) pc
where pc.length=p.max and pc.ean=p.ean and pc.implementation=p.implementation
group by pc.ean, pc.implementation, pc.price) pc , afarma.concorrente c, public.product p, afarma.produtocrawler pr
where pc.ean = p.ean and pc.concorrente = p.implementation and pc.concorrente = c.concorrente
and pc.concorrente != 'DROGASIL' and pr.nome=pc.nome) p
group by p.nome, p.ean, p.concorrente, p.valor, p.concorrente_id, p.url, p.dataatualizacao) p;


delete from afarma.produtoconcorrente pc where pc.id in 
(
select p.id from (
select pc.id, pc.ean, pc.concorrente, pc.valor from afarma.produtoconcorrente pc,
(
select pc.ean, pc.concorrente from afarma.produtoconcorrente pc
group by pc.ean, pc.concorrente
having count(concat(pc.concorrente,pc.ean)) > 1
) p where p.ean = pc.ean and p.concorrente = pc.concorrente) p, public.product pr
where p.ean = pr.ean and p.concorrente = pr.implementation and p.valor != pr.price) ;


--Atualizar preco de afarma.produtoconcorrente 

update afarma.produtoconcorrente 
set valor=v.price
from
((select p.ean as ean_price, p.implementation, p.price
from public.product p)
except
(select pc.ean, c.concorrente, pc.valor 
from afarma.produtoconcorrente pc, afarma.concorrente c where c.id=pc.concorrente_id )) v
where v.ean_price=ean and v.implementation=concorrente;


update afarma.produtoconcorrente 
set url=v.url
from
((select p.ean as ean_price, p.implementation, p.url
from public.product p)
except
(select pc.ean, c.concorrente, pc.url 
from afarma.produtoconcorrente pc, afarma.concorrente c where c.id=pc.concorrente_id )) v
where v.ean_price=ean and v.implementation=concorrente;
	

--DOMINIO

--Principio Ativo

insert into afarma.dominio select uuid_generate_v4(), pa.nome, pa.tipo_id from
((select distinct(p.active_ingredient) as "nome",
'60f5eb50-bcd5-4cf3-833f-e7cc243cc02c'
as "tipo_id"
from product p where p.active_ingredient!='')
except 
(select d.nome, d.tipo_id from afarma.dominio d)) pa;

--Marca

insert into afarma.dominio select uuid_generate_v4(), m.marca, m.tipo_id from
((select distinct(m.marca) as "marca",
'4c65f533-cd56-4ea7-939d-066d5d88ad2d'
as "tipo_id"
from afarma.marca m where m.marca!='')
except 
(select d.nome, d.tipo_id from afarma.dominio d)) m;

--Categoria

insert into afarma.dominio select uuid_generate_v4(), c.categoria, c.tipo_id from
((select distinct(g.categoria),
'f8db5ab4-cf16-4ca6-8183-183f35ae28f3'
as "tipo_id"
from afarma.categoria g where g.categoria!='')
except 
(select d.nome, d.tipo_id from afarma.dominio d)) c;


--Produto

insert into afarma.produto select uuid_generate_v4(), re.nome, re.ean, re.descricao, re.categoria_id,
re.marca_id, re.photo_id, re.departamento_id, re.principioativo_id, re.grupo_id, re.contraindicacao, re.indicacao, re.precomedio,
'', ''
from
(
select p.max as "nome", p.ean, de.descricao, ca.categoria_id, ma.marca_id, ph.photo_id, dp.departamento_id,
pa.id as "principioativo_id", gr.grupo_id, ci.max as "contraindicacao", ic.max as "indicacao", vm.avg as "precomedio"
from 
((select max(gr.name), gr.ean from public.genericos_ref gr
group by gr.ean)
union all
(select max(pr.name), pr.ean from  public.product_ref pr
group by pr.ean)) p,
--principioativo
((select r.nome, r.ean, 
 max( case when dm.id isnull then (select d.id from afarma.dominio d where d.nome='N√O IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='PRINCIPIO ATIVO')) else dm.id end) as id
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.product_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produtocrawler p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome
group by r.nome, r.ean)
union all
(select r.nome, r.ean, 
 max( case when dm.id isnull then (select d.id from afarma.dominio d where d.nome='N√O IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='PRINCIPIO ATIVO')) else dm.id end) as id
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produtocrawler p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome
group by r.nome, r.ean)) pa,
--departamento
((select pr.name, pr.ean, max(dm.id) as "departamento_id"
from public.product_ref pr, afarma.dominio dm, afarma.tipodominio t, afarma.produtocrawler p, afarma.departamento de
where pr.ean=p.ean and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
and pr.ean!='DIVERSOS' 
group by pr, name, pr.ean)
union all 
(select x.max, x.ean, max(dm.id) from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x, 
afarma.dominio dm, afarma.tipodominio t, afarma.produtocrawler p, afarma.departamento de
where translate (UPPER(x.max),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=Upper(p.nome) 
and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
group by x.max, x.ean)) dp,
--categoria
((select pr.name, pr.ean, d.id as "categoria_id"
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.category=d.nome and t.nome='CATEGORIA' and t.id=d.tipo_id and pr.ean!='DIVERSOS')
union all
(select  x.max, x.ean, d.id from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d, public.product_ref pr, public.generico_grupo gg
where x.max=gr.name and pr.grupo=cast(gg.grupo as varchar) and gg.grupo=gr.grupo and gg.nome=pr.name
and pr.category=d.nome and d.tipo_id=t.id and t.nome='CATEGORIA'
group by x.max, x.ean, d.id)) ca,
--descricao
((select pr.name, pr.ean, pr.description as "descricao" 
from public.product_ref pr
where pr.ean!='DIVERSOS'
group by pr.name, pr.ean, pr.description)
union all 
(select max(gr.name), gr.ean, 'GENERICO' as "descricao"
from public.genericos_ref gr
group by gr.ean
order by max(gr.name) asc)) de,
--marca
((select pr.name, pr.ean, d.id as "marca_id"
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.brand=d.nome and t.nome='MARCA' and t.id=d.tipo_id and pr.ean!='DIVERSOS')
union all
(select x.max, x.ean, max(d.id) 
from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d
where gr.name=x.max and UPPER(gr.brand)=UPPER(d.nome) and d.tipo_id=t.id and t.nome='MARCA'
group by x.max, x.ean
order by x.max asc)) ma,
--grupo
((select pr.name, pr.ean, (select d.id from afarma.dominio d where d.nome='N√O IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='GRUPO')) as "grupo_id" 
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.ean!='DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, d.id 
from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x,
public.genericos_ref gr, public.generico_grupo gg, afarma.tipodominio t, afarma.dominio d, public.product_ref pr
where gg.nome= d.nome and gr.name=x.max and gr.grupo=gg.grupo and t.id=d.tipo_id and t.nome='GRUPO'
group by x.max, x.ean, d.id
order by x.max asc)) gr,
--foto
((select pr.name, pr.ean, max(p.photo_id) as "photo_id" from afarma.produtocrawler p, public.product_ref pr 
where translate (UPPER(pr.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=p.nome and pr.ean!= 'DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, max(p.photo_id) from
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x left join afarma.produtocrawler p
on translate (UPPER(x.max),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') =p.nome
group by x.max, x.ean)) ph,
--valormedio&menorpreco
((select pr.name, pr.ean, (case when avg(nullif(pc.valor,0)) isnull then 0 else  avg(nullif(pc.valor,0)) end) as "avg"
from public.product_ref pr, afarma.produtoconcorrente pc
where pr.ean!='DIVERSOS' and pr.ean=pc.ean 
group by pr.name, pr.ean)
union all
(select x.max, x.ean, (case when avg(nullif(pc.valor,0)) isnull then 0 else  avg(nullif(pc.valor,0)) end) as "avg" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, public.genericos_ref gr, afarma.produtoconcorrente pc
where x.max=gr.name and gr.ean=pc.ean
group by x.max, x.ean)) vm,
--contraindicacao
((select pr.name, pr.ean, (case when 
max(case when LENGTH(pc.contraindicacao)<12 then 'N√O POSSUI' else pc.contraindicacao end)
isnull then 'N√O POSSUI'
else max(case when LENGTH(pc.contraindicacao)<12 then 'N√O POSSUI' else pc.contraindicacao end) end)
from afarma.produtocrawler pc, public.product_ref pr where pr.ean=pc.ean and pr.ean!='DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, 
(case when 
max(case when LENGTH(pc.contraindicacao)<12 then 'N√O POSSUI' else pc.contraindicacao end)
isnull then 'N√O POSSUI'
else max(case when LENGTH(pc.contraindicacao)<12 then 'N√O POSSUI' else pc.contraindicacao end) end)
from (select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, afarma.produtocrawler pc, public.genericos_ref gr 
where x.ean=gr.ean and  gr.ean=pc.ean
group by x.max, x.ean)) ci,
--indicacao
((select pr.name, pr.ean, (case when 
max(case when LENGTH(pc.indicacao)<6  then 'N√O POSSUI'
when pc.indicacao='\R\N\R\N†' then 'N√O POSSUI'
when pc.indicacao='<DIV ID=\' then 'N√O POSSUI'
when pc.indicacao='†\R\N\R\N†' then 'N√O POSSUI'
when pc.indicacao='<P STYLE=\' then 'N√O POSSUI' else pc.contraindicacao end)
isnull then 'N√O POSSUI'
else max(case when LENGTH(pc.indicacao)<12 then 'N√O POSSUI' else pc.indicacao end) end)
from afarma.produtocrawler pc, public.product_ref pr where pr.ean=pc.ean and pr.ean!='DIVERSOS'
group by pr.name, pr.ean) 
union all
(select x.max, x.ean, (case when 
max(case when LENGTH(pc.indicacao)<6  then 'N√O POSSUI'
when pc.indicacao='\R\N\R\N†' then 'N√O POSSUI'
when pc.indicacao='<DIV ID=\' then 'N√O POSSUI'
when pc.indicacao='†\R\N\R\N†' then 'N√O POSSUI'
when pc.indicacao='<P STYLE=\' then 'N√O POSSUI' else pc.contraindicacao end)
isnull then 'N√O POSSUI'
else max(case when LENGTH(pc.indicacao)<12 then 'N√O POSSUI' else pc.indicacao end) end)
from (select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, afarma.produtocrawler pc, public.genericos_ref gr 
where x.ean=gr.ean and gr.ean=pc.ean and gr.ean!='DIVERSOS'
group by x.max, x.ean)) ic
where gr.ean =p.ean and de.ean=p.ean and ca.ean=p.ean and ma.ean=p.ean and dp.ean=p.ean
and pa.ean=p.ean and gr.ean=p.ean and ph.ean=p.ean and ic.ean=p.ean and ci.ean=p.ean and vm.ean=p.ean
and 
p.ean in (select p.ean from (((select distinct(gr.ean) from public.genericos_ref gr
)
union all
(select distinct(pr.ean) from  public.product_ref pr where pr.grupo='N√O POSSUI'
))
except 
(select distinct(p.ean) from afarma.produto p )) p )
group by p.max, p.ean, de.descricao, ca.categoria_id, ma.marca_id, dp.departamento_id, pa.id, gr.grupo_id, ph.photo_id,
vm.avg, ci.max, ic.max
order by p.max asc) re;

--Produto_TSV

UPDATE
    afarma.produto
SET
    produto_tsv = b.tsv
FROM
 (
  select (to_tsvector('portuguese',upper(unaccent(b.nome_produto))) || to_tsvector('portuguese',upper(unaccent(b.categoria))) || 
  to_tsvector('portuguese',upper(unaccent(b.marca))) || to_tsvector('portuguese',upper(unaccent(b.departamento))) || 
  to_tsvector('portuguese',upper(unaccent(b.principioativo))) || to_tsvector('portuguese',upper(unaccent(b.grupo)))) as "tsv", 
  b.ean as "ean_tsv", b.categoria_id, b.marca_id,
  b.departamento_id, b.principioativo_id, b.grupo_id, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo
 from  
 (  
 select  
 b.*, d.nome as "grupo"  
 from  
 (select  
 b.*, d.nome as "principioativo"  
 from  
 (select  
 b.*, d.nome as "departamento"  
 from  
 (select  
 b.*, d.nome as "marca"  
 from  
 (select   
 b.*, d.nome as "categoria"  
 from   
 (
select p.nome as "nome_produto", p.ean, p.categoria_id, p.marca_id, p.departamento_id, p.principioativo_id, p.grupo_id, d.nome from afarma.produto p, afarma.dominio d 
where p.categoria_id=d.id or p.departamento_id=d.id or p.grupo_id=d.id or p.marca_id=d.id or p.principioativo_id=d.id
 ) b  
 left join afarma.dominio d  
 on d.id = b.categoria_id) b  
 left join afarma.dominio d  
 on d.id = b.marca_id) b  
 left join afarma.dominio d  
 on d.id = b.departamento_id) b  
 left join afarma.dominio d  
 on d.id = b.principioativo_id) b  
 left join afarma.dominio d  
 on d.id = b.grupo_id  
 ) b
 group by b.nome_produto, b.ean, b.categoria_id, b.marca_id,
  b.departamento_id, b.principioativo_id, b.grupo_id, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo ) b
  where b.ean_tsv=ean;
 
 --Atualizar valor mÈdio de Produto

update afarma.produto set precomedio=vm.avg
from
(((select pr.ean as "ean_vm", (case when avg(nullif(pc.price,0)) isnull then 0 else  avg(nullif(pc.price,0)) end) as "avg"
from public.product_ref pr, public.product pc
where pr.ean!='DIVERSOS' and pr.ean=pc.ean 
group by pr.name, pr.ean)
union all
(select x.ean, (case when avg(nullif(pc.price,0)) isnull then 0 else  avg(nullif(pc.price,0)) end) as "avg" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, public.genericos_ref gr, public.product pc
where x.max=gr.name and gr.ean=pc.ean
group by x.max, x.ean))
except
(select p.ean, p.precomedio from afarma.produto p)) vm
where vm.ean_vm=afarma.produto.ean;

 --Departamentos
 
 
insert into afarma.produto_departamentos select uuid_generate_v4(), pd.produto_id, pd.departamento_id
from
(select pd.produto_id, pd.departamento, pd.departamento_id from 
(
select p.id as "produto_id", d.translate as "departamento", dp.id as "departamento_id" from 
(
select d.id, d.name, d.ean, d.brand, d.grupo, d.translate from (
(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%infantil%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%bebe%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%bebe%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%mae%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infanti%') then 'MUNDO INFANTIL'
when lower(pr.name) like lower('%fralda%') then 'MUNDO INFANTIL'
when lower(pr.name) like lower('%fralda%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infantil%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%leite%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%lacteo%') then 'MUNDO INFANTIL'
when translate(lower(pr.description),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.description),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infantil%') then 'MUNDO INFANTIL'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from (select p.* from
((select gr.id, gr.name, gr.ean, gr.brand, gr.grupo::varchar, p.category, p.description from public.genericos_ref gr, public.product p where gr.ean=p.ean)
union all 
(select p.* from public.product_ref p)) p) pr, 
public.product p
where 
pr.ean=p.ean 
group by  pr.id, pr.brand, pr.category, pr.description, pr.ean, pr.grupo, pr.name, 
translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),
'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

union all
--------------------------------------------------------


(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%mg %') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%1g %') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%mg %') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%1g %') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%mg%') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%1g%') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%mg%') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%1g%') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%mg/%') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%1g/%') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%mg/%') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%1g/%') then 'MEDICAMENTOS'
when pr.grupo!='N√O POSSUI' then 'MEDICAMENTOS' 
when lower(translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) like lower('%medicamento%') then 'MEDICAMENTOS'
when pr.ean in ('7896382703072',
'7896006203094',
'7896523206448',
'7897572000025') then 'MEDICAMENTOS'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from (select p.* from
((select gr.id, gr.name, gr.ean, gr.brand, gr.grupo::varchar, p.category, p.description from public.genericos_ref gr, public.product p where gr.ean=p.ean)
union all 
(select p.* from public.product_ref p)) p) pr, 
public.product p
where 
pr.ean=p.ean 
group by  pr.id, pr.brand, pr.category, pr.description, pr.ean, pr.grupo, pr.name, 
translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),
'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

union all
--------------------------------------------------------------


(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%sabonete%') then 'DERMOCOSMETICOS'
when lower(pr.name) like lower('%creme%') then 'DERMOCOSMETICOS'
when lower(pr.name) like lower('%shampoo%') then 'DERMOCOSMETICOS'
when lower(pr.name) like lower('%desodorante%') then 'DERMOCOSMETICOS'
when lower(pr.brand) like lower('%nivea%') then 'DERMOCOSMETICOS'
when lower(pr.brand) like lower('%cicraticure%') then 'DERMOCOSMETICOS'
when lower(pr.category) like lower('%creme%') then 'DERMOCOSMETICOS'
when lower(pr.category) like lower('%cabelo%') then 'DERMOCOSMETICOS'
when lower(pr.description) like lower('%creme%') then 'DERMOCOSMETICOS'
when lower(pr.category) like lower('%dental%') then translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
when lower(pr.category) like lower('%idratante%') then 'DERMOCOSMETICOS'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from (select p.* from
((select gr.id, gr.name, gr.ean, gr.brand, gr.grupo::varchar, p.category, p.description from public.genericos_ref gr, public.product p where gr.ean=p.ean)
union all 
(select p.* from public.product_ref p)) p) pr, 
public.product p
where 
pr.ean=p.ean 
group by  pr.id, pr.brand, pr.category, pr.description, pr.ean, pr.grupo, pr.name, 
translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),
'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

union all

----------------------------------------------------------------


(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%vitamin%') then 'SAUDE E BEM ESTAR'
when lower(pr.name) like lower('%creme%') then 'SAUDE E BEM ESTAR'
when lower(pr.name) like lower('%eite%') then 'SAUDE E BEM ESTAR'
when lower(pr.name) like lower('%desodorante%') then 'SAUDE E BEM ESTAR'
when lower(pr.name) like lower('%gel%') then 'SAUDE E BEM ESTAR'
when lower(pr.brand) like lower('%cicraticure%') then 'SAUDE E BEM ESTAR'
when lower(pr.category) like lower('%suplemento%') then 'SAUDE E BEM ESTAR'
when lower(pr.category) like lower('%pele%') then 'SAUDE E BEM ESTAR'
when lower(pr.description) like lower('%creme%') then 'SAUDE E BEM ESTAR'
when lower(pr.description) like lower('%plemento%') then 'SAUDE E BEM ESTAR'
when lower(pr.description) like lower('%ental%') then 'SAUDE E BEM ESTAR'
when lower(pr.category) like lower('%dental%') then 'SAUDE E BEM ESTAR'
when lower(pr.category) like lower('%idratante%') then 'SAUDE E BEM ESTAR'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from (select p.* from
((select gr.id, gr.name, gr.ean, gr.brand, gr.grupo::varchar, p.category, p.description from public.genericos_ref gr, public.product p where gr.ean=p.ean)
union all 
(select p.* from public.product_ref p)) p) pr, 
public.product p
where 
pr.ean=p.ean 
group by  pr.id, pr.brand, pr.category, pr.description, pr.ean, pr.grupo, pr.name, 
translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),
'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

union all


-------------------------------------------------------------------


(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%curativo%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.name) like lower('%creme%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.name) like lower('%bucal%') then 'SHIGIENE E CUIDADOS PESSOAIS'
when lower(pr.name) like lower('%desodorante%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.category) like lower('%beleza%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%higiene%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.category) like lower('%cabelo%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%sabonete%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%ntimo%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%absorvente%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%curativo%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.category) like lower('%dental%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.category) like lower('%idratante%') then 'HIGIENE E CUIDADOS PESSOAIS'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from (select p.* from
((select gr.id, gr.name, gr.ean, gr.brand, gr.grupo::varchar, p.category, p.description from public.genericos_ref gr, public.product p where gr.ean=p.ean)
union all 
(select p.* from public.product_ref p)) p) pr, 
public.product p
where 
pr.ean=p.ean 
group by  pr.id, pr.brand, pr.category, pr.description, pr.ean, pr.grupo, pr.name, 
translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),
'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))


union all
------------------------------------------------------------------------------------------------

(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(case
when lower(pr.category) like lower('%beleza%') then 'BELEZA'
when lower(pr.category) like lower('%cabelo%') then 'BELEZA'
when lower(pr.description) like lower('%sabonete%') then 'BELEZA'
when lower(pr.name) like lower('%shampoo%') then 'BELEZA'
when lower(pr.category) like lower('%idratante%') then 'BELEZA'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from (select p.* from
((select gr.id, gr.name, gr.ean, gr.brand, gr.grupo::varchar, p.category, p.description from public.genericos_ref gr, public.product p where gr.ean=p.ean)
union all 
(select p.* from public.product_ref p)) p) pr, 
public.product p
where 
pr.ean=p.ean 
group by  pr.id, pr.brand, pr.category, pr.description, pr.ean, pr.grupo, pr.name, 
translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),
'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))
) d
where d.translate in (select d.departamento from afarma.departamento d)
group by d.id, d.name, d.ean, d.brand, d.grupo, d.translate) d, afarma.produto p, afarma.departamento dp
where p.ean=d.ean and d.translate=dp.departamento 
) pd 
where pd.produto_id in 
((select distinct(pr.id) from afarma.produto pr)
except
(select distinct(pr.produto_id) from afarma.produto_departamentos pr))
) pd;

--Atualizar fotos

update afarma.produto set photo_id=f.photo_id from
(select p.id as produto, p.nome, '69d460dc-c484-4cf6-b18b-3bd102acfd7a' as photo_id from afarma.produto p
where p.descricao='GENERICO' and p.photo_id!='69d460dc-c484-4cf6-b18b-3bd102acfd7a') f
where id=f.produto;

update afarma.produto set photo_id=ph.photo from
(select p.id as produto_id, '69d460dc-c484-4cf6-b18b-3bd102acfd7a' as photo from afarma.produto p
where p.photo_id in
(select ph.id from 
(
select ph.id, p.photo, count(p.photo)
from public.product p, afarma.photo ph, afarma.produto pr
where p.photo=ph.photo and pr.ean=p.ean 
group by p.photo, ph.id
having count(p.photo)>=3
order by count(p.photo) desc
) ph)) ph
where ph.produto_id=id;

-- Atualizar photo crawler

update afarma.produtocrawler set photo_id=f.photo_id from
(select p.id as produto, p.nome, '69d460dc-c484-4cf6-b18b-3bd102acfd7a' as photo_id from afarma.produtocrawler p
where p.ean in (select distinct(gr.ean) from public.genericos_ref gr) and p.photo_id!='69d460dc-c484-4cf6-b18b-3bd102acfd7a') f
where id=f.produto;

  --Atualizar view 

drop materialized view PRODUTOS_ALL_OTIMIZADO_ILPI_RJ;

create materialized view PRODUTOS_ALL_OTIMIZADO_ILPI_RJ as
(
select p.*, t.produto_tsv, '' as lojapromocao from
(select max(p.id) as id, max(p.contraindicacao) as contraindicacao , max(p.descricao) as descricao, p.ean, max(p.indicacao) as indicacao,
max(p.nome) as nome, max(p.photo) as photo, max(p.categoria_id) as categoria_id , max(p.marca_id) as marca_id , max(p.photo_id) as photo_id,
max(p.departamento_id) as departamento_id , max(p.principioativo_id) as principioativo_id , max(p.precomedio) as precomedio from 
((select p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo, p.categoria_id, p.marca_id, p.photo_id,
p.departamento_id, p.principioativo_id, p.precomedio  from
(select max(pr.id) as id, max(pr.contraindicacao) as contraindicacao, max(pr.descricao) as descricao, pr.ean as ean, max(pr.indicacao) as indicacao,
pr.nome as nome, length(pr.nome), '' as photo, max(pr.categoria_id) as categoria_id, max(pr.marca_id) as marca_id, max(pr.photo_id) as photo_id,
max(pr.departamento_id) as departamento_id, max(pr.principioativo_id) as principioativo_id, min(nullif(pc.valor,0)) as precomedio
from afarma.produtocrawler pr, afarma.produtoconcorrente pc
where pr.ean=pc.ean and pr.ean not in (select distinct(gr.ean) from genericos_ref gr)
group by pr.ean, pr.nome
) p , (select pc.ean, max(length(pc.nome)) from afarma.produtocrawler pc group by pc.ean) l,
(select distinct(e.ean) from public.ean_ref e where e.ean notnull and e.ean!='DIVERSOS') e
where l.max=p.length and l.ean=p.ean and e.ean=p.ean
group by p.id, p.contraindicacao, p.descricao, p.ean, p.indicacao, p.nome, p.photo, p.categoria_id, p.marca_id, p.photo_id,
p.departamento_id, p.principioativo_id, p.precomedio ) 
union all
(select max(pr.id) as id, max(pr.contraindicacao), max(pr.descricao), max(pr.ean), max(pr.indicacao), gg.nome, '' as photo, max(pr.categoria_id), max(pr.marca_id),
'69d460dc-c484-4cf6-b18b-3bd102acfd7a' as photo_id, max(pr.departamento_id), max(pr.principioativo_id), min(nullif(pc.valor,0)) as precomedio
from afarma.produtocrawler pr, public.generico_grupo gg, public.genericos_ref gr, afarma.produtoconcorrente pc
where pr.ean=pc.ean and pr.ean=gr.ean and gr.grupo=gg.grupo and pr.ean in (select distinct(gr.ean) from genericos_ref gr ) 
group by gg.nome) 
) p, afarma.produtoconcorrente pc
where p.ean=pc.ean and p.precomedio notnull and p.ean!='7896026640619' and
pc.concorrente_id in (select ce.concorrente_id from afarma.concorrentes_estados ce where ce.uf = 'RJ')
group by p.ean) p 
left join (select p.id, p.produto_tsv from afarma.produtocrawler p) t
on t.id=p.id );


     update public.log_trigger set log_fim= cast(concat(current_date ,' ', current_time) as timestamp)
  from (select t.id as proc_id from public.log_trigger t group by t.id order by t.log desc limit 1) t 
 where id=t.proc_id;

select parm into retorno;

return retorno;

end;
$function$
;


-- public.log_trigger definition

-- Drop table

-- DROP TABLE public.log_trigger;

CREATE TABLE public.log_trigger (
	log timestamp(0) NOT NULL DEFAULT now(),
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	log_fim timestamptz(0) NULL,
	CONSTRAINT log_trigger_pk PRIMARY KEY (id)
);
