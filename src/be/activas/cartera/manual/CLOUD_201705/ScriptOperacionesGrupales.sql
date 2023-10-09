use cob_cartera
go

declare @w_fecha_proceso datetime

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select co_secuencial, tg_referencia_grupal, di_dividendo, di_fecha_ven,di_estado, operaciones = count(1)
into #operaciones_div
from cob_cartera..ca_corresponsal_trn,
cob_cartera..ca_operacion p,
cob_credito..cr_tramite_grupal,
cob_cartera..ca_dividendo d
where co_fecha_proceso  = '01/31/2023'
and   co_estado         = 'X'
and   co_codigo_interno =  p.op_operacion
and   tg_referencia_grupal = p.op_banco
and   di_operacion = tg_operacion
and  di_estado     <> 3
group by co_secuencial, tg_referencia_grupal, di_dividendo, di_fecha_ven,di_estado



select secuencial = co_secuencial, tg_referencia_grupal, fecha_min_ven = min(di_fecha_ven)
into #pagos_vencimiento_min
from #operaciones_div
group by co_secuencial, tg_referencia_grupal


select *
from cob_cartera..ca_corresponsal_trn, #pagos_vencimiento_min
where secuencial = co_secuencial
and   co_estado  = 'X'
and   fecha_min_ven = @w_fecha_proceso


update cob_cartera..ca_corresponsal_trn set
co_estado = 'I'
from #pagos_vencimiento_min
where secuencial = co_secuencial
and   co_estado  = 'X'
and   fecha_min_ven = @w_fecha_proceso

select *
from cob_cartera..ca_corresponsal_trn, #pagos_vencimiento_min
where secuencial = co_secuencial
and   fecha_min_ven = @w_fecha_proceso




drop table #operaciones_div
drop table #pagos_vencimiento_min