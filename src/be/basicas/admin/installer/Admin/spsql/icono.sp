/************************************************************************/
/*	Archivo:		icono.sp				*/
/*	Stored procedure:	sp_icono	 			*/
/*	Base de datos:		cobis					*/
/*	Producto: Administrador						*/
/*	Disenado por:  Patricio Martinez / Diego Hidalgo		*/
/*	Fecha de escritura: 04-04-1995					*/
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
/*	Insercion de un icono						*/
/*	Actualizacion de un icono					*/
/*      Eliminacion de un icono						*/
/*      Busqueda de un icono						*/
/* 	Consulta de un icono						*/
/*	Ayuda de un icono						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Abr/1995	D.Hidalgo	Emision inicial			*/
/*  21/Abr/2016 BBO         Migracion SYB-SQL FAL                       */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists ( select * from sysobjects where name = 'sp_icono')
   drop proc sp_icono





go
create proc sp_icono (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(32) = NULL,
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
        @i_codigo_mapa          tinyint = 0, 
        @i_codigo_icono         tinyint = NULL,
        @i_nombre_icono         descripcion = NULL,
        @i_mapa_hijo            tinyint = NULL,
	@i_x			smallint = NULL,
	@i_y			smallint = NULL
)
as
declare
	@w_sp_name		varchar(32),
	@w_today		datetime,
        @w_nombre_icono         descripcion,
	@w_x			smallint,
	@w_y			smallint,
        @v_nombre_icono         descripcion,
	@v_x			smallint,
	@v_y			smallint,
        @o_codigo_nivel         tinyint,
        @o_codigo_mapa          tinyint,
        @o_codigo_icono         tinyint,
        @o_nombre_icono         descripcion,
        @o_mapa_hijo            tinyint,
	@o_x			smallint,
	@o_y			smallint
        
select @w_today = @s_date
select @w_sp_name = 'sp_icono'


