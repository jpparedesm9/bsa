/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : NA
--Fecha                      : 03/08/2017
--Descripción del Problema   : Se requiere registrar un nuevo servicio
--Descripción de la Solución : Se registra el servicio
--Autor                      : Maria Jose Taco
--Instalador                 : service_autorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
/**********************************************************************************************************************/
use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

--UpdateCustomerMobile - Mobile
delete ad_servicio_autorizado where ts_servicio in ('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile')
insert into ad_servicio_autorizado
	(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--UpdateCustomerMobile - Mobile
delete cts_serv_catalog where csc_service_id in ('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomerMobile', '', 104, null, null, 'N')

go


    