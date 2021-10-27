select r.* from pg_stat_activity r where r.backend_type='client backend'
order by r.query_start asc;
select pg_cancel_backend(30434);



create trigger updateview after
insert or update
    on
    public.accountability for each row execute function update_views()
    
    
    
    
CREATE OR REPLACE FUNCTION public.update_views()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN



UPDATE
    accountability 
SET
    views = (positives + negatives)
FROM
    (select a.id as id_1, a.positives as positives_1, a.negatives as negatives_1,
    a.views as views_1 
    from accountability a where a.views != (a.positives + a.negatives)) a
WHERE
    id = a.id_1;



RETURN NEW;

END;

$function$
;

create trigger updateview after
insert or update
    on
    public.accountability for each row execute function update_views()
    
    
    
UPDATE
    accountability 
SET
    views = (positives + negatives)
FROM
    (select a.id as id_1, a.positives as positives_1, a.negatives as negatives_1,
    a.views as views_1 
    from accountability a where a.views != (a.positives + a.negatives)) a
WHERE
    id = a.id_1;
    
    
 