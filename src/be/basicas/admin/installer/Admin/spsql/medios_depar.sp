/************************************************************************/
/*	Archivo:		meddepar.sp				*/
/*	Stored procedure:	sp_medios_depar				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Clientes				*/
/*	Disenado por:  		Alexis Rodr�guez/Pablo Estrella		*/
/*	Fecha de escritura: 	01-MAY-2000				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA". 							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*									*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Insercion (I)							*/
/*	Borrado   (D)							*/
/*	Actualizaci�n (U)						*/
/*	Search	(S) 							*/
/*	Query 	(Q)							*/
/*	de medios electr�nicos asociados a departamentos		*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_medios_depar')
   drop proc sp_medios_depar
go

create proc sp_medios_depar (
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
	@i_en_linea		char(1)		= 'S',
	@i_filial		tinyint		= null,
	@i_oficina		smallint	= null,
	@i_departamento		smallint	= null,
	@i_codigo		smallint	= null,
	@i_tipo			catalogo	= null,
	@i_descripcion		descripcion	= null,
	@i_estado		estado		= null,
	@o_codigo		smallint	= null 	OUT,
	@o_tipo			catalogo	= null	OUT,
	@o_descripcion		descripcion	= null	OUT,
	@o_estado		estado		= null	OUT)	
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_codigo		tinyint

select @w_today = @s_date
select @w_sp_name = 'sp_medios_depar'


/******** INSERCION *******/
if @i_operacion = 'I'
begin
	/****** CONTROL TRANSACCION ******/
	if @t_trn = 15173
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_filial is null or
		   @i_oficina is null or
		   @i_departamento is null or
		   @i_tipo is null or
		   @i_descripcion is null or
		   @i_estado is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end

		/******** CONTROL DE EXISTENCIA DEL DEPARTAMENTO *******/

		if not exists (	select *
				from cl_departamento
				where de_filial = @i_filial and
				de_oficina = @i_oficina and
				de_departamento = @i_departamento)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 141032

			return 1
		End

		/******* CONTROL DE EXISTENCIA DEL TIPO DE MEDIO ******/

		if not exists (	select 'X'
				from cl_tabla T, cl_catalogo C
				where T.tabla='cl_tipo_medio' and
				C.tabla=T.codigo and
				C.codigo=@i_tipo )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151097

			return 1
		End


		/******* CONTROL DE EXISTENCIA DEL ESTADO DEL MEDIO ******/

		if not exists (	select 'X'
				from cl_tabla T, cl_catalogo C
				where T.tabla='cl_estado_ser' and
				C.tabla=T.codigo and
				C.codigo=@i_estado )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151098

			return 1
		End


		/***** OBTENCION DEL VALOR  DEL CODIGO ********/

		select @w_codigo=isnull(max(md_codigo),0) +1
		from cl_medios_depar
		where md_filial = @i_filial and
		md_oficina = @i_oficina and
		md_departamento = @i_departamento

		if @w_codigo is null
			select @w_codigo=1


		/******* INSERCION ********/

		insert into cl_medios_depar (
		md_filial, md_oficina, md_departamento,
		md_codigo, md_tipo, md_descripcion, md_estado)
		values (
		@i_filial, @i_oficina, @i_departamento,
		@w_codigo, @i_tipo, @i_descripcion, @i_estado)

	
		/******** ERROR INSERCION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153041
		
			return 1
		End

		select @w_codigo

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
	if @t_trn = 15175
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_filial is null or
		   @i_oficina is null or
		   @i_departamento is null or
		   @i_codigo is null or
		   @i_tipo is null or
		   @i_descripcion is null or
		   @i_estado is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end


		/******* CONTROL DE EXISTENCIA DEL TIPO DE MEDIO ******/

		if not exists (	select 'X'
				from cl_tabla T, cl_catalogo C
				where T.tabla='cl_tipo_medio' and
				C.tabla=T.codigo and
				C.codigo=@i_tipo )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151097

			return 1
		End


		/******* CONTROL DE EXISTENCIA DEL ESTADO DEL MEDIO ******/

		if not exists (	select 'X'
				from cl_tabla T, cl_catalogo C
				where T.tabla='cl_estado_ser' and
				C.tabla=T.codigo and
				C.codigo=@i_estado )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151098

			return 1
		End



		/****** CONTROL DE EXISTENCIA DEL MEDIO *******/


		if not exists (	select *
				from cl_medios_depar
				where md_filial=@i_filial and
				md_oficina=@i_oficina and
				md_departamento=@i_departamento and
				md_codigo=@i_codigo )
		Begin

			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151094
	   
			return 1
  		end


		/******* ACTUALIZACION ********/
		update cl_medios_depar
		set 
			md_tipo=@i_tipo,
			md_descripcion=@i_descripcion,
			md_estado=@i_estado
		where md_filial=@i_filial and
		md_oficina=@i_oficina and
		md_departamento=@i_departamento and
		md_codigo=@i_codigo
		
		/******** ERROR ACTUALIZACION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 155043
		
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
	if @t_trn = 15174
	begin
		/****** CONTROL SERVIDOR NO ESPECIFICADO ********/
		if (@i_filial is null or
		    @i_oficina is null or
		    @i_departamento is null or
		    @i_codigo is null )
  		begin
			exec cobis..sp_cerror
	   			@t_debug	 = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151001

			return 1
   		end

		/****** CONTROL EXISTENCIA SERVIDOR *******/

		if not exists (	select *
				from cl_medios_depar
				where md_filial=@i_filial and
				md_oficina=@i_oficina and
				md_departamento=@i_departamento and
				md_codigo=@i_codigo )

  		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151094
	   
			return 1
  		end

		/***** BORRADO DEL SERVIDOR *******/

		delete cl_medios_depar
		where md_filial=@i_filial and
		md_oficina=@i_oficina and
		md_departamento=@i_departamento and
		md_codigo=@i_codigo 

		/******** ERROR BORRADO ********/

   		if @@error != 0
   		begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 157070

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
	If @t_trn = 15176
	begin
     		if @i_modo = 0
     		begin


			/***** CONTROL NULOS ********/
			if (
		   		@i_filial is null or
		   		@i_oficina is null or
		   		@i_departamento is null
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
			
			select 
				'C�digo'=md_codigo,
				'Tipo de Medio'=substring(C1.valor,1,10),
				'Medio'=substring(md_descripcion,1,30),
				'Estado '=substring(C2.valor,1,10)
			from cl_medios_depar M, cl_catalogo C1 , cl_tabla T1, cl_catalogo C2, cl_tabla T2
			where md_filial=@i_filial and
			md_oficina=@i_oficina and
			md_departamento=@i_departamento and
			T1.tabla='cl_tipo_medio' and
			C1.tabla=T1.codigo and
			M.md_tipo=C1.codigo and
			T2.tabla='cl_estado_ser' and
			C2.tabla=T2.codigo and
			M.md_estado=C2.codigo
			order by md_codigo

       			set rowcount 0
       			return 0
     		end
    		if @i_modo = 1
    		begin

			/***** CONTROL NULOS ********/
			if (
		   		@i_filial is null or
		   		@i_oficina is null or
		   		@i_departamento is null or
				@i_codigo is null
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

			select 
				'C�digo'=md_codigo,
				'Tipo de Medio'=substring(C1.valor,1,10),
				'Medio'=substring(md_descripcion,1,30),
				'Estado '=substring(C2.valor,1,10)
			from cl_medios_depar M, cl_catalogo C1, cl_tabla T1, cl_catalogo C2, cl_tabla T2 
			where md_filial=@i_filial and
			md_oficina=@i_oficina and
			md_departamento=@i_departamento and
			T1.tabla='cl_tipo_medio' and
			C1.tabla=T1.codigo and
			M.md_tipo=C1.codigo and
			T2.tabla='cl_estado_ser' and
			C2.tabla=T2.codigo and
			M.md_estado=C2.codigo and
			md_codigo > @i_codigo
			order by md_codigo

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
	if @t_trn = 15177
	begin
		/****** CONTROL SERVIDOR NO ESPECIFICADO ********/
		if (@i_filial is null or
		    @i_oficina is null or
		    @i_departamento is null or
		    @i_codigo is null )
  		begin
			exec cobis..sp_cerror
	   			@t_debug	 = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151001

			return 1
   		end

		/****** CONTROL EXISTENCIA SERVIDOR *******/

		if not exists (	select *
				from cl_medios_depar
				where md_filial=@i_filial and
				md_oficina=@i_oficina and
				md_departamento=@i_departamento and
				md_codigo=@i_codigo )

  		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151094
	   
			return 1
  		end


		/***** QUERY DEL SERVIDOR *******/

		Select  
			@o_codigo = md_codigo,
			@o_tipo	  = md_tipo, 
			@o_descripcion = md_descripcion,
			@o_estado = md_estado
		from cl_medios_depar
		where md_filial=@i_filial and
		md_oficina=@i_oficina and
		md_departamento=@i_departamento and
		md_codigo=@i_codigo

		if @i_en_linea='S' 
		Begin
			select @o_codigo, @o_tipo, @o_descripcion, @o_estado
		End
		

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


