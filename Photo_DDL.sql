-- afarma.photo definition

-- Drop table

-- DROP TABLE afarma.photo;

CREATE TABLE afarma.photo (
	id varchar(36) NOT NULL,
	photo bytea NULL,
	CONSTRAINT photo_pkey PRIMARY KEY (id)
);