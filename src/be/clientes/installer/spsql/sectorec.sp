/************************************************************************/
/*      Archivo:                sectorec.sp                            */
/*      Stored procedure:       sp_sectoreco                            */
/*      Base de datos:          cobis                                   */
/*      Producto:               MIS                                     */
/*      Disenado por:           Jaime Loyo                              */
/*      Fecha de escritura:     16-Feb-00                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones del store procedure     */
/*      Insercion de Sectores Economicos                                */
/*      Modificacion de Sectores Economicos                             */
/*      Borrado de Sectores Economicos                                  */
/*      Busqueda de Sectores Economicos                                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      16/02/00    J.Loyo.             Emision Inicial                 */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/

use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_sectoreco')
           drop proc sp_sectoreco
go

create proc sp_sectoreco
(
  @s_ssn          int = null,
  @s_sesn         int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_tipo         char(1) = null,
  @i_sectoreco    catalogo = null,
  @i_descripcion  descripcion = null,
  @i_estado       estado = null
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(32),
    @w_codigo      int,
    @w_sectoreco   catalogo,
    @w_descripcion descripcion,
    @w_estado      estado,
    @v_sectoreco   catalogo,
    @v_descripcion descripcion,
    @w_bandera     varchar(1),
    @v_estado      estado

  select
    @w_sp_name = 'sp_sectoreco'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_bandera = 'N'

  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1400
    begin
      if exists(select
                  se_sector
                from   cl_sectoreco
                where  se_sector = @i_sectoreco)
      begin
        /* 'Ya existe Sector Economico */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151093
        return 1
      end

      begin tran
      /* Insertar los datos de entrada */

      insert into cl_sectoreco
                  (se_sector,se_descripcion,se_max_riesgo,se_riesgo,se_estado,
                   se_usuario,se_fecha_registro)
      values      (@i_sectoreco,@i_descripcion,100000000000,0,'V',
                   @s_user,@s_date)

      /* Si no se puede insertar error */
      if @@error <> 0
      begin
        /* 'Error en creacion de Sector Economico '*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 155043
        return 1
      end

      /* transaccion servicio - nuevo */
      insert into ts_sectoreco
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,sectoreco,descripcion,
                   estado)
      values      (@s_ssn,@t_trn,'N',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_sectoreco,@i_descripcion,
                   'V')

      /* Si no se puede insertar , error */
      if @@error <> 0
      begin
        /* 'Error en creacion de transaccion de servicios'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end
      select
        @w_bandera = 'S'
      commit tran

      if @w_bandera = 'S'
      begin
        /* Actualizacion de la los datos en el catalogo */
        exec @w_return = sp_catalogo
          @s_ssn         = @s_ssn,
          @s_user        = @s_user,
          @s_sesn        = @s_sesn,
          @s_term        = @s_term,
          @s_date        = @s_date,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_rol         = @s_rol,
          @s_ofi         = @s_ofi,
          @s_org_err     = @s_org_err,
          @s_error       = @s_error,
          @s_sev         = @s_sev,
          @s_msg         = @s_msg,
          @s_org         = @s_org,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @t_trn         = 584,
          @i_operacion   = 'I',
          @i_tabla       = 'cl_sectoreco',
          @i_codigo      = @i_sectoreco,
          @i_descripcion = @i_descripcion,
          @i_estado      = 'V'
        if @w_return <> 0
          return @w_return
      end

      /* Retornar el nuevo codigo  */
      select
        @w_sectoreco
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /* ** Update ** */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1401
    begin
      /* Guardar los datos anteriores */
      select
        @w_descripcion = se_descripcion,
        @w_estado = se_estado
      from   cl_sectoreco
      where  se_sector = @i_sectoreco

      if @@rowcount = 0
      begin
        /* No existe dato */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 151094
        return 1
      end

      /* Guardar en transacciones de servicio solo los datos que han cambiado */
      select
        @v_descripcion = @w_descripcion,
        @v_estado = @w_estado

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
        select
          @w_estado = @i_estado

      begin tran

      update cl_sectoreco
      set    se_descripcion = @i_descripcion,
             se_estado = @i_estado
      where  se_sector = @i_sectoreco

      if @@error <> 0
      begin
        /* 'Error en actualizacion '*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 153039
        return 1
      end

      /* transaccion servicios - previo */
      insert into ts_sectoreco
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,sectoreco,descripcion,
                   estado)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_sectoreco,@v_descripcion,
                   @v_estado)
      if @@error <> 0
      begin
        /* 'Error en creacion de transaccion de servicios'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end

      insert into ts_sectoreco
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,sectoreco,descripcion,
                   estado)
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_sectoreco,@w_descripcion,
                   @w_estado)

      if @@error <> 0
      begin
        /* 'Error en creacion de transaccion de servicios'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end

      select
        @w_bandera = 'S'
      commit tran

      if @w_bandera = 'S'
      begin
        exec @w_return = sp_catalogo
          @s_ssn         = @s_ssn,
          @s_user        = @s_user,
          @s_sesn        = @s_sesn,
          @s_term        = @s_term,
          @s_date        = @s_date,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_rol         = @s_rol,
          @s_ofi         = @s_ofi,
          @s_org_err     = @s_org_err,
          @s_error       = @s_error,
          @s_sev         = @s_sev,
          @s_msg         = @s_msg,
          @s_org         = @s_org,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @t_trn         = 585,
          @i_operacion   = 'U',
          @i_tabla       = 'cl_sectoreco',
          @i_codigo      = @i_sectoreco,
          @i_descripcion = @i_descripcion,
          @i_estado      = @i_estado

        if @w_return <> 0
          return @w_return

      end
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

go

