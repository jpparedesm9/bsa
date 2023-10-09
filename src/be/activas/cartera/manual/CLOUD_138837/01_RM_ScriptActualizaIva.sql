use cob_cartera
go

declare @w_fecha_proceso datetime

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select op_operacion,
       di_dividendo, 
       di_estado   ,
       concepto   = am_concepto ,
       cuota      = am_cuota    ,
       secuencial = convert(int, null) ,
       am_secuencia,
       op_oficina
into #rubros_operaciones
from cob_cartera..ca_operacion,
     cob_cartera..ca_dividendo,
     cob_cartera..ca_amortizacion     
where op_estado    = 1
and   op_fecha_ini >= '04/06/2020'
and   op_operacion = di_operacion
and   di_operacion = am_operacion
and   di_dividendo = am_dividendo
and   di_estado    = 1
and   am_concepto  in ('INT_ESPERA', 'IVA_ESPERA')
order by op_operacion, di_dividendo


select operacion = op_operacion, dividendo = di_dividendo
into #operacion_registros_existe
from #rubros_operaciones,
     cob_cartera..ca_transaccion_prv
where op_operacion = tp_operacion
and di_dividendo   = tp_dividendo
and concepto      = tp_concepto


delete from #rubros_operaciones
where not exists (select 1 from #operacion_registros_existe
                  where op_operacion = operacion
                  and   di_dividendo = di_dividendo)



update #rubros_operaciones set
secuencial = tp_secuencial_ref
from cob_cartera..ca_transaccion_prv
where  op_operacion = tp_operacion
and    di_dividendo = tp_dividendo  


select *
into #operacion_actualizar
from #rubros_operaciones
where not exists (select 1    
                  from cob_cartera..ca_transaccion_prv
                  where op_operacion = tp_operacion
                  and di_dividendo = tp_dividendo
                  and concepto     = tp_concepto)


select *
from #operacion_actualizar

insert into ca_transaccion_prv (
       tp_fecha_mov     , tp_operacion,  tp_fecha_ref    , 
       tp_secuencial_ref, tp_estado   ,  tp_comprobante  , 
       tp_fecha_cont    , tp_dividendo,  tp_concepto     , 
       tp_codvalor      , 
       tp_monto         , tp_secuencia, tp_ofi_oper)
select @w_fecha_proceso,  op_operacion,  @w_fecha_proceso,
       secuencial      ,  'ING'       ,  0               , 
       '01/01/1900'    ,  di_dividendo,  concepto        ,
        case when concepto = 'INT_ESPERA' then 20010 else 21010 end,
       cuota           ,  am_secuencia,  op_oficina 
from #operacion_actualizar
        

update ca_amortizacion set
am_acumulado = cuota
from #operacion_actualizar
where am_operacion = op_operacion
and am_dividendo   = di_dividendo
and am_concepto    = concepto
