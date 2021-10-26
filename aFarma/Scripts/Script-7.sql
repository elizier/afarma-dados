select po.* 
from public.produtos_all_otimizado_RJ po, afarma.produto_departamentos pd 
where pd.produto_id=po.id --and pd.departamento_id = :id_departamento 
and (po.produto_tsv @@ to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | '))) 
or upper(unaccent(po.nome)) like concat('%',upper(unaccent(:busca)),'%')) 
group by po.id, po.nome, po.ean, po.photo_id, po.descricao, po.precomedio1,  
po.lojapromocao, po.categoria_id, po.marca_id, po.departamento_id, po.principioativo_id, po.grupo_id, 
po.indicacao, po.contraindicacao, po.produto_tsv, po.precomedio 
order by (similarity(upper(unaccent(po.nome)), upper(unaccent(:busca)))) desc




SELECT * 
        FROM 
                dblink('dbname=postgres port=5432 host = 192.168.88.16
                user=postgres password=!QAZxsw2',
                'SELECT * from public.product p')
            AS s (id uuid,
	brand varchar(10240),
	category varchar(10240),
	contraindication varchar(10240),
	created_date timestamp,
	department _text,
	description varchar(10240),
	ean varchar(255),
	"implementation" varchar(255),
	indication varchar(10240),
	"name" varchar(2048),
	photo bytea,
	price float4,
	updated_date timestamp,
	url varchar(10240),
	related_products _text,
	active_ingredient varchar(10240),
	retencao_receita varchar(255));




CREATE EXTENSION dblink;