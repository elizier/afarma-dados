select p.name, p.ean, gg.grupo, gg.nome,  ((similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))) 
from public.product p, public.generico_grupo gg,
(
select p.ean, max((similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome)))))
from public.product p, public.generico_grupo gg 
where (similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))>0.5
group by p.ean 
) s 
where s.ean=p.ean and s.max=(similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))
and (similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))>0.5
and p.ean not in (select distinct(gr.ean) from public.genericos_ref gr)

NULLIF(regexp_replace(po_number, '\D','','g'), '')::numeric

select p.ean, count(p.ean) from 
(
select p.name, regexp_replace(p.name, '\D', '', 'g') as numerico1,
 p.ean, gg.grupo, gg.nome,
regexp_replace(gg.nome, '\D', '', 'g') as numerico2, ((similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome)))))
	from (
		select p.name, p.ean from public.product p,
		(
		select max(LENGTH(p.name)), p.ean
		from public.product p 
		group by p.ean) l
		where  l.max = LENGTH(p.name) and l.ean=p.ean
	) p, public.generico_grupo gg--,
		(
		select p.ean, max((similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome)))))
		from public.product p, public.generico_grupo gg 
		where (similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))>0.7
		group by p.ean 
	) s 
where s.ean=p.ean and s.max=(similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))
and (similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))>0.7
and 
p.ean not in (select distinct(gr.ean) from public.genericos_ref gr where gr.ean notnull)
and regexp_replace(p.name, '\D', '', 'g') != regexp_replace(gg.nome, '\D', '', 'g')
) p
group by p.ean
order by count(p.ean) desc 



select p.ean, (similarity(upper(unaccent(p.name)), upper(unaccent(gr.nome_grupo)))) from public.product p, public.genericos_ref gr 
where (similarity(upper(unaccent(p.name)), upper(unaccent(gr.nome_grupo))))>0.7
and p.ean not in (select distinct(gr.ean) from public.genericos_ref gr where gr.ean notnull)

insert into public.genericos_ref select p.id, p.grupo, p.name, p.ean, p.brand
from 
(
select uuid_generate_v4() as id, p.name, regexp_replace(p.name, '\D', '', 'g') as numerico1, p.ean, gg.grupo, gg.nome,
regexp_replace(gg.nome, '\D', '', 'g') as numerico2,
((similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))), UPPER(p.brand) as brand
	from (
		select p.name, p.ean, p.brand from public.product p,
		(
		select max(LENGTH(p.name)), p.ean
		from public.product p 
		group by p.ean) l
		where  l.max = LENGTH(p.name) and l.ean=p.ean
	) p, public.generico_grupo gg,
		(
		select p.ean, max((similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome)))))
		from public.product p, public.generico_grupo gg 
		where (similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))>0.6
		group by p.ean 
	) s
where s.ean=p.ean and s.max=(similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))
and (similarity(upper(unaccent(p.name)), upper(unaccent(gg.nome))))>0.6
and p.ean not in (select distinct(gr.ean) from public.genericos_ref gr)
) p


----------------------------------------------------------------------
