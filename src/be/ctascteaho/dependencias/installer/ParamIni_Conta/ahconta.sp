/********************************************************************/
/*  Archivo:            ahconta.sp                                  */
/*  Stored procedure:   sp_conta                                    */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Ahorros                                     */
/*  Fecha de escritura: 08-Jun-2005                                 */
/*  Disenado por:       Fabian de la Torre (Marzo 2010)             */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                        PROPOSITO                                 */
/*  Contabilizacion automatica de transacciones de Ctas.Ahorros     */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA         AUTOR           RAZON                             */
/*  03/May/2016   J. Salazar      Migracion COBIS CLOUD MEXICO      */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_conta')
  drop proc sp_conta
go

/****** Object:  StoredProcedure [dbo].[sp_conta]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_conta
  @t_show_version bit = 0,
  @i_debug        char(1) = 'N'
as
  declare
    @w_error           int,
    @w_ar_origen       int,
    @w_asiento         int,
    @w_comprobante     int,
    @w_oficina_orig    smallint,
    @w_oficina_dest    smallint,
    @w_re_oficina_orig smallint,
    @w_re_oficina_dest smallint,
    @w_fecha_proceso   smalldatetime,
    @w_fecha_hasta     smalldatetime,
    @w_fecha_mov       smalldatetime,
    @w_mensaje         varchar(255),
    @w_descripcion     varchar(255),
    @w_sp_name         descripcion,
    @w_perfil          varchar(10),
    @w_debito          money,
    @w_credito         money,
    @w_debito_me       money,
    @w_credito_me      money,
    @w_estado_prod     char(1),
    @w_cod_producto    tinyint,
    @w_commit          char(1),
    @w_trn             varchar(10),
    @w_rows            int,
    @w_err             int

  /* VARIABLES DE TRABAJO */
  select
    @w_sp_name = 'ahorros..sp_conta',
    @w_mensaje = '',
    @w_estado_prod = '',
    @w_cod_producto = 4,
    @w_error = 0,
    @w_commit = 'N'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* DETERMINAR FECHA PROCESO */
  select
    @w_fecha_proceso = fc_fecha_cierre
  from   cobis..ba_fecha_cierre with (nolock)
  where  fc_producto = @w_cod_producto

  /********** MANEJO DE LAS EXECPCIONES DE LOS PERFILES DE REMESAS ****************/
  begin tran
  update cob_remesas..re_trn_contable
  set    tc_perfil = pe_perfil_nuevo
  from   cob_remesas..re_perfil_exepcion
  where  tc_perfil   = pe_perfil
     and tc_concepto = pe_concepto

  if @@error <> 0
  begin
    select
      @w_mensaje = ' ERROR AL ACTUALIZAR LOS PERFILES CON EXEPCION'
    goto ERRORFIN
  end

  commit tran

  exec cob_ccontable..sp_errorcconta
    @t_trn       = 60025,
    @i_operacion = 'D',
    @i_empresa   = 1,
    @i_fecha     = @w_fecha_proceso,
    @i_producto  = @w_cod_producto

  /* SELECCION DEL AREA DE AHORROS */
  select
    @w_ar_origen = pa_smallint
  from   cobis..cl_parametro with (nolock)
  where  pa_producto = 'AHO'
     and pa_nemonico = 'ACA'

  if @@rowcount = 0
  begin
    select
      @w_mensaje = 'NO ESTA DEFINIDA EL AREA CONTABLE PARA AHORROS',
      @w_error = 251091
    goto ERRORFIN
  end

  /* DETERMINAR EL ESTADO DE ADMISION DE COMPROBANTES CONTABLES EN COBIS CONTABILIDAD */
  select
    @w_estado_prod = pr_estado
  from   cob_conta..cb_producto with (nolock)
  where  pr_empresa  = 1
     and pr_producto = @w_cod_producto

  /* VALIDA EL PRODUCTO EN CONTABILIDAD */
  if @w_estado_prod not in ('V', 'E')
  begin
    select
      @w_error = 251092,
      @w_mensaje = 'NO ESTA DEFINIDA EL PRODUCTO DE AHORROS EN CONTABILIDAD'
    goto ERRORFIN
  end

  /* DETERMINAR EL RANGO DE FECHAS DE LAS TRANSACCIONES QUE SE INTENTARAN CONTABILIZAR */
  select
    @w_fecha_mov = isnull(min(co_fecha_ini),
                          '01/01/1900'),
    @w_fecha_hasta = isnull(max(co_fecha_ini),
                            '01/01/1900')
  from   cob_conta..cb_corte with (nolock)
  where  co_empresa = 1
     and co_estado in ('A', 'V')

  if @w_fecha_mov = '01/01/1900'
  begin
    select
      @w_error = 251093,
      @w_mensaje = 'NO EXISTEN PERIODOS DE CORTE ABIERTOS EN CONTABILIDAD'
    goto ERRORFIN
  end

  if @i_debug = 'S'
  begin
    print '--> sp_conta. Fecha Conta ' + cast(@w_fecha_mov as varchar)
    print '--> sp_conta. Fecha Hasta ' + cast(@w_fecha_hasta as varchar)
  end

  /* DETERMINAR EL UNIVERSO DE COMPROBANTES A CONTABILIZAR */
  select distinct
    fecha = tc_fecha,
    ofic_dest = tc_ofic_dest,
    ofic_orig = tc_ofic_orig,
    perfil = tc_perfil,
    producto = tc_producto,
    trn = tc_tipo_tran
  into   #comprobantes
  from   cob_remesas..re_trn_contable -- (index = idx1)
  where  tc_fecha between @w_fecha_mov and @w_fecha_hasta
     and tc_estado in ('ING', 'ERR')
     and tc_producto = @w_cod_producto
  order  by tc_fecha,
            tc_ofic_dest,
            tc_ofic_orig,
            tc_perfil,
            tc_producto,
            tc_tipo_tran

  if @@error <> 0
  begin
    select
      @w_mensaje = ' ERROR AL DETERMINAR EL UNIVERSO DE COMPROBANTES A GENERAR '
    goto ERRORFIN
  end

  create index idx1
    on #comprobantes(fecha, ofic_dest, ofic_orig, perfil, producto, trn )

  /* DESARROLLAR LA TABLA DE CUENTAS QUE SE USARAN EN EL DEBITO */
  select
    perfil = dp_perfil,
    tclave = pa_stored,
    clave = re_clave,
    cuenta = re_substring,
    area = isnull(ta_area,
                  0),
    origen_dest = re_origen_dest,
    debcred = dp_debcred
  into   #perfil_contable
  from   cob_conta..cb_det_perfil,
         cob_conta..cb_parametro,
         cob_conta..cb_relparam,
         cob_conta..cb_tipo_area
  where  dp_empresa   = 1
     and dp_producto  = @w_cod_producto
     and dp_cuenta    = pa_parametro
     and pa_parametro = re_parametro
     and re_tipo_area = ta_tiparea
     and dp_empresa   = ta_empresa
     and dp_producto  = ta_producto
     and 1            = 2

  if @@error <> 0
  begin
    select
      @w_mensaje = ' ERROR AL CREAR TABLA TEMPORAL #perfil_contable'
    goto ERRORFIN
  end

  create index idx1
    on #perfil_contable(perfil, tclave, clave)

  insert into #perfil_contable
    select
      perfil = dp_perfil,tclave = pa_stored,clave = re_clave,cuenta =
      re_substring
      ,
      area = isnull(ta_area,
                    0),
      origen_dest = re_origen_dest,debcred = dp_debcred
    from   cob_conta..cb_det_perfil,
           cob_conta..cb_parametro,
           cob_conta..cb_relparam,
           cob_conta..cb_tipo_area
    where  dp_empresa   = 1
       and dp_producto  = @w_cod_producto
       and dp_cuenta    = pa_parametro
       and pa_parametro = re_parametro
       and re_tipo_area = ta_tiparea
       and dp_empresa   = ta_empresa
       and dp_producto  = ta_producto
    union
    select
      perfil = dp_perfil,tclave = 'n/a',clave = 'n/a',cuenta = dp_cuenta,area =
      isnull(ta_area,
                    0),
      origen_dest = dp_origen_dest,debcred = dp_debcred
    from   cob_conta..cb_det_perfil,
           cob_conta..cb_tipo_area
    where  dp_empresa           = 1
       and dp_producto          = @w_cod_producto
       and dp_producto          = ta_producto
       and dp_area              = ta_tiparea
       and isnumeric(dp_cuenta) = 1

  if @@error <> 0
  begin
    select
      @w_mensaje = ' ERROR AL DESARROLLAR LOS PERFILES CONTABLES DEL PRODUCTO '
    goto ERRORFIN
  end

  if @i_debug = 'S'
    select
      *
    from   #perfil_contable

  /* LAZO PARA CONTABILIZAR CADA UNO DE LOS COMPROBANTES */
  while 1 = 1
  begin
    set rowcount 1

    select
      @w_fecha_mov = fecha,
      @w_oficina_dest = ofic_dest,
      @w_oficina_orig = ofic_orig,
      @w_perfil = perfil,
      @w_cod_producto = producto,
      @w_trn = convert(varchar(10), trn)
    from   #comprobantes
    order  by trn

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    set rowcount 0

    delete #comprobantes
    where  fecha     = @w_fecha_mov
       and ofic_dest = @w_oficina_dest
       and ofic_orig = @w_oficina_orig
       and perfil    = @w_perfil
       and producto  = @w_cod_producto
       and trn       = convert(smallint, @w_trn)

    /* DESCRIPCION DEL COMPROBANTE */
    select
      @w_mensaje = '',
      @w_error = 0,
      @w_descripcion = 'Pe:' + @w_perfil + ' ' + 'OO:' + convert(varchar,
                       @w_oficina_orig) + ' ' +
                       'OD:'
                       + convert(varchar, @w_oficina_dest)

    -- Oficina Contable
    select
      @w_re_oficina_orig = re_ofconta
    from   cob_conta..cb_relofi with (nolock)
    where  re_filial  = 1
       and re_empresa = 1
       and re_ofadmin = @w_oficina_orig

    if @@rowcount = 0
    begin
      select
        @w_mensaje = 'NO EXISTE CODIGO CONTABLE PARA LA OFICINA (ORIGEN):'
                     + convert(varchar, @w_oficina_orig)
      goto ERROR1
    end

    -- Oficina Contable
    select
      @w_re_oficina_dest = re_ofconta
    from   cob_conta..cb_relofi with (nolock)
    where  re_filial  = 1
       and re_empresa = 1
       and re_ofadmin = @w_oficina_dest

    if @@rowcount = 0
    begin
      select
        @w_mensaje = 'NO EXISTE CODIGO CONTABLE PARA LA OFICINA (DESTINO):'
                     + convert(varchar, @w_oficina_dest)
      goto ERROR1
    end

    if exists(select
                1
              from   sysobjects
              where  name = 'asiento_aho')
    begin
      select
        *
      from   asiento_aho
      exec('drop table asiento_aho')
      print ' Borro temporal'
    end

    -- Detalles por operacion
    select
      de_tran = @w_trn,
      de_secuencial = tc_secuencial,
      de_concepto = tc_concepto,
      de_moneda = tc_moneda,
      de_valor_base = tc_base,
      de_cuenta = cuenta,
      de_debcred = case
                     when tc_valor < 0
                          and debcred = '1' then '2'
                     when tc_valor < 0
                          and debcred = '2' then '1'
                     else debcred
                   end,
      de_area = area,
      de_oficina = case
                     when origen_dest = 'O' then @w_re_oficina_orig
                     when origen_dest = 'D' then @w_re_oficina_dest
                     else (select
                             isnull(ta_ofi_central,
                                    0)
                           from   cob_conta..cb_tipo_area
                           where  ta_empresa  = 1
                              and ta_producto = 4
                              and ta_area     = area)
                   end,
      de_cuenta_final = cuenta,
      de_debito = case
                    when tc_moneda = 0 then (case
                                               when tc_valor < 0
                                                    and debcred = '1' then 0
                                               when tc_valor < 0
                                                    and debcred = '2' then abs(
                                               tc_valor)
                                               when tc_valor > 0
                                                    and debcred = '2' then 0
                                               when tc_valor > 0
                                                    and debcred = '1' then abs(
                                               tc_valor)
                                             end)
                    else 0
                  end,
      de_debito_me = case
                       when tc_moneda <> 0 then (case
                                                   when tc_valor < 0
                                                        and debcred = '1' then 0
                                                   when tc_valor < 0
                                                        and debcred = '2' then
                                                   abs
                                                   (
                                                   tc_valor)
                                                   when tc_valor > 0
                                                        and debcred = '2' then 0
                                                   when tc_valor > 0
                                                        and debcred = '1' then
                                                   abs
                                                   (
                                                   tc_valor)
                                                 end)
                       else 0
                     end,
      de_credito = case
                     when tc_moneda = 0 then (case
                                                when tc_valor < 0
                                                     and debcred = '1' then abs(
                                                tc_valor)
                                                when tc_valor < 0
                                                     and debcred = '2' then 0
                                                when tc_valor > 0
                                                     and debcred = '2' then abs(
                                                tc_valor)
                                                when tc_valor > 0
                                                     and debcred = '1' then 0
                                              end)
                     else 0
                   end,
      de_credito_me = case
                        when tc_moneda <> 0 then (case
                                                    when tc_valor < 0
                                                         and debcred = '1' then
                                                    abs(
                                                    tc_valor)
                                                    when tc_valor < 0
                                                         and debcred = '2' then
                                                    0
                                                    when tc_valor > 0
                                                         and debcred = '2' then
                                                    abs(
                                                    tc_valor)
                                                    when tc_valor > 0
                                                         and debcred = '1' then
                                                    0
                                                  end)
                        else 0
                      end,
      de_cliente = tc_cliente,
      de_con_rete = case tc_tipo_impuesto
                      when 'R' then tc_concepto_imp
                      else null
                    end,
      de_valret = case tc_tipo_impuesto
                    when 'R' then tc_valor
                    else 0
                  end,
      de_con_ivareten = case tc_tipo_impuesto
                          when 'V' then tc_concepto_imp
                          else null
                        end,
      de_iva_retenido = case tc_tipo_impuesto
                          when 'V' then tc_valor
                          else 0
                        end,
      de_con_ica = case tc_tipo_impuesto
                     when 'C' then tc_concepto_imp
                     else null
                   end,
      de_valor_ica = case tc_tipo_impuesto
                       when 'C' then tc_valor
                       else 0
                     end,
      de_con_dptales = case tc_tipo_impuesto
                         when 'E' then tc_concepto_imp
                         else null
                       end,
      de_valor_dptales = case tc_tipo_impuesto
                           when 'E' then tc_valor
                           else 0
                         end,
      de_con_iva = case tc_tipo_impuesto
                     when 'I' then tc_concepto_imp
                     else null
                   end,
      de_valor_iva = case tc_tipo_impuesto
                       when 'I' then tc_valor
                       else 0
                     end,
      de_con_timbre = case tc_tipo_impuesto
                        when 'T' then tc_concepto_imp
                        else null
                      end,
      de_valor_timbre = case tc_tipo_impuesto
                          when 'T' then tc_valor
                          else 0
                        end,
      de_con_ivapagado = case tc_tipo_impuesto
                           when 'P' then tc_concepto_imp
                           else null
                         end,
      de_valor_ivapagado = case tc_tipo_impuesto
                             when 'P' then tc_valor
                             else 0
                           end,
      de_tclave = tclave,-- verificar
      de_clave = clave,
      identity(int,
               1,
               1) as de_asiento
    into   cob_ahorros..asiento_aho
    from   cob_remesas..re_trn_contable,
           #perfil_contable --(index = idx1)
    where  tc_fecha     = @w_fecha_mov
       and tc_ofic_dest = @w_oficina_dest
       and tc_ofic_orig = @w_oficina_orig
       and tc_perfil    = @w_perfil
       and tc_producto  = @w_cod_producto
       and tc_perfil    = perfil
       and tc_estado in ('ING', 'ERR')
       and clave           = case tclave
                               when 'sp_ah01_pf' then convert(varchar,tc_moneda) +'.'+ tc_clase_clte +'.'+ convert(varchar,tc_prod_banc)+'.'+ tc_estcta
                               when 'sp_ah02_pf' then convert(varchar,tc_moneda) +'.'+ tc_concepto
                               when 'sp_ah03_pf' then convert(varchar,tc_moneda) +'.'+ tc_estcta
                               when 'sp_ah04_pf' then convert(varchar,tc_moneda) +'.'+ tc_clase_clte +'.'+ convert(varchar,tc_prod_banc)+'.'+ tc_estcta +'.'+ tc_concepto
                               when 'sp_ah05_pf' then convert(varchar,tc_moneda) +'.'+ tc_clase_clte +'.'+ tc_estcta
			       when 'sp_ah06_pf' then convert(varchar,tc_moneda) +'.'+ convert(varchar,tc_prod_banc)+'.'+ tc_estcta
                               else 'n/a' 
                            end
       and tc_tipo_tran = @w_trn

    select
      @w_rows = @@rowcount,
      @w_err = @@error

    if @w_err <> 0
    begin
      select
        @w_mensaje =
        ' ERROR AL GENERAR LOS ASIENTOS CONTABLES EN LA TABLA asiento_aho '
      goto ERROR1
    end

    if @w_rows = 0
    begin
      select
        @w_mensaje = ' ERROR NO EXISTE PARAMETRIZACION CONTABLE '
      goto ERROR1
    end

    if @i_debug = 'S'
      select
        *
      from   cob_ahorros..asiento_aho

    /* Valores Debito y Credito Moneda Nacional */
    select
      @w_debito = isnull(sum(de_debito),
                         0),
      @w_credito = isnull(sum(de_credito),
                          0),
      @w_debito_me = isnull(sum(de_debito_me),
                            0),
      @w_credito_me = isnull(sum(de_credito_me),
                             0),
      @w_asiento = count(1)
    from   asiento_aho
    --   where (de_debito >= 0.01 or de_credito >= 0.01)

    if @w_debito <> @w_credito
    begin
      select
        @w_mensaje = ' ERROR, NO CUADRAN DEBITOS CON CREDITOS. Deb: ' + convert(
                     varchar
                            , @w_debito)
                     + ' Cre: ' + convert(varchar, @w_credito)
      goto ERROR1
    end

    if @w_debito_me <> @w_credito_me
    begin
      select
        @w_mensaje =
    ' ERROR, NO CUADRAN DEBITOS CON CREDITOS EN MONEDA EXTRANJERA . Deb: '
          + convert(varchar, @w_debito_me) + ' Cre: ' + convert(varchar,
                 @w_credito_me)
      goto ERROR1
    end

    exec @w_error = cob_conta..sp_cseqcomp
      @i_tabla     = 'cb_scomprobante',
      @i_empresa   = 1,
      @i_fecha     = @w_fecha_mov,
      @i_modulo    = @w_cod_producto,
      @i_modo      = 0,-- Numera por EMPRESA-FECHA-PRODUCTO
      @o_siguiente = @w_comprobante out

    if @w_error <> 0
    begin
      select
        @w_mensaje = ' ERROR AL GENERAR NUMERO COMPROBANTE (sp_cseqcomp)'
      goto ERROR1
    end
    print ' Comprobante :' + cast ( @w_comprobante as varchar)

    if @@trancount = 0
    begin
      select
        @w_commit = 'S'
      begin tran
    end

    if @w_asiento > 0
    begin
      /* INGRESA COMPROBANTE */
      insert into cob_conta_tercero..ct_scomprobante_tmp with (rowlock)
                  (sc_producto,sc_comprobante,sc_empresa,sc_fecha_tran,
                   sc_oficina_orig,
                   sc_area_orig,sc_digitador,sc_fecha_gra,sc_descripcion,
                   sc_perfil
                   ,
                   sc_detalles,sc_tot_debito,sc_tot_credito,
                   sc_tot_debito_me,
                   sc_tot_credito_me,
                   sc_automatico,sc_reversado,sc_estado,sc_mayorizado,
                   sc_observaciones
                   ,
                   sc_comp_definit,sc_usuario_modulo,sc_tran_modulo,
                   sc_error)
      values      ( @w_cod_producto,@w_comprobante,1,@w_fecha_mov,
                    @w_re_oficina_orig
                    ,
                    @w_ar_origen,@w_sp_name,
                    convert(char(10), getdate(), 101),
                    @w_descripcion,@w_perfil,
                    @w_asiento,@w_debito,@w_credito,@w_debito_me,@w_credito_me,
                    @w_cod_producto,'N','I','N',null,
                    null,'op_batch',@w_trn,'N')

      if @@error <> 0
      begin
        select
          @w_mensaje =
          'ERROR AL INSERTAR REGISTROS EN LA TABLA ct_scomprobante_tmp '
        goto ERROR1
      end
      set rowcount 1
      set rowcount 0

      /* INGRESA ASIENTO */
      insert into cob_conta_tercero..ct_sasiento_tmp with (rowlock)
                  (sa_producto,sa_fecha_tran,sa_comprobante,sa_empresa,
                   sa_asiento,
                   sa_cuenta,sa_oficina_dest,sa_area_dest,sa_credito,sa_debito,
                   sa_credito_me,sa_concepto,sa_debito_me,sa_cotizacion,
                   sa_tipo_doc,
                   sa_tipo_tran,sa_moneda,sa_opcion,sa_ente,sa_con_rete,
                   sa_base,sa_valret,sa_con_iva,sa_valor_iva,sa_iva_retenido,
                   sa_con_ica,sa_valor_ica,sa_con_timbre,sa_valor_timbre,
                   sa_con_iva_reten,
                   sa_con_ivapagado,sa_valor_ivapagado,sa_documento,
                   sa_mayorizado,
                   sa_con_dptales,
                   sa_valor_dptales,sa_posicion,sa_debcred,sa_oper_banco,
                   sa_cheque
                   ,
                   sa_doc_banco,sa_fecha_est,sa_detalle,sa_error
      )
        select
          @w_cod_producto,@w_fecha_mov,@w_comprobante,1,de_asiento,
          de_cuenta_final,de_oficina,de_area,de_credito,de_debito,
          0,@w_descripcion + ' Co:' + de_concepto + ' Se:' + convert(varchar,
          de_secuencial),0,1,'N',
          'A',0,0,de_cliente,de_con_rete,
          de_valor_base,de_valret,de_con_ivapagado,de_valor_iva,de_iva_retenido,
          de_con_ica,de_valor_ica,de_con_timbre,de_valor_timbre,de_con_ivareten,
          de_con_iva,de_valor_ivapagado,convert(varchar, de_cliente),'N',
          de_con_dptales,
          de_valor_dptales,'S',de_debcred,null,null,
          null,null,null,'N'
        from   asiento_aho
        where  (de_debito  <> 0.0
             or de_credito <> 0.0)

      if @@error <> 0
      begin
        select
          @w_mensaje =
          'ERROR AL INSERTAR REGISTROS EN LA TABLA ct_sasiento_tmp '
        goto ERROR1
      end

    end --@w_asiento > 0
    print ' Entra a actualizar'
    /* MARCAR COMO CONTABILIZADO */
    update cob_remesas..re_trn_contable with (rowlock)
    set    tc_comprobante = @w_comprobante,
           tc_mensaje = '',
           tc_estado = 'CON',
           tc_cuenta1 = 'S/C',
           tc_cuenta2 = 'S/C'
    where  tc_fecha     = @w_fecha_mov
       and tc_ofic_dest = @w_oficina_dest
       and tc_ofic_orig = @w_oficina_orig
       and tc_perfil    = @w_perfil
       and tc_producto  = @w_cod_producto
       and tc_estado in ('ING', 'ERR')
       and tc_tipo_tran = @w_trn

    if @@error <> 0
    begin
      select
        @w_mensaje =
