use cob_cartera
go

declare @w_fecha_desembolso    datetime

select @w_fecha_desembolso = '05/28/2020' --Fecha desde la cual las operaciones desplazadas tiene problemas 

select op_operacion, op_fecha_ini, de_fecha_real, de_int_dsp, int_amortizacion = convert(money, 0)
into  ca_operaciones_140389
from cob_cartera..ca_operacion,
     cob_cartera..ca_desplazamiento
where op_operacion     = de_operacion
and   op_estado   in (1,2)
and   op_fecha_ini  >= @w_fecha_desembolso
and   de_estado     = 'A'
--and   op_operacion in (1310360, 1310486, 1310501, 1310558, 1310516)

select am_operacion, am_concepto, am_cuota= sum(am_cuota)
into #amortizacion
from ca_operaciones_140389,
     ca_amortizacion
where am_operacion =  op_operacion
and   am_concepto  = 'INT_ESPERA'
group by am_operacion , am_concepto


update ca_operaciones_140389 set
int_amortizacion = isnull(am_cuota,0)
from #amortizacion
where op_operacion = am_operacion


delete ca_operaciones_140389
where int_amortizacion - de_int_dsp  < 1

delete ca_operaciones_140389
where int_amortizacion is null


select * from ca_operaciones_140389


--drop table ca_operaciones_140389