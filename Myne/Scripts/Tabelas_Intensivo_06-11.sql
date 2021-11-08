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


CREATE  INDEX owner_resource_index ON public.ownerresources using hash("owner");
create index resource_index on public.myneresourceinformation using hash(mri);
CREATE unique INDEX resource_index ON public.ownerresources (id, mri);


select findmyneglobalfeed(10,0)

EXPLAIN ANALYZE
(SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'POST' AS type
	,jsonb_build_object('user', f.user_data || jsonb_build_object('profile_image', p.data)) || f.post_data AS data
FROM (
	SELECT f.user_id
		,jsonb_build_object('user', f.user_data) AS user_data
		,f.post_data || jsonb_build_object('nested', array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) AS post_data
	FROM (
		SELECT a.accountability_id
			,f.OWNER AS user_id
			,to_jsonb(u.data) AS user_data
			,jsonb_build_object('type', f.type) || to_jsonb(f.data) AS post_data
		FROM (
			SELECT a.id AS accountability_id
			FROM accountability a
			ORDER BY "views" DESC
				,id DESC limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
			) a
		LEFT JOIN lateral findownerdata(a.accountability_id) f ON true
		LEFT JOIN lateral findresourcedata(f.OWNER) u ON true
		) f
	LEFT JOIN lateral findresourcebyowner(cast(f.post_data ->> 'id' AS VARCHAR)) p ON true
	WHERE f.user_id notnull
		AND f.user_id != 'DON''T HAVE'
	GROUP BY f.user_id
		,f.post_data
		,f.user_data
	) f
LEFT JOIN lateral findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE') p ON true);


DROP INDEX public.owner_resource_index;



	