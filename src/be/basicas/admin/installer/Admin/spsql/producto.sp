/************************************************************************/
/*	Archivo:		producto.sp				*/
/*	Stored procedure:	sp_producto				*/
/*	Base de datos:		cobis					*/
/*	Producto:              	Administrador				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 15-Nov-1992					*/
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
/*	Este programa procesa las transacciones del stored procedure	*/
/*	Insercion de producto						*/
/*	Actualizacion de producto					*/
/*	Ayuda de producto						*/
/*	Query de producto						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	15/Nov/92	M. Davila	Emision Inicial			*/
/*	14/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	18/Ene/94	F.Espinosa	Operacion Search retorna la	*/
/*					abreviatura			*/
/*	26/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_producto')
   drop proc sp_producto
go

create proc sp_producto (
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
        @i_operacion		char(2),
        @i_tipo_h		char(1) = null,
        @i_modo			tinyint = null,
        @i_producto		tinyint = null,
       	@i_descripcion		descripcion = null,
       	@i_tipo			char(1) = null,
       	@i_abreviatura		char(3) = null,
       	@i_estado		char(1) = null,
       	@i_saldo_minimo		money = null,
       	@i_costo		money = null,
	@i_formato_fecha	int=null
)
as
declare @w_today	  datetime,
	@w_sp_name	  varchar(32),
	@w_cambio	  int,
	@i_today	  datetime,
	@w_valor	  char(32),
	@w_return	  int,
	@w_descripcion	  descripcion,
	@w_abreviatura	  char(3),
	@w_fecha_apertura datetime,
	@w_estado	  estado,
	@w_saldo_minimo	  money,
	@w_codigo_c	varchar(10), 
	@w_costo	  money,
	@v_valor	  char(32),
	@v_descripcion	  descripcion,
	@v_abreviatura	  char(3),
	@v_fecha_apertura datetime,
	@v_estado	  estado,
	@v_saldo_minimo	  money,
	@v_costo	  money,
	@o_producto	  tinyint,
	@o_tipo		  char(1),
	@o_descripcion	  descripcion,
	@o_abreviatura	  char(3),
	@o_saldo_minimo   money,
	@o_costo	  money,
	@o_estado	  char(1),
	@o_fecha_apertura datetime

select @w_today=@s_date
select @w_sp_name = 'sp_producto'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 1519 
begin
  begin tran
     select @i_today = @s_date
/*     exec sp_cseqnos
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_tabla	= 'cl_producto',
		@o_siguiente	= @o_producto out
*/
     insert into cl_producto (pd_producto, pd_descripcion, pd_abreviatura,
			      pd_fecha_apertura, pd_estado, pd_tipo,
      			      pd_saldo_minimo, pd_costo)
		   values (@i_producto, @i_descripcion, @i_abreviatura,
			   @i_today, 'V', @i_tipo,
			   @i_saldo_minimo, @i_costo)
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103032
	   /* 'Error en creacion de producto'*/
	return 1
     end
     /* transaccion servicio - producto */
     insert into ts_producto (secuencia, tipo_transaccion, clase, fecha,
		              oficina_s, usuario, terminal_s, srv, lsrv,
			      producto, descripcion, abreviatura, 
			      tipo, saldo_minimo, costo,
                              fecha_apertura, estado)
     values (@s_ssn, 1519, 'N', @s_date,
    	     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	     @i_producto, @i_descripcion, @i_abreviatura,
	     @i_tipo, @i_saldo_minimo, @i_costo,
             @i_today, 'V')
     if @@error != 0
     begin
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	    /* 'Error en creacion de transaccion de servicios'*/
	  return 1
     end
  commit tran

	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo_c = convert(varchar(10), @i_producto)
	exec @w_return = sp_catalogo
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user,
		@s_sesn			   = @s_sesn,
		@s_term			   = @s_term,	
		@s_date			   = @s_date,	
		@s_srv			   = @s_srv,	
		@s_lsrv			   = @s_lsrv,	
		@s_rol			   = @s_rol,
		@s_ofi			   = @s_ofi,
		@s_org_err		   = @s_org_err,
		@s_error		   = @s_error,
		@s_sev			   = @s_sev,
		@s_msg			   = @s_msg,
		@s_org			   = @s_org,
		@t_debug		   = @t_debug,	
		@t_file			   = @t_file,
		@t_from		           = @w_sp_name,
		@t_trn			   = 584,
       		@i_operacion		   = 'I',
       		@i_tabla		   = 'cl_producto',
       		@i_codigo		   = @w_codigo_c,
       		@i_descripcion 		   = @i_descripcion,
       		@i_estado	     	   = 'V'	
	if @w_return != 0
		return @w_return


  /* select @o_producto */
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


