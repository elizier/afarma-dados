
insert into userrelation(id, "type" , from_id, to_id, createdate)
select uuid_generate_v4(), p.relationtype, p.fromid, p.toid, now() from
(
(select 'PUPIL' as relationtype, p.user_purchase as fromid,  p.user_product as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and --puo.owner = :user and 
pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u)
union all
(select 'MENTOR' as relationtype,  p.user_product as fromid, p.user_purchase as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and --puo.owner = :user and 
pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u )
) p;

insert into relationrequest (id, "type" , from_id, to_id, requestdate, status)
select uuid_generate_v4(), p.relationtype, p.fromid, p.toid, now(), 'ACCEPTED' from
(
(select 'PUPIL' as relationtype, p.user_purchase as fromid,  p.user_product as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and puo.owner = :user and pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u)
union all
(select 'MENTOR' as relationtype,  p.user_product as fromid, p.user_purchase as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and puo.owner = :user and pr.relationchange = true) p
except
select r."type", r.from_id , r.to_id from relationrequest r
where r.status = 'ACCEPTED')
) p;


delete from relationrequest r where r.id in
(select r.id from relationrequest r,
(select r."type", r.from_id, r.to_id, min(r.requestdate), r.status from relationrequest r ,
(select r.to_id, r.from_id , r."type", r.status , count(r.id) from relationrequest r
where r.status != 'DELETED'
group by r.to_id, r.from_id , r."type", r.status
having count(r.id) > 1) rc
where rc.to_id = r.to_id and rc.from_id = r.from_id and rc.type = r.type and rc.status = r.status
group by r."type", r.from_id, r.to_id,  r.status) rc
where rc.type = r."type" and rc.from_id = r.from_id and rc.to_id = r.to_id and rc.min = r.requestdate and rc.status = r.status );


create trigger changerelationpurchase after
insert
    on
    public.purchase for each row execute function relationchangepurchase()
    
    
CREATE OR REPLACE FUNCTION public.relationchangepurchase()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

insert into userrelation(id, "type" , from_id, to_id, createdate)
select uuid_generate_v4(), p.relationtype, p.fromid, p.toid, now() from
(
(select 'PUPIL' as relationtype, p.user_purchase as fromid,  p.user_product as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and
pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u)
union all
(select 'MENTOR' as relationtype,  p.user_product as fromid, p.user_purchase as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and
pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u )
) p;

insert into relationrequest (id, "type" , from_id, to_id, requestdate, status)
select uuid_generate_v4(), p.relationtype, p.fromid, p.toid, now(), 'ACCEPTED' from
(
(select 'PUPIL' as relationtype, p.user_purchase as fromid,  p.user_product as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and
pr.relationchange = true) p
except
select u."type", u.from_id , u.to_id from userrelation u)
union all
(select 'MENTOR' as relationtype,  p.user_product as fromid, p.user_purchase as toid from
(select puo.owner as user_purchase, p.id as purchase, pro.owner as user_product from purchase p
left join lateral findresourcedata(p.id) as puo on true
left join lateral findresourcedata(p.product_id) as pro on true
left join product pr on p.product_id = pr.id
where pro.owner in (select id from myneuser m)
and pr.relationchange = true) p
except
select r."type", r.from_id , r.to_id from relationrequest r
where r.status = 'ACCEPTED')
) p;


delete from relationrequest r where r.id in
(select r.id from relationrequest r,
(select r."type", r.from_id, r.to_id, min(r.requestdate), r.status from relationrequest r ,
(select r.to_id, r.from_id , r."type", r.status , count(r.id) from relationrequest r
where r.status != 'DELETED'
group by r.to_id, r.from_id , r."type", r.status
having count(r.id) > 1) rc
where rc.to_id = r.to_id and rc.from_id = r.from_id and rc.type = r.type and rc.status = r.status
group by r."type", r.from_id, r.to_id,  r.status) rc
where rc.type = r."type" and rc.from_id = r.from_id and rc.to_id = r.to_id and rc.min = r.requestdate and rc.status = r.status );


RETURN NEW;

END;

$function$
;


