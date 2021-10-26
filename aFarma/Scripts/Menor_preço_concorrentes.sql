select * from ((select c.concorrente as "loja",
a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1",
e.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", e.valor as "valor_2",
i.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", i.valor as "valor_3",
round((:quantidade1*a.valor+:quantidade2*e.valor+:quantidade3*i.valor)::numeric,2) as "total"
from afarma.concorrente c,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean1 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean2 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) e,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean3 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) i
where a.concorrente=c.concorrente and e.concorrente=c.concorrente and i.concorrente=c.concorrente)

union all

(select 'aFarma', 
'-', :ean1 as "ean_1",:quantidade1 as "quantidade_1", '0',
'-', :ean2 as "ean_2",:quantidade2 as "quantidade_2", '0',
'-', :ean3 as "ean_3",:quantidade3 as "quantidade_3", '0',
round((min(m.total)-1)::numeric,2) from 
(select c.concorrente,
a.nome, :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor,
e.nome, :ean2 as "ean_2",:quantidade2 as "quantidade_2", e.valor,
i.nome, :ean3 as "ean_3",:quantidade3 as "quantidade_3", i.valor,
(:quantidade1*a.valor+:quantidade2*e.valor+:quantidade3*i.valor) as "total"
from afarma.concorrente c,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean1 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean2 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) e,
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean3 and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) i
where a.concorrente=c.concorrente and e.concorrente=c.concorrente and i.concorrente=c.concorrente) m)) x
group by x.loja, x.nome_1, x.ean_1, x.quantidade_1, x.valor_1,
x.nome_2, x.ean_2,x.quantidade_2, x.valor_2,
x.nome_3 ,x.ean_3, x.quantidade_3, x.valor_3, x.total
order by x.total desc;

----------------------------------------------------------------
select p.grupo_id, count(p.ean) 
from afarma.produto p 
--where p.precomedio>0
group by p.grupo_id 
having count(p.ean)=3


select pc.ean, count (pc.ean), avg(pc.valor)
from afarma.produtoconcorrente pc
where pc.ean in (select p.ean from afarma.produto p)
and pc.valor >0
group by pc.ean
having count(pc.ean)=3


select afarma.menor_preco_grupo('7896004706900');




(select 
d.concorrente,
a.nome_1, a.ean_1, a.quantidade_1, (case when a.valor_1=0 then null else a.valor_1 end),
b.nome_2, b.ean_2, b.quantidade_2, (case when b.valor_2=0 then null else b.valor_2 end),
c.nome_3, c.ean_3, c.quantidade_3, (case when c.valor_3=0 then null else c.valor_3 end),
round((:quantidade1*coalesce(a.valor_1,0)+:quantidade2*coalesce(b.valor_2,0)+:quantidade3*coalesce(c.valor_3,0))::numeric,2) as "total"
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1", round((:quantidade1*a.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and 
p.ean=(case when (select p.grupo_id from afarma.produto p where p.ean=:ean1)='aef15c44-a0b0-4353-bc0d-4ffd5f52998d' then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end)
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a  ) a
on a.loja=c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2", round((:quantidade2*b.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and
p.ean=(case when (select p.grupo_id from afarma.produto p where p.ean=:ean2)='aef15c44-a0b0-4353-bc0d-4ffd5f52998d' then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end)
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) b  ) b
on b.loja=c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3", round((:quantidade3*d.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and
p.ean=(case when (select p.grupo_id from afarma.produto p where p.ean=:ean3)='aef15c44-a0b0-4353-bc0d-4ffd5f52998d' then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end)
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) d  ) d
on d.loja=c.concorrente) c
where a.concorrente=d.concorrente and b.concorrente=d.concorrente and c.concorrente=d.concorrente )

union all 

