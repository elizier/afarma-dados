--Criando a extension de UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

--Inserindo perfis de usuarios
INSERT INTO public.perfil(id, identificador, nome) VALUES (nextval('perfil_id_seq'),'ADMINISTRADOR','Administrador');
INSERT INTO public.perfil(id, identificador, nome) VALUES (nextval('perfil_id_seq'),'CLIENTE','Cliente');
INSERT INTO public.perfil(id, identificador, nome) VALUES (nextval('perfil_id_seq'),'FARMACIA','Farmácia');

-- Criando tabela de segmentoproduto
CREATE TABLE public.segmentoproduto
(
    id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    descricao character varying(255) COLLATE pg_catalog."default" NOT NULL,
    level integer NOT NULL,
    segmento_id character varying(36) COLLATE pg_catalog."default",
	order integer,
	rgb character varying(255) default '#FFFFFF';
    CONSTRAINT segmentoproduto_pkey PRIMARY KEY (id)
);
--Inserindo segmentos de produtos
INSERT INTO public.segmentoproduto(id, descricao, level)VALUES ('253170be-d52e-4394-92f2-7c216c5c93be','HIPERTENSÃO',0,1,'#FF0000');
INSERT INTO public.segmentoproduto(id, descricao, level)VALUES ('2f89643a-6da7-426a-a2e8-19fca736699a','DIABETES',0,2,'#F79029');
INSERT INTO public.segmentoproduto(id, descricao, level)VALUES ('97b4ef96-20e7-479a-8482-e1ba726f3d1f','ASMA',0,3,'#00ACD6');


