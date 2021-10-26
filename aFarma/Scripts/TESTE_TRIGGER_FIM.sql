CREATE OR REPLACE FUNCTION teste_trigger()
RETURNS trigger AS
$BODY$
DECLARE insert_statement TEXT;
--declare id integer;
--declare nome varchar(255);
BEGIN

 IF NOT ARRAY['conexao_afarma3'] <@ dblink_get_connections() OR dblink_get_connections() IS NULL THEN
   PERFORM dblink_connect('conexao_afarma3', 'host=afarmapopular-prod.ctaih4y3js5d.sa-east-1.rds.amazonaws.com user=postgres password=afarmapopular dbname=postgres');
 END IF;
      
 -- insert_statement =  format('insert into public.testetrigger(id, ativo, nome, email, senha,  perfilid, aceitetermo, dataaceite) values (%s, %s)', new.id::integer, 'oi');
	  insert_statement = 'insert into afarma.usuario_afarmapopular(id, aceitetermo, ativo, codigo_cad_senha, cpf, dataaceite, datanascimento, devicetoken, email, nome, senha, telefone, casarepousoid, enderecoid, perfilid, codigoind, usuarioteste)
values ('||new.id||','|| new.aceitetermo||','||new.ativo||','||new.codigo_cad_senha||','''||new.cpf||''','||new.dataaceite||','
||new.datanascimento||','''||new.devicetoken||''','''||new.email||''','''||new.nome||''','''||new.senha||''','''||new.telefone||''','
||new.casarepousoid||','||new.enderecoid||','||new.perfilid||','''||new.codigoind||''','||new.usuarioteste||');';
 --execute insert_statement;
 PERFORM dblink_exec('conexao_afarma3', insert_statement);
PERFORM dblink_disconnect('conexao_afarma3');
  RETURN new;
END;
$BODY$
 LANGUAGE plpgsql VOLATILE;
 

 CREATE TRIGGER insert_teste_trigger

  AFTER INSERT

  ON public.usuario

  FOR EACH ROW

  EXECUTE PROCEDURE teste_trigger();
 
 INSERT INTO public.usuario
(id, aceitetermo, ativo, codigo_cad_senha, cpf, dataaceite, datanascimento, devicetoken, email, nome, senha, telefone, perfilid, codigoind, usuarioteste)
VALUES(nextval('usuario_id_seq'), false, false, '', '9999', now(), now(), '', 'xxx@gmail.com', 'nome', '1234', '', 2, '', true);

 
 insert into public.usuario (id, ativo, nome, email, senha,  perfilid, aceitetermo, dataaceite)
 values(nextval('usuario_id_seq'), true, 'nome', 'xxx@gmail.com','1234','2',true,now());

INSERT INTO public.usuario
(id, aceitetermo, ativo, dataaceite, email, nome, senha, perfilid)
VALUES(nextval('usuario_id_seq'), true, true, now(), 'xxx@gmail.com', 'xpto', '1234', 2);

 


