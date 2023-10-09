use cob_cartera 
go 


update ca_corresponsal_trn set 
co_estado    = 'I',
co_error_id  = null,
co_error_msg = null
where co_secuencial = 12336


go
