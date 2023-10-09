
--Scripts para eliminar sobrantes en caso de no poder realizar reversos

use cob_cartera 
go

declare @w_operacion int 

select @w_operacion = 217305

select * 
from  ca_transaccion, ca_det_trn 
where tr_operacion  = @w_operacion 
and   tr_operacion  = dtr_operacion 
and   tr_secuencial = 99
and   tr_secuencial = dtr_secuencial 
and   tr_estado    <> 'RV'


delete ca_det_trn where dtr_operacion = @w_operacion and dtr_secuencial=99 and dtr_concepto = 'SOBRANTE' --4.51
update ca_det_trn set dtr_monto = dtr_monto - 4.51,dtr_monto_mn = dtr_monto_mn - 4.51 where dtr_operacion = @w_operacion and dtr_secuencial=99 and dtr_concepto = 'VAC0'

select * 
from  ca_transaccion, ca_det_trn 
where tr_operacion  = @w_operacion 
and   tr_operacion  = dtr_operacion 
and   tr_secuencial = 99
and   tr_secuencial = dtr_secuencial 
and   tr_estado    <> 'RV'

go
