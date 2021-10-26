-- afarma.entregador_documento definition

-- Drop table

-- DROP TABLE afarma.entregador_documento;

CREATE TABLE afarma.entregador_documento (
	entregador_id varchar(36) NOT NULL,
	documento_id varchar(36) NOT NULL,
	CONSTRAINT fk157sb4thxa34cnm7gd6hvhljt FOREIGN KEY (entregador_id) REFERENCES afarma.entregador(id),
	CONSTRAINT fkqiwi88jo5mgh9iat3ulq0hdax FOREIGN KEY (documento_id) REFERENCES afarma.documento(id)
);
