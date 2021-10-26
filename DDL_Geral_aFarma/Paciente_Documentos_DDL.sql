-- afarma.paciente_documentos definition

-- Drop table

-- DROP TABLE afarma.paciente_documentos;

CREATE TABLE afarma.paciente_documentos (
	paciente_id varchar(36) NOT NULL,
	documento_id varchar(36) NOT NULL,
	CONSTRAINT uk_do7o4tlkwxllaotmr3fbjx5j2 UNIQUE (documento_id),
	CONSTRAINT fkbke5jml057aghtcvvu5c06d82 FOREIGN KEY (paciente_id) REFERENCES afarma.paciente(id),
	CONSTRAINT fkp99pn1yxurf4v743inb6wlv4r FOREIGN KEY (documento_id) REFERENCES afarma.documento(id)
);

