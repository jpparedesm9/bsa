/************************************************************************/
/*	Archivo:		Tablas.sp				*/
/*	Stored procedure:	sp_tablas     				*/
/*	Base de datos:		cobis					*/
/*	Producto:       	Clientes				*/
/*	Disenado por:                               			*/
/*	Fecha de escritura:     21/Ene/1994				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes  exclusivos  para el  Ecuador  de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su  uso no autorizado  queda expresamente  prohibido asi como	*/
/*	cualquier   alteracion  o  agregado  hecho por  alguno de sus	*/
/*	usuarios   sin el debido  consentimiento  por  escrito  de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones del stored procedure	*/
/*      Insercion de                                                    */
/*      Modificacion de                                                 */
/*      Borrado de                                                      */
/*	Busqueda de      						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	21/Ene/1994	F.Espinosa     	Emision Inicial			*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_tablas')
   drop proc sp_tablas
go

create proc sp_tablas (
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
        @i_operacion		char(1),
        @i_modo			tinyint = null,
        @i_tipo			char(1) = null,
        @i_secuencial           int = null,  
        @i_codigo		smallint = null,
        @i_tabla		varchar(30) =null ,
        @i_descripcion 		descripcion = null,  
	@i_central_transmit	char(1) = null
)
as

declare @w_return       int,
        @w_sp_name	varchar(32),
	@w_codigo	smallint ,
	@w_tabla 	char(30),
	@w_descripcion	descripcion, 
	@v_codigo	smallint ,
	@v_tabla	varchar(30),
	@v_descripcion	descripcion,
	@o_tabla	smallint,
	@w_num_nodos     smallint,    
	@w_contador      smallint,    
	@w_nt_nombre     varchar(40), 
	@w_cmdtransrv    varchar(60),
	@w_clave         int         

select @w_sp_name = 'sp_tablas'


if ( @i_operacion = 'I' or @i_operacion = 'U' ) and 
   ( @i_central_transmit is null)
begin
      create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60),nt_bandera char(1))
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 1532
begin 

  /* comprobar que no existan datos duplicados */
     if exists ( select	codigo 
	           from	cl_tabla
	          where	tabla = @i_tabla )
     begin
	/* 'Tabla ya existe'*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101112 
	return 1
     end

  begin tran
      if @i_secuencial is null
      begin
     /* Encontrar un nuevo secuencial */
     exec sp_cseqnos
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_tabla	= 'cl_tabla',
		@o_siguiente	= @o_tabla out
       select @i_secuencial = @o_tabla
       end
       else
       /* Pasamos secuencial que viene de nodo Unix */
       select @o_tabla = @i_secuencial

     /* Insertar los datos de entrada */
     insert into cl_tabla  (codigo,tabla,descripcion)
	  values (@o_tabla, @i_tabla, @i_descripcion)


     /* Si no se puede insertar error */
     if @@error != 0
     begin
	/* 'Error en creacion de tabla '*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103063
	return 1
     end

     /* transaccion servicio - nuevos */
     insert into ts_tabla (secuencia, tipo_transaccion, clase, fecha,
		oficina_s, usuario, terminal_s, srv, lsrv,
		codigo, tabla, descripcion)
        values (@s_ssn, 1532 , 'N', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	        @o_tabla, @i_tabla, @i_descripcion)

     /* Si no se puede insertar , error */
     if @@error != 0
     begin
	  /* 'Error en creacion de transaccion de servicios'*/
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	  return 1
     end

select @o_tabla      
commit tran
/****************************  Para  Unix   *************************/
        /* Cambios para Admin Distribuido */
	/* Cuando el servidor central esta en ESTE nodo     */
	/* o sea cuando se ejecuta en SYBASE                */
	                                                    
	/* Insercion en nodos a distribuir en la tabla temporal */
	insert into #ad_nodo_reentry_tmp
	select nl_nombre,'N'
          from ad_nodo_oficina,ad_server_logico
	 where nl_nombre <> @s_lsrv          
	   and nl_filial   = sg_filial_i   
	   and nl_oficina  = sg_oficina_i 
	   and nl_nodo     = sg_nodo_i    
	   and sg_producto = 1             
	   and sg_tipo     = 'R'           
	   and sg_moneda   = 0             


	select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

	/* Lazo para hacer REENTRY a los nodos de la tabla temporal */
	select @w_contador = 1
	while @w_contador <= @w_num_nodos
         begin
		set rowcount 1
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		 where nt_bandera = 'N'

		set rowcount 0

		update #ad_nodo_reentry_tmp set nt_bandera = 'S'
 		where nt_nombre = @w_nt_nombre
	        
		exec @w_return = @w_cmdtransrv	                          
					@t_rty	       = 'S',
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
                                        @i_secuencial  = @i_secuencial,
					@i_tabla       = @i_tabla,
					@i_descripcion = @i_descripcion,
					@i_central_transmit = 'S',
					@o_clave        = @w_clave  out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
					@i_key  = @w_clave,
					@i_tipo = 'I'

			if @w_return <> 0
				return @w_return

			select @w_contador = @w_contador + 1
			continue
	end
	delete #ad_nodo_reentry_tmp
