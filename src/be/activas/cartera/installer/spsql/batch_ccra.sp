/************************************************************************/
/*   Archivo:             batch_cca.sp                                  */
/*   Stored procedure:    sp_batch_ccra                                 */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        RRB                                           */
/*   Fecha de escritura:  Mar. 09.                                      */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*            PROPOSITO                                                 */
/*   Procedimiento que realiza la ejecucion del fin de dia de           */
/*   cartera.                                                           */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA              AUTOR             CAMBIOS                    */
/*   23/abr/2010   Fdo Carvajal Interfaz Ahorros-CCA                    */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_batch_ccra')
   drop proc sp_batch_ccra
go

create proc sp_batch_ccra
@i_param1              varchar(255)  = null, 
@i_param2              varchar(255)  = null, 
@i_param3              varchar(255)  = null, 
@i_param4              varchar(255)  = null, 
@i_param5              varchar(255)  = null, 
@i_param6              varchar(255)  = null   -- FCP Interfaz Ahorros
as  

declare @w_return int

exec @w_return = sp_batch 
@i_param1 = @i_param1,                                
@i_param2 = @i_param2,                                
@i_param3 = @i_param3,                                
@i_param4 = @i_param4,                                
@i_param5 = @i_param5,                                
@i_param6 = @i_param6                   -- FCP Interfaz Ahorros


if @w_return <> 0
   return @w_return

return 0
go
