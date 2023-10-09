use cob_cartera
go

select   *
from cob_cartera..ca_corresponsal_trn
where co_fecha_proceso >= '01/06/2019'
and   co_tipo      = 'P'
and   co_archivo_ref is null


update cob_cartera..ca_corresponsal_trn
set co_tipo   = 'PG', 
    co_estado = 'I'
where co_fecha_proceso >= '01/06/2019'
and   co_tipo           = 'P'
and   co_archivo_ref is null


select *
from  cob_cartera..ca_corresponsal_trn
where co_fecha_proceso >= '01/06/2019'
and   co_tipo           = 'PG'
and   co_archivo_ref is null

go


exec cob_cartera..sp_pagos_corresponsal_batch 
@i_param1  = 'B'

go

select *
from  cob_cartera..ca_corresponsal_trn
where co_tipo           = 'P'

update cob_cartera..ca_corresponsal_trn
set co_tipo   = 'PG'
where co_tipo  = 'P'


select *
from  cob_cartera..ca_corresponsal_trn
where co_tipo           = 'PG'
