use cobis
go

delete from cts_serv_catalog where csc_service_id in ('LoansBusiness.Insurance.GetClientInsurance', 'LoansBusiness.Insurance.MaintainInsurance')
delete from ad_servicio_autorizado where ts_servicio in ('LoansBusiness.Insurance.GetClientInsurance', 'LoansBusiness.Insurance.MaintainInsurance')

declare 
@w_trn      int   = 74011

if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = @w_trn ) 
	delete from cobis..ad_pro_transaccion where pt_transaccion = @w_trn  

if  exists (select 1 from cobis..cl_ttransaccion where tn_trn_code = @w_trn ) 
	delete from cobis..cl_ttransaccion where tn_trn_code = @w_trn  

if  exists (select 1 from cobis..ad_tr_autorizada where ta_transaccion = @w_trn) 
	delete from cobis..ad_tr_autorizada where ta_transaccion = @w_trn 

if  exists (select 1 from cobis..ad_procedure where pd_stored_procedure = 'sp_mantenimiento_seguros' and pd_procedure = @w_trn) 
   delete from cobis..ad_procedure where pd_stored_procedure = 'sp_mantenimiento_seguros' 


select  @w_trn  = 74012
if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = @w_trn ) 
	delete from cobis..ad_pro_transaccion where pt_transaccion = @w_trn  

if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = @w_trn ) 
	delete from cobis..cl_ttransaccion where tn_trn_code = @w_trn  

if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = @w_trn) 
	delete from cobis..ad_tr_autorizada where ta_transaccion = @w_trn 

if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_mantenimiento_seguros' and pd_procedure = @w_trn) 
	delete from cobis..ad_procedure where pd_stored_procedure = 'sp_mantenimiento_seguros' 


go