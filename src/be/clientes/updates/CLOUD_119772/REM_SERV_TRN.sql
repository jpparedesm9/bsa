

use cobis
go

declare 
@w_producto          int,
@w_rol               int


SELECT @w_producto = pd_producto 
FROM cl_producto 
WHERE pd_descripcion = 'CARTERA'

select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='MESA DE OPERACIONES' 

if @w_rol is null    select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'

delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.ProcessCollectiveEntity'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('Collective.CollectiveEntity.ProcessCollectiveEntity', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'processCollectiveEntity', '', 0)
	
delete from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.ProcessCollectiveEntity' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Collective.CollectiveEntity.ProcessCollectiveEntity', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


SELECT @w_producto = pd_producto 
FROM cl_producto 
WHERE pd_descripcion = 'CREDITO'

select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ADMINISTRADOR' 

delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values ('OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateBuroFromSantander', 'validateBuroFromSantander', NULL, 'N')
	
delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())



delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values ('OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateAccountAndBucFromSantander', 'validateAccountAndBucFromSantander', NULL, 'N')
	
delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())




SELECT @w_producto = pd_producto 
FROM cl_producto 
WHERE pd_descripcion = 'CREDITO'

select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

if @w_rol is null    select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'

delete from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values ('CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCollectiveCustomer', 'updateCollectiveCustomer', NULL, 'N')
	
delete from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


----servivio¨Pantalla masiva de alta Asesores

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA'


if @w_rol is null    select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryCollective'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation )  
VALUES ('Collective.CollectiveEntity.QueryCollective', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'queryCollective','queryCollective', null, 'N')
   
delete cobis..ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryCollective'
insert into cobis..ad_servicio_autorizado values('Collective.CollectiveEntity.QueryCollective', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.ProcessAsesorEntity'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values (
'Collective.CollectiveEntity.ProcessAsesorEntity','cobiscorp.ecobis.collective.service.ICollectiveEntity', 'processAsesorEntity', 
'processAsesorEntity', NULL, 'N')

delete cobis..ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.ProcessAsesorEntity'
insert into cobis..ad_servicio_autorizado values('Collective.CollectiveEntity.ProcessAsesorEntity', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-- servicios Pantalla Rol Asesor Colectivo
-- Rol MESA DE OPERACIONES
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA'

if @w_rol is not null
begin
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryAdvisorRole')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('Collective.CollectiveEntity.QueryAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'queryAdvisorRole', '', 1720)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryAdvisorRole' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('Collective.CollectiveEntity.QueryAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryOfficialByRole')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('Collective.CollectiveEntity.QueryOfficialByRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'queryOfficialByRole', '', 1720)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryOfficialByRole' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('Collective.CollectiveEntity.QueryOfficialByRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.InsertAdvisorRole')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('Collective.CollectiveEntity.InsertAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'insertAdvisorRole', '', 1720)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.InsertAdvisorRole' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('Collective.CollectiveEntity.InsertAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.DeleteAdvisorRole')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('Collective.CollectiveEntity.DeleteAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'deleteAdvisorRole', '', 1720)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.DeleteAdvisorRole' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('Collective.CollectiveEntity.DeleteAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICollectiveManagement', 'queryCollectiveByVirtualDirection', '', 1140)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
end
else
begin
	print 'Rol MESA DE OPERACIONES no existe'
end

-- Rol ADMINISTRADOR
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'

if @w_rol is not null
begin
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryAdvisorRole')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('Collective.CollectiveEntity.QueryAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'queryAdvisorRole', '', 1720)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryAdvisorRole' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('Collective.CollectiveEntity.QueryAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryOfficialByRole')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('Collective.CollectiveEntity.QueryOfficialByRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'queryOfficialByRole', '', 1720)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryOfficialByRole' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('Collective.CollectiveEntity.QueryOfficialByRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.InsertAdvisorRole')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('Collective.CollectiveEntity.InsertAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'insertAdvisorRole', '', 1720)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.InsertAdvisorRole' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('Collective.CollectiveEntity.InsertAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.DeleteAdvisorRole')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('Collective.CollectiveEntity.DeleteAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'deleteAdvisorRole', '', 1720)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.DeleteAdvisorRole' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('Collective.CollectiveEntity.DeleteAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection')
	begin
		insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
		values ('CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICollectiveManagement', 'queryCollectiveByVirtualDirection', '', 1140)
	end
	if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection' and ts_rol = @w_rol)
	begin
		insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
		values('CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
	end
	
end
else
begin
	print 'Rol ADMINISTRADOR no existe'
end


go
---------------------------------------------------
---------- JOBS COLECTIVOS ------------------------
---------------------------------------------------
use cobis
go


declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int



select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'CREDITO'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'SCHEDULER CTS'

---------------------------------------------------------
----- TRANSACCIÓN CUENTA Y BUC SANTANDER JOB-------------
----------------------------------------------------------
select
@w_tn_trn_code  = 211000,
@w_pd_procedure = 211000
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'CUENTA BUC JOB SCHEDULER'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'CUENTA BUC JOB SCHEDULER', @w_tn_trn_code, 'CUENTA BUC JOB SCHEDULER')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_santander_cuenta_buc_job' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_santander_cuenta_buc_job', 'cob_credito', 'V', getdate(), 'crctabucjob.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())


---------------------------------------
----- TRANSACCIÓN BURO JOB-------------
---------------------------------------
select
@w_tn_trn_code  = 211001,
@w_pd_procedure = 211001


delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'BURO JOB SCHEDULER'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'BURO JOB SCHEDULER', @w_tn_trn_code, 'BURO JOB SCHEDULER')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_buro_ln_nf_job' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_buro_ln_nf_job', 'cob_credito', 'V', getdate(), 'crburojob.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

---------------------------------------------------
------ ACTUALIZACION CLIENTE COLECTIVO ------------
---------------------------------------------------

select
@w_tn_trn_code  = 1720,
@w_pd_procedure = 1720


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'ASESOR MOVIL' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='ACTUALIZACION CLIENTE COLECTIVO'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'ACTUALIZACION CLIENTE COLECTIVO', @w_tn_trn_code, 'ACTUALIZACION CLIENTE COLECTIVO')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_cliente_col_upd' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_cliente_col_upd', 'cobis', 'V', getdate(), 'clicolupd.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())
                                       
GO


-------------------------------------------------------------------
-- an_component: Pantalla Documentos Digitalizados LCR Colectivo
-------------------------------------------------------------------
use cobis 
go

declare 
@w_co_id         int,
@w_co_mo_id      int

delete an_component where co_name = 'Documentos Digitalizados - Consulta Colectivo'

select @w_co_id = isnull(max(co_id), 0)+1
from an_component

select @w_co_mo_id = mo_id
from an_module
where mo_name = 'IBX.InboxOficial'

INSERT INTO dbo.an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_co_id, @w_co_mo_id, 'Documentos Digitalizados - Consulta Colectivo', 'VC_SCANNEDDMO_244525_TASK.html?SOLICITUD=COLECTIVOS&MODE=Q', 'views/CSTMR/CSTMR/T_CSTMRNSVOOQTG_525/1.0.0/', 'I', NULL, 'WF')
go
