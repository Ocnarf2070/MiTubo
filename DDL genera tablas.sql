-- Generado por Oracle SQL Developer Data Modeler 4.1.5.907
--   en:        2018-04-12 17:10:12 CEST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g


CREATE TABLE video_pago(
    id_video   NUMBER NOT NULL,
    coste      NUMBER NOT NULL
);

ALTER TABLE video_pago ADD CONSTRAINT video_pago_PK PRIMARY KEY ( id_video );

CREATE TABLE ajustes (
    id_ajustes      NUMBER NOT NULL,
    nombre          VARCHAR2(50) NOT NULL,
    descripcion     VARCHAR2(50) NOT NULL,
    valor_defecto   NUMBER NOT NULL,
    tipo_dato       VARCHAR2(50) NOT NULL,
    modo_pago       VARCHAR2(50)
);

ALTER TABLE ajustes ADD CHECK (
    tipo_dato IN (
        'boolean'
    )
);

ALTER TABLE ajustes ADD CONSTRAINT ajustes_pk PRIMARY KEY ( id_ajustes );

CREATE TABLE canal (
    id_canal        NUMBER NOT NULL,
    nombre          VARCHAR2(50) NOT NULL,
    descripción     VARCHAR2(50),
    ambito          VARCHAR2(50) NOT NULL,
    temática        VARCHAR2(50) NOT NULL,
    imagen          blob,
    id_trailer      NUMBER ,
    subscriptores   NUMBER NOT NULL
);

ALTER TABLE canal ADD CONSTRAINT canal_pk PRIMARY KEY ( id_canal );

