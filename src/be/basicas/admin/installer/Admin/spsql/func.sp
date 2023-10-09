/************************************************************************/
/*	Archivo:		func.sp					*/
/*	Stored procedure:	sp_funcionalidad			*/
/*	Base de datos:		cobis					*/
/*	Producto: 		ADMIN-Seguridades			*/
/*	Disenado por:  		Alexis Rodriguez			*/
/*	Fecha de escritura: 	25-MAY-2001				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Insercion 	(I)						*/
/*	Borrado   	(D)						*/
/*	Actualizacion 	(U)						*/
/*	Search		(S)						*/
/*	Query 		(Q)						*/
/*	Help		(H)						*/
/*	de funcionalidades para el nuevo esquema de seguridades para	*/
/*	COBIS WEB							*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	01/01/2002	C. Navas	Incluir el campo producto para  */
/*					dar mantenimiento de la 	*/
/*					funcionalidad de COBIS WEB.	*/
/*	15/01/2002	S.Calderon	Desplegar los valores consul-	*/
/*					tados en la operacion Q desde	*/ 
/*					front End. Se utiliza las varia-*/
/*					bles de salida			*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_funcionalidad')
   drop proc sp_funcionalidad
go

create proc sp_funcionalidad (
	@s_ssn			int 		= NULL,
	@s_user			login 		= NULL,
	@s_sesn			int 		= NULL,
	@s_term			varchar(30) 	= NULL,
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
	@t_file			varchar(14) 	= null,
	@t_from			varchar(32) 	= null,
	@t_trn			smallint 	= NULL,
	@i_operacion		varchar(1),
	@i_modo 		smallint 	= 0,
	@i_htipo 		varchar(2)	= NULL,
	@i_func			char(12)	= NULL,
	@i_tipo			char(1)		= NULL,
	@i_visible		char(1)		= NULL,
	@i_padre		char(12)	= NULL,
	@i_ref			url		= NULL,
	@i_nemonico		char(10)	= NULL,
	@i_func2		char(12)	= NULL,
	@i_bold			char(1)		= NULL,
	@i_reload		char(1)		= NULL,
	@i_captura		char(1)		= NULL,
	@i_producto		tinyint		= NULL,  --CNA:04/12/2001
	@i_orden		smallint	= NULL	--ADU:2002-07-13
	
	
)
as

declare

	@w_today		datetime	,
	@w_return		int		,
	@w_sp_name		varchar(32)	,
	@w_idioma		char(1)		,	--ADU:2002-07-12
	@o_descripcion		varchar(50)	,
	@o_tipo			char(1)		,
	@o_visible		char(1)		,	
	@o_padre		char(12)	,
	@o_ref			url		,  
	@o_nemonico		char(10)	,
	@o_bold			char(1)		,
	@o_reload		char(1)		,
	@o_captura		char(1)		,
	@o_producto		tinyint		,
	@o_orden		smallint		--ADU:2002-07-13

select @w_today = @s_date
select @w_sp_name = 'sp_funcionalidad'


/******** INSERCION *******/
if @i_operacion = 'I'
begin
	/****** CONTROL TRANSACCION ******/
	if @t_trn = 15223
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_func is null or
		   @i_tipo is null or
		   @i_visible is null or
		   @i_bold is null or
		   @i_reload is null or
		   @i_captura is null or
		   @i_producto is null or --CNA:04/12/2001
		   @i_orden is null	--ADU:2002-07-13
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end
		
		if @i_tipo='F' and 
		   (@i_ref is null or
		    @i_nemonico is null)
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1			
		end


		if @i_tipo='G' and 
		    @i_nemonico is null
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1			
		end

		/******** CONTROL DE EXISTENCIA DEL PADRE *******/

		if @i_padre is not null AND
		   not exists (	select *
				from aw_funcionalidad
				where fn_func = @i_padre )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151130

			return 1
		End



		/******* INSERCION ********/

		insert into aw_funcionalidad(
		fn_func,  fn_tipo,  fn_visible,
		fn_padre, fn_ref,   fn_nemonico, 
		fn_bold, fn_reload, fn_captura, fn_producto, --CNA:04/12/2001
		fn_orden)					--ADU:2002-07-13
		values (
		@i_func,  @i_tipo,  @i_visible,
		@i_padre, @i_ref,   @i_nemonico, 
		@i_bold, @i_reload, @i_captura, @i_producto, --CNA:04/12/2001
		@i_orden)					--ADU:2002-07-13

	
		/******** ERROR INSERCION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153052
		
			return 1
		End

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
/******* FIN INSERCION *********/


