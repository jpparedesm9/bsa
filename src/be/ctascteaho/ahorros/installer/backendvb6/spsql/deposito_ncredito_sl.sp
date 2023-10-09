/************************************************************************/
/*  Archivo:            deposito_ncredito_sl.sp                         */
/*  Stored procedure:   sp_deposito_ncredito_sl                         */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 25-Feb-1993                                     */
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
/*  Este programa procesa las transacciones de depositos y notas de     */
/*  credito sin libreta                                                 */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA        AUTOR           RAZON                                  */
/*  25/Feb/1993  J. Navarrete    Emision inicial                        */
/*  12/Oct/1994  P. Mena         Inclusion del contador de              */
/*                               transacciones                          */
/*  19/Ene/1996  D. Villafuerte  Control de Calidad (param rem)         */
/*  30/Nov/1998  J. Salazar      Cobro de comision por la transac       */
/*  23/Jun/1999  J. Gordillo     DB                                     */
/*  25/Nov/2002  C. Cruz D.      Branch III                             */
/*  18/Mar/2005  L. Bernuil      Validacion de fecha de ult mov         */
/*  21/ene/2010  CMunoz          FRC-AHO-017-CobroComisiones CMU 2102110*/
/*  04/Feb/2010  J.Loyo          Valida el Saldo Minimo de la           */
/*                               Cuenta y envia el saldo maximo         */
/*                               que puede tener una cuenta             */
/*  17/Feb/2010  J. Loyo         Manejo de la fecha de efectivizacion   */
/*                               teniendo el sabado como habil          */
/*  27/Abr/2012  e.jimenez       Manejo de validacion para el req 203   */
/*                               transacciones diarias                  */
/*  11/Feb/2013  D. Alfonso      Verificar si la transaccion de         */
/*                               deposito requiere validacion identidad */
/*                               cliente.                               */
/*  14/Feb/2013  L.Moreno        NC Generacion de GMF a cargo de        */
/*                               Bancamia para algunas causales         */
/*  03/Jul/2014  C. Avendano     Se agrega restriccion para no transac  */
/*                               cionar con cuentas de CB               */
/*  03/May/2016  J. Salazar      Migracion COBIS CLOUD MEXICO           */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_deposito_ncredito_sl')
  drop proc sp_deposito_ncredito_sl
go

