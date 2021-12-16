select cast(uuid_generate_v4() as varchar) as id, 'LIVE' as type, to_json(f.data) as data from
(select f.live_data || jsonb_build_object('participants',array_agg(f.user_data)) as data from 
(select v.live_data  ||
jsonb_build_object('status', (case when v.enddate isnull then (case when now() < v.startdate then 'NOT_STARTED' else 'RUNNING' end ) else 'ENDED' end)) as live_data,
jsonb_build_object('user', (jsonb(u.data) || jsonb_build_object('type', u.type) ||
jsonb_build_object('token', v."token", 'participantType', v.participanttype))) ||
jsonb_build_object('profile_image', (jsonb(ph.data) || jsonb_build_object('type', ph.type))) as user_data
from
(select to_jsonb(v.*) as live_data, v.enddate, v.startdate, vp.user_id, vp.participanttype, vp."token" from myne_streams.video v, myne_streams.videoparticipant vp
where v.id = vp.video_id
and vp."token" notnull) v
left join lateral public.findresourcedata(v.user_id) as u on true
left join lateral public.findresourcebyownerandtype(v.user_id, 'PROFILE_IMAGE') as ph on true
  ) f
group by f.live_data) f






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

SELECT dtype, id, createdate, enddate, externalid, participationtype, startdate, description, title, user_id, owner_id FROM myne_streams.video;


update "global".insights set enddate = releasedate + interval '1 day'
where enddate isnull and cast(insight_data ->> 'type' as varchar) = 'INSIGHT'


select now() + interval '2 day'

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
group by v.id, v.user_id, v.insight_data, v.releasedate, v.user_data, v.insert_date, v.enddate


create trigger insertlive after
insert
    or
delete
or
update
    on
    myne_streams.video for each row execute function liveinsert()
    
CREATE OR REPLACE FUNCTION public.liveinsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

INSERT INTO "global".insights (insight_id, userid, insight_data, releasedate, user_data, insert_date, enddate) 
select v.id, v.user_id, v.insight_data, v.releasedate, v.user_data, v.insert_date, v.enddate  from
(select v.id, v.user_id, jsonb_build_object('dtype', v.dtype,'id', v.id, 'createDate', v.createdate, 'externalId', v.externalid,
'participationType', v.participationtype, 'startDate', v.startdate, 'description', v.description, 'title', v.title, 'user_id', v.user_id, 'type', 'LIVE') as insight_data,
v.startdate as releasedate, jsonb(u.data) || jsonb_build_object('type', u.type) || jsonb_build_object('profile_image', jsonb(ph.data) || jsonb_build_object('type', ph.type)) as user_data, now() as insert_date, v.enddate 
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


create trigger insertlive after
insert
    or
delete
or
update
    on
    myne_streams.video for each row execute function liveinsert()
    
    
delete from global.insights i where cast(insight_data ->> 'type' as varchar) = 'LIVE'
except 
select i.id from public.insight i);

select findmyneglobalinsights(1000,0)

select public.findmyneinsights(:user_id , :itens_by_page , :page )



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
							AND u.from_id = :user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = :user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PUPIL'
							AND u.to_id = :user_id
						)) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;


