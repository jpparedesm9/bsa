
/************************************************************************/
/*    ARCHIVO:         reg_batch.sql                                    */
/*    NOMBRE LOGICO:   reg_batch.sql                                    */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de creacion sarta y programas para envio de notificacion    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/*      31/08/2016      Jorge Salazar           AHO-H81321-Reporte R08  */  
/*      23/12/2016      Karen Meza        H92215 REPORTE BURO DE CR?ITO*/
/************************************************************************/

--USE cobis
--go
--
--declare @w_usuario       varchar(60),
--        @w_servidor      varchar(100),
--        @w_path_destino  varchar(100),
--        @w_path_fuente   varchar(100),
--        @w_producto      int,
--        @w_fecha_proceso datetime
--
--select  @w_usuario      = 'admuser',
--        @w_producto     = 36

--Fecha cierre
--delete cobis..ba_fecha_cierre where fc_producto = @w_producto
--
--select @w_fecha_proceso = isnull(fp_fecha, getdate()) from ba_fecha_proceso   
--
--insert into cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
--values (@w_producto, @w_fecha_proceso, null)

--Path de producto
--delete cobis..ba_path_pro where pp_producto = @w_producto
--
--insert into cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
--values (@w_producto, 'C:/Cobis/vbatch/Regulatorios/objetos/', 'C:/Cobis/vbatch/Regulatorios/listados/')
--
--select @w_servidor = pa_char
--  from cobis..cl_parametro
-- where pa_producto = 'ADM'
--   and pa_nemonico = 'SRVR'
--
--select @w_path_destino = pp_path_destino
--  from ba_path_pro
-- where pp_producto = @w_producto
--
--select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/Regulatorios/objetos/')
--
--select @w_path_fuente = pp_path_fuente
--  from ba_path_pro
-- where pp_producto = @w_producto
--
--select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/Regulatorios/listados/')
       
--Sarta
--DELETE FROM ba_sarta where sa_sarta = 36006
--
--INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
--VALUES (36006, 'ENVIO DE LISTA DE CLIENTES AL OFICIAL DE CUMPLIMIENTO', 'ENVIO DE LISTA DE CLIENTES AL OFICIAL DE CUMPLIMIENTO', getdate(), @w_usuario, @w_producto, NULL, NULL)

--Batch