--Inserindo produtos
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('04c0ad91-8fb1-4e8b-a092-d965b5c76b51',false,true,'253170be-d52e-4394-92f2-7c216c5c93be', 6,'Losartana Potássica 50mg','Seu médico receitou losartana potássica para tratar sua hipertensão (pressão alta) ou porque você tem uma doença conhecida como insuficiência cardíaca (enfraquecimento do coração). Em pacientes com pressão alta e hipertrofia ventricular esquerda, losartana potássica reduziu o risco de derrame (acidente vascular cerebral) e de ataque cardíaco (infarto do miocárdio) e ajudou esses pacientes a viverem mais.  Seu médico também pode ter receitado porque você tem diabetes tipo 2 e proteinúria; nesse caso, losartana potássica pode retardar a piora da doença renal.','30 Comprimidos','COZAAR','50mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('1f027ba7-7c44-4e67-8e83-68723f2b6d7b',false,true,'97b4ef96-20e7-479a-8482-e1ba726f3d1f', 3,'Dipropionato De Beclometsona 200mcg/dose - Inalador doseado ','Tratamento profilático da asma brônquica. MIFLASONA apresenta vantagens terapêuticas aos pacientes não controlados adequadamente pelo uso ocasional de broncodilatadores e/ou de cromoglicato de sódio e aos pacientes com asma grave dependentes de corticosteróides sistêmicos ou de hormônio adrenocorticotrófico (ACTH).','200 doses Spray','BECLOSOL','200mcg/dose');				
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('251d163c-13f8-44d1-ab79-50dadc187d54',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a',12,'Cloridrato de metformina 850mg','Este medicamento é um antidiabético de uso oral, que associado a uma dieta apropriada, é utilizado para o tratamento do diabetes tipo 2, isoladamente ou em combinação com outros antidiabéticos orais, como por exemplo aqueles da classe das sulfonilureias. Pode ser utilizado também para o tratamento do diabetes tipo 1 em complementação à insulinoterapia. Este medicamento também está indicado na Síndrome dos Ovários Policísticos, condição caracterizada por ciclos menstruais irregulares e frequentemente excesso de pelos e obesidade.','30 Comprimidos','GLIFAGE','850mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('43f10888-3a2d-4243-9257-0fd087cb5a2b',true ,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Glibenclamida 5mg','Este medicamento é destinado ao tratamento de Diabetes mellitus não insulino-dependente (tipo 2 ou Diabetes do adulto), quando os níveis de glicose no sangue não podem ser controlados apenas por dieta, exercício físico e redução de peso.','30 Comprimidos','DAONIL','5mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('7bb3f3c0-7a40-454c-9890-8310dfffa370',false,true,'97b4ef96-20e7-479a-8482-e1ba726f3d1f', 3,'Dipropionato De Beclometsona 250mcg/dose - Inalador doseado ','Este medicamento é destinado ao tratamento e prevenção da asma brônquica e bronquite, bem como nos processos inflamatórios das vias aéreas superiores (como nariz, garganta e brônquios).','200 doses Spray','BECLOSOL','250mcg/dose');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('80f49c6e-ea55-48c6-a9ab-1bc814abbfba',false,true,'97b4ef96-20e7-479a-8482-e1ba726f3d1f', 3,'Brometo De Ipratrópio 0,02mg/dose - Inalador doseado','Este medicamento é indicado para o tratamento de manutenção do broncoespasmo (falta de ar repentina) associado à Doença Pulmonar Obstrutiva Crônica (DPOC), que inclui bronquite crônica (inflamação dos canais das vias respiratória), enfisema pulmonar (doença pulmonar crônica que destrói a estrutura dos pulmões e geralmente afeta pessoas que fumam há muito tempo) e asma.','Frasco-ampola 10ml','AEROLIN','0,02mg/dose');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('8ae83c4b-8841-49a2-a353-5aee7a904174',false,true,'97b4ef96-20e7-479a-8482-e1ba726f3d1f', 3,'Dipropionato De Beclometsona 200mcg/cápsula - Cápsulas inalantes','Tratamento profilático da asma brônquica. MIFLASONA apresenta vantagens terapêuticas aos pacientes não controlados adequadamente pelo uso ocasional de broncodilatadores e/ou de cromoglicato de sódio e aos pacientes com asma grave dependentes de corticosteróides sistêmicos ou de hormônio adrenocorticotrófico (ACTH).','60 Cápsulas','BECLOSOL','200mcg/cápsula');									
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('a3029f6b-977f-4820-ab23-84c9b5b487d3',false,true,'97b4ef96-20e7-479a-8482-e1ba726f3d1f', 3,'Dipropionato De Beclometsona 50mcg/dose - Inalador doseado','Este spray nasal aquoso é um medicamento utilizado na prevenção e no tratamento da rinite alérgica (inflamação da mucosa nasal, que pode ser permanente ou surgir em determinadas épocas do ano), incluindo febre do feno (alergia ao pólen de algumas plantas) e rinite vasomotora (dilatação de vasos sanguíneos). Os principais sintomas da rinite alérgica são: irritação, coceira e entupimento do nariz, coriza e espirros.','200 doses Spray','BECLOSOL','50mcg/dose');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('a60b53a1-a312-4dcb-97a5-9aa6161c468a',false,true,'97b4ef96-20e7-479a-8482-e1ba726f3d1f', 3,'Sulfato De Salbutamol 5mg/ml - Solução para inalação','Este medicamento é indicado para o controle e prevenção dos espasmos (contrações) dos brônquios durante as crises de asma, bronquite crônica e enfisema.','Frasco-ampola 10ml','AEROLIN','5mg/ml');				
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3',true ,true,'253170be-d52e-4394-92f2-7c216c5c93be', 3,'Hidroclorotiazida 25mg','Hidroclorotiazida é um medicamento da linha de genéricos, com 25mg e uma embalagem com 30 comprimidos, de uso adulto e pediátrico, consumido por via oral, sendo indicado para o tratamento de pressão alta e inchaços ligados a insuficiência cardíaca.','30 Comprimidos','CLORANA','25mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('bf133a6d-88d9-4473-942e-59e874dc0a47',false,true,'253170be-d52e-4394-92f2-7c216c5c93be', 3,'Captopril 25mg','O captopril é indicado para tratar pacientes com: - hipertensão; - insuficiência cardíaca congestiva (usado com outros medicamentos diuréticos e digitálicos); - infarto do miocárdio; - nefropatia diabética (doença renal causada por diabetes).','30 Comprimidos','CAPOTEN','25mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('c0c7b69d-44c5-4239-9e8c-73af138628ec',false,true,'97b4ef96-20e7-479a-8482-e1ba726f3d1f', 3,'Sulfato De Salbutamol 100mcg/dose - Inalador doseado','Este medicamento é indicado para o controle e prevenção dos espasmos (contrações) dos brônquios durante as crises de asma, bronquite crônica e enfisema.','200 doses Spray','BECLOSOL','100mcg/dose');				
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('c10d4692-89cb-4bb0-a7c5-4a59dc995923',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Insulina Humana Regular 100 UI/ml | Frasco-ampola 10ml','Este medicamento é indicado para tratamento do diabetes mellitus. As pessoas que tem diabetes mellitus necessitam de Insulina para manutenção dos níveis normais de Glicose no organismo.','Frasco-ampola 10ml','HUMULIN','100 UI/ml ');	
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('d025ac2f-a3f3-4ea4-9939-df7e7c6cfacc',false,true,'253170be-d52e-4394-92f2-7c216c5c93be',12,'Maleato de Enalapril 10mg','Este medicamento serve para a prevenir a pressão alta ou aperfeiçoar as atividades do coração (tratamento da insuficiência cardíaca). Também é usado para a prevenir de incapacidade cardíaca sintomática.','30 Comprimidos','RENITEC','10mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('d67e8304-d13c-4edd-a0d2-3347884992de',false,true,'97b4ef96-20e7-479a-8482-e1ba726f3d1f', 3,'Brometo De Ipratrópio 0,25mg/ml - Solução para inalação','O brometo de ipratrópio é indicado como broncodilatador no tratamento de manutenção do broncoespasmo associado à Doença Pulmonar Obstrutiva Crônica (DPOC), incluindo bronquite crônica, enfisema e asma.','Frasco-ampola 20ml','ATROVENT','0,25mg/ml');				
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('da1d7783-8bb8-4141-97f7-0f1e197b94ae',false,true,'253170be-d52e-4394-92f2-7c216c5c93be',12,'Atenolol 25mg','O atenolol é indicado para o controle da hipertensão arterial (pressão alta), controle da angina pectoris (dor no peito ao esforço), controle de arritmias cardíacas, infarto do miocárdio e tratamento precoce e tardio após infarto do miocárdio.','30 Comprimidos','ATENOLOL','25mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('eedaf752-a511-42f4-b04a-df6f8396fe39',true ,true,'253170be-d52e-4394-92f2-7c216c5c93be', 3,'Cloridrato de propanolol 40mg','O cloridrato de propranolol é um betabloqueador indicado para: - Controle de hipertensão (pressão alta). - Controle de angina pectoris (sensação de pressão e dor no peito). - Controle das arritmias cardíacas (alterações no ritmo dos batimentos cardíacos). - Prevenção da enxaqueca (dor de cabeça forte). - Controle do tremor essencial. - Controle da ansiedade e taquicardia (aumento dos batimentos cardíacos) por ansiedade. - Controle adjuvante da tireotoxicose (aumento da secreção da glândula tireoide) e crise tireotóxica. - Controle da cardiomiopatia hipertrófica obstrutiva (aumento do volume do coração e problemas no seu funcionamento). - Controle de feocromocitoma (tipo de tumor, geralmente benigno, localizado na glândula supra-renal). Neste caso, o tratamento com cloridrato de propranolol deve apenas ser iniciado na presença de um bloqueio alfa efetivo.','30 Comprimidos','PROPANOLOL','40mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('f2d2a379-2769-4a96-9a56-b356000ff1d8',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a',12,'Cloridrato de metformina 500mg, comprimido de ação prolongada','Tratamento de diabetes tipo I e tipo II, associado ao regime alimenta','30 Comprimidos','GLIFAGE','500mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('f9a2feaa-d9aa-482b-931a-5275e23dc4a3',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a',12,'Cloridrato de metformina 500mg','Este é um medicamento antidiabético de uso oral, que associado a uma dieta apropriada, é utilizado para o tratamento do diabetes tipo 2 em adultos, isoladamente ou em combinação com outros antiadiabéticos orais, como por exemplo aqueles da classe das sulfonilureias. Pode ser utilizado também para o tratamento do diabetes tipo 1 em complementação à insulinoterapia. Também está indicado na Síndrome dos Ovários Policísticos, condição caracterizada por ciclos menstruais irregulares e frequentemente excesso de pelos e obesidade.','30 Comprimidos','GLIFAGE','500mg');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('8cb9ef38-9cd2-4c71-9478-89c4927b53b1',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Insulina Humana NPH 100 UI/ml | Frasco-ampola 5ml','Este medicamento é indicado para o tratamento do diabetes mellitus; As pessoas que têm a diabetes mellitus necessitam de insulina para manutenção dos níveis normais de glicose no organismo.','Frasco-ampola 5ml','HUMULIN','100 UI/ml');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Insulina Humana Regular 100 UI/ml | Frasco-ampola 5ml','Este medicamento é indicado para tratamento do diabetes mellitus. As pessoas que tem diabetes mellitus necessitam de Insulina para manutenção dos níveis normais de Glicose no organismo.','Frasco-ampola 5ml','HUMULIN','100 UI/ml');
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('cb16e64f-6480-4b39-8fc8-037931840fde',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Insulina Humana NPH 100 UI/ml | Frasco-ampola 10ml','Este medicamento é indicado para o tratamento do diabetes mellitus; As pessoas que têm a diabetes mellitus necessitam de insulina para manutenção dos níveis normais de glicose no organismo.','Frasco-ampola 10ml','HUMULIN','100 UI/ml');
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('6cef0393-d85b-4d6f-aef7-75c8498f998e',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Insulina Humana Regular 100 UI/ml | Refil 1,5ml (carpule)','Este medicamento é indicado para tratamento do diabetes mellitus. As pessoas que tem diabetes mellitus necessitam de Insulina para manutenção dos níveis normais de Glicose no organismo.','Refil 1,5ml (carpule)','HUMULIN','100 UI/ml');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('7c8a73e2-cd17-4b5d-bf18-50decc247b63',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Insulina Humana NPH 100 UI/ml | Refil 1,5ml (carpule)','Este medicamento é indicado para o tratamento do diabetes mellitus; As pessoas que têm a diabetes mellitus necessitam de insulina para manutenção dos níveis normais de glicose no organismo.','Refil 1,5ml (carpule)','HUMULIN','100 UI/ml');
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('08bbac7e-8c4e-49c9-8612-daa266f1f03f',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Insulina Humana NPH 100 UI/ml | Refil 3ml (carpule)','Este medicamento é indicado para o tratamento do diabetes mellitus; As pessoas que têm a diabetes mellitus necessitam de insulina para manutenção dos níveis normais de glicose no organismo.','Refil 3ml (carpule)','HUMULIN','100 UI/ml');					
INSERT INTO public.produto(id, restrito, active, segmento_id, quantidadeobrigatoria,nome, descricao, conteudoembalagem,  marcareferencia,  posologia) VALUES ('0a5fac9a-e87c-459e-b0b4-75468360c511',false,true,'2f89643a-6da7-426a-a2e8-19fca736699a', 3,'Insulina Humana Regular 100 UI/ml | Refil 3ml (carpule)','Este medicamento é indicado para tratamento do diabetes mellitus. As pessoas que tem diabetes mellitus necessitam de Insulina para manutenção dos níveis normais de Glicose no organismo.','Refil 3ml (carpule)','HUMULIN','100 UI/ml');

--Inserindo item produto popular(valor dos produtos)
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','04c0ad91-8fb1-4e8b-a092-d965b5c76b51',30 ,6.3);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','1f027ba7-7c44-4e67-8e83-68723f2b6d7b',200,74);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','251d163c-13f8-44d1-ab79-50dadc187d54',30 ,4.8);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','43f10888-3a2d-4243-9257-0fd087cb5a2b',30 ,2.4);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','7bb3f3c0-7a40-454c-9890-8310dfffa370',200,46);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','80f49c6e-ea55-48c6-a9ab-1bc814abbfba',200,28);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','8ae83c4b-8841-49a2-a353-5aee7a904174',60 ,22.2);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','a3029f6b-977f-4820-ab23-84c9b5b487d3',200,36);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','a60b53a1-a312-4dcb-97a5-9aa6161c468a',10 ,16.4);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3',30 ,1.8);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','bf133a6d-88d9-4473-942e-59e874dc0a47',30 ,3.3);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','c0c7b69d-44c5-4239-9e8c-73af138628ec',200,20);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','c10d4692-89cb-4bb0-a7c5-4a59dc995923',1  ,25.6);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','d025ac2f-a3f3-4ea4-9939-df7e7c6cfacc',30 ,5.4);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','d67e8304-d13c-4edd-a0d2-3347884992de',20 ,9.4);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','da1d7783-8bb8-4141-97f7-0f1e197b94ae',30 ,3.3);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','eedaf752-a511-42f4-b04a-df6f8396fe39',30 ,2.4);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','f2d2a379-2769-4a96-9a56-b356000ff1d8',30 ,7.5);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','f9a2feaa-d9aa-482b-931a-5275e23dc4a3',30 ,4.2);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','8cb9ef38-9cd2-4c71-9478-89c4927b53b1',1  ,12.85);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111',1  ,12.8);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','cb16e64f-6480-4b39-8fc8-037931840fde',1  ,25.7);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','6cef0393-d85b-4d6f-aef7-75c8498f998e',1  ,3.84);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','7c8a73e2-cd17-4b5d-bf18-50decc247b63',1  ,3.86);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','08bbac7e-8c4e-49c9-8612-daa266f1f03f',1  ,7.71);
INSERT INTO public.itemprodutopopular(id, uf, produto_id, quantidade,  valorunitario ) VALUES (uuid_generate_v4(), 'RJ','0a5fac9a-e87c-459e-b0b4-75468360c511',1  ,7.68);


