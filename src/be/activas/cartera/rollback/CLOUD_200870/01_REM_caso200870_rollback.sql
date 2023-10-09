----------------->>>>>>>>>>>>>>>>>CREACION DE BATCH
use cobis
go

declare @w_batch int, @w_fecha_proceso datetime
select @w_batch = 7533

----------------->>>>>>>>>>>>>>>>>Registro de batch
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select 'antes', * from ba_batch where ba_batch = @w_batch
delete from ba_batch where ba_batch = @w_batch
select 'desp', * from ba_batch where ba_batch = @w_batch

----------------->>>>>>>>>>>>>>>>>Registro de parametros para batch
select 'antes', * from ba_parametro where pa_batch = @w_batch
delete from ba_parametro where pa_batch = @w_batch
select 'desp', * from ba_parametro where pa_batch = @w_batch

go
