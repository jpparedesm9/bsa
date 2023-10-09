/************************************************************************/
/*  Archivo:               categoria.sp                                 */
/*  Stored procedure:      sp_categoria                                 */
/*  Base de datos:         cobis                                        */
/*  Producto:              Clientes                                     */
/*  Disenado por:                                                       */
/*  Fecha de escritura:    15-Ene-2000                                  */
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
/*     Este programa procesa las transacciones de:                      */
/*     Mantenimiento de la tabla cb_categoria                           */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*        FECHA           AUTOR              RAZON                      */
/*                       MSE        Version Inicial                     */
/*                      JAL            Modificación                     */
/*      Abr 10/2003     ELA            Ajustes actualizacion estado     */
/*      Ago 05/2004     ELA            Tunning                          */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_categoria')
  drop proc sp_categoria

go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_categoria
(
  @s_ssn          int = null,
  @s_sesn         int = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         login = null,
  @s_term         descripcion = null,
  @s_corr         char(1) = null,
  @s_ssn_corr     int = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_rty          char(1) = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_tipo         char (1) = null,
  @i_modo         tinyint = 0,
  @i_codigo       catalogo = null,
  @i_descripcion  descripcion = null,
  @i_porcentaje   tinyint = 0,
  @i_estado       char(1) = null,
  @i_categoria    catalogo = null /*JAL FEB/01*/
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(32),
    @w_existe      tinyint,
    @w_codigo      char(4),
    @w_descripcion varchar(255),
    @w_porcentaje  tinyint,
    @w_estado      char(1),
    @w_bandera     varchar(1),
    @v_descripcion varchar(255),
    @v_porcentaje  tinyint,
    @v_estado      char(1),
    @w_categoria   catalogo,/*JAL FEB/01 */
    @v_categoria   catalogo /* JAL FEB/01*/

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_categoria'

/***********************************************************/
  /* Codigos de Transacciones                                */

  if (@t_trn <> 1410
      and @i_operacion = 'I')
      or /* Insercion */
     (@t_trn <> 1411
      and @i_operacion = 'U')
      or /* Update */
     (@t_trn <> 1412
      and @i_operacion = 'D')
      or /* Eliminacion */
     (@t_trn <> 1397
      and @i_operacion = 'A')
      or /* Search */
     (@t_trn <> 1398
      and @i_operacion = 'V') /* trae la ciudad */

  begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 601077
    return 1
  end

/* Chequeo de Existencias */
  /**************************/
  if @i_operacion <> 'A'
  begin
    select
      @w_codigo = ct_codigo,
      @w_descripcion = ct_descripcion,
      @w_porcentaje = ct_porcentaje,
      @w_estado = ct_estado
    from   cl_categoria
    where  ct_codigo = @i_codigo

    if @@rowcount = 0
      select
        @w_existe = 0
    else
      select
        @w_existe = 1
  end

/* VALIDACION DE CAMPOS NULOS */
  /******************************/
  if @i_operacion = 'I'
      or @i_operacion = 'U'
      or @i_operacion = 'D'
  begin
    if @i_codigo is null
        or @i_descripcion is null
        or @i_porcentaje is null
        or @i_estado is null
    begin
      /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601001
      return 1
    end
  end

/* Insercion del registro */
  /**************************/

  if @i_operacion = 'I'
  begin
    if @t_trn = 1410
    begin
      if exists (select
                   ct_codigo
                 from   cl_categoria
                 where  ct_codigo = @i_codigo)
      begin
        /*  Ya existe codigo  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105501
        return 1
      end

      begin tran

      /* insertar los datos de entrada */
      insert into cl_categoria
                  (ct_codigo,ct_descripcion,ct_porcentaje,ct_estado)
      values      (@i_codigo,@i_descripcion,@i_porcentaje,'V')
      if @@error <> 0
      begin
        /*  Error en creacion de categoria  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105505
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_categoria
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,categoria,descripcion,
                   pcategoria,estado)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@i_descripcion,
                   @i_porcentaje,'V')
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
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
          @i_tabla       = 'cl_categoria',
          @i_codigo      = @i_codigo,
          @i_descripcion = @i_descripcion,
          @i_estado      = 'V'
        if @w_return <> 0
          return @w_return
      end

      return 0

    end
  end
/**/
/* Actualizacion del registro */
  /******************************/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1411
    begin
      select
        @w_descripcion = ct_descripcion,
        @w_porcentaje = ct_porcentaje,
        @w_estado = ct_estado
      from   cl_categoria
      where  ct_codigo = @i_codigo

      if @@rowcount <> 1
      begin
        /*  Codigo de Categoria no existe  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105502
        return 1
      end
      select
        @v_descripcion = @w_descripcion,
        @v_porcentaje = @w_porcentaje,
        @v_estado = @w_estado

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_categoria = @i_categoria
        select
          @w_categoria = null,
          @v_categoria = null
      else
        select
          @w_categoria = @i_categoria

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
      begin
        if @i_estado = 'C'
        begin
          if not exists (select
                           1
                         from   cl_categoria
                         where  ct_codigo = @i_codigo)
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105502
            /* Existe categoria */
            return 1
          end
        end
        select
          @w_estado = @i_estado
      end

      begin tran
      update cl_categoria
      set    ct_descripcion = @i_descripcion,
             ct_porcentaje = @i_porcentaje,
             ct_estado = @i_estado
      where  ct_codigo = @i_codigo

      if @@rowcount <> 1
      begin
        /*  Error en actualizacion de categoria  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  =105503
        return 1
      end

      /*  Transaccion de Servicio - Previo */
      insert into ts_categoria
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,categoria,descripcion,
                   pcategoria,estado)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@v_categoria,@v_descripcion,
                   @v_porcentaje,@v_estado)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /*  Transaccion de Servicio - Actual */
      insert into ts_categoria
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,categoria,descripcion,
                   pcategoria,estado)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_categoria,@w_descripcion,
                   @v_porcentaje,@w_estado)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
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
          @i_tabla       = 'cl_categoria',
          @i_codigo      = @i_codigo,
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
        @i_num   = 105504
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