--Inserindo redes de farmácias
INSERT INTO public.rede(id, nome, email) VALUES ('57f04b9d-e74c-4b38-b407-b26cc880b1fb','Moderna','moderna@afarma.com.br');
INSERT INTO public.rede(id, nome, email) VALUES ('5c93098e-9ea7-4a14-abe4-de2fcca0b223','Tamoio','tamoio@afarma.com.br');
INSERT INTO public.rede(id, nome, email) VALUES ('49d878bc-a237-4d87-8ce1-429ec3d0b09e','Raia','raia@afarma.com.br');
INSERT INTO public.rede(id, nome, email) VALUES ('f1be536a-bc44-4ae3-b334-83bec7c461f3','Cristal','cristal@afarma.com.br');
INSERT INTO public.rede(id, nome, email) VALUES ('2b4f69a7-2bca-4c8a-b5a4-4996581cf2f0','São Paulo','sao_paulo@afarma.com.br');
INSERT INTO public.rede(id, nome, email) VALUES ('38741b2a-53be-49a5-a286-55c3a183f812','Farmais','farmais@afarma.com.br');
INSERT INTO public.rede(id, nome, email) VALUES ('35dfa187-0693-4c5d-86b0-88a9497ae376','Rede Conceito','redeconceito@afarma.com.br');
INSERT INTO public.rede(id, nome, email) VALUES ('b8334001-65c8-4008-89e7-bdc15b595bc9','PACHECO','pacheco@afarma.com.br');


INSERT INTO public.vendedor(id, nome, documentoidentidade) VALUES (uuid_generate_v4(),'Vendedor Padrão 1','Documento de Identidade não informado');
INSERT INTO public.vendedor(id, nome, documentoidentidade) VALUES (uuid_generate_v4(),'Vendedor Padrão 2','Documento de Identidade não informado');


INSERT INTO public.entregador(id, nome, documentoidentidade) VALUES (uuid_generate_v4(),'Entregador Padrão 1','Documento de Identidade não informado');
INSERT INTO public.entregador(id, nome, documentoidentidade) VALUES (uuid_generate_v4(),'Entregador Padrão 2','Documento de Identidade não informado');

INSERT INTO public.farmaceutico(id, nome, documentoidentidade) VALUES (uuid_generate_v4(),'Farmacêutico Padrão 1','Documento de Identidade não informado');
INSERT INTO public.farmaceutico(id, nome, documentoidentidade) VALUES (uuid_generate_v4(),'Farmacêutico Padrão 2','Documento de Identidade não informado');

INSERT INTO public.motivocancelamento(id, descricao) VALUES (uuid_generate_v4(),'Fora da área de atendimento');
INSERT INTO public.motivocancelamento(id, descricao) VALUES (uuid_generate_v4(),'Indisponibilidade do entregador');
INSERT INTO public.motivocancelamento(id, descricao) VALUES (uuid_generate_v4(),'Não possui o medicamento');

INSERT INTO public.motivorejeicao(id, descricao) VALUES (uuid_generate_v4(),'CRM do médico que emitiu a receita é inválido.');
INSERT INTO public.motivorejeicao(id, descricao) VALUES (uuid_generate_v4(),'Imagem da Identidade ilegível.');
INSERT INTO public.motivorejeicao(id, descricao) VALUES (uuid_generate_v4(),'Imagem da Procuração ilegível.');
INSERT INTO public.motivorejeicao(id, descricao) VALUES (uuid_generate_v4(),'Imagem da Receita ilegível.');
INSERT INTO public.motivorejeicao(id, descricao) VALUES (uuid_generate_v4(),'Medicamento indicado na receita não faz parte do programa.');
INSERT INTO public.motivorejeicao(id, descricao) VALUES (uuid_generate_v4(),'Prescrição médica não tem mais validade.');
INSERT INTO public.motivorejeicao(id, descricao) VALUES (uuid_generate_v4(),'Receita sem endereço.');
INSERT INTO public.motivorejeicao(id, descricao) VALUES (uuid_generate_v4(),'Sistema do Programa Aqui Tem Farmácia Popular indisponível no momento.');


INSERT INTO public.proprietario(id, nome, documentoidentidade) VALUES (uuid_generate_v4(),'Proprietário Padrão 1','Documento de Identidade não informado');
INSERT INTO public.proprietario(id, nome, documentoidentidade) VALUES (uuid_generate_v4(),'Proprietário Padrão 2','Documento de Identidade não informado');




-------------------------------------------------------------------------------------------------------


--***Inserts Na Produ��o***
--Moderna Rua da concei��o
update usuario set nome = 'admin.drogariamodernaruadaconceicao' where email = 'admin.drogariamodernaruadaconceicao';
update usuario set email = 'admin.drogariamodernaruadaconceicao@afarmapopular.com.br' where nome = 'admin.drogariamodernaruadaconceicao';

update endereco set googleplaceid = 'ChIJcRX-1cSDmQARdARCOsPAcnM' where id = '5f5c1c7f-c73e-40ff-9f69-b441aab02897';
update loja set endereco_id = '5f5c1c7f-c73e-40ff-9f69-b441aab02897' where id = '081f88e9-e929-4380-b849-c005877c3183';

update usuario set enderecoid = '5f5c1c7f-c73e-40ff-9f69-b441aab02897' where id = '8';
update usuario set enderecoid = '5f5c1c7f-c73e-40ff-9f69-b441aab02897' where id = '9';

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Centro',
'24020082',
'Niter�i',
'Lojas 102 a 105',
'Drogaria Moderna da Rua da Concei��o, esquina com Maestro Fel�cio Toledo',
'ChIJLSxdgsODmQARrcMXD1qaiBM',
'-22.894129',
'-43.121025',
'Da Concei��o',
'95',
'RUA',
'RJ');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (uuid_generate_v4(),
'04.779.685/0002-58',
'77.285.431',
'3026306',
'DROGARIA MODERNA',
'3',
'Drogaria Moderna',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJLSxdgsODmQARrcMXD1qaiBM'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'57f04b9d-e74c-4b38-b407-b26cc880b1fb');


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-01',
now(),
'usuario.drogariamodernaruadaconceicao@afarmapopular.com.br',
'usuario.drogariamodernaruadaconceicao',
'1234567890',
'+552430768001',
(select e.id from endereco e where e.googleplaceid = 'ChIJLSxdgsODmQARrcMXD1qaiBM'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '04.779.685/0002-58'),
	(select u.id from usuario u where email = 'usuario.drogariamodernaruadaconceicao@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-01',
now(),
'admin.drogariamodernaruadaconceicao',
'admin.drogariamodernaruadaconceicao@afarmapopular.com.br',
'1234567890',
'+552430768001',
(select e.id from endereco e where e.googleplaceid = 'ChIJLSxdgsODmQARrcMXD1qaiBM'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '04.779.685/0002-58'),
	(select u.id from usuario u where email = 'admin.drogariamodernaruadaconceicao@afarmapopular.com.br')
	);


-- Drogal�der Portuguesa

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4(),
'Portuguesa',
'21920400',
'Rio de Janeiro',
' Lojas A e B',
'Drogaria DrogaL�der Portuguesa',
'ChIJkwyhi4h3mQAR3JAKgwZQrDA',
'-22.79982',
'-43.202767',
'Lu�s de S�',
'275',
'RUA',
'RJ');

 insert into rede (id, email, nome)
 values (uuid_generate_v4(), 'drogalider@afarma.com.br', 'L�der')

insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'29.994.660/0001-17',
'11.150.195',
'1.105.119-7',
'DROGALIDER',
'3',
'DROGARIA DROGALIDER DO VILLAGE LTDA',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJkwyhi4h3mQAR3JAKgwZQrDA'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
(select r.id from rede r where r.nome = 'L�der')
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-02',
now(),
'usuario.drogarialiderportuguesa@afarmapopular.com.br',
'usuario.drogarialiderportuguesa',
'1234567890',
'+552124620444',
(select e.id from endereco e where e.googleplaceid = 'ChIJkwyhi4h3mQAR3JAKgwZQrDA'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '29.994.660/0001-17'),
	(select u.id from usuario u where email = 'usuario.drogarialiderportuguesa@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-02',
now(),
'admin.drogarialiderportuguesa',
'admin.drogarialiderportuguesa@afarmapopular.com.br',
'1234567890',
'+552124620444',
(select e.id from endereco e where e.googleplaceid = 'ChIJkwyhi4h3mQAR3JAKgwZQrDA'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '29.994.660/0001-17'),
	(select u.id from usuario u where email = 'admin.drogarialiderportuguesa@afarmapopular.com.br')
	);

--Tamoio Rua da Concei��o

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Centro',
'24020004',
'Niter�i',
' Lojas A e B',
'Drogaria Tamoio Visc do Rio Branco',
'ChIJcRX-1cSDmQARdARCOsPAcnM',
'-22.89541',
'-43.123928',
'Visconde do Rio Branco',
'505',
'AVENIDA',
'RJ');

insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'06.993.428/0003-20',
'78.551.070',
'1405497',
'DROGARIA TAMOIO',
'3',
'DROGARIA DROGALIDER DO VILLAGE LTDA',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJcRX-1cSDmQARdARCOsPAcnM'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'5c93098e-9ea7-4a14-abe4-de2fcca0b223'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-03',
now(),
'usuario.drogariatamoioviscriobranco@afarmapopular.com.br',
'usuario.drogariatamoioviscriobranco',
'1234567890',
'+552124620444',
(select e.id from endereco e where e.googleplaceid = 'ChIJcRX-1cSDmQARdARCOsPAcnM'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '06.993.428/0003-20'),
	(select u.id from usuario u where email = 'usuario.drogariatamoioviscriobranco@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-03',
now(),
'admin.drogariatamoioviscriobranco',
'admin.drogariatamoioviscriobranco@afarmapopular.com.br',
'1234567890',
'+552126223000',
(select e.id from endereco e where e.googleplaceid = 'ChIJcRX-1cSDmQARdARCOsPAcnM'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '06.993.428/0003-20'),
	(select u.id from usuario u where email = 'admin.drogariatamoioviscriobranco@afarmapopular.com.br')
	);

--------------------------------------------------------------------------------------

INSERT INTO public.rede(id, nome, email) VALUES (uuid_generate_v4(),'nissei','nissei@afarma.com.br');

--Av. , 326 - ,  - SC, 88101-100  ChIJL9wzSSE2J5UR3LQRnRG4ybg  , 

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Kobrasol',
'88101100',
'S�o Jos�',
'',
'Drogaria Nissei da Av L Jo�o Martins, esquina com Emerson Ferrari',
'ChIJL9wzSSE2J5UR3LQRnRG4ybg',
'-27.598534243107217',
'-48.61436354136414',
'L�dio Jo�o Martins',
'326',
'AVENIDA',
'SC');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'79.430.682/0191-41',
'256313636',
'0',
'Drogaria Nissei',
'3',
'FARMACIA E DROGARIA NISSEI S.A.',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJL9wzSSE2J5UR3LQRnRG4ybg'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'472fa40a-6574-4cbe-8050-76fd7ea162a3'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-04',
now(),
'usuario.farmacianisseikobrasol@afarmapopular.com.br',
'usuario.farmacianisseikobrasol',
'1234567890',
'+554830359412',
(select e.id from endereco e where e.googleplaceid = 'ChIJL9wzSSE2J5UR3LQRnRG4ybg'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '79.430.682/0191-41'),
	(select u.id from usuario u where email = 'usuario.farmacianisseikobrasol@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-04',
now(),
'admin.farmacianisseikobrasol',
'admin.farmacianisseikobrasol@afarmapopular.com.br',
'1234567890',
'+554830359412',
(select e.id from endereco e where e.googleplaceid = 'ChIJL9wzSSE2J5UR3LQRnRG4ybg'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '79.430.682/0191-41'),
	(select u.id from usuario u where email = 'admin.farmacianisseikobrasol@afarmapopular.com.br')
	);

----------------------------------------------------------------------------------------------------------------------------------------------------------
--R. , 127 - Centro, Curitiba - PR, 80010020  ChIJo57Bvm3k3JQRleVXqfFwwjg  , 

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Centro',
'80010020',
'Curitiba',
'',
'Drogaria Nissei da R. Pedro Ivo',
'ChIJo57Bvm3k3JQRleVXqfFwwjg',
'-25.43452386132472',
'-49.2723945530408',
'Pedro Ivo',
'127',
'RUA',
'PR');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'79.430.682/0029-23',
'90229900-95',
'04214790',
'Drogaria Nissei',
'3',
'FARMACIA E DROGARIA NISSEI S.A.',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJo57Bvm3k3JQRleVXqfFwwjg'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'472fa40a-6574-4cbe-8050-76fd7ea162a3'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-05',
now(),
'usuario.farmacianisseipedroivo@afarmapopular.com.br',
'usuario.farmacianisseipedroivo',
'1234567890',
'+554132333319',
(select e.id from endereco e where e.googleplaceid = 'ChIJo57Bvm3k3JQRleVXqfFwwjg'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '79.430.682/0029-23'),
	(select u.id from usuario u where email = 'usuario.farmacianisseipedroivo@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-05',
now(),
'admin.farmacianisseipedroivo',
'admin.farmacianisseipedroivo@afarmapopular.com.br',
'1234567890',
'+554132333319',
(select e.id from endereco e where e.googleplaceid = 'ChIJo57Bvm3k3JQRleVXqfFwwjg'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '79.430.682/0029-23'),
	(select u.id from usuario u where email = 'admin.farmacianisseipedroivo@afarmapopular.com.br')
	);

-------------------------------------------------------------------------------------------------------------

--R. , 733 - Centro, Lins - SP,     , 

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Centro',
'16400100',
'Lins',
'',
'Drogaria Nissei da R. Floriano Peixoto',
'ChIJ-yp-IssVvpQRZ4QHmII8xis',
'-21.673427996590526',
'-49.755384294272886',
'Floriano Peixoto',
'733',
'RUA',
'SP');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'79.430.682/0241-45',
'419.066.144.110',
'',
'Drogaria Nissei',
'3',
'FARMACIA E DROGARIA NISSEI S.A.',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJ-yp-IssVvpQRZ4QHmII8xis'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'472fa40a-6574-4cbe-8050-76fd7ea162a3'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-06',
now(),
'usuario.farmacianisseiflorianopeixotolins@afarmapopular.com.br',
'usuario.farmacianisseiflorianopeixotolins',
'1234567890',
'+554132138487',
(select e.id from endereco e where e.googleplaceid = 'ChIJ-yp-IssVvpQRZ4QHmII8xis'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '79.430.682/0241-45'),
	(select u.id from usuario u where email = 'usuario.farmacianisseiflorianopeixotolins@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-06',
now(),
'admin.farmacianisseiflorianopeixotolins',
'admin.farmacianisseiflorianopeixotolins@afarmapopular.com.br',
'1234567890',
'+554132138487',
(select e.id from endereco e where e.googleplaceid = 'ChIJ-yp-IssVvpQRZ4QHmII8xis'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '79.430.682/0241-45'),
	(select u.id from usuario u where email = 'admin.farmacianisseiflorianopeixotolins@afarmapopular.com.br')
	);

-----------------------------------------------------------------------------------------------
--Av. , 4126 - Jardim dos Estados, Campo Grande - MS, 79020-001    , 

INSERT INTO public.rede(id, nome, email) VALUES (uuid_generate_v4(),'Drogasil','drogasil@afarma.com.br');

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Jardim dos Estados',
'79020001',
'Campo Grande',
'',
'Drogaria Nissei da Av. Afonso Pena',
'ChIJZd5pZ73ohpQRlCiQKoD2jnM',
'-20.46109125670501',
'-54.59704958627247',
'Afonso Pena',
'4126',
'AVENIDA',
'MS');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'61.585.865/1112-20',
'28.392.835-2',
'',
'Drogaria Nissei',
'3',
'RAIA DROGASIL S.A',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJZd5pZ73ohpQRlCiQKoD2jnM'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'bbd7e0f4-6d75-4969-b999-6c22759da057'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-07',
now(),
'usuario.farmaciadrogasilafonsopena@afarmapopular.com.br',
'usuario.farmaciadrogasilafonsopena',
'1234567890',
'+551137695731',
(select e.id from endereco e where e.googleplaceid = 'ChIJZd5pZ73ohpQRlCiQKoD2jnM'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '61.585.865/1112-20'),
	(select u.id from usuario u where email = 'usuario.farmaciadrogasilafonsopena@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-07',
now(),
'admin.farmaciadrogasilafonsopena',
'admin.farmaciadrogasilafonsopena@afarmapopular.com.br',
'1234567890',
'+551137695731',
(select e.id from endereco e where e.googleplaceid = 'ChIJZd5pZ73ohpQRlCiQKoD2jnM'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '61.585.865/1112-20'),
	(select u.id from usuario u where email = 'admin.farmaciadrogasilafonsopena@afarmapopular.com.br')
	);

------------------------------------------------------------------------------------------------------------------
-- ;  ;  ; Av. , 542 - St. Oeste,  - GO,  ;  -16.684638993510436, -49.26396648773066; 

INSERT INTO public.rede(id, nome, email) VALUES (uuid_generate_v4(),'Drogasil','drogasil@afarma.com.br');

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Setor Oeste',
'74130011',
'Goi�nia',
'',
'Drogasil da Assis Chateaubriand',
'ChIJiabJWF3xXpMRLHw2vYQsouk',
'-16.684638993510436',
'-49.26396648773066',
'Assis Chateaubriand',
'542',
'AVENIDA',
'GO');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'61.412.110/0493-24',
'10.565.993-2',
'3507289',
'Drogarias Pacheco',
'3',
'Drogaria Sao Paulo S.a.',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJiabJWF3xXpMRLHw2vYQsouk'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'b8334001-65c8-4008-89e7-bdc15b595bc9'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-08',
now(),
'usuario.drogariapachecoassischateaubriand@afarmapopular.com.br',
'usuario.drogariapachecoassischateaubriand',
'1234567890',
'+556239427890',
(select e.id from endereco e where e.googleplaceid = 'ChIJiabJWF3xXpMRLHw2vYQsouk'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '61.412.110/0493-24'),
	(select u.id from usuario u where email = 'usuario.drogariapachecoassischateaubriand@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-08',
now(),
'admin.drogariapachecoassischateaubriand',
'admin.drogariapachecoassischateaubriand@afarmapopular.com.br',
'1234567890',
'+556239427890',
(select e.id from endereco e where e.googleplaceid = 'ChIJiabJWF3xXpMRLHw2vYQsouk'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '61.412.110/0493-24'),
	(select u.id from usuario u where email = 'admin.drogariapachecoassischateaubriand@afarmapopular.com.br')
	);

