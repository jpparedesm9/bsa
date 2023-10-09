/************************************************************************/
/*	Archivo:		nivel.sp				*/
/*	Stored procedure:	sp_nivel	 			*/
/*	Base de datos:		cobis					*/
/*	Producto: Administrador						*/
/*	Disenado por:  Patricio Martinez / Diego Hidalgo		*/
/*	Fecha de escritura: 06-04-1995					*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Insercion de un nivel						*/
/*	Actualizacion de un nivel					*/
/*      Eliminacion de un nivel						*/
/*      Busqueda de un nivel						*/
/* 	Consulta de un nivel						*/
/*	Ayuda de un nivel						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	06/Abr/1995	D.Hidalgo	Emision inicial			*/
/************************************************************************/

use cobis
go

if exists ( select * from sysobjects where name = 'sp_nivel')
   drop proc sp_nivel
go

create proc sp_nivel (
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
	@t_file			varchar(14) = NULL,
	@t_from			varchar(32) = NULL,
	@t_trn			smallint =NULL,
        @i_operacion            char(1),
	@i_modo			smallint = NULL,
	@i_tipo			char(1) = NULL,
        @i_codigo_nivel         tinyint = NULL,
        @i_nombre_nivel         descripcion = NULL
)
as
declare
	@w_sp_name		varchar(32),
	@w_today 		datetime,
        @w_nombre_nivel         descripcion,
        @v_nombre_nivel         descripcion,
        @o_codigo_nivel         tinyint,
        @o_nombre_nivel         descripcion
        
select @w_today = @s_date
select @w_sp_name = 'sp_nivel'


/* ** Insert ** */
if @i_operacion = 'I'
begin
  if @t_trn = 15112
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_nivel is NULL OR @i_nombre_nivel is NULL)
      begin
        /*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
        return 1
      end

      begin tran
        insert into ad_nivel (ni_codigo_nivel, ni_nombre_nivel)
    		      values (@i_codigo_nivel, @i_nombre_nivel)
        if @@error != 0
          begin
            /*  'Error en insercion de nivel'*/
            exec sp_cerror  
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	   	 @i_num	 	 = 153032
	    return 1
          end

        /* transaccion de servicio */
        insert into ts_nivel (secuencia, tipo_transaccion, clase, fecha,
			      link, nombre, fecha_ult_mod)
	              values (@s_ssn, 15112, 'I', @s_date,
			      @i_codigo_nivel, @i_nombre_nivel, @w_today)
        if @@error != 0
          begin
          /*  'Error en creacion de transaccion de servicio' */
	    exec sp_cerror
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	     	 @i_num	 	 = 153023
	    return 1
          end
      commit tran
      return 0
    end
  else
    begin
    /*  'No corresponde codigo de transaccion' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	return 1
    end
end


/* ** Update ** */
if @i_operacion = 'U'
begin
  if @t_trn = 15113
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_nivel is NULL)
      begin
        /*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
        return 1
      end

      if not exists (
	select ni_codigo_nivel
	  from ad_nivel
	 where ni_codigo_nivel = @i_codigo_nivel )
      begin
        /*  'No existe nivel' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151087
	return 1
      end

      select @w_nombre_nivel = ni_nombre_nivel
        from ad_nivel
       where ni_codigo_nivel = @i_codigo_nivel

      if @@rowcount = 0
        begin
          /*  'No existe nivel' */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file	 	= @t_file,
		@t_from	 	= @w_sp_name,
	  	@i_num	 	= 151087
	  return 1
        end

      /**** verificacion de campos a actualizar ****/
      select @v_nombre_nivel = @w_nombre_nivel

      if @w_nombre_nivel = @i_nombre_nivel
         select @w_nombre_nivel = NULL, @v_nombre_nivel = NULL
      else
         select @w_nombre_nivel = @i_nombre_nivel

      begin tran
        Update ad_nivel
           set ni_nombre_nivel = @i_nombre_nivel
         where ni_codigo_nivel = @i_codigo_nivel

        if @@error != 0
          begin
            /*  'Error en la actualizacion de nivel' */
	    exec sp_cerror
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	   	 @i_num	 	 = 155029
	    return 1
          end

        /* transaccion de servicio */
        insert into ts_nivel (secuencia, tipo_transaccion, clase, fecha,
			      link, nombre, fecha_ult_mod)
	              values (@s_ssn, 15113, 'U', @s_date,
			      @i_codigo_nivel, @v_nombre_nivel, @w_today)
        if @@error != 0
          begin
            /*  'Error en creacion de transaccion de servicio' */
	    exec sp_cerror
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	   	 @i_num	 	 = 153023
	    return 1
          end

        insert into ts_nivel (secuencia, tipo_transaccion, clase, fecha,
			      link, nombre, fecha_ult_mod)
	              values (@s_ssn, 15113, 'U', @s_date,
			      @i_codigo_nivel, @w_nombre_nivel, @w_today)
        if @@error != 0
          begin
            /*  'Error en creacion de transaccion de servicio' */
	    exec sp_cerror
	  	@t_debug	 = @t_debug,
	   	@t_file	 	 = @t_file,
	   	@t_from	 	 = @w_sp_name,
	   	@i_num	 	 = 153023
	    return 1
          end
      commit tran
      return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
      return 1
    end