/* Eliminacion de registros */
  /****************************/
  if @i_operacion = 'D'
  begin
    if @w_existe = 0
    begin
      /* Registro a eliminar no existe */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 605082
      return 1
    end

    /*** validacion de integridad referencial ***/
    begin tran
    /*** eliminacion del registro ***/
    commit tran
    return 0
  end

/* Consulta opcion Search */
  /***********************/
  if @i_operacion = 'S'
  begin
    if @t_trn = 1397
    begin
      set rowcount 20
      if @i_modo = 0
      begin
        select
          'CODIGO' = ct_codigo,
          'DESCRIPCION' = ct_descripcion,
          'PORCENTAJE' = ct_porcentaje,
          'ESTADO' = ct_estado
        from   cl_categoria
        order  by ct_codigo

        if @@rowcount = 0
        begin
          if @@error <> 0
          begin
            /*No existen registros */
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105506
            return 1
          end
          set rowcount 0
        end
        set rowcount 0
        return 0
      end
      if @i_modo = 1
      begin
        select
          'CODIGO' = ct_codigo,
          'DESCRIPCION' = ct_descripcion,
          'PORCENTAJE' = ct_porcentaje,
          'ESTADO' = ct_estado
        from   cl_categoria
        where  ct_codigo > @i_codigo
        order  by ct_codigo

        if @@rowcount = 0
        begin
          if @@error <> 0
          begin
            /*No existen registros */
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105506
            return 1
          end
          set rowcount 0
        end
        set rowcount 0
        return 0
      end
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105504
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  if @i_operacion = 'H'
  begin
    if @t_trn = 1397
    begin
      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
          select
            'Codigo ' = ct_codigo,
            'Descripcion ' = convert(char(30), ct_descripcion),
            'Porcentaje ' = ct_porcentaje
          from   cl_categoria
          where  ct_codigo > '   '
             and ct_estado = 'V'

        else if @i_modo = 1
          select
            'Codigo ' = ct_codigo,
            'Descripcion ' = convert(char(30), ct_descripcion),
            'Porcentaje ' = ct_porcentaje
          from   cl_categoria
          where  ct_codigo > @i_codigo
             and ct_estado = 'V'

        set rowcount 0
        return 0
      end
      if @i_tipo = 'V'
      begin
        select
          convert(char(30), ct_descripcion),
          ct_porcentaje
        from   cl_categoria
        where  ct_codigo = @i_codigo
           and ct_estado = 'V'
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105506
          return 1
        end
        return 0
      end --Tipo V
    end --Trn
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105504
      return 1
    end
  end

/* Consulta opcion ALL */
  /***********************/
  if @i_operacion = 'A'
  begin
    set rowcount 20
    if @i_modo = 0
    begin
      select
        'CODIGO' = ct_codigo,
        'DESCRIPCION' = ct_descripcion,
        'PORCENTAJE' = ct_porcentaje
      from   cl_categoria
      order  by ct_codigo

      if @@rowcount = 0
      begin
        if @@error <> 0
        begin
          /*No existen registros */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 601159
          return 1
        end
        set rowcount 0
      end
      set rowcount 0
      return 0
    end
    if @i_modo = 1
    begin
      select
        'CODIGO' = ct_codigo,
        'DESCRIPCION' = ct_descripcion,
        'PORCENTAJE' = ct_porcentaje
      from   cl_categoria
      where  ct_codigo > @i_codigo
      order  by ct_codigo

      if @@rowcount = 0
      begin
        if @@error <> 0
        begin
          /*No existen registros */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 601159
          return 1
        end
        set rowcount 0
      end
      set rowcount 0
      return 0
    end
    return 0
  end

  /* operacion VALUE */
  if @i_operacion = 'V'
  begin
    if @w_existe = 0
    begin
      /*No existen registros */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601159
      return 1
    end
    select
      @w_descripcion,
      @w_porcentaje
    return 0
  end

go

