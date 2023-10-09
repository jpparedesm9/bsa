---------------
--CASO 113430
---------------
use cobis
go
update cobis..cl_ente
set    p_sexo = 'F'
where en_ente = 1913
go

---------------
--CASO adicional
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

--Actualizar las oficinas que estan en 9001 y 9002
UPDATE cob_cartera..ca_transaccion SET tr_ofi_usu = tr_ofi_oper 	
WHERE tr_ofi_usu IN (9002, 9001) AND tr_estado = 'ING'	

go
