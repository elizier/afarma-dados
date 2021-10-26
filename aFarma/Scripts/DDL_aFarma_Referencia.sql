-- DROP SCHEMA public;

CREATE SCHEMA afarmaref AUTHORIZATION postgres;

drop table afarmaref.produto ;
drop table afarmaref.dominio ;
drop table afarmaref.tipodominio;



create table afarmaref.tipodominio (
id varchar(36) NOT NULL,
	nome varchar(255) not null,
	CONSTRAINT tipodominio_ref_pk PRIMARY KEY (id),
	constraint name_ref_uk unique (nome)
);

insert into afarma.tipodominio values
(uuid_generate_v4(),'CATEGORIA'),
(uuid_generate_v4(),'GRUPO'),
(uuid_generate_v4(),'MARCA'),
(uuid_generate_v4(),'PRINCIPIO ATIVO'),
(uuid_generate_v4(),'DEPARTAMENTO');

create table afarmaref.dominio (
id varchar(36) NOT NULL,
	nome varchar(255) not null,
	tipo varchar(255) not null,
	CONSTRAINT dominio_ref_pk PRIMARY KEY (id),
	constraint dominiocomposite_ref_uk unique (nome,tipo)
);

insert into afarma.dominio(id,nome,tipo_id) values
(uuid_generate_v4(),'NÃO IDENTIFICADO',(select t.id from afarma.tipodominio t where t.nome ='CATEGORIA')),
(uuid_generate_v4(),'NÃO IDENTIFICADO',(select t.id from afarma.tipodominio t where t.nome ='GRUPO')),
(uuid_generate_v4(),'NÃO IDENTIFICADO',(select t.id from afarma.tipodominio t where t.nome ='MARCA')),
(uuid_generate_v4(),'NÃO IDENTIFICADO',(select t.id from afarma.tipodominio t where t.nome ='PRINCIPIO ATIVO')),
(uuid_generate_v4(),'NÃO IDENTIFICADO',(select t.id from afarma.tipodominio t where t.nome ='DEPARTAMENTO'));

CREATE TABLE afarmaref.produto (
	id varchar(36) NOT NULL,
	nome varchar(255) NULL,
	ean varchar(255) NULL,
	descricao varchar(10240) NULL,
	categoria_id varchar(36) NULL,
	marca_id varchar(36) NULL,
	photo_id varchar(36) NULL,
	departamento_id varchar(36) NULL,
	principioativo_id varchar(36) NULL,
	grupo_id varchar(36) null,
	CONSTRAINT produto_ref_pk PRIMARY KEY (id),
	constraint ean_ref_uk unique (ean)
	
);

ALTER TABLE dominio 
ADD FOREIGN KEY (tipo_id_fk) REFERENCES tipodominio(id);

ALTER TABLE afarmaref.dominio ADD CONSTRAINT dominio_fk FOREIGN KEY (tipo_id) REFERENCES afarmaref.tipodominio(id);


insert into dominio select uuid_generate_v4(), i.translate from
(select g.name, count(g.name) from public.genericos_ref g group by g.name) ;

update dominio set tipo=t.id from tipodominio t where tipo=t.nome ;

delete from 





