/****** Object:  StoredProcedure [dbo].[sp_deposito_ncredito_sl]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_deposito_ncredito_sl
(
  @s_rol           smallint,
  @s_ssn           int,
  @s_ssn_branch    int = null,/*Cambios BRANCHII */
  @s_user          varchar(30),
  @s_term          varchar(10),
  @s_srv           varchar(30),
  @s_ofi           int = null,/*Cambios BRANCHII */
  @s_date          datetime,/*Cambios BRANCHII */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(30) = null,
  @t_trn           int,
  @t_corr          char(1) = null,
  @t_ssn_corr      int = null,
  @t_ejec          char(1) = 'N',/*Cambios BRANCHII */
  @t_rty           char(1) = 'N',
  @t_show_version  bit = 0,
  @i_ofi           smallint,
  @i_cuenta        int,
  @i_efe           money,
  @i_prop          money,
  @i_loc           money,
  @i_plaz          money,
  @i_mon           tinyint,
  @i_credit        money,
  @i_ind           tinyint,
  @i_factor        smallint,
  @i_fecha         smalldatetime,
  @i_ope           char(2),
  @i_ncontrol      int,
  @i_lpend         int,
  @i_dif           char(1) = 'N',
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_turno         smallint = null,

  --CCR BRANCH III
  @i_fecha_valor_a datetime = null,
  @i_cau           char(3),
  @i_pago_servicio char(1) = 'N',

  --PCOELLO SI ES LLAMADO DESDE PAGOS DE SERVICIOS
  @i_canal         smallint = 4,
  @i_comision      money,--REQ203
  @i_causal        char(3),--REQ203
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_nombre        varchar(60) out,
  @o_cedula        varchar(12) out,
  @o_prod_banc     smallint out,
  @o_cliente       int = 0 out,
  @o_alerta_cli    varchar(40) = null out,
  @o_categoria     char(1) out,
  @o_tipocta_super char(1) = null out,
  @o_clase_clte    char(1) = null out,
  @o_comision      money = 0 out,
  @o_valiva        money = 0 out
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_alicuota           float,
    @w_fecha              datetime,
    @w_suspensos          smallint,
    @w_contador           smallint,
    @w_secuencial         int,
    @w_acum               money,
    @w_clave              int,
    @w_numdeci            tinyint,
    @w_tot_alic           float,
    @w_dis_alic           float,
    @w_tot                money,
    @w_disponible         money,
    @w_promedio1          money,
    @w_promedio2          money,
    @w_promedio3          money,
    @w_promedio4          money,
    @w_promedio5          money,
    @w_promedio6          money,
    @w_24h                money,
    @w_12h                money,
    @w_12h_dif            money,
    @w_48h                money,
    @w_saldo_para_girar   money,
    @w_saldo_contable     money,
    @w_remesas            money,
    @w_valor              money,
    @w_creditos           money,
    @w_monto_bloq         money,
    @w_nctrl              int,
    @w_cliente            int,
    @w_linea              smallint,
    @w_nemo               char(4),
    @w_rem_hoy            money,
    @w_mensaje            mensaje,
    @w_tipo_bloqueo       char(3),
    @w_tipo_prom          char(1),
    @w_usadeci            char(1),
    @w_estado             char(1),
    @w_prom_disp          money,
    @w_contador_trx       int,
    @w_fapert             smalldatetime,
    @w_fultmv             smalldatetime,
    @w_dep_ini            tinyint,
    @w_creditos_hoy       money,
    @w_debitos            money,
    @w_debitos_hoy        money,
    @w_cont               tinyint,
    @w_dias_ret           tinyint,
    @w_ciudad             int,
    @w_oficina            smallint,
    @w_oficial            smallint,
    @w_bloqueos           smallint,
    @w_numlib             int,
    @w_fecha_efe          smalldatetime,
    @w_num_blqmonto       int,
    @w_cta_funcionario    char(1),
    @w_tipocta            char(1),
    @w_tipo_ente          char(1),
    @w_rol_ente           char(1),
    @w_tipo_def           char(1),
    @w_default            int,
    @w_personalizada      char(1),
    @w_cuenta             int,
    @w_nemo2              char(4),
    @w_comision           money,
    @w_com_trna           money,
    @w_cta_banco          cuenta,
    @w_tasa_imp           float,
    @w_monto_imp          money,
    @w_tipo_exonerado_imp char(2),
    @w_cuota              money,-- lgr
    @w_mult               money,
    @w_suma               money,
    @w_cod_prdnav         smallint,
    @w_moneda_local       tinyint,
    @w_num_cuoprdnav      tinyint,
    /*LBM */
    @w_act_fecha          char(1),
    @w_fecha_ult_mov      datetime,--LBM
    @w_hora_ejecucion     smalldatetime,
    @w_filial             tinyint,
    @w_tipo               char(1),
    @w_codigo             int,
    @w_ciudad_cta         int,
    @w_ciudad_loc         int,
    @w_val_cob_rev        money,
    @w_codigo_pais        char(3),
    @w_cobro_total        money,
    @w_realizar_deb       tinyint,
    @w_iva                float,
    @w_valor_cobro        money,
    @w_valor_cobro_com    money,
    @w_valiva             money,
    @w_val_total          money,
    @w_producto           tinyint,
    @w_trn                int,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_numdeb             int,
    @w_ncredmes           int,
    @w_cobro_comision     money,
    @w_numcre             int,
    @w_numtot             int,
    @w_numero             int,
    @w_numco              int,
    @w_numtotcta          int,
    /** Validacion saldo Maximo ***/
    @w_saldo_max          money,
    @w_tipocobro          char(1),
    @w_alerta_cli         varchar(40),
    @w_gmf                money,
    @w_total_gmf          money,
    -- ADI: REQ 217 AHORRO CONTRACTUAL
    @w_moneda             tinyint,
    @w_modulo             char(3),
    @w_pro_final          smallint,
    @w_sucursal           smallint,
    @w_autoriza           char(1),
    @w_val                money,
    -- REQ 306 VALIDA DEPOSITO INICIAL
    @w_causal_depini      varchar(3),
    @w_posteo             char(1),
    @w_deposito_min       money,
    @w_comision_trn       money,--Req 203
    @w_oper_cont          char(1),
    /********VARIABLES REQ 330**************/
    @w_estado_id          int,
    @w_tipo_ced           char(2),
    @w_ced_ruc            numero,
    @w_msg_valida         varchar(64),
    @w_corresponsal       varchar(1),--Req. 381 CB Red Posicionada
    @w_prod_banc_cb       smallint --REQ 381

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_deposito_ncredito_sl'
  select
    @w_hora_ejecucion = convert(varchar(5), getdate(), 108)

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

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
      i_credit = @i_credit,
      i_ind = @i_ind,
      i_factor = @i_factor,
      i_fecha = @i_fecha
    exec cobis..sp_end_debug
  end

  /* LBM -- Colocarle el valor default a la variable @w_act_fecha */
  select
    @w_act_fecha = 'S'
  select
    @o_comision = 0,
    @o_valiva = 0,
    @w_total_gmf = 0

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
    return 251007
  end

  /*LBM -- Verificamos la tabla re_propiedad_ndc para establecer si se afecta la fecha de ultimo movimiento */
  if @t_trn = 253
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
    @o_nombre = substring (ah_nombre,
                           1,
                           60),
    @w_12h = ah_12h,
    @w_12h_dif = ah_12h_dif,
    @w_24h = ah_24h,
    @w_48h = ah_48h,
    @w_disponible = ah_disponible,
    @w_suspensos = ah_suspensos,
    @w_linea = ah_linea,
    @w_creditos = ah_creditos,
    @w_creditos_hoy = ah_creditos_hoy,
    @w_debitos = ah_debitos,
    @w_debitos_hoy = ah_debitos_hoy,
    @w_promedio1 = ah_promedio1,
    @w_promedio2 = ah_promedio2,
    @w_promedio3 = ah_promedio3,
    @w_promedio4 = ah_promedio4,
    @w_promedio5 = ah_promedio5,
    @w_promedio6 = ah_promedio6,
    @w_prom_disp = ah_prom_disponible,
    @w_contador_trx = ah_contador_trx,
    @w_fapert = ah_fecha_aper,
    @w_fultmv = ah_fecha_ult_mov,
    @w_dep_ini = ah_dep_ini,
    @w_monto_bloq = ah_monto_bloq,
    @w_estado = ah_estado,
    @w_num_blqmonto = ah_num_blqmonto,
    @w_oficina = ah_oficina,
    @w_oficial = ah_oficial,
    @o_cedula = ah_ced_ruc,
    @w_bloqueos = ah_bloqueos,
    @w_numlib = ah_numlib,
    @w_cta_banco = ah_cta_banco,
    @w_tipo_ente = ah_tipocta,
    @o_clase_clte = ah_clase_clte,
    @w_rol_ente = ah_rol_ente,
    @w_tipo = ah_tipo,
    @w_tipo_def = ah_tipo_def,
    @w_default = ah_default,
    @w_personalizada = ah_personalizada,
    @w_cuenta = ah_cuenta,
    @w_cuota = ah_cuota,--lgr
    @w_fecha_ult_mov = ah_fecha_ult_mov,--LBM
    @w_codigo = ah_default,
    @w_producto = ah_producto,
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @o_tipocta_super = ah_tipocta_super,
    @w_filial = ah_filial,
    @w_cliente = ah_cliente,
    @w_moneda = ah_moneda,--Req 306
    @w_cta_banco = ah_cta_banco,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ncredmes = isnull(ah_num_cred_mes,
                         0),
    @w_numtotcta = isnull(ah_num_con_mes, 0) + isnull(ah_num_cred_mes, 0) +
                   isnull
                   (
                   ah_num_deb_mes
                   , 0)
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @i_cuenta

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
  select
    @o_alerta_cli = @w_alerta_cli

  /* REQ 306 - SI LA CUENTA ESTA EN ESTADO ANULADA */

  if @w_estado = 'N'
  begin
    exec cobis..sp_cerror -- 251096 Tiempo para primer deposito concluido
      @t_from = @w_sp_name,
      @i_num  = 251096,
      @i_sev  = 0

    return 251096
  end

  select
    @w_prod_banc_cb = isnull(pa_smallint,
                             0)
  from   cobis..cl_parametro
  where  pa_nemonico = 'PBCB'
     and pa_producto = 'AHO'

  if @w_prod_banc_cb = @o_prod_banc
     and @t_trn <> 253
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 251007,
      @i_sev  = 0,
      @i_msg  = 'TRANSACCION NO PERMITIDA PARA CUENTA CB'

    return 251007
  end

  if @w_prod_banc_cb = @o_prod_banc
    select
      @w_corresponsal = 'S'
  else
    select
      @w_corresponsal = 'N'

  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @i_cuenta,
    @i_fecha            = @i_fecha,
    @i_ofi              = @s_ofi,
    @i_corresponsal     = @w_corresponsal,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out,
    @o_saldo_max        = @w_saldo_max out
  /* Recibimos  el saldo Maximo para la cuenta */
  if @w_return <> 0
    return @w_return

  /********REQ 330 *********************/

  if exists (select
               1
             from   cobis..cl_val_iden
             where  vi_transaccion = @t_trn
                and vi_estado      = 'V'
                and (vi_ind_causal  = 'N'
                      or (vi_ind_causal  = 'S'
                          and vi_causal      = @i_cau)))
     and @t_corr <> 'S'
  begin
    select
      @w_tipo_ced = en_tipo_ced,
      @w_ced_ruc = en_ced_ruc
    from   cobis..cl_ente
    where  en_ente = @w_cliente
  /*validaci¾n existencia*/
    -----------------------------------------------
    --inseta registro a validar la huella
    -----------------------------------------------
    exec @w_return = cobis..sp_consulta_homini
      @s_term        = @s_term,
      @s_ofi         = @s_ofi,
      @t_trn         = 1608,
      @i_operacion   = 'I',
      @i_titularidad = 'I',
      @i_tipo_ced    = @w_tipo_ced,
      @i_ced_ruc     = @w_ced_ruc,
      @i_ref         = @w_cta_banco,
      @i_user        = @s_user,
      @i_id_caja     = @i_idcaja,
      @i_trn         = @t_trn,
      @i_sec_cobis   = @s_ssn

    if @w_return <> 0
        or @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return

      return @w_return
    end

    -----------------------------------------------
    --invocar al servicio de validacion de huella
    -----------------------------------------------
    exec @w_return = cobis..sp_consulta_homini
      @s_term      = @s_term,
      @s_ofi       = @s_ofi,
      @i_operacion = 'V',
      @i_ref       = @w_cta_banco,
      @i_user      = @s_user,
      @i_id_caja   = @i_idcaja,
      @i_sec_cobis = @s_ssn,
      @i_trn       = @t_trn,
      @o_codigo    = @w_estado_id out,
      @o_mensaje   = @w_msg_valida out

    if @w_return <> 0
        or @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return

      return @w_return
    end

    -- VALIDACION MENSAJES RESTRICTIVOS HOMINI 
    if @w_estado_id <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = @w_msg_valida,
        @i_num   = @w_estado_id

      return @w_estado_id
    end

  /* Contenido no existente en el catalogo*/
  end

