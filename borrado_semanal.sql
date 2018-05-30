CREATE OR REPLACE VIEW V_ULTIMABUSQUEDA ("ALIAS","ULTIMABUSQUEDA")AS (SELECT U.ALIAS, MAX(H.TERMINO) FROM USUARIO U, HISTORIALV1 H
WHERE U.ID_USUARIO=H.USUARIO_ID_USUARIO
GROUP BY U.ALIAS);

CREATE OR REPLACE VIEW V_ULTIMOVIDEO AS
  (SELECT U.ALIAS, MAX(V.FECHA_CREACION) AS ULTIMOVIDEO FROM USUARIO U, VIDEO V
  WHERE U.CANAL_ID_CANAL = V.CANAL_ID_CANAL
GROUP BY ALIAS);

CREATE OR REPLACE VIEW ULTIMO_COMENTARIO AS
  (SELECT U.ALIAS, MAX (C.FECHA)AS ULTIMOCOMENTARIO FROM USUARIO U, COMENTARIO C
  WHERE C.USUARIO_ID_USUARIO = U.ID_USUARIO
GROUP BY ALIAS);

CREATE OR REPLACE PROCEDURE P_INACTIVO AS
  UC DATE;
  UV DATE;
  UH DATE;
  CONTADOR NUMBER;
  SENTENCIA VARCHAR2(500);
BEGIN 
  DECLARE CURSOR U_ALIAS IS SELECT ALIAS FROM USUARIO;
  BEGIN
    FOR VAR_CURSOR IN U_ALIAS LOOP
      CONTADOR:=0;
      SELECT ULTIMOCOMENTARIO INTO UC FROM ULTIMO_COMENTARIO WHERE ALIAS=VAR_CURSOR.ALIAS;
      SELECT ULTIMABUSQUEDA INTO UH FROM V_ULTIMABUSQUEDA WHERE ALIAS=VAR_CURSOR.ALIAS;
      SELECT ULTIMOVIDEO INTO UV FROM V_ULTIMOVIDEO WHERE ALIAS=VAR_CURSOR.ALIAS;
      IF UC IS NULL OR SYSDATE-UC>30 THEN
        CONTADOR:=CONTADOR+1;
      END IF;
      IF UH IS NULL OR SYSDATE-UH>30 THEN
        CONTADOR:=CONTADOR+1;
      END IF;
      IF UV IS NULL OR SYSDATE-UV>30 THEN
        CONTADOR:=CONTADOR+1;
      END IF;
      IF CONTADOR=3 THEN
        SENTENCIA:='DROP USER '|| VAR_CURSOR.ALIAS ;
        execute immediate SENTENCIA;
      END IF;
    END LOOP;
  END;
END;

begin
DBMS_SCHEDULER.CREATE_JOB (
    job_name=> 'borrado_semanal',
    job_type=> 'PLSQL_BLOCK',
    job_action => 'P_INACTIVO',
    start_date => sysdate,
    repeat_interval => 'FREQ=SECONDLY;INTERVAL=60'
    );
end;