/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 1520
begin
/* Control de campos a actualizar */
  select @w_descripcion    = pd_descripcion,
	 @w_abreviatura    = pd_abreviatura,
	 @w_saldo_minimo   = pd_saldo_minimo,
	 @w_costo	   = pd_costo,
	 @w_estado	   = pd_estado
    from cl_producto
   where pd_producto = @i_producto
     and pd_tipo = @i_tipo

  select @v_descripcion    = @w_descripcion,
         @v_abreviatura    = @w_abreviatura,
	 @v_saldo_minimo   = @w_saldo_minimo,
	 @v_costo 	   = @w_costo,
         @v_estado	   = @w_estado

  if @w_descripcion = @i_descripcion
     select @w_descripcion = null, @v_descripcion = null
  else
     select @w_descripcion = @i_descripcion
  if @w_abreviatura = @i_abreviatura
     select @w_abreviatura = null, @v_abreviatura = null
  else
     select @w_abreviatura = @i_abreviatura
  if @w_saldo_minimo = @i_saldo_minimo
     select @w_saldo_minimo = null, @v_saldo_minimo = null
  else
     select @w_saldo_minimo = @i_saldo_minimo
  if @w_costo = @i_costo
     select @w_costo = null, @v_costo = null
  else
     select @w_costo = @i_costo
  if @w_estado = @i_estado
     select @w_estado = null, @v_estado = null
  else
     select @w_estado = @i_estado

  begin tran
     /* Update producto */
     update cl_producto
     set    pd_descripcion = @i_descripcion,
	    pd_abreviatura = @i_abreviatura,
	    pd_saldo_minimo = @i_saldo_minimo,
	    pd_costo = @i_costo,
            pd_estado = @i_estado
     where  pd_producto = @i_producto
       and  pd_tipo = @i_tipo
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 105032
	   /* 'Error en actualizacion de producto'*/
	return 1
     end
     /* transaccion servicios - producto */
     insert into ts_producto (secuencia, tipo_transaccion, clase, fecha,
		         oficina_s, usuario, terminal_s, srv, lsrv,
			 producto, descripcion, abreviatura, 
                         tipo, saldo_minimo, costo,
                         fecha_apertura, estado)
     values (@s_ssn, 1520, 'P', @s_date,
	     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	     @i_producto, @v_descripcion, @v_abreviatura,
	     @i_tipo, @v_saldo_minimo, @v_costo,
	     null, @v_estado) 
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	   /* 'Error en creacion de transaccion de servicios'*/
	return 1
     end
     
     insert into ts_producto (secuencia, tipo_transaccion, clase, fecha,
		         oficina_s, usuario, terminal_s, srv, lsrv,
			 producto, tipo, descripcion, abreviatura,
                         saldo_minimo, costo,
                         fecha_apertura, estado)
     		values (@s_ssn, 1520, 'A', @s_date,
	                @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			@i_producto, @i_tipo, @w_descripcion, @w_abreviatura,
			@w_saldo_minimo, @w_costo,
			null, @w_estado)
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	    /* 'Error en creacion de transaccion de servicios'*/
	return 1
     end
  commit tran

	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo_c = convert(varchar(10), @i_producto)
	exec @w_return = sp_catalogo
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user,
		@s_sesn			   = @s_sesn,
		@s_term			   = @s_term,	
		@s_date			   = @s_date,	
		@s_srv			   = @s_srv,	
		@s_lsrv			   = @s_lsrv,	
		@s_rol			   = @s_rol,
		@s_ofi			   = @s_ofi,
		@s_org_err		   = @s_org_err,
		@s_error		   = @s_error,
		@s_sev			   = @s_sev,
		@s_msg			   = @s_msg,
		@s_org			   = @s_org,
		@t_debug		   = @t_debug,	
		@t_file			   = @t_file,
		@t_from		           = @w_sp_name,
		@t_trn			   = 585,
       		@i_operacion		   = 'U',
       		@i_tabla		   = 'cl_producto',
       		@i_codigo		   = @w_codigo_c,
       		@i_descripcion 		   = @i_descripcion,
       		@i_estado	     	   = @i_estado	
	if @w_return != 0
		return @w_return


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