' ERR AL MARCAR REGISTROS EN LA TABLA re_trn_contable COMO CONTABILIZADO '
goto ERROR1
end

/* REGISTRAR EN LA TABLA DEFINITIVA LA CUENTA UTILIZADA AL DEBITO */
update cob_remesas..re_trn_contable with (rowlock)
set    tc_cuenta1 = de_cuenta
from   asiento_aho
where  tc_secuencial = de_secuencial
and de_debcred    = '1'

if @@error <> 0
begin
select
@w_mensaje =
' ERR AL REGISTRAR EN LA TABLA re_trn_contable LA CUENTA USADA AL DEBITO '
goto ERROR1
end

/* REGISTRAR EN LA TABLA DEFINITIVA LA CUENTA UTILIZADA AL DEBITO */
update cob_remesas..re_trn_contable with (rowlock)
set    tc_cuenta2 = de_cuenta
from   asiento_aho
where  tc_secuencial = de_secuencial
and de_debcred    = '2'

if @@error <> 0
begin
select
@w_mensaje =
' ERR AL REGISTRAR EN LA TABLA re_trn_contable LA CUENTA USADA AL DEBITO '
goto ERROR1
end

/* MARCAR COMO ERRONEAS AQUELLOS COMPROBANTES QUE FUERON CONTABILIZADAS Y NO CUENTAN CON CUENTAS DE MOVIMIENTOS CONTABLE */
update cob_remesas..re_trn_contable with (rowlock)
set    tc_comprobante = null,
   tc_mensaje =
   'ERROR, NO EXISTEN CUENTAS CONTABLES RELACIONADAS AL COMPROBANTE',
   tc_estado = 'ERR'
