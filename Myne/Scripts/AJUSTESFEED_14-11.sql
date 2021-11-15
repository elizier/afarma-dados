-- public."like" definition

-- Drop table

-- DROP TABLE public."like";

CREATE TABLE global.research (
	id varchar(36) NOT NULL,
	createdate timestamp NOT NULL DEFAULT now(),
	"type" varchar(255) null,
	tag varchar(10240) NULL,
	ts_vector tsvector null,
	research_data json null 
);


select findmylearning('6a49706d-9be8-44bc-95a7-d8994150dc9b', 'NULO')

select findresourcebyowner()

select m.id
from myneresourceinformation m where m."type" = 'POST'
left join ownerresources o on m.id = o.slave
where o."type" = 'USER_POST'


left join findresourcedata(p.id) as pr on true

55f59dc6-9158-437b-ac40-981d30ca3b3f

select u.user_data, u.post_data, u.profile_image_data, m.type, replace(m.mri, 'mri::','') as post_slaves_id from
(select u.user_data, u.post_data, row_to_json(sf.*) as profile_image_data, u.mri_id_slave from 
(select --row_to_json(ud.*),
json_build_object('id',ud.id,'accountName',ud.accountname, 'active', ud.active, 'createDate', ud.createdate,'devicetoken',
ud.devicetoken, 'email',ud.email, 'name', ud.name, 'slug', ud.slug, 'userType', ud.usertype, 'visibility', ud.visibility) as user_data,
u.slave_type, p.id as post_id, u.mri_id_slave,
--row_to_json(p.*),
json_build_object('id', p.id, 'createDate', p.createdate , 'description', p.description , 'title', p.title, 'canComment', p.cancomment, 
'releaseDate', p.releasedate)  as post_data , o.slave
from
(select u.id_usuario_no_mri, u.user_id, m.type as slave_type, replace(m.mri, 'mri::','') as user_slaves, u.mri_id_slave from
(select m.id as id_usuario_no_mri, u.id as user_id, o.slave as mri_id_slave, m.createdate from
(select distinct(r.to_id) as id from relationrequest r 
where r.status = 'ACCEPTED' and
(r.type = 'FOLLOWER' or r.type = 'PUPIL' or r.type = 'PARTNER')
and r.from_id = :user_id) u
left join myneresourceinformation m on replace(m.mri, 'mri::','') = u.id
left join ownerresources o on m.id = o."owner" 
where (o."type" = 'USER_POST' )
order by m.createdate desc, mri_id_slave asc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) u
left join myneresourceinformation m on u.mri_id_slave = m.id) u
left join myneuser ud on ud.id = u.user_id
right join post p on u.user_slaves = p.id 
left join ownerresources o on o."owner" = u.id_usuario_no_mri
where o."type" = 'USER_PROFILE_IMAGE') u
left join myneresourceinformation m on m.id = u.slave
left join s3file sf on replace(m.mri, 'mri::','') = sf.id) u
left join ownerresources o on u.mri_id_slave = o.owner
left join myneresourceinformation m on m.id = o.slave ;


select  p.post_data || jsonb_build_object('nested', array_agg(p.post_resources_data)) || p.user_data from
(select jsonb_build_object('type', f.type) || jsonb(f.data) as post_data, jsonb_build_object('type', pr.type) ||jsonb(pr.data) as post_resources_data, 
jsonb_build_object('user', jsonb_build_object('profile_image', jsonb_build_object('type', pf.type) || jsonb(pf.data)) ||
jsonb_build_object('user', jsonb_build_object('type', u.type) || jsonb(u.data))) as user_data
from findresourcedata(:post_id) f
left join findresourcebyowner(:post_id) as pr on true
left join findresourcebyownerandtype(f.owner, 'PROFILE_IMAGE') as pf on true
left join findresourcedata(f.owner) as u on true) p
group by p.post_data, p.user_data




 select public.findmynefeed(:user_id , :itens_by_page, :page)




