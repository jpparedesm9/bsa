/************************************************************************/
/*      Archivo:                ahmenfest.sp                             */
/*      Stored procedure:       sp_ahmensual_festivo                    */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Disenado por:           M. Bayas/J. Navarrete/X. Bucheli        */
/*      Fecha de escritura:     12-Ene-1993                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza las transacciones de:                     */
/*      Devolucion IDB                                                  */
/*      Calcula interes                                                 */
/*      Capitaliza                                                      */
/*      Almacena datos para reportes varios                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA       AUTOR           RAZON                                   */
/*  02/May/2016   Javier Calderon Migración a CEN                         */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahmensual_festivo')
  drop proc sp_ahmensual_festivo
go

create proc sp_ahmensual_festivo
(
  @i_param1       varchar(10) = null,--> filial
  @i_param2       varchar(10) = null,--> fecha
  @i_param3       varchar(10) = null,--> hijo
  @i_param4       varchar(10) = null,--> nro de hijos
  @s_rol          smallint = null,
  @t_show_version bit = 0,
  @i_fecha        smalldatetime = null,
  @i_srv          varchar(64) = null,
  @i_filial       tinyint = null,
  @i_sec          tinyint = 1,
  @i_turno        smallint = null,
  @i_canal        smallint = 4,
  @i_cuenta       cuenta = null,
  @i_corresponsal char(1) = 'N',--Req. 381 CB Red Posicionada
  @o_procesadas   int = null out
)
as
  declare
    @w_return               int,
    @w_cuenta               int,
    @w_moneda               tinyint,
    @w_cta_banco            cuenta,
    @w_disponible           money,
    @w_promedio1            money,
    @w_disponible_imp       money,
    @w_promedio1_imp        money,
    @w_filial               tinyint,
    @w_oficina              smallint,
    @w_categoria            char(1),
    @w_rol_ente             char(1),
    @w_tipo_def             char(1),
    @w_prod_banc            smallint,
    @w_producto             smallint,
    @w_tipo                 char(1),
    @w_default              int,
    @w_contable             money,
    @w_prom_disponible      money,
    @w_contable_imp         money,
    @w_prom_disponible_imp  money,
    @w_ssn                  int,
    @w_clase_clte           char(1),
    @w_tipocta              char(1),
    @w_personalizada        char(1),
    @w_usadeci              char(1),
    @w_numdeci              tinyint,
    @w_numdeci_imp          tinyint,
    @w_12h                  money,
    @w_24h                  money,
    @w_48h                  money,
    @w_remesas              money,
    @w_saldo_interes        money,
    @w_int_mes              money,
    @w_int_mes_ant          money,
    @w_valor_acreditar      money,
    @w_tasa_interes         real,
    @w_tasa_maxima          real,
    @w_dias_anio            smallint,
    @w_fecha                datetime,
    @w_ciudad               int,
    @w_sucursal             smallint,
    @w_dias                 tinyint,
    @w_num_dias             tinyint,
    @w_bco                  tinyint,
    @w_tipo_atributo        char(1),
    @w_monto                money,
    @w_int_hoy              money,
    @w_fecha_ult_ret        datetime,
    @w_dif_dias             smallint,
    @w_min_dispmes          money,
    @w_mes_dif              smallint,
    @w_fecha_aper           datetime,
    @w_actualiza            char(1),
    @w_tasa_hoy             real,
    @w_dias_mes             tinyint,
    @w_auxiliar             varchar(10),
    @w_tipo_promedio        char(1),
    @w_estado               char(1),
    @w_nombre               char(60),
    @w_saldo_ayer           money,
    @w_fecha_ult_mov        datetime,
    @w_fecha_ult_mov_int    datetime,
    @w_saldo_rep1           money,
    @w_saldo_rep2           money,
    @w_saldo_rep3           money,
    @w_sld_rep1             money,
    @w_sld_rep2             money,
    @w_sld_rep3             money,
    @w_val_absoluto         money,
    @w_sec                  tinyint,
    @w_alicuota             float,
    @w_saldo_mayor          char(1),
    @w_creditos_hoy         money,
    @w_debitos_hoy          money,
    @w_trn                  int,
    @w_valor_cobrar         real,
    @w_sp_name              descripcion,
    @w_causa                varchar(3),
    @w_girar                money,
    @w_bloqueos             money,
    @w_tasa_imp             float,
    @w_tasa_imp_gral        float,
    @w_cambia_mes           char(1),
    @w_ini_prx_mes          datetime,
    @w_dias_mes_act         tinyint,
    @w_dias_prx_mes         tinyint,
    @w_control              int,
    @w_lp_sec               int,
    @w_sec_vs               int,
    @w_tinm                 tinyint,
    @w_debitos              money,
    @w_creditos             money,
    @w_monto_imp            money,
    @w_imp1                 money,
    @w_imp2                 money,
    @w_suspensos            smallint,
    @w_lineas               smallint,
    @w_contador_trx         int,
    @w_fecha_ult_capi       datetime,
    @w_cta_funcionario      char(1),
    @w_cliente              int,
    @w_valor_impuesto       money,
    @w_total_interes        money,
    @w_trn_code             int,
    @w_calculo_int          char(1),
    @w_tasa_impuesto        float,
    @w_tasa_imp_usado       float,
    @w_promedio2            money,
    @w_val_efe              money,
    @w_val                  money,
    @w_val2                 money,
    @w_accion               char(1),
    @w_alic                 money,
    @w_anio                 smallint,
    @w_mes                  tinyint,
    @w_tipo_exonerado_imp   char(2),
    @w_retencion            char(1),
    @w_cta                  cuenta,
    @w_lote                 int,
    @w_dev_idb              char(1),
    @w_error                int,
    @w_compra               money,
    @w_nomtrn               varchar(10),
    @w_hora                 datetime,
    @w_tcapitalizacion      char (1),
    @w_fecha_prx_capita     datetime,
    @w_ult_dia_mes          datetime,
    @w_corte_mes            datetime,
    @w_tipocta_super        char(1),
    @w_meses_prx_capita     integer,
    @w_fecha_hoy            datetime,
    @w_aplica_tasacorp      char(1),
    @w_monto_ult_capi       money,
    @w_moneda_local         tinyint,
    @w_moneda_dolar         tinyint,
    @w_saldo_mantval        money,
    @w_cot_hoy              float,
    @w_cot_hoy_aux          float,
    @w_cot_sig              float,
    @w_cot_sig_aux          float,
    @w_fecha_aux            datetime,
    @w_rubro                char(10),
    @w_impuesto             char(1),
    @w_promedio             money,
    @w_saldo_interes_tot    money,
    @w_tasa_ayer            real,
    @w_binc                 money,
    -- 14/01/2010 Para Base diaria de interes para calculo de retencion
    @w_numdecipar           tinyint,
    @w_contador_tasas       int,
    @w_flag_tasas           int,
    @w_monto_interes        money,
    @w_rango_hasta          money,
    @w_rango_busqueda       money,
    @w_monto_calculo        money,
    @w_monto_total          money,
    @w_tasa_interes_acum    float,
    @w_rango_hasta_ant      money,
    @w_procesado_ok         tinyint,
    @w_rango_intervalo      money,
    @w_rango_desde          money,
    @w_fecha_ini_mes        datetime,
    @w_ultimo_rango         int,
    @w_monto_interes1       money,
    @w_monto_interes2       money,
    @w_penultimo_rango      int,
    --PCOELLO OBTENER EL PENULTIMO RANGO PARA VER CUANTO ES EL MONTO HASTA
    @w_pen_rango_hasta      money,
    --PCOELLO PENULTIMO RANGO HASTA YA QUE LO MAYOR A ESTO SE DEBE CALCULAR 
    --A LA TASA DEL ULTIMO RANGO
    @w_codigo_pais          char(2),
    @w_cpto_rte             char(4),
    @w_cpto_rteica          char(4),
    @w_acumu_deb            money,
    @w_acumu_deb_total      money,
    @w_base                 money,
    @w_base_gmf             money,
    @w_total_gmf            money,
    @w_base_gmf_imp         money,
    @w_gmf_impuesto         money,
    @w_base_gmf_ica         money,
    @w_gmf_reteica          money,
    @w_base_rtfte           money,
    @w_porcentaje           float,
    @w_tasa_reteica         float,
    @w_valor_reteica        money,
    @w_min_rtfte            money,
    @w_dias_capi            smallint,
    @w_fechaux              datetime,
    @w_inimes               char(1),
    @w_fechain              datetime,
    @w_exento               char(1),
    @w_fecha_ini            datetime,--JAR 14/01/2010
    @w_ciudad_rte_ica       int,
    @w_anios                int,
    @w_seccta               cuenta,
    @w_cursor               char(1),
    @w_msg                  varchar(255),
    @w_factor               float,
    @w_factor1              float,
    @w_factor2              float,
    @w_cant_sec             int,
    @w_posteo               char(1),
    @w_pro_final            smallint,
    @w_tasagmf              float,
    @w_gmfbco               money,
    @w_clase_clte_b         char(1),
    @w_siguiente_dia        datetime,
    @w_commit               char(1),
    @w_hijos                int,
    @w_hijo                 int,
    @w_orden                int,
    @w_filial_2             int,
    @w_oficina_2            int,
    @w_moneda_2             int,
    @w_producto_2           int,
    @w_prod_banc_2          int,
    @w_tipocta_2            char(1),
    @w_categoria_2          char(1),
    @w_debug                char(1),
    -- REQ 217 AHORRO CONTRACTUAL
    @w_cont_modulo          tinyint,
    @w_cont_profinal        tinyint,
    @w_cont_cta_banco       varchar(24),
    @w_cont_plazo           tinyint,
    @w_cont_cuota           money,
    @w_cont_periodicidad    varchar(10),
    @w_cont_monto_final     money,
    @w_cont_intereses       money,
    @w_cont_ptos_premio     float,
    @w_cont_estado          char(1),
    @w_cont_categoria       char(1),
    @w_cont_fecha_crea      datetime,
    @w_cont_periodos_incump tinyint,
    @w_es_contractual       char(1),
    @w_fecha_ult_cuo        datetime,
    @w_cuotas_contractual   tinyint,
    @w_saldo_mes            money,
    @w_meses                int,
    @w_disponible_esp       money,
    @w_num_rango            tinyint,
    @w_prod_contractual     int,
    @w_disp_mes_ant         money,
    @w_fecha_saldo_ant      datetime,
    @w_camcat               char(1),
    @w_ajuste               money,
    @w_incumple_saldo       char(1),
    @w_dias_intereses       tinyint,
    @w_primerdia            datetime,
    @w_dia1mes              datetime,
    @w_prod_bancario        varchar(50) --Req. 381 CB Red Posicionada

  /* INICIALIZAR VARIABLES DE TRABAJO */
  select
    @w_sp_name = 'sp_ahmensual_festivo',
    @w_lote = 3000,
    @w_nomtrn = 'REGISTRO',
    @w_cambia_mes = 'N',
    @w_cursor = 'N',
    @w_trn_code = 0,
    @w_gmfbco = 0,
    @w_saldo_interes_tot = 0,
    @w_hijo = convert(int, @i_param3),
    @w_hijos = convert(int, @i_param4),
    @w_inimes = 'N',
    @w_cpto_rte = null,
    @w_cpto_rteica = null,
    @w_commit = 'N',
    @w_debug = 'S',
    @w_es_contractual = 'N' --ADI REQ 217 AHORRO CONTRACTUAL

  select
    @w_sp_name = 'sp_ahmensual_festivo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  if @i_param2 is not null
  begin
    select
      @s_rol = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'ROB'
       and pa_producto = 'ADM'

    if @s_rol is null
      select
        @s_rol = 1

    select
      @i_srv = nl_nombre,
      @i_sec = 0,
      @i_canal = 4
    from   cobis..ad_nodo_oficina
    where  nl_nodo = 1

    select
      @i_filial = convert(tinyint, @i_param1),
      @i_fecha = convert(smalldatetime, @i_param2)
  end

  select
    @w_fechain = dateadd(dd,
                         1 - datepart(dd,
                                      @i_fecha),
                         @i_fecha) --inicio del mes actual

  print 'INICIA PROC BATCH'
  /* DETERMINAR EL PAIS DONDE SE ESTA EJECUTANDO EL PROCESO */
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

  /* DETERMINAR EL BANCO DONDE SE ESTA EJECUTANDO EL PROCESO */
  select
    @w_bco = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CBCO'

  if @@rowcount <> 1
  begin
    select
      @w_error = 111020,
      @w_msg =
    'NO SE ENCUENTRA EL PARAMETRO GENERAL CBCO DE CUENTAS CORRIENTES '
    goto ERRORFIN
  end

  /*GRAVAMEN A LOS MOVIMIENTOS FINANCIEROS (SOLO PARA COLOMBIA) */
  select
    @w_tasagmf = pa_float
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'IGMF'

  if @@rowcount = 0
  begin
    select
      @w_error = 201196,
      @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL IGMF DE CUENTAS AHORROS '
    goto ERRORFIN
  end

  /* DETERMINAR LA CIUDAD DE LOS FERIADOS NACIONALES */
  select
    @w_ciudad = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO DE CIUDAD DE FERIADOS NACIONALES'
    goto ERRORFIN
  end

  if exists (select
               1
             from   cobis..cl_dias_feriados
             where  df_fecha  = @i_fecha
                and df_ciudad = @w_ciudad)
  begin
    select
      @w_error = 205031,
      @w_msg = 'ESTE PROCESO NO SE PUEDE EJECUTAR EN FERIADOS NACIONALES'
    goto ERRORFIN
  end

  /************************************************************************/
  select
    @w_primerdia = dateadd(dd,
                           1 - datepart(dd,
                                        @i_fecha),
                           @i_fecha)
  select
    @w_dia1mes = @w_primerdia

  select
    @w_primerdia

  if @w_primerdia = @i_fecha
  begin
    print ' Hoy es primero del mes y no debo hacer nada'
    print ' Parametro de fecha ' + cast ( @i_fecha as varchar)
    print ' Primer dia habil del mes ' + cast ( @w_primerdia as varchar)
    return 0
  end
  else
  begin
    /** Busco el primer dia laborable del mes  *****/
    while exists(select
                   1
                 from   cobis..cl_dias_feriados
                 where  df_ciudad = @w_ciudad
                    and df_fecha  = @w_primerdia)
    begin
      select
        @w_primerdia = dateadd(dd,
                               1,
                               @w_primerdia)
    end

  --* if @w_fechaux = @i_fecha select @w_inimes = 'S'

  end

  /*** Si el primer dia habil del mes es igual a la fecha que se esta procesando  debo calcular los intereses de los dias  ***/
  if @w_primerdia = @i_fecha
  begin
    /** Debo calcular el numero de dias a los cuales le debo pagar los intereses  ***/
    print ' Debo Generar los Calculos del primer dia laborable'
    select
      @w_dias_intereses = datediff (dd,
                                    @w_dia1mes,
                                    @i_fecha) -- 'Dias para pagar intereses' 
    print ' Dias a pagar intereses ' + cast(@w_dias_intereses as varchar)
  end
  else
  -- Si las fechas no son iguales signifia que estoy procesando un dia diferente al primer dia habil 
  begin
    print ' Nada que hacer, existen dias laborales anteriores'
    return 0
  end
