
ALTER TABLE public.aula ADD CONSTRAINT aula_pkey PRIMARY KEY (id);
ALTER TABLE public.avaliacacaoquestao ADD CONSTRAINT avaliacacaoquestao_pkey PRIMARY KEY (id);
ALTER TABLE public.avaliacao ADD CONSTRAINT avaliacao_pkey PRIMARY KEY (id);
ALTER TABLE public.cancelamento ADD CONSTRAINT cancelamento_pkey PRIMARY KEY (id);
ALTER TABLE public.chamado ADD CONSTRAINT chamado_pkey PRIMARY KEY (id);
ALTER TABLE public.chat ADD CONSTRAINT chat_pkey PRIMARY KEY (id);
ALTER TABLE public.checkin ADD CONSTRAINT checkin_pkey PRIMARY KEY (id);
ALTER TABLE public.configuracao ADD CONSTRAINT configuracao_pkey PRIMARY KEY (id);
ALTER TABLE public.conteudo ADD CONSTRAINT conteudo_pkey PRIMARY KEY (id);
ALTER TABLE public.contrato ADD CONSTRAINT contrato_pkey PRIMARY KEY (id);
ALTER TABLE public.idioma ADD CONSTRAINT idioma_pkey PRIMARY KEY (id);
ALTER TABLE public.notificacaoaula ADD CONSTRAINT notificacaoaula_pkey PRIMARY KEY (id);
ALTER TABLE public.perfil ADD CONSTRAINT perfil_pkey PRIMARY KEY (id);
ALTER TABLE public.plano ADD CONSTRAINT plano_pkey PRIMARY KEY (id);
ALTER TABLE public.questao ADD CONSTRAINT questao_pkey PRIMARY KEY (id);
ALTER TABLE public.reagendamento ADD CONSTRAINT reagendamento_pkey PRIMARY KEY (id);
ALTER TABLE public.recurso ADD CONSTRAINT recurso_pkey PRIMARY KEY (id);
ALTER TABLE public.recursousuario ADD CONSTRAINT recursousuario_pkey PRIMARY KEY (id);
ALTER TABLE public.regional ADD CONSTRAINT regional_pkey PRIMARY KEY (id);
ALTER TABLE public.regionalprofessor ADD CONSTRAINT regionalprofessor_pkey PRIMARY KEY (id);
ALTER TABLE public.respostachamado ADD CONSTRAINT respostachamado_pkey PRIMARY KEY (id);
ALTER TABLE public.usuario ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);




ALTER TABLE public.aula ADD CONSTRAINT fkeh5s0dkhtrrw28fwfxsms1p7r FOREIGN KEY (professorid) REFERENCES public.usuario(id);
ALTER TABLE public.aula ADD CONSTRAINT fknhbrl7cji5t1paw5horwyp386 FOREIGN KEY (conteudoid) REFERENCES public.conteudo(id);
ALTER TABLE public.aula ADD CONSTRAINT fks5b3w4otv32odxdeji08gm38e FOREIGN KEY (alunoid) REFERENCES public.usuario(id);


-- public.avaliacacaoquestao foreign keys

ALTER TABLE public.avaliacacaoquestao ADD CONSTRAINT fkaq8lkrjnudovxym5si7jel2sf FOREIGN KEY (questaoid) REFERENCES public.questao(id);
ALTER TABLE public.avaliacacaoquestao ADD CONSTRAINT fksw2lt4lk3s8q50qxtmlk9bxhx FOREIGN KEY (avaliacaoid) REFERENCES public.avaliacao(id);


-- public.avaliacao foreign keys

