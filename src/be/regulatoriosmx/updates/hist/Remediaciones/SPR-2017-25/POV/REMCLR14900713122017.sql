
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-R149007 Validación de documentos digitalizados
--Fecha                      : 13/12/2017
--Descripción del Problema   : No existen instaladores referentes a lo contenido en el archivo
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Crear TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_services_authorization.sql

use cobis
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'LoanGroup.ScannedDocuments.ValidateUploaded')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.loangroup.service.IScannedDocuments', csc_method_name = 'validateUploaded', csc_description = '', csc_trn = 21365 WHERE csc_service_id = 'LoanGroup.ScannedDocuments.ValidateUploaded'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('LoanGroup.ScannedDocuments.ValidateUploaded', 'cobiscorp.ecobis.loangroup.service.IScannedDocuments', 'validateUploaded', '', 21365)
GO



USE cobis
GO

declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'LoanGroup.ScannedDocuments.ValidateUploaded'
INSERT INTO cobis..ad_servicio_autorizado values('LoanGroup.ScannedDocuments.ValidateUploaded', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'



