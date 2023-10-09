/************************************************************************/
/*  Archivo:                deposito_ncredito_fe.sp                     */
/*  Stored procedure:       sp_deposito_ncredito_fe                     */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Julio Navarrete/Javier Bucheli              */
/*  Fecha de escritura:     25-Feb-1993                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno  de sus            */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp.     */
/*  Este programa esta protegido por la ley de derechos de autor        */
/*  y por las convenciones  internacionales de propiedad inte-          */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para       */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier infraccion.                   */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Este programa procesa las transacciones de depositos con libreta    */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA           AUTOR        RAZON                                  */
/*  25/Feb/1993     J Navarrete  Emision inicial                        */
/*  21/ene/2010     CMunoz       FRC-AHO-017-CobroComisiones CMU 2102110*/
/*  04/Feb/2010     J.Loyo       Validacion de Saldo Maximo             */
/*                               para la cuenta                         */
/*  03/May/2016     J. Salazar   Migracion COBIS CLOUD MEXICO           */
/*  01/Ago/2016     E. Williams  AHO-H77223 correccion i_personaliza    */
/*                               e i_codigo en sp_genera_costos         */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_deposito_ncredito_fe')
  drop proc sp_deposito_ncredito_fe
go

/****** Object:  StoredProcedure [dbo].[sp_deposito_ncredito_fe]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_deposito_ncredito_fe
(
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_ofi           smallint,
  @s_ssn           int,
  @s_date          datetime,
  @s_user          varchar(30) = 'AHO',
  @s_ssn_branch    int,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,/* Trans a ser reversada */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(30) = null,
  @t_ejec          char(1) = null,
  @t_trn           int,
  @t_show_version  bit = 0,
  @i_filial        tinyint,
  @i_ofi           smallint,
  @i_cuenta        int,
  @i_efe           money,
  @i_loc           money,
  @i_plaz          money,
  @i_mon           tinyint,
  @i_credit        money,
  @i_ind           tinyint,
  @i_factor        smallint,
  @i_fecha         datetime,
  @i_fecha_efec    datetime,
  @i_marca         char(1),
  @i_canal         tinyint = 4,--4 CAJAS
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_aj_int        money out,
  @o_aj_cap        money out,
  @o_aj_ret        money out,
  @o_nombre        varchar(60) out,
  @o_cliente       int = null out,
  @o_fecha         datetime out,
  @o_ofi_cta       smallint out,
  @o_oficial       smallint = null out,
  @o_prod_banc     tinyint = null out,
  @o_clase_clte    char(1) = null out,
  @o_categoria     char(1) = null out,--MVE AH00007
  @o_tipocta_super char(1) = null out,
  @o_cedula        varchar(12) out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_alicuota         numeric(11, 10),
    @w_tasa             float,
    @w_fecha_aper       datetime,
    @w_fecha_tmp        datetime,
    @w_suspensos        smallint,
    @w_contador         smallint,
    @w_secuencial       int,
    @w_valor            money,
    @w_clave            int,
    @w_capital_acum     float,
    @w_ajuste_interes   float,
    @w_interes_acum     float,
    @w_tot_alic         money,
    @w_saldo_para_girar money,
    @w_contable         money,
    @w_tot              money,
    @w_retfte_tot       money,
    @w_retfte_acum      money,
    @w_retencion        char(1),
    @w_disponible       money,
    @w_promedio1        money,
    @w_creditos         money,
    @w_dias_anio        float,
    @w_num_dias         smallint,
    @w_ndci             tinyint,
    @w_mes_efec         tinyint,
    @w_mes_act          tinyint,
    @w_anio_act         tinyint,
    @w_mensaje          mensaje,
    @w_tipo_bloqueo     char(3),
    @w_tipo_prom        char(1),
    @w_error            char(1),
    @w_prom_disp        money,
    @w_usadeci          char(1),
    @w_credhoy          money,
    @w_tasa_efectiva    money,
    @w_exento           char(1),
    @w_sldtmp           money,
    @w_sldtmp1          money,
    @w_prod_banc        tinyint,
    @w_tipo_ente        char(1),
    @w_categoria        char(1),
    @w_rol_ente         char(1),
    @w_default          int,
    @w_producto         tinyint,
    @w_tipo             char(1),
    @w_moneda           tinyint,
    @w_personalizada    char(1),
    @w_diftasa          float,
    @w_tasa_ret         float,
    @w_tipo_def         char(1),
    @w_cta              varchar(12),
    @w_fecha_aux        datetime,
    @w_reentry          varchar(200),
    @w_ncredmes         int,
    @w_numdeciimp       tinyint,
    @w_clase_clte       char(1),
    @w_fecha_ult_capi   datetime,--JAR 19/01/2010
    @w_debug            char(1),
    @w_cobro_comision   money,
    /** Validacion saldo Maximo ***/
    @w_saldo_max        money,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_numdeb           int,
    @w_numtot           int,
    @w_numero           int,
    @w_numcre           int,
    @w_numco            int,
    @w_tipocobro        char(1),
    @w_factor           float,
    @w_factor1          float,
    @w_factor2          float,
    @w_codigo_pais      char(2),
    @w_cpto_rte         char(4),
    @w_base_rtfte       money,
    @w_binc             money,
    @w_porcentaje       float,
    @w_dias_int         smallint,
    -- REQ 306 DEPOSITO INICIAL APERTURA
    @w_deposito_min     money,
    @w_estado           char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_deposito_ncredito_fe'
  --print @w_sp_name

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_debug = 'N'

  /* Encuentra parametro de decimales */
  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_usadeci = 'S'
  begin
    select
      @w_ndci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DCI'
       and pa_producto = 'AHO'

    select
      @w_numdeciimp = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DIM'
       and pa_producto = 'AHO'
  end
  else
    select
      @w_ndci = 0,
      @w_numdeciimp = 0

  /* Valida la fecha efectiva */
  if @i_fecha_efec >= @i_fecha
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 251020
    return 251020
  end

  --Busqueda de Pais
  select
    @w_codigo_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @@rowcount = 0
  begin
    /** No existe parametro de pais local **/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101190
    return 101190
  end

  select
    @w_binc = isnull(pa_money,
                     0)
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'BINCR'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @i_num = 201196,
      @i_msg = 'ERROR EN PARAMETRO DE BASE DIARIA'
    return 201196
  end

  /*  Determinacion de bloqueo de cuenta  */
  select
    @w_tipo_bloqueo = cb_tipo_bloqueo
  from   cob_ahorros..ah_ctabloqueada
  where  cb_cuenta = @i_cuenta
     and cb_estado = 'V'
     and cb_tipo_bloqueo in ('1', '3')

  if @@rowcount <> 0
  begin
    select
      @w_mensaje = rtrim(valor)
    from   cobis..cl_catalogo
    where  cobis..cl_catalogo.tabla  = (select
                                          cobis..cl_tabla.codigo
                                        from   cobis..cl_tabla
                                        where  tabla = 'cc_tbloqueo')
       and cobis..cl_catalogo.codigo = @w_tipo_bloqueo
    select
      @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 251007,
      @i_sev  = 1,
      @i_msg  = @w_mensaje
    return 251007
  end

  /*  Actualizacion de saldos  */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @i_cuenta,
    @i_fecha            = @i_fecha,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_contable out,
    @o_saldo_max        = @w_saldo_max out
  /* Recibimos  el saldo Maximo para la cuenta */

  if @w_return <> 0
    return @w_return

  /* lee tabla de ctas de ahorros */
  select
    @w_tipo_prom = ah_tipo_promedio,
    @w_fecha_aper = convert (varchar(10), ah_fecha_aper, 101),
    @w_disponible = ah_disponible,
    @w_creditos = ah_creditos,
    @w_credhoy = ah_creditos_hoy,
    @w_promedio1 = ah_promedio1,
    @w_prom_disp = ah_prom_disponible,
    @w_tipo_ente = ah_tipocta,
    @w_rol_ente = ah_rol_ente,
    @w_tipo_def = ah_tipo_def,
    @w_default = ah_default,
    @w_personalizada = ah_personalizada,
    @w_prod_banc = ah_prod_banc,
    @w_producto = ah_producto,
    @w_tipo = ah_tipo,
    @w_moneda = ah_moneda,
    @w_cta = ah_cta_banco,
    @w_categoria = ah_categoria,
    @w_estado = ah_estado,
    @w_fecha_ult_capi = convert(varchar(10), ah_fecha_ult_capi, 101),
    --JAR  19/01/2010
    @w_ncredmes = isnull(ah_num_cred_mes,
                         0),
    @w_clase_clte = isnull(ah_clase_clte,
                           'P'),
    @o_nombre = substring (ah_nombre,
                           1,
                           60),
    @o_cedula = ah_ced_ruc,
    @o_cliente = ah_cliente,
    @o_oficial = ah_oficial,
    @o_ofi_cta = ah_oficina,
    @o_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @i_cuenta

  if @w_fecha_aper > @i_fecha_efec
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 251054
    return 251054
  end

  /* REQ 306 - SI LA CUENTA ESTA EN ESTADO ANULADA */

  if @w_estado = 'N'
  begin
    exec cobis..sp_cerror -- 251096 Tiempo para primer deposito concluido
      @t_from = @w_sp_name,
      @i_num  = 251096,
      @i_sev  = 0

    return 251096
  end

  /* REQ 306 - SI CUENTA EN ESTADO INGRESADA, VALIDAR MONTO PRIMER DEPOSITO */
  if @w_estado = 'G'
  begin
    exec @w_return = cob_remesas..sp_genera_costos
      @i_categoria   = @w_categoria,
      @i_tipo_ente   = @w_tipo_ente,
      @i_rol_ente    = @w_rol_ente,
      @i_tipo_def    = @w_tipo_def,
      @i_prod_banc   = @w_prod_banc,
      @i_producto    = @w_producto,
      @i_moneda      = @w_moneda,
      @i_tipo        = 'R',
      @i_codigo      = @w_default,
      @i_servicio    = 'MMAP',
      @i_rubro       = '39',
      @i_disponible  = $0,
      @i_contable    = $0,
      @i_promedio    = $0,
      @i_personaliza = @w_personalizada,
      @i_filial      = @i_filial,
      @i_oficina     = @s_ofi,
      @i_fecha       = @s_date,
      @o_valor_total = @w_deposito_min out
    if @w_return <> 0
      return @w_return

    if @w_deposito_min is null
    begin
      exec cobis..sp_cerror -- 251097 Monto deposito inicial no existe
        @t_from = @w_sp_name,
        @i_num  = 251097,
        @i_sev  = 0

      return 251097
    end

    if @i_efe < @w_deposito_min
    begin
      exec cobis..sp_cerror
        -- 251098 Monto depositado inferior al monto minimo establecido
        @t_from = @w_sp_name,
        @i_num  = 251098,
        @i_sev  = 0

      return 251098
    end
  end

  --Ini JAR 18/01/2010
  /* Si fecha de ultima capitalizacion es superior a fecha efectiva generar credito */

  if @w_fecha_ult_capi <= @i_fecha_efec
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251054,
      @i_msg   = 'FECHA ULTIMA CAPITALIZACION MENOR A FECHA EFECTIVA'
    return 251054
  end
  --Fin JAR 18/01/2010

  /* Encuentra numero de dias desde fecha efectiva hasta hoy */
  select
    @w_num_dias = datediff (day,
                            @i_fecha_efec,
                            @i_fecha)

  /* SMHB: Transacciones Inusuales    */
  select
    @w_ncredmes = @w_ncredmes + (1 * @i_factor)

  /* Encuentra numero de dias del anio */
  select
    @w_dias_anio = isnull(pa_smallint,
                          0)
  from   cobis..cl_parametro
  where  pa_nemonico = 'DIA'
     and pa_producto = 'ADM'

  /* Encuentra el primero del mes actual */
  select
    @w_fecha_tmp = (convert(char(2), datepart(mm, @i_fecha)) + '/01/'
                    + convert(char(4), datepart(yy, @i_fecha)))

  if @i_fecha_efec > @w_fecha_tmp
    select
      @w_fecha_tmp = @i_fecha_efec

  /* Encuentra la alicuota para el promedio */
  select
    @w_alicuota = fp_alicuota
  from   cob_ahorros..ah_fecha_promedio
  where  fp_tipo_promedio = @w_tipo_prom
     and fp_fecha_inicio  = convert(smalldatetime, @w_fecha_tmp)

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 251013
    return 251013
  end

  if @t_trn = 315
    select
      @i_credit = 0

  select
    @w_interes_acum = 0.0,
    @w_capital_acum = 0,
    @i_efe = isnull (@i_efe,
                     0),
    @i_loc = isnull (@i_loc,
                     0),
    @i_credit = isnull (@i_credit,
                        0),
    @i_plaz = isnull (@i_plaz,
                      0),
    @w_sldtmp = isnull (@w_sldtmp,
                        0),
    @w_sldtmp1 = isnull (@w_sldtmp1,
                         0),
    @w_tasa = isnull (@w_tasa,
                      0)

  /* Proceso de fecha efectiva para Ahorro Tradicional */

  select
    @w_ajuste_interes = 0,
    @w_retfte_tot = 0,
    @w_interes_acum = 0,
    @w_retfte_acum = 0

  if @w_codigo_pais = 'CO'
  begin
    select
      @w_cpto_rte = ci_concepto
    from   cob_remesas..re_concepto_imp
    where  ci_tran        = 308--Revisar trn
       and ci_impuesto    = 'R' --Verificar nemonico tipo de impuesto
       and ci_contabiliza = 'tm_valor'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 201196,
        @i_msg = 'ERROR EN PARAMETRO DE CONCEPTO DE RETENCION'
      return 201196
    end

    select
      @w_retencion = isnull(en_retencion,
                            'N')
    from   cobis..cl_ente
    where  en_ente = @o_cliente

    if @@rowcount = 0
    begin
      /* Error en insercion de transaccion servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 121032
      return 121032
    end

    select
      @w_dias_int = abs(datediff(dd,
                                 @i_fecha,
                                 @i_fecha_efec))
    select
      @w_base_rtfte = @w_dias_int * @w_binc

  end
  else
    select
      @w_cpto_rte = null

  /* Procesa las transacciones con fecha efectiva */
  select
    @w_contador = 0

  while @w_contador <= (@w_num_dias - 1)
  begin
    select
      @w_fecha_tmp = dateadd(day,
                             @w_contador,
                             @i_fecha_efec)
    if @w_debug = 'S'
      print 'fecha tem ' + cast (@w_fecha_tmp as varchar)
    if @w_fecha_tmp <> @i_fecha
    begin
      /* Encuentra tasa de interes de la fecha temporal */
      select
        @w_fecha_aux = max(sd_fecha)
      from   cob_ahorros_his..ah_saldo_diario
      where  sd_cuenta = @i_cuenta
         and sd_fecha  <= @w_fecha_tmp

      select
        @w_tasa = sd_tasa_disponible,
        @w_sldtmp = isnull(sd_saldo_disponible,
                           0)
      from   cob_ahorros_his..ah_saldo_diario
      where  sd_cuenta = @i_cuenta
         and sd_fecha  = @w_fecha_aux
    end
    else
      select
        @w_tasa = 0

    select
      @w_sldtmp1 = @w_sldtmp + @i_efe + @i_loc + @i_plaz + @i_credit

    if @w_debug = 'S'
      print 'saldo temp 1 ' + cast(@w_sldtmp1 as varchar)
    exec @w_return = cob_remesas..sp_genera_costos
      @s_srv         = @s_srv,
      @s_ofi         = @s_ofi,
      @s_ssn         = @s_ssn,
      @s_user        = @s_user,
      @i_filial      = @i_filial,
      @i_oficina     = @i_ofi,
      @i_categoria   = @w_categoria,
      @i_tipo_ente   = @w_tipo_ente,
      @i_rol_ente    = @w_rol_ente,
      @i_tipo_def    = @w_tipo_def,
      @i_prod_banc   = @w_prod_banc,
      @i_producto    = @w_producto,
      @i_moneda      = @w_moneda,
      @i_tipo        = @w_tipo,
      @i_codigo      = @w_default,
      @i_servicio    = 'PINT',
      @i_rubro       = '18',
      @i_fecha       = @w_fecha_tmp,
      @i_disponible  = @w_sldtmp1,
      @i_contable    = @w_sldtmp1,
      @i_promedio    = @w_promedio1,
      @i_personaliza = @w_personalizada,
      @i_prom_disp   = @w_prom_disp,
      @o_valor_total = @w_tasa_efectiva out

    if @w_return <> 0
      return @w_return

    if @w_debug = 'S'
      print 'tasa efe ' + cast(@w_tasa_efectiva as varchar)

    select
      @w_diftasa = @w_tasa_efectiva - @w_tasa

    --Convierte a tasa nominal (diaria)
    select
      @w_factor1 = 1 + @w_tasa_efectiva
    select
      @w_factor2 = (convert(float, 1)) / @w_dias_anio
    /*calculo del factor para 1 dia */
    select
      @w_factor = (power (@w_factor1,
                          @w_factor2)) - 1

    select
      @w_interes_acum = (@w_capital_acum + @i_efe + @i_credit) * @w_factor

    if @w_codigo_pais <> 'CO'
    begin
    /* Encotrar los parametros de personalizacion */
      /* Tasa para la tasa de PINT para retencion en la fuente */
      exec @w_return = cob_remesas..sp_genera_costos
        @s_srv         = @s_srv,
        @s_ofi         = @s_ofi,
        @s_ssn         = @s_ssn,
        @s_user        = @s_user,
        @t_debug       = 'N',
        @t_file        = null,
        @t_from        = @w_sp_name,
        @i_filial      = @i_filial,
        @i_oficina     = @i_ofi,
        @i_fecha       = @w_fecha_tmp,
        @i_valor       = 1,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipo_ente,
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_def,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @w_producto,
        @i_moneda      = @w_moneda,
        @i_tipo        = @w_tipo,
        @i_codigo      = @w_default,
        @i_servicio    = 'PINT',
        @i_rubro       = '19',
        @i_disponible  = @w_sldtmp1,
        @i_contable    = @w_contable,
        @i_promedio    = @w_promedio1,
        @i_prom_disp   = @w_prom_disp,
        @i_personaliza = @w_personalizada,
        @o_valor_total = @w_tasa_ret out

      if @w_return <> 0
        return @w_return

      if @w_debug = 'S'
        print 'tasa retenc ' + cast(@w_tasa_ret as varchar)
      /* Calculo para hallar valor de retencion sobre intereses */
      select
        @w_retfte_acum = round(@w_interes_acum * @w_tasa_ret,
                               isnull(@w_numdeciimp,
                                      0))

    end

    select
      @w_retfte_tot = @w_retfte_tot + @w_retfte_acum,
      @w_ajuste_interes = @w_ajuste_interes + @w_interes_acum

    if @w_debug = 'S'
      print 'retenciontot ' + cast(@w_retfte_tot as varchar)

    select
      @w_capital_acum = @w_capital_acum + @w_interes_acum

    if @w_debug = 'S'
      print 'capital ' + cast(@w_capital_acum as varchar)

    select
      @w_interes_acum = 0,
      @w_retfte_acum = 0,
      @w_contador = @w_contador + 1
  end

  if @w_codigo_pais = 'CO'
  begin
    if @w_cpto_rte is not null
       and @w_capital_acum >= @w_base_rtfte
    begin
      --Calculo tasa retefuente - interfaz con contabilidad en variable @w_tasa_impuesto
      exec @w_return = cob_interfase..sp_icon_impuestos
        @i_empresa      = @i_filial,
        @i_concepto     = @w_cpto_rte,
        @i_debcred      = 'D',
        @i_monto        = @w_capital_acum,
        @i_impuesto     = 'R',--Verificar nemonico tipo de impuesto
        @i_oforig_admin = @o_ofi_cta,
        @i_ofdest_admin = @o_ofi_cta,
        @i_ente         = @o_cliente,
        @i_producto     = 4,
        @o_exento       = @w_exento out,
        @o_porcentaje   = @w_porcentaje out

      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 121032
        return 121032
      end

      if @w_exento = 'N'
        select
          @w_tasa_ret = (@w_porcentaje / 100)
      else
        select
          @w_tasa_ret = 0

      /* Calculo para hallar valor de retencion sobre intereses */
      select
        @w_retfte_tot = round(@w_capital_acum * @w_tasa_ret,
                              isnull(@w_numdeciimp,
                                     0))

    end
  end

  select
    @w_ajuste_interes = round(@w_ajuste_interes,
                              @w_ndci),
    @w_capital_acum = round(@w_capital_acum,
                            @w_ndci)

  select
    @w_tot = @i_efe + @i_credit
  select
    @w_tot_alic = round(@w_tot * @w_alicuota,
                        @w_ndci)

  select
    @w_disponible = @w_disponible + (@w_tot * @i_factor),
    @w_prom_disp = @w_prom_disp + (@w_tot_alic * @i_factor),
    @w_promedio1 = @w_promedio1 + (@w_tot_alic * @i_factor),
    @w_creditos = @w_creditos + (@w_tot * @i_factor),
    @w_credhoy = @w_credhoy + (@w_tot * @i_factor),
    @w_saldo_para_girar = @w_saldo_para_girar + @w_tot * @i_factor,
    @w_contable = @w_contable + @w_tot * @i_factor

  /*** Validamos el saldo maximo de la cuenta JLOYO *****/
  if @w_saldo_max > 0
     and @w_contable > @w_saldo_max
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 252077
    /**** EL CREDITO ALA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO ***/
    return 1
  end
  begin tran
  update cob_ahorros..ah_cuenta
  set    ah_disponible = @w_disponible,
         ah_promedio1 = @w_promedio1,
         ah_prom_disponible = @w_prom_disp,
         ah_creditos = @w_creditos,
         ah_creditos_hoy = @w_credhoy,
         ah_fecha_ult_mov = @i_fecha,
         ah_contador_trx = ah_contador_trx + @i_factor,
         /*FRC-AHO-017-CobroComisiones CMU 2102110*/
         ah_num_cred_mes = @w_ncredmes
  where  ah_cuenta = @i_cuenta
  if @@rowcount <> 1
      or @@error <> 0
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 255001
    return 255001
  end

  select
    @o_sldcont = @w_contable,
    @o_slddisp = @w_disponible,
    @o_aj_int = @w_ajuste_interes,
    @o_aj_cap = @w_capital_acum,
    @o_aj_ret = @w_retfte_tot,
    @o_fecha = convert(char(10), @i_fecha, 101) + ' ' + convert(char(8), getdate
               (
               )
               , 8),
    @o_prod_banc = @w_prod_banc,
    @o_categoria = @w_categoria,
    @o_clase_clte = @w_clase_clte

  /* Disparar las notas de credito por ajuste de intereses */

  if @w_capital_acum <> 0
  begin
    if @w_capital_acum > $0
    begin
      if @i_factor = 1
      begin
        exec @w_return = cob_ahorros..sp_ahndc_automatica
          @s_srv        = @s_srv,
          @s_ofi        = @s_ofi,
          @s_ssn        = @s_ssn,
          @s_user       = @s_user,
          @s_ssn_branch = @s_ssn_branch,
          @t_trn        = 253,
          @i_cta        = @w_cta,
          @i_val        = @w_capital_acum,
          @i_cau        = '47',--ABONO INTERESE RECALCULADOS
          @i_mon        = @i_mon,
          @i_fecha      = @i_fecha,
          @i_alt        = 10,
          @i_canal      = 4,-- ERP 04/May/2001 
          @i_clase_clte = @w_clase_clte -- MVE AH00007

        if @w_return <> 0
          return @w_return

        if @w_retfte_tot > 0
        begin
          exec @w_return = cob_ahorros..sp_ahndc_automatica
            @s_srv        = @s_srv,
            @s_ofi        = @s_ofi,
            @s_ssn        = @s_ssn,
            @s_user       = @s_user,
            @s_ssn_branch = @s_ssn_branch,
            @t_trn        = 264,
            @i_cta        = @w_cta,
            @i_val        = @w_retfte_tot,
            @i_cau        = '182',--COBRO RETEFUENTE
            @i_mon        = @i_mon,
            @i_fecha      = @i_fecha,
            @i_alt        = 11,
            @i_canal      = 4 -- ERP 04/May/2001 

          if @w_return <> 0
            return @w_return
        end
      end
      else
      begin
        exec @w_return = cob_ahorros..sp_ahndc_automatica
          @s_srv        = @s_srv,
          @s_ofi        = @s_ofi,
          @s_ssn        = @s_ssn,
          @s_user       = @s_user,
          @t_trn        = 253,
          @s_ssn_branch = @s_ssn_branch,
          @t_corr       = @t_corr,
          @t_ssn_corr   = @t_ssn_corr,
          @i_cta        = @w_cta,
          @i_val        = @w_capital_acum,
          @i_cau        = '47',--REV. INTERESES
          @i_mon        = @i_mon,
          @i_alt        = 10,
          @i_fecha      = @i_fecha,
          @i_canal      = 4 -- ERP 04/May/2001  

        if @w_return <> 0
          return @w_return

        if @w_retfte_tot > 0
        begin
          exec @w_return = cob_ahorros..sp_ahndc_automatica
            @s_srv        = @s_srv,
            @s_ofi        = @s_ofi,
            @s_ssn        = @s_ssn,
            @s_user       = @s_user,
            @s_ssn_branch = @s_ssn_branch,
            @t_corr       = @t_corr,
            @t_ssn_corr   = @t_ssn_corr,
            @t_trn        = 264,
            @i_cta        = @w_cta,
            @i_val        = @w_retfte_tot,
            @i_cau        = '182',--REV. RETEFUENTE
            @i_mon        = @i_mon,
            @i_fecha      = @i_fecha,
            @i_alt        = 11,
            @i_canal      = 4 -- ERP 04/May/2001 

          if @w_return <> 0
            return @w_return
        end
      end
    end
    else if @w_capital_acum < $0
    begin
      select
        @w_capital_acum = @w_capital_acum * -1
      if @i_factor = 1
      begin
        exec @w_return = cob_ahorros..sp_ahndc_automatica
          @s_srv        = @s_srv,
          @s_ofi        = @s_ofi,
          @s_ssn        = @s_ssn,
          @s_user       = @s_user,
          @s_ssn_branch = @s_ssn_branch,
          @t_trn        = 264,
          @i_cta        = @w_cta,
          @i_val        = @w_capital_acum,
          @i_cau        = '91',
          @i_mon        = @i_mon,
          @i_alt        = 10,
          @i_fecha      = @i_fecha,
          @i_canal      = 4 -- ERP 04/May/2001 

        if @w_return <> 0
          return @w_return

        if @w_retfte_tot > 0
        begin
          exec @w_return = cob_ahorros..sp_ahndc_automatica
            @s_srv        = @s_srv,
            @s_ofi        = @s_ofi,
            @s_ssn        = @s_ssn,
            @s_user       = @s_user,
            @s_ssn_branch = @s_ssn_branch,
            @t_trn        = 253,
            @i_cta        = @w_cta,
            @i_val        = @w_retfte_tot,
            @i_cau        = '142',
            @i_mon        = @i_mon,
            @i_fecha      = @i_fecha,
            @i_alt        = 11,
            @i_canal      = 4 -- ERP 04/May/2001 

          if @w_return <> 0
            return @w_return
        end
      end
      else
      begin
        exec @w_return = cob_ahorros..sp_ahndc_automatica
          @s_srv        = @s_srv,
          @s_ofi        = @s_ofi,
          @s_ssn        = @s_ssn,
          @s_user       = @s_user,
          @s_ssn_branch = @s_ssn_branch,
          @t_trn        = 253,
          @i_cta        = @w_cta,
          @i_val        = @w_capital_acum,
          @i_ind        = 1,
          @i_cau        = '18',
          @i_mon        = @i_mon,
          @i_alt        = 10,
          @i_fecha      = @i_fecha,
          @i_canal      = 4 -- ERP 04/May/2001 

        if @w_return <> 0
          return @w_return

        if @w_retfte_tot > 0
        begin
          exec @w_return = cob_ahorros..sp_ahndc_automatica
            @s_srv        = @s_srv,
            @s_ofi        = @s_ofi,
            @s_ssn        = @s_ssn,
            @s_user       = @s_user,
            @s_ssn_branch = @s_ssn_branch,
            @t_trn        = 264,
            @i_cta        = @w_cta,
            @i_val        = @w_retfte_tot,
            @i_cau        = '89',
            @i_mon        = @i_mon,
            @i_fecha      = @i_fecha,
            @i_alt        = 11,
            @i_canal      = 4 -- ERP 04/May/2001 

          if @w_return <> 0
            return @w_return
        end
      end
    end
  end

  /* Activa los cobros de valores en suspenso */
  if @w_suspensos > 0
     and @i_factor = 1
  begin
    select
      @w_contador = 1,
      @w_interes_acum = 0
    while @w_contador <= @w_suspensos
    begin
      set rowcount 1
      select
        @w_valor = vs_valor,
        @w_secuencial = vs_secuencial,
        @w_clave = vs_clave
      from   cob_ahorros..ah_val_suspenso
      where  vs_cuenta    = @i_cuenta
         and vs_procesada = 'N'
         and vs_valor     = (select
                               min(vs_valor)
                             from   cob_ahorros..ah_val_suspenso
                             where  vs_cuenta    = @i_cuenta
                                and vs_procesada = 'N')
      if @@rowcount = 0
      begin
        commit tran
        return 0
      end
      set rowcount 0

      select
        @w_interes_acum = @w_interes_acum + @w_valor

      update cob_ahorros..ah_val_suspenso
      set    vs_procesada = 'S',
             vs_fecha = @i_fecha
      where  vs_cuenta     = @i_cuenta
         and vs_secuencial = @w_secuencial
      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 205013
        return 205013
      end

      if @w_interes_acum >= @w_saldo_para_girar
      begin
        commit tran
        return 0
      end

      select
        @w_contador = @w_contador + 1
    end
  end

  if @t_ejec = 'R' /*BBO BRANCH II 06101999*/
  begin
    exec @w_return = cob_ahorros..sp_resultados_branch_ah
      @s_ssn_host    = @s_ssn,
      @i_cuenta      = @i_cuenta,
      @i_fecha       = @i_fecha,
      @i_ofi         = @s_ofi,
      @i_cedula      = @o_cedula,
      @i_tipo_cuenta = 'O'
    if @w_return <> 0
      return @w_return
  end

  commit tran
  return 0

go

