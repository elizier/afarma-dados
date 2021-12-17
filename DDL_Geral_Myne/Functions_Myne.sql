CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE EXTENSION dblink;

CREATE extension unaccent ;

CREATE extension pg_trgm ;

-- Agregate tsvector

CREATE AGGREGATE tsvector_agg(tsvector) (
   STYPE = pg_catalog.tsvector,
   SFUNC = pg_catalog.tsvector_concat,
   INITCOND = ''
);

CREATE OR REPLACE FUNCTION public.checklike(resource character varying, userid character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in	
 
  select cast(uuid_generate_v4() as varchar) as id, 'ACCOUNTABILITY' as type, f.data from
 (( select 
 jsonb_build_object('action', a."action", 'actionDate', a.createdate, 'user_id', a.user_id, 'possibleAction', 
 (case when a."action" isnull or a."action" = '' then 'POSITIVE' when a."action" = 'POSITIVE' then 'NEGATIVE' else 'POSITIVE' end)) as data
 from
 (select m.id, m."type", replace(m.mri, 'mri::', '') as mri from myneresourceinformation m where replace(m.mri, 'mri::', '') = coalesce (resource, replace(m.mri, 'mri::', ''))) m
 left join ownerresources o on o."owner" = m.id
 left join myneresourceinformation mr on o.slave = mr.id
 left join registeraccountability a on replace(mr.mri, 'mri::', '') = a.accountability_id 
 where o."type" like '%ACCOUNTABILITY%' and a.user_id = coalesce(userid, a.user_id)
 order by a.createdate desc 
 limit 1)
 union all 
 (select jsonb_build_object('createDate', now(), 'action', null, 'user_id', userid, 'possibleAction', 'POSITIVE'))
 limit 1) f
 
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
(select jsonb_build_object('dtype', v.dtype,'id', v.id, 'createDate', v.createdate, 'enddDate', v.enddate, 'externalId', v.externalid,
'participationType', v.participationtype, 'startDate', v.startdate, 'description', v.description, 'title', v.title, 'user_id', v.user_id) as live_data, v.enddate, v.startdate, vp.user_id, vp.participanttype, vp."token" from myne_streams.video v, myne_streams.videoparticipant vp
where v.id = vp.video_id and (--v.owner_id = coalesce(userid,v.owner_id) or 
vp.user_id = coalesce(userid,vp.user_id))
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
	p.post_data || jsonb_build_object('nested', array_agg(p.post_resource)) || p.user_data || t.tag as data
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
			(select distinct(id) from (
			select
				r.to_id as id
			from
				relationrequest r
			where
				r.status = 'ACCEPTED'
				and
(r.type = 'FOLLOWER'
					or r.type = 'PUPIL'
					or r.type = 'PARTNER')
				and r.from_id = user_id
				union all
				select user_id) u) u
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
left join (select m.id, jsonb_build_object('tags', string_to_array(m.tag, ' ')) as tag from
(select replace(m.mri, 'mri::', '') as id, string_agg(t.tag, ' ')  
as tag from myneresourceinformation m 
left join resourcetag r on r.resource = m.id
left join tag t on r.tag = t.id
where m."type" = 'POST'
group by m.id) m) t on t.id = cast(p.post_data ->> 'id' as varchar)
group by
	p.post_data,
	p.user_data,
	t.tag
	

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
		jsonb_build_object('type', 'POST', 'id', pd.id, 'createDate', pd.createdate, 'description', pd.description, 'releaseDate', pd.releasedate, 'title', pd.title, 'canComment', pd.cancomment) || t.tag as post_data,
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
		true
	left join (select m.id, jsonb_build_object('tags', string_to_array(m.tag, ' ')) as tag from
(select replace(m.mri, 'mri::', '') as id, string_agg(t.tag, ' ')  
as tag from myneresourceinformation m 
left join resourcetag r on r.resource = m.id
left join tag t on r.tag = t.id
where m."type" = 'POST'
group by m.id) m) t on t.id = u.post_id)
p
group by
	p.post_data,
	p.user_data

order by
	cast(p.post_data ->> 'createDate' as timestamp with time zone) desc

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

	select (case when l.owner isnull then 'DON''T HAVE' else l.owner end) as owner,
	(select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = mri_id limit 1) as type,  uuid_generate_v4() as id, r.* from 
(select
(case when (mri_type) = 'USER'
   then (select row_to_json(u) from (select u.id, u.accountname as "accountName", u.active, u.createdate as "createDate", u.devicetoken, u.email, u.name, u.slug, u.usertype as "userType", u.visibility, u.biography from public.myneuser u where u.id= mri_id) u)
   when (mri_type) = 'POST'
    then (select row_to_json(p) from (select p.id, p.createdate as "createDate", p.description, p.title, p.cancomment as "canComment", p.releasedate as "releaseDate" from public.post p where p.id= mri_id order by p.createdate desc) p)
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
(select distinct(i.insight_id) from global.insights i where cast(insight_data ->> 'type' as varchar) = 'INSIGHT'
except 
select i.id from public.insight i);

update "global".insights set enddate = releasedate + interval '1 day'
where enddate isnull and cast(insight_data ->> 'type' as varchar) = 'INSIGHT';

RETURN NEW;

END;

$function$
;

CREATE OR REPLACE FUNCTION public.listaccountability(resource character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in	
 	
 select  cast(uuid_generate_v4() as varchar) as id, 'USER' as "type", jsonb(f.data) ||
 jsonb_build_object('profile_image', jsonb_build_object('type', ph.type) || jsonb(ph.data)) as data
 from
 (select m.id, m."type", replace(m.mri, 'mri::', '') as mri from myneresourceinformation m where replace(m.mri, 'mri::', '') = coalesce (resource, replace(m.mri, 'mri::', ''))) m
 left join ownerresources o on o."owner" = m.id
 left join myneresourceinformation mr on o.slave = mr.id
 left join registeraccountability a on replace(mr.mri, 'mri::', '') = a.accountability_id
 left join lateral findresourcedata(a.user_id) as f on true 
 left join lateral findresourcebyownerandtype(a.user_id, 'PROFILE_IMAGE') as ph on true 
 where o."type" like '%ACCOUNTABILITY%' and a."action" = 'POSITIVE'
 order by a.createdate desc 
 limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)

 	loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

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

CREATE OR REPLACE FUNCTION public.liveinsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

INSERT INTO "global".insights (insight_id, userid, insight_data, releasedate, user_data, insert_date, enddate) 
select v.id, v.user_id, v.insight_data, v.releasedate, v.user_data, v.insert_date, v.enddate  from
(select v.id, v.user_id, jsonb_build_object('dtype', v.dtype,'id', v.id, 'createDate', v.createdate, 'externalId', v.externalid,
'participationType', v.participationtype, 'startDate', v.startdate, 'description', v.description, 'title', v.title, 'user_id', v.user_id, 'type', 'LIVE') as insight_data,
v.startdate as releasedate, jsonb(u.data) || jsonb_build_object('profile_image', ph.data) as user_data, now() as insert_date, v.enddate 
from myne_streams.video v
left join myne_streams.videoparticipant v2 on v.id = v2.video_id and v.user_id = v2.user_id 
left join lateral public.findresourcedata(v.user_id) as u on true
left join lateral public.findresourcebyownerandtype(v.user_id, 'PROFILE_IMAGE') as ph on true
where v2.participanttype = 'SPEAKER' and v.id in (select v.id from myne_streams.video v except select i.insight_id from "global".insights i)
) v
group by v.id, v.user_id, v.insight_data, v.releasedate, v.user_data, v.insert_date, v.enddate;

delete from global.insights  i where i.insight_id in
(select distinct(i.insight_id) from global.insights i where cast(insight_data ->> 'type' as varchar) = 'LIVE'
except 
select i.id from myne_streams.video i);

update "global".insights set enddate = v.dateend
from (select v.id as id1, v.enddate as dateend from myne_streams.video v) v
where enddate isnull and cast(insight_data ->> 'type' as varchar) = 'LIVE' and 
v.id1 = insight_id;

RETURN NEW;

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
or (similarity(r.tag, research)>0.1))
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
or (similarity(r.tag, research)>0.1))
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
or (similarity(r.tag, research)>0.1)) and  now() > r.releasedate 
order by similarity(r.tag, research) desc
limit coalesce(itens_by_page, 5)
offset coalesce(page, 0) * coalesce(itens_by_page, 5);

