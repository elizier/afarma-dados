(select uuid_generate_v4() as id, 
mp.concorrente as loja,  
(case when mp.grupo_0 isnull then mp.nome_0 else mp.grupo_0 end) as a0nome_0, 
 mp.ean_0 as ean_0, mp.quantidade_0 as qtde_0, 
(case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) as "a0valor_0",  
(case when mp.grupo_1 isnull then mp.nome_1 else mp.grupo_1 end) as a1nome_1, 
 mp.ean_1 as ean_1, mp.quantidade_1 as qtde_1, 
(case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) as "a1valor_1",  
(case when mp.grupo_2 isnull then mp.nome_2 else mp.grupo_2 end) as a2nome_2, 
 mp.ean_2 as ean_2, mp.quantidade_2 as qtde_2, 
(case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) as "a2valor_2",  
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 2 )+  
((case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) * 3 )+  
((case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_2" , d.nome as "grupo_2" from  
( 
select mp.*, p.precomedio as "precomedio_1" , d.nome as "grupo_1" from  
( 
select mp.*, p.precomedio as "precomedio_0" , d.nome as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from afarma.produtocrawler p where p.ean = '7896181907992') as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end), 
(select p.nome from afarma.produtocrawler p where p.ean = '7896241221853') as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", 
(case when a1.valor_1 isnull then 0 else a1.valor_1 end), 
(select p.nome from afarma.produtocrawler p where p.ean = '7896422501675') as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", 
(case when a2.valor_2 isnull then 0 else a2.valor_2 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", a0.valor as "valor_0", 
round(cast((2 * a0.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produtocrawler p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produtocrawler p where p.ean = '7896181907992') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896181907992' 
when (select afarma.menor_preco_grupo('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo('7896181907992')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from afarma.concorrente c 
left join  
(select a1.concorrente as "loja", a1.nome as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", a1.valor as "valor_1", 
round(cast((3 * a1.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produtocrawler p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produtocrawler p where p.ean = '7896241221853') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896241221853' 
when (select afarma.menor_preco_grupo('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo('7896241221853')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from afarma.concorrente c 
left join  
(select a2.concorrente as "loja", a2.nome as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", a2.valor as "valor_2", 
round(cast((1 * a2.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produtocrawler p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produtocrawler p where p.ean = '7896422501675') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896422501675' 
when (select afarma.menor_preco_grupo('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo('7896422501675')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a2  ) a2 
on a2.loja = c.concorrente) a2 where 
a0.concorrente = d.concorrente and a1.concorrente = d.concorrente and a2.concorrente = d.concorrente 
) mp 
left join afarma.produtocrawler p  
on p.ean = mp.ean_0 
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
left join afarma.produtocrawler p  
on p.ean = mp.ean_1 
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
left join afarma.produtocrawler p  
on p.ean = mp.ean_2 
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
group by mp.concorrente, 
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0, 
 mp.nome_1, mp.ean_1, mp.quantidade_1, mp.valor_1, mp.precomedio_1, mp.grupo_1, 
 mp.nome_2, mp.ean_2, mp.quantidade_2, mp.valor_2, mp.precomedio_2, mp.grupo_2) 
union all 
(select uuid_generate_v4() as id, 
'aFarma',  
max(mp.nome_0) as "nome_0", 
(case when (select p.grupo_id from afarma.produtocrawler p where p.ean = '7896181907992') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896181907992' 
when (select afarma.menor_preco_grupo('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo('7896181907992')) end) as "ean_0", 
 2 as "quantidade_0", mp.precomedio_0, 
max(mp.nome_1) as "nome_1", 
(case when (select p.grupo_id from afarma.produtocrawler p where p.ean = '7896241221853') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896241221853' 
when (select afarma.menor_preco_grupo('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo('7896241221853')) end) as "ean_1", 
 3 as "quantidade_1", mp.precomedio_1, 
max(mp.nome_2) as "nome_2", 
(case when (select p.grupo_id from afarma.produtocrawler p where p.ean = '7896422501675') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896422501675' 
when (select afarma.menor_preco_grupo('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo('7896422501675')) end) as "ean_2", 
 1 as "quantidade_2", mp.precomedio_2, 
( 
((min(mp.total) - coalesce(1.0,0)) 
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
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 2 )+  
((case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) * 3 )+  
((case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_2" , d.nome as "grupo_2" from  
( 
select mp.*, p.precomedio as "precomedio_1" , d.nome as "grupo_1" from  
( 
select mp.*, p.precomedio as "precomedio_0" , d.nome as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from afarma.produtocrawler p where p.ean = '7896181907992') as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end), 
(select p.nome from afarma.produtocrawler p where p.ean = '7896241221853') as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", 
(case when a1.valor_1 isnull then 0 else a1.valor_1 end), 
(select p.nome from afarma.produtocrawler p where p.ean = '7896422501675') as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", 
(case when a2.valor_2 isnull then 0 else a2.valor_2 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", '7896181907992' as "ean_0", 2 as "getQuantidade()_0", a0.valor as "valor_0", 
round(cast((2 * a0.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produtocrawler p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produtocrawler p where p.ean = '7896181907992') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896181907992' 
when (select afarma.menor_preco_grupo('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo('7896181907992')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from afarma.concorrente c 
left join  
(select a1.concorrente as "loja", a1.nome as "nome_1", '7896241221853' as "ean_1", 3 as "getQuantidade()_1", a1.valor as "valor_1", 
round(cast((3 * a1.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produtocrawler p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produtocrawler p where p.ean = '7896241221853') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896241221853' 
when (select afarma.menor_preco_grupo('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo('7896241221853')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from afarma.concorrente c 
left join  
(select a2.concorrente as "loja", a2.nome as "nome_2", '7896422501675' as "ean_2", 1 as "getQuantidade()_2", a2.valor as "valor_2", 
round(cast((1 * a2.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produtocrawler p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produtocrawler p where p.ean = '7896422501675') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896422501675' 
when (select afarma.menor_preco_grupo('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo('7896422501675')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a2  ) a2 
on a2.loja = c.concorrente) a2 where 
a0.concorrente = d.concorrente and a1.concorrente = d.concorrente and a2.concorrente = d.concorrente 
) mp 
left join afarma.produtocrawler p  
on p.ean = mp.ean_0
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
left join afarma.produtocrawler p  
on p.ean = mp.ean_1
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
left join afarma.produtocrawler p  
on p.ean = mp.ean_2
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
group by mp.concorrente,
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0, 
 mp.nome_1, mp.ean_1, mp.quantidade_1, mp.valor_1, mp.precomedio_1, mp.grupo_1, 
 mp.nome_2, mp.ean_2, mp.quantidade_2, mp.valor_2, mp.precomedio_2, mp.grupo_2) mp 
group by  
mp.precomedio_0, 
mp.precomedio_1, 
mp.precomedio_2)



select gg.nome from public.generico_grupo gg 
except
select d.nome from afarma.dominio d, afarma.tipodominio t where d.tipo_id=t.id and t.nome = 'GRUPO'

select (case when  
(select gr.grupo from afarma.produtocrawler p, public.genericos_ref gr  where p.ean = '7898569762681' and p.ean=gr.ean limit 1) isnull then '7898569762681' 
when (select afarma.menor_preco_grupo_crawler('7898569762681')) isnull then '7898569762681' 
else (select afarma.menor_preco_grupo_crawler('7898569762681')) end)

select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean



	select afarma.menor_preco_grupo_crawler('7898569762681')

	
	----------------------------------------------------------
	
	(select uuid_generate_v4() as id, 
mp.concorrente as loja,  
(case when mp.grupo_0 isnull then mp.nome_0 else mp.grupo_0 end) as a0nome_0, 
 mp.ean_0 as ean_0, mp.quantidade_0 as qtde_0, 
(case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) as "a0valor_0",  
(case when mp.grupo_1 isnull then mp.nome_1 else mp.grupo_1 end) as a1nome_1, 
 mp.ean_1 as ean_1, mp.quantidade_1 as qtde_1, 
(case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) as "a1valor_1",  
(case when mp.grupo_2 isnull then mp.nome_2 else mp.grupo_2 end) as a2nome_2, 
 mp.ean_2 as ean_2, mp.quantidade_2 as qtde_2, 
(case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) as "a2valor_2",  
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 2 )+  
((case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) * 3 )+  
((case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_2" , d.nome as "grupo_2" from  
( 
select mp.*, p.precomedio as "precomedio_1" , d.nome as "grupo_1" from  
( 
select mp.*, p.precomedio as "precomedio_0" , gr.grupo as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from afarma.produto p where p.ean = '7896181907992') as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end), 
(select p.nome from afarma.produto p where p.ean = '7896241221853') as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", 
(case when a1.valor_1 isnull then 0 else a1.valor_1 end), 
(select p.nome from afarma.produto p where p.ean = '7896422501675') as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", 
(case when a2.valor_2 isnull then 0 else a2.valor_2 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", a0.valor as "valor_0", 
round(cast((2 * a0.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produto p where p.ean = '7896181907992') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896181907992' 
when (select afarma.menor_preco_grupo('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo('7896181907992')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from afarma.concorrente c 
left join  
(select a1.concorrente as "loja", a1.nome as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", a1.valor as "valor_1", 
round(cast((3 * a1.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produto p where p.ean = '7896241221853') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896241221853' 
when (select afarma.menor_preco_grupo('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo('7896241221853')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from afarma.concorrente c 
left join  
(select a2.concorrente as "loja", a2.nome as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", a2.valor as "valor_2", 
round(cast((1 * a2.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produto p where p.ean = '7896422501675') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896422501675' 
when (select afarma.menor_preco_grupo('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo('7896422501675')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a2  ) a2 
on a2.loja = c.concorrente) a2 where 
a0.concorrente = d.concorrente and a1.concorrente = d.concorrente and a2.concorrente = d.concorrente 
) mp 
left join (select p.ean, avg(nullif(p.valor,0)) as precomedio from afarma.produtoconcorrente p group by p.ean) p  ---****************************************
on p.ean = mp.ean_0 
left join public.genericos_ref gr 
 on gr.ean=p.ean) mp 
left join afarma.produto p  
on p.ean = mp.ean_1 
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
left join afarma.produto p  
on p.ean = mp.ean_2 
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
group by mp.concorrente, 
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0, 
 mp.nome_1, mp.ean_1, mp.quantidade_1, mp.valor_1, mp.precomedio_1, mp.grupo_1, 
 mp.nome_2, mp.ean_2, mp.quantidade_2, mp.valor_2, mp.precomedio_2, mp.grupo_2) 
union all 
(select uuid_generate_v4() as id, 
'aFarma',  
max(mp.nome_0) as "nome_0", 
(case when (select p.grupo_id from afarma.produto p where p.ean = '7896181907992') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896181907992' 
when (select afarma.menor_preco_grupo('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo('7896181907992')) end) as "ean_0", 
 2 as "quantidade_0", mp.precomedio_0, 
max(mp.nome_1) as "nome_1", 
(case when (select p.grupo_id from afarma.produto p where p.ean = '7896241221853') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896241221853' 
when (select afarma.menor_preco_grupo('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo('7896241221853')) end) as "ean_1", 
 3 as "quantidade_1", mp.precomedio_1, 
max(mp.nome_2) as "nome_2", 
(case when (select p.grupo_id from afarma.produto p where p.ean = '7896422501675') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896422501675' 
when (select afarma.menor_preco_grupo('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo('7896422501675')) end) as "ean_2", 
 1 as "quantidade_2", mp.precomedio_2, 
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
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 2 )+  
((case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) * 3 )+  
((case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_2" , d.nome as "grupo_2" from  
( 
select mp.*, p.precomedio as "precomedio_1" , d.nome as "grupo_1" from  
( 
select mp.*, p.precomedio as "precomedio_0" , d.nome as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from afarma.produto p where p.ean = '7896181907992') as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end), 
(select p.nome from afarma.produto p where p.ean = '7896241221853') as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", 
(case when a1.valor_1 isnull then 0 else a1.valor_1 end), 
(select p.nome from afarma.produto p where p.ean = '7896422501675') as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", 
(case when a2.valor_2 isnull then 0 else a2.valor_2 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", '7896181907992' as "ean_0", 2 as "getQuantidade()_0", a0.valor as "valor_0", 
round(cast((2 * a0.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produto p where p.ean = '7896181907992') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896181907992' 
when (select afarma.menor_preco_grupo('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo('7896181907992')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from afarma.concorrente c 
left join  
(select a1.concorrente as "loja", a1.nome as "nome_1", '7896241221853' as "ean_1", 3 as "getQuantidade()_1", a1.valor as "valor_1", 
round(cast((3 * a1.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produto p where p.ean = '7896241221853') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896241221853' 
when (select afarma.menor_preco_grupo('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo('7896241221853')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from afarma.concorrente c 
left join  
(select a2.concorrente as "loja", a2.nome as "nome_2", '7896422501675' as "ean_2", 1 as "getQuantidade()_2", a2.valor as "valor_2", 
round(cast((1 * a2.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select p.grupo_id from afarma.produto p where p.ean = '7896422501675') = (select d.id  
from afarma.dominio d, afarma.tipodominio t where t.id = d.tipo_id and t.nome = 'GRUPO' and d.nome isnull) then '7896422501675' 
when (select afarma.menor_preco_grupo('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo('7896422501675')) end) 
and (c.concorrente = 'PACHECO' or c.concorrente = 'RAIA' or c.concorrente = 'VENANCIO')) a2  ) a2 
on a2.loja = c.concorrente) a2 where 
a0.concorrente = d.concorrente and a1.concorrente = d.concorrente and a2.concorrente = d.concorrente 
) mp 
left join afarma.produto p  
on p.ean = mp.ean_0
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
left join afarma.produto p  
on p.ean = mp.ean_1
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
left join afarma.produto p  
on p.ean = mp.ean_2
left join afarma.dominio d 
 on d.id=p.grupo_id) mp 
group by mp.concorrente,
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0, 
 mp.nome_1, mp.ean_1, mp.quantidade_1, mp.valor_1, mp.precomedio_1, mp.grupo_1, 
 mp.nome_2, mp.ean_2, mp.quantidade_2, mp.valor_2, mp.precomedio_2, mp.grupo_2) mp 
group by  
mp.precomedio_0, 
mp.precomedio_1, 
mp.precomedio_2)

	-----------------------------------------------------------------TESTE 1


(select uuid_generate_v4() as id, 
mp.concorrente as loja,  
(case when mp.grupo_0 isnull then mp.nome_0 else mp.grupo_0 end) as a0nome_0, 
 mp.ean_0 as ean_0, mp.quantidade_0 as qtde_0, 
(case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) as "a0valor_0",  
(case when mp.grupo_1 isnull then mp.nome_1 else mp.grupo_1 end) as a1nome_1, 
 mp.ean_1 as ean_1, mp.quantidade_1 as qtde_1, 
(case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) as "a1valor_1",  
(case when mp.grupo_2 isnull then mp.nome_2 else mp.grupo_2 end) as a2nome_2, 
 mp.ean_2 as ean_2, mp.quantidade_2 as qtde_2, 
(case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) as "a2valor_2",  
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 2 )+  
((case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) * 3 )+  
((case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_2" , cast(gr.nome_grupo as varchar) as "grupo_2" from  
( 
select mp.*, p.precomedio as "precomedio_1" , cast(gr.nome_grupo as varchar) as "grupo_1" from  
( 
select mp.*, p.precomedio as "precomedio_0" , cast(gr.nome_grupo as varchar) as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896181907992') as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896241221853') as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", 
(case when a1.valor_1 isnull then 0 else a1.valor_1 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422501675') as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", 
(case when a2.valor_2 isnull then 0 else a2.valor_2 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", a0.valor as "valor_0", 
round(cast((2 * a0.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896181907992' and p.ean=gr.ean limit 1) isnull then '7896181907992' 
when (select afarma.menor_preco_grupo_crawler('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo_crawler('7896181907992')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from afarma.concorrente c 
left join  
(select a1.concorrente as "loja", a1.nome as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", a1.valor as "valor_1", 
round(cast((3 * a1.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896241221853' and p.ean=gr.ean limit 1) isnull then '7896241221853' 
when (select afarma.menor_preco_grupo_crawler('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo_crawler('7896241221853')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from afarma.concorrente c 
left join  
(select a2.concorrente as "loja", a2.nome as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", a2.valor as "valor_2", 
round(cast((1 * a2.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422501675' and p.ean=gr.ean limit 1) isnull then '7896422501675' 
when (select afarma.menor_preco_grupo_crawler('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo_crawler('7896422501675')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a2  ) a2 
on a2.loja = c.concorrente) a2 where 
a0.concorrente = d.concorrente and a1.concorrente = d.concorrente and a2.concorrente = d.concorrente 
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
group by mp.concorrente, 
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0, 
 mp.nome_1, mp.ean_1, mp.quantidade_1, mp.valor_1, mp.precomedio_1, mp.grupo_1, 
 mp.nome_2, mp.ean_2, mp.quantidade_2, mp.valor_2, mp.precomedio_2, mp.grupo_2) 
union all 
(select uuid_generate_v4() as id, 
'aFarma',  
max(mp.nome_0) as "nome_0", 
(case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896181907992' and p.ean=gr.ean limit 1) isnull then '7896181907992' 
when (select afarma.menor_preco_grupo_crawler('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo_crawler('7896181907992')) end) as "ean_0", 
 2 as "quantidade_0", mp.precomedio_0, 
max(mp.nome_1) as "nome_1", 
(case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896241221853' and p.ean=gr.ean limit 1) isnull then '7896241221853' 
when (select afarma.menor_preco_grupo_crawler('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo_crawler('7896241221853')) end) as "ean_1", 
 3 as "quantidade_1", mp.precomedio_1, 
max(mp.nome_2) as "nome_2", 
(case when (select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422501675' and p.ean=gr.ean limit 1) isnull then '7896422501675' 
when (select afarma.menor_preco_grupo_crawler('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo_crawler('7896422501675')) end) as "ean_2", 
 1 as "quantidade_2", mp.precomedio_2, 
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
( 
((case when mp.valor_0 = 0 then mp.precomedio_0 
when min(mp.valor_0)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896181907992' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_0  
else mp.valor_0 end) * 2 )+  
((case when mp.valor_1 = 0 then mp.precomedio_1 
when min(mp.valor_1)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896241221853' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_1  
else mp.valor_1 end) * 3 )+  
((case when mp.valor_2 = 0 then mp.precomedio_2 
when min(mp.valor_2)<((select p.valor from afarma.produtoconcorrente p where p.ean='7896422501675' ORDER BY p.valor ASC OFFSET 1 LIMIT 1) * ((100-cast(20 as double precision))/100)) then mp.precomedio_2  
else mp.valor_2 end) * 1 )) as "total" 
from 
( 
select mp.*, p.precomedio as "precomedio_2" , cast(gr.nome_grupo as varchar) as "grupo_2" from  
( 
select mp.*, p.precomedio as "precomedio_1" , cast(gr.nome_grupo as varchar) as "grupo_1" from  
( 
select mp.*, p.precomedio as "precomedio_0" , cast(gr.nome_grupo as varchar) as "grupo_0" from  
(select  
d.concorrente, 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896181907992') as "nome_0", '7896181907992' as "ean_0", 2 as "quantidade_0", 
(case when a0.valor_0 isnull then 0 else a0.valor_0 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896241221853') as "nome_1", '7896241221853' as "ean_1", 3 as "quantidade_1", 
(case when a1.valor_1 isnull then 0 else a1.valor_1 end), 
(select p.nome from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p where p.ean = '7896422501675') as "nome_2", '7896422501675' as "ean_2", 1 as "quantidade_2", 
(case when a2.valor_2 isnull then 0 else a2.valor_2 end)from  
afarma.concorrente d, 
(select c.concorrente, a0.* from afarma.concorrente c 
left join  
(select a0.concorrente as "loja", a0.nome as "nome_0", '7896181907992' as "ean_0", 2 as "getQuantidade()_0", a0.valor as "valor_0", 
round(cast((2 * a0.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896181907992' and p.ean=gr.ean limit 1) isnull then '7896181907992' 
when (select afarma.menor_preco_grupo_crawler('7896181907992')) isnull then '7896181907992' 
else (select afarma.menor_preco_grupo_crawler('7896181907992')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a0  ) a0 
on a0.loja = c.concorrente) a0, 
(select c.concorrente, a1.* from afarma.concorrente c 
left join  
(select a1.concorrente as "loja", a1.nome as "nome_1", '7896241221853' as "ean_1", 3 as "getQuantidade()_1", a1.valor as "valor_1", 
round(cast((3 * a1.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896241221853' and p.ean=gr.ean limit 1) isnull then '7896241221853' 
when (select afarma.menor_preco_grupo_crawler('7896241221853')) isnull then '7896241221853' 
else (select afarma.menor_preco_grupo_crawler('7896241221853')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a1  ) a1 
on a1.loja = c.concorrente) a1, 
(select c.concorrente, a2.* from afarma.concorrente c 
left join  
(select a2.concorrente as "loja", a2.nome as "nome_2", '7896422501675' as "ean_2", 1 as "getQuantidade()_2", a2.valor as "valor_2", 
round(cast((1 * a2.valor) as numeric),2) 
from  
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor 
from afarma.produtoconcorrente pc, public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, afarma.concorrente c 
where c.id = pc.concorrente_id and pc.ean = p.ean and  
p.ean = (case when  
(select gr.grupo from public.PRODUTOS_ALL_OTIMIZADO_ILPI_RJ p, public.genericos_ref gr  where p.ean = '7896422501675' and p.ean=gr.ean limit 1) isnull then '7896422501675' 
when (select afarma.menor_preco_grupo_crawler('7896422501675')) isnull then '7896422501675' 
else (select afarma.menor_preco_grupo_crawler('7896422501675')) end) 
and (c.concorrente in (select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'))) a2  ) a2 
on a2.loja = c.concorrente) a2 where 
a0.concorrente = d.concorrente and a1.concorrente = d.concorrente and a2.concorrente = d.concorrente 
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
group by mp.concorrente,
 mp.nome_0, mp.ean_0, mp.quantidade_0, mp.valor_0, mp.precomedio_0, mp.grupo_0, 
 mp.nome_1, mp.ean_1, mp.quantidade_1, mp.valor_1, mp.precomedio_1, mp.grupo_1, 
 mp.nome_2, mp.ean_2, mp.quantidade_2, mp.valor_2, mp.precomedio_2, mp.grupo_2) mp 
group by  
mp.precomedio_0, 
mp.precomedio_1, 
mp.precomedio_2)






select uuid_generate_v4()


insert into public.genericos_ref(id,grupo) 
select uuid_generate_v4(), r.grupo from
(
select gg.grupo from public.generico_grupo gg 
except
select distinct(gr.grupo) from public.genericos_ref gr ) r

update public.genericos_ref set nome_grupo=r.nome
from
(select gr.id as id1, gg.nome from public.genericos_ref gr 
left join public.generico_grupo gg on gg.grupo=gr.grupo ) r
where id=r.id1

select c.concorrente from afarma.concorrentes_estados ce, afarma.concorrente c where c.id=ce.concorrente_id and ce.uf = 'RJ'

