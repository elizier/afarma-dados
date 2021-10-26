delete from afarma.produtoconcorrente;

delete from afarma.promocao;

delete from afarma.item_cesta;

delete from afarma.itemprodutocesta;

delete from afarma.pedido;

delete from afarma.cesta;

delete from afarma.departamento_xpto;

delete from afarma.produto_departamento;

delete from afarma.produtocrawler;

delete from afarma.concorrente;

--delete from afarma.departamento;

delete from afarma.categoria;

delete from afarma.marca;

delete from afarma.produto;

delete from afarma.dominio;

-- delete from afarma.tipodominio;

delete from afarma.photo;

delete from afarma.principioativo;

--***INSERTS***

--CATEGORIA

insert into afarma.categoria select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p) i;

--MARCA

insert into afarma.marca select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ) i;

--DEPARTAMENTOS

insert into afarma.departamento_xpto select uuid_generate_v4(), i.translate from
(select distinct(translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p) i ;

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


--CONCORRENTE

insert into afarma.concorrente select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.implementation),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ) i;

--FOTO

insert into afarma.photo select uuid_generate_v4() , i.photo
from (select distinct(p.photo) from public.product p) i;

--PRINCIPIO ATIVO

insert into afarma.principioativo select uuid_generate_v4(), a.active_ingredient from 
(select distinct(p.active_ingredient) from product p where p.active_ingredient != '') a ;

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
) m
left join
( select p.ean, p.name as "nome", a.id as "principioativo", a.descricao
from product p
left join afarma.principioativo a
on a.descricao=p.active_ingredient) n 
on (n.nome=m.nome and n.ean=m.ean and n.descricao=m.active_ingredient)) y;

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
) y
;

-- DOMINIO

insert into afarma.dominio values
(uuid_generate_v4(),	'NÃO IDENTIFICADO',	'f8db5ab4-cf16-4ca6-8183-183f35ae28f3'),
(uuid_generate_v4(),	'NÃO IDENTIFICADO',	'58629662-c75f-493e-ac8b-6f1a59769286'),
(uuid_generate_v4(),	'NÃO IDENTIFICADO',	'4c65f533-cd56-4ea7-939d-066d5d88ad2d'),
(uuid_generate_v4(),	'NÃO IDENTIFICADO',	'60f5eb50-bcd5-4cf3-833f-e7cc243cc02c'),
(uuid_generate_v4(),	'NÃO IDENTIFICADO',	'a91150c3-1e22-445a-805a-cbb19b41dc14');

insert into afarma.dominio
select g.id, g.nome, g.tipo_id
from 
(select uuid_generate_v4() as "id", gg.nome as "nome", '58629662-c75f-493e-ac8b-6f1a59769286' as "tipo_id"
from public.generico_grupo gg group by gg.nome) g ; 

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
from afarma.departamento d 
--where d.id!='38d88e0e-fe60-46fa-b226-dcdd43001b75'
) d;

-- PRODUTO

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
 ( case when dm.id isnull then (select d.id from afarma.dominio d where d.nome='NÃO IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='PRINCIPIO ATIVO')) else dm.id end)
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.product_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produtocrawler p on p.ean =x.ean
group by x.ean) y left join afarma.principioativo pa on y.principioativo_id=pa.id) r left join afarma.dominio dm
on r.descricao=dm.nome)
union all
(select r.nome, r.ean, 
 ( case when dm.id isnull then (select d.id from afarma.dominio d where d.nome='NÃO IDENTIFICADO'
and d.tipo_id=(select t.id from afarma.tipodominio t where t.nome='PRINCIPIO ATIVO')) else dm.id end)
 from (select y.nome, y.ean, pa.descricao from (select max(x.max) as "nome", x.ean, max(p.principioativo_id) as "principioativo_id" from 
(select max(gr.name), gr.ean from public.genericos_ref gr group by gr.ean order by max(gr.name) asc) x
left join afarma.produtocrawler p on p.ean =x.ean
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
p.ean in (select p.ean from (((select max(gr.name), gr.ean from public.genericos_ref gr
group by gr.ean)
union all
(select max(pr.name), pr.ean from  public.product_ref pr
group by pr.ean))
except 
(select p.nome, p.ean from afarma.produto p )) p )
group by p.max, p.ean, de.descricao, ca.categoria_id, ma.marca_id, dp.departamento_id, pa.id, gr.grupo_id, ph.photo_id,
vm.avg, ci.max, ic.max
order by p.max asc) re;

select pc.nome, pc.ean, pc.contraindicacao, pc.indicacao, pc.descricao, m.marca, d.departamento, p.descricao, c.categoria
from afarma.produtocrawler pc, afarma.marca m, afarma.departamento d, afarma.principioativo p, afarma.categoria  c
where m.id=pc.marca_id and d.id=pc.departamento_id and pc.principioativo_id=p.id and pc.categoria_id=c.id;


update afarma.produto set precomedio=0 where precomedio isnull;








