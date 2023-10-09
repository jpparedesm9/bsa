----------------->>>>>>>>>>>>>>>>>CREACION DE BATCH
use cobis
go

declare @w_batch int, @w_fecha_proceso datetime, @w_path_fuente varchar(50)
select @w_batch = 7533

----------------->>>>>>>>>>>>>>>>>Registro de batch
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select 'antes', * from ba_batch where ba_batch = @w_batch

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 7


delete from ba_batch where ba_batch = @w_batch

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (@w_batch, 'ELIMINAR OPERACIONES A FUTURO', 'ELIMINAR OPERACIONES A FUTURO', 'SP', @w_fecha_proceso, 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_cambio_fecha_fut', 1000, NULL, 'CTSSRV', 'S', @w_path_fuente, null)
----'
select 'desp', * from ba_batch where ba_batch = @w_batch

----------------->>>>>>>>>>>>>>>>>Registro de parametros para batch
select 'antes', * from ba_parametro where pa_batch = @w_batch
delete from ba_parametro where pa_batch = @w_batch

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
values (0, @w_batch, 0, 1, 'FECHA PROCESO', 'D', @w_fecha_proceso)

select 'desp', * from ba_parametro where pa_batch = @w_batch

go
