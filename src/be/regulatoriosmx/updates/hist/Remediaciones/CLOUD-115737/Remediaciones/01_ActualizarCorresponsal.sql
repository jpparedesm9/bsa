USE cob_cartera
GO

SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 2304 )


UPDATE ca_corresponsal_trn
SET    co_monto =  5770, 
       co_estado = 'I',
       co_error_id  = 0,  
       co_error_msg = ''
WHERE co_codigo_interno = 2304
AND   co_estado = 'E'
AND   co_tipo = 'GL'
AND   co_accion  = 'I'
AND   co_fecha_valor = '03/21/2019'


exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B',
     @i_ejecutar_fvalor = 'N'

GO



SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 2304 )


go
