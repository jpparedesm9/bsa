use cobis
go

declare @w_batch int, @w_fecha_proceso datetime, @w_path_fuente varchar(50), @w_path_destino varchar(50)
select @w_batch = 5001
----------------->>>>>>>>>>>>>>>>>Registro de batch
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select
	@w_path_fuente = pp_path_fuente,
	@w_path_destino  = pp_path_destino
from ba_path_pro
where pp_producto = 5

select @w_path_fuente  = isnull(@w_path_fuente,  'C:\Cobis\vbatch\regulatorios\objetos\')
select @w_path_destino = isnull(@w_path_destino, 'C:\Cobis\vbatch\regulatorios\listados\')
----'
delete from ba_batch where ba_batch = @w_batch

insert into ba_batch (
	ba_batch, 		ba_nombre, 		ba_descripcion,		ba_lenguaje, 		ba_fecha_creacion, 	ba_producto, 
	ba_tipo_batch, 	ba_sec_corrida, ba_ente_procesado,	ba_arch_resultado, 	ba_arch_fuente, 	ba_frec_reg_proc, 
	ba_impresora, 	ba_serv_destino,ba_reproceso, 		ba_path_fuente, 	ba_path_destino)
values (
	@w_batch, 'RTE EVALUACION GRUPAL EN017', 'RTE EVALUACION GRUPAL EN017', 'SP', @w_fecha_proceso, 5, 
	'R', 1, 'EVALUACION EN017', 'Reporte_EvalGrupal_', 'cobis..sp_eval_grp_en017', 1000, 
	NULL, 'CTSSRV', 'S', @w_path_fuente, @w_path_destino)

select 'desp', * from ba_batch where ba_batch = @w_batch
