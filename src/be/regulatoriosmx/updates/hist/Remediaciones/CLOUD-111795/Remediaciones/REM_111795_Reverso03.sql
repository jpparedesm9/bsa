USE cob_cartera
GO

UPDATE  ca_corresponsal_trn SET co_estado = 'I', co_error_id = 0, co_error_msg = ''
where co_codigo_interno =112994
AND co_estado IN('E','P')
AND co_accion = 'I'
AND co_tipo   = 'PG'
AND substring(co_referencia,1,2) = 'PG'


SELECT * from    ca_corresponsal_trn 
where co_codigo_interno =112994


	
DELETE    ca_corresponsal_det 
from    ca_corresponsal_trn 
where cd_secuencial = co_secuencial 
and co_codigo_interno =112994
AND co_estado ='I'
AND co_accion = 'I'
AND co_tipo   = 'PG' 



	
SELECT DISTINCT cd.* 
FROM    ca_corresponsal_det cd, 
    ca_corresponsal_trn 
where cd_secuencial = co_secuencial 
AND  co_codigo_interno =112994
AND co_estado ='I'
AND co_accion = 'I'
AND co_tipo   = 'PG' 


exec cob_cartera..sp_pagos_corresponsal_batch 
@i_param1  = 'B'
GO

