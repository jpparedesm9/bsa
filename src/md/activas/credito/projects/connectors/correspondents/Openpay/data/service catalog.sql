set nocount on
go
-- Script de instalacion de los servicios
use cobis
go


----------------------------------------------------------------------------------
-- Instalacion de: Loan.ConciliationManagement.RegisterLoanPayment
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'Loan.ConciliationManagement.RegisterLoanPayment')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'Loan.ConciliationManagement.RegisterLoanPayment'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'Loan.ConciliationManagement.RegisterLoanPayment')
   delete cobis..cts_serv_catalog where csc_service_id = 'Loan.ConciliationManagement.RegisterLoanPayment'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('Loan.ConciliationManagement.RegisterLoanPayment', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement',
       'registerLoanPayment',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('Loan.ConciliationManagement.RegisterLoanPayment',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('Loan.ConciliationManagement.RegisterLoanPayment',3,1,'R',0,getdate(),'V',getdate())


set nocount off
go
