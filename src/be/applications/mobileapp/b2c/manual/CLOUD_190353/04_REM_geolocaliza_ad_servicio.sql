
use cobis
go

DECLARE
	@w_rol_admin			INT,
	@w_rol_menu_procesos	INT,
	@w_rol_corresponsal		INT,	
    @w_producto				INT,
	@w_moneda               INT

SELECT @w_rol_admin = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'ADMINISTRADOR'
SELECT @w_rol_menu_procesos = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'MENU POR PROCESOS'
SELECT @w_rol_corresponsal = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'CORRESPONSAL NO BANCARIO'
SELECT @w_producto = pd_producto FROM cl_producto WHERE pd_abreviatura = 'CRE'  -- CREDITO
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

select * from cts_serv_catalog where csc_service_id = 'BusinessToConsumer.BankGeolocation.InsertBankGeolocation'
select * from ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.BankGeolocation.InsertBankGeolocation'
and ts_rol = @w_rol_menu_procesos and ts_producto = @w_producto

delete cts_serv_catalog where csc_service_id = 'BusinessToConsumer.BankGeolocation.InsertBankGeolocation'

delete ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.BankGeolocation.InsertBankGeolocation'
and ts_rol = @w_rol_menu_procesos and ts_producto = @w_producto

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('BusinessToConsumer.BankGeolocation.InsertBankGeolocation', 'cobiscorp.ecobis.businesstoconsumer.service.IBankGeolocation', 'insertBankGeolocation', 'Servicio de Onboarding', NULL, 'N')

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.BankGeolocation.InsertBankGeolocation', @w_rol_menu_procesos, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

select * from cts_serv_catalog where csc_service_id = 'BusinessToConsumer.BankGeolocation.InsertBankGeolocation'
select * from ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.BankGeolocation.InsertBankGeolocation'
and ts_rol = @w_rol_menu_procesos and ts_producto = @w_producto

go
