
CREATE TABLE Ajustes
  (
    ID_Ajustes    NUMBER NOT NULL ,
    nombre        VARCHAR2 (100) NOT NULL ,
    descripcion   VARCHAR2 (100)  ,
    valor_defecto NUMBER ,
    tipo_dato     VARCHAR2 (100) ,
    modo_pago     VARCHAR2 (100)
  ) ;
ALTER TABLE Ajustes ADD CHECK ( tipo_dato IN ('boolean')) ;
ALTER TABLE Ajustes ADD CONSTRAINT Ajustes_PK PRIMARY KEY ( ID_Ajustes ) ;


CREATE TABLE Canal
  (
    ID_Canal    NUMBER NOT NULL ,
    Nombre      VARCHAR2 (100) NOT NULL ,
    descripcion VARCHAR2 (100) ,
    ambito      VARCHAR2 (100) NOT NULL ,
    tematica    VARCHAR2 (100) NOT NULL ,
    imagen BLOB ,
    id_trailer    NUMBER,
    subscriptores NUMBER NOT NULL
  ) ;
ALTER TABLE Canal ADD CONSTRAINT Canal_PK PRIMARY KEY ( ID_Canal ) ;


CREATE TABLE Categoria
  (
    ID_Categoria NUMBER NOT NULL ,
    nombre       VARCHAR2 (100) NOT NULL
  ) ;
ALTER TABLE Categoria ADD CONSTRAINT Categoria_PK PRIMARY KEY ( ID_Categoria ) ;


CREATE TABLE Comentario
  (
    Fecha                    DATE NOT NULL ,
    Hora                     DATE NOT NULL ,
    Id_autor                 NUMBER NOT NULL ,
    Texto                    VARCHAR2 (100) NOT NULL ,
    id_comentario            NUMBER NOT NULL ,
    Usuario_ID_Usuario       NUMBER ,
    Video_ID_Video           NUMBER ,
    Comentario_id_comentario NUMBER
  ) ;
ALTER TABLE Comentario ADD CONSTRAINT Comentario_PK PRIMARY KEY ( id_comentario ) ;


CREATE TABLE Denuncia
  (
    tipo               VARCHAR2 (100) NOT NULL ,
    Comentario         VARCHAR2 (100) ,
    ID_Denuncia        NUMBER NOT NULL ,
    Usuario_ID_Usuario NUMBER ,
    Video_ID_Video     NUMBER
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
    Cadena_busqueda    VARCHAR2 (100)
  ) ;
ALTER TABLE Historial ADD CONSTRAINT Historialv1_PK PRIMARY KEY ( Usuario_ID_Usuario, Video_ID_Video ) ;


CREATE TABLE Lista_reproducci�n
  (
    nombre             VARCHAR2 (100) NOT NULL ,
    Id_lista           VARCHAR2 (100) NOT NULL ,
    Publica            CHAR (1) NOT NULL ,
    Canal_ID_Canal     NUMBER ,
    Usuario_ID_Usuario NUMBER
  ) ;
ALTER TABLE Lista_reproducci�n ADD CONSTRAINT Lista_reproducci�n_PK PRIMARY KEY ( Id_lista ) ;


CREATE TABLE Notificacion
  (
    ID_Notificacion      NUMBER NOT NULL ,
    Texto                VARCHAR2 (100) ,
    Canal_ID_Canal       NUMBER NOT NULL ,
    Denuncia_ID_Denuncia NUMBER ,
    Video_ID_Video       NUMBER NOT NULL ,
    Usuario_ID_Usuario   NUMBER NOT NULL
  ) ;
ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_PK PRIMARY KEY ( ID_Notificacion ) ;


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
    Lista_reproducci�n_Id_lista VARCHAR2 (100) NOT NULL ,
    Orden                       NUMBER
  ) ;
ALTER TABLE Relation_12 ADD CONSTRAINT Relation_12_PK PRIMARY KEY ( Video_ID_Video, Lista_reproducci�n_Id_lista ) ;


CREATE TABLE Relation_3
  (
    Usuario_ID_Usuario NUMBER NOT NULL ,
    Ajustes_ID_Ajustes NUMBER NOT NULL
  ) ;
ALTER TABLE Relation_3 ADD CONSTRAINT Relation_3_PK PRIMARY KEY ( Usuario_ID_Usuario, Ajustes_ID_Ajustes ) ;


CREATE TABLE Relation_5
  (
    Historial_Historial_ID NUMBER NOT NULL ,
    Video_ID_Video         NUMBER NOT NULL
  ) ;
ALTER TABLE Relation_5 ADD CONSTRAINT Relation_5_PK PRIMARY KEY ( Historial_Historial_ID, Video_ID_Video ) ;


CREATE TABLE Relation_7
  (
    Video_ID_Video         NUMBER NOT NULL ,
    Categoria_ID_Categoria NUMBER NOT NULL
  ) ;
ALTER TABLE Relation_7 ADD CONSTRAINT Relation_7_PK PRIMARY KEY ( Video_ID_Video, Categoria_ID_Categoria ) ;


CREATE TABLE Subscripciones
  (
    Usuario_ID_Usuario NUMBER NOT NULL ,
    Canal_ID_Canal     NUMBER NOT NULL
  ) ;
ALTER TABLE Subscripciones ADD CONSTRAINT Subscripciones_PK PRIMARY KEY ( Usuario_ID_Usuario, Canal_ID_Canal ) ;


