-- afarma.lead_itenscotados definition

-- Drop table

-- DROP TABLE afarma.lead_itenscotados;

CREATE TABLE afarma.lead_itenscotados (
	lead_id varchar(36) NOT NULL,
	item_id varchar(36) NOT NULL,
	CONSTRAINT fk1odb0t7o27m8l73foom5x5cx8 FOREIGN KEY (item_id) REFERENCES afarma.itemparacotacao(id),
	CONSTRAINT fkjuskovjuiyrps626sh4wyerht FOREIGN KEY (lead_id) REFERENCES afarma."lead"(id)
);