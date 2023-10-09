/************************************************************************/
/*	Archivo:		context.sp				*/
/*	Stored procedure:	sp_contexto				*/
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
/*	de contextos para el nuevo esquema de seguridades para		*/
/*	COBIS WEB							*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_contexto')
   drop proc sp_contexto
go

create proc sp_contexto(
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
	@i_htipo 		varchar(2)	= NULL,
	@i_contexto		catalogo	= NULL,
	@i_ref			url		= NULL
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32)

select @w_today = @s_date
select @w_sp_name = 'sp_contexto'


/******** INSERCION *******/
if @i_operacion = 'I'
begin
	/****** CONTROL TRANSACCION ******/
	if @t_trn = 15245
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_contexto is null or
		   @i_ref is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end
		

		/******* INSERCION ********/

		insert into aw_contexto(co_contexto, co_ref)		
		values (@i_contexto, @i_ref)

	
		/******** ERROR INSERCION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153057
		
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
	if @t_trn = 15246
	begin
		/***** CONTROL NULOS ********/
		if (
			@i_contexto is null or
			@i_ref	is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end
		


		/****** CONTROL DE EXISTENCIA DEL CONTEXTO *******/
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
  		end

		/******* ACTUALIZACION ********/
		update aw_contexto
		set co_ref=@i_ref
		where co_contexto=@i_contexto

		/******** ERROR ACTUALIZACION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 155064
		
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
	if @t_trn = 15247
	begin
	
		/****** CONTROL DE EXISTENCIA DEL CONTEXTO *******/
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
  		end

		/****** CONTROL DE EXISTENCIA DEL DATOS RELACIONADOS AL CONTEXTO *******/
		/********************************AYUDA**********************************/
		
		if exists (	select *
				from aw_ayuda_contexto
				where ac_contexto=@i_contexto)
		Begin

			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151150
	   
			return 1
  		end

		/*******************************NOMBRE**********************************/
		
		if exists (	select *
				from aw_nombre_contexto
				where nc_contexto=@i_contexto)
		Begin

			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151149
	   
			return 1
  		end

		/***** BORRADO DEL SERVIDOR *******/
		delete aw_contexto
		where co_contexto=@i_contexto

		/******** ERROR BORRADO ********/

   		if @@error != 0
   		begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 157082

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
	If @t_trn = 15248
	begin
     		if @i_modo = 0
     		begin

     			set rowcount 20

			/***** SEARCH *****/
			select
				'Contexto'=co_contexto,
				'Referencia'=co_ref
			from aw_contexto
			order by co_contexto

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
				'Contexto'=co_contexto,
				'Referencia'=co_ref
			from aw_contexto
			where co_contexto>@i_contexto
			order by co_contexto

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
	if @t_trn = 15249
	begin
		/****** CONTROL CONTEXTO NO ESPECIFICADA ********/
		if @i_contexto is null
  		begin
			exec cobis..sp_cerror
	   			@t_debug	 = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151001

			return 1
   		end

		/****** CONTROL EXISTENCIA CONTEXTO *******/
		if not exists (	select *
				from aw_contexto
				where co_contexto=@i_contexto)
  		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151140
	   
			return 1
  		end


		/***** QUERY *****/
		Select co_ref
		from aw_contexto
		where co_contexto=@i_contexto

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
	if @t_trn=15250
	begin
		/**** TODOS ****/
		if @i_htipo='A'
		begin
			if @i_modo=0
			begin
				set rowcount 20
				
				select
					'Nemonico'   = co_contexto,
					'Referencia' = co_ref
				from aw_contexto
				order by co_contexto
				
				set rowcount 0
			end
			else if @i_modo=1
			begin
				set rowcount 20
				
				select
					'Nemonico'=co_contexto,
					'Referencia' = co_ref
				from aw_contexto
				where co_contexto>@i_contexto
				order by co_contexto
				
				set rowcount 0
			
			end
			return 0
		end

		/**** EXISTE EL CONTEXTO ?? ****/
		if @i_htipo='V'
		begin
			if not exists (select *
				from aw_contexto
				where co_contexto=@i_contexto)
			begin
				exec cobis..sp_cerror
			   	@t_debug = @t_debug,
			   	@t_file	 = @t_file,
			   	@t_from	 = @w_sp_name,
			   	@i_num	 = 151140
		
				return 1
			end			
			return 0
		end	end
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
