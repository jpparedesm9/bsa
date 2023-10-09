

use cob_cartera 
go 



select 'ANTES', op_estado, * from ca_operacion where op_banco = '233510036186'


update ca_operacion set op_estado = 6 where op_banco = '233510036186'


select 'DESPUES', op_estado, * from ca_operacion where op_banco = '233510036186'

go