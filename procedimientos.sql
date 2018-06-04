-------------------1º-----------------------
CREATE SEQUENCE ID_USER_CANAL
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE;

create or replace procedure create_user
(
nombre in VARCHAR2,
apellido1 in VARCHAR2,
apellido2 in VARCHAR2,
email in VARCHAR2,
zona_horaria in VARCHAR2,
idioma in VARCHAR2,
pais in VARCHAR2,
contraseña VARCHAR2,
alias in VARCHAR2,
ambito in varchar2,
tematica in VARCHAR2
) as
sentencia1 VARCHAR2(500);
sentencia2 varchar2(500);
aleatorio number;
BEGIN
aleatorio:=ID_USER_CANAL.NEXTVAL;
sentencia1:= 'CREATE USER ' || nombre || ' IDENTIFIED BY ' || contraseña || ' PROFILE MITUBO_PERF';
execute immediate sentencia1;
sentencia2:= 'grant R_USUARIO to ' || nombre;
execute immediate sentencia2;
insert INTO canal (ID_CANAL,NOMBRE,AMBITO,TEMATICA,SUBSCRIPTORES) values (aleatorio,alias,ambito,tematica,0);
insert INTO usuario (ID_USUARIO,ALIAS,NOMBRE,APELLIDO1,APELLIDO2,EMAIL,ZONA_HORARIA,IDIOMA,PAIS,CANAL_ID_CANAL) values (aleatorio,alias,nombre,apellido1,apellido2,email,zona_horaria,
idioma,pais,aleatorio);
COMMIT;
END create_user;
--3.1
/
CREATE SEQUENCE SEQ_VIDEO
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE;
/
CREATE SEQUENCE SEQ_NOTIF
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE;
/
create or replace PROCEDURE ALTA_VIDEO 
(
DUR IN NUMBER,
TIT IN VARCHAR2,
DES IN VARCHAR2,
FRM IN VARCHAR2,
ENL IN VARCHAR2,
IMG IN BLOB,
COSTE IN NUMBER
)AS 
IDC NUMBER;
IDU NUMBER;
IDV NUMBER;
IDN NUMBER;
ID_USER NUMBER;
BEGIN
  SELECT ID_USUARIO INTO IDU FROM USUARIO WHERE UPPER(ALIAS) = UPPER(USER);
  SELECT CANAL_ID_CANAL INTO IDC FROM USUARIO WHERE UPPER(ALIAS) = UPPER(USER);
  SELECT ID_USUARIO INTO ID_USER FROM USUARIO WHERE UPPER(ALIAS)=UPPER(USER);
  IDV := SEQ_VIDEO.NEXTVAL;
  /*SELECT MAX(ID_VIDEO) INTO IDV FROM VIDEO;
  
  IF IDV IS NULL THEN 
    IDV := 1;
  ELSE
    IDV := 1 + IDV;
  END IF;
  */
  IF COSTE = 0 THEN
    INSERT INTO VIDEO (ID_VIDEO, DURACION, TITULO, DESCRIPCION, FORMATO, ENLACE,
    N_VISUALIZACIONES, N_COMENTARIOS, N_MEGUSTA, N_NOMEGUSTA, FECHA_CREACION,
    IMAGEN, VIDEO_PAGO, CANAL_ID_CANAL)
    VALUES(IDV, DUR, TIT, DES, FRM, ENL, 0, 0, 0, 0, SYSDATE, IMG, '0', IDC);
  ELSE
    INSERT INTO VIDEO (ID_VIDEO, DURACION, TITULO, DESCRIPCION, FORMATO, ENLACE,
    N_VISUALIZACIONES, N_COMENTARIOS, N_MEGUSTA, N_NOMEGUSTA, FECHA_CREACION,
    IMAGEN, VIDEO_PAGO, CANAL_ID_CANAL)
    VALUES(IDV, DUR, TIT, DES, FRM, ENL, 0, 0, 0, 0, SYSDATE, IMG, '1', IDC);
    INSERT INTO PAGO (VIDEO_ID_VIDEO, PAGO,USUARIO_ID_USUARIO) VALUES(IDV, COSTE,ID_USER);
  END IF;
  
  /*SELECT MAX(ID_NOTIFICACION) INTO IDN FROM NOTIFICACION;
  
  IF IDN IS NULL THEN
    IDN := 1;
  ELSE
    IDN := 1 + IDN;
  END IF;
  */
  DECLARE CURSOR U_SUSCRITOS IS SELECT USUARIO_ID_USUARIO FROM SUBSCRIPCIONES WHERE CANAL_ID_CANAL = IDC;
  BEGIN
    FOR VAR_CURSOR IN U_SUSCRITOS LOOP
      IDN := SEQ_NOTIF.NEXTVAL;
      INSERT INTO NOTIFICACION (ID_NOTIFICACION, TEXTO, CANAL_ID_CANAL,
      DENUNCIA_ID_DENUNCIA, VIDEO_ID_VIDEO, USUARIO_ID_USUARIO)
      VALUES (IDN, 'Nuevo vídeo: ' || TIT, IDC, NULL, IDV, VAR_CURSOR.USUARIO_ID_USUARIO);
      --IDN := IDN + 1;
    END LOOP;
  END;
  COMMIT;
