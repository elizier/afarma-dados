--Lista de Produtos por departamernto

--Por Tipo de filtro (fazer um like) - nome,descrição,princípio,indicação,contra,marca,ean

--detalhes contendo preço médio

-- lista alfabética (lista de produtos no depart com aquela letra)
select a.id, b.nome from (select * from produto p) a
left join (select
co.concorrente,
p.nome,
p.ean,
m.marca,
ca.categoria,
p.descricao,
d.departamento,
pa.descricao as "principioativo",
p.contraindicacao,
p.indicacao
from produto p,
departamento_de_para dp,
departamento d,
marca m, categoria ca,
produtoconcorrente pc,
concorrente co,
(select p.id, pr.descricao from produto p
left join principioativo pr on p.principioativo_id=pr.id) pa
where m.id=p.marca_id
and p.departamento_id=d.id
and p.categoria_id=ca.id
and pa.id=p.id
and pc.produto_id=p.id
and pc.concorrente_id=co.id 
group by p.id, co.concorrente,
p.nome, p.ean, m.marca, ca.categoria, p.descricao, d.departamento, pa.descricao, p.contraindicacao, p.indicacao
order by p.ean asc) b on a.id=b.id;




