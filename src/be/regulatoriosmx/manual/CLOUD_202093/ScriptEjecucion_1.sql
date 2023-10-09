use cob_conta_super
go

declare @w_fecha_proceso datetime
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

exec cob_conta_super..sp_ods_saldos_cont
 @i_param1       = 'M',
 @i_fecha        = @w_fecha_proceso,
 @i_valida_dia   = 'N'
go


declare @w_fecha_proceso datetime
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

exec cob_conta_super..sp_ods_saldos_cont_nv
 @i_param1       = 'M',
 @i_param2       = @w_fecha_proceso,
 @i_valida_dia   = 'N'

 
