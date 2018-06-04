alter table PAGO
add constraint CK_PAGO
check (PAGO >= 1);

ALTER TABLE VIDEO
ADD CONSTRAINT CK_POSITIVOS
CHECK (N_VISUALIZACIONES >= 0 AND N_COMENTARIOS >=0 AND N_MEGUSTA >=0
AND N_MEGUSTA >=0 AND N_NOMEGUSTA >=0);

ALTER TABLE AJUSTES 
ADD CONSTRAINT CK_METODOS
check (MODO_PAGO in ('TARJETA','EFECTIVO','TRANSFERENCIA','PAYPAL'));

alter table DENUNCIA
 add constraint CK_COMENTARIO
 check (COMENTARIO is not null);
 
 alter table USUARIO
 add CONSTRAINT ck_correo_contact
 CHECK ( REGEXP_LIKE(EMAIL, '^[a-zA-Z0-9!#$%''\*\+-/=\?^_`\{|\}~]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}$'));
 
 


