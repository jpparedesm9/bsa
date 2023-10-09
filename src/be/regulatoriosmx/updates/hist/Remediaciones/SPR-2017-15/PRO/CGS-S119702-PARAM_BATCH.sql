use cobis
go
DELETE FROM ba_sarta WHERE sa_sarta =5
go

INSERT INTO cobis..ba_sarta ( sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion ) 
VALUES ( 5, 'REPORTES DE CARTERA', 'REPORTES DE CARTERA', getDate(), 'admuser', 36, NULL, NULL )
go

DELETE FROM ba_sarta_batch WHERE sb_sarta =5
go
INSERT INTO ba_sarta_batch ( sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado ) 
VALUES ( 5, 7006, 1, NULL, 'S', 'N', 500, 550, 5, 'S' )
go

INSERT INTO ba_sarta_batch ( sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado ) 
VALUES ( 5, 28537, 2, NULL, 'S', 'N', 2000, 550, 5, 'S' )
go

INSERT INTO ba_sarta_batch ( sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado ) 
VALUES ( 5, 28793, 3, NULL, 'S', 'N', 3500, 550, 5, 'S' )
go

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (5, 36007, 4, NULL, 'S', 'N', 5500, 550, 5, 'S')
go
DELETE FROM ba_enlace WHERE en_sarta =5
go
INSERT INTO ba_enlace ( en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes ) 
VALUES ( 5, 7006, 1, 28537, 2, 'S', NULL, 'N' )
go
INSERT INTO ba_enlace ( en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes ) 
VALUES ( 5, 28537, 2, 28793, 3, 'S', NULL, 'N' )
go
INSERT INTO ba_enlace ( en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes ) 
VALUES ( 5, 28793, 3, 36007, 4, 'S', NULL, 'N' )
go
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES ( 5, 36007, 4, 0, 0, 'S', NULL, 'N')
go

delete from ba_batch where ba_batch in (36007,7006,28537,28793,36007)
go


declare @w_server varchar(24), @w_path_fuente varchar(255), @w_path_destino varchar(255)

select @w_server = pa_char
from cl_parametro 
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, @w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 36

INSERT INTO dbo.ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
		VALUES (36007, 'GENERACION DE REPORTE BURO INTF', 'RGENERACION DE REPORTE BURO INTF', 'SP', getdate(), 36, 'P', 1, 'sb_reporte_buro_cuentas', NULL, 'cob_conta_super..sp_genera_buro', 10000, NULL, @w_server, 'S', @w_path_fuente, @w_path_destino)


INSERT INTO cobis..ba_batch ( ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino ) 
        VALUES ( 7006, 'CONSOLIDADOR CARTERA', 'CONSOLIDADOR CARTERA', 'SP ', getDate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_consolidador', 1, NULL, @w_server, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch ( ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino ) 
        VALUES ( 28537, 'PASO DE DATOS COB_EXTERNOS A TBL DEF COB_CONTA_SUPER', 'PASODE DATOS COB_EXTERNOS A TBL DEF COB_CONTA_SUPER', 'SP ', getDate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_datos_operacion', 1000, NULL, 'CLOUDSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\' )

INSERT INTO cobis..ba_batch ( ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino ) 
        VALUES ( 28793, 'REPORTE OPERATIVO DE CARTERA', 'REPORTE OPERATIVO DE CARTERA', 'SP ', getDate(), 36, 'P', 1, NULL, NULL, 'cob_conta_super..sp_reporte_operativo', 10000, NULL, 'CLOUDSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\' )
go

delete from cobis..ba_parametro where  pa_batch in (select sb_batch from ba_sarta_batch where sb_sarta=5)
go

INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 0, 28537, 0, 1, 'FECHA DE PROCESO', 'D', '05/01/2017' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 0, 28537, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DO' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 0, 28793, 0, 1, 'FECHA PROCESO', 'D', '05/01/2017' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 0, 28793, 0, 2, 'PROCESO', 'I', '28793' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 0, 28793, 0, 3, 'FORMATO FECHA', 'I', '111' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 3, 28537, 23, 1, 'FECHA DE PROCESO', 'D', '06/16/2017' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 3, 28537, 23, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DO' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 4, 28793, 37, 1, 'FECHA PROCESO', 'D', '06/16/2017' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 4, 28793, 37, 2, 'PROCESO', 'I', '28793' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 4, 28793, 37, 3, 'FORMATO FECHA', 'I', '111' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 5, 28537, 2, 1, 'FECHA DE PROCESO', 'D', '06/09/2017' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 5, 28537, 2, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DO' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 5, 28793, 3, 1, 'FECHA PROCESO', 'D', '06/09/2017' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 5, 28793, 3, 2, 'PROCESO', 'I', '28793' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 21006, 28537, 48, 1, 'FECHA DE PROCESO', 'D', '06/09/2017' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 21006, 28537, 48, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DO' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 0, 36007, 4, 1, 'FECHA PROCESO', 'D', '06/16/2017' )
go
INSERT INTO cobis..ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
        VALUES ( 5, 36007, 4, 1, 'FECHA PROCESO', 'D', '06/16/2017' )
go

