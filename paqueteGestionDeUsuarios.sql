CREATE OR REPLACE PACKAGE GESTION_USUARIOS AS 
  procedure create_user(
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
  );
  
  PROCEDURE BORRADO (
    ID IN NUMBER
  );
  
  PROCEDURE MODIFICA (
    NOMBRE_NUEVO IN VARCHAR2,
    AP1 IN VARCHAR2,
    AP2 IN VARCHAR2,
    DES IN VARCHAR2,
    CORREO IN VARCHAR2
  );
  
   PROCEDURE BLOQUEAR_USUARIO (
    ALIAS IN VARCHAR2
  );
  
  PROCEDURE DESBLOQUEAR_USUARIO (
    ALIAS IN VARCHAR2 
  );
  
  PROCEDURE BLOQUEAR_PAIS (
      PAISBLOCK IN VARCHAR2 
    );
    
END GESTION_USUARIOS;
/

CREATE OR REPLACE PACKAGE BODY GESTION_USUARIOS AS
--CREAR USUARIO--
 procedure create_user
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
select MAX(ID_USUARIO) into aleatorio from USUARIO;
if aleatorio IS NULL then
aleatorio:=0;
else 
aleatorio:=aleatorio+1;
end if;
sentencia1:= 'CREATE USER ' || nombre || ' IDENTIFIED BY ' || contraseña || ' PROFILE MITUBO_PERF DEFAULT TABLESPACE ESPACE_GENTE';
execute immediate sentencia1;
sentencia2:= 'grant R_USUARIO to' || nombre;
execute immediate sentencia2;
insert INTO canal (ID_CANAL,NOMBRE,AMBITO,TEMÁTICA,SUBSCRIPTORES) values (aleatorio,alias,ambito,tematica,0);
insert INTO usuario (ID_USUARIO,ALIAS,NOMBRE,APELLIDO1,APELLIDO2,EMAIL,ZONA_HORARIA,IDIOMA,PAIS,CANAL_ID_CANAL) values (aleatorio,alias,nombre,apellido1,apellido2,email,zona_horaria,
idioma,pais,aleatorio);
COMMIT;
END create_user;
    
  ---BORRAR USUARIO---
  PROCEDURE BORRADO 
    (
    ID IN NUMBER
    ) AS
   BEGIN
    UPDATE USUARIO SET BORRADO='S' WHERE ID_USUARIO=ID;
    END BORRADO;
    
  ---MODIFICAR USUARIO---
  PROCEDURE MODIFICA (
    NOMBRE_NUEVO IN VARCHAR2,
    AP1 IN VARCHAR2,
    AP2 IN VARCHAR2,
    DES IN VARCHAR2,
    CORREO IN VARCHAR2
    ) AS 
  BEGIN
    UPDATE USUARIO SET NOMBRE = NOMBRE_NUEVO,
    APELLIDO1=AP1,
    APELLIDO2=AP2,
    DESCRIPCIÓN=DES,
    EMAIL=CORREO 
    WHERE ALIAS=USER;
  END MODIFICA;
  
  ---BLOQUEAR USUARIO---
  PROCEDURE BLOQUEAR_USUARIO (
    ALIAS IN VARCHAR2
  ) AS 
    SENTENCIA VARCHAR2(500);
  BEGIN
    SENTENCIA:= 'ALTER USER '|| ALIAS ||' ACCOUNT LOCK' ;
    EXECUTE IMMEDIATE SENTENCIA;
  END BLOQUEAR_USUARIO;
  
  ---DESBLOQUEAR USUARIO---
  PROCEDURE DESBLOQUEAR_USUARIO (
    ALIAS IN VARCHAR2 
  ) AS
    SENTENCIA VARCHAR2(500);
  BEGIN
    SENTENCIA:= 'ALTER USER '|| ALIAS ||' ACCOUNT UNLOCK' ;
    EXECUTE IMMEDIATE SENTENCIA;
  END DESBLOQUEAR_USUARIO;
  
  ---BLOQUEAR PAIS---
    PROCEDURE BLOQUEAR_PAIS (
      PAISBLOCK IN VARCHAR2 
    ) AS 
      SENTENCIA VARCHAR2(500);
    BEGIN
      DECLARE 
        CURSOR BLOQUEAR_CURSOR IS SELECT ALIAS FROM USUARIO WHERE PAIS=PAISBLOCK;
      BEGIN
        FOR VAR_CURSOR IN BLOQUEAR_CURSOR LOOP
        SENTENCIA:= 'ALTER USER '|| VAR_CURSOR.ALIAS || ' ACCOUNT LOCK';
        EXECUTE IMMEDIATE SENTENCIA;
      END LOOP;
      END;
    END BLOQUEAR_PAIS;
END;