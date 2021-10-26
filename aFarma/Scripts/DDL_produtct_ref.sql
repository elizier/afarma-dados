CREATE TABLE public.product_ref (
	id uuid NULL,
	name varchar(255) NULL,
	ean varchar(255) NULL,
	brand varchar(255) NULL,
	grupo varchar(255) NULL,
	category varchar(255) NULL,
	description varchar(10240) NULL
	--CONSTRAINT product_ref_pkey PRIMARY KEY (id),
	--CONSTRAINT c20c771e941fc9475b8c1fe726c17 UNIQUE (ean)
);

ALTER TABLE public.product_ref
ADD CONSTRAINT product_ref_pkey PRIMARY KEY (ID);

drop table public.product_ref

update product_ref set id=uuid_generate_v4();

CREATE TABLE public.genericos_ref (
	id varchar(36) NULL,
	grupo varchar(255) null,
	name varchar(255) NULL
	--CONSTRAINT product_ref_pkey PRIMARY KEY (id),
	--CONSTRAINT c20c771e941fc9475b8c1fe726c17 UNIQUE (ean)
);

ALTER TABLE public.product_ref ALTER COLUMN id SET DEFAULT uuid_generate_v4();
 update generico_ean set generico_id=grupo;

drop table generico_ean;

update genericos_ref set id=uuid_generate_v4();

delete from genericos_ref;

delete from product_ref;

insert into genericos_ref values (uuid_generate_v4(), '7015', 'N√O POSSUI');


insert into afarma.dominio values
(uuid_generate_v4(),	'N√O IDENTIFICADO',	'f8db5ab4-cf16-4ca6-8183-183f35ae28f3'),
(uuid_generate_v4(),	'N√O IDENTIFICADO',	'58629662-c75f-493e-ac8b-6f1a59769286'),
(uuid_generate_v4(),	'N√O IDENTIFICADO',	'4c65f533-cd56-4ea7-939d-066d5d88ad2d'),
(uuid_generate_v4(),	'N√O IDENTIFICADO',	'60f5eb50-bcd5-4cf3-833f-e7cc243cc02c'),
(uuid_generate_v4(),	'N√O IDENTIFICADO',	'a91150c3-1e22-445a-805a-cbb19b41dc14');


insert into afarma.dominio
select g.id, g.nome, g.tipo_id
from 
(select uuid_generate_v4() as "id", gr.name as "nome", '58629662-c75f-493e-ac8b-6f1a59769286' as "tipo_id"
from genericos_ref gr group by gr.name) g ; 

insert into afarma.dominio select uuid_generate_v4(), c.nome, c.tipo_id from
(select distinct(pr.category) as "nome",
'f8db5ab4-cf16-4ca6-8183-183f35ae28f3'
as "tipo_id"
from product_ref pr) c;

insert into afarma.dominio select uuid_generate_v4(), b.nome, b.tipo_id from
(select distinct(pr.brand) as "nome",
'4c65f533-cd56-4ea7-939d-066d5d88ad2d'
as "tipo_id"
from product_ref pr) b;

insert into afarma.dominio select uuid_generate_v4(), pa.nome, pa.tipo_id from
(select distinct(p.active_ingredient) as "nome",
'60f5eb50-bcd5-4cf3-833f-e7cc243cc02c'
as "tipo_id"
from product p where p.active_ingredient!='') pa;

insert into afarma.dominio select d.id, d.nome, d.tipo_id from
(select d.id, d.departamento as "nome",
'a91150c3-1e22-445a-805a-cbb19b41dc14'
as "tipo_id"
from afarma.departamento d where d.id!='38d88e0e-fe60-46fa-b226-dcdd43001b75') d;

insert into afarma.produto select uuid_generate_v4(),
from 

select gr.name, count(gr.name) from public.genericos_ref gr group by gr.name; 


--GRUPO

(select pr.name, pr.ean, 'ba10583f-3526-41ce-a635-14a55a0f4571' as "grupo_id" 
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.ean!='DIVERSOS'
group by pr.name, pr.ean)
union all 
(select max(gr.name), gr.ean, d.id
from public.genericos_ref gr, public.generico_grupo gg, afarma.tipodominio t, afarma.dominio d, public.product_ref pr
where gg.nome=d.nome and gg.grupo=gr.grupo and t.id=d.tipo_id and t.nome='GRUPO'
group by gr.name, gr.ean, d.id) ;


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
order by x.max asc));


--MARCA
((select pr.name, pr.ean, d.id as "marca_id", d.nome 
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.brand=d.nome and t.nome='MARCA' and t.id=d.tipo_id and pr.ean!='DIVERSOS')
union all 
(select max(gr.name), gr.ean, d.id
from public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d
where UPPER(gr.brand)=UPPER(d.nome) and t.id=d.tipo_id and t.nome='MARCA'
group by gr.name, gr.ean, d.id));