/************************************************************************/
  /* DETERMINAR EL SIGUIENTE DIA HABIL (ULTIMO PROCESO) */
  select
    @w_siguiente_dia = dateadd(dd,
                               1,
                               @i_fecha)

  while datepart(mm,
                 @i_fecha) = datepart(mm,
                                      @w_siguiente_dia)
        and exists(select
                     1
                   from   cobis..cl_dias_feriados
                   where  df_ciudad = @w_ciudad
                      and df_fecha  = @w_siguiente_dia)
  begin
    select
      @w_siguiente_dia = dateadd(dd,
                                 1,
                                 @w_siguiente_dia)
  end

  print '  COMIENZA PARA EL UNIVERSO ' + cast ( @w_hijo as varchar)

  /* (HIJO 0) GENERACION DEL UNIVERSO DE CUENTAS A PROCESAR */
  if @w_hijo = 0
  begin
    print ' Comienza hijo 0 '
    /* CONTROL PARA QUE ESTE PROCESO SEA REPROCESABLE */
    if exists(select
                1
              from   sysobjects
              where  name = 'ah_universo_ahmensual')
    begin
      if exists(select
                  1
                from   ah_universo_ahmensual
                where  hijo <> 0)
        return 0
    end

    if exists(select
                1
              from   sysobjects
              where  name = 'ah_universo_ahmensual')
      exec('drop table ah_universo_ahmensual')

    exec('create table ah_universo_ahmensual
          (
            cta_banco cuenta not null,
            hijo      int not null,
            orden     int identity
          )')

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      set rowcount 0

      insert into ah_universo_ahmensual
        select
          ah_cta_banco,ah_cuenta % @w_hijos + 1
        from   cob_ahorros..ah_cuenta
        where  ah_estado not in ('C', 'G', 'N')
           and ah_filial                             = @i_filial
           and isnull(ah_fecha_ult_proceso,
                      @i_fecha) < @w_siguiente_dia
           and ah_cta_banco                          = isnull(@i_cuenta,
                                                              ah_cta_banco)
           and ah_prod_banc                          <> @w_prod_bancario
        -- Req. 381 CB Red Posicionada
        order  by ah_filial,
                  ah_moneda,
                  ah_producto,
                  ah_oficina,
                  ah_prod_banc,
                  ah_tipocta,
                  ah_categoria

      set rowcount 0
      create index idx1
        on ah_universo_ahmensual(hijo, orden)
        on indexgroup

      delete cob_ahorros..ah_acumulador
      where  ac_trn in (271, 379)

      if @@error <> 0
      begin
        select
          @w_error = 205031,
          @w_msg = 'ERROR EN ELIMINACION DE ACUMULADOR'
        goto ERRORFIN
      end
      print ' Termina Proceso hijo 0 '
      return 0
    end
    else
    begin
      set rowcount 0

      insert into ah_universo_ahmensual
        select
          ah_cta_banco,ah_cuenta % @w_hijos + 1
        from   cob_ahorros..ah_cuenta
        where  ah_estado not in ('C', 'G', 'N')
           and ah_filial                             = @i_filial
           and isnull(ah_fecha_ult_proceso,
                      @i_fecha) < @w_siguiente_dia
           and ah_cta_banco                          = isnull(@i_cuenta,
                                                              ah_cta_banco)
        order  by ah_filial,
                  ah_moneda,
                  ah_producto,
                  ah_oficina,
                  ah_prod_banc,
                  ah_tipocta,
                  ah_categoria

      set rowcount 0
      create index idx1
        on ah_universo_ahmensual(hijo, orden)
        on indexgroup

      delete cob_ahorros..ah_acumulador
      where  ac_trn in (271, 379)

      if @@error <> 0
      begin
        select
          @w_error = 205031,
          @w_msg = 'ERROR EN ELIMINACION DE ACUMULADOR'
        goto ERRORFIN
      end
      print ' Termina Proceso hijo 0 '
      return 0
    end
  end -- hijo 0

  /* (HIJO 999) PROCESO DE CIERRE DE LOS PROCESOS PARALELIZADOS */
  if @w_hijo = 999
  begin
    print ' Inicia proceso Hijo 999 '
    /* CONTROL PARA EVITAR QUE ESTE PROCESO SE EJECUTE MIENTRAS LOS HIJOS NO HAYAN TERMINADO DE TRABAJAR */
    if exists(select
                1
              from   ah_universo_ahmensual
              where  hijo <> 0)
    begin
      select
        @w_error = 0,
        @w_msg =
'ERROR SE DETECTARON OPERACIONES SI PROCESAR (ah_universo_ahmensual CON HIJOS <> A CERO)'
  goto ERRORFIN
end

  if @w_codigo_pais = 'CO'
  begin
    print ' Codigo_pais = CO '
    select
      @w_cliente = pa_int
    from   cobis..cl_parametro
    where  pa_nemonico = 'CCBA'
       and pa_producto = 'CTE'

    if @@rowcount <> 1
    begin
      select
        @w_error = 201196,
        @w_msg = 'ERROR EN PARAMETRO DE CODIGO CLIENTE BANCO'
      goto ERRORFIN
    end

    select
      @w_clase_clte_b = case c_tipo_compania
                          when 'OF' then 'O'
                          else 'P'
                        end
    from   cobis..cl_ente
    where  en_ente = @w_cliente

    if @@rowcount <> 1
    begin
      select
        @w_error = 201196,
        @w_msg = 'CLIENTE NO EXISTE'
      goto ERRORFIN
    end

    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
                 ts_valor,ts_moneda,ts_oficina_cta,ts_prod_banc,ts_categoria,
                 ts_tipocta_super,ts_turno,ts_clase_clte,ts_cliente,ts_interes)
      select
        max(ac_ssn),max(ac_ssn),379,@i_fecha,'op_batch',
        'consola',ac_oficina,'N','U','0',
        sum(ac_intereses),ac_moneda,ac_oficina,ac_prod_banc,ac_categoria,
        ac_tipocta_super,@i_turno,ac_clase_clte,@w_cliente,
        sum(ac_intereses) / @w_tasagmf
      from   cob_ahorros..ah_acumulador
      where  ac_fecha = @i_fecha
         and ac_trn   = 379
      group  by ac_oficina,
                ac_moneda,
                ac_prod_banc,
                ac_categoria,
                ac_tipocta_super,
                ac_clase_clte

    if @@error <> 0
    begin
      select
        @w_error = 201196,
        @w_msg = 'ERROR AL REGISTRAR LOS gmf EN LAS TRANSACCIONES DE SERVICIO'
      goto ERRORFIN
    end
  end -- solo para Colombia  

  /*REGISTRAR LOS INTERESES CALCULADOS EN LAS TRANSACCIONES DE SERVICIO */
  if @w_bco <> 59
  begin
    --  Se excluye para BANCAMIA debido a que la  contabilidad de los intereses es por tercero
    print ' Insercion en ah_tran_servicio  trn=271 agrupado '
    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
                 ts_valor,ts_moneda,ts_oficina_cta,ts_prod_banc,ts_categoria,
                 ts_tipocta_super,ts_turno,ts_clase_clte,ts_cliente,ts_interes)
      select
        max(ac_ssn),max(ac_ssn),271,@i_fecha,'op_batch',
        'consola',ac_oficina,'N','U','0',
        sum(ac_intereses),ac_moneda,ac_oficina,ac_prod_banc,ac_categoria,
        ac_tipocta_super,@i_turno,ac_clase_clte,@w_cliente,sum(ac_intereses)
      from   cob_ahorros..ah_acumulador
      where  ac_fecha = @i_fecha
         and ac_trn   = 271
      group  by ac_oficina,
                ac_moneda,
                ac_prod_banc,
                ac_categoria,
                ac_tipocta_super,
                ac_clase_clte

    if @@error <> 0
    begin
      select
        @w_error = 201196,
        @w_msg =
      'ERROR AL REGISTRAR LOS INTERESES EN LAS TRANSACCIONES DE SERVICIO'
      goto ERRORFIN
    end

  end -- bco <> 59

  /* CONTROL CUENTAS SIN PROCESAR */
  if exists(select
              1
            from   cob_ahorros..ah_cuenta
            where  (ah_fecha_ult_proceso < @w_dia1mes
                     or ah_fecha_ult_proceso is null)
                   -- where (ah_fecha_ult_proceso < @w_siguiente_dia or ah_fecha_ult_proceso is null)
                   and ah_estado not in ('C', 'G', 'N'))
  begin
    print 'Cuentas cuya ah_fecha_ult_proceso  < ' + cast (@w_siguiente_dia as
          varchar)
    print 'HIJO 999 - EXISTEN CUENTAS SIN PROCESAR'
    select
      @w_error = 201196,
      @w_msg = 'ERROR - EXISTEN CUENTAS SIN PROCESAR'
    goto ERRORFIN
  end
