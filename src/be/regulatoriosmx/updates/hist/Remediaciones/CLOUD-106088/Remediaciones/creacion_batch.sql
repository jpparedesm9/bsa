/*************************************************************************/
/*   Archivo:              creacion_batch.sql                        */
/*   Base de datos:        cobis                                         */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Raymundo Picazo - Sonia Rojas                 */                          
/*   Fecha de escritura:   Enero 2019                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/* Este programa es el batch para Generar reporte regulatorio de baxico  */
/*                                                                       */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    21/Enero/2019           RPA              emision inicial           */
/*    08/Febrero/2019         RPA              actualizacion de batch    */
/*                                                                       */
/*************************************************************************/


use cobis
go

DECLARE 
@w_server varchar(24) = null,
@w_path_fuente  varchar(255) = null,
@w_path_destino varchar(255) = null,
@w_sarta int = 22,
@w_batch int = 36430,
@w_secuencial int = 48,
@w_ba_producto int = 36,
@w_batch_v        	int = 36424,
@w_secuencial_v     int = 22

select @w_server = pa_char
from   cobis.. cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, 
       @w_path_destino = pp_path_destino
from   ba_path_pro
where  pp_producto = @w_ba_producto

--select @w_secuencial max(sb_secuencial +1) from ba_sarta_batch WHERE sb_sarta = 22

--BA_BATCH --36430
IF EXISTS (select 1 from ba_batch WHERE ba_batch = @w_batch)
   delete ba_batch WHERE ba_batch = @w_batch  
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
      values (@w_batch, 'REPORTE BANXICO', 'REPORTE BANXICO', 'SP', getdate(), 36, 'R', 1, 'REGULATORIOS', 'BANXICO.txt', 'cob_conta_super..sp_banxico', 1000,   'lp', @w_server, 'S', @w_path_fuente, @w_path_destino)

--BA_PARAMETRO
IF EXISTS (select 1 from ba_parametro WHERE pa_batch = @w_batch)
   DELETE ba_parametro WHERE pa_batch =@w_batch
   INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
     VALUES (@w_sarta, @w_batch, 48, 1, 'FECHA REPROCESO', 'D', '01/01/2019')

--BA_SARTA_BATCH
if  exists (SELECT 1 FROM cobis..ba_sarta_batch WHERE sb_batch = @w_batch)
   DELETE cobis..ba_sarta_batch WHERE sb_batch =  @w_batch --36430
   INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
      VALUES (@w_sarta, @w_batch , @w_secuencial, NULL,'S', 'N', 2025, 3600, @w_sarta, 'S') 

   
--BA_ENLACE
if exists (SELECT 1 FROM cobis..ba_enlace WHERE en_batch_inicio = @w_batch_v and en_secuencial_fin = @w_secuencial)
   DELETE cobis..ba_enlace WHERE en_batch_inicio = 36424 and en_secuencial_fin = @w_secuencial
   insert into  cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
      values (@w_sarta, @w_batch_v, @w_secuencial_v, 0, @w_secuencial, 'D', NULL, 'N')

-- Listado de Reportes 
if exists (SELECT 1 FROM cob_conta..cb_listado_reportes_reg WHERE lr_reporte = 'BXO')
	DELETE cob_conta..cb_listado_reportes_reg WHERE lr_reporte = 'BXO'
	INSERT INTO cob_conta..cb_listado_reportes_reg (lr_reporte, lr_descripcion, lr_estado, lr_depende_pro)
       VALUES ('BXO', 'Reporte Banxico', 'V', 'S')

go



