/************************************************************************/
/*      Archivo:            ah_dropt.sql                                */
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
/*      Este programa realiza la eliminacion de tablas                  */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cob_ahorros
go

/* ah_acumulador1 */
print '=====> ah_acumulador1'
go
if exists (select * from sysobjects where name = 'ah_acumulador1') 
 drop table ah_acumulador1
go 

/* ah_marca_debit_aut */
print '=====> ah_marca_debit_aut'
go
if exists (select * from sysobjects where name = 'ah_marca_debit_aut') 
 drop table ah_marca_debit_aut
go 

/* ah_acumulador2 */
print '=====> ah_acumulador2'
go
if exists (select * from sysobjects where name = 'ah_acumulador2') 
 drop table ah_acumulador2
go 

/* ah_acumulador3 */
print '=====> ah_acumulador3'
go
if exists (select * from sysobjects where name = 'ah_acumulador3') 
 drop table ah_acumulador3
go 

/* ah_acumulador4 */
print '=====> ah_acumulador4'
go
if exists (select * from sysobjects where name = 'ah_acumulador4') 
 drop table ah_acumulador4
go 

/* ah_val_suspenso1 */
print '=====> ah_val_suspenso1'
go
if exists (select * from sysobjects where name = 'ah_val_suspenso1') 
 drop table ah_val_suspenso1
go 

/* ah_val_suspenso2 */
print '=====> ah_val_suspenso2'
go
if exists (select * from sysobjects where name = 'ah_val_suspenso2') 
 drop table ah_val_suspenso2
go 

/* ah_cuenta_borrar */
print '=====> ah_cuenta_borrar'
go
if exists (select * from sysobjects where name = 'ah_cuenta_borrar') 
 drop table ah_cuenta_borrar
go 

/* ah_val_suspenso3 */
print '=====> ah_val_suspenso3'
go
if exists (select * from sysobjects where name = 'ah_val_suspenso3') 
 drop table ah_val_suspenso3
go 

/* ah_val_suspenso4 */
print '=====> ah_val_suspenso4'
go
if exists (select * from sysobjects where name = 'ah_val_suspenso4') 
 drop table ah_val_suspenso4
go 

/* ah_carga_archivo_cuentas_tmp320_arch */
print '=====> ah_carga_archivo_cuentas_tmp320_arch'
go
if exists (select * from sysobjects where name = 'ah_carga_archivo_cuentas_tmp320_arch') 
 drop table ah_carga_archivo_cuentas_tmp320_arch
go 

/* ah_universo_ahmensual */
print '=====> ah_universo_ahmensual'
go
if exists (select * from sysobjects where name = 'ah_universo_ahmensual') 
 drop table ah_universo_ahmensual
go 

/* ah_his_inmovilizadas1 */
print '=====> ah_his_inmovilizadas1'
go
if exists (select * from sysobjects where name = 'ah_his_inmovilizadas1') 
 drop table ah_his_inmovilizadas1
go 

/* ah_his_inmovilizadas2 */
print '=====> ah_his_inmovilizadas2'
go
if exists (select * from sysobjects where name = 'ah_his_inmovilizadas2') 
 drop table ah_his_inmovilizadas2
go 

/* ah_his_inmovilizadas3 */
print '=====> ah_his_inmovilizadas3'
go
if exists (select * from sysobjects where name = 'ah_his_inmovilizadas3') 
 drop table ah_his_inmovilizadas3
go 

/* ah_anula_ord_pag */
print '=====> ah_anula_ord_pag'
go
if exists (select * from sysobjects where name = 'ah_anula_ord_pag') 
 drop table ah_anula_ord_pag
go 

/* ah_his_inmovilizadas4 */
print '=====> ah_his_inmovilizadas4'
go
if exists (select * from sysobjects where name = 'ah_his_inmovilizadas4') 
 drop table ah_his_inmovilizadas4
go 

/* ah_cta_gmf_tmp */
print '=====> ah_cta_gmf_tmp'
go
if exists (select * from sysobjects where name = 'ah_cta_gmf_tmp') 
 drop table ah_cta_gmf_tmp
go 

/* ah_saldo_diario1 */
print '=====> ah_saldo_diario1'
go
if exists (select * from sysobjects where name = 'ah_saldo_diario1') 
 drop table ah_saldo_diario1
go 

/* ah_datos_gmf_tmp */
print '=====> ah_datos_gmf_tmp'
go
if exists (select * from sysobjects where name = 'ah_datos_gmf_tmp') 
 drop table ah_datos_gmf_tmp
go 

/* tmp_compensacion */
print '=====> tmp_compensacion'
go
if exists (select * from sysobjects where name = 'tmp_compensacion') 
 drop table tmp_compensacion
go 

