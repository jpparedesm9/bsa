use cob_cartera
go

declare @w_error   int   ,
        @w_banco   cuenta,
        @w_oficina int,
        @w_pago_realizado char(1) 

select @w_banco = '' 

while 1 = 1
begin
   select @w_pago_realizado = 'S'
   
   select top 1 @w_banco = co_banco
   from ca_condonacion_141115
   where co_banco > @w_banco
   and   co_procesado = 'N'
   order by co_banco
   
   if @@rowcount = 0 break


   exec @w_error = sp_proceso_condonacion_tmp
        @i_banco              = @w_banco,
        @t_debug              = 'N'
  
   if @w_error <> 0
   begin  
      select @w_pago_realizado = 'N'
   end
   
  update ca_condonacion_141115 set
  co_procesado = 'S',
  co_realizado_pago = @w_pago_realizado
  where co_banco = @w_banco     
end 


select * from ca_condonacion_141115 where co_procesado = 'N'
