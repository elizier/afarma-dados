-- afarma.casarepouso_paciente definition

-- Drop table

-- DROP TABLE afarma.casarepouso_paciente;

CREATE TABLE afarma.casarepouso_paciente (
	casa_repouso_id varchar(36) NOT NULL,
	paciente_id varchar(36) NOT NULL,
	CONSTRAINT uk_mtevlgk4uo99trgxge435ngnn UNIQUE (paciente_id),
	CONSTRAINT fk7s6db20v46osf3stn9ewjshpu FOREIGN KEY (paciente_id) REFERENCES afarma.paciente(id),
	CONSTRAINT fksbg6hsotsgkh9gthuvog09f2u FOREIGN KEY (casa_repouso_id) REFERENCES afarma.casarepouso(id)
);