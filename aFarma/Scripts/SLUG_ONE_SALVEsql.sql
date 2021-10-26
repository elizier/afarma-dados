CREATE EXTENSION IF NOT EXISTS "unaccent";

CREATE OR REPLACE FUNCTION slugify("value" TEXT)
RETURNS TEXT AS $$
  -- removes accents (diacritic signs) from a given string --
  WITH "unaccented" AS (
    SELECT unaccent("value") AS "value"
  ),
  -- lowercases the string
  "lowercase" AS (
    SELECT lower("value") AS "value"
    FROM "unaccented"
  ),
  -- remove single and double quotes
  "removed_quotes" AS (
    SELECT regexp_replace("value", '[''"]+', '', 'gi') AS "value"
    FROM "lowercase"
  ),
  -- replaces anything that's not a letter, number, hyphen('-'), or underscore('_') with a hyphen('-')
  "hyphenated" AS (
    SELECT regexp_replace("value", '[^a-z0-9\\-_]+', '-', 'gi') AS "value"
    FROM "removed_quotes"
  ),
  -- trims hyphens('-') if they exist on the head or tail of the string
  "trimmed" AS (
    SELECT regexp_replace(regexp_replace("value", '\-+$', ''), '^\-', '') AS "value"
    FROM "hyphenated"
  )
  SELECT "value" FROM "trimmed";
$$ LANGUAGE SQL STRICT IMMUTABLE;


CREATE OR REPLACE FUNCTION public.user_slug()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN



update onesalveuser set slug=o.slugify from
(
select o.id as id1, slugify(concat(o.accountname, ' ',
(select (cast(max(substring(u.slug FROM '[0-9]+')) as numeric)+1) from public.onesalveuser u
where u.slug notnull))) from
(
select o.id, slugify(o.accountname) as accountname,  ROW_NUMBER() OVER(ORDER BY o.id) AS RowNumber
from public.onesalveuser o  where o.slug isnull
) o) o
where o.id1=id;



RETURN NEW;

END;

$function$
;


create trigger update_codigo_slug after
insert
    on
    public.onesalveuser for each row execute function user_slug()
    
    
    


update onesalveuser set slug=o.slugify from
(
select o.id as id1, slugify(concat(o.accountname, ' ', o.rownumber)) from
(
select o.id, slugify(o.accountname) as accountname,  ROW_NUMBER() OVER(ORDER BY o.id) AS RowNumber
from public.onesalveuser o  where o.profile_id = 2) o) o
where o.id1=id



update onesalveuser set slug=o.slugify from
(
select o.id as id1, slugify(concat(o.accountname, ' ',
(select (cast(max(substring(u.slug FROM '[0-9]+')) as numeric)+1) from public.onesalveuser u
where u.slug notnull))) from
(
select o.id, slugify(o.accountname) as accountname,  ROW_NUMBER() OVER(ORDER BY o.id) AS RowNumber
from public.onesalveuser o  where o.slug isnull
) o) o
where o.id1=id

select uuid_generate_v4()

insert into public.onesalveuser values ('313786a9-5377-45bc-b1e3-1ccd522fdaf6', 'Matheus Lima', true, now(), null,
'matheuslimabranco@outlook.com', 'Matheus Lima', null, null, 3);






select slugify(name) from myneuser



CREATE FUNCTION 
RETURNS NVARCHAR(MAX)
AS BEGIN
    select slugify()
end





CREATE OR REPLACE FUNCTION slugcolumn(column_slug character varying, table_slug character varying) 
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   slug_table varchar;
begin
	
	select slugify(column_slug) from table_slug

into slug_table;
   
   return slug_table;
end;
$function$
;

select slugcolumn('name', 'myneuser');





CREATE OR REPLACE FUNCTION public.slugcolumn(
	tbl_name character varying,
	clmn_name character varying)
    RETURNS TABLE(slug json)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
   -- ROWS 1000
AS $BODY$
BEGIN
RETURN QUERY 

EXECUTE format('select row_to_json(s) as slug from (select id, slugify(%s) as slug from %I) s',clmn_name,tbl_name);

 END;
$BODY$;




CREATE TYPE slugresult AS (
	id varchar,
	slug text);


select public.slugcolumn('myneuser','name')

