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
where co_secuencial in (19, 20)
and   co_codigo_interno = 15
and   co_estado = 'I' 
and   co_tipo = 'P'
and   co_error_id is NULL
and   co_error_msg is NULL


update ca_corresponsal_trn
set  co_estado    = 'E',
     co_error_id  = 2101011,
	 co_error_msg = 'ERROR INSERTAR DETALLE DE PAGOS A PROCESAR OPERACION GRUPAL: 4'
where co_secuencial in (19, 20)
and   co_codigo_interno = 15
and   co_estado = 'I' 
and   co_tipo = 'P'
and   co_error_id is NULL
and   co_error_msg is NULL


select estado = co_estado, 
       secuencial = co_secuencial, 
	   tipo_pago = co_tipo,  
       operacion = co_codigo_interno,
	   fecha_proceso = co_fecha_proceso,
	   fecha_valor = co_fecha_valor,
       monto_pago = co_monto
from  ca_corresponsal_trn
where co_secuencial in (19, 20)
and   co_codigo_interno = 15
and   co_estado = 'E' 
and   co_tipo = 'P'
and   co_error_id is not NULL
and   co_error_msg is not NULL

go

