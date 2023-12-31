/************************************************************/
/*******************Service Operations Script*********************/
/************************************************************/
/*   This code was generated by CEN-SG.                     */
/*   Changes to this file may cause incorrect behavior      */
/*   and will be lost if the code is regenerated.           */
/************************************************************/

use cobis
GO

--SearchRejectedDispersions

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.RejectedDispersions.SearchRejectedDispersions')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.IRejectedDispersions', csc_method_name = 'searchRejectedDispersions', csc_description = '', csc_trn = 77502, csc_procedure_validation = 'Y' WHERE csc_service_id = 'Loan.RejectedDispersions.SearchRejectedDispersions'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('Loan.RejectedDispersions.SearchRejectedDispersions', 'cobiscorp.ecobis.assets.cloud.service.IRejectedDispersions', 'searchRejectedDispersions', '', 77502, 'Y')
GO


DECLARE @rol int, @w_producto int
SELECT @rol = ro_rol from cobis..ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA'
SELECT @w_producto = 7 -- select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.RejectedDispersions.SearchRejectedDispersions' AND ts_rol = @rol)
    INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
        VALUES ('Loan.RejectedDispersions.SearchRejectedDispersions', @rol, 7, 'R', 0, getdate(), 'V', getdate())


--DispersionActions

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.RejectedDispersions.DispersionActions')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.IRejectedDispersions', csc_method_name = 'dispersionActions', csc_description = '', csc_trn = 77503, csc_procedure_validation = 'Y' WHERE csc_service_id = 'Loan.RejectedDispersions.DispersionActions'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('Loan.RejectedDispersions.DispersionActions', 'cobiscorp.ecobis.assets.cloud.service.IRejectedDispersions', 'dispersionActions', '', 77503, 'Y')
GO

-- Servicios Autorizados

DECLARE @rol int, @w_producto int
SELECT @rol = ro_rol from cobis..ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA'
SELECT @w_producto = 7 -- select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.RejectedDispersions.DispersionActions' AND ts_rol = @rol)
    INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
        VALUES ('Loan.RejectedDispersions.DispersionActions', @rol, 7, 'R', 0, getdate(), 'V', getdate())