use cob_ahorros
go

/************************************************************************/
/*      Archivo:                ahupdefe.sp                             */
/*      Stored procedure:       sp_update_efectiah_batch                */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Julio Navarrete                         */
/*      Fecha de escritura:     29-Dic-1992                             */
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
/*      BATCH:  Cursor que permite la actualizacion de saldos para      */
/*              cuentas de ahorros                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      02/Ago/1995     J. Bucheli      Personalizacion Banco de la     */
/*                                      Produccion                      */
/*      13/May/1996     J. Bucheli      Optimizacion de cursores        */
/*                                      Feriados locales                */
/*      08/Abr/2013     J. Colorado     Reintegro Impuesto gmf Alianza  */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_update_efectiah_batch')
  drop proc sp_update_efectiah_batch
go

create proc sp_update_efectiah_batch
(
  @t_show_version bit = 0,
  @i_filial       tinyint = 1,
  @i_fecha        smalldatetime= null,
  @i_param1       datetime = null,-- Fecha de proceso
  @s_srv          varchar(16) = null,
  @o_procesadas   int = null out
)
as
  declare
    @w_sp_name             varchar(64),
    @w_moneda              smallint,
    @w_cta_banco           cuenta,
    @w_prod_banc           smallint,
    @w_contable            money,
    @w_disponible          money,
    @w_12h                 money,
    @w_12h_dif             money,
    @w_12h_neto            money,
    @w_prom_disp           money,
    @w_tipo_promedio       varchar(3),
    @w_alicuota            numeric(11, 10),
    @w_procesadas          int,
    @w_error               int,
    @w_numdeci             tinyint,
    @w_numdeci_imp         tinyint,
    @w_decimales           char(1),
    @w_cuenta              int,
    @w_oficina             smallint,
    @w_mensaje             varchar(64),
    @w_ssn                 int,
    @w_return              int,
    @w_vlr_canje           money,
    @w_valor_efe           money,
    @w_vlr_devolucion      money,
    @w_fecha               smalldatetime,
    @w_mon_ant             smallint,
    @w_tipo_prom_ant       varchar(3),
    @w_estado              char(1),
    @w_registro            int,
    @w_msg                 varchar(100),
    @w_debug               char(1),
    @w_debug_int           char(1),
    @w_capitalizacion      varchar(3),
    @w_prom_disp_ant       money,
    @w_fecha_depo          smalldatetime,
    @w_fecha_depo_ant      smalldatetime,
    @w_categoria           char(1),
    @w_tipocta_super       char(1),
    @w_clase_clte          char(1),
    @w_cliente             int,
    @w_monto               money,
    @w_tipo_atributo       char(1),
    @w_producto            tinyint,
    @w_tipocta             char(1),
    @w_sucursal            smallint,
    @w_filial              int,
    @w_alic_hoy            numeric(11, 10),
    @w_sd_saldo_disponible money,
    @w_sd_prom_disponible  money,
    @w_sd_int_hoy          money,
    @w_sd_dias             smallint,
    @w_dias_anio           smallint,
    @w_factor              float,
    @w_factor1             float,
    @w_factor2             float,
    @w_ultimo_rango        int,
    @w_penultimo_rango     int,
    @w_rango_desde         money,
    @w_monto_interes       money,
    @w_monto_interes1      money,
    @w_monto_interes2      money,
    @w_pen_rango_hasta     money,
    @w_rango_hasta         money,
    @w_rango_busqueda      money,
    @w_valor_acreditar     money,
    @w_tasa_interes        real,
    @w_saldo_interes       money,
    @w_fecha_ult_cap       smalldatetime,
    @w_trn_code            smallint,
    @w_monto_ajuste        money,
    @w_monto_ult_capi      money,
    @w_monto_capi_act      money,
    @w_promedio1           money,
    @w_dias_cta            int,
    @w_dias_periodo        int,
    @w_codigo_pais         char(2),
    @w_cpto_rte            char(4),
    @w_cpto_rteica         char(4),
    @w_base_rtfte          money,
    @w_porcentaje          float,
    @w_exento              char(1),
    @w_tasa_impuesto       float,
    @w_valor_impuesto      money,
    @w_binc                money,
    @w_gmf                 money,
    @w_base_gmf            money,
    @w_acumu_deb           money,
    @w_actualiza           char(1),
    @w_tasa_disponible     real,
    @w_alt                 int,
    @w_cont_profinal       tinyint,
    @w_prod_contractual    int,
    @w_es_contractual      char(1),
    @w_num_rango           tinyint,
    @w_camcat              char(1),
    @w_fecha_calc          smalldatetime,
    @w_cambiames           char(1),
    @w_diasmesant          tinyint,
    @w_diasmesact          tinyint,
    @w_primerdia           datetime,
    @w_anio                char(4),
    @w_ciudad              int,
    @w_tasa_reintegro      float,
    @w_gmf_reintegro       money,
    @o_alic                float
