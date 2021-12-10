-- DROP SCHEMA "global";

CREATE SCHEMA "global" AUTHORIZATION postgres;
-- "global".insights definition

-- Drop table

-- DROP TABLE "global".insights;

CREATE TABLE "global".insights (
	insight_id varchar(36) NOT NULL,
	userid varchar(36) NOT NULL,
	insight_data jsonb NOT NULL,
	releasedate timestamptz NOT NULL DEFAULT now(),
	user_data jsonb NULL,
	insert_date timestamp NOT NULL DEFAULT now()
);


-- "global".research definition

-- Drop table

-- DROP TABLE "global".research;

CREATE TABLE "global".research (
	id varchar(36) NOT NULL,
	createdate timestamp NOT NULL DEFAULT now(),
	"type" varchar(255) NULL,
	tag varchar(10240) NULL,
	ts_vector tsvector NULL,
	research_data json NULL,
	releasedate timestamptz NOT NULL DEFAULT now(),
	"owner" varchar(36) NULL
);

-- DROP SCHEMA myne_streams;

CREATE SCHEMA myne_streams AUTHORIZATION postgres;
-- myne_streams.video definition

-- Drop table

-- DROP TABLE myne_streams.video;

CREATE TABLE myne_streams.video (
	dtype varchar(31) NOT NULL,
	id varchar(36) NOT NULL,
	createdate timestamptz NOT NULL,
	enddate timestamptz NOT NULL,
	externalid varchar(1000) NOT NULL,
	participationtype varchar(255) NULL,
	rememberfrequency int4 NOT NULL,
	startdate timestamptz NOT NULL,
	description varchar(10240) NULL,
	title varchar(255) NULL,
	owner_id varchar(36) NULL,
	CONSTRAINT uk_liuh3i45wlc1vos41wse35kon UNIQUE (externalid),
	CONSTRAINT video_pkey PRIMARY KEY (id)
);


-- myne_streams.videoparticipant definition

-- Drop table

-- DROP TABLE myne_streams.videoparticipant;

CREATE TABLE myne_streams.videoparticipant (
	id varchar(36) NOT NULL,
	user_id varchar(36) NULL,
	video_id varchar(36) NULL,
	participanttype varchar(255) NULL,
	"token" varchar(255) NULL,
	CONSTRAINT videoparticipant_pkey PRIMARY KEY (id)
);


-- myne_streams.video foreign keys

ALTER TABLE myne_streams.video ADD CONSTRAINT fki2no82jq31d6b1anb5p3r7y8d FOREIGN KEY (owner_id) REFERENCES public.myneuser(id);


-- myne_streams.videoparticipant foreign keys

ALTER TABLE myne_streams.videoparticipant ADD CONSTRAINT fk1tcrqsnyf7bsvh4vv7fw5bni1 FOREIGN KEY (video_id) REFERENCES myne_streams.video(id);
ALTER TABLE myne_streams.videoparticipant ADD CONSTRAINT fkikfnqsi7w5sj7jd2q9cq5d30w FOREIGN KEY (user_id) REFERENCES public.myneuser(id);

-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP TYPE gtrgm;

CREATE TYPE gtrgm (
	INPUT = gtrgm_in,
	OUTPUT = gtrgm_out,
	ALIGNMENT = 4,
	STORAGE = plain,
	CATEGORY = U,
	DELIMITER = ',');

-- public."_exec" definition

-- Drop table

-- DROP TABLE public."_exec";


-- Agregate tsvector

CREATE AGGREGATE tsvector_agg(tsvector) (
   STYPE = pg_catalog.tsvector,
   SFUNC = pg_catalog.tsvector_concat,
   INITCOND = ''
);


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


-- public.apitoken definition

-- Drop table

-- DROP TABLE public.apitoken;

CREATE TABLE public.apitoken (
	id varchar(36) NOT NULL,
	CONSTRAINT apitoken_pkey PRIMARY KEY (id)
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

-- Table Triggers

create trigger insertinsight after
insert
    or
delete
    on
    public.insight for each row execute function insightinsert();


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
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	enddate timestamptz NULL,
	phase varchar(255) NOT NULL,
	startdate timestamptz NULL,
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
	createdate timestamp NOT NULL DEFAULT now(),
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
	biography varchar(10240) NULL,
	CONSTRAINT myneuser_pkey PRIMARY KEY (id),
	CONSTRAINT myneuser_un UNIQUE (email),
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
	createdate timestamptz NOT NULL DEFAULT now(),
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
	relationchange bool NOT NULL DEFAULT false,
	CONSTRAINT product_pkey PRIMARY KEY (id)
);

-- Table Triggers

create trigger insertproducttag after
insert
    on
    public.product for each row execute function tagproductinsert();


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
	createdate timestamp NULL DEFAULT now(),
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

create trigger insertposttag after
insert
    on
    public.post for each row execute function tagpostinsert();
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

-- Table Triggers

create trigger changerelationpurchase after
insert
    on
    public.purchase for each row execute function relationchangepurchase();


-- public.registeraccountability definition

-- Drop table

-- DROP TABLE public.registeraccountability;

