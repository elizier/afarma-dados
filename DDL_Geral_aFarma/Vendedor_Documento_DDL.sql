-- afarma.vendedor_documento definition

-- Drop table

-- DROP TABLE afarma.vendedor_documento;

CREATE TABLE afarma.vendedor_documento (
	vendedor_id varchar(36) NOT NULL,
	documento_id varchar(36) NOT NULL,
	CONSTRAINT fk7qhmcb0vlqrirys2i5tufih3o FOREIGN KEY (documento_id) REFERENCES afarma.documento(id),
	CONSTRAINT fkrnvhio3g0uhhf7tf2gd1b9q9t FOREIGN KEY (vendedor_id) REFERENCES afarma.vendedor(id)
);

