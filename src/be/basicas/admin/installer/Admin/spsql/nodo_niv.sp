/************************************************************************/
/*      Archivo:                nodo_niv.sp                             */
/*      Stored procedure:       sp_nodo_nivel                           */
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
/*      Insercion de un nodo_nivel                                      */
/*      Actualizacion de un nodo_nivel                                  */
/*      Eliminacion de un nodo_nivel                                    */
/*      Busqueda de un nodo_nivel                                       */
/*      Consulta de un nodo_nivel                                       */
/*      Ayuda de un nodo_nivel                                          */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      06/Abr/1995     D.Hidalgo       Emision inicial                 */
/************************************************************************/

use cobis
go

if exists ( select * from sysobjects where name = 'sp_nodo_nivel')
   drop proc sp_nodo_nivel





go
create proc sp_nodo_nivel (
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
	@t_trn                  smallint =NULL,
	@i_operacion            char(1),
	@i_modo                 smallint = NULL,
	@i_tipo                 char(1) = NULL,
	@i_filial               tinyint = NULL,
	@i_oficina              smallint = NULL,
	@i_nodo                 tinyint = NULL,
	@i_codigo_nivel         tinyint = NULL,
	@i_codigo_mapa          tinyint = 0,
	@i_codigo_icono         tinyint = NULL,
	@i_nombre_nodo          descripcion = NULL,
	@i_mapa_hijo            tinyint  = NULL,
	@i_x                    smallint = 0,
	@i_y                    smallint = 0
)
as
declare
	@w_sp_name              varchar(32),
	@w_today                datetime,
	@w_nombre_nodo          descripcion,
	@w_mapa_hijo            tinyint,
	@w_x                    smallint,
	@w_y                    smallint,
	@v_nombre_nodo          descripcion,
	@v_mapa_hijo            tinyint,
	@v_x                    smallint,
	@v_y                    smallint
	
select @w_today = @s_date
select @w_sp_name = 'sp_nodo_nivel'


/* ** Insert ** */
if @i_operacion = 'I'
begin
  if @t_trn = 15125
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_filial is NULL OR @i_oficina is NULL OR @i_nodo is NULL
	  OR @i_codigo_nivel is NULL OR @i_codigo_mapa is NULL)
	begin
	  /*  'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug        = @t_debug,
		@t_file  	= @t_file,
		@t_from  	= @w_sp_name,
		@i_num   	= 151001
	  return 1
	end
      
      if not exists (
	select of_oficina
	  from cl_oficina
	 where of_oficina = @i_oficina
	   and of_filial = @i_filial)
      begin
	/*  'No existe oficina' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101016
	return 1
      end

      if not exists (
	select no_nodo
	  from ad_nodo
	  where no_nodo = @i_nodo
	    and no_fecha_habil is not NULL
	    and no_estado = 'V')
      begin
	/*  'No existe nodo habilitado' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151002
	return 1
      end

      if not exists (
	select nl_nombre
	  from ad_nodo_oficina
	 where nl_filial = @i_filial
	   and nl_oficina = @i_oficina
	   and nl_nodo   = @i_nodo )
      begin
	/*  'No existe nodo oficina' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151079
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

      begin tran
	insert into ad_nodo_nivel (nn_filial, nn_oficina, nn_nodo,
		                   nn_codigo_nivel, nn_codigo_mapa,
				   nn_nombre_nodo, nn_mapa_hijo, nn_x, nn_y)
			   values (@i_filial, @i_oficina, @i_nodo,
				   @i_codigo_nivel, @i_codigo_mapa,
				   @i_nombre_nodo, @i_mapa_hijo, @i_x, @i_y)
	if @@error != 0
	  begin
	    /*  'Error en insercion de nodo_nivel'*/
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num          = 153034
	    return 1
	  end

	/* transaccion de servicio */
	insert into ts_nodo_nivel (secuencia, tipo_transaccion, clase, fecha,
				   filial, oficina, nodo, link, secuencial,
				   nombre, rol, tamanio, terminal,
				   fecha_ult_mod)
		           values (@s_ssn, 15125, 'I', @s_date, @i_filial,
				   @i_oficina, @i_nodo, @i_codigo_nivel, 
			           @i_codigo_mapa, @i_nombre_nodo,
				   @i_mapa_hijo, @i_x, @i_y, @w_today)
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


