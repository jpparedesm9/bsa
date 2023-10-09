--SCRIPT DE ACTUALIZACION DE SECUENCIAL REF

use cob_cartera 
go 

update ca_transaccion set 
tr_secuencial_ref = tr_secuencial 
where tr_tran  = 'DES'
and tr_toperacion = 'REVOLVENTE'

go