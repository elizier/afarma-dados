select now()

SHOW hba_file;
select (uuid_generate_v4()


--Contar usuarios

select count(u.id)
from myneuser u;

-- Contar usuarios entre datas

select count(u.id)
from myneuser u
where u.createdate
between TO_DATE('11/08/2021','DD-MM-YYYY') and TO_DATE('13/08/2021','DD-MM-YYYY');

-- Número de seguidores

select count(u.id)
from public.userrelation u
where u.type ='FOLLOWER'
and u.to_id = :userid

--Listagem de Seguidores

select u.name 
from public.userrelation r, public.myneuser u
where u.id = r.from_id 
and r.to_id = :idfollow
and r.type = 'FOLLOWER'

-- Listagem que sigo


select u.name 
from public.userrelation r, public.myneuser u
where u.id = r.to_id
and   r.from_id = :idfollow
and r.type = 'FOLLOWER'

-- Número de pupilos

select count(u.id)
from public.userrelation u
where u.type ='PUPIL'
and u.to_id = :userid

--Listagem de Pupilos
select u.name 
from public.userrelation r, public.myneuser u
where u.id = r.from_id 
and r.to_id = :idmentor
and r.type = 'PUPIL'


-- Número de mentores

select count(u.id)
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = :userid

--Listagem de Mentores

select u.name 
from public.userrelation r, public.myneuser u
where u.id = r.from_id 
and r.to_id = :idpupil
and r.type = 'MENTOR'

-- Número de parceiros

select count(u.id)
from public.userrelation u
where u.type ='PARTNER'
and u.to_id = :userid

--Listagem de Parceiros

select u.name 
from public.userrelation r, public.myneuser u
where u.id = r.to_id 
and r.from_id = :idpartner
and r.type = 'PARTNER'

--Contar recursos por tipo

select count(distinct()



insert into public.myneresourceinformation (id, createdate, type, mri)  select u.id, u.now, u.type, u.mri
from (
select uuid_generate_v4() as id, concat('mri::', u.id) as mri, 'USER' as type, now() from public.myneuser u where u.id not in 
(
select right(m.mri, 36) as mri
from public.myneresourceinformation m 
where m.type = 'USER'
) u;

DO
$do$
BEGIN
   IF 
   (select m.type from public.myneresourceinformation m 
   where left(m.mri,36) = resource)=''
   THEN
      DELETE FROM orders;
   ELSE
      INSERT INTO orders VALUES (1,2,3);
   END IF;
END
$do$


do $$
declare
   resource varchar(40);
begin  

  select m.type 
  from public.myneresourceinformation m 
   where left(m.mri,36) = resource;
  
  if not found then
     raise notice 'Film not found';
  else
      if v_film.length >0 and v_film.length <= 50 then
		 len_description := 'Short';
	  elsif v_film.length > 50 and v_film.length < 120 then
		 len_description := 'Medium';
	  elsif v_film.length > 120 then
		 len_description := 'Long';
	  else 
		 len_description := 'N/A';
	  end if;
    
	  raise notice 'The % film is %.',
	     v_film.title,  
	     len_description;
  end if;
end $$

CREATE OR REPLACE FUNCTION public.findresourcedata(resource character varying)
 RETURNS  public.jsonresult
 LANGUAGE plpgsql
AS $function$
declare
   resource_t public.jsonresult;
begin
	
select uuid_generate_v4() as id,
(case when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'USER'
   then (select row_to_json(u) from (select * from public.myneuser u where u.id= replace(resource,'mri::','')) u)
   when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'POST'
    then (select row_to_json(p) from (select * from public.post p where p.id= replace(resource,'mri::','')) p)
     when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'SITE'
   then (select row_to_json(s) from  (select * from public.site s where s.id= replace(resource,'mri::','')) s)
   when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'PHONE'
   then (select row_to_json(p) from (select * from public.phone p where p.id= replace(resource,'mri::','')) p)
   when (select m.type 
  from public.myneresourceinformation m 
   where RIGHT(m.mri,36) = replace(resource,'mri::','') limit 1) = 'ADDRESS'
   then (select row_to_json(a) from (select * from public.address a where a.id= replace(resource,'mri::','')) a)
   else (select row_to_json(s) from (select * from public.s3file s where s.id= replace(resource,'mri::','')) s)
   end) as resourcedata
   into resource_t;
  return resource_t;

end;
$function$ ;


select public.findresourcedata('cd1993a7-4de2-4d69-a4ad-7bfe9244249e') as data


-- DROP TYPE jsonresult;

CREATE TYPE jsonresultowner AS (
owner varchar,
	id varchar,
	"data" json);


CREATE OR REPLACE FUNCTION public.findresourcebyowner(resource character varying)
 RETURNS  public.jsonresultowner
 LANGUAGE plpgsql
AS $function$
declare
   resource_t public.jsonresultowner%ROWTYPE;
begin
	for resource_t in
	
	
	CREATE OR REPLACE FUNCTION public.findresourcebyowner(resource character varying)
 RETURNS SETOF public.jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

select m.owner, f.* from public.myneresourceinformation m 
cross join lateral public.findresourcedata(m.mri) as f
where m.owner notnull and m.owner = resource
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;

select public.findresourcebyowner('fd80a235-bff2-4586-8fbb-fd3cd61744d7')




select row_to_json(m) from (select m.* from myneresourceinformation m) m

CREATE OR REPLACE FUNCTION public.user_slug()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN



update myneuser set slug=o.slugify from
(
select o.id as id1, slugify(concat(o.accountname, ' ',
(select (cast(max(substring(u.slug FROM '[0-9]+')) as numeric)+1) from public.myneuser u
where u.slug notnull))) from
(
select o.id, slugify(o.accountname) as accountname,  ROW_NUMBER() OVER(ORDER BY o.id) AS RowNumber
from public.myneuser o  where o.slug isnull
) o) o
where o.id1=id;



RETURN NEW;

END;

$function$
;



CREATE OR REPLACE FUNCTION public.fn_test_dynamic_sql(
	tbl_name text
	collumn_name text)
    RETURNS TABLE() 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$
BEGIN
RETURN QUERY 

EXECUTE format('update myneuser set slug=o.slugify from
(
select o.id as id1, slugify(concat(o.accountname, ' ',
(select (cast(max(substring(u.slug FROM '[0-9]+')) as numeric)+1) from public.myneuser u
where u.slug notnull))) from
(
select o.id, slugify(o.accountname) as accountname,  ROW_NUMBER() OVER(ORDER BY o.id) AS RowNumber
from public.myneuser o  where o.slug isnull
) o) o
where o.id1=id;',tbl_name,collumn_name);

 END;
$BODY$;


update public.post set createdate = now()



select public.findresourcebyowner('fd80a235-bff2-4586-8fbb-fd3cd61744d7')


CREATE OR REPLACE FUNCTION public.findresourcebyowner(resource character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

select m.owner, m.type, f.* from public.myneresourceinformation m 
cross join lateral public.findresourcedata(m.mri) as f
where m.owner notnull and m.owner = resource
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;



DROP TYPE jsonresultowner;

CREATE TYPE jsonresultowner AS (
	"owner" varchar,
	"type" varchar,
	id varchar,
	"data" json);




CREATE OR REPLACE FUNCTION public.testecoluna(coluna character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   generico_ean varchar;
begin
	
	select (select concat('myneresourceinformation.', coluna) ) from myneresourceinformation
	limit 1
into generico_ean;
   
   return generico_ean;
end;
$function$
;

select public.testecoluna(owner)


-- Drop table

-- DROP TABLE public.post;

CREATE TABLE public.like (
	id varchar(36) NOT NULL,
	createdate timestamp NOT NULL DEFAULT now(),
	type varchar(255) null,
	CONSTRAINT like_pkey PRIMARY KEY (id)
);




--Insert mri
update public.myneresourceinformation set tags='yoda, fotodeperfil, foto, perfil, image, imagem, jpeg'
where id='b6ac6004-d1fd-4c58-a83c-113ef76ecb17'



-- Busca Global
SELECT * FROM public.myneresourceinformation mri where
(to_tsvector('portuguese',encode(mri.tags, 'escape')) @@
to_tsquery('portuguese',(select replace(unaccent(upper(trim(:busca))),' ',' | ')))
or upper(unaccent(encode(mri.tags, 'escape'))) like concat('%',upper(unaccent(:busca)),'%'))
order by (similarity(upper(unaccent(encode(mri.tags, 'escape'))), upper(unaccent(:busca)))) desc 



select m.owner, m.type, f.* from public.myneresourceinformation m 
cross join lateral public.findresourcedata(m.mri) as f
where m.type = 'POST' and  m.owner notnull and m.owner in 
(select distinct(i.id) from
(
(
select r.from_id as id
from public.userrelation r
where r.to_id = :id
and r.type = 'MENTOR')
union all
(select r.to_id 
from public.userrelation r
where   r.from_id = :id
and r.type = 'FOLLOWER')
union all 
(select :id)
) i)

select public.findfeedbyuser('e823079e-c537-499c-9c16-72f3d3060ec7')
'55f59dc6-9158-437b-ac40-981d30ca3b3f'

CREATE OR REPLACE FUNCTION public.findfeedbyuser(user_id character varying)
 RETURNS SETOF jsonresultowner
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.jsonresultowner%ROWTYPE;
BEGIN

 	FOR resource_t in

 	select m.owner, m.type, f.* from public.myneresourceinformation m 
cross join lateral public.findresourcedata(m.mri) as f
where m.type = 'POST' and  m.owner notnull and m.owner in 
(select distinct(i.id) from
(
(
select r.from_id as id
from public.userrelation r
where r.to_id = user_id
and r.type = 'MENTOR')
union all
(select r.to_id 
from public.userrelation r
where   r.from_id = user_id
and r.type = 'FOLLOWER')
union all 
(select user_id)
) i)
 
loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;


--Listagem de Mentores
(select distinct(i.id) from
(
(
select r.from_id as id
from public.userrelation r
where r.to_id = :id
and r.type = 'MENTOR')
union all
(select r.to_id 
from public.userrelation r
where   r.from_id = :id
and r.type = 'FOLLOWER')
union all 
(select '55f59dc6-9158-437b-ac40-981d30ca3b3f')
) i)



			
			select to_tsvector('portuguese','yoda, fotodeperfil, foto, perfil, image, imagem, jpeg') 
			
			select to_tsvector('portuguese',encode(mri.tags, 'escape')), (mri.tags) from public.myneresourceinformation mri where mri.id='b6ac6004-d1fd-4c58-a83c-113ef76ecb17'
			
			
select 
			
select replace(m.mri ,'mri::','') as post_id , m.id, uuid_generate_v4() from myneresourceinformation m, accountability p
where replace(m.mri ,'mri::','') = p.id and m.id not in (select o."slave" from ownerresources o where o."type" = 'POST_ACCOUNTABILITY') 



287165c8-050f-4fa5-a170-1a0cc0fc4c1f
6ce19cb2-83ca-4486-a317-f8de3eb8ea5a
be19df13-f332-4a07-a762-8a93d38d1a95
389b296c-31c4-4002-aa77-2931f4a4faf7
bfa0aaae-d0e6-45d6-93b2-8d60fd57602b
9665ead6-2a34-40c0-a6f2-bbb95f9e3beb
f67f3042-e596-45cd-be56-170fbb3964a7
82000de8-a113-401d-a787-4227d17d49d7
0c44529e-7d79-4d4e-b2d7-2666ee383b8b
684ba265-982e-4322-9f9d-842aefde4bff
fa16a497-87fb-4110-bad6-3a2cb8d7c529
da623bfa-ac2c-4f8b-9573-7ab1fa6cbd65
87d82856-a1f2-4e2b-8905-1ca711d2c8b3
e1898caa-7d6c-4818-9016-ceab24fde779
8be0e2cc-208f-4b34-a96d-dd3317c24e1b
00704eb2-377c-4678-a232-3870e4f1a1a9
92796eb2-a731-429c-9f9d-3de29b3fbf37
c144db5c-06a4-4709-a221-6ad2a15b0491
1ee292f9-f581-4a86-a99a-345480d3e822
8620fa97-06a1-43af-a9f5-3088283d3040
ad824b08-9e6c-42e3-9dc3-f71651a202c4
e05cef7a-0e4b-458c-8665-3287ae8d1e2d
ab199714-54e4-4482-aa37-75425a9c448a
e9cde5ff-fa8d-4267-beef-af81d942e7ac
a4b707d5-ecae-471b-85ba-dc6d9b28c851
b6b945f4-06a0-42c3-a7ce-a51d4c33b7a1
898a6ea0-c302-4ed4-99f7-259dd2d61ffa
3514c61d-fcc9-4d13-9f2c-3a731ff5279b
f294a317-1e38-4818-bf6f-7c50a60d861d
25ba9db6-a7fd-4842-b535-b08544a5b723
945285cd-dc37-4402-96b5-da6583019a38
9f365cbc-ee3c-413d-aa5f-ae86453c4c97
ffaabe60-d0ba-430c-a16b-f9945c465990
89841e9b-7e5a-4f37-b266-fedce5d0cbb3
bb8023cc-abe9-4571-aeb0-2f86515ae803
e779d3f2-f27a-4020-9d2a-4a845dc749b9
44febc88-ae11-42f5-ab62-d7c8ca2e150c
959943b2-de78-452e-8645-fc178b86bdc1
3fc1e975-f9bd-4ecb-b762-d54a54fd13ff
4942ec22-726f-442c-97c7-4d819c0eabfa
43f29535-696f-47e5-9742-1c54580eca3f
43d13b40-b271-4b50-912a-63d2395bc2d2






INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('287165c8-050f-4fa5-a170-1a0cc0fc4c1f', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('6ce19cb2-83ca-4486-a317-f8de3eb8ea5a', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('be19df13-f332-4a07-a762-8a93d38d1a95', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('389b296c-31c4-4002-aa77-2931f4a4faf7', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('bfa0aaae-d0e6-45d6-93b2-8d60fd57602b', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('9665ead6-2a34-40c0-a6f2-bbb95f9e3beb', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('f67f3042-e596-45cd-be56-170fbb3964a7', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('82000de8-a113-401d-a787-4227d17d49d7', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('0c44529e-7d79-4d4e-b2d7-2666ee383b8b', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('684ba265-982e-4322-9f9d-842aefde4bff', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('fa16a497-87fb-4110-bad6-3a2cb8d7c529', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('da623bfa-ac2c-4f8b-9573-7ab1fa6cbd65', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('87d82856-a1f2-4e2b-8905-1ca711d2c8b3', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('e1898caa-7d6c-4818-9016-ceab24fde779', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('8be0e2cc-208f-4b34-a96d-dd3317c24e1b', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('00704eb2-377c-4678-a232-3870e4f1a1a9', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('92796eb2-a731-429c-9f9d-3de29b3fbf37', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('c144db5c-06a4-4709-a221-6ad2a15b0491', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('1ee292f9-f581-4a86-a99a-345480d3e822', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('8620fa97-06a1-43af-a9f5-3088283d3040', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('ad824b08-9e6c-42e3-9dc3-f71651a202c4', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('e05cef7a-0e4b-458c-8665-3287ae8d1e2d', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('ab199714-54e4-4482-aa37-75425a9c448a', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('e9cde5ff-fa8d-4267-beef-af81d942e7ac', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('a4b707d5-ecae-471b-85ba-dc6d9b28c851', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('b6b945f4-06a0-42c3-a7ce-a51d4c33b7a1', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('898a6ea0-c302-4ed4-99f7-259dd2d61ffa', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('3514c61d-fcc9-4d13-9f2c-3a731ff5279b', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('f294a317-1e38-4818-bf6f-7c50a60d861d', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('25ba9db6-a7fd-4842-b535-b08544a5b723', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('945285cd-dc37-4402-96b5-da6583019a38', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('9f365cbc-ee3c-413d-aa5f-ae86453c4c97', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('ffaabe60-d0ba-430c-a16b-f9945c465990', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('89841e9b-7e5a-4f37-b266-fedce5d0cbb3', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('bb8023cc-abe9-4571-aeb0-2f86515ae803', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('e779d3f2-f27a-4020-9d2a-4a845dc749b9', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('44febc88-ae11-42f5-ab62-d7c8ca2e150c', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('959943b2-de78-452e-8645-fc178b86bdc1', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('3fc1e975-f9bd-4ecb-b762-d54a54fd13ff', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('4942ec22-726f-442c-97c7-4d819c0eabfa', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('43f29535-696f-47e5-9742-1c54580eca3f', 0, 0, 0);
INSERT INTO public.accountability (id, negatives, positives, "views") VALUES('43d13b40-b271-4b50-912a-63d2395bc2d2', 0, 0, 0);





INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '287165c8-050f-4fa5-a170-1a0cc0fc4c1f');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '6ce19cb2-83ca-4486-a317-f8de3eb8ea5a');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'be19df13-f332-4a07-a762-8a93d38d1a95');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '389b296c-31c4-4002-aa77-2931f4a4faf7');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'bfa0aaae-d0e6-45d6-93b2-8d60fd57602b');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '9665ead6-2a34-40c0-a6f2-bbb95f9e3beb');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'f67f3042-e596-45cd-be56-170fbb3964a7');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '82000de8-a113-401d-a787-4227d17d49d7');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '0c44529e-7d79-4d4e-b2d7-2666ee383b8b');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '684ba265-982e-4322-9f9d-842aefde4bff');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'fa16a497-87fb-4110-bad6-3a2cb8d7c529');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'da623bfa-ac2c-4f8b-9573-7ab1fa6cbd65');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '87d82856-a1f2-4e2b-8905-1ca711d2c8b3');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'e1898caa-7d6c-4818-9016-ceab24fde779');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '8be0e2cc-208f-4b34-a96d-dd3317c24e1b');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '00704eb2-377c-4678-a232-3870e4f1a1a9');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '92796eb2-a731-429c-9f9d-3de29b3fbf37');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'c144db5c-06a4-4709-a221-6ad2a15b0491');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '1ee292f9-f581-4a86-a99a-345480d3e822');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '8620fa97-06a1-43af-a9f5-3088283d3040');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'ad824b08-9e6c-42e3-9dc3-f71651a202c4');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'e05cef7a-0e4b-458c-8665-3287ae8d1e2d');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'ab199714-54e4-4482-aa37-75425a9c448a');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'e9cde5ff-fa8d-4267-beef-af81d942e7ac');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'a4b707d5-ecae-471b-85ba-dc6d9b28c851');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'b6b945f4-06a0-42c3-a7ce-a51d4c33b7a1');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '898a6ea0-c302-4ed4-99f7-259dd2d61ffa');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '3514c61d-fcc9-4d13-9f2c-3a731ff5279b');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'f294a317-1e38-4818-bf6f-7c50a60d861d');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '25ba9db6-a7fd-4842-b535-b08544a5b723');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '945285cd-dc37-4402-96b5-da6583019a38');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '9f365cbc-ee3c-413d-aa5f-ae86453c4c97');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'ffaabe60-d0ba-430c-a16b-f9945c465990');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '89841e9b-7e5a-4f37-b266-fedce5d0cbb3');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'bb8023cc-abe9-4571-aeb0-2f86515ae803');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', 'e779d3f2-f27a-4020-9d2a-4a845dc749b9');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '44febc88-ae11-42f5-ab62-d7c8ca2e150c');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '959943b2-de78-452e-8645-fc178b86bdc1');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '3fc1e975-f9bd-4ecb-b762-d54a54fd13ff');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '4942ec22-726f-442c-97c7-4d819c0eabfa');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '43f29535-696f-47e5-9742-1c54580eca3f');
INSERT INTO public.myneresourceinformation (class_, "type", mri ) VALUES('etc.bda.myne.negocio.entity.Accountability', 'ACCOUNTABILITY', '43d13b40-b271-4b50-912a-63d2395bc2d2');









INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'a315d1b2-b3c3-497c-bb48-0dc3a66f083e',	'89bd003c-c633-42bb-8c6e-1eda678d17f5');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '615ad5ca-8b1a-4150-951a-616a4468a6e7',	'61f937c5-2486-4196-b178-f5f637784682');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '5514d35a-5d7e-4069-8a8b-264033fe3985',	'f5719193-e273-4c77-b050-16fdbd7d1ae1');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '9fb8b759-e460-47f0-bbe4-4b4fa11c3ac5',	'10bd8e12-71ab-4f48-8f1f-4aa5bfd49186');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'c45ce444-9331-4e7e-a88e-d1e111ce7564',	'fedf6967-42ab-4c1e-8936-ef4e7e9a4385');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'f7b83e9d-84fd-4a55-8cd7-d9675782b0e4',	'efe82551-0d69-41b4-91b4-a7624e9f2a59');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'fe6e3b49-8e56-4272-9432-dea83f406b7e',	'a21aaf06-d795-4367-a5ca-e97bce6791f4');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '74df9fe0-79ce-4069-9d81-5fc76b630673',	'bdf3a2fc-9c6d-4eae-aac8-8fbf4992c271');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'd23dbc39-974e-482e-9f6a-df415d6967a1',	'588d8b08-bbaf-4b72-8ebc-b2b1657dc2ff');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'c5d68bad-2d1a-4215-9d1f-b4ec3f951893',	'270490ba-ad13-4be5-ad79-265637a6fe4a');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '00b8955a-6c5f-4753-884c-26bff9e244f8',	'3c6b4bb8-ab12-47e0-9818-09d27bb380d7');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'cea05397-60a9-46c9-a45e-472b7d5cfadd',	'fe1185b6-d1c7-4ab9-b4d8-db0ce126e97f');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '6f3723bd-1315-41c1-aea4-698ce6ac7c41',	'bcbed0b1-d031-4d7e-b2f4-71c6113dcb61');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '5a735cf2-cdb1-4d14-80af-d1e11d90b637',	'd74f479f-c8c3-4da8-b633-4f3d615ceee2');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '87ef5111-dd57-4b54-91c6-f969ffb2ca50',	'917aa7af-73e7-4890-82af-f82d88b05f81');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '4f6e2c0c-f817-402b-ac7e-ca9380d67bd7',	'458d1b21-12b2-4dde-9ab6-e056f12b4a17');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'ee62dcc1-1eb3-4c03-96dc-ee297607ee29',	'e10fa309-52ab-4a3c-902e-c4276cdce4e8');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '6715b432-f54c-4744-82d3-a1b8954eb830',	'a01440a3-4cd4-48ac-b425-87ff3dbacd88');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '5cfbc808-c084-4ca7-9c6a-629e6628b0f0',	'aecf9161-39c6-488f-8231-8120c6a8c143');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '6810d725-93cb-4206-bdc3-137a80d1e53f',	'5d18d6f4-9aee-4bf1-9893-efdc7bb9b9a2');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '845416fc-ab17-4395-a867-f2a228998bd9',	'81ecb649-c44f-4cbf-94b8-f9b752dac1d2');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '74aed13b-60e4-471d-8b2a-8067db96dec4',	'c3448487-61ba-4e86-9bb4-2c090cbefb44');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '0fe847de-9b07-4f66-b13c-053dedf8825d',	'e996f8eb-6968-4ca3-b37d-15f810929e38');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '0fc7a8f1-6bb3-4273-ba92-99d3501cff3a',	'd3ebec66-c095-4e1e-92ff-d8224d4c5316');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '461c193e-bb61-4671-829b-43e7088bfa6b',	'f0ce288c-07a6-4b47-a5d1-6747fec6dfe9');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '22113a86-ca3e-4aa4-8c58-8e5fc50b4251',	'4fcbb67d-b926-4406-af1a-8caa70259d14');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'a9654649-32a5-4e8b-bd21-ee9cef1a3c35',	'4cca1e57-8044-4f94-ad7f-fa34188855ec');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '76026e6c-9701-485c-b1df-ff90ec7a8d82',	'b376a160-1155-46b1-95a8-91c93eaf654a');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'd77c7250-8d0a-4f02-8964-c2ad1d71a60f',	'33f83a11-ff26-4900-895a-ed3a95df35d7');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '599cf176-0d59-452f-a33b-4cc5617a7f5c',	'73d6726a-11e9-40f7-9eb3-daa206f95733');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '03e012a3-4818-4995-a347-2d6436aa51fe',	'3a9e5af6-d57b-400a-9a53-63a29877554f');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'e665b2f3-6839-4f34-a0df-72ce092a07e2',	'79ee8916-6efb-4008-be51-34b4535fba78');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'e30e10dc-a140-4994-8970-f6ba97b2858d',	'c25afde6-9d00-4ae3-88a2-72a7e40f7eb5');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', 'd0dc323a-90fc-4b71-9da3-9053608c3fca',	'63a8b100-5839-4a49-ac8a-583c3674e76a');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '8121eb0f-5ca4-4166-98ed-a0674f3da446',	'cf4941a7-8d43-49cf-85be-22ce75d1ed9b');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '1e330d6b-0416-43dc-87aa-bb8f5a4bf100',	'8f92c1e3-8fbc-4c27-87ab-65047964417a');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '5fb98e3a-8e68-45f8-8c8e-be566651ffa8',	'6d7bd21f-35de-428f-9edd-8f2fa0e1773f');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '5bbae4ed-a431-4e6e-a329-a681cd088dd3',	'ef8db94f-dc2a-4ca0-a7b2-9b5c8b030eed');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '26b1b262-5358-4332-99ca-9773c85f0567',	'51873852-3235-4041-8491-3fccec62d709');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '062cd909-cbc5-4d70-9730-9d89cf32fb49',	'23b71922-06cd-4f82-bbcb-4501e39dc5e5');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '347759ea-ff98-43d3-912c-0bed4ca0287d',	'02017086-7f93-41b1-8eda-4cebfab1fef8');
INSERT INTO public.ownerresources ("type", "owner", slave) VALUES( 'POST_ACCOUNTABILITY', '6964f74f-cad3-4ce0-b6ba-b9aa97ceec18',	'90daba97-020f-4dd7-b8a7-0a5da3f0e430');



select listresourcesbytype('POST', 10, 0);



