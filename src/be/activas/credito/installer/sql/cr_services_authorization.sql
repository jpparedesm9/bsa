
/**********************************************************************/
/*   Archivo:         cr_services_authorization.sql                   */
/*   Data base:       cobis                                           */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*   Autorizacion de los servicios de Credito                         */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   31-08-2017         Paul Clavijo           Emision Inicial        */
/**********************************************************************/

USE cobis
GO

SET NOCOUNT ON
GO

PRINT '>>>>>> ELIMINACION DE SERVICIOS'

DELETE cts_serv_catalog
WHERE csc_service_id IN
(
	'Loan.ConciliationManagement.RegisterLoanPayment',
	'Disbursement.ValidationService',
	'CobisRegisterServiceSERVImpl.registerCustomerInformation',
	'SantanderCoreServiceSERVImpl.getCustomerInformation',
	'CustomerServiceSERVImpl.findCustomerById',
	'CustomerServiceSERVImpl.getDelayGroupDays',
	'CustomerServiceSERVImpl.updateCustomerInfo',
	'CustomerServiceSERVImpl.getCustomerDetailsById',
	'OrchestrationClientValidationServiceSERVImpl.validate',
	'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule',
	'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',
	'OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule',
	'WorkflowServiceSERVImpl.executeRule',
	'OrchestrationClientValidationServiceSERVImpl.validateBuro',
	'OrchestrationClientValidationServiceSERVImpl.validateSantander',
	'BuroCustomerServiceSERVImpl.verify',
	'BuroCustomerServiceSERVImpl.validateRequest',
	'BuroCustomerUtilSERVImpl.generateHeader',
	'BuroCustomerUtilSERVImpl.getBlackList',
	'BuroCustomerUtilSERVImpl.isPartner',
	'BuroCustomerUtilSERVImpl.getDelayPercentage',
	'Loan.QueryDocuments.QueryDocuments',
	'Loan.QueryDocuments.QueryMembers',
	'Loan.QueryDocuments.QueryDocumentTypes',
	'Loan.QueryDocuments.QueryDocumentsByFilter',
	'OrchestrationClientValidationServiceSERVImpl.customerEvaluation',
	'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'
)

DELETE ad_servicio_autorizado
WHERE ts_servicio IN
(
	'Loan.ConciliationManagement.RegisterLoanPayment',
	'Disbursement.ValidationService',
	'CobisRegisterServiceSERVImpl.registerCustomerInformation',
	'SantanderCoreServiceSERVImpl.getCustomerInformation',
	'CustomerServiceSERVImpl.findCustomerById',
	'CustomerServiceSERVImpl.getDelayGroupDays',
	'CustomerServiceSERVImpl.updateCustomerInfo',
	'CustomerServiceSERVImpl.getCustomerDetailsById',
	'OrchestrationClientValidationServiceSERVImpl.validate',
	'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule',
	'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',
	'OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule',
	'WorkflowServiceSERVImpl.executeRule',
	'OrchestrationClientValidationServiceSERVImpl.validateBuro',
	'OrchestrationClientValidationServiceSERVImpl.validateSantander',
	'BuroCustomerServiceSERVImpl.verify',
	'BuroCustomerServiceSERVImpl.validateRequest',
	'BuroCustomerUtilSERVImpl.generateHeader',
	'BuroCustomerUtilSERVImpl.getBlackList',
	'BuroCustomerUtilSERVImpl.isPartner',
	'BuroCustomerUtilSERVImpl.getDelayPercentage',
	'Loan.QueryDocuments.QueryDocuments',
	'Loan.QueryDocuments.QueryMembers',
	'Loan.QueryDocuments.QueryDocumentTypes',
	'Loan.QueryDocuments.QueryDocumentsByFilter',
	'OrchestrationClientValidationServiceSERVImpl.customerEvaluation',
	'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'
)


PRINT '>>>>>> CREACION DE SERVICIOS'

DECLARE
	@w_rol_admin			INT,
	@w_rol_menu_procesos	INT,
	@w_rol_corresponsal		INT,	
    @w_producto				INT

SELECT @w_rol_admin = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'ADMINISTRADOR'
SELECT @w_rol_menu_procesos = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'MENU POR PROCESOS'
SELECT @w_rol_corresponsal = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'CORRESPONSAL NO BANCARIO'
SELECT @w_producto = pd_producto FROM cl_producto WHERE pd_abreviatura = 'CRE'  -- CREDITO

