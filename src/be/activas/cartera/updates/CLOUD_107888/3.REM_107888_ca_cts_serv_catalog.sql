/*************************************************************************/
/*   Archivo:              REM_107888_ca_cts_serv_catalog.sql			 */
/*   Stored procedure:     REM_107888_ca_cts_serv_catalog.sql			 */
/*   Base de datos:        cobis		                               	 */
/*   Producto:             cartera                                  	 */
/*   Disenado por:         jlsdv                                         */
/*   Fecha de escritura:   Marzo 2019                                  	 */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   	Script para la creacion del servicio cts para el caso #107888  	 */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    27/Marzo/2019       	Jose Sánchez          Emision inicial        */
/*                                                                       */
/*************************************************************************/
USE cobis
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.ConciliationManagement.SearchMinorDateNotConciled')
	UPDATE cts_serv_catalog 
		SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 
			csc_method_name = 'searchMinorDateNotConciled', 
			csc_description = '', 
			csc_trn = 7316 
		WHERE csc_service_id = 'Loan.ConciliationManagement.SearchMinorDateNotConciled'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		VALUES ('Loan.ConciliationManagement.SearchMinorDateNotConciled', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'searchMinorDateNotConciled', '', 7316)
GO
    
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.ConciliationManagement.SearchConciliationByFilters')
	UPDATE cts_serv_catalog 
		SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 
			csc_method_name = 'searchConciliationByFilters', 
			csc_description = '', 
			csc_trn = 7316 
	WHERE csc_service_id = 'Loan.ConciliationManagement.SearchConciliationByFilters'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		VALUES ('Loan.ConciliationManagement.SearchConciliationByFilters', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'searchConciliationByFilters', '', 7316)
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.ConciliationManagement.ApplyOperationManualConciliation')
	UPDATE cts_serv_catalog 
		SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 
			csc_method_name = 'applyOperationManualConciliation', 
			csc_description = '', 
			csc_trn = 7317 
		WHERE csc_service_id = 'Loan.ConciliationManagement.ApplyOperationManualConciliation'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		VALUES ('Loan.ConciliationManagement.ApplyOperationManualConciliation', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'applyOperationManualConciliation', '', 7317)
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.ConciliationManagement.ApplyConcilationAutomatic')
   UPDATE cts_serv_catalog 
      SET 
         csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 
	     csc_method_name = 'applyConcilationAutomatic',
		 csc_description = '', 
		 csc_trn = 7318 
	  WHERE csc_service_id = 'Loan.ConciliationManagement.ApplyConcilationAutomatic'
ELSE
   INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
      VALUES ('Loan.ConciliationManagement.ApplyConcilationAutomatic', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'applyConcilationAutomatic', '', 7318)
GO

---------- 
DECLARE 
@w_ts_rol      int,
@w_ts_producto int

-- Obtiene el id del rol de operaciones
SELECT @w_ts_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'OPERACIONES'

-- Obtiene el id del producto 'Cartera'
SELECT @w_ts_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA'

---------
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'Loan.ConciliationManagement.SearchMinorDateNotConciled')
	UPDATE ad_servicio_autorizado 
		SET ts_rol			 = @w_ts_rol,
			ts_producto		 = @w_ts_producto,
			ts_fecha_aut	 = GETDATE(),
			ts_fecha_ult_mod = GETDATE()
	WHERE ts_servicio = 'Loan.ConciliationManagement.SearchMinorDateNotConciled'
ELSE 
	INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
		VALUES ('Loan.ConciliationManagement.SearchMinorDateNotConciled', @w_ts_rol, @w_ts_producto, 'R', 0, GETDATE(), 'V', GETDATE())

---------
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'Loan.ConciliationManagement.SearchConciliationByFilters')
	UPDATE ad_servicio_autorizado 
		SET ts_rol			 = @w_ts_rol,
			ts_producto		 = @w_ts_producto,
			ts_fecha_aut	 = GETDATE(),
			ts_fecha_ult_mod = GETDATE()
	WHERE ts_servicio = 'Loan.ConciliationManagement.SearchConciliationByFilters'
ELSE 
	INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
		VALUES ('Loan.ConciliationManagement.SearchConciliationByFilters', @w_ts_rol, @w_ts_producto, 'R', 0, GETDATE(), 'V', GETDATE())

---------
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'Loan.ConciliationManagement.ApplyOperationManualConciliation')
	UPDATE ad_servicio_autorizado 
		SET ts_rol			 = @w_ts_rol,
			ts_producto		 = @w_ts_producto,
			ts_fecha_aut	 = GETDATE(),
			ts_fecha_ult_mod = GETDATE()
	WHERE ts_servicio = 'Loan.ConciliationManagement.ApplyOperationManualConciliation'
ELSE 
	INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
		VALUES ('Loan.ConciliationManagement.ApplyOperationManualConciliation', @w_ts_rol, @w_ts_producto, 'R', 0, GETDATE(), 'V', GETDATE())
----
    
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'Loan.ConciliationManagement.ApplyConcilationAutomatic')
	UPDATE ad_servicio_autorizado 
		SET ts_rol			 = @w_ts_rol,
			ts_producto		 = @w_ts_producto,
			ts_fecha_aut	 = GETDATE(),
			ts_fecha_ult_mod = GETDATE()
	WHERE ts_servicio = 'Loan.ConciliationManagement.ApplyConcilationAutomatic'
ELSE 
	INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
		VALUES ('Loan.ConciliationManagement.ApplyConcilationAutomatic', @w_ts_rol, @w_ts_producto, 'R', 0, GETDATE(), 'V', GETDATE())
GO

GO