INSERT INTO public.s3file
(id, createdate, description, filename, filetype, s3url, solicitacaoid)
values
(uuid_generate_v4(), now(), 'insight stormtrooper', 'insightstorm', 'JPG', 'https://i.pinimg.com/564x/cd/01/f1/cd01f1666d264a14fc839d83d6326594.jpg', ''),
(uuid_generate_v4(), now(), 'insight darth vader', 'insightdarth', 'JPG', 'https://a-static.mlcdn.com.br/1500x1500/quadro-decorativo-darth-vader-star-wars-super-herois-geek-decoracoes-com-moldura-g16-vital-quadros/vitalquadrosdobrasil/06656550405/fa5755017742567551bf33476ed4539e.jpg', ''),
(uuid_generate_v4(), now(), 'insight obiwan 1', 'insightobiwan1', 'JPG', 'https://i.pinimg.com/originals/ea/7f/f1/ea7ff16df2421ac31d2dd764fe8a238e.jpg', ''),
(uuid_generate_v4(), now(), 'insight obiwan 2', 'insightobiwan2', 'JPG', 'https://loginportal.funnyjunk.com/pictures/Obiwan+movie+confirmed+httpwwwhollywoodreportercomheatvisionobiwankenobistarwarsfilmplanneddirectortalks1030505_49734f_6363224.jpg', ''),
(uuid_generate_v4(), now(), 'insight yoda 1', 'insightyoda1', 'PNG', 'https://static.wikia.nocookie.net/starwars/images/d/d6/Yoda_SWSB.png', ''),
(uuid_generate_v4(), now(), 'insight yoda 2', 'insightyoda2', 'JPG', 'https://wallpaperaccess.com/full/1379113.jpg', '');




delete from insight 

011aebed-441e-43ad-a58c-1b630e10af50	true	2021-10-22 04:08:38.771	IMAGE
7f7e1e4f-6d0f-424b-a418-a4d72181d287	true	2021-10-22 04:08:38.771	IMAGE
6d7aab72-b930-490e-a346-eedaab069e68	true	2021-10-22 04:08:38.771	IMAGE
cd1ed303-def6-4e7e-a750-4c236d109ac6	true	2021-10-22 04:08:38.771	IMAGE
3c6b1854-bce4-4656-bf67-d55f93d11d22	true	2021-10-22 04:08:38.771	IMAGE
b08ebe42-4a46-4ad4-9097-152bdb57f477	true	2021-10-22 04:08:38.771	IMAGE


insert into myneresourceinformation (class_, mri, "type")
select 'etc.bda.myne.negocio.entity.S3File', concat('mri::',i.id), 'IMAGE' from 
(select i.id from s3file i order by i.createdate desc limit 6) i

select uuid_generate_v4()
ef34e718-fb2c-4469-b2df-73fc2dfb3e73
38badf6e-f441-490c-b06b-7f28cd6d7886
da5d052f-f458-4621-85a0-5b7c5041e1d2
5a1683f2-4886-4c4b-abf5-833e91ebdb06
57e9cff2-8d85-4a01-b70b-0540768150a8
c6dc7fbd-b0c6-4cf1-9973-d8421023bd8f

insert into accountability values ('ef34e718-fb2c-4469-b2df-73fc2dfb3e73', 0, 0, 0, null); 
insert into accountability values ('38badf6e-f441-490c-b06b-7f28cd6d7886', 0, 0, 0, null); 
insert into accountability values ('da5d052f-f458-4621-85a0-5b7c5041e1d2', 0, 0, 0, null); 
insert into accountability values ('5a1683f2-4886-4c4b-abf5-833e91ebdb06', 0, 0, 0, null); 
insert into accountability values ('57e9cff2-8d85-4a01-b70b-0540768150a8', 0, 0, 0, null); 
insert into accountability values ('c6dc7fbd-b0c6-4cf1-9973-d8421023bd8f', 0, 0, 0, null); 


select sf.*, m.id from s3file sf, myneresourceinformation m where replace(m.mri,'mri::', '') = sf.id order by sf.createdate desc limit 6 




insert into ownerresources(type, owner, slave) values('USER_INSIGHT', 'a02b2665-8e37-4bef-b52c-543d04cafa8c',	'917beb15-9f86-4051-8f3f-7a790b778c0a');
insert into ownerresources(type, owner, slave) values('USER_INSIGHT', 'a02b2665-8e37-4bef-b52c-543d04cafa8c',	'bedb5324-9ebe-4e3d-9b0e-ec0f73c48c56');
insert into ownerresources(type, owner, slave) values('USER_INSIGHT', '3007658e-a02b-46e2-baaf-32deccde4797',	'c853cbee-9e75-48e7-b1ee-a9a455d3811c');
insert into ownerresources(type, owner, slave) values('USER_INSIGHT', '3007658e-a02b-46e2-baaf-32deccde4797',	'8e33c3ce-cc59-4204-9c5c-e345a153c4d9');
insert into ownerresources(type, owner, slave) values('USER_INSIGHT', 'e0c2ce7d-2659-44a1-9664-6c02528eb495',	'22ac9ec5-cbe3-4a80-9d36-5ca3d8d2d146');
insert into ownerresources(type, owner, slave) values('USER_INSIGHT', 'bd34d29f-9740-4017-a98b-016ad2a1da22',	'87bac21c-aff2-4688-b1d1-dab0a95550ab');



