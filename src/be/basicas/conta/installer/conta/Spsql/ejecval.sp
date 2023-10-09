/************************************************************************/
/*   Stored procedure:     sp_ejec_asientos_val                         */
/*   Base de datos:        cob_conta                                    */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_ejec_asientos_val')
   drop proc sp_ejec_asientos_val
go


create proc sp_ejec_asientos_val
(
   @i_param1      char(1) = null,
   @i_param2      tinyint = null,
   @i_param3      tinyint = null
)
as
declare 
   @w_return   int

select @w_return = 0

execute sp_sasiento_val
	@i_operacion   = @i_param1,
	@i_empresa     = @i_param2,
	@i_producto    = @i_param3

if @w_return <> 0
begin
   print 'ERROR EN EJCUIÓN DE sp_sasiento_val'
end

return 0

go

	

