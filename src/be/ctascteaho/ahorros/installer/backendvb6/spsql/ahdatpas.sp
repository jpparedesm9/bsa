/*****************************************************************************/
/*  ARCHIVO:         ahdatpas.sp                                             */
/*  NOMBRE LOGICO:   sp_datos_pasivas_rec                                    */
/*  PRODUCTO:        Ahorros                                                 */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Ingresar informacion a las tablas de datos pasivas de REC.                */
/*****************************************************************************/
/*                         MODIFICACIONES                                    */
/* FECHA              AUTOR             RAZON                                */
/* 29-AGO-2014        Andres Diab       REQ 453 Banca movil. Inclusion de    */
/*                                      relaciones a canal                   */
/* 03/May/2016        J. Salazar        Migracion COBIS CLOUD MEXICO         */
/*****************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_datos_pasivas_rec')
  drop proc sp_datos_pasivas_rec
go

/****** Object:  StoredProcedure [dbo].[sp_datos_pasivas_rec]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_datos_pasivas_rec
(
  @t_show_version bit = 0,
  @i_corresponsal char(1) = 'N' --Req. 381 CB Red Posicionada        
)
as
  declare
    @w_error         int,
    @w_msg           descripcion,
    @w_fecha_proc    datetime,
    @w_fecha_ini     datetime,
    @w_tabla         int,
    @w_sp_name       varchar(30),
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_datos_pasivas_rec'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* TRAER LA FECHA DE PROCESO DEL SISTEMA PARA EL MODULO */
  select
    @w_fecha_proc = fc_fecha_cierre
  from   cobis..ba_fecha_cierre
  where  fc_producto = 4

  /*** Generar la el primer dia del mes *****/

  select
    @w_fecha_ini = convert(varchar(2), datepart(mm, @w_fecha_proc)) + '/01/'
                   + convert(varchar(4), datepart(yy, @w_fecha_proc))

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  /** Cuentas que estan marcadas con gravamen  **/
  create table #cuenta_gmf
  (
    cg_cuenta    int,
    cg_exento    char(1),
    cg_ley_exen  catalogo,
    cg_fecha     datetime,
    cg_fecha_act datetime null
  )

  insert into #cuenta_gmf
    select
      eg_cuenta,eg_marca,eg_concepto,isnull(eg_fecha_marca,
             convert(datetime, null)),case eg_marca
        when 'S' then convert(datetime, null)
        when 'N' then isnull(eg_fecha_actua,
                             convert(datetime, null))
      end
    from   cob_ahorros..ah_exenta_gmf
  -- where eg_fecha_actua = @w_fecha_proc

  /* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR AHORROS EN COB_EXTERNOS */
  delete cob_externos..ex_dato_pasivas
  where  dp_aplicativo = 4

  if @@error <> 0
  begin
    select
      @w_error = 147000,
      @w_msg = 'Error al eliminar registros cob_externos..ex_dato_pasivas'
    goto ERROR
  end

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    print 'Empieza'
    select
      dp_fecha = @w_fecha_proc,
      dp_ctaint = ah_cuenta,
      dp_banco = ah_cta_banco,
      dp_toperacion = convert(varchar(10), ah_prod_banc),
      dp_aplicativo = convert(tinyint, 4),
      dp_categoria_producto = (select
                                 isnull(eq_val_interfaz,
                                        ah_prod_banc)
                               from   cob_remesas..re_equivalencias
                               where  eq_modulo    = 4
                                  and eq_mod_int   = 36
                                  and eq_tabla     = 'CATPRODUC'
                                  and ah_prod_banc = convert(smallint,
                                                     eq_val_cfijo)
                              ),
      dp_naturaleza_cliente = isnull(ah_clase_clte,
                                     'P'),
      dp_cliente = ah_cliente,
      dp_documento_tipo = convert(varchar(10), null),
      dp_documento_numero = convert(varchar(14), null),
      dp_oficina = convert(int, ah_oficina),
      dp_oficial = convert(int, ah_oficial),
      dp_moneda = ah_moneda,
      dp_monto = convert(money, 0),
      dp_tasa = round(ah_tasa_hoy,
                      2),--Verificar que sea tasa efectiva
      dp_modalidad = 'V',--Vencida
      dp_plazo_dias = convert(int, 0),
      dp_fecha_apertura = ah_fecha_aper,
      dp_fecha_radicacion = case ah_estado
                              when 'C' then ah_fecha_ult_mov
                              else ah_fecha_aper
                            end,
      dp_fecha_vencimiento = case ah_estado
                               when 'C' then ah_fecha_ult_mov
                               else null
                             end,
      dp_num_renovaciones = convert(int, 0),
      dp_estado = case ah_estado
                    when 'A' then 1
                    when 'I' then 2
                    else 4
                  end,
      dp_razon_cancelacion = convert(varchar, null),
      dp_num_cuotas = convert(int, 0),
      dp_periodicidad_cuota = convert(int, 0),
      dp_saldo_disponible = ah_disponible,
      dp_saldo_int = ah_saldo_interes,
      dp_saldo_camara12h = ah_12h,
      dp_saldo_camara24h = ah_24h,
      dp_saldo_camara48h = ah_48h,
      dp_saldo_remesas = ah_remesas,
      dp_condicion_manejo = case ah_clase_clte
                              when 'C' then 'J' -- Juridica
                              when 'O' then 'J' -- Juridica
                              when 'P' then (select
                                               case b.ah_ctitularidad
                                                 when 'S' then 'I'
                                                 -- Individual 
                                                 else 'O' -- Colectiva
                                               end
                                             from   cob_ahorros..ah_cuenta_tmp b
                                             where  b.ah_cuenta = a.ah_cuenta)
                            end,
      dp_exen_gmf = 'N',
      dp_fecha_ini_exen_gmf = convert(datetime, null),
      dp_fecha_fin_exen_gmf = convert(datetime, null),
      dp_ley_exen = convert(varchar, null),
      dp_tesoro_nacional = 'N'
    -- Case ah_estado when 'I' then  'I' else 'N' end  -- Falta cuando sea inactiva, definir si paso o no al Tesoro Nal

    into   #cuenta_cb
    from   cob_ahorros..ah_cuenta_tmp a
    where  (ah_estado in ('A', 'I')
             or (ah_estado    = 'C'
                 and ah_fecha_ult_mov between @w_fecha_ini and @w_fecha_proc))
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar en #cuenta'
      goto ERROR
    end

    select
      @w_tabla = codigo
    from   cobis..cl_tabla
    where  tabla = 'ah_causa_cierre'

    if @w_tabla is null
    begin
      select
        @w_error = 499999,
        @w_msg = 'No existe catalogo ah_causa_cierre'
      goto ERROR
    end

    update #cuenta_cb
    set    dp_razon_cancelacion = (select
                                     eq_val_interfaz
                                   from   cob_remesas..re_equivalencias
                                   where  eq_modulo    = 4
                                      and eq_mod_int   = 36
                                      and eq_tabla     = 'CAUSACIERRE'
                                      and eq_val_cfijo = c.hc_causa)
    from   #cuenta_cb,
           cob_ahorros..ah_his_cierre c
    where  dp_ctaint = hc_cuenta
       and dp_estado = 4

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al actualizar causa de cierre en #cuenta'
      goto ERROR
    end

    update #cuenta_cb
    set    dp_saldo_disponible = hc_saldo
    from   #cuenta_cb,
           ah_his_cierre
    where  dp_ctaint = hc_cuenta
       and dp_estado = 4
       and hc_estado = 'C'

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al actualizar saldo de cuenta cancelada en #cuenta'
      goto ERROR
    end

    /*** Actualizamos las que estan enviadas al tesoro Nacional ***/
    update #cuenta_cb
    set    dp_tesoro_nacional = 'S'
    from   #cuenta_cb,
           cob_remesas..re_tesoro_nacional
    where  dp_banco  = tn_cuenta
       and tn_estado = 'P'

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al actualizar las cuentas enviadas al tesoro Nacional'
      goto ERROR
    end

    /*** Actualizamos las que tienen marcado gravamen ***/
    update #cuenta_cb
    set    dp_exen_gmf = cg_exento,
           dp_fecha_ini_exen_gmf = cg_fecha,
           dp_ley_exen = cg_ley_exen,
           dp_fecha_fin_exen_gmf = cg_fecha_act
    from   #cuenta_cb,
           #cuenta_gmf
    where  dp_ctaint = cg_cuenta

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al actualizar las cuentas marcadas con gravamen'
      goto ERROR
    end

    print ' Ex_dato_pasivos ....'

    insert into cob_externos..ex_dato_pasivas
                (dp_fecha,dp_banco,dp_toperacion,dp_aplicativo,
                 dp_categoria_producto,
                 dp_naturaleza_cliente,dp_cliente,dp_documento_tipo,
                 dp_documento_numero,dp_oficina,
                 dp_oficial,dp_moneda,dp_monto,dp_tasa,dp_modalidad,
                 dp_plazo_dias,dp_fecha_apertura,dp_fecha_radicacion,
                 dp_fecha_vencimiento,dp_num_renovaciones,
                 dp_estado,dp_razon_cancelacion,dp_num_cuotas,
                 dp_periodicidad_cuota,
                 dp_saldo_disponible,
                 dp_saldo_int,dp_saldo_camara12h,dp_saldo_camara24h,
                 dp_saldo_camara48h,dp_saldo_remesas,
                 dp_condicion_manejo,dp_exen_gmf,dp_fecha_ini_exen_gmf,
                 dp_fecha_fin_exen_gmf,dp_tesoro_nacional,
                 dp_ley_exen)
      select
        dp_fecha,dp_banco,dp_toperacion,dp_aplicativo,dp_categoria_producto,
        dp_naturaleza_cliente,dp_cliente,dp_documento_tipo,dp_documento_numero,
        dp_oficina,
        dp_oficial,dp_moneda,dp_monto,dp_tasa,dp_modalidad,
        dp_plazo_dias,dp_fecha_apertura,dp_fecha_radicacion,dp_fecha_vencimiento
        ,
        dp_num_renovaciones,
        dp_estado,dp_razon_cancelacion,dp_num_cuotas,dp_periodicidad_cuota,
        dp_saldo_disponible,
        dp_saldo_int,dp_saldo_camara12h,dp_saldo_camara24h,dp_saldo_camara48h,
        dp_saldo_remesas,
        dp_condicion_manejo,dp_exen_gmf,dp_fecha_ini_exen_gmf,
        dp_fecha_fin_exen_gmf,
        dp_tesoro_nacional,
        dp_ley_exen
      from   #cuenta_cb

    if @@error <> 0
    begin
      select
        *
      from   #cuenta_cb
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar en cob_externos..ex_dato_pasivas'
      goto ERROR
    end
  end
  else
  begin
    print 'Empieza'
    select
      dp_fecha = @w_fecha_proc,
      dp_ctaint = ah_cuenta,
      dp_banco = ah_cta_banco,
      dp_toperacion = convert(varchar(10), ah_prod_banc),
      dp_aplicativo = convert(tinyint, 4),
      dp_categoria_producto = (select
                                 isnull(eq_val_interfaz,
                                        ah_prod_banc)
                               from   cob_remesas..re_equivalencias
                               where  eq_modulo    = 4
                                  and eq_mod_int   = 36
                                  and eq_tabla     = 'CATPRODUC'
                                  and ah_prod_banc = convert(smallint,
                                                     eq_val_cfijo)
                              ),
      dp_naturaleza_cliente = isnull(ah_clase_clte,
                                     'P'),
      dp_cliente = ah_cliente,
      dp_documento_tipo = convert(varchar(10), null),
      dp_documento_numero = convert(varchar(14), null),
      dp_oficina = convert(int, ah_oficina),
      dp_oficial = convert(int, ah_oficial),
      dp_moneda = ah_moneda,
      dp_monto = convert(money, 0),
      dp_tasa = round(ah_tasa_hoy,
                      2),--Verificar que sea tasa efectiva
      dp_modalidad = 'V',--Vencida
      dp_plazo_dias = convert(int, 0),
      dp_fecha_apertura = ah_fecha_aper,
      dp_fecha_radicacion = case ah_estado
                              when 'C' then ah_fecha_ult_mov
                              else ah_fecha_aper
                            end,
      dp_fecha_vencimiento = case ah_estado
                               when 'C' then ah_fecha_ult_mov
                               else null
                             end,
      dp_num_renovaciones = convert(int, 0),
      dp_estado = case ah_estado
                    when 'A' then 1
                    when 'I' then 2
                    else 4
                  end,
      dp_razon_cancelacion = convert(varchar, null),
      dp_num_cuotas = convert(int, 0),
      dp_periodicidad_cuota = convert(int, 0),
      dp_saldo_disponible = ah_disponible,
      dp_saldo_int = ah_saldo_interes,
      dp_saldo_camara12h = ah_12h,
      dp_saldo_camara24h = ah_24h,
      dp_saldo_camara48h = ah_48h,
      dp_saldo_remesas = ah_remesas,
      dp_condicion_manejo = case ah_clase_clte
                              when 'C' then 'J' -- Juridica
                              when 'O' then 'J' -- Juridica
                              when 'P' then (select
                                               case b.ah_ctitularidad
                                                 when 'S' then 'I'
                                                 -- Individual 
                                                 else 'O' -- Colectiva
                                               end
                                             from   cob_ahorros..ah_cuenta_tmp b
                                             where  b.ah_cuenta = a.ah_cuenta)
                            end,
      dp_exen_gmf = 'N',
      dp_fecha_ini_exen_gmf = convert(datetime, null),
      dp_fecha_fin_exen_gmf = convert(datetime, null),
      dp_ley_exen = convert(varchar, null),
      dp_tesoro_nacional = 'N'
    -- Case ah_estado when 'I' then  'I' else 'N' end  -- Falta cuando sea inactiva, definir si paso o no al Tesoro Nal

    into   #cuenta
    from   cob_ahorros..ah_cuenta_tmp a
    where  ah_estado in ('A', 'I')
        or (ah_estado = 'C'
            and ah_fecha_ult_mov between @w_fecha_ini and @w_fecha_proc)

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar en #cuenta'
      goto ERROR
    end

    select
      @w_tabla = codigo
    from   cobis..cl_tabla
    where  tabla = 'ah_causa_cierre'

    if @w_tabla is null
    begin
      select
        @w_error = 499999,
        @w_msg = 'No existe catalogo ah_causa_cierre'
      goto ERROR
    end

    update #cuenta
    set    dp_razon_cancelacion = (select
                                     eq_val_interfaz
                                   from   cob_remesas..re_equivalencias
                                   where  eq_modulo    = 4
                                      and eq_mod_int   = 36
                                      and eq_tabla     = 'CAUSACIERRE'
                                      and eq_val_cfijo = c.hc_causa)
    from   #cuenta,
           cob_ahorros..ah_his_cierre c
    where  dp_ctaint = hc_cuenta
       and dp_estado = 4

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al actualizar causa de cierre en #cuenta'
      goto ERROR
    end

    update #cuenta
    set    dp_saldo_disponible = hc_saldo
    from   #cuenta,
           ah_his_cierre
    where  dp_ctaint = hc_cuenta
       and dp_estado = 4
       and hc_estado = 'C'

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al actualizar saldo de cuenta cancelada en #cuenta'
      goto ERROR
    end

    /*** Actualizamos las que estan enviadas al tesoro Nacional ***/
    update #cuenta
    set    dp_tesoro_nacional = 'S'
    from   #cuenta,
           cob_remesas..re_tesoro_nacional
    where  dp_banco  = tn_cuenta
       and tn_estado = 'P'

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al actualizar las cuentas enviadas al tesoro Nacional'
      goto ERROR
    end

    /*** Actualizamos las que tienen marcado gravamen ***/
    update #cuenta
    set    dp_exen_gmf = cg_exento,
           dp_fecha_ini_exen_gmf = cg_fecha,
           dp_ley_exen = cg_ley_exen,
           dp_fecha_fin_exen_gmf = cg_fecha_act
    from   #cuenta,
           #cuenta_gmf
    where  dp_ctaint = cg_cuenta

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al actualizar las cuentas marcadas con gravamen'
      goto ERROR
    end

    print ' Ex_dato_pasivos ....'

    insert into cob_externos..ex_dato_pasivas
                (dp_fecha,dp_banco,dp_toperacion,dp_aplicativo,
                 dp_categoria_producto,
                 dp_naturaleza_cliente,dp_cliente,dp_documento_tipo,
                 dp_documento_numero,dp_oficina,
                 dp_oficial,dp_moneda,dp_monto,dp_tasa,dp_modalidad,
                 dp_plazo_dias,dp_fecha_apertura,dp_fecha_radicacion,
                 dp_fecha_vencimiento,dp_num_renovaciones,
                 dp_estado,dp_razon_cancelacion,dp_num_cuotas,
                 dp_periodicidad_cuota,
                 dp_saldo_disponible,
                 dp_saldo_int,dp_saldo_camara12h,dp_saldo_camara24h,
                 dp_saldo_camara48h,dp_saldo_remesas,
                 dp_condicion_manejo,dp_exen_gmf,dp_fecha_ini_exen_gmf,
                 dp_fecha_fin_exen_gmf,dp_tesoro_nacional,
                 dp_ley_exen)
      select
        dp_fecha,dp_banco,dp_toperacion,dp_aplicativo,dp_categoria_producto,
        dp_naturaleza_cliente,dp_cliente,dp_documento_tipo,dp_documento_numero,
        dp_oficina,
        dp_oficial,dp_moneda,dp_monto,dp_tasa,dp_modalidad,
        dp_plazo_dias,dp_fecha_apertura,dp_fecha_radicacion,dp_fecha_vencimiento
        ,
        dp_num_renovaciones,
        dp_estado,dp_razon_cancelacion,dp_num_cuotas,dp_periodicidad_cuota,
        dp_saldo_disponible,
        dp_saldo_int,dp_saldo_camara12h,dp_saldo_camara24h,dp_saldo_camara48h,
        dp_saldo_remesas,
        dp_condicion_manejo,dp_exen_gmf,dp_fecha_ini_exen_gmf,
        dp_fecha_fin_exen_gmf,
        dp_tesoro_nacional,
        dp_ley_exen
      from   #cuenta

    if @@error <> 0
    begin
      select
        *
      from   #cuenta_cb
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar en cob_externos..ex_dato_pasivas'
      goto ERROR
    end
  end

  /* BORRAR LA INFORMACION GENERADA DE RELACIONES A CANALES EN COB_EXTERNOS */
  delete cob_externos..ex_relacion_canal
  where  rc_aplicativo = 4
     and rc_fecha      = @w_fecha_proc
  if @@error <> 0
  begin
    select
      @w_error = 147000,
      @w_msg = 'Error al eliminar registros cob_externos..ex_relacion_canal'
    goto ERROR
  end

  /* INSERTAR LA INFORMACION DE LA FECHA PROCESO SOBRE RELACIONES A CANALES EN COB_EXTERNOS */
  insert into cob_externos..ex_relacion_canal
              (rc_cuenta,rc_cliente,rc_tel_celular,rc_tarj_debito,rc_canal,
               rc_motivo,rc_estado,rc_fecha,rc_fecha_mod,rc_usuario,
               rc_subtipo,rc_tipo_operador,rc_aplicativo,rc_fecha_proceso,
               rc_oficina)
    select
      rc_cuenta,rc_cliente,rc_tel_celular,rc_tarj_debito,rc_canal,
      rc_motivo,rc_estado,rc_fecha,rc_fecha_mod,rc_usuario,
      rc_subtipo,rc_tipo_operador,4,@w_fecha_proc,rc_oficina
    from   cob_remesas..re_relacion_cta_canal
    where  rc_fecha     = @w_fecha_proc
        or rc_fecha_mod = @w_fecha_proc
  if @@error <> 0
  begin
    print 'ERROR CARGANDO INFORMACION DE RELACIONES A CANALES A COB_EXTERNOS'
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar en cob_externos..ex_relacion_canal'
    goto ERROR
  end

  return 0

  ERROR:
  exec sp_errorlog
    @i_fecha       = @w_fecha_proc,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 0,
    @i_descripcion = @w_msg,
    @i_programa    = 'sp_datos_pasivas_rec'

  return @w_error

go

