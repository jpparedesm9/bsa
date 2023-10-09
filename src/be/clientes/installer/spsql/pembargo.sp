/************************************************************************/
/*      Archivo:                pembargo.sp                             */
/*      Stored procedure:       sp_pembargo                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Fecha de escritura:     03-Abr-2001                             */
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
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA           AUTOR            RAZON                              */
/*  02/02/2010     O. Usiña     Embargos Ahorros                        */
/*  04/May/2016    T. Baidal    Migracion a CEN                         */
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
           where  name = 'sp_pembargo')
    drop proc sp_pembargo
go

create proc sp_pembargo
(
  @s_ssn          int = null,
  @s_sesn         int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @o_registros    int = 0 output,
  @o_saldopdte    money = 0 output
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
    @w_cont                  tinyint,
    @w_cont1                 int

  --U2 V4
  select
    @w_sp_name = "sp_pembargo"

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

  select
    @w_fecha_proceso = fc_fecha_cierre
  from   cobis..ba_fecha_cierre
  where  fc_producto = 2

  select
    @w_lsrv = pa_char
  from   cl_parametro
  where  pa_nemonico = 'SRVR'
     and pa_producto = 'ADM'

  select
    @w_numdeciimp = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'DCI'

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

  begin tran
  update cobis..ba_secuencial
  set    se_numero = @w_sec + 1000

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @i_num = 205031 /* Error en actualizacion de SSN */
    return 205031
  end
  commit tran

  /** LECTURA DE EMBARGOS PENDIENTES **/

  delete cobis..embargo_tmp

  insert into cobis..embargo_tmp
              (ente,secuencial,saldo_pdte,debita_cta,oficio,
               solicitante,demandante,fecha_ofi,monto,oficina,
               cuenta_especifica,nro_cta_especifica,producto,concepto,juzgado,
               oficina_des,tipo_doc_dem,numero_doc_dem,nombre_dem,apellido_dem,
               mmi,procesada)
    select
      ca_ente,ca_secuencial,ca_saldo_pdte,ca_debita_cta,ca_oficio,
      ca_solicitante,ca_demandante,ca_fecha_ofi,ca_monto,ca_oficina,
      ca_cuenta_especifica,ca_nro_cta_especifica,ca_producto,ca_concepto,
      ca_juzgado,
      ca_oficina_destino,ca_tipo_doc_demandante,ca_numero_doc_demandante,
      ca_nombre_demandante,ca_apellido_demandante,
      isnull(ca_mmi,
             "MMINAP"),'N'
    from   cobis..cl_cab_embargo
    where  ca_tipo_proceso = 'B'
       and ca_estado       = 'P'
       and ca_saldo_pdte   > 0
       and ca_debita_cta   = 'S'
    order  by ca_ente,
              ca_fecha

  set rowcount 1
  select
    @w_ente = ente,
    @w_secuencial = secuencial,
    @w_saldo_pdte = saldo_pdte,
    @w_debita_cta = debita_cta,
    @w_oficio = oficio,
    @w_solicitante = solicitante,
    @w_demandante = demandante,
    @w_fecha_ofi = fecha_ofi,
    @w_monto = monto,
    @w_oficina = oficina,
    @w_cuenta_especifica = cuenta_especifica,
    @w_nro_cta_especifica = nro_cta_especifica,
    @w_producto_gral = producto,
    @w_concepto = concepto,
    @w_juzgado = juzgado,
    @w_oficina_destino = oficina_des,
    @w_tipo_doc_demandante = tipo_doc_dem,
    @w_numero_doc_demandante = numero_doc_dem,
    @w_nombre_demandante = nombre_dem,
    @w_apellido_demandante = apellido_dem,
    @w_mmi = mmi
  from   cobis..embargo_tmp
  where  procesada = 'N'
  order  by ente,
            secuencial

  if @@rowcount > 0
    select
      @w_cont1 = 1
  else
    select
      @w_cont1 = 0

  while @w_cont1 = 1
  begin
    set rowcount 0
    select
      @w_concepto1 = convert(tinyint, @w_concepto)
    select
      @w_ofi_des = convert(smallint, @w_oficina_destino)
    select
      @w_producto = @w_producto_gral

    /** CONSULTA DE PRODUCTOS DE CLIENTE **/
    exec @w_return = sp_con_gral_producto
      @i_cliente   = @w_ente,
      @t_trn       = 1422,
      @i_operacion = 'H',
      @i_tipo_mmi  = @w_mmi

    if @w_return <> 0
    begin
      select
        @w_error = @w_return
      goto SIGUIENTE
    end

    select
      @w_saldo = saldo
    from   productos_tmp2
    where  producto = @w_producto
       and cuenta   = @w_nro_cta_especifica

    /** Consulta nombre, apellido Tipo Ced, y Nro Doc Cliente **/
    select
      @w_nombre_demandado = en_nombre,
      @w_apellido_demandado = (p_p_apellido + ' ' + p_s_apellido),
      @w_tipo_doc_demandado = en_tipo_ced,
      @w_numero_doc_demandado = en_ced_ruc
    from   cobis..cl_ente
    where  en_ente = @w_ente

    if @w_cuenta_especifica = 'S'
    begin
      set rowcount 0
      /* Registrar el embargo */
      exec @w_return = sp_pembargo_esp
        @s_srv                   = @s_srv,
        @s_lsrv                  = @w_lsrv,
        @s_user                  = 'Embargos',
        @s_term                  = 'consola',
        @s_date                  = @w_fecha_proceso,
        @s_ofi                   = @w_oficina,
        @s_org                   = @s_org,
        @t_trn                   = 1423,
        @s_sesn                  = @w_sec,
        @i_producto              = @w_producto,
        @i_saldo                 = @w_saldo,
        @i_saldo_pdte            = @w_saldo_pdte,
        @i_nro_cta_especifica    = @w_nro_cta_especifica,
        @i_ente                  = @w_ente,
        @i_fecha_proceso         = @w_fecha_proceso,
        @i_oficina               = @w_oficina,
        @i_fecha_ofi             = @w_fecha_ofi,
        @i_oficio                = @w_oficio,
        @i_solicitante           = @w_solicitante,
        @i_demandante            = @w_demandante,
        @i_monto                 = @w_monto,
        @i_secuencial            = @w_secuencial,
        @i_sec_prod              = @w_sec_prod,
        @i_concepto1             = @w_concepto1,
        @i_juzgado               = @w_juzgado,
        @i_ofi_des               = @w_ofi_des,
        @i_interes               = @w_interes,
        @i_debita_cta            = @w_debita_cta,
        @i_tipo_doc_demandante   = @w_tipo_doc_demandante,
        @i_numero_doc_demandante = @w_numero_doc_demandante,
        @i_nombre_demandante     = @w_nombre_demandante,
        @i_apellido_demandante   = @w_apellido_demandante,
        @i_cuenta_especifica     = @w_cuenta_especifica,
        @i_apellido_demandado    = @w_apellido_demandado,
        @i_mmi                   = @w_mmi,
        @i_nombre_demandado      = @w_nombre_demandado

      if @w_return <> 0
      begin
        exec sp_errorlog
          @i_fecha       = @w_fecha_proceso,
          @i_error       = @w_return,
          @i_usuario     = 'misbatch',
          @i_tran        = 1423,
          @i_tran_name   = @w_sp_name,
          @i_cuenta      = @w_cuenta,
          @i_descripcion = 'Error retornado por el sp sp_pembargo_esp',
          @i_rollback    = 'S'
      end
      select
        @w_sec = @w_sec + 1
    end

    /* AFECTA CUENTAS ESPECIFICA NO */
    if @w_cuenta_especifica = 'N'
    begin
      /** AFECTACION A CUENTAS DE AHORROS**/
      if @w_producto_gral = "AHO"
          or @w_producto_gral is null
      begin
        set rowcount 1
        select
          @w_cuenta = cuenta,
          @w_saldo = saldo,
          @w_producto = producto
        from   productos_tmp2
        where  producto = 'AHO'
           and saldo    > 0
        order  by cuenta

        if @@rowcount > 0
          select
            @w_cont = 1
        else
          select
            @w_cont = 0

        while @w_cont = 1
        begin
          set rowcount 0
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
          --print "valor saldopendiente " + convert(varchar(20),@w_valor) + ' ' + convert(varchar(20),@w_saldo_pdte)
          end

          /* Registrar el embargo */
          exec @w_return = sp_embargo
            @s_ssn                   = @w_sec,
            @s_srv                   = @s_srv,
            @s_lsrv                  = @w_lsrv,
            @s_user                  = 'Embargos',
            @s_term                  = 'consola',
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
            @i_autorizante           = 'Embargos',
            @i_monto_emb             = @w_valor,
            @i_estado_lev            = 'N',
            @i_num_cta               = @w_cuenta,
            @i_secuencial            = @w_secuencial,
            @i_sec_modulo            = @w_sec_prod,
            @i_oficina               = @w_oficina,
            @i_producto              = @w_producto,
            @i_observacion           = 'COBRO POR BATCH AHO NESP',
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
            print "rechazo embargo en pembargo"
            exec sp_errorlog
              @i_fecha       = @w_fecha_proceso,
              @i_error       = @w_return,
              @i_usuario     = 'misbatch',
              @i_tran        = 1423,
              @i_tran_name   = @w_sp_name,
              @i_cuenta      = @w_cuenta,
              @i_descripcion = 'Error retornado por el sp sp_pembargo aho nesp',
              @i_rollback    = 'S'
          end

          select
            @w_sec = @w_sec + 1

          if @w_saldo_pdte > 0
          begin
            set rowcount 1
            select
              @w_cuenta = cuenta,
              @w_saldo = saldo,
              @w_producto = producto
            from   productos_tmp2
            where  producto = 'AHO'
               and saldo    > 0
               and cuenta   > @w_cuenta
            order  by cuenta
            if @@rowcount > 0
              select
                @w_cont = 1
            else
              select
                @w_cont = 0
          end
          else
            break
        end -- while

        if @w_saldo_pdte = 0
          /* Agregar control de error */
          goto SIGUIENTE
      end -- Ahorros
    end --if @w_cuenta_especifica = 'N'

    SIGUIENTE:
    update cobis..embargo_tmp
    set    procesada = 'S'
    where  ente       = @w_ente
       and secuencial = @w_secuencial

    select
      @w_ente_aux = @w_ente
    select
      @o_registros = @o_registros + 1

    set rowcount 1
    select
      @w_ente = ente,
      @w_secuencial = secuencial,
      @w_saldo_pdte = saldo_pdte,
      @w_debita_cta = debita_cta,
      @w_oficio = oficio,
      @w_solicitante = solicitante,
      @w_demandante = demandante,
      @w_fecha_ofi = fecha_ofi,
      @w_monto = monto,
      @w_oficina = oficina,
      @w_cuenta_especifica = cuenta_especifica,
      @w_nro_cta_especifica = nro_cta_especifica,
      @w_producto_gral = producto,
      @w_concepto = concepto,
      @w_juzgado = juzgado,
      @w_oficina_destino = oficina_des,
      @w_tipo_doc_demandante = tipo_doc_dem,
      @w_numero_doc_demandante = numero_doc_dem,
      @w_nombre_demandante = nombre_dem,
      @w_apellido_demandante = apellido_dem,
      @w_mmi = mmi
    from   cobis..embargo_tmp
    where  procesada = 'N'
    order  by ente,
              secuencial
    if @@rowcount > 0
      select
        @w_cont1 = 1
    else
      select
        @w_cont1 = 0

  end -- While embargos

  return 0

go