/******** UPDATE *******/
if @i_operacion = 'U'
begin
	/****** CONTROL TRANSACCION ******/
	if @t_trn = 15224
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_func is null or
		   @i_tipo is null or
		   @i_visible is null or
		   @i_bold is null or
		   @i_reload is null or
		   @i_captura is null or
		   @i_producto is null or --CNA:04/12/2001
		   @i_orden is null	--ADU:2002-07-13
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end
		
		if @i_tipo='F' and 
		   (@i_ref is null or
		    @i_nemonico is null)
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1			
		end

		if @i_tipo='G' and 
		    @i_nemonico is null
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1			
		end

		/******** CONTROL DE EXISTENCIA DEL PADRE *******/

		if @i_padre is not null AND
		   not exists (	select *
				from aw_funcionalidad
				where fn_func = @i_padre )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151130

			return 1
		End


		/****** CONTROL DE EXISTENCIA DE LA FUNCIONALIDAD *******/


		if not exists (	select *
				from aw_funcionalidad
				where fn_func=@i_func)
		Begin

			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151131
	   
			return 1
  		end

		/******* ACTUALIZACION ********/
		
		update aw_funcionalidad
		set
			fn_visible = @i_visible,
			fn_padre   = @i_padre,
			fn_ref     = @i_ref,
			fn_nemonico   = @i_nemonico,
			fn_bold    = @i_bold,
			fn_reload  = @i_reload,
			fn_captura = @i_captura,
			fn_producto = @i_producto, --CNA:04/12/2001
			fn_orden   = @i_orden	--ADU:2002-07-13
		where fn_func=@i_func


		/******** ERROR ACTUALIZACION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 155061
		
			return 1
		End

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
/******* FIN UPDATE *********/


/********* BORRADO ********/
if @i_operacion = 'D'
begin
	/******** CONTROL DE TRANSACCION ********/
	if @t_trn = 15225
	begin
	
		/****** CONTROL DE EXISTENCIA DE LA FUNCIONALIDAD *******/


		if not exists (	select *
				from aw_funcionalidad
				where fn_func=@i_func)
		Begin

			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151131
	   
			return 1
  		end


		/****** CONTROL DE DEPENDENCIAS: FUNCIONALIDADES HIJAS *****/
		
		if @i_tipo<>'F' AND
		exists 	(select *
			from aw_funcionalidad
			where fn_padre=@i_func)
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151132
	   
			return 1
		end

		/**** CONTROL DE DEPENDENCIAS: AYUDA FUNCIONALIDAD ****/

		if exists (select * 
			   from aw_ayuda_funcionalidad
			   where af_func= @i_func)
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151155
	   
			return 1		
		end

		/**** CONTROL DE DEPENDENCIAS: ETIQUETA FUNCIONALIDAD ****/

		if exists (select * 
			   from aw_etiqueta_funcionalidad
			   where ef_func= @i_func)
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151156

			return 1		
		end


		/**** CONTROL DE DEPENDENCIAS: CONTEXTO FUNCIONALIDAD ****/


		if exists (select * 
			   from aw_contexto_func
			   where cf_func= @i_func)
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151157

			return 1		
		end

		/**** CONTROL DE DEPENDENCIAS: PRERERQUISITOS FUNCIONALIDAD ****/

		if exists (select * 
			   from aw_prereq_func 
			   where pf_func= @i_func)
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151158

			return 1		
		end


		/**** CONTROL DE DEPENDENCIAS: TRANSACCIONES FUNCIONALIDAD ****/
		
		if exists (select * 
			   from aw_tr_func 
			   where tf_func= @i_func)
		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151159

			return 1		
		end

		/***** BORRADO DEL SERVIDOR *******/

		delete aw_funcionalidad
		where fn_func=@i_func

		/******** ERROR BORRADO ********/

   		if @@error != 0
   		begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 157077

			return 1
   		end

		return 0
	end
	else 
	/******* ERROR TRANSACCION *********/
	begin
		exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 141018

		return 1
	end
end  
/********* FIN BORRAR *********/


