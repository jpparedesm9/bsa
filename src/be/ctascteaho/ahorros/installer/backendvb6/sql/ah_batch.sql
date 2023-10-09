/************************************************************************/
/*      Archivo:            ah_batch.sql                                */
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
/*      Este programa realiza la creacion de los batch y sartas         */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migraci�n a CEN                 */
/************************************************************************/
use cobis
go

set nocount on
go

--BATCH
delete from cobis..ba_batch where ba_batch in ('2117','3085','4000','4001','4003','4004','4011','4019','4020','4024',
                                               '4025','4029','4034','4053','4057','4058','4060','4065','4130','4133',
                                               '4150','4161','4196','4217','4219','4220','4221','4222','4223','4224',
                                               '4225','4227','4228','4229','4230','4231','4232','4237','4240','4242',
                                               '4243','4244','4245','4246','4247','4250','4251','4255','4256','4257',
                                               '4261','4264','4265','4266','4272','4273','4274','4275','6064','6084',
                                               '6100','6525','6869','7010','7055','7065','7066','7070','7073','7958',
                                               '7959','14003','14005','14006','14008','14009','14048','14090','14091',
                                               '14092','14093','14094','14999','26001','26002','26003','26004','26005',
                                               '28534','28535','28536','28538'
                                               )
GO                                               
declare @w_path_fuente varchar(64),
@w_path_destino varchar(64),
@w_servidor  varchar(15)

