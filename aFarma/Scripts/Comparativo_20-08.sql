select concat('curl -X GET "http://ec2-54-207-70-22.sa-east-1.compute.amazonaws.com:8080/api/crawlerSchedule/run?schedule%20id=',cs.id,'" -H "accept: /"')
from crawler_schedule cs
order by concat asc
limit 100
offset 200



select count(*) from (
select p.*, (case when p.valorpacheco = 0 and p.valorraia = 0 and p.valorvenancio = 0 then 'Não Existe' else 'Existe' end) as Estoque from 
(
select pr.ean, pr.name,
coalesce(p.price,0) as valorpacheco, 
coalesce(v.price,0) as valorvenancio ,
coalesce(r.price,0) as valorraia ,
pr.precomedio,
p.url as urlpacheco,
v.url as urlvenancio,
r.url as urlraia from 
(select distinct(pr.ean), min(pr.name) as name, avg((case when pr.price = 0 then null else pr.price end)) as precomedio
from product pr group by pr.ean) pr
left join (select * from product p where p.implementation= 'PACHECO') p on pr.ean = p.ean
left join (select * from product p where p.implementation= 'VENANCIO') v on pr.ean = v.ean
left join (select * from product p where p.implementation= 'RAIA') r on pr.ean = r.ean
where pr.ean notnull) p ) p where p.estoque = 'Existe'