/************************************************************************/
/*      Archivo         :  ba_batch.sql                                 */
/*      Base de datos   :  cobis                                        */
/*      Producto        :  Batch                                        */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp. Su uso no autorizado queda expresamente prohibido        */
/*  asi como cualquier alteracion o agregado hecho por alguno de        */
/*  sus usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA           AUTOR                  RAZON                        */
/*  10/05/2012      Isaac Torres           Emision Inicial              */
/*  17/07/2013      Juan Tagle             Se agrega 8004 en lote 8002  */
/*  06/10/2013      Jorge Salazar          CGS-S138784                  */
/************************************************************************/

use cobis
go

use cobis
go

DELETE FROM ba_sarta WHERE sa_sarta IN (8001,8002,8003,8005,8006)

DELETE FROM ba_sarta_batch WHERE sb_sarta IN (8001,8002,8003,8005,8006)

DELETE FROM ba_enlace WHERE en_sarta IN (8001,8002,8003,8005,8006)

DELETE FROM ba_parametro
WHERE pa_sarta IN (0,8001,8002,8003,8005,8006)
AND   pa_batch IN (8001,8002,8003,8005,8006)
GO


--SARTA 8001: DESHABILITAR PRODUCTOS
INSERT INTO ba_sarta(sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES(8001, 'DESHABILITAR PRODUCTOS', 'DESHABILITAR PRODUCTOS', getdate(), 'admuser', 8, NULL, NULL)
GO

INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (8001, 8001, 1, NULL, 'S', 'N', 500, 550, 8001, 'S' )
GO

INSERT INTO ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES(8001, 8001, 1, 0, 0, 'S', NULL, 'N')
GO

--SARTA 8002: DESHABILITAR PRODUCTOS
INSERT INTO ba_sarta(sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES(8002, 'HABILITAR PRODUCTOS', 'HABILITAR PRODUCTOS', getdate(), 'admuser', 8, NULL, NULL)
GO

INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (8002, 8002, 1, NULL, 'S', 'N', 500, 550, 8002, 'S' )
GO

INSERT INTO ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES(8002, 8002, 1, 0, 0, 'S', NULL, 'N')
GO

--SARTA 8003: PASO A HISTORICO
INSERT INTO ba_sarta(sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES(8003, 'PASO A HISTORICO', 'PASO A HISTORICO DE LOGS DE ERRORES DE BATCH', getdate(), 'admuser', 8, NULL, NULL)
GO

INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (8003, 8003, 1, NULL, 'S', 'N', 500, 550, 8003, 'S' )
GO

INSERT INTO ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES(8003, 8003, 1, 0, 0, 'S', NULL, 'N')
GO

INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES(0, 8003, 0, 1, N'@i_fecha_proceso', N'D', NULL)

INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES(8003, 8003, 1, 1, N'@i_fecha_proceso', N'D', NULL)
GO

--SARTA 8005: RESPALDOS DE BASES DE DATOS ANTES DE FIN DE DIA
INSERT INTO ba_sarta(sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES(8005, 'RESPALDOS DE BASES DE DATOS ANTES DE FIN DE DIA', 'BACKUPS FULL DE LAS BASES DE DATOS DEL SYBASE Y DE SQL SERVER', getdate(), 'admuser', 8, NULL, NULL)
GO

INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (8005, 8005, 1, NULL, 'S', 'N', 500, 550, 8005, 'S' )
GO

INSERT INTO ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES(8005, 8005, 1, 0, 0, 'S', NULL, 'N')
GO

--SARTA 8006: RESPALDOS DE BASES DE DATOS INICIO DE DIA
INSERT INTO ba_sarta(sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES(8006, 'RESPALDOS DE BASES DE DATOS POST INICIO DE DIA', 'BACKUPS FULL DE LAS BASES DE DATOS DEL SYBASE Y DE SQL SERVER', getdate(), 'admuser', 8, NULL, NULL)
GO

INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (8006, 8006, 1, NULL, 'S', 'N', 500, 550, 8006, 'S' )
GO

INSERT INTO ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES(8006, 8006, 1, 0, 0, 'S', NULL, 'N')
GO

/*SE AUTORIZA LA SARTA PARA EL USUARIO ADMUSER*/
delete from cobis..ba_login_batch where lb_sarta in (8001,8002,8003,8005,8006)
insert into cobis..ba_login_batch (lb_login,lb_sarta,lb_batch,lb_fecha_aut,lb_estado,lb_usuario,lb_fecha_ult_mod)
select  distinct 'admuser',sb_sarta, sb_batch,getdate(),'V','admuser',getdate() from ba_sarta_batch where sb_sarta in (8001,8002,8003,8005,8006)
GO



print '----->  ba_batch'
go

PRINT 'INSERCION: ba_path_pro'
delete ba_path_pro where pp_producto = 8
go

insert into ba_path_pro values (8, 'C:\Cobis\vbatch\objetos\', 'C:\Cobis\vbatch\listados\')
go

delete ba_batch where ba_batch in (8001,8002,8003,8005,8006,8007,8008)
go

declare @w_server varchar(24), @w_path_fuente varchar(255), @w_path_destino varchar(255)

select @w_server = pa_char
from cl_parametro 
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, @w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 8



PRINT 'INSERCION: ba_batch'

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
values(8001, 'DESHABILITAR PRODUCTOS','DESHABILITAR PRODUCTOS', 'SP', GETDATE(), 8,
       'P', 1, 'PRODUCTOS', NULL, 'cobis..sp_ba_deshabilita_ej', 
       50,'lp', @w_server,'S', @w_path_fuente, null)

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
values(8002, 'HABILITAR PRODUCTOS','HABILITAR PRODUCTOS', 'SP', GETDATE(), 8,
       'P', 1, 'PRODUCTOS', NULL, 'cobis..sp_ba_habilita_ej', 
       50,'lp', @w_server,'S', @w_path_fuente, null)

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
values(8003, 'PASO A HISTORICO','PASO A HISTORICO DE LOGS DE ERRORES DE BATCH', 'SP', GETDATE(), 8,
       'P', 1, 'PRODUCTOS', NULL, 'cobis..sp_ba_error_his', 
       50,'lp', @w_server,'S', @w_path_fuente, null)

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
values(8005, 'RESPALDOS DE BASES DE DATOS ANTES DE FIN DE DIA','BACKUPS FULL DE LAS BASES DE DATOS DEL SYBASE Y DE SQL SERVER', 'SP', GETDATE(), 8,
       'P', 1, 'PRODUCTOS', NULL, 'cobis..sp_ba_respaldo_sql_ej', 
       50,'lp', @w_server,'S', @w_path_fuente, null)

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
values(8006, 'RESPALDOS DE BASES DE DATOS DESPUES DE FIN DE DIA','BACKUPS FULL DE LAS BASES DE DATOS DEL SYBASE Y DE SQL SERVER', 'SP', GETDATE(), 8,
       'P', 1, 'PRODUCTOS', NULL, 'cobis..sp_ba_respaldo_sql_ej', 
       50,'lp', @w_server,'S', @w_path_fuente, null)

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
values(8008, 'RESPALDOS DE BASE SQLSERVER CANALES','RESPALDOS DE LAS BASES DE DATOS EN EL SERVIDOR BRANCH DE CANALES', 'SP', GETDATE(), 8,
       'P', 1, 'PRODUCTOS', NULL, 'cobis..sp_ba_respaldo_sql_ej', 
       50,'lp', @w_server,'S', @w_path_fuente, null)
       
select @w_server = pa_char
from   cl_parametro 
where  pa_producto = 'ADM'
and    pa_nemonico = 'SRVDW'

insert into ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,
                      ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,
                      ba_frec_reg_proc,ba_impresora,  
                      ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino)
values(8007, 'RESPALDOS DE BASE SQLSERVER BODEGA','RESPALDOS DE LAS BASES DE DATOS EN EL SERVIDOR BRANCH DE BODEGA', 'SP', GETDATE(), 8,
       'P', 1, 'PRODUCTOS', NULL, 'cobis..sp_ba_respaldo_sql_ej', 
       50,'lp', @w_server,'S', @w_path_fuente, null)
go
