/************************************************************************/
/*      Archivo:                validpwd.sp                             */
/*      Stored procedure:       sp_valida_password                      */
/*      Base de datos:          cobis                                   */
/*      Producto: 		Administracion				*/
/*      Disenado por:  		Alexis Rodríguez			*/
/*      Fecha de escritura: 	19-Ene-2001				*/
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa se encarga de la validación de los passwords de 	*/
/*	de usuario para el nuevo esquema de encriptamiento de passwords	*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_valida_password')
   drop proc sp_valida_password
go

create proc sp_valida_password (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(32) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint =NULL,
	@t_offset		varbinary(32) = NULL,
	@i_login		varchar(30) = NULL
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_offset		varbinary(32)	-- ARO:23/01/2001  CRYPWD
begin
	/*** Inicialización de las variables ***/
		
	select 	@w_sp_name = 'sp_valida_password',
		@w_today   = @s_date

	/***** VALIDACION DE CODIGO DE TRANSACCION ****/
	if @t_trn=15222
	begin
		/*** Obtener offset de la BDD ***/		
		select @w_offset=fu_offset
		from cl_funcionario
		where fu_login=@i_login
		
		if @@rowcount=0 
		begin
			/*** Funcionario no existe ***/
	     		exec sp_cerror	
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 151128
				
			return 1
		end
	
		/*** Valida password ingresado ***/		
		if @w_offset<>@t_offset
		begin
	     		exec sp_cerror	
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 151129
			return 1
		end
		
		/*** Validacion exitosa ***/
		return 0
	end
	else
	/******* TRANSACCION INCORRECTA **********/
	begin	
		exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 141018
		return 1
	end
end
go
