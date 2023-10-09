/************************************************************************/
/*    Archivo:              ahcietpl.sp                                 */
/*    Stored procedure:     sp_cierre_tarj_planilla                     */
/*    Base de datos:        cob_ahorros                                 */
/*    Producto:             Cuentas de Ahorros                          */
/*    Disenado por:         Juan F. Cadena                              */
/*    Fecha de escritura:   4-May-2005                                  */
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
/*    Cierre de cuentas de tarjetas de planilla cuando su saldo         */
/*    es 0 (cero)                                                       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    04/May/2005    Juan F. Cadena    Emision inicial                  */
/*    02/May/2016    J. Calderon       Migración a CEN                  */
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
           where  name = 'sp_cierre_tarj_planilla')
  drop proc sp_cierre_tarj_planilla
go
create proc sp_cierre_tarj_planilla
(
  @s_srv          varchar(30),
  @s_user         varchar(30) = 'batch',
  @s_term         varchar(10) = 'consola',
  @t_show_version bit = 0,
  @i_fecha        datetime,
  @i_cuenta       cuenta,
  @i_canal        smallint = 4,
  @o_saldo        money out
)
as
  declare
    @w_return              int,
    @w_sp_name             varchar(30),
    @w_cuenta              int,
    @w_est                 char(1),
    @w_filial              tinyint,
    @w_linea               smallint,
    @w_num_bloqueos        smallint,
    @w_tipo_prom           char(1),
    @w_alicuota            float,
    @w_tot_alic            float,
    @w_numdeci             tinyint,
    @w_secuencial          int,
    @w_saldo_libreta       money,
    @w_saldo_contable      money,
    @w_saldo_para_girar    money,
    @w_usadeci             char(1),
    @w_personalizada       char(1),
    @w_rol_ente            char(1),
    @w_tipo_def            char(1),
    @w_prod_banc           smallint,
    @w_producto            tinyint,
    @w_moneda              tinyint,
    @w_tipo                char(1),
    @w_aut                 descripcion,
    @w_numrg               int,
    @w_default             int,
    @w_categoria           char(1),
    @w_valor_impuesto      money,
    @w_promedio1           money,
    @w_sldint              money,
    @w_tipo_ente           char(1),
    @w_fec_aper            datetime,
    @w_dias                smallint,
    @w_dia                 tinyint,
    @w_dias_mes            tinyint,
    @w_ofi_cta             smallint,
    @w_diferencia_fechas   smallint,
    @w_rubro               varchar(5),
    @w_retencion           char(1),
    @w_tasa_interes        float,
    @w_mes                 varchar(2),
    @w_anio                varchar(4),
    @w_primer              varchar(10),
    @w_primer_fecha        datetime,
    @w_dias_anio           smallint,
    @w_tipo_bloqueo        char(3),
    @w_monto_bloq          money,
    @w_mensaje             mensaje,
    @w_monto_imp           money,
    @w_monto_imp_multa     money,
    @w_monto_imp_retiro    money,
    @w_monto_imp_retencion money,
    @w_tasa_imp            float,
    @w_prom_disponible     money,
    @w_monto_max_dev       float,
    @w_unidad_trib         money,
    @w_monto_max_idb       money,
    @w_monto_imp_total     money,
    @w_tipo_atributo       char(1),
    @w_int_mes             money,
    @w_dias_mes_act_tipoDE tinyint,
    @w_ult_dia_mes         datetime,
    @w_mes_sig             datetime,
    @w_mes_sigc            varchar(10),
    @w_dia_pri             varchar(10),
    @w_servicio_per        int,
    @w_monto               money,
    @w_sldmantval          money,
    @w_msg                 descripcion,
    @w_monto_emb           money,
    @w_nombre              descripcion,
    @w_cliente             int,
    @w_idlote              int,
    @w_trn                 int,
    @w_cau                 char(3),
    @w_sp                  char(40),
    @w_cod_prdnav          smallint,
    @w_cuota               money,
    @w_multa               money,
    @w_num_cuopre          tinyint,
    @w_val22               money,
    @w_ssn                 int,
    @w_disponible2         money,
    @w_mencta              varchar(60),
    @w_comision_imp_renta  float,
    @w_impuesto            char(1),
    @w_promedio            money,
    @w_resultado           int,
    @w_ah_monto_emb        money,
    @w_prod_tpl            smallint,
    @w_tipocta_super       char(1),
    @w_slddisp             money

  -- Captura del nombre del Stored Procedure
  select
    @w_sp_name = 'sp_cierre_tarj_planilla'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_tasa_imp = 0,
    @w_monto_imp = 0,
    @w_monto_imp_retencion = 0,
    @w_monto_imp_multa = 0,
    @w_monto_imp_retiro = 0

  select
    @w_monto_max_idb = 0 -- lgr

  -- Calculo del SSN
  begin tran

  -- Encuentra el SSN inicial
  select
    @w_ssn = se_numero + 1
  from   cobis..ba_secuencial
  if @@rowcount <> 1
  begin
    -- Error en lectura de SSN
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 2
  if @@rowcount <> 1
  begin
    -- Error en actualizacion de SSN
    return 205031
  end

  commit tran

  -- Encuentra dias del anio para provision diaria interes
  select
    @w_dias_anio = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'DIA'

  if @@rowcount <> 1
  begin
    /* Error: no se ha definido ciudad de feriados nacionales */
    return 205031
  end

  select
    @w_cuenta = ah_cuenta,
    @w_est = ah_estado,
    @w_linea = ah_linea,
    @w_saldo_libreta = ah_saldo_libreta,
    @w_prod_banc = ah_prod_banc,
    @w_categoria = ah_categoria,
    @w_monto_bloq = ah_monto_bloq,
    @w_tipo_ente = ah_tipocta,
    @w_sldmantval = ah_saldo_mantval,
    @w_monto_emb = ah_monto_emb,
    @w_nombre = ah_nombre,
    @w_cliente = ah_cliente,
    @w_ah_monto_emb = ah_monto_emb,
    @w_tipocta_super = ah_tipocta_super,
    @w_sldint = isnull(ah_saldo_interes,
                       0),
    @w_tipo_prom = ah_tipo_promedio,
    @w_slddisp = ah_disponible,
    @w_promedio1 = ah_promedio1,
    @w_rol_ente = ah_rol_ente,
    @w_tipo_def = ah_tipo_def,
    @w_default = ah_default,
    @w_personalizada = ah_personalizada,
    @w_producto = ah_producto,
    @w_moneda = ah_moneda,
    @w_tipo = ah_tipo,
    @w_fec_aper = ah_fecha_aper,
    @w_categoria = ah_categoria,
    @w_ofi_cta = ah_oficina,
    @w_prom_disponible = ah_prom_disponible,
    @w_monto_imp_total = ah_monto_imp,
    @w_int_mes = ah_int_mes,
    @w_cuota = ah_cuota,
    @w_filial = ah_filial
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cuenta
  if @@rowcount = 0
  begin
    /* No existe cuenta_banco */
    return 251001
  end

  select
    @o_saldo = @w_slddisp

  -- Encuentra parametro de decimales
  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @w_moneda

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

  -- Validacion de cuentas de tarjetas de planilla
  select
    @w_prod_tpl = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'TPL'
  if @@rowcount <> 1
  begin
    /* Error Parametro no encontrado */
    return 201196
  end

  if (@w_prod_tpl <> @w_prod_banc)
  begin
    /* La cuenta no es de tarjetas de planilla */
    return 251088
  end

  -- VALORES EMBARGADOS
  if @w_ah_monto_emb > 0
  begin
    return 201315
  end

  --LHO 20071004
