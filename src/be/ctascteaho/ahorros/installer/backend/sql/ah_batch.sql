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
/*    09/Mayo/2016      Ignacio Yupa    Migracion a CEN                 */
/*    27/Jul/2016       Tania Baidal    Se agrega sarta 4001            */
/*                                      y parametrizacion de los batchs */
/*    17/Ago/2016       Jorge Salazar   Se incluye batch en sarta 4002  */
/*                                      28534, 28535, 28538, 28539      */
/*                                      DATOS PASIVAS COB_EXTERNOS      */
/*                                      A COB_CONTA_SUPER               */
/************************************************************************/
use cobis
go


--**** PARAMETROS INICIALES ****

--Fecha cierre

DELETE cobis..ba_fecha_cierre WHERE fc_producto in (4, 17)

Declare @w_fecha_proceso datetime

SELECT @w_fecha_proceso = isnull(fp_fecha, getdate()) FROM ba_fecha_proceso   

INSERT INTO cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
VALUES (4, @w_fecha_proceso, NULL)

INSERT INTO cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
VALUES (17, @w_fecha_proceso, NULL)

--Path de producto
DELETE cobis..ba_path_pro WHERE pp_producto = 4

INSERT INTO cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
VALUES (4, 'C:/Cobis/vbatch/ahorros/objetos/', 'C:/Cobis/vbatch/ahorros/listados/')

go

--**** SARTA ****




delete from cobis..ba_sarta where sa_sarta in (4001, 4002)
go

declare @w_usuario varchar(64)       

select @w_usuario = 'operador'

insert into cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
values (4001, 'INICIO DE DIA DE AHORROS', 'INICIO DE DIA DE AHORROS', '2016-07-21 12:00:00.733', @w_usuario, 4, NULL, NULL)

insert into ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
values (4002, 'DIARIO DE CUENTAS AHORROS', 'DIARIO DE CUENTAS AHORROS', getdate(), @w_usuario, 4, null, null)

--**** BATCHS ****

delete ba_batch where ba_batch in (4053, 3317, 4026, 17001, 4037, 4011, 4204, 4237, 4236, 3363, 
                                   4133, 4257, 4161, 4130, 4150, 4256, 4255, 4240, 4135, 4012, 
                                   4013, 4222, 4223, 4217, 4219, 4220, 4221, 4224, 4225, 4249, 
                                   4016, 4131, 2224, 28534, 28535, 28538, 28539,4132,28540, 4260)
go        

declare @w_servidor   varchar(30), @w_path_fuente varchar(50), @w_path_destino  varchar(50)

