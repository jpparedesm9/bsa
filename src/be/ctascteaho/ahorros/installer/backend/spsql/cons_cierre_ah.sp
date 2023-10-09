/************************************************************************/
/*  Archivo:            cons_cierre_ah.sp                               */
/*  Stored procedure:   sp_cons_cierre_ah                               */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 18-Feb-1993                                     */
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
/*  Este programa realiza la transaccion de consulta de cierre de       */
/*  cuentas de ahorros.                                                 */
/*  214 = Consulta de cierre de cuentas de ahorros                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*  08/Mar/1993 P. Mena         Emision inicial                         */
/*  21/Dic/1994 J. Bucheli      Personalizacion para Banco de           */
/*                              la Produccion                           */
/*  25/Sep/1998 V. Molina       Personal. del B. Caribe                 */
/*  26/Abr/1999 J. Gordillo     Parametro Dias del anio                 */
/*  17/Jun/1999 V. Molina       Cobro el IDB                            */
/*  24/Ago/1999 J. Salazar      Calculo de IDB por retencion            */
/*  12/12/2006  R. Linares      se agrego @i_val_inac                   */
/*  19/Mar/2007 P. Coello       Activar cobro de multa por cie          */
/*                                      rre anticipado                  */
/*  09/Abr/2013 J. Colorado     Reintegro de gmf para Alianza Cormecial */
/*  06/NOV/2013 C. Avendaño     Validar que no exista relacion cuenta   */
/*                              - canal                                 */
/*  02/May/2016 J. Calderon     Migración a CEN                         */
/*  03/Sep/2016 J. Tagle       Cierre Ctas Aporte Social                */
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
           where  name = 'sp_cons_cierre_ah')
  drop proc sp_cons_cierre_ah
go

