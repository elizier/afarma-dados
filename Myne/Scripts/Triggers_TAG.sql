CREATE OR REPLACE FUNCTION public.taginsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


insert into tag(tag, tag_tsv) select a.tag1, a.to_tsvector from
(select concat(u.accountname,' ', u."name")  as tag1 , to_tsvector('portuguese', unaccent(concat(u.accountname,' ', u."name")))
from myneresourceinformation m, myneuser u
where replace(m.mri, 'mri::', '') = u.id
except
select t.tag, t.tag_tsv from tag t) a;

insert into resourcetag(resource, tag) select a.id, a.tag_id from
(select m.id, t.id as tag_id 
from myneresourceinformation m, myneuser u, tag t 
where replace(m.mri, 'mri::', '') = u.id and concat(u.accountname,' ', u."name") = t.tag
except
select r.resource, r.tag from resourcetag r) a;

RETURN NEW;

END;

$function$
;



create trigger inserttag after
insert
    on
    public.myneuser for each row execute function taginsert()

