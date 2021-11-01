INSERT INTO afarma.registrocotacao_afarma (id, "data", email, nome, status, uf)
VALUES(uuid_generate_v4(), now(), 'matheus@afarma', 'Matheus', 'ABERTO', 'RJ');

'64968fbc-943f-460c-8036-98f7fd48e9f8'

update afarma.produto_afarma set ean_similar = replace(replace(upper(unaccent(ean_similar)),'GENERICO: ', ''), 'SIMILAR: ', '')


-- DROP TYPE afarma.ctitem;

CREATE TYPE afarma.ctitem_json AS (
	id varchar,
	"data" json
);



select cast(uuid_generate_v4() as varchar) as id, row_to_json(c.*) as data from 
(select ia.id_produto, ra.id as cotacao_id, pa.nome, ia.quantidade, pa.valor , (ia.quantidade * pa.valor) as total 
from afarma.itenscot_afarma ia , afarma.produto_afarma pa, afarma.registrocotacao_afarma ra 
where ia.id_produto = pa.id and ra.id = ia.cotacao and ra.id = :cotid and pa.valor notnull) c


select cast(uuid_generate_v4() as varchar) as id, row_to_json(c.*) as data from 
(select  ra.id as cotacao_id, sum(ia.quantidade * pa.valor) as total 
from afarma.itenscot_afarma ia , afarma.produto_afarma pa, afarma.registrocotacao_afarma ra 
where ia.id_produto = pa.id and ra.id = ia.cotacao and ra.id = :cotid and pa.valor notnull
group by ra.id) c

select * from  public.cotacao_afarma('64968fbc-943f-460c-8036-98f7fd48e9f8')

CREATE OR REPLACE FUNCTION public.cotacao_afarma(cotid character varying)
 RETURNS SETOF afarma.ctitem_json
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t afarma.ctitem_json%ROWTYPE;
BEGIN

return query

select cast(uuid_generate_v4() as varchar) as id, row_to_json(c.*) as data from 
(select  ra.id as cotacao_id, sum(ia.quantidade * pa.valor) as total 
from afarma.itenscot_afarma ia , afarma.produto_afarma pa, afarma.registrocotacao_afarma ra 
where ia.id_produto = pa.id and ra.id = ia.cotacao and ra.id = cotid and pa.valor notnull
group by ra.id) c ;


END;

$function$
;
