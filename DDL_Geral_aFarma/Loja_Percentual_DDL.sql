-- afarma.loja_percentual definition

-- Drop table

-- DROP TABLE afarma.loja_percentual;

CREATE TABLE afarma.loja_percentual (
	loja_id varchar(36) NOT NULL,
	percentual_id varchar(36) NOT NULL,
	CONSTRAINT fk2jlmmiesxhbe2thwfsd5pvf79 FOREIGN KEY (percentual_id) REFERENCES afarma.percentualrepasse(id),
	CONSTRAINT fkdw9vvl8b9ox141qx0kmeun91i FOREIGN KEY (loja_id) REFERENCES afarma.loja(id)
);

