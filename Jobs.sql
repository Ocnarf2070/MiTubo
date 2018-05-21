begin 
dbms_scheduler.create_job(
job_name => 'Borrar_Usuarios_Inactivos',
job_type => 'PLSQL_BLOCK',
job_action => 'BEGIN 
DELETE FROM MENSAJES_BORRADOS; 
END;',
start_date => NEXT_DAY(sysdate,'LUNES'),
repeat_interval => 'FREQ=DAILY; INTERVAL =7',
enabled => TRUE,
comments => 'Borra los usuarios inactivos');
END;