/*
-- Validacion para que la cuenta no tenga Cuentas x cobrar/pagar en SIDAC
if exists (select *
         from cob_sidac..sid_formas_pago, cob_sidac..sid_registros_padre
        where fp_destino = @i_cuenta
          and fp_tipo = 'A'  -- C = cuentas corrientes A= ahorros
          and rp_empresa = fp_empresa
          and rp_consecutivo = fp_cuenta 
          and rp_submodulo = fp_submodulo
          and rp_estado = 'V')
begin
     -- Cuenta vinculada con operacion de SIDAC
     return 201308
end
*/
  -- Determina el tipo de bloqueo
  select
    @w_tipo_bloqueo = cb_tipo_bloqueo
  from   cob_ahorros..ah_ctabloqueada
  where  cb_cuenta = @w_cuenta
     and cb_estado = 'V'
     and cb_tipo_bloqueo in ('1', '2', '3')
  if @@rowcount <> 0
    return 251007

  if exists (select
               *
             from   cob_ahorros..ah_embargo
             where  he_cta_banco = @i_cuenta
                and he_fecha_lev is null)
    return 251025

  /*Determina el bloqueo de valores */
  if @w_monto_bloq > 0
      or @w_monto_emb > 0
  begin
    -- Existe Bloqueo o Embargo de Valores
    return 251076
  end