select @w_servidor = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and pa_nemonico = 'SRVR'
--select @w_servidor = isnull(@w_servidor,'CLOUDSRVD')?

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 4

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/ahorros/listados/')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 4

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/ahorros/objetos/')

     
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4053, 'CREACION TABLAS TEMPORALES DE PERSONALIZACION', 'CREACION TABLAS TEMPORALES DE PERSONALIZACION', 'SP', getdate(), 4, 'P', 1, 'TABLAS TEMPORALES', 'person.lis', 'cob_ahorros..sp_crea_tem_person', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (3317, 'VALIDA EJECUCION BATCH  FIN DE SEMANA-FESTIVO', 'VALIDA EJECUCION BATCH  FIN DE SEMANA-FESTIVO', 'SP', getdate(), 4, 'P', 1, 'EJECUCION', '', 'cob_cuentas..sp_valida_siprocesa', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4026, 'INICIO DE DIA DE CUENTAS DE AHORROS', 'INICIO DE DIA DE CUENTAS DE AHORROS', 'SP', getdate(), 4, 'P', 1, 'ah_tran_monet', NULL, 'cob_ahorros..sp_ahdiario', 1, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (17001, 'ACTUALIZACION DE COSTOS', 'ACTUALIZACION DE COSTOS', 'SP', getdate(), 17, 'P', 1, 'COSTOS', NULL, 'cob_remesas..sp_proceso_costos', 4, '', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4037, 'ACTUALIZACION DE SALDOS  DE AHORROS', 'ACTUALIZACION DE SALDOS  DE AHORROS', 'SP', getdate(), 4, 'P', 1, 'CUENTAS', NULL, 'cob_ahorros..sp_update_to_date_batch', 10, '', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4011, 'COBRO DE VALORES EN SUSPENSO DE CUENTAS DE AHORROS', 'COBRO DE VALORES EN SUSPENSO DE CUENTAS DE AHORROS CCA-550', 'SP', getdate(), 4, 'P', 1, 'AHORROS', NULL, 'cob_ahorros..sp_ah_cobsus_batch', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4204, 'INICIALIZA EL CAMPOS DE MAESTRO AL INICIAR EL DIA', 'INICIALIZA EL CAMPOS DE MAESTRO AL INICIAR EL DIA', 'SP', getdate(), 4, 'P', 1, 'sp_update_to_date_inicio_ah', NULL, 'cob_ahorros..sp_update_to_date_inicio_ah', 1, 'lp', @w_servidor, 'N', @w_path_fuente, @w_path_destino)


--sarta 4002

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (3363, 'TRASLADO NETO BANREPUBLICA',                                   'TRASLADO NETO BANREPUBLICA',                                   'SP', getdate(), 4, 'P', 1, 'CAMARA',                              null,                   'cob_remesas..sp_tras_neto_br',                1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4133, 'INICIALIZACION DE TABLAS TEMPORALES',                          'INICIALIZACION DE TABLAS TEMPORALES',                          'SP', getdate(), 4, 'P', 1, 'TABLAS DE INICIO DEL PROCESO DIARIO', null,                    'cob_ahorros..sp_ah_ahinitbl',                1000, null, @w_servidor, 'N', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4237, 'EFECTIVIZACION CANJE CUENTAS DE AHORRO', 'EFECTIVIZACION CANJE CUENTAS DE AHORRO',                                             'SP', getdate(), 4, 'P', 1, 'CUENTA',                              null,          'cob_ahorros..sp_update_efectiah_batch',                         100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4236, 'INMOVILIZACION DE CUENTAS DE AHORRO', 'INMOVILIZAICON DE CUENTAS DE AHORRO(180)',                                              'SP', getdate(), 4, 'P', 1, 'CUENTAS',                             null,                  'cob_ahorros..sp_ah_inmoviliza',                                1000, null, @w_servidor, 'S', @w_path_fuente, null)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4257, 'CIERRE AUTOMATICO DE CUENTAS DE AHORROS SIN DEPOSITO INICIAL', 'CIERRE AUTOMATICO DE CUENTAS DE AHORROS SIN DEPOSITO INICIAL', 'SP', getdate(), 4, 'P', 1, 'MAESTRO DE CUENTAS DE AHORRO',        null,           'cob_ahorros..sp_valida_tiempo_activa',       1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4161, 'VALIDACION ANTES DEL CALCULO DE INTERESES AHORROS',            'VALIDACION ANTES DEL CALCULO DE INTERESES AHORROS',            'SP', getdate(), 4, 'P', 1, '',                          'ahvaltmp.lis',                       'cob_ahorros..sp_ahvaltmp',                   1000, null, @w_servidor, 'N', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4130, 'PROVISION INTERES',                                            'PROVISION INTERES',                                            'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS',                  null,                      'cob_ahorros..sp_ahmensual',                  1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4150, 'GENERACION DE SALDOS DIARIOS',                                 'GENERACION DE SALDOS DIARIOS',                                 'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS',                  null,                'cob_ahorros..sp_ah_saldo_diario',            1000, null, @w_servidor, 'N', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4256, 'CUMPLIMIENTO CUENTAS ESPECIALES',                              'CUMPLIMIENTO CUENTAS ESPECIALES CC_286',                       'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS',        'reportes.lis',                'cob_ahorros..sp_mto_ahorro_plan',            1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4255, 'REPORTE SEGUIMIENTO CUENTAS CON CUMPLIMIENTO',                 'REPORTE SEGUIMIENTO CUENTAS CON CUMPLIMIENTO CC_286',          'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS','cumplimientos_aammdd',             'cob_ahorros..sp_reporte_seguimiento',        1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4240, 'REPORTE ERRORES BATCH',                                        'REPORTE ERRORES BATCH',                                        'SP', getdate(), 4, 'P', 1, 'AH_ERRORLOG',                         'aherrbatch.lis',       'cob_ahorros..sp_aherrbatch',                              1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4135, 'PASO DE DATOS A TABLAS TEMPORALES',                            'PASO DE DATOS A TABLAS TEMPORALES',                            'SP', getdate(), 4, 'P', 1, 'CUENTAS Y MOVIMIENTOS',               null,                   'cob_ahorros..sp_tablas_temp',                  10, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4012, 'PASO A HISTORICO DE TRANSACCIONES MONETARIAS (AHORROS)',       'PASO A HISTORICO DE TRANSACCIONES MONETARIAS (AHORROS)',       'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES MONETARIAS',            null,                   'cob_ahorros..sp_ah_his_mon',                1000, null, @w_servidor, 'N', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4013, 'PASO A HISTORICO DE TRANSACCIONES DE SERVICIO (AHORROS)',      'PASO A HISTORICO DE TRANSACCIONES DE SERVICIO (AHORROS)',      'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES DE SERVICIO',           null,                   'cob_ahorros..sp_ahhisser',                1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4222, 'TOTALIZADOR TRANSACCIONES MONETARIAS AHORROS',                 'TOTALIZADOR TRANSACCIONES MONETARIAS AHORROS',                 'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES MONETARIAS',            null,                   'cob_ahorros..sp_totaliza_tran_mon_ah',       1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4223, 'TOTALIZADOR TRANSACCIONES DE SERVICIO AHORROS',                'TOTALIZADOR TRANSACCIONES DE SERVICIO AHORROS',                'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES DE SERVICIO',           null,                   'cob_ahorros..sp_totaliza_tran_serv_ah',      1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4217, 'GENERACION DE DATA SALDOS PARA REC - COB_EXTERNOS',            'GENERACION DE DATA SALDOS PARA REC - COB_EXTERNOS',            'SP', getdate(), 4, 'P', 1, 'CUENTAS MOVIMIENTOS Y BLOQUEOS',      null,                   'cob_ahorros..sp_datos_pasivas_rec',            10, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4219, 'GENERACION DE DATA MOVIMIENTOS PARA REC - COB_EXTERNOS',       'GENERACION DE DATA MOVIMIENTOS PARA REC - COB_EXTERNOS',       'SP', getdate(), 4, 'P', 1, 'MOVIMIENTOS',                         null,                   'cob_ahorros..sp_datos_mov_rec',                10, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4220, 'GENERACION DE DATA BLOQUEOS PARA REC - COB_EXTERNOS',          'GENERACION DE DATA BLOQUEOS PARA REC - COB_EXTERNOS',          'SP', getdate(), 4, 'P', 1, 'BLOQUEOS',                            null,                   'cob_ahorros..sp_datos_bloq_rec',               10, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4221, 'GENERACION DE DATA TITULARES PARA REC - COB_EXTERNOS',         'GENERACION DE DATA TITULARES PARA REC - COB_EXTERNOS',         'SP', getdate(), 4, 'P', 1, 'CLIENTES',                            null,                   'cob_ahorros..sp_datos_deudores_rec',           10, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4224, 'GENERADOR DE COMPROBANTES AHORROS',                            'GENERADOR DE COMPROBANTES AHORROS',                            'SP', getdate(), 4, 'P', 1, 'COMPROBANTES',                        null,                   'cob_ahorros..sp_conta',                      1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4225, 'VALIDA COMPROBANTES AHORROS',                                  'VALIDA COMPROBANTES AHORROS',                                  'SP', getdate(), 4, 'P', 1, 'COMPROBANTES',                        null,                   'cob_ahorros..sp_ah_generacion_contabilidad',   10, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4249, 'ARCHIVO PLANO DE SALDOS DE CUENTAS DE AHORROS',                'ARCHIVO PLANO DE SALDOS DE CUENTAS DE AHORROS',                'SP', getdate(), 4, 'P', 1, 'AHORROS',                             'saldoscta.lis',        'cob_ahorros..sp_saldos_plano_ah',             1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4016, 'GENERACION DE ah_consolidado',                                 'GENERACION DE ah_consolidado LLS_113',                         'SP', getdate(), 4, 'P', 1, 'CUENTAS',                             null,                   'cob_ahorros..sp_consolida',                  1000, null, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4131, 'GENERACION DE CABECERAS DE ESTADOS DE CUENTA DE AHORROS',      'GENERACION DE CABECERAS DE ESTADOS DE CUENTA DE AHORROS',      'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORRO',                   null,                   'cob_ahorros..sp_estado_cuenta_ah',           1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4132, 'GENERACION DE ESTADOS DE CUENTA MASIVOS DE AHORROS',      'GENERACION DE ESTADOS DE CUENTA MASIVOS DE AHORROS',      'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORRO',                   null,                   'cob_ahorros..sp_est_cta_masivo_ah',           1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (2224, 'CONSOLIDADOR CLIENTES',                                        'CONSOLIDADOR CLIENTES',                                        'SP', getdate(), 4, 'P', 1, 'CLIENTES',                             null,                  'cobis..sp_cons_cliente',                      1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (28534, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER (DT)', 'SP', getdate(), 4, 'P', 1, 'OPERACION',               null,                   'cob_conta_super..sp_datos_operacion',         1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (28535, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER PY', 'SP', getdate(), 4, 'P', 1, 'OPERACION',               null,                   'cob_conta_super..sp_datos_operacion',         1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (28538, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'SP', getdate(), 4, 'P', 1, 'OPERACION',                    null,                   'cob_conta_super..sp_dato_pasivas',            1000, null, @w_servidor, 'S', @w_path_fuente, null           )
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (28539, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER - CLIENTES "CL"', 'SP', getdate(), 4, 'R', 1, 'OPERACIONES',  'dataope.lis',          'cob_conta_super..sp_datos_operacion',         1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (28540, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER - DEUDORES "CL"', 'SP', getdate(), 4, 'R', 1, 'OPERACIONES',  'dataope.lis',          'cob_conta_super..sp_datos_operacion',         1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4260, 'ACTUALIZACION DE ESTADOS CUENTA DE AHORROS', 'ACTUALIZACION DE ESTADOS CUENTA DE AHORROS', 'SP', getdate(), 4, 'P', 1, 'jar-with-dependencies.jar', NULL, 'cob_ahorros..sp_ejecuta_jar', 1000, NULL, @w_servidor, 'S', 'C:/java/', NULL)
go


--**** SARTA BATCH ****
delete from cobis..ba_sarta_batch where sb_sarta in (4001, 4002)
go


insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4001, 4053, 1, null, 'S', 'N', 465, 600, 4001, 'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4001, 3317, 2, null, 'S', 'N', 1590, 600, 4001, 'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4001, 4026,  3, null, 'N', 'N', 2625,  600, 4001, 'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4001, 17001, 4, null, 'S', 'N', 3645, 600, 4001, 'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4001, 4037,  5, null, 'S', 'N', 4605,  600, 4001, 'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4001, 4011, 6, null, 'S', 'N', 5640, 600, 4001, 'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4001, 4204,  7, null, 'N', 'N', 6765,  600, 4001, 'S')     


go   

--sarta 4002
declare @w_sarta int

select @w_sarta = 4002

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4053, 1, NULL, 'S', 'N', 15, 3840, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 3363, 2, NULL, 'S', 'N', 1065, 3840, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4133, 3, NULL, 'S', 'N', 2115, 3840, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4237, 4, null, 'S', 'N', 3165, 3840, @w_sarta, 'S')  

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4236, 5, null, 'S', 'N', 4215, 3840, @w_sarta, 'S')  

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4257, 6, NULL, 'S', 'N', 5265, 3840, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4161, 7, NULL, 'N', 'N', 6315, 3840, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4130, 8, 7, 'S', 'N', 7865, 510, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4130, 13, 8, 'S', 'N', 7865, 1485, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4130, 14, 13, 'S', 'N', 7865, 2370, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4130, 15, 14, 'S', 'N', 7865, 3405, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4130, 16, 15, 'S', 'N', 7865, 5115, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4130, 17, 16, 'S', 'N', 7865, 4200, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4130, 18, 17, 'S', 'N', 7865, 5910, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4150, 9, NULL, 'N', 'N', 9465, 3840, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4256, 10, NULL, 'S', 'N', 10725, 2760, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4255, 11, NULL, 'S', 'N', 11790, 2805, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4240, 12, NULL, 'S', 'N', 12960, 2775, @w_sarta, 'S')


INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4135, 19, NULL, 'S', 'N', 14160, 2805, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4012, 20, NULL, 'N', 'N', 15195, 2775, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4013, 21, NULL, 'S', 'N', 16410, 2715, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4222, 22, NULL, 'S', 'N', 16380, 3795, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4223, 23, NULL, 'S', 'N', 15210, 3825, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 2224, 24, NULL, 'S', 'N', 14070, 3795, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4217, 25, NULL, 'S', 'N', 12960, 3810, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 28538, 26, NULL, 'S', 'N', 11820, 3810, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4219, 27, NULL, 'S', 'N', 10695, 3840, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4220, 28, NULL, 'S', 'N', 10815, 4830, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4221, 29, NULL, 'S', 'N', 11820, 4800, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 28534, 30, NULL, 'S', 'N', 12975, 4770, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 28535, 31, NULL, 'S', 'N', 14160, 4755, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 28539, 32, NULL, 'S', 'N', 15210, 4725, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 28540, 33, NULL, 'S', 'N', 16365, 4785, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4224, 34, NULL, 'S', 'N', 16335, 5775, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4225, 35, NULL, 'S', 'N', 15180, 5760, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4249, 36, NULL, 'S', 'N', 14055, 5760, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4016, 37, NULL, 'S', 'N', 12870, 5745, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4131, 38, NULL, 'S', 'N', 11835, 5760, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4132, 39, NULL, 'S', 'N', 10845, 5760, @w_sarta, 'S')

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (@w_sarta, 4260, 40, NULL, 'S', 'N', 10860, 6780, @w_sarta, 'S')

