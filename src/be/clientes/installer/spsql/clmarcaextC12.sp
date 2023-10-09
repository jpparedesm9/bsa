/************************************************************************/
/*   Archivo            : clmarcaextC12.sp                              */
/*   Stored procedure   : sp_marca_extC12                               */
/*   Base de datos      : cobis                                         */
/*   Producto           : Clientes                                      */
/*   Disenado por       : A Correa                                      */
/*   Fecha de escritura : 2013/03/13                                    */
/************************************************************************/
/*                        IMPORTANTE                                    */
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
/*                        PROPOSITO                                     */
/*   Proceso de Generación Archivos planos de extractos de              */
/*   Costos financieros  de clientes                                    */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*   FECHA                AUTOR              RAZON                      */
/*   2013/03/13           A Correa           Emision Inicial            */
/*   2013/03/14           D Pulido           Carga de Archivo           */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_marca_extC12')
  drop proc sp_marca_extC12
go

create proc sp_marca_extC12
(
  @t_show_version bit = 0,
  @i_param1       varchar(1) = null,--TIPO (C)arga y validacion, (A)plicacion
  @i_param2       varchar(60) = null --ARCHIVO
)
as
  declare
    @w_sec           int,
    @w_tipo_ced      char(2),
    @w_ced_ruc       varchar(30),
    @w_extfin        varchar(10),
    @w_email         varchar(254),
    @w_ente          int,
    @w_tres          varchar(10),
    @w_tneg          varchar(10),
    @w_tmail         varchar(10),
    @w_msg           varchar(254),
    @w_estado        char(1),
    @w_direccion     int,
    @w_oficina       smallint,
    @w_ciudad        int,
    @w_path_plano    varchar(255),
    @w_server        varchar(30),
    @w_s_app         varchar(255),
    @w_archerr       varchar(255),
    @w_cmd           varchar(3000),
    @w_error         int,
    @w_return        int,
    @w_fecha_proceso datetime,
    @w_srv           varchar(30),
    @w_provincia     int,
    @w_codigo_ext    int,
    @w_forma_ext     char(1),
    @w_sp_name        varchar(30)

  set nocount on
  set ansi_nulls off

  select 
        @w_sp_name = 'sp_marca_extC12'
