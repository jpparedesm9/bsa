use cob_conta_super
go

update sb_dato_transaccion
set dt_fecha_trans = tr_fecha_ref
from cob_cartera..ca_transaccion
where dt_fecha     >= '06/01/2019' 
and   dt_secuencial = tr_secuencial
and   dt_banco      = tr_banco 