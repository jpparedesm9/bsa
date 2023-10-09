use cob_ahorros
go

/************************************************************************/
/*  Archivo:            transfer_cre_ah.sp                              */
/*  Stored procedure:   sp_transfer_cre_ah                              */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto: Cuentas Corrientes                                        */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 22-Dic-1994                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones de debito por transfe       */
/*  rencias (automaticas) en Cuentas Ahorros.                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA        AUTOR             RAZON                                */
/*  22/Dic/1994  G Velasquez C.    Emision inicial                      */
/*  5/may/2005   M. Sanguino       Personalizacion Panama               */
/*  21/ene/2010  CMunoz            FRC-AHO-017CobroComisiones CMU2102110*/
/*  04/Feb/2010  J.Loyo            Validacion de Saldo Maximo para la   */
/*                                 cuenta                               */
/*  11/feb/2013  C.Hernandez       REQ 330 Validacion identidad cliente */
/*  12/Ago/2013  O.Saavedra        INC 113071 - Mejora Integridad trn   */
/*  1/Oct/2013   L.Moreno          CCA 353 - Alianzas Comerciales       */
/*  02/May/2016  Walther Toledo    Migración a CEN                      */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_transfer_cre_ah')
  drop proc sp_transfer_cre_ah
go

create proc sp_transfer_cre_ah
(
  @s_srv            varchar(30),
  @s_ofi            smallint,
  @s_ssn            int,
  @s_user           varchar(30),
  @s_sesn           int=null,
  @s_term           varchar(10),
  @s_date           datetime,
  @s_rol            smallint,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_org            char(1),
  @s_ssn_branch     int = null,
  @t_corr           char(1) = 'N',
  @t_ssn_corr       int = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(14) = null,
  @t_from           varchar(32) = null,
  @t_rty            char(1) = 'N',
  @t_trn            int,
  @t_show_version   bit = 0,
  @i_prodeb         tinyint,
  @i_ctadb          cuenta,
  @i_prodep         tinyint,
  @i_cta_dep        cuenta,
  @i_val            money,
  @i_tipo           char(2),
  @i_mon            tinyint,
  @i_sec            int,
  @i_ncontrol       int,
  @i_lpend          int,
  @i_referencia     varchar(40) = null,
  @i_verifica_blq   char(1) = 'S',
  @i_turno          smallint = null,

  --CCR BRANCH III
  @t_ejec           char(1) = 'N',
  @i_fecha_valor_a  datetime = null,
  @i_sld_caja       money = 0,
  @i_idcierre       int = 0,
  @i_filial         smallint = 1,
  @i_idcaja         int = 0,
  @i_atm_server     char(1) = 'N',
  @i_canal          smallint = 4,
  @i_is_batch       char(1) = 'N',
  @i_valida_hom     char(1) = 'S',--VALIDA HOMINI
  @o_salconcr       money out,
  @o_saldiscr       money out,
  @o_nomcr          varchar(30) out,
  @o_idecr          varchar(15) out,
  @o_prod_banc      smallint out,
  @o_categoria      char(1) out,
  @o_saldo_girar_cr money = null out,
  @o_12hcr          money = null out,
  @o_24hcr          money = null out,
  @o_remesascr      money = null out,
  @o_blq_cr         money = null out,
  @o_tipocta_super  char(1) = null out,
  @o_comision       money = null out,
  @o_causal         char(3) = null out
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
    @w_credmes          money,
    @w_credhoy          money,
    @w_estado           char(1),
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ncredmes         int,
    @w_tipocta          char(1),
    @w_clase_clte       char(1),
    @w_rol_ente         char(1),
    @w_cliente          int,
    @w_tipo_def         char(1),
    @w_cobro_comision   money,
    @w_valiva_tarifa    money,
    @w_producto         tinyint,
    @w_tipo             char(1),
    @w_codigo           int,
    @w_personaliza      char(1),
    @w_numdeb           int,
    @w_numcre           int,
    @w_numtot           int,
    @w_numero           int,
    @w_numco            int,
    @w_numtotcta        int,
    /** Validacion saldo Maximo ***/
    @w_saldo_max        money,
    @w_tipocobro        char(1),
    @w_posteo           char(1),
    @w_pro_final        smallint,
    @w_sucursal         smallint,
    @w_error            int,
    @w_sev              tinyint,
    @w_estado_cta       char(1),-- REQ 306 VALIDA DEPOSITO INICIAL
    -- ADI: REQ 217 AHORRO CONTRACTUAL
    @w_deposito_min     money,
    @w_modulo           char(3),
    @w_autoriza         char(1),
    @w_moneda           money,
    @w_oper_cont        char(1),
    @w_estado_id        int,--REQ 330
    @w_tipo_ced         char(2),--REQ 330
    @w_ced_ruc          numero,--REQ 330
    @w_o_sec            varchar(64),--REQ 330
    @w_omsg_error       varchar(254),--REQ 330
    @w_respuesta        tinyint,--REQ 330
    @w_msg_valida       varchar(64) --REQ 330

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_transfer_cre_ah',
    @w_fecha = @s_date,
    @i_canal = 4

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  --print @w_sp_name
  if @i_turno is null
    select
      @i_turno = @s_rol

  select
    @w_mensaje = null

  /* Encuentra los decimales a utilizar */
  select
    @w_fldeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_fldeci = 'S'
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DCI'
  else
    select
      @w_numdeci = 0

  /* Determina factor para hacer credito o debito */
  if @t_corr = 'N'
  begin
    select
      @w_factor = 1,
      @w_signo = 'C',
      @w_estado = null
  end
  else
  begin
    select
      @w_factor = -1,
      @w_signo = 'D',
      @w_estado = 'R'
  end

  select
    @w_clave = 2

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
    @i_cta_banco = @i_cta_dep,
    @i_moneda    = @i_mon,
    @i_is_batch  = @i_is_batch,
    @o_cuenta    = @w_cuenta out,
    @o_filial    = @w_filial out,
    @o_oficina   = @w_oficina out,
    @o_tpromedio = @w_promedio out
  if @w_return <> 0
    return @w_return

  if @i_verifica_blq = 'S'
  begin
    /*  Determinacion de bloqueo de cuenta  */
    select
      @w_tipo_bloqueo = cb_tipo_bloqueo
    from   cob_ahorros..ah_ctabloqueada
    where  cb_cuenta       = @w_cuenta
       and cb_estado       = 'V'
       and (cb_tipo_bloqueo = '1'
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

  /* Calcular el saldo */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @w_fecha,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out,
    @o_saldo_max        = @w_saldo_max out
  /* Recibimos  el saldo Maximo para la cuenta */
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
    @w_credmes = ah_creditos,
    @w_credhoy = ah_creditos_hoy,
    @o_nomcr = substring(ah_nombre,
                         1,
                         30),
    @o_idecr = ah_ced_ruc,
    @w_cliente = ah_cliente,
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @o_12hcr = ah_12h,
    @o_24hcr = ah_24h,
    @o_remesascr = ah_remesas,
    @o_blq_cr = ah_monto_bloq,
    @o_tipocta_super = ah_tipocta_super,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ncredmes = isnull(ah_num_cred_mes,
                         0),
    @w_tipocta = ah_tipocta,
    @w_clase_clte = ah_clase_clte,
    @w_rol_ente = ah_rol_ente,
    @w_producto = ah_producto,
    @w_tipo_def = ah_tipo_def,
    @w_tipo = ah_tipo,
    @w_codigo = ah_default,
    @w_personaliza = ah_personalizada,
    @w_estado_cta = ah_estado,
    @w_moneda = ah_moneda
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @w_cuenta
     and ah_moneda = @i_mon
  if @@rowcount = 0
  begin
    select
      @w_error = 251001,
      @w_sev = 0
    goto ERROR
  end

  /* REQ 306 VALIDA DEPOSITO INICIAL - CUENTA ACREDITADA */

  if @w_estado_cta = 'N'
  begin
    if @i_is_batch = 'N'
    begin
      exec cobis..sp_cerror -- 251096 Tiempo para primer deposito concluido
        @t_from = @w_sp_name,
        @i_num  = 251096,
        @i_sev  = 0
    end

    return 251096
  end

  --REQ 330 VALIDACION IDENTIFICACION CLIENTE
  if exists (select
               1
             from   cobis..cl_val_iden
             where  vi_transaccion = @t_trn
                and vi_estado      = 'V')
     and @t_corr <> 'S'
     and @i_valida_hom = 'S'
  begin
    select
      @w_tipo_ced = en_tipo_ced,
      @w_ced_ruc = en_ced_ruc
    from   cobis..cl_ente
    where  en_ente = @w_cliente

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
      @i_ref         = @i_cta_dep,
      @i_user        = @s_user,
      @i_trn         = @t_trn,
      @i_id_caja     = @i_idcaja,
      @i_sec_cobis   = @s_ssn

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

    -----------------------------------------------
    --invocar al servicio de validacion de huella
    -----------------------------------------------
    exec @w_return = cobis..sp_consulta_homini
      @s_term      = @s_term,
      @s_ofi       = @s_ofi,
      @i_operacion = 'V',
      @i_ref       = @i_cta_dep,
      @i_user      = @s_user,
      @i_id_caja   = @i_idcaja,
      @i_sec_cobis = @s_ssn,
      @i_trn       = @t_trn,
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

  if @w_estado_cta = 'G'
  begin
    exec @w_return = cob_remesas..sp_genera_costos
      @i_categoria   = @o_categoria,
      @i_tipo_ente   = @w_tipocta,
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
      if @i_is_batch = 'N'
      begin
        exec cobis..sp_cerror -- 251097 Monto deposito inicial no existe
          @t_from = @w_sp_name,
          @i_num  = 251097,
          @i_sev  = 0
      end

      return 251097
    end

    if @i_val < @w_deposito_min
    begin
      if @i_is_batch = 'N'
      begin
        exec cobis..sp_cerror
          -- 251098 Monto depositado inferior al monto minimo establecido
          @t_from = @w_sp_name,
          @i_num  = 251098,
          @i_sev  = 0
      end
      return 251098
    end
  end

  /* REQ 217 AHORRO CONTRACTUAL CREDITO */
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
     and me_tipo_ente    = @w_tipocta
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
    if @i_is_batch = 'N'
    begin
      exec cobis..sp_cerror -- Transaccion no autorizada para esta cuenta
        @t_from = @w_sp_name,
        @i_num  = 351575,
        @i_sev  = 0
    end
    return 1
  end

/* ADI: FIN - REQ 217 AHORRO CONTRACTUAL */
  /* REQ 306 DEPOSITO INICIAL APERTURA AHO */

  exec @w_return = cob_ahorros..sp_ah_trn_depo_inicial
    @t_file       = @t_file,
    @t_debug      = @t_debug,
    @t_trn        = @t_trn,
    @i_correccion = @t_corr,
    @i_ssn_branch = @s_ssn_branch,--SECUENCIAL BRANCH
    @i_ssn_corr   = @t_ssn_corr,--SECUENCIAL TRN REVERSADA
    @i_cta_banco  = @i_cta_dep,
    @i_causal     = '0',
    @i_moneda     = 0,
    @i_estado     = @w_estado_cta,
    @i_oficina    = @w_oficina

  if @w_return <> 0
  begin
    if @i_is_batch = 'N'
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251101 /**** ERROR EN VALIDACION DEPOSITO INICIAL ***/
    end
    return 251101
  end
/* FIN - REQ 306 DEPOSITO INICIAL APERTURA AHO */
  /* Encuentra alicuota del promedio */
  select
    @w_alicuota = fp_alicuota
  from   cob_ahorros..ah_fecha_promedio
  where  fp_tipo_promedio = @w_promedio
     and fp_fecha_inicio  = @w_fecha
  if @@rowcount = 0
  begin
    select
      @w_error = 251013,
      @w_sev = 0
    goto ERROR
  end

  if @w_factor = -1
     and (@i_val > @w_disponible)
  begin
    select
      @w_error = 201115,
      @w_sev = 0
    goto ERROR
  end
  -- CCA 554 SE COMENTA PORQUE NO DEBE HABER COBRO DE COMISIONES A LA CUENTA QUE SE ACREDITA EN LA TRANSFERENCIA
  --      exec cob_remesas..sp_tipo_comision
  --          @s_date       = @s_date,
  --          @t_debug      = 'N',
  --          @s_ofi        = @s_ofi,
  --          @i_cta        = @i_cta_dep,
  --          @i_mon        = @w_moneda,
  --          @i_filial     = 1,
  --          @i_trn_accion = @t_trn,
  --          @t_corr       = @t_corr,
  --          @o_comision   = @o_comision out,
  --          @o_causal     = @o_causal out

  if @w_factor = 1
  begin
    select
      @w_cobro_comision = 0
  --@o_comision   CCA 554 SE COMENTA PORQUE NO DEBE HABER COBRO DE COMISIONES A LA CUENTA QUE SE ACREDITA EN LA TRANSFERENCIA
  end
  else
  begin
    select
      @w_cobro_comision = tm_valor
    from   ah_tran_monet
    where  tm_oficina     = @s_ofi
       and tm_ssn_branch  = @t_ssn_corr
       and tm_cta_banco   = @i_cta_dep
       and tm_tipo_tran   = 264
       and tm_cod_alterno = 6
       and tm_estado is null
  end

  /*FRC-AHO-017-CobroComisiones CMU 2102110*/
  select
    @w_ncredmes = @w_ncredmes + (1 * @w_factor)

  if @i_is_batch = 'N'
    begin tran

  /* Actualizacion de tabla de cuentas de Ahorros */
  select
    @w_alic = convert (money, round((@i_val * @w_alicuota),
                                    @w_numdeci))
  select
    @w_promedio1 = @w_promedio1 + @w_alic * @w_factor
  select
    @w_promdisp = @w_promdisp + @w_alic * @w_factor
  select
    @w_disponible = @w_disponible + @i_val * @w_factor
  select
    @w_saldo_contable = @w_saldo_contable + @i_val * @w_factor
  select
    @o_salconcr = @w_saldo_contable,
    @o_saldiscr = @w_disponible
  select
    @w_credmes = @w_credmes + @i_val * @w_factor,
    @w_credhoy = @w_credhoy + @i_val * @w_factor
  select
    @o_saldo_girar_cr = @w_saldo_para_girar + @i_val * @w_factor

  /*** Validamos el saldo maximo de la cuenta JLOYO *****/
  if @w_saldo_max > 0
     and @w_saldo_contable > 99999999999--@w_saldo_max
  begin
    select
      @w_error = 252077,
      @w_sev = 0
    goto ERROR
  /**** EL CREDITO ALA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO ***/
  end

  select
    @w_sucursal = isnull(of_regional,
                         of_oficina)
  from   cobis..cl_oficina
  where  of_oficina = @w_oficina

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
     and pf_moneda       = @i_mon
     and pf_tipo         = @w_tipo

  if @@rowcount = 0
  begin
    --No existe producto final
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

  if @w_posteo = 'S'
  begin
    select
      @w_control = @i_ncontrol,
      @w_linpen = @i_lpend

    /* Inserta en Linea Pendiente */
    select
      @w_lineas = @w_lineas + 1

    /* Inserta en Linea Pendiente */
    insert into cob_ahorros..ah_linea_pendiente
                (lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
                 lp_control,lp_signo,lp_enviada)
    values      (@w_cuenta,@w_linpen,@w_nemo,@i_val,@w_fecha,
                 @w_control,@w_signo,'N')

    if @@error <> 0
    begin
      select
        @w_error = 251033,
        @w_sev = 0
      goto ERROR
    end
  end

  update cob_ahorros..ah_cuenta
  set    ah_disponible = @w_disponible,
         ah_promedio1 = @w_promedio1,
         ah_prom_disponible = @w_promdisp,
         ah_fecha_ult_mov = @w_fecha,
         ah_fecha_ult_upd = @w_fecha,
         ah_linea = @w_lineas,
         ah_contador_trx = ah_contador_trx + @w_factor,
         ah_creditos = @w_credmes,
         ah_creditos_hoy = @w_credhoy,
         /*FRC-AHO-017-CobroComisiones CMU 2102110*/
         ah_num_cred_mes = @w_ncredmes
  where  ah_cuenta = @w_cuenta
  if @@rowcount <> 1
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
       and ctaorigen  = @i_cta_dep
       and ctadestino = @i_ctadb
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
               categoria,referencia,tipocta_super,turno,hora,
               canal,estado,cliente,clase_clte)
  values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
               @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
               @s_srv,@w_fecha,@i_cta_dep,@i_ctadb,@i_val,
               @i_tipo,@s_ssn_branch,@i_mon,@w_signo,@w_saldo_contable,
               @w_disponible,@i_sec,@w_oficina,@w_filial,@o_prod_banc,
               @o_categoria,@i_referencia,@o_tipocta_super,@i_turno,getdate(),
               @i_canal,@w_estado,@w_cliente,@w_clase_clte)
  if @@error <> 0
  begin
    select
      @w_error = 253000,
      @w_sev = 1
    goto ERROR
  end
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
      @i_is_batch   = @i_is_batch,
      @i_cta        = @i_cta_dep,
      @i_val        = @w_cobro_comision,
      @i_cau        = @o_causal,-- causa cobro comision ret ventanilla
      @i_mon        = @i_mon,
      @i_alt        = 6,
      @i_fecha      = @w_fecha,
      @i_cobiva     = 'S',
      @i_canal      = @i_canal,
      @o_valiva     = @w_valiva_tarifa out

    if @w_return <> 0
    begin
      select
        @w_error = @w_return,
        @w_sev = 1
      goto ERROR
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
    @i_cta        = @i_cta_dep,
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
      @i_sev   = @w_sev

    if @w_sev = 1
      rollback tran
  end
  return @w_error

go

