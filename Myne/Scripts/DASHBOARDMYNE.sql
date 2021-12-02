select date(createdate) from myneuser

select count(*) as users, date(createdate) as date from myneuser
group by date(createdate)


select * from
(select concat(m.accountname, ' ', m.name) as user, count(from_id) as followers 
from userrelation u, myneuser m where m.id = u.to_id
group by m.accountname, m.name) u
order by u.followers desc 
limit 1

select concat( u.name, ' (@', u.accountname,')' ) as user, c.count  from myneresourceinformation m , myneuser u,
(select o.owner, count(o.id) from ownerresources o where o."type" = 'USER_POST'
group by o."owner") c 
where c.owner = m.id and replace(m.mri, 'mri::', '') = u.id
order by c.count desc 
limit 1


select u.user, u.followers,  now() as time from
(select concat( m.name, ' ', '(@', m.accountname, ')') as user, count(from_id) as followers
from userrelation u, myneuser m where m.id = u.to_id and u."type" = 'FOLLOWER'
group by m.accountname, m.name) u
order by u.followers desc, u.user desc 


select ((select cast(count(o.id) as double precision) from ownerresources o where o."type" = 'USER_PRODUCT')/
(select cast(count(*) as double precision) from (select distinct(o.owner) from ownerresources o where o."type" = 'USER_PRODUCT') a)) 
as Product_By_User, now() as time



select i.id as "Identificador", i.insighttype as "Tipo" , i.releasedate as "Data de estréia" , a."views" as "Visualizações"  from ownerresources o 
left join myneresourceinformation m  on m.id = o."owner"
left join myneresourceinformation r on r.id = o.slave 
left join accountability a on a.id = replace(r.mri, 'mri::', '')
left join insight i on i.id = replace(m.mri, 'mri::', '')
where o."type" = 'INSIGHT_ACCOUNTABILITY'
order by a."views" desc
limit 5



select concat('@',u.accountname) as "Usuário", p.* from 
(select i.id as "Insight", i.insighttype as "Tipo" , i.releasedate as "Data de estréia" , a."views" as "Visualizações"  from ownerresources o 
left join myneresourceinformation m  on m.id = o."owner"
left join myneresourceinformation r on r.id = o.slave 
left join accountability a on a.id = replace(r.mri, 'mri::', '')
left join insight i on i.id = replace(m.mri, 'mri::', '')
where o."type" = 'INSIGHT_ACCOUNTABILITY'
order by a."views" desc, i.id asc
limit 5) p
left join lateral findresourcedata(p."Insight") as f on true
left join myneuser u on f.owner = u.id



