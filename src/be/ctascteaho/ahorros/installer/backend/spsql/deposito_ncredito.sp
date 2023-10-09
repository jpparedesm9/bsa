/************************************************************************/
/*  Archivo:                deposito_ncredito.sp                        */
/*  Stored procedure:       sp_deposito_ncredito                        */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                 */
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
/*                              PROPOSITO                               */
/*  Este programa procesa las transacciones de depositos con libreta    */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR           RAZON                               */
/*  25/Feb/1993     J. Navarrete    Emision inicial                     */
/*  16/Ene/1996     J. Cadena       Personalizacion B. de Prestamos     */
/*  20/Jun/2001     R. Penarreta    Branch II                           */
/*  18/Mar/2005     L. Bernuil      Validacion de fecha de              */
/*                                  ultimo Movimiento.                  */
/*  21/ene/2010     CMunoz          FRC-AHO-017-CobroComisiones         */
/*  04/Feb/2010     J.Loyo          Validacion de Saldo Maximo          */
/*                                  para la cuenta                      */
/*  17/Feb/2010     J. Loyo         Manejo de la fecha de efectivizacion*/
/*                                  teniendo el sabado como habil       */
/*  03/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO        */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_deposito_ncredito')
  drop proc sp_deposito_ncredito
go

/****** Object:  StoredProcedure [dbo].[sp_deposito_ncredito]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_deposito_ncredito
(
  @s_ssn           int,
  @s_ssn_branch    int = null,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int = null,
  @s_term          varchar(10),
  @s_ofi           smallint,
  @s_rol           smallint,
  @s_org           char(1),
  @s_date          datetime = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(30) = null,
  @t_trn           int,
  @t_ejec          char(1) = null,
  @t_corr          char(1) = null,
  @t_ssn_corr      int = null,
  @t_show_version  bit = 0,
  @i_cuenta        int,
  @i_efe           money,
  @i_prop          money,
  @i_loc           money,
  @i_plaz          money,
  @i_mon           tinyint,
  @i_sldlib        money,
  @i_nctrl         int,
  @i_credit        money,
  @i_ind           tinyint,
  @i_factor        smallint,
  @i_fecha         smalldatetime,
  @i_ncontrol      int,
  @i_lpend         int,

  --CCR BRANCH III
  @i_fecha_valor_a datetime = null,
  @i_usateller     char(1) = 'N',
  @i_cau           char(3),
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_control       int out,
  @o_nombre        varchar(50) out,
  @o_cliente       int = null out,
  @o_patente       varchar(40) = null out,
  @o_int_cap       money out,
  @o_lineas        int out,
  @o_usa           char(1) out,
  @o_sldlib        money out,
  @o_nctrl         smallint out,
  @o_prod_banc     smallint out,
  @o_categoria     char(1) out,
  @o_clase_clte    char(1) = null out,
  @o_tipocta_super char(1) out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_alicuota         float,
    @w_fecha            datetime,
    @w_numdeci          tinyint,
    @w_periodo          tinyint,
    @w_cta_banco        cuenta,
    @w_cliente          int,
    @w_saldo_libreta    money,
    @w_tot_alic         float,
    @w_dis_alic         float,
    @w_tot              money,
    @w_disponible       money,
    @w_suspensos        smallint,
    @w_contador         smallint,
    @w_secuencial       int,
    @w_acum             money,
    @w_clave            int,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_promedio1        money,
    @w_24h              money,
    @w_12h              money,
    @w_48h              money,
    @w_valor            money,
    @w_creditos         money,
    @w_int_cap          money,
    @w_control          int,
    @w_sec              int,
    @w_linea            smallint,
    @w_nemo             char(4),
    @w_capita           char(1),
    @w_rem_hoy          money,
    @w_remesas          money,
    @w_mensaje          mensaje,
    @w_tipo_bloqueo     char(3),
    @w_tipo_prom        char(1),
    @w_usadeci          char(1),
    @w_prom_disp        money,
    @w_nctrl            smallint,
    @w_debitos          money,
    @w_contador_trx     int,
    @w_fapert           smalldatetime,
    @w_fultmv           smalldatetime,
    @w_dep_ini          tinyint,
    @w_cont             tinyint,
    @w_dias_ret         tinyint,
    @w_fecha_efe        smalldatetime,
    @w_ciudad           int,
    @w_tipocta          char(1),
    @w_oficif           smallint,
    @w_cuota            money,
    @w_msg              char(60),
    @w_cod_prdnav       smallint,
    @w_mult             money,
    @w_suma             money,
    @w_moneda_local     tinyint,
    @w_num_cuoprdnav    tinyint,
    /*LBM */
    @w_act_fecha        char(1),
    @w_fecha_ult_mov    datetime,--LBM    
    @w_hora_ejecucion   smalldatetime,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ncredmes         int,
    @w_tipo_ente        char(1),
    @w_rol_ente         char(1),
    @w_tipo_def         char(1),
    @w_producto         tinyint,
    @w_tipo             char(1),
    @w_codigo           int,
    @w_personaliza      char(1),
    @w_filial           tinyint,
    @w_cobro_comision   money,
    @w_oficina          smallint,
    @w_valiva_tarifa    money,
    @w_ndebmes          int,
    @w_numdeb           int,
    @w_numtot           int,
    @w_numero           int,
    @w_numcre           int,
    @w_numco            int,
    /** Validacion saldo Maximo ***/
    @w_saldo_max        money,
    @w_tipocobro        char(1),
    @w_codigo_pais      char(3),
    -- REQ 306 VALIDA DEPOSITO INICIAL
    @w_estado           char(1),
    @w_causal_depini    varchar(3)
  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_deposito_ncredito'
  select
    @w_hora_ejecucion = convert(varchar(5), getdate(), 108)

  --print @w_sp_name

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      t_file = @t_file,
      t_from = @t_from,
      i_cuenta = @i_cuenta,
      i_mon = @i_mon,
      i_efe = @i_efe,
      i_prop = @i_prop,
      i_loc = @i_loc,
      i_plaz = @i_plaz,
      i_sldlib = @i_sldlib,
      i_nctrl = @i_nctrl,
      i_credit = @i_credit,
      i_ind = @i_ind,
      i_factor = @i_factor,
      i_fecha = @i_fecha
    exec cobis..sp_end_debug
  end

  /* LBM -- Colocarle el valor default a la variable @w_act_fecha */
  select
    @w_act_fecha = 'S'

  /* Encuentra parametro de decimales */
  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_usadeci = 'S'
  begin
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DCI'
       and pa_producto = 'AHO'
  end
  else
    select
      @w_numdeci = 0

  select
    @w_codigo_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @w_codigo_pais is null
    select
      @w_codigo_pais = 'PA'

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
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251007,
      @i_sev   = 1,
      @i_msg   = @w_mensaje
    return 1
  end

  /*  Calcula los Saldos  */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @i_cuenta,
    @i_fecha            = @i_fecha,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out,
    @o_saldo_max        = @w_saldo_max out
  /* Recibimos  el saldo MAximo para la cuenta */
  if @w_return <> 0
    return @w_return

  /*LBM -- Verificamos la tabla re_propiedad_ndc para establecer si se afecta la fecha de ultimo movimiento */
  if @t_trn = 255
     and @i_factor = 1
  begin
    select
      @w_act_fecha = pr_act_fecha
    from   cob_remesas..re_propiedad_ndc
    where  pr_producto = 4
       and pr_signo    = 'C'
       and pr_causa    = @i_cau

    if @@rowcount = 0
      select
        @w_act_fecha = 'S'
  end

  /* lee tabla de ctas de ahorros */
  select
    @w_rem_hoy = ah_rem_hoy,
    @w_remesas = ah_remesas,
    @w_tipo_prom = ah_tipo_promedio,
    @o_nombre = substring(ah_nombre,
                          1,
                          50),
    @w_cliente = ah_cliente,
    @o_patente = ah_patente,
    @w_12h = ah_12h,
    @w_24h = ah_24h,
    @w_48h = ah_48h,
    @w_int_cap = ah_interes_ganado,
    @w_cta_banco = ah_cta_banco,
    @w_disponible = ah_disponible,
    @w_linea = ah_linea,
    @w_control = ah_control,
    @w_creditos = ah_creditos,
    @w_capita = ah_capitalizacion,
    @w_saldo_libreta = ah_saldo_libreta,
    @w_promedio1 = ah_promedio1,
    @w_prom_disp = ah_prom_disponible,
    @w_contador_trx = ah_contador_trx,
    @w_fapert = ah_fecha_aper,
    @w_fultmv = ah_fecha_ult_mov,
    @w_debitos = ah_debitos,
    @w_dep_ini = ah_dep_ini,
    @w_fecha_ult_mov = ah_fecha_ult_mov,--LBM  
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @w_tipocta = ah_tipocta,
    @o_tipocta_super = ah_tipocta_super,
    @o_clase_clte = ah_clase_clte,
    @w_cuota = ah_cuota,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ncredmes = isnull(ah_num_cred_mes,
                         0),
    @w_tipo_ente = ah_tipocta,
    @w_rol_ente = ah_rol_ente,
    @w_tipo_def = ah_tipo_def,
    @w_producto = ah_producto,
    @w_tipo = ah_tipo,
    @w_codigo = ah_default,
    @w_personaliza = ah_personalizada,
    @w_filial = ah_filial,
    @w_oficina = ah_oficina,
    @w_estado = ah_estado
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @i_cuenta
     and ah_moneda = @i_mon

  select
    @o_cliente = @w_cliente

  /* REQ 306 DEPOSITO INICIAL APERTURA AHO */
  if @t_trn = 251
    select
      @w_causal_depini = @i_cau
  else
    select
      @w_causal_depini = '0'

  exec @w_return = cob_ahorros..sp_ah_trn_depo_inicial
    @t_file       = @t_file,
    @t_debug      = @t_debug,
    @t_trn        = @t_trn,
    @i_correccion = @t_corr,
    @i_ssn_branch = @s_ssn_branch,--SECUENCIAL BRANCH
    @i_ssn_corr   = @t_ssn_corr,--SECUENCIAL TRN REVERSADA
    @i_cta_banco  = @w_cta_banco,
    @i_causal     = @w_causal_depini,
    @i_moneda     = 0,
    @i_estado     = @w_estado,
    @i_oficina    = @w_oficina

  if @w_return <> 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251101 /**** ERROR EN VALIDACION DEPOSITO INICIAL ***/
    return 251101
  end
  /* FIN - REQ 306 DEPOSITO INICIAL APERTURA AHO */

  if @w_tipocta = 'I'
  begin
    select
      @w_oficif = oc_oficina
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
      return 1
    end
  end

  if @w_dep_ini <> 0
  begin
    /* Error cuenta sin depositos */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201158
    return 1
  end

  select
    @w_moneda_local = pa_tinyint -- lgr
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CMNAC'

  if (@t_trn = 252
       or @t_trn = 251
       or @t_trn = 207
       or @t_trn = 246
       or @t_trn = 248)
  begin
    /*if @i_mon = @w_moneda_local and (@i_plaz <> $0)   
    begin
          exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 205062
          return 205062
    end
    */

    select
      @w_cod_prdnav = pa_smallint
    from   cobis..cl_parametro
    where  pa_nemonico = 'PRDNAV'
       and pa_producto = 'AHO'

    select
      @w_num_cuoprdnav = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'CUOTA'
       and pa_producto = 'AHO'

    if @w_cod_prdnav = @o_prod_banc
    begin
      if @t_trn not in (253, 255)
      begin
        if @i_factor = 1
        begin
          if @w_disponible + @i_efe > @w_cuota * @w_num_cuoprdnav
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 257004
            return 257004
          end
        end
      end
    end

  end

  select
    @o_lineas = 0,
    @o_sldlib = 0
  /* Valida datos de entrada */
  if @t_trn = 251
      or @t_trn = 255
  begin
    if @w_control <> @i_nctrl
       and @i_factor = 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251004
      return 1
    end
    if convert(char(30), @w_saldo_libreta) <> convert(char(30), @i_sldlib)
       and @i_factor = 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251005
      return 1
    end

    select
      @w_cod_prdnav = pa_smallint
    from   cobis..cl_parametro
    where  pa_nemonico = 'PRDNAV'
       and pa_producto = 'AHO'

    if @o_prod_banc = @w_cod_prdnav
    begin
      if @i_prop > 0
          or @i_loc > 0
          or @i_plaz > 0
      begin
        /* Error en la cuota */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205061
        --@i_msg     = 'SOLO EFECTIVO ACEPTA LA CUENTA NAVIDEÑA'
        return 1
      end

      if @i_efe < @w_cuota --lgr
      begin
        /* Error en la cuota */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205056
        --@i_msg     = 'CUOTA NO CORRESPONDE A LA CUENTA NAVIDEÑA'
        return 1

      end

      if @i_efe >= @w_cuota --lgr
      begin
        select
          @w_suma = @i_efe / @w_cuota
        select
          @w_suma = round(@w_suma,
                          0)
        select
          @w_mult = @w_suma * @w_cuota

        if @i_efe <> @w_mult
        begin
          /* Error en la cuota */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 205056
          --@i_msg     = 'CUOTA NO CORRESPONDE A LA CUENTA NAVIDEÑA' 
          return 1
        end

      end
    end

    if @w_linea > 0
       and @i_factor = 1
    begin
      exec @w_return = cob_ahorros..sp_ah_actlibsp
        @s_ssn      = @s_ssn,
        @s_srv      = @s_srv,
        @s_lsrv     = @s_lsrv,
        @s_user     = @s_user,
        @s_sesn     = @s_sesn,
        @s_term     = @s_term,
        @s_date     = @i_fecha,
        @s_ofi      = @s_ofi,
        @s_rol      = @s_rol,
        @s_org      = @s_org,
        @p_sp       = 'S',
        @t_trn      = @t_trn,
        @i_cta      = @w_cta_banco,
        @i_sld_lib  = @w_saldo_libreta,
        @i_nctrl    = @w_control,
        @i_mon      = @i_mon,
        @i_usateller= @i_usateller,
        @o_sldlib   = @w_saldo_libreta out,
        @o_num      = @o_lineas out,
        @o_nctrl    = @o_nctrl out

      select
        @o_sldlib = @w_saldo_libreta
      if @i_usateller = 'N'
      begin
        if @w_return <> 2
            or @o_lineas > 0
        begin
          return @w_return
        end
        select
          @w_linea = 0,
          @w_return = 0
      end
      else
      begin
        if @w_return <> 0
        begin
          return @w_return
        end
        select
          @w_linea = @o_lineas,
          @w_return = 0
      end
    end
    else
      select
        '',
        '',
        '',
        '',
        '',
        ''
  end

  /* Envia Interes Ganado */
  select
    @o_usa = ul_usa
  from   cob_ahorros..ah_usa_linea
  where  ul_capitalizacion = @w_capita

  select
    @o_int_cap = $0
  if @w_int_cap <> $0
     and @o_usa = 'N'
  begin
    select
      @o_int_cap = @w_int_cap
    select
      @w_int_cap = $0
  end

  /* Encuentra la alicuota para el promedio */
  select
    @w_alicuota = fp_alicuota
  from   cob_ahorros..ah_fecha_promedio
  where  fp_tipo_promedio = @w_tipo_prom
     and fp_fecha_inicio  = @i_fecha
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251013
    return 1
  end

  if @t_trn = 251
    select
      @i_credit = 0
  if @t_trn = 255
    select
      @i_efe = 0

  select
    @i_efe = isnull (@i_efe,
                     0),
    @i_loc = isnull (@i_loc,
                     0),
    @i_prop = isnull (@i_prop,
                      0),
    @i_plaz = isnull (@i_plaz,
                      0)

  if @w_codigo_pais = 'CO'
    select
      @w_tot = @i_efe + @i_prop + @i_loc + @i_credit
  else
    select
      @w_tot = @i_efe + @i_prop + @i_loc + @i_plaz + @i_credit

  select
    @w_tot_alic = @w_tot * @w_alicuota
  select
    @w_dis_alic = @i_efe * @w_alicuota

  if @i_factor = -1
     and (@i_efe > @w_disponible
           or @i_prop > @w_12h
           or @i_loc > @w_24h
           or @i_plaz > @w_rem_hoy
           or @i_ind = 1
              and (@i_credit > @w_disponible)
           or @i_ind = 2
              and (@i_credit > @w_12h)
           or @i_ind = 3
              and (@i_credit > @w_24h)
           or @i_ind = 4
              and (@i_credit > @w_rem_hoy))
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 258001
    return 1
  end
  if @i_ind = 1
    select
      @w_disponible = @w_disponible + @i_credit * @i_factor
  else if @i_ind = 2
    select
      @w_12h = @w_12h + @i_credit * @i_factor
  else if @i_ind = 3
    select
      @w_24h = @w_24h + @i_credit * @i_factor
  else if @i_ind = 4
    select
      @w_remesas = @w_remesas + @i_credit * @i_factor

  select
    @w_creditos = @w_creditos + @w_tot * @i_factor

  /*FRC-AHO-017-CobroComisiones CMU 2102110*/
  select
    @w_ncredmes = @w_ncredmes + (1 * @i_factor)

  begin tran
  if @i_factor = 1
    select
      @w_control = @i_ncontrol

  if @i_factor = -1
  begin
    select
      @w_sec = @i_lpend,
      @w_linea = @w_linea + 1

    insert into cob_ahorros..ah_linea_pendiente
                (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                 lp_control,lp_signo,lp_enviada)
    values      (@i_cuenta,@w_sec,'CORR',@w_tot,@i_fecha,
                 @i_nctrl,'D','N')
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253002
      return 1
    end
  end
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      w_alicuota = @w_alicuota,
      i_credit = @i_credit,
      w_tot_alic = @w_tot_alic,
      w_promedio1 = @w_promedio1,
      i_efe = @i_efe,
      i_factor = @i_factor,
      i_plaz = @i_plaz
    exec cobis..sp_end_debug
  end
  select
    @o_control = @w_control
  select
    @w_disponible = @w_disponible + @i_efe * @i_factor
  select
    @w_saldo_para_girar = @w_saldo_para_girar + (@i_credit + @i_efe) * @i_factor

  select
    @o_sldcont = @w_saldo_contable + @w_tot * @i_factor
  select
    @o_slddisp = @w_disponible

  if @i_factor = 1
    select
      @w_saldo_libreta = @w_saldo_libreta + @w_tot

  if (@t_trn = 251
      and @i_efe > $0)
      or (@t_trn = 255
          and @i_ind = 1)
  begin
    select
      @w_prom_disp = @w_prom_disp + @i_factor * round((@i_efe + @i_credit) *
                                                             @w_alicuota,
                                                      @w_numdeci)
  end

  /* LBM -- verificar si se debe actualizar el campo con la causal */
  if @t_trn = 255
     and @i_factor = 1
  begin
    if @w_act_fecha = 'S'
      select
        @w_fecha_ult_mov = @i_fecha
  end
  else
  begin
    select
      @w_fecha_ult_mov = @i_fecha
  end
  /*** Validamos el saldo maximo de la cuenta JLOYO *****/
  if @w_saldo_max > 0
     and @o_sldcont > @w_saldo_max
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 252077
    /**** EL CREDITO ALA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO ***/
    return 1
  end

  update cob_ahorros..ah_cuenta
  set    ah_disponible = @w_disponible,
         ah_promedio1 = @w_promedio1 + @i_factor * round(@w_dis_alic,
                                                         @w_numdeci),
         ah_prom_disponible = @w_prom_disp,
         ah_saldo_libreta = @w_saldo_libreta,
         ah_12h = @w_12h + @i_prop * @i_factor,
         ah_24h = @w_24h + @i_loc * @i_factor,
         ah_interes_ganado = @w_int_cap,
         ah_control = @w_control,
         ah_linea = @w_linea,
         ah_creditos = @w_creditos,
         ah_creditos_hoy = ah_creditos_hoy + @w_tot * @i_factor,
         ah_rem_hoy = @w_rem_hoy + @i_factor * @i_plaz,
         ah_remesas = @w_remesas + @i_factor * @i_plaz,
         ah_fecha_ult_mov = @w_fecha_ult_mov,--@i_fecha,
         ah_contador_trx = ah_contador_trx + @i_factor,
         /*FRC-AHO-017-CobroComisiones CMU 2102110*/
         ah_num_cred_mes = @w_ncredmes
  where  @i_cuenta = ah_cuenta
  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255001
    return 1
  end

  /* Regitrar los depositos por ciudad de cheques locales */

  if @i_loc > 0
     and @t_trn = 251
  begin
  /*** Este valor se devuelve en el sp_fecha_habil   ***/
    --Determinar el codigo de la ciudad de la compensacion
    --     select @w_ciudad = of_ciudad
    --     from cobis..cl_oficina
    --     where of_oficina = @s_ofi

    --  if @@rowcount <> 1
    --  begin 
    --           exec cobis..sp_cerror
    --            @t_debug        = @t_debug,
    --                @t_file         = @t_file,
    --                @t_from         = @w_sp_name,
    --                @i_num          = 351095
    --       return 351095
    --
    --  end

    /* Determinar el numero de dias de retencion para la ciudad */

    select
      @w_dias_ret = rl_dias
    from   cob_ahorros..ah_retencion_locales
    where  rl_agencia = @s_ofi
       and @w_hora_ejecucion between rl_hora_inicio and rl_hora_fin

    if @@rowcount = 0
    begin
      /* Determinar el parametro general */

      select
        @w_dias_ret = pa_tinyint
      from   cobis..cl_parametro
      where  pa_producto = 'AHO'
         and pa_nemonico = 'DIRE'

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205001
        return 1
      end

    end

  /****PEDRO COELLO MODIFICA EL CALCULO DE DIAS DE HOLD ****/
  /* Determinar la fecha de efectivizacion del deposito */
    --     select @w_fecha_efe = dateadd(dd,1,@i_fecha),
    --            @w_cont = 1

    --     while @w_cont <= @w_dias_ret
    --           if exists (select 1
    --                        from cobis..cl_dias_feriados
    --                     where df_ciudad = @w_ciudad
    --                         and df_fecha  = @w_fecha_efe)
    --           select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --      else 
    --               begin
    --         select @w_cont = @w_cont + 1
    --         if @w_cont <= @w_dias_ret
    --                        select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --               end

  /*** La determinacion de la fecha de efectivizacion del deposito se     ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif  = 'N',
      @i_efec_dia = 'S',
      @i_fecha    = @i_fecha,
      @i_oficina  = @s_ofi,
      @i_dif      = 'N',/**** Ingreso en  horario Normal  ***/
      @w_dias_ret = @w_dias_ret,
      @o_ciudad   = @w_ciudad out,
      @o_fecha_sig= @w_fecha_efe out

    if @w_return <> 0
      return @w_return

    if not exists (select
                     cd_cuenta
                   from   cob_ahorros..ah_ciudad_deposito
                   where  cd_cuenta     = @i_cuenta
                      and cd_ciudad     = @w_ciudad
                      and cd_fecha_depo = @i_fecha
                      and cd_fecha_efe  = @w_fecha_efe)
    begin
      insert into cob_ahorros..ah_ciudad_deposito
                  (cd_cuenta,cd_ciudad,cd_fecha_depo,cd_fecha_efe,cd_valor,
                   cd_valor_efe)
      values      (@i_cuenta,@w_ciudad,@i_fecha,@w_fecha_efe,@i_loc,
                   @i_loc)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205001
        return 1
      end

    end
    else
    begin
      update cob_ahorros..ah_ciudad_deposito
      set    cd_valor_efe = cd_valor_efe + (@i_loc * @i_factor)
      where  cd_cuenta     = @i_cuenta
         and cd_ciudad     = @w_ciudad
         and cd_fecha_depo = @i_fecha
         and cd_fecha_efe  = @w_fecha_efe

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205001
        return 1
      end

    end
  end

  --Consulta si producto tienen parametrizado cobro tipo T o C        

  select
    @w_numtot = isnull(pc_numtot,
                       0),
    @w_numcre = isnull(pc_numcre,
                       0),
    @w_numdeb = isnull(pc_numdeb,
                       0),
    @w_numco = isnull(pc_numco,
                      0),
    @w_tipocobro = pc_tipo
  from   cob_ahorros..ah_cuenta,
         cob_remesas..pe_pro_final,
         cob_remesas..pe_mercado,
         cob_remesas..pe_par_comision,
         cobis..cl_oficina
  where  ah_estado    = 'A'
     and ah_prod_banc = me_pro_bancario --
     and ah_tipocta   = me_tipo_ente--
     and pf_mercado   = me_mercado--
     and me_estado    = 'V'--
     and ah_moneda    = pf_moneda--
     and ah_tipo      = pf_tipo--
     and ah_filial    = pf_filial--
     and ah_oficina   = of_oficina--
     and pf_sucursal  = of_regional--
     and pc_profinal  = pf_pro_final--
     and pc_categoria = ah_categoria
     --  and  pc_tipo      = 'C' 
     and pc_estado    = 'V'
     and ah_cuenta    = @i_cuenta
  order  by ah_cuenta