/**** Variables para calcular la alicuota del a±o anterior *****/
  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_update_efectiah_batch',
    @w_registro = 0,
    @w_alt = 0,
    @w_cambiames = 'N'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @w_debug_int = 'S',
    @w_debug = 'N'
  print ' Empieza el Sp '
  print ''
  if @i_param1 is null
     and @i_fecha is null
  begin
    --Falta parametro obligatorio
    exec cobis..sp_cerror
      @i_num = 101114
    return 101114
  end

  if @i_fecha is null
    select
      @i_fecha = @i_param1

  -- Encuentra el dias del anio para provision diaria interes
  select
    @w_dias_anio = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'DIA'

  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO DE NUMERO DE DIAS ANIO'
    goto ERRORFIN
  end

  -- Parametro para Base Diaria Interes para calculo de retenci¢n
  select
    @w_binc = isnull(pa_money,
                     0)
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'BINCR'

  if @@rowcount <> 1
  begin
    select
      @w_error = 201196,
      @w_msg = 'ERROR EN PARAMETRO DE BASE DIARIA'
    goto ERRORFIN
  end

  -- DETERMINAR EL PAIS DONDE SE ESTA EJECUTANDO EL PROCESO
  select
    @w_codigo_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @@rowcount = 0
  begin
    select
      @w_error = 101190,
      @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL ABPAIS DEL ADMIN'
    goto ERRORFIN
  end

  --Parametro concepto de retencion
  select
    @w_cpto_rte = ci_concepto
  from   cob_remesas..re_concepto_imp
  where  ci_tran        = 308
     and ci_impuesto    = 'R'
     and ci_contabiliza = 'tm_valor'

  if @@rowcount <> 1
  begin
    select
      @w_error = 201196,
      @w_msg = 'ERROR EN PARAMETRO DE CONCEPTO DE RETENCION'
    goto ERRORFIN
  end

  --Parametro concepto de reteica
  select
    @w_cpto_rteica = ci_concepto
  from   cob_remesas..re_concepto_imp
  where  ci_tran     = 334
     and ci_impuesto = 'C'

  if @@rowcount <> 1
  begin
    select
      @w_error = 201196,
      @w_msg = 'ERROR EN PARAMETRO DE CONCEPTO DE RETEICA'
    goto ERRORFIN
  end

  /* Inicializar el contador de cuentas procesadas */
  select
    @w_procesadas = 0,
    @w_mon_ant = -1,
    @w_tipo_prom_ant = 'Z',
    @w_fecha_depo_ant = '01/01/1900'
  select
    @w_fecha = @i_fecha /**  VMA 02-SEP-2003  **/

  select
    @w_debug = 'N'

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'pint4')
    drop table tempdb..pint4

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'PINT',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    select
      @w_msg = @w_msg + ' PINT'
    print @w_msg

    select
      @w_error = 205031,
      @w_msg = isnull(@w_msg,
                      'Error en creacion pint4')
    goto ERRORFIN
  end

  exec cob_remesas..sp_crea_atrib

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'pint4')
  begin
    create clustered index pint4_Key
      on tempdb..pint4 (tipo_ente, pro_bancario, filial, sucursal, producto,
    moneda, categoria, servicio_dis, rubro, tipo_atributo, rango_desde,
    rango_hasta)

    create index i_pint4
      on tempdb..pint4 (sucursal, pro_bancario, tipo_ente, categoria,
    rango_desde,
    rango_hasta)
  end

  select
    *
  into   #pint4
  from   tempdb..pint4
  where  1 = 2

  /* REQ 217 AHORRO CONTRACTUAL */
  select
    @w_prod_contractual = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PAHCT'
  if @@rowcount = 0
  begin
    select
      @w_error = 0,
      @w_msg = 'NO EXISTE PARAMETRO PRODUCTO CONTRACTUAL'
    goto ERROR
  end

  if (select
        count(1)
      from   cob_remesas..pe_pro_bancario
      where  pb_pro_bancario = @w_prod_contractual) = 0
  begin
    select
      @w_error = 0,
      @w_msg = 'PRODUCTO DEFINIDO EN PARAMETRO NO EXISTE'
    goto ERROR
  end

  select
    @w_camcat = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'CAMCAT'
  if @@rowcount = 0
  begin
    select
      @w_error = 0,
      @w_msg = 'NO EXISTE PARAMETRO CAMBIO DE CATEGORIA'
    goto ERROR
  end
