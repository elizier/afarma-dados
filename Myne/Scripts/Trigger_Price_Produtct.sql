create trigger insertproducttag after
insert
    on
    public.price for each row execute function tagproductinsert()
    
    
CREATE OR REPLACE FUNCTION public.tagproductinsert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


insert into tag(tag, tag_tsv) select a.tag1, a.to_tsvector from
(select concat(p.name,' ', p.producttype)  as tag1 , to_tsvector('portuguese', unaccent(concat(p.name,' ', p.producttype)))
from myneresourceinformation m, product p
where replace(m.mri, 'mri::', '') = p.id
except
select t.tag, t.tag_tsv from tag t) a;

insert into resourcetag(resource, tag) select a.id, a.tag_id from
(select m.id, t.id as tag_id 
from myneresourceinformation m, product p, tag t 
where replace(m.mri, 'mri::', '') = p.id and concat(p.name,' ', p.producttype) = t.tag
except
select r.resource, r.tag from resourcetag r) a;

RETURN NEW;

END;

$function$
;


update tag set tag_tsv = to_tsvector('portuguese', unaccent(tag))
