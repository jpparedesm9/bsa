
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S151216 Cuerpo de los mensajes de correo
--Fecha                      : 09/01/2018
--Descripción del Problema   : No existen cregistros ni campos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ALTER TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ng_origen' and TABLE_NAME = 'cl_notificacion_general')
begin
    alter table cobis..cl_notificacion_general drop column ng_origen
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ng_tramite' and TABLE_NAME = 'cl_notificacion_general')
begin
    alter table cobis..cl_notificacion_general drop column ng_tramite
end

--------------------------------------------------------------------------------------------
-- INSERT TAMPLATES
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

declare @w_id int = 0

if not exists (select 1 from cobis..ns_template where te_nombre = 'GarantiaLiquida.xslt')
begin
	delete cobis..ns_template where te_nombre = 'GarantiaLiquida.xslt'
end

if not exists (select 1 from cobis..ns_template where te_nombre = 'NotificacionGeneral.xslt')
begin
	delete cobis..ns_template where te_nombre = 'NotificacionGeneral.xslt'
end

if not exists (select 1 from cobis..ns_template where te_nombre = 'PagoCorresponsal.xslt')
begin
	delete cobis..ns_template where te_nombre = 'PagoCorresponsal.xslt'
end