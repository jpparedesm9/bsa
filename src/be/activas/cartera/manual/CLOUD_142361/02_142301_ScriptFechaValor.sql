use cob_cartera
go

declare 
@w_fecha_proceso datetime,
@w_operacion     int,
@w_fecha_valor   datetime,
@w_banco         varchar(32),
@w_oficina       int,
@w_error         int

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


select distinct op_operacion
into #sin_devengar
from operaciones_142361

select count(1) from #sin_devengar
select @w_operacion = 0
while 1 = 1
begin
   select top 1 @w_operacion =  op_operacion
   from #sin_devengar
   where op_operacion > @w_operacion
   order by op_operacion
   
   if @@rowcount = 0 break
   
   
   select 
   @w_banco   = op_banco,
   @w_oficina = op_oficina
   from cob_cartera..ca_operacion
   where op_operacion = @w_operacion
   
   select @w_fecha_valor = max(de_fecha_fin)
   from cob_cartera..ca_desplazamiento
   where de_operacion = @w_operacion
   and   de_estado    = 'A'
   
   select @w_fecha_valor = dateadd(dd,1,@w_fecha_valor)
   
   while exists (select 1 from cobis..cl_dias_feriados where df_ciudad = 999 and df_fecha = @w_fecha_valor)
   begin
       select @w_fecha_valor = dateadd(dd,1,@w_fecha_valor) --Siguiente dia habil
   end 
   
   select @w_banco, @w_operacion, @w_fecha_valor
   
   ----Llevar operaciones a fecha de inicio   
   exec @w_error = sp_fecha_valor 
        @s_date        = @w_fecha_proceso,
        @s_user        = 'usrbatch',
        @s_term        = 'consola',
        @s_ofi         = 1037,
        @t_trn         = 7049,
        @i_fecha_mov   = @w_fecha_proceso,
        @i_fecha_valor = @w_fecha_valor ,
        @i_banco       = @w_banco,
        @i_operacion   = 'F'     
  
   if @w_error <> 0 
   begin
      print 'Error hacia atras: '+ @w_banco +  ' @w_fecha_valor: ' + convert(varchar,@w_fecha_valor)
      goto Siguiente
   end  
  
   ----Llevar operaciones a fecha de inicio 
   exec @w_error = sp_fecha_valor 
        @s_date        = @w_fecha_proceso,
        @s_user        = 'usrbatch',
        @s_term        = 'consola',
        @s_ofi         = 1037,
        @t_trn         = 7049,
        @i_fecha_mov   = @w_fecha_proceso,
        @i_fecha_valor = @w_fecha_proceso ,
        @i_banco       = @w_banco,
        @i_operacion   = 'F'     

  
   if @w_error <> 0 
   begin
      print 'Error hacia adelante: '+ @w_banco +  ' @w_fecha_valor: ' + convert(varchar,@w_fecha_proceso)
      goto Siguiente
   end     
   
   Siguiente:
   
end  




drop table #sin_devengar