/***********FIN REQ 330****************************************************/
  /* REQ 306 - SI CUENTA EN ESTADO INGRESADA, VALIDAR MONTO PRIMER DEPOSITO */
  if @w_estado = 'G'
  begin
    exec @w_return = cob_remesas..sp_genera_costos
      @i_categoria   = @o_categoria,
      @i_tipo_ente   = @w_tipo_ente,
      @i_rol_ente    = @w_rol_ente,
      @i_tipo_def    = @w_tipo_def,
      @i_prod_banc   = @o_prod_banc,
      @i_producto    = @w_producto,
      @i_moneda      = @w_moneda,
      @i_tipo        = 'R',
      @i_codigo      = 0,
      @i_servicio    = 'MMAP',
      @i_rubro       = '39',
      @i_disponible  = $0,
      @i_contable    = $0,
      @i_promedio    = $0,
      @i_personaliza = 'N',
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

    if @t_trn = 252
      select
        @w_val = @i_efe
    else
      select
        @w_val = @i_credit

    if (isnull(@w_val, 0) + isnull(@i_loc, 0) + isnull(@i_prop, 0) + isnull(
        @i_plaz, 0
                                    )) < @w_deposito_min
    begin
      exec cobis..sp_cerror
        -- 251098 Monto depositado inferior al monto minimo establecido
        @t_from = @w_sp_name,
        @i_num  = 251098,
        @i_sev  = 0

      return 251098
    end
  end

  /* ADI: REQ 217 AHORRO CONTRACTUAL */
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
     and pf_moneda       = @w_moneda
     and me_tipo_ente    = @w_tipo_ente
     and pf_tipo         = @w_tipo
     and me_mercado      = pf_mercado
     and me_pro_bancario = pb_pro_bancario
     and me_pro_bancario = @o_prod_banc

  exec cob_remesas..sp_autoriza_trn_caja
    @t_trn        = 730,
    @i_operacion  = 'V',
    @i_modulo     = @w_modulo,
    @i_sucursal   = @w_sucursal,
    @i_producto   = @w_pro_final,
    @i_categoria  = @o_categoria,
    @i_tran       = @t_trn,
    @o_autorizada = @w_autoriza out

  if @w_autoriza = 'N'
  begin
    exec cobis..sp_cerror -- Transaccion no autorizada para esta cuenta
      @t_from = @w_sp_name,
      @i_num  = 351575,
      @i_sev  = 0
    return 1
  end

