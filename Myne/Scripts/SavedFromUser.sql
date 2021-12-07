allSavedFromUser(user_id character varying, resourcetype character varying,  itensbypage integer, page integer)


select cast(uuid_generate_v4() as varchar) as id, 
cast('POST' as varchar) as type, f.resource_data || jsonb_build_object('nested', array_agg(f.resource_slave)) ||
jsonb_build_object('user', jsonb_build_object('user', f.user_data) || jsonb_build_object('profile_image', f.profile_image)) as data from
(select to_jsonb(f.data) as resource_data, to_jsonb(i.data) as resource_slave,
to_jsonb(g.data) as profile_image, to_jsonb(h.data) as user_data FROM 
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = :user_id and s.resourcetype = 'POST'
order by s.savedate desc, s.resourceid asc
limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) s
LEFT JOIN lateral findresourcebyowner(s.resourceid) AS i on true
LEFT JOIN lateral findresourcedata(s.resourceid) AS f on true
LEFT JOIN lateral findresourcebyownerandtype(f.owner, 'PROFILE_IMAGE') AS g ON true
LEFT JOIN lateral findresourcedata(f.owner) AS h on true) f
group by f.resource_data, f.user_data, f.profile_image



select cast(uuid_generate_v4() as varchar) as id, 
cast('POST' as varchar) as type, r.research_data as data from
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = :user_id and s.resourcetype = 'POST'
order by s.savedate desc, s.resourceid asc
limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) s
left join global.research r on r.id = s.resourceid


select cast(uuid_generate_v4() as varchar) as id, 
r."type" as type, r.research_data as data from
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = :user_id and s.resourcetype != 'INSIGHT'
order by s.savedate desc, s.resourceid asc
limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) s
left join global.research r on r.id = s.resourceid

union all

select cast(uuid_generate_v4() as varchar) as id, 
cast('INSIGHT' as varchar) as type, cast(i.user_data || jsonb_build_object('insight', i.insight_data) as json) as data from
(select s.resourceid, s.savedate
from public.savedcontent s
where s.user_id = :user_id and s.resourcetype = 'INSIGHT'
order by s.savedate desc, s.resourceid asc
limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)) s
left join global.insights i on i.insight_id = s.resourceid 


select public.allsavedfromuser(:user_id, 10, 0)

CREATE OR REPLACE FUNCTION public.allSavedFromUser(userid character varying,  itens_by_page integer, page integer)
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



select public.savedfromuserbytype(:user_id, 'INSIGHT',  10, 0)

CREATE OR REPLACE FUNCTION public.savedfromuserbytype(userid character varying, resourcetype character varying,  itens_by_page integer, page integer)
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



select findmyneglobalinsights(10,0)






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





select findmyneglobalfeed(100,0)
