-- public."like" definition

-- Drop table

-- DROP TABLE public."like";

CREATE TABLE global.research (
	id varchar(36) NOT NULL,
	createdate timestamp NOT NULL DEFAULT now(),
	"type" varchar(255) null,
	tag varchar(10240) NULL,
	ts_vector tsvector null,
	research_data json null 
);


select findmylearning('6a49706d-9be8-44bc-95a7-d8994150dc9b', 'NULO')

select findresourcebyowner()

select m.id
from myneresourceinformation m where m."type" = 'POST'
left join ownerresources o on m.id = o.slave
where o."type" = 'USER_POST'


left join findresourcedata(p.id) as pr on true

55f59dc6-9158-437b-ac40-981d30ca3b3f

select ud.type, ud.data, sd.type, sd.data--, pf.type,  pf.data 
from
(select u.user_id, m.type as slave_type, replace(m.mri, 'mri::','') as user_slaves from
(select u.id as user_id, o.slave as mri_id_slave, o.id as or_id, o.type, m.createdate from
(select distinct(r.to_id) as id from relationrequest r 
where r.status = 'ACCEPTED' and
(r.type = 'FOLLOWER' or r.type = 'PUPIL' or r.type = 'PARTNER')
and r.from_id = :user_id) u
left join myneresourceinformation m on replace(m.mri, 'mri::','') = u.id
left join ownerresources o on m.id = o."owner" 
where (o."type" = 'USER_POST' )
order by m.createdate desc, mri_id_slave asc
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5)
) u
left join myneresourceinformation m on u.mri_id_slave = m.id) u
left join lateral findresourcedata(u.user_id) as ud on true
left join lateral findresourcedata(u.user_slaves) as sd on true
left join lateral findresourcebyownerandtype(u.user_id, 'PROFILE_IMAGE') as pf on true





update ownerresources set "type" = o.real_type from
(select o.id as ow_id, o.real_type from 
(select o.id, o."type" , m."type" as owner_type, mr."type" as slave_type, concat(m."type",'_',mr."type") as real_type
from ownerresources o 
left join myneresourceinformation m on m.id = o.owner
left join myneresourceinformation mr on mr.id = o.slave) o
where o.type != o.real_type) o
where o.ow_id = id


update ownerresources set type = 'PRODUCT_MODULE' --and slave = mp.new_slave 

where "type" = 'MODULE_PRODUCT'




