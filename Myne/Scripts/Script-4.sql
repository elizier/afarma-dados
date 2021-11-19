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