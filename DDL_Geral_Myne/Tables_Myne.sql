-- public."_exec" definition

-- Drop table

-- DROP TABLE public."_exec";

CREATE TABLE public."_exec" (
	"_" text NULL
);


-- public.address definition

-- Drop table

-- DROP TABLE public.address;

CREATE TABLE public.address (
	id varchar(36) NOT NULL,
	bairro varchar(255) NULL,
	cep varchar(255) NULL,
	cidade varchar(255) NULL,
	complemento varchar(255) NULL,
	descricao varchar(255) NULL,
	googleplaceid varchar(255) NULL,
	lat numeric(19, 2) NULL,
	lng numeric(19, 2) NULL,
	logradouro varchar(255) NULL,
	numero varchar(255) NULL,
	uf varchar(255) NULL,
	CONSTRAINT address_pkey PRIMARY KEY (id)
);


-- public.card definition

-- Drop table

-- DROP TABLE public.card;

CREATE TABLE public.card (
	id varchar(36) NOT NULL,
	expiresdate varchar(7) NULL,
	issuer varchar(255) NULL,
	"number" varchar(255) NULL,
	CONSTRAINT card_pkey PRIMARY KEY (id)
);


-- public.cardview definition

-- Drop table

-- DROP TABLE public.cardview;

CREATE TABLE public.cardview (
	id varchar(36) NOT NULL,
	CONSTRAINT cardview_pkey PRIMARY KEY (id)
);


-- public.cmda_exec definition

-- Drop table

-- DROP TABLE public.cmda_exec;

CREATE TABLE public.cmda_exec (
	cmda_output text NULL
);


-- public.config definition

-- Drop table

-- DROP TABLE public.config;

CREATE TABLE public.config (
	id varchar(36) NOT NULL,
	ativo bool NOT NULL,
	chave varchar(255) NULL,
	"data" timestamp NULL,
	mobile bool NOT NULL,
	valor varchar(255) NULL,
	CONSTRAINT config_pkey PRIMARY KEY (id)
);


-- public.counterpart definition

-- Drop table

-- DROP TABLE public.counterpart;

CREATE TABLE public.counterpart (
	id varchar(36) NOT NULL,
	description varchar(10240) NULL,
	"name" varchar(10240) NULL,
	CONSTRAINT counterpart_pkey PRIMARY KEY (id)
);


-- public.financialinfo definition

-- Drop table

-- DROP TABLE public.financialinfo;

CREATE TABLE public.financialinfo (
	id varchar(36) NOT NULL,
	agencia varchar(255) NULL,
	banco varchar(255) NULL,
	contacorrente varchar(255) NULL,
	valor float8 NOT NULL,
	CONSTRAINT financialinfo_pkey PRIMARY KEY (id)
);


-- public."groups" definition

-- Drop table

-- DROP TABLE public."groups";

CREATE TABLE public."groups" (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	createdate timestamp NOT NULL DEFAULT now(),
	description varchar(255) NULL,
	"name" varchar(255) NULL,
	slug varchar(255) NULL,
	CONSTRAINT groups_pkey PRIMARY KEY (id),
	CONSTRAINT uk_iv95crpat83rqqgixej9uhm9m UNIQUE (slug)
);


-- public.identificationdocument definition

-- Drop table

-- DROP TABLE public.identificationdocument;

CREATE TABLE public.identificationdocument (
	id varchar(36) NOT NULL,
	active bool NULL,
	expirationdate timestamp NULL,
	idtype varchar(255) NULL,
	"number" varchar(255) NULL,
	CONSTRAINT identificationdocument_pkey PRIMARY KEY (id)
);


-- public.insight definition

-- Drop table

-- DROP TABLE public.insight;

CREATE TABLE public.insight (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	active bool NOT NULL DEFAULT true,
	createdate timestamptz NOT NULL DEFAULT now(),
	insighttype varchar(255) NULL,
	url varchar(255) NULL,
	releasedate timestamptz NOT NULL DEFAULT now(),
	CONSTRAINT insight_pkey PRIMARY KEY (id)
);


-- public.launch definition

-- Drop table

-- DROP TABLE public.launch;

CREATE TABLE public.launch (
	id varchar(36) NOT NULL,
	createdate timestamp NULL,
	description varchar(255) NULL,
	launchtype varchar(255) NULL,
	"name" varchar(255) NULL,
	releasedate timestamp NULL,
	CONSTRAINT launch_pkey PRIMARY KEY (id)
);