end IF ;
  
 

  
  	
   RETURN;

END;

$function$
;

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
(select jsonb_build_object('user', (jsonb_build_object('user', jsonb(ro.data)) || jsonb_build_object('profile_image', r.array_agg))) || r.data_post || r.data_slave || t.tag as data
from
(select r.owner,  array_agg(ro.data), r.data_post, r.data as data_slave from
(select r.owner, r.data_post, jsonb_build_object('nested', array_agg(r.data_slave)) as data from
(select rd.owner, jsonb_build_object('type', rd.type) || jsonb(rd.data) as data_post ,
jsonb_build_object('type', ro.type) || jsonb(ro.data) as data_slave from
(select replace(m.mri, 'mri::', '') as resource_id from myneresourceinformation m where m.type = 'POST' and 
replace(m.mri, 'mri::', '') not in 
('d394890b-d001-43af-b280-2db7297bee1a',
'4f667f43-f529-4f04-89e9-acc124a449e9',
'f9f8b822-db26-4dfe-ae0c-9db629a714bc',
'30dc34ec-c049-4533-9ddc-4382220529a3',
'f8e33cfb-4f5f-469f-84e2-2e911a3c304b',
'68cc0189-0ded-4495-b73b-611ff807dc7e',
'ed02ac7b-7fd3-4aba-8557-5240e95bc538',
'c1980d8b-53b2-4f41-abbd-d3b6b1de389b',
'11f0e39d-13f5-4dcd-945e-3d9ecc49a75c',
'36a7ea09-dfb7-4ab6-8d93-ad0b954fe3d8',
'f0e688e6-138b-4d43-9c71-d38f50c0b33d',
'865c7bb5-7007-44cf-ad44-87318f2fa131',
'3a3b3ed7-63c8-4b5b-a7c2-80039e1005cc',
'f753e12a-292b-4c73-a2ec-471b49033a87',
'23563ec3-fc64-4d10-a253-1d2350d00ec9',
'00b3a7ef-ea8b-400d-b944-f3d5fbcc309e')
except
select r.id from global.research r where r.type = 'POST') m
cross join lateral findresourcedata(m.resource_id) as rd
cross join lateral findresourcebyowner(m.resource_id) as ro) r 
group by r.owner, r.data_post) r
left join lateral findresourcebyowner(r.owner) ro on true
where ro.type = 'PROFILE_IMAGE' or ro.type isnull
group by r.owner, r.data_post, r.data) r 
cross join lateral findresourcedata(r.owner) as ro
left join (select m.id, jsonb_build_object('tags', string_to_array(m.tag, ' ')) as tag from
(select replace(m.mri, 'mri::', '') as id, string_agg(t.tag, ' ')  
as tag from myneresourceinformation m 
left join resourcetag r on r.resource = m.id
left join tag t on r.tag = t.id
where m."type" = 'POST'
group by m.id) m) t on cast(r.data_post ->> 'id' as varchar) = t.id) r
left join findresourcedata(cast(r.data ->> 'id' as varchar)) as f on true
left join myneresourceinformation m on f.owner = replace(m.mri, 'mri::', '')
where m.type = 'USER') u;

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

