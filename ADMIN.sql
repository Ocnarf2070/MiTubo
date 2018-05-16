-- Generado por Oracle SQL Developer Data Modeler 4.1.5.907
--   en:        2018-04-12 17:10:12 CEST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g




CREATE TABLE Ajustes
  (
    ID_Ajustes    NUMBER NOT NULL ,
    nombre        VARCHAR2 (50) NOT NULL ,
    descripcion   VARCHAR2 (100) NOT NULL ,
    valor_defecto NUMBER NOT NULL ,
    tipo_dato     VARCHAR2 (50) NOT NULL ,
    modo_pago     VARCHAR2 (50)
  ) ;
ALTER TABLE Ajustes ADD CHECK ( tipo_dato IN ('boolean')) ;
ALTER TABLE Ajustes ADD CONSTRAINT Ajustes_PK PRIMARY KEY ( ID_Ajustes ) ;


CREATE TABLE Canal
  (
    ID_Canal    NUMBER NOT NULL ,
    Nombre      VARCHAR2 (50) NOT NULL ,
    descripción VARCHAR2 (50) ,
    ambito      VARCHAR2 (50) NOT NULL ,
    temática    VARCHAR2 (50) NOT NULL ,
    imagen BLOB ,
    id_trailer    NUMBER NOT NULL ,
    subscriptores NUMBER NOT NULL
  ) ;
ALTER TABLE Canal ADD CONSTRAINT Canal_PK PRIMARY KEY ( ID_Canal ) ;


CREATE TABLE Categoria
  (
    ID_Categoria   NUMBER NOT NULL ,
    nombre         VARCHAR2 (50) NOT NULL ,
    Video_ID_Video NUMBER NOT NULL
  ) ;
ALTER TABLE Categoria ADD CONSTRAINT Categoria_PK PRIMARY KEY ( ID_Categoria ) ;


CREATE TABLE Comentario
  (
    Fecha                    DATE NOT NULL ,
    Hora                     DATE NOT NULL ,
    Id_autor                 NUMBER NOT NULL ,
    Texto                    VARCHAR2 (50) NOT NULL ,
    id_comentario            NUMBER NOT NULL ,
    Usuario_ID_Usuario       NUMBER ,
    Video_ID_Video           NUMBER ,
    Comentario_id_comentario NUMBER
  ) ;
ALTER TABLE Comentario ADD CONSTRAINT Comentario_PK PRIMARY KEY ( id_comentario ) ;


CREATE TABLE Denuncia
  (
    tipo               VARCHAR2 (50) NOT NULL ,
    Comentario         VARCHAR2 (250) ,
    ID_Denuncia        NUMBER NOT NULL ,
    Usuario_ID_Usuario NUMBER
  ) ;
ALTER TABLE Denuncia ADD CONSTRAINT Denuncia_PK PRIMARY KEY ( ID_Denuncia ) ;


CREATE TABLE Empresa
  ( ID_Usuario NUMBER NOT NULL
  ) ;
ALTER TABLE Empresa ADD CONSTRAINT Empresa_PK PRIMARY KEY ( ID_Usuario ) ;


CREATE TABLE Historial
  (
    Usuario_ID_Usuario NUMBER NOT NULL ,
    Video_ID_Video     NUMBER NOT NULL ,
    Porcentaje_visto   NUMBER ,
    empezo             NUMBER ,
    termino            NUMBER ,
    Cadena_busqueda    VARCHAR2 (50)
  ) ;
ALTER TABLE Historial ADD CONSTRAINT Historial_PK PRIMARY KEY ( Usuario_ID_Usuario, Video_ID_Video ) ;


CREATE TABLE Lista_reproducción
  (
    nombre         VARCHAR2 (50) NOT NULL ,
    Creador        NUMBER ,
    Id_lista       VARCHAR2 (50) NOT NULL ,
    Pública        CHAR (1) NOT NULL ,
    orden          VARCHAR2 (50) NOT NULL ,
    Canal_ID_Canal NUMBER
  ) ;
ALTER TABLE Lista_reproducción ADD CONSTRAINT Lista_reproducción_PK PRIMARY KEY ( Id_lista ) ;


