USE cobis
GO
--////////////////////////////////////////////////////
/* BORRAR DATOS */
DELETE FROM cobis..ba_parametro   WHERE pa_batch = 36429
DELETE FROM cobis..ba_sarta_batch WHERE sb_batch = 36429
DELETE FROM cobis..ba_batch       WHERE ba_batch = 36429

delete FROM cobis..ba_enlace WHERE en_sarta = 22 AND en_batch_fin = 36429    -- es el enlace con el 6064
delete FROM cobis..ba_enlace WHERE en_sarta = 22 AND en_batch_inicio = 36429 -- es el fin
delete FROM cobis..ba_enlace WHERE en_sarta = 22 AND en_batch_inicio = 6064  -- es el enlace entre 6064 y 36429
---------------------------------------------------------------------
/* CREAR SARTA BATCH */
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (22, 36429, 41, NULL, 'S', 'N', 4700, 360, 22, 'S')
---------------------------------------------------------------------
/* CREAR PARAMETROS */
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 36429,  0, 1, 'FECHA_PROCESO', 'D', '04/01/2018')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (22, 36429, 41, 1, 'FECHA_PROCESO', 'D', '04/01/2018')
---------------------------------------------------------------------
/* CREAR ENLACE */
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (22, 6064, 3, 36429, 41, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (22, 36429, 41, 0, 0, 'S', NULL, 'N')
---------------------------------------------------------------------
/* CREAR BATCH */

declare @w_server varchar(24),
        @w_path_fuente_REG varchar(255),
        @w_path_destino_REG varchar(255)

select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente_REG = pp_path_fuente,
       @w_path_destino_REG = pp_path_destino
from ba_path_pro
where pp_producto = 36
-- LGU
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36429, 'REPORTE DE MOVIMIENTOS CONTABLES', 'REPORTE DE MOVIMIENTOS CONTABLES', 'SP', getdate(), 36, 'P', 1, 'ASIENTOS', 'MOV_CONT_DD_MM_YYYY.txt', 'cob_conta_super..sp_mov_contable_mes', 1000, NULL, @w_server, 'S',  @w_path_fuente_REG, @w_path_destino_REG)
GO



GO