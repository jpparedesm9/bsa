/************************************************************************/
/*      Archivo:                mapa.sp                                 */
/*      Stored procedure:       sp_mapa                                 */
/*      Base de datos:          cobis                                   */
/*      Producto: Administrador                                         */
/*      Disenado por:  Patricio Martinez / Diego Hidalgo                */
/*      Fecha de escritura: 06-04-1995                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Insercion de un mapa                                            */
/*      Actualizacion de un mapa                                        */
/*      Eliminacion de un mapa                                          */
/*      Busqueda de un mapa                                             */
/*      Consulta de un mapa                                             */
/*      Ayuda de un mapa                                                */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      06/Abr/1995     D.Hidalgo       Emision inicial                 */
/************************************************************************/
use cobis
go

if exists ( select * from sysobjects where name = 'sp_mapa')
   drop proc sp_mapa






go
create proc sp_mapa (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(30) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = NULL,
	@t_from                 varchar(32) = NULL,
	@t_trn                  smallint = NULL,
	@i_operacion            char(1),
	@i_modo                 smallint = NULL,
	@i_tipo                 char(1) = NULL,
	@i_codigo_nivel         tinyint = NULL,
	@i_codigo_mapa          tinyint = NULL,
	@i_nombre_mapa          descripcion = NULL,
	@i_mapath_bmp           descripcion = NULL,
	@o_codigo_mapa          tinyint = NULL out
)
as
declare
	@w_sp_name              varchar(32),
	@w_today                datetime,
	@w_return               int,
	@w_nombre_mapa          descripcion,
	@w_mapath_bmp           descripcion,
	@w_siguiente            int,
	@v_nombre_mapa          descripcion,
	@v_mapath_bmp           descripcion,
	@o_siguiente            int
	
select @w_today = @s_date
select @w_sp_name = 'sp_mapa'


