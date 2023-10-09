/************************************************************************/
/*   Archivo:                 clbandom.sp                               */
/*   Stored procedure:        sp_bandom                                 */
/*   Base de datos:           cobis                                     */
/*   Producto:                Clientes                                  */
/*   Disenado por:            Jenniffer Anaguano                        */
/*   Fecha de escritura:      08/Mayo/2001                              */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Este programa procesa las operaciones de Creacion, Busqueda,       */
/*      Actualizacion y eliminacion de los Servicios Banca Domiciliaria */
/*      Contratados por un Cliente.                                     */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA          AUTOR          RAZON                                */
/*   08/May/01 J.Anaguano     Emision Inicial                           */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_bandom')
  drop proc sp_bandom
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_bandom
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_ente         int = null,
  @i_secuencial   tinyint = null,
  @i_servicio     catalogo = null
)
as
  declare
    @w_sp_name        varchar(32),
    @w_codigo         int,
    @w_return         int,
    @o_siguiente      tinyint,
    @w_secuencial     tinyint,
    @w_servicio       catalogo,
    @v_servicio       catalogo,
    @o_ente           int,
    @o_secuencial     tinyint,
    @o_servicio       catalogo,
    @o_fecha_registro datetime,
    @o_fecha_modifi   datetime,
    @o_funcionario    login

  select
    @w_sp_name = 'sp_bandom'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1437
    begin
      /* Verificar que exista el ente */
      select
        @w_codigo = null
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        /* 'No existe persona'*/
        return 1
      end
      /* Verificar si existe el servicio para el ente */
      select
        @w_servicio = bd_servicio
      from   cl_bandom
      where  bd_ente     = @i_ente
         and bd_servicio = @i_servicio

      if @@rowcount <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105091
        /* 'No dato solicitado' */
        return 1
      end

      begin tran
      /* seleccionar el nuevo secuencial para el contacto */
      select
        @o_siguiente = isnull(max(bd_secuencial), 0) + 1
      from   cl_bandom
      where  bd_ente = @i_ente

      /* Insercion cl_bandom */
      insert into cl_bandom
                  (bd_ente,bd_secuencial,bd_servicio,bd_fecha_registro,
                   bd_funcionario)
      values      (@i_ente,@o_siguiente,@i_servicio,@s_date,@s_user)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105087
        /* 'Error en creacion de Banca Domiciliaria */
        return 1
      end

      /*  Transaccion de Servicio  */

      insert into ts_bandom
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,servicio,
                   fecha_modificacion,funcionario)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_servicio,
                   @s_date,@s_user)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      commit tran

      /* retornar el nuevo secuencial */
      select
        @o_siguiente
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

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1438
    begin
      select
        @w_servicio = bd_servicio
      from   cl_bandom
      where  bd_ente       = @i_ente
         and bd_secuencial = @i_secuencial
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105090
        return 1
      end

      /* Verificar si existe el servicio para el ente */
      select
        @w_servicio = bd_servicio
      from   cl_bandom
      where  bd_ente     = @i_ente
         and bd_servicio = @i_servicio

      if @@rowcount <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105091
        /* 'No dato solicitado' */
        return 1
      end

      select
        @v_servicio = @w_servicio

      if @w_servicio = @i_servicio
        select
          @w_servicio = null,
          @v_servicio = null
      else
        select
          @w_servicio = @i_servicio

      begin tran
    /********************************/
      /* modificar, los datos */
      update cl_bandom
      set    bd_servicio = @i_servicio,
             bd_fecha_modificacion = @s_date,
             bd_funcionario = @s_user
      where  bd_ente       = @i_ente
         and bd_secuencial = @i_secuencial

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105088
        /*'Error en actualizacion de Banca Domiciliaria' */
        return 1
      end
      /*  Transaccion de Servicio - Previo */

      insert into ts_bandom
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,servicio,
                   fecha_modificacion,funcionario)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@v_servicio,
                   @s_date,@s_user)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      /*  Transaccion de Servicio - Actual */

      insert into ts_bandom
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,servicio,
                   fecha_modificacion,funcionario)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@w_servicio,
                   @s_date,@s_user)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
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

  /** Delete **/
  if @i_operacion = 'D'
  begin
    if @t_trn = 1439
    begin
      select
        @w_servicio = bd_servicio
      from   cl_bandom
      where  bd_ente       = @i_ente
         and bd_secuencial = @i_secuencial

      /* si no existe contacto */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105090
        /* 'No dato solicitado' */
        return 1
      end

      begin tran

      delete from cl_bandom
      where  bd_ente       = @i_ente
         and bd_secuencial = @i_secuencial

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105089
        /* 'Error en eliminacion de Banca Domiciliaria'*/
        return 1
      end

      insert into ts_bandom
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,servicio,
                   fecha_modificacion,funcionario)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@w_servicio,
                   @s_date,@s_user)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
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

/** Search **/
  /* referencias personales de una persona no se controla de 20 en 20
     porque no se espera mas de 20 referencias personales */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1441
    begin
      select
        'CONSECUTIVO ' = bd_secuencial,
        'SERVICIO ' = bd_servicio,
        'DESCRIPCION ' = sb_descripcion,
        'VALOR ' = sb_valor,
        'FECHA DE REGISTRO ' = convert(char(10), bd_fecha_registro, 101),
        'FUNCIONARIO ' = bd_funcionario,
        'PRODUCTO    ' = sb_producto,
        'CAUSAL_CTE ' = sb_causal_cte,
        'CAUSAL_AHO ' = sb_causal_aho
      from   cl_bandom,
             cl_servicio_bandom
      where  bd_servicio = sb_codigo
         and bd_ente     = @i_ente
      order  by bd_secuencial
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

/** Query **/
  /* Datos especificos de una contacto */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1440
    begin
      select
        @o_ente = bd_ente,
        @o_secuencial = bd_secuencial,
        @o_servicio = bd_servicio,
        @o_fecha_registro = bd_fecha_registro,
        @o_funcionario = bd_funcionario,
        @o_fecha_modifi = bd_fecha_modificacion
      from   cl_bandom
      where  bd_ente       = @i_ente
         and bd_secuencial = @i_secuencial

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105090
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @o_ente,
        @o_secuencial,
        @o_servicio,
        convert (char(10), @o_fecha_registro, 101),
        @o_funcionario,
        convert (char(10), @o_fecha_modifi, 101)
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

