
use cobis
go

declare 
@w_tn_trn_code      int,
@w_pd_procedure     int


delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.ProcessCollectiveEntity'	
delete from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.ProcessCollectiveEntity'
delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander'	
delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander' 
delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander'
delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander' 
delete from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer'
delete from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer'

if exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryAdvisorRole')
begin
	delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryAdvisorRole'
end

if exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryAdvisorRole')
begin
	delete from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryAdvisorRole'
end

if exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryOfficialByRole')
begin
	delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryOfficialByRole'
end

if exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryAdvisorRole')
begin
	delete from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryOfficialByRole'
end

if exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.InsertAdvisorRole')
begin
	delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.InsertAdvisorRole'
end

if exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.InsertAdvisorRole')
begin
	delete from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.InsertAdvisorRole'
end

if exists (select 1 from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.DeleteAdvisorRole')
begin
	delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.DeleteAdvisorRole'
end

if exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.DeleteAdvisorRole')
begin
	delete from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.DeleteAdvisorRole'
end

if exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection')
begin
	delete from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection'
end

if exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection')
begin
	delete from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection'
end


select
@w_tn_trn_code  = 211000,
@w_pd_procedure = 211000

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'CUENTA BUC JOB SCHEDULER'
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_santander_cuenta_buc_job' 
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code 

select
@w_tn_trn_code  = 211001,
@w_pd_procedure = 211001


delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'BURO JOB SCHEDULER'
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_buro_ln_nf_job' 
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code

---------------------------------------------------
------ ACTUALIZACION CLIENTE COLECTIVO ------------
---------------------------------------------------

select
@w_tn_trn_code  = 1720,
@w_pd_procedure = 1720

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='ACTUALIZACION CLIENTE COLECTIVO'
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_cliente_col_upd' 
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code 
                                       
GO