---------------------------------------------------------------------------------
--9132300752;  Av. Visc. de Souza Franco, 863 - Umarizal Bel�m - PA ; ; ; ; ChIJiWczGJiOpJIRpFANqk4dNpY , -48.488140738131435


insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Setor Oeste',
'66055005',
'Bel�m',
'',
'Drogasil da Visc. de Souza Franco',
'ChIJiWczGJiOpJIRpFANqk4dNpY',
'-1.4458744937607024',
'-48.488140738131435',
'Visconde de Souza Franco',
'863',
'AVENIDA',
'PA');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'61.585.865/2047-41',
'15.623.882-9',
'15900486484',
'',
'3',
'RAIA DROGASIL S/A',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJiWczGJiOpJIRpFANqk4dNpY'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'bbd7e0f4-6d75-4969-b999-6c22759da057'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-09',
now(),
'usuario.drogasilviscsouzafranco@afarmapopular.com.br',
'usuario.drogasilviscsouzafranco',
'1234567890',
'+559132300752',
(select e.id from endereco e where e.googleplaceid = 'ChIJiWczGJiOpJIRpFANqk4dNpY'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '61.585.865/2047-41'),
	(select u.id from usuario u where email = 'usuario.drogasilviscsouzafranco@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-09',
now(),
'admin.drogasilviscsouzafranco',
'admin.drogasilviscsouzafranco@afarmapopular.com.br',
'1234567890',
'+559132300752',
(select e.id from endereco e where e.googleplaceid = 'ChIJiWczGJiOpJIRpFANqk4dNpY'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '61.585.865/2047-41'),
	(select u.id from usuario u where email = 'admin.drogasilviscsouzafranco@afarmapopular.com.br')
	);
--------------------------------------------------------------------------------------------------------
--R. , 1902 - CENTRO, Macap� - AP, 68908120; ChIJXf0oGgXhYY0Rj89G3ZWbonc; 96984140399; , ; ; ; 


INSERT INTO public.rede(id, nome, email) VALUES (uuid_generate_v4(),'Extrafarma','extrafarma@afarma.com.br');

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Centro',
'68908120',
'Macap�',
'',
'Extrafamra da Leopoldo Machado',
'ChIJXf0oGgXhYY0Rj89G3ZWbonc',
'0.03515619997424991',
'-51.062440131522095',
'Leopoldo Machado',
'1902',
'RUA',
'PA');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'04.899.316/0199-94',
'03.041526-8',
'1690004476-8',
'FARMACIA EXTRAFARMA',
'3',
'IMIFARMA PRODUTOS FARMACEUTICOS E COSMETICOS S.A.',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJXf0oGgXhYY0Rj89G3ZWbonc'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'7f554ccb-ee47-4412-9a0b-1dda9cee0b93'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-10',
now(),
'usuario.extrafarmaleopoldomachado@afarmapopular.com.br',
'usuario.extrafarmaleopoldomachado',
'1234567890',
'+5596984140399',
(select e.id from endereco e where e.googleplaceid = 'ChIJXf0oGgXhYY0Rj89G3ZWbonc'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '04.899.316/0199-94'),
	(select u.id from usuario u where email = 'usuario.extrafarmaleopoldomachado@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-10',
now(),
'admin.extrafarmaleopoldomachado',
'admin.extrafarmaleopoldomachado@afarmapopular.com.br',
'1234567890',
'+5596984140399',
(select e.id from endereco e where e.googleplaceid = 'ChIJXf0oGgXhYY0Rj89G3ZWbonc'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '04.899.316/0199-94'),
	(select u.id from usuario u where email = 'admin.extrafarmaleopoldomachado@afarmapopular.com.br')
	);

-------------------------------------------------------------------------------------------------------------------
--


INSERT INTO public.rede(id, nome, email) VALUES (uuid_generate_v4(),'Paguemenos','paguemenos@afarma.com.br');



insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Centro',
'68908120',
'Macap�',
'',
'Extrafamra da Leopoldo Machado',
'ChIJXf0oGgXhYY0Rj89G3ZWbonc',
'0.03515619997424991',
'-51.062440131522095',
'Leopoldo Machado',
'1902',
'RUA',
'PA');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'04.899.316/0199-94',
'03.041526-8',
'1690004476-8',
'FARMACIA EXTRAFARMA',
'3',
'IMIFARMA PRODUTOS FARMACEUTICOS E COSMETICOS S.A.',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJXf0oGgXhYY0Rj89G3ZWbonc'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'7f554ccb-ee47-4412-9a0b-1dda9cee0b93'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-11',
now(),
'usuario.extrafarmaleopoldomachado@afarmapopular.com.br',
'usuario.extrafarmaleopoldomachado',
'1234567890',
'+5596984140399',
(select e.id from endereco e where e.googleplaceid = 'ChIJXf0oGgXhYY0Rj89G3ZWbonc'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '04.899.316/0199-94'),
	(select u.id from usuario u where email = 'usuario.extrafarmaleopoldomachado@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-11',
now(),
'admin.extrafarmaleopoldomachado',
'admin.extrafarmaleopoldomachado@afarmapopular.com.br',
'1234567890',
'+5596984140399',
(select e.id from endereco e where e.googleplaceid = 'ChIJXf0oGgXhYY0Rj89G3ZWbonc'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '04.899.316/0199-94'),
	(select u.id from usuario u where email = 'admin.extrafarmaleopoldomachado@afarmapopular.com.br')
	);









insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,05','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,1','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,2','false');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,3','false');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,15','false');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,08','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,03','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,04','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,12','false');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,05','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,1','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,2','false');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,3','false');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,15','false');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,08','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,03','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,04','true');
insert into percentualrepasse (id, percentual, status) values ('uuid_generate_v4()','0,12','false');

-----------------------------------------------------------------------------------

insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '4.8', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '5.1', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '2.1', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AC', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AC', '21.4', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AC', '10.7', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AC', '6.42', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AC', '3.21', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AC', '21.5', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AC', '10.75', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AC', '6.45', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AC', '3.23', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'AC', '15.5', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AC', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'AC', '8.4', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AC', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AC', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'AC', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AC', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AC', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');

insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '3.3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '5.4', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '5.4', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AL', '7.2', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AL', '21.8', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AL', '10.9', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AL', '6.54', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AL', '3.27', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AL', '21.8', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AL', '10.9', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AL', '6.54', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AL', '3.27', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'AL', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AL', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'AL', '9.2', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AL', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AL', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'AL', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AL', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AL', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '2.7', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '2.7', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '1.5', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '5.1', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '2.1', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '3.9', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '4.2', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AM', '6.6', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AM', '20.1', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AM', '10.05', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AM', '6.03', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AM', '3.02', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AM', '19.9', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AM', '9.95', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AM', '5.97', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AM', '2.99', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'AM', '15', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AM', '16', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'AM', '8.4', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AM', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AM', '30', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'AM', '20.4', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AM', '68', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AM', '40', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '3.6', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '5.4', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '5.1', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '5.1', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'AP', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AP', '21.8', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AP', '10.9', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AP', '6.54', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AP', '3.27', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AP', '22', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AP', '11', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AP', '0.22', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'AP', '0.11', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'AP', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AP', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'AP', '8.4', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AP', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AP', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'AP', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AP', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'AP', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');

insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '3.3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '4.8', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'BA', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'BA', '21.6', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'BA', '10.8', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'BA', '6.48', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'BA', '3.24', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'BA', '21.6', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'BA', '10.8', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'BA', '6.48', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'BA', '3.24', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'BA', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'BA', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'BA', '8.8', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'BA', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'BA', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'BA', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'BA', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'BA', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');

insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '3.3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '5.7', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '5.4', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'CE', '7.2', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'CE', '21.7', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'CE', '10.85', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'CE', '6.51', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'CE', '3.26', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'CE', '21.8', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'CE', '10.9', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'CE', '6.54', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'CE', '3.27', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'CE', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'CE', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'CE', '9.4', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'CE', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'CE', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'CE', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'CE', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'CE', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');

insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '5.4', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '6', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'DF', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'DF', '22.6', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'DF', '11.3', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'DF', '6.78', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'DF', '3.39', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'DF', '22.5', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'DF', '11.25', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'DF', '6.75', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'DF', '3.38', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'DF', '15.5', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'DF', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'DF', '9', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'DF', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'DF', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'DF', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'DF', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'DF', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '4.8', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'ES', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'ES', '22', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'ES', '11', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'ES', '6.6', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'ES', '3.3', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'ES', '22', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'ES', '11', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'ES', '6.6', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'ES', '3.3', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'ES', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'ES', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'ES', '9', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'ES', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'ES', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'ES', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'ES', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'ES', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '5.7', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'GO', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'GO', '22', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'GO', '11', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'GO', '6.6', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'GO', '3.3', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'GO', '22', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'GO', '11', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'GO', '6.6', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'GO', '3.3', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'GO', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'GO', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'GO', '9.2', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'GO', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'GO', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'GO', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'GO', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'GO', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');

insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '3.6', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '5.7', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '5.7', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '2.7', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MA', '7.5', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MA', '23.5', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MA', '11.75', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MA', '7.05', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MA', '3.53', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MA', '23.7', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MA', '11.85', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MA', '7.11', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MA', '3.56', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'MA', '0.8', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MA', '20', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'MA', '9.2', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MA', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MA', '34', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'MA', '21.6', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MA', '72', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MA', '44', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '2.7', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '4.5', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '1.5', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '4.8', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '2.1', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '3.9', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MG', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MG', '20.08', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MG', '11.2', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MG', '6.72', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MG', '3.36', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MG', '22.3', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MG', '11.5', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MG', '6.69', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MG', '3.35', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'MG', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MG', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'MG', '8.6', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MG', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MG', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'MG', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MG', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MG', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '4.8', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '2.1', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '3.9', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MS', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MS', '20.08', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MS', '11.2', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MS', '6.72', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MS', '3.36', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MS', '22.3', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MS', '11.5', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MS', '6.69', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MS', '3.35', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'MS', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MS', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'MS', '9.4', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MS', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MS', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'MS', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MS', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MS', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '2.4', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '4.2', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '2.7', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '1.5', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '4.2', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '2.1', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '3.9', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '4.2', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'MT', '7.2', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MT', '19.6', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MT', '9.8', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MT', '5.88', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MT', '2.94', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MT', '19.7', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MT', '9.85', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MT', '5.91', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'MT', '2.96', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'MT', '16.1', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MT', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'MT', '8.4', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MT', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MT', '30', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'MT', '22.2', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MT', '74', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'MT', '44', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '3.9', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '6', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '5.7', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PA', '7.2', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PA', '22.5', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PA', '11.25', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PA', '6.75', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PA', '3.38', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PA', '0.37', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PA', '11.1', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PA', '6.66', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PA', '3.33', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'PA', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PA', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'PA', '9.8', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PA', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PA', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'PA', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PA', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PA', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '4.8', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '4.8', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PB', '7.2', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PB', '22.2', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PB', '11.1', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PB', '6.66', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PB', '3.33', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PB', '21.7', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PB', '10.85', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PB', '6.51', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PB', '3.26', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'PB', '15.7', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PB', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'PB', '9', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PB', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PB', '30', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'PB', '21.6', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PB', '72', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PB', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '3.3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '5.7', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '5.4', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PE', '7.2', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PE', '21.8', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PE', '10.9', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PE', '6.54', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PE', '3.27', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PE', '21.9', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PE', '10.95', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PE', '6.57', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PE', '3.29', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'PE', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PE', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'PE', '9', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PE', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PE', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'PE', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PE', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PE', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '3.3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '5.7', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '5.7', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PI', '7.2', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PI', '21.6', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PI', '10.8', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PI', '6.48', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PI', '3.24', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PI', '21.7', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PI', '10.85', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PI', '6.51', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PI', '3.26', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'PI', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PI', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'PI', '9.8', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PI', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PI', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'PI', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PI', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PI', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '3.6', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '6', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '3.6', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '6', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '2.7', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '4.5', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '5.1', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'PR', '7.5', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PR', '20.13', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PR', '11.95', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PR', '7.17', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PR', '3.59', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PR', '23.7', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PR', '11.85', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PR', '7.11', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'PR', '3.56', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'PR', '16.3', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PR', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'PR', '9.2', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PR', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PR', '34', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'PR', '22.2', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PR', '74', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'PR', '46', '7bb3f3c0-7a40-454c-9890-8310dfffa370');



insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '5.1', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RN', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RN', '21.8', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RN', '10.9', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RN', '6.54', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RN', '3.27', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RN', '21.9', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RN', '10.95', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RN', '6.57', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RN', '3.29', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'RN', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RN', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'RN', '8.8', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RN', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RN', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'RN', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RN', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RN', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '5.4', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '4.8', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RO', '7.2', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RO', '22.1', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RO', '11.05', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RO', '6.63', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RO', '3.32', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RO', '20.08', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RO', '11.2', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RO', '6.72', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RO', '3.36', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'RO', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RO', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'RO', '9', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RO', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RO', '28', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'RO', '21.6', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RO', '72', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RO', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '3.3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '4.5', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '2.1', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '3.9', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '4.2', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RR', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RR', '21.2', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RR', '10.6', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RR', '6.36', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RR', '3.18', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RR', '21.4', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RR', '10.7', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RR', '6.42', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RR', '3.21', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'RR', '15.4', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RR', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'RR', '9', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RR', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RR', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'RR', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RR', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RR', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '5.4', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'RS', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RS', '22.2', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RS', '11.1', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RS', '6.66', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RS', '3.33', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RS', '22.3', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RS', '11.15', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RS', '6.69', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'RS', '3.35', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'RS', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RS', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'RS', '9', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RS', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RS', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'RS', '21.6', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RS', '72', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'RS', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '2.7', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '4.2', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '2.7', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '1.5', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '4.8', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '2.1', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '3.9', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SC', '6.6', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SC', '20', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SC', '10', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SC', '6', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SC', '3', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SC', '20.2', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SC', '10.1', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SC', '6.06', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SC', '3.03', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'SC', '15.4', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SC', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'SC', '8.8', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SC', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SC', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'SC', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SC', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SC', '40', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '5.7', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '2.4', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '3.3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '5.4', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '4.8', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SE', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SE', '21.8', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SE', '10.9', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SE', '6.54', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SE', '3.27', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SE', '21.8', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SE', '10.9', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SE', '6.54', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SE', '3.27', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'SE', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SE', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'SE', '9', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SE', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SE', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'SE', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SE', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SE', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '2.4', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '3.9', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '1.8', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '2.4', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '1.5', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '4.5', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '2.1', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '3.9', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '4.2', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'SP', '6.6', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SP', '20.3', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SP', '10.15', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SP', '6.09', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SP', '3.05', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SP', '20.4', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SP', '10.2', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SP', '6.12', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'SP', '3.06', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'SP', '15.4', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SP', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'SP', '8.6', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SP', '26', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SP', '32', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'SP', '21.6', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SP', '72', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'SP', '40', '7bb3f3c0-7a40-454c-9890-8310dfffa370');


insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '3', 'bf133a6d-88d9-4473-942e-59e874dc0a47');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '5.1', 'd025ac2f-a3f3-4ea4-9939-df7e7c6cfacc');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '2.1', 'eedaf752-a511-42f4-b04a-df6f8396fe39');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '3', 'da1d7783-8bb8-4141-97f7-0f1e197b94ae');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '1.8', 'b469a5cc-bfa0-41ce-9dc1-ba051ec8dcb3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '4.8', '04c0ad91-8fb1-4e8b-a092-d965b5c76b51');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '2.4', '43f10888-3a2d-4243-9257-0fd087cb5a2b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '4.2', 'f9a2feaa-d9aa-482b-931a-5275e23dc4a3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '4.5', '251d163c-13f8-44d1-ab79-50dadc187d54');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'30', 'TO', '6.9', 'f2d2a379-2769-4a96-9a56-b356000ff1d8');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'TO', '21.7', 'cb16e64f-6480-4b39-8fc8-037931840fde');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'TO', '10.85', '8cb9ef38-9cd2-4c71-9478-89c4927b53b1');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'TO', '6.51', '08bbac7e-8c4e-49c9-8612-daa266f1f03f');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'TO', '3.26', '7c8a73e2-cd17-4b5d-bf18-50decc247b63');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'TO', '21.8', 'c10d4692-89cb-4bb0-a7c5-4a59dc995923');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'TO', '10.9', '972a0d1d-e2c6-4c03-a0b6-5c89bcb0e111');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'TO', '6.54', '0a5fac9a-e87c-459e-b0b4-75468360c511');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'1', 'TO', '3.27', '6cef0393-d85b-4d6f-aef7-75c8498f998e');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'10', 'TO', '15.6', 'a60b53a1-a312-4dcb-97a5-9aa6161c468a');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'TO', '18', 'c0c7b69d-44c5-4239-9e8c-73af138628ec');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'20', 'TO', '8.8', 'd67e8304-d13c-4edd-a0d2-3347884992de');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'TO', '28', '80f49c6e-ea55-48c6-a9ab-1bc814abbfba');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'TO', '30', 'a3029f6b-977f-4820-ab23-84c9b5b487d3');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'60', 'TO', '21', '8ae83c4b-8841-49a2-a353-5aee7a904174');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'TO', '70', '1f027ba7-7c44-4e67-8e83-68723f2b6d7b');
insert into itemprodutopopular(id, quantidade, uf, valorunitario, produto_id) values (uuid_generate_v4(),'200', 'TO', '42', '7bb3f3c0-7a40-454c-9890-8310dfffa370');




