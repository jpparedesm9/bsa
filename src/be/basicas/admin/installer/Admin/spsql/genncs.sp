/************************************************************************/
/*      Archivo:                genncs.sp				*/
/*      Stored procedure:       sp_gen_ncs				*/
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  							*/
/*      Fecha de escritura: 25-Oct-1996                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Generacion de claves en esquema NCS				*/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*	2003-06-03	A. Duque	Emision inicial			*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_gen_ncs')
   drop proc sp_gen_ncs
go

create proc sp_gen_ncs (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(30) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_ofi                  smallint = NULL,
	@s_rol                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint = NULL,
	@i_operacion            char(1) = NULL,
	@i_login		varchar(14) = NULL,
	@i_pwd			varchar(14) = NULL,
	@i_tipo			varchar(3) = NULL,
	@i_llave		varchar(16) = NULL,
	@i_pwdclear		char(1) = NULL
	
)
as

declare @w_cmd_trsrv varchar(254),
	@w_return int,
	@w_contador int,
	@w_num_usuarios int,
	@w_login login,
	@w_clave login,
	@w_sp_name	varchar(30),
	@w_llave	varbinary(32),
	@o_llave	varbinary(32)

select @w_sp_name = 'sp_gen_ncs'

if @t_trn = 15297
begin
	if @i_operacion = 'G'	--Genera offset de un usuario
	begin
		if ( @i_login is null or
		     @i_pwd is null or
		     @s_srv is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end

		select @w_cmd_trsrv = @s_srv + '...' + 'rp_genera_offset'
		exec @w_cmd_trsrv
			@i_login = @i_login,
			@i_pwd = @i_pwd
			
		return 0
	end

	if @i_operacion = 'L'	--Ingreso de llaves
	begin
		if ( @i_tipo is null or
		     @i_llave is null or
		     @s_srv is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end

		if exists (select name from sysobjects where name='sp_llave')
		begin
			select @w_llave=convert(varbinary(32),@i_llave)
			select @w_cmd_trsrv = @s_srv + '...' + 'rp_llave'
			exec @w_cmd_trsrv
				@i_cmd = 'C',
				@i_nombre = @i_tipo,
				@i_tipo = 'C',
				@i_estado = '1',
				@i_llave = @w_llave,
				@o_llave = @o_llave out
				
			return 0
		end
		else
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_msg   = 'No existe procedure sp_llave',
	   		@i_num	 = 151001

			return 1
		end
	end

	if @i_operacion = 'O'	--Generación de offsets
	begin
		if ( @i_pwdclear is null or
		     @s_srv is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end

		if exists (select * from ad_llave)
		begin
			select @w_cmd_trsrv = @s_srv + '...' + 'rp_migrate_offsets'
			exec @w_cmd_trsrv
				@i_pwdclear = @i_pwdclear
			
			return 0
		end
		else
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_msg   = 'No existen registros en la tabla ad_llave',
	   		@i_num	 = 151001

			return 1
		end
	end
end
go
