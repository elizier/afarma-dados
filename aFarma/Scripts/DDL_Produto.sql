select translate(UPPER(cast(p.department) as varchar), '{}',
'') from product p ;

select upper(p.department) from product p ;

SELECT translate(Upper(CAST(p.department AS varchar)), '{}"','')
from product p group by translate(Upper(CAST(p.department AS varchar)), '{}"','') ;

-- public.product definition

-- Drop table

-- DROP TABLE public.product;

CREATE TABLE public.department (
	id uuid NOT NULL,
	department varchar(255)  not NULL
);

insert into public.department select uuid_generate_v4(), translate(Upper(CAST(p.department AS varchar)), '{}"','')
from product p group by translate(Upper(CAST(p.department AS varchar)), '{}"','');

select uuid_generate_v4();


------------------------------------------------------------------------

select distinct(translate (UPPER(p.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ;

insert into afarma.categoria select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p) i;

delete from afarma.categoria;

select distinct(translate (UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ;

select distinct(p.brand) from public.product p where p.brand ='';

insert into afarma.marca select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ) i;

select distinct(translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p

insert into afarma.departamento select uuid_generate_v4(), i.translate from
(select distinct(translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p) i ;

insert into afarma.concorrente select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.implementation),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ) i;

insert into afarma.concorrente select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.implementation),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ) i;

select
translate (UPPER(p.contraindication),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "contraindicacao",
translate (UPPER(p.description),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "descricao",
translate (UPPER(p.ean),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "ean",
translate (UPPER(p.indication),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "indicacao",
translate (UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "nome",
c.id as "categoria",
m.id as "marca"
from public.product p, afarma.marca m, afarma.categoria c
where 
translate(UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = m.marca 
and 
translate(UPPER(p.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = c.categoria 
;
-----------------------------------------------------------------------------

insert into afarma.produto
select uuid_generate_v4(), y.contraindicacao, y.descricao,y.ean,y.indicacao,y.nome, '',y.categoria,y.marca,y.photo
from 
(select
translate (UPPER(p.contraindication),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "contraindicacao",
translate (UPPER(p.description),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "descricao",
translate (UPPER(p.ean),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "ean",
translate (UPPER(p.indication),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "indicacao",
translate (UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "nome",
f.id as "photo",
c.id as "categoria",
m.id as "marca"
from public.product p, afarma.marca m, afarma.categoria c, afarma.photo f
where 
translate(UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = m.marca 
and 
translate(UPPER(p.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = c.categoria
and
f.photo=p.photo) y
;


insert into afarma.produto_departamento  select y.produto, y.departamento  from
(select d.id as "departamento", k.id as "produto"
from afarma.departamento d, public.product p, afarma.produto k
where translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=d.departamento
and translate(UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=k.nome ) y
;

ALTER TABLE afarma.produto_departamento
DROP CONSTRAINT uk_79y88uw5tni755hb0ldjiwiib;

select count(p.id) from public.product p;

select count(*) from afarma.photo;
select count(f.id) from public.product p, afarma.photo f where f.photo=p.photo
------------------------------------------

insert into afarma.photo select uuid_generate_v4() , i.photo
from (select distinct(p.photo) from public.product p) i

select * from afarma.marca m 
left join public.product p 
on translate(UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = m.marca ;

select translate(UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') from  public.product p


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
from public.product p, afarma.concorrente c, afarma.produto k
where 
translate(UPPER(p.implementation),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = c.concorrente and
translate(UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') =k.nome 
) y
;

select p.photo, k.nome from afarma.photo p, afarma.produto k
where k.photo_id =p.id and p.id ='e10ceb09-3139-4867-90dd-ef86b4beb415';

delete from afarma.produtoconcorrente;

delete from afarma.departamento_xpto;

delete from afarma.produto_departamento;

delete from afarma.produtocrawler;

delete from afarma.concorrente;

--delete from afarma.departamento;

delete from afarma.categoria;

delete from afarma.marca;

delete from afarma.photo;

delete from afarma.principioativo

select x.id, d.departamento_xpto from afarma.departamento_de_para d, afarma.departamento_xpto x where d.departamento_xpto=x.departamento ;


--------------------------------------------------------------------------------------------------

--DDL Organizado

insert into afarma.categoria select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p) i;

insert into afarma.marca select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.brand),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ) i;

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

insert into afarma.concorrente select uuid_generate_v4(), i.translate from 
(select distinct(translate (UPPER(p.implementation),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) from public.product p ) i;

insert into afarma.photo select uuid_generate_v4() , i.photo
from (select distinct(p.photo) from public.product p) i;

insert into afarma.principioativo select uuid_generate_v4(), a.active_ingredient from 
(select distinct(p.active_ingredient) from product p where p.active_ingredient != '') a ;

insert into afarma.produtocrawler
select uuid_generate_v4(), y.contraindicacao, y.descricao,y.ean,y.indicacao,y.nome, '',y.categoria,y.marca,y.photo,y.departamento,
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
n.id
from (select
translate (UPPER(p.contraindication),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "contraindicacao",
translate (UPPER(p.description),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "descricao",
translate (UPPER(p.ean),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "ean",
translate (UPPER(p.indication),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "indicacao",
translate (UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "nome",
f.id as "photo",
c.id as "categoria",
m.id as "marca",
d.id as "departamento"
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
) m left join ( select p.ean, translate (UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "nome", a.id from product p
left join afarma.principioativo a
on a.descricao=p.active_ingredient) n on n.nome=m.nome ) y
;

select count(*) from public.product p;

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

select p.departamento_id , count(p.departamento_id) from afarma.produto p
group by p.departamento_id ;


select p.ean, translate (UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "nome", a.id from product p
left join afarma.principioativo a
on a.descricao=p.active_ingredient;

select count(*) from (select p.ean, translate (UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "nome", a.id from product p
left join afarma.principioativo a
on a.descricao=p.active_ingredient) t;

select count(*) from afarma.produto;
select count(*) from product p ;

update afarma.produto set departamento_id=d.departamento_afarma_id
from afarma.departamento_de_para d
where d.departamento_xpto_id=departamento_id;

insert into afarma.produto()  select y.produto, y.departamento  from
(select d.id as "departamento", k.id as "produto"
from afarma.departamento d, public.product p, afarma.produto k
where translate(translate(Upper(CAST(p.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=d.departamento
and translate(UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')=k.nome ) y
;

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

select count(*) from (select
p.updated_date as "data",
translate (UPPER(p.ean),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "ean",
p.url as "url",
p.price as "valor",
c.id as "concorrente",
k.id as "produto"
from public.product p, afarma.concorrente c, afarma.produto k, afarma.photo f
where 
translate(UPPER(p.implementation),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') = c.concorrente 
and translate(UPPER(p.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') =k.nome
and f.id=k.photo_id and f.photo=p.photo
) y
;

ALTER TABLE afarma.produto
ADD principioativo_id varchar(36);

CREATE TABLE afarma.principioativo (
	id varchar(36) NOT NULL,
	nome varchar(255) not NULL,
	CONSTRAINT principioativo_pkey PRIMARY KEY (id)
);



ALTER TABLE afarma.produto ADD CONSTRAINT bff49dcd6d59448ebe1d6d0b69d71669 FOREIGN KEY (principioativo_id) REFERENCES afarma.principioativo(id);

select * from afarma.produto p where p.id='2ef04980-d1e6-4391-8314-b54c95fd8563' or p.id='0cd7bcfd-acd5-4085-bcca-290f343fa6ca';

select uuid_generate_v4()


select count(distinct(ean)) as ean FROM afarma.produto union all
select count(distinct(nome)) as nome FROM afarma.produto union all
select count(*)as total FROM afarma.produto;

select count(distinct(ean)) as ean FROM public.product union all;
select count(distinct(name)) as nome FROM public.product union all;
select count(*)as total FROM public.product;

select (p.brand), (p.ean), (p.name), (p.price),
(p.category), p.description from public.product p
group by (p.brand), (p.ean), (p.name), (p.price),
(p.category), p.description;

select count (*) from (select (p.brand), (p.ean), (p.name), (p.price),
(p.category), p.description from public.product p
group by (p.brand), (p.ean), (p.name), (p.price),
(p.category), p.description) p;

select  * FROM afarma.produto where  ean isnull;




alter table afarma.produto drop constraint 
ALTER TABLE afarma.produto ADD CONSTRAINT fkb56tc38hl6oc5hqote3vypr99 FOREIGN KEY (departamento_id) REFERENCES afarma.departamento(id);

select * from afarma.produto p where p.photo isnull or p.photo_id ;


select pc.ean, count(pc.ean) from afarma.produto_crawler pc
group by pc.ean

update afarma.usuario set usuarioteste=true;

-----------------------Trigger usuário

CREATE OR REPLACE FUNCTION usuario_codigo_ind()

  RETURNS trigger AS

$$

BEGIN

     
UPDATE
    public.usuario 
SET
    codigoind=ci.concat
FROM
   (select cod.identificador, concat(translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),cod.codigo)
from
(select max(i.id) as "identificador", (max(cast(i.substring as integer))+1) as "codigo" from 
 (select u.id, u.nome,
 translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),
 u.codigoind, substring(u.codigoind FROM '[0-9]+') from usuario u
 where u.perfilid='2'
 order by id asc) i) cod, usuario u where u.id=cod.identificador) ci 
WHERE
    id = ci.identificador;



RETURN NEW;

END;

$$

LANGUAGE 'plpgsql';
 
 CREATE TRIGGER update_codigo_ind

  AFTER INSERT

  ON public.usuario

  FOR EACH ROW

  EXECUTE PROCEDURE usuario_codigo_ind();
 
 create extension dblink;

SELECT DBLINK_CONNECT('conexao_afarma',
'host=afarmapopular-prod.ctaih4y3js5d.sa-east-1.rds.amazonaws.com user=postgres password=afarmapopular dbname=afarma');
 
 select db.id, db.nome from
DBLINK_EXEC('conexao_afarma',
'select usuario.id, usuario.nome from public.usuario') db (id integer, nome varchar);









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
	
ALTER TABLE public.product 
DISABLE TRIGGER ALL








(select 
d.concorrente, 
(select p.nome from  afarma.produto p  where p.ean = '7891142177162') as a0nome_0 ,'7891142177162' as ean_0, 2 as qtde_0, 
(case when a0.valor isnull then 0 else a0.valor end), 
(select p.nome from  afarma.produto p  where p.ean = '7896658008801') as a1nome_1 ,'7896658008801' as ean_1, 3 as qtde_1, 
(case when a1.valor isnull then 0 else a1.valor end), 
(select p.nome from  afarma.produto p  where p.ean = '7896112425410') as a2nome_2 ,'7896112425410' as ean_2, 1 as qtde_2, 
(case when a2.valor isnull then 0 else a2.valor end), 
round(CAST((2 * coalesce(a0.valor,0) + 3 * coalesce(a1.valor,0) + 1 * coalesce(a2.valor,0) ) as numeric),2) as total 
from 
 afarma.concorrente d ,
(select c.concorrente, a0.* from  afarma.concorrente c  
left join 
(select a0.concorrente as loja, a0.nome as nome_0, 
(case when 
(select p.grupo_id from afarma.produto p where p.ean = '7891142177162') = (select dm.id 
from  afarma.dominio dm,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7891142177162' 
when (select afarma.menor_preco_grupo('7891142177162')) isnull then '7891142177162' 
else (select afarma.menor_preco_grupo('7891142177162')) end) as ean_0, 2 as qtde_0 , a0.valor as valor ,
round((2 * a0.valor)::numeric,2) 
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from  afarma.produtoconcorrente pc ,  afarma.produto p ,  afarma.concorrente c where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean=(case when 
(select p.grupo_id from afarma.produto p where p.ean = '7891142177162') = (select dm.id 
from  afarma.dominio dm,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7891142177162' 
when (select afarma.menor_preco_grupo('7891142177162')) isnull then '7891142177162' 
else (select afarma.menor_preco_grupo('7891142177162')) end) 
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from  afarma.concorrente c  
left join 
(select a1.concorrente as loja, a1.nome as nome_1, 
(case when 
(select p.grupo_id from afarma.produto p where p.ean = '7896658008801') = (select dm.id 
from  afarma.dominio dm,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7896658008801' 
when (select afarma.menor_preco_grupo('7896658008801')) isnull then '7896658008801' 
else (select afarma.menor_preco_grupo('7896658008801')) end) as ean_1, 3 as qtde_1 , a1.valor as valor ,
round((3 * a1.valor)::numeric,2) 
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from  afarma.produtoconcorrente pc ,  afarma.produto p ,  afarma.concorrente c where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean=(case when 
(select p.grupo_id from afarma.produto p where p.ean = '7896658008801') = (select dm.id 
from  afarma.dominio dm,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7896658008801' 
when (select afarma.menor_preco_grupo('7896658008801')) isnull then '7896658008801' 
else (select afarma.menor_preco_grupo('7896658008801')) end) 
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from  afarma.concorrente c  
left join 
(select a2.concorrente as loja, a2.nome as nome_2, 
(case when 
(select p.grupo_id from afarma.produto p where p.ean = '7896112425410') = (select dm.id 
from  afarma.dominio dm,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7896112425410' 
when (select afarma.menor_preco_grupo('7896112425410')) isnull then '7896112425410' 
else (select afarma.menor_preco_grupo('7896112425410')) end) as ean_2, 1 as qtde_2 , a2.valor as valor ,
round((1 * a2.valor)::numeric,2) 
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from  afarma.produtoconcorrente pc ,  afarma.produto p ,  afarma.concorrente c where c.id = pc.concorrente_id and pc.ean = p.ean and 
p.ean=(case when 
(select p.grupo_id from afarma.produto p where p.ean = '7896112425410') = (select dm.id 
from  afarma.dominio dm,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7896112425410' 
when (select afarma.menor_preco_grupo('7896112425410')) isnull then '7896112425410' 
else (select afarma.menor_preco_grupo('7896112425410')) end) 
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a2  ) a2 
on a2.loja = c.concorrente) a2
where a0.concorrente=d.concorrente and 
a1.concorrente=d.concorrente and 
a2.concorrente=d.concorrente)

 union all 
 (select 
'aFarma', 
'-' , '7891142177162' as ean_0 , 2 as qtde_0, '0' ,
'-' , '7896658008801' as ean_1 , 3 as qtde_1, '0' ,
'-' , '7896112425410' as ean_2 , 1 as qtde_2, '0' ,
round(cast
(case 
when count(mp.ean_0) = count(mp.concorrente) and count(mp.ean_1) = count(mp.concorrente) and count(mp.ean_2) = count(mp.concorrente) 
then (((min((coalesce(mp.valor_0 ,0) * 2) + (coalesce(mp.valor_1 ,0) * 3) + (coalesce(mp.valor_2 ,0) * 1))* (1-(coalesce(0,0)::double precision/100))) - coalesce(1,0))) 
when (count(mp.ean_0) < count(mp.concorrente) or count(mp.ean_1) < count(mp.concorrente) or count(mp.ean_2) < count(mp.concorrente) )
then (((min((mp.valor_0) * 2) + min((mp.valor_1) * 3) + min((mp.valor_2) * 1))* (1-(coalesce(0,0)::double precision/100))) - coalesce(1,0)) 
end as numeric),2) 
from 
( 
select 
d.concorrente, 
a0.nome_0 , a0.ean_0 , a0.qtde_0 , (case when a0.valor = 0 then null else a0.valor  end) as valor_0 ,
a1.nome_1 , a1.ean_1 , a1.qtde_1 , (case when a1.valor = 0 then null else a1.valor  end) as valor_1 ,
a2.nome_2 , a2.ean_2 , a2.qtde_2 , (case when a2.valor = 0 then null else a2.valor  end) as valor_2
from 
 afarma.concorrente d , 
(select c.concorrente, a0.* from  afarma.concorrente c  
left join 
(select a0.concorrente as loja, a0.nome as nome_0, (case when (select p.grupo_id from  afarma.produto p  where p.ean = '7891142177162'  ) = (select dm.id 
from  afarma.dominio dm ,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7891142177162' 
when (select afarma.menor_preco_grupo('7891142177162')) isnull then '7891142177162' 
else (select afarma.menor_preco_grupo('7891142177162')) end) as ean_0 , 2 as qtde_0 , a0.valor as valor, 
round(( 2 * a0.valor)::numeric,2)from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from  afarma.produtoconcorrente pc  ,  afarma.produto p , afarma.concorrente c  
where c.id=pc.concorrente_id and pc.ean=p.ean and 
p.ean = (case when (select p.grupo_id from  afarma.produto p  where p.ean = '7891142177162'  ) = (select dm.id 
from  afarma.dominio dm ,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7891142177162' 
when (select afarma.menor_preco_grupo('7891142177162')) isnull then '7891142177162' 
else (select afarma.menor_preco_grupo('7891142177162')) end)
and ( c.concorrente = 'PACHECO' or c.concorrente ='RAIA' or c.concorrente='VENANCIO')) a0  ) a0
on a0.loja=c.concorrente) a0 ,(select c.concorrente, a1.* from  afarma.concorrente c  
left join 
(select a1.concorrente as loja, a1.nome as nome_1, (case when (select p.grupo_id from  afarma.produto p  where p.ean = '7896658008801'  ) = (select dm.id 
from  afarma.dominio dm ,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7896658008801' 
when (select afarma.menor_preco_grupo('7896658008801')) isnull then '7896658008801' 
else (select afarma.menor_preco_grupo('7896658008801')) end) as ean_1 , 3 as qtde_1 , a1.valor as valor, 
round(( 3 * a1.valor)::numeric,2)from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from  afarma.produtoconcorrente pc  ,  afarma.produto p , afarma.concorrente c  
where c.id=pc.concorrente_id and pc.ean=p.ean and 
p.ean = (case when (select p.grupo_id from  afarma.produto p  where p.ean = '7896658008801'  ) = (select dm.id 
from  afarma.dominio dm ,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7896658008801' 
when (select afarma.menor_preco_grupo('7896658008801')) isnull then '7896658008801' 
else (select afarma.menor_preco_grupo('7896658008801')) end)
and ( c.concorrente = 'PACHECO' or c.concorrente ='RAIA' or c.concorrente='VENANCIO')) a1  ) a1
on a1.loja=c.concorrente) a1 ,(select c.concorrente, a2.* from  afarma.concorrente c  
left join 
(select a2.concorrente as loja, a2.nome as nome_2, (case when (select p.grupo_id from  afarma.produto p  where p.ean = '7896112425410'  ) = (select dm.id 
from  afarma.dominio dm ,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7896112425410' 
when (select afarma.menor_preco_grupo('7896112425410')) isnull then '7896112425410' 
else (select afarma.menor_preco_grupo('7896112425410')) end) as ean_2 , 1 as qtde_2 , a2.valor as valor, 
round(( 1 * a2.valor)::numeric,2)from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from  afarma.produtoconcorrente pc  ,  afarma.produto p , afarma.concorrente c  
where c.id=pc.concorrente_id and pc.ean=p.ean and 
p.ean = (case when (select p.grupo_id from  afarma.produto p  where p.ean = '7896112425410'  ) = (select dm.id 
from  afarma.dominio dm ,  afarma.tipodominio t where t.id = dm.tipo_id and t.nome = 'GRUPO' and dm.nome = 'NÃO IDENTIFICADO') then '7896112425410' 
when (select afarma.menor_preco_grupo('7896112425410')) isnull then '7896112425410' 
else (select afarma.menor_preco_grupo('7896112425410')) end)
and ( c.concorrente = 'PACHECO' or c.concorrente ='RAIA' or c.concorrente='VENANCIO')) a2  ) a2
on a2.loja=c.concorrente) a2
where a0.concorrente = d.concorrente and 
a1.concorrente = d.concorrente and 
a2.concorrente = d.concorrente) mp)


