update loja set active = true;
update loja set active = false where raioentrega = '0';



delete from distribuicao_alerta ;
delete from alerta ;
delete from pedido_procuracao ;
delete from pedido; 
delete from venda ;


update loja set nomefantasia = '' where id = '90baf4c7-4d66-46c0-b2ce-8adfeb9dcd03';
update usuario set ativo = false where id >'9';
update loja set nomefantasia = 'Raia Drogasil S/A' where id = '90baf4c7-4d66-46c0-b2ce-8adfeb9dcd03';



-----------------------------------------------------------------------------------------
--Estrada do Gale�o, 1401 B - Jardim Carioca,  - RJ,   , 


INSERT INTO public.rede(id, nome, email) VALUES (uuid_generate_v4(),'Droganews','joaopaulo@droganews.com.br');



insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Jardim Carioca',
'21931383',
'Rio de Janeiro',
'Loja B',
'Droganews Estrada do Gale�o',
'ChIJq6p6bSF4mQARV53O1p-KK5E',
'-22.807954367072533',
'-43.1971506739058',
'Do Gale�o',
'1401',
'Estrada',
'RJ');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'00.649.884/0001-00',
'84.924.19.9',
'0.184.185-8',
'DROGARIA JARDIM DO POVO LTDA',
'6',
'DROGANEWS',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJq6p6bSF4mQARV53O1p-KK5E'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'fbe1d0c6-4895-4d4d-822d-e4c897d20e1e'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-12',
now(),
'usuario.joaopaulodroganews@afarmapopular.com.br',
'usuario.joaopaulodroganews',
'1234567890',
'2133931033',
(select e.id from endereco e where e.googleplaceid = 'ChIJq6p6bSF4mQARV53O1p-KK5E'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '00.649.884/0001-00'),
	(select u.id from usuario u where email = 'usuario.joaopaulodroganews@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-12',
now(),
'admin.joaopaulodroganews',
'admin.joaopaulodroganews@afarmapopular.com.br',
'1234567890',
'2133931033',
(select e.id from endereco e where e.googleplaceid = 'ChIJq6p6bSF4mQARV53O1p-KK5E'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '00.649.884/0001-00'),
	(select u.id from usuario u where email = 'admin.joaopaulodroganews@afarmapopular.com.br')
	);

-------------------------------------------------------------------------------------------------
--Av. Meriti, 2260 - Vila da Penha,  - RJ, 21211006  , 

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Vila da Penha',
'21211006',
'Rio de Janeiro',
'Loja A',
'Droganews Avenida Mereti',
'ChIJbRiNrV97mQARze7GfHhwUMo',
'-22.83983924374107',
'-43.312001460820795',
'Mereti',
'2260',
'Avenida',
'RJ');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'11.469.542/0001-24',
'78.956.99.2',
'0.477.439-6',
'DROGANEWS',
'4',
'DROGARIA PRINCIPAL DO BICAO LTDA',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJbRiNrV97mQARze7GfHhwUMo'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'fbe1d0c6-4895-4d4d-822d-e4c897d20e1e'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-13',
now(),
'usuario.joaopaulodroganewsmereti@afarmapopular.com.br',
'usuario.joaopaulodroganewsmereti',
'1234567890',
'2133521111',
(select e.id from endereco e where e.googleplaceid = 'ChIJbRiNrV97mQARze7GfHhwUMo'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '11.469.542/0001-24'),
	(select u.id from usuario u where email = 'usuario.joaopaulodroganewsmereti@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-13',
now(),
'admin.joaopaulodroganewsmereti',
'admin.joaopaulodroganewsmereti@afarmapopular.com.br',
'1234567890',
'2133521111',
(select e.id from endereco e where e.googleplaceid = 'ChIJbRiNrV97mQARze7GfHhwUMo'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '11.469.542/0001-24'),
	(select u.id from usuario u where email = 'admin.joaopaulodroganewsmereti@afarmapopular.com.br')
	);

------------------------------------

update loja set active = true where nomefantasia = 'DROGANEWS';
update loja set nomefantasia = 'DROGANEWS' where nomefantasia = 'DROGARIA JARDIM DO POVO LTDA';
update endereco set descricao = 'Extrafarma da Leopoldo Machado' where id = 'acb94d26-3f8d-4e91-8c05-629592e4128d';

------------------------------------------------------


insert into loja_entregador values('64d67037-1c83-4858-bae6-b4d6f833ceb5', '6a9dc776-501f-4602-b329-2a490beae8cc'),
('57898d48-e428-4238-b746-0b27b1427e2a', 'cd48e870-499a-4b8a-bfe8-006fb0c0b9a3'), ('57898d48-e428-4238-b746-0b27b1427e2a','6a9dc776-501f-4602-b329-2a490beae8cc'),
('64d67037-1c83-4858-bae6-b4d6f833ceb5', 'cd48e870-499a-4b8a-bfe8-006fb0c0b9a3');

insert into loja_vendedor values('64d67037-1c83-4858-bae6-b4d6f833ceb5', '82a4df79-a9f5-4d01-9134-92c490f1f389'),
('57898d48-e428-4238-b746-0b27b1427e2a', '82a4df79-a9f5-4d01-9134-92c490f1f389'), ('57898d48-e428-4238-b746-0b27b1427e2a','0f3929ac-c329-494b-abac-0e26be0d6cb3'),
('64d67037-1c83-4858-bae6-b4d6f833ceb5', '0f3929ac-c329-494b-abac-0e26be0d6cb3');

-----------------------------------------------------------------------

--Rua , 105    , , ,  

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Bonsucesso',
'21032025',
'Rio de Janeiro',
'Loja A',
'Droganews Avenida Mereti',
'ChIJW0z_qgF8mQARXQ7ml4CLSF0',
'-22.863861960149972',
'-43.254439385569825',
'Cardoso de Moraes',
'105',
'RUA',
'RJ');
 

insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'00.194.809/0001-00',
'79027936',
'0.164.564-1',
'Drogaria Cristal',
'4',
'Drogaria Lider de Bonsucesso LTDA',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJW0z_qgF8mQARXQ7ml4CLSF0'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'f1be536a-bc44-4ae3-b334-83bec7c461f3'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-14',
now(),
'usuario.drogarialiderbonsucessoltda@afarmapopular.com.br',
'usuario.drogarialiderbonsucessoltda',
'1234567890',
'2133521111',
(select e.id from endereco e where e.googleplaceid = 'ChIJW0z_qgF8mQARXQ7ml4CLSF0'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '00.194.809/0001-00'),
	(select u.id from usuario u where email = 'usuario.drogarialiderbonsucessoltda@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-14',
now(),
'admin.drogarialiderbonsucessoltda',
'admin.drogarialiderbonsucessoltda@afarmapopular.com.br',
'1234567890',
'2133521111',
(select e.id from endereco e where e.googleplaceid = 'ChIJW0z_qgF8mQARXQ7ml4CLSF0'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '00.194.809/0001-00'),
	(select u.id from usuario u where email = 'admin.drogarialiderbonsucessoltda@afarmapopular.com.br')
	);

------------------------------------
--R. , 5 -   - RJ   ,     

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Tijuca',
'20270220',
'Rio de Janeiro',
'Loja A',
'Drogaria Cristal Rua Caruso',
'ChIJKyddWat_mQARrgCvn2OtmDU',
'-22.918232707267013',
'-43.212575706008025',
'Caruso',
'5',
'RUA',
'RJ');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'05.034.873/0001-39',
'77356568',
'0.318.806-0',
'Drogaria Cristal',
'4',
'Drogaria Moorea LTDA',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJKyddWat_mQARrgCvn2OtmDU'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'f1be536a-bc44-4ae3-b334-83bec7c461f3'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-15',
now(),
'usuario.drogariamoorealtda@afarmapopular.com.br',
'usuario.drogariamoorealtda',
'1234567890',
'02125028000',
(select e.id from endereco e where e.googleplaceid = 'ChIJKyddWat_mQARrgCvn2OtmDU'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '05.034.873/0001-39'),
	(select u.id from usuario u where email = 'usuario.drogariamoorealtda@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-15',
now(),
'admin.drogariamoorealtda',
'admin.drogariamoorealtda@afarmapopular.com.br',
'1234567890',
'02125028000',
(select e.id from endereco e where e.googleplaceid = 'ChIJKyddWat_mQARrgCvn2OtmDU'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '05.034.873/0001-39'),
	(select u.id from usuario u where email = 'admin.drogariamoorealtda@afarmapopular.com.br')
	);



