CREATE TABLE public.price (
	id varchar(36) NOT null default uuid_generate_v4(),
	price float(8) NOT NULL,
	discount float(8) NULL,
	active boolean not null default true,
	CONSTRAINT price_pkey PRIMARY KEY (id)
);

CREATE TABLE public.purchase (
	launch_id varchar(36) NULL,
	product_id varchar(36) NULL,
	user_id varchar(36) NOT NULL,
	id varchar NOT NULL DEFAULT uuid_generate_v4(),
	createdate timestamptz NOT NULL DEFAULT now(),
	CONSTRAINT purchase_pk PRIMARY KEY (id),
	CONSTRAINT purchase_fk FOREIGN KEY (user_id) REFERENCES public.myneuser(id)
);


CREATE TABLE public.counterpart (
	id varchar(36) NOT null,
	TYPE varchar(10240) null,
	description varchar(10240) null
	);


SELECT public.findmyproducts(:user_id, :type_)

select 

update myneuser set slug=o.slugify from
(
select o.id as id1, slugify(concat(o.name, ' ',
(select (max((cast(substring(u.slug FROM '[0-9]+') as numeric))+1)) from public.myneuser u
where u.slug notnull))) from
(
select o.id, slugify(o.name) as name,  ROW_NUMBER() OVER(ORDER BY o.id) AS RowNumber
from public.myneuser o  where o.slug isnull
) o) o
where o.id1=id;


update myneuser set accountname = translate(slug,'-','') from
(select id as id1 from myneuser where accountname isnull) a
where a.id1=id;







	