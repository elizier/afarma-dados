-- afarma.paciente_receitas definition

-- Drop table

-- DROP TABLE afarma.paciente_receitas;

CREATE TABLE afarma.paciente_receitas (
	paciente_id varchar(36) NOT NULL,
	receita_id varchar(36) NOT NULL,
	CONSTRAINT uk_63os0i5j3giynd7cxql4urfya UNIQUE (receita_id),
	CONSTRAINT fk23u16q30kqkjv5u2ypfll1tyc FOREIGN KEY (paciente_id) REFERENCES afarma.paciente(id),
	CONSTRAINT fkrpnro1teco5jbpdb0krtnbbrs FOREIGN KEY (receita_id) REFERENCES afarma.receita(id)
);