----------------------------------------------------------------------------------
-- R. , 380,   ,   	

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Andarai',
'20510060',
'Rio de Janeiro',
'Loja 16',
'Drogaria Cristal Rua Caruso',
'ChIJYVU6DxB-mQARcAi2IQ-NzZo',
'-22.932171785473688',
'-43.24157065503652',
'Uruguai',
'380',
'RUA',
'RJ');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'07.682.947/0001-79',
'78.012.10-2',
'0.378.950-0',
'Drogaria Cristal',
'4',
'Farmacia Uruguai Prime LTDA',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'ChIJYVU6DxB-mQARcAi2IQ-NzZo'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
'f1be536a-bc44-4ae3-b334-83bec7c461f3'
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-16',
now(),
'usuario.farmaciauruguaiprimeltda@afarmapopular.com.br',
'usuario.farmaciauruguaiprimeltda',
'1234567890',
'2122380000',
(select e.id from endereco e where e.googleplaceid = 'ChIJYVU6DxB-mQARcAi2IQ-NzZo'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '07.682.947/0001-79'),
	(select u.id from usuario u where email = 'usuario.farmaciauruguaiprimeltda@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-16',
now(),
'admin.farmaciauruguaiprimeltda',
'admin.farmaciauruguaiprimeltda@afarmapopular.com.br',
'1234567890',
'2122380000',
(select e.id from endereco e where e.googleplaceid = 'ChIJYVU6DxB-mQARcAi2IQ-NzZo'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '07.682.947/0001-79'),
	(select u.id from usuario u where email = 'admin.farmaciauruguaiprimeltda@afarmapopular.com.br')
	);
	
update endereco set descricao = 'Drogaria Cristal Cardoso de Moraes' where lat = '-22.863861960149972';
 update usuario set telefone = ' 2122609259' where cpf = '000.000.000-14';
 update endereco set descricao = 'Drogaria Cristal Uruguai' where lat = '-22.932171785473688';
 
 update loja set raioentrega = '5' where nomefantasia != 'Drogaria Cristal';
 


insert into percentualrepasse values (uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true),
(uuid_generate_v4(), '5', true);


insert into loja_percentual values ('b1a9010b-e6e4-43dd-9d01-8d0e6d2ee8c6','6594e9d3-32d0-4740-917a-fa6e03650d28');
insert into loja_percentual values ('f2985a10-3c08-494a-9ec3-20ac44319c4f','5eb4cdef-144a-42dd-9c52-c31bd98470bb');
insert into loja_percentual values ('61dd808e-0828-45bc-af3b-edbb0a2acff6','cc781d51-1fc2-4aca-9754-ea91a89c676e');
insert into loja_percentual values ('7ff6dd38-6ebf-4970-a314-96460cc6a6a3','270a26b1-ba90-473c-bf8b-339db84bef09');
insert into loja_percentual values ('d2df0aa4-de39-4705-829d-f9d135d93c32','9827fdc7-2d53-4698-8cd7-a804b26bddad');
insert into loja_percentual values ('0c22d7b9-7201-4c1c-8c4b-efb9725dcc4a','2aef4f56-6821-4b91-9031-ce73ee9af301');
insert into loja_percentual values ('ba0049de-4a26-4a19-ac8f-42804a038b13','79a685e2-6934-4847-b41d-f81653da23e1');
insert into loja_percentual values ('844d55ad-bbd8-4cb6-a818-70e16d4b30d4','69af3652-2fca-4b48-806f-ab54c0c9ec8b');
insert into loja_percentual values ('abc5d813-5e41-48d8-9b24-9cf540f73373','99e433d7-354e-4185-892f-c2eb82599907');
insert into loja_percentual values ('90baf4c7-4d66-46c0-b2ce-8adfeb9dcd03','569f9592-d23a-4337-be4a-66e3a76cc4fe');
insert into loja_percentual values ('5f3b8a3d-0ff3-44bf-9884-faa02071d5bf','3b05fac0-ce72-4fbd-9de5-9d4095d178d4');
insert into loja_percentual values ('669a49b1-b668-4cdc-9346-267d8b74934e','e0362936-dd5c-436d-a0ac-7efcc563d412');
insert into loja_percentual values ('64d67037-1c83-4858-bae6-b4d6f833ceb5','6b664850-b060-4df1-918f-a0adc6f8200a');
insert into loja_percentual values ('57898d48-e428-4238-b746-0b27b1427e2a','2cbb9270-9fd2-4e14-8231-a57abd1dbd56');
insert into loja_percentual values ('081f88e9-e929-4380-b849-c005877c3183','1e1877c2-0d50-4beb-a5bd-b3d9e3927169');

INSERT INTO public.rede(id, nome, email) VALUES (uuid_generate_v4(),'Menor Pre�o','ricardolahora@gmail.com');

insert into endereco (id, bairro, cep, cidade, complemento, descricao, googleplaceid, lat, lng, logradouro, numero, tipo, uf) 
values (uuid_generate_v4() ,
'Parque Fluminense',
'25045001',
'Duque de Caxias',
'Loja',
'Drogaria Menor Preco Presidente Kenedy',
'Ek1Bdi4gUHJlcy4gS2VubmVkeSwgOTcwMCAtIFPDo28gQmVudG8sIER1cXVlIGRlIENheGlhcyAtIFJKLCAyNTAzMC0wMDEsIEJyYXppbCJREk8KNAoyCUvJr9TTcZkAEURblbqADMqiGh4LEO7B7qEBGhQKEgn1qIzLmXqZABFFXbwHVswnigwQ5EsqFAoSCd1eHscNcJkAEb521_xsd7IC',
'-22.722807',
'-43.316019',
'Presidente Kennedy',
'9700',
'AVENIDA',
'RJ');


insert into loja (id, cnpj, inscricaoestadual, inscricaomunicipal, nomefantasia, raioentrega, razaosocial, tipo, endereco_id, farmaceutico_id, rede_id)
values (
uuid_generate_v4(),
'05.322.6890001/94',
'74466800',
'',
'MENOR PRE�O',
'4',
'Drogaria Menor Pre�o Ltda',
'FRANQUIA',
(select e.id from endereco e where e.googleplaceid = 'Ek1Bdi4gUHJlcy4gS2VubmVkeSwgOTcwMCAtIFPDo28gQmVudG8sIER1cXVlIGRlIENheGlhcyAtIFJKLCAyNTAzMC0wMDEsIEJyYXppbCJREk8KNAoyCUvJr9TTcZkAEURblbqADMqiGh4LEO7B7qEBGhQKEgn1qIzLmXqZABFFXbwHVswnigwQ5EsqFAoSCd1eHscNcJkAEb521_xsd7IC'),
'3864977b-85e8-4403-b307-f2d4f3d884b1',
(select r.id from rede r where r.email='ricardolahora@gmail.com')
);


insert into usuario (id, ativo, cpf, datanascimento, email, nome, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-30',
now(),
'usuario.drogariamenorprecopresidentekenedy@afarmapopular.com.br',
'usuario.drogariamenorprecopresidentekenedy',
'1234567890',
'021983386317',
(select e.id from endereco e where e.googleplaceid = 'Ek1Bdi4gUHJlcy4gS2VubmVkeSwgOTcwMCAtIFPDo28gQmVudG8sIER1cXVlIGRlIENheGlhcyAtIFJKLCAyNTAzMC0wMDEsIEJyYXppbCJREk8KNAoyCUvJr9TTcZkAEURblbqADMqiGh4LEO7B7qEBGhQKEgn1qIzLmXqZABFFXbwHVswnigwQ5EsqFAoSCd1eHscNcJkAEb521_xsd7IC'),
'3'
);


INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '05.034.873/0001-39'),
	(select u.id from usuario u where email = 'usuario.drogariamenorprecopresidentekenedy@afarmapopular.com.br')
	);


INSERT INTO public.usuario(id, ativo, cpf, datanascimento, nome, email, senha, telefone, enderecoid, perfilid)
values (
nextval('usuario_id_seq'),
true,
'000.000.000-30',
now(),
'admin.drogariamenorprecopresidentekenedy',
'admin.drogariamenorprecopresidentekenedy@afarmapopular.com.br',
'1234567890',
'021983386317',
(select e.id from endereco e where e.googleplaceid = 'Ek1Bdi4gUHJlcy4gS2VubmVkeSwgOTcwMCAtIFPDo28gQmVudG8sIER1cXVlIGRlIENheGlhcyAtIFJKLCAyNTAzMC0wMDEsIEJyYXppbCJREk8KNAoyCUvJr9TTcZkAEURblbqADMqiGh4LEO7B7qEBGhQKEgn1qIzLmXqZABFFXbwHVswnigwQ5EsqFAoSCd1eHscNcJkAEb521_xsd7IC'),
'1'
);

INSERT INTO loja_usuario (loja_id, usuario_id)
	values (
	(select l.id from loja l where l.cnpj = '05.322.6890001/94'),
	(select u.id from usuario u where email = 'admin.drogariamenorprecopresidentekenedy@afarmapopular.com.br')
	);
	
	update usuario set email = 'usuario.drogariamenorpreco@afarmapopular.com.br', nome=	'usuario.drogariamenorpreco' where id='138';
update usuario set email = 'admin.drogariamenorpreco@afarmapopular.com.br', nome=	'admin.drogariamenorpreco' where id='139';