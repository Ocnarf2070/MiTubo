begin 
dbms_scheduler.create_job(
job_name => 'DESCONECTAR_INACTIVOS',
job_type => 'PLSQL_BLOCK',
job_action => 'BEGIN 
 DESCONECTAR
END;',
start_date => NEXT_DAY(sysdate,'LUNES'),
repeat_interval => 'FREQ=DAILY; INTERVAL =7',
enabled => TRUE,
comments => 'Revoca los permisos de conectar');
END;
/
