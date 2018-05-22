CREATE OR REPLACE PACKAGE GESTION_VIDEOS AS
  PROCEDURE ALTA_VIDEO 
  (
  DUR IN NUMBER,
  TIT IN VARCHAR2,
  DES IN VARCHAR2,
  FRM IN VARCHAR2,
  ENL IN VARCHAR2,
  IMG IN BLOB,
  COSTE IN NUMBER
  );
  
  PROCEDURE SIMULAR_VIDEO
  (
  video_id NUMBER,
  duracion_v NUMBER 
  );
  
END GESTION_VIDEOS;
/

CREATE OR REPLACE PACKAGE BODY GESTION_VIDEOS AS
---ALTA VIDEO---
  PROCEDURE ALTA_VIDEO 
  (
  DUR IN NUMBER,
  TIT IN VARCHAR2,
  DES IN VARCHAR2,
  FRM IN VARCHAR2,
  ENL IN VARCHAR2,
  IMG IN BLOB,
  COSTE IN NUMBER
  )AS 
  IDC NUMBER;
  IDU NUMBER;
  IDV NUMBER;
  IDN NUMBER;
BEGIN
  SELECT ID_USUARIO INTO IDU FROM USUARIO WHERE ALIAS = USER;
  SELECT CANAL_ID_CANAL INTO IDC FROM USUARIO WHERE ALIAS = USER;
  SELECT MAX(ID_VIDEO) INTO IDV FROM VIDEO;
  
  IF IDV IS NULL THEN 
    IDV := 1;
  ELSE
    IDV := 1 + IDV;
  END IF;
  
  IF COSTE = 0 THEN
    INSERT INTO VIDEO (ID_VIDEO, DURACION, TITULO, DESCRIPCION, FORMATO, ENLACE,
    N_VISUALIZACIONES, N_COMENTARIOS, N_MEGUSTA, N_NOMEGUSTA, FECHA_CREACION,
    IMAGEN, VIDEO_PAGO, CANAL_ID_CANAL)
    VALUES(IDV, DUR, TIT, DES, FRM, ENL, 0, 0, 0, 0, SYSDATE, IMG, '0', IDC);
  ELSE
    INSERT INTO VIDEO (ID_VIDEO, DURACION, TITULO, DESCRIPCION, FORMATO, ENLACE,
    N_VISUALIZACIONES, N_COMENTARIOS, N_MEGUSTA, N_NOMEGUSTA, FECHA_CREACION,
    IMAGEN, VIDEO_PAGO, CANAL_ID_CANAL)
    VALUES(IDV, DUR, TIT, DES, FRM, ENL, 0, 0, 0, 0, SYSDATE, IMG, '1', IDC);
    INSERT INTO VIDEO_PAGO (ID_VIDEO, COSTE) VALUES(IDV, COSTE);
  END IF;
  
  SELECT MAX(ID_NOTIFICACION) INTO IDN FROM NOTIFICACION;
  
  IF IDN IS NULL THEN
    IDN := 1;
  ELSE
    IDN := 1 + IDN;
  END IF;
  
  DECLARE CURSOR U_SUSCRITOS IS SELECT USUARIO_ID_USUARIO FROM SUBSCRIPCIONES WHERE CANAL_ID_CANAL = IDC;
  BEGIN
    FOR VAR_CURSOR IN U_SUSCRITOS LOOP
      INSERT INTO NOTIFICACION (ID_NOTIFICACION, TEXTO, CANAL_ID_CANAL,
      DENUNCIA_ID_DENUNCIA, VIDEO_ID_VIDEO, USUARIO_ID_USUARIO)
      VALUES (IDN, 'Nuevo vídeo: ' || TIT, IDC, NULL, IDV, VAR_CURSOR.USUARIO_ID_USUARIO);
      IDN := IDN + 1;
    END LOOP;
  END;
  COMMIT;
END ALTA_VIDEO;

---SIMULAR VIDEO---
  PROCEDURE SIMULAR_VIDEO
  (
  video_id NUMBER,
  duracion_v NUMBER 
  ) AS 
  visto NUMBER:=101;
  nombre NUMBER;
  porcentaje NUMBER;
  pago_p NUMBER;
  es_de char(1);
  EX_VISIONADO_NO_AUTORIZADO EXCEPTION;
BEGIN
--Saco el id del usuario que esta en este momento
  SELECT ID_USUARIO into nombre FROM USUARIO where user=ALIAS;
--Saco la duracion de el video
  SELECT DURACION into porcentaje FROM VIDEO where ID_VIDEO=video_id;
--Miro si el video es de pago
  SELECT VIDEO_PAGO into es_de FROM VIDEO where ID_VIDEO=video_id;

  if TO_NUMBER(es_de)=1 then
--Si el video es de pago miro si el user lo ha pagado
    SELECT COUNT(*) into pago_p from PAGO where VIDEO_ID_VIDEO=video_id and USUARIO_ID_USUARIO=nombre;
--Si no he pago el video suleto la excepcion
    if pago_p=0 then 
      raise EX_VISIONADO_NO_AUTORIZADO;
    end if;
  end if;
--Si has visto el video solo hay q actualizar
--Si no lo has visto saltara la excepcion de no datos q es xq no encuentra nada
  SELECT PORCENTAJE_VISTO into visto from HISTORIALV1 where video_id=VIDEO_ID_VIDEO and USUARIO_ID_USUARIO=nombre;
--Si lo q habias visto mas lo q has visto ahora suma la duracion del video pues lo has terminado de ver
  if duracion_v+visto=porcentaje then
 --Actualizo termino a la fecha actual y el porcentaje al total del video
    UPDATE historialv1 set termino = sysdate, porcentaje_visto=porcentaje where video_id=VIDEO_ID_VIDEO and USUARIO_ID_USUARIO=nombre;
  end if;
EXCEPTION
--Si llego aqui es q es la 1º vez que veo el video
  WHEN no_data_found THEN
--Actualizo el nº de visializaciones del video
  UPDATE video set N_VISUALIZACIONES = N_VISUALIZACIONES+1 where video_id=ID_VIDEO;
 --Inserto en historial q he visto o empezado el video
  INSERT INTO historialv1 (usuario_id_usuario,video_id_video,PORCENTAJE_VISTO,EMPEZO) values (nombre,video_id,duracion_v,SYSDATE);
--Si he visto el video entero lo actualizo
  if duracion_v=porcentaje then
 --Actualizo termino al dia de finalizacion y porcentaje a la duracion total del video
    UPDATE historialv1 set termino = sysdate, porcentaje_visto=porcentaje where video_id=VIDEO_ID_VIDEO and USUARIO_ID_USUARIO=nombre;
  end if;
  --Borro la notificacion del video porque ya lo empeze a ver
  delete from NOTIFICACION where video_id=VIDEO_ID_VIDEO and nombre=USUARIO_ID_USUARIO;
 COMMIT;
  when EX_VISIONADO_NO_AUTORIZADO then
--Si llego aqui es q no lo he pagado
  dbms_output.put_line('El video es de pago y no has pagado');
END SIMULAR_VIDEO;

END;