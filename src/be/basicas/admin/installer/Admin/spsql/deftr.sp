/************************************************************************/
/*	Archivo: 		deftr.sp				*/
/*	Stored procedure: 	sp_default_tr				*/
/*	Base de datos:  	cobis					*/
/*	Producto: 		Clientes         			*/
/*	Disenado por:  		Mauricio Bayas/Sandra Ortiz		*/
/*	Fecha de escritura: 	14-Jun-1993				*/
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
/*	Consulta los codigos de los parametros				*/
/*	de una transaccion susceptibles de negociacion con el cliente.	*/
/*	(tabla cl_default_tr)						*/	
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	23-Jun-1993	S Ortiz		Emision inicial			*/
/*	04/May/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go


if exists (select * from sysobjects where name = 'sp_default_tr')
	drop proc sp_default_tr
go
create proc sp_default_tr (
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
	@i_tipo			char (1) = null,
	@i_modo			tinyint = null,
	@i_nemonico		char (6) = null,
	@i_descripcion		descripcion = null,
	@i_tdato		descripcion = null
) as
declare		@w_sp_name		varchar (30),
		@w_def_tran		char (1),
		@w_descripcion		descripcion,
		@w_tdato		descripcion,
		@v_descripcion		descripcion,
		@v_tdato		descripcion


/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_default_tr'


/*  Insert  */
if @i_operacion = 'I'
begin
   if @t_trn = 15088 
   begin
	insert into cl_default_tr (df_nemonico, df_descripcion, df_tdato)
			values	  (@i_nemonico, @i_descripcion, @i_tdato)
	if @@error != 0
	begin
		/*  Error en creacion de default  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 103055
		return 1
	end
	
	/* transaccion de servicio */
	   insert into ts_def_tran (secuencia, tipo_transaccion, clase, fecha,
			       oficina_s, usuario, terminal_s, srv, lsrv,
			       nemonico, descripcion, tdato)
		       values (@s_ssn, 15088, 'N', @s_date,
			       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			       @i_nemonico, @i_descripcion,  @i_tdato)
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
if @t_trn = 15089
   begin
	select   @w_descripcion  = df_descripcion,
		 @w_tdato	 = df_tdato
	    from cl_default_tr
	   where df_nemonico = @i_nemonico
	
	  select @v_descripcion = @w_descripcion
	  select @v_tdato	= @w_tdato
	
	  if @w_descripcion = @i_descripcion
	     select @w_descripcion = null, @v_descripcion = null
	  else
	     select @w_descripcion = @i_descripcion
	  if @w_tdato = @i_tdato 
	     select @w_tdato = null, @v_tdato = null
	  else
	     select @w_tdato = @i_tdato

	update 	cl_default_tr
	   set	df_descripcion = @i_descripcion,
		df_tdato = @i_tdato
	 where	df_nemonico = @i_nemonico

	if @@rowcount != 1
	begin
		/*  Error en actualizacion de default  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 105055
		return 1
	end

	/* transaccion de servicio */
	   insert into ts_def_tran (secuencia, tipo_transaccion, clase, fecha,
			       oficina_s, usuario, terminal_s, srv, lsrv,
			       nemonico, descripcion, tdato)
		       values (@s_ssn, 15089, 'P', @s_date,
			       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			       @i_nemonico, @v_descripcion,  @v_tdato)
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
	   insert into ts_def_tran (secuencia, tipo_transaccion, clase, fecha,
			       oficina_s, usuario, terminal_s, srv, lsrv,
			       nemonico, descripcion, tdato)
		       values (@s_ssn, 15089, 'A', @s_date,
			       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			       @i_nemonico, @w_descripcion,  @w_tdato)
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
   if @t_trn = 15090
   begin
	select	*
	  from	cl_def_tran
	 where	dt_default = @i_nemonico
	if @@rowcount != 0
	begin
		/*  Existe referencia en default de transaccion  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 101092
		select	@w_def_tran = 'S'
	end

	if @w_def_tran = 'S'
		return 1
	select	@w_descripcion = df_descripcion,
		@w_tdato = df_tdato
	 from	cl_default_tr
	where	df_nemonico = @i_nemonico

	delete	cl_default_tr
	 where	df_nemonico = @i_nemonico
	if @@error != 0
	begin
		/*  Error en eliminacion de default de transaccion  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 107052
		return 1
	end

	/* transaccion de servicio */
	   insert into ts_def_tran (secuencia, tipo_transaccion, clase, fecha,
			       oficina_s, usuario, terminal_s, srv, lsrv,
			       nemonico, descripcion, tdato)
		       values (@s_ssn, 15090, 'B', @s_date,
			       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			       @i_nemonico, @w_descripcion,  @w_tdato)
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


/*  Help  */
if @i_operacion = 'H'
begin
if @t_trn = 1589
begin
	if @i_tipo = 'A'
	begin
		select	substring(df_nemonico, 1, 6),
			df_descripcion
		  from	cobis..cl_default_tr
		
		if @@rowcount = 0
		begin
			/*  No existen parametros default  */
			exec cobis..sp_cerror
				@t_debug= @t_debug,
				@t_file	= @t_file,
				@t_from	= @w_sp_name,
				@i_num	= 151035
			return 1
		end
	end
	else
	begin
		select	df_descripcion
		  from	cobis..cl_default_tr
		 where	df_nemonico = @i_nemonico
		
		if @@rowcount = 0
		begin
			/*  No existen parametros default  */
			exec cobis..sp_cerror
				@t_debug= @t_debug,
				@t_file	= @t_file,
				@t_from	= @w_sp_name,
				@i_num	= 151035
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
if @t_trn = 1590
begin
	set rowcount 20
	if @i_modo = 0
		select	'Nemonico' = substring(df_nemonico, 1, 6),
			'Descripcion' = df_descripcion,
			'Tipo de Dato' = df_tdato
		  from	cl_default_tr
		order by df_nemonico
	else
	Begin
		select	'Nemonico' = df_nemonico,
			'Descripcion' = df_descripcion,
			'Tipo de Dato' = df_tdato
		  from	cl_default_tr
		 where	df_nemonico > @i_nemonico
		order by df_nemonico

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

go
