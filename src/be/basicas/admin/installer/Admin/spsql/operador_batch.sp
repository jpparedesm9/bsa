use cobis
go


drop proc sp_operador_batch
go

create proc sp_operador_batch (
	@s_ssn                  int 		= NULL,
	@s_user                 login 		= NULL,
	@s_sesn                 int 		= NULL,
	@s_term                 varchar(32) 	= NULL,
	@s_date                 datetime 	= NULL,
	@s_srv                  varchar(30) 	= NULL,
	@s_lsrv                 varchar(30) 	= NULL, 
	@s_rol                  smallint 	= NULL,
	@s_ofi                  smallint 	= NULL,
	@s_org_err              char(1) 	= NULL,
	@s_error                int 		= NULL,
	@s_sev                  tinyint 	= NULL,
	@s_msg                  descripcion 	= NULL,
	@s_org                  char(1) 	= NULL,
	@t_debug                char(1) 	= 'N',
	@t_file                 varchar(14) 	= NULL,
	@t_from                 varchar(32) 	= NULL,
	@t_trn                  smallint 	= NULL,
	@i_operacion            char(1)		= NULL,
	@i_osuser		varchar(16)	= NULL,
	@i_cmd			varchar(255)	= NULL,
	@i_archivo		varchar(50)	= NULL,
	@o_dblogin		varchar(240)	= NULL OUT
)
AS
DECLARE
	@w_today	datetime,
	@w_sp_name	varchar(30),
	@w_login	varchar(240),
	@w_secuencial	int,
	@w_return	int
BEGIN

	/** Inicializacion de variables **/	
	select 	@w_today = @s_date,
		@w_sp_name = 'sp_operador_batch'
	
	/** Opracion de Validacion de Usuario **/
	if (@i_operacion='V')
	begin
   		exec @w_return = sp_cseqnos @i_tabla = 'ba_log_operador',
                      		@o_siguiente = @w_secuencial out
   		
   		insert into ba_log_operador (
		lo_sec,		lo_login,	lo_rol,
		lo_osuser,	lo_fecha,	lo_cmd,
		lo_archivo)
		values (
		@w_secuencial,	@s_user,	@s_rol,
		@i_osuser,	getdate(),	@i_cmd,
		@i_archivo
		)		
		
		if @@error<>0
		begin
		       exec sp_cerror
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 108000
		       return 1				
		end
		
		if not exists ( Select 1 from ba_operador 
				where op_login=@s_user and
				op_rol=@s_rol and
				op_osuser=@i_osuser
				and op_estado='V' )
		begin
		       exec sp_cerror
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 108001
		       return 1				
		end
		
		select @w_login=op_dblogin
		from ba_operador
		where op_login=@s_user and
		op_rol=@s_rol and
		op_osuser=@i_osuser 
		and op_estado='V'
		
		if @@rowcount=0
		begin
		       exec sp_cerror
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 108001
			return 1
		end
		
		select @o_dblogin=@w_login
		return 0
	
	end
	else
	begin
	       exec sp_cerror
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 108002
		return 1
	end
	return 0
END
go