/*FRC-AHO-017-CobroComisiones CMU 2102110*/
  -- SE BUSCA COSTOS DE COBRO COMISIONES
  if @w_tipocobro = 'C'
    select
      @w_numero = @w_numcre
  else
    select
      @w_numero = @w_numtot

  if @w_ncredmes >= @w_numero
  begin
    exec @w_return = cob_remesas..sp_genera_costos
      @s_srv         = @s_srv,
      @s_ofi         = @s_ofi,
      @s_ssn         = @s_ssn,
      @s_user        = @s_user,
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @w_sp_name,
      @i_fecha       = @i_fecha,
      @i_valor       = 1,
      @i_categoria   = @o_categoria,
      @i_tipo_ente   = @w_tipo_ente,
      @i_rol_ente    = @w_rol_ente,
      @i_tipo_def    = @w_tipo_def,
      @i_prod_banc   = @o_prod_banc,
      @i_producto    = @w_producto,
      @i_moneda      = @i_mon,
      @i_tipo        = @w_tipo,
      @i_codigo      = @w_codigo,
      @i_servicio    = 'COCO',
      @i_rubro       = '3',
      @i_disponible  = @w_disponible,
      @i_contable    = @w_saldo_contable,
      @i_promedio    = @w_promedio1,
      @i_prom_disp   = @w_prom_disp,
      @i_personaliza = @w_personaliza,
      @i_filial      = @w_filial,
      @i_oficina     = @w_oficina,
      @o_valor_total = @w_cobro_comision out

    if @w_return <> 0
      return @w_return
  end
  else
    select
      @w_cobro_comision = 0
