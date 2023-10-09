/************************************************************************/
/*	Archivo:		ayfunc.sp				*/
/*	Stored procedure:	sp_ayuda_funcionalidad			*/
/*	Base de datos:		cobis					*/
/*	Producto: 		ADMIN-Seguridades			*/
/*	Disenado por:  		Alexis Rodriguez Morales		*/
/*	Fecha de escritura: 	26-JAN-2001				*/
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
/*	Este programa procesa las maneja la definición de ayudas para	*/
/*	funcionalidades en el nuevo esquema de seguridades para COBIS	*/
/*	WEB								*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_ayuda_funcionalidad')
   drop proc sp_ayuda_funcionalidad
go

create proc sp_ayuda_funcionalidad (
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
	@i_func			char(12)	= NULL,
	@i_idioma		catalogo	= NULL,
	@i_ayuda		url		= NULL
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32)

select 	@w_today = @s_date,
	@w_sp_name = 'sp_ayuda_funcionalidad'


/******** INSERCION *******/
if @i_operacion = 'I'
begin
	/****** CONTROL TRANSACCION ******/
	if @t_trn = 15232
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_func is null or
		   @i_idioma is null or
		   @i_ayuda is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end
		

		/******** CONTROL DE EXISTENCIA DE LA FUNCIONALIDAD *******/
		if not exists (	select *
				from aw_funcionalidad
				where fn_func = @i_func)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151131

			return 1
		End

		/******** CONTROL DE EXISTENCIA DEL IDIOMA *******/
		if not exists (	select *
				from cl_catalogo C, cl_tabla T
				where C.tabla=T.codigo
				and T.tabla='aw_idioma'
				and C.codigo=@i_idioma)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151137

			return 1
		End


		/******* INSERCION ********/

		insert into aw_ayuda_funcionalidad(
		af_func,  af_idioma,   af_ayuda)
		values (
		@i_func,  @i_idioma,  @i_ayuda)

	
		/******** ERROR INSERCION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153054
		
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
	if @t_trn = 15233
	begin
		/***** CONTROL NULOS ********/
		if (
			@i_ayuda is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end
		

		/******** CONTROL DE EXISTENCIA DE LA AYUDA *******/
		if not exists (	select *
				from aw_ayuda_funcionalidad
				where af_func = @i_func
				and af_idioma = @i_idioma)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151136

			return 1
		End


		/******* ACTUALIZACION ********/
		
		update aw_ayuda_funcionalidad
		set af_ayuda=@i_ayuda
		where af_func=@i_func
		and af_idioma=@i_idioma


		/******** ERROR ACTUALIZACION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 155062
		
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
	if @t_trn = 15234
	begin
	
		/****** CONTROL DE EXISTENCIA DE AYUDA *******/
		if not exists (	select *
				from aw_ayuda_funcionalidad
				where af_func=@i_func
				and af_idioma=@i_idioma)
		Begin

			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151136
	   
			return 1
  		end


		/***** BORRADO *******/

		delete aw_ayuda_funcionalidad
		where af_func=@i_func
		and af_idioma=@i_idioma

		/******** ERROR BORRADO ********/

   		if @@error != 0
   		begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 157079

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
	If @t_trn = 15235
	begin
     		if @i_modo = 0
     		begin

     			set rowcount 20

			/***** SEARCH *****/

			select
				'Codigo'=af_idioma,
				'Idioma'=substring(C.valor,1,20),
				'Ayuda'=af_ayuda
			from 
				aw_ayuda_funcionalidad, 
				cl_catalogo C,
				cl_tabla T
			where af_func=@i_func
			and T.tabla='aw_idioma'
			and C.tabla=T.codigo
			and af_idioma=C.codigo
			order by af_idioma

   			set rowcount 0
   			return 0
     		end
    		if @i_modo = 1
    		begin

			/***** CONTROL NULOS ********/
			if (
			    @i_idioma is null
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
				'Codigo'=af_idioma,
				'Idioma'=substring(C.valor,1,20),
				'Ayuda'=af_ayuda
			from 
				aw_ayuda_funcionalidad, 
				cl_catalogo C,
				cl_tabla T
			where af_func=@i_func
			and T.tabla='aw_idioma'
			and C.tabla=T.codigo
			and af_idioma=C.codigo
			and af_idioma>@i_idioma
			order by af_idioma

			set rowcount 0
			return 0
     		end
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
	if @t_trn = 15236
	begin
		/****** CONTROL NULOS ********/
		if (
			@i_func is null or
			@i_idioma is null
		   )
  		begin
			exec cobis..sp_cerror
	   			@t_debug	 = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151001

			return 1
   		end

		/****** CONTROL EXISTENCIA DE LA AYUDA *******/
		if not exists (	select *
				from aw_ayuda_funcionalidad
				where af_func=@i_func
				and af_idioma=@i_idioma)
  		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151136
	   
			return 1
  		end


		/***** QUERY  *****/		
		select 
			af_func,
			af_idioma,
			C.valor,
			af_ayuda
		from 
			aw_ayuda_funcionalidad, 
			cl_catalogo C, 
			cl_tabla T
		where af_func=@i_func
		and af_idioma=@i_idioma
		and T.tabla='aw_idioma'
		and T.codigo=C.tabla
		and af_idioma=C.codigo
		
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


go