GO



--**** PARAMETROS ****
delete FROM cobis..ba_parametro WHERE pa_sarta in (0, 4001, 4002) 
                                  AND pa_batch in (3317,4026,17001,4037,4011,4204, 
								   3363, 4133, 4236, 4237, 4257, 4161, 4130, 4150, 4256, 4255, 
								   4240, 4135, 4012, 4013, 4222, 4223, 4217, 4219, 4220, 4132,
								   4221, 4224, 4225, 4249, 4016, 4131, 2224, 28534, 28535, 28538, 
                                           28539, 28540, 4260		  )
GO

declare @w_path_destino  varchar(50)

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 4

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/ahorros/listados/')


--sarta 0
--4001
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 3317, 0, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4011, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4026, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4026, 0, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 17001, 0, 1, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4037, 0, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4204, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4204, 0, 2 , 'FECHA_PROCESO', 'D', getdate())
--4002
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 3363, 0, 1, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4133, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4133, 0, 2 , 'FECHA_ PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4237, 0, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4236, 0, 1 , 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4161, 0, 1 , 'FILIAL ', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4161, 0, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4161, 0, 3 , 'RUTA_SALIDA', 'C', 'C:/Cobis/vbatch/ahorros/listados/')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4130, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4130, 0, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4130, 0, 3 , 'HIJO', 'C', '0')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4130, 0, 4 , 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4255, 0, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4240, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4240, 0, 2 , 'FECHA_INICIAL', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4240, 0, 3 , 'FECHA_FINAL', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4240, 0, 4 , 'DIRECTORIO_SALIDA', 'C', @w_path_destino)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4012, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4012, 0, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4013, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4013, 0, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4222, 0, 1 , 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4223, 0, 1 , 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4217, 0, 1 , 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 2224, 0, 1 , 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28538, 0, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4219, 0, 1 , 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4221, 0, 1 , 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28534, 0, 1 , 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28534, 0, 2 , 'OPERACION_(TO/DO/DT/PY/DD)', 'C', 'DT')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28535, 0, 1 , 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28535, 0, 2 , 'OPERACION_(TO/DO/DT/PY/DD)', 'C', 'PY')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28539, 0, 1 , 'FECHA_OPERACION', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28539, 0, 2 , 'OPERACION', 'C', 'CL')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28540, 0, 1 , 'FECHA_OPERACION', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28540, 0, 2 , 'OPERACION', 'C', 'DD')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4225, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4249, 0, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4016, 0, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4131, 0, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4131, 0, 2 , 'FECHA', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4132, 0, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4132, 0, 2 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4260, 0, 1 , 'FECHA_PROCESO', 'D', getdate())

