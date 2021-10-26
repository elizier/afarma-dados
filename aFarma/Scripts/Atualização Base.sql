--insert into public.product

insert into public.product_prov
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


--Insert Categoria

insert into afarma.categoria select uuid_generate_v4(), g.translate from 
((select distinct(translate (UPPER(p.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p)
except
(select g.categoria from afarma.categoria g)) g;


--MARCA

insert into afarma.marca select uuid_generate_v4(), m.translate from 
((select distinct(translate (UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p )
except
(select m.marca from afarma.marca m)) m;


--DEPARTAMENTOS


insert into afarma.departamento_xpto select uuid_generate_v4(), d.translate from
((select distinct(translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
(select '38d88e0e-fe60-46fa-b226-dcdd43001b75' as "id_nao_identificado", 'NÃO IDENTIFICADO' as "dep_nao_identificado",s.id , s.departamento
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
select (cast(uuid_generate_v4() as varchar)), y.contraindicacao, y.descricao,y.ean,y.indicacao, translate (UPPER(y.nome),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'), '',y.categoria,y.marca,(cast(y.photo as varchar)),y.departamento,
y.principioativo 
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
translate (UPPER(p.contraindication),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "contraindicacao",
translate (UPPER(p.description),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "descricao",
translate (UPPER(p.ean),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "ean",
translate (UPPER(p.indication),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
translate(UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = m.marca 
and 
translate(UPPER(p.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = c.categoria
and
translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=dx.departamento
and 
dx.departamento=dp.departamento_xpto 
and 
dp.departamento_afarma_id=d.id 
and
f.photo=p.photo
and 
translate (UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') in 
((select translate (UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
 

-- PRODUTO CONCORRENTE

insert into afarma.produtoconcorrente
select uuid_generate_v4(), y.data,y.ean,y.url,y.valor,y.concorrente,y.produto
from 
(select
p.updated_date as "data",
translate (UPPER(p.ean),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "ean",
p.url as "url",
p.price as "valor",
c.id as "concorrente",
k.id as "produto"
from public.product p, afarma.concorrente c, afarma.produtocrawler k, afarma.photo f
where 
translate(UPPER(p.implementation),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = c.concorrente 
and translate(UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') =k.nome
and f.id=k.photo_id and f.photo=p.photo
and 
p.ean in
((select translate (UPPER(p.ean),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') from public.product p)
except 
(select pc.ean from afarma.produtoconcorrente pc))
) y
;


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
	


--Produto

--Produto

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
 max( case when dm.id isnull then (select d.id from afarma.dominio d where d.nome='NÃO IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='PRINCIPIO ATIVO')) else dm.id end) as id
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.product_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produtocrawler p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome
group by r.nome, r.ean)
union all
(select r.nome, r.ean, 
 max( case when dm.id isnull then (select d.id from afarma.dominio d where d.nome='NÃO IDENTIFICADO'
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
where translate (UPPER(x.max),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
((select pr.name, pr.ean, (select d.id from afarma.dominio d where d.nome='NÃO IDENTIFICADO'
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
where translate (UPPER(pr.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=p.nome and pr.ean!= 'DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, max(p.photo_id) from
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x left join afarma.produtocrawler p
on translate (UPPER(x.max),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
max(case when LENGTH(pc.contraindicacao)<12 then 'NÃO POSSUI' else pc.contraindicacao end)
isnull then 'NÃO POSSUI'
else max(case when LENGTH(pc.contraindicacao)<12 then 'NÃO POSSUI' else pc.contraindicacao end) end)
from afarma.produtocrawler pc, public.product_ref pr where pr.ean=pc.ean and pr.ean!='DIVERSOS'
group by pr.name, pr.ean)
union all
(select x.max, x.ean, 
(case when 
max(case when LENGTH(pc.contraindicacao)<12 then 'NÃO POSSUI' else pc.contraindicacao end)
isnull then 'NÃO POSSUI'
else max(case when LENGTH(pc.contraindicacao)<12 then 'NÃO POSSUI' else pc.contraindicacao end) end)
from (select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, afarma.produtocrawler pc, public.genericos_ref gr 
where x.ean=gr.ean and  gr.ean=pc.ean
group by x.max, x.ean)) ci,
--indicacao
((select pr.name, pr.ean, (case when 
max(case when LENGTH(pc.indicacao)<6  then 'NÃO POSSUI'
when pc.indicacao='\R\N\R\N ' then 'NÃO POSSUI'
when pc.indicacao='<DIV ID=\' then 'NÃO POSSUI'
when pc.indicacao=' \R\N\R\N ' then 'NÃO POSSUI'
when pc.indicacao='<P STYLE=\' then 'NÃO POSSUI' else pc.contraindicacao end)
isnull then 'NÃO POSSUI'
else max(case when LENGTH(pc.indicacao)<12 then 'NÃO POSSUI' else pc.indicacao end) end)
from afarma.produtocrawler pc, public.product_ref pr where pr.ean=pc.ean and pr.ean!='DIVERSOS'
group by pr.name, pr.ean) 
union all
(select x.max, x.ean, (case when 
max(case when LENGTH(pc.indicacao)<6  then 'NÃO POSSUI'
when pc.indicacao='\R\N\R\N ' then 'NÃO POSSUI'
when pc.indicacao='<DIV ID=\' then 'NÃO POSSUI'
when pc.indicacao=' \R\N\R\N ' then 'NÃO POSSUI'
when pc.indicacao='<P STYLE=\' then 'NÃO POSSUI' else pc.contraindicacao end)
isnull then 'NÃO POSSUI'
else max(case when LENGTH(pc.indicacao)<12 then 'NÃO POSSUI' else pc.indicacao end) end)
from (select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean) x, afarma.produtocrawler pc, public.genericos_ref gr 
where x.ean=gr.ean and gr.ean=pc.ean and gr.ean!='DIVERSOS'
group by x.max, x.ean)) ic
where gr.ean =p.ean and de.ean=p.ean and ca.ean=p.ean and ma.ean=p.ean and dp.ean=p.ean
and pa.ean=p.ean and gr.ean=p.ean and ph.ean=p.ean and ic.ean=p.ean and ci.ean=p.ean and vm.ean=p.ean
and 
p.ean in (select p.ean from (((select distinct(gr.ean) from public.genericos_ref gr
)
union all
(select distinct(pr.ean) from  public.product_ref pr where pr.grupo='NÃO POSSUI'
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

 --Departamentos
 
 
insert into afarma.produto_departamentos select uuid_generate_v4(), pd.produto_id, pd.departamento_id
from
(select pd.produto_id, pd.departamento, pd.departamento_id from 
(
select p.id as "produto_id", d.translate as "departamento", dp.id as "departamento_id" from 
(
select d.id, d.name, d.ean, d.brand, d.grupo, d.translate from (
(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%infantil%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%bebe%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%bebe%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%mae%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infanti%') then 'MUNDO INFANTIL'
when lower(pr.name) like lower('%fralda%') then 'MUNDO INFANTIL'
when lower(pr.name) like lower('%fralda%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infantil%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%leite%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%lacteo%') then 'MUNDO INFANTIL'
when translate(lower(pr.description),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.description),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infantil%') then 'MUNDO INFANTIL'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

union all
--------------------------------------------------------


(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
when pr.grupo!='NÃO POSSUI' then 'MEDICAMENTOS' 
when lower(translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) like lower('%medicamento%') then 'MEDICAMENTOS'
when pr.ean in ('7896382703072',
'7896006203094',
'7896523206448',
'7897572000025') then 'MEDICAMENTOS'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

union all
--------------------------------------------------------------


(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
when lower(pr.category) like lower('%dental%') then translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
when lower(pr.category) like lower('%idratante%') then 'DERMOCOSMETICOS'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

union all

----------------------------------------------------------------


(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))

union all


-------------------------------------------------------------------


(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'))


union all
------------------------------------------------------------------------------------------------

(select pr.*, translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(case
when lower(pr.category) like lower('%beleza%') then 'BELEZA'
when lower(pr.category) like lower('%cabelo%') then 'BELEZA'
when lower(pr.description) like lower('%sabonete%') then 'BELEZA'
when lower(pr.name) like lower('%shampoo%') then 'BELEZA'
when lower(pr.category) like lower('%idratante%') then 'BELEZA'
else translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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
'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
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





