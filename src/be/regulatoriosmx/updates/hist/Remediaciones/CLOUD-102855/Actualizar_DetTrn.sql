

use cob_cartera
go 


update ca_det_trn set 
dtr_monto   = 587.27, 
dtr_monto_mn = 587.27
where dtr_operacion = 26578
and dtr_secuencial  = 61
and dtr_concepto    = 'VAC0'

go