select @w_path_fuente  = '',
       @w_path_destino = '',
       @w_servidor       = ''
                                               
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2117, 'REPORTE ERRORES DE CARGA MASIVA', 'REPORTE ERRORES DE CARGA MASIVA', 'SP', getdate(), 2, 'R', 1, 'ALIANZAS', 'Procesados_error_FechaProceso_HoraProceso.txt', 'cobis..sp_err_masivos', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (3085, 'CONFIRMACION AUTOMATICO DE REMESAS', 'CONFIRMACION AUTOMATICO DE REMESAS', 'SP', getdate(), 3, 'P', 1, 'RE_CHEQUE_REC', '', 'cob_remesas..sp_rem_confcaraut', 100, '', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4000, 'VALIDACION ARCHIVO DE TRANSFERENCIAS MASIVAS', 'VALIDACION ARCHIVO DE TRANSFERENCIAS MASIVAS', 'SP', getdate(), 4, 'R', 1, 'ALIANZAS', 'AH_ERR_ALIANZAS_YYYYMMDD.txt', 'cob_remesas..sp_valida_dato_archivo', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4001, 'TRANSFERENCIAS MASIVAS', 'TRANSFERENCIAS MASIVAS', 'SP', getdate(), 4, 'R', 1, 'ALIANZAS', 'AH_TRANF_MASIVA_YYYYMMDD.txt', 'cob_remesas..sp_transfe_ctaalianza', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4003, 'TRANSLADO DE CUENTAS ENTRE OFICINAS', 'TRANSLADO DE CUENTAS ENTRE OFICINAS', 'SP', getdate(), 4, 'P', 1, 'CUENTAS', NULL, 'cob_ahorros..sp_traslado_oficina', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4004, 'REPORTE DE CUENTRAS TRASLADADAS ENTRE OFICINAS', 'REPORTE DE CUENTRAS TRASLADADAS ENTRE OFICINAS', 'SP', getdate(), 4, 'R', 1, 'CUENTAS', 'REPORTE_TRAS_AHO_yyyymmdd.txt', 'cob_ahorros..sp_reporte_traslado_ctas', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4011, 'COBRO DE VALORES EN SUSPENSO DE CUENTAS DE AHORROS', 'COBRO DE VALORES EN SUSPENSO DE CUENTAS DE AHORROS CCA-550', 'SP', getdate(), 4, 'P', 1, 'AHORROS', NULL, 'cob_ahorros..sp_ah_cobsus_batch', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4019, 'REPORTE  TRNSACCIONES EN CAJA', 'REPORTE  TRNSACCIONES EN CAJA', 'SP', getdate(), 4, 'R', 1, 'TRANSACCIONES', 'TRAN_CAJA_MM_YYY.txt', 'cob_ahorros..sp_rep_tran_caja', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4020, 'REPORTE DE MOVIMIENTO DE TARJETA DEBITO', 'REPORTE DE MOVIMIENTO DE TARJETA DEBITO
FTO_PARAM_BATCH_ORS_000991_V04.xlsx', 'SP', getdate(), 4, 'R', 1, 'TRANSACCIONES', 'REPORTE_COLOCACION_TD_ddmmyyy.txt', 'cob_remesas..sp_repo_tarjeta_deb', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4024, 'BATCH PARA ACTIVAR Y DESACTIVAR CTA_AHORROS', 'BATCH PARA ACTIVAR Y DESACTIVAR CTA_AHORROS ORS_1237', 'SP', getdate(), 4, 'R', 1, 'CTA_AHORROS', 'Act_DesAct_Cta_AHO.txt', 'cob_ahorros..sp_batch_act_cta', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4025, 'REPORTE DE INTERESES CAUSADOS DE CUENTAS DE AHORROS ENVIADAS A L', 'REPORTE DE INTERESES CAUSADOS DE CUENTAS DE AHORROS ENVIADAS A LA DTN_ORS_1252_V01', 'SP', getdate(), 4, 'R', 1, 'CUENTAS', 'REPORTE_INT_DTN_', 'cob_remesas..sp_rep_int_ctas_dtn', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4029, 'REPORTE DE PRODUCTOS EMBARGADOS', 'REPORTE DE PRODUCTOS EMBARGADOS', 'SP', getdate(), 4, 'R', 1, 'CUENTAS', 'PROD_EMBA_DDMMAAAA.txt', 'cob_ahorros..sp_rep_embargos', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4034, 'REPORTE DE CUENTAS A TRASLADAR A LA DTN', 'REPORTE DE CUENTAS A TRASLADAR A LA DTN', 'SP', getdate(), 4, 'P', 1, 'CUENTAS', NULL, 'cob_ahorros..sp_reporte_ctas_dtn', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4053, 'CREACION TABLAS TEMPORALES DE PERSONALIZACION', 'CREACION TABLAS TEMPORALES DE PERSONALIZACION', 'SP', getdate(), 4, 'R', 1, 'TABLAS TEMPORALES', 'person.lis', 'cob_ahorros..sp_crea_tem_person', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4057, 'CARGA ARCHIVO DATOS CUENTAS ABONOS', 'CARGA ARCHIVO DATOS CUENTAS ABONOS DEBITOS CC_320 12/20/2012', 'SP', getdate(), 4, 'R', 1, 'AHORROS', 'PLANO_CARGA_CTAS_yyyymmdd.txt', 'cob_ahorros..sp_carga_archivo_cuentas', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4058, 'VALIDACION Y APLICACIaN NOTAS DEBITO/CREDITO', 'VALIDACION Y APLICACIaN NOTAS DEBITO/CREDITO CC_320  12/20/2012', 'SP', getdate(), 4, 'P', 1, 'AHORROS', NULL, 'cob_ahorros..sp_abono_archivo_cuentas', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4060, 'DESMARCACION MASIVA GMF CUENTAS DE AHORROS', 'DESMARCACION MASIVA GMF CUENTAS DE AHORROS FORMATO_BATCH_REC362_V02.xlsx', 'SP', getdate(), 4, 'R', 1, 'CUENTAS', 'desmarca_gmf.txt', 'cob_ahorros..sp_desmarca_gmf', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4065, 'Batch Anular Ordenes pag', 'Batch Anular Ordenes pag ORS_652       10/08/2013', 'SP', getdate(), 4, 'R', 1, 'N.Cliente', 'ANULA_ORDEN_PAGO.txt', 'cob_ahorros..sp_anula_orden_pago', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4130, 'CALCULO DE INTERES', 'CALCULO DE INTERES', 'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS', NULL, 'cob_ahorros..sp_ahmensual', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4133, 'INICIALIZACION DE TABLAS TEMPORALES', 'INICIALIZACION DE TABLAS TEMPORALES', 'QR', getdate(), 4, 'P', 1, 'TABLAS DE INICIO DEL PROCESO DIARIO', NULL, 'ahinitbl.sqr', 1000, NULL, @w_servidor, 'N', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4150, 'GENERACION SALDOS DIARIOS', 'GENERACION SALDOS DIARIOS', 'SP', getdate(), 4, 'P', 1, 'CUENTA', NULL, 'cob_ahorros..sp_ah_saldo_diario', 1000, NULL, @w_servidor, 'N', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4161, 'VALIDACION ANTES DEL CALCULO DE INTERESES AH.', 'VALIDACION ANTES DEL CALCULO DE INTERESES AH.', 'QR', getdate(), 4, 'R', 1, NULL, 'ahvaltmp.lis', 'ahvaltmp.sqr', 1000, 'lp', @w_servidor, 'N', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4196, 'ARCHIVO PLANO DE DE CUENTAS DE AHORROS', 'ARCHIVO PLANO DE DE CUENTAS DE AHORROS', 'SP', getdate(), 4, 'R', 1, 'CUENTAS', 'ofica', 'cob_ahorros..sp_archivo_plano_ah', 10, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4217, 'GENERACION DE DATA SALDOS PARA REC - COB_EXTERNOS', 'GENERACION DE DATA SALDOS PARA REC - COB_EXTERNOS', 'SP', getdate(), 4, 'P', 1, 'CUENTAS MOVIMIENTOS Y BLOQUEOS', ' ', 'cob_ahorros..sp_datos_pasivas_rec', 10, ' ', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4219, 'GENERACION DE DATA MOVIMIENTOS PARA REC - COB_EXTERNOS', 'GENERACION DE DATA MOVIMIENTOS PARA REC - COB_EXTERNOS', 'SP', getdate(), 4, 'P', 1, 'MOVIMIENTOS', ' ', 'cob_ahorros..sp_datos_mov_rec', 10, ' ', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4220, 'GENERACION DE DATA BLOQUEOS PARA REC - COB_EXTERNOS', 'GENERACION DE DATA BLOQUEOS PARA REC - COB_EXTERNOS', 'SP', getdate(), 4, 'P', 1, 'BLOQUEOS', ' ', 'cob_ahorros..sp_datos_bloq_rec', 10, ' ', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4221, 'GENERACION DE DATA TITULARES PARA REC - COB_EXTERNOS', 'GENERACION DE DATA TITULARES PARA REC - COB_EXTERNOS', 'SP', getdate(), 4, 'P', 1, 'CLIENTES', ' ', 'cob_ahorros..sp_datos_deudores_rec', 10, ' ', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4222, 'TOTALIZADOR TRANSACCIONES MONETARIAS AHORROS', 'TOTALIZADOR TRANSACCIONES MONETARIAS AHORROS', 'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES MONETARIAS', ' ', 'cob_ahorros..sp_totaliza_tran_mon_ah', 10, ' ', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4223, 'TOTALIZADOR TRANSACCIONES DE SERVICIO AHORROS', 'TOTALIZADOR TRANSACCIONES DE SERVICIO AHORROS', 'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES DE SERVICIO', ' ', 'cob_ahorros..sp_totaliza_tran_serv_ah', 10, ' ', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4224, 'GENERADOR DE COMPROBANTES AHORROS', 'GENERADOR DE COMPROBANTES AHORROS', 'SP', getdate(), 4, 'P', 1, 'COMPROBANTES', NULL, 'cob_ahorros..sp_conta', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4225, 'VALIDA COMPROBANTES AHORROS', 'VALIDA COMPROBANTES AHORROS', 'SP', getdate(), 4, 'P', 1, 'COMPROBANTES', ' ', 'cob_ahorros..sp_ah_generacion_contabilidad', 10, ' ', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4227, 'REPORTE DE TRN MONETARIAS SIN PERFILES ASOCIADOS AHO', 'REPORTE DE TRN MONETARIAS SIN PERFILES ASOCIADOS AHO', 'QR', getdate(), 4, 'R', 1, 'RECHAZOS', 'ahperfmo.lis', 'ahperfmo.sqr', 10, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4228, 'REPORTE DE TRN SERVICIO SIN PERFILES ASOCIADOS AHO', 'REPORTE DE TRN SERVICIO SIN PERFILES ASOCIADOS AHO', 'QR', getdate(), 4, 'R', 1, 'RECHAZOS', 'ahperfse.lis', 'ahperfse.sqr', 10, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4229, 'REPORTE DE TRANSACCIONES SIN PERFILES ASOCIADOS AHO', 'REPORTE DE TRANSACCIONES SIN PERFILES ASOCIADOS AHO', 'QR', getdate(), 4, 'R', 1, 'RECHAZOS', 'ahperfil.lis', 'ahperfil.sqr', 10, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4230, 'EJECUCION DE TRANSFERENCIAS AUTOMATICAS', 'EJECUCION DE TRANSFERENCIAS AUTOMATICAS', 'SP', getdate(), 4, 'P', 1, 'TRASFERENCIAS', NULL, 'cob_remesas..sp_ejecuta_transfer_aut', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4231, 'COBRO DE COMISION POR TRANSFERENCIAS AUTOMATICAS', 'COBRO DE COMISION POR TRANSFERENCIAS AUTOMATICAS', 'SP', getdate(), 4, 'P', 1, 'TRANSFERENCIAS', NULL, 'cob_remesas..sp_comision_transfer', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4232, 'BALANCE OPERATIVO CONTABLE (BOC)', 'BALANCE OPERATIVO CONTABLE', 'SP', getdate(), 4, 'P', 1, 'SALDOS', ' ', 'cob_ahorros..sp_boc', 10, ' ', @w_servidor, 'S', @w_path_fuente, '')

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4237, 'EFECTIVIZACION CANJE CUENTAS DE AHORRO', 'EFECTIVIZACION CANJE CUENTAS DE AHORRO', 'SP', getdate(), 4, 'P', 1, 'CUENTA', NULL, 'cob_ahorros..sp_update_efectiah_batch', 100, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4240, 'REPORTE ERRORES BATCH', 'REPORTE ERRORES BATCH', 'QR', getdate(), 4, 'R', 1, 'AH_ERRORLOG', 'aherrbatch.lis', 'aherrbatch.sqr', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4242, 'ENVIO DE CUENTAS A LA DTN', 'ENVIO DE CUENTAS A LA DTN', 'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORRO', NULL, 'cob_ahorros..sp_envia_cta_dtn_ah', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4243, 'REINTEGRO DE CUENTAS DE LA DTN', 'REINTEGRO DE CUENTAS DE LA DTN', 'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS', NULL, 'cob_ahorros..sp_reintegra_cta_dtn_ah', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4244, 'CREA ARCHIVO ENVIO DTN', 'CREA ARCHIVO ENVIO DTN', 'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORRO', NULL, 'cob_ahorros..sp_archivo_envia_dtn_ah', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4245, 'CREA ARCHIVO REINTEGRO DTN', 'CREA ARCHIVO REINTEGRO DTN', 'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORRO', NULL, 'cob_ahorros..sp_archivo_reint_dtn_ah', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4246, 'REPORTE CUENTAS ENVIADAS DTN', 'REPORTE CUENTAS ENVIADAS DTN', 'QR', getdate(), 4, 'R', 1, 'CUENTAS DE AHORROS', 'ahenvioctadtn.lia', 'ahenvioctadtn.sqr', 10, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4247, 'REPORTE CUENTAS REINTEGRADAS DTN', 'REPORTE CUENTAS REINTEGRADAS DTN', 'QR', getdate(), 4, 'R', 1, 'CUENTAS DE AHORRO', 'ahreintegroctadtn.lis', 'ahreintegroctadtn.sqr', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4250, 'REPORTE DE TRANSACCIONES MONETARIAS - FORMATO 444', 'REPORTE DE TRANSACCIONES MONETARIAS - FORMATO 444.REQ_186_V1.07/16/2011.JCCC', 'SP', getdate(), 4, 'R', 1, 'TRANSACCIONES', 'transacciones.lis', 'cob_ahorros..sp_estadisticas_for444', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4251, 'RECLASIFICACIÒN DIFERENCIAS BOC', 'RECLASIFICACIÒN DIFERENCIAS BOCINC_116233', 'SP', getdate(), 4, 'P', 1, NULL, NULL, 'cob_ahorros..sp_ajuste_oper_conta_aho', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4255, 'REPORTE SEGUIMIENTO CUENTAS CON CUMPLIMIENTO', 'REPORTE SEGUIMIENTO CUENTAS CON CUMPLIMIENTO CC_286', 'SP', getdate(), 4, 'R', 1, 'CUENTAS', 'cumplimientos_aammdd', 'cob_ahorros..sp_reporte_seguimiento', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4256, 'CUMPLIMIENTO CUENTAS ESPECIALES', 'CUMPLIMIENTO CUENTAS ESPECIALES  CC_286', 'SP', getdate(), 4, 'R', 1, 'CUENTAS', 'reportes.lis', 'cob_ahorros..sp_mto_ahorro_plan', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
GO

declare @w_path_fuente varchar(64),
@w_path_destino varchar(64),
@w_servidor  varchar(15)

select @w_path_fuente  = '',
       @w_path_destino = '',
       @w_servidor       = ''

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4257, 'ANULACION DE CUENTAS DE AHORRO SIN DEPOSITO INICIAL', 'ANULACION DE CUENTAS DE AHORRO SIN DEPOSITO INICIAL', 'SP', getdate(), 4, 'P', 1, 'CUENTA AHORROS', NULL, 'cob_ahorros..sp_valida_tiempo_activa', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4261, 'PROCESO PARA AUTORIZAR PRODUCTO POR OFICIN', 'PROCESO PARA AUTORIZAR PRODUCTO POR OFICIN', 'SP', getdate(), 4, 'P', 1, 'cob_remesas..pe_oficina_autorizada', NULL, 'cob_ahorros..sp_aut_prod_ofi', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4264, 'PROCESOS EVENTUALES DE AHORRO', 'PROCESOS EVENTUALES DE AHORRO FTO_PARAM_BATCH_ORS468.xlsx', 'SP', getdate(), 4, 'R', 1, 'CTAS INAC', 'CTASINAC_ddmmyyyy.txt', 'cob_ahorros..sp_plano_ctas_inac_ah', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4265, 'PROCESO PARA GENERAR EL UNIVERSO DE CTAS A CANCELAR', 'PROCESO PARA GENERAR EL UNIVERSO DE CTAS A CANCELAR', 'SP', getdate(), 4, 'R', 1, 'CTAS INAC', 'ctas_can_ddmmaaaa.lis', 'cob_ahorros..sp_precancela_ctas', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4266, 'PROCESO MASIVO DE SALDAR CUENTAS', 'PROCESO MASIVO DE SALDAR CUENTAS', 'SP', getdate(), 4, 'P', 1, 'CTAS INAC', NULL, 'cob_ahorros..sp_cierre_masivo_ctaah', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4272, 'REPORTE OPERATIVO TRANSACCIONES DE CB RED POSICIONADA', 'El reporte OPERATIVO identifica y presenta los Pagos realizados por el CB  Dispersión de Fondos) y aplicaciones  de los pagos recibidos a la cuenta de corresponsalía (Detalle de cobro valores en suspenso).
CCA_550', 'SP', getdate(), 4, 'R', 1, 'AHORROS', 'reporte_operativo_cb_mm/dd/aaaa.txt', 'cob_ahorros_his..sp_reporte_operativo_cb', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4273, 'REPORTE CONTABLE TRANSACCIONES DE CB RED POSICIONADA', 'El Reporte CONTABLE presentará la información de registros contables aplicados por el proceso de Dispersión de CB.
CCA_550', 'SP', getdate(), 4, 'R', 1, 'CONTA', 'reporte_contable_cb_mm/dd/aaaa.txt', 'cob_conta_tercero..sp_reporte_contable_cb', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4274, 'HABILITA CANAL CB RED POSICIONADA', 'HABILITA CANAL CB RED POSICIONADA CCA_550', 'SP', getdate(), 4, 'P', 1, 'OPERACIONES', NULL, 'cob_ahorros..sp_hab_cbr', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4275, 'DESHABILITA CANAL CB RED POSICIONADA', 'DESHABILITA CANAL CB RED POSICIONADA CCA_550', 'SP', getdate(), 4, 'P', 1, 'OPERACIONES', NULL, 'cob_ahorros..sp_hab_cbr', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (6064, 'ACTUALIZACION ESTADISTICA VALIDACION CONTABLE', 'PROCESO DE ACTUALIZACION ESTADISTICA VALIDACION CONTABLE', 'QR', getdate(), 6, 'P', 1, NULL, NULL, 'cb_valest.sqr', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (6084, 'PASO A DEFINITIVOS (RESUMIDO POR PERFIL) - TOTAL', 'PASO A DEFINITIVOS (RESUMIDO POR PERFIL) - TOTAL', 'QR', getdate(), 6, 'R', 1, 'CUENTAS', 'cb_consu.lis', 'cb_consu.sqr', 100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (6100, 'MAYORIZACION BATCH', 'MAYORIZACION BATCH', 'SP', getdate(), 6, 'P', 1, 'MOVIMIENTOS', NULL, 'cob_conta..sp_ejec_maysi', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (6525, 'VALIDACION DE COMPROBANTES POR PRODUCTO', 'VALIDACION DE COMPROBANTES POR PRODUCTO', 'SP', getdate(), 6, 'P', 1, 'COMPROBANTES', NULL, 'cob_conta..sp_ejec_asientos_val', 100, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (6869, 'REPORTE DE DIFERENCIAS DEL BOC', 'REPORTE DE DIFERENCIAS DEL BOC FTO_PARAM_BATCH_ORS_000945_V02.xlsx', 'SP', getdate(), 6, 'R', 1, 'CUENTAS', 'cb_reporte_diferencias', 'cob_conta..sp_repo_diferencias_boc', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7010, 'GENERACION MASIVA DE DATOS TABLA CA_VALOR_ATX', 'GENERACION MASIVA DATOS TABLA CA_VALOR_ATX', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_valor_atx_mas', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7055, 'REVERSA DE DESEMBOLSOS NO ENTREGADOS', 'REVERSA DE DESEMBOLSOS NO ENTREGADOS', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_revdesnoapag', 1, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7065, 'CONTABILIZADAS CON ERROR, CAMBIO DE ESTADO A ING', 'CONTABILIZADAS CON ERROR, CAMBIO DE ESTADO A ING', 'QR', getdate(), 7, 'P', 1, 'CA_TRANSACCION', NULL, 'ca_trn_ing_ca.sqr', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7066, 'CONTABILIZADAS CON ERROR, CAMBIO ESTADO A ING, PROVISIONES', 'CONTABILIZADAS CON ERROR, CAMBIO ESTADO A ING, PROVISIONES', 'SP', getdate(), 7, 'P', 1, 'CA_TRANSACCION_PRV', NULL, 'cob_cartera..sp_trn_ing_prv', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7070, 'APLICAR PAGOS POR RECAUDOS', 'APLICAR PAGOS POR RECAUDOS', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_pagos_masivos', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7073, 'CREACION OPERACION ALTERN_FNG', 'CREACION OPERACION ALTERN_FNG', 'QR', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cacreope.sqr', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7958, 'PAGOS MASIVOS CUENTAS INACTIVAS', 'PAGOS MASIVOS CUENTAS INACTIVAS CC_341 09/27/2012', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_paginac_mas', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7959, 'ACTUALIZACION PAGOS MASIVOS CUENTAS INACTIVAS', 'ACTUALIZACION PAGOS MASIVOS CUENTAS INACTIVASCC_341 09/27/2012', 'SP', getdate(), 7, 'R', 1, 'CARTERA', 'REPO_RECH_PAGINA_DDMMAAAA_HHMM.txt', 'cob_cartera..sp_act_paginac', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14003, 'GENERACION DE TOTALES PARA GRAFICOS ESTADISTICOS', 'GENERACION DE TABLA DE TOTALES PARA LOS GRAFICOS ESTADISTICOS EN EL FRONT-END DEL MODULO', 'SP', getdate(), 14, 'P', 1, 'PF_ESTADISTICA', NULL, 'cob_pfijo..sp_graba_totales', 50, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14005, 'PROGRAMA DE CONTABILIDAD', 'PROGRAMA DE CONTABILIDAD', 'SP', getdate(), 14, 'R', 1, 'PF_TRANSACCION', 'texto.lis', 'cob_pfijo..sp_conta', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14006, 'DESMARCADOR', 'DESMARCADOR', 'SP', getdate(), 14, 'R', 1, NULL, 'textol.is', 'cob_pfijo..sp_desmarcar_trn', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14008, 'REPORTE DE PROVISION DIARIA DE INTERESES', 'PERMITE VISUALIZAR LAS CANTIDADES QUE SE PROVISIONAN O AMORTIZAN EN EL DIA. IMPRIME LA PROVISION ACUMULADA, NUMERO DE DIAS PROVISIONADOS, INTERES PAGADO O INTERES POR AMORTIZAR.', 'QR', getdate(), 14, 'R', 1, 
'PF_OPERACION,CL_CIUDAD,CL_OFICINA,PF_PLAZO', 'pf_prami.lis', 'pf_prami.sqr', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14009, 'REC', 'REC', 'SP', getdate(), 14, 'R', 1, NULL, 'texto.lis', 'cob_pfijo..sp_consolidador', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14048, 'REPORTE DE ERROR BATCH', 'LISTADO DE LOG DE ERRORES', 'QR', getdate(), 14, 'R', 1, 'PF_ERRORLOG,PF_OPERACION,CL_ERRORES', 'pf_loger.lis', 'pf_loger.sqr', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14090, 'GENERACION ARCHIVO (P) DECEVAL', 'GENERACION ARCHIVO (P) DECEVAL', 'SP', getdate(), 14, 'R', 1, '', 'arch_deceval_p.lis', 'cob_pfijo..sp_arch_deceval_p', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14091, 'CARGA ARCHIVO (Z) DECEVAL', 'CARGA ARCHIVO (Z) DECEVAL', 'SP', getdate(), 14, 'R', 1, NULL, 'arch_deceval_p.lis', 'cob_pfijo..sp_arch_deceval_z', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14092, 'REPORTE OPERACIONES DECEVAL', 'REPORTE OPERACIONES DECEVAL', 'QR', getdate(), 14, 'R', 1, '', 'deceval.lis', 'deceval.sqr', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14093, 'MAESTRO PLAZO FIJO', 'GENERA ARCHIVO PLANO MAESTRO PFIJO', 'SP', getdate(), 14, 'R', 1, 'PF_OPERACION,PF_CUOTAS', 'maestro_pf.lis', 'cob_pfijo..maestro_pf', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14094, 'MAESTRO PROYECCIONES FIJO', 'GENERA ARCHIVO PLANO MAESTRO PROYECCIONES PFIJO', 'SP', getdate(), 14, 'R', 1, 'PF_OPERACION,PF_CUOTAS', 'mestro_pry_pf.lis', 'cob_pfijo..maestro_pry_pf', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14999, 'EJECUCIONES BOC PLAZO FIJO', 'EJECUCIONES BOC PLAZO FIJO', 'SP', getdate(), 14, 'P', 1, 'PLAZO FIJO', NULL, 'cob_pfijo..sp_boc', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (26001, 'CARGA MOVIMIENTO POS', 'CARGA MOVIMIENTO POS', 'SP', getdate(), 4, 'P', 1, 'AHORROS', NULL, 'cob_wservices..sp_carga_mov_pos', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (26002, 'CARGA MOVIMIENTO ATM', 'CARGA MOVIMIENTO ATM', 'SP', getdate(), 4, 'P', 1, 'AHORROS', NULL, 'cob_wservices..sp_carga_mov_atm', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (26003, 'CARGA SERVIBANCA', 'CARGA SERVIBANCA', 'SP', getdate(), 4, 'P', 1, 'AHORROS', NULL, 'cob_wservices..sp_carga_mov_svb', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (26004, 'COMPENSACION REDES', 'COMPENSACION REDES', 'SP', getdate(), 4, 'P', 1, 'AHORROS', NULL, 'cob_wservices..sp_compensa_cob_red', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (26005, 'CONCILIACION REDES', 'CONCILIACION REDES', 'SP', getdate(), 4, 'P', 1, 'AHORROS', NULL, 'cob_wservices..sp_concilia_mov_red', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28534, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER (DT)', 'SP', getdate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_datos_operacion', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28535, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER PY', 'SP', getdate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_datos_operacion', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28536, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER DD', 'SP', getdate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_datos_operacion', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28538, 'DATOS PASIVAS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'DATOS PASIVAS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'SP', getdate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_dato_pasivas', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)
GO
--BATCH

--SARTA
delete from cobis..ba_sarta where sa_sarta in ('7','4004','4005','4100','4102','4103',
                                               '4201','4202','4203','4204','26001')
GO
       
declare @w_usuario varchar(64)       

select @w_usuario = 'sa'

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (7, 'TEMPORAL MAESTRO AHORROS', 'TEMPORAL MAESTRO AHORROS', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4004, 'PROCESOS LIBERACION CUPO CB RED POSICIONADA', 'PROCESOS LIBERACION CUPO CB RED POSICIONADA', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4005, 'PAGOS DE CARTERA POR CUENTAS INACTIVAS', 'PAGOS DE CARTERA POR CUENTAS INACTIVAS', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4100, 'TRANSFERENCIAS AUTOMATICAS', 'TRANSFERENCIAS AUTOMATICAS', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4102, 'SARTA AUXILIAR CONTABILIZACION  - REC', 'SARTA AUXILIAR CONTABILIZACION  - REC', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4103, 'SEMANAL/MENSUAL RECLASIFICACION COMPENSADOS AHO', 'SEMANAL/MENSUAL RECLASIFICACION COMPENSADOS AHO', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4201, 'PROCESOS AHORROS Y CARTERA  PREVIOS  AL CIERRE DE  CARTERA', 'PROCESOS AHORROS Y CARTERA  PREVIOS  AL CIERRE DE  CARTERA', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4202, 'PROCESOS SIMULTANEOS AHORROS  Y PLAZO FIJO', 'PROCESOS SIMULTANEOS AHORROS  Y PLAZO FIJO', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4203, 'PROCESOS EVENTUALES DE AHORROS', 'PROCESOS EVENTUALES DE AHORROS', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4204, 'TRASLADO DE CUENTAS DE AHORROS', 'TRASLADO DE CUENTAS DE AHORROS', getdate(), @w_usuario, 4, NULL, NULL)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (26001, 'PROCESOS COMPESACION Y CONCILIACION ADQUIIENTES', 'PROCESOS COMPESACION Y CONCILIACION ADQUIIENTES', getdate(), @w_usuario, 4, NULL, NULL)
GO
--SARTA

--SARTA BATCH
delete from cobis..ba_sarta_batch where sb_sarta in ('7','4004','4005','4100','4102','4103',
                                                     '4201','4202','4203','4204','26001')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (7, 4196, 1, NULL, 'S', 'N', 500, 550, 7, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4004, 4057, 1, NULL, 'S', 'N', 500, 550, 4004, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4004, 4275, 2, 1, 'S', 'N', 2000, 550, 4004, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4004, 4058, 3, 2, 'S', 'N', 3500, 550, 4004, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4004, 4011, 4, 3, 'S', 'N', 5000, 550, 4004, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4004, 4274, 5, 4, 'S', 'N', 6500, 550, 4004, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4005, 7010, 1, NULL, 'S', 'N', 500, 550, 4005, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4005, 4264, 2, 1, 'S', 'N', 2025, 555, 4005, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4005, 4265, 3, 2, 'S', 'N', 3500, 550, 4005, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4005, 4266, 4, 3, 'S', 'N', 5000, 550, 4005, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4005, 7958, 5, NULL, 'S', 'N', 465, 2025, 4005, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4005, 7070, 6, 5, 'S', 'N', 2010, 2025, 4005, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4005, 7959, 7, 6, 'S', 'N', 3510, 2025, 4005, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4100, 4230, 1, NULL, 'S', 'N', 480, 492, 4100, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4100, 4231, 2, NULL, 'S', 'N', 2004, 492, 4100, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4222, 1, NULL, 'S', 'N', 495, 1785, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4223, 2, NULL, 'S', 'N', 1995, 1785, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4224, 3, NULL, 'S', 'N', 3495, 1785, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4225, 4, NULL, 'S', 'N', 5040, 1785, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 6525, 5, NULL, 'S', 'N', 6495, 1785, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4227, 6, NULL, 'S', 'N', 510, 795, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4228, 7, NULL, 'S', 'N', 2010, 795, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4229, 8, NULL, 'S', 'N', 3510, 795, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4217, 9, NULL, 'S', 'N', 495, 2760, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4219, 10, NULL, 'S', 'N', 2010, 2775, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4220, 11, NULL, 'S', 'N', 3510, 2775, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4221, 12, NULL, 'S', 'N', 5010, 2775, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 28534, 13, NULL, 'S', 'N', 6510, 2775, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 28536, 14, NULL, 'S', 'N', 8010, 2775, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 28535, 15, NULL, 'S', 'N', 9510, 2775, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 28538, 16, NULL, 'S', 'N', 11010, 2775, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4232, 17, NULL, 'S', 'N', 12510, 2775, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 4250, 18, NULL, 'S', 'N', 510, 3750, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4102, 14999, 19, NULL, 'S', 'N', 2010, 3750, 4102, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4103, 4251, 1, NULL, 'S', 'N', 510, 945, 4103, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4103, 6525, 2, 1, 'S', 'N', 1950, 945, 4103, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4103, 6084, 3, 2, 'S', 'N', 3435, 945, 4103, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4103, 6100, 4, 3, 'S', 'N', 4815, 945, 4103, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4103, 4232, 5, 4, 'S', 'N', 6240, 960, 4103, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4103, 6869, 6, 5, 'S', 'N', 7740, 960, 4103, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4103, 4025, 7, NULL, 'S', 'N', 9240, 960, 4103, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4201, 4133, 1, NULL, 'N', 'N', 1005, 465, 4201, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4201, 4053, 2, 1, 'S', 'N', 2295, 465, 4201, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4201, 3085, 3, 2, 'S', 'N', 3525, 480, 4201, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4201, 4237, 4, 3, 'S', 'N', 4740, 480, 4201, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4201, 4230, 5, 4, 'S', 'N', 5925, 480, 4201, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4201, 7055, 6, NULL, 'S', 'N', 465, 1980, 7001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4201, 7073, 7, NULL, 'S', 'N', 1710, 1995, 7001, 'S')
GO

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4161, 1, NULL, 'N', 'N', 1785, 2415, 3001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4130, 2, 1, 'S', 'N', 3000, 2415, 3001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4240, 3, NULL, 'S', 'N', 11310, 1380, 3001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4130, 4, 2, 'S', 'N', 4380, 375, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4130, 5, 4, 'S', 'N', 4380, 1425, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4130, 6, 5, 'S', 'N', 4335, 2430, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4130, 7, 6, 'S', 'N', 4380, 3450, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4130, 8, 7, 'S', 'N', 4380, 4530, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4130, 9, 8, 'S', 'N', 5820, 2430, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4150, 10, NULL, 'N', 'N', 8415, 2430, 4202, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4255, 11, NULL, 'S', 'N', 9945, 1395, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4256, 12, NULL, 'S', 'N', 8430, 1395, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4257, 13, NULL, 'S', 'N', 540, 2415, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4242, 14, 10, 'S', 'N', 8415, 3495, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4244, 15, 14, 'S', 'N', 9990, 3480, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4246, 16, 15, 'S', 'N', 11310, 3495, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 6525, 17, NULL, 'S', 'N', 2730, 5985, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14003, 18, NULL, 'S', 'N', 555, 5970, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14005, 19, 18, 'S', 'N', 1635, 5970, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14006, 20, 17, 'S', 'N', 3810, 5970, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14009, 21, 20, 'S', 'N', 4965, 5970, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14048, 22, 21, 'S', 'N', 6135, 5970, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14008, 23, NULL, 'S', 'N', 7155, 6015, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14090, 24, NULL, 'S', 'N', 8265, 6000, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14091, 25, 24, 'S', 'N', 9435, 6000, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14092, 26, 25, 'S', 'N', 10620, 6015, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14093, 27, 26, 'S', 'N', 11820, 6000, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 14094, 28, 27, 'S', 'N', 12945, 5985, 14001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 4011, 29, 9, 'S', 'N', 7185, 2430, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 6064, 30, NULL, 'S', 'N', 4950, 6915, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 6525, 31, 30, 'S', 'N', 3795, 6915, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 7065, 32, 31, 'S', 'N', 2700, 6915, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4202, 7066, 33, 32, 'S', 'N', 1575, 6915, 4202, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4261, 1, NULL, 'S', 'N', 510, 795, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4242, 2, NULL, 'S', 'N', 495, 2295, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4243, 3, NULL, 'S', 'N', 2985, 2265, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4244, 4, 2, 'S', 'N', 480, 3780, 4203, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4245, 5, 3, 'S', 'N', 2985, 3765, 4203, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4246, 6, 4, 'S', 'N', 480, 5235, 4203, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4247, 7, 5, 'S', 'N', 3000, 5250, 4203, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4264, 8, NULL, 'S', 'N', 1950, 795, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4265, 9, NULL, 'S', 'N', 3450, 765, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4266, 10, NULL, 'S', 'N', 4935, 780, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4057, 11, NULL, 'S', 'N', 510, 6720, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4058, 12, 11, 'S', 'N', 1545, 7695, 4203, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4060, 13, NULL, 'S', 'N', 6330, 780, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4065, 14, NULL, 'S', 'N', 7860, 780, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4034, 15, NULL, 'S', 'N', 9360, 780, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4019, 16, NULL, 'S', 'N', 10860, 780, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4000, 17, NULL, 'S', 'N', 2985, 7710, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4001, 18, 17, 'S', 'N', 4500, 7710, 4203, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 2117, 19, 18, 'S', 'N', 5985, 7725, 4203, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4020, 20, NULL, 'S', 'N', 12405, 780, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4024, 21, NULL, 'S', 'N', 13905, 780, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4029, 22, NULL, 'S', 'N', 15405, 780, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4272, 23, NULL, 'S', 'N', 5445, 2310, 4203, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4203, 4273, 24, NULL, 'S', 'N', 7170, 2325, 4203, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4204, 4003, 1, NULL, 'S', 'N', 816, 888, 4204, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4204, 4004, 2, 1, 'S', 'N', 2316, 888, 4204, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (26001, 26001, 1, NULL, 'S', 'N', 500, 550, 26001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (26001, 26002, 2, NULL, 'S', 'N', 525, 2025, 26001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (26001, 26003, 3, NULL, 'S', 'N', 480, 3795, 26001, 'N')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (26001, 26004, 4, NULL, 'S', 'N', 2475, 2340, 26001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (26001, 26005, 5, 4, 'S', 'N', 2490, 1185, 26001, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (26001, 26005, 6, 4, 'S', 'N', 2460, 3780, 26001, 'S')
GO
--SARTA BATCH

--PARAMETROS
delete FROM cobis..ba_parametro WHERE pa_sarta in ('7','4004','4005','4100','4102','4103',
                                                '4201','4202','4203','4204','26001','0') 
                                  AND pa_batch in ('2117','3085','4000','4001','4003','4004','4011','4019','4020','4024',
                                               '4025','4029','4034','4053','4057','4058','4060','4065','4130','4133',
                                               '4150','4161','4196','4217','4219','4220','4221','4222','4223','4224',
                                               '4225','4227','4228','4229','4230','4231','4232','4237','4240','4242',
                                               '4243','4244','4245','4246','4247','4250','4251','4255','4256','4257',
                                               '4261','4264','4265','4266','4272','4273','4274','4275','6064','6084',
                                               '6100','6525','6869','7010','7055','7065','7066','7070','7073','7958',
                                               '7959','14003','14005','14006','14008','14009','14048','14090','14091',
                                               '14092','14093','14094','14999','26001','26002','26003','26004','26005',
                                               '28534','28535','28536','28538'
                                               )
GO
                                               
INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2117, 0, 1, 'Fecha de Proceso', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 2117, 0, 2, 'Tipo proceso', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 3085, 0, 1, 'FECHA PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4000, 0, 1, 'Fecha de Proceso', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4001, 0, 1, 'Fecha de Proceso', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4003, 0, 1, 'OFICINA ORIGEN', 'I', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4003, 0, 2, 'OFICINA DESTINO', 'I', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4004, 0, 1, 'FECHA TRASLADO', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4011, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4019, 0, 1, 'FECHA INICIAL', 'D', '01/01/2013')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4019, 0, 2, 'FECHA FINAL', 'D', '01/01/2013')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4020, 0, 1, 'FECHA DE PROCESO', 'D', '01/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4020, 0, 2, 'TIPO DE REPORTE', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4020, 0, 3, 'CANTIDAD MESES A CONSULTAR', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4025, 0, 1, 'FECHA', 'D', '09/01/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4057, 0, 1, 'TIPO CARGA "E" o "I"', 'C', 'E')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4130, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4130, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4130, 0, 3, 'HIJO', 'C', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4130, 0, 4, 'HIJOS', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4133, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4133, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4161, 0, 1, 'FILIAL ', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4161, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 1, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 2, 'MONTO INICIAL', 'M', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 3, 'MONTO FINAL', 'M', '999999999999.99')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 4, 'OPCION SUCURSAL', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 5, 'CODIGO SUCURSAL', 'I', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4222, 0, 1, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4223, 0, 1, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4225, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4227, 0, 1, 'FILIAL ', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4227, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4228, 0, 1, 'FILIAL ', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4228, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4229, 0, 1, 'FILIAL ', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4229, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4230, 0, 1, 'SERVIDOR', 'C', 'KERNELPROD')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4230, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4231, 0, 1, 'SERVIDOR', 'C', 'KERNELPROD')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4231, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4232, 0, 1, 'FILIAL ', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4232, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4232, 0, 3, 'HISTORICO', 'C', 'S')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4237, 0, 1, 'FECHA PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4240, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4240, 0, 2, 'FECHA INICIAL', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4240, 0, 3, 'FECHA FINAL', 'D', '01/01/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4242, 0, 1, 'FECHA PROCESO', 'D', '09/30/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4242, 0, 2, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4243, 0, 1, 'FECHA PROCESO', 'D', '09/30/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4243, 0, 2, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4244, 0, 1, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4244, 0, 2, 'FECHA PROCESO', 'D', '03/31/2012')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4245, 0, 1, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4245, 0, 2, 'FECHA PROCESO', 'D', '03/31/2012')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4246, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4246, 0, 2, 'FECHA PROCESO', 'D', '09/30/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4246, 0, 3, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4247, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4247, 0, 2, 'FECHA PROCESO', 'D', '09/30/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4247, 0, 3, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4250, 0, 1, 'FECHA PROCESO', 'D', '01/01/2011')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4251, 0, 1, 'PRODUCTO', 'I', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4251, 0, 2, 'FECHA', 'D', '07/31/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4255, 0, 1, 'FECHA PROCESO', 'D', '01/31/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 1, 'PRODUCTO BANCARIO', 'I', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 2, 'FECHA', 'D', '01/01/2012')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 3, 'OFICINA', 'I', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4266, 0, 1, 'FECHA A PROCESAR', 'D', '01/01/2012')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4272, 0, 1, 'FECHA_TRANSACCION', 'D', '01/01/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4273, 0, 1, 'FECHA_TRANSACCION', 'D', '01/01/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4274, 0, 1, 'HABILITADO', 'C', 'S')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4275, 0, 1, 'HABILITADO', 'C', 'N')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6064, 0, 1, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6084, 0, 1, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6084, 0, 2, 'FECHA', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6084, 0, 3, 'PRODUCTO', 'I', '6')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6100, 0, 1, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6100, 0, 2, 'FECHA', 'D', '05/31/2007')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6525, 0, 1, 'OPERACION (V)', 'C', 'V')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6525, 0, 2, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6525, 0, 3, 'PRODUCTO', 'I', '7')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6869, 0, 1, 'FECHA PROCESO', 'D', '08/19/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6869, 0, 2, 'PRODUCTO', 'I', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6869, 0, 3, 'OPCION', 'C', 'P')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7073, 0, 1, 'FECHA ', 'D', '10/21/2009')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7958, 0, 1, 'FECHA DE PROCESO', 'D', '01/01/2012')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7959, 0, 1, 'FECHA DE PROCESO', 'D', '01/01/2012')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14003, 0, 1, 'FECHA', 'D', '06/25/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14008, 0, 1, 'FECHA', 'D', '06/25/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14008, 0, 2, 'TOPERACION', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14008, 0, 3, 'CIUDAD', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14008, 0, 4, 'OFICINA', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14048, 0, 1, 'FECHA INICIAL', 'D', '06/25/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14048, 0, 2, 'FECHA FINAL', 'D', '06/25/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14093, 0, 1, 'FECHA INICIAL', 'D', '06/25/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14093, 0, 2, 'FECHA FINAL', 'D', '06/25/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14094, 0, 1, 'FECHA INICIAL', 'D', '06/25/2010')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14094, 0, 2, 'FECHA FINAL', 'D', '06/25/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14999, 0, 1, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14999, 0, 2, 'FECHA ', 'D', '05/31/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14999, 0, 3, 'HISTORICO', 'C', 'S')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26001, 0, 1, 'Nombre Archivo', 'C', 'posmia.dat')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26001, 0, 2, 'Fecha Proceso', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26002, 0, 1, 'Nombre Archivo', 'C', 'extrmia.dat')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26002, 0, 2, 'Fecha Proceso', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26003, 0, 1, 'Nombre Archivo', 'C', '140428.MOV')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26003, 0, 2, 'Fecha Proceso', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26004, 0, 1, 'Fecha Proceso', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26004, 0, 2, 'Código Red/Entidad Base (COB-Cobis,', 'C', 'RBM')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26005, 0, 1, 'Fecha Proceso', 'D', '01/01/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26005, 0, 2, 'Código Red/Entidad Base (COB-Cobis,', 'C', 'COB')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26005, 0, 3, 'Codigo Red a conciliar (RBM-Redeban', 'C', 'RBM')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28534, 0, 1, 'FECHA DE PROCESO', 'D', '01/27/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28534, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DT')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28535, 0, 1, 'FECHA DE PROCESO', 'D', '01/27/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28535, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'PY')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28536, 0, 1, 'FECHA DE PROCESO', 'D', '01/27/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28536, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DD')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28538, 0, 1, 'FECHA PROCESO     ', 'D', '08/01/2009')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7, 4196, 1, 1, 'FECHA DE PROCESO', 'D', '10/21/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7, 4196, 1, 2, 'MONTO INICIAL', 'M', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7, 4196, 1, 3, 'MONTO FINAL', 'M', '999999999999.99')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7, 4196, 1, 4, 'OPCION SUCURSAL', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (7, 4196, 1, 5, 'CODIGO SUCURSAL', 'I', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4004, 4011, 4, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4004, 4057, 1, 1, 'TIPO CARGA "E" o "I"', 'C', 'E')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4004, 4274, 5, 1, 'HABILITADO', 'C', 'S')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4004, 4275, 2, 1, 'HABILITADO', 'C', 'N')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4005, 4266, 4, 1, 'FECHA A PROCESAR', 'D', '06/27/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4005, 7958, 5, 1, 'FECHA DE PROCESO', 'D', '06/27/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4005, 7959, 7, 1, 'FECHA DE PROCESO', 'D', '06/27/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4100, 4230, 1, 1, 'SERVIDOR', 'C', 'KERNELPROD')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4100, 4230, 1, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4100, 4231, 2, 1, 'SERVIDOR', 'C', 'KERNELPROD')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4100, 4231, 2, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4222, 1, 1, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4223, 2, 1, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4225, 4, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4227, 6, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4227, 6, 2, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4228, 7, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4228, 7, 2, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4229, 8, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4229, 8, 2, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4232, 17, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4232, 17, 2, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4232, 17, 3, 'HISTORICO', 'C', 'S')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 4250, 18, 1, 'FECHA PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 6525, 5, 1, 'OPERACION (V)', 'C', 'V')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 6525, 5, 2, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 6525, 5, 3, 'PRODUCTO', 'I', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 14999, 19, 1, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 14999, 19, 2, 'FECHA', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 14999, 19, 3, 'HISTORICO', 'C', 'S')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 28534, 13, 1, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 28534, 13, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DT')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 28535, 15, 1, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 28535, 15, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'PY')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 28536, 14, 1, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 28536, 14, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DD')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4102, 28538, 16, 1, 'FECHA PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 4025, 7, 1, 'FECHA', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 4232, 5, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 4232, 5, 2, 'FECHA DE PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 4232, 5, 3, 'HISTORICO', 'C', 'S')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 4251, 1, 1, 'PRODUCTO', 'I', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 4251, 1, 2, 'FECHA', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6084, 3, 1, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6084, 3, 2, 'FECHA', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6084, 3, 3, 'PRODUCTO', 'I', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6100, 4, 1, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6100, 4, 2, 'FECHA', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6525, 2, 1, 'OPERACION (V)', 'C', 'V')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6525, 2, 2, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6525, 2, 3, 'PRODUCTO', 'I', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6869, 6, 1, 'FECHA PROCESO', 'D', '10/31/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6869, 6, 2, 'PRODUCTO', 'I', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4103, 6869, 6, 3, 'OPCION', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4201, 3085, 3, 1, 'FECHA PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4201, 4133, 1, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4201, 4133, 1, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4201, 4230, 5, 1, 'SERVIDOR', 'C', 'KERNELPROD')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4201, 4230, 5, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4201, 4237, 4, 1, 'FECHA PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4201, 7073, 7, 1, 'FECHA ', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4011, 29, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 2, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 2, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 2, 3, 'HIJO', 'C', '0')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 2, 4, 'HIJOS', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 4, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 4, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 4, 3, 'HIJO', 'C', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 4, 4, 'HIJOS', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 5, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 5, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 5, 3, 'HIJO', 'C', '2')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 5, 4, 'HIJOS', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 6, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 6, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 6, 3, 'HIJO', 'C', '3')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 6, 4, 'HIJOS', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 7, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 7, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 7, 3, 'HIJO', 'C', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 7, 4, 'HIJOS', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 8, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 8, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 8, 3, 'HIJO', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 8, 4, 'HIJOS', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 9, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 9, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 9, 3, 'HIJO', 'C', '999')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4130, 9, 4, 'HIJOS', 'C', '5')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4161, 1, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4161, 1, 2, 'FECHA DE PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4240, 3, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4240, 3, 2, 'FECHA INICIAL', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4240, 3, 3, 'FECHA FINAL', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4242, 14, 1, 'FECHA PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4242, 14, 2, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4244, 15, 1, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4244, 15, 2, 'FECHA PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4246, 16, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4246, 16, 2, 'FECHA PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4246, 16, 3, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 4255, 11, 1, 'FECHA PROCESO', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 6064, 30, 1, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 6525, 31, 1, 'OPERACION (V)', 'C', 'V')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 6525, 31, 2, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 6525, 31, 3, 'PRODUCTO', 'I', '7')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 6525, 17, 1, 'OPERACION (V)', 'C', 'V')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 6525, 17, 2, 'EMPRESA', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 6525, 17, 3, 'PRODUCTO', 'I', '14')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14003, 18, 1, 'FECHA', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14008, 23, 1, 'FECHA', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14008, 23, 2, 'TOPERACION', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14008, 23, 3, 'CIUDAD', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14008, 23, 4, 'OFICINA', 'C', 'T')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14048, 22, 1, 'FECHA INICIAL', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14048, 22, 2, 'FECHA FINAL', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14093, 27, 1, 'FECHA INICIAL', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14093, 27, 2, 'FECHA FINAL', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14094, 28, 1, 'FECHA INICIAL', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4202, 14094, 28, 2, 'FECHA FINAL', 'D', '11/09/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 2117, 19, 1, 'Fecha de Proceso', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 2117, 19, 2, 'Tipo proceso', 'C', 'A')
GO

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4000, 17, 1, 'Fecha de Proceso', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4001, 18, 1, 'Fecha de Proceso', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4019, 16, 1, 'FECHA INICIAL', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4019, 16, 2, 'FECHA FINAL', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4020, 20, 1, 'FECHA DE PROCESO', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4020, 20, 2, 'TIPO DE REPORTE', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4020, 20, 3, 'CANTIDAD MESES A CONSULTAR', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4057, 11, 1, 'TIPO CARGA "E" o "I"', 'C', 'E')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4242, 2, 1, 'FECHA PROCESO', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4242, 2, 2, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4243, 3, 1, 'FECHA PROCESO', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4243, 3, 2, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4244, 4, 1, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4244, 4, 2, 'FECHA PROCESO', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4245, 5, 1, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4245, 5, 2, 'FECHA PROCESO', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4246, 6, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4246, 6, 2, 'FECHA PROCESO', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4246, 6, 3, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4247, 7, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4247, 7, 2, 'FECHA PROCESO', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4247, 7, 3, 'EJECUCION', 'C', 'D')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4261, 1, 1, 'PRODUCTO BANCARIO', 'I', '4')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4261, 1, 2, 'FECHA', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4261, 1, 3, 'OFICINA', 'I', '7036')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4266, 10, 1, 'FECHA A PROCESAR', 'D', '11/04/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4272, 23, 1, 'FECHA_TRANSACCION', 'D', '05/06/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4203, 4273, 24, 1, 'FECHA_TRANSACCION', 'D', '05/06/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4204, 4003, 1, 1, 'OFICINA ORIGEN', 'I', '7061')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4204, 4003, 1, 2, 'OFICINA DESTINO', 'I', '7060')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4204, 4004, 2, 1, 'FECHA TRASLADO', 'D', '05/29/2014')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26001, 1, 1, 'Nombre Archivo', 'C', 'extp1103.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26001, 1, 2, 'Fecha Proceso', 'D', '11/03/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26002, 2, 1, 'Nombre Archivo', 'C', 'exta1103.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26002, 2, 2, 'Fecha Proceso', 'D', '11/03/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26003, 3, 1, 'Nombre Archivo', 'C', '151103.mov')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26003, 3, 2, 'Fecha Proceso', 'D', '11/03/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26004, 4, 1, 'Fecha Proceso', 'D', '11/03/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26004, 4, 2, 'Código Red/Entidad Base (COB-Cobis,', 'C', 'RBM')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26005, 5, 1, 'Fecha Proceso', 'D', '11/03/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26005, 5, 2, 'Código Red/Entidad Base (COB-Cobis,', 'C', 'COB')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26005, 5, 3, 'Codigo Red a conciliar (RBM-Redeban', 'C', 'RBM')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26005, 6, 1, 'Fecha Proceso', 'D', '11/03/2015')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26005, 6, 2, 'Código Red/Entidad Base (COB-Cobis,', 'C', 'RBM')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (26001, 26005, 6, 3, 'Codigo Red a conciliar (RBM-Redeban', 'C', 'SVB')
GO
--PARAMETROS