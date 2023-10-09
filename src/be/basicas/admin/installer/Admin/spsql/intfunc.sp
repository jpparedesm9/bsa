/************************************************************************/
/*	Archivo:		intfunc.sp				*/
/*	Stored procedure:	sp_interfaz_funcionalidad		*/
/*	Base de datos:		cobis					*/
/*	Producto: 		ADMIN-Seguridades			*/
/*	Disenado por:  		Alexis Rodriguez			*/
/*	Fecha de escritura: 	19-FEB-2001				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA'. 							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa proporciona la interfaz empleada por el browser	*/
/*	de COBIS WEB para el acceso a la información de funcionalidades	*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*  28/Ene/2009    A.Tabarez       Porting SQLServer2005                */
/************************************************************************/

use cobis
go
SET ANSI_NULLS OFF
go

if exists (select 1 from sysobjects where name = 'sp_interfaz_funcionalidad')
   drop proc sp_interfaz_funcionalidad
go

create proc sp_interfaz_funcionalidad (
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
	@i_func			char(12)	= NULL,
	@i_idioma		catalogo	= NULL
)
as
SET NOCOUNT ON

declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_num_context		int,
	@w_num_prereq		int,
	@w_ayuda_func		url,
	@w_bold			char(1),
	@w_nemonico		char(10),
	@w_padre		catalogo,
	@w_ref			url,
	@w_tipo			char(1),
	@w_state		int,
	@w_etiqueta		descripcion,
	@w_visible		char(1)
begin

/******* NODOS HIJOS DE UN NODO *********/
if @i_operacion='1'
begin
	if @t_trn=15287
	begin

		/***** CONTROL NULOS ********/
		if (@i_func is null)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end	

		/*** CONTROLA QUE EXISTA LA FUNCIONALIDAD ***/
		if not exists ( select 1
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
		
		/*** SELECCION DE NODOS HIJOS ***/		
		select fn_func
		from aw_funcionalidad
		where fn_padre=@i_func
		
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
/**** DATOS DE UN NODO *****/
if @i_operacion='2'
begin
	/*** CONTROL DE LA TRANSACCION ***/	
	if @t_trn=15288
	begin
		/***** CONTROL NULOS ********/
		if (@i_func is null or
		    @i_idioma is null)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end	

		/*** CONTROLA QUE EXISTA LA FUNCIONALIDAD ***/
		if not exists ( select 1
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

		/*** NUMERO DE CONTEXTOS ***/
		select @w_num_context=count(*)
		from aw_contexto_func
		where cf_func=@i_func

		/*** NUMERO DE PREREQUISITOS ***/
		select @w_num_prereq=count(*)
		from aw_prereq_func
		where pf_func=@i_func

		/*** AYUDA DE LA FUNCIONALIDAD ***/		
		select @w_ayuda_func=af_ayuda
		from aw_ayuda_funcionalidad
		where af_func=@i_func
		and af_idioma=@i_idioma
		
		/*** ETIQUETA DE LA FUNCIONALIDAD ***/
		select  @w_etiqueta=ef_etiqueta
		from aw_etiqueta_funcionalidad
		where ef_func=@i_func
		and ef_idioma=@i_idioma
		

		/**** SELECT PRINCIPAL DE DATOS DEL NODO ****/		
		select
			@w_bold=fn_bold,
			@w_nemonico=fn_nemonico,
			@w_padre=fn_padre,
			@w_ref=fn_ref,
			@w_tipo=fn_tipo,
			@w_visible=fn_visible
		from  aw_funcionalidad
		where fn_func = @i_func
		
		/*** DEFINICION DEL ESTADO ***/		
		if @w_tipo='G'
			select @w_state=1
		else
			select @w_state=0
			
		select 
			@w_bold,
			@w_num_context,
			@w_ayuda_func,
			@w_nemonico,
			@w_padre,
			@w_num_prereq,
			@w_ref,
			@w_state,
			@w_etiqueta,
			@w_visible
		
		/**** SELECT DE CONTEXTOS ****/		
		select 
			nc_nombre,
			co_ref,
			ac_ayuda
		from aw_contexto, aw_contexto_func
		LEFT OUTER JOIN aw_ayuda_contexto on cf_contexto = ac_contexto and ac_idioma=@i_idioma
		LEFT OUTER JOIN aw_nombre_contexto on cf_contexto = nc_contexto and nc_idioma=@i_idioma
		where nc_contexto=co_contexto
			and cf_func=@i_func
			and co_contexto=cf_contexto

		/**** SELECT DE PREREQUISITOS ****/
		select
			C.valor
		from 
			aw_prereq_func,
			cl_catalogo C,
			cl_tabla T
		where pf_func=@i_func
		and T.tabla='aw_prerequisitos'
		and C.tabla=T.codigo
		and pf_prereq=C.codigo


	end
	else
	/*** TRANSACCION INCORRECTA ***/
	begin
		exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 141018
		return 1	
	end
end
end
go

 