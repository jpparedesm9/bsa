/************************************************************************/
/*  Archivo:                casilla.sp                                  */
/*  Stored procedure:       sp_casilla                                  */
/*  Base de datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de documentacion: 23/Nov/93                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Insercion de casilla                                                */
/*  Actualizacion de casilla                                            */
/*  Query de casilla                                                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  23/Nov/93  R. Minga V.     Documentacion                            */
/*  19/Abr/94  C. Rodriguez V. Considerar provincia y sucursal          */
/*  16/Oct/96  J. Loyo         Ocultar el campo sucursal                */
/*  28/Feb/98  M. Silva        Adicion del campo Empresa Postal         */
/*  07/Ago/00  J. Anaguano     Validaciones por Integridad de Datos     */
/*  02/May/16  DFu             Migracion CEN                            */
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
           where  name = 'sp_casilla')
  drop proc sp_casilla
go

create proc sp_casilla
(
  @s_ssn          int = null,
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
  @i_ente         int = null,
  @i_casilla      tinyint = null,
  @i_valor        varchar(24) = null,
  @i_tipo         char(1) = null,
  @i_ciudad       int = null,
  @i_provincia    smallint = null,
  @i_sucursal     tinyint = null,
  @i_verificado   char(1) = null,
  @i_fecha_ver    datetime = null,
  @i_emp_postal   varchar(24) = null /* M. Silva */
)
as
  declare
    @o_siguiente          int,
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_valor              varchar(24),
    @w_tipo               char(1),
    @w_ciudad             int,
    @w_provincia          smallint,
    @w_sucursal           tinyint,
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    @w_vigencia           char(1),
    @w_emp_postal         varchar(24),/*M. Silva */
    @w_casilla            varchar(3),
    @v_valor              varchar(24),
    @v_tipo               char(1),
    @v_ciudad             int,
    @v_provincia          smallint,
    @v_sucursal           tinyint,
    @v_fecha_registro     datetime,
    @v_fecha_modificacion datetime,
    @v_vigencia           char(1),
    @v_emp_postal         varchar(24),/* M. Silva. */
    @o_ente               int,
    @o_ced_ruc            numero,
    @o_ennombre           descripcion,
    @o_casilla            tinyint,
    @o_valor              varchar(24),
    @o_tipo               char(1),
    @o_ciudad             int,
    @o_cinombre           descripcion,
    @o_provincia          smallint,
    @o_des_provincia      descripcion,
    @o_sucursal           tinyint,
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    @o_vigencia           char(1),
    @o_funcionario        login,
    @o_fecha_ver          datetime,
    @o_verificado         char(1),
    @o_emp_postal         varchar(24) /* M. Silva. */

  select
    @w_sp_name = 'sp_casilla'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 173
    begin
      /* Verificar que existe el ente */
      select
        @w_codigo = null
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe el ente, error */
      if @@rowcount = 0
      begin
        /*'No existe ente'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        return 1
      end
      if @i_ciudad is not null
      begin
        /* verificar que existe la ciudad */
        select
          @w_codigo = null
        from   cl_ciudad
        where  ci_ciudad = @i_ciudad

        /* si no existe el ente, error */
        if @@rowcount = 0
        begin
          /*'No existe ciudad'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          return 1
        end
      end

    /* Ocultar el campo sucursal */
      /* if ((@i_provincia is null and @i_sucursal is not null )
       or (@i_provincia is not null and @i_sucursal is null )
       or (@i_provincia is null and @i_sucursal is null and @i_ciudad is null)) */
      if (@i_provincia is null
           or @i_ciudad is null)
      begin
        /*'Parametros Incongruentes'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101113
        return 1
      end
      if (@i_provincia is not null) /*   and (@i_sucursal is not null)  */
      begin
        /* verificar que existe la provincia */
        select
          @w_codigo = null
        from   cl_provincia
        where  pv_provincia = @i_provincia

        /* si no existe la provincia, error */
        if @@rowcount = 0
        begin
          /*'No existe provincia'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101038
          return 1
        end

      /* verificar que existe la sucursal  en esa provincia*/
      /* JAN ENE/01
      if @i_sucursal is not null  
      begin
           select @w_codigo = null
             from cl_suc_correo
            where sc_provincia = @i_provincia
                  and sc_sucursal = @i_sucursal
      
           /* si no existe la sucursal, error */
           if @@rowcount = 0
           begin
                   /*'No existe sucursal'*/
                   exec sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 101028
                   return 1
           end
      end
      */
      end

      begin tran
      /* aumentar el numero de casillas de ente y tipo_dp es casilla */
      update cl_ente
      set    en_casilla = isnull(en_casilla, 0) + 1,
             en_tipo_dp = 'C'
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        /*'Error en creacion de casilla'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103047
        return 1
      end
    /* obtener un nuevo numero para casilla */
      /******REC057 Eliminar el siguiente codigo   
      select  @o_siguiente =  en_casilla   
           from  cl_ente   
          where  en_ente = @i_ente
      Y REEMPLAZARLO POR */
      select
        @o_siguiente = (select
                          max(cs_casilla)
                        from   cl_casilla
                        where  cs_ente = @i_ente)
      if @o_siguiente is null
      begin
        select
          @o_siguiente = 1
      end
      else
      begin
        select
          @o_siguiente = @o_siguiente + 1
      end

    /*****REC057 ******/
      /* si el tipo es principal, indicar que el resto seran adicionales */
      if @i_tipo = 'P'
      begin
        update cl_casilla
        set    cs_tipo = 'O'
        where  cs_ente = @i_ente
           and cs_tipo = 'P'

        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103047
          /* 'Error en creacion de casilla'*/
          return 1
        end

        /* colocar como casilla por default la principal */
        update cl_ente
        set    en_casilla_def = @i_valor
        where  en_ente = @i_ente

        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103047
          /* 'Error en creacion de casilla' */
          return 1
        end
      end
      /* insertar los datos de casilla */
      insert into cl_casilla
                  (cs_ente,cs_casilla,cs_valor,cs_tipo,cs_ciudad,
                   cs_provincia,cs_sucursal,cs_fecha_registro,
                   cs_fecha_modificacion,
                   cs_vigencia,
                   cs_verificado,cs_fecha_ver,cs_emp_postal) /* M. Silva. */
      values      (@i_ente,@o_siguiente,@i_valor,@i_tipo,@i_ciudad,
                   @i_provincia,@i_sucursal,@s_date,@s_date,'S',
                   @i_verificado,@i_fecha_ver,@i_emp_postal) /* M. Silva. */

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /* 'Error en creacion de casilla' */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103047
        return 1
      end

      /* Transaccion de servicio  */
      insert into ts_casilla
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,casilla,
                   valor,tipo,ciudad,provincia,sucursal,
                   emp_postal)
      values      (@s_ssn,@t_trn,'N',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   @i_valor,@i_tipo,@i_ciudad,@i_provincia,@i_sucursal,
                   @i_emp_postal)

      /* si no se puede insertar transaccion de servicio, error */
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
      commit tran

      /* retornar la siguiente casilla */
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
    if @t_trn = 174
        or @t_trn = 1351
    begin
      /* Verificacion que exista el ente */
      select
        @w_codigo = null
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe el ente, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        /*'No existe ente'*/
        return 1
      end

      if @i_ciudad is not null
      begin
        /* verificar que existe la ciudad */
        select
          @w_codigo = null
        from   cl_ciudad
        where  ci_ciudad = @i_ciudad

        /* si no existe el ente, error */
        if @@rowcount = 0
        begin
          /*'No existe ciudad'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          return 1
        end
      end

    /* ocultar el campo sucursal */
      /* if ((@i_provincia is null and @i_sucursal is not null )
       or (@i_provincia is not null and @i_sucursal is null )
       or (@i_provincia is null and @i_sucursal is null and @i_ciudad is null)) */
      if (@i_provincia is null
           or @i_ciudad is null)
      begin
        /*'Parametros Incongruentes'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101113
        return 1
      end
      if (@i_provincia is not null) /*   and (@i_sucursal is not null) */
      begin
        /* verificar que existe la provincia */
        select
          @w_codigo = null
        from   cl_provincia
        where  pv_provincia = @i_provincia

        /* si no existe la provincia, error */
        if @@rowcount = 0
        begin
          /*'No existe provincia'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101038
          return 1
        end

      /* verificar que existe la sucursal  en esa provincia*/
      /* JAN ENE/01
          if @i_sucursal is not null 
          begin
              select @w_codigo = null
                    from cl_suc_correo
               where sc_provincia = @i_provincia
                     and sc_sucursal = @i_sucursal
      
              /* si no existe la sucursal, error */
              if @@rowcount = 0
              begin
                      /*'No existe sucursal'*/
                      exec sp_cerror
                      @t_debug    = @t_debug,
                      @t_file     = @t_file,
                      @t_from     = @w_sp_name,
                      @i_num      = 101028
                      return 1
              end
          end
      */
      end
      /* Valores para transaccion de servicios */
      select
        @w_valor = cs_valor,
        @w_tipo = cs_tipo,
        @w_ciudad = cs_ciudad,
        @w_provincia = cs_provincia,
        @w_sucursal = cs_sucursal
      from   cl_casilla
      where  cs_ente    = @i_ente
         and cs_casilla = @i_casilla

      /* si no existe casilla, error */
      if @@rowcount = 0
      begin
        /*'No existe casilla'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101106
        return 1
      end

      select
        @v_valor = @w_valor
      select
        @v_tipo = @w_tipo
      select
        @v_ciudad = @w_ciudad
      select
        @v_provincia = @w_provincia
      select
        @v_sucursal = @w_sucursal

      if @w_valor = @i_valor
        select
          @w_valor = null,
          @v_valor = null
      else
        select
          @w_valor = @i_valor

      if @w_tipo = @i_tipo
        select
          @w_tipo = null,
          @v_tipo = null
      else
        select
          @w_tipo = @i_tipo

      if @w_ciudad = @i_ciudad
        select
          @w_ciudad = null,
          @v_ciudad = null
      else
        select
          @w_ciudad = @i_ciudad

      if @w_provincia = @i_provincia
        select
          @w_provincia = null,
          @v_provincia = null
      else
        select
          @w_provincia = @i_provincia

      if @w_sucursal = @i_sucursal
        select
          @w_sucursal = null,
          @v_sucursal = null
      else
        select
          @w_sucursal = @i_sucursal

      if @w_emp_postal = @i_emp_postal /* M. Silva. */
        select
          @w_emp_postal = null,
          @v_emp_postal = null
      else
        select
          @w_emp_postal = @i_emp_postal

      begin tran
      /* si se cambia la casilla de principal a adicional
         cambiar la casilla por default */
      if (@v_tipo = 'P')
         and (@w_tipo = 'O')
      begin
        update cl_ente
        set    en_casilla_def = null,
               en_tipo_dp = null
        where  en_ente = @i_ente

        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105047
          /*'Error en actualizacion de casilla' */
          return 1
        end
      end

      /* si se modifica a principal una adicinal, poner esta casilla 
         como default */
      if (@v_tipo = 'O')
         and (@w_tipo = 'P')
      begin
        update cl_ente
        set    en_casilla_def = @i_valor,
               en_tipo_dp = 'C'
        where  en_ente = @i_ente

        if @@error <> 0
        begin
          /* 'Error en actualizacion de casilla'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105047
          return 1
        end

        update cl_casilla
        set    cs_tipo = 'O'
        where  cs_ente = @i_ente
           and cs_tipo = 'P'

        if @@error <> 0
        begin
          /* 'Error en actualizacion de casilla'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105047
          return 1
        end
      end

      select
        @w_fecha_modificacion = getdate()

      /* modificar los datos anteriores */
      update cl_casilla
      set    cs_valor = @i_valor,
             cs_tipo = @i_tipo,
             cs_ciudad = @i_ciudad,
             cs_provincia = @i_provincia,
             cs_sucursal = @i_sucursal,
             cs_fecha_modificacion = @w_fecha_modificacion,
             cs_verificado = 'N',
             cs_fecha_ver = @i_fecha_ver,
             cs_emp_postal = @i_emp_postal /* M. Silva. */
      where  cs_ente    = @i_ente
         and cs_casilla = @i_casilla
      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        /* 'Error en actualizacion de casilla'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105047
        return 1
      end

      if @i_verificado = 'S'
      begin
        update cl_casilla
        set    cs_funcionario = @s_user,
               cs_verificado = @i_verificado,
               cs_fecha_ver = getdate()
        where  cs_ente    = @i_ente
           and cs_casilla = @i_casilla
        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          /* 'Error en actualizacion de casilla'*/
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105047
          return 1
        end
      end

      /* transaccion servicio - casilla */
      insert into ts_casilla
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,casilla,
                   valor,tipo,ciudad,provincia,sucursal,
                   emp_postal)
      values      (@s_ssn,@t_trn,'P',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_casilla,
                   @v_valor,@v_tipo,@v_ciudad,@v_provincia,@v_sucursal,
                   @v_emp_postal)

      /* si no se puede insertar, error */
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

      /* transaccion servicio - casilla */
      insert into ts_casilla
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,casilla,
                   valor,tipo,ciudad,provincia,sucursal,
                   emp_postal)
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_casilla,
                   @w_valor,@w_tipo,@w_ciudad,@w_provincia,@w_sucursal,
                   @w_emp_postal)

      /* si no se puede insertar, error */
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
      if @v_valor <> @w_valor
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      (@i_ente,@s_date,'cl_casilla','cs_valor',@v_valor,
                     @w_valor,'U',@i_casilla,null)
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103001
          return 1 /*'Error en creacion de cliente'*/
        end
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
    if @t_trn = 1128
    begin
      /* Valores para transaccion de servicios */
      select
        @w_valor = cs_valor,
        @w_tipo = cs_tipo,
        @w_ciudad = cs_ciudad,
        @w_provincia = cs_provincia,
        @w_sucursal = cs_sucursal,
        @w_emp_postal = cs_emp_postal /* M. Silva. */

      from   cl_casilla
      where  cs_ente    = @i_ente
         and cs_casilla = @i_casilla

      /* si no existe registro a borrar, error */
      if @@rowcount = 0
      begin
        /*'No existe la casilla'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101106
        return 1
      end

      if @w_tipo = 'P'
      begin
        /* 'No se puede eliminar una casilla principal'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101050
        return 1
      end
      if (select
            count(dp_apartado_ec)
          from   cl_cliente,
                 cl_det_producto
          where  cl_cliente      = @i_ente
             and cl_det_producto = dp_det_producto
             and dp_apartado_ec  = @i_casilla) > 0
      begin
        print
'NO SE PUEDE ELIMINAR APARTADO POSTAL YA QUE SE ENCUENTRA REFERENCIADO POR UN PRODUCTO'
  return 1
end

  begin tran

  /* restar uno del numero de casillas del ente */
  update cl_ente
  set    en_casilla = en_casilla - 1
  where  en_ente = @i_ente

  /* si no se puede modificar, error */
  if @@error <> 0
  begin
    /*'Error en disminucion de casillas'*/
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 107047
    return 1
  end

  /* borrar la casilla */
  delete from cl_casilla
  where  cs_ente    = @i_ente
     and cs_casilla = @i_casilla

  /* si no se puede borrar, error */
  if @@error <> 0
  begin
    /* 'Error en eliminacion de casilla'*/
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 107047
    return 1
  end

  select
    @w_casilla = convert(varchar(3), @i_casilla)

  insert into cl_actualiza
              (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
               ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
  values      (@i_ente,@s_date,'cl_casilla','cs_casilla',@w_casilla,
               null,'D',@i_casilla,null)
  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 103001
    return 1 /*'Error en creacion de cliente'*/
  end

/*****REC057 Eliminacion de reenumeracion de casillas 
      /* modificar el secuencial de las casillas restantes */
      update cl_casilla
         set cs_casilla = cs_casilla - 1
       where cs_ente = @i_ente
         and cs_casilla > @i_casilla 

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
    exec sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 107047
        /* 'Error en eliminacion de casilla'*/
    return 1
      end
*********REC057 *****/
  /* Si se han borrado todas las casillas */
  select
    @w_codigo = en_casilla
  from   cl_ente
  where  en_ente = @i_ente

  if @w_codigo = 0
  begin
    print 'Direccion postales borradas, se asignara la del domicilio'

    /* tomar la direccion default, como la direccion del domicilio */
    if exists (select
                 1
               from   cl_direccion
               where  di_ente      = @i_ente
                  and di_direccion = 1)
    begin
      update cl_ente
      set    en_casilla_def = substring(di_descripcion,
                                        1,
                                        24),
             en_tipo_dp = 'D'
      from   cl_ente,
             cl_direccion
      where  en_ente      = @i_ente
         and en_ente      = di_ente
         and di_direccion = 1

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107047
        /* 'Error en eliminacion de ultima direccion postal'*/
        return 1
      end
    end
  end

  /* Transaccion servicios - cl_casilla */
  insert into ts_casilla
              (secuencial,tipo_transaccion,clase,fecha,usuario,
               terminal,srv,lsrv,ente,casilla,
               valor,tipo,ciudad,provincia,sucursal,
               emp_postal)
  values      (@s_ssn,@t_trn,'B',@s_date,@s_user,
               @s_term,@s_srv,@s_lsrv,@i_ente,@i_casilla,
               @w_valor,@w_tipo,@w_ciudad,@w_provincia,@w_sucursal,
               @w_emp_postal)

  /* error si no se puede insertar transaccion de servicio */
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

  /** Search **/
  if @i_operacion = 'S'
  /* Busqueda de datos de casilla, no se contrala de 20 en 20
     pues no se espera mas de 20 casillas por ente */
  begin
    if @t_trn = 1215
    begin
      select
        'NUMERO' = cs_casilla,
        'APARTADO' = cs_valor,
        'TIPO' = cs_tipo,
        'CIUDAD' = substring(ci_descripcion,
                             1,
                             20),
        'DEPARTAMENTO' = cs_provincia,
        /*  'SUCURSAL'       = substring(sc_descripcion,1,20),  */
        'FECHA REGISTRO' = convert(char(10), cs_fecha_registro, 101),
        'FECHA MODIF.' = convert(char(10), cs_fecha_modificacion, 101),
        'VIGENTE' = cs_vigencia,
        'VERIFICADO' = cs_verificado,
        'FECHA VERIF.' = cs_fecha_ver,
        'EMPRESA POSTAL' = cs_emp_postal /* M. Silva. */

      from   cl_ciudad
             left outer join cl_casilla /*, cl_suc_correo */
                          on cs_ciudad = ci_ciudad
      where  cs_ente = @i_ente
      /*and ci_ciudad    = * cs_ciudad
      and   sc_provincia = * cs_provincia
      and   sc_sucursal  = * cs_sucursal */
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
  if @i_operacion = 'Q'
  /* Busqueda de casilla especifica */
  begin
    if @t_trn = 1216
    begin
      select
        @o_ente = cs_ente,
        @o_ced_ruc = en_ced_ruc,
        @o_ennombre = en_nomlar,
        /*rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre), */
        @o_casilla = cs_casilla,
        @o_valor = cs_valor,
        @o_tipo = cs_tipo,
        @o_ciudad = cs_ciudad,
        @o_cinombre = ci_descripcion,
        @o_provincia = cs_provincia,
        /*@o_sucursal           = cs_sucursal, */
        @o_fecha_registro = cs_fecha_registro,
        @o_fecha_modificacion = cs_fecha_modificacion,
        @o_vigencia = cs_vigencia,
        @o_funcionario = cs_funcionario,
        @o_verificado = cs_verificado,
        @o_fecha_ver = cs_fecha_ver,
        @o_emp_postal = cs_emp_postal /* M. Silva. */

      from   cl_ente,
             cl_casilla
             left outer join cl_ciudad
                          on cs_ciudad = ci_ciudad
      where  cs_ente    = @i_ente
         and cs_casilla = @i_casilla
         and en_ente    = cs_ente
      --and ci_ciudad  = * cs_ciudad

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @o_des_provincia = pv_descripcion
      from   cl_provincia
      where  pv_provincia = @o_provincia
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @o_casilla,
        @o_valor,
        @o_tipo,
        @o_ciudad,
        @o_cinombre,
        @o_provincia,
        @o_sucursal,
        convert(char(10), @o_fecha_registro, 101),
        convert(char(10), @o_fecha_modificacion, 101),
        @o_vigencia,
        @o_funcionario,
        convert(char(10), @o_fecha_ver, 101),
        @o_des_provincia,
        @o_verificado,
        @o_emp_postal /* M. Silva. */

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

