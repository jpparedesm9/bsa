use cob_cartera 
go 

update ca_transaccion_prv set
tp_estado      = 'ING'   ,
tp_fecha_cont  =  null   ,
tp_codvalor    =  11010  ,
tp_comprobante =  0
where tp_operacion = 217305
and tp_dividendo   in (1,3)
and tp_concepto    = 'INT'

go 