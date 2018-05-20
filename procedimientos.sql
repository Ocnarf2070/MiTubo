-------------------1�-----------------------
create or replace procedure create_user
(
nombre in VARCHAR2,
apellido1 in VARCHAR2,
apellido2 in VARCHAR2,
email in VARCHAR2,
zona_horaria in VARCHAR2,
idioma in VARCHAR2,
pais in VARCHAR2,
contrase�a VARCHAR2,
alias in VARCHAR2,
ambito in varchar2,
tematica in VARCHAR2
) as
sentencia1 VARCHAR2(500);
sentencia2 varchar2(500);
aleatorio number;
aleatorio2 number;
BEGIN
aleatorio:=trunc(dbms_random.value(0,500));
aleatorio2:=trunc(dbms_random.value(500,1000));
sentencia1:= 'CREATE USER ' || nombre || ' IDENTIFIED BY ' || contrase�a || ' PROFILE MITUBO_PERF DEFAULT TABLESPACE ESPACE_GENTE';
execute immediate sentencia1;
sentencia2:= 'grant R_USUARIO to' || nombre;
execute immediate sentencia2;
insert INTO canal (ID_CANAL,NOMBRE,AMBITO,TEM�TICA,SUBSCRIPTORES) values (aleatorio2,alias,ambito,tematica,0);
insert INTO usuario (ID_USUARIO,ALIAS,NOMBRE,APELLIDO1,APELLIDO2,EMAIL,ZONA_HORARIA,IDIOMA,PAIS,CANAL_ID_CANAL) values (aleatorio2,alias,nombre,apellido1,apellido2,email,zona_horaria,
idioma,pais,aleatorio2);
END create_user;

--3.1 (En mi PC no hace nada, pero no s� si funciona porque compilar, compila)
CREATE OR REPLACE PROCEDURE ALTA_VIDEO 
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
BEGIN
  SELECT ID_USUARIO INTO IDU FROM USUARIO WHERE ALIAS = USER;
  SELECT CANAL_ID_CANAL INTO IDC FROM USUARIO WHERE ALIAS = USER;
  SELECT MAX(ID_VIDEO) INTO IDV FROM VIDEO;
  
  IF IDV IS NULL THEN 
    IDV := 1;
  ELSE
    IDV := 1 + IDV;
  END IF;
  
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
    INSERT INTO VIDEO_PAGO (ID_VIDEO, COSTE) VALUES(IDV, COSTE);
  END IF;
  
  SELECT MAX(ID_NOTIFICACION) INTO IDN FROM NOTIFICACION;
  
  IF IDN IS NULL THEN
    IDN := 1;
  ELSE
    IDN := 1 + IDN;
  END IF;
  
  DECLARE CURSOR U_SUSCRITOS IS SELECT USUARIO_ID_USUARIO FROM SUBSCRIPCIONES WHERE CANAL_ID_CANAL = IDC;
  BEGIN
    FOR VAR_CURSOR IN U_SUSCRITOS LOOP
      INSERT INTO NOTIFICACION (ID_NOTIFICACION, TEXTO, CANAL_ID_CANAL,
      DENUNCIA_ID_DENUNCIA, VIDEO_ID_VIDEO, USUARIO_ID_USUARIO)
      VALUES (IDN, 'Nuevo v�deo: ' || TIT, IDC, NULL, IDV, VAR_CURSOR.USUARIO_ID_USUARIO);
      IDN := IDN + 1;
    END LOOP;
  END;
  
END ALTA_VIDEO;