/* ah_saldo_diario2 */
print '=====> ah_saldo_diario2'
go
if exists (select * from sysobjects where name = 'ah_saldo_diario2') 
 drop table ah_saldo_diario2
go 

/* ah_saldo_diario3 */
print '=====> ah_saldo_diario3'
go
if exists (select * from sysobjects where name = 'ah_saldo_diario3') 
 drop table ah_saldo_diario3
go 

/* ah_saldo_diario4 */
print '=====> ah_saldo_diario4'
go
if exists (select * from sysobjects where name = 'ah_saldo_diario4') 
 drop table ah_saldo_diario4
go 

/* ah_saldos_rep1 */
print '=====> ah_saldos_rep1'
go
if exists (select * from sysobjects where name = 'ah_saldos_rep1') 
 drop table ah_saldos_rep1
go 

/* ah_saldos_rep2 */
print '=====> ah_saldos_rep2'
go
if exists (select * from sysobjects where name = 'ah_saldos_rep2') 
 drop table ah_saldos_rep2
go 

/* ah_rep_cta_dtn */
print '=====> ah_rep_cta_dtn'
go
if exists (select * from sysobjects where name = 'ah_rep_cta_dtn') 
 drop table ah_rep_cta_dtn
go 

/* ah_imprime_plan_backup */
print '=====> ah_imprime_plan_backup'
go
if exists (select * from sysobjects where name = 'ah_imprime_plan_backup') 
 drop table ah_imprime_plan_backup
go 

/* ah_saldos_rep3 */
print '=====> ah_saldos_rep3'
go
if exists (select * from sysobjects where name = 'ah_saldos_rep3') 
 drop table ah_saldos_rep3
go 

/* cc_backup */
print '=====> cc_backup'
go
if exists (select * from sysobjects where name = 'cc_backup') 
 drop table cc_backup
go 

/* ah_saldos_rep4 */
print '=====> ah_saldos_rep4'
go
if exists (select * from sysobjects where name = 'ah_saldos_rep4') 
 drop table ah_saldos_rep4
go 

/* ah_seg_plan */
print '=====> ah_seg_plan'
go
if exists (select * from sysobjects where name = 'ah_seg_plan') 
 drop table ah_seg_plan
go 

/* re_error_batch1 */
print '=====> re_error_batch1'
go
if exists (select * from sysobjects where name = 're_error_batch1') 
 drop table re_error_batch1
go 

/* tmp_detalle_dtn */
print '=====> tmp_detalle_dtn'
go
if exists (select * from sysobjects where name = 'tmp_detalle_dtn') 
 drop table tmp_detalle_dtn
go 

/* ah_rep_rex */
print '=====> ah_rep_rex'
go
if exists (select * from sysobjects where name = 'ah_rep_rex') 
 drop table ah_rep_rex
go 

/* ah_reporte_plan */
print '=====> ah_reporte_plan'
go
if exists (select * from sysobjects where name = 'ah_reporte_plan') 
 drop table ah_reporte_plan
go 

/* re_error_batch2 */
print '=====> re_error_batch2'
go
if exists (select * from sysobjects where name = 're_error_batch2') 
 drop table re_error_batch2
go 

/* ah_errores_rr */
print '=====> ah_errores_rr'
go
if exists (select * from sysobjects where name = 'ah_errores_rr') 
 drop table ah_errores_rr
go 

/* ah_reporte_plan_incump */
print '=====> ah_reporte_plan_incump'
go
if exists (select * from sysobjects where name = 'ah_reporte_plan_incump') 
 drop table ah_reporte_plan_incump
go 

/* re_error_batch3 */
print '=====> re_error_batch3'
go
if exists (select * from sysobjects where name = 're_error_batch3') 
 drop table re_error_batch3
go 

/* ah_reporte_plan_venc */
print '=====> ah_reporte_plan_venc'
go
if exists (select * from sysobjects where name = 'ah_reporte_plan_venc') 
 drop table ah_reporte_plan_venc
go 

/* re_error_batch4 */
print '=====> re_error_batch4'
go
if exists (select * from sysobjects where name = 're_error_batch4') 
 drop table re_error_batch4
go 

/* ah_cuenta_cumple_tmp */
print '=====> ah_cuenta_cumple_tmp'
go
if exists (select * from sysobjects where name = 'ah_cuenta_cumple_tmp') 
 drop table ah_cuenta_cumple_tmp
go 

/* cp_campoah */
print '=====> cp_campoah'
go
if exists (select * from sysobjects where name = 'cp_campoah') 
 drop table cp_campoah
go 

/* cp_campoah_monetario */
print '=====> cp_campoah_monetario'
go
if exists (select * from sysobjects where name = 'cp_campoah_monetario') 
 drop table cp_campoah_monetario
go 

