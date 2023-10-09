
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S123366 Validaciones Estado de Clientes y Solicitud IND
--Fecha                      : 24/07/2017
--Descripción del Problema   : Se requiere registrar un nuevo servicio
--Descripción de la Solución : Se registra el servicio
--Autor                      : Santiago Mosquera
--Instalador                 : service_autorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
/**********************************************************************************************************************/
use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'


--UpdateEconomicInformation - Mobile
delete ad_servicio_autorizado where ts_servicio in ('CustomerDataManagementService.CustomerManagement.UpdateEconomicInformation')
insert into ad_servicio_autorizado
	(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateEconomicInformation', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())



--UpdateEconomicInformation - Mobile
delete cts_serv_catalog where csc_service_id in ('CustomerDataManagementService.CustomerManagement.UpdateEconomicInformation')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.UpdateEconomicInformation', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateEconomicInformation', '', 104, null, null, 'N')



delete cts_serv_catalog
where csc_service_id in ('CustomerDataManagementService.CustomerManagement.FindPostalCode')

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.FindPostalCode', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'findPostalCode', '', 0, NULL, NULL, NULL)

--FindPostalCode
delete ad_servicio_autorizado
where ts_servicio in ('CustomerDataManagementService.CustomerManagement.FindPostalCode')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.FindPostalCode', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())
