
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

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ng_origen' and TABLE_NAME = 'cl_notificacion_general')
begin
    alter table cobis..cl_notificacion_general add ng_origen char(1)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ng_tramite' and TABLE_NAME = 'cl_notificacion_general')
begin
    alter table cobis..cl_notificacion_general add ng_tramite int
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
	select @w_id = (max(te_id)+1) from cobis..ns_template 
	insert into cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
	values (@w_id, 'XSLT', 'NEUTRAL', 'GarantiaLiquida.xslt', 'A', '1.0.0.0')
	set @w_id = 0
end

if not exists (select 1 from cobis..ns_template where te_nombre = 'NotificacionGeneral.xslt')
begin
	select @w_id = (max(te_id)+1) from cobis..ns_template 
	insert into cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
	values (@w_id, 'XSLT', 'NEUTRAL', 'NotificacionGeneral.xslt', 'A', '1.0.0.0')
	set @w_id = 0
end

if not exists (select 1 from cobis..ns_template where te_nombre = 'PagoCorresponsal.xslt')
begin
	select @w_id = (max(te_id)+1) from cobis..ns_template 
	insert into cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
	values (@w_id, 'XSLT', 'NEUTRAL', 'PagoCorresponsal.xslt', 'A', '1.0.0.0')
	set @w_id = 0
end