insert into ownerresources(type,owner, slave) values('INSIGHT_IMAGE', '917beb15-9f86-4051-8f3f-7a790b778c0a',	'd1b590d1-fa21-4bee-908e-c4e8c21a3867');
insert into ownerresources(type,owner, slave) values('INSIGHT_IMAGE', '87bac21c-aff2-4688-b1d1-dab0a95550ab',	'd299aca6-7df1-45fe-bd11-80d3d9ce0267');
insert into ownerresources(type,owner, slave) values('INSIGHT_IMAGE', '22ac9ec5-cbe3-4a80-9d36-5ca3d8d2d146',	'f998f5d5-02df-4809-94e1-73e429ec7344');
insert into ownerresources(type,owner, slave) values('INSIGHT_IMAGE', 'c853cbee-9e75-48e7-b1ee-a9a455d3811c',	'1bb2b14b-7f27-4bf1-aafc-29ae5aa12ce0');
insert into ownerresources(type,owner, slave) values('INSIGHT_IMAGE', 'bedb5324-9ebe-4e3d-9b0e-ec0f73c48c56',	'051d651f-cf6f-4122-a6c0-e936d3c838cb');
insert into ownerresources(type,owner, slave) values('INSIGHT_IMAGE', '8e33c3ce-cc59-4204-9c5c-e345a153c4d9',	'2f737986-75ae-4c03-9ce3-f7d3589ea073');


select findresourcebyowner('8e459487-fa68-4326-8690-b58c261b6212')


select listmynerelations('55f59dc6-9158-437b-ac40-981d30ca3b3f', 'FOLLOWER',10,0)





select cast(uuid_generate_v4() as varchar) as id, 'INSGIHT' as type, to_json(r.data) from 
(select r.user || jsonb_build_object('insight',array_agg(r.data)) as data from 
(select r.user, r.insight || jsonb_build_object('nested', array_agg(r.slave)) as data from
(select to_jsonb(h.data) || jsonb_build_object('relation',r.relation) || jsonb_build_object('profile_image',jsonb(g.data)) as user, 
jsonb_build_object('type', i.type) || jsonb(i.data) as insight,  jsonb_build_object('type', f.type) || jsonb(f.data) as slave from
(
(select * from
(select u.to_id, 'FOLLOWING' as relation
from public.userrelation u
where u.type ='FOLLOWER'
and u.from_id = :user_id) a
except
(select u.to_id, 'FOLLOWING'
from public.userrelation u
where u.type ='PARTNER'
and u.from_id = :user_id)
except
(select u.from_id, 'FOLLOWING'
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = :user_id)
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5))
union all 
(select * from 
(select u.to_id, 'PARTNER'
from public.userrelation u
where u.type ='PARTNER'
and u.from_id = :user_id) a
except
(select u.from_id, 'PARTNER'
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = :user_id)
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5))
union all
(select * from 
(select u.from_id, 'MENTOR'
from public.userrelation u
where u.type ='MENTOR'
and u.to_id = :user_id) a
limit coalesce(:itens_by_page, 5)
offset coalesce(:page, 0) * coalesce(:itens_by_page, 5))
) r
cross join lateral findresourcebyowner(r.to_id) as i
cross join lateral findresourcebyowner(cast(i.data ->> 'id' as varchar)) as f
left join lateral findresourcebyowner(r.to_id) as g on true
cross join lateral findresourcedata(r.to_id) as h
where i.type = 'INSIGHT' and g.type = 'PROFILE_IMAGE') r
group by r.user, r.insight) r
group by r.user) r



select public.findmyneinsights(:user_id , :itens_by_page , :page)

CREATE OR REPLACE FUNCTION public.findmyneinsights(user_id character varying, itens_by_page integer, page integer)
 RETURNS SETOF mynejsontype
 LANGUAGE plpgsql
AS $function$
   DECLARE
      resource_t public.mynejsontype%ROWTYPE;
BEGIN

 	FOR resource_t in

SELECT cast(uuid_generate_v4() AS VARCHAR) AS id
	,'INSGIHT' AS type
	,to_json(r.data)
FROM (
	SELECT r.user || jsonb_build_object('insight', array_agg(r.data)) AS data
	FROM (
		SELECT r.user
			,r.insight || jsonb_build_object('nested', array_agg(r.slave)) AS data
		FROM (
			SELECT to_jsonb(h.data) || jsonb_build_object('relation', r.relation) || jsonb_build_object('profile_image', jsonb(g.data)) AS user
				,jsonb_build_object('type', i.type) || jsonb(i.data) AS insight
				,jsonb_build_object('type', f.type) || jsonb(f.data) AS slave
			FROM (
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'FOLLOWING' AS relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'FOLLOWER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.to_id
							,'FOLLOWING'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						)
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'FOLLOWING'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				UNION ALL
				
				(
					SELECT *
					FROM (
						SELECT u.to_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PARTNER'
							AND u.from_id = user_id
						) a
					
					EXCEPT
					
					(
						SELECT u.from_id
							,'PARTNER'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				
				UNION ALL
				
				(
					SELECT *
					FROM (
						SELECT u.from_id
							,'MENTOR'
						FROM PUBLIC.userrelation u
						WHERE u.type = 'MENTOR'
							AND u.to_id = user_id
						) a limit coalesce(itens_by_page, 5) offset coalesce(page, 0) * coalesce(itens_by_page, 5)
					)
				) r
			CROSS JOIN lateral findresourcebyowner(r.to_id) AS i
			CROSS JOIN lateral findresourcebyowner(cast(i.data ->> 'id' AS VARCHAR)) AS f
			LEFT JOIN lateral findresourcebyowner(r.to_id) AS g ON true
			CROSS JOIN lateral findresourcedata(r.to_id) AS h
			WHERE i.type = 'INSIGHT'
				AND g.type = 'PROFILE_IMAGE'
			) r
		GROUP BY r.user
			,r.insight
		) r
	GROUP BY r.user
	) r
	

loop
		RETURN NEXT resource_t;
	
   END LOOP;
  
  	
   RETURN;

END;

$function$
;
