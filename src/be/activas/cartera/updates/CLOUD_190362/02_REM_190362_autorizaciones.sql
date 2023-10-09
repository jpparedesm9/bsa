--Requerimiento #190362 Impresion de Ficha PI
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cobis
go

declare 
@w_rol_1 int,
@w_producto int

select @w_rol_1 = ro_rol from ad_rol where ro_descripcion='CONSULTA' 

select @w_producto = pd_producto from cobis..cl_producto 
where pd_descripcion = 'CARTERA'

--ReadCorresponsalPaymentInd --Requerimiento #190362 Impresion de Ficha PI
delete from cobis..cts_serv_catalog where csc_service_id='Loan.LoanMaintenance.ReadCorresponsalPaymentInd'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoanMaintenance.ReadCorresponsalPaymentInd', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance','readCorresponsalPaymentInd','datos para generacion del reporte ficha pago individual',0)

delete from ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.ReadCorresponsalPaymentInd' and ts_rol = @w_rol_1
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Loan.LoanMaintenance.ReadCorresponsalPaymentInd', @w_producto, 'R', 0, getdate(), @w_rol_1, 'V', getdate())

go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
