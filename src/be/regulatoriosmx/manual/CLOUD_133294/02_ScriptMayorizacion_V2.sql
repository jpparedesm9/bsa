use cob_conta
go
declare @w_error         int,
        @w_fecha_proceso datetime,
        @w_empresa       int,
        @w_msg             VARCHAR(150)

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_empresa = 1

    
 EXEC @w_error = sp_ejec_maysi
   @i_param1    = @w_empresa,
   @i_param2    = @w_fecha_proceso
   
   IF @w_error <> 0 BEGIN
      SELECT
      w_msg   = 'MAYORIZACION CONTA',
      w_campo = 'return',
      w_dato  =  convert(VARCHAR, @w_error),
      w_error = 601309
   END
   
  