--sarta 4001
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4001, 3317, 2, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4001, 4026, 3, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4001, 4026, 3, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4001, 17001, 4, 1, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4001, 4037, 5, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4001, 4011, 6, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4001, 4204, 7, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4001, 4204, 7, 2 , 'FECHA_PROCESO', 'D', getdate())

--sarta 4002
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 3363, 2, 1, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4133, 3, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4133, 3, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4237, 4, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4236, 5, 1 , 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4161, 7, 1 , 'FILIAL ', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4161, 7, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4161, 7, 3 , 'RUTA_SALIDA', 'C', 'C:/Cobis/vbatch/ahorros/listados/')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 8, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 8, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 8, 3 , 'HIJO', 'C', '0')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 8, 4 , 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 13, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 13, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 13, 3 , 'HIJO', 'C', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 13, 4 , 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 14, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 14, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 14, 3 , 'HIJO', 'C', '2')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 14, 4 , 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 15, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 15, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 15, 3 , 'HIJO', 'C', '3')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 15, 4 , 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 16, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 16, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 16, 3 , 'HIJO', 'C', '4')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 16, 4 , 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 17, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 17, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 17, 3 , 'HIJO', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 17, 4 , 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 18, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 18, 2 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 18, 3 , 'HIJO', 'C', '999')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4130, 18, 4 , 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4255, 11, 1 , 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4240, 12, 1 , 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4240, 12, 2 , 'FECHA_INICIAL', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4240, 12, 3 , 'FECHA_FINAL', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4240, 12, 4 , 'DIRECTORIO_SALIDA', 'C', 'C:/Cobis/vbatch/ahorros/listados/')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4012, 20, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4012, 20, 2, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4013, 21, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4013, 21, 2, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values (4002, 4222, 22, 1, 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4223, 23, 1, 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 2224, 24, 1, 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4217, 25, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28538, 26, 1, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4219, 27, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4221, 29, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28534, 30, 1, 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28534, 30, 2, 'OPERACION_(TO/DO/DT/PY/DD)', 'C', 'DT')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28535, 31, 1, 'FECHA_DE_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28535, 31, 2, 'OPERACION_(TO/DO/DT/PY/DD)', 'C', 'PY')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28539, 32, 1, 'FECHA_OPERACION', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28539, 32, 2, 'OPERACION', 'C', 'CL')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28540, 33, 1, 'FECHA_OPERACION', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 28540, 33, 2, 'OPERACION', 'C', 'DD')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4225, 35, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4249, 36, 1, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4016, 37, 1, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4131, 38, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4131, 38, 2, 'FECHA', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4132, 39, 1, 'FECHA_PROCESO', 'D', getdate())
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4132, 39, 2, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(4002, 4260, 40, 1, 'FECHA_PROCESO', 'D', getdate())