/********* SEARCH ***********/
if @i_operacion = 'S'
begin
	/*********** CONTROL TRANSACCION **************/
	If @t_trn = 15226
	begin
		if @i_tipo is null	--ADU: 2002-07-12
		begin			--ADU: 2002-07-12
	     		if @i_modo = 0
	     		begin
	
	     			set rowcount 20
	
				/***** SEARCH *****/
	
				select
					'Clave'=fn_func,
					'Tipo'=fn_tipo,
					'Padre'=fn_padre,
					'Referencia'=fn_ref,
					'Nemonico'=fn_nemonico,
					'Visible'=fn_visible,
					'Bold' = fn_bold,
					'Reload' = fn_reload,
					'Captura' = fn_captura
				from aw_funcionalidad
				order by fn_func
	
	   			set rowcount 0
	   			return 0
	     		end
	    		if @i_modo = 1
	    		begin
	
				/***** CONTROL NULOS ********/
				if (
				    @i_func is null
			   	    )
				Begin
					exec cobis..sp_cerror
		   			@t_debug = @t_debug,
		   			@t_file	 = @t_file,
		   			@t_from	 = @w_sp_name,
		   			@i_num	 = 151001
	
					return 1
				end
	
	     			set rowcount 20
	
				/***** SEARCH *****/
	
				select
					'Clave'=fn_func,
					'Tipo'=fn_tipo,
					'Padre'=fn_padre,
					'Referencia'=fn_ref,
					'Nemonico'=fn_nemonico,
					'Visible'=fn_visible,
					'Bold' = fn_bold,
					'Reload' = fn_reload,
					'Captura' = fn_captura
				from aw_funcionalidad
				where fn_func>@i_func
				order by fn_func
	
				set rowcount 0
				return 0
	     		end
	     	end			--ADU: 2002-07-12

/***************************************************************/
/*******Consulta de funcionalidades con valor de etiqueta*******/
/************************ADU:2002-07-12*************************/
		if @i_tipo = '1'
		begin		
	     		if @i_modo = 0
	     		begin
				/***** Consulta de Idioma ******/			
				if not exists (	select pa_char
			 			from cl_parametro
						where pa_producto='ADM' and
						pa_nemonico='IEAW')
		  		begin
					exec cobis..sp_cerror
			   		@t_debug = @t_debug,
			   		@t_file	 = @t_file,
			   		@t_from	 = @w_sp_name,
			   		@i_num	 = 151138
			   
					return 1
		  		end


				select @w_idioma=isnull(pa_char,"")
	 			from cl_parametro
				where pa_producto='ADM' and
				pa_nemonico='IEAW'
		  		
	     			set rowcount 20
	
				/***** SEARCH *****/
	
				select
					'Clave'=fn_func,
					'Padre'=fn_padre,
					'Nemonico'=fn_nemonico,
					'Tipo'=fn_tipo,
					'Etiqueta' = isnull((select ef_etiqueta
							from 
								aw_etiqueta_funcionalidad
							where ef_func=aw_funcionalidad.fn_func
							and ef_idioma='ESP'),"No tiene etiqueta")
				from aw_funcionalidad
				order by fn_func
	
	   			set rowcount 0
	   			return 0
	     		end
	    		if @i_modo = 1
	    		begin
	
				/***** CONTROL NULOS ********/
				if (
				    @i_func is null
			   	    )
				Begin
					exec cobis..sp_cerror
		   			@t_debug = @t_debug,
		   			@t_file	 = @t_file,
		   			@t_from	 = @w_sp_name,
		   			@i_num	 = 151001
	
					return 1
				end
	
	     			set rowcount 20
	
				/***** SEARCH *****/
	
				select
					'Clave'=fn_func,
					'Padre'=fn_padre,
					'Nemonico'=fn_nemonico,
					'Tipo'=fn_tipo,
					'Etiqueta' = isnull((select ef_etiqueta
							from 
								aw_etiqueta_funcionalidad
							where ef_func=aw_funcionalidad.fn_func
							and ef_idioma='ESP'),"No tiene etiqueta")
				from aw_funcionalidad
				where fn_func>@i_func
				order by fn_func
	
				set rowcount 0
				return 0
	     		end
	     	end
/*********FIN ADU*********/
	     	
	end
	else
	/***** TRANSACCION INCORRECTA **********/
	begin
		exec cobis..sp_cerror
	   		@t_debug	 = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 141018

			return 1
	end
end
/********* FIN SEARCH *********/