/**********************************************************************************************************/
  --* Paso de los saldos diarios 
  --** Borrado de los datos en caso de una reejecucion *

  delete cob_ahorros_his..ah_saldo_diario
  where  sd_fecha = @w_dia1mes

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR AL BORRAR TABLA DE SALDOS DIARIOS',
      @w_error = 253006
    print @w_msg
    goto ERRORFIN
  end

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    insert into cob_ahorros_his..ah_saldo_diario
                (sd_cuenta,sd_fecha,sd_12h,sd_24h,sd_48h,
                 sd_remesas,sd_saldo_contable,sd_saldo_disponible,
                 sd_tasa_contable
                 ,
                 sd_tasa_disponible,
                 sd_int_hoy,sd_estado,sd_categoria,sd_prod_banc,sd_dias,
                 sd_promedio1,sd_prom_disponible)
      select
        ah_cuenta,@w_dia1mes,ah_12h,ah_24h,ah_48h,
        ah_remesas,ah_disponible + ah_12h + ah_24h + ah_48h,ah_disponible,0,
        ah_tasa_hoy,
        ah_int_hoy,ah_estado,ah_categoria,ah_prod_banc,@w_dias_intereses,
        ah_promedio1,ah_prom_disponible
      from   cob_ahorros..ah_cuenta
      where  (ah_estado        <> 'C'
               or (ah_estado        = 'C'
                   and ah_fecha_ult_mov = @i_fecha))
         and ah_prod_banc     <> @w_prod_bancario -- Req. 381 CB Red Posicionada
      order  by ah_cuenta

    if @@error <> 0
    begin
      select
        @w_msg = 'ERROR EN INSERCION DE SALDO DIARIO',
        @w_error = 203035
      print @w_msg
      goto ERRORFIN
    end

    select
      'Registros insertados  :' + cast(count(1) as varchar)
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_fecha     = @w_dia1mes
       and sd_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

    /****************************************************************************************************************/
    print ' Termina el proceso del hijo 999'
    return 0
  end
  else
  begin
    insert into cob_ahorros_his..ah_saldo_diario
                (sd_cuenta,sd_fecha,sd_12h,sd_24h,sd_48h,
                 sd_remesas,sd_saldo_contable,sd_saldo_disponible,
                 sd_tasa_contable
                 ,
                 sd_tasa_disponible,
                 sd_int_hoy,sd_estado,sd_categoria,sd_prod_banc,sd_dias,
                 sd_promedio1,sd_prom_disponible)
      select
        ah_cuenta,@w_dia1mes,ah_12h,ah_24h,ah_48h,
        ah_remesas,ah_disponible + ah_12h + ah_24h + ah_48h,ah_disponible,0,
        ah_tasa_hoy,
        ah_int_hoy,ah_estado,ah_categoria,ah_prod_banc,@w_dias_intereses,
        ah_promedio1,ah_prom_disponible
      from   cob_ahorros..ah_cuenta
      where  (ah_estado        <> 'C'
           or (ah_estado        = 'C'
               and ah_fecha_ult_mov = @i_fecha))
      order  by ah_cuenta

    if @@error <> 0
    begin
      select
        @w_msg = 'ERROR EN INSERCION DE SALDO DIARIO',
        @w_error = 203035
      print @w_msg
      goto ERRORFIN
    end

    select
      'Registros insertados  :' + cast(count(1) as varchar)
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_fecha = @w_dia1mes

    /****************************************************************************************************************/
    print ' Termina el proceso del hijo 999'
    return 0
  end