-- public.launchworkflow definition

-- Drop table

-- DROP TABLE public.launchworkflow;

CREATE TABLE public.launchworkflow (
	id varchar(36) NOT NULL,
	enddate timestamp NULL,
	phase int4 NULL,
	startdate timestamp NULL,
	CONSTRAINT launchworkflow_pkey PRIMARY KEY (id)
);


-- public."like" definition

-- Drop table

-- DROP TABLE public."like";

CREATE TABLE public."like" (
	id varchar(36) NOT NULL,
	createdate timestamp NOT NULL DEFAULT now(),
	"type" varchar(255) NULL,
	CONSTRAINT like_pkey PRIMARY KEY (id)
);


-- public."module" definition

-- Drop table

-- DROP TABLE public."module";

CREATE TABLE public."module" (
	id varchar(36) NOT NULL,
	active bool NOT NULL DEFAULT true,
	createdate timestamp NULL DEFAULT now(),
	description varchar(255) NULL,
	details varchar(255) NULL,
	"name" varchar(255) NOT NULL,
	CONSTRAINT module_pkey PRIMARY KEY (id)
);


-- public.mynejsondto definition

-- Drop table

-- DROP TABLE public.mynejsondto;

CREATE TABLE public.mynejsondto (
	id varchar(255) NOT NULL,
	"data" varchar(255) NULL,
	resourcetype varchar(255) NULL,
	"type" varchar(255) NULL,
	CONSTRAINT mynejsondto_pkey PRIMARY KEY (id)
);


-- public.mynerelationjsondto definition

-- Drop table

-- DROP TABLE public.mynerelationjsondto;

CREATE TABLE public.mynerelationjsondto (
	id varchar(255) NOT NULL,
	"data" json NULL,
	"type" varchar(255) NULL,
	CONSTRAINT mynerelationjsondto_pkey PRIMARY KEY (id)
);


-- public.myneuser definition

-- Drop table

-- DROP TABLE public.myneuser;

CREATE TABLE public.myneuser (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	accountname varchar(255) NULL,
	active bool NOT NULL DEFAULT true,
	createdate timestamp NOT NULL DEFAULT now(),
	devicetoken varchar(255) NULL,
	email varchar(255) NOT NULL,
	"name" varchar(255) NOT NULL,
	"password" varchar(255) NULL,
	slug varchar(255) NULL,
	updatecode varchar(255) NULL,
	usertype varchar(32) NOT NULL DEFAULT 'USER'::character varying,
	visibility varchar(32) NOT NULL DEFAULT 'PUBLIC'::character varying,
	"method" varchar NULL DEFAULT 'Myne'::character varying,
	CONSTRAINT myneuser_pkey PRIMARY KEY (id),
	CONSTRAINT uk_78xrwtd24kvmcjhsc006sjivr UNIQUE (slug)
);

-- Table Triggers

create trigger updateslug after
insert
    on
    public.myneuser for each row execute function user_slug();
create trigger insertusertag after
insert
    on
    public.myneuser for each row execute function taguserinsert();


-- public.payment definition

-- Drop table

-- DROP TABLE public.payment;

CREATE TABLE public.payment (
	id varchar(36) NOT NULL,
	paymenttype varchar(255) NULL,
	value float8 NOT NULL,
	CONSTRAINT payment_pkey PRIMARY KEY (id)
);


-- public.phone definition

-- Drop table

-- DROP TABLE public.phone;

CREATE TABLE public.phone (
	id varchar(36) NOT NULL,
	internationalareacode varchar(255) NULL,
	localareacode varchar(255) NULL,
	"number" varchar(255) NULL,
	CONSTRAINT phone_pkey PRIMARY KEY (id)
);


-- public.postsummary definition

-- Drop table

-- DROP TABLE public.postsummary;

CREATE TABLE public.postsummary (
	id varchar(36) NOT NULL,
	CONSTRAINT postsummary_pkey PRIMARY KEY (id)
);


-- public.price definition

-- Drop table

-- DROP TABLE public.price;

CREATE TABLE public.price (
	id varchar(36) NOT NULL,
	active bool NOT NULL,
	discount float8 NOT NULL,
	price float8 NOT NULL,
	createdate varchar NOT NULL DEFAULT now(),
	CONSTRAINT price_pkey PRIMARY KEY (id)
);

-- Table Triggers

create trigger insertproducttag after
insert
    on
    public.price for each row execute function tagproductinsert();