/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --Ruta de publicacion archivo marcacion
  select
    @w_path_plano = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'PATHMA'

  if @w_path_plano is null
  begin
    select
      @w_error = 1,
      @w_msg = 'No existe parametro PATH DE PUBLICACION ARCHIVO MARCACION'
    goto ERROR1
  end

  -- Servidor para publicar extractos para impresion
  select
    @w_server = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'SRVMAR'

  if @w_server is null
  begin
    select
      @w_error = 2,
      @w_msg = 'No existe parametro PATH DE PUBLICACION ARCHIVO MARCACION'
    goto ERROR1
  end

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @w_s_app is null
  begin
    select
      @w_error = 3,
      @w_msg = 'No existe parametro S_APP'
    goto ERROR1
  end

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_srv = nl_nombre
  from   cobis..ad_nodo_oficina
  where  nl_nodo = 1

  if @i_param1 = 'C'
  begin --Carga y Validacion
    if exists (select
                 1
               from   sysobjects
               where  name = 'tmp_marca_dir')
      drop table tmp_marca_dir

    create table tmp_marca_dir
    (
      md_tipo_ced  char(2) null,
      md_ced_ruc   varchar(30) null,
      md_email     varchar(254) null,
      md_extfin    varchar(10) null,
      md_ente      int default 0,
      md_direccion int default 0,
      md_oficina   smallint default 0,
      md_ciudad    int default 0,
      md_estado    char(1) null,
      md_valida    varchar(255) null
    )

    --Carga archivo
    select
      @w_archerr = @w_server + @w_path_plano + @i_param2 + '.err'
    select
      @w_cmd =
      @w_s_app + 's_app bcp -auto -login cobis..tmp_marca_dir in ' +
      @w_server +
      @w_path_plano
               + @i_param2 + ' -b5000 -c -e ' + @w_archerr + ' -t "&&" -config '
      +
      @w_s_app + 's_app.ini'

    exec @w_error = xp_cmdshell
      @w_cmd

    if @w_error <> 0
    begin
      select
        @w_error = 3,
        @w_msg = 'Error cargando archivo ' + @i_param2
      goto ERROR1
    end
    else
    begin
      /* Solamente deja el archivo definitivo, se eliminan los archivos temporales */
      select
        @w_cmd = 'del ' + @w_archerr
      exec @w_error = xp_cmdshell
        @w_cmd
      if @w_error <> 0
      begin
        select
          @w_error = 808022,
          @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
        goto ERROR1
      end
    end

    create index p_id
      on tmp_marca_dir (md_ced_ruc, md_tipo_ced)

    --Modifica estructura para actualizacion
    alter table tmp_marca_dir
      add md_secuencial int identity

    if @@error <> 0
    begin
      select
        @w_error = 4,
        @w_msg = 'Error modificando la estructura'
      goto ERROR1
    end

    update tmp_marca_dir
    set    md_estado = 'E',
           md_valida = isnull(md_valida, '') + ' *** TipoID con valor null'
    where  md_tipo_ced is null

    if @@error <> 0
    begin
      select
        @w_error = 5,
        @w_msg = 'Error marcando error en TipoID null'
      goto ERROR1
    end

    update tmp_marca_dir
    set    md_estado = 'E',
           md_valida = isnull(md_valida, '') + ' *** TipoID Invalido'
    where  md_tipo_ced is not null
       and md_tipo_ced not in (select
                                 codigo
                               from   cobis..cl_catalogo
                               where  tabla  =
                              (select
                                 codigo
                               from   cobis..cl_tabla
                               where  tabla = 'cl_tipo_documento')
                                  and estado = 'V')

    if @@error <> 0
    begin
      select
        @w_error = 6,
        @w_msg = 'Error marcando error en TipoID errado'
      goto ERROR1
    end

    update tmp_marca_dir
    set    md_estado = 'E',
           md_valida = isnull(md_valida, '') + ' *** NumID con valor null'
    where  md_ced_ruc is null

    if @@error <> 0
    begin
      select
        @w_error = 7,
        @w_msg = 'Error marcando error en TipoID errado'
      goto ERROR1
    end

    update tmp_marca_dir
    set    md_estado = 'E',
           md_valida = isnull(md_valida, '') + ' *** Marca con valor null'
    where  md_extfin is null

    if @@error <> 0
    begin
      select
        @w_error = 8,
        @w_msg = 'Error marcando error en ExtFin Nulla'
      goto ERROR1
    end

    update tmp_marca_dir
    set    md_estado = 'E',
           md_valida = isnull(md_valida, '') +
                       ' *** Marca con valor errado o no vigente'
    where  (case md_extfin
              when 'R' then 'D'
              when 'N' then 'D'
              when 'O' then 'R'
              else md_extfin
            end) not in (select
                           c.codigo
                         from   cobis..cl_catalogo c,
                                cobis..cl_tabla t
                         where  t.tabla  = 'cl_forma_extractos'
                            and t.codigo = c.tabla
                            and c.estado = 'V')

    if @@error <> 0
    begin
      select
        @w_error = 9,
        @w_msg = 'Error marcando error en ExtFin errado'
      goto ERROR1
    end

    update tmp_marca_dir
    set    md_estado = 'E',
           md_valida = isnull(md_valida, '') + ' *** Email con valor null'
    where  md_extfin = 'C' --Validar
       and md_email is null

    if @@error <> 0
    begin
      select
        @w_error = 10,
        @w_msg = 'Error marcando error en Email errado'
      goto ERROR1
    end

    update tmp_marca_dir
    set    md_estado = 'E',
           md_valida = isnull(md_valida, '') + 'Cliente no existe'
    where  md_ced_ruc not in (select
                                en_ced_ruc
                              from   cobis..cl_ente)
       and md_estado is null

    if @@error <> 0
    begin
      select
        @w_error = 11,
        @w_msg = 'Error marcando error en Cliente errado'
      goto ERROR1
    end

    update tmp_marca_dir
    set    md_estado = 'V'
    where  md_estado is null

    if @@error <> 0
    begin
      select
        @w_error = 12,
        @w_msg = 'Error marcando registros como validados'
      goto ERROR1
    end

    select
      tmp_tipo_ced = md_tipo_ced,
      tmp_ced_ruc = md_ced_ruc,
      tmp_direccion = max(di_direccion) + 1
    into   #temporal
    from   cobis..tmp_marca_dir,
           cobis..cl_ente,
           cobis..cl_direccion
    where  en_tipo_ced = md_tipo_ced
       and en_ced_ruc  = md_ced_ruc
       and di_ente     = en_ente
       and md_estado   = 'V'
    group  by md_tipo_ced,
              md_ced_ruc

    --Secuencial de la direccion a crear
    update tmp_marca_dir
    set    md_direccion = tmp_direccion
    from   #temporal
    where  tmp_tipo_ced = md_tipo_ced
       and tmp_ced_ruc  = md_ced_ruc

    if @@error <> 0
    begin
      select
        @w_error = 13,
        @w_msg = 'Error actualizando cod. direccion'
      goto ERROR1
    end

    --Oficina de productos del cliente
    update tmp_marca_dir
    set    md_ente = isnull(en_ente,
                            0),
           md_oficina = isnull(en_oficina_prod,
                               en_oficina)
    from   cl_ente
    where  en_tipo_ced = md_tipo_ced
       and en_ced_ruc  = md_ced_ruc

    if @@error <> 0
    begin
      select
        @w_error = 14,
        @w_msg = 'Error actualizando oficina de productos del cliente'
      goto ERROR1
    end

    --Ciudad de la oficina de productos del cliente
    update tmp_marca_dir
    set    md_ciudad = of_ciudad
    from   cobis..cl_oficina
    where  md_oficina = of_oficina

    if @@error <> 0
    begin
      select
        @w_error = 15,
        @w_msg =
      'Error actualizando ciudad de la oficina de productos del cliente'
      goto ERROR1
    end

    goto FIN1
    ERROR1:
    print cast(@w_error as varchar)
    print @w_msg

    return @w_error

    FIN1:
    return 0
  end

  if @i_param1 = 'A'
  begin --Aplicación
    --Inicializa variables
    select
      @w_sec = 0
    select
      @w_msg = ''

    --Leer parametros cl_parametro para identificar tipos de direccion

    select
      @w_tneg = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'TDN' --Negocio
    if @w_tneg is null
    begin
      select
        @w_error = 1,
        @w_msg = 'Error leyendo parametro TDN'

      goto ERROR2
    end

    select
      @w_tres = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'TDR' --Residencia
    if @w_tres is null
    begin
      select
        @w_error = 2,
        @w_msg = 'Error leyendo parametro TDR'

      goto ERROR2
    end

    select
      @w_tmail = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'TDW' --Correo
    if @w_tmail is null
    begin
      select
        @w_error = 3,
        @w_msg = 'Error leyendo parametro TDW'

      goto ERROR2
    end

    set rowcount 1

    --Marcacion direccion
    while 1 = 1
    begin
      select
        @w_sec = md_secuencial,
        @w_ente = isnull(md_ente,
                         0),
        @w_tipo_ced = md_tipo_ced,
        @w_ced_ruc = md_ced_ruc,
        @w_extfin = md_extfin,
        @w_email = md_email,
        @w_direccion = md_direccion,
        @w_oficina = md_oficina,
        @w_ciudad = md_ciudad,
        @w_provincia = ci_provincia
      from   tmp_marca_dir,
             cobis..cl_ciudad
      where  md_secuencial > @w_sec
         and md_estado     = 'V'
         and md_ciudad     = ci_ciudad
      order  by md_secuencial

      if @@rowcount = 0
        break

      --'Valida cliente'
      if @w_ente = 0
      begin
        select
          @w_estado = 'E',
          @w_msg = 'Cliente no existe'
        goto SIGUIENTE
      end

      if exists (select
                   1
                 from   cobis..cl_forma_extractos
                 where  fe_cliente = @w_ente)
      begin
        select
          @w_estado = 'E',
          @w_msg = 'Cliente ya tiene direccion marcada'
        goto SIGUIENTE
      end

      if @w_extfin = 'R'
          or @w_extfin = 'N'--Direccion de residencia o Direccion de negocio
      begin
        select
          @w_codigo_ext = di_direccion,
          @w_forma_ext = 'D'
        from   cobis..cl_direccion
        where  di_ente               = @w_ente
           and di_tipo               <> @w_tmail
           and di_fecha_modificacion = (select
                                          max(di_fecha_modificacion)
                                        from   cobis..cl_direccion
                                        where  di_ente = @w_ente
                                           and di_tipo <> @w_tmail)

        if @@rowcount = 0
        begin
          select
            @w_estado = 'E',
            @w_msg = 'Error al marcar direccion Fisica.'
          goto SIGUIENTE
        end

        select
          @w_estado = 'P',
          @w_msg = 'Marcacion Dir. Fisica Correcta'
        goto SIGUIENTE
      end

      if @w_extfin = 'O' --Oficina
      begin
        select
          @w_codigo_ext = null

        /*** BUSCA OFICINA MAS RECIENTE CON PRODUCTOS DEL CLIENTE ***/
        select top 1
          @w_codigo_ext = dp_oficina
        from   cobis..cl_det_producto
        where  dp_cliente_ec = @w_ente
        order  by dp_fecha desc

        if @w_codigo_ext is null
        begin
          /*** BUSCA OFICINA DE CREACION DEL CLIENTE ***/
          select
            @w_codigo_ext = case
                              when en_oficina_prod is null then en_oficina
                              else en_oficina_prod
                            end
          from   cobis..cl_ente
          where  en_ente = @w_ente

          if @w_codigo_ext is null
          begin
            select
              @w_estado = 'E',
              @w_msg = 'Error al marcar oficina.'
            goto SIGUIENTE
          end
        end

        select
          @w_estado = 'P',
          @w_forma_ext = 'R',
          @w_msg = 'Marcacion Oficina Correcta'
        goto SIGUIENTE
      end

      if @w_extfin = 'C' --Correo Electronico
      begin
        if isnull(@w_email,
                  '') = '' --Marcar email existente
        begin
          select
            @w_codigo_ext = di_direccion,
            @w_forma_ext = 'C'
          from   cobis..cl_direccion
          where  di_ente               = @w_ente
             and di_tipo               = @w_tmail
             and di_fecha_modificacion = (select
                                            max(di_fecha_modificacion)
                                          from   cobis..cl_direccion
                                          where  di_ente = @w_ente
                                             and di_tipo = @w_tmail)

          if @@rowcount = 0
          begin
            select
              @w_estado = 'E',
              @w_msg = 'Error al marcar correo electronico'
            goto SIGUIENTE
          end
        end
        else
        begin
          select
            @w_codigo_ext = di_direccion,
            @w_forma_ext = 'C'
          from   cobis..cl_direccion
          where  di_ente        = @w_ente
             and di_tipo        = @w_tmail
             and di_descripcion = @w_email

          if @@rowcount = 0
          begin
            print 'Creando direccion'

            if @w_direccion = 0
              select
                @w_direccion = 1

            insert into cl_direccion
                        (di_ente,di_direccion,di_tipo,di_descripcion,
                         di_fecha_registro
                         ,
                         di_fecha_modificacion,di_parroquia,
                         di_ciudad,di_oficina,
                         di_vigencia
                         ,
                         di_verificado,di_funcionario,di_telefono,di_principal
                         ,di_provincia)
            values      ( @w_ente,@w_direccion,@w_tmail,@w_email,getdate(),
                          getdate(),0,@w_ciudad,@w_oficina,'S',
                          'N','masivoC12',0,'N',@w_provincia)

            if @@error <> 0
            begin
              select
                @w_msg = 'Error al crear email '
              select
                @w_estado = 'E'
              goto SIGUIENTE
            end

            update cobis..cl_ente
            set    en_direccion = @w_direccion
            where  en_ente = @w_ente

            if @@error <> 0
            begin
              select
                @w_msg = 'Error al actualizar ente'
              select
                @w_estado = 'E'
              goto SIGUIENTE
            end

            select
              @w_codigo_ext = @w_direccion,
              @w_forma_ext = 'C'

          end --Fin crea direccion
        end

        select
          @w_estado = 'P',
          @w_msg = 'Marcacion Email Correcta'
        goto SIGUIENTE
      end

      SIGUIENTE:
      if @w_estado = 'P'
      begin
        /*** INGRESA MARCACION ENVIO EXTRACTOS ***/
        exec @w_return = cobis..sp_forma_extracto
          @s_ssn       = 1,
          @s_date      = @w_fecha_proceso,
          @s_user      = 'op_batch',
          @s_srv       = 'batch',
          @s_lsrv      = 'batch',
          @s_term      = 'KERNELPROD',
          @s_ofi       = @w_oficina,
          @t_trn       = 1609,
          @i_operacion = 'I',
          @i_cliente   = @w_ente,
          @i_codigo    = @w_codigo_ext,
          @i_forma_ext = @w_forma_ext,
          @i_linea     = 'N'

        if @w_return <> 0
        begin
          select
            @w_error = @w_return,
            @w_msg = 'Error en insercion del sp_forma_extracto'
          goto ERROR2
        end
      end

      update tmp_marca_dir
      set    md_estado = @w_estado,
             md_valida = isnull(md_valida, '') + @w_msg
      where  md_secuencial = @w_sec

    end --while

    --TRANSACCION DE SERVICIO
    insert into cl_tran_servicio
                (ts_srv,ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,
                 ts_clase,
                 ts_fecha,ts_usuario,ts_terminal,ts_ente,ts_direccion,
                 ts_descripcion,ts_posicion,ts_parroquia,ts_ciudad,ts_tipo,
                 ts_sucursal,ts_tipo_dp,ts_rural_urbano,ts_observaciondir)
      select
        @w_srv,@w_sec,di_ente,103,'P',
        @w_fecha_proceso,'masivoC12','consola',di_ente,di_direccion,
        di_descripcion,di_vigencia,di_parroquia,di_ciudad,di_tipo,
        di_oficina,di_verificado,di_rural_urb,
        'MARCACION MASIVA DIRECCION EXTRACTO CIRCULAR 012 SFC'
      from   cobis..tmp_marca_dir,
             cobis..cl_ente,
             cobis..cl_direccion
      where  en_tipo_ced = md_tipo_ced
         and en_ced_ruc  = md_ced_ruc
         and di_ente     = en_ente
         and md_estado   = 'P'
         and en_ente in
             (select
                fe_cliente
              from   cobis..cl_forma_extractos)

    if @@error <> 0
    begin
      select
        @w_return = 103005
      goto ERROR2
    /* 'Error en creacion de transaccion de servicio'*/
    end

    --Generar archivo de resultado de validacion
    select
      @w_archerr = @w_server + @w_path_plano + 'Resultados_Marca_C12' + '.err'
    select
      @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..tmp_marca_dir out ' +
      @w_server
      +
      @w_path_plano
      + 'Resultados_Marca_C12_' + @i_param2 + ' -c -e ' + @w_archerr +
      ' -t"|"  -config ' + @w_s_app
      + 's_app.ini'

    exec @w_error = xp_cmdshell
      @w_cmd

    if @w_error <> 0
    begin
      select
        @w_error = 16,
        @w_msg = 'Error generando Archivo de resultados para archivo ' +
                 @i_param2

      goto ERROR1
    end
    else
    begin
      /* Solamente deja el archivo definitivo, se eliminan los archivos temporales */
      select
        @w_cmd = 'del ' + @w_archerr
      exec @w_error = xp_cmdshell
        @w_cmd
      if @w_error <> 0
      begin
        select
          @w_error = 808022,
          @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
        goto ERROR1
      end
    end
    goto FIN2

    ERROR2:
    print cast(@w_error as varchar)
    print @w_msg

    return @w_error

    FIN2:
    set rowcount 0
    return 0
  end
  return 0

go