ALTER TABLE public.avaliacao ADD CONSTRAINT fk8ijckyysgk5igjyv2bnny0ply FOREIGN KEY (aulaid) REFERENCES public.aula(id);
ALTER TABLE public.avaliacao ADD CONSTRAINT fkjpwoqc9jbivlo589q4cobd0tv FOREIGN KEY (avaliadorid) REFERENCES public.usuario(id);
ALTER TABLE public.avaliacao ADD CONSTRAINT fklriqgw6x4dlylv7cmd6jhlyu0 FOREIGN KEY (avaliadoid) REFERENCES public.usuario(id);


-- public.cancelamento foreign keys

ALTER TABLE public.cancelamento ADD CONSTRAINT fklfq7kvxsmiehf2dapp0qlcyok FOREIGN KEY (usuarioid) REFERENCES public.usuario(id);
ALTER TABLE public.cancelamento ADD CONSTRAINT fktgglxwy5py4k54cnkw2mbvtrk FOREIGN KEY (aulaid) REFERENCES public.aula(id);


-- public.chamado foreign keys

ALTER TABLE public.chamado ADD CONSTRAINT fkold21jocexl7spx9hfnjmplml FOREIGN KEY (usuarioid) REFERENCES public.usuario(id);


-- public.chat foreign keys

ALTER TABLE public.chat ADD CONSTRAINT fk51m66g29gpa085kw06kabjsf3 FOREIGN KEY (remetenteid) REFERENCES public.usuario(id);
ALTER TABLE public.chat ADD CONSTRAINT fk5ld9ifiq6mk7j1md8i3a040j0 FOREIGN KEY (destinatarioid) REFERENCES public.usuario(id);


-- public.checkin foreign keys

ALTER TABLE public.checkin ADD CONSTRAINT fkjem5c87xnecw3dpvcq3bfs9sr FOREIGN KEY (usuarioid) REFERENCES public.usuario(id);
ALTER TABLE public.checkin ADD CONSTRAINT fkkcbk4x6klr2beb0h5kxnm5o8 FOREIGN KEY (aulaid) REFERENCES public.aula(id);


-- public.conteudo foreign keys

ALTER TABLE public.conteudo ADD CONSTRAINT fkcdxu7u1tdpxtd30envmk9dobj FOREIGN KEY (idiomaid) REFERENCES public.idioma(id);


-- public.contrato foreign keys

ALTER TABLE public.contrato ADD CONSTRAINT fk6bcnxjj0b1ly34b7w5yhf2yc6 FOREIGN KEY (planoid) REFERENCES public.plano(id);
ALTER TABLE public.contrato ADD CONSTRAINT fk9d9mtoxc5branvh95me4g3djm FOREIGN KEY (alunoid) REFERENCES public.usuario(id);
ALTER TABLE public.contrato ADD CONSTRAINT fktotyx4rdi29luq0ri5g83mvsv FOREIGN KEY (idiomaid) REFERENCES public.idioma(id);

-- public.notificacaoaula foreign keys

ALTER TABLE public.notificacaoaula ADD CONSTRAINT fk394dcmhcmgvnvn0pxq4hmfbpb FOREIGN KEY (aulaid) REFERENCES public.aula(id);
ALTER TABLE public.notificacaoaula ADD CONSTRAINT fkr5f7x4osgr24p0aguelcl8wqe FOREIGN KEY (usuarioid) REFERENCES public.usuario(id);


-- public.reagendamento foreign keys

ALTER TABLE public.reagendamento ADD CONSTRAINT fkg8k14q0vymo38mo6csre6mrds FOREIGN KEY (aulaid) REFERENCES public.aula(id);
ALTER TABLE public.reagendamento ADD CONSTRAINT fkoar1jrneo0r6ws1kho2a6m3vb FOREIGN KEY (usuarioid) REFERENCES public.usuario(id);

ALTER TABLE public.recurso ADD CONSTRAINT fkqpy3gfe67udquqlo6s7bs6y0g FOREIGN KEY (idiomaid) REFERENCES public.idioma(id);


-- public.recursousuario foreign keys

