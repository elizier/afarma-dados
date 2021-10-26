UPDATE usuario 
SET codigoind=indicacao.concat
FROM (select usuario.id, concat(translate((lower(left(usuario.nome,((strpos(usuario.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),(RANK () OVER ( ORDER BY usuario.id)))
from usuario where usuario.perfilid='2' 
) AS indicacao
where usuario.id=indicacao.id;


--Ele olha a parte numérica do último código de indicação gerado e adiciona +1:


select concat(translate((lower(left(:nome,((strpos(:nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),(select (cast(substring(usuario.codigoind FROM '[0-9]+') as integer)+1)
from usuario
where usuario.perfilid='2' and (usuario.codigoind isnull or usuario.codigoind='' or usuario.codigoind=null)
order by usuario.id desc
limit 1)) from usuario where usuario.perfilid='2';

 (select  substring(usuario.codigoind ,patindex('%[0-9]%', usuario.codigoind),len(usuario.codigoind)) from usuario)
 
 
 -------------------- CODIGO TRIGGER
 
UPDATE
    public.usuario 
SET
    codigoind=ci.concat
FROM
   (select cod.identificador, concat(translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),cod.codigo)
from
(select max(i.id) as "identificador", (max(cast(i.substring as integer))+1) as "codigo" from 
 (select u.id, u.nome,
 translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),
 u.codigoind, substring(u.codigoind FROM '[0-9]+') from usuario u
 where u.perfilid='2'
 order by id asc) i) cod, usuario u where u.id=cod.identificador) ci 
WHERE
    id = ci.identificador;
   
   ---------------
    
    
 (select cod.id, concat(translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),cod.codigo)
from
(select max(i.id) as "id", (max(cast(i.substring as integer))+1) as "codigo" from 
 (select u.id, u.nome,
 translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),
 u.codigoind, substring(u.codigoind FROM '[0-9]+') from usuario u
 where u.perfilid='2'
 order by id asc) i) cod, usuario u where u.id=cod.id) ci
 
 
 
 
 
 
 
 -----------------------------------
 
 CREATE OR REPLACE FUNCTION usuario_codigo_ind()

  RETURNS trigger AS

$$

BEGIN



     
UPDATE
    public.usuario 
SET
    codigoind=ci.concat
FROM
   (select cod.identificador, concat(translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),cod.codigo)
from
(select max(i.id) as "identificador", (max(cast(i.substring as integer))+1) as "codigo" from 
 (select u.id, u.nome,
 translate((lower(left(u.nome,((strpos(u.nome, ' '))-1)))), 'áàâãäåaaaÁÂÃÄÅAAAÀéèêëeeeeeEEEÉEEÈìíîïìiiiÌÍÎÏÌIIIóôõöoooòÒÓÔÕÖOOOùúûüuuuuÙÚÛÜUUUUçÇñÑıİ',
'aaaaaaaaaAAAAAAAAAeeeeeeeeeEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnNyY'),
 u.codigoind, substring(u.codigoind FROM '[0-9]+') from usuario u
 where u.perfilid='2'
 order by id asc) i) cod, usuario u where u.id=cod.identificador and (u.codigoind isnull or u.codigoind='' or u.codigoind=null)) ci 
WHERE
    id = ci.identificador;



RETURN NEW;

END;

$$

LANGUAGE 'plpgsql';
 
 CREATE TRIGGER update_codigo_ind

  AFTER INSERT

  ON public.usuario

  FOR EACH ROW

  EXECUTE PROCEDURE usuario_codigo_ind();
 

 create extension dblink;
 select * from postgres.afarma.usuario;

select * from
dblink('host=afarmapopular-prod.ctaih4y3js5d.sa-east-1.rds.amazonaws.com user=postgres password=afarmapopular dbname=afarma',
'select * from usuario') db;
 
 
 
 
 
 

