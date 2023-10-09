USE cobis 
GO
--rollback
delete cobis..ad_tr_autorizada where ta_transaccion  IN( 21367,21369,21370)  -- posiblemente no
delete cobis..ad_pro_transaccion where pt_procedure  IN( 21367,21369,21370)  and pt_transaccion  IN( 21367,21369,21370) 
delete cobis..cl_ttransaccion where tn_trn_code  IN( 21367,21369,21370) 
delete cobis..ad_procedure where pd_procedure  IN( 21367,21369,21370) 

SELECT * FROM cobis..ad_procedure
 where pd_procedure IN( 21367,21369,21370)  
 and pd_base_datos = 'cob_credito'

SELECT * FROM cobis..cl_ttransaccion
 where tn_trn_code  IN( 21367,21369,21370)

SELECT * FROM cobis..ad_pro_transaccion 
where pt_procedure  IN( 21367,21369,21370) 
and pt_transaccion  IN( 21367,21369,21370)

SELECT * FROM cobis..ad_tr_autorizada
where ta_transaccion  IN( 21367,21369,21370)
 
go