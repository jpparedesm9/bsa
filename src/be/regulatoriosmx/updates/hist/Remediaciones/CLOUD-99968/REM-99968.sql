use cob_cartera
go

create table seguros_funeral_net_altas_tmp
( 
 ra_identificador  		varchar(100)    null,
 ra_apellido_paterno   	varchar(100)	null,
 ra_apellido_materno   	varchar(100)	null,
 ra_nombre				varchar(100)	null,
 ra_fecha_de_emision	varchar(100)	null,
 ra_edad				varchar(100)  	null
)

go

create table seguros_funeral_net_bajas_tmp
( 
 ra_identificador  		varchar(100)    null,
 ra_fecha_de_baja		varchar(100)    null
)

go

insert into cobis..cl_parametro
values ('DIA DE GENERACION REPORTE SEGUROS FUNERAL NET BAJAS', 'DGRFNB','I',NULL,NULL,NULL,25,NULL,NULL,NULL,'CCA')


/*Registro de batch*/
use cobis
go

declare @w_server varchar(24),
        @w_path_fuente_CCA varchar(255),
        @w_path_destino_CCA varchar(255),
		@w_secuencial int,
		@w_siguiente int
		
select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente_CCA = pp_path_fuente, @w_path_destino_CCA = pp_path_destino
from ba_path_pro
where pp_producto = 7

select @w_secuencial = max(sb_secuencial) from cobis..ba_sarta_batch
where sb_sarta = 13

select @w_secuencial = @w_secuencial + 1	
select @w_siguiente = @w_secuencial + 1	
		
--batch
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7192, 'REPORTE SEGUROS FUNERAL NET ALTAS', 'REPORTE SEGUROS FUNERAL NET ALTAS', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_seguro_funeral_net_altas', 1, NULL, @w_server, 'S', @w_path_fuente_CCA, @w_path_destino_CCA)

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7193, 'REPORTE SEGUROS FUNERAL NET BAJAS', 'REPORTE SEGUROS FUNERAL NET BAJAS', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_seguro_funeral_net_bajas', 1, NULL, @w_server, 'S', @w_path_fuente_CCA, @w_path_destino_CCA)

--ba_sarta_batch
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (13, 7192, @w_secuencial, NULL, 'S', 'N', 10155, 4635, 13, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (13, 7193, @w_siguiente, NULL, 'S', 'N', 11445, 4635, 13, 'S')

--ba_parametro
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7192, 0, 1, 'FECHA_PROCESO', 'D', '09/20/2017')
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7193, 0, 1, 'FECHA_PROCESO', 'D', '09/20/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (13, 7192, @w_secuencial, 1, 'FECHA_PROCESO', 'D', '09/20/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (13, 7193, @w_siguiente, 1, 'FECHA_PROCESO', 'D', '09/20/2017')

--ba_enlace
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
 VALUES (13, 7192, @w_secuencial, 7193, @w_siguiente, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
 VALUES (13, 7193, @w_siguiente, 0, 0, 'S', NULL, 'N')

 go
 