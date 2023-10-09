use cobis
go


select *
from cobis..ba_batch
where ba_batch = 6937


if not exists(select 1 from cobis..ba_batch where ba_batch = 6937)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (6937, 'PROCESO TEMPORAL ACTUALIZACION SUMATORIA', 'PROCESO TEMPORAL ACTUALIZACION SUMATORIA', 'SP', '2019-12-31', 6, 'P', 1, 'AUXILIARES', NULL, 'cob_conta..sp_actual_sumatoria_tmp', 1000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Conta\Objetos\', NULL)
end

select *
from cobis..ba_batch
where ba_batch = 6937

select *
from cobis..ba_parametro
where pa_batch = 6937


if not exists (select 1 from cobis..ba_parametro where pa_batch = 6937 and pa_sarta =0)
begin
   insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
   values (0, 6937, 0, 1, 'FECHA PROCESO', 'D', '03/18/2020')
end 


select *
from cobis..ba_parametro
where pa_batch = 6937