use cobis
go

declare @w_server varchar(24), 
        @w_path_fuente varchar(255), 
        @w_path_destino varchar(255),
        @w_path_fuente_CCA varchar(255),
        @w_path_destino_CCA varchar(255),
        @w_path_fuente_REG varchar(255),
        @w_path_destino_REG varchar(255),
        @w_sec INT
        

select @w_server = pa_char
from cl_parametro 
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, @w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 6

DELETE from ba_batch where ba_batch = 6078

INSERT INTO ba_batch(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES(6078, 'CIERRE DE CUENTAS P Y G', 'CIERRE PDE CUENTAS P Y G', 'SP', getdate(), 6, 'P', 1, 'CUENTAS', NULL, 'cob_conta..sp_finpe_mx', 1000, NULL, @w_server, 'S', @w_path_fuente, @w_path_destino)

SELECT @w_sec = max(sb_secuencial) FROM cobis..ba_sarta_batch WHERE sb_sarta = 13 
SELECT @w_sec = @w_sec + 1

DELETE ba_sarta_batch  where sb_sarta = 13 and   sb_batch = 6078

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (13, 6078, @w_sec, NULL, 'S', 'N', 480, 450, 13,'S')

DELETE from ba_parametro where pa_batch     = 6078

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
VALUES (13, 6078, @w_sec, 1, 'EMPRESA', 'I', '1')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
VALUES (0, 6078, 0, 1, 'EMPRESA', 'I', '1')


DELETE cobis..ba_enlace WHERE en_sarta = 13 AND en_batch_inicio = 6078

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (13, 6078, @w_sec, 0, 0, 'S', NULL, 'N')

GO