select z.ean, count(z.ean) from 
((select pr.name, pr.ean, d.id as "marca_id"
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.brand=d.nome and t.nome='MARCA' and t.id=d.tipo_id and pr.ean!='DIVERSOS')
union all
(select x.max, x.ean, d.id 
from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d
where gr.name=x.max and UPPER(gr.brand)=UPPER(d.nome) and d.tipo_id=t.id and t.nome='MARCA'
group by x.max, x.ean, d.id
order by x.max asc)) z
group by z.ean

order by name;


--DESCRI«√O

((select pr.name, pr.ean, pr.description as "descricao" 
from public.product_ref pr
where pr.ean!='DIVERSOS'
group by pr.name, pr.ean, pr.description)
union all 
(select max(gr.name), gr.ean, 'GENERICO' as "descricao"
from public.genericos_ref gr
group by gr.ean
order by max(gr.name) asc));

--CATEGORIA

(select pr.name, pr.ean, d.id as "categoria_id", d.nome 
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.category=d.nome and t.nome='CATEGORIA' and t.id=d.tipo_id and pr.ean!='DIVERSOS')
union all 
(select max(gr.name), gr.ean, d.id, d.nome 
from public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d, public.product_ref pr, public.generico_grupo gg 
where pr.category=d.nome and d.tipo_id=t.id and t.nome='CATEGORIA' and pr.grupo=cast(gr.grupo as varchar) 
group by gr.ean, d.id);



((select pr.name, pr.ean, d.id as "categoria_id"
from public.product_ref pr, afarma.dominio d, afarma.tipodominio t 
where pr.category=d.nome and t.nome='CATEGORIA' and t.id=d.tipo_id and pr.ean!='DIVERSOS')
union all
(select  x.max, x.ean, d.id from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d, public.product_ref pr, public.generico_grupo gg
where x.max=gr.name and pr.grupo=cast(gg.grupo as varchar) and gg.grupo=gr.grupo and gg.nome=pr.name
and pr.category=d.nome and d.tipo_id=t.id and t.nome='CATEGORIA'
group by x.max, x.ean, d.id))
order by name) ;

--DEPARTAMENTO

(select pr.name, pr.ean, dm.id as "departamento_id"
from public.product_ref pr, afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.departamento de
where pr.ean=p.ean and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
and pr.ean!='DIVERSOS' 
group by pr.ean)
union all 
(select max(gr.name), gr.ean, dm.id
from public.genericos_ref gr, afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.departamento de
where gr.ean=p.ean and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
group by gr.ean, dm.id);

