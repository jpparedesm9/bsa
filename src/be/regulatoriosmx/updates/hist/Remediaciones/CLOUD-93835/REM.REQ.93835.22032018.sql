/*************************************************************************************/
--No Historia                : 93835
--Titulo de la Historia      : Interfaz Cobis - Riesgos parte 2
--Fecha                      : 22/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Cambios en sarta 22:
--                             36428: GENERACION ARCHIVO RIESGOS MORA
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cb_batch.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/Activas/Cartera/Backend/sql/Param_Conta_MX
/*************************************************************************************/
use cobis
go

declare @w_secuencial int

DELETE FROM ba_sarta_batch WHERE sb_sarta = 22 AND sb_batch = 36428

DELETE FROM ba_enlace WHERE en_sarta = 22 AND en_batch_inicio = 36428


SELECT @w_secuencial = max(sb_secuencial) + 1 from ba_sarta_batch where sb_sarta = 22

DELETE FROM ba_sarta_batch WHERE sb_sarta = 22 AND sb_batch = 36428 AND sb_secuencial = @w_secuencial

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (22, 36428, @w_secuencial, NULL, 'S', 'N', 3255, 4665, 22, 'S')

DELETE FROM ba_enlace WHERE en_sarta = 22 AND en_batch_inicio = 36428 AND en_secuencial_inicio = @w_secuencial

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (22, 36428, @w_secuencial, 0, 0, 'S', NULL, 'N')
go


DELETE FROM cobis..ba_batch
WHERE ba_batch = 36428
GO

declare @w_server varchar(24), @w_path_fuente varchar(255), @w_path_destino varchar(255)

select @w_server = pa_char
from  cobis..cl_parametro 
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, @w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 36

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36428, 'GENERACION ARCHIVO RIESGOS PROVISION', 'GENERACION ARCHIVO RIESGOS PROVISION', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_PROV', 'cob_conta_super..sp_riesgo_provision', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
GO

insert into cobis..ba_login_batch (lb_login,lb_sarta,lb_batch,lb_fecha_aut,lb_estado,lb_usuario,lb_fecha_ult_mod)
select distinct 'admuser',sb_sarta, sb_batch,getdate(),'V','admuser',getdate()
from ba_sarta_batch
where sb_sarta = 22
and   sb_batch = 36428
GO

insert into ba_sarta_batch_exec (sb_sarta,sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, sb_adicionado, sb_id_proceso, sb_imprimir)
select sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion,sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,'N', null, 0
from ba_sarta_batch
where sb_sarta = 22
and   sb_batch = 36428
GO

