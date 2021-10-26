-- afarma.alerta foreign keys

ALTER TABLE afarma.alerta ADD CONSTRAINT fk7soe1f0dvunnrik2whd41k336 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);
ALTER TABLE afarma.alerta ADD CONSTRAINT fkk2ca97dclkptty65yhwp72bam FOREIGN KEY (pedido_id) REFERENCES afarma.pedido(id);


-- afarma.alertapedidorecorrente foreign keys

ALTER TABLE afarma.alertapedidorecorrente ADD CONSTRAINT fks31f3v8lj6k73ul0q1oa0l4y1 FOREIGN KEY (pedido_inicial_id) REFERENCES afarma.pedido(id);


-- afarma.cesta foreign keys

ALTER TABLE afarma.cesta ADD CONSTRAINT fkjw0b181se462ub7ckctukln4s FOREIGN KEY (cotacao_id) REFERENCES afarma.cotacaosql(id);
ALTER TABLE afarma.cesta ADD CONSTRAINT fko49usnik8smrfa1ucwwro25es FOREIGN KEY (cliente_id) REFERENCES afarma.usuario(id);


-- afarma.cotacaosql foreign keys

ALTER TABLE afarma.cotacaosql ADD CONSTRAINT fkq595f3igy2mdsbdrb7dlcy4ds FOREIGN KEY (cesta_id) REFERENCES afarma.cesta(id);


-- afarma.distribuicao_alerta foreign keys

ALTER TABLE afarma.distribuicao_alerta ADD CONSTRAINT fkb24umxengh1g4bs1v9qmsvc64 FOREIGN KEY (alerta_id) REFERENCES afarma.alerta(id);
ALTER TABLE afarma.distribuicao_alerta ADD CONSTRAINT fkn5qbqmmrr7pnnsumudv38rnkk FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);


-- afarma.item_cesta foreign keys

ALTER TABLE afarma.item_cesta ADD CONSTRAINT fkb3h3sv2gd7w9l8wiarwbvw4nb FOREIGN KEY (item_id) REFERENCES afarma.itemprodutocesta(id);
ALTER TABLE afarma.item_cesta ADD CONSTRAINT fktq9s7cgrjyhpgdo1triop4b7l FOREIGN KEY (cesta_id) REFERENCES afarma.cesta(id);


-- afarma.loja_pedido foreign keys

ALTER TABLE afarma.loja_pedido ADD CONSTRAINT fkc5jgrirne7e828rq9mrs8kt57 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);
ALTER TABLE afarma.loja_pedido ADD CONSTRAINT fkllkn385wuf56adr9sw47653a0 FOREIGN KEY (pedido_id) REFERENCES afarma.pedido(id);


-- afarma.pedido foreign keys

ALTER TABLE afarma.pedido ADD CONSTRAINT fk5plmsxy4s1bvlf1aeolsu9m2d FOREIGN KEY (cesta_id) REFERENCES afarma.cesta(id);
ALTER TABLE afarma.pedido ADD CONSTRAINT fk6a4snne4m674sewarh8gf72sw FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);
ALTER TABLE afarma.pedido ADD CONSTRAINT fk6wdba1avarar4rikh5v6rke1l FOREIGN KEY (endereco_id) REFERENCES afarma.endereco(id);
ALTER TABLE afarma.pedido ADD CONSTRAINT fke2o14y204r47x07r2id68qc3a FOREIGN KEY (cesta_alterada_id) REFERENCES afarma.cesta(id);


-- afarma.venda foreign keys

ALTER TABLE afarma.venda ADD CONSTRAINT fk296brvvpok33jrtv7dem8qse2 FOREIGN KEY (loja_id) REFERENCES afarma.loja(id);
ALTER TABLE afarma.venda ADD CONSTRAINT fk9w726k9pcn21t7f9n6tqvlo0p FOREIGN KEY (pedido_id) REFERENCES afarma.pedido(id);
ALTER TABLE afarma.venda ADD CONSTRAINT fkay1rxv2k23nky2kgkfp3tseqx FOREIGN KEY (entregador_id) REFERENCES afarma.entregador(id);
ALTER TABLE afarma.venda ADD CONSTRAINT fkm41ogg6f23qj5d1dquauo81d3 FOREIGN KEY (endereco_id) REFERENCES afarma.endereco(id);
ALTER TABLE afarma.venda ADD CONSTRAINT fkrbtidqm7plo38vfqqkil0wy1c FOREIGN KEY (vendedor_id) REFERENCES afarma.vendedor(id);