end -- hijo 999

/********************************************************/
/*     PROCESO QUE EJECUTAN EXCLUSIVAMENTE LOS HIJOS    */
  /********************************************************/
  select
    'Inicio Procesamiento' = convert(varchar(30), getdate(), 109)

  select
    @w_lp_sec = siguiente + @i_sec
  from   cobis..cl_seqnos
  where  tabla = 'ah_lpendiente'

  if @w_lp_sec > 2147483640
    select
      @w_lp_sec = @i_sec

  if @i_turno is null
    select
      @i_turno = @s_rol

  -- PARAMETRO DE DECIMALES
  select
    @w_numdecipar = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'DCI'

  if @@rowcount <> 1
  begin
    select
      @w_error = 111020,
      @w_msg = 'ERROR EN PARAMETRO DE DECIMALES PARA AHORROS'
    goto ERRORFIN
  end

  -- PARAMETRO DE DECIMALES PARA IMPUESTOS
  select
    @w_numdeci_imp = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'DIM'

  if @@rowcount <> 1
  begin
    select
      @w_error = 111020,
      @w_msg = 'ERROR EN PARAMETRO DE DECIMALES DE IMPUESTOS PARA AHORROS'
    goto ERRORFIN
  end

  -- Codigo de moneda local
  select
    @w_moneda_local = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CMNAC'

  if @@rowcount <> 1
  begin
    select
      @w_error = 111020,
      @w_msg = 'ERROR EN PARAMETRO DE MONEDA NACIONAL'
    goto ERRORFIN
  end

  select
    @w_moneda_dolar = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CDOLAR'

  if @@rowcount <> 1
  begin
    select
      @w_error = 111020,
      @w_msg = 'ERROR EN PARAMETRO DE MONEDA DOLAR'
    goto ERRORFIN
  end

  -- Encuentra valor de parametro para comparar saldos
  select
    @w_saldo_rep1 = pa_money
  from   cobis..cl_parametro
  where  pa_nemonico = 'DS0'

  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO DE DIFERENCIA DE SALDOS'
    goto ERRORFIN
  end

  -- Encuentra valor de parametro para comparar saldos
  select
    @w_saldo_rep2 = pa_money
  from   cobis..cl_parametro
  where  pa_nemonico = 'RCLS0'

  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO DE SALDOS MAYORES A UN VALOR'
    goto ERRORFIN
  end

  -- Encuentra valor de parametro para saldos superiores
  select
    @w_saldo_rep3 = pa_money
  from   cobis..cl_parametro
  where  pa_nemonico = 'RCS0'

  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO DE RET/DEP MAYORES A UN VALOR'
    goto ERRORFIN
  end

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

  /**** se Asignan los dias que debe calcular los intereses *****/
  print ' PAGARA INTERESES POR ' + cast(@w_dias_intereses as varchar) + ' DIAS'
  select
    @w_dias_mes_act = @w_dias_intereses

  -- Tasa de Impuesto
  select
    @w_tasa_imp_gral = pa_float
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'TIDB'

  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO DE TASA DE IMPUESTO'
    goto ERRORFIN
  end

  -- Obtener el secuencial para numero de control y linea pendiente
  select
    @w_control = siguiente
  from   cobis..cl_seqnos
  where  tabla = 'ah_control'

  if @w_control > 9999
    select
      @w_control = 0

  -- Parametro para Inmovilizacion de Cuentas
  select
    @w_tinm = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'TIN'

  if @@rowcount <> 1
  begin
    select
      @w_error = 201196,
      @w_msg = 'ERROR EN PARAMETRO DE TIEMPO INMIVILIZACION'
    goto ERRORFIN
  end

  -- Parametro para Base Diaria Interes para calculo de retención
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

  /* SOLO PARA COLOMBIA */
  if @w_codigo_pais = 'CO'
  begin
    select
      @w_min_rtfte = isnull(pa_money,
                            0)
    from   cobis..cl_parametro
    where  pa_nemonico = 'MRTF'
       and pa_producto = 'AHO'

    if @@rowcount = 0
    begin
      select
        @w_error = 101077,
        @w_msg = 'NO EXISTE PARAMETRO DE MONTO MINIMO DE RETEFTE'
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

    /*** PARAMETRO PRODUCTO AHORRO CONTRACTUAL ***/
    select
      @w_prod_contractual = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'PAHCT'
    if @@rowcount = 0
    begin
      print 'NO EXISTE PARAMETRO PRODUCTO CONTRACTUAL'
      select
        @w_error = 201196,
        @w_msg = 'NO EXISTE PARAMETRO PRODUCTO CONTRACTUAL'
      goto ERRORFIN
    end

    if (select
          count(1)
        from   cob_remesas..pe_pro_bancario
        where  pb_pro_bancario = @w_prod_contractual) = 0
    begin
      print 'PRODUCTO DEFINIDO EN PARAMETRO NO EXISTE'
      select
        @w_error = 201196,
        @w_msg = 'PRODUCTO DEFINIDO EN PARAMETRO NO EXISTE'
      goto ERRORFIN
    end
  end

  /* DETERMINAR LA CANTIDAD DE CUENTAS DE AHORRO A PROCESAR EN ESTE HIJO */
  select
    @w_cant_sec = count(1) * 3
  -- ( cantidad de transacciones maximas, capitalizaicon, iva y retefuente
  from   ah_universo_ahmensual with (index(idx1))
  where  hijo = @w_hijo

  update cobis..ba_secuencial
  set    @w_ssn = se_numero,
         se_numero = @w_ssn + @w_cant_sec

  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'Error en actualizacion de SSN'
    goto ERRORFIN
  end

  select
    pf_pro_final,
    me_tipo_ente,
    me_pro_bancario,
    pf_filial,
    pf_sucursal,
    pf_producto,
    pf_moneda,
    pf_tipo
  into   #tmp_profinal
  from   cob_remesas..pe_pro_final,
         cob_remesas..pe_mercado
  where  pf_mercado = me_mercado

  print ' Cuentas a procesar ' + cast (@w_cant_sec as varchar)
  print ' Empieza el cursor '

  /* TABLA TEMPORAL DE TRABAJO */
  select
    *
  into   #pint4
  from   tempdb..pint4
  where  1 = 2

  if @@error <> 0
  begin
    select
      @w_error = 351504,
      @w_msg = 'NO SE PUEDE CREAR TABLA DE TRABAJO PIN4'
    goto ERRORFIN
  end

  select
    @w_error = 0,
    @w_filial_2 = -1,
    @w_oficina_2 = -1,
    @w_producto_2 = -1,
    @w_moneda_2 = -1,
    @w_prod_banc_2 = -1,
    @w_tipocta_2 = 'X',
    @w_categoria_2 = 'X'

  -- Cursor para el procesamiento de cuentas
  while 1 = 1
  begin
    set rowcount 1

    select
      @w_cta_banco = cta_banco,
      @w_orden = orden
    from   ah_universo_ahmensual with (index(idx1))
    where  hijo = @w_hijo

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    set rowcount 0

    if @w_debug = 'S'
    begin
      print ' '
      print 'PROCESANDO CUENTA: ' + @w_cta_banco
      print '----------------------------------'
    end

    /* MARCAR A LA CUENTA COMO PROCESADA */
    update ah_universo_ahmensual with (rowlock)
    set    hijo = 0
    from   ah_universo_ahmensual with (index(idx1))
    where  hijo  = @w_hijo
       and orden = @w_orden

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      select
        @w_cuenta = ah_cuenta,
        @w_cta_banco = ah_cta_banco,
        @w_categoria = ah_categoria,
        @w_tipocta = ah_tipocta,
        @w_rol_ente = ah_rol_ente,
        @w_tipo_def = ah_tipo_def,
        @w_prod_banc = ah_prod_banc,
        @w_producto = ah_producto,
        @w_tipo = ah_tipo,
        @w_default = ah_default,
        @w_personalizada = ah_personalizada,
        @w_oficina = ah_oficina,
        @w_12h = ah_12h,
        @w_24h = ah_24h,
        @w_48h = ah_48h,
        @w_remesas = ah_remesas,
        @w_disponible = ah_disponible,
        @w_filial = ah_filial,
        @w_moneda = ah_moneda,
        @w_promedio1 = ah_promedio1,
        @w_promedio2 = ah_promedio2,
        @w_prom_disponible = ah_prom_disponible,
        @w_saldo_interes = ah_saldo_interes,
        @w_int_hoy = ah_int_hoy,
        @w_fecha_ult_ret = ah_fecha_ult_ret,
        @w_min_dispmes = ah_min_dispmes,
        @w_fecha_aper = ah_fecha_aper,
        @w_tasa_hoy = ah_tasa_hoy,
        @w_tipo_promedio = ah_tipo_promedio,
        @w_estado = ah_estado,
        @w_nombre = ah_nombre,
        @w_saldo_ayer = ah_saldo_ayer,
        @w_fecha_ult_mov = ah_fecha_ult_mov,
        @w_fecha_ult_mov_int = ah_fecha_ult_mov_int,
        @w_creditos_hoy = ah_creditos_hoy,
        @w_debitos_hoy = ah_debitos_hoy,
        @w_cta_funcionario = ah_cta_funcionario,
        @w_debitos = ah_debitos,
        @w_bloqueos = ah_monto_bloq + ah_monto_consumos,
        @w_creditos = ah_creditos,
        @w_monto_imp = ah_monto_imp,
        @w_suspensos = ah_suspensos,
        @w_lineas = ah_linea,
        @w_contador_trx = ah_contador_trx,
        @w_fecha_ult_capi = ah_fecha_ult_capi,
        @w_cliente = ah_cliente,
        @w_tcapitalizacion = ah_capitalizacion,
        @w_fecha_prx_capita = ah_fecha_prx_capita,
        @w_int_mes = ah_int_mes,
        @w_tipocta_super = ah_tipocta_super,
        @w_aplica_tasacorp = ah_aplica_tasacorp,
        @w_monto_ult_capi = ah_monto_ult_capi,
        @w_saldo_mantval = ah_saldo_mantval,
        @w_clase_clte = ah_clase_clte,
        @w_es_contractual = 'N'
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_cta_banco
         and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
    end
    else
    begin
      select
        @w_cuenta = ah_cuenta,
        @w_cta_banco = ah_cta_banco,
        @w_categoria = ah_categoria,
        @w_tipocta = ah_tipocta,
        @w_rol_ente = ah_rol_ente,
        @w_tipo_def = ah_tipo_def,
        @w_prod_banc = ah_prod_banc,
        @w_producto = ah_producto,
        @w_tipo = ah_tipo,
        @w_default = ah_default,
        @w_personalizada = ah_personalizada,
        @w_oficina = ah_oficina,
        @w_12h = ah_12h,
        @w_24h = ah_24h,
        @w_48h = ah_48h,
        @w_remesas = ah_remesas,
        @w_disponible = ah_disponible,
        @w_filial = ah_filial,
        @w_moneda = ah_moneda,
        @w_promedio1 = ah_promedio1,
        @w_promedio2 = ah_promedio2,
        @w_prom_disponible = ah_prom_disponible,
        @w_saldo_interes = ah_saldo_interes,
        @w_int_hoy = ah_int_hoy,
        @w_fecha_ult_ret = ah_fecha_ult_ret,
        @w_min_dispmes = ah_min_dispmes,
        @w_fecha_aper = ah_fecha_aper,
        @w_tasa_hoy = ah_tasa_hoy,
        @w_tipo_promedio = ah_tipo_promedio,
        @w_estado = ah_estado,
        @w_nombre = ah_nombre,
        @w_saldo_ayer = ah_saldo_ayer,
        @w_fecha_ult_mov = ah_fecha_ult_mov,
        @w_fecha_ult_mov_int = ah_fecha_ult_mov_int,
        @w_creditos_hoy = ah_creditos_hoy,
        @w_debitos_hoy = ah_debitos_hoy,
        @w_cta_funcionario = ah_cta_funcionario,
        @w_debitos = ah_debitos,
        @w_bloqueos = ah_monto_bloq + ah_monto_consumos,
        @w_creditos = ah_creditos,
        @w_monto_imp = ah_monto_imp,
        @w_suspensos = ah_suspensos,
        @w_lineas = ah_linea,
        @w_contador_trx = ah_contador_trx,
        @w_fecha_ult_capi = ah_fecha_ult_capi,
        @w_cliente = ah_cliente,
        @w_tcapitalizacion = ah_capitalizacion,
        @w_fecha_prx_capita = ah_fecha_prx_capita,
        @w_int_mes = ah_int_mes,
        @w_tipocta_super = ah_tipocta_super,
        @w_aplica_tasacorp = ah_aplica_tasacorp,
        @w_monto_ult_capi = ah_monto_ult_capi,
        @w_saldo_mantval = ah_saldo_mantval,
        @w_clase_clte = ah_clase_clte,
        @w_es_contractual = 'N'
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_cta_banco
    end
    /* ADI: REQ 217 DATOS DE CUENTA - AHORRO CONTRACTUAL */
    if exists (select
                 1
               from   cob_remesas..re_cuenta_contractual
               where  cc_cta_banco = @w_cta_banco
                  and cc_prodbanc  = @w_prod_contractual
                  and cc_estado    = 'A')
      select
        @w_es_contractual = 'S',
        @w_cont_modulo = cc_modulo,
        @w_cont_profinal = cc_profinal,
        @w_cont_cta_banco = cc_cta_banco,
        @w_cont_plazo = cc_plazo,
        @w_cont_cuota = cc_cuota,
        @w_cont_periodicidad = cc_periodicidad,
        @w_cont_monto_final = cc_monto_final,
        @w_cont_intereses = cc_intereses,
        @w_cont_ptos_premio = cc_ptos_premio,
        @w_cont_estado = cc_estado,
        @w_cont_categoria = cc_categoria,
        @w_cont_fecha_crea = convert(varchar, cc_fecha_crea, 101),
        @w_cont_periodos_incump = cc_periodos_incump,
        @w_fecha_ult_cuo = convert(varchar, dateadd(mm,
                                                    cc_plazo - 1,
                                                    @w_fecha_aper), 101)
      from   cob_remesas..re_cuenta_contractual
      where  cc_cta_banco = @w_cta_banco
         and cc_prodbanc  = @w_prod_contractual
         and cc_estado    = 'A'

    select
      @w_disp_mes_ant = sd_saldo_disponible
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_cuenta = @w_cuenta
       and sd_fecha  = dateadd(mm,
                               -1,
                               @i_fecha)

    /* Ajuste dias calculados */
    if @w_inimes = 'S'
       and @i_fecha = @w_fecha_aper
      select
        @w_dias_mes_act = @w_dias_mes_act - @w_num_dias

    /* FIN ADI: REQ 217  DATOS DE CUENTA - AHORRO CONTRACTUAL */

    if @w_filial <> @w_filial_2
        or @w_oficina <> @w_oficina_2
        or @w_producto <> @w_producto_2
        or @w_moneda <> @w_moneda_2
        or @w_prod_banc <> @w_prod_banc_2
        or @w_tipocta <> @w_tipocta_2
        or @w_categoria <> @w_categoria_2
    begin
      print 'CAMBIO DE VARIABLES --> '

      /* DETERMINAR LA SUCURSAL DE LA OFICINA */
      select
        @w_sucursal = isnull(of_regional,
                             of_oficina)
      from   cobis..cl_oficina
      where  of_oficina = @w_oficina

      /* DETERMINAR EL NUMERO DE DECIMALES QUE MANEJA LA MONEDA */
      if @w_moneda <> @w_moneda_2
      begin
        select
          @w_numdeci = 0,
          @w_numdeci_imp = 0

        select
          @w_numdeci = @w_numdecipar
        from   cobis..cl_moneda
        where  mo_moneda    = @w_moneda
           and mo_decimales = 'S'

      end

      /* DETERMINAR LA CIUDAD DE LA OFICINA DE LA CUENTA */
      if @w_oficina <> @w_oficina_2
      begin
        select
          @w_ciudad_rte_ica = of_ciudad
        from   cobis..cl_oficina
        where  of_oficina = @w_oficina
      end

      /* DETERMINAR LA MODALIDAD DE CALCULO DEL VALOR BASE SOBRE EL QUE SE PAGARA EL INTERES */
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
          @w_msg = 'NO SE ECUENTRA TIPO DE ATRIBUTO tempdb..pe_tipo_atributo'
        goto ERROR
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

      if @@rowcount = 0
      begin
        select
          @w_error = 351504,
          @w_msg = 'NO SE ECUENTRAN REGISTROS EN LA TABLA tmpdb..pint4'
        goto ERROR
      end

      /* REQ 217 AHORRO CONTRACTUAL - No. RANGOS A TRABAJAR */
      select
        @w_num_rango = isnull(cp_tipo_rango,
                              2)
      from   cob_remesas..pe_capitaliza_profinal
      where  cp_profinal            = @w_cont_profinal
         and cp_tipo_capitalizacion = @w_tcapitalizacion

      /* DETERMINAR EL ULTIMO Y PENULTIMO RANGO ADEMAS LA MAXIMA TASA */
      select
        @w_ultimo_rango = max(rango)
      from   #pint4
      select
        @w_penultimo_rango = max(rango)
      from   #pint4
      where  rango < @w_ultimo_rango
      select
        @w_tasa_maxima = max(valor)
      from   #pint4

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
        select
          @w_flag_tasas = 0
        goto ERROR
      end

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
          select
            @w_flag_tasas = 0
          goto ERROR
        end

        /* SI EL RANGO DESDE DEFINIDO ES MENOR QUE CERO SE SETEA EL VALOR EN CERO  */
        if @w_rango_desde < 0
          select
            @w_rango_desde = 0

        --NO EVALUAR CONTRA EL SALDO DESDE DEL ULTIMO RANGO SINO CONTRA EL SALDO HASTA DEL PENULTIMO RANGO
        if @w_pen_rango_hasta is null
          select
            @w_pen_rango_hasta = 0

      end --FIN - SOLO PARA PRODUCTOS CON DOS RANGOS

      if @w_debug = 'S'
      begin
        print 'rango desde    : ' + convert(varchar, @w_rango_desde)
        print 'rango hasta    : ' + convert(varchar, @w_rango_hasta)
        print 'rango pen_hasta: ' + convert(varchar, @w_pen_rango_hasta)
        print 'decimales      : ' + convert(varchar, @w_numdeci)
      end

      select
        @w_filial_2 = @w_filial,
        @w_oficina_2 = @w_oficina,
        @w_producto_2 = @w_producto,
        @w_moneda_2 = @w_moneda,
        @w_prod_banc_2 = @w_prod_banc,
        @w_tipocta_2 = @w_tipocta,
        @w_categoria_2 = @w_categoria

    end

    select
      @w_procesado_ok = 1,-- POR DEFAULT LA CUENTA FALLA
      @w_dev_idb = 'N',
      @w_error = 0,
      @w_tasa_imp = 0,
      @w_tasa_impuesto = 0,
      @w_tipo_exonerado_imp = '',
      @w_acumu_deb_total = 0,
      @w_acumu_deb = 0,
      @w_trn_code = 271,
      @w_valor_reteica = 0,
      @w_gmf_reteica = 0

    -- CALCULO DE LA ALICUOTA PARA EL PROMEDIO
    select
      @w_alicuota = fp_alicuota
    from   cob_ahorros..ah_fecha_promedio
    where  fp_tipo_promedio = @w_tipo_promedio
       and fp_fecha_inicio  = @i_fecha

    if @@rowcount = 0
    begin
      select
        @w_error = 251013,
        @w_msg = 'NO SE ENCUENTRAN REGISTROS EN LA TABLA ah_fecha_promedio'
      goto ERROR
    end

    -- Calcula saldo minimo del mes
    if @w_min_dispmes = -1
    begin
      if @w_disponible >= 0
        select
          @w_min_dispmes = @w_disponible
      else
        select
          @w_min_dispmes = 0
    end
    else if @w_disponible < @w_min_dispmes
      select
        @w_min_dispmes = @w_disponible

    select
      @w_contable = @w_12h + @w_24h + @w_disponible + @w_48h -- + @w_remesas

    /* CALCULO DE INTERES */
    select
      @w_valor_acreditar = 0,
      @w_calculo_int = 'N',
      @w_tasa_ayer = @w_tasa_hoy,
      @w_contador_tasas = 1,
      @w_flag_tasas = 1,
      @w_monto_calculo = 0,
      @w_monto_total = 0,
      @w_rango_hasta_ant = 0,
      @w_monto_interes = 0,
      @w_tasa_interes_acum = 0,
      @w_monto_interes1 = 0,
      @w_monto_interes2 = 0

    if @w_tipo_atributo = 'B' /* Saldo promedio */
      select
        @w_monto = @w_promedio1
    else if @w_tipo_atributo = 'C' /* Saldo Contable */
      select
        @w_monto = @w_contable
    else if @w_tipo_atributo = 'A' /* Saldo Disponible */
      select
        @w_monto = @w_disponible
    else if @w_tipo_atributo = 'E' /* Promedio Disponible */
      select
        @w_monto = @w_prom_disponible
    else if @w_tipo_atributo = 'D' /* Saldo minimo mensual */
      select
        @w_monto = @w_min_dispmes
    else
      select
        @w_monto = $1

    if @w_debug = 'S'
      print '@w_monto          ' + cast (@w_monto as varchar ) +
                                                  '   @w_pen_rango_hasta '
            + cast (@w_pen_rango_hasta as varchar)

    /* ADI REQ 217: AJUSTE DE MONTOS PARA UN SOLO RANGO */

    if @w_num_rango = 1
    begin
      select
        @w_monto_interes1 = 0
      select
        @w_monto_interes2 = @w_monto
    end
    else
    begin
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
    end
    /* FIN ADI REQ 217: AJUSTE DE MONTOS PARA UN SOLO RANGO */

    if @w_debug = 'S'
    begin
      print '@w_monto_interes1 ' + cast (@w_monto_interes1 as varchar) +
            '   @w_monto_interes2  '
            + cast (@w_monto_interes2 as varchar)
      print ' '
    end

    select
      @w_tasa_interes = 0,
      @w_tasa_maxima = 0

    if @w_monto_interes1 > 0
    begin
      select
        @w_rango_busqueda = @w_rango_hasta - 1

      if @w_personalizada = 'N'
      begin /* Cuentas Normales */
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

      end
      else
      begin -- SI esta personalizada
        exec @w_error = cob_remesas..sp_genera_costos
          @i_fecha       = @i_fecha,
          @i_categoria   = @w_categoria,
          @i_tipo_ente   = @w_tipocta,
          @i_rol_ente    = @w_rol_ente,
          @i_tipo_def    = @w_tipo_def,
          @i_prod_banc   = @w_prod_banc,
          @i_producto    = @w_producto,
          @i_moneda      = @w_moneda,
          @i_tipo        = @w_tipo,
          @i_codigo      = @w_default,
          @i_servicio    = 'PINT',
          @i_rubro       = '18',
          @i_disponible  = @w_rango_busqueda,
          @i_contable    = @w_rango_busqueda,
          @i_promedio    = @w_rango_busqueda,
          @i_prom_disp   = @w_rango_busqueda,
          @i_personaliza = @w_personalizada,
          @i_filial      = @w_filial,
          @i_oficina     = @w_oficina,
          @i_batch       = 'S',
          @o_valor_total = @w_tasa_interes out

        if @w_error <> 0
            or @@error <> 0
        begin
          select
            @w_msg = mensaje
          from   cobis..cl_errores
          where  numero = @w_return

          if @@rowcount = 0
          begin
            select
              @w_msg = 'ERROR EN CUENTA PERSONALIZADA AL EXTRAER COSTO',
              @w_error = 351504
          end

          goto ERROR

        end

      end --Personalizada

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
        print '1====> @w_valor_acreditar ' + cast(@w_valor_acreditar as varchar)
        select
          @w_valor_acreditar = @w_valor_acreditar * @w_dias_mes_act

        --PCOELLO ESTE IF SOLO VA A SER VERDADERO SI NO ENCONTRO TASA EN EL RANGO MAXIMO
        if @w_tasa_maxima = 0
          --SOLO SI NO ENCONTRO TASA EN EL RANGO ANTERIOR ACUMULA
          select
            @w_tasa_maxima = @w_tasa_interes
      end
      if @w_debug = 'S'
      begin
        set nocount on
        print 'monto interes 1'
        print '====> @w_tasa_interes ' + cast(@w_tasa_interes as varchar)
        print '====> @w_factor1 ' + cast(@w_factor1 as varchar) + ' @w_factor2 '
              + cast(@w_factor1 as varchar) + ' @w_factor ' + cast(@w_factor as
              varchar)
        print '====> @w_valor_acreditar ' + cast(@w_valor_acreditar as varchar)
        set nocount off
      end
    end -- fin monto interes 1

    select
      @w_monto_interes = @w_monto_interes + @w_valor_acreditar
    select
      @w_tasa_interes_acum = @w_tasa_interes_acum + @w_tasa_interes
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
      -- - 1 --PCOELLO RESTARLE UNO PARA QUE CAIGA EN EL RANGO ANTERIOR

      if @w_personalizada = 'N'
      begin /* Cuentas Normales */
        select
          @w_tasa_interes = valor / 100
        from   #pint4
        where  rango_desde <= @w_rango_busqueda
           and rango_hasta > @w_rango_busqueda

        /*****PCOELLO SI EL VALOR COINCIDE CON EL RANGO HASTA NO LO ENCUENTRA Y LO CALCULA A TASA CERO LO CUAL ESTA MAL
        POR ESO SI NO ENCONTRO EN EL RANGO INDICADO, BUSCA EN EL RANGO CON EL VALOR MENOS UNO PARA QUE 
        ENCUENTRE LA TASA CORRECTA *********/

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
                @w_msg = 'Procesando ...4ERROR EN TABLA TMP DE PERSONALIZACION '
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

      end
      else
      begin -- SI esta personalizada
        exec @w_return = cob_remesas..sp_genera_costos
          @i_fecha       = @i_fecha,
          @i_categoria   = @w_categoria,
          @i_tipo_ente   = @w_tipocta,
          @i_rol_ente    = @w_rol_ente,
          @i_tipo_def    = @w_tipo_def,
          @i_prod_banc   = @w_prod_banc,
          @i_producto    = @w_producto,
          @i_moneda      = @w_moneda,
          @i_tipo        = @w_tipo,
          @i_codigo      = @w_default,
          @i_servicio    = 'PINT',
          @i_rubro       = '18',
          @i_disponible  = @w_rango_busqueda,
          @i_contable    = @w_rango_busqueda,
          @i_promedio    = @w_rango_busqueda,
          @i_prom_disp   = @w_rango_busqueda,
          @i_personaliza = @w_personalizada,
          @i_filial      = @w_filial,
          @i_oficina     = @w_oficina,
          @i_batch       = 'S',
          @o_valor_total = @w_tasa_interes out

        if @w_return <> 0
            or @@error <> 0
        begin
          print 'Procesando ...3----'
          select
            @w_msg = mensaje
          from   cobis..cl_errores
          where  numero = @w_return
          if @@rowcount = 0
            select
              @w_msg = 'ERROR EN CUENTA PERSONALIZADA AL EXTRAER COSTO',
              @w_error = 351552
          else
            select
              @w_error = @w_return
          goto ERROR
        end
        if @w_debug = 'S'
          print ' Rango Especial para Cuenta Personalizada'
      end --Personalizada 

      select
        @w_valor_acreditar = 0,
        @w_factor1 = 0,
        @w_factor2 = 0,
        @w_factor = 0

      select
        @w_ajuste = 0

      if (@w_tasa_interes <> 0)
      begin --Convierte a tasa nominal (diaria)         
        /* ADI REQ 217: SUMA DE INTERESES ADICIONALES */
        select
          @w_ult_dia_mes = dateadd(dd,
                                   -datepart(dd,
                                             dateadd(mm,
                                                     1,
                                                     @w_fecha_ult_cuo)),
                                   dateadd(mm,
                                           1,
                                           @w_fecha_ult_cuo))

        while 1 = 1
        begin
          if exists (select
                       1
                     from   cobis..cl_dias_feriados
                     where  df_ciudad = @w_ciudad
                        and df_fecha  = @w_ult_dia_mes)
            select
              @w_ult_dia_mes = dateadd(dd,
                                       -1,
                                       @w_ult_dia_mes)
          else
            break
        end

        select
          @w_factor1 = 1 + @w_tasa_interes
        select
          @w_factor2 = (convert(float, 1)) / @w_dias_anio
        /*calculo del factor para 1 dia */
        select
          @w_factor = (power (@w_factor1,
                              @w_factor2)) - 1
        select
          @w_valor_acreditar = isnull(round((@w_monto_interes2 * @w_factor),
                                            @w_numdeci),
                                      0)
        print '2====> @w_valor_acreditar ' + cast(@w_valor_acreditar as varchar)
        select
          @w_valor_acreditar = @w_valor_acreditar * @w_dias_mes_act
      end
      --* else 
      if @w_debug = 'S'
      begin
        set nocount on
        print 'monto interes 2'
        print '====> @w_tasa_interes ' + cast(@w_tasa_interes as varchar)
        print '====> @w_factor1 ' + cast(@w_factor1 as varchar) + ' @w_factor2 '
              + cast(@w_factor1 as varchar) + ' @w_factor ' + cast(@w_factor as
              varchar)
        print '====> @w_valor_acreditar ' + cast(@w_valor_acreditar as varchar)
        set nocount off
      end

    end -- fin monto interes 2

    select
      @w_monto_interes = @w_monto_interes + @w_valor_acreditar
    select
      @w_tasa_interes_acum = @w_tasa_interes_acum + @w_tasa_interes

    /******************************************************************/
    if @w_monto_interes1 > 0
      select
        @w_tasa_interes_acum = @w_tasa_interes_acum / 2
    select
      @w_monto_interes = round(@w_monto_interes,
                               @w_numdeci)

    select
      @w_valor_acreditar = @w_monto_interes

    -- Calculo de la tasa aplicada en base al valor de interes obtenido en los pasos anteriores
    if ((@w_dias_mes_act <> 0)
        and (@w_monto <> 0)
        and (@w_valor_acreditar <> 0))
    begin
      if @w_num_rango > 1
        select
          @w_tasa_interes = ((convert(real, @w_valor_acreditar) /
                              convert(real, @w_dias_mes_act
                              ))
                             /
                             convert(
                                               real, @w_monto
                             ))
                                                       *
                            convert(real, @w_dias_anio)
      else
        select
          @w_tasa_interes = @w_factor * @w_dias_anio
    end
    else
      select
        @w_tasa_interes = 0

    if @w_tasa_interes > 0
    begin
      select
        @w_calculo_int = 'S'
    end
    else
      select
        @w_valor_acreditar = 0,
        @w_calculo_int = 'N'

    -- Guarda saldo anterior de intereses del mes
    select
      @w_int_mes_ant = @w_int_mes

    -- Nuevos saldos de interes
    select
      @w_saldo_interes = @w_saldo_interes + @w_valor_acreditar + isnull(
                         @w_ajuste
                         ,
                         0
                                ),
      @w_int_hoy = @w_valor_acreditar,
      @w_tasa_hoy = round((@w_tasa_interes * 100),
                          @w_numdeci),
      @w_int_mes = @w_int_mes + @w_valor_acreditar + isnull(@w_ajuste, 0)

    if @w_debug = 'S'
    begin
      set nocount on
      print ':......................... @w_saldo_interes ' + cast (
            @w_saldo_interes
            as
                             varchar)
      print ':......................... @w_int_hoy       ' + cast (@w_int_hoy as
            varchar)
      print ':......................... @w_tasa_hoy      ' + cast (@w_tasa_hoy
            as
            varchar)
      print ':......................... @w_tasa_interes  ' + cast (
            @w_tasa_interes
            as
                             varchar)
      print ':......................... @i_fecha         ' + cast (@i_fecha as
            varchar)
      print ':......................... @w_ajuste         ' + cast (@w_ajuste as
            varchar)
      print ':......................... @w_cont_ptos_premio '
            + cast (@w_cont_ptos_premio as varchar)
      print
    '-------------------------------------------------------------------------'
      set nocount off
    end

    /* ADI REQ 217: ACTUALIZO INTERESES CUENTA CONTRACTUAL*/

    select
      @w_ult_dia_mes = pe_fecha_fin
    from   cob_ahorros..ah_periodo
    where  pe_capitalizacion = @w_cont_periodicidad
       and pe_periodo        = (select
                                  datepart(mm,
                                           @i_fecha))

    while 1 = 1
    begin
      if exists (select
                   df_fecha
                 from   cobis..cl_dias_feriados
                 where  df_ciudad = @w_ciudad
                    and df_fecha  = @w_ult_dia_mes)
        select
          @w_ult_dia_mes = dateadd(dd,
                                   -1,
                                   @w_ult_dia_mes)
      else
        break
    end

    if (@w_es_contractual = 'S'
        and @w_ult_dia_mes = @i_fecha
        and @w_categoria <> @w_camcat)
    begin
      update cob_remesas..re_cuenta_contractual with(rowlock)
      set    cc_intereses = cc_intereses + isnull(@w_saldo_interes, 0)
      where  cc_cta_banco = @w_cta_banco
         and cc_estado    = 'A'
      if @@error <> 0
      begin
        select
          @w_msg = 'ERROR ACTUALIZANDO INTERESES CONTRACTUAL: ' + convert(
                   varchar
                   ,
                          @w_cta_banco)
        goto ERROR
      end
    end
    /* ADI REQ 217: ACTUALIZO INTERESES CUENTA CONTRACTUAL*/
    if @w_debug = 'S'
    begin
      set nocount on
      print ':......................... @w_es_contractual '
            + cast (@w_es_contractual as varchar)
      print ':......................... @w_saldo_interes  '
            + cast (@w_saldo_interes as varchar)
      print ':......................... @w_corte_mes      ' + cast (@w_corte_mes
            as
            varchar)
      print ':......................... @w_tasa_interes   ' + cast (
            @w_tasa_interes
            as
                             varchar)
      print
    '-------------------------------------------------------------------------'
      set nocount off
    end

    /* ACTUALIZACION DE DATOS DE LA CUENTA */
    select
      @w_saldo_mantval = 0

    update cob_ahorros..ah_cuenta with (rowlock)
    set    ah_saldo_interes = @w_saldo_interes,
           ah_int_hoy = @w_int_hoy,
           ah_tasa_hoy = @w_tasa_hoy,
           ah_int_mes = @w_int_mes,
           --*    ah_disponible        = @w_disponible,
           --*    ah_prom_disponible   = @w_prom_disponible,
           --*    ah_promedio1         = @w_promedio1,
           --*    ah_min_dispmes       = @w_min_dispmes,
           --*    ah_estado            = @w_estado,
           --*    ah_fecha_ult_mov_int = @w_fecha_ult_mov_int,
           --*    ah_fecha_prx_capita  = @w_fecha_prx_capita,
           --*   ah_monto_imp         = @w_monto_imp,
           --*    ah_debitos           = @w_debitos,
           --*    ah_creditos          = @w_creditos,
           --*    ah_debitos_hoy       = @w_debitos_hoy,
           --*    ah_creditos_hoy      = @w_creditos_hoy,   
           --*    ah_linea             = @w_lineas,
           --*    ah_contador_trx      = @w_contador_trx,
           --*    ah_monto_ult_capi    = @w_monto_ult_capi,
           --*    ah_saldo_mantval     = @w_saldo_mantval,
           --*    ah_12h_dif           = isnull(@w_valor_impuesto,0),
           --*    ah_tasa_ayer         = @w_tasa_ayer,
           --*    ah_fecha_ult_capi    = @w_fecha_ult_capi,
           ah_fecha_ult_proceso = @w_dia1mes
    where  ah_cta_banco = @w_cta_banco

    if @@error <> 0
    begin
      select
        @w_error = 0,
        @w_msg = 'Procesando ...12 ERROR EN ACTUALIZACION DE CUENTA'
      goto ERROR
    end

    if @w_valor_acreditar >= 0.01
    begin
      select
        @w_trn_code = 271

      if @w_bco = 59
      begin
        --Para el Proyecto de Bancamia, la  contabilidad de los intereses es por tercero
        --select @w_ssn = @w_ssn + 1

        insert into cob_ahorros..ah_tran_servicio
                    (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                     ts_usuario,
                     ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
                     ts_valor,ts_moneda,ts_oficina_cta,ts_prod_banc,ts_categoria
                     ,
                     ts_tipocta_super,ts_turno,
                     ts_clase_clte,ts_cliente,ts_tasa)
        values      ( @w_ssn,@w_ssn,@w_trn_code,@i_fecha,'op_batch',
                      'consola',@w_oficina,'N','U',@w_cta_banco,
                      @w_valor_acreditar,@w_moneda,@w_oficina,@w_prod_banc,
                      @w_categoria,
                      @w_tipocta_super,@i_turno,@w_clase_clte,@w_cliente,
                      convert(float, @w_tasa_hoy))

        if @@error <> 0
        begin
          select
            @w_error = 0,
            @w_msg =
          'Procesando ...26 ERROR AL INSERTAR TRANSACCION DE SERVICIO'
          goto ERROR
        end

      end
      else
      begin
        --select @w_ssn = @w_ssn + 1

        insert into ah_acumulador
                    (ac_oficina,ac_moneda,ac_prod_banc,ac_categoria,ac_ssn,
                     ac_usuario,ac_terminal,ac_trn,ac_fecha,ac_reentry,
                     ac_origen,ac_cta_banco,ac_intereses,ac_tipocta_super,
                     ac_clase_clte)
        values      ( @w_oficina,@w_moneda,@w_prod_banc,@w_categoria,@w_ssn,
                      'op_batch','consola',@w_trn,@i_fecha,'N',
                      'U','0',@w_valor_acreditar,@w_tipocta_super,@w_clase_clte)

        if @@error <> 0
        begin
          select
            @w_error = 0,
            @w_msg = 'Procesando ...8 ERROR INSERTAR ACUMULADO DE INTERES',
            @w_cta_banco = '0'
          goto ERROR
        end

      end -- solo para bancamia

    end

    /* FIN DE ACUMULAR INTERES */

    select
      @w_ssn = @w_ssn + 1
    select
      @w_procesado_ok = 0 -- LA CUENTA SE PROCESO CORRECTAMENTE

    LEER:

    if @w_commit = 'S'
    begin
      commit tran
      select
        @w_commit = 'N'
    end

    goto SALDO

    ERROR:

    print @w_msg

    if @w_commit = 'S'
    begin
      rollback tran
      select
        @w_commit = 'N'
    end

    exec sp_errorlog
      @i_fecha       = @i_fecha,
      @i_error       = @w_error,
      @i_usuario     = 'batch',
      @i_tran        = @w_trn_code,
      @i_cuenta      = @w_cta_banco,
      @i_descripcion = @w_msg,
      @i_rollback    = 'S',
      @i_programa    = @w_sp_name

    SALDO:

    /**** Se elimino la carga para la tabla de ah_saldo_diario *****/

    leer2:
    select
      @w_ssn = @w_ssn + 1
  end

  while @@trancount > 0
    commit tran

  select
    'Fin Procesamiento' = convert(varchar(30), getdate(), 109)
  return 0

  ERRORFIN:
  print ' ERRORFIN:'
  exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = @w_trn_code,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return @w_error

go

