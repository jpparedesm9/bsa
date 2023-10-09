use cobis
go

if not exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'FPM.Administration.IsDynamicAPF')
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_procedure_validation, csc_component) 
values ('FPM.Administration.IsDynamicAPF','com.cobiscorp.ecobis.fpm.administration.service.INodeProductManager','isDynamicAPFConfiguration','Verifica si existen pantallas renderizadas en el APF',null,null,null,null)

if not exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'Busin.Service.GetCatalogByStoredProcedure')
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_procedure_validation, csc_component) 
values ('Busin.Service.GetCatalogByStoredProcedure','com.cobiscorp.ecobis.busin.service.IQueryStoredProcedure','getCatalogByStoredProcedure','getCatalogByStoredProcedure',null,null,null,null)

if not exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'Remittance.RemittanceService.QueryRemittanceByClient')
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_procedure_validation, csc_component) 
values ('Remittance.RemittanceService.QueryRemittanceByClient','cobiscorp.ecobis.remittance.service.IRemittanceService','queryRemittanceByClient','queryRemittanceByClient',null,null,null,null)

if not exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'Remittance.RemittanceService.GroupRemittanceByClient')
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_procedure_validation, csc_component) 
values ('Remittance.RemittanceService.GroupRemittanceByClient','cobiscorp.ecobis.remittance.service.IRemittanceService','groupRemittanceByClient','groupRemittanceByClient',null,null,null,null)

declare @w_rol int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'FPM.Administration.IsDynamicAPF')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('FPM.Administration.IsDynamicAPF',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Busin.Service.GetCatalogByStoredProcedure')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Busin.Service.GetCatalogByStoredProcedure',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Remittance.RemittanceService.QueryRemittanceByClient')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Remittance.RemittanceService.QueryRemittanceByClient',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Remittance.RemittanceService.GroupRemittanceByClient')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Remittance.RemittanceService.GroupRemittanceByClient',@w_rol,1,'R',0,getdate(),'V',getdate())
