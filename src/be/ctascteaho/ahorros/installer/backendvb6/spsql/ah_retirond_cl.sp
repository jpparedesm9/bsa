/************************************************************************/
/*  Archivo:                ah_retirond_cl.sp                            */
/*  Stored procedure:       sp_ah_retirond_cl                            */
/*  Base de datos:          cob_ahorros                                  */
/*  Producto:               Cuentas de Ahorros                           */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                  */
/*  Fecha de escritura:     10-Feb-1993                                  */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                              PROPOSITO                                */
/*  Este programa procesa las transacciones de retiros y notas           */
/*  de debito con libreta                                                */
/*************************************************************************/
/*                              MODIFICACIONES                           */
/*  FECHA           AUTOR                   RAZON                        */
/*  10/Feb/1993     X Gellibert Coello      Emision Inicial              */
/*  10/Nov/1993     J Navarrete V.          Modificaciones Generales     */
/*  10/Ago/1998     V.Molina E.             Requerimiento del Bco. Del Caribe */
/*  21/Nov/1998     J. Salazar              Creacion del parametro @o_ssn */
/*  04/Jun/1999     J.Salazar/G.George      Creacion de @i_monto_imp,     */
/*                                          @o_monto_imp,@o_tipo_exonera. */
/*  2004/03/13      Carlos Cruz D.          Correcci¢n del envio de       */
/*                                          lineas pendientes             */
/*  18/Mar/2005     L. Bernuil              Validacion de fecha de        */
/*                                          ultimo Movimiento.            */
/*  21/ene/2010     CMunoz                  FRC-AHO-017-CobroComisiones   */
/*  08/Abr/2013     J.Colorado              Alianza Comerciales GMF       */
/*  02/Mayo/2016    Ignacio Yupa            Migración a CEN               */
/**************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_retirond_cl')
  drop proc sp_ah_retirond_cl
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_retirond_cl
( 
  @t_debug              char(1) = 'N',
  @t_file               varchar(14) = null,
  @t_from               varchar(30) = null,
  @t_trn                int,
  @t_rty                char(1),
  @t_corr               char(1),
  @t_show_version       bit = 0,
  @s_rol                smallint,
  @s_ofi                smallint,
  @s_org                char(1),
  @s_sev                tinyint,
  @s_sesn               int,
  @s_user               varchar(30),
  @s_lsrv               varchar(30),
  @s_srv                varchar(30),
  @s_term               varchar(10),
  @s_ssn                int,
  @s_ssn_branch         int = null,
  @t_ssn_corr           int,
  @p_rssn_corr          int,
  @p_lssn               int,
  @i_cta                cuenta,
  @i_cuenta             int,
  @i_sdolib             money,
  @i_val                float,
  @i_control            int,
  @i_ind                tinyint,
  @i_cau                char(3),
  @i_mon                tinyint,
  @i_factor             smallint,
  @i_fecha              smalldatetime,
  @i_ncontrol           int,
  @i_lpend              int,
  @i_monto_imp          money,
  @i_sld_caja           money = 0,
  @i_idcierre           int = 0,
  @i_filial             smallint = 1,
  @i_idcaja             int = 0,

  --CCR BRANCH III
  @t_ejec               char(1) = 'N',
  @i_fecha_valor_a      datetime = null,
  @i_usateller          char(1) = 'N',
  @s_date               datetime = null,
  @o_sldcont            money out,
  @o_slddisp            money out,
  @o_nombre             varchar(30) out,
  @o_cliente            int = null out,
  @o_control            int out,
  @o_int_cap            money out,
  @o_lineas             int out,
  @o_usa                char(1) out,
  @o_sldlib             money out,
  @o_nctrl              smallint out,
  @o_prod_banc          smallint = null out,
  @o_categoria          char(1) = null out,
  @o_ssn                int = null out,
  @o_monto_imp          money out,
  @o_tipo_exonerado_imp char(2) out,
  @o_tipocta_super      char(1) out,
  @o_clase_clte         char(1) = null out,
  @o_val_nx1000         money = null out,
  @o_base_gmf           money = null out,
  @o_concep_exc         smallint = 0 out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_alic_int         float,
    @w_alic_prom        float,
    @w_sdo_lib          money,
    @w_disponible       money,
    @w_promedio1        money,
    @w_12h              money,
    @w_24h              money,
    @w_remesas          money,
    @w_int_gnd          money,
    @w_sdo_int          float,
    @w_debitos          money,
    @w_numdeci          tinyint,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_tipo_prom        char(1),
    @w_control          int,
    @w_linea            smallint,
    @w_capitalizacion   char(1),
    @w_mon              tinyint,
    @w_sec              int,
    @w_mensaje          mensaje,
    @w_ssn_corr         int,
    @w_factor           float,
    @w_tipo_bloqueo     char(3),
    @w_usadeci          char(1),
    @w_prom_disp        money,
    @w_tasa_imp         float,
    /*LBM */
    @w_act_fecha        char(1),
    @w_fecha_ult_mov    datetime,--LBM    
    @w_codigo_pais      catalogo,
    @w_val_total        money,
    @w_producto         tinyint,
    @w_acumu_deb        money,
    @w_actualiza        char(1),
    @w_cobro_tarifa     money,
    @w_valiva_tarifa    money,
    @w_cob_tari_rev     money,
    @w_valiva_tari_rev  money,
    @w_valor_tope       money,
    @w_ciudad_cta       int,
    @w_ciudad_loc       int,
    @w_comision         money,
    @w_com_rev          money,
    @w_valor_cobro      money,
    @w_valiva           money,
    @w_val_cob_rev      money,
    @w_valor_cobro_com  money,
    @w_oficina          smallint,
    @w_tipo_ente        char(1),
    @w_rol_ente         char(1),
    @w_tipo_def         char(1),
    @w_tipo             char(1),
    @w_personaliza      char(1),
    @w_codigo           int,
    @w_filial           tinyint,
    @w_cobro_total      money,
    @w_realizar_deb     tinyint,
    @w_iva              float,
    @w_reg_imp_nx1000   char(1),
    @w_valnxmil         money,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ndebmes          int,
    @w_cobro_comision   money,
    @w_numtotcta        int,
    @w_numdeb           int,
    @w_numtot           int,
    @w_numero           int,
    @w_numcre           int,
    @w_numco            int,
    @w_tipocobro        char(1),
    @w_tasa_reintegro   float,
    @w_gmf_reintegro    money,
    @w_cuenta           int,
    -- REQ 306 VALIDA DEPOSITO INICIAL
    @w_estado           char(1),
    @w_numdeci_imp      tinyint

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_retirond_cl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @o_ssn = @s_ssn

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
      i_sdolib = @i_sdolib,
      i_val = @i_val,
      i_control = @i_control,
      i_ind = @i_ind,
      i_cau = @i_cau,
      i_mon = @i_mon,
      i_factor = @i_factor,
      i_fecha = @i_fecha
    exec cobis..sp_end_debug
  end

  /* LBM -- Colocarle el valor default a la variable @w_act_fecha */
  select
    @w_act_fecha = 'S'

  if @i_factor = 1
  begin
    /* Busqueda de la tasa del impuesto */
    select
      @w_tasa_imp = pa_float
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'TIDB'

    if @@rowcount <> 1
    begin
      /* Parametro no encontrado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 201196
      return 201196
    end
  end
  else
    select
      @w_tasa_imp = 0.0

  /*  Determinacion de bloqueo de cuenta  */
  select
    @w_tipo_bloqueo = cb_tipo_bloqueo
  from   cob_ahorros..ah_ctabloqueada
  where  cb_cuenta = @i_cuenta
     and cb_estado = 'V'
     and cb_tipo_bloqueo in ('2', '3')

  if @@rowcount <> 0
  begin
    select
      @w_mensaje = rtrim(valor)
    from   cobis..cl_catalogo
    where  tabla  = (select
                       codigo
                     from   cobis..cl_tabla
                     where  tabla = 'ah_tbloqueo')
       and codigo = @w_tipo_bloqueo

    if @@rowcount = 0
    begin /** Tipo Bloqueo No Identificado **/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 251025
      return 251025
    end
    else
    begin
      select
        @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251007,
        @i_sev   = 1,
        @i_msg   = @w_mensaje
      return 251007
    end
  end

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

    select
      @w_numdeci_imp = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DIM'
       and pa_producto = 'AHO'

    if @w_numdeci_imp is null
      select
        @w_numdeci_imp = 0

  end
  else
    select
      @w_numdeci = 0,
      @w_numdeci_imp = 0

  /* Calcular el saldo */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @i_cuenta,
    @i_fecha            = @i_fecha,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      'StoredProcedure: ' = @w_sp_name,
      saldo_para_girar = @w_saldo_para_girar,
      saldo_contable = @w_saldo_contable
    exec cobis..sp_end_debug
  end

  /*LBM -- Verificamos la tabla re_propiedad_ndc para establecer si se afecta la fecha de ultimo movimiento */
  if @t_trn = 262
     and @i_factor = 1
  begin
    select
      @w_act_fecha = pr_act_fecha
    from   cob_remesas..re_propiedad_ndc
    where  pr_producto = 4
       and pr_signo    = 'D'
       and pr_causa    = @i_cau

    if @@rowcount = 0
      select
        @w_act_fecha = 'S'
  end

  select
    @w_sdo_lib = ah_saldo_libreta,
    @w_sdo_int = ah_saldo_interes,
    @w_int_gnd = ah_interes_ganado,
    @w_linea = ah_linea,
    @w_12h = ah_12h,
    @w_24h = ah_24h,
    @w_remesas = ah_remesas,
    @w_control = ah_control,
    @w_tipo_prom = ah_tipo_promedio,
    @o_nombre = substring(ah_nombre,
                          1,
                          30),
    @o_cliente = ah_cliente,
    @w_mon = ah_moneda,
    @w_oficina = ah_oficina,
    @w_disponible = ah_disponible,
    @w_promedio1 = ah_promedio1,
    @w_debitos = ah_debitos,
    @w_capitalizacion = ah_capitalizacion,
    @w_prom_disp = ah_prom_disponible,
    @w_fecha_ult_mov = ah_fecha_ult_mov,--LBM  
    @w_producto = ah_producto,
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @o_tipocta_super = ah_tipocta_super,
    @o_clase_clte = ah_clase_clte,
    @w_tipo_ente = ah_tipocta,
    @w_rol_ente = ah_rol_ente,
    @w_tipo = ah_tipo,
    @w_tipo_def = ah_tipo_def,
    @w_codigo = ah_default,
    @w_personaliza = ah_personalizada,
    @w_reg_imp_nx1000 = ah_nxmil,
    @w_filial = ah_filial,
    @w_cuenta = ah_cuenta,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ndebmes = isnull(ah_num_deb_mes,
                        0),
    @w_estado = ah_estado
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @i_cuenta

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** stored Procedure **/' = @w_sp_name,
      t_file = @t_file,
      w_sdo_interes = @w_sdo_int,
      t_capitalizacion = @w_capitalizacion,
      w_saldos_para_girar = @w_saldo_para_girar,
      w_saldo_contable = @w_saldo_contable,
      i_fecha = @i_fecha
    exec cobis..sp_end_debug
  end

  /* REQ 306 DEPOSITO INICIAL APERTURA */
  if @w_estado in ('G', 'N')
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251099

    return 251099
  end

  /* Verificar si la cuenta esta exonerada de IDB */
  if (@w_tasa_imp > 0
      and @i_factor = 1)
  begin
    select
      @o_tipo_exonerado_imp = ei_tipo_exonerado_imp
    from   cob_remesas..re_exoneracion_impuesto
    where  ei_producto = 'AHO'
       and ei_cuenta   = @i_cuenta

    if @@rowcount = 1
      /* La cuenta esta exonerada de IDB */
      select
        @w_tasa_imp = 0.0
  end

  /* CALCULO DEL MONTO DE IDB */
  if @w_tasa_imp > 0
      or (@i_factor = -1
          and @i_monto_imp > 0)
  begin
    if @i_factor = 1
      select
        @o_monto_imp = round((@i_val * @w_tasa_imp),
                             @w_numdeci)
    else
      select
        @o_monto_imp = @i_monto_imp
  end
  else
    select
      @o_monto_imp = $0

  /*  Validacion de la moneda */
  if @i_mon <> @w_mon
  begin
    /** Cod.Moneda Errado **/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251026
    return 251026
  end

  /* Validacion del Saldo Libreta */
  if convert(char(30), @w_sdo_lib) <> convert(char(30), @i_sdolib)
     and @i_factor = 1
  begin
    /** Sdo.Libreta Errado **/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251005
    return 251005
  end

  /*  Validacion del numero de control */
  if @i_control <> @w_control
     and @i_factor = 1
  begin
    /** Nro.Control No Coincide **/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251004
    return 251004
  end

  /* CALCULO IMPUESTO NX1000 */
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

  if @w_codigo_pais = 'CO' -- Colombia
  begin
    select
      @o_val_nx1000 = $0,
      @w_gmf_reintegro = 0

    --  Llama sp que calcula GMF de acuerdo a concepto exencion
    exec @w_return = sp_calcula_gmf
      @s_user            = @s_user,
      @s_date            = @i_fecha,
      @s_ofi             = @s_ofi,
      @t_trn             = @t_trn,
      @t_ssn_corr        = @t_ssn_corr,
      @i_factor          = @i_factor,
      @i_mon             = @i_mon,
      @i_cta             = @i_cta,
      @i_cuenta          = @i_cuenta,
      @i_val             = @i_val,
      @i_val_tran        = @i_val,
      @i_numdeciimp      = @w_numdeci,
      @i_producto        = @w_producto,
      @i_operacion       = 'Q',
      @o_total_gmf       = @o_val_nx1000 out,
      @o_acumu_deb       = @w_acumu_deb out,
      @o_actualiza       = @w_actualiza out,
      @o_base_gmf        = @o_base_gmf out,
      @o_concepto        = @o_concep_exc out,
      @o_tasa_reintegro  = @w_tasa_reintegro out,--JCO
      @o_valor_reintegro = @w_gmf_reintegro out -- JCO 

    if @w_return <> 0
      return @w_return

    -- Calculo valor total de impuestos
    if @i_factor = 1
    begin
      if @t_trn = 261
          or (@t_trn = 264
              and @i_ind = 1)
        select
          @o_monto_imp = isnull(@o_monto_imp, $0) + @o_val_nx1000
      else
        select
          @o_val_nx1000 = $0
    end

    select
      @w_valnxmil = @o_val_nx1000
    -- Consulta de ciudad para las oficinas de la cuenta
    -- y oficina con la que trabaja el sistema

  /*select @w_ciudad_cta = of_ciudad
    from cobis..cl_oficina
   where of_oficina = @w_oficina*/
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    select
      @w_ciudad_cta = oc_centro
    from   cob_cuentas..cc_ofi_centro
    where  oc_oficina = @w_oficina

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201094
      return 201094
    end
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    select
      @w_ciudad_loc = oc_centro
    from   cob_cuentas..cc_ofi_centro
    where  oc_oficina = @s_ofi
    /*select @w_ciudad_loc = of_ciudad
      from cobis..cl_oficina
     where of_oficina = @s_ofi*/
    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201094

      return 201094
    end

    if @i_factor = 1
    begin
      if @w_ciudad_cta <> @w_ciudad_loc
      begin -- Se realiza el cobro de la comision por transaccion nacional
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
          @i_servicio    = 'TRNA',
          @i_rubro       = '3',
          @i_disponible  = @w_disponible,
          @i_contable    = @w_saldo_contable,
          @i_promedio    = @w_promedio1,
          @i_prom_disp   = @w_prom_disp,
          @i_personaliza = @w_personaliza,
          @i_filial      = @w_filial,
          @i_oficina     = @w_oficina,
          @o_valor_total = @w_comision out

        if @w_return <> 0
          return @w_return

        if isnull(@w_comision,
                  0) > 0
        begin
          select
            @w_iva = 0 -- No se cobra IVA sobre la comision
          /* DMV
          exec @w_return = cob_cuentas..sp_exento_impuestos
          @i_trn          = @t_trn,
          @i_empresa      = 1,
          @i_impuesto     = 'V',
          @i_debcred      = 'C',
          @i_oforig_admin = @s_ofi,
          @i_ofdest_admin = @w_oficina,
          @i_ente         = @w_cliente,
          @i_producto     = @w_producto,
          @o_exento       = @o_exento  out,
          @o_base         = @o_base out,
          @o_porcentaje   = @o_porcentaje out
          
          if @w_return <> 0
             return @w_return
          
          if @o_exento = 'N'
             select @w_iva = @o_porcentaje
          else
             select @w_iva = 0
          */

          select
            @w_valor_cobro = ((@w_comision * @w_iva) / 100)
          select
            @w_valor_cobro_com = @w_valor_cobro + @w_comision
          select
            @w_cobro_total = @w_valor_cobro_com + @w_val_total

          if @w_cobro_total > @w_saldo_para_girar
          begin /* Fondos Insuficientes */
            select
              @w_realizar_deb = 0

            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 251033

            return 251033
          end
          else
            select
              @w_realizar_deb = 1
        end
      end
    end

    -- Parametro tope para cobro comision retiro ventanilla
    select
      @w_valor_tope = pa_money
    from   cobis..cl_parametro
    where  pa_nemonico = 'AHMCRV'
       and pa_producto = 'AHO'

    if @@rowcount = 0
    begin
      -- No existe parametro 
      exec cobis..sp_cerror
        @t_debug = null,
        @t_file  = null,
        @t_from  = @w_sp_name,
        @i_num   = 101077

      return 101077
    end

    -- VALIDACION APLICACION COBRO REITIRO VENTANILLA
    if @i_val < @w_valor_tope
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
        @i_servicio    = 'REVE',
        @i_rubro       = '3',
        @i_disponible  = @w_disponible,
        @i_contable    = @w_saldo_contable,
        @i_promedio    = @w_promedio1,
        @i_prom_disp   = @w_prom_disp,
        @i_personaliza = @w_personaliza,
        @i_filial      = @w_filial,
        @i_oficina     = @w_oficina,
        @o_valor_total = @w_cobro_tarifa out

      if @w_return <> 0
        return @w_return
    end

    --Consulta si producto tienen parametrizado cobro tipo T o C        
    exec @w_return = cob_remesas..sp_tipo_comision
      @i_prodbanc  = @o_prod_banc,
      @i_categoria = @o_categoria,
      @i_tipocta   = @w_tipo_ente,
      @i_tipo      = @w_tipo,
      @i_mon       = @i_mon,
      @i_filial    = @w_filial,
      @i_oficina   = @w_oficina,
      @o_numcre    = @w_numcre out,
      @o_numtot    = @w_numtot out,
      @o_numco     = @w_numco out,
      @o_numdeb    = @w_numdeb out,
      @o_tipocobro = @w_tipocobro out
    -- print ' Tipo Cobro ' + cast (@w_tipocobro as varchar)  +  '  total transacciones ' + cast (@w_numtot as varchar)
  /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    -- SE BUSCA COSTOS DE COBRO COMISIONES

    if @w_tipocobro = 'C'
      select
        @w_numero = @w_numdeb
    else
      select
        @w_numero = @w_numtot

    -- print ' @w_ndebmes ' + cast (@w_ndebmes as varchar)  +  '  Ciudad cuenta ' + cast (@w_ciudad_cta as varchar)             
    if @w_tipocobro = 'T'
      select
        @w_ndebmes = @w_numtotcta
    -- print ' SI es Total @w_ndebmes ' + cast (@w_ndebmes as varchar)  

    if @w_ndebmes >= @w_numero
       and @w_tipocobro <> 'M'
       and @w_ciudad_cta = @w_ciudad_loc
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
  end

  select
    @o_lineas = 0,
    @o_sldlib = 0
  /* Validacion de lineas Pendientes */
  if @w_linea > 0
     and @i_factor = 1
  begin
    exec @w_return = cob_ahorros..sp_ah_actlibsp
      @s_ssn        = @s_ssn,
      @s_srv        = @s_srv,
      @s_lsrv       = @s_lsrv,
      @s_user       = @s_user,
      @s_sesn       = @s_sesn,
      @s_ssn_branch = @s_ssn_branch,
      @s_term       = @s_term,
      @s_date       = @i_fecha,
      @s_ofi        = @s_ofi,
      @s_rol        = @s_rol,
      @s_org        = @s_org,
      @p_sp         = 'S',
      @t_trn        = @t_trn,
      @i_cta        = @i_cta,
      @i_sld_lib    = @w_sdo_lib,
      @i_nctrl      = @w_control,
      @i_mon        = @i_mon,
      @i_usateller  = @i_usateller,
      @o_sldlib     = @w_sdo_lib out,
      @o_num        = @o_lineas out,
      @o_nctrl      = @o_nctrl out
    select
      @o_sldlib = @w_sdo_lib
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

  /*  Alicuota de Promedio  */
  select
    @w_alic_prom = fp_alicuota
  from   ah_fecha_promedio
  where  fp_tipo_promedio = @w_tipo_prom
     and fp_fecha_inicio  = convert(datetime, @i_fecha)

  if @@rowcount = 0
  begin
    /** Alicuota de Promedio No Existe **/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251012
    return 251012
  end

  if @i_factor = 1
    select
      @w_sdo_lib = @w_sdo_lib - @i_val - @o_monto_imp

  select
    @w_promedio1 = @w_promedio1 - (((@i_val + @o_monto_imp) * @w_alic_prom) *
    @i_factor
    ),
    @w_debitos = @w_debitos + (@i_val + @o_monto_imp) * @i_factor

  /* Asigna variables de origen de la transaccion */
  if @s_org = 'S'
    select
      @w_ssn_corr = @p_rssn_corr
  else
    select
      @w_ssn_corr = @t_ssn_corr

  /*FRC-AHO-017-CobroComisiones CMU 2102110*/
  if @w_ciudad_cta = @w_ciudad_loc
    select
      @w_ndebmes = @w_ndebmes + (1 * @i_factor)

  /* Validar Fondos */
  begin tran
  if @i_factor = 1
  begin
    if @t_trn = 262
    begin
      if @i_ind = 2
        select
          @w_saldo_para_girar = @w_12h
      else if @i_ind = 3
        select
          @w_saldo_para_girar = @w_24h
      else if @i_ind = 4
        select
          @w_saldo_para_girar = @w_remesas
    end
    if @i_val + @o_monto_imp > @w_saldo_para_girar
    begin
      if @t_trn = 261
      begin /* Fondos insuficientes */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251033
        return 251033
      end

      if @t_trn = 262
         and @i_ind > 1
      begin /* Valor mayor a retencion */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251028
        return 251028
      end

      if @t_trn = 262
         and @i_ind = 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251033
        return 251033
      end
    end
  end

  if @i_factor = 1
  begin
    select
      @w_control = @i_ncontrol
    if @o_monto_imp > 0
      select
        @w_control = @w_control + 1
  end

  /* Envia Interes Ganado */
  select
    @o_usa = ul_usa
  from   cob_ahorros..ah_usa_linea
  where  ul_capitalizacion = @w_capitalizacion

  select
    @o_int_cap = $0
  if @w_int_gnd <> $0
     and @o_usa = 'N'
  begin
    select
      @o_int_cap = @w_int_gnd
    select
      @w_int_gnd = $0
  end

  if @t_trn = 261
      or (@t_trn = 262
          and @i_ind = 1)
  begin
    select
      @w_disponible = @w_disponible - (@i_val + @o_monto_imp) * @i_factor
    select
      @w_prom_disp = @w_prom_disp - (@i_val + @o_monto_imp) * @w_alic_prom *
                                    @i_factor
  end
  else
  begin
    if @i_ind = 2
      select
        @w_12h = @w_12h - @i_val * @i_factor
    else if @i_ind = 3
      select
        @w_24h = @w_24h - @i_val * @i_factor
    else if @i_ind = 4
      select
        @w_remesas = @w_remesas - @i_val * @i_factor
  end

  if @i_factor = -1
  begin
    select
      @w_linea = @w_linea + 1,
      @w_sec = @i_lpend

    insert into cob_ahorros..ah_linea_pendiente
                (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                 lp_control,lp_signo,lp_enviada)
    values      (@i_cuenta,@w_sec,'CORR',@i_val,@i_fecha,
                 @w_control + 1,'C','N')
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253002
      return 253002
    end

    if @i_monto_imp > 0
    begin
      select
        @w_linea = @w_linea + 1

      insert into cob_ahorros..ah_linea_pendiente
                  (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                   lp_control,lp_signo,lp_enviada)
      values      (@i_cuenta,@w_sec + 1,'CORR',@o_monto_imp,@i_fecha,
                   @w_control + 2,'C','N')

      if @@error <> 0
      begin
        /* Error en insercion de linea pendiente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253002
        return 253002
      end
    end
  end

  /* LBM -- verificar si se debe actualizar el campo con la causal */
  if @t_trn = 262
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

  update cob_ahorros..ah_cuenta
  set    ah_disponible = @w_disponible,
         ah_saldo_libreta = @w_sdo_lib,
         ah_12h = @w_12h,
         ah_24h = @w_24h,
         ah_remesas = @w_remesas,
         ah_promedio1 = round(@w_promedio1,
                              @w_numdeci),
         ah_prom_disponible = round(@w_prom_disp,
                                    @w_numdeci),
         ah_debitos = @w_debitos,
         ah_debitos_hoy = ah_debitos_hoy + (@i_val + @o_monto_imp) * @i_factor,
         ah_control = @w_control,
         ah_linea = @w_linea,
         ah_interes_ganado = @w_int_gnd,
         ah_fecha_ult_mov = @w_fecha_ult_mov,--@i_fecha,
         ah_contador_trx = ah_contador_trx + @i_factor,
         ah_fecha_ult_ret = @i_fecha,
         ah_monto_imp = ah_monto_imp + @o_monto_imp * @i_factor,
         /*FRC-AHO-017-CobroComisiones CMU 2102110*/
         ah_num_deb_mes = @w_ndebmes
  where  ah_cta_banco = @i_cta
  -- where @i_cuenta = ah_cuenta

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 255001
    return 255001
  end

  if @w_codigo_pais = 'CO' -- Colombia
  begin
    -- Actualiza acumulados topes gmf 
    if @w_actualiza = 'S'
    begin
      exec @w_return = sp_calcula_gmf
        @s_date      = @i_fecha,
        @i_cuenta    = @i_cuenta,
        @i_producto  = @w_producto,
        @i_operacion = 'U',
        @i_acum_deb  = @w_acumu_deb

      if @w_return <> 0
        return @w_return
    end

    -- ND Comision Transaccion Nacional e IVA 
    if @w_realizar_deb = 1
    begin
      if @i_factor = -1
      begin
        -- Reverso Comision
        select
          @w_comision = 0

        if @w_ciudad_cta <> @w_ciudad_loc
        begin
          select
            @w_comision = fv_costo
          from   cob_ahorros..ah_fecha_valor
          where  fv_transaccion = @t_trn
             and fv_referencia  = convert(varchar(24), @t_ssn_corr)
             and fv_rubro       = '1'
        end
      end

      if isnull(@w_comision,
                0) > 0
      begin
        exec @w_return = cob_ahorros..sp_ahndc_automatica
          @s_srv        = @s_srv,
          @s_ofi        = @s_ofi,
          @s_ssn        = @s_ssn,
          @s_ssn_branch = @s_ssn_branch,
          @s_user       = @s_user,
          @t_trn        = 264,
          @t_corr       = @t_corr,
          @t_ssn_corr   = @t_ssn_corr,
          @i_cta        = @i_cta,
          @i_val        = @w_comision,
          @i_cau        = '30',-- POR COMISION TRANSACCION NACIONAL
          @i_mon        = @i_mon,
          @i_alt        = 2,
          @i_fecha      = @i_fecha,
          @i_cobiva     = 'S',
          @i_canal      = 4,
          @o_valiva     = @w_valiva
        if @w_return <> 0
          return @w_return

        if @i_factor = 1
        begin
          /* Inserto en ah_fecha_valor el valor de la comision CPA */
          insert into cob_ahorros..ah_fecha_valor
                      (fv_transaccion,fv_cuenta,fv_referencia,fv_rubro,fv_costo)
          values      (@t_trn,@i_cuenta,convert(varchar(24), @s_ssn_branch),'1',
                       @w_comision)
          if @@error <> 0
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601161

            return 601161
          end

          if isnull(@w_valiva,
                    0) > 0
          begin
            -- Inserto en ah_fecha_valor el valor del iva CPA
            insert into cob_ahorros..ah_fecha_valor
                        (fv_transaccion,fv_cuenta,fv_referencia,fv_rubro,
                         fv_costo)
            values      (@t_trn,@i_cuenta,convert(varchar(24), @s_ssn_branch),
                         '2',
                         @w_valiva)
            if @@error <> 0
            begin
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 601161

              return 601161
            end
          end
        end
        else
        begin
          -- Reversos
          select
            @w_val_cob_rev = 0

          select
            @w_val_cob_rev = fv_costo
          from   cob_ahorros..ah_fecha_valor
          where  fv_transaccion = @t_trn
             and fv_referencia  = convert(varchar(24), @t_ssn_corr)
             and fv_rubro       = '2'

          if isnull(@w_val_cob_rev,
                    0) > 0
          begin
            exec @w_return = cob_ahorros..sp_ahndc_automatica
              @s_srv        = @s_srv,
              @s_ofi        = @s_ofi,
              @s_ssn        = @s_ssn,
              @s_ssn_branch = @s_ssn_branch,
              @s_user       = @s_user,
              @t_trn        = 253,
              @i_cta        = @i_cta,
              @i_val        = @w_val_cob_rev,
              @i_cau        = '144',--DEVOLUCION IVA
              @i_mon        = @i_mon,
              @i_alt        = 1,
              @i_fecha      = @i_fecha,
              @i_canal      = 4

            if @w_return <> 0
              return @w_return
          end

          -- Actualiza movimiento Original
          update cob_ahorros..ah_tran_monet
          set    tm_estado = 'R'
          where  tm_oficina    = @s_ofi
             and tm_ssn_branch = @t_ssn_corr
             and tm_cta_banco  = @i_cta
             and tm_tipo_tran  = 264
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
          where  tm_oficina    = @s_ofi
             and tm_ssn_branch = @s_ssn_branch
             and tm_cta_banco  = @i_cta
             and tm_tipo_tran  = 253
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

          -- Borro los registros de ah_fecha_valor
          delete cob_ahorros..ah_fecha_valor
          where  fv_transaccion = @t_trn
             and fv_referencia  = convert(varchar(24), @t_ssn_corr)
             and fv_rubro in('1', '2')

          if @@error <> 0
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 208052

            return 208052
          end
        end /* REVERSO*/
      end /* COMISION */
    end /* @w_realizar_deb  */

    -- AUTOMATICA TARIFARIO
    if isnull(@w_cobro_tarifa,
              0) > 0
    begin
      -- ND por  valor comision
      exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv        = @s_srv,
        @s_ofi        = @s_ofi,
        @s_ssn        = @s_ssn,
        @s_ssn_branch = @s_ssn_branch,
        @s_user       = @s_user,
        @t_trn        = 264,
        @t_corr       = @t_corr,
        @t_ssn_corr   = @t_ssn_corr,
        @i_cta        = @i_cta,
        @i_val        = @w_cobro_tarifa,
        @i_cau        = '31',-- causa cobro comision ret ventanilla
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
           and tm_cta_banco   = @i_cta
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
           and tm_cta_banco   = @i_cta
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
      end/* FACTOR */
    end /* TARIFA */

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
        @t_trn        = 264,
        @t_corr       = @t_corr,
        @t_ssn_corr   = @t_ssn_corr,
        @i_cta        = @i_cta,
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
           and tm_cta_banco   = @i_cta
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
           and tm_cta_banco   = @i_cta
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
      end /* FACTOR */
    end /* COBRO DE COMISION */

  end /* COLOMBIA */

  /* POR RETIRO */
  if @o_val_nx1000 > 0 --isnull(@w_gmf_reintegro,0) > 0
  begin
    if @i_factor <> 1
      select
        @w_gmf_reintegro = isnull(round(isnull(@o_val_nx1000,
                                               0) * (@w_tasa_reintegro / 100),
                                        @w_numdeci_imp),
                                  0)

    if @w_gmf_reintegro > 0
    begin
      execute @w_return = sp_reintegro_gmf
        @s_srv        = @s_srv,
        @s_ofi        = @s_ofi,
        @s_user       = @s_user,
        @s_term       = @s_term,
        @s_ssn        = @s_ssn,
        @s_ssn_branch = @s_ssn_branch,
        @t_corr       = @t_corr,
        @t_ssn_corr   = @t_ssn_corr,
        @s_date       = @i_fecha,
        @i_cuenta     = @w_cuenta,
        @i_valor      = @w_gmf_reintegro,
        @i_mon        = @i_mon,
        @i_alterno    = 50,
        @i_factor     = @i_factor,
        @i_cliente    = @o_cliente

      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 252093

        return 252093
      end
    end
  end

  commit tran

  select
    @o_control = @w_control
  select
    @o_sldcont = @w_saldo_contable - (@i_val + @o_monto_imp) * @i_factor
  select
    @o_slddisp = @w_disponible

  --CCR BRANCH III
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

