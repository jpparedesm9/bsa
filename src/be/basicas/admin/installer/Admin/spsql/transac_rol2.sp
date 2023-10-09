/************************************************************************/
/*	Archivo:		trnrol2.sp				*/
/*	Stored procedure:	sp_transac_rol2				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		ADMIN-Seguridades			*/
/*	Disenado por:  		Alexis Rodriguez Morales		*/
/*	Fecha de escritura: 	14-FEB-2001				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA". 							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa maneja la generación de transacciones autorizadas	*/
/*	para un rol en el nuevo esquema de seguridades en COBIS WEB	*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go


create table #aw_tran_rol
(tr_transaccion int)
go

create table #aw_func_procesada
(fp_func char(10))
go


if exists (select * from sysobjects where name = 'sp_transac_rol2')
   drop proc sp_transac_rol2
go

create proc sp_transac_rol2 (
	@s_ssn			int 		= NULL,
	@s_user			login 		= NULL,
	@s_sesn			int 		= NULL,
	@s_term			varchar(32) 	= NULL,
	@s_date			datetime 	= NULL,
	@s_srv			varchar(30) 	= NULL,
	@s_lsrv			varchar(30) 	= NULL, 
	@s_rol			smallint 	= NULL,
	@s_ofi			smallint 	= NULL,
	@s_org_err		char(1) 	= NULL,
	@s_error		int 		= NULL,
	@s_sev			tinyint 	= NULL,
	@s_msg			descripcion 	= NULL,
	@s_org			char(1) 	= NULL,
	@t_debug		char(1) 	= 'N',
	@t_file			varchar(14) 	= NULL,
	@t_from			varchar(32) 	= NULL,
	@t_trn			smallint 	= NULL,
	@i_operacion		varchar(2),
	@i_rol			tinyint		= NULL,
	@i_func			char(12)	= NULL
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_func			char(12),
	@w_func_aux		char(12)
begin


	/** INICIALIZACION DE VARIABLES **/
	select 	@w_today = @s_date,
		@w_sp_name = 'sp_transac_rol2'

	/*** GENERA TRANSACCIONES PARA UN ROL ***/
	if @i_operacion='GR'
	begin
		
		select @w_func_aux=''

		/*** LAZO DE GRUPOS DE FUNCIONALIDADES 
		     ASIGNADOS AL ROL ***/
		while 1=1
		begin

			/** SELECCIONA EL SIGUIENTE GRUPO DE FUNCIONALIDAD **/
			set rowcount 1

			select @w_func=fr_func
			from aw_func_rol, aw_funcionalidad
			where fr_rol=@i_rol
			and fn_func=fr_func
			and fn_tipo='G'
			and fr_func>@w_func_aux


			/** TERMINA EL LAZO CUANDO NO HAY MAS REGISTROS **/
			if @@rowcount=0
			begin
				set rowcount 0
				break
			end

			set rowcount 0

			/**  CONTROLA SI YA SE PROCESO 
			     ANTERIORMENTE EL GRUPO DE FUNCIONALIDAD  **/
			if not exists (
				select * 
				from #aw_func_procesada 
				where fp_func=@w_func)
			begin
			
				/** REGISTRA EL GRUPO DE FUNC. COMO PROCESADO **/
				insert into #aw_func_procesada
				values (@w_func)
				
				/** CONTROL DE ERROR **/
				if @@error <> 0
				begin
					return 153066
				end
			
				/** GENERA LAS TRANSACCIONES AUTORIZADAS 
				    PARA EL GRUPO DE  FUNCIONALIDAD ***/				    
				exec @w_return = sp_transac_rol2
					@s_ssn	= @s_ssn,
					@s_user	= @s_user,
					@s_sesn	= @s_sesn,
					@s_term	= @s_term,
					@s_date	= @s_date,
					@s_srv	= @s_srv,
					@s_lsrv	= @s_lsrv, 
					@s_rol	= @s_rol,
					@s_ofi	= @s_ofi,
					@s_org_err = @s_org_err,
					@s_error   = @s_error,
					@s_sev	   = @s_sev,
					@s_msg	   = @s_msg,
					@s_org	   = @s_org,
					@t_debug   = @t_debug,
					@t_file	   = @t_file,
					@t_from	   = @t_from,
					@i_operacion = 'GF',
					@i_func	   = @w_func
				
				/** CONTROL DE ERROR **/
				if @w_return<>0
				begin
					return @w_return
				end

			end
			
			select @w_func_aux=@w_func
		end

		/** REGISTRA TRANSACCIONES AUTORIZADAS
		   ASOCIADAS A FUNCIONALIDADES DEL ROL **/
		insert into #aw_tran_rol
		select tf_transaccion
		from aw_funcionalidad, aw_tr_func, aw_func_rol
		where fr_rol=@i_rol
		and fr_func=fn_func
		and fn_tipo='F'
		and tf_func=fn_func
		and fn_func not in ( 	select fp_func
					from #aw_func_procesada
				   )

		/** CONTROL DE ERROR **/
		if @@error<>0
		begin
			return 153067
		end

		/** REGISTRA COMO PROCESADAS
		    FUNCIONALIDADES ASOCIADAS DEL ROL **/
		insert into #aw_func_procesada
		select fn_func
		from aw_funcionalidad, aw_func_rol
		where fr_rol=@i_rol
		and fr_func=fn_func
		and fn_tipo='F'
		and fn_func not in ( 	select fp_func
					from #aw_func_procesada
				   )
		
		/** CONTROL DE ERROR **/
		if @@error <> 0
		begin
			return 153066
		end

		return 0
	end

	/*** GENERA TRANSACCIONES PARA UNA FUNCIONALIDAD O GRUPO DE FUNCIONALIDADES ***/
	if @i_operacion='GF'
	begin
		

		select @w_func_aux=''		
		
		/** LAZO DE GRUPOS DE FUNC. ASOCIADOS **/
		while 1=1
		begin
		
			/** SELECCIONA EL SIGUIENTE REGISTRO **/
			set rowcount 1

			select @w_func=fn_func
			from aw_funcionalidad
			where fn_padre=@i_func
			and fn_tipo='G'
			and fn_func>@w_func_aux

			/** SI NO HAY MAS REGISTROS **/
			if @@rowcount=0
			begin
				set rowcount 0
				break
			end

			set rowcount 0

			/** CONTROLA SI EL GRUPO DE FUNC. YA
			    SE REGISTRÓ ANTERIORMENTE  **/
			if not exists (
				select * 
				from #aw_func_procesada 
				where fp_func=@w_func)
			begin

				/** REGISTRA EL GF COMO PROCESADO **/
				insert into #aw_func_procesada
				values (@w_func)

				/** CONTROLA ERROR **/
				if @@error<>0
				begin
					return 153066
				end

				/** GENERA LAS TRANSACCIONES AUTORIZADAS 
				    PARA EL GRUPO DE  FUNCIONALIDAD ***/
				exec @w_return = sp_transac_rol2
					@s_ssn	= @s_ssn,
					@s_user	= @s_user,
					@s_sesn	= @s_sesn,
					@s_term	= @s_term,
					@s_date	= @s_date,
					@s_srv	= @s_srv,
					@s_lsrv	= @s_lsrv, 
					@s_rol	= @s_rol,
					@s_ofi	= @s_ofi,
					@s_org_err = @s_org_err,
					@s_error   = @s_error,
					@s_sev	   = @s_sev,
					@s_msg	   = @s_msg,
					@s_org	   = @s_org,
					@t_debug   = @t_debug,
					@t_file	   = @t_file,
					@t_from	   = @t_from,
					@t_trn	   = @t_trn,
					@i_operacion = 'GF',
					@i_func	   = @w_func

				if @w_return<>0
				begin
					return @w_return
				end

			end

			select @w_func_aux=@w_func
		end


		/** REGISTRA TRANSACCIONES DE FUNCIONALIDADES
		    HIJAS DE LA FUNC O GF **/
		insert into #aw_tran_rol
		select tf_transaccion
		from aw_funcionalidad, aw_tr_func
		where fn_padre=@i_func
		and fn_tipo='F'
		and tf_func=fn_func
		and fn_func not in (	select fp_func
					from #aw_func_procesada
				    )

		/** CONTROL DE ERRORES **/
		if @@error<>0
		begin
			return 153067
		end

		/** REGISTRA COMO PROCESADAS FUNCIONALIDADES
		   HIJAS DE LA FUNC. O GF **/
		insert into #aw_func_procesada
		select fn_func
		from aw_funcionalidad
		where fn_padre=@i_func
		and fn_tipo='F'
		and fn_func not in (	select fp_func
					from #aw_func_procesada
				    )

		/** CONTROL DE ERRORES **/
		if @@error<>0
		begin
			return 153066
		end

		
		return 0

	end
end
go
