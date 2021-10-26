
-- afarma.procuracao definition

-- Drop table

-- DROP TABLE afarma.procuracao;

CREATE TABLE afarma.procuracao (
	id varchar(36) NOT NULL,
	descricao varchar(255) NULL,
	imageprocuracao bytea NULL,
	pacienteid varchar(36) NULL,
	usuarioid varchar(36) NULL,
	CONSTRAINT procuracao_pkey PRIMARY KEY (id),
	CONSTRAINT fk25h9nqyddhnwbuabbajiy8l69 FOREIGN KEY (pacienteid) REFERENCES afarma.paciente(id),
	CONSTRAINT fkah9r57kshucg9qd0gr4gikb3s FOREIGN KEY (usuarioid) REFERENCES afarma.usuario(id)
);