/************************************************************************/
/*  Archivo:            s_h_dml.sp                                      */
/*  Stored procedure:   sp_soc_hecho_dml                                */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 02-Sep-1992                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Insercion de sociedades de hecho                                    */
/*  Actualizacion de sociedades de hecho                                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  02/Sep/94   C. Rodriguez V.  Emision Inicial                        */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_soc_hecho_dml')
           drop proc sp_soc_hecho_dml
go

create proc sp_soc_hecho_dml
(
  @s_ssn            int = null,
  @s_user           login = null,
  @s_term           varchar(30) = null,
  @s_date           datetime = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_ofi            smallint = null,
  @s_rol            smallint = null,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            descripcion = null,
  @s_org            char(1) = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(10) = null,
  @t_from           varchar(32) = null,
  @t_trn            smallint = null,
  @t_show_version   bit = 0,
  @i_operacion      char(1),
  @i_ente           int = null,
  @i_sociedad       tinyint = null,
  @i_nombre         varchar(32) = null,
  @i_tipo_soc_hecho catalogo = null,
  @i_verificado     char(1) = null,
  @i_fecha_ver      datetime = null
)
as
  declare
    @w_today          datetime,
    @w_sp_name        varchar(32),
    @w_return         int,
    @w_siguiente      int,
    @w_codigo         int,
    @w_nombre         varchar(32),
    @w_tipo_soc_hecho catalogo,
    @w_vigencia       char(1),
    @w_verificado     char(1),
    @v_nombre         varchar(32),
    @v_tipo_soc_hecho catalogo,
    @v_vigencia       char(1),
    @v_verificado     char(1),
    @w_catalogo       catalogo

  select
    @w_sp_name = 'sp_soc_hecho_dml'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1243
    begin
      /* verificar que exista el tipo de sociedad de hecho */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_stipo',
        @i_codigo    = @i_tipo_soc_hecho
      if @w_return <> 0
      begin
        /* 'No existe tipo de sociedad de hecho'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101147
        return 1
      end

      begin tran
      /* encontrar un secuencial para la nueva sociedad de hecho */

      select
        @w_siguiente = isnull(p_soc_hecho, 0) + 1
      from   cl_ente
      where  en_ente = @i_ente

      update cl_ente
      set    p_soc_hecho = isnull(p_soc_hecho, 0) + 1
      where  en_ente = @i_ente

      insert into cl_soc_hecho
                  (sh_ente,sh_secuencial,sh_descripcion,sh_tipo,
                   sh_fecha_registro,
                   sh_fecha_modificacion,sh_vigencia,sh_verificado)
      values      (@i_ente,@w_siguiente,@i_nombre,@i_tipo_soc_hecho,@w_today,
                   @w_today,'S','N')
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103073
        /*'Error en creacion de sociedad de hecho'*/
        return 1
      end

      /* transaccion de servicio - nuevo */
      insert into ts_soc_hecho
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,sociedad,
                   nombre,tipo_soc_hecho,vigencia,verificado)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@w_siguiente,
                   @i_nombre,@i_tipo_soc_hecho,'S','N')

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end

      commit tran
      select
        @w_siguiente
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

  /* Update */

  if @i_operacion = 'U'
  begin
    if @t_trn = 1244
    begin
      /* seleccionar los datos anteriores de la sociedad de hecho */
      select
        @w_nombre = sh_descripcion,
        @w_tipo_soc_hecho = sh_tipo,
        @w_vigencia = sh_vigencia,
        @w_verificado = sh_verificado
      from   cl_soc_hecho
      where  sh_ente       = @i_ente
         and sh_secuencial = @i_sociedad

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /*  'No existe dato solicitado'*/
        return 1
      end

      /* verificar que exista el tipo de sociedad de hecho */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_stipo',
        @i_codigo    = @i_tipo_soc_hecho
      if @w_return <> 0
      begin
        /* 'No existe tipo de sociedad de hecho'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101147
        return 1
      end

      if (@i_verificado not in ('N', 'S'))
         and (@i_verificado is not null)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        /* parametro invalido */
        return 1
      end

      /* capturar los datos que han cambiado */
      select
        @v_nombre = @w_nombre,
        @v_tipo_soc_hecho = @w_tipo_soc_hecho,
        @v_vigencia = @w_vigencia,
        @v_verificado = @w_verificado

      if @w_nombre = @i_nombre
        select
          @w_nombre = null,
          @v_nombre = null
      else
        select
          @w_nombre = @i_nombre

      if @w_tipo_soc_hecho = @i_tipo_soc_hecho
        select
          @w_tipo_soc_hecho = null,
          @v_tipo_soc_hecho = null
      else
        select
          @w_tipo_soc_hecho = @i_tipo_soc_hecho

      if (@w_verificado = @i_verificado)
         and @i_verificado is not null
        select
          @w_verificado = null,
          @v_verificado = null

      if (@w_verificado <> @i_verificado)
         and @i_verificado is not null
        select
          @w_verificado = @i_verificado

      select
        @i_verificado = isnull(@i_verificado,
                               'N')

      begin tran
      update cl_soc_hecho
      set    sh_descripcion = @i_nombre,
             sh_tipo = @i_tipo_soc_hecho,
             sh_fecha_modificacion = getdate(),
             sh_vigencia = 'S',
             sh_verificado = 'N'
      where  sh_ente       = @i_ente
         and sh_secuencial = @i_sociedad
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105068
        /* 'Error en actualizacion de sociedad de hecho'*/
        return 1
      end

      if @i_verificado = 'S'
      begin
        update cl_soc_hecho
        set    sh_verificado = @i_verificado,
               sh_funcionario = @s_user,
               sh_fecha_ver = @i_fecha_ver
        where  sh_ente       = @i_ente
           and sh_secuencial = @i_sociedad
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105068
          /* 'Error en actualizacion de sociedad de hecho'*/
          return 1
        end
      end

      /* transaccion de servicio - datos previos */
      insert into ts_soc_hecho
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,sociedad,
                   nombre,tipo_soc_hecho,vigencia,verificado)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_sociedad,
                   @i_nombre,@i_tipo_soc_hecho,'S',@i_verificado)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /*'Error en creacion de transaccion de servicio'*/
        return 1
      end

      /* transaccion de servicio - datos anteriores  */

      insert into ts_soc_hecho
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,sociedad,
                   nombre,tipo_soc_hecho,vigencia,verificado)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_sociedad,
                   @v_nombre,@v_tipo_soc_hecho,@v_vigencia,@v_verificado)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end
      commit tran
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

  /* ** Delete ** */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1249
    begin
      select
        @w_codigo = sh_secuencial,
        @w_nombre = sh_descripcion,
        @w_tipo_soc_hecho = sh_tipo,
        @w_vigencia = sh_vigencia,
        @w_verificado = sh_verificado
      from   cl_soc_hecho
      where  sh_ente       = @i_ente
         and sh_secuencial = @i_sociedad

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /*'No existe dato solicitado'*/
        return 1
      end

      begin tran

      delete cl_soc_hecho
      where  sh_ente       = @i_ente
         and sh_secuencial = @i_sociedad

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107063
        /*'Error en creacion de sociedad de hecho'*/
        return 1
      end

      /* transaccion de servicio */
      insert into ts_soc_hecho
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,sociedad,
                   nombre,tipo_soc_hecho,vigencia,verificado)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_sociedad,
                   @w_nombre,@w_tipo_soc_hecho,@w_vigencia,@w_verificado)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end
      commit tran
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

