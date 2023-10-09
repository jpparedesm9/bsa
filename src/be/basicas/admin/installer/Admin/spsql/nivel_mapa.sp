/************************************************************************/
/*      Archivo:                niv_map.sp                              */
/*      Stored procedure:       sp_nivel_mapa                           */
/*      Base de datos:          cobis                                   */
/*      Producto: Administrador                                         */
/*      Disenado por:  Patricio Martinez / Diego Hidalgo                */
/*      Fecha de escritura: 19-04-1995                                  */
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
/*      Insercion de un nivel_mapa                                      */
/*      Busqueda de un nivel_mapa                                       */
/*      Consulta de un nivel_mapa                                       */
/*      Ayuda de un nivel_mapa                                          */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      19/Abr/1995     D.Hidalgo       Emision inicial                 */
/************************************************************************/

use cobis
go

if exists ( select * from sysobjects where name = 'sp_nivel_mapa')
   drop proc sp_nivel_mapa






go
create proc sp_nivel_mapa (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(32) = NULL,
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
	@i_codigo_nivel         tinyint = NULL,
	@i_codigo_mapa          tinyint = 0
)
as
declare
	@w_sp_name              varchar(32),
	@w_today                datetime,
	@o_codigo_nivel         tinyint, 
	@o_codigo_mapa          tinyint,
	@o_nombre_mapa 		descripcion,
	@o_mapath_bmp		descripcion

select @w_today = @s_date
select @w_sp_name = 'sp_nivel_mapa'


/* ** Insert ** */
if @i_operacion = 'I'
begin
  if @t_trn = 15139
    begin
      /* chequeo de claves primarias y foraneas */
      if (@i_codigo_mapa is NULL OR @i_codigo_nivel is NULL)
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
	insert into ad_nivel_mapa (nm_codigo_nivel, nm_codigo_mapa)
		      values (@i_codigo_nivel, @i_codigo_mapa)
	if @@error != 0
	  begin
	    /*  'Error en insercion de nivel_mapa'*/
	    exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num          = 153035
	    return 1
	  end
       /* transaccion de servicio */
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
  If @t_trn = 15140
    begin
      set rowcount 20

      select 'CODIGO MAPA' = nm_codigo_mapa,
             'NOMBRE'      = substring(mp_nombre_mapa,1,20),
             'UBICACION'   = substring(mp_mapath_bmp,1,40)
        from cobis..ad_nivel_mapa,
             cobis..ad_mapa
       where nm_codigo_nivel = @i_codigo_nivel
         and nm_codigo_mapa  = mp_codigo_mapa
         and mp_codigo_mapa  > @i_codigo_mapa

      set rowcount 0

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
  If @t_trn = 15141
    begin
      select 'Codigo Nivel'= nm_codigo_nivel,
	     'Codigo Mapa' = nm_codigo_mapa
	from ad_nivel_mapa
       where nm_codigo_nivel = @i_codigo_nivel
	 and nm_codigo_mapa = @i_codigo_mapa
	
      if @@rowcount = 0
	begin
	  /*  'No existe nivel_mapa'*/
	  exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num          = 151080
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
  If @t_trn = 15142
    begin
      if @i_tipo = 'A'
	begin
	  select 'Codigo Nivel'= nm_codigo_nivel,
		 'Codigo Mapa' = nm_codigo_mapa
	    from ad_nivel_mapa
	end

      if @i_tipo = 'V'
	begin
	  select 'Codigo Nivel'= nm_codigo_nivel,
		 'Codigo Mapa' = nm_codigo_mapa
	    from ad_nivel_mapa
	   where nm_codigo_nivel = @i_codigo_nivel
	     and nm_codigo_mapa = @i_codigo_mapa
	end
      if @@rowcount = 0
	begin
	  /*  'No existe nivel_mapa'*/
	  exec sp_cerror
		 @t_debug        = @t_debug,
		 @t_file         = @t_file,
		 @t_from         = @w_sp_name,
		 @i_num          = 151080
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

