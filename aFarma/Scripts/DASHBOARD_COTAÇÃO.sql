select r.* from pg_stat_activity r where r.backend_type='client backend'
order by r.query_start asc;

select pg_cancel_backend(21122);



--Quantidade de Cotação por mês

SELECT extract( month from r.data), extract( year from r.data), count(r.id)
FROM afarma.registrocotacao r
group by  extract( month from r.data), extract( year from r.data);

--Quantidade de cotações por período

select count(r.id)
FROM afarma.registrocotacao r
where cast(r.data as date) between TO_DATE(:datainicio,'DD-MM-YYYY') and TO_DATE(:datafim,'DD-MM-YYYY')

-- Total de cotação

select count(r.id) FROM afarma.registrocotacao r

--Cotações por status

select r.status,--varchar
count(r.id)--int
from afarma.registrocotacao r
where r.status=:status--parametro varchar
group by r.status

--Cotações por status no período

select r.status, -- varchar
count(r.id)-- int
from afarma.registrocotacao r
where cast(r.data as date) between TO_DATE(:datainicio,'DD/MM/YYYY') and TO_DATE(:datafim,'DD/MM/YYYY')-- parametro date
and r.status=:status--parametro varchar
group by r.status

--Cotações / cliente / período filtrado

select r.nome ,--VARCHAR
count(r.id)-- int
from afarma.registrocotacao r 
where r.nome notnull and r.nome != '' and lower(r.nome) not like '%teste%'
and cast(r.data as date) between TO_DATE(:datainicio,'DD/MM/YYYY') and TO_DATE(:datafim,'DD/MM/YYYY')-- parametro date
group by r.nome

-- Expectativa de venda no período
select extract( month from r.data) as mes, extract( year from r.data) as ano, concat('R$ ',round(cast(sum(r.valor) as numeric),2)) as total
from afarma.registrocotacaodetalhado r
where r.loja='aFarma' and 
cast(r.data as date) between TO_DATE(:datainicio,'DD/MM/YYYY') and TO_DATE(:datafim,'DD/MM/YYYY')
group by extract( month from r.data), extract( year from r.data)
--select r.cotacaoid, r.valor from
--(select r.cotacaoid , min(r.valor) as valor from afarma.registrocotacaodetalhado r group by r.cotacaoid ) r
--group by r.cotacaoid, r.valor
--having  count(r.valor)>3

-- Expectativa de venda mensal
select extract( month from r.data) as mes, extract( year from r.data) as ano, concat('R$ ',round(cast(sum(r.valor) as numeric),2)) as total
from afarma.registrocotacaodetalhado r
where r.loja='aFarma'
group by extract( month from r.data), extract( year from r.data)
--select r.cotacaoid, r.valor from
--(select r.cotacaoid , min(r.valor) as valor from afarma.registrocotacaodetalhado r group by r.cotacaoid ) r
--group by r.cotacaoid, r.valor
--having  count(r.valor)>3

--Listagem de cotações por status

select r.cotacaoid, c.data, r.valor, c.status
from afarma.registrocotacaodetalhado r, afarma.registrocotacao c
where c.id = r.cotacaoid and r.loja = 'aFarma' and c.status = coalesce(:status,c.status)
order by c.data asc



