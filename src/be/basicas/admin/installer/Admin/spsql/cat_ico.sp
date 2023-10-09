/************************************************************************/
/*      Archivo:                cat_ico.sp                              */
/*      Stored procedure:       sp_cat_icono                            */
/*      Base de datos:          cobis                                   */
/*      Producto: Administrador                                         */
/*      Disenado por:  Patricio Martinez / Diego Hidalgo                */
/*      Fecha de escritura: 04-05-1995                                  */
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
/*      Insercion de catalogo icono                                     */
/*      Actualizacion de catalogo icono                                 */ 
/*      Eliminacion de catalogo icono                                   */
/*      Busqueda de de catalogo icono                                   */
/*      Consulta de catalogo icono                                      */
/*      Ayuda de catalogo icono                                         */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      04/May/1995     D.Hidalgo       Emision inicial                 */
/************************************************************************/
use cobis
go

if exists ( select * from sysobjects where name = 'sp_cat_icono')
   drop proc sp_cat_icono






go
create proc sp_cat_icono (
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
	@i_codigo_icono         tinyint = NULL,
	@i_icopath_bmp          descripcion = NULL,
	@i_nombre               descripcion = NULL
)
as
declare
	@w_sp_name              varchar(32),
	@w_today                datetime,
	@w_return               int,
	@w_nombre               descripcion,
	@w_icopath_bmp          descripcion,
	@w_siguiente            int,
	@v_nombre               descripcion,
	@v_icopath_bmp          descripcion
	
select @w_today = @s_date
select @w_sp_name = 'sp_cat_icono'


/* ** Insert ** */
if @i_operacion = 'I'
begin

  if @t_trn = 15143
    begin
      /* chequeo de claves primarias y foraneas */
      if ( @i_codigo_icono is NULL OR @i_nombre is NULL OR
	   @i_icopath_bmp is NULL)
      begin
	/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	return 1
      end

      begin tran

	/* insercion de datos en la tabla ad_mapa */
	insert into ad_catalogo_icono (ci_codigo_icono, ci_nombre,
				       ci_icopath_bmp)
		      values (@i_codigo_icono, @i_nombre, @i_icopath_bmp)
	if @@error != 0
	  begin
	    /*  'Error en insercion de Catalogo Icono */  
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 153037
	    return 1
	  end
	
	/* transaccion de servicio */
	insert into ts_cat_icono (secuencia, tipo_transaccion, clase, fecha,
			          link, nombre, descripcion, fecha_ult_mod)
		          values (@s_ssn, 15143, 'I', @s_date, @i_codigo_icono,
			          @i_nombre, @i_icopath_bmp, @w_today)
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
  if @t_trn = 15144
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_icono is NULL)
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
	select ci_codigo_icono
	  from ad_catalogo_icono
	 where ci_codigo_icono = @i_codigo_icono )
      begin
	/*  'No existe icono' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151077
	return 1
      end

      select @w_nombre = ci_nombre,
	     @w_icopath_bmp  = ci_icopath_bmp
	from ad_catalogo_icono
       where ci_codigo_icono = @i_codigo_icono

      if @@rowcount = 0
	begin
	  /*  'No existe icono' */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file  	= @t_file,
		@t_from  	= @w_sp_name,
		@i_num   	= 151077
	  return 1
	end

      /**** verificacion de campos a actualizar ****/
      select @v_nombre = @w_nombre,
	     @v_icopath_bmp  = @w_icopath_bmp

      if @w_nombre = @i_nombre
	 select @w_nombre = NULL, @v_nombre = NULL
      else
	 select @w_nombre = @i_nombre

      if @w_icopath_bmp = @i_icopath_bmp
	 select @w_icopath_bmp = NULL, @v_icopath_bmp = NULL
      else
	 select @w_icopath_bmp = @i_icopath_bmp

      begin tran
	Update ad_catalogo_icono
	   set ci_nombre = @i_nombre,
	       ci_icopath_bmp  = @i_icopath_bmp
	 where ci_codigo_icono = @i_codigo_icono

	if @@error != 0
	  begin
	    /*  'Error en la actualizacion de Catalogo Icono' */
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 155032
	    return 1
	  end

	/* transaccion de servicio */
	insert into ts_cat_icono (secuencia, tipo_transaccion, clase, fecha,
			          link, nombre, descripcion, fecha_ult_mod)
		       values (@s_ssn, 15144, 'U', @s_date, @i_codigo_icono,
		               @v_nombre, @v_icopath_bmp, @w_today)
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

	insert into ts_cat_icono (secuencia, tipo_transaccion, clase, fecha,
			          link, nombre, descripcion, fecha_ult_mod)
		          values (@s_ssn, 15144, 'U', @s_date, @i_codigo_icono,
			          @w_nombre, @w_icopath_bmp, @w_today)
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

/* ** search ** */

/* ** Query ** */
if @i_operacion = 'Q'
begin
  If @t_trn = 15147
    begin
      select ci_codigo_icono
	from ad_catalogo_icono
       where ci_nombre = @i_nombre 
	
      if @@rowcount = 0
	begin
	  /*  'No existe icono'*/
	  exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num 	 = 151077
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
  If @t_trn = 15148
    begin
      if @i_tipo = 'A'
	begin
	  select 'CODIGO ICONO' = ci_codigo_icono,
		 'NOMBRE' = substring(ci_nombre,1,20),
		 'UBICACION DISCO' = substring(ci_icopath_bmp,1,40)
	      from ad_catalogo_icono
	  return 0
	end

      if @i_tipo = 'V'
	begin
	  select ci_nombre
	    from ad_catalogo_icono
	   where ci_codigo_icono = @i_codigo_icono
          if @@rowcount = 0
	    begin
	      /*  'No existe icono'*/
	      exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 151077
	      return 1
	    end
          return 0
        end
      
      if @i_tipo = 'B'
	begin
	  select ci_nombre,
		 ci_icopath_bmp
	    from ad_catalogo_icono
	   where ci_codigo_icono = @i_codigo_icono
          if @@rowcount = 0
	    begin
	      /*  'No existe icono'*/
	      exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 151077
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

/* ** Creacion del icono 0 ( Ninguno )** */
if @i_operacion = 'Z'
begin
  If @t_trn = 15143
    begin
      if not exists (
	select ci_codigo_icono
	  from ad_catalogo_icono
	 where ci_codigo_icono = 0 )
      begin
        begin tran
	  /* insercion de datos en la tabla ad_mapa */
	  insert into ad_catalogo_icono (ci_codigo_icono, ci_nombre,
				         ci_icopath_bmp)
		                 values (0, 'Ninguno', ' ')
	  if @@error != 0
	    begin
	      /*  'Error en insercion de Catalogo Icono */  
	      exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num  	 = 153037
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