create proc sp_cons_cierre_ah
(
  @s_ssn          int,
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
  @i_filial       tinyint,
  @i_oficina      smallint,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_val_inac     char(1) = 'S',--PARA VALIDAR O NO LA INACTIVIDAD
  @i_cob_multa    char(1),-- Para cobrar o  no la multa
  @i_corresponsal char(1) = 'N',
  @o_retiro       money = 0 out
)
as
  declare
    @w_return              int,
    @w_sp_name             varchar(30),
    @w_cuenta              int,
    @w_est                 char(1),
    @w_filial              tinyint,
    @w_secuencial          int,
    @w_saldo_para_girar    money,
    @w_saldo_contable      money,
    @w_tcapital            char(1),
    @w_personalizada       char(1),
    @w_tipo_def            char(1),
    @w_default             int,
    @w_rol_ente            char(1),
    @w_categoria           char(1),
    @w_alicuota            float,
    @w_factor              float,
    @w_int_perdidos        money,
    @w_int_ganados         money,
    @w_saldo_interes       money,
    @w_saldo_cierre        money,
    @w_acumu_deb           money,
    @o_concep_exc          int,
    @w_actualiza           char(1),
    @w_funcionario         char(1),
    @w_disponible          money,
    @w_promedio1           money,
    @w_tipo_ente           char(1),
    @w_prod_banc           smallint,
    @w_producto            tinyint,
    @w_valor_impuesto      money,
    @w_moneda              tinyint,
    @w_tipo                char(1),
    @w_fec_aper            datetime,
    @o_base_gmf            money,
    @w_dias                smallint,
    @w_oficina             smallint,
    @w_multa               money,
    @w_tmp                 varchar(30),
    @w_usadeci             char(1),
    @w_numdeci             tinyint,
    @w_numdeci_imp         tinyint,
    @w_retiro              money,
    @w_valsus              money,
    @w_saldo_min_mes       money,
    @w_fecha_ult_ret       datetime,
    @w_diferencia_fechas   smallint,
    @w_rubro               varchar(10),
    @w_tasa_interes        float,
    @w_retencion           char(1),
    @w_ente                int,
    @w_lineas              smallint,
    @w_mes                 varchar(2),
    @w_anio                varchar(4),
    @w_primer              varchar(10),
    @w_primer_fecha        datetime,
    @w_dias_anio           smallint,
    @w_monto_imp           money,
    @w_monto_imp_fin       money,
    @w_tasa_imp            float,
    @w_monto_imp_multa     money,
    @w_monto_imp_retiro    money,
    @w_monto_imp_valsus    money,
    @w_monto_imp_retencion money,
    @w_saldo_mantval       money,
    @w_msg                 char(100),
    @w_cuota               money,
    @w_sldint_aux          money,
    @w_multa_aux           money,
    @w_monto_embargado     money,
    @w_tasagmf             float,
    @w_porcentaje          float,
    @w_exento              char(1),
    @w_pais                varchar(10),
    @w_banco               varchar(10),
    @w_com_iva             char(1),
    @w_imp_gmf             char(1),
    @w_accion              char(1),
    @w_cau                 char(3),
    @w_impuesto            money,
    @w_timpuesto           float,
    @o_valiva              money,
    @w_concto_iva          char(4),
    @w_piva                float,
    @w_dias_capi           smallint,
    @w_fecha_ult_capi      datetime,
    @w_fecha               datetime,
    @w_base_rtfte          money,
    @w_binc                money,
    @w_cpto_rte            char(4),
    @w_remesas             money,
    @w_sldcred             money,
    @w_debug               char(1),
    @w_contractual         char(1),
    @w_tipocta             char(1),
    @w_interes_con         money,--REQ 217 Intereses Contractual
    @w_interes_acum        money,--REQ 217 Intereses acumulados no capitalizados
    @w_porc_tiempo         float,--REQ 217 Porcentaje Tiempo Cumplido
    @w_cant_plazos         smallint,--REQ 217 Cantidad de Plazos Contractual
    @w_interes_con_tot     money,--REQ 217 Total de Intereses con multa
    @w_camcat              varchar(2),-- REQ 217 Categoria Normal Contractual
    @w_par_prod_cont       int,
    @w_tasa_reintegro      float,
    @w_gmf_reintegro       money,
    @w_arecibir            money

	
  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_cons_cierre_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
    
  select
    @w_prod_banc = C.codigo
  from   cobis..cl_tabla T,
         cobis..cl_catalogo C
  where  T.tabla  = 're_pro_banc_cb'
     and T.codigo = C.tabla
     and C.estado = 'V'

  select
    @w_debug = 'N'

  select
    @w_remesas = 0,
    @w_fecha = @s_date
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
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  if @t_trn <> 214
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

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

  /* Encuentra dias del anio para provision diaria interes */

  select
    @w_dias_anio = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'DIA'

  if @@rowcount <> 1
  begin
    /* Error: no se ha definido ciudad de feriados nacionales */
    exec cobis..sp_cerror
      @i_num = 205031,
      @i_msg = 'ERROR EN PARAMETRO DE NUMERO DE DIAS ANIO'
    return 205031
  end

  select
    @w_pais = isnull(pa_char,
                     'PA')
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'ABPAIS'

  if @w_pais is null
    select
      @w_pais = 'PA'

  select
    @w_banco = isnull(pa_char,
                      '')
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CLIENT'

  if @w_banco is null
    select
      @w_banco = ''

  select
    @w_tasagmf = isnull(pa_float,
                        0)
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'IGMF'

  if @w_tasagmf is null
    if @w_pais <> 'CO'
      select
        @w_tasagmf = 0
    else
    begin
      /* Error: no se ha definido tasa para impuesto GMF */
      exec cobis..sp_cerror
        @i_num = 205031,
        @i_msg = 'ERROR EN PARAMETRO IMPUESTO GRAVAMEN MOVIMIENTO FINANCIERO'
      return 205031
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
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DCI'

    select
      @w_numdeci_imp = pa_tinyint
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DIM'

  end
  else
    select
      @w_numdeci = 0,
      @w_numdeci_imp = 0

  /* REQ 363 CORRESPONSALES FASE II */
  if exists(select
              1
            from   cob_remesas..re_relacion_cta_canal
            where  rc_cuenta = @i_cta
               and rc_estado = 'V')
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 353518,
      @i_msg   = 'CUENTA TIENE RELACION VIGENTE A UN CANAL'
    return 353518
  end

  /* CATEGORIA NORMAL CONTRACTUAL */
  select
    @w_camcat = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'CAMCAT'

  /* REQ 217 PARAMETRO PRODUCTO AHO CONTRACTUAL */
  select
    @w_par_prod_cont = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PAHCT'

  --REQ 381 - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    select
      @w_saldo_interes = ah_saldo_interes,
      @w_disponible = ah_disponible,
      @w_promedio1 = ah_promedio1,
      @w_tipo_ente = ah_tipocta,
      @w_rol_ente = ah_rol_ente,
      @w_tipo_def = ah_tipo_def,
      @w_default = ah_default,
      @w_personalizada = ah_personalizada,
      @w_prod_banc = ah_prod_banc,
      @w_producto = ah_producto,
      @w_moneda = ah_moneda,
      @w_tipo = ah_tipo,
      @w_categoria = ah_categoria,
      @w_fec_aper = ah_fecha_aper,
      @w_cuenta = ah_cuenta,
      @w_est = ah_estado,
      @w_funcionario = ah_cta_funcionario,
      @w_saldo_min_mes = ah_min_dispmes,
      @w_fecha_ult_ret = ah_fecha_ult_ret,
      @w_ente = ah_cliente,
      @w_oficina = ah_oficina,
      @w_lineas = ah_linea,
      @w_saldo_mantval = ah_saldo_mantval,
      @w_cuota = ah_cuota,
      @w_monto_embargado = ah_monto_emb,
      @w_fecha_ult_capi = ah_fecha_ult_capi,
      @w_remesas = ah_remesas,
      @w_tipocta = ah_tipocta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_prod_banc <> @w_prod_banc

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
  end
  else
  begin
    select
      @w_saldo_interes = ah_saldo_interes,
      @w_disponible = ah_disponible,
      @w_promedio1 = ah_promedio1,
      @w_tipo_ente = ah_tipocta,
      @w_rol_ente = ah_rol_ente,
      @w_tipo_def = ah_tipo_def,
      @w_default = ah_default,
      @w_personalizada = ah_personalizada,
      @w_prod_banc = ah_prod_banc,
      @w_producto = ah_producto,
      @w_moneda = ah_moneda,
      @w_tipo = ah_tipo,
      @w_categoria = ah_categoria,
      @w_fec_aper = ah_fecha_aper,
      @w_cuenta = ah_cuenta,
      @w_est = ah_estado,
      @w_funcionario = ah_cta_funcionario,
      @w_saldo_min_mes = ah_min_dispmes,
      @w_fecha_ult_ret = ah_fecha_ult_ret,
      @w_ente = ah_cliente,
      @w_oficina = ah_oficina,
      @w_lineas = ah_linea,
      @w_saldo_mantval = ah_saldo_mantval,
      @w_cuota = ah_cuota,
      @w_monto_embargado = ah_monto_emb,
      @w_fecha_ult_capi = ah_fecha_ult_capi,
      @w_remesas = ah_remesas,
      @w_tipocta = ah_tipocta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_prod_banc = @w_prod_banc

    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2609858
      return 1
    end
  end

  if @w_pais <> 'CO'
    select
      @w_saldo_interes = 0,-- EN GLOBALBANK NO SE PAGAN INTERESES.
      @w_saldo_mantval = 0
  else
  begin
    --Parametro concepto de retencion
    select
      @w_cpto_rte = ci_concepto
    from   cob_remesas..re_concepto_imp
    where  ci_tran        = 308
       and ci_impuesto    = 'R' --Verificar nemonico tipo de impuesto
       and ci_contabiliza = 'tm_valor'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @i_num = 201196,
        @i_msg = 'ERROR EN PARAMETRO DE CONCEPTO DE RETENCION'
      return 201196
    end

  end

  /* Validaciones */
  if @w_est <> 'A'
     and (@w_est = 'I'
          and @i_val_inac = 'S')
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  /*Verificacion de Remesas Pendientes*/
  if @w_remesas > 0
  begin
    /* Cuenta Con Valores Pendientes en Remesas */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 258006
    return 1
  end

  /* Verificacion de cuentas de funcionarios para oficiales autorizados */
  if @w_funcionario = 'S'
  begin
    if not exists (select
                     1
                   from   cob_remesas..re_ofi_personal,
                          cobis..cc_oficial,
                          cobis..cl_funcionario
                   where  fu_login       = @s_user
                      and fu_funcionario = oc_funcionario
                      and op_oficial     = oc_oficial)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201123
      return 1
    end
  end
  select
    @w_valor_impuesto = 0,
    @w_monto_imp_retencion = 0,
    @w_multa = 0,
    @w_monto_imp_multa = 0,
    @w_valsus = 0,
    @w_monto_imp_valsus = 0,
    @w_monto_imp_retiro = 0,
    @w_monto_imp = 0,
    @w_sldint_aux = 0,
    @w_multa_aux = 0,
    @w_gmf_reintegro = 0,
	@w_monto_imp_fin = 0

  if (@w_tasa_imp > 0)
  begin
    /* Verificar que la cuenta este exonerada */
    if exists (select
                 1
               from   cob_remesas..re_exoneracion_impuesto
               where  ei_producto = 'AHO'
                  and ei_cuenta   = @w_cuenta)
      select
        @w_tasa_imp = 0.0
  end

  --Para verificar cuenta contractual
  if exists (select
               1
             from   cob_remesas..re_cuenta_contractual
             where  cc_cta_banco = @i_cta
                and cc_estado    = 'A')
    select
      @w_contractual = 'S'
  else
    select
      @w_contractual = 'N'

  /* Calculo del saldo contable de la cuenta */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @s_date,
    @i_corresponsal     = @i_corresponsal,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  if @w_saldo_contable <> @w_disponible
  begin
    /* Cuenta con Retenciones */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251059,
      @i_msg   = 'SALDO CONTABLE DIFIERE DEL DISPONIBLE'
    return 1
  end

  if @w_saldo_interes > 0
  begin
    -- Parametros para nuevas opciones Entrega de dinero, CMU -BPT- REQ016 BANCAMIA
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

    /*** Preguntar si el cliente es sujeto de retencion ***/
    select
      @w_retencion = isnull(en_retencion,
                            'N')
    from   cobis..cl_ente
    where  en_ente = @w_ente

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

    --Verificar si @w_saldo_interes supera parametro de interes diario * cantidad de dias a capitalizar
    select
      @w_dias_capi = abs(datediff(dd,
                                  @w_fecha_ult_capi,
                                  @w_fecha))
    -- @w_dias_prx_mes no aplica en cierre

    select
      @w_base_rtfte = @w_dias_capi * @w_binc --@w_min_rtfte JAR 14/01/2010

    if @w_cpto_rte is not null
       and @w_saldo_interes >= @w_base_rtfte
    begin
      --Porcentaje retencion  
      exec @w_return = cob_interfase..sp_icon_impuestos
        @i_empresa      = 1,
        @i_concepto     = '0210',--RENDIMIENTOS-AHORROS
        @i_debcred      = 'D',
        @i_monto        = @w_saldo_interes,
        @i_impuesto     = 'R',--RETENCION
        @i_oforig_admin = @s_ofi,
        @i_ofdest_admin = @s_ofi,
        @i_ente         = @w_ente,
        @i_producto     = 4,
        @o_exento       = @w_exento out,
        @o_porcentaje   = @w_porcentaje out

      --      print ' saldo interes ' + cast(@w_saldo_interes as varchar) + ' @w_numdeci_imp-' + cast(@w_numdeci_imp as varchar)
      --Retencion en la fuente sobre intereses
      if @w_exento = 'N'
        select
          @w_valor_impuesto = round((@w_saldo_interes * round(
                                     (@w_porcentaje / 100),
                                     2)),
                                    @w_numdeci_imp)
      else
        select
          @w_valor_impuesto = 0
      if @w_debug = 'S'
        print ' @w_valor_impuesto : ' + cast(@w_valor_impuesto as varchar)
    end
  end
  else
    select
      @w_valor_impuesto = 0

  no_calcula_interes:

  select
    @w_valor_impuesto = isnull(@w_valor_impuesto,0)

	-- Calculo de IDB por la retencion --
  if @w_tasa_imp > 0
     and @w_valor_impuesto > 0
  begin
    select
      @w_monto_imp_retencion = round((@w_valor_impuesto * @w_tasa_imp),
                                     @w_numdeci_imp)
    select
      @w_monto_imp = @w_monto_imp + @w_monto_imp_retencion
  end

  select
    @w_sldcred = isnull(@w_disponible, 0) + isnull(@w_saldo_interes, 0)

  /*** El saldo de la cuenta = disponible + intereses - Retefuente - Monto embargados ***/
  select
    @w_saldo_cierre = @w_disponible + @w_saldo_interes + @w_saldo_mantval
                             - @w_valor_impuesto
                             - @w_monto_embargado

  select
    @w_valsus = isnull(sum(vs_valor),
                       0)
  from   cob_ahorros..ah_val_suspenso
  where  vs_procesada = 'N'
     and vs_cuenta    = @w_cuenta
     and vs_impuesto  = 'S'

  -- Cobro de impuestos de los valores en suspenso --
  select
    @w_monto_imp_valsus = 0
  if @w_valsus > 0
  begin
    if @w_tasa_imp > 0
      select
        @w_monto_imp_valsus = round((@w_valsus * @w_tasa_imp),
                                    @w_numdeci_imp)

    select
      @w_monto_imp = @w_monto_imp + @w_monto_imp_valsus
  end

  select
    @w_valsus = @w_valsus + isnull(sum(vs_valor), 0)
  from   cob_ahorros..ah_val_suspenso
  where  vs_procesada = 'N'
     and vs_cuenta    = @w_cuenta
     and vs_impuesto  = 'N'

  if @w_pais = 'CO'
  -- Se habilita bloque comentado para GLOBALBANK limitandolo segun pais
  begin
    if (@w_valsus + @w_monto_imp_valsus) > @w_saldo_cierre
    begin
      select
        @w_msg = '[' + @w_sp_name + '] ' +
                 'VALORES POR COBRAR MAYOR A SALDO DE CIERRE'
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251059,
        @i_sev   = 1,
        @i_msg   = @w_msg
      return 1
    end
    select
      @w_saldo_cierre = @w_saldo_cierre - @w_valsus - @w_monto_imp_valsus
  end

  select
    @w_dias = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'MCI'

  if @w_dias is null
    select
      @w_dias = 0

