CREATE OR REPLACE VIEW V_USUARIOS (ID_USUARIO,ALIAS,NOMBRE,APELLIDO1,APELLIDO2,EMAIL,FOTO,DESCRIPCION,
        ZONA_HORARIA,IDIOMA,PAIS) AS
  SELECT ID_USUARIO,ALIAS,NOMBRE,APELLIDO1,APELLIDO2,EMAIL,FOTO,DESCRIPCION,ZONA_HORARIA,IDIOMA,PAIS
  FROM USUARIO
  WHERE BORRADO='N';