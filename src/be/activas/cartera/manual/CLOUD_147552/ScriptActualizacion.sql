use cob_cartera
go



select valor_inicial = cu_valor_inicial, codigo_externo = cu_codigo_externo, op_cliente, op_operacion, tramite_grupal = tg_tramite, monto_pagado = convert(money,0), tg_grupo
into #garantias_inconveniente
from cob_cartera..ca_operacion,
cob_credito..cr_gar_propuesta,
cob_custodia..cu_custodia,
cob_credito..cr_tramite_grupal
where op_estado = 1
and op_tramite = gp_tramite 
and cu_codigo_externo    = gp_garantia
and cu_valor_inicial = 0
and op_operacion = tg_operacion
and exists (select 1 
            from cob_cartera..ca_garantia_liquida 
            where op_cliente = gl_cliente 
            and   gl_monto_garantia > 0 
            and gl_pag_valor > 0
            and  gl_monto_garantia = gl_pag_valor
            and  gl_pag_valor is not null
            and  gl_tramite = tg_tramite)

                       

update #garantias_inconveniente set
monto_pagado = gl_pag_valor
from cob_cartera..ca_garantia_liquida
where tramite_grupal = gl_tramite
and op_cliente = gl_cliente
and  gl_pag_valor > 0
and gl_dev_estado is null

select * from #garantias_inconveniente

update cob_custodia..cu_custodia set
cu_valor_inicial = monto_pagado
from #garantias_inconveniente
where codigo_externo = cu_codigo_externo

drop table #garantias_inconveniente            