/************************************************************************/
/*      Archivo:            ah_table.sql                                */
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
/*      Este programa realiza la creacion de tablas                     */
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



/* ah_dev_recaudos_cb */
print '=====> ah_dev_recaudos_cb'
go
if exists (select * from sysobjects where name = 'ah_dev_recaudos_cb') 
 drop table ah_dev_recaudos_cb
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

/* ah_det_estado_cuenta */
print '=====> ah_det_estado_cuenta'
go
if exists (select * from sysobjects where name = 'ah_det_estado_cuenta') 
 drop table ah_det_estado_cuenta
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

/* ah_cuenta_aux */
print '=====> ah_cuenta_aux'
go
if exists (select * from sysobjects where name = 'ah_cuenta_aux') 
 drop table ah_cuenta_aux
go

print '=====>  ah_report_ctas'
if exists (select * from sysobjects where name = 'ah_report_ctas') 
drop table ah_report_ctas
go


print '=====> ah_transacciones_cm_tmp'
if exists (select * from sysobjects where name = 'ah_transacciones_cm_tmp') 
    drop table ah_transacciones_cm_tmp
go

print '=====>  ah_det_cheq_cm_tmp'
if exists (select * from sysobjects where name = 'ah_det_cheq_cm_tmp') 
    drop table ah_det_cheq_cm_tmp
go

print '=====>  ah_transacciones_cm'
if exists (select * from sysobjects where name = 'ah_transacciones_cm') 
    drop table ah_transacciones_cm
go

print '=====>  ah_det_cheq_cm'
if exists (select * from sysobjects where name = 'ah_det_cheq_cm') 
drop table ah_det_cheq_cm
go

/* ah_ahorro_individual */
print '=====> ah_ahorro_individual'
go
if exists (select * from sysobjects where name = 'ah_ahorro_individual') 
 drop table ah_ahorro_individual
go


print '=====>  ah_log_cm_tran'
if exists (select * from sysobjects where name = 'ah_log_cm_tran') 
drop table ah_log_cm_tran
go

CREATE TABLE ah_abono_cuentas_inc
    (
    ac_cuenta     VARCHAR (26) NULL,
    ac_secuencial INT NULL,
    ac_valor      MONEY NULL,
    ac_estado     CHAR (2) NULL,
    ac_oficina    SMALLINT NULL,
    ac_error      VARCHAR (100) NULL
    )
GO

