
use cob_cartera
go

declare
@w_grupo int,
@w_operacionca int,
@w_error int,
@w_fecha_proceso datetime,
@w_referencia varchar(64),
@w_banco varchar(24),
@w_secuencial_pag int,
@w_secuencial int,
@w_fecha_valor datetime,
@w_sec_ing int

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_operacionca     = tr_operacion ,
       @w_secuencial      = tr_secuencial,
       @w_banco           = tr_banco
from cob_cartera..ca_transaccion
where tr_operacion  = 113589
and   tr_secuencial = 14


exec @w_error = sp_fecha_valor 
     @s_date       = @w_fecha_proceso,
     @s_user       = 'usrbatch',
     @s_term       = 'consola',
     @t_trn        = 7049,
     @i_fecha_mov  = @w_fecha_proceso,
     @i_banco      = @w_banco,
     @i_secuencial = @w_secuencial   ,
     @i_operacion  = 'R'

if @w_error <> 0
   print 'Error:' + convert(varchar,@w_error)

select @w_operacionca     = tr_operacion ,
       @w_secuencial      = tr_secuencial,
       @w_banco           = tr_banco
from cob_cartera..ca_transaccion
where tr_operacion  = 113607
and   tr_secuencial = 14


exec @w_error = sp_fecha_valor 
     @s_date       = @w_fecha_proceso,
     @s_user       = 'usrbatch',
     @s_term       = 'consola',
     @t_trn        = 7049,
     @i_fecha_mov  = @w_fecha_proceso,
     @i_banco      = @w_banco        ,
     @i_secuencial = @w_secuencial,
     @i_operacion  = 'R'
     
if @w_error <> 0
   print 'Error:' + convert(varchar,@w_error)     
     