/* ah_rep_tran_caja */
print '=====> ah_rep_tran_caja'
go
if exists (select * from sysobjects where name = 'ah_rep_tran_caja') 
 drop table ah_rep_tran_caja
go 

/* ah_dias_laborables */
print '=====> ah_dias_laborables'
go
if exists (select * from sysobjects where name = 'ah_dias_laborables') 
 drop table ah_dias_laborables
go 

/* ah_ext_masivos */
print '=====> ah_ext_masivos'
go
if exists (select * from sysobjects where name = 'ah_ext_masivos') 
 drop table ah_ext_masivos
go 

/* extracto_ahorros_tmp */
print '=====> extracto_ahorros_tmp'
go
if exists (select * from sysobjects where name = 'extracto_ahorros_tmp') 
 drop table extracto_ahorros_tmp
go 

/* ah_ext_masivos_tmp */
print '=====> ah_ext_masivos_tmp'
go
if exists (select * from sysobjects where name = 'ah_ext_masivos_tmp') 
 drop table ah_ext_masivos_tmp
go 

/* ah_ofica */
print '=====> ah_ofica'
go
if exists (select * from sysobjects where name = 'ah_ofica') 
 drop table ah_ofica
go 

/* ah_saldos_cta */
print '=====> ah_saldos_cta'
go
if exists (select * from sysobjects where name = 'ah_saldos_cta') 
 drop table ah_saldos_cta
go 

/* ah_tran_monet */
print '=====> ah_tran_monet'
go
if exists (select * from sysobjects where name = 'ah_tran_monet') 
 drop table ah_tran_monet
go 

/* ah_tran_monet_tmp */
print '=====> ah_tran_monet_tmp'
go
if exists (select * from sysobjects where name = 'ah_tran_monet_tmp') 
 drop table ah_tran_monet_tmp
go 

/* ah_notcredeb1 */
print '=====> ah_notcredeb1'
go
if exists (select * from sysobjects where name = 'ah_notcredeb1') 
 drop table ah_notcredeb1
go 

/* ah_notcredeb2 */
print '=====> ah_notcredeb2'
go
if exists (select * from sysobjects where name = 'ah_notcredeb2') 
 drop table ah_notcredeb2
go 

/* ah_apertura_cta */
print '=====> ah_apertura_cta'
go
if exists (select * from sysobjects where name = 'ah_apertura_cta') 
 drop table ah_apertura_cta
go 

/* ah_notcredeb3 */
print '=====> ah_notcredeb3'
go
if exists (select * from sysobjects where name = 'ah_notcredeb3') 
 drop table ah_notcredeb3
go 

/* ah_arch_facturacion */
print '=====> ah_arch_facturacion'
go
if exists (select * from sysobjects where name = 'ah_arch_facturacion') 
 drop table ah_arch_facturacion
go 

/* ah_notcredeb4 */
print '=====> ah_notcredeb4'
go
if exists (select * from sysobjects where name = 'ah_notcredeb4') 
 drop table ah_notcredeb4
go 

/* ah_arch_movimientos */
print '=====> ah_arch_movimientos'
go
if exists (select * from sysobjects where name = 'ah_arch_movimientos') 
 drop table ah_arch_movimientos
go 

/* ah_tran_servicio */
print '=====> ah_tran_servicio'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio') 
 drop table ah_tran_servicio
go 

/* ah_dev_recaudos_cb */
print '=====> ah_dev_recaudos_cb'
go
if exists (select * from sysobjects where name = 'ah_dev_recaudos_cb') 
 drop table ah_dev_recaudos_cb
go 

/* ah_tran_servicio_tmp */
print '=====> ah_tran_servicio_tmp'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio_tmp') 
 drop table ah_tran_servicio_tmp
go 

/* ah_error_arch_red */
print '=====> ah_error_arch_red'
go
if exists (select * from sysobjects where name = 'ah_error_arch_red') 
 drop table ah_error_arch_red
go 

/* ah_mov_tarj_cobis */
print '=====> ah_mov_tarj_cobis'
go
if exists (select * from sysobjects where name = 'ah_mov_tarj_cobis') 
 drop table ah_mov_tarj_cobis
go 

/* ah_mov_tarj_red */
print '=====> ah_mov_tarj_red'
go
if exists (select * from sysobjects where name = 'ah_mov_tarj_red') 
 drop table ah_mov_tarj_red
go 

/* ah_reporte_devolucion_tmp */
print '=====> ah_reporte_devolucion_tmp'
go
if exists (select * from sysobjects where name = 'ah_reporte_devolucion_tmp') 
 drop table ah_reporte_devolucion_tmp
go 

/* tmp_consulta_mov_cb */
print '=====> tmp_consulta_mov_cb'
go
if exists (select * from sysobjects where name = 'tmp_consulta_mov_cb') 
 drop table tmp_consulta_mov_cb
