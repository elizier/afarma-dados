
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

select findmyposts(:user_id,10,0)

select findmynefeed(:user_id,10,0)

select public.findmylives(:user_id, :itens_by_page, :page)

select public.findmyneglobalfeed(20,0)

delete from global.research where "type" = 'POST'

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
	
	
	
