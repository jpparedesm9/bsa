/************************************************************************/
/*   Archivo:             saldos_cli.sp                                 */
/*   Stored procedure:    sp_saldos_req_880                             */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Elcira Pelaez                                 */
/*   Fecha de escritura:  Julio-2005                                    */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*  retornar a front-end los saldos de las cuentas , creditos o cdts    */
/* que tiene un cliente                                                 */
/*                                                                      */
/************************************************************************/
/*                             MODIFICACIONES                           */
/*                                                                      */
/*    FECHA             AUTOR              RAZON                        */
/*  05/May/2016  T. Baidal     Migracion a CEN                          */
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
           where  name = 'sp_saldos_req_880')
           drop proc sp_saldos_req_880
go

create proc sp_saldos_req_880
(
  @s_ssn           int = null,
  @s_ssn_branch    int = null,
  @s_rol           smallint = 1,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_ofi           smallint = null,
  @s_org           char(1) = null,
  @s_sesn          int = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_modo          tinyint = null,
  @i_producto      char(3) = null,
  @i_cliente       int = null,
  @i_forma_pago    tinyint = null,
  @i_operacion     char(1) = null,
  @i_cobro         char(1) = null,
  @i_tipo_ser      catalogo = null,
  @i_cuenta        cuenta = null,
  @i_tipo          char(1) = 'C',
  @i_filial        tinyint = 1,
  @i_turno         smallint = null,
  @i_formato_fecha int = null
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(32),
    @w_error            int,
    @w_ref              char(1),
    @w_causal           catalogo,
    @w_valor            money,
    @w_prod_cta         tinyint,
    @w_servicio         descripcion,
    @w_exento           char(1),
    @w_ciudad_oficina   int,
    @w_lugar_doc        int,
    @w_cuenta           int,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_categoria        char(1),
    @w_tipo_ente        char(1),
    @w_rol_ente         char(1),
    @w_oficina_cta      smallint,
    @w_tipo_def         char(1),
    @w_prod_banc        smallint,
    @w_moneda           tinyint,
    @w_default          int,
    @w_producto         tinyint,
    @w_disponible       money,
    @w_personalizada    char(1),
    @w_promedio1        money,
    @w_tipocta_super    char(1),
    @w_valor_cobro      money,
    @w_mensaje          mensaje,
    -- REQ 250 CERTIFICACIONES
    @w_ref_efectivo     int,
    @w_num_orden        int

  --U2 V3
  select
    @w_sp_name = 'sp_saldos_req_880'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  ---VALIDAR LAS REFERENCIAS DEL CLIENTE
  select
    @w_ref = en_mala_referencia
  from   cobis..cl_ente
  where  en_ente = @i_cliente
  if @w_ref = 'S'
  begin
    select
      @w_error = 201107,
      @w_mensaje = 'CLIENTE CON MALA REFERENCIA'
    goto ERROR
  end

  if @s_date is null
    select
      @s_date = convert(char(12), fp_fecha, 101)
    from   cobis..ba_fecha_proceso

  --SE LIMPIAN LOS DATOS DEL USUARIO EL CLIENTE y EL PRODUCTO
  delete cl_productoxcli_cer_ref
  where  crc_usuario = @s_user
     and crc_cliente = @i_cliente
     and crc_modulo  = @i_producto

  if @i_operacion = 'V' -- Valores para impresion
  begin
    --CORRIENTES
    if @i_producto = 'CTE'
    begin
      insert into cl_productoxcli_cer_ref
        select
          @s_user,@i_cliente,@i_producto,cc_cta_banco,(select
             substring(valor,
                       1,
                       15)
           from   cobis..cl_catalogo C,cobis..cl_tabla T
           where  T.tabla  = 'cc_estado_cta'
              and T.codigo = C.tabla
              and C.codigo = cc_estado),
          convert(char(12), cc_fecha_aper, 101),
          convert(char(12), cc_fecha_ult_upd
          ,
          101)
          ,cc_moneda,cc_embargada_ilim,cc_embargada_fijo,
          round((cc_12h + cc_24h + cc_48h + cc_remesas + cc_disponible) *
                cv_valor
          ,
                0),round(((cc_promedio1 + cc_promedio2 + cc_promedio3 +
                           cc_promedio4
                           +
                           cc_promedio5
                           +
                                  cc_promedio6) / 6) * cv_valor,
                0),cc_ctacte,0,convert(char(10), cc_bloqueos),
          (select
             C.valor
           from   cobis..cl_catalogo C,cobis..cl_tabla T
           where  C.tabla  = T.codigo
              and T.tabla  = 'cl_oficina'
              and C.codigo = convert(varchar, cc_oficina))
        from   cobis..cl_det_producto,
               cobis..cl_cliente,
               cobis..cl_ente,
               cob_cuentas..cc_ctacte x,
               cob_conta..cb_vcotizacion
        where  cl_det_producto = dp_det_producto
           and dp_cuenta       = cc_cta_banco
           and cl_cliente      = en_ente
           and dp_producto     = 3 -- CTA CTE
           and cc_cliente      = @i_cliente
           and cl_rol in ('T', 'C')
           and cc_moneda       = cv_moneda
           and cv_fecha        = (select
                                    max(cv_fecha)
                                  from   cob_conta..cb_vcotizacion
                                  where  cv_moneda = x.cc_moneda
                                     and cv_fecha  <= @s_date)
        order  by cc_ctacte

      if exists(select
                  1
                from   cobis..cl_productoxcli_cer_ref
                where  crc_usuario = @s_user
                   and crc_modulo  = @i_producto
                   and crc_estado  = 'CANCELADA'
                   and crc_cliente = @i_cliente)
      --Actualizar la fecha cierre de estas cuentas
      begin
        update cobis..cl_productoxcli_cer_ref
        set    crc_fecha_fin = hc_fecha
        from   cob_cuentas..cc_his_cierre,
               cobis..cl_productoxcli_cer_ref
        where  crc_oper_interna = hc_cuenta
           and crc_usuario      = @s_user
           and crc_modulo       = @i_producto
           and crc_estado       = 'CANCELADA'
           and crc_cliente      = @i_cliente
      end -- actualizar la fecha cierre

    end --cuentas

    --AHORROS

    if @i_producto = 'AHO'
    begin
      insert into cl_productoxcli_cer_ref
        select
          @s_user,@i_cliente,@i_producto,ah_cta_banco,(select
             substring(valor,
                       1,
                       15)
           from   cobis..cl_catalogo C,cobis..cl_tabla T
           where  T.tabla  = 'ah_estado_cta'
              and T.codigo = C.tabla
              and C.codigo = ah_estado),
          convert(char(12), ah_fecha_aper, 101),
          convert(char(12), ah_fecha_ult_upd
          ,
          101)
          ,ah_moneda,ah_monto_emb,ah_monto_bloq,
          round((ah_12h + ah_24h + ah_48h + ah_remesas + ah_disponible) *
                cv_valor
          ,
                0),round(((ah_promedio1 + ah_promedio2 + ah_promedio3 +
                           ah_promedio4
                           +
                           ah_promedio5
                           +
                                  ah_promedio6) / 6) * cv_valor,
                0),ah_cuenta,0,convert(char(10), ah_bloqueos),
          (select
             C.valor
           from   cobis..cl_catalogo C,cobis..cl_tabla T
           where  C.tabla  = T.codigo
              and T.tabla  = 'cl_oficina'
              and C.codigo = convert(varchar, ah_oficina))
        from   cobis..cl_det_producto,
               cobis..cl_cliente,
               cobis..cl_ente,
               cob_ahorros..ah_cuenta x,
               cob_conta..cb_vcotizacion
        where  cl_det_producto = dp_det_producto
           and dp_cuenta       = ah_cta_banco
           and cl_cliente      = en_ente
           and dp_producto     = 4 -- AHORROS
           and cl_cliente      = @i_cliente
           and cl_rol in ('T', 'C')
           and cv_moneda       = ah_moneda
           and cv_fecha        = (select
                                    max(cv_fecha)
                                  from   cob_conta..cb_vcotizacion
                                  where  cv_moneda = ah_moneda
                                     and cv_fecha  <= @s_date)
        order  by ah_cuenta

      if exists(select
                  1
                from   cobis..cl_productoxcli_cer_ref
                where  crc_usuario = @s_user
                   and crc_modulo  = @i_producto
                   and crc_estado  = 'CANCELADA'
                   and crc_cliente = @i_cliente)
      --Actualizar la fecha cierre de estas cuentas
      begin
        update cobis..cl_productoxcli_cer_ref
        set    crc_fecha_fin = hc_fecha
        from   cob_ahorros..ah_his_cierre,
               cobis..cl_productoxcli_cer_ref
        where  crc_oper_interna = hc_cuenta
           and crc_usuario      = @s_user
           and crc_modulo       = @i_producto
           and crc_estado       = 'CANCELADA'
           and crc_cliente      = @i_cliente
      end -- actualizar la fecha cierre

    end --ahorros

    -- CDT
    if @i_producto = 'PFI'
    begin
      insert into cl_productoxcli_cer_ref
        select
          @s_user,@i_cliente,@i_producto,op_num_banco,(select
             substring(valor,
                       1,
                       15)
           from   cobis..cl_catalogo C,cobis..cl_tabla T
           where  T.tabla  = 'pf_estado'
              and T.codigo = C.tabla
              and C.codigo = op_estado),
          convert(char(12), op_fecha_crea, 101),convert(char(12), op_fecha_ven,
          101)
          ,
          op_moneda,null,null,
          round((op_monto) * cv_valor,
                0),0,op_operacion,0,op_bloqueo_legal,
          (select
             C.valor
           from   cobis..cl_catalogo C,cobis..cl_tabla T
           where  C.tabla  = T.codigo
              and T.tabla  = 'cl_oficina'
              and C.codigo = convert(varchar, op_oficina_apertura))
        from   cobis..cl_ente,
               cobis..cl_cliente,
               cobis..cl_det_producto,
               cob_pfijo..pf_operacion,
               cob_pfijo..pf_beneficiario,
               cob_conta..cb_vcotizacion
        where  cl_det_producto = dp_det_producto
           and cl_cliente      = en_ente
           and dp_producto     = 14 -- CDT
           and cl_cliente      = be_ente
           and cl_rol in ('T', 'A')
           and dp_cuenta       = op_num_banco
           and op_operacion    = be_operacion
           and be_ente         = @i_cliente
           and op_moneda       = cv_moneda
           and be_estado       = 'I'
           and be_estado_xren  = 'N'
           and cv_fecha        = (select
                                    max(cv_fecha)
                                  from   cob_conta..cb_vcotizacion
                                  where  cv_moneda = op_moneda
                                     and cv_fecha  <= @s_date)
        order  by op_operacion

    end---plazo fijo

    --CARTERA

    if @i_producto = 'CCA'
    begin
      insert into cl_productoxcli_cer_ref
        select
          @s_user,@i_cliente,@i_producto,op_banco,substring(es_descripcion,
                    1,
                    15),
          convert(char(12), op_fecha_liq, 101),convert(char(12), op_fecha_fin,
          101
          ),
          op_moneda,valor,isnull(op_calificacion,
                 'A'),
          round(op_monto * cv_valor,
                0),0,op_operacion,0,isnull(op_estado_cobranza,
                 'NR'),
          (select
             C.valor
           from   cobis..cl_catalogo C,cobis..cl_tabla T
           where  C.tabla  = T.codigo
              and T.tabla  = 'cl_oficina'
              and C.codigo = convert(varchar, op_oficina))
        from   cob_cartera..ca_operacion x,
               cob_conta..cb_vcotizacion,
               cob_cartera..ca_estado,
               cobis..cl_catalogo a,
               cobis..cl_tabla b
        where  (op_cliente = @i_cliente)
           and (op_moneda = cv_moneda)
           and (op_estado = es_codigo)
           and (op_estado in(1, 2, 3, 4,
                             5, 9, 10))
           and (b.tabla = 'ca_toperacion')
           and (b.codigo = a.tabla)
           and (op_toperacion = a.codigo)
           and (op_naturaleza = 'A')
           and (cv_fecha = (select
                              max(cv_fecha)
                            from   cob_conta..cb_vcotizacion
                            where  cv_moneda = x.op_moneda
                               and cv_fecha  <= @s_date))

      if exists (select
                   1
                 from   cobis..cl_productoxcli_cer_ref
                 where  crc_usuario = @s_user
                    and crc_cliente = @i_cliente
                    and crc_modulo  = @i_producto)
      begin
        update cobis..cl_productoxcli_cer_ref
        set    crc_dias_vto = isnull(do_dias_vto_div,
                                     0)
        from   cobis..cl_productoxcli_cer_ref
               left outer join cob_credito..cr_dato_operacion
                            on crc_oper_interna = do_numero_operacion
                               and do_estado_cartera in (1, 2, 4, 5,
                                                         9, 10)
                               and do_tipo_reg = 'D'
                               and do_codigo_producto = 7
        where  crc_usuario = @s_user
           and crc_modulo  = @i_producto
           and crc_cliente = @i_cliente

      /*** from cob_credito..cr_dato_operacion,
           cobis..cl_productoxcli_cer_ref
      where do_numero_operacion = * crc_oper_interna
      and   crc_usuario        = @s_user
      and   crc_modulo         = @i_producto
      and   do_estado_cartera  in (1,2,4,5,9,10)
      and   crc_cliente        = @i_cliente
      and   do_tipo_reg        = 'D'
      and   do_codigo_producto = 7 ****/
      end
    end --cartera

    if @i_producto in ('AHO', 'CTE')
    begin
      --Actualizar las fechas de cierre si existen cuentas cerradas para este cliente
      select
        'No.CUENTA' = crc_oper_externa,
        'ESTADO' = crc_estado,
        'FECHA-APERTURA' = convert(char(10), crc_fecha_ini, @i_formato_fecha),
        'FECHA-CIERRE' = case
                           when crc_estado = 'CANCELADA' then
                           convert(char(10), crc_fecha_fin, @i_formato_fecha)
                           else ''
                         end,
        'SALDO' = crc_valor,
        'PROMEDIO' = crc_promedio,
        'EMBARGADA-ILIM' = crc_opcion_a,
        'EMBARGADA-FIJO' = crc_opcion_b,
        'NUMERO DE BLOQUEOS' = crc_blq,
        'OFICINA PRODUCTO' = crc_oficina
      from   cl_productoxcli_cer_ref
      where  crc_usuario = @s_user
         and crc_cliente = @i_cliente
         and crc_modulo  = @i_producto
    end

    if @i_producto = 'PFI'
    begin
      select
        'No.CDT' = crc_oper_externa,
        'ESTADO' = crc_estado,
        'FECHA-APERTURA' = convert(char(12), crc_fecha_ini, @i_formato_fecha),
        'FECHA-VENCIMIENTO' = convert(char(12), crc_fecha_fin, @i_formato_fecha)
        ,
        'VALOR' = crc_valor,
        'BLOQUEO' = crc_blq,
        'OFICINA PRODUCTO' = crc_oficina
      from   cl_productoxcli_cer_ref
      where  crc_usuario = @s_user
         and crc_cliente = @i_cliente
         and crc_modulo  = @i_producto
    end

    if @i_producto = 'CCA'
    begin
      select
        'No.CREDITO' = crc_oper_externa,
        'ESTADO' = crc_estado,
        'FECHA-DESEMBOLSO' = convert(char(12), crc_fecha_ini, @i_formato_fecha),
        'FECHA-VENCIMIENTO' = convert(char(12), crc_fecha_fin, @i_formato_fecha)
        ,
        'LINEA CREDITO' = crc_opcion_a,
        'CALIFICACION' = substring(crc_opcion_b,
                                   1,
                                   2),
        'VALOR' = crc_valor,
        'DIAS VENCIDO' = crc_dias_vto,
        'ESTADO COBRANZA' = crc_blq,
        'OFICINA PRODUCTO' = crc_oficina
      from   cl_productoxcli_cer_ref
      where  crc_usuario = @s_user
         and crc_cliente = @i_cliente
         and crc_modulo  = @i_producto
    end
  end --operacion V

  if @i_operacion = 'C' -- Consulta de Cuentas
  begin
    --CORRIENTES
    if @i_producto = 'CTE'
    begin
      select
        cc_cta_banco,
        cc_disponible
      from   cob_cuentas..cc_ctacte
      where  (cc_cliente = @i_cliente)
         and (cc_estado = 'A')
         and (cc_disponible > 0)
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101127
        return 101127 /*'No existe Cuenta'*/
      end
    end --corrientes

    --AHORROS
    if @i_producto = 'AHO'
    begin
      select
        ah_cta_banco,
        ah_disponible
      from   cob_ahorros..ah_cuenta
      where  (ah_cliente = @i_cliente)
         and (ah_estado = 'A')
         and (ah_disponible > 0)
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101127
        return 101127 /*'No existe Cuenta'*/
      end
    end --ahorros
  end --operacion C

  if @i_operacion = 'Q' -- Query de Ciudades
  begin
    if @i_tipo = 'C'
    begin
      -- Seleccion de la ciudad de expedicion del documento de Identidad,
      -- y la ciudad de expedicion del Certificado o Referencia

      select
        @w_ciudad_oficina = of_ciudad
      from   cl_oficina
      where  of_oficina = @s_ofi

      select
        @w_lugar_doc = p_lugar_doc
      from   cl_ente
      where  en_ente = @i_cliente

      select
        ci_descripcion,
        (select
           ci_descripcion
         from   cl_ciudad
         where  ci_ciudad = @w_ciudad_oficina)
      from   cl_ciudad
      where  ci_ciudad = case
                           when @w_lugar_doc is not null then @w_lugar_doc
                           else @w_ciudad_oficina
                         end
    end
  /*
     if @i_tipo = 'B'
     begin
        if @i_tipo_ser = '003'
        begin
           -- valor a cobrar por certificaciones
           select pa_money
           from   cobis..cl_parametro
           where  pa_producto = 'ADM'
           and    pa_nemonico = 'VALCER'
        end
        if @i_tipo_ser = '026'
        begin
           -- valor a cobrar por referencias
           select pa_money
           from   cobis..cl_parametro
           where  pa_producto = 'ADM'
           and    pa_nemonico = 'VALREF'
        end
     end
  */
  end --operacion Q

  if @i_operacion = 'I'
  begin -- Insertar cobros
    if @i_forma_pago = 26
    begin
      /*** REGISTRO ORDEN DE COBRO EN EFECTIVO ***/
      if @i_producto = 'AHO'
      begin
        select
          @w_ref_efectivo = ah_cuenta
        from   cob_ahorros..ah_cuenta
        where  ah_cta_banco = @i_cuenta
      end

      if @i_producto = 'CCA'
      begin
        select
          @w_ref_efectivo = op_operacion
        from   cob_cartera..ca_operacion
        where  op_banco = @i_cuenta
      end

      if @i_producto = 'PFI'
      begin
        select
          @w_ref_efectivo = op_operacion
        from   cob_pfijo..pf_operacion
        where  op_num_banco = @i_cuenta
      end

      begin tran

      select
        @w_valor = ci_costo
      from   cob_cuentas..cc_causa_ingegr
      where  ci_tipo   = 'I'
         and ci_causal = '015'

      /* Invoca interfaz otros modulos y marca estado orden */
      exec @w_return = cob_remesas..sp_genera_orden
        @s_date      = @s_date,--> Fecha de proceso
        @s_user      = @s_user,--> Usuario
        @i_ofi       = @s_ofi,--> Oficina de la transaccion
        @i_operacion = 'I',--> Operacion ('I' -> Insercion, 'A' Anulaci¾n)
        @i_causa     = '015',
        --Ref. Clientes  -- @i_causa, --> Causal de Ingreso(cc_causa_oioe)
        @i_ente      = @i_cliente,--> Cod ente,
        @i_valor     = @w_valor,--> Valor,
        @i_tipo      = 'C',
        --> 'C' -> Orden de Cobro/Ingreso, 'P' -> Orden de Pago/Egreso
        @i_idorden   = null,--> C¾d Orden cuando operaci¾n 'A',
        @i_ref1      = 2935,--> Codigo Transaccion pagos certificaciones
        @i_ref2      = @i_cliente,--> Codigo Cliente pagos certificaciones
        @i_ref3      = @i_cuenta,--> Ref. AlfaN·merica no oblicatoria
        @i_interfaz  = 'N',
        --> 'N' - Invoca sp_cerror, 'S' - Solo devuelve c¾d error
        @o_idorden   = @w_num_orden out
      --> Devuelve c¾d orden de pago/cobro generada - Operaci¾n 'I'

      if @@error <> 0
          or @w_return <> 0
      begin
        if @w_return <> 0
          return @w_return
        /* Error en creacion de registro en ah_his_cierre */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end

      exec @w_return = cobis..sp_orden_cobro_cer_ref
        @t_trn       = 2934,
        @i_operacion = 'I',
        @i_cliente   = @i_cliente,
        @i_idorden   = @w_num_orden,
        @i_modulo    = @i_producto,
        @i_cuenta    = @i_cuenta,
        @i_modo      = 'A'
      if @w_return <> 0
          or @@error <> 0
      begin
        /* Error insertando orden de cobro certificacion*/
        select
          @w_error = 2903195
        goto ERROR
      end

      commit tran

    end

    if @i_forma_pago = 4
    begin
      /* SOLO PARA DEBITOS DE CUENTAS DE AHORROS */
      select
        @w_cuenta = ah_cuenta,
        @w_categoria = ah_categoria,
        @w_tipo_ente = ah_tipocta,
        @w_rol_ente = ah_rol_ente,
        @w_tipo_def = ah_tipo_def,
        @w_prod_banc = ah_prod_banc,
        @w_moneda = ah_moneda,
        @w_default = ah_default,
        @w_disponible = ah_disponible,
        @w_personalizada = ah_personalizada,
        @w_promedio1 = ah_promedio1,
        @w_tipocta_super = ah_tipocta_super,
        @w_oficina_cta = ah_oficina,
        @w_producto = ah_producto
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cuenta

      if @@rowcount <> 1
      begin
        /* No existe cuenta_banco */
        select
          @w_mensaje = 'No existe la cuenta de la que se quiere debitar'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251001,
          @i_sev   = 1,
          @i_msg   = @w_mensaje
        return 1
      end

      /* Calcular el saldo */
      exec @w_return = cob_ahorros..sp_ahcalcula_saldo
        @t_debug            = @t_debug,
        @t_file             = @t_file,
        @t_from             = @w_sp_name,
        @i_cuenta           = @w_cuenta,
        @i_fecha            = @s_date,
        @o_saldo_para_girar = @w_saldo_para_girar out,
        @o_saldo_contable   = @w_saldo_contable out
      if @w_return <> 0
        return @w_return

      /* Encuentra el costo por solicitud certificado o referencia de cuenta on line */
      exec @w_return = cob_remesas..sp_genera_costos
        @s_srv         = @s_srv,
        @s_ofi         = @s_ofi,
        @s_ssn         = @s_ssn,
        @s_user        = @s_user,
        @i_filial      = @i_filial,
        @i_oficina     = @w_oficina_cta,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipo_ente,
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_def,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @w_producto,
        @i_moneda      = @w_moneda,
        @i_tipo        = 'R',
        @i_codigo      = @w_default,
        @i_servicio    = 'CCER',
        @i_rubro       = '3',
        @i_fecha       = @s_date,
        @i_disponible  = @w_disponible,--@w_sldtmp1,
        @i_personaliza = @w_personalizada,
        @i_contable    = @w_saldo_contable,
        @i_promedio    = @w_promedio1,
        @o_valor_total = @w_valor_cobro out

      /* Inicio de la transaccion debito */
      begin tran
      if @w_valor_cobro > 0
      begin
        /* Generacion de la Nota de Debito */
        exec @w_return = cob_ahorros..sp_ahndc_automatica
          @s_srv        = @s_srv,
          @s_ofi        = @s_ofi,
          @s_ssn        = @s_ssn,
          @s_ssn_branch = @s_ssn_branch,
          @s_rol        = @s_rol,
          @s_user       = @s_user,
          @s_term       = @s_term,
          @t_trn        = 264,
          @i_cta        = @i_cuenta,
          @i_val        = @w_valor_cobro,
          @i_cau        = '11',--comision por referencias bancarias
          @i_mon        = @w_moneda,
          @i_alt        = 10,
          @i_fecha      = @s_date,
          @i_imp        = 'S',
          @i_turno      = @i_turno,
          @i_cobiva     = 'S'
        if @w_return <> 0
        begin
          select
            @w_mensaje = 'Error al genera la nota de debito por cobro'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 203078,
            @i_sev   = 1,
            @i_msg   = @w_mensaje
          return @w_return
        end
      end
      commit tran

      exec @w_return = cobis..sp_orden_cobro_cer_ref
        @t_trn       = 2934,
        @i_operacion = 'I',
        @i_cliente   = @i_cliente,
        @i_idorden   = @s_ssn,
        @i_modulo    = @i_producto,
        @i_cuenta    = @i_cuenta,
        @i_modo      = 'M'
      if @w_return <> 0
          or @@error <> 0
      begin
        /* Error insertando orden de Impresion*/
        select
          @w_error = 2903195,
          @w_mensaje = 'Error Insertando Orden de Impresion'
        goto ERROR
      end
    end -- producto ahorros
  end --operacion I

  return 0

  ERROR:
  exec cobis..sp_cerror
    @t_debug ='N',
    @t_file  = null,
    @t_from  = @w_sp_name,
    @i_num   = @w_error,
    @i_msg   = @w_mensaje

go

