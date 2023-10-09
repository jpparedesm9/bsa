use cob_ahorros
go

/***********************************************************************/
/*      Archivo:                  ahtabtmp.sp                          */
/*      Base de datos:            cob_ahorros                          */
/*      Producto:                 Cuentas de Ahooros                   */
/*      Disenado por:             Marco Sanguino                       */
/*      Fecha de escritura:       28/Nov/1999                          */
/***********************************************************************/
/*                              IMPORTANTE                             */
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
/***********************************************************************/
/*                              PROPOSITO                              */
/*         LLenado de tablas para reportes de Cuentas de Ahorros       */
/***********************************************************************/
/*                              MODIFICACIONES                         */
/*      FECHA           AUTOR             RAZON                        */
/*      20/Nov/1999     M.Sanguino        Emision inicial              */
/*      24/Abr/2000     Maria Gracia      Eliminacion de mensajes      */
/*                                        Informativos                 */
/*        02/Oct/2000        Yenny Rivero          Se incluyo el campo */
/*                                        ah_tipocta al proceso que    */
/*                                        llena la tabla ah_cuenta_tmp */
/*       02/Mayo/2016    Walther Toledo   Migración a CEN              */
/* ******************************************************************* */

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tablas_temp')
  drop proc sp_tablas_temp
go

create proc sp_tablas_temp
(
  @t_show_version bit = 0
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30)

  set ansi_warnings off

  select
    @w_sp_name = 'sp_tablas_temp'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end alter index all on ah_tran_monet_tmp disable alter index all on