/* ADI: FIN - REQ 217 AHORRO CONTRACTUAL */
  /* REQ 306 DEPOSITO INICIAL APERTURA AHO */
  if @t_trn = 253
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
    @i_moneda     = @w_moneda,
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
  --Si el producto de la cuenta de es cifradas chequeo si es una oficina valida
  if @w_tipo_ente = 'I'
  begin
    select
      1
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

  --if @w_dep_ini <> 0
  --begin
  --   /* Error cuenta sin depositos */
  --   exec cobis..sp_cerror
  --   @t_debug = @t_debug,
  --   @t_file  = @t_file,
  --   @t_from  = @w_sp_name,
  --   @i_num   = 201158
  --   return 1
  --end

  select
    @w_moneda_local = pa_tinyint -- lgr
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CMNAC'

  select
    @w_moneda_local = pa_tinyint -- lgr
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CMNAC'

  select
    @w_codigo_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @w_codigo_pais is null
    select
      @w_codigo_pais = 'PA'

  if @w_codigo_pais = 'CO' -- Colombia
  begin
    -- Consulta de ciudad para las oficinas de la cuenta
    -- y oficina con la que trabaja el sistema

  /* select @w_ciudad_cta = of_ciudad
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

    if @t_trn = 252
        or @t_trn = 253
    begin
      select
        @w_trn = 264

      if @i_factor = 1
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
    end
  end
  else
    select
      @w_ciudad_cta = 0,
      @w_ciudad_loc = 0

  select
    @w_cod_prdnav = pa_smallint
  from   cobis..cl_parametro
  where  pa_nemonico = 'PRDNAV'
     and pa_producto = 'AHO'

  if (@t_trn = 252
       or @t_trn = 251
       or @t_trn = 207
       or @t_trn = 246
       or @t_trn = 248
       or @i_pago_servicio = 'S')
  begin
    select
      @w_num_cuoprdnav = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'CUOTA'
       and pa_producto = 'AHO'

    if @t_trn not in (253, 255)
    begin
      if @w_cod_prdnav = @o_prod_banc
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
      --@i_msg   = 'SOLO EFECTIVO ACEPTA LA CUENTA NAVIDENA'
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
      --@i_msg = 'CUOTA NO CORRESPONDE A LA CUENTA NAVIDENA'
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
        --@i_msg = 'CUOTA NO CORRESPONDE A LA CUENTA NAVIDENA' 
        return 1
      end
    end
  end

  if (@w_tasa_imp > 0
      and @i_factor = 1)
  begin
    /* Verificar que la cuenta este exonerada */
    select
      @w_tipo_exonerado_imp = ei_tipo_exonerado_imp
    from   cob_remesas..re_exoneracion_impuesto
    where  ei_producto = 'AHO'
       and ei_cuenta   = @i_cuenta
    if @@rowcount = 1
      select
        @w_tasa_imp = 0.0
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
    return 251013
  end

  if @t_trn = 252
      or @i_pago_servicio = 'S' --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIOS
    select
      @i_credit = 0

  select
    @i_efe = isnull (@i_efe,
                     0),
    @i_loc = isnull (@i_loc,
                     0),
    @i_prop = isnull (@i_prop,
                      0),
    @i_plaz = isnull (@i_plaz,
                      0)

  if @t_trn = 252
      or @i_pago_servicio = 'S' --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIOS
  begin
    if @i_factor = 1
    begin
      /* Calculo del monto del IDB */
      select
        @w_comision = 0
      if @w_tasa_imp > 0
        select
          @w_monto_imp = round((@w_comision * @w_tasa_imp),
                               @w_numdeci)
      else
        select
          @w_monto_imp = 0

      if @w_disponible >= 0
      begin
        if (@w_comision + @w_monto_imp) > (@w_disponible + @i_efe)
        begin
          /* VALOR DE LA COMISION EXCEDE AL DISPONIBLE */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 251051
          return 251051

        end
      end
    end
    else /********* @i_factor <> 1 *********/
    begin
      select
        @w_comision = tm_valor,
        @w_monto_imp = isnull(tm_monto_imp,
                              0)
      from   cob_ahorros..ah_tran_monet
      where  --tm_secuencial    = @t_ssn_corr
        tm_ssn_branch  = @t_ssn_corr
      and tm_cod_alterno = 10
      and tm_tipo_tran   = 264 /* ND por Comision */
      and tm_causa       = '15'
      and tm_cta_banco   = @w_cta_banco
      and tm_moneda      = @i_mon
      and tm_usuario     = @s_user
      and tm_estado is null

      if @@rowcount > 1
      begin
        /* NO EXISTE REGISTRO DE REVERSO */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251075
      end

      select
        @w_comision = isnull(@w_comision,
                             0),
        @w_monto_imp = isnull(@w_monto_imp,
                              0)

    end
  end
  else /****** @t_trn <> 252 *****/
    select
      @w_comision = 0,
      @w_monto_imp = 0

  if @w_codigo_pais = 'CO'
    select
      @w_tot = @i_efe + @i_prop + @i_loc + @i_credit -
               (@w_comision + @w_monto_imp)
  else
    select
      @w_tot = @i_efe + @i_prop + @i_loc + @i_plaz + @i_credit - (
                           @w_comision + @w_monto_imp)

  select
    @w_tot_alic = @w_tot * @w_alicuota

  select
    @w_dis_alic = (@i_efe + @i_credit) * @w_alicuota

  if ((@t_trn = 252
        or @i_pago_servicio = 'S')
      and @i_efe > $0)
      or ((@t_trn = 253
            or @t_trn = 2677)
          and @i_ind = 1)
  begin
    select
      @w_prom_disp = @w_prom_disp
                     + round(((@i_efe + @i_credit - (@w_comision + @w_monto_imp)
                     )
                     *
                            @w_alicuota * @i_factor), @w_numdeci)
  end

  if @i_factor = -1
     and ((@i_efe - (@w_comision + @w_monto_imp)) > @w_disponible
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
              and (@i_credit > @w_remesas))
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 161724
    return 161724
  end

  /*FRC-AHO-017-CobroComisiones CMU 2102110*/
  if @w_ciudad_cta = @w_ciudad_loc
    select
      @w_ncredmes = @w_ncredmes + (1 * @i_factor)

  begin tran

  if @i_ind = 1
    select
      @w_disponible = @w_disponible + (@i_credit * @i_factor)
  else if @i_ind = 2
  begin
    select
      @w_12h = @w_12h + (@i_credit * @i_factor)
    if @i_dif = 'S'
      select
        @w_12h_dif = @w_12h_dif + (@i_credit * @i_factor)
  end
  else if @i_ind = 3
  begin
    select
      @w_24h = @w_24h + (@i_credit * @i_factor)

  /****** Este parametro se alla con el llamado del sp_fecha_habil ********/
    /* Determinar el numero de dias de retencion para la ciudad */

    select
      @w_dias_ret = rl_dias
    from   cob_ahorros..ah_retencion_locales
    where  rl_agencia = @i_ofi
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
  /****** La validacion de la fecha se hace mediente el llamado al sp_fecha_abil  **********/
  /* Determinar la fecha de efectivizacion del deposito */
  /****PEDRO COELLO MODIFICA EL CALCULO DE DIAS DE HOLD ****/
  /*** La determinacion del siguiente dia laboral  se           ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO            ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif   = 'N',
      @i_efec_dia  = 'S',
      @i_fecha     = @w_fecha_efe,
      @i_oficina   = @i_ofi,
      @i_dif       = @i_dif,/**** Ingreso en  horario normal  ***/
      @w_dias_ret  = @w_dias_ret,/*** Dias siguientes habil ***/
      @o_ciudad    = @w_ciudad out,
      @o_fecha_sig = @w_fecha_efe out

    if @w_return <> 0
      return @w_return

    if not exists (select
                     1
                   from   cob_ahorros..ah_ciudad_deposito
                   where  cd_cuenta     = @i_cuenta
                      and cd_ciudad     = @w_ciudad
                      and cd_fecha_depo = @i_fecha
                      and cd_fecha_efe  = @w_fecha_efe)
    begin
      insert into cob_ahorros..ah_ciudad_deposito
                  (cd_cuenta,cd_ciudad,cd_fecha_depo,cd_fecha_efe,cd_valor,
                   cd_valor_efe)
      values      (@i_cuenta,@w_ciudad,@i_fecha,@w_fecha_efe,@i_credit,
                   @i_credit)

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
      set    cd_valor_efe = cd_valor_efe + (@i_credit * @i_factor),
             cd_valor = cd_valor + (@i_credit * @i_factor)
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
          @i_num   = 253002
        return 253002
      end
    end
  end
  else if @i_ind = 4
    select
      @w_remesas = @w_remesas + (@i_credit * @i_factor),
      @w_rem_hoy = @w_rem_hoy + (@i_credit * @i_factor)

  select
    @w_creditos = @w_creditos + ((@w_tot + (@w_comision + @w_monto_imp)) *
                                 @i_factor
                                       ),
    @w_creditos_hoy = @w_creditos_hoy + ((@w_tot + (@w_comision + @w_monto_imp))
                                         *
                                         @i_factor),
    @w_debitos = @w_debitos + ((@w_comision + @w_monto_imp) * @i_factor),
    @w_debitos_hoy = @w_debitos_hoy + ((@w_comision + @w_monto_imp) * @i_factor)

  /* Genera numero de control */
  if @i_ope <> 'CL'
  begin
    /* Inserta linea pendiente */

    if @t_trn = 252
        or @t_trn = 253
        or @t_trn = 229
        or @t_trn = 2677
        or @i_pago_servicio = 'S'
    --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIOS
    begin
      if @t_trn = 252
          or @t_trn = 2677
          or @i_pago_servicio = 'S'
        --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIOS
        select
          @w_linea = @w_linea + 1
      else
        select
          @w_linea = @w_linea + 1

      select
        @w_nemo = tn_nemonico
      from   cobis..cl_ttransaccion
      where  tn_trn_code = @t_trn

      select
        @w_nemo2 = tn_nemonico
      from   cobis..cl_ttransaccion
      where  tn_trn_code = 264

      if @i_factor = 1
      begin
        insert into cob_ahorros..ah_linea_pendiente
                    (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                     lp_control,lp_signo,lp_enviada)
        values      (@i_cuenta,@i_lpend,@w_nemo,@w_tot +
                     (@w_comision + @w_monto_imp),
                     @i_fecha,
                     @i_ncontrol,'C','N')

        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 253002
          return 253002
        end

        if (@t_trn = 252
             or @i_pago_servicio = 'S')
           and @w_comision > 0
        begin
          select
            @w_linea = @w_linea + 1

          insert into cob_ahorros..ah_linea_pendiente
                      (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                       lp_control,lp_signo,lp_enviada)
          values      (@i_cuenta,@i_lpend + 1,@w_nemo2,@w_comision,@i_fecha,
                       @i_ncontrol + 1,'D','N')

          if @@error <> 0
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 253002
            return 253002
          end

          if @w_monto_imp > 0
          begin
            select
              @w_linea = @w_linea + 1

            insert into cob_ahorros..ah_linea_pendiente
                        (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                         lp_control,lp_signo,lp_enviada)
            values      (@i_cuenta,@i_lpend + 2,'IDB',@w_monto_imp,@i_fecha,
                         @i_ncontrol + 2,'D','N')

            if @@error <> 0
            begin
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 253002
              return 253002
            end
          end
        end
      end
      else /***  @i_factor = -1  ***/
      begin
        insert into cob_ahorros..ah_linea_pendiente
                    (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                     lp_control,lp_signo,lp_enviada)
        values      (@i_cuenta,@i_lpend,'CORR',@w_tot + (@w_comision +
                                                         @w_monto_imp)
                     ,
                     @i_fecha,
                     @i_ncontrol,'D','N')

        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 253002
          return 253002
        end

        if (@t_trn = 252
             or @i_pago_servicio = 'S')
           and @w_comision > 0
        begin
          select
            @w_linea = @w_linea + 1

          insert into cob_ahorros..ah_linea_pendiente
                      (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                       lp_control,lp_signo,lp_enviada)
          values      (@i_cuenta,@i_lpend + 1,'CORR',@w_comision,@i_fecha,
                       @i_ncontrol + 1,'C','N')

          if @@error <> 0
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 253002
            return 253002
          end

          if @w_monto_imp > 0
          begin
            select
              @w_linea = @w_linea + 1

            insert into cob_ahorros..ah_linea_pendiente
                        (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                         lp_control,lp_signo,lp_enviada)
            values      (@i_cuenta,@i_lpend + 2,'CORR',@w_monto_imp,@i_fecha,
                         @i_ncontrol + 2,'C','N')

            if @@error <> 0
            begin
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 253002
              return 253002
            end
          end
        end
      end
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
      w_remesas = @w_remesas,
      i_factor = @i_factor,
      i_plaz = @i_plaz
    exec cobis..sp_end_debug
  end

  /* LBM -- verificar si se debe actualizar el campo con la causal */
  if @t_trn = 253
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
     and @w_saldo_contable + (@w_tot + (@w_comision + @w_monto_imp)) * @i_factor
         >
         @w_saldo_max
  --  @w_disponible    + ((@i_efe - (@w_comision + @w_monto_imp))* @i_factor) >  @w_saldo_max
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 252077
    /**** EL CREDITO ALA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO ***/
    return 1
  end

  if @w_corresponsal = 'S'
  begin
    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_cod_alterno,ts_tipo_transaccion,
                 ts_oficina,
                 ts_usuario,ts_terminal,ts_correccion,ts_ssn_corr,ts_reentry,
                 ts_origen,ts_nodo,ts_tsfecha,ts_cta_banco,ts_moneda,
                 ts_valor,ts_interes,ts_indicador,ts_causa,ts_prod_banc,
                 ts_categoria,ts_oficina_cta,ts_observacion,ts_tipocta_super,
                 ts_clase_clte,
                 ts_cliente,ts_hora)
    values      (@s_ssn,@s_ssn,1,751,@w_oficina,
                 @s_user,@s_term,'N',null,'N',
                 'L',@s_srv,@i_fecha,@w_cta_banco,0,
                 @i_credit,null,1,'52',@o_prod_banc,
                 @o_categoria,@w_oficina,('AUMENTO CUPO CB POSICIONADO ' + cast(
                                          @w_oficina as varchar)),@w_tipo_ente,
                 @o_clase_clte,
                 @w_cliente,getdate())

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253003
      return 1
    end

  end

  update cob_ahorros..ah_cuenta
  set    ah_disponible = @w_disponible + ((@i_efe - (@w_comision + @w_monto_imp)
                                          ) *
                                                 @i_factor),
         ah_promedio1 = @w_promedio1 + @i_factor * round(@w_dis_alic,
                                                         @w_numdeci),
         ah_prom_disponible = @w_prom_disp,
         ah_12h = @w_12h + @i_prop * @i_factor,
         ah_12h_dif = @w_12h_dif,
         ah_24h = @w_24h + @i_loc * @i_factor,
         ah_linea = @w_linea,
         ah_creditos = @w_creditos,
         ah_creditos_hoy = @w_creditos_hoy,
         ah_debitos = @w_debitos,
         ah_debitos_hoy = @w_debitos_hoy,
         ah_rem_hoy = @w_rem_hoy + (@i_factor * @i_plaz),
         ah_remesas = @w_remesas + (@i_factor * @i_plaz),
         ah_fecha_ult_mov = @w_fecha_ult_mov,--@i_fecha,
         ah_contador_trx = ah_contador_trx + @i_factor,
         ah_monto_imp = ah_monto_imp + @w_monto_imp * @i_factor,
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
    return 255001
  end

  if @w_codigo_pais = 'CO' -- Colombia
  begin
    -- ND Comision Transaccion Nacional e IVA 
    if @i_factor = -1
    begin
      -- Reverso Comision e IVA
      select
        @w_comision_trn = 0

      select
        @w_comision_trn = fv_costo
      from   cob_ahorros..ah_fecha_valor
      where  fv_transaccion = @w_trn
         and fv_referencia  = convert(varchar(24), @t_ssn_corr)
         and fv_rubro       = '1'

    end
    select
      @w_realizar_deb = 1
    if @i_factor = 1
    begin
      if @w_realizar_deb = 1
      begin
        select
          @w_comision_trn = @i_comision
        select
          @w_trn = 264
        if isnull(@w_comision_trn,
                  0) > 0
        begin
          exec @w_return = cob_ahorros..sp_ahndc_automatica
            @s_srv        = @s_srv,
            @s_ofi        = @s_ofi,
            @s_ssn        = @s_ssn,
            @s_ssn_branch = @s_ssn_branch,
            @s_user       = @s_user,
            @t_trn        = @w_trn,
            @t_corr       = @t_corr,
            @t_ssn_corr   = @t_ssn_corr,
            @i_cta        = @w_cta_banco,
            @i_val        = @w_comision_trn,
            @i_cau        = @i_causal,
            -- POR COMISION TRANSACCION NACIONAL o COMISION DE TRANSACCION
            @i_mon        = @i_mon,
            @i_alt        = 2,
            @i_fecha      = @i_fecha,
            @i_cobiva     = 'S',
            @i_canal      = 4,
            @o_valiva     = @w_valiva out,
            @o_val_2x1000 = @w_gmf out
          if @w_return <> 0
            return @w_return

          select
            @w_total_gmf = @w_total_gmf + @w_gmf

          /* Inserto en ah_fecha_valor el valor de la comision CPA */
          insert into cob_ahorros..ah_fecha_valor
                      (fv_transaccion,fv_cuenta,fv_referencia,fv_rubro,fv_costo)
          values      (@w_trn,@i_cuenta,convert(varchar(24), @s_ssn_branch),'1',
                       @w_comision_trn)
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
            values      (@w_trn,@i_cuenta,convert(varchar(24), @s_ssn_branch),
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

        select
          @o_comision = isnull(@o_comision, 0) + isnull(@w_comision_trn, 0),
          @o_valiva = isnull(@o_valiva, 0) + isnull(@w_valiva, 0)
      end
    end
    else
    begin
      -- Reversos
      if isnull(@w_comision_trn,
                0) > 0
      begin
        exec @w_return = cob_ahorros..sp_ahndc_automatica
          @s_srv        = @s_srv,
          @s_ofi        = @s_ofi,
          @s_ssn        = @s_ssn,
          @s_ssn_branch = @s_ssn_branch,
          @s_user       = @s_user,
          @t_corr       = @t_corr,
          @t_ssn_corr   = @t_ssn_corr,
          @t_trn        = @w_trn,
          @i_cta        = @w_cta_banco,
          @i_val        = @w_comision_trn,
          @i_cau        = @i_causal,
          @i_mon        = @i_mon,
          @i_alt        = 2,
          @i_fecha      = @i_fecha,
          @i_canal      = 4,
          @o_valiva     = @w_valiva out,
          @o_val_2x1000 = @w_gmf out

        if @w_return <> 0
          return @w_return
      end

      if exists (select
                   1
                 from   cob_ahorros..ah_tran_servicio
                 where  ts_tsfecha          = @i_fecha
                        --Fecha de la transaccion (Solo del dia)
                        and ts_tipo_transaccion = 751 --Tx AUMENTO Cupo
                        and ts_causa            = 52 --Causal AUMENTO Cupo
                        and ts_secuencial       = @t_ssn_corr
                        and ts_valor            = @i_credit)
      begin
        update cob_ahorros..ah_tran_servicio
        set    ts_estado = 'R'
        where  ts_tsfecha          = @i_fecha
               --Fecha de la transaccion (Solo del dia)
               and ts_tipo_transaccion = 751 --Tx AUMENTO Cupo
               and ts_causa            = 52 --Causal AUMENTO Cupo
               and ts_secuencial       = @t_ssn_corr
               and ts_valor            = @i_credit

        --Se genera transacci¾n de servicio para aumento de cupo 
        insert into cob_ahorros..ah_tran_servicio
                    (ts_secuencial,ts_ssn_branch,ts_cod_alterno,
                     ts_tipo_transaccion,
                     ts_oficina,
                     ts_usuario,ts_terminal,ts_correccion,ts_ssn_corr,ts_reentry
                     ,
                     ts_origen,ts_nodo,ts_tsfecha,
                     ts_cta_banco,ts_moneda,
                     ts_valor,ts_interes,ts_indicador,ts_causa,ts_prod_banc,
                     ts_categoria,ts_oficina_cta,ts_observacion,ts_tipocta_super
                     ,
                     ts_clase_clte,
                     ts_cliente,ts_hora,ts_estado)
        values      (@s_ssn,@s_ssn,1,751,@s_ofi,
                     @s_user,@s_term,'S',@t_ssn_corr,'N',
                     'L',@s_srv,@i_fecha,@w_cta_banco,0,
                     @i_credit,null,1,'52',@o_prod_banc,
                     @o_categoria,@w_oficina,('CORR: ' + cast(@t_ssn_corr as
                                              varchar
                                              )
                                              +
                                              ' AUMENTO CUPO CB POSICIONADO '
                      + cast(@w_oficina as varchar)),@w_tipo_ente,@o_clase_clte,
                     @w_cliente,getdate(),'R')

      end
      else
      begin
        select
          @w_return = @@error

        if @w_return <> 0
        begin
          if @@error <> 0
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 253003
            return 1
          end
        end
      end

      select
        @o_comision = isnull(@w_comision_trn,
                             0),
        @o_valiva = isnull(@o_valiva, 0) + isnull(@w_valiva, 0),
        @w_total_gmf = isnull(@w_total_gmf, 0) + isnull(@w_gmf, 0)

      -- Actualiza movimiento Original
      update cob_ahorros..ah_tran_monet
      set    tm_estado = 'R'
      where  tm_oficina    = @s_ofi
         and tm_ssn_branch = @t_ssn_corr
         and tm_cta_banco  = @w_cta_banco
         and tm_tipo_tran  = @w_trn
         and tm_estado     = null

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
      where  fv_transaccion = @w_trn
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
    end

    if @i_factor = -1
    begin
      -- Actualiza movimiento Original
      update cob_ahorros..ah_tran_monet
      set    tm_estado = 'R'
      where  tm_oficina     = @s_ofi
         and tm_ssn_branch  = @t_ssn_corr
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

      -- Actualiza movimiento Reverso
      update cob_ahorros..ah_tran_monet
      set    tm_estado = 'R',
             tm_correccion = 'S',
             tm_sec_correccion = @t_ssn_corr
      where  tm_oficina     = @s_ofi
         and tm_ssn_branch  = @s_ssn_branch
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

    end
  end

  /* Regitrar los depositos por ciudad de cheques locales */

  if @i_loc > 0
     and (@t_trn = 252
           or @i_pago_servicio = 'S')
  --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIOS
  begin
  /* Esto se tiene con la llamada al sp_fecha_habil  *****/
  /* Determinar el codigo de la ciudad del deposito */
    --         select @w_ciudad = of_ciudad
    --            from cobis..cl_oficina
    --            where of_oficina = @s_ofi

    /* Determinar el numero de dias de retencion para la ciudad */

    select
      @w_dias_ret = rl_dias
    from   cob_ahorros..ah_retencion_locales
    where  rl_agencia = @i_ofi
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

  /**** La validaicon de la fecha habil siguiente se realiza con el sp_fecha_habil   *********/
  /* Determinar la fecha de efectivizacion del deposito */
  /****PEDRO COELLO MODIFICA EL CALCULO DE DIAS DE HOLD ****/
    --            if @i_dif = 'S'
    --              select @w_fecha_efe = dateadd(dd,(2),@i_fecha),
    --                     @w_cont = 1
    --           else
    --              select @w_fecha_efe = dateadd(dd,1,@i_fecha),
    --                     @w_cont = 1

    --            while @w_cont <= @w_dias_ret
    --                if exists (select 1
    --                             from cobis..cl_dias_feriados
    --                          where df_ciudad = @w_ciudad
    --                              and df_fecha  = @w_fecha_efe)
    --                  select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --                else 
    --                begin
    --                      select @w_cont = @w_cont + 1
    --                if @w_cont <= @w_dias_ret
    --                         select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
    --                end 

  /*** La determinacion del siguiente dia laboral  se             ****/
    /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
    exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif   = 'N',
      @i_efec_dia  = 'S',
      @i_fecha     = @i_fecha,
      @i_oficina   = @i_ofi,
      @i_dif       = @i_dif,/**** Ingreso en  horario normal  ***/
      @w_dias_ret  = @w_dias_ret,/*** Dias siguientes habil ***/
      @o_ciudad    = @w_ciudad out,
      @o_fecha_sig = @w_fecha_efe out

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
      set    cd_valor_efe = cd_valor_efe + (@i_loc * @i_factor),
             cd_valor = cd_valor + (@i_loc * @i_factor)
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

  if (@t_trn = 252
       or @i_pago_servicio = 'S')
     and @w_comision > 0
  begin
    if @i_factor = 1
    begin
      /*  Transaccion monetaria */
      insert into cob_ahorros..ah_notcredeb
                  (secuencial,tipo_tran,oficina,filial,usuario,
                   terminal,correccion,reentry,origen,fecha,
                   cta_banco,nodo,valor,moneda,causa,
                   signo,alterno,saldocont,saldodisp,oficina_cta,
                   prod_banc,categoria,monto_imp,tipo_exonerado,ssn_branch,
                   tipocta_super,turno,hora,canal,cliente,
                   clase_clte)
      values      (@s_ssn,264,@i_ofi,@i_filial,@s_user,
                   @s_term,'N','N','L',@i_fecha,
                   @w_cta_banco,@s_srv,@w_comision,@i_mon,'15',
                   'D',10,(@w_saldo_contable + @w_tot),(
                   @w_disponible + @i_efe - (@w_comision + @w_monto_imp)),
                   @w_oficina
                   ,
                   @o_prod_banc,@o_categoria,@w_monto_imp,
                   @w_tipo_exonerado_imp,
                   @s_ssn_branch,
                   @o_tipocta_super,@i_turno,getdate(),@i_canal,@w_cliente,
                   @o_clase_clte )

      if @@error <> 0
      begin
        /* ERROR EN INSERCION DE TRANSACCION MONETARIA */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253000
        return 1
      end

      /* INSERTAR EL REGISTRO DE REGULARIZACION */
      insert into cob_ahorros..ah_fecha_valor
                  (fv_transaccion,fv_cuenta,fv_referencia,fv_rubro,fv_costo)
      values      (@t_trn,@w_cuenta,convert (varchar(24), @s_ssn),'3',
                   @w_comision)

      if @@error <> 0
      begin
        /* ERROR EN INSERCION DE REGISTRO DE REGULARIZACION */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253012
        return 1
      end

    end
    else /***** @i_factor <> 1 *****/
    begin
      /*  Transaccion monetaria */
      insert into cob_ahorros..ah_notcredeb
                  (secuencial,tipo_tran,oficina,filial,usuario,
                   terminal,correccion,sec_correccion,reentry,origen,
                   fecha,cta_banco,nodo,valor,moneda,
                   causa,signo,alterno,saldocont,saldodisp,
                   oficina_cta,estado,prod_banc,categoria,monto_imp,
                   tipo_exonerado,ssn_branch,tipocta_super,turno,hora,
                   canal,cliente,clase_clte)
      values      (@s_ssn,264,@i_ofi,@i_filial,@s_user,
                   @s_term,'S',@t_ssn_corr,'N','L',
                   @i_fecha,@w_cta_banco,@s_srv,@w_comision,@i_mon,
                   '15','C',10,(@w_saldo_contable - @w_tot),(
                   @w_disponible - @i_efe + (@w_comision + @w_monto_imp)),
                   @w_oficina,'R',@o_prod_banc,@o_categoria,@w_monto_imp,
                   @w_tipo_exonerado_imp,@s_ssn_branch,@o_tipocta_super,@i_turno
                   ,
                   getdate(),
                   @i_canal,@w_cliente,@o_clase_clte )

      if @@error <> 0
      begin
        /* ERROR EN INSERCION DE TRANSACCION MONETARIA */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253000
        return 1
      end

      /* ACTUALIZAR LA TRANSACCION MONET. ORIGINAL */
      update cob_ahorros..ah_tran_monet
      set    tm_estado = 'R'
      where  tm_ssn_branch  = @t_ssn_corr
             --     tm_secuencial = @t_ssn_corr
             and tm_cta_banco   = @w_cta_banco
             and tm_cod_alterno = 10
             and tm_valor       = @w_comision
             and tm_causa       = '15'
             and tm_moneda      = @i_mon
             and tm_estado is null

      if @@rowcount <> 1
      begin
        /* DATOS DEL REVERSO NO COINCIDEN CON EL ORIGINAL */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 1
      end

      /* ELIMINAR EL REGISTRO DE REGULARIZACION */
      delete cob_ahorros..ah_fecha_valor
      where  fv_transaccion = @t_trn
         and fv_cuenta      = @w_cuenta
         and fv_referencia  = convert (varchar(24), @t_ssn_corr)
         and fv_rubro       = '3'

      if @@error <> 0
      begin
        /* ERROR EN ELIMINACION REGISTRO DE REGULARIZACION */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 257003
        return 1
      end
    end
  end

  /* Si es una NC y la causal genera cobro de GMF a cargo Bancamia se realiza el cobro correspondiente*/
  if @t_trn = 253
  begin
    if exists (select
                 1
               from   cobis..cl_tabla t,
                      cobis..cl_catalogo c
               where  t.tabla  = 'ah_cau_nc_gmf_ba'
                  and c.tabla  = t.codigo
                  and c.codigo = @i_cau
                  and c.estado = 'V')
    begin
      exec @w_return = sp_ah_genera_gmf_bco
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,
        @s_user          = @s_user,
        @s_term          = @s_term,
        @s_ofi           = @s_ofi,
        @t_trn           = @t_trn,
        @t_corr          = @t_corr,
        @t_ssn_corr      = @t_ssn_corr,
        @i_cta_banco     = @w_cta_banco,
        @i_fecha         = @i_fecha,
        @i_prod_banc     = @o_prod_banc,
        @i_categoria     = @o_categoria,
        @i_tipocta_super = @o_tipocta_super,
        @i_valor         = @i_credit,
        @i_moneda        = @w_moneda,
        @i_clase_clte    = @o_clase_clte,
        @i_causal        = @i_cau,
        @i_cliente       = @w_cliente,
        @i_oficina       = @w_oficina

      if @w_return <> 0
      begin
        if @t_debug = 'S'
        begin
          print 'ERROR GENERANDO REGISTRO GMF PARA BANCAMIA'
          print '@t_ssn_corr ' + cast(@t_ssn_corr as varchar)
          print '@w_cta_banco ' + @w_cta_banco + ' @i_cau ' + @i_cau +
                ' @i_mon '
                +
                cast
                (@i_mon
                                                                      as varchar
                )
          print '@i_credit ' + cast(@i_credit as varchar)
        end
        return @w_return
      end
    end
  end

  if @i_factor = 1
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
    @i_cta        = @w_cta_banco,
    @i_trn_accion = @t_trn

  if @w_return <> 0
    return @w_return

  commit tran

  select
    @o_sldcont = @w_saldo_contable + (@w_tot + (@w_comision + @w_monto_imp)) *
                                                          @i_factor,
    @w_disponible = @w_disponible + @i_efe * @i_factor,
    @o_slddisp = @w_disponible,
    @w_saldo_para_girar = @w_saldo_para_girar + (@i_efe + @i_credit) * @i_factor
    ,
    @o_cliente = @w_cliente

  if @t_ejec = 'R'
  begin
    exec @w_return = cob_ahorros..sp_resultados_branch_ah
      @s_ssn_host    = @s_ssn,
      @i_cuenta      = @i_cuenta,
      @i_fecha       = @s_date,
      @i_ofi         = @s_ofi,
      @i_tipo_cuenta = 'O',
      @i_comision    = @o_comision,
      @i_iva         = @w_valiva,
      @i_gmf         = @w_total_gmf,
      @i_cedula      = @o_cedula

    if @w_return <> 0
      return @w_return
  end
  /* Fin cambios BRANCHII */

  return 0

go

