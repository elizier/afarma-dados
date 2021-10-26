-- afarma.casarepouso_telefones definition

-- Drop table

-- DROP TABLE afarma.casarepouso_telefones;

CREATE TABLE afarma.casarepouso_telefones (
	casa_repouso_id varchar(36) NOT NULL,
	telefone_id varchar(36) NOT NULL,
	CONSTRAINT fkfmwrxeogf0eyo34js0g4qq29m FOREIGN KEY (casa_repouso_id) REFERENCES afarma.casarepouso(id),
	CONSTRAINT fkhbkp0kwo9qamw9ors62q3c3w3 FOREIGN KEY (telefone_id) REFERENCES afarma.telefone(id)
);