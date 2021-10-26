(select uuid_generate_v4() as id, 
mp.concorrente as loja,  
(case when mp.grupo_0 isnull then mp.nome_0 else mp.grupo_0 end) as a0nome_0, 
 mp.ean_0 as ean_0, mp.quantidade_0 as qtde_0, 
(case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506236' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) as "a0valor_0",  
(case when mp.grupo_1 isnull then mp.nome_1 else mp.grupo_1 end) as a1nome_1, 
 mp.ean_1 as ean_1, mp.quantidade_1 as qtde_1, 
(case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506243' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) as "a1valor_1",  
(case when mp.grupo_2 isnull then mp.nome_2 else mp.grupo_2 end) as a2nome_2, 
 mp.ean_2 as ean_2, mp.quantidade_2 as qtde_2, 
(case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422507059' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) as "a2valor_2",  
(case when mp.grupo_3 isnull then mp.nome_3 else mp.grupo_3 end) as a3nome_3, 
 mp.ean_3 as ean_3, mp.quantidade_3 as qtde_3, 
(case when mp.valor_3 = 0 then mp.precomedio_3 
when min(mp.valor_3)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506229' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_3  
else mp.valor_3 end) as "a3valor_3",  
(case when mp.grupo_4 isnull then mp.nome_4 else mp.grupo_4 end) as a4nome_4, 
 mp.ean_4 as ean_4, mp.quantidade_4 as qtde_4, 
(case when mp.valor_4 = 0 then mp.precomedio_4 
when min(mp.valor_4)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896714207551' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_4  
else mp.valor_4 end) as "a4valor_4",  
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506236' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 1 )+  
((case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506243' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) * 1 )+  
((case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422507059' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) * 1 )+  
((case when mp.valor_3 = 0 then mp.precomedio_3 
when min(mp.valor_3)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506229' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_3  
else mp.valor_3 end) * 1 )+  
((case when mp.valor_4 = 0 then mp.precomedio_4 
when min(mp.valor_4)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896714207551' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_4  
else mp.valor_4 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_4" , cast(gr.nome_grupo as varchar) as "grupo_4" from  
( 
select mp.*, p.precomedio as "precomedio_3" , cast(gr.nome_grupo as varchar) as "grupo_3" from  
( 
select mp.*, p.precomedio as "precomedio_2" , cast(gr.nome_grupo as varchar) as "grupo_2" from  
( 
select mp.*, p.precomedio as "precomedio_1" , cast(gr.nome_grupo as varchar) as "grupo_1" from  
( 
select mp.*, p.precomedio as "precomedio_0" , cast(gr.nome_grupo as varchar) as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422506236') as "nome_0", '7896422506236' as "ean_0", 1 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422506243') as "nome_1", '7896422506243' as "ean_1", 1 as "quantidade_1", 
(case when a1.valor_1 isnull then 0 else a1.valor_1 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422507059') as "nome_2", '7896422507059' as "ean_2", 1 as "quantidade_2", 
(case when a2.valor_2 isnull then 0 else a2.valor_2 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422506229') as "nome_3", '7896422506229' as "ean_3", 1 as "quantidade_3", 
(case when a3.valor_3 isnull then 0 else a3.valor_3 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896714207551') as "nome_4", '7896714207551' as "ean_4", 1 as "quantidade_4", 
(case when a4.valor_4 isnull then 0 else a4.valor_4 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", '7896422506236' as "ean_0", 1 as "quantidade_0", a0.valor as "valor_0", 
round(cast((1 * a0.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506236' and p.ean=gr.ean limit 1) isnull then '7896422506236' 
when (select afarma.menor_preco_grupo_crawler('7896422506236')) isnull then '7896422506236' 
else (select afarma.menor_preco_grupo_crawler('7896422506236')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from afarma.concorrente c 
left join  
(select a1.concorrente as "loja", a1.nome as "nome_1", '7896422506243' as "ean_1", 1 as "quantidade_1", a1.valor as "valor_1", 
round(cast((1 * a1.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506243' and p.ean=gr.ean limit 1) isnull then '7896422506243' 
when (select afarma.menor_preco_grupo_crawler('7896422506243')) isnull then '7896422506243' 
else (select afarma.menor_preco_grupo_crawler('7896422506243')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from afarma.concorrente c 
left join  
(select a2.concorrente as "loja", a2.nome as "nome_2", '7896422507059' as "ean_2", 1 as "quantidade_2", a2.valor as "valor_2", 
round(cast((1 * a2.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422507059' and p.ean=gr.ean limit 1) isnull then '7896422507059' 
when (select afarma.menor_preco_grupo_crawler('7896422507059')) isnull then '7896422507059' 
else (select afarma.menor_preco_grupo_crawler('7896422507059')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a2  ) a2 
on a2.loja = c.concorrente) a2, 
(select c.concorrente, a3.* from afarma.concorrente c 
left join  
(select a3.concorrente as "loja", a3.nome as "nome_3", '7896422506229' as "ean_3", 1 as "quantidade_3", a3.valor as "valor_3", 
round(cast((1 * a3.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506229' and p.ean=gr.ean limit 1) isnull then '7896422506229' 
when (select afarma.menor_preco_grupo_crawler('7896422506229')) isnull then '7896422506229' 
else (select afarma.menor_preco_grupo_crawler('7896422506229')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a3  ) a3 
on a3.loja = c.concorrente) a3, 
(select c.concorrente, a4.* from afarma.concorrente c 
left join  
(select a4.concorrente as "loja", a4.nome as "nome_4", '7896714207551' as "ean_4", 1 as "quantidade_4", a4.valor as "valor_4", 
round(cast((1 * a4.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896714207551' and p.ean=gr.ean limit 1) isnull then '7896714207551' 
when (select afarma.menor_preco_grupo_crawler('7896714207551')) isnull then '7896714207551' 
else (select afarma.menor_preco_grupo_crawler('7896714207551')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a4  ) a4 
on a4.loja = c.concorrente) a4 where 
a0.concorrente = d.concorrente and a1.concorrente = d.concorrente and a2.concorrente = d.concorrente and a3.concorrente = d.concorrente and a4.concorrente = d.concorrente 
) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_0 
left join public.genericos_ref gr 
 on gr.ean=p.ean) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_1 
left join public.genericos_ref gr 
 on gr.ean=p.ean) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_2 
left join public.genericos_ref gr 
 on gr.ean=p.ean) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_3 
left join public.genericos_ref gr 
 on gr.ean=p.ean) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_4 
left join public.genericos_ref gr 
 on gr.ean=p.ean) mp 
group by mp.concorrente, 
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0, 
 mp.nome_1, mp.ean_1, mp.quantidade_1, mp.valor_1, mp.precomedio_1, mp.grupo_1, 
 mp.nome_2, mp.ean_2, mp.quantidade_2, mp.valor_2, mp.precomedio_2, mp.grupo_2, 
 mp.nome_3, mp.ean_3, mp.quantidade_3, mp.valor_3, mp.precomedio_3, mp.grupo_3, 
 mp.nome_4, mp.ean_4, mp.quantidade_4, mp.valor_4, mp.precomedio_4, mp.grupo_4) 
union all 
(select uuid_generate_v4() as id, 
'aFarma',  
max(mp.nome_0) as "nome_0", 
(case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506236' and p.ean=gr.ean limit 1) isnull then '7896422506236' 
when (select afarma.menor_preco_grupo_crawler('7896422506236')) isnull then '7896422506236' 
else (select afarma.menor_preco_grupo_crawler('7896422506236')) end) as "ean_0", 
 1 as "quantidade_0", mp.precomedio_0, 
max(mp.nome_1) as "nome_1", 
(case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506243' and p.ean=gr.ean limit 1) isnull then '7896422506243' 
when (select afarma.menor_preco_grupo_crawler('7896422506243')) isnull then '7896422506243' 
else (select afarma.menor_preco_grupo_crawler('7896422506243')) end) as "ean_1", 
 1 as "quantidade_1", mp.precomedio_1, 
max(mp.nome_2) as "nome_2", 
(case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422507059' and p.ean=gr.ean limit 1) isnull then '7896422507059' 
when (select afarma.menor_preco_grupo_crawler('7896422507059')) isnull then '7896422507059' 
else (select afarma.menor_preco_grupo_crawler('7896422507059')) end) as "ean_2", 
 1 as "quantidade_2", mp.precomedio_2, 
max(mp.nome_3) as "nome_3", 
(case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506229' and p.ean=gr.ean limit 1) isnull then '7896422506229' 
when (select afarma.menor_preco_grupo_crawler('7896422506229')) isnull then '7896422506229' 
else (select afarma.menor_preco_grupo_crawler('7896422506229')) end) as "ean_3", 
 1 as "quantidade_3", mp.precomedio_3, 
max(mp.nome_4) as "nome_4", 
(case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896714207551' and p.ean=gr.ean limit 1) isnull then '7896714207551' 
when (select afarma.menor_preco_grupo_crawler('7896714207551')) isnull then '7896714207551' 
else (select afarma.menor_preco_grupo_crawler('7896714207551')) end) as "ean_4", 
 1 as "quantidade_4", mp.precomedio_4, 
( 
((min(mp.total) - coalesce(1,0)) 
) 
*(1-(coalesce(cast(0 as double precision),0))/100)) 
from  
(select  
mp.concorrente,  
(case when mp.grupo_0 isnull then mp.nome_0 else mp.grupo_0 end) as nome_0, 
mp.ean_0, mp.quantidade_0, (case when mp.valor_0 = 0 then mp.precomedio_0 else mp.valor_0 end) as "valor_0", mp.precomedio_0,  
(case when mp.grupo_1 isnull then mp.nome_1 else mp.grupo_1 end) as nome_1, 
mp.ean_1, mp.quantidade_1, (case when mp.valor_1 = 0 then mp.precomedio_1 else mp.valor_1 end) as "valor_1", mp.precomedio_1,  
(case when mp.grupo_2 isnull then mp.nome_2 else mp.grupo_2 end) as nome_2, 
mp.ean_2, mp.quantidade_2, (case when mp.valor_2 = 0 then mp.precomedio_2 else mp.valor_2 end) as "valor_2", mp.precomedio_2,  
(case when mp.grupo_3 isnull then mp.nome_3 else mp.grupo_3 end) as nome_3, 
mp.ean_3, mp.quantidade_3, (case when mp.valor_3 = 0 then mp.precomedio_3 else mp.valor_3 end) as "valor_3", mp.precomedio_3,  
(case when mp.grupo_4 isnull then mp.nome_4 else mp.grupo_4 end) as nome_4, 
mp.ean_4, mp.quantidade_4, (case when mp.valor_4 = 0 then mp.precomedio_4 else mp.valor_4 end) as "valor_4", mp.precomedio_4,  
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506236' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 1 )+  
((case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506243' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) * 1 )+  
((case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422507059' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) * 1 )+  
((case when mp.valor_3 = 0 then mp.precomedio_3 
when min(mp.valor_3)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422506229' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_3  
else mp.valor_3 end) * 1 )+  
((case when mp.valor_4 = 0 then mp.precomedio_4 
when min(mp.valor_4)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896714207551' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_4  
else mp.valor_4 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_4" , cast(gr.nome_grupo as varchar) as "grupo_4" from  
( 
select mp.*, p.precomedio as "precomedio_3" , cast(gr.nome_grupo as varchar) as "grupo_3" from  
( 
select mp.*, p.precomedio as "precomedio_2" , cast(gr.nome_grupo as varchar) as "grupo_2" from  
( 
select mp.*, p.precomedio as "precomedio_1" , cast(gr.nome_grupo as varchar) as "grupo_1" from  
( 
select mp.*, p.precomedio as "precomedio_0" , cast(gr.nome_grupo as varchar) as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422506236') as "nome_0", '7896422506236' as "ean_0", 1 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422506243') as "nome_1", '7896422506243' as "ean_1", 1 as "quantidade_1", 
(case when a1.valor_1 isnull then 0 else a1.valor_1 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422507059') as "nome_2", '7896422507059' as "ean_2", 1 as "quantidade_2", 
(case when a2.valor_2 isnull then 0 else a2.valor_2 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422506229') as "nome_3", '7896422506229' as "ean_3", 1 as "quantidade_3", 
(case when a3.valor_3 isnull then 0 else a3.valor_3 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896714207551') as "nome_4", '7896714207551' as "ean_4", 1 as "quantidade_4", 
(case when a4.valor_4 isnull then 0 else a4.valor_4 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", '7896422506236' as "ean_0", 1 as "getQuantidade()_0", a0.valor as "valor_0", 
round(cast((1 * a0.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506236' and p.ean=gr.ean limit 1) isnull then '7896422506236' 
when (select afarma.menor_preco_grupo_crawler('7896422506236')) isnull then '7896422506236' 
else (select afarma.menor_preco_grupo_crawler('7896422506236')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from afarma.concorrente c 
left join  
(select a1.concorrente as "loja", a1.nome as "nome_1", '7896422506243' as "ean_1", 1 as "getQuantidade()_1", a1.valor as "valor_1", 
round(cast((1 * a1.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506243' and p.ean=gr.ean limit 1) isnull then '7896422506243' 
when (select afarma.menor_preco_grupo_crawler('7896422506243')) isnull then '7896422506243' 
else (select afarma.menor_preco_grupo_crawler('7896422506243')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from afarma.concorrente c 
left join  
(select a2.concorrente as "loja", a2.nome as "nome_2", '7896422507059' as "ean_2", 1 as "getQuantidade()_2", a2.valor as "valor_2", 
round(cast((1 * a2.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422507059' and p.ean=gr.ean limit 1) isnull then '7896422507059' 
when (select afarma.menor_preco_grupo_crawler('7896422507059')) isnull then '7896422507059' 
else (select afarma.menor_preco_grupo_crawler('7896422507059')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a2  ) a2 
on a2.loja = c.concorrente) a2, 
(select c.concorrente, a3.* from afarma.concorrente c 
left join  
(select a3.concorrente as "loja", a3.nome as "nome_3", '7896422506229' as "ean_3", 1 as "getQuantidade()_3", a3.valor as "valor_3", 
round(cast((1 * a3.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422506229' and p.ean=gr.ean limit 1) isnull then '7896422506229' 
when (select afarma.menor_preco_grupo_crawler('7896422506229')) isnull then '7896422506229' 
else (select afarma.menor_preco_grupo_crawler('7896422506229')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a3  ) a3 
on a3.loja = c.concorrente) a3, 
(select c.concorrente, a4.* from afarma.concorrente c 
left join  
(select a4.concorrente as "loja", a4.nome as "nome_4", '7896714207551' as "ean_4", 1 as "getQuantidade()_4", a4.valor as "valor_4", 
round(cast((1 * a4.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896714207551' and p.ean=gr.ean limit 1) isnull then '7896714207551' 
when (select afarma.menor_preco_grupo_crawler('7896714207551')) isnull then '7896714207551' 
else (select afarma.menor_preco_grupo_crawler('7896714207551')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a4  ) a4 
on a4.loja = c.concorrente) a4 where 
a0.concorrente = d.concorrente and a1.concorrente = d.concorrente and a2.concorrente = d.concorrente and a3.concorrente = d.concorrente and a4.concorrente = d.concorrente 
) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_0
left join public.genericos_ref gr  
 on gr.ean=p.ean) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_1
left join public.genericos_ref gr  
 on gr.ean=p.ean) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_2
left join public.genericos_ref gr  
 on gr.ean=p.ean) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_3
left join public.genericos_ref gr  
 on gr.ean=p.ean) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  
on p.ean = mp.ean_4
left join public.genericos_ref gr  
 on gr.ean=p.ean) mp 
group by mp.concorrente,
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0, 
 mp.nome_1, mp.ean_1, mp.quantidade_1, mp.valor_1, mp.precomedio_1, mp.grupo_1, 
 mp.nome_2, mp.ean_2, mp.quantidade_2, mp.valor_2, mp.precomedio_2, mp.grupo_2, 
 mp.nome_3, mp.ean_3, mp.quantidade_3, mp.valor_3, mp.precomedio_3, mp.grupo_3, 
 mp.nome_4, mp.ean_4, mp.quantidade_4, mp.valor_4, mp.precomedio_4, mp.grupo_4) mp 
group by  
mp.precomedio_0, 
mp.precomedio_1, 
mp.precomedio_2, 
mp.precomedio_3, 
mp.precomedio_4)












select pc.ean, count(pc.ean) from public.produtos_all_otimizado_ilpi_rj po
group by pc.ean