/*FRC-AHO-017-CobroComisiones CMU 2102110*/
  -- COBRO COMISIONES
  if isnull(@w_cobro_comision,
            0) > 0
  begin
    -- ND por  valor comision
    exec @w_return = cob_ahorros..sp_ahndc_automatica
      @s_srv        = @s_srv,
      @s_ofi        = @s_ofi,
      @s_ssn        = @s_ssn,
      @s_ssn_branch = @s_ssn_branch,
      @s_user       = @s_user,
      @t_trn        = 253,
      @t_corr       = @t_corr,
      @t_ssn_corr   = @t_ssn_corr,
      @i_cta        = @w_cta_banco,
      @i_val        = @w_cobro_comision,
      @i_cau        = '90',-- causa cobro comision ret ventanilla
      @i_mon        = @i_mon,
      @i_alt        = 2,
      @i_fecha      = @i_fecha,
      @i_cobiva     = 'S',
      @i_canal      = 4,
      @o_valiva     = @w_valiva_tarifa out

    if @w_return <> 0
      return @w_return

    if @i_factor = -1
    begin
      -- Actualiza movimiento Original
      update cob_ahorros..ah_tran_monet
      set    tm_estado = 'R'
      where  tm_oficina     = @s_ofi
         and tm_ssn_branch  = @t_ssn_corr
         and tm_cta_banco   = @w_cta_banco
         and tm_tipo_tran   = 264
         and tm_cod_alterno = 1
         and tm_estado is null

      if @@error <> 0
      begin
        -- Error en la eliminacion
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 208052

        return 208052
      end

      -- Actualiza movimiento Reverso
      update cob_ahorros..ah_tran_monet
      set    tm_estado = 'R',
             tm_correccion = 'S',
             tm_sec_correccion = @t_ssn_corr
      where  tm_oficina     = @s_ofi
         and tm_ssn_branch  = @s_ssn_branch
         and tm_cta_banco   = @w_cta_banco
         and tm_tipo_tran   = 253
         and tm_cod_alterno = 1
         and tm_estado is null

      if @@error <> 0
      begin
        -- Error en la eliminacion
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 208052

        return 208052
      end
    end
  end

  commit tran

/* Modificaciones Branch III */
  /* Sp que retorna resultados para Branch III */

  if @t_ejec = 'R'
  begin
    exec @w_return = cob_ahorros..sp_resultados_branch_ah
      @s_ssn_host    = @s_ssn,
      @i_cuenta      = @i_cuenta,
      @i_fecha       = @s_date,
      @i_ofi         = @s_ofi,
      @i_tipo_cuenta = 'O'

    if @w_return <> 0
      return @w_return

  end

  return 0

go

