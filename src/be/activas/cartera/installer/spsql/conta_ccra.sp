/************************************************************************/
/*   Archivo:             conta_ccra.sp                                 */
/*   Stored procedure:    sp_conta_ccra                                 */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        RRB                                           */
/*   Fecha de escritura:  Abr. 09.                                      */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA".                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*            PROPOSITO                                                 */
/*   Procedimiento que realiza la ejecucion de contabilidad cartera     */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA              AUTOR             CAMBIOS                    */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_conta_ccra')
   drop proc sp_conta_ccra
go

create proc sp_conta_ccra
   @i_param1              varchar(255)  = null, 
   @i_param2              varchar(255)  = null, 
   @i_param3              varchar(255)  = null, 
   @i_param4              varchar(255)  = null, 
   @i_param5              varchar(255)  = null
as 
declare @i_hijo   varchar(2),
        @i_sarta  int,
        @i_batch  int,
        @i_opcion char(1),
        @i_bloque int       

if @i_param1 is not null
   select 
   @i_hijo          = convert(varchar(2), rtrim(ltrim(@i_param1))),
   @i_sarta         = convert(int       , rtrim(ltrim(@i_param2))),
   @i_batch         = convert(int       , rtrim(ltrim(@i_param3))),
   @i_opcion        = convert(char(1)   , rtrim(ltrim(@i_param4))),
   @i_bloque        = convert(int       , rtrim(ltrim(@i_param5)))

select @i_param1 = convert(varchar(2), rtrim(ltrim(@i_param1)))

exec sp_caconta
@i_param1           = @i_param1,
@i_param2           = @i_param2,
@i_param3           = @i_param3,
@i_param4           = @i_param4,
@i_param5           = @i_param5  
     
go