/****************************  Para  Unix   *************************/
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
if @t_trn = 1533
begin


  /* Guardar los datos anteriores */
  select @w_codigo = codigo,
	 @w_tabla = tabla,
         @w_descripcion = descripcion
    from cl_tabla
   where  codigo = @i_codigo

  if @@rowcount != 1 
  begin
        /* No existe tabla */
	exec sp_cerror 
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101003
	return 1
  end

  /* Guardar en transacciones de servicio solo los datos que han
     cambiado */
  select @v_codigo = @w_codigo,
         @v_tabla = @w_tabla,
         @v_descripcion = @w_descripcion

  If @w_codigo = @i_codigo
     select @w_codigo = null, @v_codigo = null
  else
     select @w_codigo = @i_codigo

  If @w_tabla = @i_tabla
     select @w_tabla = null, @v_tabla = null
  else
     select @w_tabla = @i_tabla

  If @w_descripcion = @i_descripcion
     select @w_descripcion = null, @v_descripcion = null
  else
     select @w_descripcion = @i_descripcion
 
  begin tran

     update cl_tabla
     /* set codigo     	    = @i_codigo, PES 2000-01-31 */
	set  tabla          = @i_tabla,
	     descripcion    = @i_descripcion
        where codigo  = @i_codigo

     if @@error != 0
     begin
	/* 'Error en actualizacion de tabla '*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 105056
	return 1
     end

     /* transaccion servicios - previo */
     insert into ts_tabla (secuencia, tipo_transaccion, clase, fecha,
		   oficina_s, usuario, terminal_s, srv, lsrv,
		   codigo, tabla, descripcion
                  )
        values (@s_ssn, 1533, 'P', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	        @i_codigo, @v_tabla, @v_descripcion)

     if @@error != 0
     begin
	/* 'Error en creacion de transaccion de servicios'*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	return 1
     end

     /* transaccion servicios - anterior */
     insert into ts_tabla  (secuencia, tipo_transaccion, clase, fecha,
		   oficina_s, usuario, terminal_s, srv, lsrv,
                   codigo,tabla,descripcion)
        values (@s_ssn, 1533, 'A', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	        @i_codigo, @w_tabla, @w_descripcion
               )

     if @@error != 0
     begin
	/* 'Error en creacion de transaccion de servicios'*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	return 1
     end
  commit tran

/****************************  Para  Unix   *************************/

        /* Cambios para Admin Distribuido */
	/* Cuando el servidor central esta en ESTE nodo     */
	/* o sea cuando se ejecuta en SYBASE                */

	insert into #ad_nodo_reentry_tmp
	select nl_nombre,'N'
          from ad_nodo_oficina,ad_server_logico
	 where nl_nombre <> @s_lsrv          
	   and nl_filial   = sg_filial_i   
	   and nl_oficina  = sg_oficina_i 
	   and nl_nodo     = sg_nodo_i    
	   and sg_producto = 1             
	   and sg_tipo     = 'R'           
	   and sg_moneda   = 0             

	select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

	/* Lazo para hacer REENTRY a los nodos de la tabla temporal */
	select @w_contador = 1
	while @w_contador <= @w_num_nodos
         begin
		set rowcount 1
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'
		set rowcount 0
	        
		 update #ad_nodo_reentry_tmp set nt_bandera = 'S'
 		 where nt_nombre = @w_nt_nombre

		exec @w_return = @w_cmdtransrv	                           
					@t_rty	       = 'S',
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_codigo      = @i_codigo,
					@i_tabla       = @i_tabla,
					@i_descripcion = @i_descripcion,
					@i_central_transmit = 'S',
					@o_clave        = @w_clave  out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
					@i_key  = @w_clave,
					@i_tipo = 'I'

			if @w_return <> 0
				return @w_return

			select @w_contador = @w_contador + 1
			continue
	end
	delete #ad_nodo_reentry_tmp
/****************************  Para  Unix   *************************/
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
Begin
   If @t_trn = 15055
   begin
     set rowcount 20
     if @i_modo = 0
     begin
        select  'Codigo'      = codigo,
	 	'Descripcion' = substring(descripcion, 1, 30),  
 	        'Tabla'       = substring(tabla, 1, 30)
          from cobis..cl_tabla
	set rowcount 0
	return 0
     end
	

     if @i_modo = 1
     begin
        select  'Codigo'      = codigo,
  		'Descripcion' = substring(descripcion, 1, 30),  
 	        'Tabla'       = substring(tabla, 1, 30)
          from cobis..cl_tabla
	  where @i_codigo < codigo

	 if @@rowcount = 0
	 begin
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 151121
		   /*  'No existen más datos' */
		return 1
	 end
	 set rowcount 0
	 return 0
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

/* Query */
if @i_operacion = 'Q' 
begin
If @t_trn = 15056
begin
	select codigo,
	       tabla,
	       descripcion
	  from cl_tabla
         where codigo = @i_codigo
	
	if @@rowcount = 0
	begin
	     /* No existe la tabla */ 		
	     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101003
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
