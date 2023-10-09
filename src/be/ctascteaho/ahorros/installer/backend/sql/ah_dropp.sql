/************************************************************************/
/*      Archivo:            ah_dropp.sql                                */
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


if exists( select 1 from sysindexes where name='ah_acumulador_Key')
    drop index ah_acumulador.ah_acumulador_Key
 go 

 
 
if exists( select 1 from sysindexes where name='ah_alicuota_Key')
    drop index ah_alicuota.ah_alicuota_Key
 go 

if exists( select 1 from sysindexes where name='ah_apertura_cta_Key')
    drop index ah_apertura_cta.ah_apertura_cta_Key
 go 
 

if exists( select 1 from sysindexes where name='ah_beneficiario_cta_Key')
    drop index ah_beneficiario_cta.ah_beneficiario_cta_Key
 go 

if exists( select 1 from sysindexes where name='ah_caja_Key')
    drop index ah_caja.ah_caja_Key
 go 
 

if exists( select 1 from sysindexes where name='ah_ciudad_deposito_Key')
    drop index ah_ciudad_deposito.ah_ciudad_deposito_Key
 go 

if exists( select 1 from sysindexes where name='ah_clicta_solicitud_Key')
    drop index ah_clicta_solicitud.ah_clicta_solicitud_Key
 go 

 
if exists( select 1 from sysindexes where name='ah_ctabloqueada_Key')
    drop index ah_ctabloqueada.ah_ctabloqueada_Key
 go 

if exists( select 1 from sysindexes where name='ah_cuenta_Key')
    drop index ah_cuenta.ah_cuenta_Key
 go 

 
if exists( select 1 from sysindexes where name='ah_cuenta_navidad_Key')
    drop index ah_cuenta_navidad.ah_cuenta_navidad_Key
 go 

if exists( select 1 from sysindexes where name='ah_cuenta_tmp_Key')
    drop index ah_cuenta_tmp.ah_cuenta_tmp_Key
 go 

if exists( select 1 from sysindexes where name='ah_cuenta_tmp1_Key')
    drop index ah_cuenta_tmp1.ah_cuenta_tmp1_Key
 go 

if exists( select 1 from sysindexes where name='ah_cuentas_subsidiarias_key')
    drop index ah_cuentas_subsidiarias.ah_cuentas_subsidiarias_key
 go 

if exists( select 1 from sysindexes where name='ah_datos_adic_Key')
    drop index ah_datos_adic.ah_datos_adic_Key
 go 

if exists( select 1 from sysindexes where name='ah_dep_difer_Key')
    drop index ah_dep_difer.ah_dep_difer_Key
 go 

if exists( select 1 from sysindexes where name='ah_dev_recaudos_cb_Key')
    drop index ah_dev_recaudos_cb.ah_dev_recaudos_cb_Key
 go 

if exists( select 1 from sysindexes where name='ah_dias_laborables_Key')
    drop index ah_dias_laborables.ah_dias_laborables_Key
 go 

if exists( select 1 from sysindexes where name='ah_embargo_Key')
    drop index ah_embargo.ah_embargo_Key
 go 
 
if exists( select 1 from sysindexes where name='ah_estado_cta_Key')
    drop index ah_estado_cta.ah_estado_cta_Key
 go 

 if exists( select 1 from sysindexes where name='ah_det_estado_cuenta_Key')
    drop index ah_det_estado_cuenta.ah_det_estado_cuenta_Key
 go 
 
if exists( select 1 from sysindexes where name='ah_exenta_gmf_key')
    drop index ah_exenta_gmf.ah_exenta_gmf_key
 go 

if exists( select 1 from sysindexes where name='ah_exenta_gmf_keyCta')
    drop index ah_exenta_gmf.ah_exenta_gmf_keyCta
 go 

if exists( select 1 from sysindexes where name='ah_fecha_periodo_Key')
    drop index ah_fecha_periodo.ah_fecha_periodo_Key
 go 

if exists( select 1 from sysindexes where name='ah_fecha_promedio_Key')
    drop index ah_fecha_promedio.ah_fecha_promedio_Key
 go 
 
if exists( select 1 from sysindexes where name='ah_fecha_valor_Key')
    drop index ah_fecha_valor.ah_fecha_valor_Key
 go 

if exists( select 1 from sysindexes where name='ah_his_bloqueo_Key')
    drop index ah_his_bloqueo.ah_his_bloqueo_Key
 go 

if exists( select 1 from sysindexes where name='ah_his_cierre_Key')
    drop index ah_his_cierre.ah_his_cierre_Key
 go 

