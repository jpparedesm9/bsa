use cob_cartera
go


select grupo     = tg_grupo, 
       operacion = max(op_operacion),
       secuencial = convert(int,0)
into #operacion_grupales_act
from cob_cartera..ca_operacion,
     cob_credito..cr_tramite_grupal
where op_cliente in (7881)
and   op_estado  = 3
and   op_banco   = tg_referencia_grupal
and   op_cliente = tg_grupo
group by tg_grupo

update #operacion_grupales_act set 
secuencial = 449054
where grupo = 7881




/**********************************************/
/* Actualizacion pagos para reproceso         */
/**********************************************/

select codigo_interno = co_codigo_interno, secuencial = co_secuencial
into #reproceso_pagos
from #operacion_grupales_act,
     cob_cartera..ca_corresponsal_trn
where  operacion     = co_codigo_interno
and    co_secuencial > secuencial


select *
from #reproceso_pagos,
     cob_cartera..ca_corresponsal_det
where secuencial = cd_secuencial


delete cob_cartera..ca_corresponsal_det
from #reproceso_pagos     
where secuencial = cd_secuencial


select *
from #reproceso_pagos,
     cob_cartera..ca_corresponsal_det
where secuencial = cd_secuencial


select *
from cob_cartera..ca_corresponsal_trn,
     #reproceso_pagos
where co_secuencial = secuencial

update cob_cartera..ca_corresponsal_trn set
co_estado = 'I'
from #reproceso_pagos
where co_secuencial = secuencial


select *
from cob_cartera..ca_corresponsal_trn,
     #reproceso_pagos
where co_secuencial = secuencial