go 

/* tmp_movimiento_svb */
print '=====> tmp_movimiento_svb'
go
if exists (select * from sysobjects where name = 'tmp_movimiento_svb') 
 drop table tmp_movimiento_svb
go 

/* ah_tran_servicio2 */
print '=====> ah_tran_servicio2'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio2') 
 drop table ah_tran_servicio2
go 

/* ah_tran_servicio3 */
print '=====> ah_tran_servicio3'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio3') 
 drop table ah_tran_servicio3
go 

/* ah_tran_servicio4 */
print '=====> ah_tran_servicio4'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio4') 
 drop table ah_tran_servicio4
go 

/* ah_tsval_suspenso1 */
print '=====> ah_tsval_suspenso1'
go
if exists (select * from sysobjects where name = 'ah_tsval_suspenso1') 
 drop table ah_tsval_suspenso1
go 

/* ah_tsval_suspenso2 */
print '=====> ah_tsval_suspenso2'
go
if exists (select * from sysobjects where name = 'ah_tsval_suspenso2') 
 drop table ah_tsval_suspenso2
go 

/* ah_tsval_suspenso3 */
print '=====> ah_tsval_suspenso3'
go
if exists (select * from sysobjects where name = 'ah_tsval_suspenso3') 
 drop table ah_tsval_suspenso3
go 

/* ah_tsval_suspenso4 */
print '=====> ah_tsval_suspenso4'
go
if exists (select * from sysobjects where name = 'ah_tsval_suspenso4') 
 drop table ah_tsval_suspenso4
go 

/* ah_compensacion_actpas */
print '=====> ah_compensacion_actpas'
go
if exists (select * from sysobjects where name = 'ah_compensacion_actpas') 
 drop table ah_compensacion_actpas
go 

/* ah_saldoscompensa_actpas */
print '=====> ah_saldoscompensa_actpas'
go
if exists (select * from sysobjects where name = 'ah_saldoscompensa_actpas') 
 drop table ah_saldoscompensa_actpas
go 

/* ah_reporte_aho_cab */
print '=====> ah_reporte_aho_cab'
go
if exists (select * from sysobjects where name = 'ah_reporte_aho_cab') 
 drop table ah_reporte_aho_cab
go 

/* ah_tran_monet_tmp1 */
print '=====> ah_tran_monet_tmp1'
go
if exists (select * from sysobjects where name = 'ah_tran_monet_tmp1') 
 drop table ah_tran_monet_tmp1
go 

/* ah_tran_servicio1 */
print '=====> ah_tran_servicio1'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio1') 
 drop table ah_tran_servicio1
go 

/* ah_solicitud_cuenta */
print '=====> ah_solicitud_cuenta'
go
if exists (select * from sysobjects where name = 'ah_solicitud_cuenta') 
 drop table ah_solicitud_cuenta
go 

/* ah_clicta_solicitud */
print '=====> ah_clicta_solicitud'
go
if exists (select * from sysobjects where name = 'ah_clicta_solicitud') 
 drop table ah_clicta_solicitud
go 

/* ah_relacion_navidad */
print '=====> ah_relacion_navidad'
go
if exists (select * from sysobjects where name = 'ah_relacion_navidad') 
 drop table ah_relacion_navidad
go 

/* ah_cuenta_navidad */
print '=====> ah_cuenta_navidad'
go
if exists (select * from sysobjects where name = 'ah_cuenta_navidad') 
 drop table ah_cuenta_navidad
go 

/* ah_alicuota */
print '=====> ah_alicuota'
go
if exists (select * from sysobjects where name = 'ah_alicuota') 
 drop table ah_alicuota
go 

/* ah_caja */
print '=====> ah_caja'
go
if exists (select * from sysobjects where name = 'ah_caja') 
 drop table ah_caja
go 

/* ah_trn_grupo */
print '=====> ah_trn_grupo'
go
if exists (select * from sysobjects where name = 'ah_trn_grupo') 
 drop table ah_trn_grupo
go 

/* ah_grupo */
print '=====> ah_grupo'
go
if exists (select * from sysobjects where name = 'ah_grupo') 
 drop table ah_grupo
go 

/* ah_ctabloqueada */
print '=====> ah_ctabloqueada'
go
if exists (select * from sysobjects where name = 'ah_ctabloqueada') 
 drop table ah_ctabloqueada
go 

/* ah_cuenta */
print '=====> ah_cuenta'
go
if exists (select * from sysobjects where name = 'ah_cuenta') 
 drop table ah_cuenta
go 

/* ah_cuenta_tmp */
print '=====> ah_cuenta_tmp'
go
if exists (select * from sysobjects where name = 'ah_cuenta_tmp') 
 drop table ah_cuenta_tmp