END ALTA_VIDEO;
/
----------3.2-------------------
create or replace PROCEDURE SIMULAR_VIDEO
(
video_id NUMBER,
duracion_v NUMBER 
) AS 
visto NUMBER:=101;
nombre NUMBER;
porcentaje NUMBER;
pago_p NUMBER;
es_de char(1);
EX_VISIONADO_NO_AUTORIZADO EXCEPTION;
BEGIN
--Saco el id del usuario que esta en este momento
SELECT ID_USUARIO into nombre FROM USUARIO where UPPER(user)=UPPER(ALIAS);
--Saco la duracion de el video
SELECT DURACION into porcentaje FROM VIDEO where ID_VIDEO=video_id;
--Miro si el video es de pago
SELECT VIDEO_PAGO into es_de FROM VIDEO where ID_VIDEO=video_id;
if TO_NUMBER(es_de)=1 then
--Si el video es de pago miro si el user lo ha pagado
SELECT COUNT(*) into pago_p from PAGO where VIDEO_ID_VIDEO=video_id and USUARIO_ID_USUARIO=nombre;
--Si no he pago el video suleto la excepcion
if pago_p=0 then 
raise EX_VISIONADO_NO_AUTORIZADO;
end if;
end if;
--Si has visto el video solo hay q actualizar
--Si no lo has visto saltara la excepcion de no datos q es xq no encuentra nada
SELECT VISTO into visto from HISTORIAL where video_id=VIDEO_ID_VIDEO and USUARIO_ID_USUARIO=nombre;
--Si lo q habias visto mas lo q has visto ahora suma la duracion del video pues lo has terminado de ver
 if duracion_v+visto=porcentaje then
 --Actualizo termino a la fecha actual y el porcentaje al total del video
  UPDATE historial set termino = sysdate, visto=porcentaje where video_id=VIDEO_ID_VIDEO and USUARIO_ID_USUARIO=nombre;
  else 
  UPDATE historial set  visto=VISTO+duracion_v where video_id=VIDEO_ID_VIDEO and USUARIO_ID_USUARIO=nombre;
  end if;
EXCEPTION
--Si llego aqui es q es la 1º vez que veo el video
WHEN no_data_found THEN
--Actualizo el nº de visializaciones del video
 UPDATE video set N_VISUALIZACIONES = N_VISUALIZACIONES+1 where video_id=ID_VIDEO;
 --Inserto en historial q he visto o empezado el video
 INSERT INTO historial (usuario_id_usuario,video_id_video,VISTO,EMPEZO) values (nombre,video_id,duracion_v,SYSDATE);
--Si he visto el video entero lo actualizo
 if duracion_v=porcentaje then
 --Actualizo termino al dia de finalizacion y porcentaje a la duracion total del video
  UPDATE historial set termino = sysdate, visto=porcentaje where video_id=VIDEO_ID_VIDEO and USUARIO_ID_USUARIO=nombre;
  end if;
  --Borro la notificacion del video porque ya lo empeze a ver
  delete from NOTIFICACION where video_id=VIDEO_ID_VIDEO and nombre=USUARIO_ID_USUARIO;
 COMMIT;
when EX_VISIONADO_NO_AUTORIZADO then
--Si llego aqui es q no lo he pagado
--dbms_output.put_line('El video es de pago y no has pagado');
raise EX_VISIONADO_NO_AUTORIZADO;
END SIMULAR_VIDEO;