use cobis
go

declare
@w_producto int,
@w_rol int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS'

delete cobis..ad_servicio_autorizado where ts_servicio IN ('IndividualLoan.OnBoarding.CreateLifeInsurance') AND ts_rol= @w_rol
delete cobis..cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.OnBoarding.CreateLifeInsurance'
go