-- afarma.banner definition

-- Drop table

-- DROP TABLE afarma.banner;

CREATE TABLE afarma.banner (
	id varchar(36) NOT NULL,
	image varchar(255) NOT NULL,
	url varchar(255) NULL,
	CONSTRAINT banner_pkey PRIMARY KEY (id)
);