/* ** Insert ** */
if @i_operacion = 'I'
begin
  if @t_trn = 15157
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_nivel is NULL OR @i_codigo_mapa is NULL
	OR @i_codigo_icono is NULL OR @i_mapa_hijo is NULL)
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

      if not exists (
        select mp_codigo_mapa
          from ad_mapa
         where mp_codigo_mapa = @i_codigo_mapa )
      begin
        /*  'No existe mapa' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151088
        return 1
      end

      if not exists (
        select ci_codigo_icono
          from ad_catalogo_icono
         where ci_codigo_icono = @i_codigo_icono)
      begin
      /*  'No existe icono' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151077
	return 1
      end

      begin tran
        insert into ad_icono (ic_codigo_nivel, ic_codigo_mapa, ic_codigo_icono,
                              ic_nombre_icono, ic_mapa_hijo, ic_x, ic_y)
    		      values (@i_codigo_nivel, @i_codigo_mapa, @i_codigo_icono,
                              @i_nombre_icono, @i_mapa_hijo, @i_x, @i_y)
        if @@error != 0
          begin
            /*  'Error en insercion de icono'*/
	    exec sp_cerror
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	   	 @i_num	 	 = 153035
	    return 1
          end

        /* transaccion de servicio */
        insert into ts_icono (secuencia, tipo_transaccion, clase, fecha,
			      link, secuencial, horario, nombre, rol,
			      tamanio, terminal, fecha_ult_mod)
	              values (@s_ssn, 15157, 'I', @s_date, @i_codigo_nivel, 
 		              @i_codigo_mapa, @i_codigo_icono,
	  		      @i_nombre_icono, @i_mapa_hijo, @i_x, @i_y,
			      @w_today)
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
  if @t_trn = 15158
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_nivel is NULL OR @i_codigo_mapa is NULL
	  OR @i_codigo_icono is NULL OR @i_mapa_hijo is NULL)
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

      if not exists (
        select mp_codigo_mapa
          from ad_mapa
          where mp_codigo_mapa = @i_codigo_mapa )
      begin
      /*  'No existe mapa' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151088
        return 1
      end

      if not exists (
        select ci_codigo_icono
          from ad_catalogo_icono
          where ci_codigo_icono = @i_codigo_icono)
      begin
      /*  'No existe icono' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151077
	return 1
      end

      select @w_nombre_icono = ic_nombre_icono,
	     @w_x = ic_x,
	     @w_y = ic_y
        from ad_icono
       where ic_codigo_nivel = @i_codigo_nivel
         and ic_codigo_mapa = @i_codigo_mapa
         and ic_codigo_icono = @i_codigo_icono
	 and ic_mapa_hijo = @i_mapa_hijo

      if @@rowcount = 0
        begin
          /*  'No existe icono' */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file	 	= @t_file,
		@t_from	 	= @w_sp_name,
	  	@i_num	 	= 151077
	  return 1
        end

      /**** verificacion de campos a actualizar ****/
      select @v_nombre_icono = @w_nombre_icono,
	     @v_x = @w_x,
	     @v_y = @w_y	

      if @w_nombre_icono = @i_nombre_icono
         select @w_nombre_icono = NULL, @v_nombre_icono = NULL
      else
         select @w_nombre_icono = @i_nombre_icono

      if @w_x = @i_x
         select @w_x = NULL, @v_x = NULL
      else
         select @w_x = @i_x

      if @w_y = @i_y
         select @w_y = NULL, @v_y = NULL
      else
         select @w_y = @i_y

      begin tran
        Update ad_icono
           set ic_nombre_icono = @i_nombre_icono,
	       ic_x = @i_x,
	       ic_y = @i_y	
         where ic_codigo_nivel = @i_codigo_nivel
           and ic_codigo_mapa = @i_codigo_mapa
           and ic_codigo_icono = @i_codigo_icono
	   and ic_mapa_hijo = @i_mapa_hijo

        if @@error != 0
          begin
            /*  'Error en la actualizacion de icono' */
	    exec sp_cerror
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	   	 @i_num	 	 = 155028
	    return 1
          end

        /* transaccion de servicio */
        insert into ts_icono (secuencia, tipo_transaccion, clase, fecha,
			      link, secuencial, horario, nombre, rol,
			      tamanio, terminal, fecha_ult_mod)
	              values (@s_ssn, 15158, 'U', @s_date, @i_codigo_nivel, 
 		              @i_codigo_mapa, @i_codigo_icono,
	  		      @v_nombre_icono, @i_mapa_hijo, @v_x, @v_y,
			      @w_today)
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

        insert into ts_icono (secuencia, tipo_transaccion, clase, fecha,
			      link, secuencial, horario, nombre, rol,
			      tamanio, terminal, fecha_ult_mod)
	              values (@s_ssn, 15150, 'U', @s_date, @i_codigo_nivel, 
 		              @i_codigo_mapa, @i_codigo_icono,
	  		      @w_nombre_icono, @i_mapa_hijo, @w_x, @w_y,
			      @w_today)
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


/* ** Delete ** */
if @i_operacion = 'D'
begin
  if @t_trn = 15159
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_nivel is NULL OR @i_codigo_mapa is NULL
	  OR @i_codigo_icono is NULL OR @i_mapa_hijo is NULL)
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

      if not exists (
        select mp_codigo_mapa
          from ad_mapa
          where mp_codigo_mapa = @i_codigo_mapa )
      begin
      /*  'No existe mapa' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151088
        return 1
      end

      if not exists (
        select ci_codigo_icono
          from ad_catalogo_icono
          where ci_codigo_icono = @i_codigo_icono)
      begin
      /*  'No existe icono' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151077
	return 1
      end

      select @w_nombre_icono = ic_nombre_icono,
	     @w_x = ic_x,
	     @w_y = ic_y
        from ad_icono
       where ic_codigo_nivel = @i_codigo_nivel
         and ic_codigo_mapa = @i_codigo_mapa
         and ic_codigo_icono = @i_codigo_icono
	 and ic_mapa_hijo = @i_mapa_hijo

      if @@rowcount = 0
        begin
          /*  'No existe icono' */
	  exec sp_cerror
		@t_debug 	= @t_debug,
		@t_file	 	= @t_file,
		@t_from	 	= @w_sp_name,
	  	@i_num	 	= 151077
	  return 1
        end

      /* deteccion de referencias */

      /* borrado de icono */
      begin Tran
        Delete ad_icono
         where ic_codigo_nivel = @i_codigo_nivel
           and ic_codigo_mapa = @i_codigo_mapa
           and ic_codigo_icono = @i_codigo_icono
	   and ic_mapa_hijo = @i_mapa_hijo

        if @@error != 0
          begin
            /*  'Error en la eliminacion de icono'*/
	    exec sp_cerror
	   	@t_debug	= @t_debug,
	   	@t_file	 	= @t_file,
	   	@t_from	 	= @w_sp_name,
	   	@i_num	 	= 157051
	    return 1
          end

        /* transaccion de servicio */
        insert into ts_icono (secuencia, tipo_transaccion, clase, fecha,
			      link, secuencial, horario, nombre, rol,
			      tamanio, terminal, fecha_ult_mod)
	              values (@s_ssn, 15159, 'D', @s_date, @i_codigo_nivel, 
 		              @i_codigo_mapa, @i_codigo_icono,
	  		      @w_nombre_icono, @i_mapa_hijo, @w_x, @w_y,
			      @w_today)
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
	   /*  'No corresponde codigo de transaccion' */
      return 1
    end