PRINT '- Loan.ConciliationManagement.RegisterLoanPayment'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('Loan.ConciliationManagement.RegisterLoanPayment', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'registerLoanPayment', 'Servicio de escucha de notificación de Openpay', NULL, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('Loan.ConciliationManagement.RegisterLoanPayment', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

PRINT '- Disbursement.ValidationService'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('Disbursement.ValidationService', 'com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.tasklet.IValidation', 'execute', 'Validación de chequeo de archivo de Desembolso', NULL, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('Disbursement.ValidationService', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('Disbursement.ValidationService', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


/* Servicios de Andres Cusme */ 
PRINT '- Loan.QueryDocuments.QueryDocuments'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('Loan.QueryDocuments.QueryDocuments', 'cobiscorp.ecobis.assets.cloud.service.IQueryDocuments', 'queryDocuments', 'Consulta de clientes', 21366, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('Loan.QueryDocuments.QueryDocuments', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

PRINT '- Loan.QueryDocuments.QueryMembers'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('Loan.QueryDocuments.QueryMembers', 'cobiscorp.ecobis.assets.cloud.service.IQueryDocuments', 'queryMembers', 'Consulta de clientes', 21366, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('Loan.QueryDocuments.QueryMembers', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- CobisRegisterServiceSERVImpl.registerCustomerInformation
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('CobisRegisterServiceSERVImpl.registerCustomerInformation', 'com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.bsl.ICobisRegisterService', 'registerCustomerInformation', 'Description', null,'N')

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CobisRegisterServiceSERVImpl.registerCustomerInformation', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CobisRegisterServiceSERVImpl.registerCustomerInformation', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CobisRegisterServiceSERVImpl.registerCustomerInformation', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
--SantanderCoreServiceSERVImpl.getCustomerInformation
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('SantanderCoreServiceSERVImpl.getCustomerInformation', 'com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.bsl.ISantanderCoreService', 'getCustomerInformation', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('SantanderCoreServiceSERVImpl.getCustomerInformation', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('SantanderCoreServiceSERVImpl.getCustomerInformation', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('SantanderCoreServiceSERVImpl.getCustomerInformation', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
--CustomerServiceSERVImpl.findCustomerById
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('CustomerServiceSERVImpl.findCustomerById', 'com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService', 'findCustomerById', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.findCustomerById', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.findCustomerById', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.findCustomerById', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
--CustomerServiceSERVImpl.getDelayGroupDays
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('CustomerServiceSERVImpl.getDelayGroupDays', 'com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService', 'getDelayGroupDays', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.getDelayGroupDays', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.getDelayGroupDays', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.getDelayGroupDays', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- Instalacion de: CustomerServiceSERVImpl.updateCustomerInfo
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('CustomerServiceSERVImpl.updateCustomerInfo', 'com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService', 'updateCustomerInfo', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.updateCustomerInfo', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.updateCustomerInfo', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.updateCustomerInfo', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())



----------------------------------------------------------------------------------
-- Instalacion de: CustomerServiceSERVImpl.getCustomerDetailsById
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('CustomerServiceSERVImpl.getCustomerDetailsById', 'com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService', 'getCustomerDetailsById', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.getCustomerDetailsById', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.getCustomerDetailsById', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerServiceSERVImpl.getCustomerDetailsById', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: CustomerServiceSERVImpl.getCustomerDetailsById
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('OrchestrationClientValidationServiceSERVImpl.validate', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validate', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validate', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validate', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validate', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- Instalacion de: CustomerServiceSERVImpl.getCustomerDetailsById
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
values ('OrchestrationClientValidationServiceSERVImpl.customerEvaluation', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'customerEvaluation', 'customerEvaluation', NULL, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.customerEvaluation', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.customerEvaluation', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.customerEvaluation', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.clientEvaluation
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
values ('OrchestrationClientValidationServiceSERVImpl.clientEvaluation', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'clientEvaluation', 'clientEvaluation', NULL, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.clientEvaluation', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.clientEvaluation', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.clientEvaluation', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateBuroClientGroupRule', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroupRule', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateBuroClientGroup', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateBuroClientIndividualRule', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuroClientIndividualRule', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: WorkflowServiceSERVImpl.executeRule
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('WorkflowServiceSERVImpl.executeRule', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'executeRule', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('WorkflowServiceSERVImpl.executeRule', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('WorkflowServiceSERVImpl.executeRule', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('WorkflowServiceSERVImpl.executeRule', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateBuro
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuro', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateBuro', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuro', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuro', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateBuro', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateSantander
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('OrchestrationClientValidationServiceSERVImpl.validateSantander', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateSantander', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateSantander', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateSantander', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('OrchestrationClientValidationServiceSERVImpl.validateSantander', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerServiceSERVImpl.verify
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('BuroCustomerServiceSERVImpl.verify', 'com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerService', 'verify', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerServiceSERVImpl.verify', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerServiceSERVImpl.verify', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerServiceSERVImpl.verify', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerServiceSERVImpl.validateRequest
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('BuroCustomerServiceSERVImpl.validateRequest', 'com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerService', 'validateRequest', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerServiceSERVImpl.validateRequest', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerServiceSERVImpl.validateRequest', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerServiceSERVImpl.validateRequest', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.generateHeader
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('BuroCustomerUtilSERVImpl.generateHeader', 'com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil', 'generateHeader', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.generateHeader', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.generateHeader', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.generateHeader', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.getBlackList
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('BuroCustomerUtilSERVImpl.getBlackList', 'com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil', 'getBlackList', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.getBlackList', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.getBlackList', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.getBlackList', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.isPartner
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('BuroCustomerUtilSERVImpl.isPartner', 'com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil', 'isPartner', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.isPartner', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.isPartner', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.isPartner', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.getDelayPercentage
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('BuroCustomerUtilSERVImpl.getDelayPercentage', 'com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil', 'getDelayPercentage', 'Description', null, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.getDelayPercentage', @w_rol_corresponsal, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.getDelayPercentage', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BuroCustomerUtilSERVImpl.getDelayPercentage', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- Instalacion de: Businessprocess.Creditmanagement.ApplicationManagment.CreateRevolvingApplication
----------------------------------------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('Businessprocess.Creditmanagement.ApplicationManagment.CreateRevolvingApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'createRevolvingApplication', '', 77100)
insert into cobis..ad_servicio_autorizado 
values ('Businessprocess.Creditmanagement.ApplicationManagment.CreateRevolvingApplication', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())    

----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.getDelayPercentage
----------------------------------------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateRevolvingApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'updateRevolvingApplication', '', 77100)
insert into cobis..ad_servicio_autorizado 
values('Businessprocess.Creditmanagement.ApplicationManagment.UpdateRevolvingApplication', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

----------------------------------------------------------------------------------
-- Instalacion de: Loan.QueryDocuments.QueryDocumentTypes
----------------------------------------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('Loan.QueryDocuments.QueryDocumentTypes', 'cobiscorp.ecobis.assets.cloud.service.IQueryDocuments', 'queryDocumentTypes', 'Consulta tipo de documentos', 21321)
insert into cobis..ad_servicio_autorizado 
values('Loan.QueryDocuments.QueryDocumentTypes', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())


----------------------------------------------------------------------------------
-- Instalacion de: Loan.QueryDocuments.QueryDocumentsByFilter
----------------------------------------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('Loan.QueryDocuments.QueryDocumentsByFilter', 'cobiscorp.ecobis.assets.cloud.service.IQueryDocuments', 'queryDocumentsByFilter', 'Consulta documentos por filtro', 21322)
insert into cobis..ad_servicio_autorizado 
values('Loan.QueryDocuments.QueryDocumentsByFilter', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())



----------------------------------------------------------------------------------
-- Instalacion de: Loan.BankGeolocation.InsertBankGeolocation
----------------------------------------------------------------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('BusinessToConsumer.BankGeolocation.InsertBankGeolocation', 'cobiscorp.ecobis.businesstoconsumer.service.IBankGeolocation', 'insertBankGeolocation', 'Servicio de Onboarding', NULL, 'N')
INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.BankGeolocation.InsertBankGeolocation', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())


GO

SET NOCOUNT OFF
GO

-------------------------------------------
--- SERVICIO OBTENER ESTADOS          -----
-------------------------------------------
declare 
@w_producto              int,
@w_tn_trn_code           int,
@w_pd_procedure          int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select 
@w_tn_trn_code  = 21745,
@w_pd_procedure = 21745

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ASESOR',
'FUNCIONARIO OFICINA',
'COORDINADOR',
'GERENTE OFICINA', 
'MESA DE OPERACIONES'
)

delete cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchState'

insert into cts_serv_catalog values ('CustomerDataManagementService.CustomerManagement.SearchState', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement','searchState','',@w_tn_trn_code,null, null, null)

delete ad_servicio_autorizado  where ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchState'

insert into ad_servicio_autorizado 
select 'CustomerDataManagementService.CustomerManagement.SearchState',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from @w_roles


-------------------------------------------
--- SERVICIO ACTUALIZAR ESTADOS          -----
-------------------------------------------
declare 
@w_producto              int,
@w_tn_trn_code           int,
@w_pd_procedure          int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select 
@w_tn_trn_code  = 21745,
@w_pd_procedure = 21745

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ASESOR',
'FUNCIONARIO OFICINA',
'COORDINADOR',
'GERENTE OFICINA', 
'MESA DE OPERACIONES'
)

delete cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateState'

insert into cts_serv_catalog values ('CustomerDataManagementService.CustomerManagement.UpdateState', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement','updateState','',@w_tn_trn_code,null, null, null)

delete ad_servicio_autorizado  where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateState'

insert into ad_servicio_autorizado 
select 'CustomerDataManagementService.CustomerManagement.UpdateState',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from @w_roles

go
