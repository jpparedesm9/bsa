/************************************************************************/
/*      Archivo:            ah_fkey.sql                                 */
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
/*      Este programa realiza la creacion de indices                    */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/

use cob_ahorros
go


CREATE NONCLUSTERED INDEX i_ah_acumulador
    ON ah_acumulador (ac_fecha,ac_trn)
GO

CREATE NONCLUSTERED INDEX idx1
    ON ah_aut_retiro_ofic (ar_cta_banco,ar_fecha)
GO

CREATE NONCLUSTERED INDEX ah_ciudad_deposito_Alt
    ON ah_ciudad_deposito (cd_cuenta,cd_fecha_efe)
GO

CREATE NONCLUSTERED INDEX ah_ciudad_deposito_Alt1
    ON ah_ciudad_deposito (cd_fecha_depo,cd_cuenta)
GO

CREATE NONCLUSTERED INDEX i_idx_ah_condonacion
    ON ah_condonacion (co_cta_banco,co_causa,co_fecha)
GO

CREATE NONCLUSTERED INDEX i_idx_ah_condonacion_ente
    ON ah_condonacion (co_ente,co_fecha)
GO

CREATE NONCLUSTERED INDEX idx1
    ON ah_ctas_cancelar (cc_ctabanco,cc_cliente)
GO

CREATE NONCLUSTERED INDEX ah_cuenta_idx1
    ON ah_cuenta (ah_filial,ah_cuenta)
GO

CREATE NONCLUSTERED INDEX ah_cuenta_idx2
    ON ah_cuenta (ah_filial,ah_oficina)
GO

CREATE NONCLUSTERED INDEX ah_cuenta_idx3
    ON ah_cuenta (ah_filial,ah_fecha_prx_corte)
GO

CREATE NONCLUSTERED INDEX ah_cuenta_idx4
    ON ah_cuenta (ah_estado,ah_filial,ah_fecha_ult_mov)
GO

CREATE NONCLUSTERED INDEX i_ah_cliente
    ON ah_cuenta (ah_cliente)
GO

CREATE NONCLUSTERED INDEX i_ah_oficina
    ON ah_cuenta (ah_oficina,ah_estado)
GO

CREATE NONCLUSTERED INDEX i_ah_servicio_tmp
    ON ah_cuenta_tmp (ah_filial,ah_oficina,ah_moneda,ah_prod_banc,ah_categoria,ah_estado)
GO

CREATE UNIQUE NONCLUSTERED INDEX i_ah_cuenta_tmp
    ON ah_cuenta_tmp (ah_cuenta)
GO

CREATE NONCLUSTERED INDEX ah_errorlog_1
    ON ah_errorlog (er_fecha_proc,er_cuenta)
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_fecha_promedio_alt
    ON ah_fecha_promedio (fp_tipo_promedio,fp_numero_promedio)
GO

CREATE UNIQUE NONCLUSTERED INDEX idx1
    ON ah_param_dtn (pd_sucursal,pd_profinal,pd_categoria,pd_codigo_dtn)
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_relacion_navidad_codigo
    ON ah_relacion_navidad (rn_codigo)
GO

CREATE UNIQUE NONCLUSTERED INDEX idx1
    ON ah_tran_mensual (tm_ano,tm_mes,tm_cuenta,tm_cod_trn)
GO

CREATE NONCLUSTERED INDEX ah_tran_monet_sec
    ON ah_tran_monet (tm_secuencial,tm_cod_alterno)
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_tran_monet_branch
    ON ah_tran_monet (tm_ssn_branch,tm_oficina,tm_cod_alterno)
GO

CREATE NONCLUSTERED INDEX ah_tran_monet_tran
    ON ah_tran_monet (tm_oficina,tm_moneda,tm_tipo_tran,tm_secuencial,tm_cod_alterno)
GO

CREATE NONCLUSTERED INDEX ah_tran_monet_sec_tmp
    ON ah_tran_monet_tmp (tm_secuencial,tm_cod_alterno)
GO

CREATE NONCLUSTERED INDEX ah_tran_monet_tran_tmp
    ON ah_tran_monet_tmp (tm_oficina,tm_moneda,tm_tipo_tran,tm_secuencial,tm_cod_alterno)
GO

CREATE NONCLUSTERED INDEX ah_tran_monet_valor_tmp
    ON ah_tran_monet_tmp (tm_moneda,tm_valor,tm_secuencial,tm_cod_alterno)
GO

CREATE NONCLUSTERED INDEX idx1
    ON ah_tran_rechazos (tr_fecha,tr_cod_cliente)
GO

CREATE NONCLUSTERED INDEX ah_tran_servicio_ofi_cta
    ON ah_tran_servicio (ts_oficina_cta,ts_moneda,ts_cta_banco,ts_tipo_transaccion)
GO

CREATE NONCLUSTERED INDEX ah_tran_servicio_tran
    ON ah_tran_servicio (ts_oficina,ts_moneda,ts_tipo_transaccion,ts_secuencial,ts_cod_alterno)
GO

CREATE NONCLUSTERED INDEX ah_tran_servicio_ofi_cta_tmp
    ON ah_tran_servicio_tmp (ts_oficina_cta,ts_moneda,ts_cta_banco,ts_tipo_transaccion)
GO

CREATE NONCLUSTERED INDEX ah_tran_servicio_tran_tmp
    ON ah_tran_servicio_tmp (ts_oficina,ts_moneda,ts_tipo_transaccion,ts_secuencial,ts_cod_alterno)
GO

CREATE UNIQUE NONCLUSTERED INDEX idx1
    ON ah_trn_deposito_inicial (di_tran,di_causal)
GO

CREATE NONCLUSTERED INDEX idx1
    ON ah_universo_ahmensual (hijo,orden)
GO

CREATE NONCLUSTERED INDEX i_vs_ssn
    ON ah_val_suspenso (vs_fecha,vs_ssn)
GO

CREATE NONCLUSTERED INDEX if_cp_campoah
    ON cp_campoah (cc_transaccion)
GO

CREATE NONCLUSTERED INDEX if_cp_campoah_monet
    ON cp_campoah_monetario (ah_transaccion_m)
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_report_ctas_key
	ON ah_report_ctas (w_ah_cuenta,w_ah_cta_banco)
GO

-- ---------------------------------------------------------------------
-- ------------------------COB_AHORROS_HIS------------------------------
use cob_ahorros_his
go
-- ---------------------------------------------------------------------
-- ---------------------------------------------------------------------

CREATE UNIQUE NONCLUSTERED INDEX ah_his_movimiento_1
    ON ah_his_movimiento (hm_fecha,hm_oficina,hm_moneda,hm_tipo_tran,hm_transaccion)
GO
