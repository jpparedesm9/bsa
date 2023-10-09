use cob_ahorros
go

/************************************************************************/
/*  Archivo:            transfer_deb_ah.sp                              */
/*  Stored procedure:   sp_transfer_deb_ah                              */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 22-Dic-1994                                     */
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
/*  Este programa procesa las transacciones de debito por transfe       */
/*  rencias (automaticas) en Cuentas Ahorros.                           */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR             RAZON                                */
/*  22/Dic/1994     G Velasquez C.  Emision inicial                     */
/*  10/Ago/1998     V.Molina E.     Requerimiento del Caribe            */
/*  21/Jun/1999     J.C. Gordillo   IDB                                 */
/*  19/Jul/1999     J.C. Gordillo   Titulares                           */
/*  10/Sep/1999     V.Molina        Titulares y Cotitulares             */
/*  2002/12/10      Carlos Cruz D.  Branch III                          */
/*  11/feb/2013    D.Pulido     REQ 330 - Validacion identidad cliente  */
/*  21/ene/2010  CMunoz     FRC-AHO-017-CobroComisiones CMU 2102110     */
/*  12/Ago/2013  O.Saavedra      INC 113071 - Mejora Integridad trn     */
/*  02/May/2016  Walther Toledo      Migración a CEN                    */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_transfer_deb_ah')
  drop proc sp_transfer_deb_ah
go