end


/* ** Delete ** */
if @i_operacion = 'D'
begin
  if @t_trn = 15114
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_nivel is NULL)
      begin
        /*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
        return 1
      end

      if not exists (
	select ni_codigo_nivel
	  from ad_nivel
	 where ni_codigo_nivel = @i_codigo_nivel )
      begin
        /*  'No existe nivel' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151087
	return 1
      end

      select @w_nombre_nivel = ni_nombre_nivel
        from ad_nivel
       where ni_codigo_nivel = @i_codigo_nivel

      if @@rowcount = 0
        begin
          /*  'No existe nivel' */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file	 	= @t_file,
		@t_from	 	= @w_sp_name,
	  	@i_num	 	= 151087
	  return 1
        end

      /* deteccion de referencias */

      if exists(
	   select nm_codigo_nivel
	     from ad_nivel_mapa
	    where nm_codigo_nivel = @i_codigo_nivel )
	begin
          /* Existe referencia en la tabla nivel_mapa */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file	 	= @t_file,
		@t_from	 	= @w_sp_name,
	  	@i_num	 	= 157055
	  return 1
        end
      
      if exists(
	   select ic_codigo_nivel
	     from ad_icono
	    where ic_codigo_nivel = @i_codigo_nivel )
	begin
          /* Existe referencia en la tabla icono */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file	 	= @t_file,
		@t_from	 	= @w_sp_name,
	  	@i_num	 	= 157056
	  return 1
        end

      if exists(
	   select nn_codigo_nivel
	     from ad_nodo_nivel
	    where nn_codigo_nivel = @i_codigo_nivel )
	begin
          /* Existe referencia en la tabla nodo_nivel */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file	 	= @t_file,
		@t_from	 	= @w_sp_name,
	  	@i_num	 	= 157057
	  return 1
        end
 
      /* borrado de nivel */
      begin Tran
        Delete ad_nivel
         where ni_codigo_nivel = @i_codigo_nivel

        if @@error != 0
          begin
            /*  'Error en la eliminacion de nivel'*/
	    exec sp_cerror
	   	@t_debug	= @t_debug,
	   	@t_file	 	= @t_file,
	   	@t_from	 	= @w_sp_name,
	   	@i_num	 	= 157052
	    return 1
          end

        /* transaccion de servicio */
        insert into ts_nivel (secuencia, tipo_transaccion, clase, fecha,
			      link, nombre, fecha_ult_mod)
	              values (@s_ssn, 15114, 'D', @s_date,
			      @i_codigo_nivel, @w_nombre_nivel, @w_today)
        if @@error != 0
          begin
            /*  'Error en creacion de transaccion de servicio' */
	    exec sp_cerror
	  	@t_debug	= @t_debug,
	   	@t_file	 	= @t_file,
	   	@t_from	 	= @w_sp_name,
	   	@i_num	 	= 153023
	    return 1
          end
      commit tran
      return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
      return 1
    end
end


/* ** search ** */
if @i_operacion = 'S'
begin
  If @t_trn = 15115
    begin
      set rowcount 20
      if @i_modo = 0
        begin
	  select 'Codigo Nivel' = ni_codigo_nivel,
		 'Nombre Nivel' = ni_nombre_nivel
	    from ad_nivel
          set rowcount 0
        end

      if @i_modo = 1
        begin
	  select 'Codigo Nivel' = ni_codigo_nivel,
		 'Nombre Nivel' = ni_nombre_nivel
	    from ad_nivel
	   where (
		 (ni_codigo_nivel > @i_codigo_nivel)
	      or (ni_codigo_nivel = @i_codigo_nivel)
	         )
	  set rowcount 0
        end
      return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
      return 1
    end
end


/* ** Query ** */
if @i_operacion = 'Q'
begin
  If @t_trn = 15116
    begin
      select ni_codigo_nivel
	from ad_nivel
       where ni_nombre_nivel = @i_nombre_nivel
	
      if @@rowcount = 0
	begin
          /*  'No existe nivel'*/
	  exec sp_cerror
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	   	 @i_num	 	 = 151087
	  return 1
	end
      return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
      return 1
    end
end


/* ** help ** */
if @i_operacion = 'H'
begin
  If @t_trn = 15117
    begin
      if @i_tipo = 'A'
        begin
          select   'Codigo Nivel' = ni_codigo_nivel,
	           'Nombre Nivel' = ni_nombre_nivel
	      from ad_nivel
         order by ni_codigo_nivel
        end

      if @i_tipo = 'V'
        begin
          select 'Nombre Nivel' = ni_nombre_nivel
	    from ad_nivel
           where ni_codigo_nivel = @i_codigo_nivel
          if @@rowcount = 0
	    begin
          	/*  'No existe nivel'*/
		 exec sp_cerror
	  		 @t_debug	 = @t_debug,
	   		 @t_file	 = @t_file,
	   		 @t_from	 = @w_sp_name,
	   		 @i_num	 	 = 151087
	 	 return 1
	    end
         end
       return 0
    end
  else
    begin
      /*  'No corresponde codigo de transaccion' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
      return 1
    end
end

go

