use cob_conta
go
declare @w_error         int,
        @w_fecha_proceso datetime,
        @w_empresa       int,
        @w_msg             VARCHAR(150)

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_empresa = 1

 -- PASO A DEFINITIVO DE AUXILIARES 
   EXEC @w_error = sp_cb_tterc_ej
   @i_param1  = @w_empresa
   
   IF @w_error <> 0 BEGIN
      SELECT
      w_msg   = 'PASO A DEFINITIVO DE AUXILIARES',
      w_campo = 'return',
      w_dato  =  convert(VARCHAR, @w_error),
      w_error = 601308

   END
   
