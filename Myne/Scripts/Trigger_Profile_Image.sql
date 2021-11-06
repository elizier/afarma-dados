SELECT * FROM myneuser where slug = 'elizier-santos'


select * from myneresourceinformation m where replace(m.mri, 'mri::', '') in 


SELECT u.id FROM myneuser u WHERE u.id NOT IN 
select * from myneresourceinformation m where replace(m.mri,'mri::', '') in
('c74f1e72-e674-4f44-ba37-d625c8d49e0f',
'6a49706d-9be8-44bc-95a7-d8994150dc9b',
'7a217f2b-7fcd-46b0-91e7-aa88c4b36f1c')



create trigger update_profile_image after
insert
    on
    public.s3file for each row execute function public.profile_image_update()



CREATE OR REPLACE FUNCTION public.profile_image_update()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

delete from s3file where id in
(select b.s3_id from 
(
select m.id as id_f, min(cast(f.data ->> 'createDate' AS timestamp)) as "date_f" from myneuser m
left join lateral findresourcebyownerandtype(m.id, 'PROFILE_IMAGE') as f on true
where f.data notnull
group by m.id
having count(m.id)>1
) a,
(
select m.id, cast(f.data ->> 'id' AS VARCHAR) as s3_id, cast(f.data ->> 'createDate' AS timestamp) as "date" from myneuser m
left join lateral findresourcebyownerandtype(m.id, 'PROFILE_IMAGE') as f on true
where f.data notnull
) b
where a.id_f = b.id and a.date_f = b.date);

delete from ownerresources where slave in
(select m.id from myneresourceinformation m,
(select replace(m.mri, 'mri::', '') as id from myneresourceinformation m where m."type" = 'PROFILE_IMAGE'
except
select s.id from s3file s) s
where s.id = replace(m.mri, 'mri::', ''));

delete from myneresourceinformation where id in
(select m.id from myneresourceinformation m,
(select replace(m.mri, 'mri::', '') as id from myneresourceinformation m where m."type" = 'PROFILE_IMAGE'
except
select s.id from s3file s) s
where s.id = replace(m.mri, 'mri::', ''));



RETURN NEW;

END;

$function$
;

update myneuser set "method" = upper("method")
