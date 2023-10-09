

use cobis
go

declare 
@w_rol_1 int,
@w_producto int

select @w_rol_1 = ro_rol from ad_rol where ro_descripcion='CONSULTA' 

SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'


--SEARCH TRANSACTIONS
delete from cobis..cts_serv_catalog where csc_service_id='Loan.OperationDataQuery.SearchTransactions'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.SearchTransactions', 'cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','searchTransactions','recupera la información de transacciones',7020)



delete from ad_servicio_autorizado where ts_servicio = 'Loan.OperationDataQuery.SearchTransactions' and ts_rol = @w_rol_1
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Loan.OperationDataQuery.SearchTransactions', @w_producto, 'R', 0, getdate(), @w_rol_1, 'V', getdate())


--SEARCH TRANSACTION DETAIL
delete from cobis..cts_serv_catalog where csc_service_id='Loan.OperationDataQuery.SearchTransactionDetail'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.SearchTransactionDetail', 'cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','searchTransactionDetail','recupera el detalle de la transacción',7020)



delete from ad_servicio_autorizado where ts_servicio = 'Loan.OperationDataQuery.SearchTransactionDetail' and ts_rol = @w_rol_1
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Loan.OperationDataQuery.SearchTransactionDetail', @w_producto, 'R', 0, getdate(), @w_rol_1, 'V', getdate())


--ReadCorresponsalPayment
delete from cobis..cts_serv_catalog where csc_service_id='Loan.LoanMaintenance.ReadCorresponsalPayment'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoanMaintenance.ReadCorresponsalPayment', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance','readCorresponsalPayment','recupera los datos para generar el reporte CorresponsalPagos',0)



delete from ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.ReadCorresponsalPayment' and ts_rol = @w_rol_1
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Loan.LoanMaintenance.ReadCorresponsalPayment', @w_producto, 'R', 0, getdate(), @w_rol_1, 'V', getdate())


