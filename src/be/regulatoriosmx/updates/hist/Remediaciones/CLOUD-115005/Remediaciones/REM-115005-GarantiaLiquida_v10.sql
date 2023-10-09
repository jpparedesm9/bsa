--Remediacion caso 115005

use cob_cartera
go

--Grupo 295
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 295
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go

--Grupo 3898
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3898
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'



exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B'



go


