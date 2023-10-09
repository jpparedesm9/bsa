use cob_ahorros
go

/************************************************************************/
/*      Archivo:                up_gral_ctahorro.sp                     */
/*      Stored procedure:       sp_up_gral_ctahorro                     */
/*      Base de datos:          cob_ahorros                             */
/*      Producto: Cuentas de Ahorros                                    */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*  Fecha de escritura: 14_Dic-1993                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la transaccion de actualizacion general   */
/*      de los datos ingresados en apertura de cuentas de ahorros.      */
/*      205 = Actualizacion general de cuentas de ahorros.              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      14/Dic/1993     P Mena      Emision Inicial                     */
/*      01/Nov/1994     J. Bucheli      Personalizacion para Banco de   */
/*                                      la Produccion                   */
/*      18/Feb/1999     M. Sanguino    Personalizacion B. del Caribe    */
/*      25/Sep/1999     Juan F. Cadena  Revision Banco del Caribe       */
/*      17/Feb/2010     J. Loyo     Manejo de la fecha de efectivizacion*/
/*                                  teniendo el sabado como habil       */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_up_gral_ctahorro')
  drop proc sp_up_gral_ctahorro
go

create proc sp_up_gral_ctahorro
(
  @s_ssn          int,
  @s_ssn_branch   int,
  @s_srv          varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_nombre       descripcion,
  @i_nombre1      char(64),
  @i_cedruc1      char(13),
  @i_direc        tinyint,
  @i_cli_ec       int,
  @i_ciclo        char(1),
  @i_tipodir      char(1),
  @i_agencia      smallint = 11,
  @i_casillero    varchar(10) = null,
  @i_numlib       int,
  @i_causa        char(1),
  @i_cli1         int,
  @i_direc_dv     tinyint = null,
  @i_tipodir_dv   char(1) = null,
  @i_casillero_dv varchar(10) = null,
  @i_agencia_dv   smallint = 0,
  @i_cli_dv       int,
  @i_turno        smallint = null,
  @o_oficina_cta  smallint=null out
)
as
  declare
    @w_return          int,
    @w_sp_name         varchar(30),
    @w_est             char(1),
    @w_cuenta          int,
    @w_cliente         int,
    @w_producto        tinyint,
    @w_filial          tinyint,
    @w_ced_ruc         numero,
    @w_nombre          descripcion,
    @w_nombre1         char(64),
    @w_cedruc1         char(13),
    @w_direccion_ec    tinyint,
    @w_descdir_ec      direccion,
    @w_cliente_ec      int,
    @w_zona            smallint,
    @w_sector          smallint,
    @w_parroquia       int,
    @w_ciclo           char(1),
    @w_tipodir         char(1),
    @o_fecha_prx_corte varchar(10),
    @w_mes_sig         datetime,
    @w_mes_sigc        varchar(10),
    @w_prx_mes         varchar(10),
    @w_dia_pri         varchar(10),
    @w_ult_dia_mes     datetime,
    @w_ciudad_matriz   int,
    @w_dia_hoy         smallint,
    @w_fecha_prx_ec    datetime,
    @w_fecha_hoy       datetime,
    @w_dia_ciclo       varchar(2),
    @w_tmp             tinyint,
    @v_nombre          descripcion,
    @v_direccion_ec    tinyint,
    @v_descdir_ec      direccion,
    @v_cliente_ec      int,
    @v_zona            smallint,
    @v_sector          smallint,
    @v_parroquia       smallint,
    @v_ciclo           char(1),
    @w_funcio          char(1),
    @w_funcionario     char(10),
    @w_aux             char(10),
    @w_numlib          int,
    @w_levblo          char(1),
    @w_mensaje         varchar(30),
    @w_num_bloqueos    smallint,
    @w_secuencial      int,
    @w_sec             int,
    @w_tipo_bloqueo    char(3),
    @w_oficina_cta     smallint,
    @v_nombre1         char(64),
    @v_cedruc1         char(13),
    @w_direccion_dv    tinyint,
    @w_tipodir_dv      char(1),
    @w_zona_dv         smallint,
    @w_parroquia_dv    int,
    @w_descdir_dv      direccion,
    @v_direccion_dv    tinyint,
    @v_zona_dv         smallint,
    @v_parroquia_dv    smallint,
    @v_descdir_dv      direccion,
    @w_cliente_dv      int,
    @w_tipo_ente       char(1),
    @w_ofi_cifrada     smallint,
    @w_origen          varchar(3),
    @w_oficina_social  tinyint,
    @w_prodbanc        smallint

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_up_gral_ctahorro'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_nombre = @i_nombre,
      i_nombre1 = @i_nombre1,
      i_cedruc1 = @i_cedruc1,
      i_direc = @i_direc,
      i_cli_ec = @i_cli_ec,
      i_ciclo = @i_ciclo,
      i_tipodir = @i_tipodir,
      i_agencia = @i_agencia,
      i_casillero = @i_casillero,
      i_numlib = @i_numlib,
      i_causa = @i_causa,
      i_cli1 = @i_cli1
    exec cobis..sp_end_debug
  end

  /* Validacion del codigo de la Transaccioin */

  if @t_trn <> 205
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end
  /* Variables de trabajo */
  select
    @w_cuenta = ah_cuenta,
    @w_cliente = ah_cliente,
    @w_producto = ah_producto,
    @w_ced_ruc = ah_ced_ruc,
    @w_est = ah_estado,
    @w_nombre = ah_nombre,
    @w_direccion_ec = ah_direccion_ec,
    @w_descdir_ec = ah_descripcion_ec,
    @w_cliente_ec = ah_cliente_ec,
    @w_ciclo = ah_ciclo,
    @w_zona = ah_zona,
    @w_sector = ah_sector,
    @w_parroquia = ah_parroquia,
    @w_numlib = ah_numlib,
    @w_oficina_cta = ah_oficina,
    @w_nombre1 = ah_nombre1,
    @w_cedruc1 = ah_cedruc1,
    @w_tipodir_dv = ah_tipodir_dv,
    @w_direccion_dv = ah_direccion_dv,
    @w_descdir_dv = ah_descripcion_dv,
    @w_zona_dv = ah_zona_dv,
    @w_parroquia_dv = ah_parroquia_dv,
    @w_cliente_dv = ah_cliente_dv,
    @w_tipo_ente = ah_tipocta,
    @w_origen = ah_origen,
    @w_prodbanc = ah_prod_banc
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon

  select
    @o_oficina_cta = @w_oficina_cta

  if @@rowcount <> 1
  begin
    /* No existe cuenta_banco */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 1
  end

  if @w_tipo_ente = 'I'
  begin
    select
      @w_ofi_cifrada = oc_oficina
    from   cob_ahorros..ah_oficina_ctas_cifradas
    where  oc_oficina = @s_ofi
       and oc_estado  = 'V'
    if @@rowcount = 0
    begin
      -- Oficina no autorizada para cuentas cifradas
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251081
      return 251081
    end
  end

