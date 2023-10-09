/* ******************************************************** */
/* ************* Service Operations Script **************** */
/* ******************************************************** */
/*   This code was generated by CEN-SG.                     */
/*   Changes to this file may cause incorrect behavior      */
/*   and will be lost if the code is regenerated.           */
/* ******************************************************** */

use cobis
GO

--------------------------
-- searchSegment
--------------------------
DELETE cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchSegment'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchSegment', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IPortfolioCatalogQuery', 'searchSegment', '', 7856)
GO

DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchSegment'
INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchSegment', 7, 'R', 0, getdate(), 3, 'V', getdate())
GO

--------------------------
-- SearchDestinationActivity
--------------------------
DELETE cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchDestinationActivity'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchDestinationActivity', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IPortfolioCatalogQuery', 'searchFinancialDestination', '', 7412)
GO

DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchDestinationActivity'
INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchDestinationActivity', 7, 'R', 0, getdate(), 3, 'V', getdate())
GO

--------------------------
-- searchEconomicActivity
--------------------------
DELETE cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchEconomicActivity'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchEconomicActivity', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IPortfolioCatalogQuery', 'searchEconomicActivity', '', 7412)
GO

DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchEconomicActivity'
INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.PortfolioCatalogQuery.SearchEconomicActivity', 7, 'R', 0, getdate(), 3, 'V', getdate())
GO

--------------------------
-- CreateNewApplication
--------------------------
DELETE cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'createNewApplication', '', 77100)
GO

DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication'
INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication', 7, 'R', 0, getdate(), 3, 'V', getdate())
GO

--------------------------
-- ReadNewApplication
--------------------------
DELETE cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationQuery', 'readNewApplication', '', 77200)
GO

DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication'
INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication', 7, 'R', 0, getdate(), 3, 'V', getdate())
GO

--------------------------
-- UpdateNewApplication
--------------------------
DELETE cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'updateNewApplication', '', 77300)
GO

DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication'
INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication', 7, 'R', 0, getdate(), 3, 'V', getdate())
GO

--------------------------
-- RejectTransact
--------------------------
DELETE cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.RejectTransact'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.RejectTransact', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'rejectTransact', '', 77400)
GO

DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.RejectTransact'
INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.RejectTransact', 7, 'R', 0, getdate(), 3, 'V', getdate())
GO

--------------------------
-- RoutingOperation
--------------------------
DELETE cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.RoutingOperation'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.RoutingOperation', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'routingOperation', '', 77500)
GO

DELETE cobis..ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.RoutingOperation'
INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.RoutingOperation', 7, 'R', 0, getdate(), 3, 'V', getdate())
GO