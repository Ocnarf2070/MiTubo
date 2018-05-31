create or replace view V_INACTIVO as
  (SELECT U.ALIAS, MAX(V.FECHA_CREACION)AS ULTIMOVIDEO, MAX(C.FECHA)AS ULTIMOCOMENTARIO, MAX(H.TERMINO)AS ULTIMABUSQUEDA  FROM USUARIO U,VIDEO V,CANAL CA,COMENTARIO C,HISTORIALV1 H 
  WHERE U.ID_USUARIO=H.USUARIO_ID_USUARIO and U.ID_USUARIO=C.USUARIO_ID_USUARIO and U.CANAL_ID_CANAL=CA.ID_CANAL and CA.ID_CANAL=V.CANAL_ID_CANAL
  GROUP BY U.ALIAS);