use cob_cartera
go

declare @w_fecha_proceso datetime,
        @w_banco         cuenta,
        @w_secuencial    int,
        @w_operacion     int
        
        
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_operacion = 0

while 1 = 1
begin   
   select top 1
   @w_operacion = operacion,
   @w_secuencial= secuencial,
   @w_banco     = banco
   from rev_operaciones_desplazamiento
   where operacion > @w_operacion
   order by operacion asc
   
   if @@rowcount = 0 break
   
   
   if exists (select 1 from ca_transaccion where tr_operacion = @w_operacion and tr_secuencial = @w_secuencial and tr_estado = 'RV')
      goto Siguiente
   
   exec sp_fecha_valor 
      @s_date        = @w_fecha_proceso,
      @s_user        = 'usrbatch',
      @s_term        = 'consola_rv',
      @t_trn         = 7049,
      @i_fecha_mov   = @w_fecha_proceso,
      @i_banco       = @w_banco,
      @i_secuencial  = @w_secuencial,
      @i_operacion   = 'R'       
   
   Siguiente:
     print 'Procesado Reverso: @w_operacion: ' + @w_banco + ' Secuencial: ' + convert(varchar,@w_secuencial)
end  

