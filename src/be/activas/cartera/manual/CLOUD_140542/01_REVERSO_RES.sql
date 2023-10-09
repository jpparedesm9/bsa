

--SCRIPT REVERSO 
--GRUPOS 
--12169,1968 ,11847,2880,4799
 

 
use cob_cartera
go

declare 
@w_operacion           int,
@w_fecha_proceso       datetime,
@w_banco               cuenta,
@w_error               int,
@w_secuencial          int 



select 
operacion  = tr_operacion,
banco      = tr_banco , 
secuencial = tr_secuencial
into #operaciones 
from ca_transaccion 
where tr_banco 
in (
'213450000698',
'213450000715',
'213450000756',

'233510108308',
'233510108316',

'214790071571',
'214790071589',
			 
'214790071803',
'214790071811',
'214790071829',
'214790071837',
'214790071845',
'214790071878',
			 
			 
'214800070705',
'214800070754'
)
and tr_tran = 'RES'
and tr_secuencial >0 
and tr_estado <> 'RV'

select @w_operacion = 0

while 1 = 1 begin

   select  top 1
   @w_operacion    = operacion,
   @w_banco        = banco ,
   @w_secuencial   = secuencial
   from #operaciones
   where operacion > @w_operacion
   order by operacion asc
   
   if @@rowcount = 0 break 
   
   
   ----REVERSAR TRANSACCIONES RES   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_banco       = @w_banco,
   @i_secuencial  = @w_secuencial,
   @i_operacion   = 'R'
                
       
   if @w_error <> 0 begin 
      select 'error', @w_error, 'banco',@w_banco
      goto Siguiente
   end         
   
   Siguiente:   
end



--PUNTO DE CONTROL 


select tr_tran, tr_banco, tr_estado,tr_secuencial,* from ca_transaccion 
where tr_banco 
in ( select banco from #operaciones)
and tr_tran = 'RES'


select di_operacion , count(di_dividendo) 
from ca_dividendo 
where di_operacion  in ( select operacion from #operaciones)
group by di_operacion 

select am_operacion, am_concepto, sum(am_cuota) from ca_amortizacion 
where am_operacion in ( select operacion from #operaciones)
and am_concepto in( 'INT_ESPERA','IVA_ESPERA','SEGAD')
group by am_operacion , am_concepto

select op_fecha_ult_proceso,* from ca_operacion 
where op_operacion in (select operacion from #operaciones)

drop table #operaciones
go


