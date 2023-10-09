declare @w_fecha_proceso datetime

select @w_fecha_proceso = '04/01/2020'

exec cob_conta_super..sp_ods_plan_cuentas_ttj
     @i_param1 = @w_fecha_proceso
     
 