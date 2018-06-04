CREATE OR REPLACE PROCEDURE BLOQUEAR_USUARIO 
(
    ALIAS IN VARCHAR2
  ) AS 
    SENTENCIA VARCHAR2(500);
    ERROR_AL_BLOQUEAR EXCEPTION;
  BEGIN
    SENTENCIA:= 'ALTER USER '|| ALIAS ||' ACCOUNT LOCK' ;
    EXECUTE IMMEDIATE SENTENCIA;
    EXCEPTION
    WHEN ERROR_AL_BLOQUEAR THEN
    DBMS_OUTPUT.PUT_LINE('EL USUARIO '||ALIAS|| '  NO SE HA PODIDO BLOQUEAR');
  END BLOQUEAR_USUARIO;