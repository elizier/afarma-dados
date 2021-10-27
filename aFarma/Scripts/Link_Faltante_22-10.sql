-- public.product_ref definition

-- Drop table

-- DROP TABLE public.product_ref;

CREATE TABLE public.product_comparacao (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	"name" varchar(10240) NULL,
	ean varchar(255) NULL,
	brand varchar(10240) NULL,
	url varchar(10240) NULL,
	"implementation" varchar(10240) NULL
);

insert into product_comparacao(name, ean, marca, url, implementation) values ('Bosentana 62,5mg 60 comprimidos','','JANSSEN','https://www.drogariavenancio.com.br/bosentana-62-5mg-60tab-br-act/p','VENANCIO');
insert into product_comparacao(name, ean, marca, url, implementation) values ('Máscara Facial Em tecido Garnier Uniform & Matte Vitamina C 32g','6923700956849','GARNIER','https://www.drogariavenancio.com.br/masc-fac-garnier-skinactive-uniform---matte-vit-c-32g/p','VENANCIO');


delete from product_comparacao 

select pc.ean, pc."implementation", pc.url from
(
select * from 
(select pc.ean, pc.implementation from product_comparacao pc
except 
select p.ean, p.implementation from product p ) p
where p.ean in (select er.ean from ean_ref er)) p, product_comparacao pc
where concat(pc.ean, pc."implementation") = concat(p.ean, p."implementation") 