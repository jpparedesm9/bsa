/************************************************************************/
/*	Archivo:		ctfunc.sp				*/
/*	Stored procedure:	sp_contexto_funcionalidad		*/
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
/*	Este programa procesa las maneja la definición de contextos 	*/
/*	para funcionalidades en el nuevo esquema de seguridades para 	*/
/*	COBIS WEB							*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*  19-04-2016  BBO         Migracion SYB-SQL FAL                       */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_contexto_funcionalidad')
   drop proc sp_contexto_funcionalidad
go

create proc sp_contexto_funcionalidad (
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
	@t_file			varchar(14) 	= null,
	@t_from			varchar(32) 	= null,
	@t_trn			smallint 	= NULL,
	@i_operacion		varchar(1),
	@i_modo 		smallint 	= 0,
	@i_func			char(12)	= NULL,
	@i_contexto		catalogo	= NULL,
	@i_tipo			varchar(1)	= NULL,
	@i_idioma		catalogo	= NULL,
	@i_prereq		catalogo	= NULL 
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32)
                            
select 	@w_today = @s_date,
	@w_sp_name = 'sp_contexto_funcionalidad'

/******** INSERCION *******/

if @i_operacion = 'I'
begin
	/****** CONTROL TRANSACCION ******/
	if @t_trn = 15242
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_func is null or
		   @i_contexto is null
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

		/******** CONTROL DE EXISTENCIA DEL CONTEXTO *******/
		if not exists (	select *
				from aw_contexto
				where co_contexto=@i_contexto)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151140

			return 1
		End

		/******* INSERCION ********/

		insert into aw_contexto_func(
		cf_func, cf_contexto)
		values (@i_func, @i_contexto)

		/******** ERROR INSERCION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153056

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

/********* BORRADO ********/

