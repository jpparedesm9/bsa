/************************************************************************/
/*	Archivo:		server_d.sp				*/
/*	Stored procedure:	sp_server_dist				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Administracion				*/
/*	Disenado por:  		Alexis Rodriguez			*/
/*	Fecha de escritura: 02-Dic-1992					*/
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
/*	Insercion 							*/
/*	Borrado 							*/
/*	Busqueda 							*/
/*	Query 								*/
/*	de servidores de distribucion					*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	26-Abr-2000	Alexis R.					*/
/*  17-Jul-2012 Julio Nieto      Cambios por Incidencia         */
/*  30-Jul-2011 Julio Nieto      Cambios por INC-776            */
/*  11-04-2016  BBO              Migracion Sybase-Sqlserver FAL       */
/************************************************************************/

use cob_distrib
go

if exists (select * from sysobjects where name = 'sp_server_dist')
   drop proc sp_server_dist
go

create proc sp_server_dist (
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
	@t_show_version		bit         	= 0, -- Mostrar la version del programa  --(PRMR STANDAR)
	@t_debug		char(1) 	= 'N',
	@t_file			varchar(14) 	= null,
	@t_from			varchar(32) 	= null,
	@t_trn			smallint 	= NULL,
	@i_operacion		varchar(1),
	@i_modo 		smallint 	= null,
	@i_servidor		varchar(30)	= null,
	@i_direccion		varchar(30)	= null,
	@i_logid		int		= null,
	@i_habilitado		char(1)		= null,
	@i_estado		char(1)		= null,
	@i_error		int		= null,
	@i_mensaje		varchar(128)	= null,
        @i_formato_fecha        int 		= null
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_servidor		varchar(30),
	@w_logid		int

-- print @i_servidor  + ' ' + @i_direccion + ' ' + @i_habilitado + ' ' + @i_estado
select @w_today = @s_date
select @w_sp_name = 'sp_server_dist'
select @w_logid=@i_logid

if @i_mensaje is null
	select @i_mensaje=''

/***Mostrar versionamiento del sp ***/--(PRMR STANDAR)
	if @t_show_version = 1
	begin
		print 'Stored procedure sp_busca_cust_senial, Version 4.0.0.0'
		return 0
	end

/******** INSERCION *******/
if @i_operacion = 'I'
begin
	/****** CONTROL TRANSACCION ******/
	if @t_trn = 15169
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_servidor is null or
		   @i_direccion is null
		   )
		Begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151001

			return 1
		end

		/***** SELECCION DEL MAXIMO LOGID ********/
		if @i_logid is null
		BEGIN
			select @w_logid=max(lg_id)
			from di_log
		END

		if @w_logid is null
			select @w_logid=0


		/******* INSERCION ********/
		insert into di_control (
		ct_servidor, ct_direccion, ct_fecha,
		ct_habilitado, ct_estado, ct_logid, 
		ct_error, ct_mensaje )
		Values (
		@i_servidor, @i_direccion, getdate(),
		'S', 'D', @w_logid, 0, '')

	
		/******** ERROR INSERCION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153069 --JN
		
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
	if @t_trn = 15169
	begin
		/***** CONTROL NULOS ********/
		if (
		   @i_servidor is null or
		   @i_direccion is null or
		   @i_habilitado is null or
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


		/****** CONTROL EXISTENCIA SERVIDOR *******/

		select @w_servidor=ct_servidor
		from di_control
		where ct_servidor=@i_servidor

  		if @@rowcount = 0  
  		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151093
	   
			return 1
  		end


		/******* ACTUALIZACION ********/
		update di_control 
		set 
			ct_direccion=@i_direccion,
			ct_habilitado=@i_habilitado,
			ct_estado=@i_estado,
			ct_logid=@i_logid,
			ct_error=@i_error,
			ct_mensaje=@i_mensaje
		where ct_servidor=@i_servidor
		
		/******** ERROR ACTUALIZACION *********/
		if @@error<>0 
		Begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153040
		
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
	if @t_trn = 15170 
	begin
		/****** CONTROL SERVIDOR NO ESPECIFICADO ********/
		if (@i_servidor is null)
  		begin
			exec cobis..sp_cerror
	   			@t_debug	 = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151001

			return 1
   		end

		/****** CONTROL EXISTENCIA SERVIDOR *******/

		select @w_servidor=ct_servidor
		from di_control
		where ct_servidor=@i_servidor

  		if @@rowcount = 0  
  		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151093
	   
			return 1
  		end

		/***** BORRADO DEL SERVIDOR *******/

		delete di_control
		where ct_servidor=@i_servidor

		/******** ERROR BORRADO ********/

   		if @@error != 0
   		begin
			exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 157069

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
	If @t_trn = 15171
	begin
     		if @i_modo = 0
     		begin
     			set rowcount 20
			
			select 
				'Servidor'	= ct_servidor,
				'Dirección'	= ct_direccion,
				'Fecha'		= convert(varchar(12),ct_fecha,@i_formato_fecha), --se cambio el tama¤o del campo de 10 -->12
				'Habilitado'	= ct_habilitado,
				'Estado'	= ct_estado,
				'Secuencial'	= ct_logid,
				'No Error'	= ct_error,
				'Mensaje'	= ct_mensaje
			from di_control
			order by ct_servidor

	/* ARO: 2 de Junio del 2000: Correcci¢n Siguientes */        
        if @@rowcount=0
        Begin
   		exec cobis..sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */


       			set rowcount 0
       			return 0
     		end
    		if @i_modo = 1
    		begin
     			set rowcount 20

			select 
				'Servidor'	= ct_servidor,
				'Dirección'	= ct_direccion,
				'Fecha'		= convert(varchar(12),ct_fecha,@i_formato_fecha), --se cambio el tama¤o del campo de 10 -->12
				'Habilitado'	= ct_habilitado,
				'Estado'	= ct_estado,
				'Secuencial'	= ct_logid,
				'No Error'	= ct_error,
				'Mensaje'	= ct_mensaje
			from di_control
			where ct_servidor > @i_servidor
			order by ct_servidor

	/* ARO: 2 de Junio del 2000: Correcci¢n Siguientes */        
        if @@rowcount=0
        Begin
   		exec cobis..sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */


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
	if @t_trn = 15171 
	begin
		/****** CONTROL SERVIDOR NO ESPECIFICADO ********/
		if (@i_servidor is null)
  		begin
			exec cobis..sp_cerror
	   			@t_debug	 = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151001

			return 1
   		end

		/****** CONTROL EXISTENCIA SERVIDOR *******/

		select @w_servidor=ct_servidor
		from di_control
		where ct_servidor=@i_servidor

  		if @@rowcount = 0  
  		begin
			exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151093
	   
			return 1
  		end

		/***** QUERY DEL SERVIDOR *******/

		Select 
			ct_direccion,
			convert(varchar(12),ct_fecha,@i_formato_fecha), --se cambio el tama¤o del campo de 10 -->12
			ct_logid,
			ct_habilitado,
			ct_estado,
			ct_error,
			ct_mensaje,
			ct_servidor

		from di_control
		where ct_servidor=@i_servidor

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
