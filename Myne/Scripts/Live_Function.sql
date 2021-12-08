select  from 
(select to_jsonb(v.*)  ||
jsonb_build_object('status', (case when v.enddate isnull then (case when now() < v.createdate then 'NOT_STARTED' else 'RUNNING' end ) else 'ENDED' end)) as live_data,
jsonb(u.data) || jsonb_build_object('type', u.type) ||
jsonb_build_object('token', vp."token", 'participantType', vp.participanttype) as user_data,
jsonb(ph.data) || jsonb_build_object('type', ph.type) as profile_image
from myne_streams.video v, myne_streams.videoparticipant vp
left join lateral public.findresourcedata(vp.user_id) as u on true
left join lateral public.findresourcebyownerandtype(vp.user_id, 'PROFILE_IMAGE') as ph on true
where v.id = vp.video_id and (v.owner_id = coalesce(:user_id,v.owner_id) or vp.user_id = coalesce(:user_id,vp.user_id))
and vp."token" notnull) f

select public.findmyneglobalfeed(20,0)