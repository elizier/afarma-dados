-- afarma.rede_lojas definition

-- Drop table

-- DROP TABLE afarma.rede_lojas;

CREATE TABLE afarma.rede_lojas (
	rede_id varchar(36) NOT NULL,
	loja_id varchar(36) NOT NULL,
	CONSTRAINT fk5tcrcn03ig8w7f9ejgx0y7jdg FOREIGN KEY (rede_id) REFERENCES afarma.rede(id),
	CONSTRAINT fkopeecdqxox6wx4av0uj4dh3b9 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id)
);
