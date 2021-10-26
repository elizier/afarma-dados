
--***Inserts Na Produção***
--Moderna Rua da conceição
with vars as (select uuid_generate_v4() as id, uuid_generate_v4() as enderecoId, nextval('usuario_id_seq') as usuarioId, nextval('usuario_id_seq') as adminId )

insert into rede values(uuid_generate_v4(),concat(replace(lower(:nomerede),' ',''),'@afarma.com.br'),:nomerede);

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (:id_endereco,
:bairro,
:cep,
:cidade,
:complemento,
:descrição,
:googleplaceid,
:latitude,
:longitude,
:logradouro,
:número,
:tipologradouro,
:uf);


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, apelido, tipo, endereco_id, farmaceutico_id, rede_id)
values (:id_loja,
:cnpj,
:inscriçãoestadual,
:inscriçãomunicipal,
:nomefantasia,
:raiodeentrega,
:razaosocial,
:apelido,
:tipo,
:id_endereco,
'76019374-c223-4489-b5e5-128938433392',
:id_rede);


insert into usuario (id, ativo, aceitetermo, cpf, datanascimento, dataaceite, email, nome, senha, telefone, enderecoid, perfilid)
values (
:usuarioId,
true,
true,
:cpf,
now(),
now(),
concat('usuario.',replace(lower(:nomefantasia),' ',''),right(replace(:cnpj,'-',''),6),'@afarmapopular.com.br'),
concat('usuario.',replace(lower(:nomefantasia),' ',''),right(replace(:cnpj,'-',''),6)),
'1234567890',
:telefone,
:id_endereco,
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	:loja_id,
	:usuarioId
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
:adminId,
true,
true,
:cpf,
now(),
now(),
concat('admin.',replace(lower(:nomefantasia),' ',''),right(replace(:cnpj,'-',''),6),'@afarmapopular.com.br'),
concat('admin.',replace(lower(:nomefantasia),' ',''),right(replace(:cnpj,'-',''),6)),
'1234567890',
:telefone,
:id_endereco,
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	:loja_id,
	:adminId);


	

{
  "nomerede": "MatheusTest",
  "bairro": "TestBairro",
  "cep": "Testcep",
  "cidade": "Testcidade",
  "complemento": "Testcompl",
  "descrição": "Testdescr",
  "googleplaceid": "Teststringplaceid",
  "latitude": 8721407320742,
  "longitude": 978134082893,
  "logradouro": "Do carmo",
  "número": "5461",
  "tipologradouro": "Rua",
  "uf": "RJ",
  "cnpj": "2515168165156",
  "inscriçãoestadual": "1215616",
  "inscriçãomunicipal": "61651",
  "nomefantasia": "FarmMath",
  "raiodeentrega": 8,
  "razaosocial": "FranqMath",
  "tipo": "Franquia",
  "cpf": "12112112122",
  "telefone": "021999526666"
  usuarioid
  adminid
  enderecoid
  lojaid
}

