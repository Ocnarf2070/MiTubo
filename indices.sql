create index idxVideo_Pago on VIDEO(ID_VIDEO,VIDEO_PAGO); --saber que videos son de pago
create index idxUsuario_Pais on USUARIO(ID_USUARIO,ALIAS,PAIS);--mayor facilidad para saber el pais de un usuario
create index idxDenuncia on DENUNCIA(ID_DENUNCIA,USUARIO_ID_USUARIO);--saber mas facilmente los usuarios con denuncias
create index idxUsuario_Canal on USUARIO(ID_USUARIO,CANAL_ID_CANAL);--que usuarios tienen canal
create index idxPago_por_Usuario on PAGO(VIDEO_ID_VIDEO,USUARIO_ID_USUARIO,PAGO);--Saber que usuarios han visto videos de pago


