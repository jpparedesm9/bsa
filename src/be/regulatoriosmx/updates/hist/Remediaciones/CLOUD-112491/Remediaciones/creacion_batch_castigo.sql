/*************************************************************************/
/*   Archivo:              creacion_batch_castigo.sql                    */
/*   Base de datos:        cob_    cartera                               */
/*   Producto:             Cartera                                       */
/*   Disenado por:         Jose Luis Calvillo                            */                          
/*   Fecha de escritura:   Marzo 2019                                    */
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
/* Este programa es el batch para creacion del proceso batch             */
/* castigo automatico                                                    */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                   AUTOR                 RAZON                */
/*    21/Enero/2019           JLCC             emision inicial           */
/*                                                                       */
/*                                                                       */
/*************************************************************************/


use cobis
go

declare 
@w_server       varchar(24) = null,
@w_path_fuente  varchar(255) = null,
@w_path_destino varchar(255) = null,
@w_sarta        int = 12,
@w_batch        int = 7194,
@w_secuencial   int = 29,
@w_ba_producto  int = 7,
@w_batch_v      int = 7191,
@w_secuencial_v int = 22 


select @w_server   = pa_char
from   cobis.. cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'


select @w_path_fuente  = pp_path_fuente, 
       @w_path_destino = pp_path_destino
from   ba_path_pro
where  pp_producto = @w_ba_producto


--BA_BATCH -- 
 if exists(select 1 from ba_batch where ba_batch = @w_batch)
 delete ba_batch where ba_batch = @w_batch  
 insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
 values (@w_batch, 'CASTIGO AUTOMATICO', 'CASTIGO AUTOMATICO', 'SP', getdate(), 7, 'P',1,'CARTERA',NULL,'cob_cartera..sp_castigo_automatico',1,null,@w_server, 'S', @w_path_fuente, @w_path_destino)

--BA_PARAMETRO
 if exists(select 1 from ba_parametro where pa_batch = @w_batch)
 delete ba_parametro where pa_batch =@w_batch
 insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
 values(@w_sarta, @w_batch, 0, 1, 'FECHA_PROCESO', 'D', '01/01/2019')