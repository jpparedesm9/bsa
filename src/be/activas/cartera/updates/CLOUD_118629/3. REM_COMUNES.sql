--------------------------------------------------------------------------------------------
-- REGISTRO DE MENU DE PANTALLA PARA RESETEO DE IMAGENES Y MENSAJE DE BIENVENIDA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : .sql
-- Parametrizar el rol

---------------------------------------------------------------------------------------------
-- AÑADIR TEMPLATE PARA ENVIO DE CORREOS
---------------------------------------------------------------------------------------------

if not exists (select 1 from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt')
begin
   INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
   VALUES(1009,'XSLT','','NotificacionGenerica.xslt','A','1.0.0')
end

---------------------------------------------------------------------------------------------
-- ACTUALIZACION PARAMETRO DE VIGENCIA DE EXPIRACION DEL CODIGO DE ENROLAMIENTO
---------------------------------------------------------------------------------------------
if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'B2CDVR' and   pa_producto = 'CRE')
begin
   update cobis..cl_parametro 
   set pa_smallint = 1
   where pa_nemonico = 'B2CDVR'
   and   pa_producto = 'CRE'
end