--ENLACE
delete from cobis..ba_enlace WHERE en_sarta in (4001, 4002)
go

--sarta 1
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4001,4053,1,3317,2, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4001,3317,2,4026,3, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4001,4026,3,17001,4, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4001,17001,4,4037,5, 'S', null, 'N')
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4001,4037,5,4011,6, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4001,4011,6,4204,7, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4001,4204,7,0,0, 'S', null, 'N')

--sarta 2
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4053, 1, 3363, 2, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 3363, 2, 4133, 3, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4133, 3, 4237, 4, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4237, 4, 4236, 5, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4236, 5, 4257, 6, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4257, 6, 4161, 7, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4161, 7, 4130, 8, 'D', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4161, 7, 4130, 13, 'D', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4161, 7, 4130, 14, 'D', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4161, 7, 4130, 15, 'D', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4161, 7, 4130, 16, 'D', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4161, 7, 4130, 17, 'D', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4161, 7, 4130, 18, 'D', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4150, 9, 4256, 10, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4256, 10, 4255, 11, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4255, 11, 4240, 12, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4240, 12, 4135, 19, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4130, 8, 4150, 9, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4130, 13, 4150, 9, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4130, 14, 4150, 9, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4130, 15, 4150, 9, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4130, 16, 4150, 9, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4130, 17, 4150, 9, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4130, 18, 4150, 9, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4135, 19, 4012, 20, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4012, 20, 4013, 21, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4013, 21, 4222, 22, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4222, 22, 4223, 23, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4223, 23, 2224, 24, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 2224, 24, 4217, 25, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4217, 25, 28538, 26, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 28538, 26, 4219, 27, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4219, 27, 4220, 28, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4220, 28, 4221, 29, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4221, 29, 28534, 30, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 28534, 30, 28535, 31, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 28535, 31, 28539, 32, 'S', NULL, 'N')
go

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4002, 28539, 32, 28540, 33, 'S', NULL, 'N')
GO

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4002, 28540, 33, 4224, 34, 'S', NULL, 'N')
GO

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4224, 34, 4225, 35, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4225, 35, 4249, 36, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4249, 36, 4016, 37, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4016, 37, 4131, 38, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4131, 38, 4132, 39, 'S', NULL, 'N')
go

insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (4002, 4132, 39, 4260, 40, 'S', NULL, 'N')
go

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4002, 4260, 40, 0, 0, 'S', NULL, 'N')
GO

---------------------------------------------------------------------------------------------------------------
--SARTA EVENTUAL PARA AUTORIZACION DE PRODUCTOS BANCARIOS------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
use cobis
go
delete from cobis..ba_sarta where sa_sarta in (4003)
go
declare @w_usuario varchar(64)       

select @w_usuario = 'operador'

insert into cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
values (4003, 'EVENTUAL AHORROS', 'EVENTUAL AHORROS', '2016-07-21 12:00:00.733', @w_usuario, 4, NULL, NULL)

delete ba_batch where ba_batch in (4261, 4276)
go
declare @w_servidor   varchar(30), @w_path_fuente varchar(50), @w_path_destino  varchar(50)

select @w_servidor = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and pa_nemonico = 'SRVR'

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 4

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/ahorros/listados/')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 4

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/data/objetos')

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4261, 'PROCESO PARA AUTORIZAR PRODUCTO POR OFICIN', 'PROCESO PARA AUTORIZAR PRODUCTO POR OFICIN', 'SP', getdate(), 4, 'P', 1, 'cob_remesas..pe_oficina_autorizada', NULL, 'cob_ahorros..sp_aut_prod_ofi', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (4276, 'PROCESO MASIVO DE TRANSACCIONES DE DEPOSITO, RETIRO, ND Y NC', 'PROCESO MASIVO DE TRANSACCIONES DE DEPOSITO, RETIRO, ND Y NC CARGADAS DESDE UN ARCHIVO PLANO', 'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES', NULL, 'cob_ahorros..sp_pro_mas_tran', 50, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
go

delete from cobis..ba_sarta_batch where sb_sarta in (4003)
go

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4003, 4261, 1, null, 'S', 'N', 465, 600, 4003, 'S')

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (4003, 4276, 2, null, 'S', 'N', 1965, 600, 4003, 'S')
go


