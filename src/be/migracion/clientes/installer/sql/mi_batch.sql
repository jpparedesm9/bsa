/************************************************************************/
/*    ARCHIVO:         mi_batch.sql                                     */
/*    NOMBRE LOGICO:   mi_batch.sql                                     */
/*    PRODUCTO:        CLIENTES                                         */
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
/*   Script de creacion sarta y programas para migracion de clientes    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/

USE cobis
go

declare @w_usuario      varchar(60),
        @w_servidor     varchar(100),
        @w_path_destino varchar(100),
        @w_path_fuente  varchar(100),
        @w_sarta        int 

SELECT @w_servidor = pa_char FROM cobis..cl_parametro
WHERE pa_nemonico = 'SCVL' and pa_producto='ADM'

SELECT @w_usuario = 'admuser',
       @w_path_fuente = 'C:/Cobis/vbatch/ahorros/objetos/',
       @w_path_destino = 'C:/Cobis/vbatch/ahorros/listados/',
       @w_sarta = 2000 
        
--Sarta
DELETE FROM ba_sarta where sa_sarta = @w_sarta

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (@w_sarta, 'MIGRACION DE CLIENTES', 'PASO DE CLIENTES DE COB_EXTERNOS A COBIS', getdate(), @w_usuario, 4, NULL, NULL)

--Batch

DELETE FROM ba_batch WHERE ba_batch IN (5002,5003,5004,5005,5006,5007,5008,5009,5010,5011)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5002, 'CARGA DE DATOS CL_ENTE_EXT', 'CARGA DE DATOS CLIENTE', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_cliente_ext', 10000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5003, 'CARGA CL_DIRECCION', 'CARGA CL_DIRECCION', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_cliente_ext', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5004, 'CARGA REFERENCIAS INHIBITORIAS', 'CARGA REFERENCIAS INHIBITORIAS', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_cliente_ext', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5005, 'CARGA TELEFONO', 'CARGA TELEFONO', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_cliente_ext', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5006, 'CARGA REFERENCIA PERSONAL', 'CARGA REFERENCIA PERSONAL', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_cliente_ext', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5007, 'CARGA CL_TRABAJO', 'CARGA CL_TRABAJO', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_cliente_ext', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5011, 'CARGA CL_INSTANCIA', 'CARGA CL_INSTANCIA', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_cliente_ext', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5008, 'CARGA DE DATOS MIG', 'REALIZA LA CARGA DE DATOS A LAS DISTINTAS TABLAS MIG', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_tabla_mig', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5009, 'VALIDACION DE DATOS MIG', 'REALIZA LAS DISTINTAS VALIDACIONES DE LOS DATOS EN LAS TABLAS MIG', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_princ_clientes', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (5010, 'CARGA DE DATOS EN COBIS', 'REALIZA EL PASO DE DATOS A LAS TABLAS EN COBIS', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_externos..sp_carga_cobis', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

--ba_sarta_batch

DELETE ba_sarta_batch WHERE sb_sarta = @w_sarta

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5002, 1, NULL, 'S', 'N', 510, 75, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5003, 2, NULL, 'S', 'N', 510, 900, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5004, 3, NULL, 'S', 'N', 510, 1725, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5005, 4, NULL, 'S', 'N', 510, 2550, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5006, 5, NULL, 'S', 'N', 510, 3375, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5007, 6, NULL, 'S', 'N', 510, 4200, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5011, 7, NULL, 'S', 'N', 510, 5025, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5008, 8, 7, 'S', 'N', 3150, 2175, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5009, 9, 8, 'S', 'N', 4650, 2175, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 5010, 10, 9, 'S', 'N', 6150, 2175, @w_sarta, 'S')

--ba_enlace
DELETE FROM ba_enlace WHERE en_sarta = @w_sarta

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5002, 1, 5008, 8, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5003, 2, 5008, 8, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5004, 3, 5008, 8, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5005, 4, 5008, 8, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5006, 5, 5008, 8, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5007, 6, 5008, 8, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5011, 7, 5008, 8, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5008, 8, 5009, 9, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5009, 9, 5010, 10, 'D', NULL, 'N')

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (@w_sarta, 5010, 10, 0, 0, 'S', NULL, 'N')

--ba_parametro
DELETE FROM ba_parametro WHERE pa_batch IN (5002,5003,5004,5005,5006,5007,5008,5009,5010,5011)

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5002, 0, 1, 'OPERACION', 'C', 'N')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5002, 0, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5002, 0, 3, 'ARCHIVO', 'C', 'cl_ente_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5003, 0, 1, 'OPERACION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5003, 0, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5003, 0, 3, 'ARCHIVO', 'C', 'cl_direccion_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5004, 0, 1, 'OPERACION', 'C', 'R')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5004, 0, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5004, 0, 3, 'ARCHIVO', 'C', 'cl_refinh_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5005, 0, 1, 'OPERACION', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5005, 0, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5005, 0, 3, 'ARCHIVO', 'C', 'cl_telefono_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5006, 0, 1, 'OPERACION', 'C', 'P')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5006, 0, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5006, 0, 3, 'ARCHIVO', 'C', 'cl_ref_personal_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5007, 0, 1, 'OPERACION', 'C', 'B')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5007, 0, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5007, 0, 3, 'ARCHIVO', 'C', 'cl_trabajo_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5011, 0, 1, 'OPERACION', 'C', 'I')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5011, 0, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5011, 0, 3, 'ARCHIVO', 'C', 'cl_instancia_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 5010, 0, 1, 'REINGRESO', 'C', 'S')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5002, 1, 1, 'OPERACION', 'C', 'N')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5002, 1, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5002, 1, 3, 'ARCHIVO', 'C', 'cl_ente_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5003, 2, 1, 'OPERACION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5003, 2, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5003, 2, 3, 'ARCHIVO', 'C', 'cl_direccion_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5004, 3, 1, 'OPERACION', 'C', 'R')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5004, 3, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5004, 3, 3, 'ARCHIVO', 'C', 'cl_refinh_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5005, 4, 1, 'OPERACION', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5005, 4, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5005, 4, 3, 'ARCHIVO', 'C', 'cl_telefono_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5006, 5, 1, 'OPERACION', 'C', 'P')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5006, 5, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5006, 5, 3, 'ARCHIVO', 'C', 'cl_ref_personal_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5007, 6, 1, 'OPERACION', 'C', 'B')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5007, 6, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5007, 6, 3, 'ARCHIVO', 'C', 'cl_trabajo_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5011, 7, 1, 'OPERACION', 'C', 'I')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5011, 7, 2, 'FECHA', 'D', '02/02/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5011, 7, 3, 'ARCHIVO', 'C', 'cl_instancia_ext.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (@w_sarta, 5010, 10, 1, 'REINGRESO', 'C', 'S')

go