/* ** Insert ** */
if @i_operacion = 'I'
begin
  if @t_trn = 15118
    begin
      /* chequeo de claves primarias y foraneas */
      if ( @i_nombre_mapa is NULL OR @i_mapath_bmp is NULL)
      begin
	/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	return 1
      end

      if not exists (
	select ni_codigo_nivel
	  from ad_nivel
	 where ni_codigo_nivel = @i_codigo_nivel )
      begin
	/*  'No existe nivel' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151087
	return 1
      end

      begin tran
        exec @w_return = sp_cseqnos @i_tabla = 'ad_mapa',
			 @o_siguiente = @w_siguiente out
	if @w_return != 0
	   return @w_return

	select @i_codigo_mapa = @w_siguiente

	/* insercion de datos en la tabla ad_mapa */
	insert into ad_mapa (mp_codigo_mapa, mp_nombre_mapa, mp_mapath_bmp)
		      values (@i_codigo_mapa, @i_nombre_mapa, @i_mapath_bmp)
	if @@error != 0
	  begin
	    /*  'Error en insercion de mapa'*/
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 153033
	    return 1
	  end
	
	/* insercion de datos en la tabla ad_nivel_mapa */
	insert into ad_nivel_mapa (nm_codigo_nivel, nm_codigo_mapa)
		      values (@i_codigo_nivel, @i_codigo_mapa)
	if @@error != 0
	  begin
	    /*  'Error en insercion de nivel mapa'*/
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 153035
	    return 1
	  end

	/* transaccion de servicio */
	insert into ts_mapa (secuencia, tipo_transaccion, clase, fecha,
			     link, nombre, descripcion, fecha_ult_mod)
		      values (@s_ssn, 15118, 'I', @s_date, @i_codigo_mapa,
			      @i_nombre_mapa, @i_mapath_bmp, @w_today)
	if @@error != 0
	  begin
	  /*  'Error en creacion de transaccion de servicio' */
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 153023
	    return 1
	  end
      commit tran
      select @o_codigo_mapa = @w_siguiente
      select @o_codigo_mapa 
      return 0
    end
  else
    begin
    /*  'No corresponde codigo de transaccion' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
	return 1
    end
end


/* ** Update ** */
if @i_operacion = 'U'
begin
  if @t_trn = 15119
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_mapa is NULL)
      begin
	/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	return 1
      end

      if not exists (
	select mp_codigo_mapa
	  from ad_mapa
	 where mp_codigo_mapa = @i_codigo_mapa )
      begin
	/*  'No existe mapa' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151088
	return 1
      end

      select @w_nombre_mapa = mp_nombre_mapa,
	     @w_mapath_bmp  = mp_mapath_bmp
	from ad_mapa
       where mp_codigo_mapa = @i_codigo_mapa

      if @@rowcount = 0
	begin
	  /*  'No existe mapa' */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file  	= @t_file,
		@t_from  	= @w_sp_name,
		@i_num   	= 151088
	  return 1
	end

      /**** verificacion de campos a actualizar ****/
      select @v_nombre_mapa = @w_nombre_mapa,
	     @v_mapath_bmp  = @w_mapath_bmp

      if @w_nombre_mapa = @i_nombre_mapa
	 select @w_nombre_mapa = NULL, @v_nombre_mapa = NULL
      else
	 select @w_nombre_mapa = @i_nombre_mapa

      if @w_mapath_bmp = @i_mapath_bmp
	 select @w_mapath_bmp = NULL, @v_mapath_bmp = NULL
      else
	 select @w_mapath_bmp = @i_mapath_bmp

      begin tran
	Update ad_mapa
	   set mp_nombre_mapa = @i_nombre_mapa,
	       mp_mapath_bmp  = @i_mapath_bmp
	 where mp_codigo_mapa = @i_codigo_mapa

	if @@error != 0
	  begin
	    /*  'Error en la actualizacion de mapa' */
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 155030
	    return 1
	  end

	/* transaccion de servicio */
	insert into ts_mapa (secuencia, tipo_transaccion, clase, fecha,
			     link, nombre, descripcion, fecha_ult_mod)
		      values (@s_ssn, 15119, 'U', @s_date, @i_codigo_mapa,
			      @v_nombre_mapa, @v_mapath_bmp, @w_today)
	if @@error != 0
	  begin
	    /*  'Error en creacion de transaccion de servicio' */
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num		 = 153023
	    return 1
	  end

	insert into ts_mapa (secuencia, tipo_transaccion, clase, fecha,
			     link, nombre, descripcion, fecha_ult_mod)
		      values (@s_ssn, 15119, 'U', @s_date, @i_codigo_mapa,
			      @w_nombre_mapa, @w_mapath_bmp, @w_today)
	if @@error != 0
	  begin
	    /*  'Error en creacion de transaccion de servicio' */
	    exec sp_cerror
		@t_debug         = @t_debug,
		@t_file 	 = @t_file,
		@t_from  	 = @w_sp_name,
		@i_num   	 = 153023
	    return 1
	  end
      commit tran
      return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
      return 1
    end
end


/* ** Delete ** */
if @i_operacion = 'D'
begin
  if @t_trn = 15120
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_mapa is NULL)
      begin
	/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	return 1
      end

      if not exists (
	select mp_codigo_mapa
	  from ad_mapa
	 where mp_codigo_mapa = @i_codigo_mapa )
      begin
	/*  'No existe mapa' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151088
	return 1
      end

      select @w_nombre_mapa = mp_nombre_mapa,
	     @w_mapath_bmp  = mp_mapath_bmp
	from ad_mapa
       where mp_codigo_mapa = @i_codigo_mapa

      if @@rowcount = 0
	begin
	  /*  'No existe mapa' */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file  	= @t_file,
		@t_from  	= @w_sp_name,
		@i_num   	= 151088
	  return 1
	end

      /* deteccion de referencias */
      if exists (
	select nn_codigo_mapa
	  from ad_nodo_nivel
         where nn_codigo_mapa = @i_codigo_mapa)
      begin
      /* 'Existe referencia en nodo nivel' */
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 157057
	    return 1
      end
      
      if exists (
	select ic_codigo_mapa
	  from ad_icono
         where ic_codigo_mapa = @i_codigo_mapa)
      begin
      /* 'Existe referencia en icono' */
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 157056
	    return 1
      end
          
      /* borrado de mapa */
      begin Tran
	Delete ad_mapa
	 where mp_codigo_mapa = @i_codigo_mapa
	if @@error != 0
	  begin
	    /*  'Error en la eliminacion de mapa'*/
	    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 157053
	    return 1
	  end
	
	Delete ad_nivel_mapa
	 where nm_codigo_mapa = @i_codigo_mapa
	if @@error != 0
	  begin
	    /*  'Error en la eliminacion de nivel mapa'*/
	    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 157058
	    return 1
	  end

	/* transaccion de servicio */
	insert into ts_mapa (secuencia, tipo_transaccion, clase, fecha,
			     link, nombre, descripcion, fecha_ult_mod)
		      values (@s_ssn, 15120, 'D', @s_date, @i_codigo_mapa,
			      @w_nombre_mapa, @w_mapath_bmp, @w_today)
	if @@error != 0
	  begin
	    /*  'Error en creacion de transaccion de servicio' */
	    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 153023
	    return 1
	  end
      commit tran
      return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
      return 1
    end
