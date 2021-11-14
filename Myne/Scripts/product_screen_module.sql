select * from product p where p.id = :product_id

select
	cast(uuid_generate_v4() as varchar) as id,
	'PRODUCT' as "type",
	jsonb_build_object('owner', array_agg(p.owner_data)) || p.product as "data"
from
	(
	select
		p.owner_data,
		p.product_data || jsonb_build_object('nested', array_agg(p.product_resources)) as product
	from
		(
		select
			p.product_data,
			p.owner_data,
			(case
				when p.file_data isnull then p.product_resources
				else p.product_resources || jsonb_build_object('nested', array_agg(p.file_data))
			end)
as product_resources
		from
			(
			select
				jsonb_build_object('type', pr.type) || to_jsonb(pr.data) as product_data,
				(case
					when ow.data isnull then jsonb_build_object(lower(o.type), to_jsonb(o.data))
					else jsonb_build_object('user', jsonb_build_object(lower(o.type), to_jsonb(o.data)) || jsonb_build_object(lower(ow.type), to_jsonb(ow.data)))
				end) as owner_data,
				jsonb_build_object('type', pw.type) || to_jsonb(pw.data) as product_resources,
				jsonb_build_object('type', s3.type) || to_jsonb(s3.data) as file_data
			from
				findresourcedata(:product_id) as pr
			left join lateral findresourcedata(pr.owner) as o on
				true
			left join lateral findresourcebyownerandtype(pr.owner,
				'PROFILE_IMAGE') as ow on
				true
			left join lateral findresourcebyowner(:product_id) as pw on
				true
			left join lateral findresourcebyowner(cast(pw.data ->> 'id' as varchar)) as s3 on
				true) p
		group by
			p.product_data,
			p.owner_data,
			p.product_resources,
			p.file_data) p
	group by
		p.product_data,
		p.owner_data) p
group by
	p.product
	
	
	
	
	
	
	
select
	cast(uuid_generate_v4() as varchar) as id,
	'PRODUCT' as "type",
	jsonb_build_object('owner', array_agg(p.owner_data)) || p.product as "data"
from
select p.owner_data, p.product_data, p.product
	(
	select
		p.owner_data,
		p.product_data, jsonb_build_object('nested', array_agg(p.product_resources)) as product
	from
		(
		select
			p.product_data,
			p.owner_data,
			(case
				when p.file_data isnull then p.product_resources
				else p.product_resources || p.file_data
			end)
as product_resources
		from
		(select p.product_data, p.owner_data, p.product_resources, (case when p.file_data isnull then null 
		else  jsonb_build_object('nested', array_agg(p.file_data)) end) as file_data from 
			(
			select
				jsonb_build_object('type', pr.type) || to_jsonb(pr.data) as product_data,
				(case
					when ow.data isnull then jsonb_build_object(lower(o.type), to_jsonb(o.data))
					else jsonb_build_object('user', jsonb_build_object(lower(o.type), to_jsonb(o.data)) || jsonb_build_object(lower(ow.type), to_jsonb(ow.data)))
				end) as owner_data,
				jsonb_build_object('type', pw.type) || to_jsonb(pw.data) as product_resources,
				jsonb_build_object('type', s3.type) || to_jsonb(s3.data) as file_data
			from
				findresourcedata(:product_id) as pr
			left join lateral findresourcedata(pr.owner) as o on
				true
			left join lateral findresourcebyownerandtype(pr.owner,
				'PROFILE_IMAGE') as ow on
				true
			left join lateral findresourcebyowner(:product_id) as pw on
				true
			left join lateral findresourcebyowner(cast(pw.data ->> 'id' as varchar)) as s3 on
				true) p
		group by
			p.product_data,
			p.owner_data,
			p.product_resources,
			p.file_data) p) p
	group by
		p.product_data,
		p.owner_data) p
group by
	p.product


select public.product_page(:product_id)

CREATE OR REPLACE FUNCTION public.product_page(product_id character varying)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   declare
      resource_t public.mynejsontype%ROWTYPE;

begin

 	for resource_t in	
	
	select
	cast(uuid_generate_v4() as varchar) as id,
	'PRODUCT' as "type",
	p.product_data || jsonb_build_object('owner', array_agg(p.owner)) || jsonb_build_object('nested', p.nested) as data
from
	(
	select
		p.product_data,
		p.owner_data as owner,
		array_agg(p.nested) as nested
	from
		(
		select
			p.product_data,
			p.owner_data,
			(case
				when p.file = cast('{"nested": [null]}' as jsonb) then p.product_resources
				else p.product_resources || p.file
			end) as nested
		from
			(
			select
				p.product_data,
				p.owner_data,
				p.product_resources,
				jsonb_build_object('nested', array_agg(p.file_data)) as file
			from
				(
				select
					jsonb_build_object('type', pr.type) || to_jsonb(pr.data) as product_data,
					(case
						when ow.data isnull then jsonb_build_object(lower(o.type), to_jsonb(o.data))
						else jsonb_build_object('user',jsonb_build_object(lower(o.type), to_jsonb(o.data)) || jsonb_build_object(lower(ow.type), to_jsonb(ow.data)))
					end) as owner_data,
					jsonb_build_object('type', pw.type) || to_jsonb(pw.data) as product_resources,
					jsonb_build_object('type', s3.type) || to_jsonb(s3.data) as file_data
				from
					findresourcedata(:product_id) as pr
				left join lateral findresourcedata(pr.owner) as o on
					true
				left join lateral findresourcebyownerandtype(pr.owner,
					'PROFILE_IMAGE') as ow on
					true
				left join lateral findresourcebyowner(:product_id) as pw on
					true
				left join lateral findresourcebyowner(cast(pw.data ->> 'id' as varchar)) as s3 on
					true) p
			group by
				p.product_data,
				p.owner_data,
				p.product_resources) p) p
	group by
		p.product_data,
		p.owner_data) p
group by
	p.product_data,
	p.nested
	
loop
		return next resource_t;
end loop;

return;
end;

$function$
;

select public.findmylaunchs(:user_id, 'NULO')


select public.product_page(:product_id)
7a217f2b-7fcd-46b0-91e7-aa88c4b36f1c

select public.user_notification('7a217f2b-7fcd-46b0-91e7-aa88c4b36f1c')




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