(select 
'aFarma', 
'-', :ean1 as "ean_1",:quantidade1 as "quantidade_1", '0',
'-', :ean2 as "ean_2",:quantidade2 as "quantidade_2", '0',
'-', :ean3 as "ean_3",:quantidade3 as "quantidade_3", '0',
round(
(case 
when count(mp.ean_1)=count(mp.concorrente) and count(mp.ean_2)=count(mp.concorrente) and count(mp.ean_3)=count(mp.concorrente)
then (min((coalesce(mp.valor_1,0)*:quantidade1)+(coalesce(mp.valor_2,0)*:quantidade2)+(coalesce(mp.valor_3,0)*:quantidade3))-1)
when (count(mp.ean_1)<count(mp.concorrente) or count(mp.ean_2)<count(mp.concorrente) or count(mp.ean_3)<count(mp.concorrente))
then ((min(coalesce(mp.valor_1,0)*:quantidade1)+min(coalesce(mp.valor_2,0)*:quantidade2)+min(coalesce(mp.valor_3,0)*:quantidade3))-1)
end)::numeric,2)
from 
(
select 
d.concorrente,
a.nome_1, a.ean_1, a.quantidade_1, (case when a.valor_1=0 then null else a.valor_1 end),
b.nome_2, b.ean_2, b.quantidade_2, (case when b.valor_2=0 then null else b.valor_2 end),
c.nome_3, c.ean_3, c.quantidade_3, (case when c.valor_3=0 then null else c.valor_3 end)
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1", round((:quantidade1*a.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and 
p.ean=(case when (select p.grupo_id from afarma.produto p where p.ean=:ean1)='aef15c44-a0b0-4353-bc0d-4ffd5f52998d' then :ean1
when (select afarma.menor_preco_grupo(:ean1)) isnull then :ean1
else (select afarma.menor_preco_grupo(:ean1)) end)
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a  ) a
on a.loja=c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2", round((:quantidade2*b.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and
p.ean=(case when (select p.grupo_id from afarma.produto p where p.ean=:ean2)='aef15c44-a0b0-4353-bc0d-4ffd5f52998d' then :ean2
when (select afarma.menor_preco_grupo(:ean2)) isnull then :ean2
else (select afarma.menor_preco_grupo(:ean2)) end)
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) b  ) b
on b.loja=c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3", round((:quantidade3*d.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and
p.ean=(case when (select p.grupo_id from afarma.produto p where p.ean=:ean3)='aef15c44-a0b0-4353-bc0d-4ffd5f52998d' then :ean3
when (select afarma.menor_preco_grupo(:ean3)) isnull then :ean3
else (select afarma.menor_preco_grupo(:ean3)) end)
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) d  ) d
on d.loja=c.concorrente) c
where a.concorrente=d.concorrente and b.concorrente=d.concorrente and c.concorrente=d.concorrente 
) mp)

union all

(select 'aFarma', 
'-', :ean1 as "ean_1",:quantidade1 as "quantidade_1", '0',
'-', :ean2 as "ean_2",:quantidade2 as "quantidade_2", '0',
'-', :ean3 as "ean_3",:quantidade3 as "quantidade_3", '0',
round((min(m.total)-1)::numeric,2) from 
(select 
d.concorrente,
a.nome_1, a.ean_1, a.quantidade_1, (case when a.valor_1=0 then null else a.valor_1 end),
b.nome_2, b.ean_2, b.quantidade_2, (case when b.valor_2=0 then null else b.valor_2 end),
c.nome_3, c.ean_3, c.quantidade_3, (case when c.valor_3=0 then null else c.valor_3 end)
from 
afarma.concorrente d,
(select c.concorrente, a.* from afarma.concorrente c
left join 
(select a.concorrente as "loja", a.nome as "nome_1", :ean1 as "ean_1",:quantidade1 as "quantidade_1", a.valor as "valor_1", round((:quantidade1*a.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean1
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) a  ) a
on a.loja=c.concorrente) a,
(select c.concorrente, b.* from afarma.concorrente c
left join 
(select b.concorrente as "loja", b.nome as "nome_2", :ean2 as "ean_2",:quantidade2 as "quantidade_2", b.valor as "valor_2", round((:quantidade2*b.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean2
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) b  ) b
on b.loja=c.concorrente) b,
(select c.concorrente, d.* from afarma.concorrente c
left join 
(select d.concorrente as "loja", d.nome as "nome_3", :ean3 as "ean_3",:quantidade3 as "quantidade_3", d.valor as "valor_3", round((:quantidade3*d.valor)::numeric,2)
from 
(select c.concorrente, p.nome, p.ean, p.marca_id, p.descricao, pc.valor
from afarma.produtoconcorrente pc, afarma.produto p, afarma.concorrente c
where c.id=pc.concorrente_id and pc.ean=p.ean and p.ean=:ean3
and (c.concorrente='PACHECO' or c.concorrente='RAIA' or c.concorrente='VENANCIO')) d  ) d
on d.loja=c.concorrente) c
where a.concorrente=d.concorrente and b.concorrente=d.concorrente and c.concorrente=d.concorrente 
) m)) x
group by x.loja, x.nome_1, x.ean_1, x.quantidade_1, x.valor_1,
x.nome_2, x.ean_2,x.quantidade_2, x.valor_2,
x.nome_3 ,x.ean_3, x.quantidade_3, x.valor_3, x.total
order by x.total desc;



