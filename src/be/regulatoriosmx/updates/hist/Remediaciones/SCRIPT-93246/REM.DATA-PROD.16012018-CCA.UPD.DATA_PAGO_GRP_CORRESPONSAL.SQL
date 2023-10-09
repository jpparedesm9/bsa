
use cob_cartera
go


select estado = co_estado, 
       secuencial = co_secuencial, 
	   tipo_pago = co_tipo,  
       operacion = co_codigo_interno,
	   fecha_proceso = co_fecha_proceso,
	   fecha_valor = co_fecha_valor,
       monto_pago = co_monto
from  ca_corresponsal_trn
where co_estado = 'E' 
and   co_tipo = 'P'
and   co_error_id  = 2101011
and   upper(co_error_msg) like 'ERROR%INSERTAR%DETALLE%PAGOS%PROCESAR%OPERACION%GRUPAL%'


update ca_corresponsal_trn
set  co_estado    = 'I',
     co_error_id  = NULL,
	 co_error_msg = NULL
where co_estado = 'E' 
and   co_tipo = 'P'
and   co_error_id  = 2101011
and   upper(co_error_msg) like 'ERROR%INSERTAR%DETALLE%PAGOS%PROCESAR%OPERACION%GRUPAL%'


select estado = co_estado, 
       secuencial = co_secuencial, 
	   tipo_pago = co_tipo,  
       operacion = co_codigo_interno,
	   fecha_proceso = co_fecha_proceso,
	   fecha_valor = co_fecha_valor,
       monto_pago = co_monto
from  ca_corresponsal_trn
where co_tipo = 'P'
and   co_error_id  is NULL
and   co_error_msg is NULL

go