CREATE TABLE public.registeraccountability (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	createdate timestamptz NOT NULL DEFAULT now(),
	user_id varchar(36) NULL,
	CONSTRAINT registeraccountability_pkey PRIMARY KEY (id),
	CONSTRAINT fk8vkdd89w0twtg4ix46xmx3l1t FOREIGN KEY (user_id) REFERENCES public.myneuser(id)
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


-- public.savedcontent definition

-- Drop table

-- DROP TABLE public.savedcontent;

CREATE TABLE public.savedcontent (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	active bool NOT NULL DEFAULT true,
	resourceid varchar(255) NULL,
	resourcetype varchar(255) NULL,
	savedate timestamptz NOT NULL DEFAULT now(),
	user_id varchar(36) NULL,
	CONSTRAINT savedcontent_pkey PRIMARY KEY (id),
	CONSTRAINT fk9orqrjj4t76h9ch7g9q2o79nb FOREIGN KEY (user_id) REFERENCES public.myneuser(id)
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
	createdate timestamptz NOT NULL DEFAULT now(),
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


-- public.globalfeed source

CREATE MATERIALIZED VIEW public.globalfeed
TABLESPACE pg_default
AS SELECT uuid_generate_v4()::character varying AS id,
    f.viewbyday,
    (f.post_data ->> 'id'::text)::character varying AS post_id,
    'POST'::text AS type,
    jsonb_build_object('user', f.user_data || jsonb_build_object('profile_image', p.data)) || f.post_data AS data
   FROM ( SELECT f_1.viewbyday,
            f_1.user_id,
            jsonb_build_object('user', f_1.user_data) AS user_data,
            f_1.post_data || jsonb_build_object('nested', array_agg(to_jsonb(p_1.data) || jsonb_build_object('type', p_1.type))) AS post_data
           FROM ( SELECT a.accountability_id,
                    a.views::double precision /
                        CASE
                            WHEN date_part('day'::text, now() - ((f_2.data ->> 'createDate'::text)::timestamp with time zone)) = 0::double precision THEN 1::double precision
                            ELSE date_part('day'::text, now() - ((f_2.data ->> 'createDate'::text)::timestamp with time zone))
                        END AS viewbyday,
                    f_2.owner AS user_id,
                    to_jsonb(u.data) AS user_data,
                    jsonb_build_object('type', f_2.type) || to_jsonb(f_2.data) AS post_data
                   FROM ( SELECT a_1.id AS accountability_id,
                            a_1.views
                           FROM accountability a_1
                          ORDER BY a_1.views DESC, a_1.id DESC) a
                     LEFT JOIN LATERAL findownerdata(a.accountability_id) f_2(owner, type, id, data) ON true
                     LEFT JOIN LATERAL findresourcedata(f_2.owner) u(owner, type, id, data) ON true
                  WHERE f_2.type::text = 'POST'::text) f_1
             LEFT JOIN LATERAL findresourcebyowner((f_1.post_data ->> 'id'::text)::character varying) p_1(owner, type, id, data) ON true
          WHERE f_1.user_id IS NOT NULL AND f_1.user_id::text <> 'DON''T HAVE'::text
          GROUP BY f_1.user_id, f_1.viewbyday, f_1.post_data, f_1.user_data) f
     LEFT JOIN LATERAL findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE'::character varying) p(owner, type, id, data) ON true
  ORDER BY f.viewbyday DESC
WITH DATA;



CREATE OR REPLACE FUNCTION public.allsavedfromuser(userid character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select cast(uuid_generate_v4() as varchar) as id, 
r."type" as type, r.research_data as data from
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = user_id and s.resourcetype != 'INSIGHT'
order by s.savedate desc, s.resourceid asc
limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)) s
left join global.research r on r.id = s.resourceid

union all

select cast(uuid_generate_v4() as varchar) as id, 
cast('INSIGHT' as varchar) as type, cast(i.user_data || jsonb_build_object('insight', i.insight_data) as json) as data from
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = user_id and s.resourcetype = 'INSIGHT'
order by s.savedate desc, s.resourceid asc
limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)) s
left join global.insights i on i.insight_id = s.resourceid 
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.checkpurchase(user_id character varying, product character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   declare
      resource_t public.mynejsontype%ROWTYPE;

begin

 	for resource_t in
 

	select cast(uuid_generate_v4() as varchar) as id,
	'PURCHASE' as type, json_build_object('purchased', (case when p.product_id isnull then 'false' else 'true' end)) as purchase from
(select o.slave, replace(m.mri, 'mri::', '') as user_id  from myneresourceinformation m, ownerresources o 
where replace(m.mri, 'mri::', '') = user_id and o."owner" = m.id and o."type" = 'USER_PURCHASE') up
left join
myneresourceinformation m on m.id = up.slave
left join purchase p on replace(m.mri, 'mri::', '') = p.id
where p.product_id = product

loop
		return next resource_t;
end loop;

return;
end;

$function$
;

CREATE OR REPLACE FUNCTION public.finddata(resource character varying)
 RETURNS SETOF jsonresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresult%ROWTYPE;
BEGIN

 	FOR resource_t in

SELECT uuid_generate_v4(), row_to_json(a.*)
FROM (
	SELECT (case when a.owner_id = 'DON''T HAVE' then null else a.owner_id end) as owner_id
		,m.type
		,array_agg(a.data) AS data
	FROM (
		SELECT a.owner_id
			,(a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) AS data
		FROM (
			SELECT a.owner_id
				,(jsonb_build_object('type', coalesce(a.type, 'NULL')) || jsonb(a.data)) AS data_owner
				,f.data AS data_slave
			FROM (
				SELECT f.OWNER AS owner_id
					,m.type
					,f.data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				where cast(f.data ->> 'id' as varchar) = replace(resource, 'mri::', '')) a
			LEFT JOIN (
				SELECT f.OWNER
					,(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) AS data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				) f ON f.OWNER = cast(a.data ->> 'id' AS VARCHAR)
			) a
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	GROUP BY a.owner_id
		,m.type
	) a
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findfeedbyuser(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF feedresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.feedresult%ROWTYPE;
BEGIN

 	FOR resource_t in

 	
 	select * from
	(select 
	cast(data ->> 'id' as varchar) as id, 
	cast(data ->> 'createdate' as timestamp) as createdate,
	cast(data ->> 'description' as varchar) as description ,
	cast(data ->> 'title' as varchar) as title
	from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
group by  m.mri, mr.mri, m.type) m
cross join lateral public.findresourcedata(m.mri) as f
where m.type = 'POST' and m.owner notnull and m.owner in 
(select distinct(i.id) from
(
(
select r.from_id as id
from public.userrelation r
where r.to_id = user_id
and r.type = 'MENTOR')
union all
(select r.to_id 
from public.userrelation r
where   r.from_id = user_id
and r.type = 'FOLLOWER')
union all 
(select user_id)
) i)
order by cast(data ->> 'createdate' as timestamp) desc, cast(data ->> 'description' as varchar) asc) f
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findfeedbyuserdata(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF jsonresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresult%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
 	
select uuid_generate_v4(), json_agg(a.*) from (
SELECT 
	row_to_json(a.*) AS post
FROM (
	SELECT (jsonb_build_object('owner_id', coalesce(a.owner_id, 'NULL')) || jsonb_build_object('owner_type', coalesce(m.type, 'NULL')) || a.data) AS data
	FROM (
		SELECT a.owner_id
			,(a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) AS data
		FROM (
			SELECT a.owner_id
				,(jsonb_build_object('type', coalesce(a.type, 'NULL')) || jsonb(a.data)) AS data_owner
				,f.data AS data_slave
			FROM (
				SELECT f.OWNER AS owner_id
					,m.type
					,f.data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				) a
			LEFT JOIN (
				SELECT f.OWNER
					,(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) AS data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				) f ON f.OWNER = cast(a.data ->> 'id' AS VARCHAR)
			) a
		WHERE cast(a.data_owner ->> 'id' AS VARCHAR) IN (
				SELECT f.id
				FROM findfeedbyuser(user_id, itens_by_page, page) f
				)
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	) a
ORDER BY cast(a.data ->> 'createdate' AS TIMESTAMP) desc, cast(a.data ->> 'description' AS varchar) desc) a
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmylaunchs(user_id character varying, type_ character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   declare
      resource_t public.mynejsontype%ROWTYPE;

begin

 	for resource_t in
 	
select
	cast(uuid_generate_v4() as varchar) as id,
	'LAUNCH' as "type",
	l.launch_data || jsonb_build_object('nested', array_agg(l.product_data)) || l.user_data as data
from
	(
	select
		l.launch_data,
		l.product_data || jsonb_build_object('nested', array_agg(l.product_nested)) as product_data,
		jsonb_build_object('user', jsonb_build_object('user', l.user_data) || jsonb_build_object('profile_image', l.profile_image)) as user_data
	from
		(
		select
			jsonb_build_object('type', f.type) || to_jsonb(f.data) as launch_data,
			jsonb_build_object('type', ow.type) || to_jsonb(ow.data) as user_data,
			jsonb_build_object('type', ro.type) || to_jsonb(ro.data) as product_data,
			jsonb_build_object('type', rf.type) || to_jsonb(rf.data) as profile_image,
			jsonb_build_object('type', pn.type) || to_jsonb(pn.data) as product_nested
		from
			(
			select
				m.id
			from
				myneresourceinformation m
			where
				replace(m.mri, 'mri::', '') = coalesce(user_id, replace(m.mri, 'mri::', ''))
				and m.type = 'USER') m
		left join ownerresources o on
			m.id = o.owner
		left join myneresourceinformation mr on
			o.slave = mr.id
		left join lateral findresourcedata(replace(mr.mri, 'mri::', '')) as f on
			true
		left join lateral findresourcedata(f.owner) as ow on
			true
		left join lateral findresourcebyowner(cast(f.data ->> 'id' as varchar)) as ro on
			true
		left join lateral findresourcebyownerandtype(cast(ow.data ->> 'id' as varchar),
			'PROFILE_IMAGE') as rf on
			true
		left join lateral findresourcebyowner(cast(ro.data ->> 'id' as varchar)) as pn on
			true
		where
			mr.type = 'LAUNCH'
			and cast(f.data ->> 'launchType' as varchar) = coalesce(nullif(type_, 'NULO'), cast(f.data ->> 'launchType' as varchar)) ) l
	group by
		launch_data,
		l.user_data,
		l.product_data,
		l.profile_image
		) l
group by
	l.launch_data,
		l.user_data


loop
		return next resource_t;
end loop;

return;
end;

$function$
;

CREATE OR REPLACE FUNCTION public.findmylearning(user_id character varying, type_ character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'PRODUCT' AS "type"
	,p.data
FROM (
	SELECT jsonb_build_object('nested', array_agg(p.product_nested) || p.purchase_data || p.launch_data) || jsonb_build_object('user', jsonb_build_object('profile_image', p.profile_image) || jsonb_build_object('user', p.user)) || p.product_data AS data
	FROM (
		SELECT cast(f.data ->> 'product_id' AS VARCHAR) AS product_id
			,cast(f.data ->> 'launch_id' AS VARCHAR) AS launch_id
			,jsonb_build_object('type', p.type) || jsonb(p.data) AS product_nested
			,jsonb_build_object('type', f.type) || (jsonb(f.data) - 'product_id' - 'launch_id') AS purchase_data
			,jsonb_build_object('type', 'LAUNCH') || (
				CASE 
					WHEN jsonb(l.data) isnull
						THEN jsonb_build_object('data', NULL)
					ELSE jsonb(l.data)
					END
				) AS launch_data
			,jsonb_build_object('type', pd.type) || jsonb(pd.data) AS product_data
			,jsonb_build_object('type', ph.type) || jsonb(ph.data) AS profile_image
			,jsonb(u.data) AS "user"
		FROM (
			SELECT m.id
			FROM PUBLIC.myneresourceinformation m
			WHERE m.mri = CONCAT (
					'mri::'
					,user_id
					)
			) m
		LEFT JOIN ownerresources o ON m.id = o.OWNER
		LEFT JOIN myneresourceinformation mr ON mr.id = o.slave
		LEFT JOIN lateral findresourcedata(replace(mr.mri, 'mri::', '')) AS f ON true
		LEFT JOIN lateral findresourcebyowner(cast(f.data ->> 'product_id' AS VARCHAR)) AS p ON true
		LEFT JOIN lateral findresourcedata(cast(f.data ->> 'launch_id' AS VARCHAR)) AS l ON true
		LEFT JOIN lateral findresourcedata(cast(f.data ->> 'product_id' AS VARCHAR)) AS pd ON true
		LEFT JOIN lateral findresourcebyowner(pd.OWNER) AS ph ON true
		LEFT JOIN lateral findresourcedata(pd.OWNER) AS u ON true
		WHERE o.type = 'USER_PURCHASE'
			AND ph.type = 'PROFILE_IMAGE'
			AND cast(pd.data ->> 'productType' AS VARCHAR) = coalesce(nullif(type_, 'NULO'), cast(pd.data ->> 'productType' AS VARCHAR))
		) p
	GROUP BY p.purchase_data
		,p.user
		,p.profile_image
		,p.launch_data
		,p.product_data
	) p


loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmylives(userid character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in	
 	
select cast(uuid_generate_v4() as varchar) as id, 'LIVE' as type, to_json(f.data) as data from
(select f.live_data || jsonb_build_object('participants',array_agg(f.user_data)) as data from 
(select v.live_data  ||
jsonb_build_object('status', (case when v.enddate isnull then (case when now() < v.startdate then 'NOT_STARTED' else 'RUNNING' end ) else 'ENDED' end)) as live_data,
jsonb_build_object('user', (jsonb(u.data) || jsonb_build_object('type', u.type) ||
jsonb_build_object('token', v."token", 'participantType', v.participanttype))) ||
jsonb_build_object('profile_image', (jsonb(ph.data) || jsonb_build_object('type', ph.type))) as user_data
from
(select to_jsonb(v.*) as live_data, v.enddate, v.startdate, vp.user_id, vp.participanttype, vp."token" from myne_streams.video v, myne_streams.videoparticipant vp
where v.id = vp.video_id and (v.owner_id = coalesce(userid,v.owner_id) or vp.user_id = coalesce(userid,vp.user_id))
and vp."token" notnull
limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)) v
left join lateral public.findresourcedata(v.user_id) as u on true
left join lateral public.findresourcebyownerandtype(v.user_id, 'PROFILE_IMAGE') as ph on true
  ) f
group by f.live_data) f

	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmynefeed(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

 	
select cast(uuid_generate_v4() as varchar) as id, cast('POST' as varchar) as "type",
	p.post_data || jsonb_build_object('nested', array_agg(p.post_resource)) || p.user_data as data
from
	(
	select
		jsonb_build_object('type', 'POST', 'id', pd.id, 'createDate', pd.createdate, 'description', pd.description, 'releaseDate', pd.releasedate, 'title', pd.title, 'canComment', pd.cancomment) as post_data,
		jsonb_build_object('type', pr.type) || jsonb(pr.data) as post_resource,
		jsonb_build_object('user', jsonb_build_object('user', jsonb_build_object('type', ud.type) || jsonb(ud.data)) || 
jsonb_build_object('profile_image', jsonb_build_object('type', ur.type) || jsonb(ur.data))) as user_data
	from
		(
		select
			u.id as user_id,
			o.slave as mri_id_slave,
			mr.createdate,
			replace(mr.mri, 'mri::', '') as post_id,
			mr.type as slaves_type
		from
			(
			select
				distinct(r.to_id) as id
			from
				relationrequest r
			where
				r.status = 'ACCEPTED'
				and
(r.type = 'FOLLOWER'
					or r.type = 'PUPIL'
					or r.type = 'PARTNER')
				and r.from_id = user_id) u
		left join myneresourceinformation m on
			replace(m.mri, 'mri::', '') = u.id
		left join ownerresources o on
			m.id = o."owner"
		left join myneresourceinformation mr on
			mr.id = o.slave
		where
			(o."type" = 'USER_POST' )
		order by
			mr.createdate desc,
			mr.id asc
		limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)) u
	left join post as pd on pd.id = u.post_id
	left join lateral findresourcedata(u.user_id) as ud on
		true
	left join lateral findresourcebyowner(u.post_id) as pr on
		true
	left join lateral findresourcebyownerandtype(u.user_id,
		'PROFILE_IMAGE') as ur on
		true
		where DATE_PART('day', now() - pd.releasedate) >= 0 )
p
group by
	p.post_data,
	p.user_data
	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmynegalaxy(user_id character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select user_id as id, 'USER_GALAXY' as type, row_to_json(r.*) as data from 
(
select a.follower, b.following, c.partner, d.mentor, e.pupil from
(select CAST(count(u.id)AS varchar(50)) as follower
from public.userrelation u
where u.type ='FOLLOWER'
and u.to_id = user_id) a,
(select CAST(count(u.id)AS varchar(50)) as following
from public.userrelation u
where u.type ='FOLLOWER'
and u.from_id = user_id) b,
(select CAST(count(u.id)AS varchar(50)) as partner
from public.userrelation u
where u.type ='PARTNER'
and u.to_id = user_id) c,
(select CAST(count(u.id)AS varchar(50)) as mentor
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = user_id) d,
(select CAST(count(u.id)AS varchar(50)) as pupil
from public.userrelation u
where u.type ='PUPIL'
and u.to_id = user_id) e
) r


loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in	
	
	
	select g.id, g.type, g.data from public.globalfeed g
limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)

	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyneglobalinsights(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in	
	
	
select
	cast(uuid_generate_v4() as varchar) as id,
	cast('INSIGHT' as varchar) as "type",
	json(i.data)
from
	(
	select
		i.user || jsonb_build_object('insight', array_agg(i.insight)) as data
	from
		(
		select
			i.user,
			i.insight_data || jsonb_build_object('nested', array_agg(i.insight_slave)) as insight
		from
			(
			select
				jsonb_build_object('type', ud.type) || jsonb(ud.data) ||
jsonb_build_object('profile_image', jsonb_build_object('type', pf.type) || jsonb(pf.data)) as user ,
				jsonb_build_object('type', ui.type) || jsonb(ui.data) as insight_data,
				jsonb_build_object('type', id.type) || jsonb(id.data) as insight_slave
			from
				(
				select
					u.user_id
				from
					(
					select
						distinct(replace(m.mri, 'mri::', '')) user_id
					from
						myneresourceinformation m,
						ownerresources o
					where
						o."type" = 'USER_INSIGHT'
						and o."owner" = m.id
 ) u
				order by
					random()
				limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)) u
			left join lateral findresourcedata(u.user_id) as ud on
				true
			left join lateral findresourcebyownerandtype(u.user_id,
				'PROFILE_IMAGE') as pf on
				true
			left join lateral findresourcebyownerandtype(u.user_id,
				'INSIGHT') as ui on
				true
			left join lateral findresourcebyowner(cast(ui.data ->> 'id' as varchar)) as id on
				true) i
		group by
			i.user,
			i.insight_data) i
	group by
		i.user) i
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyneinsights(user_id character varying, relation_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	--FOR resource_t in

--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
IF relation_type = 'FOLLOWING' then
	RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('relation', 'FOLLOWING') || jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWER' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PUPIL'
							AND u.to_id = user_id
						)) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;

elsif relation_type = 'PARTNER' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('relation', 'PARTNER') || jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(
					SELECT *
					FROM (
						SELECT u.to_id
							,'PARTNER' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PUPIL'
							AND u.to_id = user_id
						) 
					) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;

elsif relation_type = 'MENTOR' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('relation', 'MENTOR') || jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(
				
				
				
					SELECT *
					FROM (
						SELECT u.to_id as to_id
							,'MENTOR' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PUPIL'
							AND u.from_id = user_id
						) a 
					
				) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;


elsif relation_type = 'NULO' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data) as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('relation', 'GLOBAL') || jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid != user_id
group by
i.user_data, i.userid) i
order by random();
	
	end IF ;
  
 
--loop
		--RETURN NEXT resource_t;
	
   --END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyneinsights(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'INSIGHT' AS type
	,to_json(r.data)
FROM (
	SELECT r.user || jsonb_build_object('insight', array_agg(r.data)) AS data
	FROM (
		SELECT r.user
			,r.insight || jsonb_build_object('nested', array_agg(r.slave)) AS data
		FROM (
			SELECT to_jsonb(h.data) || jsonb_build_object('relation', r.relation) || jsonb_build_object('profile_image', jsonb(g.data)) AS user
				,jsonb_build_object('type', i.type) || jsonb(i.data) AS insight
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS slave
			FROM (
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWING' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWING'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWING'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				UNION ALL
				
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				UNION ALL
				
				(
					SELECT *
					FROM (
						SELECT u.from_id
							,'MENTOR'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) a limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				) r
			CROSS JOIN lateral findresourcebyowner(r.to_id) AS i
			CROSS JOIN lateral findresourcebyowner(cast(i.data ->> 'id' AS VARCHAR)) AS f
			LEFT JOIN lateral findresourcebyowner(r.to_id) AS g ON true
			CROSS JOIN lateral findresourcedata(r.to_id) AS h
			WHERE i.type = 'INSIGHT'
				AND g.type = 'PROFILE_IMAGE'
			) r
		GROUP BY r.user
			,r.insight
		) r
	GROUP BY r.user
	) r
	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyneinsights(user_id character varying, itens_by_page integer, page integer, relation_type character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	--FOR resource_t in

--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
IF relation_type = 'FOLLOWING' then
	RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWER' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						)) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;

elsif relation_type = 'PARTNER' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(
					SELECT *
					FROM (
						SELECT u.to_id
							,'PARTNER' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) 
					) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;

elsif relation_type = 'MENTOR' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(
				
				
				
					SELECT *
					FROM (
						SELECT u.from_id as to_id
							,'MENTOR' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) a 
					
				) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;


elsif relation_type = 'NULO' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid != user_id
group by
i.user_data, i.userid) i
order by random();
	
	end IF ;
  
 
--loop
		--RETURN NEXT resource_t;
	
   --END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyneinsightsbyrelation(user_id character varying, relation_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	--FOR resource_t in

--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
IF relation_type = 'FOLLOWING' then
	RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,cast('INSIGHT' as varchar) AS type
	,to_json(r.data)
FROM (
	SELECT r.user || jsonb_build_object('insight', array_agg(r.data)) AS data
	FROM (
		SELECT r.user
			,r.insight || jsonb_build_object('nested', array_agg(r.slave)) AS data
		FROM (
			SELECT to_jsonb(h.data) || jsonb_build_object('relation', r.relation) || jsonb_build_object('profile_image', jsonb(g.data)) AS user
				,jsonb_build_object('type', i.type) || jsonb(i.data) AS insight
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS slave
			FROM (
				
					SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWER' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
				) r
			CROSS JOIN lateral findresourcebyowner(r.to_id) AS i
			CROSS JOIN lateral findresourcebyowner(cast(i.data ->> 'id' AS VARCHAR)) AS f
			LEFT JOIN lateral findresourcebyowner(r.to_id) AS g ON true
			CROSS JOIN lateral findresourcedata(r.to_id) AS h
			WHERE i.type = 'INSIGHT'
				AND g.type = 'PROFILE_IMAGE'
			) r
		GROUP BY r.user
			,r.insight
		) r
	GROUP BY r.user
	) r;

elsif relation_type = 'PARTNER' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,cast('INSIGHT' as varchar) AS type
	,to_json(r.data)
FROM (
	SELECT r.user || jsonb_build_object('insight', array_agg(r.data)) AS data
	FROM (
		SELECT r.user
			,r.insight || jsonb_build_object('nested', array_agg(r.slave)) AS data
		FROM (
			SELECT to_jsonb(h.data) || jsonb_build_object('relation', r.relation) || jsonb_build_object('profile_image', jsonb(g.data)) AS user
				,jsonb_build_object('type', i.type) || jsonb(i.data) AS insight
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS slave
			FROM (
				
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'PARTNER' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				
				) r
			CROSS JOIN lateral findresourcebyowner(r.to_id) AS i
			CROSS JOIN lateral findresourcebyowner(cast(i.data ->> 'id' AS VARCHAR)) AS f
			LEFT JOIN lateral findresourcebyowner(r.to_id) AS g ON true
			CROSS JOIN lateral findresourcedata(r.to_id) AS h
			WHERE i.type = 'INSIGHT'
				AND g.type = 'PROFILE_IMAGE'
			) r
		GROUP BY r.user
			,r.insight
		) r
	GROUP BY r.user
	) r;

elsif relation_type = 'MENTOR' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,cast('INSIGHT' as varchar) AS type
	,to_json(r.data)
FROM (
	SELECT r.user || jsonb_build_object('insight', array_agg(r.data)) AS data
	FROM (
		SELECT r.user
			,r.insight || jsonb_build_object('nested', array_agg(r.slave)) AS data
		FROM (
			SELECT to_jsonb(h.data) || jsonb_build_object('relation', r.relation) || jsonb_build_object('profile_image', jsonb(g.data)) AS user
				,jsonb_build_object('type', i.type) || jsonb(i.data) AS insight
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS slave
			FROM (
				
				
				
					SELECT *
					FROM (
						SELECT u.from_id as to_id
							,'MENTOR' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) a limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					
				) r
			CROSS JOIN lateral findresourcebyowner(r.to_id) AS i
			CROSS JOIN lateral findresourcebyowner(cast(i.data ->> 'id' AS VARCHAR)) AS f
			LEFT JOIN lateral findresourcebyowner(r.to_id) AS g ON true
			CROSS JOIN lateral findresourcedata(r.to_id) AS h
			WHERE i.type = 'INSIGHT'
				AND g.type = 'PROFILE_IMAGE'
			) r
		GROUP BY r.user
			,r.insight
		) r
	GROUP BY r.user
	) r;


elsif relation_type = 'NULO' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,cast('INSIGHT' as varchar) AS type
	,to_json(r.data)
FROM (
	SELECT r.user || jsonb_build_object('insight', array_agg(r.data)) AS data
	FROM (
		SELECT r.user
			,r.insight || jsonb_build_object('nested', array_agg(r.slave)) AS data
		FROM (
			SELECT to_jsonb(h.data) || jsonb_build_object('relation', r.relation) || jsonb_build_object('profile_image', jsonb(g.data)) AS user
				,jsonb_build_object('type', i.type) || jsonb(i.data) AS insight
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS slave
			FROM (
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWING' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWING'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWING'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				UNION ALL
				
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				UNION ALL
				
				(
					SELECT *
					FROM (
						SELECT u.from_id
							,'MENTOR'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) a limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				) r
			CROSS JOIN lateral findresourcebyowner(r.to_id) AS i
			CROSS JOIN lateral findresourcebyowner(cast(i.data ->> 'id' AS VARCHAR)) AS f
			LEFT JOIN lateral findresourcebyowner(r.to_id) AS g ON true
			CROSS JOIN lateral findresourcedata(r.to_id) AS h
			WHERE i.type = 'INSIGHT'
				AND g.type = 'PROFILE_IMAGE'
			) r
		GROUP BY r.user
			,r.insight
		) r
	GROUP BY r.user
	) r;
	
	end IF ;
  
 
--loop
		--RETURN NEXT resource_t;
	
   --END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmynerelatedposts(post_id character varying, qtde integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select r.id, 'POST' as type,  r.data from 
	(select r.id, jsonb_build_object('nested', array_agg(r.nested)) || r.post as data from 
	(select f.id, jsonb_build_object( 'type', r.type) || jsonb(r.data) as nested,  to_jsonb( f.data) as post from
	(select cast(data ->> 'id' as varchar) as id, r.data from 
findresourcebyowner((select r.owner from findresourcedata(replace(post_id,'mri::','')) r)) r
where r.type = 'POST'
and cast(data ->> 'id' as varchar) != replace(post_id,'mri::','')
order by cast(data ->> 'createdate' as timestamp) desc
limit qtde) f
cross join lateral findresourcebyowner(f.id) as r ) r
group by r.id, r.post) r

	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmynerelations(user_from character varying, user_to character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
select uuid_generate_v4() as id, 'USER_RELATIONS' as type,
json_build_object('from_id', u.from_id , 'type', u."type", 'to_id', u.to_id, 'status', u.status) as data
from relationrequest u 
where u.from_id = coalesce((case when user_from = 'a' then null else user_from end), u.from_id)
and u.to_id = coalesce((case when user_to = 'a' then null else user_to end), u.to_id)
and u.status != 'DELETED' and u.status != 'DENIED'
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)



loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyneresource(resource character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 
 	select cast(uuid_generate_v4() as varchar) as id,  (select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(resource, 'mri::', '')) as type, 
 	to_json(f.data) as data from
(select jsonb_build_object('owner_id', o.owner) || jsonb_build_object('type', o.type) || to_jsonb(o.data) || f.nested as data from
(select f.owner, jsonb_build_object('nested', array_agg(f.data)) as nested from
(select o.owner, f.data  from (select resource as owner) o left join 
(select f.owner, jsonb_build_object('type', f.type) || to_jsonb(f.data)	as data 
from findresourcebyowner(resource) f) f on o.owner = f.owner
) f
group by f.owner) f 
cross join lateral findresourcedata(f.owner) as o ) f

	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyposts(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 	
select cast(uuid_generate_v4() as varchar) as id, cast('POST' as varchar) as "type",
	p.post_data || jsonb_build_object('nested', array_agg(p.post_resource)) || p.user_data as data
from
	(
	select
		jsonb_build_object('type', 'POST', 'id', pd.id, 'createDate', pd.createdate, 'description', pd.description, 'releaseDate', pd.releasedate, 'title', pd.title, 'canComment', pd.cancomment) as post_data,
		jsonb_build_object('type', pr.type) || jsonb(pr.data) as post_resource,
		jsonb_build_object('user', jsonb_build_object('profile_image', jsonb_build_object('type', ur.type) || jsonb(ur.data)) || 
jsonb_build_object('user', jsonb_build_object('type', ud.type) || jsonb(ud.data))) as user_data
	from
		(
		select
			u.id as user_id,
			o.slave as mri_id_slave,
			mr.createdate,
			replace(mr.mri, 'mri::', '') as post_id,
			mr.type as slaves_type
		from
			(select user_id as id) u
		left join myneresourceinformation m on
			replace(m.mri, 'mri::', '') = u.id
		left join ownerresources o on
			m.id = o."owner"
		left join myneresourceinformation mr on
			mr.id = o.slave
		where
			(o."type" = 'USER_POST' and 
			mr."type" = 'POST')
		order by
			mr.createdate desc,
			mr.id asc
		limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)) u
	left join post as pd on pd.id = u.post_id
	left join lateral findresourcedata(u.user_id) as ud on
		true
	left join lateral findresourcebyowner(u.post_id) as pr on
		true
	left join lateral findresourcebyownerandtype(u.user_id,
		'PROFILE_IMAGE') as ur on
		true)
p
group by
	p.post_data,
	p.user_data

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findmyproducts(user_id character varying, type_ character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'PRODUCT' AS "type"
	,p.data
FROM (
	SELECT jsonb_build_object('user', jsonb_build_object('user', p.user) || jsonb_build_object('profile_image', i.data)) || p.product_data AS data
	FROM (
		SELECT p.user
			,p.product_data || jsonb_build_object('nested', array_agg(p.nested)) AS product_data
		FROM (
			SELECT jsonb(u.data) AS user
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS product_data
				,jsonb_build_object('type', s.type) || jsonb(s.data) AS nested
			FROM findresourcebyowner(user_id) f
			LEFT JOIN lateral findresourcebyowner(cast(f.data ->> 'id' AS VARCHAR)) AS s ON true
			LEFT JOIN lateral findresourcedata(user_id) AS u ON true
			WHERE f.type = 'PRODUCT'
				AND cast(f.data ->> 'productType' AS VARCHAR) = coalesce(nullif(type_,'NULO'), cast(f.data ->> 'productType' AS VARCHAR))
			) p
		GROUP BY p.user
			,p.product_data
		) p
	LEFT JOIN lateral findresourcebyowner(user_id) AS i ON true
	WHERE i.type = 'PROFILE_IMAGE'
	) p


loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findownerdata(resource character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
    mri_id character varying;
BEGIN
mri_id := replace(resource,'mri::','');
   


 	FOR resource_t in

	
select o.* from findresourcedata(mri_id) f
cross join lateral findresourcedata(f.owner) as o
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findownerresource(resource character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

select f.owner as slave, f.type, f.id, f.data from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
group by  m.mri, mr.mri, m.type) m
cross join lateral public.findresourcebyowner(m.owner) as f
where m.owner notnull and m.mri = replace(resource,'mri::','') --and f.owner = m.owner
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findprofilebyslug(slug_ character varying, type_ character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
     user_id character varying;
begin
	
user_id := (select u.id from myneuser u where u.slug = slug_);
   


 	FOR resource_t in

 	
select cast(uuid_generate_v4() as varchar) as id, r.type, to_json(r.data || jsonb_build_object('nested', array_agg(r.nested))) as data from
(select m.type, m.createdate, jsonb_build_object('type', f.type) || jsonb(f.data) as data, jsonb_build_object('type', r.type) || jsonb(r.data) as nested from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type, m.createdate from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
where
 m."type" = coalesce(nullif(type_,'NULO'), m."type")
 and m."type" in ('POST', 'INSIGHT', 'PURCHASE', 'PROFILE_IMAGE')
and replace(mr.mri,'mri::','') = user_id
group by  m.mri, mr.mri, m.type, m.createdate
order by m.createdate desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral public.findresourcedata(m.mri) as f
left join lateral public.findresourcebyowner(m.mri) as r on true
where m.owner notnull and m.owner = replace(user_id,'mri::','') and f.owner = m.owner) r
group by r.data, r.type, r.createdate
order by r.createdate desc

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findrelatedposts(mri character varying, qtdepost integer)
 RETURNS SETOF feedresult
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.feedresult%ROWTYPE;
BEGIN

 	FOR resource_t in

	select cast(data ->> 'id' as varchar) as id, 
	cast(data ->> 'createdate' as timestamp) as createdate,
	cast(data ->> 'description' as varchar) as description ,
	cast(data ->> 'title' as varchar) as title
	from 
findresourcebyowner((select r.owner from findresourcedata(replace(mri,'mri::','')) r)) r
where r.type = 'POST'
and cast(data ->> 'id' as varchar) != replace(mri,'mri::','')
order by cast(data ->> 'createdate' as timestamp) desc
limit qtdepost

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findresourcebyowner(resource character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

select f.* from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
group by  m.mri, mr.mri, m.type) m
cross join lateral public.findresourcedata(m.mri) as f
where m.owner notnull and m.owner = replace(resource,'mri::','') and f.owner = m.owner
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findresourcebyownerandtype(resource character varying, type_ character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

select f.* from 
(
select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner = mr.id
group by  m.mri, mr.mri, m.type) m
cross join lateral public.findresourcedata(m.mri) as f
where m.owner notnull and m.owner = replace(resource,'mri::','') and f.owner = m.owner and m.type = type_
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.findresourcedata(resource character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
     mri_type character varying;
    mri_id character varying;
BEGIN
mri_id := replace(resource,'mri::','');
  mri_type := (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = mri_id limit 1);
   


 	FOR resource_t in

	select (case when l.owner isnull then (case when (mri_type) = 'LIVE' then cast((r.resourcedata ->> 'owner_id') as varchar) else 'DON''T HAVE' end) else l.owner end) as owner,
	(select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = mri_id limit 1) as type,  uuid_generate_v4() as id, r.* from 
(select
(case when (mri_type) = 'USER'
   then (select row_to_json(u) from (select u.id, u.accountname as "accountName", u.active, u.createdate as "createDate", u.devicetoken, u.email, u.name, u.slug, u.usertype as "userType", u.visibility, u.biography from public.myneuser u where u.id= mri_id) u)
   when (mri_type) = 'POST'
    then (select row_to_json(p) from (select p.id, p.createdate as "createDate", p.description, p.title, p.cancomment as "canComment", p.releasedate as "releaseDate" from public.post p where p.id= mri_id order by p.createdate desc) p)
    when (mri_type) = 'LIVE'
    then (select row_to_json(l) from (select l.id, l.dtype, l.createdate as "createDate", l.enddate as "endDate", l.externalid as "externalId", l.participationtype as "participationType", l.rememberfrequency as "rememberFrequency", l.startdate as "startDate", l.description, l.title, l.owner_id from myne_streams.video l where l.id= mri_id ) l) 
    when (mri_type) = 'LAUNCH'
   then (select row_to_json(l) from  (select l.id, l.createdate as "createDate", l.description, l.launchtype as "launchType", l."name", l.releasedate as "releaseDate" from public.launch l where l.id= mri_id) l)
      when (mri_type) = 'MODULE'
   then (select row_to_json(m) from  (select m.id, m.name, m.active, m.createdate as "createDate", m.description, cast(m.details as json) as "details" from public."module" m where m.id= mri_id) m)
     when (mri_type) = 'SITE'
   then (select row_to_json(s) from  (select * from public.site s where s.id= mri_id) s)
   when (mri_type) = 'PHONE'
   then (select row_to_json(p) from (select * from public.phone p where p.id= mri_id) p)
    when (mri_type) = 'ACCOUNTABILITY' 
   then (select row_to_json(a) from (select * from public.accountability a where a.id= mri_id) a)
   when (mri_type) = 'LAUNCHWORKFLOW' 
   then (select row_to_json(l) from (select l.id, l.startdate as "startDate", l.enddate as "endDate", l.phase from public.launchworkflow l where l.id= mri_id) l)
   when (mri_type) = 'INSIGHT'
   then (select row_to_json(i) from (select i.id, i.active, i.createdate as "createDate", i.insighttype as "insightType", i.url, i.releasedate as "releaseDate" from public.insight i where i.id= mri_id) i)
   when (mri_type) = 'PRICE'
   then (select row_to_json(p) from (select p.id, p.active, p.discount, p.price, p.createdate as "createDate" from public.price p where p.id= mri_id) p)
    when (mri_type) = 'COMMENT' 
   then (select row_to_json(c) from (select c.id, c.createdate as "createDate", c.text from public.comment c  where c.id = mri_id) c)
   when (mri_type) = 'PRODUCT' 
   then (select row_to_json(p) from (select p.id, p.active, p.createdate as "createDate", p.releasedate as "releaseDate", p.description, p.name, p.producttype as "productType", cast(p.details as json) from public.product p  where p.id = mri_id) p)
    when (mri_type) = 'PURCHASE' 
   then (select row_to_json(p) from (select p.id, p.product_id, p.launch_id, p.createdate as "createDate", p.value from public.purchase p  where p.id = mri_id) p)
   when (mri_type) = 'ADDRESS'
   then (select row_to_json(a) from (select * from public.address a where a.id= mri_id) a)
   else (select row_to_json(s) from (select s.id, s.createdate as "createDate", s.description, s.filename as "fileName", s.filetype as "fileType", s.s3url, s.solicitacaoid, s.order_ from public.s3file s where s.id= mri_id) s)
   end) as resourcedata) r,
  (select replace(m.mri,'mri::','') as mri, replace(mr.mri,'mri::','') as owner, m.type from public.myneresourceinformation m 
left join ownerresources o on o.slave = m.id
left join myneresourceinformation mr on o.owner=mr.id
group by  m.mri, mr.mri, m.type) l
where r.resourcedata ->> 'id' = l.mri

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.gin_extract_query_trgm(text, internal, smallint, internal, internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_extract_query_trgm$function$
;

CREATE OR REPLACE FUNCTION public.gin_extract_value_trgm(text, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_extract_value_trgm$function$
;

CREATE OR REPLACE FUNCTION public.gin_trgm_consistent(internal, smallint, text, integer, internal, internal, internal, internal)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_trgm_consistent$function$
;

CREATE OR REPLACE FUNCTION public.gin_trgm_triconsistent(internal, smallint, text, integer, internal, internal, internal)
 RETURNS "char"
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_trgm_triconsistent$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_compress(internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_compress$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_consistent(internal, text, smallint, oid, internal)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_consistent$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_decompress(internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_decompress$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_distance(internal, text, smallint, oid, internal)
 RETURNS double precision
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_distance$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_in(cstring)
 RETURNS gtrgm
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_in$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_out(gtrgm)
 RETURNS cstring
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_out$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_penalty(internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_penalty$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_picksplit(internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_picksplit$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_same(gtrgm, gtrgm, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_same$function$
;

CREATE OR REPLACE FUNCTION public.gtrgm_union(internal, internal)
 RETURNS gtrgm
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_union$function$
;

CREATE OR REPLACE FUNCTION public.insertadmindata()
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

insert into myneuser(id,accountname,active,createdate,email,name,password,usertype,visibility,method)
values (uuid_generate_v4(), 'MYNE_SYSTEM_USER', true, now(),
'sender@myne.net.br', 'System User','duBl4ck@pw', 'USER', 'PRIVATE', 'Myne');

select 'DONE' into retorno;

return retorno;


end;
$function$
;

CREATE OR REPLACE FUNCTION public.insightinsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

INSERT INTO "global".insights (insight_id, userid, insight_data, releasedate, user_data, insert_date) 
select i.insight_id, i.user_id, i.insight_data, i.releasedate, i.user_data, now() from
(select i.insight_id, i.user_id, i.insight_data || i.insight_slave as insight_data, i.releasedate, i.user_data
from
(select i.insight_id, i.user_id, i.insight_data, i.releasedate,
jsonb_build_object('nested', array_agg(i.insight_slave)) as insight_slave,
i.user_data from
(select m.mri as insight_id, cast(ud.data ->> 'id' as varchar) as "user_id",
cast(id.data ->> 'releaseDate' as timestamp with time zone) as "releasedate",
jsonb_build_object('type', id.type) || jsonb(id.data) as insight_data,
jsonb_build_object('type', ir.type) || jsonb(ir.data) as insight_slave,
jsonb_build_object('type', ud.type) || jsonb(ud.data) ||
jsonb_build_object('profile_image', jsonb_build_object('type', ur.type) || jsonb(ur.data)) as user_data
from
(select distinct(i.id) as mri from insight i
except
select distinct(i.insight_id) from global.insights i) m
left join lateral findresourcedata(m.mri) as id on true
left join lateral findresourcebyowner(m.mri) as ir on true 
left join findresourcedata(id.owner) as ud on true 
left join lateral findresourcebyownerandtype(id.owner, 'PROFILE_IMAGE') as ur on true
where id.data notnull  and ud.type = 'USER') i
group by  i.insight_id, i.user_id, i.insight_data, i.user_data, i.releasedate) i ) i;

delete from global.insights i where i.insight_id in
(select distinct(i.insight_id) from global.insights i
except 
select i.id from public.insight i);

RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.listmynerelations(user_id_ character varying, relation_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	--FOR resource_t in

--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
IF relation_type = 'FOLLOWER' then
	RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
	,row_to_json(u.*) AS relation
FROM (
	SELECT row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createdate', o.createdate) || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype) || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname
			,u.active
			,u.createdate
			,u.devicetoken
			,u.email
			,u.name
			,u.slug
			,u.usertype
			,u.visibility
		FROM myneuser u
		) u
		,(
			SELECT max(s.id) AS s3_id
				,max(s.createdate) AS createdate
				,max(s.description) AS description
				,max(s.filename) AS filename
				,max(s.filetype) AS filetype
				,max(s.s3url) AS s3url
				,o.user_id
				,o.
			ORDER
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
					,pi.
				ORDER
				FROM (
					SELECT u.user_id
						,o.slave AS id
						,u.
					ORDER
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
							,u.
						ORDER
						FROM (
							SELECT u.user_id
								,ROW_NUMBER() OVER (
									ORDER BY cast(count.data ->> 'followers' AS INTEGER) DESC
										,count.id ASC
									) AS
							ORDER
							FROM (
								SELECT u.*
								FROM PUBLIC.userrelation r
									,(
										SELECT u.id AS user_id
											,u.accountname
											,u.active
											,u.createdate
											,u.devicetoken
											,u.email
											,u.name
											,u.slug
											,u.usertype
											,u.visibility
										FROM myneuser u
										) u
								WHERE u.user_id = r.from_id
									AND r.to_id = user_id_
									AND r.type = 'FOLLOWER'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
							) u
							,myneresourceinformation m
						WHERE replace(m.mri, 'mri::', '') = u.user_id
						) u
					LEFT JOIN ownerresources o ON u.mri_id = o.OWNER
						AND o.type = 'USER_PROFILE_IMAGE'
					) pi
				LEFT JOIN myneresourceinformation m ON pi.id = m.id
				) o
			LEFT JOIN s3file s ON o.s3_id = s.id
			GROUP BY o.user_id
				,o.
			ORDER
			) o
	WHERE o.user_id = u.id
	ORDER BY o.
	ORDER ASC
	) u;

elsif relation_type = 'FOLLOWING' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
	,row_to_json(u.*) AS relation
FROM (
	SELECT row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createdate', o.createdate) || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype) || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname
			,u.active
			,u.createdate
			,u.devicetoken
			,u.email
			,u.name
			,u.slug
			,u.usertype
			,u.visibility
		FROM myneuser u
		) u
		,(
			SELECT max(s.id) AS s3_id
				,max(s.createdate) AS createdate
				,max(s.description) AS description
				,max(s.filename) AS filename
				,max(s.filetype) AS filetype
				,max(s.s3url) AS s3url
				,o.user_id
				,o.
			ORDER
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
					,pi.
				ORDER
				FROM (
					SELECT u.user_id
						,o.slave AS id
						,u.
					ORDER
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
							,u.
						ORDER
						FROM (
							SELECT u.user_id
								,ROW_NUMBER() OVER (
									ORDER BY cast(count.data ->> 'followers' AS INTEGER) DESC
										,count.id ASC
									) AS
							ORDER
							FROM (
								SELECT u.*
								FROM PUBLIC.userrelation r
									,(
										SELECT u.id AS user_id
											,u.accountname
											,u.active
											,u.createdate
											,u.devicetoken
											,u.email
											,u.name
											,u.slug
											,u.usertype
											,u.visibility
										FROM myneuser u
										) u
								WHERE u.user_id = r.to_id
									AND r.from_id = user_id_
									AND r.type = 'FOLLOWER'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
							) u
							,myneresourceinformation m
						WHERE replace(m.mri, 'mri::', '') = u.user_id
						) u
					LEFT JOIN ownerresources o ON u.mri_id = o.OWNER
						AND o.type = 'USER_PROFILE_IMAGE'
					) pi
				LEFT JOIN myneresourceinformation m ON pi.id = m.id
				) o
			LEFT JOIN s3file s ON o.s3_id = s.id
			GROUP BY o.user_id
				,o.
			ORDER
			) o
	WHERE o.user_id = u.id
	ORDER BY o.
	ORDER ASC
	) u;

elsif relation_type = 'MENTOR' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
	,row_to_json(u.*) AS relation
FROM (
	SELECT row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createdate', o.createdate) || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype) || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname
			,u.active
			,u.createdate
			,u.devicetoken
			,u.email
			,u.name
			,u.slug
			,u.usertype
			,u.visibility
		FROM myneuser u
		) u
		,(
			SELECT max(s.id) AS s3_id
				,max(s.createdate) AS createdate
				,max(s.description) AS description
				,max(s.filename) AS filename
				,max(s.filetype) AS filetype
				,max(s.s3url) AS s3url
				,o.user_id
				,o.
			ORDER
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
					,pi.
				ORDER
				FROM (
					SELECT u.user_id
						,o.slave AS id
						,u.
					ORDER
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
							,u.
						ORDER
						FROM (
							SELECT u.user_id
								,ROW_NUMBER() OVER (
									ORDER BY cast(count.data ->> 'followers' AS INTEGER) DESC
										,count.id ASC
									) AS
							ORDER
							FROM (
								SELECT u.*
								FROM PUBLIC.userrelation r
									,(
										SELECT u.id AS user_id
											,u.accountname
											,u.active
											,u.createdate
											,u.devicetoken
											,u.email
											,u.name
											,u.slug
											,u.usertype
											,u.visibility
										FROM myneuser u
										) u
								WHERE u.user_id = r.from_id
									AND r.to_id = user_id_
									AND r.type = 'MENTOR'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
							) u
							,myneresourceinformation m
						WHERE replace(m.mri, 'mri::', '') = u.user_id
						) u
					LEFT JOIN ownerresources o ON u.mri_id = o.OWNER
						AND o.type = 'USER_PROFILE_IMAGE'
					) pi
				LEFT JOIN myneresourceinformation m ON pi.id = m.id
				) o
			LEFT JOIN s3file s ON o.s3_id = s.id
			GROUP BY o.user_id
				,o.
			ORDER
			) o
	WHERE o.user_id = u.id
	ORDER BY o.
	ORDER ASC
	) u;

elsif relation_type = 'PARTNER' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
	,row_to_json(u.*) AS relation
FROM (
	SELECT row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createdate', o.createdate) || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype) || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname
			,u.active
			,u.createdate
			,u.devicetoken
			,u.email
			,u.name
			,u.slug
			,u.usertype
			,u.visibility
		FROM myneuser u
		) u
		,(
			SELECT max(s.id) AS s3_id
				,max(s.createdate) AS createdate
				,max(s.description) AS description
				,max(s.filename) AS filename
				,max(s.filetype) AS filetype
				,max(s.s3url) AS s3url
				,o.user_id
				,o.
			ORDER
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
					,pi.
				ORDER
				FROM (
					SELECT u.user_id
						,o.slave AS id
						,u.
					ORDER
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
							,u.
						ORDER
						FROM (
							SELECT u.user_id
								,ROW_NUMBER() OVER (
									ORDER BY cast(count.data ->> 'followers' AS INTEGER) DESC
										,count.id ASC
									) AS
							ORDER
							FROM (
								SELECT u.*
								FROM PUBLIC.userrelation r
									,(
										SELECT u.id AS user_id
											,u.accountname
											,u.active
											,u.createdate
											,u.devicetoken
											,u.email
											,u.name
											,u.slug
											,u.usertype
											,u.visibility
										FROM myneuser u
										) u
								WHERE u.user_id = r.to_id
									AND r.from_id = user_id_
									AND r.type = 'PARTNER'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
							) u
							,myneresourceinformation m
						WHERE replace(m.mri, 'mri::', '') = u.user_id
						) u
					LEFT JOIN ownerresources o ON u.mri_id = o.OWNER
						AND o.type = 'USER_PROFILE_IMAGE'
					) pi
				LEFT JOIN myneresourceinformation m ON pi.id = m.id
				) o
			LEFT JOIN s3file s ON o.s3_id = s.id
			GROUP BY o.user_id
				,o.
			ORDER
			) o
	WHERE o.user_id = u.id
	ORDER BY o.
	ORDER ASC
	) u;

elsif relation_type = 'PUPIL' then

RETURN query

SELECT cast(uuid_generate_v4() AS VARCHAR) AS "user_id_"
	,--user_id_, 
	relation_type AS type
	,row_to_json(u.*) AS relation
FROM (
	SELECT row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createdate', o.createdate) || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o.filename) || jsonb_build_object('filetype', o.filetype) || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname
			,u.active
			,u.createdate
			,u.devicetoken
			,u.email
			,u.name
			,u.slug
			,u.usertype
			,u.visibility
		FROM myneuser u
		) u
		,(
			SELECT max(s.id) AS s3_id
				,max(s.createdate) AS createdate
				,max(s.description) AS description
				,max(s.filename) AS filename
				,max(s.filetype) AS filetype
				,max(s.s3url) AS s3url
				,o.user_id
				,o.
			ORDER
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
					,pi.
				ORDER
				FROM (
					SELECT u.user_id
						,o.slave AS id
						,u.
					ORDER
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
							,u.
						ORDER
						FROM (
							SELECT u.user_id
								,ROW_NUMBER() OVER (
									ORDER BY cast(count.data ->> 'followers' AS INTEGER) DESC
										,count.id ASC
									) AS
							ORDER
							FROM (
								SELECT u.*
								FROM PUBLIC.userrelation r
									,(
										SELECT u.id AS user_id
											,u.accountname
											,u.active
											,u.createdate
											,u.devicetoken
											,u.email
											,u.name
											,u.slug
											,u.usertype
											,u.visibility
										FROM myneuser u
										) u
								WHERE u.user_id = r.from_id
									AND r.to_id = user_id_
									AND r.type = 'PUPIL'
								) u
							CROSS JOIN lateral PUBLIC.findmynegalaxy(u.user_id) AS count limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
							) u
							,myneresourceinformation m
						WHERE replace(m.mri, 'mri::', '') = u.user_id
						) u
					LEFT JOIN ownerresources o ON u.mri_id = o.OWNER
						AND o.type = 'USER_PROFILE_IMAGE'
					) pi
				LEFT JOIN myneresourceinformation m ON pi.id = m.id
				) o
			LEFT JOIN s3file s ON o.s3_id = s.id
			GROUP BY o.user_id
				,o.
			ORDER
			) o
	WHERE o.user_id = u.id
	ORDER BY o.
	ORDER ASC
	) u;
	
	end IF ;
  
 
--loop
		--RETURN NEXT resource_t;
	
   --END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.listresourcesbytype(resource_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

 	
select uuid_generate_v4() as id, resource_type as type, row_to_json(a.*) as data
FROM (
	SELECT (case when a.owner_id = 'DON''T HAVE' then null else a.owner_id end) as owner_id
		,m.type as owner_type
		,a.data
	FROM (
		SELECT a.owner_id
			,(a.data_owner || jsonb_build_object('data', array_agg(a.data_slave))) AS data
		FROM (
			SELECT a.owner_id
				,(jsonb_build_object('type', coalesce(a.type, 'NULL')) || jsonb(a.data)) AS data_owner
				,f.data AS data_slave
			FROM (
				SELECT f.OWNER AS owner_id
					,m.type
					,f.data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				where m.type = resource_type
				) a
			LEFT JOIN (
				SELECT f.OWNER
					,(jsonb_build_object('type', coalesce(f.type, 'NULL')) || jsonb(f.data)) AS data
				FROM PUBLIC.myneresourceinformation m
				CROSS JOIN lateral findresourcedata(m.mri) AS f
				) f ON f.OWNER = cast(a.data ->> 'id' AS VARCHAR)
			) a
		GROUP BY a.owner_id
			,a.data_owner
		) a
	LEFT JOIN PUBLIC.myneresourceinformation m ON m.mri = CONCAT (
			'mri::'
			,a.owner_id
			)
	limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
	) a
	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.myneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select f.id, f.type, f.data from  public.findmyneglobalfeed( itens_by_page, page) f

	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.myneresearch(research character varying, research_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN


IF research_type = 'POST' then
	RETURN query
	

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as "type",
r.research_data from global.research r 
where ((r.ts_vector @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | '))))
or (similarity(r.tag, research)>0.3))
and r."type" = 'POST' and  now() > r.releasedate 
order by similarity(r.tag, research) desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5);



elsif research_type = 'PRODUCT' then
	RETURN query
	
select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as "type",
r.research_data from global.research r 
where ((r.ts_vector @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | '))))
or (similarity(r.tag, research)>0.1))
and r."type" = 'PRODUCT' and  now() > r.releasedate 
order by similarity(r.tag, research) desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5);




elsif research_type = 'USER' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as "type",
r.research_data from global.research r 
where ((r.ts_vector @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | '))))
or (similarity(r.tag, research)>0.3))
and r."type" = 'USER' and  now() > r.releasedate 
order by similarity(r.tag, research) desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5);


elsif research_type = 'NULO' then

RETURN query


select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as "type",
r.research_data from global.research r 
where ((r.ts_vector @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | '))))
or (similarity(r.tag, research)>0.3)) and  now() > r.releasedate 
order by similarity(r.tag, research) desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5);

end IF ;
  
 

  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.myneresearchfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in
 select
	*
from
	(
	select
		cast(uuid_generate_v4() as varchar) as id,
		cast('RESEARCH' as varchar) as type,
		to_json(r.data) as data
	from
		(
		select
			jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
		from
			(
			select
				r.owner,
				array_agg(ro.data),
				r.data_post,
				r.data as data_slave
			from
				(
				select
					r.owner,
					r.data_post,
					jsonb_build_object('nested', array_agg(r.data_slave)) as data
				from
					(
					select
						rd.owner,
						jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
						jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave
					from
						(
						select
							replace(m.mri, 'mri::', '') as resource_id
						from
							myneresourceinformation m
						where
							m.type = 'POST'
						order by
							random()
						limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
					cross join lateral findresourcedata(m.resource_id) as rd
					cross join lateral findresourcebyowner(m.resource_id) as ro) r
				group by
					r.owner,
					r.data_post) r
			left join lateral findresourcebyowner(r.owner) ro on
				true
			where
				ro.type = 'PROFILE_IMAGE'
				or ro.type isnull
			group by
				r.owner,
				r.data_post,
				r.data) r
		cross join lateral findresourcedata(r.owner) as ro) r
	group by
		r.data
union all
	select
		cast(uuid_generate_v4() as varchar) as id,
		cast('RESEARCH' as varchar) as type,
		to_json(r.data) as data
	from
		(
		select
			jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data
		from
			(
			select
				replace(m.mri, 'mri::', '') as resource_id
			from
				myneresourceinformation m
			where
				m.type = 'USER'
			order by
				random()
			limit coalesce(
ceil( 
itens_by_page *
(cast( (select count(*) from myneresourceinformation m where m."type" = 'USER') as float)/
cast( (select count(*) from myneresourceinformation m where m."type" = 'POST') as float)))
, 5)
offset coalesce(page, 0) * coalesce(
ceil( 
itens_by_page *
(cast( (select count(*) from myneresourceinformation m where m."type" = 'USER') as float)/
cast( (select count(*) from myneresourceinformation m where m."type" = 'POST') as float)))
, 5)
) m
		cross join lateral findresourcedata(m.resource_id) as rd
		left join lateral findresourcebyowner(m.resource_id) ro on
			true
		where
			ro.type isnull
			or ro.type = 'PROFILE_IMAGE'
) r
	group by
		r.data
) r
order by
	random()


loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.password_recovery(user_email character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in


select cast(uuid_generate_v4() as varchar) as id, 'PASSWORD' as type, to_json(jsonb_build_object('password',
(case when u.password = 'PROVIDED BY OAUTH'
then 'Your password could not be recovered.' else u.password end)) || jsonb_build_object('name', u.name))
as "data"
FROM myneuser u WHERE u.email = user_email

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.product_page(product_id character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   declare
      resource_t public.mynejsontype%ROWTYPE;

begin

 	for resource_t in	
 	
select cast(uuid_generate_v4() as varchar) as id, cast('PRODUCT' as varchar) as  "type", 
	p.product_data || 
jsonb_build_object('user', jsonb_build_object('user', p.user_data) || jsonb_build_object('profile_image', p.profile_image)) ||
jsonb_build_object('nested', array_agg(p.module_data)) as "data"
from
	(
	select
		p.product_data,
		p.product_slave,
		p.user_data,
		p.profile_image,
		(case
			when cast(p.module_file as varchar) = '{"nested": [null]}' then p.product_slave
			else p.product_slave || p.module_file
		end) as module_data
	from
		(
		select
			p.product_data,
			p.product_slave,
			p.user_data,
			p.profile_image,
			jsonb_build_object('nested' , array_agg(p.module_file)) as module_file
		from
			(
			select
				replace(m.mri, 'mri::', ''),
				jsonb_build_object('type', p.type) || jsonb(p.data) as product_data,
				jsonb_build_object('type', pr.type) || jsonb(pr.data) as product_slave ,
				jsonb_build_object('type', o.type) || jsonb(o.data) as user_data,
				jsonb_build_object('type', ot.type) || jsonb(ot.data) as profile_image,
				(case
					when ms.data isnull then null
					else jsonb_build_object('type', ms.type) || jsonb(ms.data)
				end) as module_file
			from
				myneresourceinformation m
			left join lateral findresourcedata(replace(m.mri, 'mri::', '')) as p on
				true
			left join lateral findresourcebyowner(replace(m.mri, 'mri::', '')) as pr on
				true
			left join lateral findresourcedata(p.owner) as o on
				true
			left join lateral findresourcebyownerandtype(p.owner,
				'PROFILE_IMAGE') as ot on
				true
			left join lateral findresourcebyowner(cast(pr.data ->> 'id' as varchar)) as ms on
				true
			where
				m.type = 'PRODUCT'
				and o.type = 'USER'
				and replace(m.mri, 'mri::', '') = product_id ) p
		group by
			p.product_data,
			p.product_slave,
			p.user_data,
			p.profile_image) p) p
group by
	p.product_data,
	p.user_data,
	p.profile_image
	
	loop
		return next resource_t;
end loop;

return;
end;

$function$
;

CREATE OR REPLACE FUNCTION public.profile_image_update()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

delete from s3file where id in
(select b.s3_id from 
(
select m.id as id_f, min(cast(f.data ->> 'createDate' AS timestamp)) as "date_f" from myneuser m
left join lateral findresourcebyownerandtype(m.id, 'PROFILE_IMAGE') as f on true
where f.data notnull
group by m.id
having count(m.id)>1
) a,
(
select m.id, cast(f.data ->> 'id' AS VARCHAR) as s3_id, cast(f.data ->> 'createDate' AS timestamp) as "date" from myneuser m
left join lateral findresourcebyownerandtype(m.id, 'PROFILE_IMAGE') as f on true
where f.data notnull
) b
where a.id_f = b.id and a.date_f = b.date);

delete from ownerresources where slave in
(select m.id from myneresourceinformation m,
(select replace(m.mri, 'mri::', '') as id from myneresourceinformation m where m."type" = 'PROFILE_IMAGE'
except
select s.id from s3file s) s
where s.id = replace(m.mri, 'mri::', ''));

delete from myneresourceinformation where id in
(select m.id from myneresourceinformation m,
(select replace(m.mri, 'mri::', '') as id from myneresourceinformation m where m."type" = 'PROFILE_IMAGE'
except
select s.id from s3file s) s
where s.id = replace(m.mri, 'mri::', ''));



RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.refresh_mat_view_global_feed()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN
	drop materialized view public.globalfeed;
	
    create materialized view public.globalfeed as
(SELECT cast(uuid_generate_v4() AS VARCHAR) AS id, f.viewbyday, cast(f.post_data ->> 'id' AS VARCHAR) as post_id
	,'POST' AS type
	,jsonb_build_object('user', f.user_data || jsonb_build_object('profile_image', p.data)) || f.post_data AS data
FROM (
	SELECT f.viewbyday, f.user_id
		,jsonb_build_object('user', f.user_data) AS user_data
		,f.post_data || jsonb_build_object('nested', array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) AS post_data
	FROM (
		SELECT a.accountability_id, (a.views) / (case when (DATE_PART('day', now() - cast(f.data ->> 'createDate' AS timestamp with time zone))) = 0 then 1 else
		(DATE_PART('day', now() - cast(f.data ->> 'createDate' AS timestamp with time zone))) end) as viewbyday
			,f.OWNER AS user_id
			,to_jsonb(u.data) AS user_data
			,jsonb_build_object('type', f.type) || to_jsonb(f.data) AS post_data
		FROM (
			SELECT a.id AS accountability_id, a.views 
			FROM accountability a
			ORDER BY "views" DESC
				,id desc --limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
			) a
		LEFT JOIN lateral findownerdata(a.accountability_id) f ON true
		LEFT JOIN lateral findresourcedata(f.OWNER) u ON true
		where f.type = 'POST') f
	LEFT JOIN lateral findresourcebyowner(cast(f.post_data ->> 'id' AS VARCHAR)) p ON true
	WHERE f.user_id notnull
		AND f.user_id != 'DON''T HAVE'
	GROUP BY f.user_id, f.viewbyday
		,f.post_data
		,f.user_data
	) f
LEFT JOIN lateral findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE') p ON true
order by f.viewbyday desc);
   
   
RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.relationchangepurchase()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


insert into userrelation(id, "type" , from_id, to_id, createdate)
select uuid_generate_v4(), p.relationtype, p.fromid, p.toid, now() from
(
(select 'PUPIL' as relationtype, p.user_purchase as fromid,  p.user_product as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and
pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u where u."type" = 'PUPIL')
union all
(select 'MENTOR' as relationtype,  p.user_product as fromid, p.user_purchase as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and
pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u where u."type" = 'MENTOR')
union all 
(select 'FOLLOWER' as relationtype, p.user_purchase as fromid,  p.user_product as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and
pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u where u."type" = 'FOLLOWER')
) p;

insert into relationrequest (id, "type" , from_id, to_id, requestdate, status)
select uuid_generate_v4(), p.relationtype, p.fromid, p.toid, now(), 'ACCEPTED' from
(
(select 'PUPIL' as relationtype, p.user_purchase as fromid,  p.user_product as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and
pr.relationchange = true) p
except
select r."type", r.from_id , r.to_id from relationrequest r where r.status = 'ACCEPTED' and r."type" = 'PUPIL')
union all
(select 'MENTOR' as relationtype,  p.user_product as fromid, p.user_purchase as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and pr.relationchange = true) p
except
select r."type", r.from_id , r.to_id from relationrequest r
where r.status = 'ACCEPTED' and r."type" = 'MENTOR')
union all 
(select 'FOLLOWER' as relationtype, p.user_purchase as fromid,  p.user_product as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and
pr.relationchange = true) p
except
select r."type", r.from_id , r.to_id from relationrequest r where r."type" = 'FOLLOWER' and r.status = 'ACCEPTED')
) p;


delete from relationrequest r where r.id in
(select r.id from relationrequest r,
(select r."type", r.from_id, r.to_id, min(r.requestdate), r.status from relationrequest r ,
(select r.to_id, r.from_id , r."type", r.status , count(r.id) from relationrequest r
where r.status != 'DELETED'
group by r.to_id, r.from_id , r."type", r.status
having count(r.id) > 1) rc
where rc.to_id = r.to_id and rc.from_id = r.from_id and rc.type = r.type and rc.status = r.status
group by r."type", r.from_id, r.to_id,  r.status) rc
where rc.type = r."type" and rc.from_id = r.from_id and rc.to_id = r.to_id and rc.min = r.requestdate and rc.status = r.status );

RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.removerelations(fromuser character varying, touser character varying, type_ character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

SELECT (
		CASE 
			WHEN (
					SELECT r.id
					FROM relationrequest r
					WHERE r.from_id = fromuser
						AND r.to_id = touser
						AND r.type = type_
						AND r.status = 'ACCEPTED' limit 1
					) notnull
				THEN 'DELETED'
			WHEN (
					SELECT r.id
					FROM relationrequest r
					WHERE r.from_id = fromuser
						AND r.to_id = touser
						AND r.type = type_
						AND r.status = 'DELETED' limit 1
					) notnull
				THEN 'ALREADY_DELETED'
			ELSE 'RELATION_NOT_FOUND'
			END
		)
into retorno;

UPDATE relationrequest
SET status = 'DELETED'
WHERE id = (
		SELECT r.id
		FROM relationrequest r
		WHERE r.from_id = fromuser
			AND r.to_id = touser
			AND r.type = type_
			AND r.status = 'ACCEPTED' limit 1
		);
	
UPDATE relationrequest
SET status = 'DELETED'
WHERE id = (
		SELECT r.id
		FROM relationrequest r
		WHERE r.from_id = (case when type_ = 'PARTNER' then touser else null end)
			AND r.to_id = (case when type_ = 'PARTNER' then fromuser else null end)
			AND r.type = type_
			AND r.status = 'ACCEPTED' limit 1
		);

DELETE
FROM userrelation
WHERE id = (
		SELECT u.id
		FROM relationrequest r
			,userrelation u
		WHERE u.from_id = r.from_id
			AND u.to_id = r.to_id
			AND u.type = r.type
			AND r.from_id = fromuser
			AND r.to_id = touser
			AND r.type = type_
			AND r.status = 'DELETED' limit 1
		);
	

DELETE
FROM userrelation
WHERE id = (
		SELECT u.id
		FROM relationrequest r
			,userrelation u
		WHERE u.from_id = r.from_id
			AND u.to_id = r.to_id
			AND u.type = r.type
			AND r.from_id = (case when type_ = 'PARTNER' then touser else null end)
			AND r.to_id = (case when type_ = 'PARTNER' then fromuser else null end)
			AND r.type = type_
			AND r.status = 'DELETED' limit 1
		);

RETURN retorno;


end;
$function$
;

CREATE OR REPLACE FUNCTION public.requestrelation(user_request character varying, user_to_follow character varying, relation_type character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

SELECT (
		CASE 
			WHEN (
					SELECT u.id
					FROM PUBLIC.userrelation u
					WHERE u.from_id = user_request
						AND u.to_id = user_to_follow
						AND u.type = relation_type
					) isnull
				THEN (
						CASE 
							WHEN (
									SELECT u.id
									FROM PUBLIC.relationrequest u
									WHERE u.from_id = user_request
										AND u.to_id = user_to_follow
										AND u.type = relation_type
										AND u.status = 'REQUESTED'
									) isnull
								THEN (
										CASE 
											WHEN (
													SELECT m.id
													FROM PUBLIC.myneuser m
													WHERE m.visibility = 'PUBLIC'
														AND m.id = user_to_follow
														AND user_to_follow != user_request
														AND relation_type = 'FOLLOWER'
													) notnull
												THEN 'ACCEPTED'
											ELSE 'REQUESTED'
											END
										)
							ELSE 'ALREADY_REQUESTED'
							END
						)
			ELSE 'ALREADY_RELATED'
			END
		)
into retorno;

INSERT into PUBLIC.userrelation
SELECT *
FROM (
	SELECT uuid_generate_v4()
		,'FOLLOWER' AS relation
		,user_request AS
	"from"
		,r.id AS to
		,now() AS DATE
	FROM (
		SELECT (
				CASE 
					WHEN (
							SELECT u.id
							FROM PUBLIC.userrelation u
							WHERE u.from_id = user_request
								AND u.to_id = user_to_follow
								AND u.type = relation_type
							) isnull
						THEN (
								CASE 
									WHEN (
											SELECT u.id
											FROM PUBLIC.relationrequest u
											WHERE u.from_id = user_request
												AND u.to_id = user_to_follow
												AND u.type = relation_type
												AND u.status = 'REQUESTED'
											) isnull
										THEN (
												CASE 
													WHEN (
															SELECT m.id
															FROM PUBLIC.myneuser m
															WHERE m.visibility = 'PUBLIC'
																AND m.id = user_to_follow
																AND user_to_follow != user_request
																--AND relation_type = 'FOLLOWER'
															) notnull
														THEN (
																case when (select u.id from userrelation u where u.from_id = user_request
																and u.to_id = user_to_follow and u.type = 'FOLLOWER' limit 1) isnull 
																then (select user_to_follow) else null end
																)
													ELSE NULL
													END
												)
									ELSE NULL
									END
								)
					ELSE NULL
					END
				) AS id
		) r
	) r
WHERE r.to notnull;

INSERT into PUBLIC.relationrequest
SELECT *
FROM (
	SELECT uuid_generate_v4()
		,relation_type AS relation
		,user_request AS
	FROM
		,r.id AS to
		,now() AS DATE
		,'REQUESTED' AS stat
	FROM (
		SELECT (
				CASE 
					WHEN (
							SELECT u.id
							FROM PUBLIC.userrelation u
							WHERE u.from_id = user_request
								AND u.to_id = user_to_follow
								AND u.type = relation_type
							) isnull
						THEN (
								CASE 
									WHEN (
											SELECT u.id
											FROM PUBLIC.relationrequest u
											WHERE u.from_id = user_request
												AND u.to_id = user_to_follow
												AND u.type = relation_type
												AND u.status = 'REQUESTED'
											) isnull
										THEN (
												CASE 
													WHEN (
															SELECT m.id
															FROM PUBLIC.myneuser m
															WHERE (
																	m.visibility = 'PRIVATE'
																	OR relation_type != 'FOLLOWER'
																	)
																AND m.id = user_to_follow
																AND user_to_follow != user_request
															) notnull
														THEN (
																SELECT user_to_follow
																)
													ELSE NULL
													END
												)
									ELSE NULL
									END
								)
					ELSE NULL
					END
				) AS id
		) r
	) r
WHERE r.to notnull;

INSERT into PUBLIC.relationrequest
SELECT r.*
FROM (
	SELECT uuid_generate_v4()
		,r.*
		,u.createdate
		,'ACCEPTED' AS status
	FROM (
		SELECT u.type
			,u.from_id
			,u.to_id
		FROM userrelation u
		
		EXCEPT
		
		SELECT r.type
			,r.from_id
			,r.to_id
		FROM relationrequest r
		) r
	LEFT JOIN userrelation u ON r.type = u.type
		AND r.from_id = u.from_id
		AND r.to_id = u.to_id
	) r;

RETURN retorno;

end;
$function$
;

CREATE OR REPLACE FUNCTION public.responserelationrequest(requestid character varying, status_ character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   retorno varchar;
 -- id_trans varchar;
begin

SELECT (
		CASE 
			WHEN (
					SELECT r.STATUS
					FROM relationrequest r
					WHERE r.id = requestid
					) != 'REQUESTED'
				THEN 'ALREADY_RESPONDED'
			ELSE (
					CASE 
						WHEN status_ = 'ACCEPTED'
							THEN 'ACCEPTED'
						ELSE 'DENIED'
						END
					)
			END
		)
into retorno;

UPDATE relationrequest
SET status = (select 
(case when (select r.status from relationrequest r where r.id = requestid) = 'DENIED' then 'DENIED'
when (select r.status from relationrequest r where r.id = requestid) = 'ACCEPTED' then 'ACCEPTED' 
else  status_ end))
WHERE id = requestid;

INSERT into userrelation
SELECT *
FROM (
	SELECT uuid_generate_v4()
		,r.type
		,r.from_id
		,r.to_id
		,now()
	FROM (
		SELECT (
				CASE 
					WHEN (
							SELECT u.id
							FROM userrelation u
								,(
									SELECT r.from_id
										,r.status 
										,r.to_id
										,r.type
									FROM relationrequest r
									WHERE r.id = requestid
										AND r.status = 'ACCEPTED'
									) r
							WHERE u.from_id = r.from_id
								AND u.to_id = r.to_id
								AND u.type = r.type
							) isnull
						THEN (case when (
									SELECT r.id
									FROM relationrequest r
									WHERE r.id = requestid
										AND r.status = 'DENIED'
									) ISNULL 
									then requestid 
						else NULL end )
					ELSE NULL
					END
				) AS id
		) i
		,relationrequest r
	WHERE r.id = i.id
	) r;

INSERT into userrelation
SELECT *
FROM (
	SELECT uuid_generate_v4()
		,'FOLLOWER'
		,r.from_id
		,r.to_id
		,now()
	FROM (
		SELECT (
				CASE 
					WHEN (
							SELECT u.id
							FROM userrelation u
								,(
									SELECT r.from_id
										,r.status
										,r.to_id
										,r.type
									FROM relationrequest r
									WHERE r.id = requestid
										AND r.status = 'ACCEPTED'
										AND (r.type = 'PARTNER' or r.type = 'PUPIL' or r.type = 'MENTOR')
									) r
							WHERE u.from_id = r.from_id
								AND u.to_id = r.to_id
								AND u.type = 'FOLLOWER'
							) isnull
						THEN (case when (
									SELECT r.id
									FROM relationrequest r
									WHERE r.id = requestid
										AND r.status = 'DENIED'
									) ISNULL 
									then requestid 
						else NULL end 
								)
					ELSE NULL
					END
				) AS id
		) i
		,relationrequest r
	WHERE r.id = i.id
	) r;

RETURN retorno;

end;
$function$
;

CREATE OR REPLACE FUNCTION public.savedfromuserbytype(userid character varying, resourcetype character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN


IF resourcetype = 'POST' then
	RETURN query
	

select cast(uuid_generate_v4() as varchar) as id, 
cast('POST' as varchar) as type, r.research_data as data from
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = userid and s.resourcetype = 'POST'
order by s.savedate desc, s.resourceid asc
limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)) s
left join global.research r on r.id = s.resourceid;



elsif resourcetype = 'PRODUCT' then
	RETURN query
	
select cast(uuid_generate_v4() as varchar) as id, 
cast('PRODUCT' as varchar) as type, r.research_data as data from
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = userid and s.resourcetype = 'PRODUCT'
order by s.savedate desc, s.resourceid asc
limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)) s
left join global.research r on r.id = s.resourceid;




elsif resourcetype = 'INSIGHT' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id, 
cast('INSIGHT' as varchar) as type, cast(i.user_data || jsonb_build_object('insight', i.insight_data) as json) as data from
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = userid and s.resourcetype = 'INSIGHT'
order by s.savedate desc, s.resourceid asc
limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)) s
left join global.insights i on i.insight_id = s.resourceid ;

end IF ;
  
  	
   RETURN;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.set_limit(real)
 RETURNS real
 LANGUAGE c
 STRICT
AS '$libdir/pg_trgm', $function$set_limit$function$
;

CREATE OR REPLACE FUNCTION public.show_limit()
 RETURNS real
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$show_limit$function$
;

CREATE OR REPLACE FUNCTION public.show_trgm(text)
 RETURNS text[]
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$show_trgm$function$
;

CREATE OR REPLACE FUNCTION public.similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity$function$
;

CREATE OR REPLACE FUNCTION public.similarity_dist(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity_dist$function$
;

CREATE OR REPLACE FUNCTION public.similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity_op$function$
;

CREATE OR REPLACE FUNCTION public.slugcolumn(tbl_name character varying, clmn_name character varying)
 RETURNS TABLE(slug json)
 LANGUAGE plpgsql
AS $function$
BEGIN
RETURN QUERY 

EXECUTE format('select row_to_json(s) as slug from (select id, slugify(%s) as slug from %I) s',clmn_name,tbl_name);

 END;
$function$
;

CREATE OR REPLACE FUNCTION public.slugify(value text)
 RETURNS text
 LANGUAGE sql
 IMMUTABLE STRICT
AS $function$
  -- removes accents (diacritic signs) from a given string --
  WITH "unaccented" AS (
    SELECT unaccent("value") AS "value"
  ),
  -- lowercases the string
  "lowercase" AS (
    SELECT lower("value") AS "value"
    FROM "unaccented"
  ),
  -- remove single and double quotes
  "removed_quotes" AS (
    SELECT regexp_replace("value", '[''"]+', '', 'gi') AS "value"
    FROM "lowercase"
  ),
  -- replaces anything that's not a letter, number, hyphen('-'), or underscore('_') with a hyphen('-')
  "hyphenated" AS (
    SELECT regexp_replace("value", '[^a-z0-9\\-_]+', '-', 'gi') AS "value"
    FROM "removed_quotes"
  ),
  -- trims hyphens('-') if they exist on the head or tail of the string
  "trimmed" AS (
    SELECT regexp_replace(regexp_replace("value", '\-+$', ''), '^\-', '') AS "value"
    FROM "hyphenated"
  )
  SELECT "value" FROM "trimmed";
$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_commutator_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_commutator_op$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_dist_commutator_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_dist_commutator_op$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_dist_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_dist_op$function$
;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_op$function$
;

CREATE OR REPLACE FUNCTION public.tagpostinsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


insert into tag(tag, tag_tsv) select a.tag1, a.to_tsvector from
(select p.title  as tag1 , to_tsvector('portuguese', unaccent(p.title))
from myneresourceinformation m, post p
where replace(m.mri, 'mri::', '') = p.id
except
select t.tag, t.tag_tsv from tag t) a;

insert into resourcetag(resource, tag) select a.id, a.tag_id from
(select m.id, t.id as tag_id 
from myneresourceinformation m, post p, tag t 
where replace(m.mri, 'mri::', '') = p.id and p.title = t.tag
except
select r.resource, r.tag from resourcetag r) a;

insert into "global".research(id, createdate, type, tag, ts_vector, releasedate, owner, research_data)
select u.id, u.createdate, u.type, u.tag, u.ts_vector, u.releasedate, u.owner, u.data
from
(select cast(r.data ->> 'id' as varchar) as id,  cast(r.data ->> 'createDate' as timestamp with time zone) as createdate,
cast('POST' as varchar) as type, concat(cast(r.data ->> 'title' as varchar)) as tag,
to_tsvector(cast(r.data ->> 'title' as varchar)) as ts_vector, cast(r.data ->> 'releaseDate' as timestamp with time zone) as releasedate,
f.owner,
to_json( r.data) as data  from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri, 'mri::', '') as resource_id from myneresourceinformation m where m.type = 'POST' and 
replace(m.mri, 'mri::', '') not in 
('30dc34ec-c049-4533-9ddc-4382220529a3',
'ed02ac7b-7fd3-4aba-8557-5240e95bc538',
'3a3b3ed7-63c8-4b5b-a7c2-80039e1005cc')
except
select r.id from global.research r where r.type = 'POST') m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyownerandtype(r.owner, 'PROFILE_IMAGE') ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r
left join findresourcedata(cast(r.data ->> 'id' as varchar)) as f on true
left join myneresourceinformation m on f.owner = replace(m.mri, 'mri::', '')
where m.type = 'USER' ) u;


RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.tagproductinsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


insert into tag(tag, tag_tsv) select a.tag1, a.to_tsvector from
(select concat(p.name,' ', p.producttype)  as tag1 , to_tsvector('portuguese', unaccent(concat(p.name,' ', p.producttype)))
from myneresourceinformation m, product p
where replace(m.mri, 'mri::', '') = p.id
except
select t.tag, t.tag_tsv from tag t) a;

insert into resourcetag(resource, tag) select a.id, a.tag_id from
(select m.id, t.id as tag_id 
from myneresourceinformation m, product p, tag t 
where replace(m.mri, 'mri::', '') = p.id and concat(p.name,' ', p.producttype) = t.tag
except
select r.resource, r.tag from resourcetag r) a;


insert into "global".research(id, createdate, type, tag, ts_vector, releasedate, owner, research_data)
select u.id, u.createdate, u.type, u.tag, u.ts_vector, u.releasedate, u.owner, u.data
from
(select cast(r.data ->> 'id' as varchar) as id,  cast(r.data ->> 'createDate' as timestamp with time zone) as createdate,
'PRODUCT' as "type", concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'productType' as varchar)) as tag,
to_tsvector(concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'productType' as varchar))) as ts_vector,
cast(r.data ->> 'releaseDate' as timestamp with time zone) as releasedate, f.owner,
to_json( r.data) as data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri, 'mri::', '') as resource_id from myneresourceinformation m where m.type = 'PRODUCT'
and replace(m.mri, 'mri::', '') not in ('58df74af-f105-489b-9ae0-3479c909ed80')
except
select r.id from global.research r where r.type = 'PRODUCT') m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r
left join findresourcedata(cast(r.data ->> 'id' as varchar)) as f on true
left join myneresourceinformation m on f.owner = replace(m.mri, 'mri::', '')
where m.type = 'USER' ) u;


RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.taguserinsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


insert into tag(tag, tag_tsv) select a.tag1, a.to_tsvector from
(select concat(u.accountname,' ', u."name")  as tag1 , to_tsvector('portuguese', unaccent(concat(u.accountname,' ', u."name")))
from myneresourceinformation m, myneuser u
where replace(m.mri, 'mri::', '') = u.id
except
select t.tag, t.tag_tsv from tag t) a;

insert into resourcetag(resource, tag) select a.id, a.tag_id from
(select m.id, t.id as tag_id 
from myneresourceinformation m, myneuser u, tag t 
where replace(m.mri, 'mri::', '') = u.id and concat(u.accountname,' ', u."name") = t.tag
except
select r.resource, r.tag from resourcetag r) a;

insert into "global".research(id, createdate, type, tag, ts_vector, releasedate, owner, research_data)
select u.id, u.createdate, u.type, u.tag, u.ts_vector, u.releasedate, u.owner, u.data
from
(
select cast(r.data ->> 'id' as varchar) as id,  cast(r.data ->> 'createDate' as timestamp with time zone) as createdate,
 cast('USER' as varchar) as type, concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'accountName' as varchar)) as tag,
to_tsvector(concat(cast(r.data ->> 'name' as varchar), ' ', cast(r.data ->> 'accountName' as varchar))) as ts_vector,
now() as releasedate, '' as owner,
to_json(r.data) as data from
(select jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri, 'mri::', '') as resource_id from myneresourceinformation m where m.type = 'USER'
and replace(m.mri, 'mri::', '') not in 
('6d5cb104-36a0-4f50-b8fb-0d8b905a78b3',
'c74f1e72-e674-4f44-ba37-d625c8d49e0f',
'7c875a39-66fd-434f-ac8c-6fe0c32669f7',
'7a217f2b-7fcd-46b0-91e7-aa88c4b36f1c',
'daf0efb2-c29a-4b10-a756-87343477f5bf')
except
select r.id from global.research r where r.type = 'USER') m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE') r 
) u;

RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.test_pg_sleep(integer, integer)
 RETURNS void
 LANGUAGE plpgsql
 STRICT
AS $function$
DECLARE
    loops ALIAS FOR $1;
    delay ALIAS FOR $2;
BEGIN
    FOR i IN 1..loops loop
    loops = (loops+1);
	RAISE INFO 'Current timestamp: %', timeofday()::TIMESTAMP;
	RAISE INFO 'Sleep % seconds', delay;
	PERFORM pg_sleep(delay);
    END LOOP;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.testecoluna(coluna character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   generico_ean varchar;
begin
	
	select (select concat('myneresourceinformation.', coluna) ) from myneresourceinformation
	limit 1
into generico_ean;
   
   return generico_ean;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.unaccent(text)
 RETURNS text
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

CREATE OR REPLACE FUNCTION public.unaccent(regdictionary, text)
 RETURNS text
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

CREATE OR REPLACE FUNCTION public.unaccent_init(internal)
 RETURNS internal
 LANGUAGE c
 PARALLEL SAFE
AS '$libdir/unaccent', $function$unaccent_init$function$
;

CREATE OR REPLACE FUNCTION public.unaccent_lexize(internal, internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 PARALLEL SAFE
AS '$libdir/unaccent', $function$unaccent_lexize$function$
;

CREATE OR REPLACE FUNCTION public.update_views()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN



UPDATE
    accountability 
SET
    views = (positives + negatives)
FROM
    (select a.id as id_1, a.positives as positives_1, a.negatives as negatives_1,
    a.views as views_1 
    from accountability a where a.views != (a.positives + a.negatives)) a
WHERE
    id = a.id_1;



RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.user_notification(user_id character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   declare
      resource_t public.mynejsontype%ROWTYPE;

begin

 	for resource_t in	



select cast(uuid_generate_v4() as varchar) as id, cast('NOTIFICATION' as varchar) as "type", 
row_to_json(m.*) as data from messagenotification m 
where m.receiverid = user_id and (DATE_PART('day', now() - m.delivereddatetime) < 7)
order by m.delivereddatetime desc

loop
		return next resource_t;
end loop;

return;
end;

$function$
;

CREATE OR REPLACE FUNCTION public.user_slug()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN



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



RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.userrelationajust()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

begin
	

insert into userrelation select ur.id, ur.type, ur.from_id, ur.to_id
from
(select uuid_generate_v4() as id, 'MENTOR' as type, p.to_id as from_id, p.from_id as to_id from  
(select u.to_id, u.from_id from userrelation u where u.type = 'PUPIL') p
left join 
(select u.from_id, u.to_id from userrelation u where u.type = 'MENTOR') m
on m.to_id = p.from_id and m.from_id = p.to_id
where m.from_id isnull and m.to_id isnull) ur;


insert into userrelation select ur.id, ur.type, ur.from_id, ur.to_id
from
(select uuid_generate_v4() as id, 'PUPIL' as type, m.to_id as from_id, m.from_id as to_id from  
(select u.from_id, u.to_id from userrelation u where u.type = 'MENTOR') m
left join
(select u.to_id, u.from_id from userrelation u where u.type = 'PUPIL') p
on m.to_id = p.from_id and m.from_id = p.to_id
where p.from_id isnull and p.to_id isnull) ur;

insert into userrelation select ur.id, ur.type, ur.from_id, ur.to_id
from
(
select uuid_generate_v4() as id, 'PARTNER' as type, a.to_id as from_id, a.from_id as to_id from 
(select u.from_id, u.to_id from userrelation u where u."type" = 'PARTNER') a
left join 
(select u.to_id, u.from_id from userrelation u where u."type" = 'PARTNER') b
on a.from_id = b.to_id and a.to_id = b.from_id
where b.to_id isnull and b.from_id isnull ) ur;


insert into userrelation select ur.id, ur.type, ur.from_id, ur.to_id
from
(
select uuid_generate_v4() as id, 'PARTNER' as type, b.to_id as from_id, b.from_id as to_id from 
(select u.to_id, u.from_id  from userrelation u where u."type" = 'PARTNER') b
left join 
(select u.from_id, u.to_id from userrelation u where u."type" = 'PARTNER') a
on a.from_id = b.to_id and a.to_id = b.from_id
where b.to_id isnull and b.from_id isnull ) ur;


insert into relationrequest select uuid_generate_v4(), r.*, now(), 'ACCEPTED'
from
(
(select u.type, u.from_id, u.to_id from userrelation u)
except
(select r.type, r.from_id, r.to_id from relationrequest r where r.status = 'ACCEPTED')
) r;

delete from userrelation where id in
(select u.id from userrelation u,
(select u."type", u.from_id, u.to_id, min(u.createdate) from userrelation u,
(select u."type", u.from_id, u.to_id, count(u.id) from userrelation u
group by u."type", u.from_id, u.to_id
having count(u.id) > 1) ur
where ur."type" = u."type" and ur.from_id = u.from_id and ur.to_id = u.to_id
group by u."type", u.from_id, u.to_id) ur
where ur.type = u.type and ur.from_id = u.from_id and ur.to_id = u.to_id and ur.min = u.createdate);

insert into userrelation select uuid_generate_v4(), u.type, u.from_id, u.to_id , now() from
(select 'FOLLOWER' as type, u.from_id, u.to_id  from userrelation u where u."type" = 'PARTNER' or u."type" = 'PUPIL'
except 
select u."type", u.from_id, u.to_id from userrelation u where u."type" = 'FOLLOWER') u;


RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v1()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v1mc()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1mc$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v3(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v3$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v4()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v4$function$
;

CREATE OR REPLACE FUNCTION public.uuid_generate_v5(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v5$function$
;

CREATE OR REPLACE FUNCTION public.uuid_nil()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_nil$function$
;

CREATE OR REPLACE FUNCTION public.uuid_ns_dns()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_dns$function$
;

CREATE OR REPLACE FUNCTION public.uuid_ns_oid()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_oid$function$
;

CREATE OR REPLACE FUNCTION public.uuid_ns_url()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_url$function$
;

CREATE OR REPLACE FUNCTION public.uuid_ns_x500()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_x500$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity_commutator_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_commutator_op$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity_dist_commutator_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_dist_commutator_op$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity_dist_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_dist_op$function$
;

CREATE OR REPLACE FUNCTION public.word_similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_op$function$
;
