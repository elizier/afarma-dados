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



(select row_to_json(ud.*) as user_data, u.slave_type, p.id as post_id, row_to_json(p.*) as post_data , o.slave
from
(select u.id_usuario_no_mri, u.user_id, m.type as slave_type, replace(m.mri, 'mri::','') as user_slaves from
(select m.id as id_usuario_no_mri, u.id as user_id, o.slave as mri_id_slave, m.createdate from
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
left join myneuser ud on ud.id = u.user_id
left join post p on u.user_slaves = p.id 
left join ownerresources o on o."owner" = u.id_usuario_no_mri
where o."type" = 'USER_PROFILE_IMAGE') u
left join 





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