CREATE TABLE ah_act_capitalizacion
    (
    ac_cta_banco      cuenta NOT NULL,
    ac_capitalizacion CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_acumulador
    (
    ac_oficina       SMALLINT NOT NULL,
    ac_moneda        SMALLINT NOT NULL,
    ac_prod_banc     SMALLINT NOT NULL,
    ac_categoria     catalogo NOT NULL,
    ac_intereses     MONEY NOT NULL,
    ac_ssn           INT NOT NULL,
    ac_usuario       CHAR (16) NOT NULL,
    ac_terminal      CHAR (16) NOT NULL,
    ac_trn           INT NOT NULL,
    ac_fecha         DATETIME NOT NULL,
    ac_reentry       CHAR (1) NOT NULL,
    ac_origen        CHAR (1) NOT NULL,
    ac_cta_banco     CHAR (16) NOT NULL,
    ac_tipocta_super CHAR (1) NOT NULL,
    ac_clase_clte    CHAR (1) NULL
    )
GO

CREATE TABLE ah_acumulador1
    (
    ac_oficina       SMALLINT NOT NULL,
    ac_moneda        SMALLINT NOT NULL,
    ac_prod_banc     SMALLINT NOT NULL,
    ac_categoria     catalogo NOT NULL,
    ac_intereses     MONEY NOT NULL,
    ac_ssn           INT NOT NULL,
    ac_usuario       CHAR (16) NOT NULL,
    ac_terminal      CHAR (16) NOT NULL,
    ac_trn           INT NOT NULL,
    ac_fecha         DATETIME NOT NULL,
    ac_reentry       CHAR (1) NOT NULL,
    ac_origen        CHAR (1) NOT NULL,
    ac_cta_banco     CHAR (16) NOT NULL,
    ac_tipocta_super CHAR (1) NOT NULL,
    ac_clase_clte    CHAR (1) NULL
    )
GO

CREATE TABLE ah_acumulador2
    (
    ac_oficina       SMALLINT NOT NULL,
    ac_moneda        SMALLINT NOT NULL,
    ac_prod_banc     SMALLINT NOT NULL,
    ac_categoria     catalogo NOT NULL,
    ac_intereses     MONEY NOT NULL,
    ac_ssn           INT NOT NULL,
    ac_usuario       CHAR (16) NOT NULL,
    ac_terminal      CHAR (16) NOT NULL,
    ac_trn           INT NOT NULL,
    ac_fecha         DATETIME NOT NULL,
    ac_reentry       CHAR (1) NOT NULL,
    ac_origen        CHAR (1) NOT NULL,
    ac_cta_banco     CHAR (16) NOT NULL,
    ac_tipocta_super CHAR (1) NOT NULL,
    ac_clase_clte    CHAR (1) NULL
    )
GO

CREATE TABLE ah_acumulador3
    (
    ac_oficina       SMALLINT NOT NULL,
    ac_moneda        SMALLINT NOT NULL,
    ac_prod_banc     SMALLINT NOT NULL,
    ac_categoria     catalogo NOT NULL,
    ac_intereses     MONEY NOT NULL,
    ac_ssn           INT NOT NULL,
    ac_usuario       CHAR (16) NOT NULL,
    ac_terminal      CHAR (16) NOT NULL,
    ac_trn           INT NOT NULL,
    ac_fecha         DATETIME NOT NULL,
    ac_reentry       CHAR (1) NOT NULL,
    ac_origen        CHAR (1) NOT NULL,
    ac_cta_banco     CHAR (16) NOT NULL,
    ac_tipocta_super CHAR (1) NOT NULL,
    ac_clase_clte    CHAR (1) NULL
    )
GO

CREATE TABLE ah_acumulador4
    (
    ac_oficina       SMALLINT NOT NULL,
    ac_moneda        SMALLINT NOT NULL,
    ac_prod_banc     SMALLINT NOT NULL,
    ac_categoria     catalogo NOT NULL,
    ac_intereses     MONEY NOT NULL,
    ac_ssn           INT NOT NULL,
    ac_usuario       CHAR (16) NOT NULL,
    ac_terminal      CHAR (16) NOT NULL,
    ac_trn           INT NOT NULL,
    ac_fecha         DATETIME NOT NULL,
    ac_reentry       CHAR (1) NOT NULL,
    ac_origen        CHAR (1) NOT NULL,
    ac_cta_banco     CHAR (16) NOT NULL,
    ac_tipocta_super CHAR (1) NOT NULL,
    ac_clase_clte    CHAR (1) NULL
    )
GO

CREATE TABLE ah_alicuota
    (
    al_capitalizacion CHAR (1) NOT NULL,
    al_fecha          SMALLDATETIME NOT NULL,
    al_factor         REAL NULL,
    al_usa_linea_pend CHAR (1) NOT NULL
    )
GO


CREATE TABLE ah_ano
    (
    ah_ano INT NULL
    )
GO

CREATE TABLE ah_anula_ord_pag
    (
    ao_ente INT NULL
    )
GO

CREATE TABLE ah_apertura_cta
    (
    ac_cuenta    INT NULL,
    ac_cta_banco CHAR (16) NULL,
    ac_fecha     DATETIME NULL,
    ac_oficina   SMALLINT NULL
    )
GO

CREATE TABLE ah_arch_facturacion
    (
    af_dia      DATETIME NULL,
    af_val_tran MONEY NULL,
    af_num_tran INT NULL,
    af_tot_atm  MONEY NULL,
    af_can_atm  INT NULL,
    af_tot_pos  MONEY NULL,
    af_can_pos  INT NULL
    )
GO

CREATE TABLE ah_arch_movimientos
    (
    am_secuencial     INT NULL,
    am_origen         VARCHAR (5) NULL,
    am_tipo_tran      CHAR (3) NULL,
    am_cta_banco      VARCHAR (24) NULL,
    am_valor          MONEY NULL,
    am_fecha_tran     DATETIME NULL,
    am_hora           VARCHAR (6) NULL,
    am_tarjeta        VARCHAR (19) NULL,
    am_referencia     INT NULL,
    am_id_cliente     VARCHAR (30) NULL,
    am_estado_conc    CHAR (4) NULL,
    am_fecha_carga    DATETIME NULL,
    am_fecha_concilia DATETIME NULL
    )
GO

CREATE TABLE ah_aut_retiro_ofic
    (
    ar_secuencial         INT NOT NULL,
    ar_cta_banco          cuenta NOT NULL,
    ar_nombre             VARCHAR (64) NOT NULL,
    ar_forma_pago         CHAR (1) NOT NULL,
    ar_valor              MONEY NOT NULL,
    ar_retiro_add         SMALLINT NOT NULL,
    ar_login              VARCHAR (30) NOT NULL,
    ar_fecha              DATETIME NOT NULL,
    ar_hora               DATETIME NOT NULL,
    ar_estado             CHAR (1) NOT NULL,
    ar_oficina_radicadora CHAR (1) NULL
    )
GO

CREATE TABLE ah_beneficiario_cta
    (
    bc_beneficiario INT NOT NULL,
    bc_cta_banco    CHAR (16) NOT NULL,
    bc_ced_ruc      CHAR (20) NOT NULL,
    bc_nombre       CHAR (64) NOT NULL,
    bc_porcentaje   FLOAT NOT NULL
    )
GO

CREATE TABLE ah_caja
    (
    cj_oficina      SMALLINT NOT NULL,
    cj_rol          SMALLINT NOT NULL,
    cj_operador     CHAR (14) NOT NULL,
    cj_moneda       TINYINT NOT NULL,
    cj_transaccion  INT NOT NULL,
    cj_numero       SMALLINT NOT NULL,
    cj_efectivo     MONEY NOT NULL,
    cj_cheque       MONEY NOT NULL,
    cj_chq_locales  MONEY NOT NULL,
    cj_chq_ot_plaza MONEY NOT NULL,
    cj_otros        MONEY NOT NULL,
    cj_interes      MONEY NOT NULL,
    cj_ajuste_int   MONEY NOT NULL,
    cj_ajuste_cap   MONEY NOT NULL,
    cj_nodo         CHAR (30) NOT NULL,
    cj_tipo         CHAR (1) NOT NULL,
    cj_fecha        SMALLDATETIME NOT NULL,
    cj_ssn          INT NOT NULL
    )
GO

CREATE TABLE ah_carga_archivo_cuentas
    (
    ca_tipo_reg   CHAR (2) NULL,
    ca_secuencia  INT NULL,
    ca_tipo_carga CHAR (1) NULL,
    ca_tipo_ced   CHAR (2) NULL,
    ca_ced_ruc    BIGINT NULL,
    ca_nomb_arch  VARCHAR (60) NULL,
    ca_ente       INT NULL,
    ca_cta_banco  CHAR (16) NULL,
    ca_tipo_prod  TINYINT NULL,
    ca_fecha_reg  DATETIME NULL,
    ca_cant_reg   INT NULL,
    ca_valor      MONEY NULL,
    ca_tipo_mov   CHAR (1) NULL,
    ca_causal     CHAR (3) NULL,
    ca_fecha_proc DATETIME NULL,
    ca_tipo_oper  CHAR (1) NULL,
    ca_estado     CHAR (1) NULL,
    ca_error      VARCHAR (250) NULL,
    ca_empresa    INT NULL
    )
GO

CREATE TABLE ah_carga_archivo_cuentas_tmp
    (
    ca_tipo_reg   VARCHAR (2) NULL,
    ca_secuencia  VARCHAR (20) NULL,
    ca_tipo_carga VARCHAR (20) NULL,
    ca_tipo_ced   VARCHAR (20) NULL,
    ca_ced_ruc    VARCHAR (20) NULL,
    ca_nomb_arch  VARCHAR (60) NULL,
    ca_ente       VARCHAR (25) NULL,
    ca_cta_banco  VARCHAR (26) NULL,
    ca_tipo_prod  VARCHAR (6) NULL,
    ca_fecha_reg  VARCHAR (12) NULL,
    ca_cant_reg   VARCHAR (10) NULL,
    ca_valor      MONEY NULL,
    ca_tipo_mov   VARCHAR (10) NULL,
    ca_causal     VARCHAR (30) NULL,
    ca_fecha_proc VARCHAR (12) NULL,
    ca_tipo_oper  VARCHAR (10) NULL,
    ca_estado     VARCHAR (10) NULL,
    ca_error      VARCHAR (250) NULL,
    ca_autnum     INT IDENTITY(100,1) NOT NULL,
    ca_empresa    INT NULL
    )
GO

CREATE TABLE ah_carga_archivo_cuentas_tmp320
    (
    ca_tipo_carga   VARCHAR (10) NULL,
    ca_total_reg    VARCHAR (30) NULL,
    ca_reg_ok       VARCHAR (30) NULL,
    ca_error_data   VARCHAR (60) NULL,
    ca_error_estruc VARCHAR (25) NULL,
    ca_nombre_clie  VARCHAR (255) NULL,
    ca_tipo_identi  VARCHAR (30) NULL,
    ca_iden_clie    VARCHAR (30) NULL,
    ca_valor        VARCHAR (30) NULL,
    ca_tipo_produc  VARCHAR (30) NULL,
    ca_cta_banco    VARCHAR (30) NULL,
    ca_estado       VARCHAR (30) NULL,
    ca_error        VARCHAR (255) NULL,
    ca_nomb_arch    VARCHAR (60) NULL
    )
GO

CREATE TABLE ah_carga_archivo_cuentas_tmp320_arch
    (
    ca_tipo_carga   VARCHAR (10) NULL,
    ca_total_reg    VARCHAR (30) NULL,
    ca_reg_ok       VARCHAR (30) NULL,
    ca_error_data   VARCHAR (60) NULL,
    ca_error_estruc VARCHAR (25) NULL,
    ca_nombre_clie  VARCHAR (255) NULL,
    ca_tipo_identi  VARCHAR (30) NULL,
    ca_iden_clie    VARCHAR (30) NULL,
    ca_valor        VARCHAR (30) NULL,
    ca_tipo_produc  VARCHAR (30) NULL,
    ca_cta_banco    VARCHAR (30) NULL,
    ca_estado       VARCHAR (30) NULL,
    ca_error        VARCHAR (255) NULL,
    ca_nomb_arch    VARCHAR (60) NULL
    )
GO

CREATE TABLE ah_ciudad_deposito
    (
    cd_cuenta       INT NOT NULL,
    cd_ciudad       INT NOT NULL,
    cd_fecha_depo   SMALLDATETIME NOT NULL,
    cd_fecha_efe    SMALLDATETIME NOT NULL,
    cd_valor        MONEY NOT NULL,
    cd_efectivizado CHAR (1) NULL,
    cd_valor_efe    MONEY NOT NULL
    )
GO

CREATE TABLE ah_clicta_solicitud
    (
    cs_codigo INT NOT NULL,
    cs_tipo   VARCHAR (5) NULL,
    cs_numsol INT NOT NULL
    )
GO

CREATE TABLE ah_compensacion_actpas
    (
    co_secuencial      INT NULL,
    co_tipo_obligacion VARCHAR (10) NULL,
    co_operacion       VARCHAR (20) NULL,
    co_cuenta          INT NULL,
    co_saldo           MONEY NULL,
    co_valor_aplicado  MONEY NULL,
    co_cliente         INT NULL,
    co_tipo_doc        CHAR (2) NULL,
    co_identificacion  VARCHAR (30) NULL,
    co_nombre          VARCHAR (64) NULL,
    co_rol             CHAR (1) NULL,
    co_tipo_prod       CHAR (3) NULL,
    co_num_producto    VARCHAR (20) NULL,
    co_oficina         INT NULL,
    co_desc_oficina    VARCHAR (64) NULL,
    co_estado_nd       CHAR (1) NULL,
    co_estado_pago     CHAR (1) NULL,
    co_observacion     VARCHAR (255) NULL,
    co_estado_registro CHAR (1) NULL,
    co_valor_cartera   MONEY NULL
    )
GO

CREATE TABLE ah_condonacion
    (
    co_ente       INT NOT NULL,
    co_celular    VARCHAR (10) NOT NULL,
    co_tarjeta    VARCHAR (20) NOT NULL,
    co_cta_banco  VARCHAR (16) NOT NULL,
    co_estado_tar CHAR (1) NOT NULL,
    co_oficina    INT NOT NULL,
    co_causa      VARCHAR (4) NOT NULL,
    co_valor      MONEY NOT NULL,
    co_dias       INT NOT NULL,
    co_fecha      DATETIME NOT NULL,
    co_aplicativo TINYINT NOT NULL
    )
GO

CREATE TABLE ah_consolidado
    (
    co_oficina          SMALLINT NOT NULL,
    co_moneda           TINYINT NOT NULL,
    co_estado           CHAR (1) NOT NULL,
    co_tipo             VARCHAR (20) NOT NULL,
    co_numcuentas       INT NOT NULL,
    co_interes          MONEY NOT NULL,
    co_acreedoras       INT NOT NULL,
    co_total_acreedoras MONEY NOT NULL,
    co_deudoras         INT NOT NULL,
    co_total_deudoras   MONEY NOT NULL,
    co_saldo_neto       MONEY NOT NULL,
    co_remesas          MONEY NOT NULL,
    co_ret24h           MONEY NOT NULL,
    co_debitos_hoy      MONEY NOT NULL,
    co_creditos_hoy     MONEY NOT NULL,
    co_interes_hoy      MONEY NOT NULL,
    co_prod_banc        SMALLINT NOT NULL,
    co_categoria        CHAR (1) NOT NULL,
    co_errores          INT NOT NULL,
    co_min_dispmes      MONEY NOT NULL,
    co_aperturadas      INT NOT NULL,
    co_cerradas         INT NOT NULL,
    co_tasa             FLOAT NOT NULL,
    co_cta_gobierno     CHAR (1) NOT NULL,
    co_fecha            SMALLDATETIME NOT NULL
    )
GO

CREATE TABLE ah_cta_gmf_tmp
    (
    cgt_sec            INT IDENTITY NOT NULL,
    cgt_fecha          VARCHAR (10) NULL,
    cgt_tipo_id        VARCHAR (2) NULL,
    cgt_identificacion VARCHAR (30) NULL,
    cgt_nombre         VARCHAR (254) NULL,
    cgt_entidad        VARCHAR (2) NULL,
    cgt_cuenta         VARCHAR (16) NULL,
    cgt_estado         VARCHAR (30) NULL,
    cgt_msg            VARCHAR (254) NULL
    )
GO

CREATE TABLE ah_cta_prog
    (
    cu_cta_banco     VARCHAR (14) NULL,
    cu_fecha_aper    DATETIME NULL,
    cu_oficina       INT NULL,
    cu_categoria     CHAR (1) NULL,
    cu_des_categoria VARCHAR (16) NULL,
    cu_cuota         SMALLINT NULL,
    cu_estadocuota   VARCHAR (12) NULL
    )
GO

CREATE TABLE ah_ctabloqueada
    (
    cb_cuenta       INT NOT NULL,
    cb_secuencial   INT NOT NULL,
    cb_tipo_bloqueo VARCHAR (3) NOT NULL,
    cb_fecha        SMALLDATETIME NOT NULL,
    cb_hora         SMALLDATETIME NOT NULL,
    cb_autorizante  login NULL,
    cb_solicitante  descripcion NOT NULL,
    cb_oficina      SMALLINT NOT NULL,
    cb_estado       estado NULL,
    cb_causa        VARCHAR (3) NOT NULL,
    cb_sec_asoc     INT NULL,
    cb_observacion  VARCHAR (120) NULL
    )
GO

CREATE TABLE ah_ctas_actualizar
    (
    ca_cta_banco   VARCHAR (12) NULL,
    ca_operacion   CHAR (1) NULL,
    ca_observacion VARCHAR (254) NULL
    )
GO

CREATE TABLE ah_ctas_cancelar
    (
    cc_fecha         DATETIME NOT NULL,
    cc_zona          SMALLINT NULL,
    cc_nom_zona      descripcion NULL,
    cc_oficina       SMALLINT NULL,
    cc_nom_oficina   descripcion NULL,
    cc_ctabanco      cuenta NOT NULL,
    cc_cuenta        INT NOT NULL,
    cc_estado_cta    CHAR (1) NOT NULL,
    cc_titularidad   CHAR (1) NOT NULL,
    cc_cliente       INT NOT NULL,
    cc_nombre_cli    VARCHAR (254) NULL,
    cc_documento     numero NULL,
    cc_producto      SMALLINT NULL,
    cc_disponible    MONEY NOT NULL,
    cc_operacion     VARCHAR (24) NULL,
    cc_estadocca     TINYINT NULL,
    cc_desc_est      descripcion NULL,
    cc_diasmora      INT NULL,
    cc_castigado     CHAR (1) NULL,
    cc_valorven      MONEY NULL,
    cc_deudatotal    MONEY NULL,
    cc_saldado       MONEY NULL,
    cc_exclusivo     CHAR (1) NULL,
    cc_procesado     CHAR (1) NOT NULL,
    cc_fecha_aper    DATETIME NULL,
    cc_fecha_ult_mov DATETIME NULL,
    cc_fecha_proc    DATETIME NULL,
    cc_mensaje       VARCHAR (64) NULL,
    cc_exento        CHAR (1) NULL,
    cc_sec           NUMERIC (10) IDENTITY NOT NULL
    )
GO

CREATE TABLE ah_ctas_cancelar_his
    (
    cc_fecha         DATETIME NOT NULL,
    cc_zona          SMALLINT NULL,
    cc_nom_zona      descripcion NULL,
    cc_oficina       SMALLINT NULL,
    cc_nom_oficina   descripcion NULL,
    cc_ctabanco      cuenta NOT NULL,
    cc_cuenta        INT NOT NULL,
    cc_estado_cta    CHAR (1) NOT NULL,
    cc_titularidad   CHAR (1) NOT NULL,
    cc_cliente       INT NOT NULL,
    cc_nombre_cli    VARCHAR (254) NULL,
    cc_documento     numero NULL,
    cc_producto      SMALLINT NULL,
    cc_disponible    MONEY NOT NULL,
    cc_operacion     VARCHAR (24) NULL,
    cc_estadocca     TINYINT NULL,
    cc_desc_est      descripcion NULL,
    cc_diasmora      INT NULL,
    cc_castigado     CHAR (1) NULL,
    cc_valorven      MONEY NULL,
    cc_deudatotal    MONEY NULL,
    cc_saldado       MONEY NULL,
    cc_exclusivo     CHAR (1) NULL,
    cc_procesado     CHAR (1) NOT NULL,
    cc_fecha_aper    DATETIME NULL,
    cc_fecha_ult_mov DATETIME NULL,
    cc_fecha_proc    DATETIME NULL,
    cc_mensaje       VARCHAR (64) NULL,
    cc_exento        CHAR (1) NULL,
    cc_sec           NUMERIC (10) IDENTITY NOT NULL
    )
GO

CREATE TABLE ah_cuenta
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (30) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO


sp_bindefault 'ah_patente_def', 'ah_cuenta.ah_patente'
GO

CREATE TABLE ah_cuenta_batch
    (
    cb_cuenta cuenta NOT NULL
    )
GO

CREATE TABLE ah_cuenta_borrar
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_cumple_tmp
    (
    cc_sucursal  VARCHAR (10) NULL,
    cc_oficina   VARCHAR (10) NULL,
    cc_cta_banco VARCHAR (16) NULL,
    cc_nombre    VARCHAR (100) NULL,
    cc_sld_espe  VARCHAR (32) NULL,
    cc_sld_act   VARCHAR (32) NULL
    )
GO

CREATE TABLE ah_cuenta_navidad
    (
    cn_cuenta         INT NOT NULL,
    cn_cuota          catalogo NOT NULL,
    cn_relacion       SMALLINT NULL,
    cn_manejo         CHAR (1) NOT NULL,
    cn_fecha_apertura SMALLDATETIME NOT NULL,
    cn_usuario_crea   VARCHAR (30) NOT NULL,
    cn_fecha_cierre   SMALLDATETIME NULL,
    cn_cuota_gratis   CHAR (1) NULL,
    cn_usuario_cuota  login NULL,
    cn_fecha_cuota    SMALLDATETIME NULL,
    cn_fecha_pago     SMALLDATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ofica
    (
    [Nro Cuenta] NVARCHAR (20) NULL,
    [Cod  Cliente] NVARCHAR (20) NULL,
    Cedula       NVARCHAR (20) NULL,
    Nombre       NVARCHAR (60) NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1239_1
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1239_2
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1246_1
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1246_2
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1251_1
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1251_2
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1261_1
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1261_2
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1272_1
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1272_2
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1297_1
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ors_1297_2
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ORS1266
    (
    ah_cliente   INT NOT NULL,
    en_tipo_ced  CHAR (2) NULL,
    en_ced_ruc   VARCHAR (30) NULL,
    en_nombre    VARCHAR (64) NOT NULL,
    p_p_apellido VARCHAR (16) NULL,
    ah_cta_banco CHAR (16) NOT NULL,
    valor        MONEY NOT NULL,
    oficio       INT NOT NULL
    )
GO

CREATE TABLE ah_cuenta_ORS1271
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_ticket_0262203
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_tmp
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (30) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )
GO

CREATE TABLE ah_cuenta_tmp1
    (
    ah_moneda       TINYINT NOT NULL,
    ah_prod_banc    SMALLINT NOT NULL,
    ah_saldo_ayer   MONEY NOT NULL,
    ah_creditos_hoy MONEY NOT NULL,
    ah_debitos_hoy  MONEY NOT NULL,
    ah_disponible   MONEY NOT NULL,
    ah_diferido     MONEY NOT NULL,
    ah_contable     MONEY NOT NULL,
    ah_promedio1    MONEY NOT NULL,
    ah_int_mes      MONEY NOT NULL,
    ah_min_dispmes  MONEY NOT NULL
    )
GO

CREATE TABLE ah_cuentas_subsidiarias
    (
    as_cta_banco cuenta NOT NULL
    )
GO

CREATE TABLE ah_datos_adic
    (
    da_cta_banco           cuenta NOT NULL,
    da_fecha_ingreso       DATETIME NULL,
    da_fecha_ult_modif     DATETIME NULL,
    da_usuario             login NULL,
    da_dep_inicial         MONEY NOT NULL,
    da_forma_dep_inicial   VARCHAR (10) NOT NULL,
    da_proposito_cuenta    VARCHAR (10) NOT NULL,
    da_origen_fondos       VARCHAR (10) NOT NULL,
    da_prod_cobis1         VARCHAR (10) NULL,
    da_prod_cobis2         VARCHAR (10) NULL,
    da_monto_ext           MONEY NULL,
    da_trx_ext             INT NULL,
    da_frecuencia_ext      VARCHAR (10) NULL,
    da_monto_efec          MONEY NULL,
    da_trx_efec            INT NULL,
    da_frecuencia_efec     VARCHAR (10) NULL,
    da_monto_refec         MONEY NULL,
    da_trx_refec           INT NULL,
    da_frecuencia_refec    VARCHAR (10) NULL,
    da_monto_giro          MONEY NULL,
    da_trx_giro            INT NULL,
    da_frecuencia_giro     VARCHAR (10) NULL,
    da_monto_gerencia      MONEY NULL,
    da_trx_gerencia        INT NULL,
    da_frecuencia_gerencia VARCHAR (10) NULL,
    da_monto_transfer      MONEY NULL,
    da_trx_transfer        INT NULL,
    da_frecuencia_transfer VARCHAR (10) NULL,
    da_monto_recib         MONEY NULL,
    da_trx_recib           INT NULL,
    da_frecuencia_recib    VARCHAR (10) NULL
    )
GO

CREATE TABLE ah_datos_gmf_tmp
    (
    dgt_sec         INT IDENTITY NOT NULL,
    dgt_ente        INT NULL,
    dgt_cuenta      INT NULL,
    dgt_cta_banco   VARCHAR (16) NULL,
    dgt_filial      TINYINT NULL,
    dgt_oficina     SMALLINT NULL,
    dgt_producto    TINYINT NULL,
    dgt_moneda      TINYINT NULL,
    dgt_oficial     SMALLINT NULL,
    dgt_origen      VARCHAR (3) NULL,
    dgt_clase       CHAR (1) NULL,
    dgt_nxmil       CHAR (1) NULL,
    dgt_descripcion VARCHAR (120) NULL
    )
GO

CREATE TABLE ah_debito_auto
    (
    territorial          VARCHAR (60) NULL,
    zona                 VARCHAR (60) NULL,
    oficina              VARCHAR (60) NULL,
    producto             VARCHAR (60) NULL,
    categoria            VARCHAR (60) NULL,
    Nro_Cuenta           VARCHAR (60) NULL,
    estado               VARCHAR (60) NULL,
    f_aper_cta           VARCHAR (60) NULL,
    cod_cl               VARCHAR (60) NULL,
    doc_id               VARCHAR (60) NULL,
    nom_tit_cta          VARCHAR (60) NULL,
    tip_pers             VARCHAR (60) NULL,
    ciudad               VARCHAR (60) NULL,
    cl_cliente           VARCHAR (60) NULL,
    fech_marc_cuent_deb  VARCHAR (60) NULL,
    usuar_proc_marc      VARCHAR (60) NULL,
    sal_cta              VARCHAR (60) NULL,
    no_prest             VARCHAR (60) NULL,
    of_prest             VARCHAR (60) NULL,
    vlr_desemb           VARCHAR (60) NULL,
    f_pag_cred           VARCHAR (60) NULL,
    vlr_cuot_cred        VARCHAR (60) NULL,
    vlr_debitado         VARCHAR (60) NULL,
    vlr_pend_cuot        VARCHAR (60) NULL,
    f_debito             VARCHAR (60) NULL,
    caus_rechaz_deb_auto VARCHAR (60) NULL,
    nro_deb_pag          VARCHAR (60) NULL,
    titul_cuent          VARCHAR (60) NULL
    )
GO

CREATE TABLE ah_dep_difer
    (
    dd_ssn   INT NOT NULL,
    dd_srv   VARCHAR (30) NOT NULL,
    dd_lsrv  VARCHAR (30) NOT NULL,
    dd_user  VARCHAR (30) NOT NULL,
    dd_ofi   SMALLINT NOT NULL,
    dd_fecha SMALLDATETIME NOT NULL,
    dd_ope   CHAR (2) NOT NULL,
    dd_cta   cuenta NOT NULL,
    dd_efe   MONEY NOT NULL,
    dd_prop  MONEY NOT NULL,
    dd_loc   MONEY NOT NULL,
    dd_plaz  MONEY NOT NULL,
    dd_mon   TINYINT NOT NULL,
    dd_sp    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_dev_recaudos_cb
    (
    dr_fecha        DATETIME NOT NULL,
    dr_cta_banco    CHAR (16) NOT NULL,
    dr_cash_in      MONEY NOT NULL,
    dr_cash_out     MONEY NOT NULL,
    dr_pos_neta     MONEY NOT NULL,
    dr_devolucion   MONEY NOT NULL,
    dr_saldo_cierre MONEY NOT NULL
    )
GO

CREATE TABLE ah_dias_laborables
    (
    dl_ciudad   INT NOT NULL,
    dl_fecha    SMALLDATETIME NOT NULL,
    dl_num_dias SMALLINT NOT NULL
    )
GO

CREATE TABLE ah_embargo
    (
    he_secuencial       INT NOT NULL,
    he_cta_banco        CHAR (16) NOT NULL,
    he_tipo_embargo     CHAR (1) NOT NULL,
    he_monto            MONEY NULL,
    he_juez             VARCHAR (64) NULL,
    he_juzgado          VARCHAR (64) NULL,
    he_referencia       VARCHAR (64) NULL,
    he_notificador      VARCHAR (64) NULL,
    he_oficial          VARCHAR (64) NULL,
    he_promovido_por    VARCHAR (64) NULL,
    he_fecha_embargo    DATETIME NOT NULL,
    he_fecha_lev        DATETIME NULL,
    he_comentario       VARCHAR (64) NULL,
    he_monto_pendiente  MONEY NOT NULL,
    he_monto_solicitado MONEY NOT NULL,
    he_id_embargo       CHAR (1) NOT NULL,
    he_fecha_oficio     DATETIME NOT NULL,
    he_autoridad        CHAR (4) NOT NULL
    )
GO

CREATE TABLE ah_error_arch_red
    (
    er_tarjeta      VARCHAR (19) NULL,
    er_tipo_tran    CHAR (2) NULL,
    er_valor        MONEY NULL,
    er_id_cliente   VARCHAR (11) NULL,
    er_referencia   VARCHAR (12) NULL,
    er_autorizacion VARCHAR (6) NULL
    )
GO

CREATE TABLE ah_error_conta
    (
    ec_fecha       DATETIME NULL,
    ec_moneda      TINYINT NOT NULL,
    ec_ofi_orig    SMALLINT NOT NULL,
    ec_ofi_dest    SMALLINT NOT NULL,
    ec_perfil      VARCHAR (10) NOT NULL,
    ec_valor       MONEY NOT NULL,
    ec_valor_me    MONEY NOT NULL,
    ec_descripcion VARCHAR (255) NOT NULL,
    ec_filial      TINYINT NULL,
    ec_tipo_tran   SMALLINT NULL,
    ec_causa       VARCHAR (12) NULL
    )
GO

CREATE TABLE ah_errores_rr
    (
    er_numero  INT NULL,
    er_mensaje VARCHAR (1000) NULL
    )
GO

CREATE TABLE ah_errorlog
    (
    er_fecha_proc  DATETIME NOT NULL,
    er_error       INT NULL,
    er_usuario     VARCHAR (14) NULL,
    er_tran        INT NULL,
    er_cuenta      VARCHAR (24) NULL,
    er_descripcion VARCHAR (240) NULL,
    er_cta_pagrec  VARCHAR (24) NULL,
    er_programa    VARCHAR (24) NULL
    )
GO

CREATE TABLE ah_estado_cta
    (
    ec_cuenta            INT NOT NULL,
    ec_cta_banco         CHAR (16) NOT NULL,
    ec_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ec_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ec_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ec_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ec_oficina           SMALLINT NOT NULL,
    ec_oficial           SMALLINT NOT NULL,
    ec_moneda            TINYINT NOT NULL,
    ec_nombre            CHAR (55) NOT NULL,
    ec_ced_ruc           CHAR (13) NOT NULL,
    ec_cliente           INT NOT NULL,
    ec_cliente_ec        INT NOT NULL,
    ec_direccion_ec      TINYINT NOT NULL,
    ec_descripcion_ec    CHAR (120) NOT NULL,
    ec_tipo_dir          CHAR (1) NOT NULL,
    ec_disponible        MONEY NOT NULL,
    ec_saldo_contable    MONEY NOT NULL,
    ec_saldo_ult_corte   MONEY NOT NULL,
    ec_saldo_promedio    MONEY NOT NULL,
    ec_ret_locales       MONEY NOT NULL,
    ec_ret_plazas        MONEY NOT NULL,
    ec_telefono          CHAR (12) NOT NULL,
    ec_tipocta           CHAR (1) NOT NULL,
    ec_nombre1           CHAR (64) NOT NULL,
    ec_zona              SMALLINT NOT NULL,
    ec_parroquia         INT NOT NULL,
    ec_sector            SMALLINT NOT NULL,
    ec_prod_banc         SMALLINT NOT NULL,
    ec_consumos          MONEY NOT NULL,
    ec_monto_imp         MONEY NOT NULL,
    ec_prom_semestral    MONEY NOT NULL,
    ec_nombre2           CHAR (64) NOT NULL,
    ec_tasa_hoy          REAL NOT NULL
    )
GO


CREATE TABLE ah_det_estado_cuenta
        (
        de_fecha          VARCHAR (12) COLLATE Latin1_General_BIN NULL,
        de_cta_banco      cuenta NULL,
        de_oficina        SMALLINT NOT NULL,
        de_nombre         VARCHAR (15) COLLATE Latin1_General_BIN NULL,
        de_correcion      CHAR (1) COLLATE Latin1_General_BIN NULL,
        de_transaccion    VARCHAR (326) COLLATE Latin1_General_BIN NULL,
        de_signo          VARCHAR (1) COLLATE Latin1_General_BIN NULL,
        de_valor          MONEY NULL,
        de_saldo_contable MONEY NULL,
        de_impuesto       MONEY NULL,
        de_interes        MONEY NOT NULL,
        de_secuencial     INT NOT NULL,
        de_cod_alterno    INT NULL,
        de_tipotran       INT NOT NULL,
        de_serial         VARCHAR (30) COLLATE Latin1_General_BIN NULL,
        de_destino        VARCHAR (30) COLLATE Latin1_General_BIN NULL,
        de_causa          CHAR (3) COLLATE Latin1_General_BIN NOT NULL,
        de_estado         CHAR (1) COLLATE Latin1_General_BIN NULL,
        de_ssnbranch      INT NULL,
        de_hora           SMALLDATETIME NULL,
        de_valcomision    MONEY NULL
        )
GO

CREATE TABLE ah_exenta_gmf
    (
    eg_cuenta        INT NOT NULL,
    eg_cta_banco     CHAR (16) NOT NULL,
    eg_marca         CHAR (1) NOT NULL,
    eg_fecha_marca   DATETIME NOT NULL,
    eg_fecha_actua   DATETIME NULL,
    eg_fecha_valor   DATETIME NULL,
    eg_mes_01        MONEY NULL,
    eg_mes_02        MONEY NULL,
    eg_mes_03        MONEY NULL,
    eg_mes_04        MONEY NULL,
    eg_mes_05        MONEY NULL,
    eg_mes_06        MONEY NULL,
    eg_mes_07        MONEY NULL,
    eg_mes_08        MONEY NULL,
    eg_mes_09        MONEY NULL,
    eg_mes_10        MONEY NULL,
    eg_mes_11        MONEY NULL,
    eg_mes_12        MONEY NULL,
    eg_concepto      SMALLINT NOT NULL,
    eg_usuario       VARCHAR (20) NULL,
    eg_oficina_marca INT NULL,
    eg_oficina_actua INT NULL,
    eg_fecha_desm    DATETIME NULL,
    eg_usuario_desm  VARCHAR (20) NULL,
    eg_oficina_desm  INT NULL
    )
GO

CREATE TABLE ah_ext_masivos
    (
    em_registro VARCHAR (500) NULL
    )
GO

CREATE TABLE ah_ext_masivos_tmp
    (
    emt_sec       INT IDENTITY NOT NULL,
    emt_registro  VARCHAR (500) NULL,
    emt_cta_banco VARCHAR (24) NULL,
    emt_estado    CHAR (1) NULL
    )
GO

CREATE TABLE ah_fecha_periodo
    (
    fp_tipo_promedio   CHAR (1) NOT NULL,
    fp_numero_promedio SMALLINT NOT NULL,
    fp_fecha_inicio    SMALLDATETIME NOT NULL
    )
GO

CREATE TABLE ah_fecha_promedio
    (
    fp_tipo_promedio   CHAR (1) NOT NULL,
    fp_numero_promedio SMALLINT NOT NULL,
    fp_fecha_inicio    SMALLDATETIME NOT NULL,
    fp_alicuota        FLOAT NULL
    )
GO

CREATE TABLE ah_fecha_valor
    (
    fv_transaccion INT NOT NULL,
    fv_cuenta      INT NOT NULL,
    fv_referencia  VARCHAR (24) NOT NULL,
    fv_rubro       VARCHAR (10) NOT NULL,
    fv_costo       MONEY NOT NULL
    )
GO

CREATE TABLE ah_grupo
    (
    gr_grupo       TINYINT NOT NULL,
    gr_descripcion VARCHAR (20) NOT NULL
    )
GO

CREATE TABLE ah_his_bloqueo
    (
    hb_cuenta      INT NOT NULL,
    hb_secuencial  INT NOT NULL,
    hb_valor       MONEY NOT NULL,
    hb_monto_bloq  MONEY NULL,
    hb_fecha       SMALLDATETIME NOT NULL,
    hb_fecha_ven   SMALLDATETIME NULL,
    hb_hora        SMALLDATETIME NULL,
    hb_autorizante login NOT NULL,
    hb_solicitante descripcion NULL,
    hb_oficina     SMALLINT NULL,
    hb_causa       CHAR (3) NOT NULL,
    hb_saldo       MONEY NOT NULL,
    hb_accion      CHAR (1) NOT NULL,
    hb_levantado   CHAR (2) NULL,
    hb_sec_asoc    INT NULL,
    hb_observacion CHAR (120) NULL,
    hb_ngarantia   CHAR (25) NULL,
    hb_nlinea_sob  VARCHAR (24) NULL,
    hb_numcte      VARCHAR (24) NULL
    )
GO

CREATE TABLE ah_his_cierre
    (
    hc_secuencial    INT NOT NULL,
    hc_cuenta        INT NOT NULL,
    hc_causa         VARCHAR (3) NOT NULL,
    hc_orden         CHAR (1) NOT NULL,
    hc_saldo         MONEY NULL,
    hc_fecha         SMALLDATETIME NOT NULL,
    hc_filial        TINYINT NOT NULL,
    hc_oficina       SMALLINT NOT NULL,
    hc_autorizante   login NULL,
    hc_ssn_branch    INT NULL,
    hc_forma_pg      CHAR (4) NULL,
    hc_estado        CHAR (1) NULL,
    hc_fecha_r_saldo SMALLDATETIME NULL,
    hc_oficina_r     SMALLINT NULL,
    hc_usuario_pg    login NULL,
    hc_observacion   VARCHAR (50) NULL,
    hc_observacion1  VARCHAR (50) NULL,
    hc_fecha_act     SMALLDATETIME NULL,
    hc_nombre_rt     VARCHAR (30) NULL,
    hc_sec_ord_pago  INT NULL
    )
GO

CREATE TABLE ah_his_inmovilizadas
    (
    hi_cuenta cuenta NOT NULL,
    hi_saldo  MONEY NULL,
    hi_fecha  SMALLDATETIME NULL
    )
GO

CREATE TABLE ah_his_inmovilizadas1
    (
    hi_cuenta cuenta NOT NULL,
    hi_saldo  MONEY NULL,
    hi_fecha  SMALLDATETIME NULL
    )
GO

CREATE TABLE ah_his_inmovilizadas2
    (
    hi_cuenta cuenta NOT NULL,
    hi_saldo  MONEY NULL,
    hi_fecha  SMALLDATETIME NULL
    )
GO

CREATE TABLE ah_his_inmovilizadas3
    (
    hi_cuenta cuenta NOT NULL,
    hi_saldo  MONEY NULL,
    hi_fecha  SMALLDATETIME NULL
    )
GO

CREATE TABLE ah_his_inmovilizadas4
    (
    hi_cuenta cuenta NOT NULL,
    hi_saldo  MONEY NULL,
    hi_fecha  SMALLDATETIME NULL
    )
GO

CREATE TABLE ah_his_lineacred
    (
    hl_cuenta       INT NOT NULL,
    hl_secuencial   SMALLINT NOT NULL,
    hl_tipo         CHAR (1) NOT NULL,
    hl_fecha_aut    SMALLDATETIME NOT NULL,
    hl_monto_aut    MONEY NOT NULL,
    hl_fecha_uso    SMALLDATETIME NULL,
    hl_monto_uso    MONEY NULL,
    hl_fecha_ven    SMALLDATETIME NULL,
    hl_filial       TINYINT NOT NULL,
    hl_oficina      SMALLINT NOT NULL,
    hl_autorizante  login NOT NULL,
    hl_filial_anula TINYINT NULL,
    hl_ofi_anula    SMALLINT NULL,
    hl_aut_anula    login NULL
    )
GO

CREATE TABLE ah_imprime_plan
    (
    im_cuenta      INT NOT NULL,
    im_numero      INT NULL,
    im_fecha       VARCHAR (12) NULL,
    im_cuota       MONEY NULL,
    im_sldo_esp    MONEY NULL,
    im_saldo_hoy   MONEY NULL,
    im_diferencia  MONEY NULL,
    im_estado      CHAR (1) NULL,
    im_fecha_aprox DATETIME NULL,
    im_mto_mes     MONEY NULL
    )
GO

CREATE TABLE ah_imprime_plan_backup
    (
    im_cuenta      INT NOT NULL,
    im_numero      INT NULL,
    im_fecha       VARCHAR (12) NULL,
    im_cuota       MONEY NULL,
    im_sldo_esp    MONEY NULL,
    im_saldo_hoy   MONEY NULL,
    im_diferencia  MONEY NULL,
    im_estado      VARCHAR (10) NULL,
    im_fecha_aprox DATETIME NULL,
    im_mto_mes     MONEY NULL
    )
GO

CREATE TABLE ah_interfase
    (
    in_trn_code     SMALLINT NOT NULL,
    in_oficina_gen  SMALLINT NOT NULL,
    in_oficina_prop SMALLINT NOT NULL,
    in_monto        MONEY NOT NULL,
    in_signo        CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_lincredito
    (
    lc_cuenta      INT NOT NULL,
    lc_secuencial  SMALLINT NOT NULL,
    lc_tipo        CHAR (1) NOT NULL,
    lc_fecha_aut   SMALLDATETIME NOT NULL,
    lc_monto_aut   MONEY NOT NULL,
    lc_fecha_uso   SMALLDATETIME NULL,
    lc_monto_uso   MONEY NULL,
    lc_fecha_ven   SMALLDATETIME NOT NULL,
    lc_filial      TINYINT NOT NULL,
    lc_oficina     SMALLINT NOT NULL,
    lc_autorizante login NOT NULL
    )
GO

CREATE TABLE ah_linea_pendiente
    (
    lp_cuenta   INT NOT NULL,
    lp_linea    INT NOT NULL,
    lp_nemonico CHAR (4) NOT NULL,
    lp_valor    MONEY NOT NULL,
    lp_fecha    SMALLDATETIME NOT NULL,
    lp_control  INT NOT NULL,
    lp_signo    CHAR (1) NOT NULL,
    lp_enviada  CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_linea_pendiente1
    (
    lp_cuenta   INT NOT NULL,
    lp_linea    INT NOT NULL,
    lp_nemonico CHAR (4) NOT NULL,
    lp_valor    MONEY NOT NULL,
    lp_fecha    SMALLDATETIME NOT NULL,
    lp_control  INT NOT NULL,
    lp_signo    CHAR (1) NOT NULL,
    lp_enviada  CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_linea_pendiente2
    (
    lp_cuenta   INT NOT NULL,
    lp_linea    INT NOT NULL,
    lp_nemonico CHAR (4) NOT NULL,
    lp_valor    MONEY NOT NULL,
    lp_fecha    SMALLDATETIME NOT NULL,
    lp_control  INT NOT NULL,
    lp_signo    CHAR (1) NOT NULL,
    lp_enviada  CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_linea_pendiente3
    (
    lp_cuenta   INT NOT NULL,
    lp_linea    INT NOT NULL,
    lp_nemonico CHAR (4) NOT NULL,
    lp_valor    MONEY NOT NULL,
    lp_fecha    SMALLDATETIME NOT NULL,
    lp_control  INT NOT NULL,
    lp_signo    CHAR (1) NOT NULL,
    lp_enviada  CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_linea_pendiente4
    (
    lp_cuenta   INT NOT NULL,
    lp_linea    INT NOT NULL,
    lp_nemonico CHAR (4) NOT NULL,
    lp_valor    MONEY NOT NULL,
    lp_fecha    SMALLDATETIME NOT NULL,
    lp_control  INT NOT NULL,
    lp_signo    CHAR (1) NOT NULL,
    lp_enviada  CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_log_ctas_act
    (
    lca_cta_banco VARCHAR (24) NULL,
    lca_estado    CHAR (1) NULL,
    lca_cliente   INT NULL,
    lca_ced_ruc   VARCHAR (12) NULL,
    lca_control   CHAR (1) NULL
    )
GO

CREATE TABLE ah_marca_debit_aut
    (
    of_sucursal       VARCHAR (60) NULL,
    ah_oficina        VARCHAR (20) NULL,
    ah_cta_banco      VARCHAR (20) NULL,
    ah_ced_ruc        VARCHAR (20) NULL,
    ah_nombre         VARCHAR (60) NULL,
    op_banco          VARCHAR (20) NULL,
    op_cliente        VARCHAR (20) NULL,
    op_monto_aprobado VARCHAR (20) NULL
    )
GO

CREATE TABLE ah_mov_tarj_cobis
    (
    mc_fecha_tran     DATETIME NULL,
    mc_hora           SMALLDATETIME NULL,
    mc_tipo_tran      VARCHAR (3) NULL,
    mc_secuencial     INT NULL,
    mc_id_cliente     VARCHAR (30) NULL,
    mc_tarjeta        VARCHAR (19) NULL,
    mc_cta_banco      VARCHAR (24) NULL,
    mc_signo          CHAR (1) NULL,
    mc_correccion     CHAR (1) NULL,
    mc_sec_correccion INT NULL,
    mc_valor_tran     MONEY NULL,
    mc_causa          CHAR (3) NULL,
    mc_valor_comision MONEY NULL,
    mc_estado_conc    CHAR (4) NULL,
    mc_fecha_carga    DATETIME NULL,
    mc_fecha_conc     DATETIME NULL
    )
GO

CREATE TABLE ah_mov_tarj_red
    (
    mt_tipo_arch    CHAR (2) NULL,
    mt_tipo_reg     CHAR (2) NULL,
    mt_tipo_bol     CHAR (2) NULL,
    mt_cod_comp     CHAR (3) NULL,
    mt_bin          VARCHAR (6) NULL,
    mt_tipo_conv    CHAR (2) NULL,
    mt_espacio      VARCHAR (9) NULL,
    mt_cod_proc     VARCHAR (6) NULL,
    mt_dispositivo  CHAR (2) NULL,
    mt_terminal     VARCHAR (16) NULL,
    mt_comercio     CHAR (1) NULL,
    mt_pais         CHAR (2) NULL,
    mt_flag_seg     CHAR (1) NULL,
    mt_referencia   VARCHAR (12) NULL,
    mt_autorizacion VARCHAR (9) NULL,
    mt_estableci    VARCHAR (10) NULL,
    mt_fecha_tran   VARCHAR (8) NULL,
    mt_hora_tran    VARCHAR (6) NULL,
    mt_cod_lectura  VARCHAR (3) NULL,
    mt_miembro      VARCHAR (3) NULL,
    mt_mcc          VARCHAR (10) NULL,
    mt_moneda       VARCHAR (3) NULL,
    mt_origen       CHAR (1) NULL,
    mt_red          VARCHAR (4) NULL,
    mt_reverso      CHAR (1) NULL,
    mt_respuesta    CHAR (2) NULL,
    mt_tarjeta      VARCHAR (19) NULL,
    mt_tipo_tran    CHAR (2) NULL,
    mt_valor_com    MONEY NULL,
    mt_valor_disp   MONEY NULL,
    mt_valor_iva    MONEY NULL,
    mt_valor_tran   MONEY NULL,
    mt_tipo_mensaje VARCHAR (4) NULL,
    mt_nit_estable  VARCHAR (11) NULL,
    mt_id_cliente   VARCHAR (11) NULL,
    mt_estado       CHAR (4) NULL,
    mt_fecha_carga  DATETIME NULL,
    mt_fecha_conc   DATETIME NULL
    )
GO

CREATE TABLE ah_notcredeb1
    (
    secuencial     INT NOT NULL,
    ssn_branch     INT NULL,
    tipo_tran      INT NOT NULL,
    oficina        SMALLINT NOT NULL,
    filial         TINYINT NULL,
    usuario        VARCHAR (30) NOT NULL,
    terminal       VARCHAR (10) NOT NULL,
    correccion     CHAR (1) NULL,
    sec_correccion INT NULL,
    reentry        CHAR (1) NULL,
    origen         CHAR (1) NULL,
    nodo           descripcion NULL,
    fecha          SMALLDATETIME NULL,
    cta_banco      cuenta NULL,
    valor          MONEY NULL,
    remoto_ssn     INT NULL,
    moneda         TINYINT NULL,
    interes        MONEY NULL,
    val_cheque     MONEY NULL,
    indicador      TINYINT NULL,
    saldo_lib      MONEY NULL,
    control        INT NULL,
    causa          CHAR (3) NULL,
    fecha_efec     SMALLDATETIME NULL,
    signo          CHAR (1) NULL,
    alterno        INT NULL,
    saldocont      MONEY NULL,
    saldodisp      MONEY NULL,
    saldoint       MONEY NULL,
    departamento   SMALLINT NULL,
    oficina_cta    SMALLINT NULL,
    banco          SMALLINT NULL,
    hora           SMALLDATETIME NULL,
    concepto       VARCHAR (40) NULL,
    estado         CHAR (1) NULL,
    prod_banc      SMALLINT NOT NULL,
    categoria      CHAR (1) NOT NULL,
    monto_imp      MONEY NULL,
    tipo_exonerado VARCHAR (2) NULL,
    serial         VARCHAR (30) NULL,
    tipocta_super  CHAR (1) NOT NULL,
    turno          SMALLINT NULL,
    ctabanco_dep   cuenta NULL,
    cheque         INT NULL,
    stand_in       CHAR (1) NULL,
    canal          SMALLINT NULL,
    clase_clte     CHAR (1) NULL,
    oficial        SMALLINT NULL,
    monto_iva      MONEY NULL,
    cliente        INT NULL,
    base_imp       MONEY NULL,
    base_gmf       MONEY NULL
    )
GO

CREATE TABLE ah_notcredeb2
    (
    secuencial     INT NOT NULL,
    ssn_branch     INT NULL,
    tipo_tran      INT NOT NULL,
    oficina        SMALLINT NOT NULL,
    filial         TINYINT NULL,
    usuario        VARCHAR (30) NOT NULL,
    terminal       VARCHAR (10) NOT NULL,
    correccion     CHAR (1) NULL,
    sec_correccion INT NULL,
    reentry        CHAR (1) NULL,
    origen         CHAR (1) NULL,
    nodo           descripcion NULL,
    fecha          SMALLDATETIME NULL,
    cta_banco      cuenta NULL,
    valor          MONEY NULL,
    remoto_ssn     INT NULL,
    moneda         TINYINT NULL,
    interes        MONEY NULL,
    val_cheque     MONEY NULL,
    indicador      TINYINT NULL,
    saldo_lib      MONEY NULL,
    control        INT NULL,
    causa          CHAR (3) NULL,
    fecha_efec     SMALLDATETIME NULL,
    signo          CHAR (1) NULL,
    alterno        INT NULL,
    saldocont      MONEY NULL,
    saldodisp      MONEY NULL,
    saldoint       MONEY NULL,
    departamento   SMALLINT NULL,
    oficina_cta    SMALLINT NULL,
    banco          SMALLINT NULL,
    hora           SMALLDATETIME NULL,
    concepto       VARCHAR (40) NULL,
    estado         CHAR (1) NULL,
    prod_banc      SMALLINT NOT NULL,
    categoria      CHAR (1) NOT NULL,
    monto_imp      MONEY NULL,
    tipo_exonerado VARCHAR (2) NULL,
    serial         VARCHAR (30) NULL,
    tipocta_super  CHAR (1) NOT NULL,
    turno          SMALLINT NULL,
    ctabanco_dep   cuenta NULL,
    cheque         INT NULL,
    stand_in       CHAR (1) NULL,
    canal          SMALLINT NULL,
    clase_clte     CHAR (1) NULL,
    oficial        SMALLINT NULL,
    monto_iva      MONEY NULL,
    cliente        INT NULL,
    base_imp       MONEY NULL,
    base_gmf       MONEY NULL
    )
GO

CREATE TABLE ah_notcredeb3
    (
    secuencial     INT NOT NULL,
    ssn_branch     INT NULL,
    tipo_tran      INT NOT NULL,
    oficina        SMALLINT NOT NULL,
    filial         TINYINT NULL,
    usuario        VARCHAR (30) NOT NULL,
    terminal       VARCHAR (10) NOT NULL,
    correccion     CHAR (1) NULL,
    sec_correccion INT NULL,
    reentry        CHAR (1) NULL,
    origen         CHAR (1) NULL,
    nodo           descripcion NULL,
    fecha          SMALLDATETIME NULL,
    cta_banco      cuenta NULL,
    valor          MONEY NULL,
    remoto_ssn     INT NULL,
    moneda         TINYINT NULL,
    interes        MONEY NULL,
    val_cheque     MONEY NULL,
    indicador      TINYINT NULL,
    saldo_lib      MONEY NULL,
    control        INT NULL,
    causa          CHAR (3) NULL,
    fecha_efec     SMALLDATETIME NULL,
    signo          CHAR (1) NULL,
    alterno        INT NULL,
    saldocont      MONEY NULL,
    saldodisp      MONEY NULL,
    saldoint       MONEY NULL,
    departamento   SMALLINT NULL,
    oficina_cta    SMALLINT NULL,
    banco          SMALLINT NULL,
    hora           SMALLDATETIME NULL,
    concepto       VARCHAR (40) NULL,
    estado         CHAR (1) NULL,
    prod_banc      SMALLINT NOT NULL,
    categoria      CHAR (1) NOT NULL,
    monto_imp      MONEY NULL,
    tipo_exonerado VARCHAR (2) NULL,
    serial         VARCHAR (30) NULL,
    tipocta_super  CHAR (1) NOT NULL,
    turno          SMALLINT NULL,
    ctabanco_dep   cuenta NULL,
    cheque         INT NULL,
    stand_in       CHAR (1) NULL,
    canal          SMALLINT NULL,
    clase_clte     CHAR (1) NULL,
    oficial        SMALLINT NULL,
    monto_iva      MONEY NULL,
    cliente        INT NULL,
    base_imp       MONEY NULL,
    base_gmf       MONEY NULL
    )
GO

CREATE TABLE ah_notcredeb4
    (
    secuencial     INT NOT NULL,
    ssn_branch     INT NULL,
    tipo_tran      INT NOT NULL,
    oficina        SMALLINT NOT NULL,
    filial         TINYINT NULL,
    usuario        VARCHAR (30) NOT NULL,
    terminal       VARCHAR (10) NOT NULL,
    correccion     CHAR (1) NULL,
    sec_correccion INT NULL,
    reentry        CHAR (1) NULL,
    origen         CHAR (1) NULL,
    nodo           descripcion NULL,
    fecha          SMALLDATETIME NULL,
    cta_banco      cuenta NULL,
    valor          MONEY NULL,
    remoto_ssn     INT NULL,
    moneda         TINYINT NULL,
    interes        MONEY NULL,
    val_cheque     MONEY NULL,
    indicador      TINYINT NULL,
    saldo_lib      MONEY NULL,
    control        INT NULL,
    causa          CHAR (3) NULL,
    fecha_efec     SMALLDATETIME NULL,
    signo          CHAR (1) NULL,
    alterno        INT NULL,
    saldocont      MONEY NULL,
    saldodisp      MONEY NULL,
    saldoint       MONEY NULL,
    departamento   SMALLINT NULL,
    oficina_cta    SMALLINT NULL,
    banco          SMALLINT NULL,
    hora           SMALLDATETIME NULL,
    concepto       VARCHAR (40) NULL,
    estado         CHAR (1) NULL,
    prod_banc      SMALLINT NOT NULL,
    categoria      CHAR (1) NOT NULL,
    monto_imp      MONEY NULL,
    tipo_exonerado VARCHAR (2) NULL,
    serial         VARCHAR (30) NULL,
    tipocta_super  CHAR (1) NOT NULL,
    turno          SMALLINT NULL,
    ctabanco_dep   cuenta NULL,
    cheque         INT NULL,
    stand_in       CHAR (1) NULL,
    canal          SMALLINT NULL,
    clase_clte     CHAR (1) NULL,
    oficial        SMALLINT NULL,
    monto_iva      MONEY NULL,
    cliente        INT NULL,
    base_imp       MONEY NULL,
    base_gmf       MONEY NULL
    )
GO

CREATE TABLE ah_ofica
    (
    ao_dato VARCHAR (8000) NULL
    )
GO

CREATE TABLE ah_oficina_ctas_cifradas
    (
    oc_oficina SMALLINT NOT NULL,
    oc_estado  CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_param_dtn
    (
    pd_sucursal   INT NOT NULL,
    pd_profinal   SMALLINT NOT NULL,
    pd_categoria  CHAR (1) NOT NULL,
    pd_estado     CHAR (1) NOT NULL,
    pd_codigo_dtn CHAR (2) NOT NULL
    )
GO

CREATE TABLE ah_periodo
    (
    pe_capitalizacion CHAR (1) NOT NULL,
    pe_periodo        SMALLINT NOT NULL,
    pe_fecha_inicio   SMALLDATETIME NOT NULL,
    pe_fecha_fin      SMALLDATETIME NOT NULL,
    pe_num_dias       SMALLINT NOT NULL
    )
GO

CREATE TABLE ah_rango_oficina_batch
    (
    rb_rango       TINYINT NOT NULL,
    rb_oficina_ini SMALLINT NOT NULL,
    rb_oficina_fin SMALLINT NOT NULL,
    rb_cuenta      cuenta NOT NULL,
    rb_lp_sec      INT NOT NULL
    )
GO

CREATE TABLE ah_rangos_saldos
    (
    rs_moneda         TINYINT NOT NULL,
    rs_secuencial     INT NOT NULL,
    rs_rango_ini      MONEY NOT NULL,
    rs_rango_fin      MONEY NOT NULL,
    rs_saldo_contable MONEY NOT NULL,
    rs_num_cuentas_c  INT NOT NULL,
    rs_saldo_promedio MONEY NOT NULL,
    rs_num_cuentas_p  INT NOT NULL,
    rs_saldo_minimo   MONEY NOT NULL,
    rs_num_cuentas_m  INT NOT NULL
    )
GO

CREATE TABLE ah_relacion_navidad
    (
    rn_codigo SMALLINT NOT NULL,
    rn_nombre descripcion NOT NULL,
    rn_ach    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_rep_cta_dtn
    (
    cd_cuenta      VARCHAR (24) NULL,
    cd_id_ente     VARCHAR (30) NULL,
    cd_nombre      VARCHAR (60) NULL,
    cd_disponible  MONEY NULL,
    cd_fecha_inac  DATETIME NULL,
    cd_tipo_cta    VARCHAR (60) NULL,
    cd_dias_inac   SMALLINT NULL,
    cd_tel_fijo    VARCHAR (16) NULL,
    cd_celular     VARCHAR (16) NULL,
    cd_oficina     SMALLINT NULL,
    cd_nom_oficina VARCHAR (60) NULL,
    cd_zona        SMALLINT NULL,
    cd_nom_zona    VARCHAR (30) NULL,
    cd_tipo_soc    VARCHAR (60) NULL,
    cd_exenta      CHAR (1) NULL,
    cd_tipo_cli    VARCHAR (10) NULL
    )
GO

CREATE TABLE ah_rep_retiros_ofic
    (
    rr_oficina     SMALLINT NULL,
    rr_cta_banco   cuenta NOT NULL,
    rr_ente        INT NULL,
    rr_tipo_ced    VARCHAR (2) NULL,
    rr_ced_ruc     VARCHAR (30) NULL,
    rr_num_retiros INT NULL,
    rr_retiro_efec MONEY NULL,
    rr_retiro_chq  MONEY NULL
    )
GO

CREATE TABLE ah_rep_rex
    (
    rr_contenido VARCHAR (1000) NULL
    )
GO

CREATE TABLE ah_rep_tran_caja
    (
    tc_mes         CHAR (2) NULL,
    tc_anio        CHAR (4) NULL,
    tc_oficina     SMALLINT NULL,
    tc_transaccion INT NULL,
    ts_destran     VARCHAR (255) NULL,
    tc_cantidad    INT NULL,
    tc_monto       MONEY NULL
    )
GO

CREATE TABLE ah_reporte_aho
    (
    zona_oficina        VARCHAR (255) NULL,
    territorial_oficina VARCHAR (255) NULL,
    cod_oficina         INT NULL,
    nom_oficina         VARCHAR (255) NULL,
    nro_cuenta          VARCHAR (64) NULL,
    est_cuenta          VARCHAR (15) NULL,
    cliente             INT NULL,
    cedula_cliente      VARCHAR (24) NULL,
    nombre_cliente      VARCHAR (255) NULL,
    genero              VARCHAR (10) NULL,
    edad                INT NULL,
    fecha_aper          VARCHAR (10) NULL,
    actividad           VARCHAR (25) NULL,
    nivel_educa         VARCHAR (30) NULL,
    tel_residencia      VARCHAR (50) NULL,
    ciu_residencia      VARCHAR (25) NULL,
    segmento            VARCHAR (15) NULL,
    categoria           VARCHAR (25) NULL,
    plazo_ahorro        INT NULL,
    valor_mes_ahorro    MONEY NULL,
    monto_final         MONEY NULL,
    numero_cuota        INT NULL,
    cumple_plan         VARCHAR (2) NULL,
    num_cuo_cumple      INT NULL,
    num_cuo_nocumple    INT NULL,
    cuo_nocumple        INT NULL,
    fecha_ult_incump    VARCHAR (10) NULL,
    no_cumple           INT NULL,
    saldo_plan_ahorro   INT NULL,
    saldo_cuenta        INT NULL,
    tasa_interes        FLOAT NULL,
    puntos_premio       FLOAT NULL,
    valor_total_canc    MONEY NULL,
    valor_total_canc_in MONEY NULL,
    oficial             VARCHAR (20) NULL
    )
GO

CREATE TABLE ah_reporte_aho_cab
    (
    zona_oficina        VARCHAR (36) NULL,
    territorial_oficina VARCHAR (36) NULL,
    cod_oficina         VARCHAR (36) NULL,
    nom_oficina         VARCHAR (36) NULL,
    nro_cuenta          VARCHAR (36) NULL,
    est_cuenta          VARCHAR (36) NULL,
    cliente             VARCHAR (36) NULL,
    cedula_cliente      VARCHAR (36) NULL,
    nombre_cliente      VARCHAR (36) NULL,
    genero              VARCHAR (36) NULL,
    edad                VARCHAR (36) NULL,
    fecha_aper          VARCHAR (36) NULL,
    actividad           VARCHAR (36) NULL,
    nivel_educa         VARCHAR (36) NULL,
    tel_residencia      VARCHAR (36) NULL,
    ciu_residencia      VARCHAR (36) NULL,
    segmento            VARCHAR (36) NULL,
    categoria           VARCHAR (36) NULL,
    plazo_ahorro        VARCHAR (36) NULL,
    valor_mes_ahorro    VARCHAR (36) NULL,
    monto_final         VARCHAR (36) NULL,
    numero_cuota        VARCHAR (36) NULL,
    cumple_plan         VARCHAR (36) NULL,
    num_cuo_cumple      VARCHAR (36) NULL,
    num_cuo_nocumple    VARCHAR (36) NULL,
    cuo_nocumple        VARCHAR (36) NULL,
    fecha_ult_incump    VARCHAR (36) NULL,
    no_cumple           VARCHAR (36) NULL,
    saldo_plan_ahorro   VARCHAR (36) NULL,
    saldo_cuenta        VARCHAR (36) NULL,
    tasa_interes        VARCHAR (36) NULL,
    puntos_premio       VARCHAR (36) NULL,
    valor_total_canc    VARCHAR (36) NULL,
    valor_total_canc_in VARCHAR (36) NULL,
    oficial             VARCHAR (36) NULL
    )
GO

CREATE TABLE ah_reporte_comercio_cta
    (
    tipo_id         VARCHAR (2) NULL,
    identificacion  VARCHAR (24) NULL,
    codigo_comercio VARCHAR (24) NULL,
    tipo_tran       VARCHAR (255) NULL,
    causal          VARCHAR (255) NULL,
    monto           MONEY NULL,
    fecha_tran      VARCHAR (16) NULL,
    hora_tran       VARCHAR (16) NULL,
    id_tran         VARCHAR (36) NULL,
    estado_tran     VARCHAR (255) NULL,
    ctaahoorg       VARCHAR (24) NULL,
    ctaahodest      VARCHAR (24) NULL
    )
GO

CREATE TABLE ah_reporte_devolucion_tmp
    (
    rd_secuencial   INT IDENTITY NOT NULL,
    rd_fecha        DATETIME NOT NULL,
    rd_cash_in      MONEY NOT NULL,
    rd_cash_out     MONEY NOT NULL,
    rd_pos_neta     MONEY NOT NULL,
    rd_val_recaudo  MONEY NOT NULL,
    rd_pend_cubrir  MONEY NOT NULL,
    rd_saldo_cierre MONEY NOT NULL,
    rd_cta_banco    CHAR (16) NOT NULL,
    rd_usuario      VARCHAR (30) NOT NULL
    )
GO

CREATE TABLE ah_reporte_plan
    (
    rp_secuencial  INT IDENTITY NOT NULL,
    rp_oficina     SMALLINT NOT NULL,
    rp_cliente     INT NOT NULL,
    rp_cta_banco   CHAR (16) NOT NULL,
    rp_ced_ruc     numero NOT NULL,
    rp_nomlar      VARCHAR (254) NOT NULL,
    rp_fecha_aper  SMALLDATETIME NOT NULL,
    rp_cuota       MONEY NULL,
    rp_mto_mes     MONEY NULL,
    rp_saldo_mes   MONEY NULL,
    rp_saldo_esp   MONEY NULL,
    rp_diferencia  MONEY NULL,
    rp_telefono    VARCHAR (16) NULL,
    rp_estado      CHAR (1) NULL,
    rp_fecha_aprox DATETIME NULL,
    rp_producto    SMALLINT NULL,
    rp_prod_banc   SMALLINT NULL
    )
GO

CREATE TABLE ah_reporte_plan_incump
    (
    pi_oficina      SMALLINT NOT NULL,
    pi_total_ctas   INT NOT NULL,
    pi_total_dispon MONEY NOT NULL,
    pi_total_esper  MONEY NOT NULL,
    pi_prod_banc    SMALLINT NOT NULL
    )
GO

CREATE TABLE ah_reporte_plan_venc
    (
    pv_oficina      SMALLINT NOT NULL,
    pv_total_ctas   INT NOT NULL,
    pv_total_dispon MONEY NOT NULL,
    pv_total_esper  MONEY NOT NULL,
    pv_prod_banc    SMALLINT NOT NULL
    )
GO

CREATE TABLE ah_reporte_vsuspenso
    (
    ah_fecha           DATETIME NULL,
    ah_ofi_suspenso    SMALLINT NULL,
    ah_ofi_sus_desc    VARCHAR (64) NULL,
    ah_oficina_cta     SMALLINT NULL,
    ah_nom_oficina_cta VARCHAR (64) NULL,
    ah_zona_cta        INT NULL,
    ah_zona_cta_desc   VARCHAR (64) NULL,
    ah_causal          CHAR (3) NULL,
    ah_concepto        VARCHAR (64) NULL,
    ah_fecha_cobro     VARCHAR (10) NULL,
    ah_valor           MONEY NULL,
    ah_nombre_cliente  VARCHAR (60) NULL,
    ah_id_cliente      VARCHAR (15) NULL,
    ah_cuenta          VARCHAR (16) NULL,
    ah_saldo_cuenta    VARCHAR (20) NULL,
    ah_dias            VARCHAR (20) NULL
    )
GO

CREATE TABLE ah_resumen_ctacontrac
    (
    rc_tipo_reporte  TINYINT NULL,
    rc_regional      INT NULL,
    rc_zona          INT NULL,
    rc_oficina       INT NULL,
    rc_prod_banc     TINYINT NULL,
    rc_categoria     CHAR (1) NULL,
    rc_cliente       INT NULL,
    rc_nombre        CHAR (64) NULL,
    rc_cuenta        INT NULL,
    rc_cta_banco     CHAR (16) NULL,
    rc_saldo_mes_ant MONEY NULL,
    rc_debitos       MONEY NULL,
    rc_creditos      MONEY NULL,
    rc_mvto_mes      MONEY NULL,
    rc_saldo_mes     MONEY NULL,
    rc_num_cuota     TINYINT NULL,
    rc_vlr_cuota     MONEY NULL,
    rc_saldo_esp     MONEY NULL,
    rc_diferencia    MONEY NULL
    )
GO

CREATE TABLE ah_retencion_locales
    (
    rl_agencia     SMALLINT NOT NULL,
    rl_dias        TINYINT NOT NULL,
    rl_hora_inicio SMALLDATETIME NULL,
    rl_hora_fin    SMALLDATETIME NULL
    )
GO

CREATE TABLE ah_saldo_diario1
    (
    sd_cuenta           INT NOT NULL,
    sd_fecha            SMALLDATETIME NOT NULL,
    sd_12h              MONEY NOT NULL,
    sd_24h              MONEY NOT NULL,
    sd_48h              MONEY NOT NULL,
    sd_remesas          MONEY NOT NULL,
    sd_saldo_contable   MONEY NOT NULL,
    sd_saldo_disponible MONEY NULL,
    sd_tasa_contable    REAL NOT NULL,
    sd_tasa_disponible  REAL NULL,
    sd_int_hoy          MONEY NOT NULL,
    sd_estado           CHAR (1) NOT NULL,
    sd_categoria        CHAR (1) NOT NULL,
    sd_prod_banc        SMALLINT NOT NULL,
    sd_dias             TINYINT NULL,
    sd_prom_disponible  MONEY NULL,
    sd_promedio1        MONEY NULL
    )
GO

CREATE TABLE ah_saldo_diario2
    (
    sd_cuenta           INT NOT NULL,
    sd_fecha            SMALLDATETIME NOT NULL,
    sd_12h              MONEY NOT NULL,
    sd_24h              MONEY NOT NULL,
    sd_48h              MONEY NOT NULL,
    sd_remesas          MONEY NOT NULL,
    sd_saldo_contable   MONEY NOT NULL,
    sd_saldo_disponible MONEY NULL,
    sd_tasa_contable    REAL NOT NULL,
    sd_tasa_disponible  REAL NULL,
    sd_int_hoy          MONEY NOT NULL,
    sd_estado           CHAR (1) NOT NULL,
    sd_categoria        CHAR (1) NOT NULL,
    sd_prod_banc        SMALLINT NOT NULL,
    sd_dias             TINYINT NULL,
    sd_prom_disponible  MONEY NULL,
    sd_promedio1        MONEY NULL
    )
GO

CREATE TABLE ah_saldo_diario3
    (
    sd_cuenta           INT NOT NULL,
    sd_fecha            SMALLDATETIME NOT NULL,
    sd_12h              MONEY NOT NULL,
    sd_24h              MONEY NOT NULL,
    sd_48h              MONEY NOT NULL,
    sd_remesas          MONEY NOT NULL,
    sd_saldo_contable   MONEY NOT NULL,
    sd_saldo_disponible MONEY NULL,
    sd_tasa_contable    REAL NOT NULL,
    sd_tasa_disponible  REAL NULL,
    sd_int_hoy          MONEY NOT NULL,
    sd_estado           CHAR (1) NOT NULL,
    sd_categoria        CHAR (1) NOT NULL,
    sd_prod_banc        SMALLINT NOT NULL,
    sd_dias             TINYINT NULL,
    sd_prom_disponible  MONEY NULL,
    sd_promedio1        MONEY NULL
    )
GO

CREATE TABLE ah_saldo_diario4
    (
    sd_cuenta           INT NOT NULL,
    sd_fecha            SMALLDATETIME NOT NULL,
    sd_12h              MONEY NOT NULL,
    sd_24h              MONEY NOT NULL,
    sd_48h              MONEY NOT NULL,
    sd_remesas          MONEY NOT NULL,
    sd_saldo_contable   MONEY NOT NULL,
    sd_saldo_disponible MONEY NULL,
    sd_tasa_contable    REAL NOT NULL,
    sd_tasa_disponible  REAL NULL,
    sd_int_hoy          MONEY NOT NULL,
    sd_estado           CHAR (1) NOT NULL,
    sd_categoria        CHAR (1) NOT NULL,
    sd_prod_banc        SMALLINT NOT NULL,
    sd_dias             TINYINT NULL,
    sd_prom_disponible  MONEY NULL,
    sd_promedio1        MONEY NULL
    )
GO

CREATE TABLE ah_saldos_cta
    (
    sd_dato VARCHAR (300) NULL
    )
GO

CREATE TABLE ah_saldos_rep
    (
    se_cuenta         cuenta NOT NULL,
    se_nombre         VARCHAR (64) NOT NULL,
    se_oficina        SMALLINT NOT NULL,
    se_moneda         TINYINT NOT NULL,
    se_prod_banc      SMALLINT NOT NULL,
    se_categoria      CHAR (1) NOT NULL,
    se_saldo_contable MONEY NOT NULL,
    se_saldo_ayer     MONEY NOT NULL,
    se_saldo_mayor    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_saldos_rep1
    (
    se_cuenta         cuenta NOT NULL,
    se_nombre         VARCHAR (64) NOT NULL,
    se_oficina        SMALLINT NOT NULL,
    se_moneda         TINYINT NOT NULL,
    se_prod_banc      SMALLINT NOT NULL,
    se_categoria      CHAR (1) NOT NULL,
    se_saldo_contable MONEY NOT NULL,
    se_saldo_ayer     MONEY NOT NULL,
    se_saldo_mayor    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_saldos_rep2
    (
    se_cuenta         cuenta NOT NULL,
    se_nombre         VARCHAR (64) NOT NULL,
    se_oficina        SMALLINT NOT NULL,
    se_moneda         TINYINT NOT NULL,
    se_prod_banc      SMALLINT NOT NULL,
    se_categoria      CHAR (1) NOT NULL,
    se_saldo_contable MONEY NOT NULL,
    se_saldo_ayer     MONEY NOT NULL,
    se_saldo_mayor    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_saldos_rep3
    (
    se_cuenta         cuenta NOT NULL,
    se_nombre         VARCHAR (64) NOT NULL,
    se_oficina        SMALLINT NOT NULL,
    se_moneda         TINYINT NOT NULL,
    se_prod_banc      SMALLINT NOT NULL,
    se_categoria      CHAR (1) NOT NULL,
    se_saldo_contable MONEY NOT NULL,
    se_saldo_ayer     MONEY NOT NULL,
    se_saldo_mayor    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_saldos_rep4
    (
    se_cuenta         cuenta NOT NULL,
    se_nombre         VARCHAR (64) NOT NULL,
    se_oficina        SMALLINT NOT NULL,
    se_moneda         TINYINT NOT NULL,
    se_prod_banc      SMALLINT NOT NULL,
    se_categoria      CHAR (1) NOT NULL,
    se_saldo_contable MONEY NOT NULL,
    se_saldo_ayer     MONEY NOT NULL,
    se_saldo_mayor    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_saldoscompensa_actpas
    (
    sc_cuenta      INT NULL,
    sc_cliente     INT NULL,
    sc_documento   VARCHAR (30) NULL,
    sc_saldo       MONEY NULL,
    sc_cta_banco   VARCHAR (20) NULL,
    sc_titularidad CHAR (1) NULL,
    sc_estado      CHAR (1) NULL,
    sc_oficina     SMALLINT NULL,
    sc_moneda      TINYINT NULL,
    sc_producto    TINYINT NULL,
    sc_prod_banc   SMALLINT NULL
    )
GO

CREATE TABLE ah_seg_plan
    (
    im_cuenta      INT NULL,
    im_numero      INT NULL,
    im_cuota       MONEY NULL,
    im_sldo_esp    MONEY NULL,
    im_estado      CHAR (1) NULL,
    im_fecha_aprox DATETIME NULL
    )
GO

CREATE TABLE ah_servicio
    (
    se_servicio      TINYINT NOT NULL,
    se_descripcion   descripcion NOT NULL,
    se_clasificacion CHAR (1) NOT NULL,
    se_tipo          CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_solicitud_cuenta
    (
    sc_numsol          INT NOT NULL,
    sc_fecha           DATETIME NOT NULL,
    sc_ofi             SMALLINT NOT NULL,
    sc_user            login NULL,
    sc_estado          CHAR (2) NULL,
    sc_moneda          TINYINT NOT NULL,
    sc_tipo            VARCHAR (5) NULL,
    sc_depar           VARCHAR (5) NULL,
    sc_feccal          DATETIME NOT NULL,
    sc_usercal         login NULL,
    sc_categoria       CHAR (1) NOT NULL,
    sc_mala_referencia CHAR (1) NOT NULL,
    sc_desc            VARCHAR (255) NULL
    )
GO

CREATE TABLE ah_sorteo_agrob
    (
    sa_secuencial   INT NOT NULL,
    sa_agencia      SMALLINT NOT NULL,
    sa_cta_banco    VARCHAR (16) NOT NULL,
    sa_nombre       VARCHAR (64) NOT NULL,
    sa_saldo_minimo MONEY NOT NULL,
    sa_saldo_actual MONEY NOT NULL,
    sa_tipo_sorteo  CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_temp_devgmf
    (
    td_cta_banco cuenta NOT NULL,
    td_cuenta    INT NOT NULL,
    td_oficina   SMALLINT NOT NULL,
    td_mes       TINYINT NOT NULL,
    td_acum_efe  MONEY NULL,
    td_acum_imp  MONEY NULL,
    td_acum_gmfn MONEY NULL,
    td_acum_int  MONEY NULL,
    td_acum_gfmi MONEY NULL,
    td_categoria CHAR (1) NULL
    )
GO

CREATE TABLE ah_tipotrx_mes
    (
    tm_cta_banco    CHAR (20) NOT NULL,
    tm_tipo_tran    INT NOT NULL,
    tm_contador_trx INT NOT NULL
    )
GO

CREATE TABLE ah_total_ciiu
    (
    tc_fecha     DATETIME NOT NULL,
    tc_escala    TINYINT NOT NULL,
    tc_numero    INT NOT NULL,
    tc_saldo     MONEY NOT NULL,
    tc_prod_banc SMALLINT NOT NULL,
    tc_moneda    TINYINT NOT NULL,
    tc_oficina   SMALLINT NOT NULL,
    tc_estado    CHAR (1) NOT NULL,
    tc_categoria CHAR (1) NOT NULL,
    tc_tasa      REAL NOT NULL
    )
GO

CREATE TABLE ah_total_escala
    (
    te_fecha     DATETIME NOT NULL,
    te_escala    TINYINT NOT NULL,
    te_numero    INT NOT NULL,
    te_saldo     MONEY NOT NULL,
    te_saldo_min MONEY NOT NULL,
    te_prod_banc SMALLINT NOT NULL,
    te_moneda    TINYINT NOT NULL,
    te_tasa      REAL NOT NULL,
    te_categoria CHAR (1) NOT NULL,
    te_estado    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_totales_interofi
    (
    ti_moneda       TINYINT NOT NULL,
    ti_ofi_des      SMALLINT NOT NULL,
    ti_ofi_ori      SMALLINT NOT NULL,
    ti_prod_banc    SMALLINT NOT NULL,
    ti_categoria    CHAR (1) NOT NULL,
    ti_valor_cre    MONEY NOT NULL,
    ti_valor_cre_me MONEY NOT NULL,
    ti_valor_deb    MONEY NOT NULL,
    ti_valor_deb_me MONEY NOT NULL
    )
GO

CREATE TABLE ah_tran_mensual
    (
    tm_ano      CHAR (4) NOT NULL,
    tm_mes      CHAR (2) NOT NULL,
    tm_cuenta   VARCHAR (24) NOT NULL,
    tm_cod_trn  INT NOT NULL,
    tm_cantidad INT NOT NULL
    )
GO


CREATE TABLE ah_tran_rechazos
    (
    tr_fecha        DATETIME NULL,
    tr_oficina      SMALLINT NULL,
    tr_cod_cliente  INT NULL,
    tr_id_cliente   VARCHAR (30) NULL,
    tr_nom_cliente  VARCHAR (255) NULL,
    tr_cta_banco    VARCHAR (24) NULL,
    tr_tipo_tran    INT NULL,
    tr_nom_tran     VARCHAR (64) NULL,
    tr_vlr_comision MONEY NULL,
    tr_vlr_iva      MONEY NULL,
    tr_modulo       CHAR (3) NULL,
    tr_causal_rech  INT NULL
    )
GO

CREATE TABLE ah_trn_deposito_inicial
    (
    di_tran        INT NOT NULL,
    di_causal      VARCHAR (3) NOT NULL,
    di_descripcion VARCHAR (64) NOT NULL,
    di_estado      CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_trn_grupo
    (
    tg_transaccion     INT NOT NULL,
    tg_grupo           TINYINT NOT NULL,
    tg_afecta_efectivo CHAR (1) NOT NULL,
    tg_afecta_signo    CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_tsval_suspenso1
    (
    secuencial    INT NOT NULL,
    ssn_branch    INT NULL,
    tipo_tran     INT NOT NULL,
    oficina       SMALLINT NULL,
    usuario       descripcion NULL,
    terminal      descripcion NULL,
    correccion    CHAR (1) NULL,
    reentry       CHAR (1) NULL,
    origen        CHAR (1) NULL,
    nodo          VARCHAR (30) NULL,
    fecha         SMALLDATETIME NOT NULL,
    cta_banco     cuenta NULL,
    valor         MONEY NULL,
    interes       MONEY NULL,
    indicador     TINYINT NULL,
    servicio      VARCHAR (3) NULL,
    remoto_ssn    INT NULL,
    moneda        TINYINT NULL,
    ssn_corr      INT NULL,
    alterno       INT NULL,
    oficina_cta   SMALLINT NULL,
    hora          SMALLDATETIME NULL,
    prod_banc     SMALLINT NULL,
    categoria     CHAR (1) NULL,
    tipocta_super CHAR (1) NULL,
    turno         SMALLINT NULL,
    serial        descripcion NULL,
    cliente       INT NULL
    )
GO

CREATE TABLE ah_tsval_suspenso2
    (
    secuencial    INT NOT NULL,
    ssn_branch    INT NULL,
    tipo_tran     INT NOT NULL,
    oficina       SMALLINT NULL,
    usuario       descripcion NULL,
    terminal      descripcion NULL,
    correccion    CHAR (1) NULL,
    reentry       CHAR (1) NULL,
    origen        CHAR (1) NULL,
    nodo          VARCHAR (30) NULL,
    fecha         SMALLDATETIME NOT NULL,
    cta_banco     cuenta NULL,
    valor         MONEY NULL,
    interes       MONEY NULL,
    indicador     TINYINT NULL,
    servicio      VARCHAR (3) NULL,
    remoto_ssn    INT NULL,
    moneda        TINYINT NULL,
    ssn_corr      INT NULL,
    alterno       INT NULL,
    oficina_cta   SMALLINT NULL,
    hora          SMALLDATETIME NULL,
    prod_banc     SMALLINT NULL,
    categoria     CHAR (1) NULL,
    tipocta_super CHAR (1) NULL,
    turno         SMALLINT NULL,
    serial        descripcion NULL,
    cliente       INT NULL
    )
GO

CREATE TABLE ah_tsval_suspenso3
    (
    secuencial    INT NOT NULL,
    ssn_branch    INT NULL,
    tipo_tran     INT NOT NULL,
    oficina       SMALLINT NULL,
    usuario       descripcion NULL,
    terminal      descripcion NULL,
    correccion    CHAR (1) NULL,
    reentry       CHAR (1) NULL,
    origen        CHAR (1) NULL,
    nodo          VARCHAR (30) NULL,
    fecha         SMALLDATETIME NOT NULL,
    cta_banco     cuenta NULL,
    valor         MONEY NULL,
    interes       MONEY NULL,
    indicador     TINYINT NULL,
    servicio      VARCHAR (3) NULL,
    remoto_ssn    INT NULL,
    moneda        TINYINT NULL,
    ssn_corr      INT NULL,
    alterno       INT NULL,
    oficina_cta   SMALLINT NULL,
    hora          SMALLDATETIME NULL,
    prod_banc     SMALLINT NULL,
    categoria     CHAR (1) NULL,
    tipocta_super CHAR (1) NULL,
    turno         SMALLINT NULL,
    serial        descripcion NULL,
    cliente       INT NULL
    )
GO

CREATE TABLE ah_tsval_suspenso4
    (
    secuencial    INT NOT NULL,
    ssn_branch    INT NULL,
    tipo_tran     INT NOT NULL,
    oficina       SMALLINT NULL,
    usuario       descripcion NULL,
    terminal      descripcion NULL,
    correccion    CHAR (1) NULL,
    reentry       CHAR (1) NULL,
    origen        CHAR (1) NULL,
    nodo          VARCHAR (30) NULL,
    fecha         SMALLDATETIME NOT NULL,
    cta_banco     cuenta NULL,
    valor         MONEY NULL,
    interes       MONEY NULL,
    indicador     TINYINT NULL,
    servicio      VARCHAR (3) NULL,
    remoto_ssn    INT NULL,
    moneda        TINYINT NULL,
    ssn_corr      INT NULL,
    alterno       INT NULL,
    oficina_cta   SMALLINT NULL,
    hora          SMALLDATETIME NULL,
    prod_banc     SMALLINT NULL,
    categoria     CHAR (1) NULL,
    tipocta_super CHAR (1) NULL,
    turno         SMALLINT NULL,
    serial        descripcion NULL,
    cliente       INT NULL
    )
GO

CREATE TABLE ah_universo_ahmensual
    (
    cta_banco cuenta NOT NULL,
    hijo      INT NOT NULL,
    orden     INT IDENTITY NOT NULL
    )
GO

CREATE TABLE ah_usa_linea
    (
    ul_capitalizacion CHAR (1) NOT NULL,
    ul_usa            CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_val_suspenso
    (
    vs_cuenta     INT NOT NULL,
    vs_secuencial INT NOT NULL,
    vs_servicio   CHAR (3) NOT NULL,
    vs_valor      MONEY NOT NULL,
    vs_oficina    SMALLINT NOT NULL,
    vs_fecha      SMALLDATETIME NOT NULL,
    vs_hora       SMALLDATETIME NOT NULL,
    vs_ssn        INT NOT NULL,
    vs_estado     CHAR (1) NOT NULL,
    vs_procesada  CHAR (1) NOT NULL,
    vs_clave      INT NOT NULL,
    vs_impuesto   CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_val_suspenso1
    (
    vs_cuenta     INT NOT NULL,
    vs_secuencial INT NOT NULL,
    vs_servicio   CHAR (3) NOT NULL,
    vs_valor      MONEY NOT NULL,
    vs_oficina    SMALLINT NOT NULL,
    vs_fecha      SMALLDATETIME NOT NULL,
    vs_hora       SMALLDATETIME NOT NULL,
    vs_ssn        INT NOT NULL,
    vs_estado     CHAR (1) NOT NULL,
    vs_procesada  CHAR (1) NOT NULL,
    vs_clave      INT NOT NULL,
    vs_impuesto   CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_val_suspenso2
    (
    vs_cuenta     INT NOT NULL,
    vs_secuencial INT NOT NULL,
    vs_servicio   CHAR (3) NOT NULL,
    vs_valor      MONEY NOT NULL,
    vs_oficina    SMALLINT NOT NULL,
    vs_fecha      SMALLDATETIME NOT NULL,
    vs_hora       SMALLDATETIME NOT NULL,
    vs_ssn        INT NOT NULL,
    vs_estado     CHAR (1) NOT NULL,
    vs_procesada  CHAR (1) NOT NULL,
    vs_clave      INT NOT NULL,
    vs_impuesto   CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_val_suspenso3
    (
    vs_cuenta     INT NOT NULL,
    vs_secuencial INT NOT NULL,
    vs_servicio   CHAR (3) NOT NULL,
    vs_valor      MONEY NOT NULL,
    vs_oficina    SMALLINT NOT NULL,
    vs_fecha      SMALLDATETIME NOT NULL,
    vs_hora       SMALLDATETIME NOT NULL,
    vs_ssn        INT NOT NULL,
    vs_estado     CHAR (1) NOT NULL,
    vs_procesada  CHAR (1) NOT NULL,
    vs_clave      INT NOT NULL,
    vs_impuesto   CHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_val_suspenso4
    (
    vs_cuenta     INT NOT NULL,
    vs_secuencial INT NOT NULL,
    vs_servicio   CHAR (3) NOT NULL,
    vs_valor      MONEY NOT NULL,
    vs_oficina    SMALLINT NOT NULL,
    vs_fecha      SMALLDATETIME NOT NULL,
    vs_hora       SMALLDATETIME NOT NULL,
    vs_ssn        INT NOT NULL,
    vs_estado     CHAR (1) NOT NULL,
    vs_procesada  CHAR (1) NOT NULL,
    vs_clave      INT NOT NULL,
    vs_impuesto   CHAR (1) NOT NULL
    )
GO

CREATE TABLE asiento_aho
    (
    de_tran            VARCHAR (10) NULL,
    de_secuencial      INT NOT NULL,
    de_concepto        VARCHAR (10) NOT NULL,
    de_moneda          TINYINT NOT NULL,
    de_valor_base      MONEY NULL,
    de_cuenta          VARCHAR (20) NOT NULL,
    de_debcred         VARCHAR (1) NOT NULL,
    de_area            SMALLINT NOT NULL,
    de_oficina         SMALLINT NULL,
    de_cuenta_final    VARCHAR (20) NOT NULL,
    de_debito          MONEY NULL,
    de_debito_me       MONEY NULL,
    de_credito         MONEY NULL,
    de_credito_me      MONEY NULL,
    de_cliente         INT NULL,
    de_con_rete        VARCHAR (10) NULL,
    de_valret          MONEY NOT NULL,
    de_con_ivareten    VARCHAR (10) NULL,
    de_iva_retenido    MONEY NOT NULL,
    de_con_ica         VARCHAR (10) NULL,
    de_valor_ica       MONEY NOT NULL,
    de_con_dptales     VARCHAR (10) NULL,
    de_valor_dptales   MONEY NOT NULL,
    de_con_iva         VARCHAR (10) NULL,
    de_valor_iva       MONEY NOT NULL,
    de_con_timbre      VARCHAR (10) NULL,
    de_valor_timbre    MONEY NOT NULL,
    de_con_ivapagado   VARCHAR (10) NULL,
    de_valor_ivapagado MONEY NOT NULL,
    de_tclave          VARCHAR (20) NOT NULL,
    de_clave           VARCHAR (20) NOT NULL,
    de_asiento         INT IDENTITY NOT NULL
    )
GO

CREATE TABLE ca_emb_temp
    (
    dt_data VARCHAR (1000) NULL
    )
GO


CREATE TABLE cl_conjunta
    (
    ac_ente INT NULL
    )
GO

CREATE TABLE cp_campoah
    (
    cc_transaccion INT NOT NULL,
    cc_campo       VARCHAR (255) NOT NULL
    )
GO

CREATE TABLE cp_campoah_monetario
    (
    ah_transaccion_m INT NOT NULL,
    ah_campo_m       VARCHAR (255) NOT NULL
    )
GO

CREATE TABLE cuentas_gmf
    (
    Oficina            VARCHAR (64) NOT NULL,
    Producto           VARCHAR (64) NOT NULL,
    [Nro Cuenta]       VARCHAR (16) NOT NULL,
    Estado             VARCHAR (64) NOT NULL,
    Apertura           VARCHAR (10) NOT NULL,
    Oficial            VARCHAR (64) NOT NULL,
    Cedula             VARCHAR (30) NOT NULL,
    Nombre             VARCHAR (60) NOT NULL,
    Categoria          VARCHAR (64) NOT NULL,
    Condiciones        VARCHAR (10) NOT NULL,
    [Sal. Disponible]  VARCHAR (20) NOT NULL,
    [Descripcion EC]   VARCHAR (60) NOT NULL,
    [Cta Personalizada] VARCHAR (5) NOT NULL,
    [Nro. Transacciones] VARCHAR (5) NOT NULL,
    Telefono           VARCHAR (47) NOT NULL,
    [Cobrado GMF]      VARCHAR (20) NOT NULL,
    [Exonerado GMF]    CHAR (1) NOT NULL,
    Titularidad        VARCHAR (64) NOT NULL,
    [Tipo Sociedad]    VARCHAR (64) NOT NULL,
    [Direccion DVC]    VARCHAR (64) NOT NULL,
    [Ciudad DVC]       VARCHAR (64) NOT NULL,
    [Permite saldo 0]  VARCHAR (5) NOT NULL,
    [Zona Oficina]     VARCHAR (64) NOT NULL,
    [Cta. Trasl. DNT]  VARCHAR (1) NOT NULL,
    [Cod. Tutor]       VARCHAR (10) NOT NULL,
    [Ced. Tutor]       VARCHAR (30) NOT NULL,
    [Nom. Tutor]       VARCHAR (254) NOT NULL,
    Genero             VARCHAR (64) NULL
    )
GO

CREATE TABLE datos_inac
    (
    zona        SMALLINT NOT NULL,
    nom_zona    descripcion NULL,
    oficina     SMALLINT NOT NULL,
    nom_ofi     descripcion NULL,
    producto    SMALLINT NOT NULL,
    ctabanco    cuenta NOT NULL,
    cuenta      INT NOT NULL,
    estado      CHAR (1) NOT NULL,
    fechaaper   DATETIME NOT NULL,
    titularidad CHAR (1) NULL,
    cliente     INT NOT NULL,
    cedula      VARCHAR (16) NOT NULL,
    disponible  MONEY NOT NULL,
    fechaultmov DATETIME NOT NULL,
    tipodir     CHAR (1) NOT NULL,
    operacion   VARCHAR (24) NULL,
    estadocca   TINYINT NULL,
    desc_est    descripcion NULL,
    diasmora    INT NULL,
    notacred    TINYINT NULL,
    castigado   CHAR (1) NULL,
    exclusivo   CHAR (1) NULL,
    valorven    MONEY NULL,
    deudatotal  MONEY NULL,
    exento      CHAR (1) NULL
    )
GO

CREATE TABLE extracto_ahorros_tmp
    (
    ext_cliente       INT NULL,
    ext_cedula        VARCHAR (30) NULL,
    ext_cuenta_ah_H   VARCHAR (20) NULL,
    ext_nombre_H      VARCHAR (255) NULL,
    ext_direccion_H   VARCHAR (255) NULL,
    ext_fec_cierre_H  VARCHAR (10) NULL,
    ext_tel_oficial_H VARCHAR (180) NULL,
    ext_fec_mes_ant_H VARCHAR (10) NULL,
    ext_fec_impr_H    VARCHAR (10) NULL,
    ext_oficina_H     VARCHAR (25) NULL,
    ext_fecha_D       VARCHAR (10) NULL,
    ext_lugar_D       VARCHAR (64) NULL,
    ext_saldo_cont_D  VARCHAR (20) NULL,
    ext_debito_D      VARCHAR (20) NULL,
    ext_credito_D     VARCHAR (20) NULL,
    ext_descripcion_D VARCHAR (200) NULL,
    ext_numdep_F      VARCHAR (20) NULL,
    ext_depositos_F   VARCHAR (20) NULL,
    ext_nc_F          VARCHAR (20) NULL,
    ext_saldo_prom_F  VARCHAR (20) NULL,
    ext_nd_F          VARCHAR (20) NULL,
    ext_saldo_cont_F  VARCHAR (20) NULL,
    ext_mail          VARCHAR (254) NULL,
    ext_archivo       VARCHAR (254) NULL
    )
GO

CREATE TABLE ORS485_ctas_react
    (
    OFICINA_REACTIVACION SMALLINT NULL,
    CUENTA               CHAR (16) NOT NULL,
    NOMBRE_CUENTA        VARCHAR (40) NULL,
    FECHA_Y_HORA         SMALLDATETIME NULL,
    MONTO_INICIO_DIA     MONEY NULL,
    TRANSACCION          VARCHAR (50) NULL,
    AFECTACION           VARCHAR (7) NULL,
    VALOR_TRANSACCION    MONEY NULL,
    MONTO_FIN_DIA        MONEY NOT NULL,
    OFICINA_MOVIMIENTO   SMALLINT NULL,
    USUARIO_REACTIVA     descripcion NULL,
    ESTADO_CUENTA        VARCHAR (64) NULL
    )
GO

CREATE TABLE re_error_batch
    (
    eb_cuenta  cuenta NOT NULL,
    eb_mensaje descripcion NOT NULL
    )
GO

CREATE TABLE re_error_batch1
    (
    eb_cuenta  cuenta NOT NULL,
    eb_mensaje descripcion NOT NULL
    )
GO

CREATE TABLE re_error_batch2
    (
    eb_cuenta  cuenta NOT NULL,
    eb_mensaje descripcion NOT NULL
    )
GO

CREATE TABLE re_error_batch3
    (
    eb_cuenta  cuenta NOT NULL,
    eb_mensaje descripcion NOT NULL
    )
GO

CREATE TABLE re_error_batch4
    (
    eb_cuenta  cuenta NOT NULL,
    eb_mensaje descripcion NOT NULL
    )
GO

CREATE TABLE saldo_compensa
    (
    sc_cuenta      INT NULL,
    sc_saldo       MONEY NULL,
    sc_titularidad CHAR (1) NULL,
    sc_cliente     INT NULL,
    sc_oficina     SMALLINT NULL,
    sc_moneda      TINYINT NULL,
    sc_producto    TINYINT NULL,
    sc_prod_banc   SMALLINT NULL,
    sc_cta_banco   VARCHAR (20) NULL
    )
GO

CREATE TABLE tiempo
    (
    Batch       SMALLINT NULL,
    Consecutivo INT NULL,
    Texto       NVARCHAR (150) NULL,
    FechaHora   DATETIME NULL
    )
GO

CREATE TABLE tmp_compensacion
    (
    reg VARCHAR (5000) NULL
    )
GO

CREATE TABLE tmp_consulta_mov_cb
    (
    id            INT NOT NULL,
    cuenta        VARCHAR (16) NOT NULL,
    fecha         VARCHAR (10) NULL,
    descripcion   VARCHAR (132) NULL,
    debito        MONEY NULL,
    credito       MONEY NULL,
    punto_atn     VARCHAR (64) NULL,
    referencia    VARCHAR (36) NULL,
    hora          DATETIME NULL,
    estado        VARCHAR (12) NULL,
    cod_alterno   INT NULL,
    secuencial    INT NULL,
    usuario       VARCHAR (12) NULL,
    user_consulta VARCHAR (12) NULL
    )
GO

CREATE TABLE tmp_datos_aho_407
    (
    fecha          DATETIME NULL,
    oficina        SMALLINT NULL,
    nro_cuentas    INT NULL,
    tipo_cta       VARCHAR (30) NULL,
    estado         VARCHAR (20) NULL,
    saldo_contable MONEY NULL,
    egresos        MONEY NULL,
    ingresos       MONEY NULL
    )
GO

CREATE TABLE tmp_detalle_dtn
    (
    registro VARCHAR (500) NULL
    )
GO

CREATE TABLE tmp_movimiento_svb
    (
    registro VARCHAR (278) NULL
    )
GO

CREATE TABLE tmp_plano_aho
    (
    orden  INT NOT NULL,
    cadena VARCHAR (2000) NOT NULL
    )
GO

CREATE TABLE tmp_transacciones
    (
    Mes           NVARCHAR (30) NULL,
    Producto      VARCHAR (1) NOT NULL,
    Trans         SMALLINT NOT NULL,
    Des_tran      VARCHAR (64) NOT NULL,
    Cod_forma_pag VARCHAR (10) NOT NULL,
    Des_forma_pag VARCHAR (64) NULL,
    Num_registro  INT NULL,
    Valor         MONEY NULL,
    Estado        VARCHAR (1) NOT NULL
    )
GO

CREATE TABLE ah_cuenta_aux(
    ca_cuenta        INT NOT NULL,
    ca_cta_banco     CHAR (16) NOT NULL,
    ca_cta_banco_rel CHAR (16),
    ca_saldo_max     MONEY,
    ca_dias_plazo    INT,
    ca_cta_banco_mig CHAR(16),
    ca_fecha_mig     DATETIME
)
go



CREATE TABLE ah_report_ctas
	(
	w_ah_fecha            CHAR(10),
	w_ah_cuenta           CHAR(12),
	w_ah_cta_banco        CHAR(20),
	w_ah_oficina          CHAR(7),
	w_nomb_oficina        CHAR(40),
	w_ah_moneda           CHAR(6),
	w_descp_moneda        CHAR(35),
	w_ah_prod_banc        CHAR(13),
	w_descp_prod          CHAR(50),
	w_ah_origen           CHAR(6),
	w_desc_origen         CHAR(50),
	w_ah_categoria        CHAR(9),
	w_desc_categoria      CHAR(50),
	w_ah_titularidad      CHAR(11),
	w_desc_titularidad    CHAR(50),
	w_ah_oficial          CHAR(7),
	w_nomb_oficial        CHAR(64),
	w_ah_cliente          CHAR(10),
	w_ah_nombre           CHAR(80),
	w_ah_ced_ruc          CHAR(20),
	w_ah_descripcion_dv   CHAR(64),
	w_ah_fecha_ult_mov    CHAR(16),
	w_ah_fecha_prx_capita CHAR(17),
	w_ah_numsol           CHAR(13),
	w_ah_plazo            CHAR(10),
    w_perfil              CHAR(10),
	w_ca_cta_banco_mig    CHAR(18),
	w_ah_disponible       CHAR(18),
	w_ah_12h              CHAR(18),
	w_ah_24h              CHAR(18),
	w_saldo_contable      CHAR(18),
	w_ah_saldo_interes    CHAR(18),
	w_ah_tasa_hoy         CHAR(6),
	w_ah_creditos_hoy     CHAR(18),
	w_ah_debitos_hoy      CHAR(18),
	w_ah_num_deb_mes      CHAR(11),
	w_ah_num_cred_mes     CHAR(12),
	w_ah_prom_disponible  CHAR(18),
	w_ah_promedio1        CHAR(18),
	w_ah_promedio2        CHAR(18),
	w_ah_promedio3        CHAR(18),
	w_ah_promedio4        CHAR(18),
	w_ah_promedio5        CHAR(18),
	w_ah_promedio6        CHAR(18),
	w_ah_monto_bloq       CHAR(18),
	w_monto_bloq1         CHAR(18),
	w_fecha_bloq1         CHAR(18),
	w_monto_bloq2         CHAR(18),
	w_fecha_bloq2         CHAR(18),
	w_monto_bloq3         CHAR(19),
	w_fecha_bloq3         CHAR(19),
	w_existe_bloq1        CHAR(12),
	w_fecha_bloqm1        CHAR(22),
	w_existe_bloq2        CHAR(11),
	w_fecha_bloqm2        CHAR(22),
	w_existe_bloq3        CHAR(13),
	w_fecha_bloqm3        CHAR(23),
	w_ah_estado           CHAR(6),
	w_descip_estado       CHAR(50),
	w_ah_fecha_aper       CHAR(14),
	w_ah_fecha_inacti     CHAR(18),
	w_ah_fecha_cierre     CHAR(12),
    w_ah_fecha_reacti     CHAR(18)
	)
go



CREATE TABLE ah_transacciones_cm_tmp(
    tc_secuencial  int         not null,
    tc_transaccion varchar(10) not null,
    tc_cta_cobis   cuenta      null,
    tc_cta_mig     varchar(64) null,
    tc_monto_efe   money       null,
    tc_monto_chq   money       null,
    tc_fecha_carga datetime    null,
    tc_causa       int         null,
	tc_remesas     char(1)     null
)
GO

CREATE TABLE ah_det_cheq_cm_tmp(
    dc_sec_dep     int         not null,
    dc_sec_chq     int         not null,
    dc_cod_ban     int         not null,
    dc_cuenta_chq  varchar(64) not null,
    dc_num_chq     int         not null,
    dc_monto       money       not null,
	dc_fecha_emi   datetime    not null,
    dc_fecha_carga datetime    not null
)
GO

CREATE TABLE ah_transacciones_cm(
    tr_nom_archivo   varchar(50) not null,
	tr_secuencial    int         not null,
    tr_transaccion   varchar(10) not null,
    tr_cta_cobis     cuenta,
    tr_cta_mig       varchar(64),
    tr_monto_efe     money,
    tr_monto_chq     money,
    tr_fecha_carga   datetime,
    tr_causa         int,
	tr_estado        char(1),
	tr_num_ejecucion int         not null,
	tr_remesas       char(1),
	tr_total         money,
	tr_ssn_branch    int,
	tr_ofi           smallint,
	tr_moneda        smallint,
	tr_user          varchar(30),
	tr_term          varchar(10),
	tr_corr          char(1),
	tr_ssn_corr      int,
    tr_srv           varchar(30),
    tr_date          datetime,
    tr_rol           smallint,
    tr_org           char(1),
	tr_servicio      char(1)
)
GO

CREATE TABLE ah_det_cheq_cm(
    dc_nom_archivo    varchar(50)  not null,
	dc_secuencial     int identity,
    dc_sec_dep        int          not null,
    dc_sec_chq        int          not null,
	dc_sec_chq_aux    int          not null,
    dc_cod_ban        int          not null,
    dc_cuenta_chq     varchar(64)  not null,
    dc_num_chq        int          not null,
    dc_monto          money        not null,
	dc_fecha_emi      datetime     not null,
    dc_fecha_carga    datetime     not null,
	dc_estado         char(1),
	dc_num_ejecucion  int          not null,
	dc_ssn_branch_dep int,
	dc_ssn            int,
    dc_ssn_branch     int,
    dc_ofi            smallint,
    dc_user           varchar(30),
    dc_term           varchar(10),
    dc_corr           char(1),
    dc_ssn_corr       int,
    dc_srv            varchar(30),
    dc_date           datetime,
    dc_rol            smallint,
    dc_org            char(1),
	dc_servicio       char(1)
)
GO

CREATE TABLE ah_log_cm_tran(
    lc_nom_archivo   varchar(100) not null,   
	lc_ejecucion     int not null,
    lc_sec_tran      int not null,
	lc_sec_chq       int null,
	lc_ssn           int null,
    lc_num_error     int not null,
    lc_mensaje_error varchar(100) not null,
	lc_fecha         datetime
)
GO

CREATE TABLE ah_ahorro_individual
	(
	ai_cta_grupal       cuenta,
	ai_operacion        INT,
	ai_cliente          INT,
	ai_saldo_individual MONEY,
	ai_incentivo        MONEY,
	ai_ganancia         MONEY
	)
GO



use cob_ahorros_his
go

/* ah_his_retiro_ofic */
print '=====> ah_his_retiro_ofic'
go
if exists (select * from sysobjects where name = 'ah_his_retiro_ofic') 
 drop table ah_his_retiro_ofic
go

CREATE TABLE ah_his_retiro_ofic
    (
    ar_secuencial INT NOT NULL,
    ar_cta_banco  cuenta NOT NULL,
    ar_nombre     VARCHAR (64) NOT NULL,
    ar_forma_pago CHAR (1) NOT NULL,
    ar_valor      MONEY NOT NULL,
    ar_retiro_add SMALLINT NOT NULL,
    ar_login      VARCHAR (30) NOT NULL,
    ar_fecha      DATETIME NOT NULL,
    ar_hora       DATETIME NOT NULL,
    ar_estado     CHAR (1) NOT NULL
    )
GO

