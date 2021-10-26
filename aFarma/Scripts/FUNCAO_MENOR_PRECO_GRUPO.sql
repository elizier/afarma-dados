

create function menor_preco_grupo(ean_generico varchar)
returns varchar
language plpgsql
as
$$
declare
   generico_ean varchar;
begin
	select p.ean 
	into generico_ean
	from produto p
	where p.grupo_id=(select p.grupo_id from afarma.produto p
	where p.ean=ean_generico) and p.precomedio!=0 
	order by p.precomedio asc
	limit 1
	offset 1
   ;
   
   return generico_ean;
end;
$$;

select menor_preco_grupo('7896422507950')


select p.name, p.ean, m.marca, c.categoria, p.description, p.contraindication,
p.indication, p.department as "departamento_antigo", d.departamento as "departamento_filtrado", p.url, p.implementation, p.price
from afarma.produtocrawler pc, public.product p, afarma.departamento d, afarma.marca m, afarma.categoria c
where d.id=pc.departamento_id and pc.ean=p.ean and m.id=pc.marca_id and c.id=pc.categoria_id
order by p.ean asc

select pr.*,d.departamento 
from public.product_ref pr, 
--public.product p, 
afarma.produtocrawler pc, afarma.departamento d
where 
--pr.ean=p.ean and
d.id=pc.departamento_id and pc.ean=pr.ean
group by  pr.id, pr.brand, pr.category, pr.description, pr.ean, pr.grupo, pr.name, --p.department,
d.departamento 



