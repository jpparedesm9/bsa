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
/*                                                                       */
/*    08/Febrero/2019         RPA     actualizacion de nom reporte       */
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
@w_ba_producto int = 36


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
      values (@w_batch, 'REPORTE BANXICO', 'REPORTE BANXICO', 'SP', getdate(), 36, 'R', 1, 'REGULATORIOS', 'Banxico_nomrep_dd_mm_yyyy.txt', 'cob_conta_super..sp_banxico', 1,   null, @w_server, 'S', @w_path_fuente, @w_path_destino)

