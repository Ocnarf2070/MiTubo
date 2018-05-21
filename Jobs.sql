begin 
dbms_scheduler.create_job(
job_name => 'Borrar_Usuarios_Inactivos',
job_type => 'PLSQL_BLOCK',
job_action => 'BEGIN 
 
END;',
start_date => NEXT_DAY(sysdate,'LUNES'),
repeat_interval => 'FREQ=DAILY; INTERVAL =7',
enabled => TRUE,
comments => 'Borra los usuarios inactivos');
END;
/
select u.ID_USUARIO from usuario u,HISTORIAL h,COMENTARIO co,CANAL ca, VIDEO v 
where (u.ID_USUARIO=h.USUARIO_ID_USUARIO and u.ID_USUARIO=co.USUARIO_ID_USUARIO
and u.CANAL_ID_CANAL=ca.ID_CANAL and ca.ID_CANAL=v.CANAL_ID_CANAL);
-- Se debe buscar cual fue el ultimo video y ver si es mayor que 1 mes
-- Se debe buscar cual fue el ultimo comentario y ver si es mayor que un mes
-- Se debe buscar en el hstorial el ultimo video visto y ver si es mayor que un mes.