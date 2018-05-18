﻿--Desde system creamos los tablespaces. Uno para el administrador y el otro para los demas
create tablespace MITUBO_ESPACE datafile 'C:\app\alumnos\mitubo_espace.dbf' size 1G autoextend on; 
create tablespace ESPACE_GENTE datafile 'C:\app\alumnos\espace_gente.dbf' size 500M autoextend on; 
--Creamos el perfil de conexion que compartiran los usuarios
CREATE PROFILE MITUBO_PERF LIMIT FAILED_LOGIN_ATTEMPTS 3 IDLE_TIME 5;
--Creamos los roles de los usuarios y los usuarios
--Ademas les damos los permisos necesarios para que realicen sus funciones
CREATE ROLE CONSULTOR;
GRANT CONNECT TO CONSULTOR;

CREATE USER CONSULTOR_U IDENTIFIED BY bd PROFILE MITUBO_PERF
DEFAULT TABLESPACE ESPACE_GENTE;

CREATE ROLE AGENTE;


CREATE ROLE ADMINISTRADOR;
GRANT CONNECT TO ADMINISTRADOR; 
GRANT RESOURCE, CREATE VIEW TO ADMINISTRADOR;
CREATE USER ADMINISTRADO IDENTIFIED BY bd PROFILE MITUBO_PERF QUOTA 1G 
ON MITUBO_ESPACE DEFAULT TABLESPACE MITUBO_ESPACE;
GRANT ADMINISTRADOR to ADMINISTRADO;

CREATE ROLE USUARIO;
GRANT CONNECT TO USUARIO; 
CREATE USER USUARIO_U IDENTIFIED BY bd PROFILE MITUBO_PERF
DEFAULT TABLESPACE ESPACE_GENTE;

--Ejecutamos el ddl desde ADMINISTRADOR_U

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
    empezo               NUMBER,
    termino              NUMBER,
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
    duración             DATE NOT NULL,
    titulo               VARCHAR2(50) NOT NULL,
    descripción          VARCHAR2(50),
    formato              VARCHAR2(50) NOT NULL,
    enlace               VARCHAR2(50) NOT NULL,
    n_visualizaciones   NUMBER NOT NULL,
    n_comentarios       NUMBER NOT NULL,
    n_megusta           NUMBER NOT NULL,
    n_nomegusta         NUMBER,
    fecha_creación       DATE NOT NULL,
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


--Creamos las vistas tanto para administrador como para un usuario concreto
--Desde ADMINISTRADOR
CREATE  VIEW Pago_TOTAL_VIDEO AS (select (pago*video.N_VISUALIZACIONES) PAGO_TOTAL,
 video.ID_VIDEO, video.TITULO  from video , pago where video.ID_VIDEO=pago.VIDEO_ID_VIDEO
) with read only;
CREATE  VIEW CANAL_DINERO_TOTAL AS (select  canal.ID_CANAL, sum(pago.PAGO*video.N_VISUALIZACIONES) pago, canal.NOMBRE
 from video, canal, pago 
 where video.CANAL_ID_CANAL= canal.ID_CANAL and video.ID_VIDEO=pago.VIDEO_ID_VIDEO 
 group by canal.ID_CANAL, canal.NOMBRE
)with read only;
CREATE  VIEW VIDEOS_CON_DENUNCIA AS (select video.ID_VIDEO, DENUNCIA.ID_DENUNCIA 
from video, DENUNCIA, RELATION_13 
where RELATION_13.VIDEO_ID_VIDEO=video.id_video 
and RELATION_13.DENUNCIA_ID_DENUNCIA=DENUNCIA.ID_DENUNCIA
)with read only;
CREATE  VIEW VIDEO_ESTADISTICAS  AS (select ID_VIDEO, N_MEGUSTA, N_VISUALIZACIONES, 
N_NOMEGUSTA, N_COMENTARIOS from video
)with read only;
CREATE  VIEW PORCENTAJES_VIDEO AS (SELECT ID_VIDEO, (N_MEGUSTA/N_VISUALIZACIONES*100) porcentaje_likes,
(N_NOMEGUSTA/N_VISUALIZACIONES*100) porcentaje_no_likes  FROM video
)with read only;
CREATE  VIEW USUARIO_DATOS AS (select U.ID_USUARIO, V.TITULO,CA.NOMBRE  
from ADMINISTRADOR_U.USUARIO U, ADMINISTRADOR_U.video V, ADMINISTRADOR_U.CANAL CA 
where V.CANAL_ID_CANAL=CA.ID_CANAL AND U.CANAL_ID_CANAL=CA.ID_CANAL AND U.ALIAS = USER
)with read only;


--Desde system concedemos los permisos para acceder a las vistas
GRANT SELECT ON ADMINISTRADOR_U.PAGO_TOTAL_VIDEO TO CONSULTOR_U;
GRANT SELECT ON ADMINISTRADOR_U.CANAL_DINERO_TOTAL TO CONSULTOR_U;
GRANT SELECT ON ADMINISTRADOR_U.VIDEOS_CON_DENUNCIA TO CONSULTOR_U; 
GRANT SELECT ON ADMINISTRADOR_U.VIDEO_ESTADISTICAS TO CONSULTOR_U; 
GRANT SELECT ON ADMINISTRADOR_U.PORCENTAJES_VIDEO TO CONSULTOR_U;
GRANT SELECT on ADMINISTRADOR_U.USUARIO_DATOS to USUARIO_U;
GRANT SELECT, DELETE  ON ADMINISTRADOR_U.DENUNCIA TO AGENTE;
GRANT DELETE ON ADMINISTRADOR_U.VIDEO TO AGENTE;
GRANT INSERT, DELETE ON ADMINISTRADOR_U.NOTIFICACION TO AGENTE;
GRANT CONNECT TO AGENTE; 
CREATE USER AGENTE_U IDENTIFIED BY bd PROFILE MITUBO_PERF
DEFAULT TABLESPACE ESPACE_GENTE;