-- public.product definition

-- Drop table

-- DROP TABLE public.product;

CREATE TABLE public.product (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	active bool NOT NULL DEFAULT true,
	createdate timestamptz NOT NULL DEFAULT now(),
	description varchar(10240) NULL,
	"name" varchar(255) NULL,
	producttype varchar(255) NULL,
	details varchar(10240) NULL,
	releasedate timestamptz NOT NULL DEFAULT now(),
	CONSTRAINT product_pkey PRIMARY KEY (id)
);


-- public.productdetail definition

-- Drop table

-- DROP TABLE public.productdetail;

CREATE TABLE public.productdetail (
	id varchar(36) NOT NULL,
	description varchar(255) NULL,
	"key" varchar(255) NULL,
	"_order" int4 NULL,
	CONSTRAINT productdetail_pkey PRIMARY KEY (id)
);


-- public.resourcebyownerdto definition

-- Drop table

-- DROP TABLE public.resourcebyownerdto;

CREATE TABLE public.resourcebyownerdto (
	id varchar(255) NOT NULL,
	"data" varchar(255) NULL,
	"owner" varchar(255) NULL,
	"type" varchar(255) NULL,
	CONSTRAINT resourcebyownerdto_pkey PRIMARY KEY (id)
);


-- public.resourcedto definition

-- Drop table

-- DROP TABLE public.resourcedto;

CREATE TABLE public.resourcedto (
	findresourcedata varchar(255) NOT NULL,
	id varchar(255) NOT NULL,
	"data" varchar(255) NULL,
	CONSTRAINT resourcedto_pkey PRIMARY KEY (findresourcedata)
);


-- public.retorno definition

-- Drop table

-- DROP TABLE public.retorno;

CREATE TABLE public.retorno (
	"case" text NULL
);


-- public.s3file definition

-- Drop table

-- DROP TABLE public.s3file;

CREATE TABLE public.s3file (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	createdate timestamp NOT NULL DEFAULT now(),
	description varchar(255) NULL,
	filename varchar(255) NULL,
	filetype varchar(30) NULL,
	s3url varchar(10240) NULL,
	solicitacaoid varchar(36) NULL,
	order_ int4 NULL,
	CONSTRAINT s3file_pkey PRIMARY KEY (id)
);

-- Table Triggers

create trigger update_profile_image after
insert
    on
    public.s3file for each row execute function profile_image_update();


-- public.site definition

-- Drop table

-- DROP TABLE public.site;

CREATE TABLE public.site (
	id varchar(36) NOT NULL,
	url varchar(255) NULL,
	CONSTRAINT site_pkey PRIMARY KEY (id)
);


-- public.socialnetwork definition

-- Drop table

-- DROP TABLE public.socialnetwork;

CREATE TABLE public.socialnetwork (
	id varchar(36) NOT NULL,
	"name" varchar(255) NULL,
	socialnetworktype varchar(255) NULL,
	url varchar(255) NULL,
	username varchar(255) NULL,
	CONSTRAINT socialnetwork_pkey PRIMARY KEY (id)
);


-- public.t_e definition

-- Drop table

-- DROP TABLE public.t_e;

CREATE TABLE public.t_e (
	docs text NULL
);


-- public.tag definition

-- Drop table

-- DROP TABLE public.tag;

CREATE TABLE public.tag (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	tag varchar(255) NULL,
	tag_tsv tsvector NULL,
	createdate varchar NOT NULL DEFAULT now(),
	CONSTRAINT tag_pkey PRIMARY KEY (id)
);


-- public.tmp_docs definition

-- Drop table

-- DROP TABLE public.tmp_docs;

CREATE TABLE public.tmp_docs (
	"data" text NULL
);


-- public.world1 definition

-- Drop table

-- DROP TABLE public.world1;

CREATE TABLE public.world1 (
	"data" json NULL
);


-- public.groupmembers definition

-- Drop table

-- DROP TABLE public.groupmembers;

CREATE TABLE public.groupmembers (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	createdate timestamp NOT NULL DEFAULT now(),
	removedate timestamp NULL,
	group_id varchar(36) NULL,
	user_id varchar(36) NULL,
	CONSTRAINT groupmembers_pkey PRIMARY KEY (id),
	CONSTRAINT fk1pck7dir09c5yques4b3gakii FOREIGN KEY (user_id) REFERENCES public.myneuser(id),
	CONSTRAINT fk6suac69cc5vn69fwbp96i0xnl FOREIGN KEY (group_id) REFERENCES public."groups"(id)
);


