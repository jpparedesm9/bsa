/************************************************************************/
/*	Archivo:		herramrol.sp				*/
/*	Stored procedure:	sp_herr_rol				*/
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
/*	Este programa procesa las maneja la asignación de herramientas	*/
/*	Para los roles en el nuevo esquema de seguridades que		*/
/*	maneja ADMIN WEB						*/
/*	'S'	Search							*/
/*	   1	Busqueda de las Herramientas Disponibles por Codigo	*/
/*	   2	Busqueda de las Herramientas Asignadas			*/
/*	'I'	Asignar Herramientas					*/
/*	'D'	Desasignar Herramientas					*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_herr_rol')
   drop proc sp_herr_rol
go

create proc sp_herr_rol (
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
	@i_tipo 		varchar(1)	= NULL,
	@i_modo 		smallint 	= 0,
	@i_valor		varchar(20)	= '%',
	@i_rol			smallint	= NULL,
	@i_herr_code		catalogo	= NULL
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_longitud		tinyint

select 	@w_today    = @s_date,
	@w_sp_name  = 'sp_herr_rol',
	@w_longitud = 50

/********* SEARCH ***********/
if @i_operacion = 'S'
begin
	/*********** CONTROL TRANSACCION **************/
	If @t_trn = 15283
	begin
		/*** HERRAMIENTAS DISPONIBLES POR CODIGO ***/
		if @i_tipo='1'
		begin
			/*** BUSCAR ***/
	     		if @i_modo = 0
	     		begin

				/***** CONTROL NULOS ********/
				if (
				    @i_rol is null
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
					'Herramienta'=he_herramienta,
					'Url'=he_ref
				from aw_herramienta
				where he_herramienta like @i_valor
				and  he_herramienta not in
					( select hr_herramienta
					  from aw_herr_rol
					  where hr_rol=@i_rol)
				order by he_herramienta
					
       			set rowcount 0
       			return 0
	     		end	     		
	     		/*** SIGUIENTES ***/
	    		if @i_modo = 1
	    		begin
	
				/***** CONTROL NULOS ********/
				if (
				    @i_rol is null or
				    @i_herr_code is null
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
					'Herramienta'=he_herramienta,
					'Url'=he_ref
				from aw_herramienta
				where he_herramienta like @i_valor
				and he_herramienta > @i_herr_code
				and  he_herramienta not in
					( select hr_herramienta
					  from aw_herr_rol
					  where hr_rol=@i_rol)
				order by he_herramienta

				set rowcount 0
				return 0
	     		end	     	
		end
		/*** FIN HERRAMIENTAS DISP POR CODIGO ***/


		/*** TRANSACCIONES ASIGNADAS  ***/
		if @i_tipo='2'
		begin
			/*** BUSCAR ***/
	     		if @i_modo = 0
	     		begin	

				/***** CONTROL NULOS ********/
				if (
				    @i_rol is null
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
					'Herramienta'=he_herramienta,
					'Url'=he_ref
				from aw_herramienta, aw_herr_rol
				where hr_rol=@i_rol
				and he_herramienta=hr_herramienta
				order by hr_herramienta
				
       			set rowcount 0
       			return 0
	     		end
	     		/*** SIGUIENTES ***/
	    		if @i_modo = 1
	    		begin
	
				/***** CONTROL NULOS ********/
				if (
				    @i_rol is null or
				    @i_herr_code is null
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
					'Herramienta'=he_herramienta,
					'Url'=he_ref
				from aw_herramienta, aw_herr_rol
				where hr_rol=@i_rol
				and he_herramienta=hr_herramienta
				and hr_herramienta > @i_herr_code
				order by hr_herramienta

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

/***** ASIGNACION DE UNA HERRAMIENTA A UN ROL *****/
if @i_operacion='I'
begin
	/*** CONTROL DE TRANSACCION ***/
	if @t_trn=15284
	begin
	
		/*** CONTROL DE NULOS ***/
		if (@i_herr_code is null or
		    @i_rol is null )
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151001
				
			return 1
		end
	
		/******** CONTROL DE EXISTENCIA DEL ROL  *******/
		if not exists (	select *
				from ad_rol
				where ro_rol=@i_rol)
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151026 

			return 1
		End
		
		/*** VALIDA QUE EXISTA LA HERRAMIENTA ***/
		if not exists (select *
			       from aw_herramienta
			       where he_herramienta=@i_herr_code)
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151143
			
			return 1
		end
		
		/*** REVISA SI LA HERRAMIENTA YA HA SIDO ASIGNADA ***/	
		if exists ( select *
			    from aw_herr_rol
			    where hr_rol=@i_rol and
			    hr_herramienta=@i_herr_code
			  )
		begin
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 151153
				
			return 1
		end
		
		/*** ASIGNA LA HERRAMIENTA ***/	
		insert into aw_herr_rol (hr_rol,hr_herramienta)
		values (@i_rol,@i_herr_code)
		
		
		/*** CONTROL DE ERRORES ***/
		if @@error<>0
		begin
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 153065	
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


/***** DESASIGNACION DE UNA HERRAMIENTA A UN ROL *****/
if @i_operacion='D'
begin
	/**** CONTROL DE TRANSACCION ****/
	if @t_trn=15285
	begin

		/*** CONTROL DE NULOS ***/
		if (@i_herr_code is null or
		    @i_rol is null )
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151001
				
			return 1
		end
	
		/*** VALIDA QUE LA HERRAMIENTA HAYA SIDO ASIGNADA ***/	
		if not exists ( select *
			    from aw_herr_rol
			    where hr_rol=@i_rol and
			    hr_herramienta=@i_herr_code
			  )
		begin
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 151154
				
			return 1
		end
		
		/*** DESASIGNACION DE LA HERRAMIENTA ***/
		delete aw_herr_rol
		where hr_rol=@i_rol
		and hr_herramienta=@i_herr_code
		
		
		/*** CONTROL DE ERRORES ***/
		if @@error<>0
		begin
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 157090
				
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

