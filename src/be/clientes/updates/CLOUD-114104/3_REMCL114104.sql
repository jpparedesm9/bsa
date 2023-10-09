/**********************************************************************************************************************/
--Título Incidencia          : Error #114599: Sistema permite generar solicitudes de credito revolvente a grupos
--Fecha                      : 19/03/2019
--Descripción del Problema   : No existe error
--Descripción de la Solución : Agregar error
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR ERRORES
--------------------------------------------------------------------------------------------
use cobis
go

delete cobis..cl_errores where numero in (103176, 103177, 103196, 103198, 103160)

insert into cobis..cl_errores values (103176, 0, 'Error al iniciar el flujo, el solicitante no es un Grupo.')
insert into cobis..cl_errores values (103177, 0, 'Error al iniciar el flujo, el solicitante debe ser Persona Natural.')
insert into cobis..cl_errores values (103196, 0, 'Error, el cliente tiene un trámite en ejecución.')
insert into cobis..cl_errores values (103198, 0, 'La solicitud tiene un oficial diferente al del cliente.')
insert into cobis..cl_errores values (103160, 0, 'El cliente tiene una operación activa.')

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------
use cobis
go

delete cl_parametro where pa_nemonico = 'HPWA' and pa_producto = 'CWF'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('HISTORICOS POLITICAS WORKFLOW NO ACTIVOS', 'HPWA', 'C', 'S', null, null, null, null, null, null, 'CWF')

--------------------------------------------------------------------------------------------
-- AGREGAR AUTORIZACION DE SERVICIO
--------------------------------------------------------------------------------------------
use cobis
go

if exists (select * from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual')
	update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', csc_method_name = 'createApplicationIndividual', csc_description = '', csc_trn = 77100 where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual'
else
	insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'createApplicationIndividual', '', 77100)
go

if exists (select * from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual')
	update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', csc_method_name = 'updateApplicationIndividual', csc_description = '', csc_trn = 77300 where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual'
else
	insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'updateApplicationIndividual', '', 77300)
go

declare @w_rol int, @w_producto int

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual'
	insert into cobis..ad_servicio_autorizado values('Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado ADMINISTRADOR'
end
if exists(select 1 from cobis..ad_rol where ro_descripcion = 'ASESOR')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual'
	insert into cobis..ad_servicio_autorizado values('Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado ASESOR'
end


if exists(select 1 from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual'
	insert into cobis..ad_servicio_autorizado values('Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado ADMINISTRADOR'
end
if exists(select 1 from cobis..ad_rol where ro_descripcion = 'ASESOR')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual'
	insert into cobis..ad_servicio_autorizado values('Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado ASESOR'
end