CREATE TABLE Usuario
  (
    ID_Usuario NUMBER NOT NULL ,
    ALIAS      VARCHAR2 (100) NOT NULL ,
    nombre     VARCHAR2 (100) NOT NULL ,
    Apellido1  VARCHAR2 (100) NOT NULL ,
    Apellido2  VARCHAR2 (100) ,
    email      VARCHAR2 (100) NOT NULL ,
    foto BLOB ,
    descripcion            VARCHAR2 (100) ,
    zona_horaria           VARCHAR2 (100) ,
    idioma                 VARCHAR2 (100) NOT NULL ,
    pais                   VARCHAR2 (100) NOT NULL ,
    Canal_ID_Canal         NUMBER NOT NULL ,
    Historial_Historial_ID NUMBER
  ) ;
CREATE UNIQUE INDEX Usuario__IDX ON Usuario
  (
    Historial_Historial_ID ASC
  )
  ;
CREATE UNIQUE INDEX Usuario__IDXv1 ON Usuario
  (
    Canal_ID_Canal ASC
  )
  ;
ALTER TABLE Usuario ADD CONSTRAINT Usuario_PK PRIMARY KEY ( ID_Usuario ) ;


CREATE TABLE Video
  (
    ID_Video          NUMBER NOT NULL ,
    Duracion          NUMBER NOT NULL ,
    Titulo            VARCHAR2 (100) NOT NULL ,
    Descripcion       VARCHAR2 (100) ,
    Formato           VARCHAR2 (100) ,
    Enlace            VARCHAR2 (100) NOT NULL ,
    n_visualizaciones NUMBER NOT NULL ,
    n_comentarios     NUMBER NOT NULL ,
    n_megusta        NUMBER NOT NULL ,
    n_nomegusta       NUMBER ,
    fecha_creacion    DATE NOT NULL ,
    imagen BLOB ,
    Video_Pago     CHAR (1) ,
    Canal_ID_Canal NUMBER
  ) ;
ALTER TABLE Video ADD CONSTRAINT Video_PK PRIMARY KEY ( ID_Video ) ;


CREATE TABLE Video_anuncio
  (
    ID_Video           NUMBER NOT NULL ,
    Tematica           VARCHAR2 (100) NOT NULL ,
    edad               NUMBER ,
    Genero             VARCHAR2 (100) ,
    Idioma             VARCHAR2 (100) ,
    Pais               VARCHAR2 (100) ,
    Empresa_ID_Usuario NUMBER ,
    Tarifa             NUMBER NOT NULL
  ) ;
ALTER TABLE Video_anuncio ADD CONSTRAINT Video_anuncio_PK PRIMARY KEY ( ID_Video ) ;


ALTER TABLE Comentario ADD CONSTRAINT Comentario_Comentario_FK FOREIGN KEY ( Comentario_id_comentario ) REFERENCES Comentario ( id_comentario ) ;

ALTER TABLE Comentario ADD CONSTRAINT Comentario_Usuario_FK FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Comentario ADD CONSTRAINT Comentario_Video_FK FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Denuncia ADD CONSTRAINT Denuncia_Usuario_FK FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Denuncia ADD CONSTRAINT Denuncia_Video_FK FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Empresa ADD CONSTRAINT Empresa_Usuario_FK FOREIGN KEY ( ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Relation_12 ADD CONSTRAINT FK_ASS_10 FOREIGN KEY ( Lista_reproducci�n_Id_lista ) REFERENCES Lista_reproducci�n ( Id_lista ) ;

ALTER TABLE Relation_3 ADD CONSTRAINT FK_ASS_22 FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Relation_3 ADD CONSTRAINT FK_ASS_23 FOREIGN KEY ( Ajustes_ID_Ajustes ) REFERENCES Ajustes ( ID_Ajustes ) ;

ALTER TABLE Relation_5 ADD CONSTRAINT FK_ASS_27 FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Relation_7 ADD CONSTRAINT FK_ASS_28 FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Relation_7 ADD CONSTRAINT FK_ASS_29 FOREIGN KEY ( Categoria_ID_Categoria ) REFERENCES Categoria ( ID_Categoria ) ;

ALTER TABLE Subscripciones ADD CONSTRAINT FK_ASS_31 FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Subscripciones ADD CONSTRAINT FK_ASS_32 FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Historial ADD CONSTRAINT FK_ASS_5 FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Historial ADD CONSTRAINT FK_ASS_6 FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Relation_12 ADD CONSTRAINT FK_ASS_9 FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Lista_reproducci�n ADD CONSTRAINT Lista_reproducci�n_Canal_FK FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Lista_reproducci�n ADD CONSTRAINT Lista_reproducci�n_Usuario_FK FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_Canal_FK FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_Denuncia_FK FOREIGN KEY ( Denuncia_ID_Denuncia ) REFERENCES Denuncia ( ID_Denuncia ) ;

ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_Usuario_FK FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Notificacion ADD CONSTRAINT Notificacion_Video_FK FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Pago ADD CONSTRAINT Pago_Usuario_FK FOREIGN KEY ( Usuario_ID_Usuario ) REFERENCES Usuario ( ID_Usuario ) ;

ALTER TABLE Pago ADD CONSTRAINT Pago_Video_FK FOREIGN KEY ( Video_ID_Video ) REFERENCES Video ( ID_Video ) ;

ALTER TABLE Usuario ADD CONSTRAINT Usuario_Canal_FK FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Video ADD CONSTRAINT Video_Canal_FK FOREIGN KEY ( Canal_ID_Canal ) REFERENCES Canal ( ID_Canal ) ;

ALTER TABLE Video_anuncio ADD CONSTRAINT Video_anuncio_Empresa_FK FOREIGN KEY ( Empresa_ID_Usuario ) REFERENCES Empresa ( ID_Usuario ) ;

ALTER TABLE Video_anuncio ADD CONSTRAINT Video_anuncio_Video_FK FOREIGN KEY ( ID_Video ) REFERENCES Video ( ID_Video ) ;