create proc sp_transfer_deb_ah
(
  @s_srv                varchar(30),
  @s_ofi                smallint,
  @s_ssn                int,
  @s_user               varchar(30),
  @s_sesn               int=null,
  @s_term               varchar(10),
  @s_date               datetime,
  @s_rol                smallint,
  @s_org_err            char(1) = null,
  @s_error              int = null,
  @s_sev                tinyint = null,
  @s_org                char(1),
  @s_ssn_branch         int = null,
  @t_corr               char(1) = 'N',
  @t_ssn_corr           int = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(14) = null,
  @t_from               varchar(32) = null,
  @t_rty                char(1) = 'N',
  @t_trn                int,
  @t_show_version       bit = 0,
  @i_prodeb             tinyint,
  @i_ctadb              cuenta,
  @i_prodep             tinyint,
  @i_cta_dep            cuenta,
  @i_val                money,
  @i_tipo               char(2),
  @i_mon                tinyint,
  @i_sec                int,
  @i_ncontrol           int,
  @i_lpend              int,
  @i_reg_imp2x1000      char(1),
  @i_sobregirar         char (1) = 'N',
  @i_referencia         varchar(40) = null,
  @i_verifica_blq       char(1) = 'S',
  @i_turno              smallint = null,
  @i_por_traslado       char(1) = null,
  @i_comision           money = 0,--REQ 203
  @i_causal             char(3) = '',--REQ 203

  --CCR BRANCH III
  @t_ejec               char(1) = 'N',
  @i_fecha_valor_a      datetime = null,
  @i_sld_caja           money = 0,
  @i_idcierre           int = 0,
  @i_filial             smallint = 1,
  @i_idcaja             int = 0,
  @i_atm_server         char(1) = 'N',
  @i_canal              smallint = 4,
  @i_is_batch           char(1) = 'N',
  @i_alianza            char(1) = 'N',
  @i_valida_hom         char(1) = 'S',--VALIDA HOMINI
  @o_salcondb           money out,
  @o_saldisdb           money out,
  @o_nomdb              varchar(30) out,
  @o_idedb              varchar(15) out,
  @o_prod_banc          smallint out,
  @o_categoria          char(1) out,
  @o_comision           money out,
  @o_monto_iva          money out,
  @o_monto_imp          money = null out,
  @o_tipo_exonerado_imp char(2) out,
  @o_saldo_girar_db     money = null out,
  @o_12hdb              money = null out,
  @o_24hdb              money = null out,
  @o_remesasdb          money = null out,
  @o_blq_db             money = null out,
  @o_tipocta_super      char(1) = null out,
  @o_val_GMF            money = null out,
  @o_base_gmf           money = null out,
  @o_concep_exc         smallint = 0 out,
  @o_total_gmf          money = 0 out,
  @o_tasa_reintegro     float = 0 out
)
as
  declare
    @w_return           int,
    @w_cuenta           int,
    @w_sp_name          varchar(30),
    @w_disponible       money,
    @w_fecha            smalldatetime,
    @w_filial           tinyint,
    @w_oficina          smallint,
    @w_promedio         char(1),
    @w_promedio1        money,
    @w_promdisp         money,
    @w_val              money,
    @w_mon              tinyint,
    @w_valor            money,
    @w_alic             money,
    @w_numdeci          tinyint,
    @w_fldeci           char(1),
    @w_lineas           smallint,
    @w_clave            int,
    @w_control          int,
    @w_linpen           int,
    @w_alicuota         float,
    @w_saldint          float,
    @w_tipo_bloqueo     varchar(3),
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_mensaje          mensaje,
    @w_factor           smallint,
    @w_signo            char(1),
    @w_capitaliza       char(1),
    @w_nemo             char(4),
    @w_debmes           money,
    @w_debhoy           money,
    @w_reg_imp2x1000    char(1),
    @w_imp_2x1000       float,
    @w_tasa_imp         float,
    @w_cliente          int,
    @w_cotitular_deb    int,
    @w_cotitular_dep    int,
    @w_titular          int,
    @w_num_cotit_dep    tinyint,
    @w_num_cotit_deb    tinyint,
    @w_estado           char(1),
    @w_producto         tinyint,
    @w_codigo_pais      catalogo,
    @w_actualiza        char(1),
    @w_ciudad_cta       int,
    @w_ciudad_loc       int,
    @w_valor_tope       money,
    @w_val_total        money,
    @w_cobro_tarifa     money,
    @w_valiva_tarifa    money,
    @w_comision         money,
    @w_com_rev          money,
    @w_valor_cobro      money,
    @w_valiva           money,
    @w_val_cob_rev      money,
    @w_valor_cobro_com  money,
    @w_acumu_deb        money,
    @w_tipocta          char(1),
    @w_rol_ente         char(1),
    @w_tipo_def         char(1),
    @w_tipo             char(1),
    @w_personaliza      char(1),
    @w_codigo           int,
    @w_cobro_total      money,
    @w_realizar_deb     tinyint,
    @w_iva              float,
    @w_reg_imp_nx1000   char(1),
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ndebmes          int,
    @w_cobro_comision   money,
    @w_numdeb           int,
    @w_numtot           int,
    @w_numero           int,
    @w_numcre           int,
    @w_numco            int,
    @w_numtotcta        int,
    @w_tipocobro        char(1),
    @w_clase_clte       char(1),
    @w_categoria        char(1),
    @w_alerta           char(1),
    @w_alerta_cli       varchar(40),
    @w_gmf              money,
    @w_posteo           char(1),
    @w_pro_final        smallint,
    @w_sucursal         smallint,
    @w_val_2x1000       money,
    @w_error            int,
    @w_sev              tinyint,
    @w_comision_trn     money,
    @w_alt              int,
    @w_oper_cont        char(1),
    @w_prod_banc        smallint,
    @w_modulo           char(3),
    @w_autoriza         char(1),
    @w_estcta           char(1),
    @w_estado_id        int,--REQ 330
    @w_msg_valida       varchar(64),--REQ 330
    @w_gmf_reintegro    money,
    @w_gmf_valor        money,
    @w_numdeci_imp      tinyint

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_transfer_deb_ah',
    @w_fecha = @s_date

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @o_comision = 0,
    @o_monto_iva = 0,
    @o_total_gmf = 0,
    @w_gmf = 0,
    @w_comision = 0,
    @w_cobro_comision = 0,
    @i_canal = 4,
    @w_estcta = null,
    @w_gmf_valor = 0

  --print @w_sp_name

  if @i_turno is null
    select
      @i_turno = @s_rol

  select
    @w_mensaje = null

  /* CALCULO IMPUESTO NX1000 */
  select
    @w_codigo_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @@rowcount = 0
  begin
    select
      @w_error = 101190,
      @w_sev = 0
    goto ERROR
  end

  if @w_codigo_pais = 'CO'
  begin
    select
      @w_tasa_imp = pa_float
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'IGMF'

    if @@rowcount <> 1
    begin
      select
        @w_error = 201196,
        @w_sev = 0
      goto ERROR
    end

    select
      @o_tipo_exonerado_imp = '1'

  end
  else
  begin
    /* Busqueda de la tasa del impuesto */
    select
      @w_tasa_imp = pa_float
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'TIDB'

    if @@rowcount <> 1
    begin
      select
        @w_error = 201196,
        @w_sev = 0
      goto ERROR
    end
  end

  /* Encuentra los decimales a utilizar */
  select
    @w_fldeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_fldeci = 'S'
  begin
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DCI'

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

  /* Determina factor para hacer credito o debito */
  if @t_corr = 'N'
  begin
    select
      @w_factor = 1,
      @w_signo = 'D',
      @w_estado = null
  end
  else
  begin
    select
      @w_factor = -1,
      @w_signo = 'C',
      @w_estado = 'R'
  end

  select
    @w_clave = 1

  /* Determina Nemonico de la Transaccion */
  select
    @w_nemo = tn_nemonico
  from   cobis..cl_ttransaccion
  where  tn_trn_code = @t_trn

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_cta_banco = @i_ctadb,
    @i_moneda    = @i_mon,
    @i_is_batch  = @i_is_batch,
    @o_cuenta    = @w_cuenta out,
    @o_filial    = @w_filial out,
    @o_oficina   = @w_oficina out,
    @o_tpromedio = @w_promedio out
  if @w_return <> 0
    return @w_return

  /* Calcular el saldo */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @w_fecha,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  /* Encuentra datos de trabajo de la cuenta */
  select
    @w_saldint = ah_saldo_interes,
    @w_disponible = ah_disponible,
    @w_promedio1 = ah_promedio1,
    @w_promdisp = ah_prom_disponible,
    @w_capitaliza = ah_capitalizacion,
    @w_lineas = ah_linea,
    @w_debmes = ah_debitos,
    @w_debhoy = ah_debitos_hoy,
    @o_nomdb = substring(ah_nombre,
                         1,
                         40),
    @o_idedb = ah_ced_ruc,
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @w_cliente = ah_cliente,
    @w_producto = ah_producto,
    @w_mon = ah_moneda,
    @w_clase_clte = ah_clase_clte,
    @w_categoria = ah_categoria,
    @w_producto = ah_producto,
    @o_12hdb = ah_12h,
    @o_24hdb = ah_24h,
    @o_remesasdb = ah_remesas,
    @o_blq_db = ah_monto_bloq,
    @o_tipocta_super = ah_tipocta_super,
    @w_tipocta = ah_tipocta,
    @w_rol_ente = ah_rol_ente,
    @w_tipo = ah_tipo,
    @w_tipo_def = ah_tipo_def,
    @w_codigo = ah_default,
    @w_personaliza = ah_personalizada,
    @w_reg_imp_nx1000 = ah_nxmil,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ndebmes = isnull(ah_num_deb_mes,
                        0),
    @w_prod_banc = ah_prod_banc,
    @w_estcta = ah_estado
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_ctadb
     and ah_moneda    = @i_mon
  if @@rowcount = 0
  begin
    select
      @w_error = 251001,
      @w_sev = 0
    goto ERROR
  end

  --REQ 330 VALIDACION IDENTIFICACION CLIENTE
  if exists (select
               1
             from   cobis..cl_val_iden
             where  vi_transaccion = @t_trn
                and vi_estado      = 'V'
                and (vi_ind_causal  = 'N'
                      or (vi_ind_causal  = 'S'
                          and vi_causal      = @i_causal)))
     and @t_corr <> 'S'
     and @i_valida_hom = 'S'
  begin
    -----------------------------------------------
    --invocar al servicio de validacion de huella
    -----------------------------------------------
    exec @w_return = cobis..sp_consulta_homini
      @s_term      = @s_term,
      @s_ofi       = @s_ofi,
      @i_operacion = 'V',
      @i_ref       = @i_ctadb,
      @i_user      = @s_user,
      @i_id_caja   = @i_idcaja,
      @i_sec_cobis = @s_ssn,
      @i_trn       = 2519,--@t_trn,
      @o_codigo    = @w_estado_id out,
      @o_mensaje   = @w_msg_valida out

    if @w_return <> 0
        or @@error <> 0
    begin
      if @i_is_batch = 'N'
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_return
      end

      return @w_return
    end

    -- VALIDACION MENSAJES RESTRICTIVOS HOMINI
    if @w_estado_id <> 0
    begin
      if @i_is_batch = 'N'
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_estado_id,
          @i_msg   = @w_msg_valida
      end

      return @w_estado_id
    end
  end

  /* REQ 306 VALIDA DEPOSITO INICIAL */
  if @w_estcta in ('G', 'N')
  begin
    if @i_is_batch = 'N'
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251099
    end

    return 251099
  end

  select
    @w_estcta = null

  /* REQ 217 AHORRO CONTRACTUAL DEBITO*/
  if @w_producto = 4
    select
      @w_modulo = 'AHO'
  else
    select
      @w_modulo = 'CTE'

  select
    @w_sucursal = isnull(of_sucursal,
                         of_regional)
  from   cobis..cl_oficina
  where  of_oficina = @s_ofi

  select distinct
    @w_pro_final = pf_pro_final
  from   cob_remesas..pe_pro_final,
         cob_remesas..pe_mercado,
         cob_remesas..pe_pro_bancario
  where  pf_filial       = @i_filial
     and pf_sucursal     = @w_sucursal
     and pf_producto     = @w_producto
     and pf_moneda       = @w_mon
     and me_tipo_ente    = @w_tipocta
     and pf_tipo         = @w_tipo
     and me_mercado      = pf_mercado
     and me_pro_bancario = pb_pro_bancario
     and me_pro_bancario = @w_prod_banc

  exec cob_remesas..sp_autoriza_trn_caja
    @t_trn        = 730,
    @i_operacion  = 'V',
    @i_modulo     = @w_modulo,
    @i_sucursal   = @w_sucursal,
    @i_producto   = @w_pro_final,
    @i_categoria  = @w_categoria,
    @i_tran       = @t_trn,
    @o_autorizada = @w_autoriza out

  if @w_autoriza = 'N'
  begin
    if @i_is_batch = 'N'
    begin
      exec cobis..sp_cerror -- Transaccion no autorizada para esta cuenta
        @t_from = @w_sp_name,
        @i_num  = 351575,
        @i_sev  = 0
    end
    return 1
  end