if @i_operacion = 'D'
begin
	/******** CONTROL DE TRANSACCION ********/
	if @t_trn = 15243
	begin
		/****** CONTROL DE EXISTENCIA DE CONTEXTO *******/
		if not exists (	select *
				from aw_contexto_func
				where cf_func=@i_func
				and cf_contexto=@i_contexto)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151139

			return 1
  		end

		/***** BORRADO *******/

		delete aw_contexto_func
		where cf_func=@i_func
		and cf_contexto=@i_contexto

		/******** ERROR BORRADO ********/
   		if @@error != 0
   		begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 157081

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
	if @t_trn = 15244
	begin
		/************* Contextos asignados por funcionalidad *************/
		if @i_tipo='1' 
		begin
			if @i_modo = 0
			begin
				set rowcount 20
				/***** SEARCH *****/
				select
					'Contexto'=cf_contexto
				from 
					aw_contexto_func
				where cf_func=@i_func
				order by cf_contexto

				set rowcount 0
				return 0
			end

			if @i_modo = 1
			begin
				/***** CONTROL NULOS ********/
				if (
				    @i_contexto is null
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
					'Contexto'=cf_contexto
 				from 
					aw_contexto_func
				where cf_func=@i_func
				and cf_contexto>@i_contexto
				order by cf_contexto

				set rowcount 0
				return 0
			end
     		end

		/************* Consulta de Nombre, Referencia, Ayuda de los contextos de una funcionalidad *************/
		if @i_tipo='2'  /* DCU */
		begin

			if @i_modo = 0
			begin
				set rowcount 20
				/***** SEARCH *****/
				select 
				  'Contexto'=cf_contexto,
				  'Nombre'=nc_nombre,
				  'Referencia'=co_ref,
				  'Ayuda'=ac_ayuda
                --inicio migra syb-sql  
				from aw_contexto_func                     
                     left outer join aw_ayuda_contexto on ac_contexto = cf_contexto
                     inner join aw_contexto on co_contexto = cf_contexto
                     inner join cl_tabla T on T.tabla = 'aw_idioma'
                     left outer join cl_catalogo C on ac_idioma = C.codigo
                                                  and C.tabla   = T.codigo
                     inner join aw_nombre_contexto on nc_contexto = cf_contexto
                                                  and nc_idioma = C.codigo
				where cf_func  = @i_func
				  and C.codigo = @i_idioma
				order by cf_contexto                
                --fin migra syb-sql
                /*******MIGRACION SYB-SQL
				from 
  				  aw_contexto_func,
				  aw_nombre_contexto,
				  aw_contexto,
				  aw_ayuda_contexto,
				  cl_catalogo C,
				  cl_tabla T
				where 
				  cf_func=@i_func
				  and nc_contexto=cf_contexto  -- Debe existir nombre
				  and co_contexto=cf_contexto  -- Debe existir referencia  
				  and ac_contexto=*cf_contexto -- =* left join. No necesariamente debe tener ayuda
				  and T.tabla='aw_idioma'
				  and C.tabla=T.codigo
				  and ac_idioma=*C.codigo
				  and nc_idioma=C.codigo
				  and C.codigo=@i_idioma
				order by cf_contexto
                ********/

			/***** SEARCH *****/

			select
				'Codigo'=pf_prereq,
				'Descripcion'=substring(C.valor,1,30)
			from 
			aw_prereq_func,
				cl_catalogo C,
				cl_tabla T
			where T.tabla='aw_prerequisitos'
			and C.tabla=T.codigo
			and C.codigo=pf_prereq
			and pf_func=@i_func
			order by pf_prereq

				set rowcount 0
				return 0
			end

			if @i_modo = 1
			begin

				/***** CONTROL NULOS ********/
				if (
				    @i_contexto is null or
				    @i_prereq is null
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
				  'Contexto'=cf_contexto,
				  'Nombre'=nc_nombre,
				  'Referencia'=co_ref,
				  'Ayuda'=ac_ayuda
                --inicio migra syb-sql  
				from aw_contexto_func                     
                     left outer join aw_ayuda_contexto on ac_contexto = cf_contexto
                     inner join aw_contexto on co_contexto = cf_contexto
                     inner join cl_tabla T on T.tabla = 'aw_idioma'
                     left outer join cl_catalogo C on ac_idioma = C.codigo
                                                  and C.tabla   = T.codigo
                     inner join aw_nombre_contexto on nc_contexto = cf_contexto
                                                  and nc_idioma = C.codigo
				where cf_func     = @i_func
				  and C.codigo    = @i_idioma
                  and cf_contexto > @i_contexto
				order by cf_contexto                
                --fin migra syb-sql
                /*******MIGRACION SYB-SQL
				from 
  				  aw_contexto_func,
				  aw_nombre_contexto,
				  aw_contexto,
				  aw_ayuda_contexto,
				  cl_catalogo C,
				  cl_tabla T
				where 
				  cf_func=@i_func
  				  and cf_contexto>@i_contexto
				  and nc_contexto=cf_contexto  -- Debe existir nombre
				  and co_contexto=cf_contexto  -- Debe existir referencia  
				  and ac_contexto=*cf_contexto -- =* left join. No necesariamente debe tener ayuda
				  and T.tabla='aw_idioma'
				  and C.tabla=T.codigo
				  and ac_idioma=*C.codigo
				  and nc_idioma=C.codigo
				  and C.codigo=@i_idioma
				order by cf_contexto
                ********/

			/***** SEARCH *****/

			select
				'Codigo'=pf_prereq,
				'Descripcion'=substring(C.valor,1,30)
			from 
				aw_prereq_func,
				cl_catalogo C,
				cl_tabla T
			where T.tabla='aw_prerequisitos'
			and C.tabla=T.codigo
			and C.codigo=pf_prereq
			and pf_func=@i_func
			and pf_prereq>@i_prereq
			order by pf_prereq

				set rowcount 0
				return 0
			end
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
go
