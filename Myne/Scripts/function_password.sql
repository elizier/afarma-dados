CREATE OR REPLACE FUNCTION public.password_recovery(user_email character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
   password_key varchar;
begin
	


SELECT (case when u.password = 'PROVIDED BY OAUTH' then 'Your password could not be recovered.' else u.password end)
FROM myneuser u WHERE u.email = user_email
into password_key;

   return password_key;
end;
$function$
;

select public.password_recovery(:email)

ALTER TABLE public.s3file ADD order_ integer NULL;
