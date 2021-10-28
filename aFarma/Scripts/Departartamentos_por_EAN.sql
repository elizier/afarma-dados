

select pd.produto_id, pd.departamento, pd.departamento_id from 


--Departamentos por EAN

select d.ean, d.departamento 
			from
(
select p.ean, unaccent(upper(translate(Upper(CAST(p.department AS varchar)), '{}"',''))) as xpto , 
(case when d.departamento isnull 
then 'NÃO IDENTIFICADO' else d.departamento end) 
	 from 
(
select  d.ean, d.departamento as xpto, d.translate as departamento from (
(select pr.ean, translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%infantil%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%bebe%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%bebe%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%mae%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infanti%') then 'MUNDO INFANTIL'
when lower(pr.name) like lower('%fralda%') then 'MUNDO INFANTIL'
when lower(pr.name) like lower('%fralda%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infantil%') then 'MUNDO INFANTIL'
when translate(lower(pr.category),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%leite%') then 'MUNDO INFANTIL'
when translate(lower(pr.name),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%lacteo%') then 'MUNDO INFANTIL'
when translate(lower(pr.description),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%pediatrico%') then 'MUNDO INFANTIL'
when translate(lower(pr.description),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') like lower ('%infantil%') then 'MUNDO INFANTIL'
else translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from 
public.product pr)

union all
--------------------------------------------------------


(select pr.ean, translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%mg %') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%1g %') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%mg %') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%1g %') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%mg%') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%1g%') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%mg%') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%1g%') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%mg/%') then 'MEDICAMENTOS'
when lower(pr.name) like lower('%1g/%') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%mg/%') then 'MEDICAMENTOS'
when lower(pr.description) like lower('%1g/%') then 'MEDICAMENTOS'
when lower(translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')) like lower('%medicamento%') then 'MEDICAMENTOS'
when pr.ean in ('7896382703072',
'7896006203094',
'7896523206448',
'7897572000025') then 'MEDICAMENTOS'
else translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from 
public.product pr)

union all
--------------------------------------------------------------


(select pr.ean, translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%sabonete%') then 'DERMOCOSMETICOS'
when lower(pr.name) like lower('%creme%') then 'DERMOCOSMETICOS'
when lower(pr.name) like lower('%shampoo%') then 'DERMOCOSMETICOS'
when lower(pr.name) like lower('%desodorante%') then 'DERMOCOSMETICOS'
when lower(pr.brand) like lower('%nivea%') then 'DERMOCOSMETICOS'
when lower(pr.brand) like lower('%cicraticure%') then 'DERMOCOSMETICOS'
when lower(pr.category) like lower('%creme%') then 'DERMOCOSMETICOS'
when lower(pr.category) like lower('%cabelo%') then 'DERMOCOSMETICOS'
when lower(pr.description) like lower('%creme%') then 'DERMOCOSMETICOS'
when lower(pr.category) like lower('%dental%') then translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
when lower(pr.category) like lower('%idratante%') then 'DERMOCOSMETICOS'
else translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from 
public.product pr
)

union all

----------------------------------------------------------------


(select pr.ean, translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%vitamin%') then 'SAUDE E BEM ESTAR'
when lower(pr.name) like lower('%creme%') then 'SAUDE E BEM ESTAR'
when lower(pr.name) like lower('%eite%') then 'SAUDE E BEM ESTAR'
when lower(pr.name) like lower('%desodorante%') then 'SAUDE E BEM ESTAR'
when lower(pr.name) like lower('%gel%') then 'SAUDE E BEM ESTAR'
when lower(pr.brand) like lower('%cicraticure%') then 'SAUDE E BEM ESTAR'
when lower(pr.category) like lower('%suplemento%') then 'SAUDE E BEM ESTAR'
when lower(pr.category) like lower('%pele%') then 'SAUDE E BEM ESTAR'
when lower(pr.description) like lower('%creme%') then 'SAUDE E BEM ESTAR'
when lower(pr.description) like lower('%plemento%') then 'SAUDE E BEM ESTAR'
when lower(pr.description) like lower('%ental%') then 'SAUDE E BEM ESTAR'
when lower(pr.category) like lower('%dental%') then 'SAUDE E BEM ESTAR'
when lower(pr.category) like lower('%idratante%') then 'SAUDE E BEM ESTAR'
else translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from 
public.product pr
)

union all


-------------------------------------------------------------------


(select pr.ean, translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(
case when lower(pr.name) like lower('%curativo%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.name) like lower('%creme%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.name) like lower('%bucal%') then 'SHIGIENE E CUIDADOS PESSOAIS'
when lower(pr.name) like lower('%desodorante%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.category) like lower('%beleza%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%higiene%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.category) like lower('%cabelo%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%sabonete%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%ntimo%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%absorvente%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.description) like lower('%curativo%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.category) like lower('%dental%') then 'HIGIENE E CUIDADOS PESSOAIS'
when lower(pr.category) like lower('%idratante%') then 'HIGIENE E CUIDADOS PESSOAIS'
else translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from 
public.product pr
)


union all
------------------------------------------------------------------------------------------------

(select pr.ean, translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY') as "departamento",
(case
when lower(pr.category) like lower('%beleza%') then 'BELEZA'
when lower(pr.category) like lower('%cabelo%') then 'BELEZA'
when lower(pr.description) like lower('%sabonete%') then 'BELEZA'
when lower(pr.name) like lower('%shampoo%') then 'BELEZA'
when lower(pr.category) like lower('%idratante%') then 'BELEZA'
else translate(translate(Upper(CAST(pr.department AS varchar)), '{}"',''),'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY')
end
)
from 
public.product pr
)



) d
where d.translate in (select d.departamento from afarma.departamento d)
group by d.ean, d.departamento, d.translate) d
right join 
public.product p on p.ean = d.ean) d
group by d.ean, d.departamento 





where p.ean=d.ean and d.translate=dp.departamento 
) pd 
where pd.produto_id in 
((select distinct(pr.id) from afarma.produto pr)
except
(select distinct(pr.produto_id) from afarma.produto_departamentos pr))
