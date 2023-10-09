use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS'
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--Inserta en la tabla el servicio realizado ReadDisbursementFormSearch
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin','cobiscorp.ecobis.loan.service.IReadDisbursementForm','readDisbursementFormSearch','readDisbursementFormSearch',7032)

delete from ad_servicio_autorizado where ts_servicio = 'Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values(
'Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


--Inserta en la tabla el servicio realizado ReadDisbursementFormSearch
delete from cobis..cts_serv_catalog where csc_service_id='Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin','cobiscorp.ecobis.businessprocess.creditmanagement.service.ILineOpCurrency','getQuoteBusin','getQuoteBusin',7032)

delete from ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values(
'Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())



