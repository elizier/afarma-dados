

CREATE TABLE public.product (
	id varchar(36) NOT null default uuid_generate_v4(),
	createdate timestamp NOT NULL DEFAULT now(),
	name varchar(255) not NULL,
	description varchar(255) NULL,
	type varchar(255) not NULL,
	active boolean not null default true,
	details varchar(10240) NULL,
	CONSTRAINT myne_product_pkey PRIMARY KEY (id)
);


CREATE TABLE public.price (
	id varchar(36) NOT null default uuid_generate_v4(),
	price float(8) NOT NULL,
	discount float(8) NULL,
	active boolean not null default true,
	CONSTRAINT price_pkey PRIMARY KEY (id)
);



CREATE TABLE public.launch (
	id varchar(36) NOT null default uuid_generate_v4(),
	createdate timestamp NOT NULL DEFAULT now(),
	releasedate timestamp NULL DEFAULT now(),
	name varchar(255) not NULL,
	description varchar(255) NULL,
	launchtype varchar(255) not NULL,
	CONSTRAINT release_pkey PRIMARY KEY (id)
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



CREATE TABLE public.launch_workflow (
	id varchar(36) NOT null default uuid_generate_v4(),
	phase varchar(255) not null,
	startdate timestamptz NOT NULL,
	enddate timestamptz not null
	);


CREATE TABLE public.email (
	id varchar(36) NOT null default uuid_generate_v4(),
	createdate timestamp NOT NULL DEFAULT now(),
	title varchar(255) not NULL,
	description varchar(255) NULL,
	CONSTRAINT email_pkey PRIMARY KEY (id)
);

CREATE TABLE public.email_file (
	s3_id varchar(36) NOT null,
	email_id varchar(36) NOT null
);


CREATE TABLE public.email_transmission (
	email_id varchar(36) NOT null,
	senddate timestamp NOT NULL,
	group_id varchar(36) not NULL
);


CREATE TABLE public.insights (
	id varchar(36) not null default uuid_generate_v4(),
	createdate timestamp NOT NULL DEFAULT now(),
	active boolean not null default true,
	CONSTRAINT insights_pkey PRIMARY KEY (id)
);