use cob_cartera 
go 


update ca_corresponsal_trn set 
co_estado    = 'E',
co_error_id  = 2101011,
co_error_msg = 'NO EXISTE TRAMITE INGRESADO PARA EL GRUPO: 418'
where co_secuencial = 12336


go