/* ADI: FIN - REQ 217 AHORRO CONTRACTUAL DEBITO */
  /* Valida que la cuenta no este embargada */
  if exists(select
              1
            from   cobis..cl_cuentas_embargo
            where  ce_cta_banco = @i_ctadb
               and ce_estado    = 'V')
  begin
    select
      @w_error = 252081,
      @w_sev = 1
    goto ERROR
  end

  select
    @w_alerta_cli = (select
                       case codigo
                         when 'NIN' then ''
                         else valor
                       end
                     from   cobis..cl_catalogo
                     where  tabla in
                            (select
                               codigo
                             from   cobis..cl_tabla
                             where  tabla = 'cl_accion_cliente')
                            and codigo = X.en_accion)
  from   cobis..cl_ente X
  where  en_ente = @w_cliente

  if @@rowcount > 0
    select
      @w_alerta = 'S'
  else
    select
      @w_alerta = 'N'

  select
    @w_sucursal = isnull(of_regional,
                         of_oficina)
  from   cobis..cl_oficina
  where  of_oficina = @w_oficina -- (Oficina de la cuenta)

  select
    @w_pro_final = pf_pro_final
  from   cob_remesas..pe_pro_final,
         cob_remesas..pe_mercado
  where  pf_mercado      = me_mercado
     and me_tipo_ente    = @w_tipocta
     and me_pro_bancario = @o_prod_banc
     and pf_filial       = @w_filial
     and pf_sucursal     = @w_sucursal
     and pf_producto     = @w_producto
     and pf_moneda       = @w_mon
     and pf_tipo         = @w_tipo

  if @@rowcount = 0
  begin
    select
      @w_error = 351527,
      @w_sev = 0
    goto ERROR
  end

  select
    @w_posteo = cp_posteo
  from   cob_remesas..pe_categoria_profinal
  where  cp_profinal  = @w_pro_final
     and cp_categoria = @o_categoria

  if @w_posteo is null
    select
      @w_posteo = 'N'

  if @w_tasa_imp > 0
     and @w_codigo_pais <> 'CO'
  begin
    /* Verificar que la cuenta este exonerada */
    select
      @o_tipo_exonerado_imp = ei_tipo_exonerado_imp
    from   cob_remesas..re_exoneracion_impuesto
    where  ei_producto = 'AHO'
       and ei_cuenta   = @w_cuenta

    if @@rowcount = 1
      select
        @w_tasa_imp = 0.0

  end

  if @w_tasa_imp > 0 /* Si es impuesto esta vigente o esta exento */
  begin
    select
      @w_num_cotit_deb = count(1)
    from   cobis..cl_det_producto,
           cobis..cl_cliente
    where  cl_det_producto = dp_det_producto
       and dp_cuenta       = @i_ctadb
       and dp_producto     = @i_prodeb
       and cl_rol          = 'C'

    select
      @w_num_cotit_deb = isnull(@w_num_cotit_deb,
                                0)

    select
      @w_num_cotit_dep = count(1)
    from   cobis..cl_det_producto,
           cobis..cl_cliente
    where  cl_det_producto = dp_det_producto
       and dp_cuenta       = @i_cta_dep
       and dp_producto     = @i_prodep
       and cl_rol          = 'C'

    select
      @w_num_cotit_dep = isnull(@w_num_cotit_dep,
                                0)

    if (@w_num_cotit_deb < 2
         or @w_num_cotit_dep < 2)
    begin
    /* Exoneracion de IDB */
      /* Chequeo de Titulares */
      if @i_prodep = 3
      begin
        exec cob_interfase..sp_icte_select_cc_ctacte
          @i_cuenta  = @i_cta_dep,
          @o_cliente = @w_titular out

        if isnull(@w_titular,
                  0) <> 0
        begin
          select
            @w_error = 201004,
            @w_sev = 0
          goto ERROR
        end
      end
      else if @i_prodep = 4
      begin
        select
          @w_titular = ah_cliente
        from   cob_ahorros..ah_cuenta
        where  ah_cta_banco = @i_cta_dep

        if @@rowcount <> 1
        begin
          select
            @w_error = 201004,
            @w_sev = 0
          goto ERROR
        end
      end
      if @w_num_cotit_dep = 1
      begin
        select
          @w_cotitular_dep = cl_cliente
        from   cobis..cl_det_producto,
               cobis..cl_cliente
        where  cl_det_producto = dp_det_producto
           and dp_cuenta       = @i_cta_dep
           and dp_producto     = @i_prodep
           and cl_rol          = 'C'

        if @@rowcount <> 1
        begin
          select
            @w_error = 105050,
            @w_sev = 0
          goto ERROR
        end
      end

      if @w_num_cotit_deb = 1
      begin
        select
          @w_cotitular_deb = cl_cliente
        from   cobis..cl_det_producto,
               cobis..cl_cliente
        where  cl_det_producto = dp_det_producto
           and dp_cuenta       = @i_ctadb
           and dp_producto     = @i_prodeb
           and cl_rol          = 'C'

        if @@rowcount <> 1
        begin
          select
            @w_error = 105050,
            @w_sev = 0
          goto ERROR
        end
      end

      if @w_num_cotit_deb = 0
         and @w_num_cotit_dep = 0
      begin
        if @w_titular = @w_cliente
        begin
          select
            @w_tasa_imp = 0,
            @o_tipo_exonerado_imp = '0'
        end
      end

      if @w_num_cotit_deb = 0
         and @w_num_cotit_dep = 1
      begin
        if (@w_titular = @w_cliente)
            or (@w_cotitular_dep = @w_cliente)
        begin
          select
            @w_tasa_imp = 0,
            @o_tipo_exonerado_imp = '0'
        end
      end
      if @w_num_cotit_deb = 1
         and @w_num_cotit_dep = 0
      begin
        if (@w_titular = @w_cliente)
            or (@w_titular = @w_cotitular_deb)
        begin
          select
            @w_tasa_imp = 0,
            @o_tipo_exonerado_imp = '0'
        end
      end

      if @w_num_cotit_deb = 1
         and @w_num_cotit_dep = 1
      begin
        if (@w_titular = @w_cliente)
            or (@w_titular = @w_cotitular_deb)
            or (@w_cotitular_dep = @w_cliente)
            or (@w_cotitular_dep = @w_cotitular_deb)
        begin
          select
            @w_tasa_imp = 0,
            @o_tipo_exonerado_imp = '0'
        end
      end

    end /* Este es el fin de la nueva validacion  de cotitulares */

  end /* Fin de la tasa de impuesto vigente */

  if @i_verifica_blq = 'S'
  begin
    /*  Determinacion de bloqueo de cuenta  */
    select
      @w_tipo_bloqueo = cb_tipo_bloqueo
    from   cob_ahorros..ah_ctabloqueada
    where  cb_cuenta       = @w_cuenta
       and cb_estado       = 'V'
       and (cb_tipo_bloqueo = '2'
             or cb_tipo_bloqueo = '3')
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
      select
        @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje

      select
        @w_error = 251007,
        @w_sev = 0
      goto ERROR
    end
  end

  /*  EXTRAER TOPES PARA EL TIPO DE PRODUCTO req 412*/
  if @t_corr = 'N'
  begin
    -- [DS 27-05-2014] Req 412 CB. Limites transaccionales
    exec @w_return = cob_remesas..sp_valida_limites_canal
      @s_ofi       = @s_ofi,
      @i_cta       = @i_ctadb,
      @i_tipo_prod = @w_producto,
      @i_fecha     = @s_date,
      @i_trn       = @t_trn,
      @i_val       = @i_val,
      @i_causal    = @i_causal,
      @o_msg       = @w_mensaje out

    if @w_return <> 0
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_msg  = @w_mensaje,
        @i_num  = @w_return,
        @i_sev  = 0

      return @w_return
    end
  end
