-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

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

CREATE TABLE public."_exec" (
	"_" text NULL
);

-- Permissions

ALTER TABLE public."_exec" OWNER TO postgres;
GRANT ALL ON TABLE public."_exec" TO postgres;


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

-- Permissions

ALTER TABLE public.address OWNER TO postgres;
GRANT ALL ON TABLE public.address TO postgres;


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

-- Permissions

ALTER TABLE public.card OWNER TO postgres;
GRANT ALL ON TABLE public.card TO postgres;


-- public.cardview definition

-- Drop table

-- DROP TABLE public.cardview;

CREATE TABLE public.cardview (
	id varchar(36) NOT NULL,
	CONSTRAINT cardview_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.cardview OWNER TO postgres;
GRANT ALL ON TABLE public.cardview TO postgres;


-- public.cmda_exec definition

-- Drop table

-- DROP TABLE public.cmda_exec;

CREATE TABLE public.cmda_exec (
	cmda_output text NULL
);

-- Permissions

ALTER TABLE public.cmda_exec OWNER TO postgres;
GRANT ALL ON TABLE public.cmda_exec TO postgres;


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

-- Permissions

ALTER TABLE public.config OWNER TO postgres;
GRANT ALL ON TABLE public.config TO postgres;


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

-- Permissions

ALTER TABLE public.financialinfo OWNER TO postgres;
GRANT ALL ON TABLE public.financialinfo TO postgres;


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

-- Permissions

ALTER TABLE public."groups" OWNER TO postgres;
GRANT ALL ON TABLE public."groups" TO postgres;


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

-- Permissions

ALTER TABLE public.identificationdocument OWNER TO postgres;
GRANT ALL ON TABLE public.identificationdocument TO postgres;


-- public.insight definition

-- Drop table

-- DROP TABLE public.insight;

CREATE TABLE public.insight (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	active bool NOT NULL DEFAULT true,
	createdate timestamp NOT NULL DEFAULT now(),
	insighttype varchar(255) NULL,
	url varchar(255) NULL,
	CONSTRAINT insight_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.insight OWNER TO postgres;
GRANT ALL ON TABLE public.insight TO postgres;


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

-- Permissions

ALTER TABLE public.launch OWNER TO postgres;
GRANT ALL ON TABLE public.launch TO postgres;


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

-- Permissions

ALTER TABLE public.launchworkflow OWNER TO postgres;
GRANT ALL ON TABLE public.launchworkflow TO postgres;


-- public."like" definition

-- Drop table

-- DROP TABLE public."like";

CREATE TABLE public."like" (
	id varchar(36) NOT NULL,
	createdate timestamp NOT NULL DEFAULT now(),
	"type" varchar(255) NULL,
	CONSTRAINT like_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public."like" OWNER TO postgres;
GRANT ALL ON TABLE public."like" TO postgres;


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

-- Permissions

ALTER TABLE public.mynejsondto OWNER TO postgres;
GRANT ALL ON TABLE public.mynejsondto TO postgres;


-- public.mynerelationjsondto definition

-- Drop table

-- DROP TABLE public.mynerelationjsondto;

CREATE TABLE public.mynerelationjsondto (
	id varchar(255) NOT NULL,
	"data" json NULL,
	"type" varchar(255) NULL,
	CONSTRAINT mynerelationjsondto_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.mynerelationjsondto OWNER TO postgres;
GRANT ALL ON TABLE public.mynerelationjsondto TO postgres;


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
create trigger inserttag after
insert
    on
    public.myneuser for each row execute function taginsert();

-- Permissions

ALTER TABLE public.myneuser OWNER TO postgres;
GRANT ALL ON TABLE public.myneuser TO postgres;


-- public.payment definition

-- Drop table

-- DROP TABLE public.payment;

CREATE TABLE public.payment (
	id varchar(36) NOT NULL,
	paymenttype varchar(255) NULL,
	value float8 NOT NULL,
	CONSTRAINT payment_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.payment OWNER TO postgres;
GRANT ALL ON TABLE public.payment TO postgres;


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

-- Permissions

ALTER TABLE public.phone OWNER TO postgres;
GRANT ALL ON TABLE public.phone TO postgres;


-- public.postsummary definition

-- Drop table

-- DROP TABLE public.postsummary;

CREATE TABLE public.postsummary (
	id varchar(36) NOT NULL,
	CONSTRAINT postsummary_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.postsummary OWNER TO postgres;
GRANT ALL ON TABLE public.postsummary TO postgres;


-- public.product definition

-- Drop table

-- DROP TABLE public.product;

CREATE TABLE public.product (
	id varchar(36) NOT NULL,
	active bool NOT NULL,
	createdate timestamp NULL,
	description varchar(255) NULL,
	"name" varchar(255) NULL,
	producttype varchar(255) NULL,
	CONSTRAINT product_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.product OWNER TO postgres;
GRANT ALL ON TABLE public.product TO postgres;


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

-- Permissions

ALTER TABLE public.resourcebyownerdto OWNER TO postgres;
GRANT ALL ON TABLE public.resourcebyownerdto TO postgres;


-- public.resourcedto definition

-- Drop table

-- DROP TABLE public.resourcedto;

CREATE TABLE public.resourcedto (
	findresourcedata varchar(255) NOT NULL,
	id varchar(255) NOT NULL,
	"data" varchar(255) NULL,
	CONSTRAINT resourcedto_pkey PRIMARY KEY (findresourcedata)
);

-- Permissions

ALTER TABLE public.resourcedto OWNER TO postgres;
GRANT ALL ON TABLE public.resourcedto TO postgres;


-- public.retorno definition

-- Drop table

-- DROP TABLE public.retorno;

CREATE TABLE public.retorno (
	"case" text NULL
);

-- Permissions

ALTER TABLE public.retorno OWNER TO postgres;
GRANT ALL ON TABLE public.retorno TO postgres;


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
	CONSTRAINT s3file_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.s3file OWNER TO postgres;
GRANT ALL ON TABLE public.s3file TO postgres;


-- public.site definition

-- Drop table

-- DROP TABLE public.site;

CREATE TABLE public.site (
	id varchar(36) NOT NULL,
	url varchar(255) NULL,
	CONSTRAINT site_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.site OWNER TO postgres;
GRANT ALL ON TABLE public.site TO postgres;


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

-- Permissions

ALTER TABLE public.socialnetwork OWNER TO postgres;
GRANT ALL ON TABLE public.socialnetwork TO postgres;


-- public.t_e definition

-- Drop table

-- DROP TABLE public.t_e;

CREATE TABLE public.t_e (
	docs text NULL
);

-- Permissions

ALTER TABLE public.t_e OWNER TO postgres;
GRANT ALL ON TABLE public.t_e TO postgres;


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

-- Permissions

ALTER TABLE public.tag OWNER TO postgres;
GRANT ALL ON TABLE public.tag TO postgres;


-- public.tmp_docs definition

-- Drop table

-- DROP TABLE public.tmp_docs;

CREATE TABLE public.tmp_docs (
	"data" text NULL
);

-- Permissions

ALTER TABLE public.tmp_docs OWNER TO postgres;
GRANT ALL ON TABLE public.tmp_docs TO postgres;


-- public.world1 definition

-- Drop table

-- DROP TABLE public.world1;

CREATE TABLE public.world1 (
	"data" json NULL
);

-- Permissions

ALTER TABLE public.world1 OWNER TO postgres;
GRANT ALL ON TABLE public.world1 TO postgres;


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

-- Permissions

ALTER TABLE public.groupmembers OWNER TO postgres;
GRANT ALL ON TABLE public.groupmembers TO postgres;


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
	CONSTRAINT messagenotification_pkey PRIMARY KEY (id),
	CONSTRAINT fk5liknp4huj0bry2tbf81v47k1 FOREIGN KEY (senderid) REFERENCES public.myneuser(id),
	CONSTRAINT fkbujicj06wbwl43xkwraffia2j FOREIGN KEY (receiverid) REFERENCES public.myneuser(id)
);

-- Permissions

ALTER TABLE public.messagenotification OWNER TO postgres;
GRANT ALL ON TABLE public.messagenotification TO postgres;


-- public.post definition

-- Drop table

-- DROP TABLE public.post;

CREATE TABLE public.post (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	createdate timestamp NOT NULL DEFAULT now(),
	description varchar(255) NULL DEFAULT 'Myne Post DESC'::character varying,
	title varchar(255) NULL DEFAULT 'Myne Post TITLE'::character varying,
	owner_id varchar(36) NULL,
	cancomment bool NOT NULL DEFAULT true,
	CONSTRAINT post_pkey PRIMARY KEY (id),
	CONSTRAINT fksmimo05ej6b8u91r6omk3n85g FOREIGN KEY (owner_id) REFERENCES public.myneuser(id)
);

-- Permissions

ALTER TABLE public.post OWNER TO postgres;
GRANT ALL ON TABLE public.post TO postgres;


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

-- Permissions

ALTER TABLE public.relationrequest OWNER TO postgres;
GRANT ALL ON TABLE public.relationrequest TO postgres;


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

-- Permissions

ALTER TABLE public.userrelation OWNER TO postgres;
GRANT ALL ON TABLE public.userrelation TO postgres;


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

-- Permissions

ALTER TABLE public.myneresourceinformation OWNER TO postgres;
GRANT ALL ON TABLE public.myneresourceinformation TO postgres;


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

-- Permissions

ALTER TABLE public.ownerresources OWNER TO postgres;
GRANT ALL ON TABLE public.ownerresources TO postgres;


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

-- Permissions

ALTER TABLE public.resourcetag OWNER TO postgres;
GRANT ALL ON TABLE public.resourcetag TO postgres;


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

-- Permissions

ALTER TABLE public.accountability OWNER TO postgres;
GRANT ALL ON TABLE public.accountability TO postgres;


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

-- Permissions

ALTER TABLE public."comment" OWNER TO postgres;
GRANT ALL ON TABLE public."comment" TO postgres;



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

-- Permissions

ALTER FUNCTION public.finddata(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.finddata(varchar) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findfeedbyuser(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findfeedbyuser(varchar,int4,int4) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findfeedbyuserdata(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findfeedbyuserdata(varchar,int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.findmynefeed(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

select cast(uuid_generate_v4() as varchar) as  id, (select m.type from public.myneresourceinformation m 
where replace(m.mri , 'mri::', '') = replace(user_id, 'mri::', '')) as type, u.data as data from
(
select u.createdate_post, jsonb_build_object('user', u.user_data) || u.post as data  from 
(
select u.createdate_post, u.user_data, u.post_data || jsonb_build_object('nested', array_agg(u.data))  as post from
(
select  u.createdate_post, jsonb(u.user_data) as user_data, jsonb(u.post_data) as post_data, jsonb_build_object('type', p.type) || jsonb(p.data) as data from
(SELECT row_to_json(u.*) as user_data, jsonb_build_object('type', p.type) || jsonb(p.data) as post_data, cast(p.data ->> 'createDate' AS TIMESTAMP) as createdate_post, cast(p.data ->> 'id' AS varchar) as id_post
FROM (
	select u.id, row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createDate', o."createDate") || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o."fileName") || jsonb_build_object('filetype', o."fileType") || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname as "accountName"
			,u.active
			,u.createdate as "createDate"
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
				,max(s.createdate) AS "createDate"
				,max(s.description) AS description
				,max(s.filename) AS "fileName"
				,max(s.filetype) AS "fileType"
				,max(s.s3url) AS s3url
				,o.user_id
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id
				FROM (
					SELECT u.user_id
						,o.slave AS id
					FROM (
						SELECT u.user_id
							,m.id AS mri_id
						FROM (select distinct(u.user_id) as user_id
from
(
(select u.to_id as user_id 
from public.userrelation u
where u.type ='FOLLOWER'
and u.from_id = user_id)
union all
(select u.from_id as partner
from public.userrelation u
where u.type ='PARTNER'
and u.to_id = user_id)
union all
(select u.from_id as mentor
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = user_id)
union all 
(select user_id)
) u) u
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
			) o
	WHERE o.user_id = u.id
	) u
cross join lateral findresourcebyownerandtype(u.id, 'POST') as p
) u
cross join lateral findresourcebyowner(u.id_post) as p) u
group by u.user_data, u.post_data, u.createdate_post) u
) u
order by createdate_post desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)

	
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmynefeed(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmynefeed(varchar,int4,int4) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findmynegalaxy(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmynegalaxy(varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.findmyneglobalfeed(itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in


select cast(uuid_generate_v4() as varchar) as  id, 'POST' as type, u.data from
(
select jsonb_build_object('user', u.user_data) || u.post as data  from 
(
select u.user_data, u.post_data || jsonb_build_object('nested', array_agg(u.data))  as post from
(
select  jsonb(u.user_data) as user_data, jsonb(u.post_data) as post_data, jsonb_build_object('type', p.type) || jsonb(p.data) as data from
(SELECT json_build_object('user',u.user ,'profile_image',u.profile_image)  as user_data, jsonb_build_object('type', p.type) || jsonb(p.data) as post_data, cast(p.data ->> 'createdate' AS TIMESTAMP) as createdate_post, cast(p.data ->> 'id' AS varchar) as id_post
FROM (
	select o.post_id, u.id, row_to_json(u.*) AS user
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createDate', o."createDate") || jsonb_build_object('description', o.description) || jsonb_build_object('filename', o."fileName") || jsonb_build_object('filetype', o."fileType") || jsonb_build_object('s3url', o.s3url)) AS profile_image
	FROM (
		SELECT u.id
			,u.accountname as "accountName"
			,u.active
			,u.createdate as "createDate"
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
				,max(s.createdate) AS "createDate"
				,max(s.description) AS description
				,max(s.filename)  as "fileName"
				,max(s.filetype) as "fileType"
				,max(s.s3url) AS s3url
				,o.user_id, o.post_id
			FROM (
				SELECT pi.user_id
					,replace(m.mri, 'mri::', '') AS s3_id, pi.post_id
				FROM (
					SELECT u.user_id
						,o.slave AS id, u.post_id
					FROM (select m.id as mri_id, replace(m.mri, 'mri::', '') as user_id, a.post_id from
(select a.owner, replace(m.mri, 'mri::', '') as post_id, a.accountability_id from  
(select o.owner, a.accountability_id from myneresourceinformation m,
(select a.id as accountability_id from accountability a
order by "views" desc, id desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)) a, ownerresources o
where replace(m.mri, 'mri::', '') = a.accountability_id and o.slave = m.id
and o.type = 'POST_ACCOUNTABILITY') a, myneresourceinformation m
where a.owner = m.id ) a, ownerresources o,  myneresourceinformation m
where a.owner = o.slave and o.owner = m.id) u
					LEFT JOIN ownerresources o ON u.mri_id = o.OWNER
						AND o.type = 'USER_PROFILE_IMAGE'
					) pi
				LEFT JOIN myneresourceinformation m ON pi.id = m.id
				) o
			LEFT JOIN s3file s ON o.s3_id = s.id
			GROUP BY o.user_id, o.post_id
			) o
	WHERE o.user_id = u.id
	) u
cross join lateral findresourcedata(u.post_id) as p
) u
cross join lateral findresourcebyowner(u.id_post) as p) u
group by u.user_data, u.post_data) u
) u

	
	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmyneglobalfeed(int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmyneglobalfeed(int4,int4) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findmyneinsights(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmyneinsights(varchar,int4,int4) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findmynerelatedposts(varchar,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmynerelatedposts(varchar,int4) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findmynerelations(varchar,varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmynerelations(varchar,varchar,int4,int4) TO postgres;

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
(select f.owner, jsonb_build_object('type', f.type) || to_jsonb(f.data)	as data 
from findresourcebyowner(resource) f) f
group by f.owner) f 
cross join lateral findresourcedata(f.owner) as o ) f

	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.findmyneresource(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findmyneresource(varchar) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findrelatedposts(varchar,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findrelatedposts(varchar,int4) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findresourcebyowner(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findresourcebyowner(varchar) TO postgres;

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

-- Permissions

ALTER FUNCTION public.findresourcebyownerandtype(varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findresourcebyownerandtype(varchar,varchar) TO postgres;

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

	select (case when l.owner isnull then 'DON''T HAVE' else l.owner end) as owner,
	(select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = mri_id limit 1) as type,  uuid_generate_v4() as id, r.* from 
(select
(case when (mri_type) = 'USER'
   then (select row_to_json(u) from (select u.id, u.accountname as "accountName", u.active, u.createdate, u.devicetoken, u.email, u.name, u.slug, u.usertype, u.visibility from public.myneuser u where u.id= mri_id) u)
   when (mri_type) = 'POST'
    then (select row_to_json(p) from (select p.id, p.createdate as "createDate", p.description, p.title, p.cancomment as "canComment" from public.post p where p.id= mri_id order by p.createdate desc) p)
     when (mri_type) = 'SITE'
   then (select row_to_json(s) from  (select * from public.site s where s.id= mri_id) s)
   when (mri_type) = 'PHONE'
   then (select row_to_json(p) from (select * from public.phone p where p.id= mri_id) p)
    when (mri_type) = 'ACCOUNTABILITY' 
   then (select row_to_json(a) from (select * from public.accountability a where a.id= mri_id) a)
   when (mri_type) = 'INSIGHT'
   then (select row_to_json(i) from (select * from public.insight i where i.id= mri_id) i)
    when (mri_type) = 'COMMENT' 
   then (select row_to_json(c) from (select c.id, c.createdate as "createDate", c.text from public.comment c  where c.id = mri_id) c)
   when (mri_type) = 'ADDRESS'
   then (select row_to_json(a) from (select * from public.address a where a.id= mri_id) a)
   else (select row_to_json(s) from (select s.id, s.createdate as "createDate", s.description, s.filename as "filename", s.filetype as "filetype", s.s3url, s.solicitacaoid from public.s3file s where s.id= mri_id) s)
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

-- Permissions

ALTER FUNCTION public.findresourcedata(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.findresourcedata(varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.gin_extract_query_trgm(text, internal, smallint, internal, internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_extract_query_trgm$function$
;

-- Permissions

ALTER FUNCTION public.gin_extract_query_trgm(text,internal,int2,internal,internal,internal,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gin_extract_query_trgm(text,internal,int2,internal,internal,internal,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gin_extract_value_trgm(text, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_extract_value_trgm$function$
;

-- Permissions

ALTER FUNCTION public.gin_extract_value_trgm(text,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gin_extract_value_trgm(text,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gin_trgm_consistent(internal, smallint, text, integer, internal, internal, internal, internal)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_trgm_consistent$function$
;

-- Permissions

ALTER FUNCTION public.gin_trgm_consistent(internal,int2,text,int4,internal,internal,internal,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gin_trgm_consistent(internal,int2,text,int4,internal,internal,internal,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gin_trgm_triconsistent(internal, smallint, text, integer, internal, internal, internal)
 RETURNS "char"
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gin_trgm_triconsistent$function$
;

-- Permissions

ALTER FUNCTION public.gin_trgm_triconsistent(internal,int2,text,int4,internal,internal,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gin_trgm_triconsistent(internal,int2,text,int4,internal,internal,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_compress(internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_compress$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_compress(internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_compress(internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_consistent(internal, text, smallint, oid, internal)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_consistent$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_consistent(internal,text,int2,oid,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_consistent(internal,text,int2,oid,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_decompress(internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_decompress$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_decompress(internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_decompress(internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_distance(internal, text, smallint, oid, internal)
 RETURNS double precision
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_distance$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_distance(internal,text,int2,oid,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_distance(internal,text,int2,oid,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_in(cstring)
 RETURNS gtrgm
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_in$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_in(cstring) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_in(cstring) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_out(gtrgm)
 RETURNS cstring
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_out$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_out(gtrgm) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_out(gtrgm) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_penalty(internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_penalty$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_penalty(internal,internal,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_penalty(internal,internal,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_picksplit(internal, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_picksplit$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_picksplit(internal,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_picksplit(internal,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_same(gtrgm, gtrgm, internal)
 RETURNS internal
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_same$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_same(gtrgm,gtrgm,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_same(gtrgm,gtrgm,internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.gtrgm_union(internal, internal)
 RETURNS gtrgm
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$gtrgm_union$function$
;

-- Permissions

ALTER FUNCTION public.gtrgm_union(internal,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.gtrgm_union(internal,internal) TO rdsadmin;

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

-- Permissions

ALTER FUNCTION public.insertadmindata() OWNER TO postgres;
GRANT ALL ON FUNCTION public.insertadmindata() TO postgres;

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

-- Permissions

ALTER FUNCTION public.listmynerelations(varchar,varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.listmynerelations(varchar,varchar,int4,int4) TO postgres;

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

-- Permissions

ALTER FUNCTION public.listresourcesbytype(varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.listresourcesbytype(varchar,int4,int4) TO postgres;

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

-- Permissions

ALTER FUNCTION public.myneglobalfeed(int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.myneglobalfeed(int4,int4) TO postgres;

CREATE OR REPLACE FUNCTION public.myneresearch(research character varying, user_id character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

 select uuid_generate_v4() as id, 'POST' as type, to_json(research)  as data

 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.myneresearch(varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.myneresearch(varchar,varchar) TO postgres;


-- Agregate tsvector

CREATE AGGREGATE tsvector_agg(tsvector) (
   STYPE = pg_catalog.tsvector,
   SFUNC = pg_catalog.tsvector_concat,
   INITCOND = ''
);



CREATE OR REPLACE FUNCTION public.myneresearch(research character varying, research_type character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN


IF research_type = 'POST' then
	RETURN query
	
select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data  from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and 
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
and m.type = 'POST'
group by t.id , m.mri
order by similarity desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r;




elsif research_type = 'USER' then

RETURN query

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json(r.data) as data from
(select jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and --m.type = :type and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
group by t.id , m.mri
order by similarity desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE') r;


elsif research_type isnull then

RETURN query


select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json( r.data) as data from 
(select jsonb_build_object('user', (jsonb(ro.data) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
and m.type = 'POST'
group by t.id , m.mri
order by similarity desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro) r

union all

select cast(uuid_generate_v4() as varchar) as id,  cast('RESEARCH' as varchar) as type, to_json(r.data) as data from
(select jsonb_build_object('type', rd.type) || jsonb(rd.data)|| jsonb_build_object('profile_image', ro.data) as data from
(select replace(m.mri,'mri::','') as resource_id, 
t.id, tsvector_agg(t.tag_tsv), similarity(lower(unaccent(STRING_AGG(t.tag, ' '))), lower(unaccent(research)))
from tag t, myneresourceinformation m, resourcetag r 
where 
 m.id = r.resource and r.tag = t.id and m.type = 'USER' and
t.tag_tsv @@
to_tsquery('portuguese',(select replace(unaccent(trim(research)),' ',' | ')))
group by t.id , m.mri
order by similarity desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5)
) m
cross join lateral findresourcedata(m.resource_id) as rd
LEFT   JOIN LATERAL findresourcebyowner(m.resource_id) ro ON true
where ro.type isnull or ro.type = 'PROFILE_IMAGE') r;

end IF ;
  
 

  
  	
   RETURN;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.myneresearch(varchar,varchar,int4,int4) OWNER TO postgres;
GRANT ALL ON FUNCTION public.myneresearch(varchar,varchar,int4,int4) TO postgres;

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

RETURN retorno;


end;
$function$
;

-- Permissions

ALTER FUNCTION public.removerelations(varchar,varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.removerelations(varchar,varchar,varchar) TO postgres;

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

-- Permissions

ALTER FUNCTION public.requestrelation(varchar,varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.requestrelation(varchar,varchar,varchar) TO postgres;

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

-- Permissions

ALTER FUNCTION public.responserelationrequest(varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.responserelationrequest(varchar,varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.set_limit(real)
 RETURNS real
 LANGUAGE c
 STRICT
AS '$libdir/pg_trgm', $function$set_limit$function$
;

-- Permissions

ALTER FUNCTION public.set_limit(float4) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.set_limit(float4) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.show_limit()
 RETURNS real
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$show_limit$function$
;

-- Permissions

ALTER FUNCTION public.show_limit() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.show_limit() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.show_trgm(text)
 RETURNS text[]
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$show_trgm$function$
;

-- Permissions

ALTER FUNCTION public.show_trgm(text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.show_trgm(text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity$function$
;

-- Permissions

ALTER FUNCTION public.similarity(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.similarity(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.similarity_dist(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity_dist$function$
;

-- Permissions

ALTER FUNCTION public.similarity_dist(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.similarity_dist(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$similarity_op$function$
;

-- Permissions

ALTER FUNCTION public.similarity_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.similarity_op(text,text) TO rdsadmin;

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

-- Permissions

ALTER FUNCTION public.slugcolumn(varchar,varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.slugcolumn(varchar,varchar) TO postgres;

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

-- Permissions

ALTER FUNCTION public.slugify(text) OWNER TO postgres;
GRANT ALL ON FUNCTION public.slugify(text) TO public;
GRANT ALL ON FUNCTION public.slugify(text) TO postgres;

CREATE OR REPLACE FUNCTION public.strict_word_similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity$function$
;

-- Permissions

ALTER FUNCTION public.strict_word_similarity(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.strict_word_similarity(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_commutator_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_commutator_op$function$
;

-- Permissions

ALTER FUNCTION public.strict_word_similarity_commutator_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.strict_word_similarity_commutator_op(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_dist_commutator_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_dist_commutator_op$function$
;

-- Permissions

ALTER FUNCTION public.strict_word_similarity_dist_commutator_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.strict_word_similarity_dist_commutator_op(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_dist_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_dist_op$function$
;

-- Permissions

ALTER FUNCTION public.strict_word_similarity_dist_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.strict_word_similarity_dist_op(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.strict_word_similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$strict_word_similarity_op$function$
;

-- Permissions

ALTER FUNCTION public.strict_word_similarity_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.strict_word_similarity_op(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.taginsert()
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

RETURN NEW;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.taginsert() OWNER TO postgres;
GRANT ALL ON FUNCTION public.taginsert() TO postgres;

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

-- Permissions

ALTER FUNCTION public.testecoluna(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION public.testecoluna(varchar) TO postgres;

CREATE OR REPLACE FUNCTION public.unaccent(regdictionary, text)
 RETURNS text
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

-- Permissions

ALTER FUNCTION public.unaccent(regdictionary,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.unaccent(regdictionary,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.unaccent(text)
 RETURNS text
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

-- Permissions

ALTER FUNCTION public.unaccent(text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.unaccent(text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.unaccent_init(internal)
 RETURNS internal
 LANGUAGE c
 PARALLEL SAFE
AS '$libdir/unaccent', $function$unaccent_init$function$
;

-- Permissions

ALTER FUNCTION public.unaccent_init(internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.unaccent_init(internal) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.unaccent_lexize(internal, internal, internal, internal)
 RETURNS internal
 LANGUAGE c
 PARALLEL SAFE
AS '$libdir/unaccent', $function$unaccent_lexize$function$
;

-- Permissions

ALTER FUNCTION public.unaccent_lexize(internal,internal,internal,internal) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.unaccent_lexize(internal,internal,internal,internal) TO rdsadmin;

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

-- Permissions

ALTER FUNCTION public.update_views() OWNER TO postgres;
GRANT ALL ON FUNCTION public.update_views() TO postgres;

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



RETURN NEW;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.user_slug() OWNER TO postgres;
GRANT ALL ON FUNCTION public.user_slug() TO public;
GRANT ALL ON FUNCTION public.user_slug() TO postgres;

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


RETURN NEW;

END;

$function$
;

-- Permissions

ALTER FUNCTION public.userrelationajust() OWNER TO postgres;
GRANT ALL ON FUNCTION public.userrelationajust() TO postgres;

CREATE OR REPLACE FUNCTION public.uuid_generate_v1()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1$function$
;

-- Permissions

ALTER FUNCTION public.uuid_generate_v1() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_generate_v1() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_generate_v1mc()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1mc$function$
;

-- Permissions

ALTER FUNCTION public.uuid_generate_v1mc() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_generate_v1mc() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_generate_v3(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v3$function$
;

-- Permissions

ALTER FUNCTION public.uuid_generate_v3(uuid,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_generate_v3(uuid,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_generate_v4()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v4$function$
;

-- Permissions

ALTER FUNCTION public.uuid_generate_v4() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_generate_v4() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_generate_v5(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v5$function$
;

-- Permissions

ALTER FUNCTION public.uuid_generate_v5(uuid,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_generate_v5(uuid,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_nil()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_nil$function$
;

-- Permissions

ALTER FUNCTION public.uuid_nil() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_nil() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_ns_dns()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_dns$function$
;

-- Permissions

ALTER FUNCTION public.uuid_ns_dns() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_ns_dns() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_ns_oid()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_oid$function$
;

-- Permissions

ALTER FUNCTION public.uuid_ns_oid() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_ns_oid() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_ns_url()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_url$function$
;

-- Permissions

ALTER FUNCTION public.uuid_ns_url() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_ns_url() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.uuid_ns_x500()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_x500$function$
;

-- Permissions

ALTER FUNCTION public.uuid_ns_x500() OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.uuid_ns_x500() TO rdsadmin;

CREATE OR REPLACE FUNCTION public.word_similarity(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity$function$
;

-- Permissions

ALTER FUNCTION public.word_similarity(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.word_similarity(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.word_similarity_commutator_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_commutator_op$function$
;

-- Permissions

ALTER FUNCTION public.word_similarity_commutator_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.word_similarity_commutator_op(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.word_similarity_dist_commutator_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_dist_commutator_op$function$
;

-- Permissions

ALTER FUNCTION public.word_similarity_dist_commutator_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.word_similarity_dist_commutator_op(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.word_similarity_dist_op(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_dist_op$function$
;

-- Permissions

ALTER FUNCTION public.word_similarity_dist_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.word_similarity_dist_op(text,text) TO rdsadmin;

CREATE OR REPLACE FUNCTION public.word_similarity_op(text, text)
 RETURNS boolean
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity_op$function$
;

-- Permissions

ALTER FUNCTION public.word_similarity_op(text,text) OWNER TO rdsadmin;
GRANT ALL ON FUNCTION public.word_similarity_op(text,text) TO rdsadmin;


-- Permissions

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
