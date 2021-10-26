-- afarma.paciente_procuracao definition

-- Drop table

-- DROP TABLE afarma.paciente_procuracao;

CREATE TABLE afarma.paciente_procuracao (
	paciente_id varchar(36) NOT NULL,
	procuracao_id varchar(36) NOT NULL,
	CONSTRAINT uk_n19byqlaybfhdv483aghhopbo UNIQUE (procuracao_id),
	CONSTRAINT fk934ecaadbyhw91fylj1yyn9ke FOREIGN KEY (paciente_id) REFERENCES afarma.paciente(id),
	CONSTRAINT fks2t84rck4h1m1txww5cyx9g9n FOREIGN KEY (procuracao_id) REFERENCES afarma.procuracao(id)
);