/************************************************************************/
/*      Archivo:                b2c_validar_pwd.sp                      */
/*      Stored procedure:       sp_b2c_validar_pwd                      */
/*      Base de datos:          cob_bvirtual                            */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Recibe un código de registro B2C y devuelve datos del cliente.  */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    06/Dic/2018           ERA              Emision Inicial            */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_validar_pwd')
    drop proc sp_b2c_validar_pwd
go

create proc sp_b2c_validar_pwd(
@s_date          datetime    = null,
@s_servicio		 int,
@i_ente 		 int,
@i_login		login,
@i_pwd           varchar(64),
@o_clave_valida   char(1)='' output ,
@o_msg           varchar(200) = '' output
)
as
declare
@w_sp_name        varchar(25),
@w_error          int

select 
@w_sp_name = 'sp_b2c_validar_pwd',
@w_error = 0

select 1 from bv_login 
where lo_login = @i_login
and lo_clave_def = @i_pwd
and lo_ente = @i_ente

if @@rowcount = 0 
begin
	select @o_clave_valida = 'N'
    select  @w_error = 17025
	exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error        
	return @w_error

end

select @o_clave_valida = 'S'

return 0

go