/****** PEDRO COELLO RAMIREZ NO VALIDAR LINEA PENDIENTES GLOBAL BANK 21 DE FEBRERO DEL 2006
if @w_linea <> 0 
begin
    -- Cuenta con Lineas Pendientes
    return 251008
end
******/
/* COMENTADO POR SOLICITUD DE GLOBALBANK
-- VALORES EN SUSPENSO POR COBRAR
if exists (select *
             from cob_ahorros..ah_val_suspenso
            where vs_procesada = 'N'
              and vs_cuenta = @w_cuenta)
    return 251074
 FIN COMENTARIO */
  -- Calculo del saldo contable de la cuenta
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = 'N',
    @t_file             = '',
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @i_fecha,
    @i_ofi              = @w_ofi_cta,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  if @w_saldo_contable <> @w_slddisp
  begin
    -- Cuenta con Retenciones
    return 251059
  end

  select
    @w_slddisp = round((@w_slddisp + @w_sldmantval),
                       @w_numdeci)

  /** COMENTADO NO APLICA A GLOBAL BANK NO SE COBRA MULTAS POR CIERRE ANTES DE TIEMPO
  
  select @w_dias =  pa_smallint
    from cobis..cl_parametro
   where pa_producto = 'AHO'
     and pa_nemonico = 'MCI'
  
  -- cobra una multa por cerrar una cuenta antes de tiempo
  if (datediff(dd,@w_fec_aper,@i_fecha) < @w_dias)
  begin
      exec    @w_return    = cob_remesas..sp_genera_costos
          @i_filial    = @w_filial,
          @i_fecha    = @i_fecha,
          @i_oficina    = @w_ofi_cta,
          @i_categoria    = @w_categoria,
          @i_tipo_ente    = @w_tipo_ente,
          @i_rol_ente    = @w_rol_ente,
          @i_tipo_def    = @w_tipo_def,
          @i_prod_banc    = @w_prod_banc,
          @i_producto    = @w_producto,
          @i_moneda    = @w_moneda,
          @i_tipo        = @w_tipo,
          @i_codigo    = @w_default,
          @i_servicio    = 'CCTA',
          @i_rubro    = '22',
          @i_disponible    = @w_slddisp,
          @i_contable    = @w_saldo_contable,
          @i_promedio    = @w_promedio1,
          @i_personaliza    = @w_personalizada,
          @o_valor_total    = @w_multa out
      if @w_return <> 0
          return @w_return
  end
       FIN COMENTARIO */

  select
    @w_multa = isnull(@w_multa,
                      0)

  -- Cobro del IDB de la multa
  if @w_slddisp >= @w_multa
    select
      @w_slddisp = @w_slddisp - @w_multa
  else
  begin
    select
      @w_multa = @w_slddisp,
      @w_slddisp = 0
  end

  select
    @w_retencion = en_retencion
  from   cobis..cl_ente
  where  en_ente = @w_cliente

  select
    @w_valor_impuesto = isnull(@w_valor_impuesto,
                               0)

  if @w_slddisp >= @w_valor_impuesto
    select
      @w_slddisp = @w_slddisp - @w_valor_impuesto
  else
  begin
    select
      @w_valor_impuesto = @w_slddisp,
      @w_slddisp = 0
  end

  -- Solo se cierran las cuentas con saldo 0 (cero)
  if @w_slddisp > 0
  begin
    -- Entrega del saldo de la cuenta
    select
      @o_saldo = @w_slddisp
    -- La cuenta de tarjeta de planilla no tiene saldo cero
    return 251089
  end

  -- Se obtiene la filial
  select
    @w_filial = of_filial
  from   cobis..cl_oficina
  where  of_oficina = @w_ofi_cta

  -- Encuentra la alicuota para el promedio
  select
    @w_alicuota = fp_alicuota
  from   cob_ahorros..ah_fecha_promedio
  where  fp_tipo_promedio = @w_tipo_prom
     and fp_fecha_inicio  = @i_fecha
  if @@rowcount = 0
    return 251013

  begin tran

  -- Grabar transaccion de servicio por reverso de intereses provisionados
  if @w_sldint > 0
  begin
    insert into ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_ctacte,ts_filial,ts_valor,ts_oficina,
                 ts_oficina_cta,ts_prod_banc,ts_categoria,ts_moneda,
                 ts_tipocta_super)
    values      (@w_ssn,@w_ssn,323,@i_fecha,@s_user,
                 @s_term,@w_cuenta,@w_filial,@w_sldint,@w_ofi_cta,
                 @w_ofi_cta,@w_prod_banc,@w_categoria,@w_moneda,@w_tipocta_super
    )
    if @@error <> 0
    begin
      -- Error en insercion de transaccion servicio
      rollback tran
      return 253004
    end
    select
      @w_sldint = 0 -- se reversaron los intereses provisionados y no se pagaran
  end

  select
    @w_trn = 264,
    @w_cau = '12'

  -- Graba transaccion monetaria en caso de multa antes de cierre
  if @w_multa > 0
  begin
    select
      @w_prom_disponible = @w_prom_disponible - (@w_multa) * @w_alicuota,
      @w_promedio1 = @w_promedio1 - (@w_multa) * @w_alicuota

    select
      @w_monto_imp_multa = 0

    insert into cob_ahorros..ah_notcredeb
                (secuencial,alterno,tipo_tran,oficina,usuario,
                 terminal,correccion,sec_correccion,reentry,origen,
                 nodo,fecha,cta_banco,signo,indicador,
                 remoto_ssn,moneda,causa,interes,valor,
                 saldocont,saldodisp,oficina_cta,filial,prod_banc,
                 categoria,monto_imp,tipocta_super,hora,canal)
    values      (@w_ssn,4,@w_trn,@w_ofi_cta,@s_user,
                 @s_term,'N',null,'N','L',
                 @s_srv,@i_fecha,@i_cuenta,'D',1,
                 null,@w_moneda,@w_cau,0,@w_multa,
                 @w_slddisp,@w_slddisp,@w_ofi_cta,@w_filial,@w_prod_banc,
                 @w_categoria,@w_monto_imp_multa,@w_tipocta_super,getdate(),
                 @i_canal)
    if @@error <> 0
    begin
      -- Error en insercion de transaccion monetaria
      rollback tran
      return 203000
    end
  end -- MULTA > 0

  -- Actualizacion de las tablas: ah_his_cierre, ah_cuenta y cl_det_producto
  exec @w_return = cobis..sp_cseqnos
    @t_debug     = 'N',
    @t_file      = '',
    @t_from      = @w_sp_name,
    @i_tabla     = 'ah_his_cierre',
    @o_siguiente = @w_numrg out
  if @w_return <> 0
  begin
    rollback tran
    return @w_return
  end

  insert into cob_ahorros..ah_his_cierre
              (hc_secuencial,hc_cuenta,hc_orden,hc_causa,hc_saldo,
               hc_fecha,hc_filial,hc_oficina,hc_autorizante,hc_ssn_branch,
               hc_forma_pg,hc_observacion,hc_observacion1,hc_estado)
  values      (@w_numrg,@w_cuenta,'','',@w_slddisp,
               @i_fecha,@w_filial,@w_ofi_cta,'batch',@w_ssn,
               'E','','','C')
  if @@error <> 0
  begin
    /* Error en creacion de registro en ah_his_cierre */
    rollback tran
    return 203010
  end

  select
    @w_prom_disponible = @w_prom_disponible - (@w_multa) * @w_alicuota,
    @w_promedio1 = @w_promedio1 - (@w_multa) * @w_alicuota

  update cob_ahorros..ah_cuenta
  set    ah_disponible = round(@w_slddisp,
                               @w_numdeci),
         ah_promedio1 = round(isnull(@w_promedio1,
                                     0),
                              @w_numdeci),
         ah_prom_disponible = round (isnull(@w_prom_disponible,
                                            0),
                                     @w_numdeci),
         ah_debitos = ah_debitos + @w_multa,
         ah_debitos_hoy = ah_debitos_hoy + @w_multa,
         ah_creditos = ah_creditos + @w_sldint,
         ah_creditos_hoy = ah_creditos_hoy + @w_sldint,
         ah_fecha_ult_upd = @i_fecha,
         ah_contador_trx = ah_contador_trx + 1,
         ah_estado = 'C'
  where  ah_cuenta = @w_cuenta
  if @@rowcount <> 1
  begin
    -- Error en actualizacion de registro en ah_cuenta
    rollback tran
    return 255001
  end

  update cobis..cl_det_producto
  set    dp_estado_ser = 'C'
  where  dp_cuenta   = @i_cuenta
     and dp_producto = 4
  if @@rowcount <> 1
  begin
    -- Error en actualizacion de registro en cl_det_producto
    rollback tran
    return 105050
  end

  commit tran

  return 0

go

