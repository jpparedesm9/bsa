/***********************************************************************************************************/

---Fecha					: 01/09/2016 
--Descripción               : script para la Historia 81552
--Descripción de la Solución: Proceso masivo de transacciones - Batch
--Autor						: Tania Baidal
/***********************************************************************************************************/

---------------------------------------------------------------------------------------------------------------
--SARTA EVENTUAL PARA AUTORIZACION DE PRODUCTOS BANCARIOS------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--ah_batch
use cobis
go
delete from cobis..ba_sarta where sa_sarta in (4003)
go
declare @w_usuario varchar(64)       

select @w_usuario = 'operador'

insert into cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
values (4003, 'EVENTUAL AHORROS', 'EVENTUAL AHORROS', '2016-07-21 12:00:00.733', @w_usuario, 4, NULL, NULL)

delete ba_batch where ba_batch in (4261, 4276)
go
declare @w_servidor   varchar(30), @w_path_fuente varchar(50), @w_path_destino  varchar(50)

select @w_servidor = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and pa_nemonico = 'SRVR'

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 4

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/ahorros/listados/')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 4

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/data/objetos')

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4261, 'PROCESO PARA AUTORIZAR PRODUCTO POR OFICIN', 'PROCESO PARA AUTORIZAR PRODUCTO POR OFICIN', 'SP', getdate(), 4, 'P', 1, 'cob_remesas..pe_oficina_autorizada', NULL, 'cob_ahorros..sp_aut_prod_ofi', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4276, 'PROCESO MASIVO DE TRANSACCIONES DE DEPOSITO, RETIRO, ND Y NC', 'PROCESO MASIVO DE TRANSACCIONES DE DEPOSITO, RETIRO, ND Y NC CARGADAS DESDE UN ARCHIVO PLANO', 'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES', NULL, 'cob_ahorros..sp_pro_mas_tran', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
go

delete from cobis..ba_sarta_batch where sb_sarta in (4003)
go

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4003, 4261, 1, null, 'S', 'N', 465, 600, 4003, 'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4003, 4276, 2, null, 'S', 'N', 1965, 600, 4003, 'S')
go


delete FROM cobis..ba_parametro WHERE pa_sarta in (4003) 
                                  AND pa_batch in (4261, 4276)
delete FROM cobis..ba_parametro WHERE pa_batch in (4261, 4276) and  pa_sarta in (0) 
go					
	
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 1, 'PRODUCTO BANCARIO', 'I', '0')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 2, 'FECHA', 'D', getDate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 3, 'OFICINA', 'I', '0')


INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 2, 'FECHA_PROCESO', 'D', getDate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 3, 'RUTA_ARCHIVOS', 'C', 'C:/Cobis/vbatch/ahorros/listados/')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 4, 'NOMBRE_ARCHIVO_TRAN', 'C', '12312016_OFI_TRAN.txt')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 5, 'NOMBRE_ARCHIVO_CHQ', 'C', '12312016_OFI_CHQ.txt')

--4003
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4261, 1, 1, 'PRODUCTO BANCARIO', 'I', '4')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4261, 1, 2, 'FECHA', 'D', getDate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4261, 1, 3, 'OFICINA', 'I', '7036')


INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 2, 'FECHA_PROCESO', 'D', getDate())

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 3, 'RUTA_ARCHIVOS', 'C', 'C:/Cobis/vbatch/ahorros/listados/')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 4, 'NOMBRE_ARCHIVO_TRAN', 'C', '12312016_OFI_TRAN.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 5, 'NOMBRE_ARCHIVO_CHQ', 'C', '12312016_OFI_CHQ.txt')

go

delete from cobis..ba_enlace where en_sarta=4003
go

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4003, 4261, 1, 4276, 2, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4003, 4276, 2, 0, 0, 'S', NULL, 'N')

go