--DELETE FROM ba_batch WHERE ba_batch IN (36002,36003)
--
--INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
--VALUES (36002, 'CARGA DE DATOS DE TRANSACCIONES POR LAVADO DE DINERO', 'CARGA DE DATOS DE TRANSACCIONES POR LAVADO DE DINERO', 'SP', getdate(), @w_producto, 'P', 1, NULL, NULL, 'cob_conta_super..sp_consulta_monetarias', 10000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
--
--INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
--VALUES (36003, 'ENVIO DE CORREO AL OFICIAL DE CUMPLIMIENTO', 'REALIZA EL ENVIO DE CORREO AL OFICIAL DE CUMPLIMIENTO', 'SP', getdate(), @w_producto, 'P', 1, NULL, NULL, 'cob_conta_super..sp_envio_notificacion', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)


--ba_sarta_batch

--DELETE ba_sarta_batch WHERE sb_sarta = 36006
--
--INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
--VALUES (36006, 36002, 1, NULL, 'S', 'N', 510, 645, 36006, 'S')
--GO
--
--INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
--VALUES (36006, 36003, 2, NULL, 'S', 'N', 2010, 645, 36006, 'S')
--GO


--ba_enlace
--DELETE FROM ba_enlace WHERE en_sarta = 36006
--
--INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
--VALUES (36006, 36002, 1, 36003, 2, 'S', NULL, 'N')
--GO
--
--INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
--VALUES (36006, 36003, 2, 0, 0, 'S', NULL, 'N')
--GO

--ba_parametro
--DELETE FROM ba_parametro WHERE pa_batch IN (36002,36003)
--
--INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
--VALUES (0, 36002, 0, 1, 'FECHA_PROCESO', 'D', '08/06/2016')
--GO

--INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
--VALUES (0, 36002, 0, 2, 'APLICATIVO', 'I', '4')
--GO

--INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
--VALUES (0, 36003, 0, 1, 'FECHA_PROCESO', 'D', '08/06/2016')
--GO
--
--INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
--VALUES (36006, 36002, 1, 1, 'FECHA_PROCESO', 'D', '08/06/2016')
--GO

--INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
--VALUES (36006, 36002, 1, 2, 'APLICATIVO', 'I', '4')
--GO

--INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
--VALUES (36006, 36003, 2, 1, 'FECHA_PROCESO', 'D', '08/06/2016')
--GO


/*************************************************************************************/
--No Historia				 : H81321
--T?tulo de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/31/2016
--Descripci?n del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripci?n de la Soluci?n : Creacion de la sarta 36005: REPORTES TRIMESTRALES REC
--Autor						 : Jorge Salazar Andrade
--Instalador                 : reg_batch.sql
/*************************************************************************************/
use cobis
go

declare @w_usuario       varchar(60),
        @w_servidor      varchar(100),
        @w_path_destino  varchar(100),
        @w_path_fuente   varchar(100),
        @w_producto      int

select  @w_usuario      = 'admuser',
        @w_producto     = 36

--Path de producto
select @w_servidor = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

select @w_path_destino = pp_path_destino
  from ba_path_pro
 where pp_producto = @w_producto

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/Regulatorios/objetos/')

select @w_path_fuente = pp_path_fuente
  from ba_path_pro
 where pp_producto = @w_producto

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/Regulatorios/listados/')

--Sarta 36005
delete from ba_sarta where sa_sarta = 36005

insert into cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
values (36005, 'REPORTES REGULATORIOS REC', 'REPORTES REGULATORIOS REC', getdate(), @w_usuario, @w_producto, null, null)

--Batch 36001

delete from ba_batch where ba_batch in (36001,  36004,   36005,   36006,   36002,
                                        36003,  21057,   21058,   21059,   36423,
                                        152026, 36432,   28796,   28797,   28798)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (36001, 'REPORTE REGULATORIO R08 CAPTACION SOCAP', 'REPORTE REGULATORIO R08 CAPTACION SOCAP', 'SP', getdate(), @w_producto, 'P', 1, null, null, 'cob_conta_super..sp_reporte_r08', 10000, null, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36004, 'GENERACION DE REPORTE DE LAVADO DE DINERO MENSUAL', 'GENERACION DE REPORTE DE LAVADO DE DINERO INUSUALES - PREOCUPANTES', 'SP', getdate(), @w_producto, 'P', 1, 'ah_reporte_operacrelev', NULL, 'cob_conta_super..sp_reporte_reg_operelv', 10000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36005, 'GENERACION DE REPORTE DE LAVADO DE DINERO TRIMESTRAL', 'GENERACION DE REPORTE DE LAVADO DE DINERO RELEVANTES', 'SP', getdate(), @w_producto, 'P', 1, 'ah_reporte_operacrelev', NULL, 'cob_conta_super..sp_reporte_reg_operelv', 10000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36006, 'GENERACION DE REPORTE DE LAVADO DE DINERO 24H', 'GENERACION DE REPORTE DE LAVADO DE DINERO 24H', 'SP', getdate(), @w_producto, 'P', 1, 'ah_reporte_operacrelev', NULL, 'cob_conta_super..sp_reporte_reg_operelv', 10000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21057, 'REPORTE REGULATORIO R0451', 'REPORTE REGULATORIO R0451 DESAGREGADO DE CREDITO', 'SP', getdate(), 36, 'P', 3, NULL, NULL, 'cob_conta_super..sp_reporte_r0451', 10000, NULL, @w_servidor, 'S', 'C:/Cobis/vbatch/Regulatorios/objetos/', NULL)

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21058, 'REPORTE REGULATORIO R0453', 'REPORTE REGULATORIO R0451 DESAGREGADO DE CARTERA DE CREDITO CASTIGADA', 'SP', getdate(), 36, 'P', 3, NULL, NULL, 'cob_conta_super..sp_reporte_r0453', 10000, NULL, @w_servidor, 'S', 'C:/Cobis/vbatch/Regulatorios/objetos/', NULL)

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21059, 'GENERACION DE REPORTE PARA EL BURO DE CREDITO', 'GENERACION DE REPORTE PARA EL BURO DE CREDITO', 'SP', getdate(), 36, 'P', 1, 'sb_reporte_buro_credito', NULL, 'cob_conta_super..sp_ca_burocred', 100000, NULL, @w_servidor, 'S', 'C:/Cobis/vbatch/cartera/objetos/', 'C:/Cobis/vbatch/cartera/listados/')

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36002, 'CARGA DE DATOS DE TRANSACCIONES POR LAVADO DE DINERO', 'CARGA DE DATOS DE TRANSACCIONES POR LAVADO DE DINERO', 'SP', getdate(), 36, 'P', 1, NULL, NULL, 'cob_conta_super..sp_consulta_monetarias', 10000, NULL, @w_servidor, 'S', 'C:/Cobis/vbatch/Regulatorios/objetos/', 'C:/Cobis/vbatch/Regulatorios/listados/')

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36003, 'ENVIO DE CORREO AL OFICIAL DE CUMPLIMIENTO', 'REALIZA EL ENVIO DE CORREO AL OFICIAL DE CUMPLIMIENTO', 'SP', getdate(), 36, 'P', 1, NULL, NULL, 'cob_conta_super..sp_envio_notificacion', 1000, NULL, @w_servidor, 'S', 'C:/Cobis/vbatch/Regulatorios/objetos/', 'C:/Cobis/vbatch/Regulatorios/listados/')

