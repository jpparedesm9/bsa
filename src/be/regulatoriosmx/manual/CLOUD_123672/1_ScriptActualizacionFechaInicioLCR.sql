
use cob_cartera
go


select 
banco      = op_banco,
operacion  = op_operacion,
fecha_ini  = op_fecha_ini,
fecha_fin  = op_fecha_fin
into #operaciones_lcr 
from cob_cartera..ca_operacion
where op_toperacion = 'REVOLVENTE'


select 
fecha = dc_fecha, 
banco = dc_banco
into #operaciones_lcr_fecha
from cob_conta_super..sb_dato_cuota_pry,
#operaciones_lcr
where dc_banco = banco
group by dc_fecha, dc_banco



select *
from #operaciones_lcr_fecha,
cob_conta_super..sb_dato_cuota_pry,
cob_cartera..ca_operacion,
cob_cartera..ca_dividendo
where dc_fecha = fecha
and dc_banco = banco 
and op_banco = banco
and op_operacion = di_operacion
and dc_num_cuota = di_dividendo
and dc_fecha_ini is null



update cob_conta_super..sb_dato_cuota_pry set
dc_fecha_ini = di_fecha_ini
from #operaciones_lcr_fecha,
cob_cartera..ca_operacion,
cob_cartera..ca_dividendo
where dc_fecha = fecha
and dc_banco = banco 
and op_banco = banco
and op_operacion = di_operacion
and dc_num_cuota = di_dividendo
and dc_fecha_ini is null



select *
from #operaciones_lcr_fecha,
cob_conta_super..sb_dato_cuota_pry,
cob_cartera..ca_operacion,
cob_cartera..ca_dividendo
where dc_fecha = fecha
and dc_banco = banco 
and op_banco = banco
and op_operacion = di_operacion
and dc_num_cuota = di_dividendo
and dc_fecha_ini is null

