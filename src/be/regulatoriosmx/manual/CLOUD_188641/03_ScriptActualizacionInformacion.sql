
update cob_conta_super..sb_dato_operacion set
do_periodicidad = op_periodo_int
from cob_cartera..ca_operacion
where do_fecha >='04/01/2022'
and do_banco = op_banco