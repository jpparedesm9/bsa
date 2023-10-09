
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

select * from cts_serv_catalog where csc_service_id = 'BusinessToConsumer.BankGeolocation.InsertBankGeolocation'
select * from ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.BankGeolocation.InsertBankGeolocation'
and ts_rol = @w_rol_menu_procesos and ts_producto = @w_producto

go