end


/* ** search ** */
if @i_operacion = 'S'
begin
  If @t_trn = 15109
    begin
      set rowcount 20
      if @i_modo = 0
        begin
	  select 'ICONO' = substring(ci_nombre,1,30), 
	 	 'MAPA' = substring(A.mp_nombre_mapa,1,20),
		 'MAPA HIJO' = substring(B.mp_nombre_mapa,1,20),
		 'NOMBRE ICONO' = substring(ic_nombre_icono,1,20)
	    from ad_icono, ad_mapa A, ad_mapa B, ad_catalogo_icono
	  where ic_codigo_nivel = @i_codigo_nivel
	    and ic_codigo_icono = ci_codigo_icono 
	    and (
		 ic_codigo_mapa = A.mp_codigo_mapa and  
		 ic_mapa_hijo   = B.mp_codigo_mapa
		)
          set rowcount 0
        end
      if @i_modo = 1
        begin
	  select 'ICONO' = substring(ci_nombre,1,15), 
	 	 'MAPA' = substring(A.mp_nombre_mapa,1,20),
		 'MAPA HIJO' = substring(B.mp_nombre_mapa,1,20),
		 'NOMBRE ICONO' = substring(ic_nombre_icono,1,20)
	    from ad_icono, ad_mapa A, ad_mapa B, ad_catalogo_icono
	  where ic_codigo_nivel = @i_codigo_nivel
	    and ic_codigo_icono = ci_codigo_icono 
	    and (
		 ic_codigo_mapa = A.mp_codigo_mapa and  
		 ic_mapa_hijo   = B.mp_codigo_mapa
		)
	    and ic_codigo_mapa > @i_codigo_mapa
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
  If @t_trn = 15110
    begin
      select 'Codigo Nivel' = ic_codigo_nivel,
	     'Codigo Mapa'  = ic_codigo_mapa,
	     'Codigo Icono' = ic_codigo_icono,
	     'Nombre Icono' = ic_nombre_icono,
	     'Nombre Mapa Hijo' = ic_mapa_hijo,
	     'Posicion X' = ic_x,
	     'Posicion Y' = ic_y
	from ad_icono
       where ic_codigo_nivel = @i_codigo_nivel
	 and ic_codigo_mapa = @i_codigo_mapa
	 and ic_codigo_icono = @i_codigo_icono	
	 and ic_mapa_hijo = @i_mapa_hijo 
	
      if @@rowcount = 0
	begin
          /*  'No existe icono'*/
	  exec sp_cerror
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	   	 @i_num	 	 = 151077
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
  If @t_trn = 15111
    begin
      if @i_tipo = 'B'
        begin
          select   'CODIGO ICONO' = ci_codigo_icono,
	           'NOMBRE' = substring(ci_nombre,1,20)
	      from ad_catalogo_icono
          order by ci_codigo_icono
        end

      if @i_tipo = 'V'
        begin
          select 'Nombre Icono' = ic_nombre_icono
	    from ad_icono
           where ic_codigo_nivel = @i_codigo_nivel
	     and ic_codigo_mapa = @i_codigo_mapa
	     and ic_codigo_icono = @i_codigo_icono
	     and ic_mapa_hijo = @i_mapa_hijo

          if @@rowcount = 0
	    begin
              /*  'No existe icono'*/
	      exec sp_cerror
	  	 @t_debug	 = @t_debug,
	   	 @t_file	 = @t_file,
	   	 @t_from	 = @w_sp_name,
	   	 @i_num	 	 = 151077
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

