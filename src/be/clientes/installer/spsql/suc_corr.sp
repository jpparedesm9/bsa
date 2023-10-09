/************************************************************************/
/*  Archivo:        suc_corr.sp                                         */
/*  Stored procedure:   sp_suc_correo                                   */
/*  Base de datos:      cobis                                           */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:           Carlos Rodriguez V.                         */
/*  Fecha de escritura:     10-Abr-94                                   */
/************************************************************************/
/*                       IMPORTANTE                                     */
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
/*  Este programa procesa las transacciones del stored procedure        */
/*      Insercion de Sucursales de Correo                               */
/*      Modificacion de Sucursales de Correo                            */
/*      Borrado de Sucursales de Correo                                 */
/*  Busqueda de Sucursales de Correo                                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*                              Emision Inicial                         */
/*  17/May/94   F.Espinosa  Control del @t_trn                          */
/*  03/May/95   S. Vinces       Admin Distribuido                       */
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
           where  name = 'sp_suc_correo')
           drop proc sp_suc_correo
go

create proc sp_suc_correo
(
  @s_ssn              int = null,
  @s_user             login = null,
  @s_sesn             int = null,
  @s_term             varchar(30) = null,
  @s_date             datetime = null,
  @s_srv              varchar(30) = null,
  @s_lsrv             varchar(30) = null,
  @s_rol              smallint = null,
  @s_ofi              smallint = null,
  @s_org_err          char(1) = null,
  @s_error            int = null,
  @s_sev              tinyint = null,
  @s_msg              descripcion = null,
  @s_org              char(1) = null,
  @t_debug            char(1) = 'N',
  @t_file             varchar(14) = null,
  @t_from             varchar(32) = null,
  @t_trn              smallint = null,
  @t_show_version     bit = 0,
  @i_operacion        char(1),
  @i_modo             tinyint = null,
  @i_tipo             char(1) = null,
  @i_provincia        smallint = null,
  @i_sucursal         tinyint = null,
  @i_descripcion      descripcion = null,
  @i_estado           char(1) = null,
  @i_central_transmit char(1) = null
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(32),
    @w_codigo        smallint,
    @w_provincia     smallint,
    @w_sucursal      tinyint,
    @w_descripcion   descripcion,
    @w_estado        char(1),
    @v_provincia     smallint,
    @v_sucursal      tinyint,
    @v_descripcion   descripcion,
    @v_estado        char(1),
    @w_server_logico varchar(10),
    @w_num_nodos     smallint,
    @w_contador      smallint,
    @w_cmdtransrv    varchar(60),
    @w_nt_nombre     varchar(30),
    @w_clave         int

  select
    @w_sp_name = 'sp_suc_correo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Stored Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_file = @t_file,
      t_from = @t_from,
      t_trn = @t_trn,
      i_provincia = @i_provincia,
      i_sucursal = @i_sucursal,
      i_descripcion = @i_descripcion,
      i_central_transmit = @i_central_transmit
    exec cobis..sp_end_debug
  end

/* Creacion de tabla temporal de nodos a distribuir */
  /* Si esta en ambiente UNIX SYBASE                  */
  if (@i_operacion = 'I'
       or @i_operacion = 'U'
       or @i_operacion = 'D')
     and (@i_central_transmit is null)
  begin
    create table #ad_nodo_reentry_tmp
    (
      nt_nombre  varchar(60),
      nt_bandera char (1)
    )
  end

  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1545
    begin
      /* comprobar que no existan datos duplicados */
      if exists (select
                   *
                 from   cl_suc_correo
                 where  sc_provincia = @i_provincia
                    and sc_sucursal  = @i_sucursal)
      begin
        /* 'Dato ya existe'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101135
        return 1
      end

      /* verificar que exista provincia en cl_provincia*/

      select
        @w_codigo = pv_provincia
      from   cl_provincia
      where  pv_provincia = @i_provincia
         and pv_estado    = 'V'

      if @@rowcount = 0
      begin
        /*'No existe provincia o no esta vigente'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101038
        return 1
      end

      begin tran

      /* Insertar los datos de entrada */
      insert into cl_suc_correo
                  (sc_provincia,sc_sucursal,sc_descripcion,sc_estado)
      values      (@i_provincia,@i_sucursal,@i_descripcion,'V')

      /* Si no se puede insertar error */

      if @@error <> 0
      begin
        /* 'Error en creacion '*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103069
        return 1
      end

      /* transaccion servicio - nuevo */
      insert into ts_suc_correo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,provincia,sucursal,
                   descripcion,estado)
      values      (@s_ssn,1545,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_provincia,@i_sucursal,
                   @i_descripcion,'V')

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
      commit tran

      /******************************* Para   Unix  **************************/

      insert into #ad_nodo_reentry_tmp
        select
          nl_nombre,'N'
        from   ad_nodo_oficina,
               ad_server_logico
        where  nl_nombre   <> @s_lsrv
           and nl_filial   = sg_filial_i
           and nl_oficina  = sg_oficina_i
           and nl_nodo     = sg_nodo_i
           and sg_producto = 1
           and sg_tipo     = 'R'
           and sg_moneda   = 0

      select
        @w_num_nodos = count(*)
      from   #ad_nodo_reentry_tmp

      select
        @w_contador = 1
      while @w_contador <= @w_num_nodos
      begin
        set rowcount 1
        select
          @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,
          @w_nt_nombre = nt_nombre
        from   #ad_nodo_reentry_tmp
        where  nt_bandera = 'N'

        set rowcount 0
        update #ad_nodo_reentry_tmp
        set    nt_bandera = 'S'
        where  nt_nombre = @w_nt_nombre

        exec @w_return = @w_cmdtransrv
          @t_trn              = @t_trn,
          @i_operacion        = @i_operacion,
          @i_provincia        = @i_provincia,
          @i_sucursal         = @i_sucursal,
          @i_descripcion      = @i_descripcion,
          @i_estado           = @i_estado,
          @i_central_transmit = 'S',
          @o_clave            = @w_clave out

        if @w_return <> 0
          return @w_return

        exec @w_return = cobis..sp_reentry
          @i_key  = @w_clave,
          @i_tipo = 'I'

        if @w_return <> 0
          return @w_return

        select
          @w_contador = @w_contador + 1
        continue
      end
      delete #ad_nodo_reentry_tmp
      /******************************* Para   Unix  **************************/
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
    if @t_trn = 1546
    begin
      /* Guardar los datos anteriores */
      select
        @w_descripcion = sc_descripcion,
        @w_estado = sc_estado
      from   cl_suc_correo
      where  sc_provincia = @i_provincia
         and sc_sucursal  = @i_sucursal

      if @@rowcount = 0
      begin
        /* No existe dato */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        return 1
      end

      if @i_estado <> 'V'
         and @i_estado <> 'C'
      begin
        /* Estado incorrecto */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        return 1
      end

      /* Guardar en transacciones de servicio solo los datos que han
         cambiado */
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

      update cl_suc_correo
      set    sc_descripcion = @i_descripcion,
             sc_estado = @i_estado
      where  sc_provincia = @i_provincia
         and sc_sucursal  = @i_sucursal

      if @@error <> 0
      begin
        /* 'Error en actualizacion  de sucursal de correo'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105064
        return 1
      end

      /* transaccion servicios - previo */
      insert into ts_suc_correo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,provincia,sucursal,
                   descripcion,estado)
      values      (@s_ssn,1546,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_provincia,@i_sucursal,
                   @v_descripcion,@v_estado)

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

      /* transaccion servicios - anterior */
      insert into ts_suc_correo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,provincia,sucursal,
                   descripcion,estado)
      values      (@s_ssn,1546,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_provincia,@i_sucursal,
                   @w_descripcion,@w_estado)

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
      commit tran

      /******************************* Para   Unix  **************************/

      insert into #ad_nodo_reentry_tmp
        select
          nl_nombre,'N'
        from   ad_nodo_oficina,
               ad_server_logico
        where  nl_nombre   <> @s_lsrv
           and nl_filial   = sg_filial_i
           and nl_oficina  = sg_oficina_i
           and nl_nodo     = sg_nodo_i
           and sg_producto = 1
           and sg_tipo     = 'R'
           and sg_moneda   = 0

      select
        @w_num_nodos = count(*)
      from   #ad_nodo_reentry_tmp

      select
        @w_contador = 1
      while @w_contador <= @w_num_nodos
      begin
        set rowcount 1
        select
          @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,
          @w_nt_nombre = nt_nombre
        from   #ad_nodo_reentry_tmp
        where  nt_bandera = 'N'

        set rowcount 0
        update #ad_nodo_reentry_tmp
        set    nt_bandera = 'S'
        where  nt_nombre = @w_nt_nombre

        exec @w_return = @w_cmdtransrv
          @t_trn              = @t_trn,
          @i_operacion        = @i_operacion,
          @i_provincia        = @i_provincia,
          @i_sucursal         = @i_sucursal,
          @i_descripcion      = @i_descripcion,
          @i_estado           = @i_estado,
          @i_central_transmit = 'S',
          @o_clave            = @w_clave out

        if @w_return <> 0
          return @w_return

        exec @w_return = cobis..sp_reentry
          @i_key  = @w_clave,
          @i_tipo = 'I'

        if @w_return <> 0
          return @w_return

        select
          @w_contador = @w_contador + 1
        continue
      end
      delete #ad_nodo_reentry_tmp
      /******************************* Para   Unix  **************************/
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
    if @t_trn = 1546
    begin
      /* Conservar valores para transaccion de servicios */
      select
        @w_estado = sc_estado
      from   cl_suc_correo
      where  sc_provincia = @i_provincia
         and sc_sucursal  = @i_sucursal

      /* si no existe registro a borrar, error */
      if @@rowcount = 0
      begin
        /* No existe la sucursal indicada para esa provincia */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        return 1
      end

      begin tran

      update cl_suc_correo
      set    sc_estado = 'C'
      where  sc_provincia = @i_provincia
         and sc_sucursal  = @i_sucursal

      if @@error <> 0
      begin
        /* 'Error al cancelar sucursal de correo'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107060
        return 1
      end

      /* transaccion servicios - previo */
      insert into ts_suc_correo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,provincia,sucursal,
                   estado)
      values      (@s_ssn,1546,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_provincia,@i_sucursal,
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

      /* transaccion servicios - anterior */
      insert into ts_suc_correo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,provincia,sucursal,
                   estado)
      values      (@s_ssn,1546,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_provincia,@i_sucursal,
                   'C')

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
      commit tran

      /******************************* Para   Unix  **************************/

      insert into #ad_nodo_reentry_tmp
        select
          nl_nombre,'N'
        from   ad_nodo_oficina,
               ad_server_logico
        where  nl_nombre   <> @s_lsrv
           and nl_filial   = sg_filial_i
           and nl_oficina  = sg_oficina_i
           and nl_nodo     = sg_nodo_i
           and sg_producto = 1
           and sg_tipo     = 'R'
           and sg_moneda   = 0

      select
        @w_num_nodos = count(*)
      from   #ad_nodo_reentry_tmp

      select
        @w_contador = 1
      while @w_contador <= @w_num_nodos
      begin
        set rowcount 1
        select
          @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,
          @w_nt_nombre = nt_nombre
        from   #ad_nodo_reentry_tmp
        where  nt_bandera = 'N'

        set rowcount 0
        update #ad_nodo_reentry_tmp
        set    nt_bandera = 'S'
        where  nt_nombre = @w_nt_nombre

        exec @w_return = @w_cmdtransrv
          @t_trn              = @t_trn,
          @i_operacion        = @i_operacion,
          @i_provincia        = @i_provincia,
          @i_sucursal         = @i_sucursal,
          @i_descripcion      = @i_descripcion,
          @i_estado           = @i_estado,
          @i_central_transmit = 'S',
          @o_clave            = @w_clave out

        if @w_return <> 0
          return @w_return

        exec @w_return = cobis..sp_reentry
          @i_key  = @w_clave,
          @i_tipo = 'I'

        if @w_return <> 0
          return @w_return

        select
          @w_contador = @w_contador + 1
        continue
      end
      delete #ad_nodo_reentry_tmp
      /******************************* Para   Unix  **************************/
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

  /* ** Search** */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1567
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Pais' = pv_pais,
          'Nombre del Pais' = substring(pa_descripcion,
                                        1,
                                        25),
          'Prov.' = sc_provincia,
          'Nombre de Prov.' = substring(pv_descripcion,
                                        1,
                                        20),
          'Sucursal' = sc_sucursal,
          'Nombre de Suc.' = substring(sc_descripcion,
                                       1,
                                       20),
          'Estado' = sc_estado
        from   cl_suc_correo,
               cl_provincia,
               cl_pais
        where  sc_provincia = pv_provincia
           and pv_pais      = pa_pais
        order  by pv_pais,
                  sc_provincia,
                  sc_sucursal

      if @i_modo = 1
        select
          'Pais' = pv_pais,
          'Nombre del Pais' = substring(pa_descripcion,
                                        1,
                                        25),
          'Prov.' = sc_provincia,
          'Nombre de Prov.' = substring(pv_descripcion,
                                        1,
                                        20),
          'Sucursal' = sc_sucursal,
          'Nombre de Suc.' = substring(sc_descripcion,
                                       1,
                                       20),
          'Estado' = sc_estado
        from   cl_suc_correo,
               cl_provincia,
               cl_pais
        where  sc_provincia = pv_provincia
           and pv_pais      = pa_pais
           and ((sc_provincia > @i_provincia)
                 or ((sc_provincia = @i_provincia)
                     and (sc_sucursal = @i_sucursal)))
        order  by pv_pais,
                  sc_provincia,
                  sc_sucursal

      set rowcount 0
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

  /* ** Query especifico para cada sp ** */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1566
    begin
      select
        pv_pais,
        substring(pa_descripcion,
                  1,
                  40),
        sc_provincia,
        substring(pv_descripcion,
                  1,
                  40),
        sc_sucursal,
        substring(sc_descripcion,
                  1,
                  40),
        sc_estado
      from   cl_suc_correo,
             cl_provincia,
             cl_pais
      where  sc_provincia = pv_provincia
         and pv_pais      = pa_pais
         and sc_provincia = @i_provincia
         and sc_sucursal  = @i_sucursal

      if @@rowcount = 0
      begin
        /* no existe dato solicitado */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        return 1
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

  /* ** Help ** */
  if @i_operacion = 'H'
  begin
    if @t_trn = 1568
    begin
      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
          select
            'Cod.'=sc_sucursal,
            'Nombre'=convert(char(30), sc_descripcion)
          from   cl_suc_correo
          where  sc_estado    = 'V'
             and sc_provincia = @i_provincia
        else if @i_modo = 1
          select
            'Cod.'=sc_sucursal,
            'Nombre'=convert(char(30), sc_descripcion)
          from   cl_suc_correo
          where  sc_sucursal  > @i_sucursal
             and sc_estado    = 'V'
             and sc_provincia = @i_provincia

        set rowcount 0
        return 0
      end
      if @i_tipo = 'V'
      begin
        select
          convert(char(30), sc_descripcion)
        from   cl_suc_correo
        where  sc_provincia = @i_provincia
           and sc_sucursal  = @i_sucursal
           and sc_estado    = 'V'

        if @@rowcount = 0
        begin
          /* no existe dato solicitado */
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          return 1
        end
        return 0
      end
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