/* FIN - REQ 217 AHORRO CONTRACTUAL */
  /* Cursor para ah_cuenta */
  declare update_to_date_batch cursor for
    select
      cd_cuenta,
      cd_fecha_depo,
      sum(cd_valor_efe),
      cd_ciudad
    from   cob_ahorros..ah_ciudad_deposito
    /**** (index ah_ciudad_deposito_Alt)   ***/
    where  cd_cuenta       >= 1
       and cd_fecha_efe    = @w_fecha
       and cd_efectivizado = 'S'
    group  by cd_fecha_depo,
              cd_cuenta,
              cd_ciudad
    order  by cd_fecha_depo,
              cd_cuenta,
              cd_ciudad

  /* Abrir el cursor para liquidacion de sobregiros */
  open update_to_date_batch

  /* Ubicar el primer registro para el cursor */
  fetch update_to_date_batch into @w_cuenta, @w_fecha_depo, @w_vlr_canje,
                                  @w_ciudad

  if @@fetch_status = -1
  begin
    print 'No hay Registros a Procesar'
    close update_to_date_batch
    deallocate update_to_date_batch
    return 0
  end
  else if @@fetch_status = -2
  begin
    print 'Error En la apertura del Cursor'
    close update_to_date_batch
    deallocate update_to_date_batch
    select
      @o_procesadas = 0
    return 201154
  end

  /* Barrer todas las cuentas para actualizacion de saldos */
  while @@fetch_status = 0
  begin
    print ''
    print ' Sp...cuenta ' + cast ( @w_cuenta as varchar) + ' Ciudad : '
          + cast(@w_ciudad as varchar)

    if @w_procesadas = 0
    begin
      update cobis..ba_secuencial
      set    @w_ssn = se_numero,
             se_numero = @w_ssn + 1

      if @@rowcount <> 1
      begin
        select
          @w_error = 205031,
          @w_msg = 'Error en actualizacion de SSN'
        goto ERRORFIN
      end
    end

    begin tran

    select
      @w_registro = @w_registro + 1

    if @w_registro >= 5000
    begin
      print 'registros procesados' + cast (@w_registro as varchar)
      select
        @w_registro = 0
    end

    select
      @w_cta_banco = ah_cta_banco,
      @w_disponible = ah_disponible,
      @w_estado = ah_estado,
      @w_12h = ah_12h,
      @w_12h_dif = ah_12h_dif,
      @w_contable = ah_disponible + ah_12h + ah_24h,
      @w_tipo_promedio = ah_tipo_promedio,
      @w_prom_disp = ah_prom_disponible,
      @w_moneda = ah_moneda,
      @w_prod_banc = ah_prod_banc,
      @w_capitalizacion = ah_capitalizacion,
      @w_oficina = ah_oficina,
      @w_categoria = ah_categoria,
      @w_tipocta_super = ah_tipocta_super,
      @w_clase_clte = ah_clase_clte,
      @w_cliente = ah_cliente,
      @w_tipocta = ah_tipocta,
      @w_filial = ah_filial,
      @w_saldo_interes = ah_saldo_interes,
      @w_producto = ah_producto,
      @w_fecha_ult_cap = ah_fecha_ult_capi,
      @w_monto_ult_capi = ah_monto_ult_capi,
      @w_dias_cta = datediff(dd,
                             ah_fecha_aper,
                             ah_fecha_ult_capi),
      @w_promedio1 = ah_promedio1
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta = @w_cuenta
       and ah_12h    >= 1

    if @@rowcount <> 1
    begin
      select
        @w_cta_banco = convert(varchar(24), @w_cuenta)
      select
        @w_error = 0,
        @w_msg = 'NO EXISTE CUENTA CON RETENCION EN 12 HORAS: ' + @w_cta_banco
      goto ERROR
    end

    select
      @w_sucursal = isnull(of_regional,
                           of_oficina)
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina

    print ' ===================== INICIO CUENTA ' + @w_cta_banco +
          ' =========== '
    if @w_estado = 'C'
    begin
      select
        @w_error = 0,
        @w_msg = 'CUENTA CERRADA CON RETENCION EN 12 HORAS: ' + @w_cta_banco
      goto ERROR
    end

    /* Encontrar el numero de decimales que usa la moneda */
    if @w_mon_ant <> @w_moneda
    begin
      select
        @w_decimales = mo_decimales
      from   cobis..cl_moneda
      where  mo_moneda = @w_moneda

      if @w_decimales = 'S'
      begin
        select
          @w_numdeci = isnull(pa_tinyint,
                              0)
        from   cobis..cl_parametro
        where  pa_producto = 'AHO'
           and pa_nemonico = 'DCI'

        if @w_numdeci is null
          select
            @w_numdeci = 0

        select
          @w_numdeci_imp = isnull(pa_tinyint,
                                  0)
        from   cobis..cl_parametro
        where  pa_producto = 'AHO'
           and pa_nemonico = 'DIM'

        if @w_numdeci_imp is null
          select
            @w_numdeci_imp = 0
      end
      else
        select
          @w_numdeci = 0,
          @w_numdeci_imp = 0
    end

    /* Calculo del promedio del disponible */
    if (@w_tipo_prom_ant <> @w_tipo_promedio)
        or (@w_fecha_depo_ant <> @w_fecha_depo)
    begin
      select
        @w_tipo_prom_ant = @w_tipo_promedio

      select
        @w_alicuota = fp_alicuota
      from   cob_ahorros..ah_fecha_promedio
      where  fp_tipo_promedio = @w_tipo_promedio
         and fp_fecha_inicio  = @w_fecha_depo

      if @@rowcount = 0
      begin
        if datepart(yy,
                    @w_fecha_depo) <> datepart(yy,
                                               @w_fecha)
        /*** Si hay cambio de a±o calcular el valor de alicuota ****/
        begin
          select
            @w_anio = convert(varchar(4), datepart (yy,
                                                    @w_fecha_depo))
          exec cob_ahorros..sp_gen_aliprom
            @i_anio  = @w_anio,
            @i_tprom = @w_tipo_promedio,
            @i_fecha = @w_fecha_depo,
            @i_oper  = 'D',/*** Para generar la alicuota de un dia ***/
            @o_alic  = @o_alic out
          select
            @w_alicuota = @o_alic

        end
        else
        begin
          select
            @w_error = 251013,
            @w_msg = 'ERROR EN LECTURA DE FECHA PROMEDIO'
          goto ERROR
        end
      end

      select
        @w_alic_hoy = fp_alicuota
      from   cob_ahorros..ah_fecha_promedio
      where  fp_tipo_promedio = @w_tipo_promedio
         and fp_fecha_inicio  = @w_fecha_ult_cap

      if @@rowcount = 0
      begin
        if datepart(yy,
                    @w_fecha_ult_cap) <> datepart(yy,
                                                  @w_fecha)
        /*** Si hay cambio de a±o calcular el valor de alicuota ****/
        begin
          select
            @w_anio = convert(varchar(4), datepart (yy,
                                                    @w_fecha_ult_cap))
          exec cob_ahorros..sp_gen_aliprom
            @i_anio  = @w_anio,
            @i_tprom = @w_tipo_promedio,
            @i_fecha = @w_fecha_ult_cap,
            @i_oper  = 'D',/*** Para generar la alicuota de un dia ***/
            @o_alic  = @o_alic out
          select
            @w_alic_hoy = @o_alic
        end
        else
        begin
          select
            @w_error = 251013,
            @w_msg = 'ERROR EN LECTURA DE FECHA PROMEDIO'
          goto ERROR
        end
      end
    end

    if @w_debug = 'S'
    begin
      print ''
      print '============'
      print 'ANTES'
      select
        cd_efectivizado,
        cd_valor_efe,
        cd_valor,
        cd_cuenta,
        cd_fecha_efe,
        cd_ciudad
      from   cob_ahorros..ah_ciudad_deposito
      where  cd_cuenta    = @w_cuenta
         and cd_fecha_efe = @i_fecha

      select
        ah_cta_banco,
        ah_fecha_aper,
        ah_fecha_ult_capi,
        ah_disponible,
        ah_12h,
        ah_12h_dif,
        ah_24h,
        ah_prom_disponible,
        ah_saldo_interes,
        ah_int_hoy,
        ah_tasa_hoy,
        ah_monto_ult_capi
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_cta_banco
    end

    select
      @w_12h = @w_12h - @w_vlr_canje
    select
      @w_12h_neto = @w_vlr_canje

    select
      @w_procesadas = @w_procesadas + 1
    select
      @w_alt = @w_alt + 1

    print ' '
    print ' =====> Canje ' + cast (@w_vlr_canje as varchar)
    print ' '

  /* REQ 217 AHORRO CONTRACTUAL - No. RANGOS A TRABAJAR */
    /* ADI: REQ 217 DATOS DE CUENTA - AHORRO CONTRACTUAL */
    if exists (select
                 1
               from   cob_remesas..re_cuenta_contractual
               where  cc_cta_banco = @w_cta_banco
                  and cc_prodbanc  = @w_prod_contractual
                  and cc_estado    = 'A')
      select
        @w_es_contractual = 'S',
        @w_cont_profinal = cc_profinal
      from   cob_remesas..re_cuenta_contractual
      where  cc_cta_banco = @w_cta_banco
         and cc_prodbanc  = @w_prod_contractual
         and cc_estado    = 'A'

    select
      @w_num_rango = isnull(cp_tipo_rango,
                            2)
    from   cob_remesas..pe_capitaliza_profinal
    where  cp_profinal            = @w_cont_profinal
       and cp_tipo_capitalizacion = @w_capitalizacion

    --Ajuste al interes causado
    select
      @w_tipo_atributo = tipo_atributo
    from   tempdb..pe_tipo_atributo
    where  filial       = @w_filial
       and sucursal     = @w_sucursal
       and producto     = @w_producto
       and moneda       = @w_moneda
       and pro_bancario = @w_prod_banc
       and tipo_cta     = @w_tipocta
       and servicio     = 'PINT'
       and rubro        = '18'

    if @@rowcount = 0
    begin
      select
        @w_error = 351504,
        @w_msg = 'NO SE ENCUENTRA TIPO DE ATRIBUTO tempdb..pe_tipo_atributo'
      goto ERROR
    end

    select
      @w_disponible = @w_disponible + @w_12h_neto,
      @w_valor_acreditar = 0

    if @w_tipo_atributo = 'A'
        or @w_tipo_atributo = 'E' /* Saldo Disponible o  Promedio Disponible */
    begin
      if datepart(mm,
                  @w_fecha_depo) <> datepart(mm,
                                             @w_fecha)
      begin
        select
          @w_cambiames = 'S',
          @w_primerdia = (convert(varchar(2), datepart(mm, @w_fecha)) + '/01/'
                          + convert(varchar(4), datepart(yy, @w_fecha)))
        select
          @w_diasmesant = datediff(dd,
                                   @w_fecha_depo,
                                   @w_primerdia),
          @w_diasmesact = datediff(dd,
                                   @w_primerdia,
                                   @w_fecha)
        select
          @w_sd_dias = @w_diasmesant
      end
      else
      begin
        select
          @w_cambiames = 'N'
        select
          @w_diasmesant = 0,
          @w_diasmesact = datediff(dd,
                                   @w_fecha_depo,
                                   @w_fecha)
        select
          @w_sd_dias = @w_diasmesact
      end

      truncate table #pint4

      insert into #pint4
        select
          *
        from   tempdb..pint4
        where  filial        = @w_filial
           and sucursal      = @w_sucursal
           and producto      = @w_producto
           and moneda        = @w_moneda
           and pro_bancario  = @w_prod_banc
           and tipo_ente     = @w_tipocta
           and servicio_dis  = 'PINT'
           and rubro         = '18'
           and tipo_atributo = @w_tipo_atributo
           and categoria     = @w_categoria

      select
        @w_fecha_calc = @w_fecha_depo

      while 1 = 1
      begin
        --Encuentra saldos dia de consignacion del cheque
        select
          @w_sd_saldo_disponible = sd_saldo_disponible,
          @w_sd_prom_disponible = sd_prom_disponible,
          @w_sd_int_hoy = sd_int_hoy,
          @w_tasa_disponible = sd_tasa_disponible -- ,
        -- @w_sd_dias             = sd_dias
        from   cob_ahorros_his..ah_saldo_diario
        where  sd_cuenta = @w_cuenta
           and sd_fecha  = @w_fecha_calc

        if @w_tipo_atributo = 'A' /* Saldo Disponible */
          select
            @w_monto = @w_sd_saldo_disponible + round(@w_12h_neto, @w_numdeci)
        else if @w_tipo_atributo = 'E' /* Promedio Disponible */
          select
            @w_monto = @w_sd_prom_disponible + round(@w_12h_neto * @w_alicuota,
                       @w_numdeci
                       )

        --Encuentra tasa de interes a aplicar

        /* DETERMINAR EL ULTIMO Y PENULTIMO RANGO ADEMAS LA MAXIMA TASA */
        select
          @w_ultimo_rango = max(rango)
        from   #pint4
        where  @w_monto between rango_desde and rango_hasta
        select
          @w_penultimo_rango = max(rango)
        from   #pint4
        where  rango < @w_ultimo_rango

        -- SE UBICA EL ULTIMO RANGO DE INTERES PARA DETERMINAR LA TASA
        select
          @w_rango_hasta = rango_hasta,
          @w_rango_desde = rango_desde
        from   #pint4
        where  rango = @w_ultimo_rango

        if @@rowcount = 0
        begin
          select
            @w_error = 351504,
            @w_msg = 'ERROR AL BUSCAR RANGO HASTA'
          goto ERROR
        end

        -- SE UBICA EL PENULTIMO RANGO DE INTERES PARA DETERMINAR LA TASA A LA QUE SE DEBE PAGAR
        -- SE UBICA EL PENULTIMO RANGO DE INTERES PARA DETERMINAR LA TASA A LA QUE SE DEBE PAGAR
        if @w_num_rango = 2 -- SOLO PARA PRODUCTOS CON DOS RANGOS
        begin
          select
            @w_pen_rango_hasta = rango_hasta
          from   #pint4
          where  rango = @w_penultimo_rango

          if @@rowcount = 0
          begin
            select
              @w_error = 351504,
              @w_msg = 'ERROR AL BUSCAR PENULTIMO RANGO HASTA'
            goto ERROR
          end

          if @w_pen_rango_hasta is null
            select
              @w_pen_rango_hasta = 0
        end
        else
          select
            @w_pen_rango_hasta = 0

        /* SI EL RANGO DESDE DEFINIDO ES MENOR QUE CERO SE SETEA EL VALOR EN CERO  */
        if @w_rango_desde < 0
          select
            @w_rango_desde = 0

        --NO EVALUAR CONTRA EL SALDO DESDE DEL ULTIMO RANGO SINO CONTRA EL SALDO HASTA DEL PENULTIMO RANGO
        if @w_pen_rango_hasta is null
          select
            @w_pen_rango_hasta = 0

        if @w_debug_int = 'S'
        begin
          select
            sd_dias,
            sd_prom_disponible,
            sd_promedio1,
            *
          from   cob_ahorros_his..ah_saldo_diario
          where  sd_cuenta = @w_cuenta
             and sd_fecha  = @w_fecha_depo

          print '===================================================='
          print 'diasmesant     : ' + convert(varchar, @w_diasmesant)
          print 'diasmesact     : ' + convert(varchar, @w_diasmesact)
          print 'alicuota       : ' + convert(varchar, @w_alicuota)
          print 'fecha_calc     : ' + convert(varchar, @w_fecha_calc)
          print 'rango desde    : ' + convert(varchar, @w_rango_desde)
          print 'rango hasta    : ' + convert(varchar, @w_rango_hasta)
          print 'rango pen_hasta: ' + convert(varchar, @w_pen_rango_hasta)
          print 'decimales      : ' + convert(varchar, @w_numdeci)
          print '===================================================='
        end

        select
          @w_tasa_interes = 0,
          @w_monto_ajuste = 0,
          @w_valor_acreditar = 0,
          @w_monto_interes1 = 0,
          @w_monto_interes2 = 0,
          @w_monto_interes = 0

        if @w_debug_int = 'S'
          print '@w_monto: ' + cast (@w_monto as varchar ) +
                ' @w_pen_rango_hasta: '
                + cast (@w_pen_rango_hasta as varchar)

        if @w_monto > @w_pen_rango_hasta
        begin
          select
            @w_monto_interes1 = @w_monto - @w_pen_rango_hasta
          -- lo que debe calcularse en el rango mas alto
          select
            @w_monto_interes2 = @w_pen_rango_hasta
        -- lo que debe calcularse en el rango que le toque
        end
        else
        begin
          select
            @w_monto_interes1 = 0 -- lo que debe calcularse en el rango mas alto
          select
            @w_monto_interes2 = @w_monto
        -- lo que debe calcularse en el rango que le toque
        end

        if @w_debug_int = 'S'
        begin
          print '@w_monto_interes1: ' + cast (@w_monto_interes1 as varchar) +
                ' @w_monto_interes2: '
                + cast (@w_monto_interes2 as varchar)
          print ' '
        end

        --Calcula interes

        if @w_monto_interes1 > 0
        begin
          select
            @w_rango_busqueda = @w_rango_hasta - 1

          select
            @w_tasa_interes = valor / 100
          from   #pint4
          where  rango_desde <= @w_rango_busqueda
             and rango_hasta > @w_rango_busqueda

          if @@rowcount <> 1
          begin
            print 'Procesando ...7 ERROR EN TABLA TMP DE PERSONALIZACION'
            select
              @w_error = 351504,
              @w_msg = 'ERROR EN TABLA TMP DE PERSONALIZACION'
            goto ERROR
          end

          select
            @w_valor_acreditar = 0,
            @w_factor1 = 0,
            @w_factor2 = 0,
            @w_factor = 0

          if (@w_tasa_interes <> 0)
          begin
            --Convierte a tasa nominal (diaria)
            select
              @w_factor1 = 1 + @w_tasa_interes
            select
              @w_factor2 = (convert(float, 1)) / @w_dias_anio
            /*calculo del factor para 1 dia */
            select
              @w_factor = (power (@w_factor1,
                                  @w_factor2)) - 1

            select
              @w_valor_acreditar = round((@w_monto_interes1 * @w_factor),
                                         @w_numdeci)
            select
              @w_valor_acreditar = @w_valor_acreditar * @w_sd_dias
          end
          if @w_debug_int = 'S'
          begin
            print 'monto interes 1'
            print '====> @w_tasa_interes    ' + cast(@w_tasa_interes as varchar)
            print '====> @w_factor1         ' + cast(@w_factor1 as varchar)
            print '====> @w_factor2         ' + cast(@w_factor2 as varchar)
            print '====> @w_factor          ' + cast(@w_factor as varchar)
            print '====> @w_sd_dias         ' + cast(@w_sd_dias as varchar)
            print '====> @w_valor_acreditar ' + cast(@w_valor_acreditar as
                  varchar
                  )
          end
        end -- fin monto interes 1

        select
          @w_monto_interes = isnull(@w_monto_interes, 0) + isnull(
                             @w_valor_acreditar,
                             0
                             )
        select
          @w_tasa_interes = 0,
          @w_valor_acreditar = 0

        if @w_monto_interes2 > 0
        begin
          if @w_monto_interes1 > 0
            -- debe buscar en el rango inferior al maximo el saldo
            select
              @w_rango_busqueda = @w_rango_desde - 1
          else
            -- no llego al rango maximo busca el monto total en el rango que le toca
            select
              @w_rango_busqueda = @w_monto_interes2

          select
            @w_tasa_interes = valor / 100
          from   #pint4
          where  rango_desde <= @w_rango_busqueda
             and rango_hasta > @w_rango_busqueda

          select
            @w_return = @@rowcount

          if @w_return <> 1
          begin
            print 'Procesando ...7 ERROR EN TABLA TMP DE PERSONALIZACION'
            select
              @w_error = 351551,
              @w_msg = 'Procesando ...7 ERROR EN TABLA TMP DE PERSONALIZACION'
            goto ERROR
          end

          if @w_return = 0
          begin
            if exists(select
                        1
                      from   #pint4)
               and @w_monto_interes1 = 0
            begin
              select
                @w_rango_busqueda = @w_monto_interes2 - 1
              --PCOELLO RESTARLE UNO PARA QUE CAIGA EN EL RANGO ANTERIOR

              select
                @w_tasa_interes = valor / 100
              from   #pint4
              where  rango_desde <= @w_rango_busqueda
                 and rango_hasta > @w_rango_busqueda

              if @@rowcount <> 1
              begin
                select
                  @w_error = 351551,
                  @w_msg =
                'Procesando ...4ERROR EN TABLA TMP DE PERSONALIZACION '
                + cast(@w_monto_interes1 as varchar) + ' ' + cast(
                @w_monto_interes2
                as
                varchar)
                goto ERROR
              end

            end
            else
            begin
              select
                @w_error = 351551,
                @w_msg =
              'Procesando ...4..ERROR NO EXISTE RANGO TABLA TMP DE PERS.'
              goto ERROR
            end
          end
          select
            @w_factor1 = 0,
            @w_factor2 = 0,
            @w_factor = 0

          if (@w_tasa_interes <> 0)
          begin --Convierte a tasa nominal (diaria)
            select
              @w_factor1 = 1 + @w_tasa_interes
            select
              @w_factor2 = (convert(float, 1)) / @w_dias_anio
            /*calculo del factor para 1 dia */
            select
              @w_factor = (power (@w_factor1,
                                  @w_factor2)) - 1
            select
              @w_valor_acreditar = round((@w_monto_interes2 * @w_factor),
                                         @w_numdeci)
            select
              @w_valor_acreditar = @w_valor_acreditar * @w_sd_dias
          end
          else if @w_debug_int = 'S'
          begin
            print 'monto interes 2'
            print '====> @w_tasa_interes    ' + cast(@w_tasa_interes as varchar)
            print '====> @w_factor1         ' + cast(@w_factor1 as varchar)
            print '====> @w_factor2         ' + cast(@w_factor2 as varchar)
            print '====> @w_factor          ' + cast(@w_factor as varchar)
            print '====> @w_sd_dias         ' + cast(@w_sd_dias as varchar)
            print '====> @w_valor_acreditar ' + cast(@w_valor_acreditar as
                  varchar
                  )
          end
          select
            @w_monto_interes = isnull(@w_monto_interes, 0) + isnull(
                               @w_valor_acreditar,
                               0
                               )
        end

        select
          @w_monto_interes = round(@w_monto_interes,
                                   @w_numdeci)

        --Graba transaccion de causacion
        if @w_debug_int = 'S'
          print '@w_monto_interes: ' + cast(@w_monto_interes as varchar) +
                                      ' @w_sd_int_hoy '
                + cast(@w_sd_int_hoy as varchar)

        select
          @w_monto_ajuste = @w_monto_interes - isnull(@w_sd_int_hoy,
                                                      0)
        select
          @w_monto_capi_act = @w_monto_ult_capi --*****

        --Calcula el promedio disponible
        if @w_cambiames = 'S' --INC 101457
          select
            @w_prom_disp = @w_prom_disp + round(@w_12h_neto, @w_numdeci)
        else
          select
            @w_prom_disp = @w_prom_disp + round(@w_12h_neto * @w_alicuota,
                           @w_numdeci)

        if @w_monto_ajuste > 0
        begin
          --Causacion Interes
          insert into cob_ahorros..ah_tran_servicio
                      (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,
                       ts_tsfecha,
                       ts_usuario,
                       ts_terminal,ts_oficina,ts_cod_alterno,ts_reentry,
                       ts_origen,
                       ts_cta_banco,ts_valor,ts_moneda,ts_oficina_cta,
                       ts_prod_banc
                       ,
                       ts_categoria,ts_tipocta_super,
                       ts_clase_clte,ts_cliente,
                       ts_fec_marca_gmf,
                       ts_saldo,ts_interes,ts_monto,ts_default,ts_tasa)
          values      ( @w_ssn,@w_ssn,271,@w_fecha,'op_batch',
                        'efectiviza',@w_oficina,@w_procesadas,'N','U',
                        @w_cta_banco,@w_monto_ajuste,@w_moneda,@w_oficina,
                        @w_prod_banc
                        ,
                        @w_categoria,@w_tipocta_super,@w_clase_clte
                        ,@w_cliente,
                        @w_fecha_calc,
                        @w_monto_interes,@w_monto_interes1,@w_monto_interes2,
                        @w_sd_dias,
                        @w_tasa_interes)

          if @@error <> 0
          begin
            select
              @w_error = 0,
              @w_msg =
            'Procesando ...26 ERROR AL INSERTAR TRANSACCION DE SERVICIO'
            goto ERROR
          end
          print ' Transaccion de servicio 271 '
          print ''
          select
            @w_procesadas = @w_procesadas + 1
          --Capitalizacion del interes en caso de ser necesario
          if @w_cambiames = 'S'
          begin
            if (@w_es_contractual = 'S'
                and @w_categoria <> @w_camcat)
            begin
              update cob_remesas..re_cuenta_contractual with(rowlock)
              set    cc_intereses = cc_intereses + isnull(@w_monto_ajuste, 0)
              where  cc_cta_banco = @w_cta_banco
                 and cc_estado    = 'A'
            end

            if @w_estado = 'A'
              select
                @w_trn_code = 221
            else
              select
                @w_trn_code = 304

            select
              @w_disponible = @w_disponible + @w_monto_ajuste,
              @w_contable = @w_contable + @w_monto_ajuste,
              @w_prom_disp = @w_prom_disp + @w_monto_ajuste,
              @w_promedio1 = @w_promedio1 + @w_monto_ajuste,
              @w_monto_capi_act = @w_monto_capi_act + @w_monto_ajuste

            insert into ah_notcredeb
                        (secuencial,ssn_branch,alterno,tipo_tran,oficina,
                         usuario,terminal,correccion,reentry,origen,
                         fecha,cta_banco,signo,indicador,moneda,
                         valor,saldocont,saldodisp,oficina_cta,filial,
                         prod_banc,categoria,monto_imp,tipo_exonerado,hora,
                         tipocta_super,canal,cliente,clase_clte)
            values      ( @w_ssn,@w_ssn,@w_alt,@w_trn_code,@w_oficina,
                          'op_batch','efectiviza','N','N','L',
                          @w_fecha,@w_cta_banco,'C',1,@w_moneda,
                          @w_monto_ajuste,@w_contable,@w_disponible,@w_oficina,
                          @w_filial
                          ,
                          @w_prod_banc,@w_categoria,null,null,getdate
                          (),
                          @w_tipocta_super,4,@w_cliente,@w_clase_clte)

            if @@error <> 0
            begin
              select
                @w_error = 255004,
                @w_msg = 'ERROR AL INSERTAR LA NOTA DE DEBITO (1)'
              goto ERROR
            end
            select
              @w_alt = @w_alt + 1
            print ' Insercion en ah_notcredeb ' + cast (@w_trn_code as varchar)

            --Verificacion ajuste sobre retencion en la fuente
            select
              @w_dias_periodo = pe_num_dias
            from   cob_ahorros..ah_periodo
            where  pe_capitalizacion = @w_capitalizacion
               and pe_periodo        = datepart(mm,
                                                @w_fecha_ult_cap)

            if @w_debug = 'S'
            begin
              print ''
              print '@w_binc ' + cast(@w_binc as varchar) + ' @w_dias_periodo '
                    + cast(@w_dias_periodo as varchar) + ' @w_cpto_rte ' +
                    isnull(
                    @w_cpto_rte
                               , '')
                    + ' @w_monto_capi_act ' + cast(@w_monto_capi_act as varchar)
            end

            if @w_dias_cta = 0
              select
                @w_dias_cta = 1

            if @w_dias_cta < @w_dias_periodo
              select
                @w_dias_periodo = @w_dias_cta

            select
              @w_base_rtfte = @w_dias_periodo * @w_binc

            if @w_debug = 'S'
            begin
              print ''
              print '@w_dias_cta ' + cast(@w_dias_cta as varchar) +
                    ' @w_base_rtfte '
                    + cast(@w_base_rtfte as varchar) + ' @w_monto_capi_act '
                    + cast(@w_monto_capi_act as varchar)
            end

            if @w_cpto_rte is not null
               and @w_monto_capi_act >= @w_base_rtfte
            begin
              --Calculo tasa retefuente - interfaz con contabilidad en variable @w_tasa_impuesto
              exec @w_error = cob_interfase..sp_icon_impuestos
                @i_empresa      = @w_filial,
                @i_concepto     = @w_cpto_rte,
                @i_debcred      = 'D',
                @i_monto        = @w_monto_capi_act,
                @i_impuesto     = 'R',--Verificar nemonico tipo de impuesto
                @i_oforig_admin = @w_oficina,
                @i_ofdest_admin = @w_oficina,
                @i_ente         = @w_cliente,
                @i_producto     = 4,
                @o_exento       = @w_exento out,
                @o_porcentaje   = @w_porcentaje out

              if @w_error <> 0
              begin
                select
                  @w_msg =
                'ERROR INTERFAZ sp_icon_impuestos - CALCULO DE RETENCION'
                goto ERROR
              end

              if @w_exento = 'N'
                select
                  @w_tasa_impuesto = (@w_porcentaje / 100)
              else
                select
                  @w_tasa_impuesto = 0

              select
                @w_valor_impuesto = 0

              if @w_tasa_impuesto > 0
              begin
                if @w_monto_ult_capi >= @w_base_rtfte
                  select
                    @w_valor_impuesto = round((
                    @w_monto_ult_capi * @w_tasa_impuesto)
                                        ,
                                              @w_numdeci_imp),
                    @w_base_rtfte = @w_monto_ult_capi
                else
                  select
                    @w_base_rtfte = 0

                select
                  @w_valor_impuesto = round((
                  @w_monto_capi_act * @w_tasa_impuesto)
                                      ,
                                            @w_numdeci_imp) - @w_valor_impuesto,
                  @w_base_rtfte = @w_monto_capi_act - @w_base_rtfte

              end
              else
                select
                  @w_valor_impuesto = 0

              if @w_debug = 'S'
              begin
                print ''
                print '@w_exento ' + @w_exento + ' @w_tasa_impuesto ' + cast(
                      @w_tasa_impuesto
                      as
                                 varchar)
                      + ' @w_valor_impuesto ' + cast(@w_porcentaje as varchar)
              end

              if @w_valor_impuesto > 0
              begin
                /**** Manejo del disponible y contable restando solo el impuesto de retencion ****/
                if @w_debug = 'S'
                begin
                  print 'SALDO DISPONIBLE RETENCION ' + cast(@w_disponible as
                        varchar)
                        +
                        ' Valor imp '
                        + cast (@w_valor_impuesto as varchar) + ' gmf ' + cast (
                        @w_gmf
                        as
                        varchar
                        )
                  print 'ANTES RECALCULO @w_prom_disp ' + cast(@w_prom_disp as
                        varchar
                        )
                        +
                                  ' @w_promedio1 '
                        + cast(@w_promedio1 as varchar)
                end

                --Calculo de cliente exonerado GMF
                select
                  @w_gmf = 0,
                  @w_base_gmf = 0,
                  @w_gmf_reintegro = 0

                if @w_codigo_pais = 'CO' -- Colombia
                begin
                  exec @w_return = cob_ahorros..sp_calcula_gmf
                    @s_date            = @i_fecha,
                    @i_cuenta          = @w_cuenta,
                    @i_cta             = @w_cta_banco,
                    @i_operacion       = 'Q',
                    @i_val             = @w_valor_impuesto,
                    @i_is_batch        = 'S',
                    @i_cliente         = @w_cliente,
                    @o_total_gmf       = @w_gmf out,
                    @o_acumu_deb       = @w_acumu_deb out,
                    @o_base_gmf        = @w_base_gmf out,
                    @o_actualiza       = @w_actualiza out,
                    @o_tasa_reintegro  = @w_tasa_reintegro out,--JCO
                    @o_valor_reintegro = @w_gmf_reintegro out -- JCO

                  if @w_return <> 0
                  begin
                    select
                      @w_msg = 'ERROR Calculando BASE GMF'
                    goto ERROR
                  end
                  print ' Valor de @w_acumu_deb :' + cast( @w_acumu_deb as
                        varchar
                        )
                  print ' Valor DE reintegro : ' + cast( @w_gmf_reintegro as
                        varchar
                        )

                  -- Actualiza acumulados topes gmf
                  if @w_actualiza = 'S'
                     and isnull(@w_acumu_deb,
                                0) <> 0
                  begin
                    exec @w_error = sp_calcula_gmf
                      @s_date      = @i_fecha,
                      @i_cuenta    = @w_cuenta,
                      @i_producto  = @w_producto,
                      @i_is_batch  = 'S',
                      @i_operacion = 'U',
                      @i_acum_deb  = @w_acumu_deb

                    if @w_error <> 0
                    begin
                      select
                        @w_msg = 'ERROR ACTUALIZANDO BASE GMF'
                      goto ERROR
                    end
                  end
                end

                if @w_debug = 'S'
                  print 'Valor dela Retencion ' + cast ( @w_valor_impuesto as
                        varchar)
                        +
                                                ' Valor del gmf: '
                        + cast (@w_gmf as varchar)

                select
                  @w_disponible = @w_disponible - (@w_valor_impuesto + @w_gmf),
                  @w_contable = @w_contable - (@w_valor_impuesto + @w_gmf),
                  @w_prom_disp = @w_prom_disp - (@w_valor_impuesto + @w_gmf),
                  @w_promedio1 = @w_promedio1 - (@w_valor_impuesto + @w_gmf)

                if @w_debug = 'S'
                  print 'DESPUES RECALCULO @w_prom_disp ' + cast(@w_prom_disp as
                        varchar
                        )
                        +
                  ' @w_promedio1 '
                  + cast(@w_promedio1 as varchar)

                if @w_estado = 'I'
                  select
                    @w_trn_code = 309
                else
                  select
                    @w_trn_code = 308

                -- Inserta transaccion monetaria de retencion en la fuente
                insert into ah_notcredeb
                            (secuencial,ssn_branch,alterno,tipo_tran,oficina,
                             usuario,terminal,correccion,reentry,origen,
                             fecha,cta_banco,signo,indicador,canal,
                             moneda,interes,valor,val_cheque,saldocont,
                             saldodisp,oficina_cta,filial,prod_banc,categoria,
                             monto_imp,hora,tipocta_super,cliente,base_gmf,
                             clase_clte)
                values      ( @w_ssn,@w_ssn,@w_alt,@w_trn_code,@w_oficina,
                              'op_batch','efectiviza','N','N','L',
                              @w_fecha,@w_cta_banco,'D',1,4,
                              @w_moneda,@w_base_rtfte,@w_valor_impuesto,
                              @w_tasa_impuesto
                              ,
                              @w_contable,
                              @w_disponible,@w_oficina,@w_filial,@w_prod_banc,
                              @w_categoria
                              ,
                              @w_gmf,getdate(),@w_tipocta_super,
                              @w_cliente,@w_base_gmf,
                              @w_clase_clte)

                if @@error <> 0
                begin
                  select
                    @w_error = 0,
                    @w_msg =
                  'ERROR EN INSERCION DE TRANSACCION MONETARIA RETENCION'
                  goto ERROR
                end
                print ' Transaccion....:' + cast(@w_trn_code as varchar)
                print ''
                select
                  @w_alt = @w_alt + 1

                if @w_gmf_reintegro > 0
                begin
                  select
                    @w_disponible = @w_disponible + @w_gmf_reintegro,
                    @w_contable = @w_contable + @w_gmf_reintegro,
                    @w_prom_disp = @w_prom_disp + @w_gmf_reintegro,
                    @w_promedio1 = @w_promedio1 + @w_gmf_reintegro

                  insert into ah_notcredeb
                              (secuencial,ssn_branch,alterno,tipo_tran,oficina,
                               usuario,terminal,correccion,reentry,origen,
                               fecha,cta_banco,signo,indicador,canal,
                               moneda,valor,saldocont,causa,saldodisp,
                               oficina_cta,filial,prod_banc,categoria,hora,
                               tipocta_super,cliente,base_gmf,clase_clte)
                  values      ( @w_ssn,@w_ssn,@w_alt,253,@w_oficina,
                                'op_batch','efectiviza','N','N','L',
                                @w_fecha,@w_cta_banco,'C',1,4,
                                @w_moneda,@w_gmf_reintegro,@w_contable,'20',
                                @w_disponible,
                                @w_oficina,@w_filial,@w_prod_banc,@w_categoria,
                                getdate
                                (
                                ),
                                @w_tipocta_super,@w_cliente,@w_gmf,@w_clase_clte
                  )

                  if @@error <> 0
                  begin
                    select
                      @w_error = 0,
                      @w_msg =
          'ERROR EN INSERCION DE TRANSACCION MONETARIA REINTEGRO de GMF'
          goto ERROR
                  end

                  select
                    @w_alt = @w_alt + 1
                end

              end --@w_valor_impuesto > 0
            end
          --if @w_cpto_rte is not null and @w_monto_capi_act >= @w_base_rtfte
          end -- @w_fecha_ult_cap = @w_fecha_calc
          else
          begin
            select
              @w_saldo_interes = @w_saldo_interes + @w_monto_ajuste
          end

          -- Calculo de la tasa aplicada en base al valor de interes obtenido en los pasos anteriores
          if ((@w_sd_dias <> 0)
              and (@w_monto_interes <> 0)
              and (@w_monto <> 0))
            select
              @w_tasa_disponible = (
                                              (convert(real, @w_monto_interes) /
                                               convert(real, @w_sd_dias)) /
                                              convert(real, @w_monto)
                                   )
                                   *
                                   convert(real, @w_dias_anio)

          select
            @w_tasa_disponible = round((isnull(@w_tasa_disponible,
                                               0) * 100),
                                       @w_numdeci)

          if @w_debug = 'S'
          begin
            print ' '
            print ' =====> Ajuste al interes: ' + cast(@w_monto_ajuste as
                  varchar)
          end
        end

        if @w_diasmesact > 0
           and @w_cambiames = 'S'
        begin
          select
            @w_fecha_calc = @w_primerdia,
            @w_alicuota = 1,
            @w_cambiames = 'N',
            @w_sd_dias = @w_diasmesact
        end
        else
          break

      --update cob_ahorros_his..ah_saldo_diario set
      --sd_saldo_disponible = @w_disponible,
      --sd_prom_disponible  = @w_prom_disp,
      --sd_int_hoy          = sd_int_hoy + @w_monto_ajuste,
      --sd_tasa_disponible  = @w_tasa_disponible
      --where  sd_cuenta = @w_cuenta
      --and    sd_fecha  = @w_fecha_calc
      --
      --if @@rowcount <> 1 or @@error <> 0
      --begin
      --   select
      --   @w_error = 0,
      --   @w_msg   = 'ERROR EN ACTUALIZACION DE SALDOS HISTORICOS DE LA CUENTA'
      --   goto ERROR
      --end /* Fin Error actualizacion*/
      end -- while 1=1
    end --@w_tipo_atributo = 'A' or @w_tipo_atributo = 'E'

    print ' Actualizo Datos'

    /* Actualizacion de los valores en retencion diaria */
    update cob_ahorros..ah_cuenta
    set    ah_disponible = @w_disponible,
           ah_12h = @w_12h,
           ah_12h_dif = 0,
           ah_prom_disponible = @w_prom_disp,
           ah_saldo_interes = @w_saldo_interes,
           ah_monto_ult_capi = @w_monto_capi_act,
           ah_int_hoy = ah_int_hoy + @w_monto_ajuste,
           ah_tasa_hoy = @w_tasa_disponible
    where  ah_cta_banco = @w_cta_banco

    if @@rowcount <> 1
        or @@error <> 0
    begin
      select
        @w_error = 0,
        @w_msg = 'ERROR EN ACTUALIZACION DE CUENTA'
      goto ERROR
    end /* Fin Error actualizacion*/

    update cob_ahorros..ah_ciudad_deposito
    set    cd_efectivizado = 'C',
           cd_valor_efe = cd_valor_efe - @w_12h_neto
    where  cd_cuenta       = @w_cuenta
       and cd_fecha_efe    = @i_fecha
       and cd_fecha_depo   = @w_fecha_depo
       and cd_efectivizado = 'S'
       and cd_ciudad       = @w_ciudad

    if @@error <> 0
    begin
      select
        @w_error = 0,
        @w_msg = 'ERROR EN ACTUALIZACION DE CIUDAD DEPOSITO'
      goto ERROR
    end /* Fin Error actualizacion*/

    select
      @w_procesadas = @w_procesadas + 1

    --Insercion transaccion de servicio por efectivizacion
    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_cod_alterno,ts_tipo_transaccion,
                 ts_tsfecha,
                 ts_usuario,ts_terminal,ts_oficina,ts_reentry,ts_origen,
                 ts_cta_banco,ts_valor,ts_saldo,ts_moneda,ts_oficina_cta,
                 ts_prod_banc,ts_categoria,ts_tipocta_super,ts_clase_clte,
                 ts_cliente
                 ,
                 ts_fecha_uso,ts_tasa)
    values      ( @w_ssn,@w_ssn,@w_procesadas,219,@w_fecha,
                  'op_batch','consola',@w_oficina,'N','U',
                  @w_cta_banco,@w_12h_neto,@w_monto_ajuste,@w_moneda,@w_oficina,
                  @w_prod_banc,@w_categoria,@w_tipocta_super,@w_clase_clte,
                  @w_cliente,
                  @w_fecha_depo,@w_alicuota)

    if @w_debug = 'S'
    begin
      print ''
      print 'DESPUES'
      select
        cd_efectivizado,
        cd_valor_efe,
        cd_valor,
        cd_cuenta,
        cd_fecha_efe,
        cd_ciudad
      from   cob_ahorros..ah_ciudad_deposito
      where  cd_cuenta    = @w_cuenta
         and cd_fecha_efe = @i_fecha
         and cd_ciudad    = @w_ciudad

      select
        ah_cta_banco,
        ah_disponible,
        ah_12h,
        ah_12h_dif,
        ah_24h,
        ah_prom_disponible,
        ah_saldo_interes,
        ah_int_hoy,
        ah_tasa_hoy,
        ah_monto_ult_capi
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_cta_banco

      select
        *
      from   cob_ahorros_his..ah_saldo_diario
      where  sd_cuenta = @w_cuenta
         and sd_fecha  = @w_fecha_depo

      select
        tm_cta_banco,
        tm_tipo_tran,
        tm_valor,
        tm_monto_imp,
        tm_interes,
        tm_base_gmf,
        tm_saldo_contable,
        tm_saldo_disponible
      from   cob_ahorros..ah_tran_monet
      where  tm_cta_banco = @w_cta_banco
         and tm_tipo_tran in (221, 304, 308, 309, 334)
      order  by tm_fecha

      select
        ts_tipo_transaccion,
        ts_cta_banco,
        ts_valor,
        ts_saldo,
        ts_moneda,
        ts_oficina_cta,
        ts_prod_banc,
        ts_tsfecha,
        ts_categoria,
        ts_tipocta_super,
        ts_clase_clte,
        ts_cliente,
        ts_fecha_uso,
        ts_tasa
      from   cob_ahorros..ah_tran_servicio
      where  ts_cta_banco = @w_cta_banco
         and ts_tipo_transaccion in (219, 271)
      order  by ts_tsfecha

      print ' ========================== FIN CUENTA ' + @w_cta_banco +
                                   ' ========================'
      print ''
      rollback
    end
    else
      commit tran

    goto LEER

    ERROR:
    print '---MENSAJE DE ERROR---'
    print @w_msg
    print '----------------------'
    rollback tran
    exec sp_errorlog
      @i_fecha       = @w_fecha,
      @i_error       = @w_error,
      @i_usuario     = 'batch',
      @i_tran        = 219,
      @i_cuenta      = @w_cta_banco,
      @i_descripcion = @w_msg,
      @i_programa    = @w_sp_name

    LEER:
    print '___________________________________'
    /* Localizar el siguiente registro de cuenta sobregirada ocasionalmente */
    fetch update_to_date_batch into @w_cuenta, @w_fecha_depo, @w_vlr_canje,
                                    @w_ciudad
  end

  /* CLE Control de fecha para evitar doble ejecucion */
  update cob_remesas..re_fecha_ejecucion
  set    fe_fecha = @i_fecha
  where  fe_producto = 4

  if @@rowcount <> 1
  begin
    insert cob_cuentas..re_error_batch
    values ('0','ERROR EN LA ACTUALIZACION DE FECHA DE EJECUCION')
  end

  /* Cerrar y liberar cursor */
  close update_to_date_batch
  deallocate update_to_date_batch
  select
    @o_procesadas = @w_procesadas

  return 0
  ERRORFIN:
  exec cobis..sp_cerror
    @i_num = @w_error,
    @i_msg = @w_msg
  return @w_error

go

