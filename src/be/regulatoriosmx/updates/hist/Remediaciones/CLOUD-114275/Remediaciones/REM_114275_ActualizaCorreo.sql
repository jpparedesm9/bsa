use cob_credito 
go

-- CLIENTE 1395 
-- BRAULIA CAROLINA FRANCO RAMIREZ, 
-- SOLICITAMOS NUEVAMENTE EL ENVIO DE LAS CLAVES CORREO CORRECTO 
-- CARO.FR26@GMAIL.COM

update cob_credito..cr_ns_creacion_lcr set 
nc_correo = 'caro.fr26@gmail.com',
nc_estado = 'P'
where nc_cliente = 1395 
go