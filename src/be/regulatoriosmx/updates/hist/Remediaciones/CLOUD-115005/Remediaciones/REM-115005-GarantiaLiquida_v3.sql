--Remediacion caso 115005
--Grupo 2425
use cob_cartera
go

SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 2425 )

 
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 2425
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/22/2019'


exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B'



SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 2425 )

go