delete FROM cobis..ba_parametro WHERE pa_sarta in (4003) 
                                  AND pa_batch in (4261, 4276)
delete FROM cobis..ba_parametro WHERE pa_batch in (4261, 4276) and  pa_sarta in (0) 
go					
	
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 1, 'PRODUCTO BANCARIO', 'I', '0')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 2, 'FECHA', 'D', getDate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4261, 0, 3, 'OFICINA', 'I', '0')


INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 2, 'FECHA_PROCESO', 'D', getDate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 3, 'RUTA_ARCHIVOS', 'C', 'C:/Cobis/vbatch/ahorros/listados/')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 4, 'NOMBRE_ARCHIVO_TRAN', 'C', '12312016_OFI_TRAN.txt')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4276, 0, 5, 'NOMBRE_ARCHIVO_CHQ', 'C', '12312016_OFI_CHQ.txt')

--4003
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4261, 1, 1, 'PRODUCTO BANCARIO', 'I', '4')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4261, 1, 2, 'FECHA', 'D', getDate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4261, 1, 3, 'OFICINA', 'I', '7036')


INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 2, 'FECHA_PROCESO', 'D', getDate())

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 3, 'RUTA_ARCHIVOS', 'C', 'C:/Cobis/vbatch/ahorros/listados/')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 4, 'NOMBRE_ARCHIVO_TRAN', 'C', '12312016_OFI_TRAN.txt')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4003, 4276, 2, 5, 'NOMBRE_ARCHIVO_CHQ', 'C', '12312016_OFI_CHQ.txt')

go

delete from cobis..ba_enlace where en_sarta=4003
go

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4003, 4261, 1, 4276, 2, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4003, 4276, 2, 0, 0, 'S', NULL, 'N')

go


use cobis
go

DELETE  FROM cobis..ba_batch where  ba_batch = 4389
DELETE  FROM cobis..ba_parametro WHERE pa_sarta = 4007 and pa_batch = 4389
DELETE  FROM cobis..ba_parametro WHERE pa_batch = 4389 and pa_sarta = 0 
DELETE  FROM cobis..ba_sarta_batch WHERE sb_sarta = 4007
DELETE  FROM cobis..ba_enlace WHERE en_sarta = 4007
DELETE  FROM cobis..ba_sarta WHERE sa_sarta = 4007

declare @w_servidor   varchar(30), @w_path_fuente varchar(50), @w_path_destino  varchar(50)

select @w_servidor = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and pa_nemonico = 'SRVR'

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 4

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/ahorros/listados/')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 4

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/data/objetos')


declare @w_usuario varchar(64)       

select @w_usuario = 'admuser'

print 'Ingresando --ba_SARTA'
INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4007, 'GENERACION REPORTES OPERATIVOS AHO', 'GENERACION REPORTES OPERATIVOS AHO', getdate(), @w_usuario, 4, NULL, NULL)

print 'Ingresando --ba_batch'
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4389, 'GENERACION DE REPORTE OPERATIVO CTAS AHORROS', 'GENERACION DE REPORTE OPERATIVO CTAS AHORROS', 'SP', getdate(), 4, 'P', 1, 'REPORTE DE CTAS AHORROS', NULL, 'cob_ahorros..sp_reporte_cuenta_ah', 30, NULL, @w_servidor, 'S', @w_path_fuente,@w_path_destino)


print 'Ingresando --ba_parametro'

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4389, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4389, 0, 2, 'FECHA_PROCESO', 'D', '01/01/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4007, 4389, 1, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4007, 4389, 1, 2, 'FECHA_PROCESO', 'D', '01/01/2016')

print 'Ingresando --ba_sarta_batch'

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4007, 4389, 1, NULL, 'S', 'N', 500, 550, 4007, 'S')

print 'Ingresando --ba_enlace'

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4007, 4389, 1, 0, 0, 'S', NULL, 'N')
go



                                               