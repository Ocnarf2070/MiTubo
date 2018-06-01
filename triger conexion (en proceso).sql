create or replace TRIGGER CONTROL_SESION 
BEFORE ALTER OR ANALYZE OR ASSOCIATE STATISTICS OR AUDIT OR COMMENT OR CREATE OR DDL OR DISASSOCIATE STATISTICS OR DROP OR GRANT OR LOGOFF OR NOAUDIT OR RENAME OR REVOKE OR SHUTDOWN OR TRUNCATE ON DATABASE 
DECLARE
numero NUMBER;
BEGIN
 select count(username) into numero from ADMINISTRADO.SESIONES_ACTIVAS  where USERNAME='SYSTEM';
 if numero=1 then
 raise PROGRAM_ERROR;
 end if;
END;