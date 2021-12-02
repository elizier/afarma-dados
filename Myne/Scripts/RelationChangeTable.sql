-- public.site definition

-- Drop table

-- DROP TABLE public.site;

CREATE TABLE public.live (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	title varchar(255) NULL,
	description varchar(10240) null,
	createdate timestamp WITH time ZONE NOT NULL DEFAULT now(),
	enddate timestamp WITH time ZONE  NULL,
	CONSTRAINT live_pkey PRIMARY KEY (id)
);

CREATE TABLE public.registeraccountability (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	user_id varchar(36) NOT NULL,
	type varchar(255) NOT null,
	createdate timestamp WITH time ZONE NOT NULL DEFAULT now(),
	CONSTRAINT registeraccountability_pkey PRIMARY KEY (id)
);

CREATE TABLE public.savedcontent (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	user_id varchar(36) NOT NULL,
	resource_id varchar(36) NOT null,
	resourcetype varchar(255) NOT NULL,
	savedate timestamp WITH time ZONE NOT NULL DEFAULT now(),
	active boolean NOT NULL DEFAULT TRUE,
	CONSTRAINT savedcontent_pkey PRIMARY KEY (id)
);

