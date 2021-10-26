-- afarma.proprietario_documento definition

-- Drop table

-- DROP TABLE afarma.proprietario_documento;

CREATE TABLE afarma.proprietario_documento (
	proprietario_id varchar(36) NOT NULL,
	documento_id varchar(36) NOT NULL,
	CONSTRAINT fk9r7tcg8imrctunodxgmb6nfg4 FOREIGN KEY (documento_id) REFERENCES afarma.documento(id),
	CONSTRAINT fkju1r7j5kpq3y6yoa6mxinfblt FOREIGN KEY (proprietario_id) REFERENCES afarma.proprietario(id)
);