-- public.messagenotification definition

-- Drop table

-- DROP TABLE public.messagenotification;

CREATE TABLE public.messagenotification (
	id varchar(36) NOT NULL,
	body varchar(10000) NOT NULL,
	datetime timestamp NOT NULL DEFAULT now(),
	delivereddatetime timestamp NULL,
	messagetype varchar(255) NOT NULL,
	readdatetime timestamp NULL,
	status varchar(255) NOT NULL,
	title varchar(255) NULL,
	receiverid varchar(36) NOT NULL,
	senderid varchar(36) NOT NULL,
	link varchar(10240) NULL,
	CONSTRAINT messagenotification_pkey PRIMARY KEY (id),
	CONSTRAINT fk5liknp4huj0bry2tbf81v47k1 FOREIGN KEY (senderid) REFERENCES public.myneuser(id),
	CONSTRAINT fkbujicj06wbwl43xkwraffia2j FOREIGN KEY (receiverid) REFERENCES public.myneuser(id)
);


-- public.post definition

-- Drop table

-- DROP TABLE public.post;

CREATE TABLE public.post (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	createdate timestamptz NOT NULL DEFAULT now(),
	description varchar(10240) NULL DEFAULT 'Myne Post DESC'::character varying,
	title varchar(255) NULL DEFAULT 'Myne Post TITLE'::character varying,
	owner_id varchar(36) NULL,
	cancomment bool NOT NULL DEFAULT true,
	releasedate timestamptz NOT NULL DEFAULT now(),
	CONSTRAINT post_pkey PRIMARY KEY (id),
	CONSTRAINT fksmimo05ej6b8u91r6omk3n85g FOREIGN KEY (owner_id) REFERENCES public.myneuser(id)
);

-- Table Triggers

create trigger global_feed_refresh_mat_view after
insert
    or
update
    on
    public.post for each statement execute function refresh_mat_view_global_feed();


-- public.purchase definition

-- Drop table

-- DROP TABLE public.purchase;

CREATE TABLE public.purchase (
	launch_id varchar(36) NULL,
	product_id varchar(36) NULL,
	id varchar NOT NULL DEFAULT uuid_generate_v4(),
	createdate timestamptz NOT NULL DEFAULT now(),
	value float4 NOT NULL DEFAULT 0,
	CONSTRAINT purchase_pk PRIMARY KEY (id),
	CONSTRAINT fk93t8gvf0r076j4uejkb0injck FOREIGN KEY (product_id) REFERENCES public.product(id),
	CONSTRAINT fku0ma9y7k5mhbb5bx7tms4u3m FOREIGN KEY (launch_id) REFERENCES public.launch(id)
);


-- public.relationrequest definition

-- Drop table

-- DROP TABLE public.relationrequest;

CREATE TABLE public.relationrequest (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	"type" varchar(32) NOT NULL DEFAULT 'FOLLOWER'::character varying,
	from_id varchar(36) NOT NULL,
	to_id varchar(36) NOT NULL,
	requestdate timestamp(0) NOT NULL DEFAULT now(),
	status varchar(32) NOT NULL DEFAULT 'REQUESTED'::character varying,
	CONSTRAINT relationrequest_pk PRIMARY KEY (id),
	CONSTRAINT relationrequest_un UNIQUE (id),
	CONSTRAINT fk65ggw39f5ih5r58nx74tam11i FOREIGN KEY (from_id) REFERENCES public.myneuser(id),
	CONSTRAINT fknjawc3oheuvp3vu2o7jbvo5g1 FOREIGN KEY (to_id) REFERENCES public.myneuser(id)
);


-- public.userrelation definition

-- Drop table

-- DROP TABLE public.userrelation;

CREATE TABLE public.userrelation (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	"type" varchar(255) NULL,
	from_id varchar(36) NULL,
	to_id varchar(36) NULL,
	createdate timestamp(0) NOT NULL DEFAULT now(),
	CONSTRAINT userrelation_pkey PRIMARY KEY (id),
	CONSTRAINT fk3me9jysenechbn9i9eoxprkoo FOREIGN KEY (from_id) REFERENCES public.myneuser(id),
	CONSTRAINT fkbt9fywtkux1b7qs1ync0nqy9 FOREIGN KEY (to_id) REFERENCES public.myneuser(id)
);

-- Table Triggers

