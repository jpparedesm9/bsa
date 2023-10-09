/************************************************************************/
/*      Archivo:            ah_pkey.sql                                 */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de primary key                */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cob_ahorros
go


CREATE CLUSTERED INDEX ah_acumulador_Key
    ON ah_acumulador (ac_oficina,ac_moneda,ac_prod_banc,ac_categoria,ac_tipocta_super,ac_trn,ac_fecha)
GO


CREATE UNIQUE CLUSTERED INDEX ah_alicuota_Key
    ON ah_alicuota (al_fecha,al_capitalizacion)
GO

CREATE CLUSTERED INDEX ah_apertura_cta_Key
    ON ah_apertura_cta (ac_fecha,ac_cta_banco,ac_oficina)
GO


CREATE UNIQUE CLUSTERED INDEX ah_caja_Key
    ON ah_caja (cj_oficina,cj_rol,cj_operador,cj_moneda,cj_transaccion)
GO


CREATE UNIQUE CLUSTERED INDEX ah_clicta_solicitud_Key
    ON ah_clicta_solicitud (cs_numsol,cs_codigo)
GO


CREATE UNIQUE CLUSTERED INDEX ah_ctabloqueada_Key
    ON ah_ctabloqueada (cb_cuenta,cb_secuencial)
GO


CREATE UNIQUE CLUSTERED INDEX ah_cuenta_Key
    ON ah_cuenta (ah_cta_banco)
GO

CREATE UNIQUE NONCLUSTERED INDEX i_ah_cuenta
    ON ah_cuenta (ah_cuenta)
GO

CREATE NONCLUSTERED INDEX i_ah_nombre
    ON ah_cuenta (ah_nombre)
GO

CREATE UNIQUE CLUSTERED INDEX ah_cuenta_navidad_Key
    ON ah_cuenta_navidad (cn_cuenta)
GO


CREATE UNIQUE NONCLUSTERED INDEX ah_cuenta_tmp_Key
    ON ah_cuenta_tmp (ah_cta_banco)
GO


CREATE UNIQUE CLUSTERED INDEX ah_cuenta_tmp1_Key
    ON ah_cuenta_tmp1 (ah_moneda,ah_prod_banc)
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_cuentas_subsidiarias_key
    ON ah_cuentas_subsidiarias (as_cta_banco)
GO


CREATE UNIQUE NONCLUSTERED INDEX ah_datos_adic_Key
    ON ah_datos_adic (da_cta_banco)
GO


CREATE UNIQUE CLUSTERED INDEX ah_dep_difer_Key
    ON ah_dep_difer (dd_ssn)
GO

CREATE NONCLUSTERED INDEX ah_dev_recaudos_cb_Key
    ON ah_dev_recaudos_cb (dr_cta_banco,dr_fecha)
GO

CREATE UNIQUE CLUSTERED INDEX ah_dias_laborables_Key
    ON ah_dias_laborables (dl_ciudad,dl_fecha)
GO

CREATE UNIQUE CLUSTERED INDEX ah_embargo_Key
    ON ah_embargo (he_secuencial)
GO


CREATE UNIQUE CLUSTERED INDEX ah_estado_cta_Key
    ON ah_estado_cta (ec_cuenta,ec_fecha_prx_corte)
GO

CREATE UNIQUE CLUSTERED INDEX ah_det_estado_cuenta_Key
    ON ah_det_estado_cuenta (de_fecha,de_cta_banco,de_transaccion, de_secuencial,de_tipotran,de_serial,de_causa)
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_exenta_gmf_key
    ON ah_exenta_gmf (eg_cta_banco)
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_exenta_gmf_keyCta
    ON ah_exenta_gmf (eg_cuenta)
GO


CREATE UNIQUE CLUSTERED INDEX ah_fecha_periodo_Key
    ON ah_fecha_periodo (fp_tipo_promedio,fp_numero_promedio)
GO

CREATE CLUSTERED INDEX ah_fecha_promedio_Key
    ON ah_fecha_promedio (fp_tipo_promedio,fp_fecha_inicio)
GO


CREATE UNIQUE NONCLUSTERED INDEX ah_fecha_valor_Key
    ON ah_fecha_valor (fv_transaccion,fv_cuenta,fv_referencia,fv_rubro)
GO


CREATE UNIQUE CLUSTERED INDEX ah_his_bloqueo_Key
    ON ah_his_bloqueo (hb_cuenta,hb_secuencial)
GO


CREATE UNIQUE CLUSTERED INDEX ah_his_cierre_Key
    ON ah_his_cierre (hc_secuencial)
GO


