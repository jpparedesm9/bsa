

use cob_cartera 
go 


declare @w_operacion int, @w_fecha_des datetime , @w_banco cuenta ,  @w_error int , @w_fecha_ven datetime   ,@w_fecha_proc datetime 

select @w_fecha_proc = fp_fecha  from cobis..ba_fecha_proceso

select
operacion = op_operacion,
banco     = op_banco
into #operaciones 
from ca_operacion where op_banco in 
(
'233510044065',
'233510047415',
'233510036202',
'224030035584',
'233510043778',
'214790020692',
'224030035930',
'233510044602')


--REGRESAMOS EN EL TIEMPO A LAS OPERACIONES PARA QUE EL BATCH EN LA NOCHE LOS DEVUELVA CON PRV QUE ES LO QUE NO TIENEN Y QUE ESTÁ DESCUADRANDO LA CONTA

																	
select @w_operacion = 0

while (1=1) begin 


   select top 1 
   @w_operacion = operacion , 
   @w_banco      = banco
   from #operaciones
   where operacion  >@w_operacion 
   order by operacion
   
   if @@rowcount = 0 break 
   
    
   select @w_fecha_ven = min(tr_fecha_ref) 
   from ca_transaccion 
   where tr_tran= 'VEN'
   and tr_estado <> 'RV'
   and tr_secuencial >0
   and tr_operacion =@w_operacion
   
   if @w_fecha_ven is null goto SIG
   
 -- select @w_banco,@w_operacion,@w_fecha_ven
  
   exec @w_error = sp_fecha_valor 
   @s_date              = @w_fecha_proc,
   @s_user              = 'consola',
   @s_term              = 'cobis',
   @i_fecha_valor       = @w_fecha_ven,
   @i_banco             = @w_banco,
   @i_operacion         = 'F',
   @i_en_linea          = 'N'
		 
  if  @w_error <> 0 goto SIG
  
  
   exec @w_error = sp_fecha_valor 
   @s_date              = @w_fecha_proc,
   @s_user              = 'consola',
   @s_term              = 'cobis',
   @i_fecha_valor       = @w_fecha_proc,
   @i_banco             = @w_banco,
   @i_operacion         = 'F',
   @i_en_linea          = 'N'
		 
  if  @w_error <> 0 goto SIG
  
		 
   SIG:
end 

go

select 'ANTES' , * from ca_transaccion 
where  tr_operacion in ( 
228178,
228181,
228184,
228187,
228190,
228193,
228196,
228199) 
and tr_secuencial = 1 


update ca_transaccion set 
tr_ofi_usu = tr_ofi_oper 
where tr_operacion in ( 
228178,
228181,
228184,
228187,
228190,
228193,
228196,
228199) 
and tr_secuencial = 1 



select 'DESPUES' , * from ca_transaccion 
where  tr_operacion in ( 
228178,
228181,
228184,
228187,
228190,
228193,
228196,
228199) 
and tr_secuencial = 1 

go

drop table #operaciones 
go