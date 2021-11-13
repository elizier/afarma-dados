select * from product p where p.id = :product_id


select  p.product_data, p.owner_data, p.product_resources, 
(case when p.file_data isnull then p.product_resources else p.product_resources || jsonb_build_object('nested', array_agg(p.file_data)) end) from 
(select to_jsonb(pr.data) as product_data, 
(case when ow.data isnull then jsonb_build_object(lower(o.type), to_jsonb(o.data))
else jsonb_build_object('user', jsonb_build_object(lower(o.type), to_jsonb(o.data)) || jsonb_build_object(lower(ow.type), to_jsonb(ow.data))) end) as owner_data,
to_jsonb(pw.data) as product_resources, to_jsonb(s3.data) as file_data
from 
findresourcedata(:product_id) as pr
left join lateral findresourcedata(pr.owner) as o on true
left join lateral findresourcebyownerandtype(pr.owner,'PROFILE_IMAGE') as ow on true
left join lateral findresourcebyowner(:product_id) as pw on true
left join lateral findresourcebyowner(cast(pw.data ->> 'id' as varchar)) as s3 on true) p
group by p.product_data, p.owner_data, p.product_resources, p.file_data
