/************************************************************************/
/*   Archivo:              ConsultaPagoCorresponsal.sp                  */
/*   Stored procedure:     sp_consulta_pago_corresponsal  				*/
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Ra�l Altamirano Mendez                       */
/*   Fecha de escritura:   Junio 2017                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Realiza la Aplicacion de los Pagos a los Prestamos procesados en ar*/
/*   chivo de retiro para banco SANTANDER MX, con respuesta OK.         */
/*                              CAMBIOS                                 */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_consulta_pago_corresponsal')
   drop proc sp_consulta_pago_corresponsal
go

create proc sp_consulta_pago_corresponsal
(
	@i_param1         datetime	= null,	
	@i_param2         cuenta	= null,
   
   @o_valida_error  char(1)    = 'S' out
)
as 

declare
	@w_error				int,
	@w_return			int,
	@w_sp_name			varchar(30),
	@w_msg				varchar(255)

select @w_sp_name = 'sp_consulta_pago_corresponsal'

if (@i_param2 = '')
	select @i_param2 = null

exec @w_return = sp_pago_corresponsal_srv
	@i_banco        = @i_param2,
	@i_fecha        = @i_param1,
	@o_msg			 = @w_msg out,
   @o_valida_error = @o_valida_error out
   
if @w_return != 0 
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end

return 0
   
ERROR_PROCESO:
select @i_param1 = isnull(@i_param1, (select fp_fecha from cobis..ba_fecha_proceso))

exec sp_errorlog 
	@i_fecha     = @i_param1,
	@i_error     = @w_error, 
	@i_usuario   = 'sa', 
	@i_tran      = 7071,
	@i_tran_name = @w_sp_name,
	@i_cuenta    = @i_param2,
	@i_anexo     = @w_msg,
	@i_rollback  = 'N'

if (@o_valida_error = 'S')
begin
   return @w_error
end
else
begin
   return 0
end
go