go 

/* ah_cuenta_tmp1 */
print '=====> ah_cuenta_tmp1'
go
if exists (select * from sysobjects where name = 'ah_cuenta_tmp1') 
 drop table ah_cuenta_tmp1
go 

/* ah_periodo */
print '=====> ah_periodo'
go
if exists (select * from sysobjects where name = 'ah_periodo') 
 drop table ah_periodo
go 

/* ah_ano */
print '=====> ah_ano'
go
if exists (select * from sysobjects where name = 'ah_ano') 
 drop table ah_ano
go 

/* ah_his_bloqueo */
print '=====> ah_his_bloqueo'
go
if exists (select * from sysobjects where name = 'ah_his_bloqueo') 
 drop table ah_his_bloqueo
go 

/* ah_cta_prog */
print '=====> ah_cta_prog'
go
if exists (select * from sysobjects where name = 'ah_cta_prog') 
 drop table ah_cta_prog
go 

/* ah_resumen_ctacontrac */
print '=====> ah_resumen_ctacontrac'
go
if exists (select * from sysobjects where name = 'ah_resumen_ctacontrac') 
 drop table ah_resumen_ctacontrac
go 

/* ah_his_cierre */
print '=====> ah_his_cierre'
go
if exists (select * from sysobjects where name = 'ah_his_cierre') 
 drop table ah_his_cierre
go 

/* ah_trn_deposito_inicial */
print '=====> ah_trn_deposito_inicial'
go
if exists (select * from sysobjects where name = 'ah_trn_deposito_inicial') 
 drop table ah_trn_deposito_inicial
go 

/* ah_imprime_plan */
print '=====> ah_imprime_plan'
go
if exists (select * from sysobjects where name = 'ah_imprime_plan') 
 drop table ah_imprime_plan
go 

/* ah_his_inmovilizadas */
print '=====> ah_his_inmovilizadas'
go
if exists (select * from sysobjects where name = 'ah_his_inmovilizadas') 
 drop table ah_his_inmovilizadas
go 

/* cuentas_gmf */
print '=====> cuentas_gmf'
go
if exists (select * from sysobjects where name = 'cuentas_gmf') 
 drop table cuentas_gmf
go 

/* ah_his_lineacred */
print '=====> ah_his_lineacred'
go
if exists (select * from sysobjects where name = 'ah_his_lineacred') 
 drop table ah_his_lineacred
go 

/* ah_interfase */
print '=====> ah_interfase'
go
if exists (select * from sysobjects where name = 'ah_interfase') 
 drop table ah_interfase
go 

/* tmp_datos_aho_407 */
print '=====> tmp_datos_aho_407'
go
if exists (select * from sysobjects where name = 'tmp_datos_aho_407') 
 drop table tmp_datos_aho_407
go 

/* ah_lincredito */
print '=====> ah_lincredito'
go
if exists (select * from sysobjects where name = 'ah_lincredito') 
 drop table ah_lincredito
go 

/* ah_linea_pendiente */
print '=====> ah_linea_pendiente'
go
if exists (select * from sysobjects where name = 'ah_linea_pendiente') 
 drop table ah_linea_pendiente
go 

/* ah_servicio */
print '=====> ah_servicio'
go
if exists (select * from sysobjects where name = 'ah_servicio') 
 drop table ah_servicio
go 

/* ah_val_suspenso */
print '=====> ah_val_suspenso'
go
if exists (select * from sysobjects where name = 'ah_val_suspenso') 
 drop table ah_val_suspenso
go 

/* ah_act_capitalizacion */
print '=====> ah_act_capitalizacion'
go
if exists (select * from sysobjects where name = 'ah_act_capitalizacion') 
 drop table ah_act_capitalizacion
go 

/* ah_usa_linea */
print '=====> ah_usa_linea'
go
if exists (select * from sysobjects where name = 'ah_usa_linea') 
 drop table ah_usa_linea
go 

/* ah_consolidado */
print '=====> ah_consolidado'
go
if exists (select * from sysobjects where name = 'ah_consolidado') 
 drop table ah_consolidado
go 

/* ah_cuenta_ORS1266 */
print '=====> ah_cuenta_ORS1266'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ORS1266') 
 drop table ah_cuenta_ORS1266
go 

/* ah_ctas_cancelar_his */
print '=====> ah_ctas_cancelar_his'
go
if exists (select * from sysobjects where name = 'ah_ctas_cancelar_his') 
 drop table ah_ctas_cancelar_his
go 

/* ah_estado_cta */
print '=====> ah_estado_cta'
go
if exists (select * from sysobjects where name = 'ah_estado_cta') 
 drop table ah_estado_cta
go 

