--post

ALTER TABLE public.post ALTER COLUMN createdate TYPE timestamp with time zone USING createdate::timestamp with time zone;

ALTER TABLE public.post ADD releasedate timestamp with time zone NULL;

update public.post set releasedate = createdate ;

ALTER TABLE public.post ALTER COLUMN releasedate SET NOT NULL;

ALTER TABLE public.post ALTER COLUMN releasedate SET DEFAULT now();

--product

ALTER TABLE public.product ALTER COLUMN createdate TYPE timestamp with time zone USING createdate::timestamp with time zone;

ALTER TABLE public.product ADD releasedate timestamp with time zone NULL;

update public.product set releasedate = createdate ;

ALTER TABLE public.product ALTER COLUMN releasedate SET NOT NULL;

ALTER TABLE public.product ALTER COLUMN releasedate SET DEFAULT now();

--insight

ALTER TABLE public.insight ALTER COLUMN createdate TYPE timestamp with time zone USING createdate::timestamp with time zone;

ALTER TABLE public.insight ADD releasedate timestamp with time zone NULL;

update public.insight set releasedate = createdate ;

ALTER TABLE public.insight ALTER COLUMN releasedate SET NOT NULL;

ALTER TABLE public.insight ALTER COLUMN releasedate SET DEFAULT now();