CREATE TABLE categoria (
    id_categoria   NUMBER NOT NULL,
    nombre         VARCHAR2(50) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE comentario (
    fecha                      DATE NOT NULL,
    hora                       DATE NOT NULL,
    id_autor                   NUMBER NOT NULL,
    texto                      VARCHAR2(50) NOT NULL,
    id_comentario              NUMBER NOT NULL,
    usuario_id_usuario         NUMBER,
    video_id_video             NUMBER,
    comentario_id_comentario   NUMBER
);

ALTER TABLE comentario ADD CONSTRAINT comentario_pk PRIMARY KEY ( id_comentario );

CREATE TABLE denuncia (
    tipo                 VARCHAR2(50) NOT NULL,
    comentario           VARCHAR2(250),
    id_denuncia          NUMBER NOT NULL,
    usuario_id_usuario   NUMBER
);

ALTER TABLE denuncia ADD CONSTRAINT denuncia_pk PRIMARY KEY ( id_denuncia );

CREATE TABLE empresa (
    id_usuario   NUMBER NOT NULL
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( id_usuario );

CREATE TABLE historial (
    porcentaje_de_video   NUMBER NOT NULL,
    fecha_de_inicio       DATE NOT NULL,
    fecha_fin             DATE NOT NULL,
    usuario_id_usuario    NUMBER NOT NULL,
    historial_id          NUMBER NOT NULL
);

CREATE UNIQUE INDEX historial__idx ON
    historial ( usuario_id_usuario ASC );

ALTER TABLE historial ADD CONSTRAINT historial_pk PRIMARY KEY ( historial_id );

CREATE TABLE historialv1 (
    usuario_id_usuario   NUMBER NOT NULL,
    video_id_video       NUMBER NOT NULL,
    porcentaje_visto     NUMBER,
    empezo               DATE,
    termino              DATE,
    cadena_busqueda      VARCHAR2(50)
);

ALTER TABLE historialv1 ADD CONSTRAINT historialv1_pk PRIMARY KEY ( usuario_id_usuario,video_id_video );

CREATE TABLE lista_reproducción (
    nombre               VARCHAR2(50) NOT NULL,
    id_lista             VARCHAR2(50) NOT NULL,
    pública              CHAR(1) NOT NULL,
    canal_id_canal       NUMBER,
    usuario_id_usuario   NUMBER
);

ALTER TABLE lista_reproducción ADD CONSTRAINT lista_reproducción_pk PRIMARY KEY ( id_lista );

CREATE TABLE notificacion (
    id_notificacion        NUMBER NOT NULL,
    texto                  VARCHAR2(50),
    canal_id_canal         NUMBER NOT NULL,
    denuncia_id_denuncia   NUMBER NOT NULL,
    video_id_video         NUMBER NOT NULL,
    usuario_id_usuario     NUMBER NOT NULL
);

ALTER TABLE notificacion ADD CONSTRAINT notificacion_pk PRIMARY KEY ( id_notificacion );

CREATE TABLE pago (
    pago                 NUMBER,
    fecha_cambio         DATE,
    video_id_video       NUMBER NOT NULL,
    usuario_id_usuario   NUMBER
);

ALTER TABLE pago ADD CONSTRAINT pago_pk PRIMARY KEY ( video_id_video );

CREATE TABLE relation_12 (
    video_id_video                NUMBER NOT NULL,
    lista_reproducción_id_lista   VARCHAR2(50) NOT NULL,
    orden                         NUMBER
);

ALTER TABLE relation_12 ADD CONSTRAINT relation_12_pk PRIMARY KEY ( video_id_video,lista_reproducción_id_lista );

CREATE TABLE relation_13 (
    video_id_video         NUMBER NOT NULL,
    denuncia_id_denuncia   NUMBER NOT NULL
);

ALTER TABLE relation_13 ADD CONSTRAINT relation_13_pk PRIMARY KEY ( video_id_video,denuncia_id_denuncia );

CREATE TABLE relation_3 (
    usuario_id_usuario   NUMBER NOT NULL,
    ajustes_id_ajustes   NUMBER NOT NULL
);

ALTER TABLE relation_3 ADD CONSTRAINT relation_3_pk PRIMARY KEY ( usuario_id_usuario,ajustes_id_ajustes );

CREATE TABLE relation_5 (
    historial_historial_id   NUMBER NOT NULL,
    video_id_video           NUMBER NOT NULL
);

ALTER TABLE relation_5 ADD CONSTRAINT relation_5_pk PRIMARY KEY ( historial_historial_id,video_id_video );

CREATE TABLE relation_7 (
    video_id_video           NUMBER NOT NULL,
    categoria_id_categoria   NUMBER NOT NULL
);

ALTER TABLE relation_7 ADD CONSTRAINT relation_7_pk PRIMARY KEY ( video_id_video,categoria_id_categoria );

CREATE TABLE subscripciones (
    usuario_id_usuario   NUMBER NOT NULL,
    canal_id_canal       NUMBER NOT NULL
);

ALTER TABLE subscripciones ADD CONSTRAINT subscripciones_pk PRIMARY KEY ( usuario_id_usuario,canal_id_canal );

CREATE TABLE usuario (
    id_usuario               NUMBER NOT NULL,
    alias                    VARCHAR2(50) NOT NULL,
    nombre                   VARCHAR2(50) NOT NULL,
    apellido1                VARCHAR2(50) NOT NULL,
    apellido2                VARCHAR2(50) NOT NULL,
    email                    VARCHAR2(50) NOT NULL,
    foto                     blob NOT NULL,
    descripción              VARCHAR2(50),
    zona_horaria             VARCHAR2(50) NOT NULL,
    idioma                   VARCHAR2(50) NOT NULL,
    pais                     VARCHAR2(50) NOT NULL,
    canal_id_canal           NUMBER NOT NULL,
    historial_historial_id   NUMBER NOT NULL
);

CREATE UNIQUE INDEX usuario__idx ON
    usuario ( historial_historial_id ASC );

CREATE UNIQUE INDEX usuario__idxv1 ON
    usuario ( canal_id_canal ASC );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

CREATE TABLE video (
    id_video             NUMBER NOT NULL,
    duracion             NUMBER NOT NULL,
    titulo               VARCHAR2(50) NOT NULL,
    descripción          VARCHAR2(50),
    formato              VARCHAR2(50) NOT NULL,
    enlace               VARCHAR2(50) NOT NULL,
    n_visualizaciones   NUMBER NOT NULL,
    n_comentarios       NUMBER NOT NULL,
    n_megusta           NUMBER NOT NULL,
    n_nomegusta         NUMBER,
    fecha_creacion       DATE NOT NULL,
    imagen               blob NOT NULL,
    video_pago           CHAR(1),
    canal_id_canal       NUMBER
);

ALTER TABLE video ADD CONSTRAINT video_pk PRIMARY KEY ( id_video );

CREATE TABLE video_anuncio (
    id_video             NUMBER NOT NULL,
    temática             VARCHAR2(50) NOT NULL,
    edad                 NUMBER,
    género               VARCHAR2(50),
    idioma               VARCHAR2(50),
    pais                 VARCHAR2(50),
    empresa_id_usuario   NUMBER,
    tarifa               NUMBER NOT NULL
);

ALTER TABLE video_anuncio ADD CONSTRAINT video_anuncio_pk PRIMARY KEY ( id_video );

ALTER TABLE video_pago ADD CONSTRAINT video_pago_Video_FK FOREIGN KEY ( id_video )
    REFERENCES video ( id_video );

ALTER TABLE comentario ADD CONSTRAINT comentario_comentario_fk FOREIGN KEY ( comentario_id_comentario )
    REFERENCES comentario ( id_comentario );

ALTER TABLE comentario ADD CONSTRAINT comentario_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE comentario ADD CONSTRAINT comentario_video_fk FOREIGN KEY ( video_id_video )
    REFERENCES video ( id_video );

ALTER TABLE denuncia ADD CONSTRAINT denuncia_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE empresa ADD CONSTRAINT empresa_usuario_fk FOREIGN KEY ( id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE relation_12 ADD CONSTRAINT fk_ass_10 FOREIGN KEY ( lista_reproducción_id_lista )
    REFERENCES lista_reproducción ( id_lista );

ALTER TABLE relation_13 ADD CONSTRAINT fk_ass_11 FOREIGN KEY ( video_id_video )
    REFERENCES video ( id_video );

ALTER TABLE relation_13 ADD CONSTRAINT fk_ass_12 FOREIGN KEY ( denuncia_id_denuncia )
    REFERENCES denuncia ( id_denuncia );

ALTER TABLE relation_3 ADD CONSTRAINT fk_ass_22 FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE relation_3 ADD CONSTRAINT fk_ass_23 FOREIGN KEY ( ajustes_id_ajustes )
    REFERENCES ajustes ( id_ajustes );

ALTER TABLE relation_5 ADD CONSTRAINT fk_ass_26 FOREIGN KEY ( historial_historial_id )
    REFERENCES historial ( historial_id );

ALTER TABLE relation_5 ADD CONSTRAINT fk_ass_27 FOREIGN KEY ( video_id_video )
    REFERENCES video ( id_video );

ALTER TABLE relation_7 ADD CONSTRAINT fk_ass_28 FOREIGN KEY ( video_id_video )
    REFERENCES video ( id_video );

ALTER TABLE relation_7 ADD CONSTRAINT fk_ass_29 FOREIGN KEY ( categoria_id_categoria )
    REFERENCES categoria ( id_categoria );

ALTER TABLE subscripciones ADD CONSTRAINT fk_ass_31 FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE subscripciones ADD CONSTRAINT fk_ass_32 FOREIGN KEY ( canal_id_canal )
    REFERENCES canal ( id_canal );

ALTER TABLE historialv1 ADD CONSTRAINT fk_ass_5 FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE historialv1 ADD CONSTRAINT fk_ass_6 FOREIGN KEY ( video_id_video )
    REFERENCES video ( id_video );

ALTER TABLE relation_12 ADD CONSTRAINT fk_ass_9 FOREIGN KEY ( video_id_video )
    REFERENCES video ( id_video );

ALTER TABLE historial ADD CONSTRAINT historial_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE lista_reproducción ADD CONSTRAINT lista_reproducción_canal_fk FOREIGN KEY ( canal_id_canal )
    REFERENCES canal ( id_canal );

ALTER TABLE lista_reproducción ADD CONSTRAINT lista_reproducción_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE notificacion ADD CONSTRAINT notificacion_canal_fk FOREIGN KEY ( canal_id_canal )
    REFERENCES canal ( id_canal );

ALTER TABLE notificacion ADD CONSTRAINT notificacion_denuncia_fk FOREIGN KEY ( denuncia_id_denuncia )
    REFERENCES denuncia ( id_denuncia );

ALTER TABLE notificacion ADD CONSTRAINT notificacion_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE notificacion ADD CONSTRAINT notificacion_video_fk FOREIGN KEY ( video_id_video )
    REFERENCES video ( id_video );

ALTER TABLE pago ADD CONSTRAINT pago_usuario_fk FOREIGN KEY ( usuario_id_usuario )
    REFERENCES usuario ( id_usuario );

ALTER TABLE pago ADD CONSTRAINT pago_video_fk FOREIGN KEY ( video_id_video )
    REFERENCES video ( id_video );

ALTER TABLE usuario ADD CONSTRAINT usuario_canal_fk FOREIGN KEY ( canal_id_canal )
    REFERENCES canal ( id_canal );

ALTER TABLE usuario ADD CONSTRAINT usuario_historial_fk FOREIGN KEY ( historial_historial_id )
    REFERENCES historial ( historial_id );

ALTER TABLE video_anuncio ADD CONSTRAINT video_anuncio_empresa_fk FOREIGN KEY ( empresa_id_usuario )
    REFERENCES empresa ( id_usuario );

ALTER TABLE video_anuncio ADD CONSTRAINT video_anuncio_video_fk FOREIGN KEY ( id_video )
    REFERENCES video ( id_video );

ALTER TABLE video ADD CONSTRAINT video_canal_fk FOREIGN KEY ( canal_id_canal )
    REFERENCES canal ( id_canal );

CREATE SEQUENCE historial_historial_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER historial_historial_id_trg BEFORE
    INSERT ON historial
    FOR EACH ROW
    WHEN (
        new.historial_id IS NULL
    )
BEGIN
    :new.historial_id := historial_historial_id_seq.nextval;
END;
/


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             1
-- ALTER TABLE                             45
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
