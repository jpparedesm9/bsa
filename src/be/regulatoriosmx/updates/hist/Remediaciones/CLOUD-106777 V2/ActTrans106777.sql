use cob_cartera 
go 

delete ca_det_trn where dtr_operacion = 26800 and dtr_secuencial=99 and dtr_concepto = 'SOBRANTE' --0.06
delete ca_det_trn where dtr_operacion = 26803 and dtr_secuencial=99 and dtr_concepto = 'SOBRANTE' --0.06
delete ca_det_trn where dtr_operacion = 26806 and dtr_secuencial=99 and dtr_concepto = 'SOBRANTE' --0.06
delete ca_det_trn where dtr_operacion = 26809 and dtr_secuencial=99 and dtr_concepto = 'SOBRANTE' --0.07
delete ca_det_trn where dtr_operacion = 26812 and dtr_secuencial=99 and dtr_concepto = 'SOBRANTE' --0.07
delete ca_det_trn where dtr_operacion = 26815 and dtr_secuencial=99 and dtr_concepto = 'SOBRANTE' --0.06
go
update ca_det_trn set dtr_monto =dtr_monto -0.06,dtr_monto_mn=dtr_monto_mn-0.06  where dtr_operacion = 26800 and dtr_secuencial=99 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto -0.06,dtr_monto_mn=dtr_monto_mn-0.06  where dtr_operacion = 26803 and dtr_secuencial=99 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto -0.06,dtr_monto_mn=dtr_monto_mn-0.06  where dtr_operacion = 26806 and dtr_secuencial=99 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto -0.07,dtr_monto_mn=dtr_monto_mn-0.07  where dtr_operacion = 26809 and dtr_secuencial=99 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto -0.07,dtr_monto_mn=dtr_monto_mn-0.07  where dtr_operacion = 26812 and dtr_secuencial=99 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto -0.06,dtr_monto_mn=dtr_monto_mn-0.06  where dtr_operacion = 26812 and dtr_secuencial=99 and dtr_concepto = 'VAC0'
go


