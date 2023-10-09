use cob_cartera
go

declare 
@w_operacion      int     ,
@w_registro       int     ,
@w_fecha_proceso  datetime

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select 
operacion    = de_operacion,
fecha_inicio = de_fecha_ini,
dias_aplaza  = datediff(dd,de_fecha_ini,de_fecha_fin),
dias_transcu = datediff(dd,de_fecha_ini,@w_fecha_proceso),
moneda       = op_moneda,
procesado    = convert(varchar(2),'N'),
mensaje      = convert(varchar(100),null)
into ca_desplazamiento_138837
from ca_desplazamiento,
     ca_operacion,
     ca_estado
where de_operacion = op_operacion
and   de_estado    = 'A'
and   op_estado    = es_codigo
and   es_procesa  = 'S'
order by op_operacion  


select count(1) from ca_desplazamiento_138837



select op_operacion, 
       mensaje     = convert(varchar(100),null)
into ca_procesamiento_138837
from cob_cartera..ca_operacion
where 1 = 2
   
