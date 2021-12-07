SELECT p.ean, avg(p.price) FROM public.product p
where p.ean in 
(select distinct(e.ean) from
(
select e.ean from public.ean_ref e where e.ean != 'DIVERSOS'
) e)
group by p.ean
having avg(p.price) > 0
union all 
select p.ean, p.price from
(select p.nome_grupo, avg(p.price) as price from
(select p.ean, g.nome_grupo, p.price from
public.product p
left join 
public.genericos_ref g on g.ean = p.ean
where g.nome_grupo notnull and p.price > 0
group by p.ean, g.nome_grupo, p.price) p
group by p.nome_grupo) p



select p.ean, count(p.ean) from
(select max(p.name), p.ean, p."length" from
(select p.ean, max(p.length) as "length" from 
(select p.name, p.ean, LENGTH(p.name) from product p
where p.ean in 
(select distinct(e.ean) from
(
select e.ean from public.ean_ref e where e.ean != 'DIVERSOS'
union all 
select distinct(g.ean) from genericos_ref g
) e)) p
group by p.ean) p
group by p.ean, p."length") p
group by p.ean
having count(p.ean) > 1

-- Terminando o MatView

create materialized view PRODUTOS_ALL_OTIMIZADO_ILPI_RJ as
(
select cast(uuid_generate_v4() as varchar) as id, p.name as nome, p.ean, p.price as precomedio, pr.produto_id, pr.marca_id, pr.categoria_id, pr.photo_id,
pr.principioativo_id, pr.contraindicacao, pr.descricao , pr.indicacao , '' as lojapromocao, '' as photo, pr.produto_tsv, pr.departamento_id from 
(select p.name, max(p.ean) as ean, pr.price from
(select (case when g.nome_grupo isnull then p.name else g.nome_grupo end) as name, p.ean from
(select max(b.name) as name, b.ean from
(select p.ean, max(p.length) as "length" from 
(select p.name, p.ean, LENGTH(p.name) from product p
where p.ean in 
(select distinct(e.ean) from
(
select e.ean from public.ean_ref e where e.ean != 'DIVERSOS'
union all 
select distinct(g.ean) from genericos_ref g
) e) and p.price > 0) p
group by p.ean) a,
(select p.name, p.ean, LENGTH(p.name) from product p
where p.ean in 
(select distinct(e.ean) from
(
select distinct(g.ean) from genericos_ref g
) e)) b
where a.ean = b.ean and a."length" = b."length"
group by b.ean, b.length) p
left join genericos_ref g on g.ean = p.ean) p
left join
(select p.nome_grupo, avg(p.price) as price from
(select p.ean, g.nome_grupo, p.price from
public.product p
left join 
public.genericos_ref g on g.ean = p.ean
where g.nome_grupo notnull and p.price > 0
group by p.ean, g.nome_grupo, p.price) p
group by p.nome_grupo) pr on p.name = pr.nome_grupo
group by p.name, pr.price

union all 


select p.name, p.ean, pr.price from 
(select max(b.name) as name, b.ean from
(select p.ean, max(p.length) as "length" from 
(select p.name, p.ean, LENGTH(p.name) from product p
where p.ean in 
(select distinct(e.ean) from
(
select e.ean from public.ean_ref e where e.ean != 'DIVERSOS'
union all 
select distinct(g.ean) from genericos_ref g
) e) and p.price > 0) p
group by p.ean) a,
(select p.name, p.ean, LENGTH(p.name) from product p
where p.ean in 
(select distinct(e.ean) from
(
select e.ean from public.ean_ref e where e.ean != 'DIVERSOS'
) e)) b
where a.ean = b.ean and a."length" = b."length"
group by b.ean, b.length) p
left join 
(SELECT p.ean, avg(p.price) as price FROM public.product p
where p.ean in 
(select distinct(e.ean) from
(
select e.ean from public.ean_ref e where e.ean != 'DIVERSOS'
) e)
group by p.ean
having avg(p.price) > 0) pr on pr.ean = p.ean) p
left join
(select pc.ean, pc.produto_id, p.marca_id, p.categoria_id, p.photo_id,
p.principioativo_id, p.contraindicacao, p.descricao , p.indicacao, p.produto_tsv, p.departamento_id
from afarma.produtoconcorrente pc, afarma.produtocrawler p 
where pc.produto_id = p.id ) pr
on pr.ean = p.ean
where pr.produto_id notnull);


insert into afarma.produtocrawler
select (cast(uuid_generate_v4() as varchar)), y.contraindicacao, y.descricao,y.ean,y.indicacao, y.nome ,
y.categoria_id, y.departamento_id, y.marca_id, y.photo_id,
y.principioativo_id , '' as produto_tsv from
(select unaccent(UPPER(p.name)) as nome, p.ean, unaccent(UPPER(p.description)) as descricao,
unaccent(UPPER(p.contraindication)) as contraindicacao, UPPER(p.indication) as indicacao,
coalesce(m.id, (select m.id from afarma.marca m where m.marca = 'N√O IDENTIFICADO')) as marca_id, 
coalesce(pa.id, (select pa.id from afarma.principioativo pa where pa.descricao = 'N√O IDENTIFICADO')) as principioativo_id,
coalesce(c.id, (select c.id from afarma.categoria c where c.categoria = 'N√O IDENTIFICADO')) as categoria_id,
coalesce(ph.id, (select ph.id from afarma.photo ph where ph."path" = '/aFarma/img.png')) as photo_id,
d.id as departamento_id
from public.product p
left join afarma.marca m on m.marca = UPPER(p.brand)
left join afarma.principioativo pa on pa.descricao = UPPER(p.active_ingredient)
left join afarma.categoria c on c.categoria = UPPER(p.category)
left join afarma.photo ph on ph."path" = p.pathimage
left join afarma.departamento_xpto dx on translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=dx.departamento
left join afarma.departamento_de_para dp on dx.departamento=dp.departamento_xpto  
left join afarma.departamento d on dp.departamento_afarma_id=d.id 
where p.ean in
(select distinct(p.ean) from public.product p where p.ean in (select e.ean from public.ean_ref e)
except 
(select distinct(p.ean) from afarma.produtocrawler p where p.ean notnull))) y


select uuid_generate_v4()


select pc.ean, pc.produto_id, p.marca_id, p.categoria_id, p.photo_id,
p.principioativo_id, p.contraindicacao, p.descricao , p.indicacao 
from afarma.produtoconcorrente pc, afarma.produtocrawler p 
where pc.produto_id = p.id 