/* VALIDACION PARA QUE LA CUENTA DE SERVICIO SOCIAL (origen = '9') */
  /* SOLO SE ACTUALICE EN LA OFICINA MATRIZ */

  select
    @w_oficina_social = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'OMAT'

  if @w_origen = '9'
     and @s_ofi <> @w_oficina_social
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251084
    return 251084
  end

  /* Se obtiene la filial */

  select
    @w_filial = of_filial
  from   cobis..cl_oficina
  where  of_oficina = @s_ofi

  select
    @w_fecha_hoy = @s_date
  select
    @w_dia_hoy = datepart(dd,
                          @w_fecha_hoy)

/* Obtencion de la ciudad de la oficina Matriz para el calculo de la fecha */
/* de proximo corte                                                        */
/** La ciudad matriz se trae en el llamado al sp_fecha_habil  ***/
  --select @w_ciudad_matriz  = pa_int
  --  from cobis..cl_parametro
  -- where pa_producto = 'CTE'
  --   and pa_nemonico = 'CMA'

  /* Validaciones */
  if @w_est <> 'A'
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  select
    @v_direccion_ec = @w_direccion_ec,
    @v_descdir_ec = @w_descdir_ec,
    @v_cliente_ec = @w_cliente_ec,
    @v_zona = @w_zona,
    @v_sector = @w_sector,
    @v_parroquia = @w_parroquia,
    @v_ciclo = @w_ciclo,
    @v_nombre1 = @w_nombre1,
    @v_cedruc1 = @w_cedruc1,
    @v_direccion_dv = @w_direccion_dv,
    @v_zona_dv = @w_zona_dv,
    @v_parroquia_dv = @w_parroquia_dv,
    @v_descdir_dv = @w_descdir_dv

  /* Actualizacion de los campos permisibles de actualizar */
  if @w_nombre = @i_nombre
    select
      @w_nombre = null,
      @v_nombre = null
  else
    select
      @w_nombre = @i_nombre

