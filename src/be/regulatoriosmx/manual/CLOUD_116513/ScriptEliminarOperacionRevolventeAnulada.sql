use cob_conta_super
go

select do_estado_cartera,*
from cob_conta_super..sb_dato_operacion
where do_fecha >= '06/01/2019'
and   do_banco = '233510036186'
and   do_estado_cartera = 6

delete cob_conta_super..sb_dato_operacion
where do_fecha >= '06/01/2019'
and   do_banco = '233510036186'
and   do_estado_cartera = 6

select do_estado_cartera,*
from cob_conta_super..sb_dato_operacion
where do_fecha >= '06/01/2019'
and   do_banco = '233510036186'
and   do_estado_cartera = 6

