

update  cob_conta_super..sb_dato_cuota_pry
set dc_fecha_ini = di_fecha_ini
from cob_cartera..ca_operacion,
     cob_cartera..ca_dividendo
where dc_fecha     = '05/31/2019'
and   dc_banco     = op_banco
and   op_operacion = di_operacion
and   dc_fecha_vto = di_fecha_ven


update  cob_conta_super..sb_dato_cuota_pry
set dc_fecha_ini = di_fecha_ini
from cob_cartera..ca_operacion,
     cob_cartera..ca_dividendo
where dc_fecha     = '06/28/2019'
and   dc_banco     = op_banco
and   op_operacion = di_operacion
and   dc_fecha_vto = di_fecha_ven



update  cob_conta_super..sb_dato_cuota_pry
set dc_fecha_ini = di_fecha_ini
from cob_cartera..ca_operacion,
     cob_cartera..ca_dividendo
where dc_fecha     = '07/31/2019'
and   dc_banco     = op_banco
and   op_operacion = di_operacion
and   dc_fecha_vto = di_fecha_ven
