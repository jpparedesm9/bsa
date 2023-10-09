use cob_bvirtual
go
if object_id('sp_fin_sesion') is not null
		drop proc sp_fin_sesion
go

/******************************************************************************/
/*      Stored procedure:       b2c_fin_sesion.sp                             */
/*      Base de datos:          cob_bvirtual                                  */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/*   Registrar el final de sesion para Cobis Internet                         */
/******************************************************************************/
/*                              MODIFICACIONES                                */
/******************************************************************************/
/*  FECHA       VERSION   AUTOR                 RAZON                         */
/******************************************************************************/
/*  22-Sep-1998           Juan Arthos           Emision inicial               */
/*  06-Ene-2012 4.0.0.0   NES                   Servidor web                  */         
/*  14-Nov-2012 4.0.0.0   Ronald Perero         error cierre sesion           */ 
/*  1/22/2015   4.0.0.2   Carlos Echeverría      Reversión de Cambio de RPE   */
/*  18-Oct-2019           Jonathan R            Agrega registro log B2C       */
/******************************************************************************/   

Create Procedure sp_fin_sesion
  @t_show_version   BIT          = 0,
  @s_date           datetime     = null,
  @s_ssn            int          = null,
  @i_login          varchar(64)  = null,  
  @i_server         varchar(30)  = null,
  @i_webserver      varchar(30)  = null,
  @i_terminal_ip    varchar(30)  = null
 
As  
  declare 
  @w_sp_name    varchar(64)   
  select @w_sp_name = 'sp_fin_sesion'   

-- Mostrar la version del programa
IF @t_show_version = 1
BEGIN
   PRINT 'Stored procedure = ' + @w_sp_name + ' 4.0.0.2'
   RETURN 0
END

set rowcount 1

-- Eliminar el registro del usuario 
delete bv_in_login 
where il_login = @i_login 
  and il_server_name = isnull(@i_webserver, @i_server) 
 and il_terminal_ip  = @i_terminal_ip --RPE
if @@error <> 0 
begin 
  -- ERROR EN LA ELIMINACION DE LA TABLA bv_in_login 
  exec cobis..sp_cerror   
    @t_from       = @w_sp_name,   
    @i_num        = 1875024 
  return 1   
end 

 delete bv_session
 where bv_usuario = @i_login 
 and bv_terminal_ip = @i_terminal_ip
if @@error <> 0 
begin 
  -- ERROR EN LA ELIMINACION DE LA TABLA bv_in_login 
  exec cobis..sp_cerror   
    @t_from       = @w_sp_name,   
    @i_num        = 1875024 
  return 1   
end 

-- REGISTRO LOG B2C
exec cob_bvirtual..sp_b2c_registro_transacciones
	@s_ssn = @s_ssn,
	@s_lsrv = @i_webserver,
	@s_date = @s_date,
	@i_tipo_tran = 1502,
	@i_login = @i_login
return 0 


GO
