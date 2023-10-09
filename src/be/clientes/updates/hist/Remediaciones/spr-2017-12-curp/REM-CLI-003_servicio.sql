/**********************************************************************************************************************/
--No Bug                                : NA
--Título de la Historia           : CGS-R117762 Cambio en Direcciones
--Fecha                                      : 20/06/2017
--Descripción del Problema   : nueva funcionalidad
--Descripción de la Solución : Registrar el servicio de la busqueda de codigo postal
--Autor                      : Maria Jose Taco
--Instalador                 : cl_services_authorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

use cobis
go

declare @w_rol int,
        @w_producto int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


delete cts_serv_catalog where csc_service_id in ('CustomerDataManagementService.CustomerManagement.SearchZipPostal')
delete ad_servicio_autorizado where ts_servicio in ('CustomerDataManagementService.CustomerManagement.SearchZipPostal')

insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchZipPostal',  'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchZipPostal', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchZipPostal', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
