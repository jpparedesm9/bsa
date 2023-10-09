/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-R117557 Modificaciones - Demo 1
--Fecha                      : 22/06/2017
--Descripción del Problema   : Agregado de servicio Ingexistente
--Descripción de la Solución : Agregado el servicio
--Autor                      : Paúl Ortiz Vera
--Instalador                 : service_authorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
/**********************************************************************************************************************/




use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

--cts_serv_catalog

   -- Carga de usuario login  SearchOfficer
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'SystemConfiguration.OfficerManagement.SearchOfficer')
    insert into cts_serv_catalog 
	(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	values ('SystemConfiguration.OfficerManagement.SearchOfficer','cobiscorp.ecobis.systemconfiguration.service.IOfficerManagement','searchOfficer', '',15153, null, null, null)

   
   
-------------------------
--ad_servicio_autorizado
-------------------------
	-- Carga de usuario login SearchOfficer
	
	if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'SystemConfiguration.OfficerManagement.SearchOfficer'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('SystemConfiguration.OfficerManagement.SearchOfficer', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

go