
select *
from cob_cartera..ca_transaccion,
     cob_cartera..ca_det_trn  
where tr_operacion  = 33324
and   tr_secuencial = 85
and   tr_operacion  = dtr_operacion
and   tr_secuencial = dtr_secuencial


update cob_cartera..ca_det_trn 
set   dtr_monto	    = 397.21,
      dtr_monto_mn  = 397.21
where dtr_operacion = 33324
and   dtr_secuencial = 85
and   dtr_concepto  = 'VAC0'


select *
from cob_cartera..ca_transaccion,
     cob_cartera..ca_det_trn  
where tr_operacion  = 33324
and   tr_secuencial = 85
and   tr_operacion  = dtr_operacion
and   tr_secuencial = dtr_secuencial

/**************************************************************/
/*                                                            */
/**************************************************************/
select *
from cob_cartera..ca_transaccion,
     cob_cartera..ca_det_trn  
where tr_operacion  = 26815
and   tr_secuencial = -99
and   tr_operacion  = dtr_operacion
and   tr_secuencial = dtr_secuencial


update cob_cartera..ca_det_trn 
set   dtr_monto	    = 209.12,
      dtr_monto_mn  = 209.12
where dtr_operacion = 26815
and   dtr_secuencial = -99
and   dtr_concepto  = 'VAC0'


select *
from cob_cartera..ca_transaccion,
     cob_cartera..ca_det_trn  
where tr_operacion  = 26815
and   tr_secuencial = -99
and   tr_operacion  = dtr_operacion
and   tr_secuencial = dtr_secuencial


/**************************************************************/
/*                                                            */
/**************************************************************/
select *
from cob_cartera..ca_transaccion,
     cob_cartera..ca_det_trn  
where tr_operacion  = 26812
and   tr_secuencial = -99
and   tr_operacion  = dtr_operacion
and   tr_secuencial = dtr_secuencial


update cob_cartera..ca_det_trn 
set   dtr_monto	    = 254.11,
      dtr_monto_mn  = 254.11
where dtr_operacion = 26812
and   dtr_secuencial = -99
and   dtr_concepto  = 'VAC0'

select *
from cob_cartera..ca_transaccion,
     cob_cartera..ca_det_trn  
where tr_operacion  = 26812
and   tr_secuencial = -99
and   tr_operacion  = dtr_operacion
and   tr_secuencial = dtr_secuencial



