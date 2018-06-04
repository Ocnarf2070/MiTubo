create tablespace MITUBO_ESPACE datafile 'C:\app\alumnos\mitubo_espace.dbf' size 1G autoextend on; 

CREATE PROFILE MITUBO_PERF LIMIT FAILED_LOGIN_ATTEMPTS 3 IDLE_TIME 5;

CREATE ROLE R_CONSULTOR;
GRANT CONNECT TO R_CONSULTOR; 
CREATE USER U_CONSULTOR IDENTIFIED BY bd PROFILE MITUBO_PERF;
GRANT R_CONSULTOR to U_CONSULTOR;

CREATE ROLE R_AGENTE;
GRANT CONNECT TO R_AGENTE; 
GRANT SELECT, DELETE  ON U_ADMINISTRADOR.DENUNCIA TO R_AGENTE;
GRANT DELETE ON U_ADMINISTRADOR.VIDEO TO R_AGENTE;
GRANT INSERT, DELETE ON U_ADMINISTRADOR.NOTIFICACION TO R_AGENTE;
CREATE USER U_AGENTE IDENTIFIED BY bd PROFILE MITUBO_PERF;
GRANT R_AGENTE to U_AGENTE;

CREATE ROLE R_ADMINISTRADOR;
GRANT CONNECT TO R_ADMINISTRADOR; 
--GRANT CREATE TABLE TO U_ADMINISTRADOR;
--GRANT CREATE VIEW TO U_ADMINISTRADOR;
--GRANT CREATE ROLE to U_ADMINISTRADOR;
--GRANT CREATE SEQUENCE to U_ADMINISTRADOR;
GRANT ALTER USER to U_ADMINISTRADOR;
GRANT RESOURCE TO R_ADMINISTRADOR;
CREATE USER U_ADMINISTRADOR IDENTIFIED BY bd PROFILE MITUBO_PERF QUOTA 1G 
ON MITUBO_ESPACE DEFAULT TABLESPACE MITUBO_ESPACE;
GRANT R_ADMINISTRADOR to U_ADMINISTRADOR;
grant CREATE USER to R_ADMINISTRADOR with admin option;

CREATE ROLE R_USUARIO;
GRANT CONNECT TO R_USUARIO; 
CREATE USER U_USUARIO IDENTIFIED BY bd PROFILE MITUBO_PERF;
GRANT R_USUARIO to U_USUARIO;