/********* QUERY ***********/
if @i_operacion = 'Q'
begin
	/******** CONTROL DE TRANSACCION ********/
	if @t_trn = 15227
	begin
		/****** CONTROL FUNCIONALIDAD NO ESPECIFICADA ********/
		if @i_func is null
  		begin
			exec cobis..sp_cerror
	   			@t_debug	 = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151001

			return 1
   		end

		/****** CONTROL EXISTENCIA FUNCIONALIDAD *******/

		if not exists (	select *
				from aw_funcionalidad
				where fn_func=@i_func)
  		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151131
	   
			return 1
  		end


		/***** QUERY DEL SERVIDOR *******/

		Select
			@o_tipo 	= fn_tipo,
			@o_visible 	= fn_visible,
			@o_padre	= fn_padre,
			@o_ref		= fn_ref,  
			@o_nemonico	= fn_nemonico,
			@o_bold		= fn_bold,
			@o_reload	= fn_reload,
			@o_captura	= fn_captura,
			@o_producto	= fn_producto, --CNA:04/12/2001
			@o_descripcion = substring(pd_descripcion, 1,50),
			@o_orden	= fn_orden	--ADU:2002-07-13
		from aw_funcionalidad , cl_producto
		where fn_func=@i_func		
		and   pd_producto = fn_producto

		 select
	 	@o_tipo,
		@o_visible,
		@o_padre,
		@o_ref,
		@o_nemonico,
		@o_bold,
		@o_reload,
		@o_captura,
		@o_producto,
		@o_descripcion,  --SCA Retronar para desplegar en FrontEnd
		@o_orden	--ADU:2002-07-13


		return 0
	end
	else 
	/******* ERROR TRANSACCION *********/
	begin
		exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 141018

		return 1
	end
end  
/********* FIN QUERY *********/

/********* HELP **********/
if @i_operacion='H'
begin

	/******** CONTROL DE TRANSACCION ********/
	if @t_trn=15228
	begin
		/**** TODOS: FUNCIONALIDADES Y GRUPOS DE FUNCIONALIDADES ****/
		if @i_htipo='A'
		begin
			if @i_modo=0
			begin
				set rowcount 20
				
				select
					'Nemonico'=fn_func
				from aw_funcionalidad
				order by fn_func
				
				set rowcount 0
			end
			else if @i_modo=1
			begin
				set rowcount 20
				
				select
					'Nemonico'=fn_func
				from aw_funcionalidad
				where fn_func>@i_func
				order by fn_func
				
				set rowcount 0
			
			end
			return 0
		end

		/**** SOLO GRUPOS DE FUNCIONALIDADES ****/
		if @i_htipo='G'
		begin

			if @i_modo=0
			begin
				set rowcount 20
				
				select
					'Nemonico'=fn_func
				from aw_funcionalidad
				where fn_tipo='G'
				and fn_func <> @i_func2
				order by fn_func
				
				set rowcount 0
			end
			else if @i_modo=1
			begin
				set rowcount 20
				
				select
					'Nemonico'=fn_func
				from aw_funcionalidad
				where fn_tipo='G'
				and fn_func <> @i_func2
				and fn_func>@i_func
				order by fn_func
				
				set rowcount 0
			
			end

			return 0
		end

		/**** SOLO FUNCIONALIDADES ****/
		if @i_htipo='F'
		begin
			if @i_modo=0
			begin
				set rowcount 20
				
				select
					'Nemonico'=fn_func
				from aw_funcionalidad
				where fn_tipo='F'
				order by fn_func
				
				set rowcount 0
			end
			else if @i_modo=1
			begin
				set rowcount 20
				
				select
					'Nemonico'=fn_func
				from aw_funcionalidad
				where fn_tipo='F'
				and fn_func>@i_func
				order by fn_func
				
				set rowcount 0
			
			end
			return 0

		end

		/**** EXISTE LA FUNCIONALIDAD  O GRUPO?? ****/
		if @i_htipo='V'
		begin
			if not exists (select *
				from aw_funcionalidad
				where fn_func=@i_func)
			begin
				exec cobis..sp_cerror
			   	@t_debug = @t_debug,
			   	@t_file	 = @t_file,
			   	@t_from	 = @w_sp_name,
			   	@i_num	 = 151131
		
				return 1
			end			
			return 0
		end

		/**** EXISTE LA FUNCIONALIDAD ?? ****/
		if @i_htipo='VF'
		begin
			if not exists (select *
				from aw_funcionalidad
				where fn_func=@i_func
				and fn_tipo='F')
			begin
				exec cobis..sp_cerror
			   	@t_debug = @t_debug,
			   	@t_file	 = @t_file,
			   	@t_from	 = @w_sp_name,
			   	@i_num	 = 151131
		
				return 1
			end			
			return 0
		end

		/**** EXISTE EL GRUPO DE FUNCIONALIDADES ?? ****/
		if @i_htipo='VG'
		begin
			if not exists (select *
				from aw_funcionalidad
				where fn_func=@i_func
				and fn_tipo='G')
			begin
				exec cobis..sp_cerror
			   	@t_debug = @t_debug,
			   	@t_file	 = @t_file,
			   	@t_from	 = @w_sp_name,
			   	@i_num	 = 151133
		
				return 1
			end			
			return 0
		end
		

	end
	else
	/******* ERROR TRANSACCION *********/
	begin
		exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 141018

		return 1
	end	
end
/********* FIN HELP **********/


go


