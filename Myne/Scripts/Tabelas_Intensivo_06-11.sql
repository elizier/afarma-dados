CREATE TABLE public.price (
	id varchar(36) NOT null default uuid_generate_v4(),
	price float(8) NOT NULL,
	discount float(8) NULL,
	active boolean not null default true,
	CONSTRAINT price_pkey PRIMARY KEY (id)
);

CREATE TABLE public.purchase (
	id varchar NOT NULL DEFAULT uuid_generate_v4(),
	launch_id varchar(36) NULL,
	product_id varchar(36) NULL,
	createdate timestamptz NOT NULL DEFAULT now(),
	value float NOT NULL
	CONSTRAINT purchase_pk PRIMARY KEY (id),
	CONSTRAINT purchase_fk FOREIGN KEY (user_id) REFERENCES public.myneuser(id)
);



CREATE TABLE public.counterpart (
	id varchar(36) NOT null,
	TYPE varchar(10240) null,
	description varchar(10240) null
	);

CREATE TABLE public.purchase_counterpart(
	purchase_id varchar(36) NOT null,
	counterpart_id varchar(36) NOT NULL
	);



CREATE TABLE public.counterpart (
	id varchar(36) NOT null,
	TYPE varchar(10240) null,
	description varchar(10240) null
	);

USER_PURCHASE



CREATE INDEX resource_index ON public.myneresourceinformation (id, mri);


select findmyneglobalfeed(10,0)



	