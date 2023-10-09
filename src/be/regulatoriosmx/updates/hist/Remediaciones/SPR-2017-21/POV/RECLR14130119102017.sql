/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : 
--Fecha                      : 17/10/2017
--Descripción del Problema   : Usuario caducado
--Descripción de la Solución : Actualizar fecha de usuario caducado
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS SearchAddresBusiness CUSTOMERMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo          	 : 


use cobis
    GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchAddresBusiness')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'searchAddresBusiness', csc_description = '', csc_trn = 1227 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchAddresBusiness'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.SearchAddresBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchAddresBusiness', '', 1227)
      GO


USE cobis
GO

declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchAddresBusiness'
INSERT INTO cobis..ad_servicio_autorizado values('CustomerDataManagementService.CustomerManagement.SearchAddresBusiness', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())


--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS LOANSGROUP CalcLoanAmount
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo          	 : 


 use cobis
    GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.loangroup.service.IGroupLoanAmountMaintenance', csc_method_name = 'calcLoanAmount', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount', 'cobiscorp.ecobis.loangroup.service.IGroupLoanAmountMaintenance', 'calcLoanAmount', '', 0)
      GO


USE cobis
GO

declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount'
INSERT INTO cobis..ad_servicio_autorizado values('LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())