/* ah_cuenta_ors_1272_1 */
print '=====> ah_cuenta_ors_1272_1'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1272_1') 
 drop table ah_cuenta_ors_1272_1
go 

/* tmp_plano_aho */
print '=====> tmp_plano_aho'
go
if exists (select * from sysobjects where name = 'tmp_plano_aho') 
 drop table tmp_plano_aho
go 

/* ah_cuenta_ors_1239_1 */
print '=====> ah_cuenta_ors_1239_1'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1239_1') 
 drop table ah_cuenta_ors_1239_1
go 

/* ah_dep_difer */
print '=====> ah_dep_difer'
go
if exists (select * from sysobjects where name = 'ah_dep_difer') 
 drop table ah_dep_difer
go 

/* ah_param_dtn */
print '=====> ah_param_dtn'
go
if exists (select * from sysobjects where name = 'ah_param_dtn') 
 drop table ah_param_dtn
go 

/* ah_cuenta_ors_1272_2 */
print '=====> ah_cuenta_ors_1272_2'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1272_2') 
 drop table ah_cuenta_ors_1272_2
go 

/* tmp_transacciones */
print '=====> tmp_transacciones'
go
if exists (select * from sysobjects where name = 'tmp_transacciones') 
 drop table tmp_transacciones
go 

/* ah_cuenta_ors_1239_2 */
print '=====> ah_cuenta_ors_1239_2'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1239_2') 
 drop table ah_cuenta_ors_1239_2
go 

/* ah_acumulador */
print '=====> ah_acumulador'
go
if exists (select * from sysobjects where name = 'ah_acumulador') 
 drop table ah_acumulador
go 

/* ah_reporte_aho */
print '=====> ah_reporte_aho'
go
if exists (select * from sysobjects where name = 'ah_reporte_aho') 
 drop table ah_reporte_aho
go 

/* ah_ctas_actualizar */
print '=====> ah_ctas_actualizar'
go
if exists (select * from sysobjects where name = 'ah_ctas_actualizar') 
 drop table ah_ctas_actualizar
go 

/* ah_cuenta_ors_1246_1 */
print '=====> ah_cuenta_ors_1246_1'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1246_1') 
 drop table ah_cuenta_ors_1246_1
go 

/* re_error_batch */
print '=====> re_error_batch'
go
if exists (select * from sysobjects where name = 're_error_batch') 
 drop table re_error_batch
go 

/* ah_cuenta_ORS1271 */
print '=====> ah_cuenta_ORS1271'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ORS1271') 
 drop table ah_cuenta_ORS1271
go 

/* ah_cuenta_ors_1246_2 */
print '=====> ah_cuenta_ors_1246_2'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1246_2') 
 drop table ah_cuenta_ors_1246_2
go 

/* ah_ciudad_deposito */
print '=====> ah_ciudad_deposito'
go
if exists (select * from sysobjects where name = 'ah_ciudad_deposito') 
 drop table ah_ciudad_deposito
go 

/* ah_cuenta_ors_1297_1 */
print '=====> ah_cuenta_ors_1297_1'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1297_1') 
 drop table ah_cuenta_ors_1297_1
go 

/* ah_cuenta_ors_1251_1 */
print '=====> ah_cuenta_ors_1251_1'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1251_1') 
 drop table ah_cuenta_ors_1251_1
go 

/* ah_fecha_valor */
print '=====> ah_fecha_valor'
go
if exists (select * from sysobjects where name = 'ah_fecha_valor') 
 drop table ah_fecha_valor
go 

/* ah_cuenta_ors_1297_2 */
print '=====> ah_cuenta_ors_1297_2'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1297_2') 
 drop table ah_cuenta_ors_1297_2
go 

/* ah_cuenta_ors_1251_2 */
print '=====> ah_cuenta_ors_1251_2'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1251_2') 
 drop table ah_cuenta_ors_1251_2
go 

/* ah_saldos_rep */
print '=====> ah_saldos_rep'
go
if exists (select * from sysobjects where name = 'ah_saldos_rep') 
 drop table ah_saldos_rep
go 

/* ah_cuenta_ticket_0262203 */
print '=====> ah_cuenta_ticket_0262203'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ticket_0262203') 
 drop table ah_cuenta_ticket_0262203
go 

/* ah_reporte_comercio_cta */
print '=====> ah_reporte_comercio_cta'
go
if exists (select * from sysobjects where name = 'ah_reporte_comercio_cta') 
 drop table ah_reporte_comercio_cta
go 

/* ah_cuenta_batch */
print '=====> ah_cuenta_batch'
go
if exists (select * from sysobjects where name = 'ah_cuenta_batch') 
 drop table ah_cuenta_batch
go 

