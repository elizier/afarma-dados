


select removerelations('fd80a235-bff2-4586-8fbb-fd3cd61744d7', '6d17dbd1-cbc5-40d6-bb48-e2543d58570e', 'MENTOR')

select listmynerelations('55f59dc6-9158-437b-ac40-981d30ca3b3f', 'FOLLOWER', 3, 1)

select public.responserelationrequest('3e4542fd-8ded-4592-ab77-fae2443d05b4', 'ACCEPTED')

select public.requestrelation('6d17dbd1-cbc5-40d6-bb48-e2543d58570e', 'fd80a235-bff2-4586-8fbb-fd3cd61744d7', 'PUPIL')



select
(case when 
(select count(u.id) from userrelation u
where u."type" = 'MENTOR') > (select count(u.id) from userrelation u
where u."type" = 'PUPIL')
then
(select u.id from userrelation u, 
((select u.to_id, u.from_id from userrelation u where u.type = 'MENTOR')
except
(select u.from_id, u.to_id from userrelation u where u.type = 'PUPIL')) m
where m.to_id = u.to_id and m.from_id = u.from_id and u."type" = 'MENTOR')
when 
(select count(u.id) from userrelation u
where u."type" = 'PUPIL') > (select count(u.id) from userrelation u
where u."type" = 'MENTOR')
then 
(select u.id from userrelation u, 
(
(select u.from_id, u.to_id from userrelation u where u.type = 'PUPIL')
except
(select u.to_id, u.from_id from userrelation u where u.type = 'MENTOR')
) m
where m.to_id = u.to_id and m.from_id = u.from_id and u."type" = 'PUPIL')
else
null
end)


select * from 
(select (jsonb_build_object('id1', p.from_id) || jsonb_build_object('id2', p.to_id)) as pupil from
(select u.from_id, u.to_id from userrelation u where u.type = 'PUPIL') p) p
join
(select (jsonb_build_object('id1', m.to_id) || jsonb_build_object('id2', m.from_id)) as mentor from
(select u.to_id, u.from_id from userrelation u where u.type = 'MENTOR') m) m
on p.pupil @> m.mentor and p.pupil <@ m.mentor






create trigger ajustuserrelation after
insert
    on
    public.userrelation for each row execute function userrelationajust()


    
    
CREATE OR REPLACE FUNCTION public.userrelationajust()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

begin
	

insert into userrelation select ur.id, ur.type, ur.from_id, ur.to_id
from
(select uuid_generate_v4() as id, 'MENTOR' as type, p.to_id as from_id, p.from_id as to_id from  
(select u.to_id, u.from_id from userrelation u where u.type = 'PUPIL') p
left join 
(select u.from_id, u.to_id from userrelation u where u.type = 'MENTOR') m
on m.to_id = p.from_id and m.from_id = p.to_id
where m.from_id isnull and m.to_id isnull) ur;


insert into userrelation select ur.id, ur.type, ur.from_id, ur.to_id
from
(select uuid_generate_v4() as id, 'PUPIL' as type, m.to_id as from_id, m.from_id as to_id from  
(select u.from_id, u.to_id from userrelation u where u.type = 'MENTOR') m
left join
(select u.to_id, u.from_id from userrelation u where u.type = 'PUPIL') p
on m.to_id = p.from_id and m.from_id = p.to_id
where p.from_id isnull and p.to_id isnull) ur;

insert into userrelation select ur.id, ur.type, ur.from_id, ur.to_id
from
(
select uuid_generate_v4() as id, 'PARTNER' as type, a.to_id as from_id, a.from_id as to_id from 
(select u.from_id, u.to_id from userrelation u where u."type" = 'PARTNER') a
left join 
(select u.to_id, u.from_id from userrelation u where u."type" = 'PARTNER') b
on a.from_id = b.to_id and a.to_id = b.from_id
where b.to_id isnull and b.from_id isnull ) ur;


insert into userrelation select ur.id, ur.type, ur.from_id, ur.to_id
from
(
select uuid_generate_v4() as id, 'PARTNER' as type, b.to_id as from_id, b.from_id as to_id from 
(select u.to_id, u.from_id  from userrelation u where u."type" = 'PARTNER') b
left join 
(select u.from_id, u.to_id from userrelation u where u."type" = 'PARTNER') a
on a.from_id = b.to_id and a.to_id = b.from_id
where b.to_id isnull and b.from_id isnull ) ur;


insert into relationrequest select uuid_generate_v4(), r.*, now(), 'ACCEPTED'
from
(
(select u.type, u.from_id, u.to_id from userrelation u)
except
(select r.type, r.from_id, r.to_id from relationrequest r where r.status = 'ACCEPTED')
) r;


RETURN NEW;

END;

$function$
;

