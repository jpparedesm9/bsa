---------------
--CASO 111371
---------------

use cob_cartera
go
--Actualizar a GAR_DEB todos los prestamos que estan en GAR_CRE
UPDATE cob_cartera..ca_det_trn 
SET	dtr_concepto = 'GAR_DEB', 
	dtr_codvalor = 132
FROM cob_cartera..ca_transaccion	
WHERE tr_operacion = dtr_operacion	
AND tr_secuencial = dtr_secuencial	
AND tr_estado = 'ING' 	
AND tr_secuencial < 0	
AND dtr_concepto = 'GAR_CRE'

go


