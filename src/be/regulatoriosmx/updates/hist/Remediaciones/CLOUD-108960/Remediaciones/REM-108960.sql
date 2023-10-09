--Remediacion caso 108960
--Cambio de cuenta en cliente 5137 - GENILU MIRANDA PARRA

DECLARE @w_cliente INT
SELECT @w_cliente = 5137

UPDATE cobis..cl_ente_aux 
SET ea_cta_banco = '60606349650'
WHERE ea_ente = @w_cliente

UPDATE cob_cartera..ca_operacion 
SET op_cuenta = '60606349650'
WHERE op_cliente= @w_cliente

go


