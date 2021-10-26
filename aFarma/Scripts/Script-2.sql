select concat('curl -X GET "http://127.0.0.1:8080/api/crawlerSchedule/run?schedule%20id=', cs.id,'" -H "accept: /"')
from crawler_schedule cs

select count(*) from product p where p."implementation" = 'VENANCIO'


update crawler_schedule  set createdate = '2021-10-22 00:00:00.000 -0300'

select now()