select distinct(r.to_id) as id from relationrequest r 
where r.status = 'ACCEPTED' and
(r.type = 'FOLLOWER' or r.type = 'PUPIL' or r.type = 'PARTNER')
and r.from_id = :user_id



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
		jsonb_build_object('type', pd.type) || jsonb(pd.data) as post_data,
		jsonb_build_object('type', pr.type) || jsonb(pr.data) as post_resource,
		jsonb_build_object('user', jsonb_build_object('user', jsonb_build_object('type', ur.type) || jsonb(ur.data)) || 
jsonb_build_object('profile_image', jsonb_build_object('type', ud.type) || jsonb(ud.data))) as user_data
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
	left join lateral findresourcedata(u.post_id) as pd on
		true
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


update ownerresources set "type" = o.real_type from
(select o.id as ow_id, o.real_type from 
(select o.id, o."type" , m."type" as owner_type, mr."type" as slave_type, concat(m."type",'_',mr."type") as real_type
from ownerresources o 
left join myneresourceinformation m on m.id = o.owner
left join myneresourceinformation mr on mr.id = o.slave) o
where o.type != o.real_type) o
where o.ow_id = id


update ownerresources set type = 'PRODUCT_MODULE' --and slave = mp.new_slave 

where "type" = 'MODULE_PRODUCT'



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
		,(jsonb_build_object('id', o.s3_id) || jsonb_build_object('createDate', o."createDate") || jsonb_build_object('description', o.description) || jsonb_build_object('fileName', o."fileName") || jsonb_build_object('fileType', o."fileType") || jsonb_build_object('s3url', o.s3url)) AS profile_image
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

select product_page('9dbe77ff-15d6-43b7-a3ed-edb0f575a096')

update public."module" set createdate = now()
where createdate isnull

select from findmynefeed(:user_id,20,0)


select cast(uuid_generate_v4() as varchar) as id, cast('POST' as varchar) as "type",
	p.post_data || jsonb_build_object('nested', array_agg(p.post_resource)) || p.user_data as data
from
	(
	select
		jsonb_build_object('type', 'POST', 'id', pd.id, 'createDate', pd.createdate, 'description', pd.description, 'releaseDate', pd.releasedate, 'title', pd.title, 'canComment', pd.cancomment) as post_data,
		jsonb_build_object('type', pr.type) || jsonb(pr.data) as post_resource,
		jsonb_build_object('user', jsonb_build_object('user', jsonb_build_object('type', ur.type) || jsonb(ur.data)) || 
jsonb_build_object('profile_image', jsonb_build_object('type', ud.type) || jsonb(ud.data))) as user_data
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
				and r.from_id = :user_id) u
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
		limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) u
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
	
	
	
	
	
	select product_page('272dc401-33f5-41bf-93ae-69daa7117029')
	
select now()
	
	
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
		jsonb_build_object('user', jsonb_build_object('user', jsonb_build_object('type', ur.type) || jsonb(ur.data)) || 
jsonb_build_object('profile_image', jsonb_build_object('type', ud.type) || jsonb(ud.data))) as user_data
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





	
select cast(uuid_generate_v4() as varchar) as id, cast('POST' as varchar) as "type",
	p.post_data || jsonb_build_object('nested', array_agg(p.post_resource)) || p.user_data as data
from
	(
	select
		jsonb_build_object('type', 'POST', 'id', pd.id, 'createDate', pd.createdate, 'description', pd.description, 'releaseDate', pd.releasedate, 'title', pd.title, 'canComment', pd.cancomment) as post_data,
		jsonb_build_object('type', pr.type) || jsonb(pr.data) as post_resource,
		jsonb_build_object('user', jsonb_build_object('user', jsonb_build_object('type', ur.type) || jsonb(ur.data)) || 
jsonb_build_object('profile_image', jsonb_build_object('type', ud.type) || jsonb(ud.data))) as user_data
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
				and r.from_id = :user_id) u
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
		limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) u
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
	