/***************************************************/
/* cobra una multa por cierre anticipado de cuenta */
  /***************************************************/
  if @i_cob_multa = 'S'
  begin
    if datediff(dd,
                @w_fec_aper,
                @s_date) < @w_dias
    begin
      if @w_contractual = 'S'
         and @w_prod_banc = @w_par_prod_cont
      begin
        if (@w_categoria <> @w_camcat)
        begin
          select
            @w_cant_plazos = cc_plazo,
            @w_interes_con = cc_intereses
          from   cob_remesas..re_cuenta_contractual
          where  cc_cta_banco = @i_cta
             and cc_estado    = 'A'

          select
            @w_interes_con_tot = round(isnull(@w_interes_con, 0) + isnull(
                                       @w_saldo_interes,
                                                                          0),
                                       @w_numdeci),
            @w_porc_tiempo = round(convert(float, (datediff(mm,
                                                            @w_fec_aper,
                                                            @s_date))) /
                                   convert(float, @w_cant_plazos),
                                   @w_numdeci),
            @w_rubro = '3'
          -- REQ 217 Rubro Deduccion de Intereses por Cancelacion Anticipada

          exec @w_return = cob_remesas..sp_genera_costos
            @i_filial      = @i_filial,
            @i_fecha       = @s_date,
            @i_oficina     = @w_oficina,
            @i_categoria   = @w_categoria,
            @i_tipo_ente   = @w_tipo_ente,
            @i_rol_ente    = @w_rol_ente,
            @i_tipo_def    = @w_tipo_def,
            @i_prod_banc   = @w_prod_banc,
            @i_producto    = @w_producto,
            @i_moneda      = @w_moneda,
            @i_tipo        = @w_tipo,
            @i_codigo      = @w_default,
            @i_servicio    = 'CCTA',
            @i_rubro       = @w_rubro,
            @i_disponible  = @w_disponible,
            @i_contable    = @w_saldo_contable,
            @i_promedio    = @w_promedio1,
            @i_porc_tiempo = @w_porc_tiempo,
            -- REQ 217 Porcentaje de Tiempo Cumplido
            @i_personaliza = @w_personalizada,
            @o_valor_total = @w_multa_aux out

          if @w_return <> 0
            return @w_return
        end
      end
      else
      begin
        if @w_pais = 'CO'
           and @w_banco = 'BM'
          select
            @w_rubro = '41'
        else
          select
            @w_rubro = '22'
        --       print ' w-rubro  ' + @w_rubro
        exec @w_return = cob_remesas..sp_genera_costos
          @i_filial      = @i_filial,
          @i_fecha       = @s_date,
          @i_oficina     = @w_oficina,
          @i_categoria   = @w_categoria,
          @i_tipo_ente   = @w_tipo_ente,
          @i_rol_ente    = @w_rol_ente,
          @i_tipo_def    = @w_tipo_def,
          @i_prod_banc   = @w_prod_banc,
          @i_producto    = @w_producto,
          @i_moneda      = @w_moneda,
          @i_tipo        = @w_tipo,
          @i_codigo      = @w_default,
          @i_servicio    = 'CCTA',
          @i_rubro       = @w_rubro,
          @i_disponible  = @w_disponible,
          @i_contable    = @w_saldo_contable,
          @i_promedio    = @w_promedio1,
          @i_personaliza = @w_personalizada,
          @o_valor_total = @w_multa_aux out

        if @w_return <> 0
          return @w_return
      end

	  -- JTA Ctas de Aporte Social No se cobra Multa
	  if (@w_prod_banc in (select pa_int from cobis..cl_parametro where  pa_producto = 'AHO' and  (pa_nemonico = 'PCAASO' OR pa_nemonico = 'PCAASA' )))			
	      select @w_multa_aux = 0	
			
      if (@w_contractual = 'S' and @w_categoria <> @w_camcat) and @w_prod_banc = @w_par_prod_cont
        select @w_multa_aux = round(@w_interes_con_tot * @w_multa_aux,@w_numdeci)
    end

    no_cobra_multa_cierre:

    select
      @w_multa = @w_multa + isnull(@w_multa_aux, 0)

    -- Cobro del IDB de la multa --
    if @w_multa > 0
    begin
      select
        @w_monto_imp_multa = 0
      if @w_tasa_imp > 0
        select
          @w_monto_imp_multa = round((@w_multa * @w_tasa_imp),@w_numdeci_imp)
    end
    else
      select
        @w_monto_imp_multa = 0

    if @w_saldo_cierre >= (@w_multa + @w_monto_imp_multa)
    begin
      --select @w_saldo_cierre = @w_saldo_cierre - @w_multa - @w_monto_imp_multa
      select
        @w_saldo_cierre = @w_saldo_cierre - @w_monto_imp_multa
    end
    else
    begin
      if @w_tasa_imp > 0
      begin
        select
          @w_multa = round((@w_saldo_cierre / (@w_tasa_imp + 1)),@w_numdeci)
        select
          @w_monto_imp_multa = @w_saldo_cierre - @w_multa
      end
      else
      begin
        select
          @w_monto_imp_multa = $0
        select
          @w_multa = @w_saldo_cierre
        select
          @w_saldo_cierre = $0
      end
    end

    /* Cobro del GMF y del IVA en caso de requerirlo ****/
    select
      @w_cau = '12'

    select
      @w_com_iva = an_comision,
      @w_imp_gmf = an_impuesto,
      @w_accion = an_accion
    from   cob_remesas..re_accion_nd
    where  an_producto = 4
       and an_causa    = @w_cau

    if @@rowcount = 0
    begin
      select
        @w_impuesto = 0,
        @w_timpuesto = 0,
        @o_valiva = 0,
        @w_accion = 'E',
        @w_imp_gmf = 'N',
        @w_com_iva = 'N'
    end

    if @w_com_iva = 'S'
    begin--3
      select
        @w_concto_iva = ci_concepto
      from   cob_remesas..re_concepto_imp
      where  ci_tran     = 264
         and ci_causal   = @w_cau
         and ci_impuesto = 'V'

      if @@rowcount = 0
        return 201232

      exec @w_return = cob_interfase..sp_icon_impuestos
        @i_empresa      = 1,
        @i_concepto     = @w_concto_iva,
        @i_debcred      = 'C',
        @i_monto        = @w_multa_aux,
        @i_impuesto     = 'V',
        @i_oforig_admin = @s_ofi,
        @i_ofdest_admin = @w_oficina,
        @i_ente         = @w_ente,
        @i_producto     = 4,
        @o_exento       = @w_exento out,
        @o_porcentaje   = @w_porcentaje out

      if @w_exento = 'N'
        select
          @w_piva = @w_porcentaje
      else
        select
          @w_piva = 0

      select
        @w_impuesto = round((@w_multa_aux * @w_piva / 100),
                            @w_numdeci_imp)

      if (@w_multa_aux + @w_impuesto) > @w_saldo_cierre
      begin
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'VALORES POR COBRAR -- MAYOR A SALDO DE CIERRE'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251059,
          @i_sev   = 1,
          @i_msg   = @w_msg
        return 1
      end
    end --3
    else
      select
        @w_impuesto = 0

    select
      @w_saldo_cierre = @w_saldo_cierre - @w_multa_aux - @w_impuesto
    --    - @w_monto_imp_multa
    if @w_debug = 'S'
      print 'w_monto_imp_multa ' + cast(@w_monto_imp_multa as varchar) + ' w_impuesto ' + cast(@w_impuesto as varchar)
    select
      @w_valor_impuesto = @w_valor_impuesto + @w_monto_imp_multa + @w_impuesto
  end
  else -- En caso de no cobrar la multa por cierre anticipado
  begin
    select
      @w_multa = 0,
      @w_monto_imp_multa = 0,
      @w_impuesto = 0
  end
  select
    @w_monto_imp = @w_monto_imp + @w_monto_imp_multa + @w_impuesto

  select
    @w_retiro = round(@w_saldo_cierre,@w_numdeci)

  if @w_retiro > 0
  begin
    if @w_tasa_imp > 0
    begin
      select
        @w_retiro = round((@w_retiro / (@w_tasa_imp + 1)),@w_numdeci)
      select
        @w_monto_imp_retiro = @w_saldo_cierre - @w_retiro
    end
    else
      select
        @w_monto_imp_retiro = $0
  end
  else
    select
      @w_monto_imp_retiro = 0

  select
    @w_monto_imp = @w_monto_imp + @w_monto_imp_retiro
  select
    @w_monto_imp = round(((@w_valor_impuesto + @w_multa) * @w_tasa_imp),
                         @w_numdeci_imp)
  select
    @w_retiro = @w_retiro - @w_monto_imp

  exec @w_return = sp_calcula_gmf
    @s_user            = @s_user,
    @s_date            = @s_date,
    @s_ofi             = @s_ofi,
    @t_trn             = @t_trn,
    @i_factor          = 1,
    @i_mon             = @i_mon,
    @i_cta             = @i_cta,
    @i_cliente         = @w_ente,
    @i_cuenta          = @w_cuenta,
    @i_val             = @w_sldcred,
    @i_val_tran        = @w_sldcred,
    @i_numdeciimp      = @w_numdeci,
    @i_producto        = @w_producto,
    @i_operacion       = 'Q',
    @i_total           = 'S',
    @o_total_gmf       = @w_monto_imp_fin out,-- @o_val_2x1000 out,
    @o_acumu_deb       = @w_acumu_deb out,
    @o_actualiza       = @w_actualiza out,
    @o_base_gmf        = @o_base_gmf out,
    @o_tasa            = @w_tasagmf out,
    @o_concepto        = @o_concep_exc out,
    @o_tasa_reintegro  = @w_tasa_reintegro out,--JCO
    @o_valor_reintegro = @w_gmf_reintegro out -- JCO 

  if @w_return <> 0
    return @w_return
	
  if @w_debug = 'S'
    print '@w_monto_imp_fin  ' + cast(@w_monto_imp_fin as varchar) +' @w_monto_imp ' + cast(@w_monto_imp as varchar) + ' @w_sldcred ' + cast(@w_sldcred as varchar)
  select
    @w_monto_imp = isnull(@w_monto_imp, 0) + @w_monto_imp_fin
  select
    @w_retiro = @w_retiro - isnull(@w_monto_imp_fin,0) + @w_gmf_reintegro
  select
    @o_retiro = @w_retiro

  -- Envio de resultados al Front End --
  select
    @w_saldo_contable,
    @w_saldo_interes,
    @w_valor_impuesto,
    @w_multa,
    @w_valsus,
    @w_monto_imp,
    @w_lineas,
    @o_retiro,
    @w_saldo_mantval,
    @w_monto_embargado,
    @w_tasagmf,
    @w_contractual,
    @w_categoria,
    @w_tipocta,
    @w_prod_banc,
    isnull(@w_gmf_reintegro,0)

  return 0

go