/* ** Update ** */
if @i_operacion = 'U'
begin
  if @t_trn = 15126
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_filial is NULL OR @i_oficina is NULL OR @i_nodo is NULL
	  OR @i_codigo_nivel is NULL OR @i_codigo_mapa is NULL)
	begin
	  /*  'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug        = @t_debug,
		@t_file  	= @t_file,
		@t_from  	= @w_sp_name,
		@i_num   	= 151001
	  return 1
	end
      
      if not exists (
	select of_oficina
	  from cl_oficina
	 where of_oficina = @i_oficina
	   and of_filial = @i_filial)
      begin
	/*  'No existe oficina' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101016
	return 1
      end

      if not exists (
	select no_nodo
	  from ad_nodo
	  where no_nodo = @i_nodo
	    and no_fecha_habil is not NULL
	    and no_estado = 'V')
      begin
	/*  'No existe nodo habilitado' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151002
	return 1
      end

      if not exists (
	select nl_nombre
	  from ad_nodo_oficina
	 where nl_filial = @i_filial
	   and nl_oficina = @i_oficina
	   and nl_nodo   = @i_nodo )
      begin
	/*  'No existe nodo oficina' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151079
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

      select @w_nombre_nodo  = nn_nombre_nodo,
	     @w_mapa_hijo    = nn_mapa_hijo,
	     @w_x = nn_x,
	     @w_y = nn_y
	from ad_nodo_nivel
       where nn_filial  = @i_filial
         and nn_oficina = @i_oficina
         and nn_nodo    = @i_nodo
         and nn_codigo_nivel = @i_codigo_nivel
	 and nn_codigo_mapa  = @i_codigo_mapa

      if @@rowcount = 0
	begin
	  /*  'No existe nodo nivel' */
	  exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151078
	  return 1
	end

      /**** verificacion de campos a actualizar ****/
      select @v_nombre_nodo = @w_nombre_nodo,
	     @v_mapa_hijo = @w_mapa_hijo,
	     @v_x = @w_x,
	     @v_y = @w_y        

      if @w_nombre_nodo = @i_nombre_nodo
	 select @w_nombre_nodo = NULL, @v_nombre_nodo = NULL
      else
	 select @w_nombre_nodo = @i_nombre_nodo

      if @w_mapa_hijo = @i_mapa_hijo
	 select @w_mapa_hijo = NULL, @v_mapa_hijo = NULL
      else
	 select @w_mapa_hijo = @i_mapa_hijo

      if @w_x = @i_x
	 select @w_x = NULL, @v_x = NULL
      else
	 select @w_x = @i_x

      if @w_y = @i_y
	 select @w_y = NULL, @v_y = NULL
      else
	 select @w_y = @i_y

      begin tran
	Update ad_nodo_nivel
	   set nn_nombre_nodo = @i_nombre_nodo,
	       nn_mapa_hijo = @i_mapa_hijo,
	       nn_x = @i_x,
	       nn_y = @i_y      
         where nn_filial  = @i_filial
           and nn_oficina = @i_oficina
           and nn_nodo    = @i_nodo
           and nn_codigo_nivel = @i_codigo_nivel
	   and nn_codigo_mapa  = @i_codigo_mapa

	if @@error != 0
	  begin
	    /*  'Error en la actualizacion de nodo nivel' */
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num          = 155031
	    return 1
	  end

	/* transaccion de servicio */
	insert into ts_nodo_nivel (secuencia, tipo_transaccion, clase, fecha,
				   filial, oficina, nodo, link, secuencial,
				   nombre, rol, tamanio, terminal,
				   fecha_ult_mod)
		           values (@s_ssn, 15126, 'U', @s_date, @i_filial,
				   @i_oficina, @i_nodo, @i_codigo_nivel, 
			           @i_codigo_mapa, @v_nombre_nodo,
				   @v_mapa_hijo, @v_x, @v_y, @w_today)
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

	insert into ts_nodo_nivel (secuencia, tipo_transaccion, clase, fecha,
				   filial, oficina, nodo, link, secuencial,
				   nombre, rol, tamanio, terminal,
				   fecha_ult_mod)
		           values (@s_ssn, 15126, 'U', @s_date, @i_filial,
				   @i_oficina, @i_nodo, @i_codigo_nivel, 
			           @i_codigo_mapa, @w_nombre_nodo,
				   @w_mapa_hijo, @w_x, @w_y, @w_today)
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


