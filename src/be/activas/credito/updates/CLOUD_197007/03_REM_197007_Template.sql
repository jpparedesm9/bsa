--------------------------------------------------------------------------------------------
-- TEMPLATE PARA NUEVA PLANTILLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : .sql
-- Parametrizar el rol

---------------------------------------------------------------------------------------------
-- AÑADIR TEMPLATE PARA ENVIO DE CORREOS
---------------------------------------------------------------------------------------------

use cobis
go

select * from cobis..ns_template

if not exists (select 1 from cobis..ns_template where te_nombre = 'NotifGeneracionReporteDocUnificado.xslt')
begin
   INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
   VALUES(1026,'XSLT','NEUTRAL','NotifGeneracionReporteDocUnificado.xslt','A','1.0.0')
end
GO

select * from cobis..ns_template