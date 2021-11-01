select p.id, p.active, p.createdate as "createDate", p.description, p.name, p.productType, to_json(p.details)
from public.product p  where p.id = :mri_id