CREATE TABLE Notificacion
  (
    ID_Notificacion      NUMBER NOT NULL ,
    Texto                VARCHAR2 (50) ,
    Canal_ID_Canal       NUMBER NOT NULL ,
    Denuncia_ID_Denuncia NUMBER NOT NULL ,
    Video_ID_Video       NUMBER NOT NULL
  ) ;
ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_PK PRIMARY KEY ( ID_Notificacion, Canal_ID_Canal, Denuncia_ID_Denuncia, Video_ID_Video ) ;


CREATE TABLE Pago
  (
    Pago               NUMBER ,
    Fecha_Cambio       DATE ,
    Video_ID_Video     NUMBER NOT NULL ,
    Usuario_ID_Usuario NUMBER
  ) ;
ALTER TABLE Pago ADD CONSTRAINT Pago_PK PRIMARY KEY ( Video_ID_Video ) ;


CREATE TABLE Relation_12
  (
    Video_ID_Video              NUMBER NOT NULL ,
    Lista_reproducción_Id_lista VARCHAR2 (50) NOT NULL
  ) ;
ALTER TABLE Relation_12 ADD CONSTRAINT Relation_12_PK PRIMARY KEY ( Video_ID_Video, Lista_reproducción_Id_lista ) ;


CREATE TABLE Relation_13
  (
    Video_ID_Video       NUMBER NOT NULL ,
    Denuncia_ID_Denuncia NUMBER NOT NULL
  ) ;
ALTER TABLE Relation_13 ADD CONSTRAINT Relation_13_PK PRIMARY KEY ( Video_ID_Video, Denuncia_ID_Denuncia ) ;


CREATE TABLE Relation_3
  (
    Usuario_ID_Usuario NUMBER NOT NULL ,
    Ajustes_ID_Ajustes NUMBER NOT NULL
  ) ;
ALTER TABLE Relation_3 ADD CONSTRAINT Relation_3_PK PRIMARY KEY ( Usuario_ID_Usuario, Ajustes_ID_Ajustes ) ;


CREATE TABLE Subscripciones
  (
    Usuario_ID_Usuario NUMBER NOT NULL ,
    Canal_ID_Canal     NUMBER NOT NULL
  ) ;
ALTER TABLE Subscripciones ADD CONSTRAINT Subscripciones_PK PRIMARY KEY ( Usuario_ID_Usuario, Canal_ID_Canal ) ;


CREATE TABLE Usuario
  (
    ID_Usuario NUMBER NOT NULL ,
    ALIAS      VARCHAR2 (50) NOT NULL ,
    nombre     VARCHAR2 (50) NOT NULL ,
    Apellido1  VARCHAR2 (50) NOT NULL ,
    Apellido2  VARCHAR2 (50) NOT NULL ,
    email      VARCHAR2 (50) NOT NULL ,
    foto BLOB NOT NULL ,
    descripción                  VARCHAR2 (50) ,
    zona_horaria                 VARCHAR2 (50) NOT NULL ,
    idioma                       VARCHAR2 (50) NOT NULL ,
    pais                         VARCHAR2 (50) NOT NULL ,
    Canal_ID_Canal               NUMBER NOT NULL ,
    Notificacion_ID_Notificacion NUMBER NOT NULL ,
    Notificacion_Canal_ID_Canal  NUMBER NOT NULL ,
    Notificacion_ID_Denuncia     NUMBER NOT NULL ,
    Notificacion_Video_ID_Video  NUMBER NOT NULL
  ) ;
CREATE UNIQUE INDEX Usuario__IDX ON Usuario
  (
    Canal_ID_Canal ASC
  )
  ;
ALTER TABLE Usuario ADD CONSTRAINT Usuario_PK PRIMARY KEY ( ID_Usuario ) ;


CREATE TABLE Video
  (
    ID_Video           NUMBER NOT NULL ,
    Duración           DATE NOT NULL ,
    Titulo             VARCHAR2 (50) NOT NULL ,
    Descripción        VARCHAR2 (50) ,
    Formato            VARCHAR2 (50) NOT NULL ,
    Enlace             VARCHAR2 (50) NOT NULL ,
    n_visualizaciones NUMBER NOT NULL ,
    n_comentarios     NUMBER NOT NULL ,
    n_megusta         NUMBER NOT NULL ,
    n_nomegusta       NUMBER ,
    fecha_creación     DATE NOT NULL ,
    imagen BLOB NOT NULL ,
    Video_Pago     CHAR (1) ,
    Canal_ID_Canal NUMBER
  ) ;