/* ah_error_conta */
print '=====> ah_error_conta'
go
if exists (select * from sysobjects where name = 'ah_error_conta') 
 drop table ah_error_conta
go 

/* cl_conjunta */
print '=====> cl_conjunta'
go
if exists (select * from sysobjects where name = 'cl_conjunta') 
 drop table cl_conjunta
go 

/* ah_abono_cuentas_inc */
print '=====> ah_abono_cuentas_inc'
go
if exists (select * from sysobjects where name = 'ah_abono_cuentas_inc') 
 drop table ah_abono_cuentas_inc
go 

/* ah_log_ctas_act */
print '=====> ah_log_ctas_act'
go
if exists (select * from sysobjects where name = 'ah_log_ctas_act') 
 drop table ah_log_ctas_act
go 

/* ah_totales_interofi */
print '=====> ah_totales_interofi'
go
if exists (select * from sysobjects where name = 'ah_totales_interofi') 
 drop table ah_totales_interofi
go 

/* ah_ctas_cancelar */
print '=====> ah_ctas_cancelar'
go
if exists (select * from sysobjects where name = 'ah_ctas_cancelar') 
 drop table ah_ctas_cancelar
go 

/* ah_reporte_vsuspenso */
print '=====> ah_reporte_vsuspenso'
go
if exists (select * from sysobjects where name = 'ah_reporte_vsuspenso') 
 drop table ah_reporte_vsuspenso
go 

/* ah_cuenta_ors_1261_1 */
print '=====> ah_cuenta_ors_1261_1'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1261_1') 
 drop table ah_cuenta_ors_1261_1
go 

/* ah_rango_oficina_batch */
print '=====> ah_rango_oficina_batch'
go
if exists (select * from sysobjects where name = 'ah_rango_oficina_batch') 
 drop table ah_rango_oficina_batch
go 

/* ah_cuenta_ofica */
print '=====> ah_cuenta_ofica'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ofica') 
 drop table ah_cuenta_ofica
go 

/* ah_cuenta_ors_1261_2 */
print '=====> ah_cuenta_ors_1261_2'
go
if exists (select * from sysobjects where name = 'ah_cuenta_ors_1261_2') 
 drop table ah_cuenta_ors_1261_2
go 

/* tiempo */
print '=====> tiempo'
go
if exists (select * from sysobjects where name = 'tiempo') 
 drop table tiempo
go 

/* ah_oficina_ctas_cifradas */
print '=====> ah_oficina_ctas_cifradas'
go
if exists (select * from sysobjects where name = 'ah_oficina_ctas_cifradas') 
 drop table ah_oficina_ctas_cifradas
go 

/* ah_tran_mensual */
print '=====> ah_tran_mensual'
go
if exists (select * from sysobjects where name = 'ah_tran_mensual') 
 drop table ah_tran_mensual
go 

/* ah_embargo */
print '=====> ah_embargo'
go
if exists (select * from sysobjects where name = 'ah_embargo') 
 drop table ah_embargo
go 

/* ah_tran_rechazos */
print '=====> ah_tran_rechazos'
go
if exists (select * from sysobjects where name = 'ah_tran_rechazos') 
 drop table ah_tran_rechazos
go 

/* ah_total_ciiu */
print '=====> ah_total_ciiu'
go
if exists (select * from sysobjects where name = 'ah_total_ciiu') 
 drop table ah_total_ciiu
go 

/* ah_total_escala */
print '=====> ah_total_escala'
go
if exists (select * from sysobjects where name = 'ah_total_escala') 
 drop table ah_total_escala
go 

/* datos_inac */
print '=====> datos_inac'
go
if exists (select * from sysobjects where name = 'datos_inac') 
 drop table datos_inac
go 

/* ca_emb_temp */
print '=====> ca_emb_temp'
go
if exists (select * from sysobjects where name = 'ca_emb_temp') 
 drop table ca_emb_temp
go 

/* ah_sorteo_agrob */
print '=====> ah_sorteo_agrob'
go
if exists (select * from sysobjects where name = 'ah_sorteo_agrob') 
 drop table ah_sorteo_agrob
go 

/* cl_det_producto */
print '=====> cl_det_producto'
go
if exists (select * from sysobjects where name = 'cl_det_producto') 
 drop table cl_det_producto
go 

/* ah_rangos_saldos */
print '=====> ah_rangos_saldos'
go
if exists (select * from sysobjects where name = 'ah_rangos_saldos') 
 drop table ah_rangos_saldos
go 

/* saldo_compensa */
print '=====> saldo_compensa'
go
if exists (select * from sysobjects where name = 'saldo_compensa') 
 drop table saldo_compensa
go 

/* ah_beneficiario_cta */
print '=====> ah_beneficiario_cta'
go
if exists (select * from sysobjects where name = 'ah_beneficiario_cta') 
 drop table ah_beneficiario_cta
