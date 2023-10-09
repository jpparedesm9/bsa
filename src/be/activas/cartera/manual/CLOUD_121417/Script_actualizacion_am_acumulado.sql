
select am_acumulado, am_cuota, *
from cob_cartera..ca_operacion,
     cob_cartera..ca_amortizacion
where op_operacion = am_operacion
and   op_toperacion = 'REVOLVENTE'     
and   am_concepto   = 'IVA_INT'
and   am_acumulado  = 0

update cob_cartera..ca_amortizacion
set  am_acumulado  = am_cuota
from cob_cartera..ca_operacion
where op_operacion = am_operacion
and   op_toperacion = 'REVOLVENTE'     
and   am_concepto   = 'IVA_INT'
and   am_acumulado  = 0

select am_acumulado, am_cuota, *
from cob_cartera..ca_operacion,
     cob_cartera..ca_amortizacion
where op_operacion = am_operacion
and   op_toperacion = 'REVOLVENTE'     
and   am_concepto   = 'IVA_INT'


select amh_acumulado,amh_cuota, *
from cob_cartera..ca_amortizacion_his,
     cob_cartera..ca_operacion
where amh_operacion = op_operacion
and   op_toperacion = 'REVOLVENTE'   
and   amh_concepto   = 'IVA_INT'  
and   amh_acumulado  = 0   


update cob_cartera..ca_amortizacion_his
set  amh_acumulado  = amh_cuota
from cob_cartera..ca_operacion
where amh_operacion = op_operacion
and   op_toperacion = 'REVOLVENTE'   
and   amh_concepto   = 'IVA_INT'  
and   amh_acumulado  = 0


select  amh_acumulado,amh_cuota, *
from cob_cartera..ca_amortizacion_his,
     cob_cartera..ca_operacion
where amh_operacion = op_operacion
and   op_toperacion = 'REVOLVENTE'   
and   amh_concepto   = 'IVA_INT'  
 
