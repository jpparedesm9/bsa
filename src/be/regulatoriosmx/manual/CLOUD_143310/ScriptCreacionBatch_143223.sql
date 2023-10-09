
use cobis
go


if not exists (select 1 from cobis..ba_batch where ba_batch = 36436)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36436, 'GENERACION REPORTE MOV CONTABLES', 'GENERACION REPORTE MOV CONTABLES', 'SP', '2020-07-24', 36, 'R', 1, 'REGULATORIOS', 'MOV_POLIZAS', 'cob_conta_super..sp_reporte_movdiario', 1, 'lp', 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end

select *
from  cobis..ba_batch
where ba_batch = 36436


if not exists(select 1 from  cobis..ba_parametro where pa_batch = 36436)
begin
   insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
   values (0, 36436, 0, 3, 'FECHA', 'D', '04/07/2020')
end


select *
from  cobis..ba_parametro
where pa_batch = 36436