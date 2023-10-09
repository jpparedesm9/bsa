/*estados_cca.sp*********************************************************/
/*   Archivo:             estado_cca.sp                                 */
/*   Stored procedure:    sp_batch1                                     */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Fabian de la Torre                            */
/*   Fecha de escritura:  Ene. 98.                                      */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Retorna los codigos de los estados de cartera.                     */
/************************************************************************/

use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_estados_cca')
   drop proc sp_estados_cca
go
 

create proc sp_estados_cca
@o_est_novigente  tinyint = null out,
@o_est_vigente    tinyint = null out,
@o_est_etapa2     tinyint  = null out,
@o_est_vencido    tinyint = null out,
@o_est_cancelado  tinyint = null out,
@o_est_castigado  tinyint = null out,
@o_est_diferido   tinyint = null out,
@o_est_anulado    tinyint = null out,
@o_est_condonado  tinyint = null out,
@o_est_suspenso   tinyint = null out,
@o_est_credito    tinyint = null out

as

select 
@o_est_novigente  = 0,
@o_est_vigente    = 1,
@o_est_etapa2     =12,
@o_est_vencido    = 2,
@o_est_cancelado  = 3,
@o_est_castigado  = 4,
@o_est_diferido   = 8,
@o_est_anulado    = 6,
@o_est_condonado  = 7,
@o_est_suspenso   = 9,
@o_est_credito    = 99

return 0



GO

