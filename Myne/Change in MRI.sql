ALTER TABLE public.myneresourceinformation ALTER COLUMN createdate SET DEFAULT now();
ALTER TABLE public.myneresourceinformation ALTER COLUMN createdate SET NOT NULL;


update public.myneresourceinformation set createdate = now() where createdate isnull
