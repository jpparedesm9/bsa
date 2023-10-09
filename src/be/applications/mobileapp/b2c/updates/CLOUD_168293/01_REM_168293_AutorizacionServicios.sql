USE cobis
GO

DECLARE @w_rol INT, @w_producto int, @w_moneda tinyint

SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'MENU POR PROCESOS'
SELECT @w_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'BANCA VIRTUAL'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

-- ======================== IndividualLoan.OnBoarding.SimulationTableAmortization =====================================

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.OnBoarding.SimulationTableAmortization')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.individualloan.service.IOnBoarding', csc_method_name = 'simulationTableAmortization', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'IndividualLoan.OnBoarding.SimulationTableAmortization'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('IndividualLoan.OnBoarding.SimulationTableAmortization', 'cobiscorp.ecobis.individualloan.service.IOnBoarding', 'simulationTableAmortization', '', 0)

if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'IndividualLoan.OnBoarding.SimulationTableAmortization')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto = @w_producto , ts_tipo = 'R', ts_moneda = @w_moneda, ts_fecha_aut = getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'IndividualLoan.OnBoarding.SimulationTableAmortization'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('IndividualLoan.OnBoarding.SimulationTableAmortization', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate()) 


-- ======================== IndividualLoan.DisbursementManagement.DisbursementOperation =====================================
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.DisbursementManagement.DisbursementOperation')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.individualloan.service.IDisbursementManagement', csc_method_name = 'disbursementOperation', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'IndividualLoan.DisbursementManagement.DisbursementOperation'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('IndividualLoan.DisbursementManagement.DisbursementOperation', 'cobiscorp.ecobis.individualloan.service.IDisbursementManagement', 'disbursementOperation', '', 0)
      
if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'IndividualLoan.DisbursementManagement.DisbursementOperation')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto = @w_producto , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'IndividualLoan.OnBoarding.DisbursementOperation'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('IndividualLoan.DisbursementManagement.DisbursementOperation', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate()) 
GO