
use cob_cartera 
go

select *
from cob_cartera..ca_det_trn
where dtr_operacion in (92764, 92767, 92770, 92773, 92776, 92779, 92782, 92785, 92788, 92791)
and   dtr_secuencial=394 
and dtr_concepto = 'SOBRANTE'

delete ca_det_trn where dtr_operacion = 92764 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --21.5
delete ca_det_trn where dtr_operacion = 92767 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --23.39
delete ca_det_trn where dtr_operacion = 92770 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --23.39
delete ca_det_trn where dtr_operacion = 92773 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --21.5
delete ca_det_trn where dtr_operacion = 92776 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --21.5
delete ca_det_trn where dtr_operacion = 92779 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --23.39
delete ca_det_trn where dtr_operacion = 92782 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --23.39
delete ca_det_trn where dtr_operacion = 92785 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --22.01
delete ca_det_trn where dtr_operacion = 92788 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --22.01
delete ca_det_trn where dtr_operacion = 92791 and dtr_secuencial=394 and dtr_concepto = 'SOBRANTE' --22.01


select *
from cob_cartera..ca_det_trn
where dtr_operacion in (92764, 92767, 92770, 92773, 92776, 92779, 92782, 92785, 92788, 92791)
and   dtr_secuencial = 394 
and dtr_concepto     = 'SOBRANTE'

go

select *
from cob_cartera..ca_det_trn
where dtr_operacion in (92764, 92767, 92770, 92773, 92776, 92779, 92782, 92785, 92788, 92791)
and   dtr_secuencial = 394 
and dtr_concepto     = 'VAC0'

update ca_det_trn set dtr_monto =dtr_monto-21.5,dtr_monto_mn=dtr_monto_mn-21.5 where dtr_operacion = 92764 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-23.39,dtr_monto_mn=dtr_monto_mn-23.39 where dtr_operacion = 92767 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-23.39,dtr_monto_mn=dtr_monto_mn-23.39 where dtr_operacion = 92770 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-21.5,dtr_monto_mn=dtr_monto_mn-21.5 where dtr_operacion = 92773 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-21.5,dtr_monto_mn=dtr_monto_mn-21.5 where dtr_operacion = 92776 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-23.39,dtr_monto_mn=dtr_monto_mn-23.39 where dtr_operacion = 92779 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-23.39,dtr_monto_mn=dtr_monto_mn-23.39 where dtr_operacion = 92782 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-22.01,dtr_monto_mn=dtr_monto_mn-22.01 where dtr_operacion = 92785 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-22.01,dtr_monto_mn=dtr_monto_mn-22.01 where dtr_operacion = 92788 and dtr_secuencial=394 and dtr_concepto = 'VAC0'
update ca_det_trn set dtr_monto =dtr_monto-22.01,dtr_monto_mn=dtr_monto_mn-22.01 where dtr_operacion = 92791 and dtr_secuencial=394 and dtr_concepto = 'VAC0'


select *
from cob_cartera..ca_det_trn
where dtr_operacion in (92764, 92767, 92770, 92773, 92776, 92779, 92782, 92785, 92788, 92791)
and   dtr_secuencial = 394 
and dtr_concepto     = 'VAC0'


go


                                                