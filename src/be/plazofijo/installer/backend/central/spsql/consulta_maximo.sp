/************************************************************************/
/*      Archivo:                conmax.sp                               */
/*      Stored procedure:       sp_consulta_maximo                      */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Memito Saborio                          */
/*      Fecha de documentacion: 05/Oct/2001                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este procedimiento almacenado la consulta de el máximo numero   */
/*      de retiros de ahorros para una cuenta.             		*/
/*                                                                      */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_maximo')
   drop proc sp_consulta_maximo 
go

create proc sp_consulta_maximo (
@s_ssn                  int         = null,
@s_user                 login       = null,
@s_sesn                 int         = null,
@s_term                 varchar(30) = null,
@s_date                 datetime    = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint    = null,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint,
@i_cta                  cuenta,
@o_respuesta            char(1)     = null out)
with encryption
as
declare         
@w_return               int,
@w_sp_name              varchar(32)
    
select @w_sp_name = 'sp_consulta_maximo', @o_respuesta = 'N'

if @t_trn <> 14454 begin
  exec cobis..sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 141112
   /*  'Error en codigo de transaccion' */
   return 1
end

/* Comentado no existe esta funcionalidad en global

exec @w_return = cob_ahorros..sp_maximo_retiro_ah @t_debug = @t_debug,
					@t_file	= @t_file,
					@t_from	= @t_from,
        	@s_date = @s_date,
        	@i_cta  = @i_cta,
        	@o_respuesta = @o_respuesta out
        	
select @o_respuesta

Comentado no existe esta funcionalidad en global */

return 0
go
        	