insert into cobis..ba_batch 
(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36423,  'REPORTE RIESGO PROVISIONES LCR', 'REPORTE RIESGO PROVISIONES LCR','SP', getdate(), 36, 'P', 1, 'REGULATORIOS',null,'cob_conta_super..sp_lcr_riesgo_prov', 1,   null, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (152026, 'REPORTES IMPACTO SOCIAL', 'COMPORTAMIENTO DE CLIENTES ACTIVOS Y PROSPECTOS; E INVENTARIO DE CLIENTES Y PROSPECTOS', 'SP', getdate(), 7, 'P', 1, NULL, NULL, 'cob_conta_super..sp_rpt_comp_clientes_act', 10000, NULL, @w_servidor, 'S', 'C:/Cobis/VBatch/Cartera/listados/Impacto_Social/', 'C:\Cobis\VBatch\Cartera\listados\Impacto_Social' + char(92))

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (36432, 'ACTUALIZA EXPERIENCIA CRED', 'ACTUALIZA EXPERIENCIA DE CREDITICIA', 'SP', getdate(), 36, 'P', 1, null, null, 'cob_conta_super..sp_act_experiencia_cred', 10000, null, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28796, 'REPORTE CLIENTES EN MOROSIDAD', 'REPORTE CLIENTES EN MOROSIDAD', 'SP', getdate(), @w_producto, 'P', 1, NULL, 'ASIGNA_DESP', 'cob_conta_super..sp_reporte_morosidad', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\Asignaciones\')

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28797, 'REPORTE DETALLE TELEFONO DOMICILIO', 'REPORTE DETALLE TELEFONO DOMICILIO', 'SP', getdate(), @w_producto, 'P', 1, NULL, 'TEL_ASIGNA', 'cob_conta_super..sp_reporte_telf_domicilio', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\Asignaciones\')

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28798, 'REPORTE DE ASIGNACIONES, SEGUNDA PARTE', 'REPORTE DE ASIGNACIONES, SEGUNDA PARTE', 'SP', getdate(), @w_producto, 'P', 1, NULL, 'ASIGNAMORA_DESP', 'cob_conta_super..sp_reporte_asigna_mora', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\Asignaciones\')



--ba_sarta_batch 36005

delete ba_sarta_batch where sb_sarta = 36005

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 36001, 1, NULL, 'S', 'N', 3465, 705, 36005, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 36004, 2, NULL, 'S', 'N', 4965, 690, 36005, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 36005, 3, NULL, 'S', 'N', 6435, 675, 36005, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 36006, 4, NULL, 'S', 'N', 7965, 660, 36005, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 36002, 5, NULL, 'S', 'N', 465, 720, 36005, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 36003, 6, NULL, 'S', 'N', 1965, 720, 36005, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 21057, 7, NULL, 'S', 'N', 9405, 675, 36005, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 21058, 8, NULL, 'S', 'N', 10875, 660, 36005, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (36005, 21059, 9, NULL, 'S', 'N', 12360, 675, 36005, 'S')
GO

--ba_enlace
DELETE FROM ba_enlace WHERE en_sarta = 36005

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 36001, 1, 36004, 2, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 36004, 2, 36005, 3, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 36005, 3, 36006, 4, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 36006, 4, 21057, 7, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 36002, 5, 36003, 6, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 36003, 6, 36001, 1, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 21057, 7, 21058, 8, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 21058, 8, 21059, 9, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 21059, 9, 0, 0, 'S', NULL, 'N')
GO



--ba_parametro 36005, 36001
delete from ba_parametro where pa_batch in (36001,  36004,   36005,   36006,   36002,
                                        36003,  21057,   21058,   21059, 36423)
                               and pa_sarta in (0,36005)

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21057, 0, 1, 'FECHA PROCESO', 'D', '08/09/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21057, 0, 2, 'PERIODICIDAD', 'I', '3')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21058, 0, 1, 'FECHA PROCESO', 'D', '08/09/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21058, 0, 2, 'PERIODICIDAD', 'I', '3')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21059, 0, 1, 'FECHA', 'D', '06/30/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36001, 0, 1, 'FECHA PROCESO', 'D', '08/09/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36001, 0, 2, 'PERIODICIDAD', 'I', '3')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36002, 0, 1, 'FECHA_PROCESO', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36003, 0, 1, 'FECHA_PROCESO', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36004, 0, 1, 'OPERACION', 'I', '2')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36004, 0, 2, 'FECHA', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36004, 0, 3, '24H', 'C', 'N')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36005, 0, 1, 'OPERACION', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36005, 0, 2, 'FECHA', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36005, 0, 3, '24H', 'C', 'N')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36006, 0, 1, 'OPERACION', 'I', '2')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36006, 0, 2, 'FECHA', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 36006, 0, 3, '24H', 'C', 'S')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36001, 1, 1, 'FECHA PROCESO', 'D', '08/09/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36001, 1, 2, 'PERIODICIDAD', 'I', '3')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36004, 2, 1, 'OPERACION', 'I', '2')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36004, 2, 2, 'FECHA', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36004, 2, 3, '24H', 'C', 'N')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36005, 3, 1, 'OPERACION', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36005, 3, 2, 'FECHA', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36005, 3, 3, '24H', 'C', 'N')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36006, 4, 1, 'OPERACION', 'I', '2')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36006, 4, 2, 'FECHA', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36006, 4, 3, '24H', 'C', 'S')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36002, 5, 1, 'FECHA_PROCESO', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 36003, 6, 1, 'FECHA_PROCESO', 'D', '08/06/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 21057, 7, 1, 'FECHA PROCESO', 'D', '08/09/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 21057, 7, 2, 'PERIODICIDAD', 'I', '3')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 21058, 8, 1, 'FECHA PROCESO', 'D', '08/09/2016')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 21058, 8, 2, 'PERIODICIDAD', 'I', '3')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (36005, 21059, 9, 1, 'FECHA', 'D', '06/30/2016')
GO

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 36423, 0, 1, 'param1', 'D', '09/19/2017')


