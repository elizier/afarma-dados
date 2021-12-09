
CREATE OR REPLACE FUNCTION public.findmylives(itens_by_page integer, page integer)
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
where v.id = vp.video_id and (v.owner_id = coalesce(:user_id,v.owner_id) or vp.user_id = coalesce(:user_id,vp.user_id))
and vp."token" notnull
limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) v
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


select public.findmyneglobalfeed(20,0)