create trigger ajustuserrelation after
insert
    on
    public.userrelation for each row execute function userrelationajust();


-- public.myneresourceinformation definition

-- Drop table

-- DROP TABLE public.myneresourceinformation;

CREATE TABLE public.myneresourceinformation (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	class_ varchar(255) NULL,
	createdate timestamp NOT NULL DEFAULT now(),
	description varchar(255) NULL,
	"location" varchar(255) NULL,
	mri varchar(255) NULL,
	tags bytea NULL,
	"type" varchar(255) NULL,
	payment varchar(36) NULL,
	group_owner varchar(36) NULL,
	post varchar(36) NULL,
	owner_id varchar(36) NULL,
	"owner" varchar(36) NULL,
	CONSTRAINT myneresourceinformation_pkey PRIMARY KEY (id),
	CONSTRAINT fkfk4ejf19ielo6pf1bi02wchyo FOREIGN KEY (payment) REFERENCES public.payment(id),
	CONSTRAINT fkn8s0kqu9hhcqk51bssqkujqx0 FOREIGN KEY (group_owner) REFERENCES public."groups"(id),
	CONSTRAINT fknk23pifl0ru91hn57oqljajnm FOREIGN KEY (owner_id) REFERENCES public.myneresourceinformation(id),
	CONSTRAINT fkso12pi6ebo8rcjv3e9pi3ybnd FOREIGN KEY (post) REFERENCES public.post(id)
);
CREATE UNIQUE INDEX resource_index ON public.myneresourceinformation USING btree (id, mri);


-- public.ownerresources definition

-- Drop table

-- DROP TABLE public.ownerresources;

CREATE TABLE public.ownerresources (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	"type" varchar(255) NULL,
	"owner" varchar(36) NULL,
	slave varchar(36) NULL,
	CONSTRAINT ownerresources_pkey PRIMARY KEY (id),
	CONSTRAINT fk2pdgglupfwvs49i8e3w5ovfkb FOREIGN KEY (slave) REFERENCES public.myneresourceinformation(id),
	CONSTRAINT fkoxoer1503fnjf9g63kcm9bujx FOREIGN KEY ("owner") REFERENCES public.myneresourceinformation(id)
);
CREATE INDEX owner_resource_index ON public.ownerresources USING btree (owner, slave);


-- public.resourcetag definition

-- Drop table

-- DROP TABLE public.resourcetag;

CREATE TABLE public.resourcetag (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	resource varchar(36) NOT NULL,
	tag varchar(36) NOT NULL,
	CONSTRAINT resourcetag_pkey PRIMARY KEY (id),
	CONSTRAINT fkbecq978ibubt369vfp12n1hqy FOREIGN KEY (tag) REFERENCES public.tag(id),
	CONSTRAINT fkfl5m64glrhopquj9e8eb006gn FOREIGN KEY (resource) REFERENCES public.myneresourceinformation(id)
);


-- public.accountability definition

-- Drop table

-- DROP TABLE public.accountability;

CREATE TABLE public.accountability (
	id varchar(36) NOT NULL,
	negatives int4 NOT NULL,
	positives int4 NOT NULL,
	"views" int4 NOT NULL,
	owner_id varchar(36) NULL,
	CONSTRAINT accountability_pkey PRIMARY KEY (id),
	CONSTRAINT fk7gia2cy80rv51jxoxsibu7hsf FOREIGN KEY (owner_id) REFERENCES public.myneresourceinformation(id)
);

-- Table Triggers

create trigger updateview after
insert
    or
update
    on
    public.accountability for each row execute function update_views();


-- public."comment" definition

-- Drop table

-- DROP TABLE public."comment";

CREATE TABLE public."comment" (
	id varchar(36) NOT NULL,
	createdate timestamp NULL,
	"text" varchar(255) NULL,
	owner_id varchar(36) NULL,
	postowner_id varchar(36) NULL,
	userowner_id varchar(36) NULL,
	CONSTRAINT comment_pkey PRIMARY KEY (id),
	CONSTRAINT fk2su2aewk9jafhkannwdghi463 FOREIGN KEY (userowner_id) REFERENCES public.ownerresources(id),
	CONSTRAINT fk4m11y2dem5m00480fejdlb8t7 FOREIGN KEY (postowner_id) REFERENCES public.ownerresources(id),
	CONSTRAINT fkbqaxmjh45xx9x2f41do2hqi84 FOREIGN KEY (owner_id) REFERENCES public.myneresourceinformation(id)
);