ALTER TABLE Video ADD CONSTRAINT Video_PK PRIMARY KEY ( ID_Video ) ;


CREATE TABLE Video_anuncio
  (
    ID_Video           NUMBER NOT NULL ,
    Temática           VARCHAR2 (50) NOT NULL ,
    edad               NUMBER ,
    Género             VARCHAR2 (50) ,
    Idioma             VARCHAR2 (50) ,
    Pais               VARCHAR2 (50) ,
    Empresa_ID_Usuario NUMBER ,
    Tarifa             NUMBER NOT NULL
  ) ;
ALTER TABLE Video_anuncio ADD CONSTRAINT Video_anuncio_PK PRIMARY KEY ( ID_Video ) ;


ALTER TABLE Categoria ADD CONSTRAINT Categoria_Video_FK FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Comentario ADD CONSTRAINT Comentario_Comentario_FK FOREIGN KEY ( Comentario_id_comentario ) REFERENCES Comentario ( id_comentario ) ;

ALTER TABLE Comentario ADD CONSTRAINT Comentario_Usuario_FK FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Comentario ADD CONSTRAINT Comentario_Video_FK FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Denuncia ADD CONSTRAINT Denuncia_Usuario_FK FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Empresa ADD CONSTRAINT Empresa_Usuario_FK FOREIGN KEY ( ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Relation_13 ADD CONSTRAINT FK_ASS_10 FOREIGN KEY ( Denuncia_ID_Denuncia ) REFERENCES Denuncia ( ID_Denuncia ) ;

ALTER TABLE Relation_3 ADD CONSTRAINT FK_ASS_20 FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Relation_3 ADD CONSTRAINT FK_ASS_21 FOREIGN KEY ( Ajustes_ID_Ajustes ) REFERENCES Ajustes ( ID_Ajustes ) ;

ALTER TABLE Subscripciones ADD CONSTRAINT FK_ASS_24 FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Subscripciones ADD CONSTRAINT FK_ASS_25 FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Historial ADD CONSTRAINT FK_ASS_3 FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Historial ADD CONSTRAINT FK_ASS_4 FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Relation_12 ADD CONSTRAINT FK_ASS_7 FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Relation_12 ADD CONSTRAINT FK_ASS_8 FOREIGN KEY ( Lista_reproducción_Id_lista ) REFERENCES Lista_reproducción ( Id_lista ) ;

ALTER TABLE Relation_13 ADD CONSTRAINT FK_ASS_9 FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Lista_reproducción ADD CONSTRAINT Lista_reproducción_Canal_FK FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_Canal_FK FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_Denuncia_FK FOREIGN KEY ( Denuncia_ID_Denuncia ) REFERENCES Denuncia ( ID_Denuncia ) ;

ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_Video_FK FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Pago ADD CONSTRAINT Pago_Usuario_FK FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Pago ADD CONSTRAINT Pago_Video_FK FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Usuario ADD CONSTRAINT Usuario_Canal_FK FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Usuario ADD CONSTRAINT Usuario_Notificacion_FK FOREIGN KEY ( Notificacion_ID_Notificacion, Notificacion_Canal_ID_Canal, Notificacion_ID_Denuncia, Notificacion_Video_ID_Video ) REFERENCES Notificacion ( ID_Notificacion, Canal_ID_Canal, Denuncia_ID_Denuncia, Video_ID_Video ) ;

ALTER TABLE Video ADD CONSTRAINT Video_Canal_FK FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Video_anuncio ADD CONSTRAINT Video_anuncio_Empresa_FK FOREIGN KEY ( Empresa_ID_Usuario ) REFERENCES Empresa ( ID_Usuario ) ;

ALTER TABLE Video_anuncio ADD CONSTRAINT Video_anuncio_Video_FK FOREIGN KEY ( ID_Video ) REFERENCES Video ( ID_Video ) ;


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
