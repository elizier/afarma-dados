
SELECT cast(uuid_generate_v4() AS VARCHAR) AS id, f.viewbyday
	,'POST' AS type
	,jsonb_build_object('user', f.user_data || jsonb_build_object('profile_image', p.data)) || f.post_data AS data
FROM (
	SELECT f.viewbyday, f.user_id
		,jsonb_build_object('user', f.user_data) AS user_data
		,f.post_data || jsonb_build_object('nested', array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) AS post_data
	FROM (
		SELECT a.accountability_id, (a.views) / (DATE_PART('day', now() - cast(f.data ->> 'createDate' AS timestamp with time zone))) as viewbyday
			,f.OWNER AS user_id
			,to_jsonb(u.data) AS user_data
			,jsonb_build_object('type', f.type) || to_jsonb(f.data) AS post_data
		FROM (
			SELECT a.id AS accountability_id, a.views 
			FROM accountability a
			ORDER BY "views" DESC
				,id DESC limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
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
order by f.viewbyday desc

create materialized view globalfeed as
(SELECT cast(uuid_generate_v4() AS VARCHAR) AS id, f.viewbyday, cast(f.post_data ->> 'id' AS VARCHAR) as post_id
	,'POST' AS type
	,jsonb_build_object('user', f.user_data || jsonb_build_object('profile_image', p.data)) || f.post_data AS data
FROM (
	SELECT f.viewbyday, f.user_id
		,jsonb_build_object('user', f.user_data) AS user_data
		,f.post_data || jsonb_build_object('nested', array_agg(to_jsonb(p.data) || jsonb_build_object('type', p.type))) || t.tag AS post_data
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
	left join (select m.id, jsonb_build_object('tags', string_to_array(m.tag, ' ')) as tag from
(select replace(m.mri, 'mri::', '') as id, string_agg(t.tag, ' ')  
as tag from myneresourceinformation m 
left join resourcetag r on r.resource = m.id
left join tag t on r.tag = t.id
where m."type" = 'POST'
group by m.id) m) t on t.id = cast(f.post_data ->> 'id' AS VARCHAR)
	WHERE f.user_id notnull
		AND f.user_id != 'DON''T HAVE'
	GROUP BY f.user_id, f.viewbyday
		,f.post_data
		,f.user_data
		,t.tag
	) f
LEFT JOIN lateral findresourcebyownerandtype(f.user_id, 'PROFILE_IMAGE') p ON true
order by f.viewbyday desc)


refresh materialized view public.globalfeed;


select g.id, g.type, g.data from public.globalfeed g
where post_id = 'f9f8b822-db26-4dfe-ae0c-9db629a714bc'
limit coalesce(:itens_by_page, 5) offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)

select public.refresh_mat_view_global_feed()

create or replace function public.refresh_mat_view_global_feed()
returns trigger language plpgsql
as $$
begin

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

create trigger global_feed_refresh_mat_view
after insert or update
on public.post for each statement 
execute procedure public.refresh_mat_view_global_feed();


create trigger global_feed_mat_view_refresh after
insert or update
    on
    public.post for each row execute function public.refresh_mat_view_global_feed()


CREATE OR REPLACE FUNCTION public.refresh_mat_view_global_feed()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN



refresh materialized view public.globalfeed;



RETURN NEW;

END;

$function$
;