GO

/*************************************************************************************/
--No Historia				 : H92215
--T?tulo de la Historia		 : REPORTE BUR? DE CR?DITO(MX)
--Fecha					     : 23/12/2016
--Descripci?n del Problema	 : Se requiere para la versi?n MX, el reporte de Bur? de Cr?dito 
--Descripci?n de la Soluci?n : Creacion del programa 21059 ubicado en la sarta 36007
--Autor						 : Karen Meza
--Instalador                 : reg_batch.sql
/*************************************************************************************/



--
--
--USE cobis
--go
--
--declare @w_usuario       varchar(60),
--        @w_servidor      varchar(100),
--        @w_path_destino  varchar(100),
--        @w_path_fuente   varchar(100),
--        @w_producto      int,
--        @w_fecha_proceso datetime
--
--select  @w_usuario      = 'admuser',
--        @w_producto     = 36
--
----Fecha cierre
--delete cobis..ba_fecha_cierre where fc_producto = @w_producto
--
--select @w_fecha_proceso = isnull(fp_fecha, getdate()) from ba_fecha_proceso   
--
--insert into cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
--values (@w_producto, @w_fecha_proceso, null)
--
----Path de producto
--delete cobis..ba_path_pro where pp_producto = @w_producto
--
--insert into cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
--values (@w_producto, 'C:/Cobis/vbatch/cartera/objetos/', 'C:/Cobis/vbatch/cartera/listados/')
--
--select @w_servidor = pa_char
--  from cobis..cl_parametro
-- where pa_producto = 'ADM'
--   and pa_nemonico = 'SRVR'
--
--select @w_path_destino = pp_path_destino
--  from ba_path_pro
-- where pp_producto = @w_producto
--
--select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/cartera/objetos/')
--
--select @w_path_fuente = pp_path_fuente
--  from ba_path_pro
-- where pp_producto = @w_producto
--
--select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/cartera/listados/')
--       
----Batch
--
--if exists (select 1 from cobis..ba_batch where ba_batch= 21059 )
--begin
-- delete cobis..ba_batch where ba_batch= 21059
--end
--
--
--INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
--VALUES (21059, 'GENERACION DE REPORTE PARA EL BURO DE CREDITO', 'GENERACION DE REPORTE PARA EL BURO DE CREDITO', 'SP', getdate(), @w_producto, 'P', 1, 'sb_reporte_buro_credito', NULL, 'cob_conta_super..sp_ca_burocred', 100000, NULL, @w_servidor, 'S',  @w_path_fuente, @w_path_destino)
--GO
--
----ba_sarta_batch
--
--if exists (select 1 from cobis..ba_sarta_batch where sb_batch= 21059 )
--begin
-- delete cobis..ba_sarta_batch where sb_batch= 21059
--end
--
--INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
--VALUES (36007, 21059, 5, NULL, 'S', 'N', 6500, 550, 36007, 'S')
--
--
----ba_enlace
--
--DELETE FROM ba_enlace WHERE en_sarta = 36006
--
--
--if exists (select 1 from cobis..ba_enlace where en_batch_inicio = 21059 and en_sarta = 36007 )
--begin
-- delete cobis..ba_enlace where en_batch_inicio = 21059 and en_sarta = 36007
--end
--
--INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
--VALUES (36007, 21059, 5, 0, 0, 'S', NULL, 'N')
--GO
----ba_parametro
--if exists (select 1 from cobis..ba_parametro where pa_batch = 21059)
--begin
-- delete cobis..ba_parametro where  pa_batch = 21059
--end
--
--INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
--VALUES (0, 21059, 0, 1, 'FECHA', 'D', '06/30/2016')
--GO
--
--INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
--VALUES (36007, 21059, 5, 1, 'FECHA', 'D', '06/30/2016')
--GO
--
--


delete from ba_batch where ba_batch= 287934
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (287934, 'REPORTE CASTIGOS Y CONDONACIONES', 'REPORTE CASTIGOS Y CONDONACIONES', 'SP', getDATE(), 36, 'P', 1, NULL, 'Integracion_COBIS_', 'cob_conta_super..sp_reporte_castigos_condonaciones', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

if not exists (select 1 from ba_parametro where pa_batch = 287934 and pa_nombre = 'FECHA PROCESO' )
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 287934, 0, 1, 'FECHA PROCESO', 'D', '12/01/2020')

go
