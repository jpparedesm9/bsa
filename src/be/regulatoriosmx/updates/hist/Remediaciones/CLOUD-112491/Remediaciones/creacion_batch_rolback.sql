/*************************************************************************/
/*   Archivo:              creacion_batch_rolback_castigo.sql            */
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
/*   Este programa es el batch para creacion del batch rolback           */
/*   castigo automatico.                                                 */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                   AUTOR                 RAZON                */
/*    21/Enero/2019           JLCC             emision inicial           */
/*                                                                       */
/*                                                                       */
/*************************************************************************/
use cobis
go

DECLARE 
@w_server       varchar(24) = null,
@w_path_fuente  varchar(255) = null,
@w_path_destino varchar(255) = null,
@w_sarta        int = 12,
@w_batch        int = 7194,
@w_secuencial   int,
@w_ba_producto  int = 7 

select @w_server = pa_char
from   cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, 
       @w_path_destino = pp_path_destino
from   ba_path_pro
where  pp_producto = @w_ba_producto

--BA_BATCH --7194
IF EXISTS (select 1 from ba_batch WHERE ba_batch = @w_batch)
   delete ba_batch WHERE ba_batch = @w_batch
   