ALTER TABLE public.recursousuario ADD CONSTRAINT fk8oktmtrrdmeiwdjvixq1eyh42 FOREIGN KEY (alunoid) REFERENCES public.usuario(id);
ALTER TABLE public.recursousuario ADD CONSTRAINT fkjx2780o9ln9h31ebfauoncpbe FOREIGN KEY (recursoid) REFERENCES public.recurso(id);


-- public.regionalprofessor foreign keys

ALTER TABLE public.regionalprofessor ADD CONSTRAINT fkiemwrg1903iqeftspw1c6orx FOREIGN KEY (regionalid) REFERENCES public.regional(id);
ALTER TABLE public.regionalprofessor ADD CONSTRAINT fkr7vwcb88fvqcgd145b8jvgw6q FOREIGN KEY (professorid) REFERENCES public.usuario(id);


-- public.respostachamado foreign keys

ALTER TABLE public.respostachamado ADD CONSTRAINT fk9cby13bthp1a8qsl0yspchpus FOREIGN KEY (usuarioid) REFERENCES public.usuario(id);
ALTER TABLE public.respostachamado ADD CONSTRAINT fklyto2042ek5t8ofd2afcwpe0r FOREIGN KEY (chamadoid) REFERENCES public.chamado(id);


-- public.usuario foreign keys

ALTER TABLE public.usuario ADD CONSTRAINT fk34hugjscw65kfk49ta3qm7fg1 FOREIGN KEY (regionalid) REFERENCES public.regional(id);
ALTER TABLE public.usuario ADD CONSTRAINT fk6fi3jljkemk7mf93aw7k8yv4w FOREIGN KEY (perfilid) REFERENCES public.perfil(id);

ALTER TABLE public.chat ADD CONSTRAINT fk51m66g29gpa085kw06kabjsf3 FOREIGN KEY (remetenteid) REFERENCES public.usuario(id);
ALTER TABLE public.chat ADD CONSTRAINT fk5ld9ifiq6mk7j1md8i3a040j0 FOREIGN KEY (destinatarioid) REFERENCES public.usuario(id);

CREATE SEQUENCE public.aula_id_seq
    INCREMENT 1
    START 23335
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

   
CREATE SEQUENCE public.avaliacacaoquestao_id_seq
    INCREMENT 1
    START 5548
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

   
CREATE SEQUENCE public.avaliacao_id_seq
    INCREMENT 1
    START 1387
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
CREATE SEQUENCE public.cancelamento_id_seq
    INCREMENT 1
    START 614
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


CREATE SEQUENCE public.chamado_id_seq
    INCREMENT 1
    START 302
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   

CREATE SEQUENCE public.chat_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.checkin_id_seq
    INCREMENT 1
    START 3110
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
CREATE SEQUENCE public.configuracao_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.conteudo_id_seq
    INCREMENT 1
    START 503
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.contrato_id_seq
    INCREMENT 1
    START 292
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
CREATE SEQUENCE public.idioma_id_seq
    INCREMENT 1
    START 6
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   

CREATE SEQUENCE public.notificacaoaula_id_seq
    INCREMENT 1
    START 26339
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
CREATE SEQUENCE public.perfil_id_seq
    INCREMENT 1
    START 5
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.plano_id_seq
    INCREMENT 1
    START 12
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.questao_id_seq
    INCREMENT 1
    START 36
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.reagendamento_id_seq
    INCREMENT 1
    START 322
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
  
CREATE SEQUENCE public.recurso_id_seq
    INCREMENT 1
    START 122
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.recursousuario_id_seq
    INCREMENT 1
    START 181
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.regional_id_seq
    INCREMENT 1
    START 14
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

   
CREATE SEQUENCE public.regionalprofessor_id_seq
    INCREMENT 1
    START 257
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.respostachamado_id_seq
    INCREMENT 1
    START 8
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
   
   
CREATE SEQUENCE public.usuario_id_seq
    INCREMENT 1
    START 530
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


