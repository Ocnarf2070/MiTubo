--EN SYS AS SYSDBA--
GRANT SELECT ON SYS.V_$SESSION TO U_ADMINISTRADOR;
--EN u_ADMINISTRADOR--
create or replace TRIGGER CONTROL_SESION 
AFTER LOGON ON DATABASE
DECLARE
    CURSOR ESTA_SYSTEM IS
      SELECT USERNAME FROM SYS.V_$SESSION WHERE USERNAME = 'SYSTEM';
  APODO_SYS VARCHAR2(50);
  CURSOR USU_ACT IS
    SELECT SID FROM SYS.V_$SESSION WHERE USERNAME != 'SYSTEM';
BEGIN
  OPEN ESTA_SYSTEM;
  FETCH ESTA_SYSTEM INTO APODO_SYS;

  FOR VAR_CURSOR IN USU_ACT LOOP
    IF(APODO_SYS = 'SYSTEM') THEN
      EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION' || VAR_CURSOR.SID;
    END IF;
  END LOOP;
END;