CREATE UNIQUE CLUSTERED INDEX ah_his_lineacred_Key
    ON ah_his_lineacred (hl_cuenta,hl_secuencial)
GO

CREATE NONCLUSTERED INDEX ah_cuenta_plan_Key
    ON ah_imprime_plan (im_cuenta)
GO

CREATE UNIQUE CLUSTERED INDEX ah_linea_pendiente_Key
    ON ah_linea_pendiente (lp_cuenta,lp_linea,lp_control)
GO

CREATE UNIQUE CLUSTERED INDEX ah_oficina_ctas_cifradas_Key
    ON ah_oficina_ctas_cifradas (oc_oficina)
GO


CREATE UNIQUE CLUSTERED INDEX ah_rangos_saldos_Key
    ON ah_rangos_saldos (rs_moneda,rs_secuencial)
GO


CREATE UNIQUE CLUSTERED INDEX ah_relacion_navidad_Key
    ON ah_relacion_navidad (rn_nombre)
GO


CREATE NONCLUSTERED INDEX ah_reporte_devolucion_tmp_Key
    ON ah_reporte_devolucion_tmp (rd_cta_banco,rd_fecha)
GO


CREATE UNIQUE NONCLUSTERED INDEX cc_retencion_locales_Key
    ON ah_retencion_locales (rl_agencia,rl_hora_inicio,rl_hora_fin)
GO

CREATE UNIQUE CLUSTERED INDEX ah_solicitud_cuenta_Key
    ON ah_solicitud_cuenta (sc_numsol)
GO

CREATE UNIQUE CLUSTERED INDEX ah_sorteo_agrob_Key
    ON ah_sorteo_agrob (sa_secuencial)
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_tipotrx_mes_Key
    ON ah_tipotrx_mes (tm_cta_banco,tm_tipo_tran)
GO


CREATE UNIQUE CLUSTERED INDEX ah_tran_monet_Key
    ON ah_tran_monet (tm_cta_banco,tm_secuencial,tm_cod_alterno)
GO


CREATE UNIQUE NONCLUSTERED INDEX ah_tran_monet_tmp_Key
    ON ah_tran_monet_tmp (tm_cta_banco,tm_secuencial,tm_cod_alterno)
GO


CREATE UNIQUE CLUSTERED INDEX ah_tran_servicio_Key
    ON ah_tran_servicio (ts_tipo_transaccion,ts_clase,ts_secuencial,ts_cod_alterno)
GO


CREATE UNIQUE NONCLUSTERED INDEX ah_tran_servicio_tmp_Key
    ON ah_tran_servicio_tmp (ts_tipo_transaccion,ts_clase,ts_secuencial,ts_cod_alterno)
GO


CREATE UNIQUE CLUSTERED INDEX ah_trn_grupo_Key
    ON ah_trn_grupo (tg_transaccion,tg_grupo)
GO


CREATE UNIQUE CLUSTERED INDEX ah_val_suspenso_Key
    ON ah_val_suspenso (vs_cuenta,vs_secuencial)
GO

CREATE UNIQUE CLUSTERED INDEX ah_cuenta_batch_Key
    ON ah_cuenta_batch (cb_cuenta)
GO

CREATE UNIQUE INDEX i_ah_cuenta_aux
    ON ah_cuenta_aux (ca_cuenta)
GO

CREATE UNIQUE INDEX ah_transacciones_cm_tmp_Key 
    ON ah_transacciones_cm_tmp(tc_secuencial)
GO

CREATE UNIQUE INDEX ah_det_cheq_cm_tmp_Key 
    ON ah_det_cheq_cm_tmp(dc_sec_dep, dc_sec_chq)
GO

CREATE UNIQUE INDEX ah_transacciones_cm_Key 
    ON ah_transacciones_cm(tr_nom_archivo, tr_secuencial)
GO

CREATE UNIQUE INDEX ah_det_cheq_cm_Key 
    ON ah_det_cheq_cm(dc_nom_archivo,dc_sec_dep,dc_sec_chq)
GO

CREATE UNIQUE INDEX ah_log_cm_tran_Key 
    ON ah_log_cm_tran(lc_nom_archivo,lc_ejecucion,lc_sec_tran,lc_sec_chq, lc_num_error)
GO

-- ---------------------------------------------------------------------
-- ------------------------COB_AHORROS_HIS------------------------------
use cob_ahorros_his
go
-- ---------------------------------------------------------------------
-- ---------------------------------------------------------------------

CREATE UNIQUE NONCLUSTERED INDEX ah_his_movimiento_Key
    ON ah_his_movimiento (hm_cta_banco,hm_fecha,hm_transaccion)
GO

