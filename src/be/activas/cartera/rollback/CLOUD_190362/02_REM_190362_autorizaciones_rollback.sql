--Requerimiento #190362 Impresion de Ficha PI
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cobis
go

declare 
@w_rol_1 int

select @w_rol_1 = ro_rol from ad_rol where ro_descripcion='CONSULTA' 

--ReadCorresponsalPaymentInd --Requerimiento #190362 Impresion de Ficha PI
delete from cobis..cts_serv_catalog where csc_service_id='Loan.LoanMaintenance.ReadCorresponsalPaymentInd'

delete from ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.ReadCorresponsalPaymentInd' and ts_rol = @w_rol_1

go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
