/*************************************************/
-- Fecha Creación del Script:  15/Jul/2016
-- Historial  Dependencias:
-- TBA    15/Jul/2016   Autorización de las transacciones Pantalla Búsqueda de Clientes: 1190 CONSULTA DEL NOMBRE DE UN CLIENTE, 1414 CONSULTA DIRECCION Y TELEFONO DEL ENTE
-- RSA    15/Jul/2016   Inserción de sp en la ad_procedure
/*************************************************/ 

--Instalador: $/COB/Test/TEST_SaaSMX/CtasCteAho/Dependencias/sql/mis_traut.sql

DELETE FROM cobis..ad_tr_autorizada
WHERE (ta_producto = 2 AND ta_tipo = 'R' AND ta_moneda = 0 AND ta_transaccion = 1190 AND ta_rol = 3 ) OR
(ta_producto = 2 AND ta_tipo = 'R' AND ta_moneda = 0 AND ta_transaccion = 1414 AND ta_rol = 3 )

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', 0, 1190, 3, getdate(), 1, 'V', getdate())


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', 0, 1414, 3, getdate(), 1, 'V', getdate())

--Instalador: $/COB/Test/TEST_SaaSMX/CtasCteAho/Remesas/BackEnd/sql/re_proc.sql

delete from ad_procedure where pd_procedure = 710
and pd_base_datos = 'cob_remesas'

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (710, 'sp_mto_marca_servicio', 'cob_remesas', 'V', getdate(), 'remtomase.sp')
GO