where  tc_fecha     = @w_fecha_mov
and tc_ofic_dest = @w_oficina_dest
and tc_ofic_orig = @w_oficina_orig
and tc_perfil    = @w_perfil
and tc_producto  = @w_cod_producto
and tc_tipo_tran = @w_trn
and tc_estado    = 'CON'
and (tc_cuenta1   = 'S/C'
    and tc_cuenta2   = 'S/C')

if @@error <> 0
begin
select
@w_mensaje =
' ERR AL MARCAR REGISTROS EN LA TABLA re_trn_contable COMO ERRONEOS '
goto ERROR1
end

if @w_commit = 'S'
begin
commit tran
select
@w_commit = 'N'
end
print ' siguiente comprobante'
goto SIG_COMPROBANTE

ERROR1:

if @w_commit = 'S'
begin
rollback tran
select
@w_commit = 'N'
end

/* MARCAR COMO CONTABILIZADO */
update cob_remesas..re_trn_contable with (rowlock)
set    tc_comprobante = @w_comprobante,
   tc_estado = 'ERR',
   tc_cuenta1 = 'S/C',
   tc_cuenta2 = 'S/C',
   tc_mensaje = @w_mensaje
where  tc_fecha     = @w_fecha_mov
and tc_ofic_dest = @w_oficina_dest
and tc_ofic_orig = @w_oficina_orig
and tc_perfil    = @w_perfil
and tc_producto  = @w_cod_producto
and tc_estado in ('ING', 'ERR')
and tc_tipo_tran = @w_trn

if @@error <> 0
begin
select
@w_mensaje =
' ERR AL MARCAR REGISTROS EN LA TABLA re_trn_contable COMO CONTABILIZADO '
goto ERRORFIN
end

exec cob_ccontable..sp_errorcconta
@t_trn         = 60011,
@i_operacion   = 'I',
@i_empresa     = 1,
@i_fecha       = @w_fecha_proceso,
@i_producto    = @w_cod_producto,
@i_tran_modulo = @w_trn,
@i_asiento     = 0,
@i_fecha_conta = @w_fecha_mov,
@i_numerror    = @w_error,
@i_mensaje     = @w_mensaje,
@i_perfil      = @w_perfil,
@i_oficina     = @w_re_oficina_dest

SIG_COMPROBANTE:

end --while 1=1

  return 0

  ERRORFIN:

  if @w_commit = 'S'
  begin
    rollback tran
    select
      @w_commit = 'N'
  end

  print 'ERROR GENERAL: ' + @w_mensaje
  return 1

go