go 

/* ah_tipotrx_mes */
print '=====> ah_tipotrx_mes'
go
if exists (select * from sysobjects where name = 'ah_tipotrx_mes') 
 drop table ah_tipotrx_mes
go 

/* ah_datos_adic */
print '=====> ah_datos_adic'
go
if exists (select * from sysobjects where name = 'ah_datos_adic') 
 drop table ah_datos_adic
go 

/* ah_cuentas_subsidiarias */
print '=====> ah_cuentas_subsidiarias'
go
if exists (select * from sysobjects where name = 'ah_cuentas_subsidiarias') 
 drop table ah_cuentas_subsidiarias
go 

/* ah_fecha_promedio */
print '=====> ah_fecha_promedio'
go
if exists (select * from sysobjects where name = 'ah_fecha_promedio') 
 drop table ah_fecha_promedio
go 

/* ah_retencion_locales */
print '=====> ah_retencion_locales'
go
if exists (select * from sysobjects where name = 'ah_retencion_locales') 
 drop table ah_retencion_locales
go 

/* ah_aut_retiro_ofic */
print '=====> ah_aut_retiro_ofic'
go
if exists (select * from sysobjects where name = 'ah_aut_retiro_ofic') 
 drop table ah_aut_retiro_ofic
go 

/* ah_fecha_periodo */
print '=====> ah_fecha_periodo'
go
if exists (select * from sysobjects where name = 'ah_fecha_periodo') 
 drop table ah_fecha_periodo
go 

/* ah_rep_retiros_ofic */
print '=====> ah_rep_retiros_ofic'
go
if exists (select * from sysobjects where name = 'ah_rep_retiros_ofic') 
 drop table ah_rep_retiros_ofic
go 

/* ah_exenta_gmf */
print '=====> ah_exenta_gmf'
go
if exists (select * from sysobjects where name = 'ah_exenta_gmf') 
 drop table ah_exenta_gmf
go 

/* ah_carga_archivo_cuentas */
print '=====> ah_carga_archivo_cuentas'
go
if exists (select * from sysobjects where name = 'ah_carga_archivo_cuentas') 
 drop table ah_carga_archivo_cuentas
go 

/* asiento_aho */
print '=====> asiento_aho'
go
if exists (select * from sysobjects where name = 'asiento_aho') 
 drop table asiento_aho
go 

/* ah_temp_devgmf */
print '=====> ah_temp_devgmf'
go
if exists (select * from sysobjects where name = 'ah_temp_devgmf') 
 drop table ah_temp_devgmf
go 

/* ah_carga_archivo_cuentas_tmp */
print '=====> ah_carga_archivo_cuentas_tmp'
go
if exists (select * from sysobjects where name = 'ah_carga_archivo_cuentas_tmp') 
 drop table ah_carga_archivo_cuentas_tmp
go 

/* ah_errorlog */
print '=====> ah_errorlog'
go
if exists (select * from sysobjects where name = 'ah_errorlog') 
 drop table ah_errorlog
go 

/* ah_condonacion */
print '=====> ah_condonacion'
go
if exists (select * from sysobjects where name = 'ah_condonacion') 
 drop table ah_condonacion
go 

/* ah_carga_archivo_cuentas_tmp320 */
print '=====> ah_carga_archivo_cuentas_tmp320'
go
if exists (select * from sysobjects where name = 'ah_carga_archivo_cuentas_tmp320') 
 drop table ah_carga_archivo_cuentas_tmp320
go 

/* ah_linea_pendiente1 */
print '=====> ah_linea_pendiente1'
go
if exists (select * from sysobjects where name = 'ah_linea_pendiente1') 
 drop table ah_linea_pendiente1
go 

/* ORS485_ctas_react */
print '=====> ORS485_ctas_react'
go
if exists (select * from sysobjects where name = 'ORS485_ctas_react') 
 drop table ORS485_ctas_react
go 

/* ah_linea_pendiente2 */
print '=====> ah_linea_pendiente2'
go
if exists (select * from sysobjects where name = 'ah_linea_pendiente2') 
 drop table ah_linea_pendiente2
go 

/* ah_linea_pendiente3 */
print '=====> ah_linea_pendiente3'
go
if exists (select * from sysobjects where name = 'ah_linea_pendiente3') 
 drop table ah_linea_pendiente3
go 

/* ah_linea_pendiente4 */
print '=====> ah_linea_pendiente4'
go
if exists (select * from sysobjects where name = 'ah_linea_pendiente4') 
 drop table ah_linea_pendiente4
go 

/* ah_debito_auto */
print '=====> ah_debito_auto'
go
if exists (select * from sysobjects where name = 'ah_debito_auto') 
 drop table ah_debito_auto
go 