if exists( select 1 from sysindexes where name='ah_his_lineacred_Key')
    drop index ah_his_lineacred.ah_his_lineacred_Key
 go 

if exists( select 1 from sysindexes where name='ah_cuenta_plan_Key')
    drop index ah_imprime_plan.ah_cuenta_plan_Key
 go 

if exists( select 1 from sysindexes where name='ah_linea_pendiente_Key')
    drop index ah_linea_pendiente.ah_linea_pendiente_Key
 go 

if exists( select 1 from sysindexes where name='ah_oficina_ctas_cifradas_Key')
    drop index ah_oficina_ctas_cifradas.ah_oficina_ctas_cifradas_Key
 go 
 
if exists( select 1 from sysindexes where name='ah_rangos_saldos_Key')
    drop index ah_rangos_saldos.ah_rangos_saldos_Key
 go 

if exists( select 1 from sysindexes where name='ah_relacion_navidad_Key')
    drop index ah_relacion_navidad.ah_relacion_navidad_Key
 go 
 
if exists( select 1 from sysindexes where name='ah_reporte_devolucion_tmp_Key')
    drop index ah_reporte_devolucion_tmp.ah_reporte_devolucion_tmp_Key
 go 

if exists( select 1 from sysindexes where name='cc_retencion_locales_Key')
    drop index ah_retencion_locales.cc_retencion_locales_Key
 go 

if exists( select 1 from sysindexes where name='ah_solicitud_cuenta_Key')
    drop index ah_solicitud_cuenta.ah_solicitud_cuenta_Key
 go 

if exists( select 1 from sysindexes where name='ah_sorteo_agrob_Key')
    drop index ah_sorteo_agrob.ah_sorteo_agrob_Key
 go 

if exists( select 1 from sysindexes where name='ah_tipotrx_mes_Key')
    drop index ah_tipotrx_mes.ah_tipotrx_mes_Key
 go 
 
if exists( select 1 from sysindexes where name='ah_tran_monet_tmp_Key')
    drop index ah_tran_monet_tmp.ah_tran_monet_tmp_Key
 go 

if exists( select 1 from sysindexes where name='ah_tran_servicio_Key')
    drop index ah_tran_servicio.ah_tran_servicio_Key
 go 

if exists( select 1 from sysindexes where name='ah_tran_servicio_tmp_Key')
    drop index ah_tran_servicio_tmp.ah_tran_servicio_tmp_Key
 go 

if exists( select 1 from sysindexes where name='ah_trn_grupo_Key')
    drop index ah_trn_grupo.ah_trn_grupo_Key
 go 

if exists( select 1 from sysindexes where name='ah_val_suspenso_Key')
    drop index ah_val_suspenso.ah_val_suspenso_Key
 go 
 
if exists( select 1 from sysindexes where name='ah_cuenta_batch_Key')
    drop index ah_cuenta_batch.ah_cuenta_batch_Key
 go

if exists( select 1 from sysindexes where name='ah_tran_monet_Key')
    drop index ah_tran_monet.ah_tran_monet_Key
 go 

if exists( select 1 from sysindexes where name='i_ah_nombre')
    drop index ah_cuenta.i_ah_nombre
 go

if exists( select 1 from sysindexes where name='i_ah_cuenta')
    drop index ah_cuenta.i_ah_cuenta
 go 

if exists (select 1 from sysindexes where name = 'ah_transacciones_cm_tmp_Key')
    drop index ah_transacciones_cm_tmp.ah_transacciones_cm_tmp_Key
go

if exists (select 1 from sysindexes where name = 'ah_det_cheq_cm_tmp_Key')
    drop index ah_det_cheq_cm_tmp.ah_det_cheq_cm_tmp_Key
go
 
if exists (select 1 from sysindexes where name = 'ah_transacciones_cm_Key')
    drop index ah_transacciones_cm.ah_transacciones_cm_Key
go

if exists (select 1 from sysindexes where name = 'ah_det_cheq_cm_Key')
    drop index ah_det_cheq_cm.ah_det_cheq_cm_Key
go

if exists (select 1 from sysindexes where name = 'ah_log_cm_tran_Key')
    drop index ah_log_cm_tran.ah_log_cm_tran_Key
go

-- ---------------------------------------------------------------------
-- ------------------------COB_AHORROS_HIS------------------------------
use cob_ahorros_his
go
-- ---------------------------------------------------------------------
-- ---------------------------------------------------------------------

if exists( select 1 from sysindexes where name='ah_his_movimiento_Key')
    drop index ah_his_movimiento.ah_his_movimiento_Key
 go