/* Para Personalizacion Banco Caribe */
  /* Actualizacion de Campos nombre1 */
  if @w_nombre1 = @i_nombre1
    select
      @w_nombre1 = '',
      @v_nombre1 = ''
  else
    select
      @w_nombre1 = @i_nombre1

  if @w_cedruc1 = @i_cedruc1
    select
      @w_cedruc1 = '',
      @v_cedruc1 = ''
  else
    select
      @w_cedruc1 = @i_cedruc1

  if @w_direccion_ec = @i_direc
     and @w_cliente_ec = @i_cli_ec
     and @w_tipodir = @i_tipodir
     and (@i_tipodir <> 'R'
          and @i_tipodir <> 'S')
    select
      @w_direccion_ec = null,
      @v_direccion_ec = null

  else
  begin
    select
      @w_parroquia = 0,
      @w_zona = 0,
      @w_sector = 0

    if @i_tipodir = 'D'
    begin
      select
        @w_descdir_ec = di_descripcion,
        @w_parroquia = isnull(di_ciudad,
                              0)
      from   cobis..cl_direccion
      where  di_ente      = @i_cli_ec
         and di_direccion = @i_direc

      select
        @w_direccion_ec = @i_direc
    end

    if @i_tipodir = 'C'
    begin
      select
        @w_descdir_ec = cs_valor + ' | ' + sc_descripcion,
        @w_parroquia = isnull(cs_ciudad,
                              0),
        @w_zona = cs_provincia,
        @w_sector = 0
      from   cobis..cl_casilla,
             cobis..cl_suc_correo
      where  cs_ente      = @i_cli_ec
         and cs_casilla   = @i_direc
         and cs_sucursal  = sc_sucursal
         and cs_provincia = sc_provincia
         and cs_provincia is not null

      if @@rowcount = 0
      begin
        select
          @w_descdir_ec = cs_valor + ' | ' + pv_descripcion,
          @w_parroquia = isnull(cs_ciudad,
                                0),
          @w_zona = isnull(cs_provincia,
                           0),
          @w_sector = 0
        from   cobis..cl_casilla,
               cobis..cl_provincia --, cobis..cl_pais
        where  cs_ente      = @i_cli_ec
           and cs_casilla   = @i_direc
           --and cs_provincia is null
           and pv_provincia = cs_provincia
      --and ci_pais = pa_pais

      end

      select
        @w_direccion_ec = @i_direc
    end

    if @i_tipodir = 'R'
    begin
      select
        @w_descdir_ec = 'RETENCION EN ' + of_nombre
      from   cobis..cl_oficina
      where  of_filial  = @w_filial
         and of_oficina = @i_agencia
      select
        @i_cli_ec = 0,
        @i_direc = 0
      select
        @w_direccion_ec = @i_direc
    end
    if @i_tipodir = 'S'
    begin
      if @i_casillero is not null
        select
          @w_descdir_ec = 'CASILLERO # ' + @i_casillero
      select
        @i_cli_ec = 0,
        @i_direc = 0
      select
        @w_direccion_ec = @i_direc
    end
  end

  /*  direccion de cheques devueltos */

  if @w_direccion_dv = @i_direc_dv
     and @w_cliente_dv = @i_cli_dv
     and @w_tipodir_dv = @i_tipodir_dv
     and (@i_tipodir_dv <> 'R'
          and @i_tipodir_dv <> 'S')
    select
      @w_direccion_dv = null,
      @v_direccion_dv = null
  else
  begin
    select
      @w_parroquia_dv = 0,
      @w_zona_dv = 0

    if @i_tipodir_dv = 'D'
    begin
      select
        @w_descdir_dv = di_descripcion,
        @w_parroquia_dv = isnull(di_ciudad,
                                 0)
      from   cobis..cl_direccion
      where  di_ente      = @i_cli_dv
         and di_direccion = @i_direc_dv

      select
        @w_direccion_dv = @i_direc_dv
    end
    if @i_tipodir_dv = 'C'
    begin
      select
        @w_descdir_dv = cs_valor + ' | ' + sc_descripcion,
        @w_parroquia_dv = isnull(cs_ciudad,
                                 0),
        @w_zona_dv = cs_provincia
      from   cobis..cl_casilla,
             cobis..cl_suc_correo
      where  cs_ente      = @i_cli_dv
         and cs_casilla   = @i_direc_dv
         and cs_sucursal  = sc_sucursal
         and cs_provincia = sc_provincia
         and cs_provincia is not null

      if @@rowcount = 0
      begin
        select
          @w_descdir_dv = cs_valor + ' | ' + pv_descripcion,
          @w_parroquia_dv = isnull(cs_ciudad,
                                   0),
          @w_zona_dv = isnull(cs_provincia,
                              0)
        from   cobis..cl_casilla,
               cobis..cl_provincia --, cobis..cl_pais
        where  cs_ente      = @i_cli_dv
           and cs_casilla   = @i_direc_dv
           -- and cs_provincia is null
           and pv_provincia = cs_provincia
        -- and ci_pais = pa_pais

        if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 201098
          return 1
        end
      end
      select
        @w_direccion_dv = @i_direc_dv
    end
    if @i_tipodir_dv = 'R'
    begin
      select
        @w_descdir_dv = 'RETENCION EN ' + of_nombre
      from   cobis..cl_oficina
      where  of_filial  = @w_filial
         and of_oficina = @i_agencia_dv
      select
        @i_cli_dv = 0,
        @i_direc_dv = 0
      select
        @w_direccion_dv = @i_direc_dv
    end
    if @i_tipodir_dv = 'S'
    begin
      if @i_casillero_dv is not null
        select
          @w_descdir_dv = 'CASILLERO # ' + @i_casillero_dv
      select
        @i_cli_dv = 0,
        @i_direc_dv = 0
      select
        @w_direccion_dv = @i_direc_dv
    end
  end

  /* Calculo de la fecha del proximo corte de estado de cuenta */

  if @i_ciclo = '3'
  begin
    select
      @w_mes_sig = dateadd(mm,
                           1,
                           @w_fecha_hoy)
    select
      @w_mes_sigc = convert(varchar(10), @w_mes_sig, 101)
    select
      @w_dia_pri = substring(@w_mes_sigc, 1, 3) + '01' + substring(@w_mes_sigc,
                   6,
                   5
                   )
    --       select  @w_ult_dia_mes = dateadd(dd,-1,convert(datetime,@w_dia_pri))

    --       while 1 = 1
    --         begin
    --           if exists (select 1 from cobis..cl_dias_feriados
    --                       where df_ciudad  = @w_ciudad_matriz
    --                         and df_fecha = @w_ult_dia_mes)
    --             select @w_ult_dia_mes = dateadd(dd, -1, @w_ult_dia_mes)
    --           else
    --             break
    --         end

  /*** La determinacion del anterior dia laboral  se           ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif       = 'N',
      @i_efec_dia      = 'S',
      @i_fecha         = @w_ult_dia_mes,
      @i_oficina       = @s_ofi,
      @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
      @w_dias_ret      = -1,/*** Dia anterior habil          ***/
      @o_ciudad_matriz = @w_ciudad_matriz out,
      @o_fecha_sig     = @w_ult_dia_mes out

    if @w_return <> 0
      return @w_return

    select
      @o_fecha_prx_corte = convert(varchar(10), @w_ult_dia_mes, 101)

  end
  else
  begin
    select
      @w_dia_ciclo = substring(valor,
                               1,
                               2)
    from   cobis..cl_catalogo
    where  tabla  = (select
                       cobis..cl_tabla.codigo
                     from   cobis..cl_tabla
                     where  tabla = 'cc_ciclo')
       and codigo = @i_ciclo

    select
      @w_tmp = convert(tinyint, @w_dia_ciclo)

    if @w_dia_hoy < @w_tmp
    begin
      select
        @w_prx_mes = convert(varchar(10), @w_fecha_hoy, 101)
      select
        @o_fecha_prx_corte =
        substring(@w_prx_mes, 1, 3) + @w_dia_ciclo + substring(
        @w_prx_mes, 6, 5)
    end
    else
    begin
      select
        @w_prx_mes = convert(varchar(10), dateadd(month,
                                                  1,
                                                  @w_fecha_hoy), 101)
      select
        @o_fecha_prx_corte = substring(@w_prx_mes, 1, 2) + '/' + @w_dia_ciclo +
                             '/'
                             +
                             substring(@w_prx_mes, 7
                             , 4)
    end

    select
      @w_fecha_prx_ec = convert(datetime, @o_fecha_prx_corte)

  /****** En este caso envian a validar la fecha actual y si es festivo se regresan un dia *****/
    /****** Por ello a la fecha le sumamos un dia e invocamos el sp restando un dia          *****/
    select
      @w_fecha_prx_ec = dateadd(dd,
                                1,
                                @w_fecha_prx_ec)

    --       while 1 = 1
    --         begin
    --           if exists (
    --                      select  * from  cobis..cl_dias_feriados
    --                       where  df_ciudad = @w_ciudad_matriz
    --                         and  df_fecha = @w_fecha_prx_ec)
    --             select @w_fecha_prx_ec = dateadd(dd,-1,@w_fecha_prx_ec)
    --           else
    --             break
    --         end

  /*** La determinacion del anterior dia laboral  se           ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif       = 'N',
      @i_efec_dia      = 'S',
      @i_fecha         = @w_fecha_prx_ec,
      @i_oficina       = @s_ofi,
      @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
      @w_dias_ret      = -1,/*** Dia anterior habil          ***/
      @o_ciudad_matriz = @w_ciudad_matriz out,
      @o_fecha_sig     = @w_fecha_prx_ec out

    if @w_return <> 0
      return @w_return

    select
      @o_fecha_prx_corte = convert(varchar(10), @w_fecha_prx_ec, 101)
  end

  if @w_ciclo = @i_ciclo
    select
      @w_ciclo = null,
      @v_ciclo = null
  else
    select
      @w_ciclo = @i_ciclo

  /* Validacion que el cliente titular de la cuenta sea un funcionario */

  select
    @w_funcionario = en_tipo_vinculacion
  from   cobis..cl_ente
  where  en_ente = @w_cliente

  select
    @w_aux = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CFU'

  if @w_funcionario <> @w_aux
    select
      @w_funcio = 'N'
  else
  begin
    if (select
          count(1)
        from   cobis..cl_catalogo
        where  tabla in
               (select
                  codigo
                from   cobis..cl_tabla
                where  tabla = 'ah_producto_funcionario')
               and codigo = convert(varchar(10), @w_prodbanc)
               and estado = 'V') > 0
    begin
      select
        @w_funcio = 'S'
    end
    else
    begin
      select
        @w_funcio = 'N'
    end
  end

  /* Verificacion si modificaron el numero de libreta     EGA */

  if @i_numlib <> @w_numlib
    select
      @w_levblo = 'S'

  if @w_levblo = 'S'
     and @i_causa = 'A'
  begin
    /*  Determinacion de bloqueo de cuenta  */
    select
      @w_tipo_bloqueo = cb_tipo_bloqueo,
      @w_secuencial = cb_secuencial
    from   cob_ahorros..ah_ctabloqueada
    where  cb_cuenta       = @w_cuenta
       and cb_estado       = 'V'
       and cb_tipo_bloqueo = '3'
    if @@rowcount = 0
    begin
      select
        @w_mensaje = 'Libreta no ha sido anulada: '
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251007,
        @i_sev   = 1,
        @i_msg   = @w_mensaje
      return 1
    end
  end

  /*  si es canje de libreta no debe estar bloqueada movimientos   EGA*/

  if @w_levblo = 'S'
     and @i_causa = 'C'
  begin
    /*  Determinacion de bloqueo de cuenta  */
    select
      @w_tipo_bloqueo = cb_tipo_bloqueo
    from   cob_ahorros..ah_ctabloqueada
    where  cb_cuenta       = @w_cuenta
       and cb_estado       = 'V'
       and cb_tipo_bloqueo = '3'
    if @@rowcount <> 0
    begin
      select
        @w_mensaje = 'Libreta Bloqueada Dep/Retiro:'
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251007,
        @i_sev   = 1,
        @i_msg   = @w_mensaje
      return 1
    end
  end

  /* Actualizacion de las tablas: ah_cuenta, cl_det_producto */
  begin tran
  update cob_ahorros..ah_cuenta
  set    ah_nombre = @i_nombre,
         ah_direccion_ec = @i_direc,
         ah_descripcion_ec = @w_descdir_ec,
         ah_cliente_ec = @i_cli_ec,
         ah_zona = @w_zona,
         ah_sector = @w_sector,
         ah_parroquia = @w_parroquia,
         ah_agen_ec = @i_agencia,
         ah_ciclo = @i_ciclo,
         ah_tipo_dir = @i_tipodir,
         ah_fecha_prx_corte = @o_fecha_prx_corte,
         ah_cta_funcionario = @w_funcio,
         ah_numlib = @i_numlib,
         ah_nombre1 = @i_nombre1,
         ah_cedruc1 = @i_cedruc1,
         ah_cliente1 = @i_cli1,
         ah_direccion_dv = @i_direc_dv,
         ah_tipodir_dv = @i_tipodir_dv,
         ah_descripcion_dv = @w_descdir_dv,
         ah_zona_dv = @w_zona_dv,
         ah_parroquia_dv = @w_parroquia_dv,
         ah_cliente_dv = @i_cli_dv,
         ah_agen_dv = @i_agencia_dv
  where  ah_cuenta = @w_cuenta

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de registro en ah_cuenta */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255001
    return 1
  end

  update cobis..cl_det_producto
  set    dp_direccion_ec = @i_direc,
         dp_descripcion_ec = @w_descdir_ec
  where  dp_cuenta   = @i_cta
     and dp_producto = 4

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de registro en cl_det_producto */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105050
    return 1
  end

  /* Creacion de transaccion de servicio */
  insert into cob_ahorros..ah_tsapertura
              (secuencial,ssn_branch,alterno,tipo_transaccion,oficina,
               usuario,terminal,reentry,clase,tsfecha,
               cta_banco,filial,origen,moneda,cliente,
               ced_ruc,estado,cuenta,direccion_ec,ciclo,
               producto,tipo,numlib,accion,oficina_cta,
               nombre1,cedula1,turno)
  values      (@s_ssn,@s_ssn_branch,20,@t_trn,@s_ofi,
               @s_user,@s_term,@t_rty,'P',@s_date,
               @i_cta,@w_filial,@s_org,@i_mon,@w_cliente,
               @w_ced_ruc,'A',@w_cuenta,@v_direccion_ec,@v_ciclo,
               @w_producto,'R',@w_numlib,@i_causa,@w_oficina_cta,
               @v_nombre1,@v_cedruc1,@i_turno)
  if @@error <> 0
  begin
    /* Error en creacion de transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 1
  end

  insert into cob_ahorros..ah_tsapertura
              (secuencial,ssn_branch,alterno,tipo_transaccion,oficina,
               usuario,terminal,reentry,clase,tsfecha,
               cta_banco,filial,origen,moneda,fecha_aper,
               cliente,ced_ruc,estado,cuenta,direccion_ec,
               ciclo,producto,tipo,numlib,accion,
               oficina_cta,nombre1,cedula1,turno)
  values      (@s_ssn,@s_ssn_branch,30,@t_trn,@s_ofi,
               @s_user,@s_term,@t_rty,'A',@s_date,
               @i_cta,@w_filial,@s_org,@i_mon,@s_date,
               @w_cliente,@w_ced_ruc,'A',@w_cuenta,@w_direccion_ec,
               @w_ciclo,@w_producto,'R',@i_numlib,@i_causa,
               @w_oficina_cta,@w_nombre1,@w_cedruc1,@i_turno)
  if @@error <> 0
  begin
    /* Error en creacion de transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 1
  end

  select
    @o_fecha_prx_corte

/* Transaccion de levantamiento de bloqueos a la cuenta */
  /* Si se modifica el numero de libreta          EGA     */

  if @w_levblo = 'S'
     and @i_causa = 'A'
  begin
    select
      @w_num_bloqueos = ah_bloqueos - 1
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta = @w_cuenta

    /* Actualizacion de las tablas: ah_ctabloqueada */

    update cob_ahorros..ah_ctabloqueada
    set    cb_estado = 'C'
    where  cb_cuenta     = @w_cuenta
       and cb_secuencial = @w_secuencial

    if @@rowcount <> 1
    begin
      /* Error en actualizacion de registro en ah_ctabloqueada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205007
      return 1
    end

    /* Actualizacion del campo de numero de bloqueos en ah_cuenta */

    update cob_ahorros..ah_cuenta
    set    ah_bloqueos = @w_num_bloqueos
    where  ah_cuenta = @w_cuenta

    if @@rowcount <> 1
    begin
      /* Error en actualizacion de registro en ah_cuenta */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255001
      return 1
    end

    /* Generacion del registro de levantamiento */

    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'ah_ctabloqueada',
      @o_siguiente = @w_sec out
    if @w_return <> 0
      return @w_return

    insert into ah_ctabloqueada
                (cb_cuenta,cb_secuencial,cb_tipo_bloqueo,cb_fecha,cb_hora,
                 cb_autorizante,cb_solicitante,cb_estado,cb_oficina,cb_causa,
                 cb_sec_asoc)
    values      (@w_cuenta,@w_sec,'3',@s_date,getdate(),
                 @s_user,'CLIENTE','L',@s_ofi,@i_causa,
                 @w_secuencial)

    if @@error <> 0
    begin
      /* Error en creacion de registro en ah_ctabloqueada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203009
      return 1
    end

    /* Creacion de transaccion de servicio  */

    insert into cob_ahorros..ah_tsbloqueo
                (secuencial,ssn_branch,alterno,tipo_transaccion,tsfecha,
                 usuario,terminal,oficina,reentry,origen,
                 cta_banco,tipo_bloqueo,fecha,moneda,autorizante,
                 estado,causa,ctacte,hora,solicitante,
                 oficina_cta,turno)
    values      (@s_ssn,@s_ssn_branch,40,212,@s_date,
                 @s_user,@s_term,@s_ofi,@t_rty,@s_org,
                 @i_cta,'3',@s_date,@i_mon,@s_user,
                 'C',@i_causa,@w_cuenta,getdate(),'CLIENTE',
                 @w_oficina_cta,@i_turno)
    if @@error <> 0
    begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 1
    end
  end /* termina if levantamiento bloqueo si modifico num.libreta */
  commit tran

go