select z.ean, count(z.ean) from
((select pr.name, pr.ean, max(dm.id) as "departamento_id"
from public.product_ref pr, afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.departamento de
where pr.ean=p.ean and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
and pr.ean!='DIVERSOS' 
group by pr, name, pr.ean)
union all 
(select x.max, x.ean, max(dm.id) from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
--public.genericos_ref gr, 
afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.departamento de
where translate (UPPER(x.max),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=Upper(p.nome) 
and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
group by x.max, x.ean)) z 
group by z.ean;


--PRINCIPIO ATIVO

(select y.name,y.ean,(case when (p.principioativo_id isnull or p.principioativo_id='' or p.principioativo_id=null)
then '7b25b7c2-e539-429e-bf33-f6297c81dffe' else p.principioativo_id end) from (select pr.name, pr.ean, max(dm.id) as "principioativo_id"
from public.product_ref pr, afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.principioativo pa
where pr.ean=p.ean and p.principioativo_id =pa.id and pa.descricao=dm.nome and dm.tipo_id=t.id and t.nome='PRINCIPIO ATIVO'
and pr.ean!='DIVERSOS' 
group by pr.ean, pr.name) y left join afarma.produto p on p.ean=y.ean)
union all 
(select y.nome,y.ean, (case when (p.principioativo_id isnull or p.principioativo_id='' or p.principioativo_id=null)
then '7b25b7c2-e539-429e-bf33-f6297c81dffe' else p.principioativo_id end)
from (select max(gr.name) as "nome", gr.ean, max(dm.id)  
from public.genericos_ref gr, afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.principioativo pa
where gr.ean=p.ean and p.principioativo_id=pa.id and pa.descricao=dm.nome and dm.tipo_id=t.id and t.nome='PRINCIPIO ATIVO'
group by gr.ean)  y left join afarma.produto p on p.ean=y.ean);

select z.ean, count(z.ean) from
((select pr.name, pr.ean, max(dm.id) as "principioativo_id"
from public.product_ref pr, afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.principioativo pa
where pr.ean=p.ean and p.principioativo_id =pa.id and pa.descricao=dm.nome and dm.tipo_id=t.id and t.nome='PRINCIPIO ATIVO'
and pr.ean!='DIVERSOS' 
group by pr.ean, pr.name)
union all 
(select x.max, x.ean, dm.id
from
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.principioativo pa
where
x.max=gr.name and gr.ean=p.ean and p.principioativo_id=pa.id and pa.descricao=dm.nome and dm.tipo_id=t.id and t.nome='PRINCIPIO ATIVO'
group by x.max, x.ean, dm.id)) z group by z.ean;

((select r.nome, r.ean, 
 ( case when dm.id isnull then '7b25b7c2-e539-429e-bf33-f6297c81dffe' else dm.id end)
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.product_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produto p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome)
union all
(select r.nome, r.ean, 
 ( case when dm.id isnull then '7b25b7c2-e539-429e-bf33-f6297c81dffe' else dm.id end)
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produto p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome))


-- FOTO


(select pr.name, pr.ean, max(p.photo_id) as "photo_id" from afarma.produto p, public.product_ref pr 
where translate (UPPER(pr.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=p.nome and pr.ean!= 'DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, max(p.photo_id) from
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x left join afarma.produto p
on translate (UPPER(x.max),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') =p.nome
group by x.max, x.ean);


----------------------------------------

insert into afarma.produto select uuid_generate_v4(), re.nome, re.ean, re.descricao, re.categoria_id,
re.marca_id, '', re.departamento_id, re.principioativo_id, re.grupo_id
 from 
(
select p.max as "nome", p.ean, de.descricao, ca.categoria_id, ma.marca_id, '' as "photo", dp.departamento_id, pa.id as "principioativo_id", gr.grupo_id
from 
((select max(gr.name), gr.ean from public.genericos_ref gr
group by gr.ean)
union all
(select max(pr.name), pr.ean from  public.product_ref pr
group by pr.ean)) p,
--principioativo
((select r.nome, r.ean, 
 ( case when dm.id isnull then '7b25b7c2-e539-429e-bf33-f6297c81dffe' else dm.id end)
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.product_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produto p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome)
union all
(select r.nome, r.ean, 
 ( case when dm.id isnull then '7b25b7c2-e539-429e-bf33-f6297c81dffe' else dm.id end)
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produto p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome)) pa,
--departamento
((select pr.name, pr.ean, max(dm.id) as "departamento_id"
from public.product_ref pr, afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.departamento de
where pr.ean=p.ean and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
and pr.ean!='DIVERSOS' 
group by pr, name, pr.ean)
union all 
(select x.max, x.ean, dm.id from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
--public.genericos_ref gr, 
afarma.dominio dm, afarma.tipodominio t, afarma.produto p, afarma.departamento de
where translate (UPPER(x.max),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=Upper(p.nome) 
and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
group by x.max, x.ean, dm.id)) dp,
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
(select x.max, x.ean, d.id 
from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d
where gr.name=x.max and UPPER(gr.brand)=UPPER(d.nome) and d.tipo_id=t.id and t.nome='MARCA'
group by x.max, x.ean, d.id
order by x.max asc)) ma,
--grupo
((select pr.name, pr.ean, 'ba10583f-3526-41ce-a635-14a55a0f4571' as "grupo_id" 
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
((select pr.name, pr.ean, max(p.photo_id) as "photo_id" from afarma.produto p, public.product_ref pr 
where translate (UPPER(pr.name),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=p.nome and pr.ean!= 'DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, max(p.photo_id) from
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x left join afarma.produto p
on translate (UPPER(x.max),'·‡‚„‰Âaaa¡¬√ƒ≈AAA¿ÈËÍÎeeeeeEEE…EE»ÏÌÓÔÏiiiÃÕŒœÃIIIÛÙıˆoooÚ“”‘’÷OOO˘˙˚¸uuuuŸ⁄€‹UUUUÁ«Ò—˝›',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') =p.nome
group by x.max, x.ean)) ph
where gr.ean =p.ean and de.ean=p.ean and ca.ean=p.ean and ma.ean=p.ean and dp.ean=p.ean
and pa.ean=p.ean and gr.ean=p.ean
group by p.max, p.ean, de.descricao, ca.categoria_id, ma.marca_id, dp.departamento_id, pa.id, gr.grupo_id
order by p.max asc) re;


delete from afarma.produto ;


insert into afarma.produto select uuid_generate_v4(), re.nome, re.ean, re.descricao, re.categoria_id,
re.marca_id, re.photo_id, re.departamento_id, re.principioativo_id, re.grupo_id
 from 
(
select p.max as "nome", p.ean, de.descricao, ca.categoria_id, ma.marca_id, ph.photo_id, dp.departamento_id, pa.id as "principioativo_id", gr.grupo_id
from 
((select max(gr.name), gr.ean from public.genericos_ref gr
group by gr.ean)
union all
(select max(pr.name), pr.ean from  public.product_ref pr
group by pr.ean)) p,
--principioativo
((select r.nome, r.ean, 
 ( case when dm.id isnull then '7b25b7c2-e539-429e-bf33-f6297c81dffe' else dm.id end)
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.product_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produto p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome)
union all
(select r.nome, r.ean, 
 ( case when dm.id isnull then '7b25b7c2-e539-429e-bf33-f6297c81dffe' else dm.id end)
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produto p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome)) pa,
--departamento
((select pr.name, pr.ean, max(dm.id) as "departamento_id"
from public.product_ref pr, afarma.dominio dm, afarma.tipodominio t, afarma.produtocrawler p, afarma.departamento de
where pr.ean=p.ean and p.departamento_id=de.id and de.departamento=dm.nome and dm.tipo_id=t.id and t.nome='DEPARTAMENTO'
and pr.ean!='DIVERSOS' 
group by pr, name, pr.ean)
union all 
(select x.max, x.ean, max(dm.id) from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
--public.genericos_ref gr, 
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
(select x.max, x.ean, d.id 
from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x,
public.genericos_ref gr, afarma.tipodominio t, afarma.dominio d
where gr.name=x.max and UPPER(gr.brand)=UPPER(d.nome) and d.tipo_id=t.id and t.nome='MARCA'
group by x.max, x.ean, d.id
order by x.max asc)) ma,
--grupo
((select pr.name, pr.ean, 'ba10583f-3526-41ce-a635-14a55a0f4571' as "grupo_id" 
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
group by x.max, x.ean)) ph
where gr.ean =p.ean and de.ean=p.ean and ca.ean=p.ean and ma.ean=p.ean and dp.ean=p.ean
and pa.ean=p.ean and gr.ean=p.ean and ph.ean=p.ean
group by p.max, p.ean, de.descricao, ca.categoria_id, ma.marca_id, dp.departamento_id, pa.id, gr.grupo_id, ph.photo_id
order by p.max asc) re;





















-- BUSCAS
select b.id, b.nome, b.ean, b.descricao, b.categoria, b.marca, b.departamento, b.principioativo, b.grupo
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
select p.*
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) 
or upper(p.nome) like upper(:busca)
)
and (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and d.tipo_id=t.id 
group by 
p.id, p.ean, p.nome, p.descricao) b
left join afarma.dominio d
on d.id=b.categoria_id) b
left join afarma.dominio d
on d.id=b.marca_id) b
left join afarma.dominio d
on d.id=b.departamento_id) b
left join afarma.dominio d
on d.id=b.principioativo_id) b
left join afarma.dominio d
on d.id=b.grupo_id
) b
;





select p.id, p.ean, p.nome, p.descricao,
(case when p.categoria_id=d.id then d.nome else p.categoria_id end) as "categoria",
(case when p.departamento_id =d.id then d.nome else p.departamento_id end) as "departamento",
(case when p.grupo_id =d.id then d.nome else p.grupo_id end) as "grupo",
(case when p.marca_id =d.id then d.nome else p.marca_id end) as "marca",
(case when p.principioativo_id =d.id then d.nome else p.principioativo_id end) as "principioativo"
from afarma.produto p, afarma.dominio d, afarma.tipodominio t 
where
(upper(d.nome) like upper(:busca) 
or upper(p.nome) like upper(:busca)
)
and (d.id=p.categoria_id or d.id=p.departamento_id or d.id=p.grupo_id or d.id=p.marca_id or d.id=p.principioativo_id)
and d.tipo_id=t.id 
group by 
p.id, p.ean, p.nome, p.descricao,
(case when p.categoria_id=d.id then d.nome else p.categoria_id end),
(case when p.departamento_id =d.id then d.nome else p.departamento_id end),
(case when p.grupo_id =d.id then d.nome else p.grupo_id end),
(case when p.marca_id =d.id then d.nome else p.marca_id end),
(case when p.principioativo_id =d.id then d.nome else p.principioativo_id end);

select d.id, dp.departamento, dp.backgroundcolor, dp.image
from afarma.dominio d, afarma.tipodominio t, afarma.departamento dp
where
t.nome='DEPARTAMENTO' and d.tipo_id=t.id and dp.id=d.id

select * from afarma.departamento dp;

delete from afarma.produto 




 select count (*) from ((select pr.ean, pr.name from public.product_ref pr) 
union all 
(select gr.ean, gr.name from public.genericos_ref gr)) a;












