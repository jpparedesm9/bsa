--------------------------------------------------------------------------------------------
-- TEMPLATE PARA NUEVA PLANTILLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : .sql

---------------------------------------------------------------------------------------------
-- ROLLBACK TEMPLATE PARA ENVIO DE CORREOS
---------------------------------------------------------------------------------------------

use cobis
go

select * from cobis..ns_template

if exists (select 1 from cobis..ns_template where te_nombre = 'NotifGeneracionReporteDocUnificado.xslt')
begin
   delete from cobis..ns_template where te_nombre = 'NotifGeneracionReporteDocUnificado.xslt'
end
GO

select * from cobis..ns_template