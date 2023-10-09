use cob_cartera
go

declare @w_fecha datetime,
        @w_banco cuenta

select @w_fecha = fp_fecha from cobis..ba_fecha_proceso

select op_banco, op_fecha_ult_proceso
into #operaciones_fecha_valor
from cob_cartera..ca_operacion
where op_estado = 1
and   op_fecha_ult_proceso <> @w_fecha

select @w_banco = ''
while 1= 1
begin
   select top 1
   @w_banco = op_banco
   from #operaciones_fecha_valor
   where op_banco> @w_banco
   order by op_banco
   
   if @@rowcount = 0 break
   
   print 'Procesamiento Operacion: '+ @w_banco
   
   exec sp_fecha_valor 
      @s_date        = @w_fecha,
      @s_user        = 'usrbatch',
      @s_term        = 'consola',
      @s_ofi         = 1037,
      @t_trn         = 7049,
      @i_fecha_mov   = @w_fecha,
      @i_fecha_valor = @w_fecha,
      @i_banco       = @w_banco,
      @i_operacion   = 'F'  

end  