ah_tran_servicio_tmp disable alter index all on ah_cuenta_tmp disable
  /** truncar la tabla temporal ****/
  truncate table cob_ahorros..ah_tran_monet_tmp
  print 'Truncate de tran_monet_tmp correcta'

  truncate table cob_ahorros..ah_tran_servicio_tmp
  print 'truncate de tran_servicio_tmp correcta'

  truncate table cob_ahorros..ah_cuenta_tmp
  print 'Eliminacion de ah_cuenta_tmp correcta'

  begin tran

  /**** Insercion de la ah_tran_moent_tmp *******/
  insert into cob_ahorros..ah_tran_monet_tmp
              (tm_fecha,tm_secuencial,tm_ssn_branch,tm_cod_alterno,tm_tipo_tran,
               tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_correccion,
               tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_signo,
               tm_fecha_ult_mov,tm_cta_banco,tm_valor,tm_chq_propios,
               tm_chq_locales,
               tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_indicador
               ,
               tm_causa,tm_departamento,tm_saldo_lib,
               tm_saldo_contable,
               tm_saldo_disponible,
               tm_saldo_interes,tm_fecha_efec,tm_interes,tm_control,
               tm_ctadestino,
               tm_tipo_xfer,tm_estado,tm_concepto,tm_oficina_cta,tm_hora,
               tm_banco,tm_valor_comision,tm_prod_banc,tm_categoria,tm_monto_imp
               ,
               tm_tipo_exonerado_imp,tm_serial,tm_tipocta_super,
               tm_turno,tm_cheque
               ,
               tm_forma_pg,tm_canal,tm_stand_in,tm_oficial,
               tm_clase_clte,
               tm_cliente,tm_base_gmf)
    select
      tm_fecha,tm_secuencial,tm_ssn_branch,tm_cod_alterno,tm_tipo_tran,
      tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_correccion,
      tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_signo,
      tm_fecha_ult_mov,tm_cta_banco,tm_valor,tm_chq_propios,tm_chq_locales,
      tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_indicador,
      tm_causa,tm_departamento,tm_saldo_lib,tm_saldo_contable,
      tm_saldo_disponible,
      tm_saldo_interes,tm_fecha_efec,tm_interes,tm_control,tm_ctadestino,
      tm_tipo_xfer,tm_estado,tm_concepto,tm_oficina_cta,tm_hora,
      tm_banco,tm_valor_comision,tm_prod_banc,tm_categoria,tm_monto_imp,
      tm_tipo_exonerado_imp,tm_serial,tm_tipocta_super,tm_turno,tm_cheque,
      tm_forma_pg,tm_canal,tm_stand_in,tm_oficial,tm_clase_clte,
      tm_cliente,tm_base_gmf
    from   cob_ahorros..ah_tran_monet

  if @@error <> 0
  begin
    /** Error al insertar en transaccion de servicio de cuentas de ahorros***/
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 353005
    return 1
  end
  print 'Insercion ah_tran_monet_tmp correcta'

  insert into cob_ahorros..ah_tran_servicio_tmp
              (ts_secuencial,ts_ssn_branch,ts_cod_alterno,ts_tipo_transaccion,
               ts_clase,
               ts_tsfecha,ts_tabla,ts_usuario,ts_terminal,ts_correccion,
               ts_ssn_corr,ts_reentry,ts_origen,ts_nodo,ts_remoto_ssn,
               ts_ctacte,ts_cta_banco,ts_filial,ts_oficina,ts_oficial,
               ts_fecha_aper,ts_cliente,ts_ced_ruc,ts_estado,ts_direccion_ec,
               ts_rol_ente,ts_descripcion_ec,ts_cheque_rec,ts_ciclo,ts_categoria
               ,
               ts_producto,ts_tipo,ts_indicador,ts_moneda,
               ts_default,
               ts_tipo_def,ts_tipo_promedio,ts_capitalizacion,ts_tipo_interes,
               ts_numero,
               ts_fecha,ts_autorizante,ts_valor,ts_accion,ts_secuencia,
               ts_causa,ts_orden,ts_servicio,ts_saldo,ts_interes,
               ts_contrato,ts_fecha_uso,ts_monto,ts_fecha_ven,ts_filial_aut,
               ts_ofi_aut,ts_autoriz_aut,ts_filial_anula,ts_ofi_anula,
               ts_autoriz_anula,
               ts_cheque_desde,ts_cheque_hasta,ts_causa_np,ts_clase_np,
               ts_departamento,
               ts_causa_rev,ts_cta_gir,ts_endoso,ts_nro_cheque,ts_cod_banco,
               ts_corresponsal,ts_propietario,ts_carta,ts_sec_correccion,
               ts_cheque
               ,
               ts_cta_banco_dep,ts_oficina_pago,ts_cta_funcionario,
               ts_mercantil,ts_tipocta,
               ts_numlib,ts_tasa,ts_oficina_cta,ts_hora,ts_prod_banc,
               ts_nombre1,ts_cedruc1,ts_observacion,ts_tipocta_super,ts_turno,
               ts_clase_clte,ts_marca_gmf,ts_fec_marca_gmf,ts_nxmil)
    select
      ts_secuencial,ts_ssn_branch,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
      ts_tsfecha,ts_tabla,ts_usuario,ts_terminal,ts_correccion,
      ts_ssn_corr,ts_reentry,ts_origen,ts_nodo,ts_remoto_ssn,
      ts_ctacte,ts_cta_banco,ts_filial,ts_oficina,ts_oficial,
      ts_fecha_aper,ts_cliente,ts_ced_ruc,ts_estado,ts_direccion_ec,
      ts_rol_ente,ts_descripcion_ec,ts_cheque_rec,ts_ciclo,ts_categoria,
      ts_producto,ts_tipo,ts_indicador,ts_moneda,ts_default,
      ts_tipo_def,ts_tipo_promedio,ts_capitalizacion,ts_tipo_interes,ts_numero,
      ts_fecha,ts_autorizante,ts_valor,ts_accion,ts_secuencia,
      ts_causa,ts_orden,ts_servicio,ts_saldo,ts_interes,
      ts_contrato,ts_fecha_uso,ts_monto,ts_fecha_ven,ts_filial_aut,
      ts_ofi_aut,ts_autoriz_aut,ts_filial_anula,ts_ofi_anula,ts_autoriz_anula,
      ts_cheque_desde,ts_cheque_hasta,ts_causa_np,ts_clase_np,ts_departamento,
      ts_causa_rev,ts_cta_gir,ts_endoso,ts_nro_cheque,ts_cod_banco,
      ts_corresponsal,ts_propietario,ts_carta,ts_sec_correccion,ts_cheque,
      ts_cta_banco_dep,ts_oficina_pago,ts_cta_funcionario,ts_mercantil,
      ts_tipocta,
      ts_numlib,ts_tasa,ts_oficina_cta,ts_hora,ts_prod_banc,
      ts_nombre1,ts_cedruc1,ts_observacion,ts_tipocta_super,ts_turno,
      ts_clase_clte,ts_marca_gmf,ts_fec_marca_gmf,ts_nxmil
    from   cob_ahorros..ah_tran_servicio

  if @@error <> 0
  begin
    /** Error al insertar en transaccion de servicio de cuentas de ahorros***/
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 353005
    return 1
  end
  print 'Insercion ah_tran_servicio_tmp correcta'

  insert into cob_ahorros..ah_cuenta_tmp
              (ah_cuenta,ah_cta_banco,ah_estado,ah_control,ah_filial,
               ah_oficina,ah_producto,ah_tipo,ah_moneda,ah_fecha_aper,
               ah_oficial,ah_cliente,ah_ced_ruc,ah_nombre,ah_categoria,
               ah_tipo_promedio,ah_capitalizacion,ah_ciclo,ah_suspensos,
               ah_bloqueos,
               ah_condiciones,ah_monto_bloq,ah_num_blqmonto,ah_cred_24,
               ah_cred_rem
               ,
               ah_tipo_def,ah_default,ah_rol_ente,ah_disponible,
               ah_12h,
               ah_12h_dif,ah_24h,ah_48h,ah_remesas,ah_rem_hoy,
               ah_interes,ah_interes_ganado,ah_saldo_libreta,ah_saldo_interes,
               ah_saldo_anterior,
               ah_saldo_ult_corte,ah_saldo_ayer,ah_creditos,ah_debitos,
               ah_creditos_hoy,
               ah_debitos_hoy,ah_fecha_ult_mov,ah_fecha_ult_mov_int,
               ah_fecha_ult_upd,ah_fecha_prx_corte,
               ah_fecha_ult_corte,ah_fecha_ult_capi,ah_fecha_prx_capita,ah_linea
               ,
               ah_ult_linea,
               ah_cliente_ec,ah_direccion_ec,ah_descripcion_ec,ah_tipo_dir,
               ah_agen_ec,
               ah_parroquia,ah_zona,ah_prom_disponible,ah_promedio1,ah_promedio2
               ,
               ah_promedio3,ah_promedio4,ah_promedio5,
               ah_promedio6,
               ah_personalizada,
               ah_contador_trx,ah_cta_funcionario,ah_tipocta,ah_prod_banc,
               ah_origen,
               ah_numlib,ah_dep_ini,ah_contador_firma,ah_telefono,ah_int_hoy,
               ah_tasa_hoy,ah_min_dispmes,ah_fecha_ult_ret,ah_cliente1,
               ah_nombre1,
               ah_cedruc1,ah_sector,ah_monto_imp,ah_monto_consumos,
               ah_ctitularidad
               ,
               ah_promotor,ah_int_mes,ah_tipocta_super,
               ah_direccion_dv,ah_descripcion_dv,
               ah_tipodir_dv,ah_parroquia_dv,ah_zona_dv,ah_agen_dv,ah_cliente_dv
               ,
               ah_traslado,ah_aplica_tasacorp,ah_monto_emb,
               ah_monto_ult_capi,
               ah_saldo_mantval,
               ah_cuota,ah_creditos2,ah_creditos3,ah_creditos4,ah_creditos5,
               ah_creditos6,ah_debitos2,ah_debitos3,ah_debitos4,ah_debitos5,
               ah_debitos6,ah_tasa_ayer,ah_estado_cuenta,ah_permite_sldcero,
               ah_rem_ayer,
               ah_numsol,ah_patente,ah_fideicomiso,ah_nxmil,ah_clase_clte,
               ah_deb_mes_ant,ah_cred_mes_ant,ah_num_deb_mes,ah_num_cred_mes,
               ah_num_con_mes,
               ah_num_deb_mes_ant,ah_num_cred_mes_ant,ah_num_con_mes_ant,
               ah_fecha_ult_proceso)
    select
      ah_cuenta,ah_cta_banco,ah_estado,ah_control,ah_filial,
      ah_oficina,ah_producto,ah_tipo,ah_moneda,ah_fecha_aper,
      ah_oficial,ah_cliente,ah_ced_ruc,ah_nombre,ah_categoria,
      ah_tipo_promedio,ah_capitalizacion,ah_ciclo,ah_suspensos,ah_bloqueos,
      ah_condiciones,ah_monto_bloq,ah_num_blqmonto,ah_cred_24,ah_cred_rem,
      ah_tipo_def,ah_default,ah_rol_ente,ah_disponible,ah_12h,
      ah_12h_dif,ah_24h,ah_48h,ah_remesas,ah_rem_hoy,
      ah_interes,ah_interes_ganado,ah_saldo_libreta,ah_saldo_interes,
      ah_saldo_anterior,
      ah_saldo_ult_corte,ah_saldo_ayer,ah_creditos,ah_debitos,ah_creditos_hoy,
      ah_debitos_hoy,ah_fecha_ult_mov,ah_fecha_ult_mov_int,ah_fecha_ult_upd,
      ah_fecha_prx_corte,
      ah_fecha_ult_corte,ah_fecha_ult_capi,ah_fecha_prx_capita,ah_linea,
      ah_ult_linea
      ,
      ah_cliente_ec,ah_direccion_ec,ah_descripcion_ec,ah_tipo_dir,ah_agen_ec,
      ah_parroquia,ah_zona,ah_prom_disponible,ah_promedio1,ah_promedio2,
      ah_promedio3,ah_promedio4,ah_promedio5,ah_promedio6,ah_personalizada,
      ah_contador_trx,ah_cta_funcionario,ah_tipocta,ah_prod_banc,ah_origen,
      ah_numlib,ah_dep_ini,ah_contador_firma,ah_telefono,ah_int_hoy,
      ah_tasa_hoy,ah_min_dispmes,ah_fecha_ult_ret,ah_cliente1,ah_nombre1,
      ah_cedruc1,ah_sector,ah_monto_imp,ah_monto_consumos,ah_ctitularidad,
      ah_promotor,ah_int_mes,ah_tipocta_super,ah_direccion_dv,ah_descripcion_dv,
      ah_tipodir_dv,ah_parroquia_dv,ah_zona_dv,ah_agen_dv,ah_cliente_dv,
      ah_traslado,ah_aplica_tasacorp,ah_monto_emb,ah_monto_ult_capi,
      ah_saldo_mantval
      ,
      ah_cuota,ah_creditos2,ah_creditos3,ah_creditos4,ah_creditos5,
      ah_creditos6,ah_debitos2,ah_debitos3,ah_debitos4,ah_debitos5,
      ah_debitos6,ah_tasa_ayer,ah_estado_cuenta,ah_permite_sldcero,ah_rem_ayer,
      ah_numsol,ah_patente,ah_fideicomiso,ah_nxmil,ah_clase_clte,
      ah_deb_mes_ant,ah_cred_mes_ant,ah_num_deb_mes,ah_num_cred_mes,
      ah_num_con_mes
      ,
      ah_num_deb_mes_ant,ah_num_cred_mes_ant,ah_num_con_mes_ant,
      ah_fecha_ult_proceso
    from   cob_ahorros..ah_cuenta

  if @@error <> 0
  begin
    /** Error al insertar en transaccion de servicio de cuentas de ahorros***/
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 353005
    return 1
  end

  print 'ah_tran_monet_tmp ah_tran_servicio_tmp ah_cuenta_tmp ejecutado' alter
index all on ah_tran_monet_tmp rebuild alter index all on ah_tran_servicio_tmp
rebuild alter index all on ah_cuenta_tmp rebuild
  commit tran
  return 0

go

