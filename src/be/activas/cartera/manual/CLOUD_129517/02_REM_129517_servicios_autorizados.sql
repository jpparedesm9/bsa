use cobis
go

-------------------------------------------
--- SERVICIO GENERIC PAYMENT SLIP     -----
-------------------------------------------
declare 
@w_producto              int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'CARTERA'

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'FUNCIONARIO OFICINA',
'ASESOR'
)

delete cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.PdfGenericPaymentSlip'

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('Loan.LoanMaintenance.PdfGenericPaymentSlip', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'pdfGenericPaymentSlip', '', 0)

delete ad_servicio_autorizado  where ts_servicio = 'Loan.LoanMaintenance.PdfGenericPaymentSlip'

insert into ad_servicio_autorizado 
select 'Loan.LoanMaintenance.PdfGenericPaymentSlip',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from @w_roles
go

    