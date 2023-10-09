/********************************************************************/
/* Fecha:   05-MAR-2015                                             */
/* Objeto:  Script de catalogación de servicios CTS                 */
/* Modulo:  COBIS - ADMIN                                         */
/********************************************************************/

use cobis
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.CatalogManagement.Search')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.ICatalogManagement', csc_method_name = 'search', csc_description = '', csc_trn = 1572, csc_procedure_validation = 'Y' WHERE csc_service_id = 'SystemConfiguration.CatalogManagement.Search'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('SystemConfiguration.CatalogManagement.Search', 'cobiscorp.ecobis.systemconfiguration.service.ICatalogManagement', 'search', '', 1564, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.OfficeManagement.ReadOffice')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', csc_method_name = 'readOffice', csc_description = '', csc_trn = 1572, csc_procedure_validation = 'Y' WHERE csc_service_id = 'SystemConfiguration.OfficeManagement.ReadOffice'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('SystemConfiguration.OfficeManagement.ReadOffice', 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', 'readOffice', '', 1572, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.OfficerManagement.ReadOfficer')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IOfficerManagement', csc_method_name = 'readOfficer', csc_description = '', csc_trn = 1577, csc_procedure_validation = 'Y' WHERE csc_service_id = 'SystemConfiguration.OfficerManagement.ReadOfficer'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('SystemConfiguration.OfficerManagement.ReadOfficer', 'cobiscorp.ecobis.systemconfiguration.service.IOfficerManagement', 'readOfficer', '', 1577, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.ParameterManagement.ParameterManagement')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IParameterManagement', csc_method_name = 'parameterManagement', csc_description = '', csc_trn = 1579, csc_procedure_validation = 'Y' WHERE csc_service_id = 'SystemConfiguration.ParameterManagement.ParameterManagement'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('SystemConfiguration.ParameterManagement.ParameterManagement', 'cobiscorp.ecobis.systemconfiguration.service.IParameterManagement', 'parameterManagement', '', 1579, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.OfficerManagement.SearchOfficer')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IOfficerManagement', csc_method_name = 'searchOfficer', csc_description = '', csc_trn = 15153, csc_procedure_validation = 'Y' WHERE csc_service_id = 'SystemConfiguration.OfficerManagement.SearchOfficer'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('SystemConfiguration.OfficerManagement.SearchOfficer', 'cobiscorp.ecobis.systemconfiguration.service.IOfficerManagement', 'searchOfficer', '', 15153, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.OfficeManagement.SearchCity')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', csc_method_name = 'searchCity', csc_description = '', csc_trn = 1562, csc_procedure_validation = 'Y' WHERE csc_service_id = 'SystemConfiguration.OfficeManagement.SearchCity'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('SystemConfiguration.OfficeManagement.SearchCity', 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', 'searchCity', '', 1562, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.BranchManagement.ReadBranch')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IBranchManagement', csc_method_name = 'readBranch', csc_description = '', csc_trn = 1569, csc_procedure_validation = 'Y' WHERE csc_service_id = 'SystemConfiguration.BranchManagement.ReadBranch'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('SystemConfiguration.BranchManagement.ReadBranch', 'cobiscorp.ecobis.systemconfiguration.service.IBranchManagement', 'readBranch', '', 1569, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.ParameterManagement.ProcessDate')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IParameterManagement', csc_method_name = 'processDate', csc_description = '', csc_trn = 15168, csc_procedure_validation = 'Y' WHERE csc_service_id = 'SystemConfiguration.ParameterManagement.ProcessDate'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) VALUES ('SystemConfiguration.ParameterManagement.ProcessDate', 'cobiscorp.ecobis.systemconfiguration.service.IParameterManagement', 'processDate', '', 15168, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', csc_method_name = 'searchOfficeGeoreference', csc_description = '', csc_trn = 1573 WHERE csc_service_id = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('SystemConfiguration.OfficeManagement.SearchOfficeGeoreference', 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', 'searchOfficeGeoreference', '', 15388)
GO