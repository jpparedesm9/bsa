/************************************************************************/
/*	Archivo:		func.sp					*/
/*	Stored procedure:	sp_tr_funcionalidad			*/
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
/*	Este programa procesa las maneja la asignación de transacciones	*/
/*	Para las funcionalidades en el nuevo esquema de seguridades que	*/
/*	maneja ADMIN WEB						*/
/*	'S'	Search							*/
/*	   1	Busqueda de Transacciones Disponibles por Codigo	*/
/*	   2	Busqueda de Transacciones Disponibles por Nemonico	*/
/*	   3	Busqueda de Transacciones Asignadas			*/
/*	   4	Busqueda de Transacciones Asignadas pot Producto	*/
/*	'I'	Asignar Transaccion					*/
/*	'D'	Desasignar Transaccion					*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_tr_funcionalidad')
   drop proc sp_tr_funcionalidad
go

create proc sp_tr_funcionalidad (
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
	@i_tipo 		varchar(1)	= NULL,
	@i_modo 		smallint 	= 0,
	@i_valor		varchar(20)	= '%',
	@i_func			char(12)	= NULL,
	@i_trn_code		int		= NULL,
	@i_producto		tinyint		= NULL,		--ADU:2002-07-25
	@i_moneda		tinyint		= NULL,		--ADU:2002-07-25
	@i_rtipo		char(1)		= NULL		--ADU:2002-07-25
	
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_longitud		tinyint,
	@w_creador  		smallint,	--ADU:2002-07-13
	@w_cmdtransrv		varchar(60)	--ADU:2002-07-15

select 	@w_today    = @s_date,
	@w_sp_name  = 'sp_tr_funcionalidad',
	@w_longitud = 50

/********* SEARCH ***********/
if @i_operacion = 'S'
begin
	/*********** CONTROL TRANSACCION **************/
	If @t_trn = 15229
	begin
		/*** TRANSACCIONES DISPONIBLES POR CODIGO ***/
		if @i_tipo='1'
		begin
			/*** BUSCAR ***/
	     		if @i_modo = 0
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
					'Codigo'=tn_trn_code,
					'Nemonico'=tn_nemonico,
					'Descripcion'=substring(tn_descripcion,1,@w_longitud)
				from cl_ttransaccion
				where convert(varchar,tn_trn_code) like @i_valor
				and  tn_trn_code not in
					( select tf_transaccion
					  from aw_tr_func
					  where tf_func=@i_func)
				order by tn_trn_code
	
       			set rowcount 0
       			return 0
	     		end	     		
	     		/*** SIGUIENTES ***/
	    		if @i_modo = 1
	    		begin
	
				/***** CONTROL NULOS ********/
				if (
				    @i_func is null or
				    @i_trn_code is null
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
					'Codigo'=tn_trn_code,
					'Nemonico'=tn_nemonico,
					'Descripcion'=substring(tn_descripcion,1,@w_longitud)
				from cl_ttransaccion
				where convert(varchar,tn_trn_code) like @i_valor
				and tn_trn_code > @i_trn_code
				and  tn_trn_code not in
					( select tf_transaccion
					  from aw_tr_func
					  where tf_func=@i_func)
				order by tn_trn_code
	
				set rowcount 0
				return 0
	     		end	     	
		end
		/*** FIN TRANSACCIONES DISP POR CODIGO ***/

		/*** TRANSACCIONES DISPONIBLES POR NEMONICO ***/
		if @i_tipo='2'
		begin
			/*** BUSCAR ***/	
	     		if @i_modo = 0
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
					'Codigo'=tn_trn_code,
					'Nemonico'=tn_nemonico,
					'Descripcion'=substring(tn_descripcion,1,@w_longitud)
				from cl_ttransaccion
				where tn_nemonico like @i_valor
				and  tn_trn_code not in
					( select tf_transaccion
					  from aw_tr_func
					  where tf_func=@i_func)
				order by tn_trn_code
	
       			set rowcount 0
       			return 0
	     		end
	     		/*** SIGUIENTES ***/
	    		if @i_modo = 1
	    		begin
	
				/***** CONTROL NULOS ********/
				if (
				    @i_func is null or
				    @i_trn_code is null
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
					'Codigo'=tn_trn_code,
					'Nemonico'=tn_nemonico,
					'Descripcion'=substring(tn_descripcion,1,@w_longitud)
				from cl_ttransaccion
				where  tn_nemonico like @i_valor
				and tn_trn_code > @i_trn_code
				and  tn_trn_code not in
					( select tf_transaccion
					  from aw_tr_func
					  where tf_func=@i_func)
				order by tn_trn_code
	
				set rowcount 0
				return 0
	     		end
	     	
		end
		/*** FIN TRANSACCIONES DISPONIBLES POR NEMONICO ***/

		/*** TRANSACCIONES ASIGNADAS  ***/
		if @i_tipo='3'
		begin
			/*** BUSCAR ***/
	     		if @i_modo = 0
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
					'Codigo'=tn_trn_code,
					'Nemonico'=tn_nemonico,
					'Descripcion'=substring(tn_descripcion,1,@w_longitud)
				from aw_tr_func, cl_ttransaccion
				where tf_func=@i_func
				and tn_trn_code = tf_transaccion
				order by tf_transaccion
				
       			set rowcount 0
       			return 0
	     		end
	     		/*** SIGUIENTES ***/
	    		if @i_modo = 1
	    		begin
	
				/***** CONTROL NULOS ********/
				if (
				    @i_func is null or
				    @i_trn_code is null
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
					'Codigo'=tn_trn_code,
					'Nemonico'=tn_nemonico,
					'Descripcion'=substring(tn_descripcion,1,@w_longitud)
				from aw_tr_func, cl_ttransaccion
				where tf_func=@i_func
				and tn_trn_code = tf_transaccion
				and tf_transaccion > @i_trn_code
				order by tf_transaccion
	
				set rowcount 0
				return 0
	     		end	     	
		end
		/*** FIN TRANSACCIONES ASIGNADAS ***/


		/*** TRANSACCIONES ASIGNADAS  POR PRODUCTO***/
		if @i_tipo='4'
		begin
			/*** BUSCAR ***/
	     		if @i_modo = 0
	     		begin	

				/***** CONTROL NULOS ********/
				if (
				    @i_func is null or
				    @i_producto is null or
				    @i_moneda is null or
				    @i_rtipo is null
				    
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
	
				select distinct
					'Codigo'=tn_trn_code,
					'Nemonico'=tn_nemonico,
					'Descripcion'=substring(tn_descripcion,1,@w_longitud)
				from	cobis..ad_pro_transaccion,
					cobis..cl_ttransaccion,
					cobis..aw_tr_func
				where tf_func=@i_func
					and tn_trn_code = tf_transaccion
					and pt_producto = @i_producto
					and pt_tipo = @i_rtipo
--					and pt_moneda = @i_moneda
					and pt_transaccion = tn_trn_code
				order by tn_trn_code
				
       			set rowcount 0
       			return 0
	     		end
	     		/*** SIGUIENTES ***/
	    		if @i_modo = 1
	    		begin
	
				/***** CONTROL NULOS ********/
				if (
				    @i_func is null or
				    @i_trn_code is null or
				    @i_producto is null or
				    @i_moneda is null or
				    @i_rtipo is null
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
	
				select distinct
					'Codigo'=tn_trn_code,
					'Nemonico'=tn_nemonico,
					'Descripcion'=substring(tn_descripcion,1,@w_longitud)
				from	cobis..ad_pro_transaccion,
					cobis..cl_ttransaccion,
					cobis..aw_tr_func
				where tf_func=@i_func
					and tn_trn_code = tf_transaccion
					and pt_producto = @i_producto
					and pt_tipo = @i_rtipo
--					and pt_moneda = @i_moneda
					and pt_transaccion = tn_trn_code
					and tn_trn_code > @i_trn_code
				order by tn_trn_code

				set rowcount 0
				return 0
	     		end	     	
		end
		/*** FIN TRANSACCIONES ASIGNADAS ***/
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

/***** ASIGNACION DE UNA TRANSACCION A UNA FUNCIONALIDAD *****/
if @i_operacion='I'
begin
	/*** CONTROL DE TRANSACCION ***/
	if @t_trn=15230
	begin
	
		/*** CONTROL DE NULOS ***/
		if (@i_trn_code is null or
		    @i_func is null )
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151001
				
			return 1
		end
	
		/*** VALIDA QUE EXISTA LA FUNCIONALIDAD ***/	
		if not exists (select *
			       from aw_funcionalidad
			       where fn_func = @i_func)
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151131
			
			return 1
		end
		
		/*** VALIDA QUE EXISTA LA TRANSACCION ***/
		if not exists (select *
			       from cl_ttransaccion
			       where tn_trn_code=@i_trn_code)
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151007
			
			return 1
		end
		
		/*** REVISA SI LA TRN. YA HA SIDO ASIGNADA ***/	
		if exists ( select *
			    from aw_tr_func
			    where tf_func=@i_func and
			    tf_transaccion=@i_trn_code
			  )
		begin
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 151134
				
			return 1
		end
		
		/*** ASIGNA LA TRANSACCION ***/	
		insert into aw_tr_func (tf_func,tf_transaccion)
		values (@i_func,@i_trn_code)
		
		
		/*** CONTROL DE ERRORES ***/
		if @@error<>0
		begin
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 153053	
			return 1
		end
		
		return 0
	end
	else
	/**** TRANSACCION INCORRECTA ****/
	begin
		exec cobis..sp_cerror
	   		@t_debug	 = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 141018

		return 1	
	end
end
/*** FIN ASIGNACION ***/


/***** DESASIGNACION DE UNA TRANSACCION A UNA FUNCIONALIDAD *****/
if @i_operacion='D'
begin
	/**** CONTROL DE TRANSACCION ****/
	if @t_trn=15231
	begin

		/*** CONTROL DE NULOS ***/
		if (@i_trn_code is null or
		    @i_func is null )
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151001
				
			return 1
		end
	
		/*** VALIDA QUE LA TRANSACCION HAYA SIDO ASIGNADA ***/	
		if not exists ( select *
			    from aw_tr_func
			    where tf_func=@i_func and
			    tf_transaccion=@i_trn_code
			  )
		begin
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 151135
				
			return 1
		end
		
		/*** DESASIGNACION DE LA TRANSACCION ***/
		delete aw_tr_func
		where tf_func=@i_func
		and tf_transaccion=@i_trn_code
		
		
		/*** CONTROL DE ERRORES ***/
		if @@error<>0
		begin
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 157078
				
			return 1		
		end
		
		return 0
	end
	else
	/**** TRANSACCION INCORRECTA ****/
	begin
		exec cobis..sp_cerror
	   		@t_debug	 = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 141018

		return 1	
	end
end
/*** FIN DESASIGNACION ***/

go

