use cob_cartera
go

select *
from ca_corresponsal_trn
where co_referencia = '233450017279'
and  co_secuencial = 61612


update  ca_corresponsal_trn
set   co_estado     = 'I',
      co_error_id   = null,
      co_error_msg  = null
where co_referencia = '233450017279'
and   co_secuencial = 61612

select *
from ca_corresponsal_trn
where co_referencia = '233450017279'
and  co_secuencial = 61612

go

exec cob_cartera..sp_pagos_corresponsal_batch 
@i_param1  = 'B'
go




