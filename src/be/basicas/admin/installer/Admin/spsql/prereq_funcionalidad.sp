/************************************************************************/
/*	Archivo:		prfunc.sp				*/
/*	Stored procedure:	sp_prereq_funcionalidad			*/
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
/*	Este programa procesa las maneja la definición de prerequisitos	*/
/*	para funcionalidades en el nuevo esquema de seguridades para 	*/
/*	COBIS WEB							*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_prereq_funcionalidad')
   drop proc sp_prereq_funcionalidad
go


create proc sp_prereq_funcionalidad (
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
	@i_prereq		catalogo	= NULL,
  @i_tipo     smallint  = 1      /***** DCU *****/
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32)

select 	@w_today = @s_date,
	@w_sp_name = 'sp_prereq_funcionalidad'


/******** INSERCION *******/
if @i_operacion = 'I'
begin
	/****** CONTROL TRANSACCION ******/
	if @t_trn = 15277
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_func is null or
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

		/******** CONTROL DE EXISTENCIA DEL PREREQUISITO*******/
		if not exists (	select *
				from cl_catalogo C, cl_tabla T
				where T.tabla='aw_prerequisitos'
				and C.tabla=T.codigo
				and C.codigo=@i_prereq)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151146

			return 1
		End


		/******* INSERCION ********/

		insert into aw_prereq_func(
		pf_func, pf_prereq)
		values (
		@i_func, @i_prereq)

	
		/******** ERROR INSERCION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153063
		
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
	if @t_trn = 15278
	begin
	
		/****** CONTROL DE EXISTENCIA DE CONTEXTO *******/
		if not exists (	select *
				from aw_prereq_func
				where pf_func=@i_func
				and pf_prereq=@i_prereq)
		Begin

			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151147

			return 1
  		end


		/***** BORRADO *******/

		delete aw_prereq_func
		where pf_func=@i_func
		and pf_prereq=@i_prereq

		/******** ERROR BORRADO ********/

   		if @@error != 0
   		begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 157088

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
	If @t_trn = 15279
	begin

    /***** DCU *****/
    if @i_tipo=0   /* Select * de la relación prereq-func */
    begin
   			set rowcount 20

     		if @i_modo = 0
     		begin
					
					select * from aw_prereq_func
					order by pf_func, pf_prereq

					set rowcount 0
					return 0
					
     		end
     		else /* modo=1 */
				begin
				
  				/***** CONTROL NULOS ********/
					if (
						@i_func is null or
						@i_prereq is null
						)
					begin
						exec cobis..sp_cerror
	   					@t_debug = @t_debug,
	   					@t_file	 = @t_file,
	   					@t_from	 = @w_sp_name,
	   					@i_num	 = 151001

						return 1
					end
					
					select * from aw_prereq_func
					where pf_func+pf_prereq>@i_func+@i_prereq /* clave primaria conformada por ambos campos */
					order by pf_func, pf_prereq

					set rowcount 0
					return 0
				end /* modo = 1 */
    end /* tipo = 0 */
     
		else /* tipo=1 */
		begin
		
     		if @i_modo = 0
     		begin

     			set rowcount 20

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
    
    end /* tipo */
    
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

go
