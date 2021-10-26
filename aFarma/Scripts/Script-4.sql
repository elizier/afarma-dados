copy (select encode(p.photo,'hex') from public.product p limit 1)
    TO 'C:\Users\mathe\Pictures\aFarma_caixa\imagetest.hext' ;
    
   
select decode(replace(cast(p.photo as text),'\',''), 'hex') from public.product p


select p.id, p.active_ingredient , p.brand , p.category  , p.contraindication , p.created_date , p.department , p.description , p.ean ,
p."implementation" , p.indication , p."name" , p.price , p.related_products , p.retencao_receita , p.updated_date , p.url ,
concat('\', p."implementation" , '\img_', p.ean , '.png') as pathimage from public.product p
