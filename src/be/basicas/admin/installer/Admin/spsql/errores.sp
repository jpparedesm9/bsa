/************************************************************************/
/*	Archivo: 		errores.sp				*/
/*	Stored procedure: 	sp_errores				*/
/*	Base de datos:  	cobis					*/
/*	Producto: 		Administracion				*/
/*	Disenado por:  		Mauricio Bayas/Sandra Ortiz		*/
/*	Fecha de escritura: 	29-Jun-1993				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Realiza el mantenimiento de errores del Sistema.  Permite	*/
/*	insertar, actualizar, eliminar y consultar errores.		*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	29-Jun-1993	S Ortiz		Emision inicial			*/
/*	04/May/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_errores')
	drop proc sp_errores








go
create proc sp_errores (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
	@i_operacion		char (1),
	@i_modo			tinyint = null,
	@i_numero		int = null,
	@i_mensaje		varchar (132) = null,
	@i_severidad		int = null,
	@i_codigo		varchar (10) = null,
	@i_central_transmit	char(1) = null
) as
declare	@w_sp_name		descripcion,
	@w_mensaje		varchar (132),
	@w_severidad		int ,
	@v_mensaje		varchar (132),
	@v_severidad		int,
	@w_server_logico    	varchar(10),
	@w_num_nodos        	smallint,    
	@w_contador          	smallint,
	@w_cmdtransrv		varchar(60),
	@w_nt_nombre  		varchar(40),
	@w_clave 		int,
	@w_return 	int 
 

/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_errores'

/*  Modo de debug  */

/*  Chequeo de Existencias  */
if @i_severidad is not null and @i_severidad not in (0, 1)
begin
	/*  Severidad debe ser 1 o 0  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 151038
	return 1
end

if (@i_numero is not null) and (@i_numero < 100000)
begin
	/*  Codigo de error debe ser mayor a 100000  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 151039
	return 1
end

/*  Insert  */
if @i_operacion = 'I'
begin
if @t_trn = 1534
begin
	if exists ( select numero  from cl_errores
	             where numero = @i_numero )                 
	begin
		/*  Ya existe codigo de error */                  
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 151070
		return 1
	end

	begin tran
	insert into cl_errores (numero, severidad, mensaje)
		values (@i_numero, @i_severidad, @i_mensaje)
	if @@error != 0
	begin
		/*  Error en creacion de error  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 153025
		return 1
	end

	/* transaccion de servicio */
   	insert into ts_error (secuencia, tipo_transaccion, clase, fecha,
		       oficina_s, usuario, terminal_s, srv, lsrv,
		       numero, severidad, mensaje)
	       values (@s_ssn, 1534, 'N', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		       @i_numero, @i_severidad, @i_mensaje)
   	if @@error != 0
   	begin
	/*  'Error en creacion de transaccion de servicio' */
		exec sp_cerror
	   		@t_debug	 = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 153023
		return 1
   	end
	commit tran

	return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end


/*  Update  */
if @i_operacion = 'U'
begin
	if @t_trn = 1535
	begin

 	/* chequeo de campos a actualizar */
   	select @w_severidad = severidad,
          	@w_mensaje = mensaje
     	from cl_errores
     	where  numero = @i_numero

   	select @v_severidad = @w_severidad,
          	@v_mensaje = @w_mensaje
	
   	if @w_severidad= @i_severidad
    		select @w_severidad = null, @v_severidad = null
   	else
     		select @w_severidad = @i_severidad
   
   	if @w_mensaje = @i_mensaje
     		select @w_mensaje = null, @v_mensaje = null
   	else
     		select @w_mensaje = @i_mensaje
   
    	begin tran

	update	cl_errores
	set	severidad = @i_severidad,
		mensaje   = @i_mensaje
	where	numero	  = @i_numero
	if @@rowcount != 1
	begin
		/*  Error en actualizacion de error  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 155020
		return 1
	end

	/* transaccion de servicio */
   	insert into ts_error (secuencia, tipo_transaccion, clase, fecha,
		       oficina_s, usuario, terminal_s, srv, lsrv,
		       numero, severidad, mensaje)
	       values (@s_ssn, 1535, 'A', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		       @i_numero, @v_severidad, @v_mensaje)
   	if @@error != 0
   	begin
	/*  'Error en creacion de transaccion de servicio' */
		exec sp_cerror
	   		@t_debug	 = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 153023
		return 1
   	end

	/* transaccion de servicio */
   	insert into ts_error (secuencia, tipo_transaccion, clase, fecha,
		       oficina_s, usuario, terminal_s, srv, lsrv,
		       numero, severidad, mensaje)
	       values (@s_ssn, 1535, 'P', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		       @i_numero, @w_severidad, @w_mensaje)
   	if @@error != 0
   	begin
	/*  'Error en creacion de transaccion de servicio' */
		exec sp_cerror
	   		@t_debug	 = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 153023
		return 1
   	end

	commit tran
	return 0
	end
	else
		begin
		exec sp_cerror
	   	@t_debug	 = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
		return 1
		end
end

/*  Delete  */
if @i_operacion = 'D'
begin
if @t_trn = 1536
begin
	if exists 	(select	*
			   from	cl_errores
			  where	numero = @i_numero)
	begin
           begin tran
   		   select @w_severidad = severidad,
          	          @w_mensaje = mensaje
                   from cl_errores
                   where  numero = @i_numero

		delete	cl_errores
		 where	numero = @i_numero
		if @@error != 0
		begin
			/*  Error en eliminacion de error  */
			exec cobis..sp_cerror
				@t_debug= @t_debug,
				@t_file	= @t_file,
				@t_from	= @w_sp_name,
				@i_num	=157042
			return 1
		end
		/* transaccion de servicio */
   		insert into ts_error (secuencia, tipo_transaccion, clase, fecha,
		       oficina_s, usuario, terminal_s, srv, lsrv,
		       numero, severidad, mensaje)
	       values (@s_ssn, 1536, 'B', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		       @i_numero, @w_severidad, @w_mensaje)
   		if @@error != 0
   		begin
		/*  'Error en creacion de transaccion de servicio' */
			exec sp_cerror
	   			@t_debug	 = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 153023
			return 1
   		end
		commit tran
	end
	else
	begin
		if @@error != 0
		begin
			/*  Error en eliminacion de error  */
			exec cobis..sp_cerror
				@t_debug= @t_debug,
				@t_file	= @t_file,
				@t_from	= @w_sp_name,
				@i_num	=157042
			return 1
		end
	end
	return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end


/*  Search  */
if @i_operacion = 'S'
begin
If @t_trn = 1598
begin
	set rowcount 20
	if @i_modo = 0
		select	'Numero' = numero,
			'Severidad'= severidad,
			'Mensaje' = mensaje
		  from	cl_errores 
		 where	convert(varchar(10), numero) like @i_codigo
		 order	by numero
	else
	Begin
		select	'Numero' = numero,
			'Severidad'= severidad,
			'Mensaje' = mensaje
		  from	cl_errores 
		 where	convert(varchar(10), numero) like @i_codigo
		   and	numero > @i_numero
		 order	by numero

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

		 
	End
	
	set rowcount 0
	return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end


/*  Query  */
if @i_operacion = 'Q'
begin
If @t_trn = 1599
begin
	select	numero,
		mensaje,
		severidad
	  from	cl_errores
	 where	numero = @i_numero
	 if @@rowcount = 0
	 begin
		/*  No existe codigo de error solicitado  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 151040
		return 1
	 end
	return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end

go
