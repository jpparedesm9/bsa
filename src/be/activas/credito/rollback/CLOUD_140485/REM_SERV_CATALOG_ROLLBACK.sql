use cobis
go

declare 
@w_tn_trn_code           int,
@w_pd_procedure          int

select 
@w_tn_trn_code  = 18001,
@w_pd_procedure = 18001

delete cts_serv_catalog where csc_service_id = 'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount'
delete ad_servicio_autorizado  where ts_servicio = 'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount'
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code 
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure 
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code 

go