/* Search */
if @i_operacion = 'S'
begin
If @t_trn = 15029
begin
     	set rowcount 20
     	if @i_modo = 0
	begin
		select 	'Producto'    = pd_producto,
			'Tipo'        = pd_tipo,
			'Descripcion' = substring(pd_descripcion,1,35),
			'Abreviatura' = pd_abreviatura,
			'Fecha Apert.' = convert(char(10), pd_fecha_apertura, @i_formato_fecha),
			'Estado'      = pd_estado
		  from	cl_producto
	end
        else
	if @i_modo = 1
	begin
		select 	'Producto'    = pd_producto,
			'Tipo'        = pd_tipo,
			'Descripcion' = substring(pd_descripcion,1,35),
			'Abreviatura' = pd_abreviatura,
			'Fecha Apert.' = convert(char(10), pd_fecha_apertura, @i_formato_fecha),
		        'Estado'      = pd_estado
		  from  cl_producto
		 where  (
			(pd_producto > @i_producto)
		    or  ((pd_producto = @i_producto) and (pd_tipo > @i_tipo))
			)
		if @@rowcount = 0
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101000
			    	/* No existe dato en catalogo */
			set rowcount 0
			return 0
		end
	end
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

/* Query */
if @i_operacion = 'Q'
begin
If @t_trn = 15030
begin
     	set rowcount 20
     	if @i_modo = 0
	begin
		select 	'Producto'    = pd_producto,
			'Tipo'        = pd_tipo,
			'Descripcion' = pd_descripcion	
		  from	cl_producto
		 where  pd_estado = 'V'
		if @@rowcount = 0
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101032
			    /* No existe producto */
			set rowcount 0
			return 1
		end
	end
	if @i_modo = 1
	begin
		select 	'Producto'    = pd_producto,
			'Tipo'        = pd_tipo,
			'Descripcion' = pd_descripcion	
		  from  cl_producto
		 where  (
			(pd_producto > @i_producto)
		    or  ((pd_producto = @i_producto) and (pd_tipo > @i_tipo))
			)
		   and  pd_estado = 'V'
		if @@rowcount = 0
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101032
			    /* No existe producto */
			set rowcount 0
			return 1
		end
	end
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

/* * Help ** */
if @i_operacion = "H"
begin
If @t_trn = 15031
begin
	if @i_tipo_h = "A"
	begin
	 	set rowcount 0
		if @i_modo = 0
		begin
			select  'Cod. Producto' = pd_producto,
		       		'Cod. Tipo' = pd_tipo,
				'Descripcion' = pd_descripcion,
				'Abreviatura' = pd_abreviatura
			  from	cl_producto
			 where  pd_estado = 'V'
			if @@rowcount = 0
			begin
				exec sp_cerror
					@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 101001
					/* No existe producto */
				set rowcount 0
				return 1	
			end
		end
		if @i_modo = 1
		begin
			select  'Cod. Producto' = pd_producto,
		       		'Cod. Tipo' = pd_tipo,
				'Descripcion' = pd_descripcion,
				'Abreviatura' = pd_abreviatura
			  from	cl_producto
			 where	(
				(pd_producto > @i_producto)
			    or	((pd_producto = @i_producto) and
				 (pd_tipo > @i_tipo)) 
				)
			   and  pd_estado = 'V'
			if @@rowcount = 0
			begin
				exec sp_cerror
					@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 101001
					/* No existe producto */
				set rowcount 0
				return 1	
			end
		end
		set rowcount 0
		return 0
	end
	if @i_tipo_h = "V"
	begin
		select pd_tipo,
			pd_descripcion,
			pd_abreviatura
		  from cl_producto
		 where pd_producto = @i_producto
		   and pd_estado = 'V'
		if @@rowcount = 0
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101001
				/* No existe producto */
			return 1
		end	
		return 0
	end
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
