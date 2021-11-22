update
	s3file
set
	s3url = s3.s3url_new
from
	(
	select
		s3.id as id1,
		s3.s3url,
		replace(
			replace(
				replace(
					replace(s3.s3url, 'https://audios', 'https://audios3'),
				'sa-east-1', 'us-east-1'),
			'https://files', 'https://files3'),
		'https://images', 'https://images2'),
		as s3url_new
	from
		s3file s3) s3
where
	id = s3.id1
	
	
	
	
	
	
	
update
	s3file
set
	s3url = s3.s3url_new
from
	(
	select
		s3.id as id1,
		s3.s3url,
		replace(
			replace(
				replace(
					replace(s3.s3url, 'https://audios3', 'https://audios'), 'us-east-1',
				'sa-east-1'), 'https://files3',
			'https://files'), 'https://images2',
		'https://images')
		as s3url_new
	from
		s3file s3) s3
where
	id = s3.id1
	
	
select findmyneglobalinsights(100,0)





SELECT findmyneinsights('6a49706d-9be8-44bc-95a7-d8994150dc9b','MENTOR',10,0)



select cast(uuid_generate_v4() as varchar) as id, cast('INSIGHT' as varchar), to_json(i.data)  as "data" from
(select i.userid as userid, max(i.releasedate) as releasedate, jsonb_build_object('relation', 'MENTOR') || jsonb_build_object('insight', array_agg(i.insight_data)) || i.user_data as "data" from
global.insights i
where i.userid in
(
				select a.to_id from
					(
				
				
				
					SELECT *
					FROM (
						SELECT u.from_id as to_id
							,'MENTOR' as relation
						FROM PUBLIC.userrelation u
						WHERE u.type = 'PUPIL'
							AND u.to_id = :user_id
						) a 
					
				) a
				)
group by
i.user_data, i.userid) i
order by i.releasedate desc;


delete from global.insights i where i.insight_id in
(select distinct(i.insight_id) from global.insights i
except 
select i.id from public.insight i)

update global.insights set user_data = 



select cast('{"id": "51259dab-9dab-431d-b471-e46430ef32f4", "name": "Thiago Rapparine Pinto", "slug": "thiago-rapparine-pinto-33", "type": "USER", "email": "thiagorapparine1@gmail.com", "active": true, "userType": "USER", "biography": "Consultor em estratégia digital com 8 anos de experiência em gerenciamento de projetos de larga escala em diversos setores como Papel e celulose, O&G e Mineração. ", "createDate": "2021-11-18T23:00:22.161", "visibility": "PUBLIC", "accountName": "thiagorapparine", "devicetoken": "fRrvvq9NSUqWXLRBCJc-H1:APA91bGpBjfqtK8wmNKxN-H1OaM8dN4e5Xrewb3Cpi-b9ZPtmMxjD-jt4oLcmVIZHdxokga4H4qCxd0roP4p8le96A5GxyW_sBi57V-m_UBinjG0n_9no9WmGIZNEiY5KeSHnftQ_Jgy", "profile_image": {"id": "1a422884-c699-4d5f-bfa2-f2d0c5da7722", "type": "PROFILE_IMAGE", "s3url": "https://images.myne.net.br.s3.sa-east-1.amazonaws.com/image_picker4915566236993158023.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20211107T201955Z&X-Amz-SignedHeaders=content-type%3Bhost&X-Amz-Expires=3600&X-Amz-Credential=AKIAUKSHEG757GBOWFNA%2F20211107%2Fsa-east-1%2Fs3%2Faws4_request&X-Amz-Signature=f94f6bbd69d9eb6d50693328fe0c899999e138faec89324092bf1e9cd61b2ed3", "order_": 0, "fileName": "image_picker4915566236993158023.jpg", "fileType": "JPG", "createDate": "2021-11-07T20:19:55.503", "description": "/data/user/0/etc.bda.myne/cache/image_picker4915566236993158023.jpg", "solicitacaoid": null}}' as json) 


