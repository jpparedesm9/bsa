

use cob_cartera 
go



select 'ANTES', * from ca_det_trn where  dtr_operacion = 155619 and dtr_secuencial=22 and dtr_concepto = 'SOBRANTE'

select 'ANTES', * from ca_det_trn  where dtr_operacion = 155619 and dtr_secuencial=22 and dtr_concepto = 'VAC0'



delete ca_det_trn where dtr_operacion = 155619 and dtr_secuencial=22 and dtr_concepto = 'SOBRANTE' --0.62

go

update ca_det_trn set dtr_monto =dtr_monto -0.62 ,dtr_monto_mn=dtr_monto_mn-0.62 where dtr_operacion = 155619 and dtr_secuencial=22 and dtr_concepto = 'VAC0'
go 





select 'DESPUES', * from ca_det_trn where  dtr_operacion = 155619 and dtr_secuencial=22 and dtr_concepto = 'SOBRANTE'

select 'DESPUES', * from ca_det_trn  where dtr_operacion = 155619 and dtr_secuencial=22 and dtr_concepto = 'VAC0'