/* ** Delete ** */
if @i_operacion = 'D'
begin
  if @t_trn = 15127
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_filial is NULL OR @i_oficina is NULL OR @i_nodo is NULL
	  OR @i_codigo_nivel is NULL OR @i_codigo_mapa is NULL)
	begin
	  /*  'No se llenaron todos los campos' */
	  exec sp_cerror
		@t_debug        = @t_debug,
		@t_file  	= @t_file,
		@t_from  	= @w_sp_name,
		@i_num   	= 151001
	  return 1
	end
      
      if not exists (
	select of_oficina
	  from cl_oficina
	 where of_oficina = @i_oficina
	   and of_filial = @i_filial)
      begin
	/*  'No existe oficina' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101016
	return 1
      end

      if not exists (
	select no_nodo
	  from ad_nodo
	  where no_nodo = @i_nodo
	    and no_fecha_habil is not NULL
	    and no_estado = 'V')
      begin
	/*  'No existe nodo habilitado' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151002
	return 1
      end

      if not exists (
	select nl_nombre
	  from ad_nodo_oficina
	 where nl_filial = @i_filial
	   and nl_oficina = @i_oficina
	   and nl_nodo   = @i_nodo )
      begin
	/*  'No existe nodo oficina' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151079
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

      select @w_nombre_nodo  = nn_nombre_nodo,
	     @w_mapa_hijo    = nn_mapa_hijo,
	     @w_x = nn_x,
	     @w_y = nn_y
	from ad_nodo_nivel
       where nn_filial  = @i_filial
         and nn_oficina = @i_oficina
         and nn_nodo    = @i_nodo
         and nn_codigo_nivel = @i_codigo_nivel
	 and nn_codigo_mapa  = @i_codigo_mapa

      if @@rowcount = 0
	begin
	  /*  'No existe nodo nivel' */
	  exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151078
	  return 1
	end

      /* deteccion de referencias */
      /* ver si existen referencias en rutas */

      /* borrado de nodo nivel */
      begin Tran
	Delete ad_nodo_nivel
	 where nn_filial  = @i_filial
           and nn_oficina = @i_oficina
           and nn_nodo    = @i_nodo
           and nn_codigo_nivel = @i_codigo_nivel
	   and nn_codigo_mapa  = @i_codigo_mapa

	if @@error != 0
	  begin
	    /*  'Error en la eliminacion de nodo_nivel'*/
	    exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 15704
	    return 1
	  end

	/* transaccion de servicio */
	insert into ts_nodo_nivel (secuencia, tipo_transaccion, clase, fecha,
				   filial, oficina, nodo, link, secuencial,
				   nombre, rol, tamanio, terminal,
				   fecha_ult_mod)
		           values (@s_ssn, 15127, 'D', @s_date, @i_filial,
				   @i_oficina, @i_nodo, @i_codigo_nivel, 
			           @i_codigo_mapa, @w_nombre_nodo,
				   @w_mapa_hijo, @w_x, @w_y, @w_today)
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
  If @t_trn = 15128
    begin
      set rowcount 20
      if @i_modo = 0
	begin
	  select 'NIVEL' = substring(ni_nombre_nivel,1,15),
		 'MAPA'  = substring(A.mp_nombre_mapa,1,20),
		 'MAPA HIJO' = substring(B.mp_nombre_mapa,1,20)
	    from ad_nodo_nivel, ad_nivel, ad_mapa A, ad_mapa B
 	   where nn_filial = @i_filial
	     and nn_oficina = @i_oficina
	     and nn_nodo = @i_nodo 
	     and ni_codigo_nivel = nn_codigo_nivel
	     and A.mp_codigo_mapa = nn_codigo_mapa
	     and B.mp_codigo_mapa = nn_mapa_hijo
	   order by ni_codigo_nivel, A.mp_codigo_mapa
	  set rowcount 0
	end

      if @i_modo = 1
	begin
	  select 'NIVEL' = substring(ni_nombre_nivel,1,15),
		 'MAPA'  = substring(A.mp_nombre_mapa,1,20),
		 'MAPA HIJO' = substring(B.mp_nombre_mapa,1,20)
	    from ad_nodo_nivel, ad_nivel, ad_mapa A, ad_mapa B
 	   where nn_filial = @i_filial
	     and nn_oficina = @i_oficina
	     and nn_nodo = @i_nodo 
	     and ni_codigo_nivel = nn_codigo_nivel
	     and A.mp_codigo_mapa = nn_codigo_mapa
	     and B.mp_codigo_mapa = nn_mapa_hijo
	     and nn_codigo_mapa > @i_codigo_mapa
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
  If @t_trn = 15129
    begin
	  select 'Filial'  = nn_filial,
	         'Oficina' = nn_oficina,
		 'Nodo'    = nn_nodo,
		 'Codigo Nivel' = nn_codigo_nivel,
		 'Codigo Mapa'  = nn_codigo_mapa,
		 'Nombre Nodo'  = nn_nombre_nodo,
		 'Nombre Mapa Hijo' = nn_mapa_hijo,
		 'Posicion X' = nn_x,
		 'Posicion Y' = nn_y
	    from ad_nodo_nivel
           where nn_filial  = @i_filial
             and nn_oficina = @i_oficina
             and nn_nodo    = @i_nodo
             and nn_codigo_nivel = @i_codigo_nivel
	     and nn_codigo_mapa  = @i_codigo_mapa
	     	
      if @@rowcount = 0
	begin
	  /*  'No existe nodo nivel'*/
	  exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num          = 151078
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
  If @t_trn = 15130
    begin
      if @i_tipo = 'A'
	begin
	   select 'Filial'  = nn_filial,
	          'Oficina' = nn_oficina,
		  'Nodo'    = nn_nodo,
		  'Nombre Nodo' = nn_nombre_nodo
	      from ad_nodo_nivel
	     where nn_codigo_nivel = @i_codigo_nivel
	       and nn_codigo_mapa = @i_codigo_mapa
	  order by nn_filial, nn_oficina, nn_nodo
	end
      if @i_tipo = 'V'
	begin
	  select 'Nombre Nodo' = nn_nombre_nodo
	    from ad_nodo_nivel
           where nn_filial  = @i_filial
             and nn_oficina = @i_oficina
             and nn_nodo    = @i_nodo
             and nn_codigo_nivel = @i_codigo_nivel
	     and nn_codigo_mapa  = @i_codigo_mapa
	end
      if @@rowcount = 0
	begin
	  /*  'No existe nodo nivel'*/
	  exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num          = 151078
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

go

