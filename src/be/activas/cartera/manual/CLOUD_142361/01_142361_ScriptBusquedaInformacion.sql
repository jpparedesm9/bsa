
use cob_cartera
go

declare @w_fecha_proceso datetime
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select *
into #operaciones_anteriores
from cob_cartera..ca_operacion
where op_estado in (1,2)
and   op_fecha_ini < '04/06/2020'


select am_operacion, am_concepto, cuota = sum(am_cuota), acumulado = sum(am_acumulado)
into #valores_espera
from #operaciones_anteriores, 
     cob_cartera..ca_amortizacion
where op_operacion = am_operacion
and   am_concepto  in ('IVA_ESPERA', 'INT_ESPERA' )
group by am_operacion, am_concepto


select op_banco, op_operacion,  am_concepto, cuota, acumulado
into operaciones_142361
from #valores_espera, ca_operacion
where cuota <> acumulado
and op_operacion = am_operacion
order by op_banco


delete operaciones_142361
where exists (select 1 from cob_cartera..ca_desplazamiento 
              where de_operacion = op_operacion 
              and de_fecha_ini <= @w_fecha_proceso 
              and de_fecha_fin >= @w_fecha_proceso
              and de_estado = 'A')



--drop table operaciones_142361
