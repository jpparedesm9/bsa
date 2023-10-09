--------------
--CASO 110637 
--------------
use cob_cartera
go

--Actualizar las oficinas que estan en 9001 y 9002
UPDATE cob_cartera..ca_transaccion 
SET tr_ofi_usu = tr_ofi_oper 	
WHERE tr_ofi_usu IN (9002, 9001) 
AND tr_estado = 'ING'

go

