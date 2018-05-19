-------------------1º-----------------------
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
aleatorio2 number;
BEGIN
aleatorio:=trunc(dbms_random.value(0,500));
aleatorio2:=trunc(dbms_random.value(500,1000));
sentencia1:= 'CREATE USER ' || nombre || ' IDENTIFIED BY ' || contraseña || ' PROFILE MITUBO_PERF DEFAULT TABLESPACE ESPACE_GENTE';
execute immediate sentencia1;
sentencia2:= 'grant R_USUARIO to' || nombre;
execute immediate sentencia2;
insert INTO canal (ID_CANAL,NOMBRE,AMBITO,TEMÁTICA,SUBSCRIPTORES) values (aleatorio2,alias,ambito,tematica,0);
insert INTO usuario (ID_USUARIO,ALIAS,NOMBRE,APELLIDO1,APELLIDO2,EMAIL,ZONA_HORARIA,IDIOMA,PAIS,CANAL_ID_CANAL) values (aleatorio2,alias,nombre,apellido1,apellido2,email,zona_horaria,
idioma,pais,aleatorio2);
END create_user;