end


/* ** search ** */
if @i_operacion = 'S'
begin
  If @t_trn = 15121
    begin
      set rowcount 20
      if @i_modo = 0
	begin
	  select 'CODIGO MAPA' = mp_codigo_mapa,
		 'NOMBRE MAPA' = substring(mp_nombre_mapa,1,20),
		 'UBICACION DISCO' = substring(mp_mapath_bmp,1,30)
	    from ad_mapa
	  set rowcount 0
	end

      if @i_modo = 1
	begin
	  select 'CODIGO MAPA' = mp_codigo_mapa,
		 'NOMBRE MAPA' = substring(mp_nombre_mapa,1,20),
		 'UBICACION DISCO' = substring(mp_mapath_bmp,1,30)
	    from ad_mapa
	   where (
		 (mp_codigo_mapa > @i_codigo_mapa)
	      or (mp_codigo_mapa = @i_codigo_mapa)
		 )
	  set rowcount 0
	end
      return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
      return 1
    end
end


/* ** Query ** */
if @i_operacion = 'Q'
begin
  If @t_trn = 15122
    begin
      select mp_codigo_mapa
	from ad_mapa
       where mp_nombre_mapa = @i_nombre_mapa
	
      if @@rowcount = 0
	begin
	  /*  'No existe mapa'*/
	  exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num 	 = 151088
	  return 1
	end
      return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
      return 1
    end
end


/* ** help ** */
if @i_operacion = 'H'
begin
  If @t_trn = 15123
    begin
      if @i_tipo = 'A'
	begin
	  select   'CODIGO MAPA' = mp_codigo_mapa,
		   'NOMBRE MAPA' = mp_nombre_mapa,
 		   'UBICACION DISCO' = mp_mapath_bmp
	      from ad_mapa
          return 0
	end

      if @i_tipo = 'V'
	begin
	  select 'Nombre mapa' = mp_nombre_mapa
	    from ad_mapa
	   where mp_codigo_mapa = @i_codigo_mapa
          if @@rowcount = 0
	    begin
	      /*  'No existe mapa'*/
	      exec sp_cerror
		@t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 151088
	      return 1
	    end
          return 0
        end
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
      return 1
    end
end

/* ** Creacion mapa 0 (no existe) ** */
if @i_operacion = 'Z'
begin
If @t_trn = 15118
  begin
    if not exists (
      select mp_codigo_mapa 
	from ad_mapa
       where mp_codigo_mapa = 0)
    begin
      begin tran
      /* insercion de datos en la tabla ad_mapa */
      insert into ad_mapa (mp_codigo_mapa, mp_nombre_mapa, mp_mapath_bmp)
 	           values (0,'Ninguno',' ')
      if @@error != 0
        begin
	  /*  'Error en insercion de mapa'*/
	  exec sp_cerror
	     @t_debug        = @t_debug,
	     @t_file         = @t_file,
	     @t_from         = @w_sp_name,
	     @i_num  	     = 153033
	  return 1
        end
      commit tran
      return 0
    end
  end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
      return 1
    end
end

go