/* FIN - REQ 412 EXTRAER TOPES PARA EL TIPO DE PRODUCTO */
  /* Calculo del monto de IDB */
  if @w_tasa_imp > 0
     and @w_codigo_pais <> 'CO'
    select
      @o_monto_imp = isnull(round((@i_val * @w_tasa_imp),
                                  @w_numdeci),
                            0)
  else
    select
      @o_monto_imp = 0

  /* Encuentra alicuota del promedio */
  select
    @w_alicuota = fp_alicuota
  from   ah_fecha_promedio
  where  fp_tipo_promedio = @w_promedio
     and fp_fecha_inicio  = @w_fecha
  if @@rowcount = 0
  begin
    select
      @w_error = 251013,
      @w_sev = 0
    goto ERROR
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
    select
      @w_error = 101190,
      @w_sev = 0
    goto ERROR
  end

  if @w_codigo_pais = 'CO' -- Colombia
  begin
    if @o_tipo_exonerado_imp = '1'
    begin
      select
        @o_val_GMF = $0

      --  Llama sp que calcula GMF de acuerdo a concepto exencion
      exec @w_return = sp_calcula_gmf
        @s_user            = @s_user,
        @s_date            = @w_fecha,
        @s_ofi             = @s_ofi,
        @t_trn             = @t_trn,
        @t_ssn_corr        = @t_ssn_corr,
        @i_is_batch        = @i_is_batch,
        @i_factor          = @w_factor,
        @i_mon             = @i_mon,
        @i_cta             = @i_ctadb,
        @i_cuenta          = @w_cuenta,
        @i_val             = @i_val,
        @i_val_tran        = @i_val,
        @i_numdeciimp      = @w_numdeci,
        @i_producto        = @w_producto,
        @i_operacion       = 'Q',
        @i_cliente         = @w_cliente,--JCO alianza
        @o_total_gmf       = @o_val_GMF out,
        @o_acumu_deb       = @w_acumu_deb out,
        @o_actualiza       = @w_actualiza out,
        @o_base_gmf        = @o_base_gmf out,
        @o_concepto        = @o_concep_exc out,
        @o_tasa_reintegro  = @o_tasa_reintegro out,--JCO alianza
        @o_valor_reintegro = @w_gmf_reintegro out --JCO alianza

      if @w_return <> 0
        return @w_return

      -- Calculo valor total de impuestos
      if @w_factor = 1
        select
          @o_monto_imp = isnull(@o_monto_imp, $0) + @o_val_GMF,
          @o_total_gmf = @o_total_gmf + @o_monto_imp,
          @w_gmf_valor = @o_val_GMF
      else
      begin
        select
          @w_val_2x1000 = isnull(tm_monto_imp,
                                 0)
        from   cob_ahorros..ah_tran_monet
        where  tm_ssn_branch  = @t_ssn_corr
           and tm_oficina     = @s_ofi
           and tm_cod_alterno = 1

        select
          @o_monto_imp = isnull(@o_monto_imp, $0) + @w_val_2x1000,
          @o_total_gmf = @o_total_gmf + @o_monto_imp,
          @w_gmf_valor = @w_val_2x1000
      end

      -- Consulta de ciudad para las oficinas de la cuenta
      -- y oficina con la que trabaja el sistema
      /*FRC-AHO-017-CobroComisiones CMU 2102110*/
      /*
      select
        @w_ciudad_cta = oc_centro
      from   cob_cuentas..cc_ofi_centro
      where  oc_oficina = @w_oficina
      */
	  --19/Sep/2016 Se descomenta consulta a cl_oficina y se comenta uso de cc_ofi_centro
	  select @w_ciudad_cta = of_ciudad
      from cobis..cl_oficina
      where of_oficina = @w_oficina
	  
      if @@rowcount <> 1
      begin
        select
          @w_error = 201094,
          @w_sev = 0
        goto ERROR
      end

      /*FRC-AHO-017-CobroComisiones CMU 2102110*/
      /*
	  select
        @w_ciudad_loc = oc_centro
      from   cob_cuentas..cc_ofi_centro
      where  oc_oficina = @s_ofi
	  */
	  
	  --19/Sep/2016 Se descomenta consulta a cl_oficina y se comenta uso de cc_ofi_centro
	  select @w_ciudad_loc = of_ciudad
      from cobis..cl_oficina
      where of_oficina = @s_ofi
	  
      if @@rowcount <> 1
      begin
        select
          @w_error = 201094,
          @w_sev = 0
        goto ERROR
      end

      if @w_factor = 1
      begin
        select
          @w_comision_trn = @i_comision

        if @w_ciudad_cta <> @w_ciudad_loc
        begin -- Se realiza el cobro de la comision por transaccion nacional
          if isnull(@w_comision_trn,
                    0) > 0
          begin
            select
              @w_iva = 0 -- No se cobra IVA sobre la comision

            select
              @w_valor_cobro = ((@w_comision_trn * @w_iva) / 100)
            select
              @w_valor_cobro_com = @w_valor_cobro + @w_comision_trn
            select
              @w_cobro_total = @w_valor_cobro_com + @w_val_total
            select
              @w_cobro_total = @w_comision_trn + @w_val_total

            if @w_cobro_total > @w_saldo_para_girar
            begin /* Fondos Insuficientes */
              select
                @w_realizar_deb = 0
              select
                @w_error = 251033,
                @w_sev = 0
              goto ERROR
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
        select
          @w_error = 101077,
          @w_sev = 0
        goto ERROR
      end

      --Consulta si producto tienen parametrizado cobro tipo T o C

      select
        @w_cobro_comision = @i_comision
    end
  end

  /*FRC-AHO-017-CobroComisiones CMU 2102110*/
  if @w_ciudad_cta = @w_ciudad_loc
    select
      @w_ndebmes = @w_ndebmes + (1 * @w_factor)

  if @i_is_batch = 'N'
    begin tran

  /* Validar Fondos para Notas de Debito */
  if (@i_val + @o_monto_imp) > @w_saldo_para_girar
     and @i_sobregirar = 'N'
     and @w_factor = 1
  begin
    select
      @w_error = 251051,
      @w_sev = 0
    goto ERROR
  end

  if @w_posteo = 'S' -- Si es 'S' mantener lineas pendientes
  begin
    select
      @w_control = @i_ncontrol,
      @w_linpen = @i_lpend

    /* Inserta en Linea Pendiente */
    select
      @w_lineas = @w_lineas + 1

    insert into cob_ahorros..ah_linea_pendiente
                (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                 lp_control,lp_signo,lp_enviada)
    values      (@w_cuenta,@w_linpen,@w_nemo,@i_val,@w_fecha,
                 @w_control,@w_signo,'N')

    if @@error <> 0
    begin
      select
        @w_error = 253002,
        @w_sev = 0
      goto ERROR
    end

    /* Inserta en Linea Pendiente el monto IDB */
    if @o_monto_imp > 0
    begin
      select
        @w_lineas = @w_lineas + 1

      insert into cob_ahorros..ah_linea_pendiente
                  (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                   lp_control,lp_signo,lp_enviada)
      values      (@w_cuenta,@w_linpen + 1,'IDB',@o_monto_imp,@w_fecha,
                   @w_control + 1,@w_signo,'N')

      if @@error <> 0
      begin
        select
          @w_error = 253002,
          @w_sev = 0
        goto ERROR
      end
    end

  end

  /* Actualizacion de tabla de cuentas de Ahorros */
  select
    @w_alic = convert (money, round(((@i_val + isnull(@o_monto_imp, 0) + isnull(
                                             @o_monto_iva,
                                                       0)) *
                                     @w_alicuota)
                              ,
                                    @w_numdeci))
  select
    @w_promedio1 = @w_promedio1 - @w_alic * @w_factor
  select
    @w_promdisp = @w_promdisp - @w_alic * @w_factor
  select
    @w_disponible = @w_disponible - (@i_val + isnull(@o_monto_imp, 0) + isnull(
    @o_monto_iva
    , 0)) *
    @w_factor --Descontar el costo de la comision @i_comision
  select
    @w_saldo_contable = @w_saldo_contable - (@i_val + @o_monto_imp + isnull(
                                                    @o_monto_iva, 0)) *
                                                   @w_factor
  select
    @o_salcondb = @w_saldo_contable,
    @o_saldisdb = @w_disponible
  select
    @w_debmes = @w_debmes + (@i_val + @o_monto_imp + isnull(@o_monto_iva, 0)) *
                                                                   @w_factor,
    @w_debhoy = @w_debhoy + (@i_val + @o_monto_imp + isnull(@o_monto_iva, 0)) *
                            @w_factor
  select
    @o_saldo_girar_db = @w_saldo_para_girar - @i_val * @w_factor

  update cob_ahorros..ah_cuenta
  set    ah_disponible = @w_disponible,
         ah_promedio1 = @w_promedio1,
         ah_prom_disponible = @w_promdisp,
         ah_debitos = @w_debmes,
         ah_debitos_hoy = @w_debhoy,
         ah_fecha_ult_mov = @w_fecha,
         ah_fecha_ult_upd = @w_fecha,
         ah_linea = @w_lineas,
         ah_contador_trx = ah_contador_trx + @w_factor,
         ah_fecha_ult_ret = @w_fecha,
         ah_monto_imp = ah_monto_imp + @o_monto_imp,
         /*FRC-AHO-017-CobroComisiones CMU 2102110*/
         ah_num_deb_mes = @w_ndebmes
  where  ah_cuenta = @w_cuenta

  if @@error <> 0
  begin
    select
      @w_error = 253001,
      @w_sev = 1
    goto ERROR
  end

  /*****PEDRO COELLO REVERSA LA TRANSACCION ORIGINAL *****/

  if @w_factor = -1
  begin
    update cob_ahorros..ah_transferencia
    set    estado = @w_estado
    where  ssn_branch = @t_ssn_corr
       and oficina    = @s_ofi
       and tipo_tran  = @t_trn
       and ctaorigen  = @i_ctadb
       and ctadestino = @i_cta_dep
       and valor      = @i_val

    if @@rowcount <> 1
    begin /* Error en actualizacion de registro en cc_tran_mo */
      select
        @w_error = 205032,
        @w_sev = 1
      goto ERROR
    end
  end

  /* Transaccion Monetaria */
  insert into cob_ahorros..ah_transferencia
              (secuencial,ssn_branch,tipo_tran,oficina,usuario,
               terminal,correccion,sec_correccion,reentry,origen,
               nodo,fecha,ctaorigen,ctadestino,valor,
               tipo_xfer,remoto_ssn,moneda,signo,saldocont,
               saldodisp,alterno,oficina_cta,filial,prod_banc,
               categoria,referencia,monto_imp,tipo_exonerado_imp,tipocta_super,
               turno,traslado,hora,canal,estado,
               cliente,base_gmf,clase_clte)
  values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
               @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
               @s_srv,@w_fecha,@i_ctadb,@i_cta_dep,@i_val,
               @i_tipo,@s_ssn_branch,@i_mon,@w_signo,@w_saldo_contable,
               @w_disponible,@i_sec,@w_oficina,@w_filial,@o_prod_banc,
               @o_categoria,@i_referencia,@o_monto_imp,@o_tipo_exonerado_imp,
               @o_tipocta_super,
               @i_turno,@i_por_traslado,getdate(),@i_canal,@w_estado,
               @w_cliente,@o_base_gmf,@w_clase_clte)
  if @@error <> 0
  begin
    select
      @w_error = 253000,
      @w_sev = 0
    goto ERROR
  end

  if @w_codigo_pais = 'CO' -- Colombia
  begin
    -- Actualiza acumulados topes gmf
    if @w_actualiza = 'S'
    begin
      exec @w_return = sp_calcula_gmf
        @s_date      = @w_fecha,
        @i_is_batch  = @i_is_batch,
        @i_cuenta    = @w_cuenta,
        @i_producto  = @w_producto,
        @i_operacion = 'U',
        @i_acum_deb  = @w_acumu_deb

      if @w_return <> 0
        return @w_return
    end

    -- ND Comision Transaccion Nacional e IVA

    if @w_factor = -1
    begin
      -- Reverso Comision e IVA
      select
        @w_comision_trn = 0

      select
        @w_comision_trn = fv_costo
      from   cob_ahorros..ah_fecha_valor
      where  fv_transaccion = @t_trn
         and fv_referencia  = convert(varchar(24), @t_ssn_corr)
         and fv_rubro       = '1'

      if isnull(@w_comision_trn,
                0) > 0
        select
          @w_realizar_deb = 1
    end

    select
      @w_realizar_deb = 1

    if @w_realizar_deb = 1
    begin
      if @w_factor = 1
        select
          @w_comision_trn = @i_comision

      if isnull(@w_comision_trn,
                0) > 0
      begin
        if @w_ciudad_cta <> @w_ciudad_loc
          select
            @w_alt = 10
        else
          select
            @w_alt = 12

        select
          @w_valiva = 0,
          @w_gmf = 0

        exec @w_return = cob_ahorros..sp_ahndc_automatica
          @s_srv        = @s_srv,
          @s_ofi        = @s_ofi,
          @s_ssn        = @s_ssn,
          @s_ssn_branch = @s_ssn_branch,
          @s_user       = @s_user,
          @t_trn        = 264,
          @t_corr       = @t_corr,
          @t_ssn_corr   = @t_ssn_corr,
          @i_is_batch   = @i_is_batch,
          @i_cta        = @i_ctadb,
          @i_val        = @w_comision_trn,
          @i_cau        = @i_causal,
          @i_mon        = @i_mon,
          @i_alt        = @w_alt,
          @i_fecha      = @w_fecha,
          @i_cobiva     = 'S',
          @i_canal      = @i_canal,
          @o_valiva     = @w_valiva out,
          @o_val_2x1000 = @w_gmf out
        if @w_return <> 0
          return @w_return

        if @w_factor = 1
        begin
          /* Inserto en ah_fecha_valor el valor de la comision CPA */
          insert into cob_ahorros..ah_fecha_valor
                      (fv_transaccion,fv_cuenta,fv_referencia,fv_rubro,fv_costo)
          values      (@t_trn,@w_cuenta,convert(varchar(24), @s_ssn_branch),'1',
                       @w_comision_trn)

          if @@error <> 0
          begin
            select
              @w_error = 601161,
              @w_sev = 0
            goto ERROR
          end

          if isnull(@w_valiva,
                    0) > 0
          begin
            -- Inserto en ah_fecha_valor el valor del iva CPA
            insert into cob_ahorros..ah_fecha_valor
                        (fv_transaccion,fv_cuenta,fv_referencia,fv_rubro,
                         fv_costo)
            values      (@t_trn,@w_cuenta,convert(varchar(24), @s_ssn_branch),
                         '2',
                         @w_valiva)
            if @@error <> 0
            begin
              select
                @w_error = 601161,
                @w_sev = 0
              goto ERROR
            end
          end

        end
        else
        begin
          -- Actualiza movimiento Original
          update cob_ahorros..ah_tran_monet
          set    tm_estado = 'R'
          where  tm_oficina     = @s_ofi
             and tm_ssn_branch  = @t_ssn_corr
             and tm_cta_banco   = @i_ctadb
             and tm_tipo_tran   = 264
             and tm_cod_alterno = @w_alt
             and tm_estado is null

          if @@error <> 0
          begin
            -- Error en la eliminacion
            select
              @w_error = 208052,
              @w_sev = 1
            goto ERROR
          end

          -- Borro los registros de ah_fecha_valor
          delete cob_ahorros..ah_fecha_valor
          where  fv_transaccion = @t_trn
             and fv_referencia  = convert(varchar(24), @t_ssn_corr)
             and fv_rubro in('1', '2')

          if @@error <> 0
          begin
            select
              @w_error = 208052,
              @w_sev = 0
            goto ERROR
          end
        end

        select
          @o_comision = @o_comision + @w_comision_trn,
          @o_monto_iva = @o_monto_iva + @w_valiva,
          @o_total_gmf = @o_total_gmf + @w_gmf

      end
    end

    -- AUTOMATICA TARIFARIO
    if isnull(@w_cobro_tarifa,
              0) > 0
       and @i_alianza = 'N'
    begin
      -- ND por  valor comision
      select
        @w_valiva_tarifa = 0,
        @w_gmf = 0

      exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv        = @s_srv,
        @s_ofi        = @s_ofi,
        @s_ssn        = @s_ssn,
        @s_ssn_branch = @s_ssn_branch,
        @s_user       = @s_user,
        @t_trn        = 264,
        @t_corr       = @t_corr,
        @t_ssn_corr   = @t_ssn_corr,
        @i_is_batch   = @i_is_batch,
        @i_cta        = @i_ctadb,
        @i_val        = @w_cobro_tarifa,
        @i_cau        = '31',-- causa cobro comision ret ventanilla
        @i_mon        = @i_mon,
        @i_alt        = 11,
        @i_fecha      = @w_fecha,
        @i_cobiva     = 'S',
        @i_canal      = @i_canal,
        @o_valiva     = @w_valiva out,
        @o_monto_imp  = @w_gmf out

      if @w_return <> 0
        return @w_return

      select
        @o_comision = @o_comision + @w_cobro_tarifa,
        @o_monto_iva = @o_monto_iva + @w_valiva_tarifa,
        @o_total_gmf = @o_total_gmf + @w_gmf

      if @w_factor = -1
      begin
        -- Actualiza movimiento Original
        update cob_ahorros..ah_tran_monet
        set    tm_estado = 'R'
        where  tm_oficina     = @s_ofi
           and tm_ssn_branch  = @t_ssn_corr
           and tm_cta_banco   = @i_ctadb
           and tm_tipo_tran   = 264
           and tm_cod_alterno = 11
           and tm_estado is null

        if @@error <> 0
        begin
          -- Error en la eliminacion
          select
            @w_error = 208052,
            @w_sev = 1
          goto ERROR
        end

      end
    end

  end

  /* reitengro de GMF CUANDO LA TRANSACCION ES POR CAJA  */
  if @i_alianza = 'N'
     and @w_gmf_valor > 0
  begin
    if @w_factor <> 1
      select
        @w_gmf_reintegro = isnull(round(isnull(@w_gmf_valor,
                                               0) * (@o_tasa_reintegro / 100),
                                        @w_numdeci),
                                  0)

    if @w_gmf_reintegro > 0
    begin
      execute @w_return = sp_reintegro_gmf
        @s_srv        = @s_srv,
        @s_ofi        = @s_ofi,
        @s_ssn        = @s_ssn,
        @s_ssn_branch = @s_ssn_branch,
        @t_corr       = @t_corr,
        @t_ssn_corr   = @t_ssn_corr,
        @s_date       = @w_fecha,
        @i_cuenta     = @w_cuenta,
        @i_valor      = @w_gmf_reintegro,
        @i_mon        = @i_mon,
        @i_alterno    = 50,
        @i_factor     = @w_factor,
        @i_cliente    = @w_cliente,
        @i_posteo     = @w_posteo,
        @i_base_gmf   = @o_base_gmf

      if @w_return <> 0
      begin
        if @i_is_batch = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 252093
        end
        return 252093
      end

    end
  end

  if @w_factor = 1
    select
      @w_oper_cont = 'I'
  else
    select
      @w_oper_cont = 'D'

  /* Actualiza el contador de transacciones */
  exec @w_return = sp_act_cont_trn
    @s_date       = @s_date,
    @t_debug      = @t_debug,
    @i_operacion  = @w_oper_cont,
    @i_cta        = @i_ctadb,
    @i_trn_accion = @t_trn

  if @w_return <> 0
    return @w_return

  if @i_is_batch = 'N'
    commit tran
  return 0

  ERROR:
  if @i_is_batch = 'N'
  begin
    exec cobis..sp_cerror
      @t_debug = null,
      @t_file  = null,
      @t_from  = @w_sp_name,
      @i_num   = @w_error,
      @i_sev   = @w_sev,
      @i_msg   = @w_mensaje

    if @w_sev = 1
      rollback tran
  end

  return @w_error

go

