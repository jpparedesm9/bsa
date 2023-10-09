/************************************************************************/
/*      Archivo:                pemb_esp.sp                             */
/*      Stored procedure:       sp_pembargo_esp                         */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Fecha de escritura:     02-Feb-2009                             */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*    Este programa procesa los cobros de embargos pendientes durante   */
/*    el proceso Batch,se aplica a AHO, CTE y PFI segun prioridades     */
/*    a cuenta especifica                                               */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA           AUTOR            RAZON                              */
/*  04/May/2016 T. Baidal      Migracion a CEN                          */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_pembargo_esp')
    drop proc sp_pembargo_esp
go

create proc sp_pembargo_esp
(
  @s_ssn                   int = null,
  @s_sesn                  int = null,
  @s_user                  login = null,
  @s_term                  varchar(30) = null,
  @s_date                  datetime = null,
  @s_srv                   varchar(30) = null,
  @s_lsrv                  varchar(30) = null,
  @s_ofi                   smallint = null,
  @s_rol                   smallint = null,
  @s_org_err               char(1) = null,
  @s_error                 int = null,
  @s_sev                   tinyint = null,
  @s_msg                   descripcion = null,
  @s_org                   char(1) = null,
  @t_debug                 char(1) = 'N',
  @t_file                  varchar(10) = null,
  @t_from                  varchar(32) = null,
  @t_trn                   smallint = null,
  @t_show_version          bit = 0,
  @i_producto              char(3),
  @i_saldo                 money,
  @i_saldo_pdte            money,
  @i_nro_cta_especifica    varchar(16),
  @i_ente                  int,
  @i_oficina               smallint,
  @i_fecha_proceso         datetime,
  @i_fecha_ofi             datetime,
  @i_oficio                varchar(16),
  @i_solicitante           descripcion,
  @i_demandante            descripcion,
  @i_monto                 money,
  @i_secuencial            int,
  @i_sec_prod              int,
  @i_concepto1             tinyint,
  @i_juzgado               varchar(64),
  @i_ofi_des               smallint,
  @i_interes               money,
  @i_debita_cta            char(1),
  @i_tipo_doc_demandante   varchar(2),
  @i_numero_doc_demandante varchar(13),
  @i_nombre_demandante     varchar(20),
  @i_apellido_demandante   varchar(30),
  @i_cuenta_especifica     char(1),
  @i_nombre_demandado      varchar(20),
  @i_apellido_demandado    varchar(30),
  @i_mmi                   varchar(10),
  @o_registros             int = 0 out,
  @o_saldopdte             money = 0 out
)
as
  declare
    @w_return                int,
    @w_error                 int,
    @w_parametro             money,
    @w_ente_aux              int,
    @w_cuenta                cuenta,
    @w_saldo                 money,
    @w_saldo_3xm             money,
    @w_valor                 money,
    @w_valor_int             money,
    @w_valor_3xmil           money,
    @w_causa                 varchar(8),
    @w_sec_prod              int,
    @w_sec                   int,
    @w_fecha_proceso         datetime,
    @w_capital               money,
    @w_interes               money,
    @w_sp_name               descripcion,
    @w_ente                  int,
    @w_secuencial            int,
    @w_saldo_pdte            money,
    @w_debita_cta            char(1),
    @w_oficina               smallint,
    @w_oficio                varchar(16),
    @w_solicitante           descripcion,
    @w_demandante            descripcion,
    @w_fecha_ofi             datetime,
    @w_monto                 money,
    @w_lsrv                  char(15),
    @w_imp_2x1000            float,
    @w_factor_3x1000         float,
    @w_valcheque             money,
    @w_tipo_persona          char(1),
    @w_cuenta_especifica     char(1),
    @w_nro_cta_especifica    varchar(20),
    @w_producto              varchar(10),
    @w_producto_gral         varchar(10),
    @w_concepto              varchar(10),
    @w_juzgado               varchar(64),
    @w_oficina_destino       varchar(10),
    @w_ofi_des               smallint,
    @w_tipo_doc_demandante   varchar(2),
    @w_numero_doc_demandante varchar(13),
    @w_nombre_demandante     varchar(20),
    @w_apellido_demandante   varchar(30),
    @w_tipo_ced              char(2),
    @w_ced_ruc               varchar(30),
    @w_nombre                varchar(64),
    @w_p_apellido            varchar(16),
    @w_s_apellido            varchar(16),
    @w_apellidos             varchar(33),
    @w_pagadora              smallint,
    @w_concepto1             tinyint,
    @w_3xmil                 char(1),
    @w_cta                   int,
    @w_numdeciimp            tinyint,
    @w_piva                  float,
    @w_saldo_para_girar      money,
    @w_saldo_contable        money,
    @w_impuesto              money,
    @w_val_emb               money,
    @w_imp_emb               money,
    @w_dif_emb               money,
    @w_valor_cobro           money,
    @w_tipo_doc_demandado    char(2),
    @w_numero_doc_demandado  varchar(13),
    @w_modulo                tinyint,
    @w_nombre_demandado      varchar(20),
    @w_apellido_demandado    varchar(30),
    @w_mmi                   varchar(10),
    @w_contador              int,
    @w_moneda                tinyint,
    @w_ctabanco              varchar(20),
    @w_oficina2              smallint,
    @w_redcero               tinyint,
    @w_newsaldo              money,
    @w_cuenta_valida_int     int,
    @w_llamar_embargo        char(1),
    @w_nro_cta               int,
    @w_vr_super              money,
    @w_vr_dian               money

  --U2 V4
  select
    @w_sp_name = "sp_pembargo_esp"

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_ente_aux = 0
  select
    @w_redcero = 0

  /* Encuentra el SSN inicial */
  select
    @w_sec = se_numero
  from   cobis..ba_secuencial
  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_sec + 10
  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @i_num = 205031 /* Error en actualizacion de SSN */
    return 205031
  end

  /* LECTURA DE EMBARGOS PENDIENTES **/
  select
    @w_ente = @i_ente,
    @w_saldo_pdte = @i_saldo_pdte,
    @w_saldo = @i_saldo,
    @w_producto = @i_producto,
    @w_nro_cta_especifica = @i_nro_cta_especifica,
    @w_oficina = @i_oficina,
    @w_fecha_proceso = @i_fecha_proceso,
    @w_fecha_ofi = @i_fecha_ofi,
    @w_oficio = @i_oficio,
    @w_solicitante = @i_solicitante,
    @w_demandante = @i_demandante,
    @w_monto = @i_monto,
    @w_secuencial = @i_secuencial,
    @w_sec_prod = @i_sec_prod,
    @w_oficina = @i_oficina,
    @w_concepto1 = @i_concepto1,
    @w_juzgado = @i_juzgado,
    @w_ofi_des = @i_ofi_des,
    @w_interes = @i_interes,
    @w_debita_cta = @i_debita_cta,
    @w_tipo_doc_demandante = @i_tipo_doc_demandante,
    @w_numero_doc_demandante = @i_numero_doc_demandante,
    @w_nombre_demandante = @i_nombre_demandante,
    @w_apellido_demandante = @i_apellido_demandante,
    @w_cuenta_especifica = @i_cuenta_especifica,
    @w_apellido_demandado = @i_apellido_demandado,
    @w_mmi = @i_mmi

  /** Consulta nombre, apellido Tipo Ced, y Nro Doc Cliente **/
  select
    @w_nombre_demandado = en_nombre,
    @w_apellido_demandado = p_p_apellido + ' ' + p_s_apellido,
    @w_tipo_doc_demandado = en_tipo_ced,
    @w_numero_doc_demandado = en_ced_ruc
  from   cobis..cl_ente
  where  en_ente = @w_ente

  if @i_producto in ('CTE', 'AHO')
  begin
    select
      @w_valor = 0
    if @w_saldo_pdte < @w_saldo
    begin
      select
        @w_valor = @w_saldo_pdte
      select
        @w_saldo_pdte = @w_saldo_pdte - @w_valor
    end

    if @w_saldo_pdte > @w_saldo
    begin
      select
        @w_valor = @w_saldo
      select
        @w_saldo_pdte = @w_saldo_pdte - @w_valor
    end

    if @w_saldo_pdte = @w_saldo
    begin
      select
        @w_valor = isnull(round(@w_saldo,
                                @w_numdeciimp),
                          0)
      select
        @w_saldo_pdte = @w_saldo_pdte - @w_valor
    end

    /* Registrar el embargo */
    select
      @w_llamar_embargo = 'S'

    if @w_producto = 'AHO'
    begin
      select
        @w_cuenta_valida_int = ah_cuenta
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_nro_cta_especifica

      exec @w_return = cob_ahorros..sp_ahcalcula_saldo
        @t_debug            = null,
        @t_file             = null,
        @t_from             = @w_sp_name,
        @i_cuenta           = @w_cuenta_valida_int,
        @i_fecha            = @w_fecha_proceso,
        @i_monblq           = 'N',
        @i_valida_saldo     = 'N',
        @o_saldo_para_girar = @w_saldo_para_girar out,
        @o_saldo_contable   = @w_saldo_contable out

      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101017--cambiar
        return 1
      end
    end

    if @w_saldo_para_girar = 0 --si el valor es cero no insertar embargo
      select
        @w_llamar_embargo = 'N'

    select
      @w_vr_super = pa_money
    from   cobis..cl_parametro
    where  pa_nemonico = "MMISUP"

    select
      @w_vr_dian = pa_money
    from   cobis..cl_parametro
    where  pa_nemonico = "MMIDIA"

    if (@w_saldo_para_girar <= @w_vr_super)
       and @w_mmi = "MMISUP"
      select
        @w_llamar_embargo = 'N'

    if (@w_saldo_para_girar <= @w_vr_dian)
       and @w_mmi = "MMIDIA"
      select
        @w_llamar_embargo = 'N'

    if @w_llamar_embargo is null
        or @w_llamar_embargo = 'S'
    /*La idea es que no inserte cabeceras y detalles en cero*/
    begin
      exec @w_return = sp_embargo
        @s_ssn                   = @w_sec,
        @s_srv                   = @s_srv,
        @s_lsrv                  = @s_lsrv,
        @s_user                  = 'Embargos',
        @s_term                  = @s_term,
        @s_date                  = @w_fecha_proceso,
        @s_ofi                   = @w_oficina,
        @s_org                   = @s_org,
        @t_trn                   = 1423,
        @s_sesn                  = @w_sec,
        @i_linea                 = 'N',
        @i_operacion             = 'U',
        @i_cliente               = @w_ente,
        @i_fecha                 = @w_fecha_proceso,
        @i_fecha_ofi             = @w_fecha_ofi,
        @i_oficio                = @w_oficio,
        @i_solicitante           = @w_solicitante,
        @i_demandante            = @w_demandante,
        @i_monto                 = @w_monto,
        @i_tipo_proceso          = 'B',
        @i_autorizante           = 'embargos',
        @i_monto_emb             = @w_valor,
        @i_estado_lev            = 'N',
        @i_num_cta               = @w_nro_cta_especifica,
        @i_secuencial            = @w_secuencial,
        @i_sec_modulo            = @w_sec_prod,
        @i_oficina               = @w_oficina,
        @i_producto              = @w_producto,
        @i_observacion           = 'COBRO POR BATCH CUENTA ESPECIFICA',
        @i_modulo                = 2,
        @i_concepto              = @w_concepto1,
        @i_juzgado               = @w_juzgado,
        @i_oficina_destino       = @w_ofi_des,
        @i_interes               = @w_interes,
        @i_debita_cta            = @w_debita_cta,
        @i_tipo_doc_demandante   = @w_tipo_doc_demandante,
        @i_numero_doc_demandante = @w_numero_doc_demandante,
        @i_nombre_demandante     = @w_nombre_demandante,
        @i_apellido_demandante   = @w_apellido_demandante,
        @i_tipo_doc_demandado    = @w_tipo_doc_demandado,
        @i_numero_doc_demandado  = @w_numero_doc_demandado,
        @i_cuenta_especifica     = @w_cuenta_especifica,
        @i_nro_cta_especifica    = @w_nro_cta_especifica,
        @i_nombre_demandado      = @w_nombre_demandado,
        @i_apellido_demandado    = @w_apellido_demandado,
        @i_mmi                   = @w_mmi,
        @o_saldopdte             = @w_saldo_pdte out

      if @w_return <> 0
      begin
        print 'rechazo embargo en pembargo' + convert (varchar(10), @w_return)
        exec sp_errorlog
          @i_fecha       = @w_fecha_proceso,
          @i_error       = @w_return,
          @i_usuario     = 'misbatch',
          @i_tran        = 1423,
          @i_tran_name   = @w_sp_name,
          @i_cuenta      = @w_cuenta,
          @i_descripcion = 'Error retornado por el sp sp_pembargo esp4 3 ',
          @i_rollback    = 'S'
      end
    end

    if @i_producto in ("CTE", "AHO")
    begin
      select
        @w_sec = @w_sec + 1
    end
  end --@w_producto = "CTE" or "AHO"

  /*
  /*PRODUCTO PLAZO FIJO***/
  if @w_producto = "PFI"
  begin
     select @w_saldo = saldo,
            @w_cuenta = cuenta,
            @w_capital = capital,
            @w_interes = interes
       from productos_tmp2
      where producto = 'PFI'
       and cuenta   = @w_nro_cta_especifica
  
     select @w_valor      = 0,
            @w_valor_int  = 0
  
     /** Validar monto de embargo para plazo fijo **/
  
     if @w_saldo_pdte >= @w_interes
     begin
        select @w_valor_int = @w_interes
        select @w_saldo_pdte = @w_saldo_pdte - @w_valor_int
     end
     else
        select @w_valor_int = 0
  
     if @w_saldo_pdte > @w_capital
     begin
        select @w_valor   = @w_capital
        select @w_saldo_pdte = @w_saldo_pdte - @w_capital
     end
     else
     begin
        select @w_valor   = @w_saldo_pdte
        select @w_saldo_pdte = @w_saldo_pdte - @w_valor
     end
  
     /* Registrar el embargo */
     exec @w_return = sp_embargo
          @s_ssn                    = @w_sec,
          @s_srv                    = @s_srv,
          @s_lsrv                   = @w_lsrv,
          @s_user                   = "embargos",
          @s_term                   = @s_term,
          @s_date                   = @w_fecha_proceso,
          @s_ofi                    = @s_ofi,
          @s_org                    = @s_org,
          @t_trn                    = 1423,
          @s_sesn                   = @w_sec,
          @i_linea                  = 'N',
          @i_operacion              = 'U',
          @i_cliente                = @w_ente,
          @i_fecha                  = @w_fecha_proceso,
          @i_fecha_ofi              = @w_fecha_ofi,
          @i_oficio                 = @w_oficio,
          @i_solicitante            = @w_solicitante,
          @i_demandante             = @w_demandante,
          @i_monto                  = @w_monto,
          @i_tipo_proceso           = 'B',
          @i_autorizante            = 'embargos',
          @i_monto_emb              = @w_valor,
          @i_estado_lev             = 'N',
          @i_num_cta                = @w_nro_cta_especifica,
          @i_secuencial             = @w_secuencial,
          @i_sec_modulo             = @w_sec_prod,
          @i_oficina                = @w_oficina,
          @i_producto               = @w_producto,
          @i_observacion            = 'COBRO POR BATCH',
          @i_modulo                 = 2,
          @i_concepto               = @w_concepto1,
          @i_juzgado                = @w_juzgado,
          @i_oficina_destino        = @w_ofi_des,
          @i_interes                = @w_interes,
          @i_debita_cta             =  @w_debita_cta,
          @i_tipo_doc_demandante    = @w_tipo_doc_demandante,
          @i_numero_doc_demandante  = @w_numero_doc_demandante,
          @i_nombre_demandante      = @w_nombre_demandante,
          @i_apellido_demandante    = @w_apellido_demandante,
          @i_tipo_doc_demandado     = @w_tipo_doc_demandado,
          @i_numero_doc_demandado   = @w_numero_doc_demandado,
          @i_cuenta_especifica      = @w_cuenta_especifica,
          @i_nro_cta_especifica     = @w_nro_cta_especifica,
          @i_nombre_demandado       = @w_nombre_demandado,
          @i_apellido_demandado     = @w_apellido_demandado,
          @i_mmi                    = @w_mmi
  
     if @w_return <> 0
     begin
        --print "rechazo embargo en pembargo %1!",@w_return
        exec sp_errorlog
           @i_fecha         = @w_fecha_proceso,
           @i_error         = @w_return,
           @i_usuario       = 'misbatch',
           @i_tran          = 1423,
           @i_tran_name     = @w_sp_name,
           @i_cuenta        = @w_cuenta,
           @i_descripcion   = 'Error retornado por el sp sp_pembargo esp pfi',
           @i_rollback      = 'S'
     end
     else
     begin
       select @w_sec = @w_sec + 1
     end
  end --plazo fijo
  */
  return 0

go

