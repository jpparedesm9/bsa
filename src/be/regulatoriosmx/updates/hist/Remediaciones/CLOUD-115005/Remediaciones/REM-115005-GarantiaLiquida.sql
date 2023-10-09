--Remediacion caso 115005
--Grupo 3776
use cob_cartera
go

SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 3776 )

 
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3776
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'

exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B'



SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 3776 )

go


