/************************************************************************/
/*      Archivo:                borratmp.sp                             */
/*      Stored procedure:       sp_borrar_tmp                           */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           R Garces                                */
/*      Fecha de escritura:     Jul. 1997                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                           */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Eliminar las tablas temporales de una operacion                 */
/************************************************************************/
/* 05/05/2017        M. Custode           Eliminaciond el conver tramite*/
/*                                        por i_banco                   */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_borrar_tmp')
    drop proc sp_borrar_tmp
go
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
---NR000353 partiendo de la verion inical
create proc sp_borrar_tmp
        @s_user                   login        = null,
        @s_term                   varchar(30)  = null, 
        @s_sesn                   int          = null,
        @i_desde_cre              char(1)      = null,
        @i_banco                  cuenta       = null,
        @i_crea_ext               char(1)      = null,
        @o_msg_msv                varchar(255) = null out

as
declare @w_operacionca            int ,
        @w_error                  int ,
        @w_sp_name                descripcion,
        @w_return                 int
                                  
--SE COMENTA POR MEJORA
--begin tran

if @i_desde_cre = 'S'
   select @i_banco = op_banco
from ca_operacion
where op_banco = @i_banco


exec @w_return =  sp_borrar_tmp_int
@s_user      = @s_user,
@s_sesn      = @s_sesn,
@i_banco     = @i_banco

if @w_return <> 0
begin
   select @w_error = @w_return
   goto ERROR
end    

--SE COMENTA POR MEJORA
--commit tran

return 0

ERROR:
if @i_crea_ext is null
begin
	exec cobis..sp_cerror
	@t_debug  = 'N', 
	@t_file   = null,
	@t_from   = @w_sp_name,
	@i_num    = @w_error
	
	return @w_error
end
ELSE
begin
   select @o_msg_msv = 'Error en Borrado de Temporales ' + @w_sp_name
   return @w_error
end