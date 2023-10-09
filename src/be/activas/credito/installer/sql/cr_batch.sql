use cobis
go

--Producto
DELETE cobis..cl_producto WHERE pd_producto IN (7,21)
INSERT INTO cobis..cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
VALUES (7, 'R', 'CARTERA', 'CCA', getdate(), 'V', 0, 0)
GO

INSERT INTO cobis..cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
VALUES (21, 'R', 'CREDITO', 'CRE', getdate(), 'V', NULL, NULL)
GO

--Path Producto
DELETE cobis..ba_path_pro WHERE pp_producto IN (7,21)
INSERT INTO cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
VALUES (7, 'C:/Cobis/vbatch/cartera/objetos/', 'C:/Cobis/vbatch/cartera/listados/')
GO

INSERT INTO cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
VALUES (21, 'C:/Cobis/vbatch/credito/objetos/', 'C:/Cobis/vbatch/credito/objetos/')
GO

--FechaCierre  
DELETE cobis..ba_fecha_cierre WHERE fc_producto IN (7,21)
      
INSERT INTO cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
VALUES (7, getdate(), NULL)
GO         

INSERT INTO cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
VALUES (21, getdate(), NULL)
GO        
        
declare @w_servidor varchar(20),
        @w_path_fuente varchar(100),
        @w_path_destino varchar(100)
      
select @w_servidor = pa_char
   from cobis..cl_parametro
   where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

--Sarta
DELETE cobis..ba_sarta WHERE sa_sarta in (21006, 21301)

INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (21006, 'PROCESOS DIARIOS CREDITO - CARTERA - AHORROS - REPOSITORIO', 'PROCESOS DIARIOS CREDITO - CARTERA - AHORROS - REPOSITORIO - GARANTIAS', getdate(), 'operador', 21, NULL, NULL)

insert into cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion) 
values (21301, 'CIERRE PRELIMINAR', 'CIERRE PRELIMINAR', getdate(), 'operador', 21, NULL, NULL)

---------------------------------------------
--Batch
---------------------------------------------
DELETE cobis..ba_batch where ba_batch in (4234,   7006,   7074,   21042,   21220,   21441,   28536,   28537,  28541,
                                          4053,   3363,   4133,   4237,    4236,    4257,    4161,    4130,   4150,   4256, 
                                          4255,   4240,   4135,   4012,    4013,    4222,    4223,    2224,   4217,   28538,
                                          4219,   4220,   4221,   28534,   28535,   28539,   28540,   19064,  28790,  28791,  28792,
                                4224,   4225,   4249,   4016,    4131,    4132,    4260,
                                7003,   7004,   7063,   7065,    21887,   21888,    14009,21007 
                                         )

---------------------------------------------

SELECT @w_path_fuente = isnull(pp_path_fuente,'C:/Cobis/vbatch/clientes/objetos/'),
       @w_path_destino = isnull(pp_path_destino,'C:/Cobis/vbatch/clientes/listados/')
FROM ba_path_pro WHERE pp_producto = 2

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2224, 'CONSOLIDADOR CLIENTES',                                        'CONSOLIDADOR CLIENTES',                                        'SP', getdate(), 4, 'P', 1, 'CLIENTES',                             null,                  'cobis..sp_cons_cliente',                      1000, null, @w_servidor, 'S', @w_path_fuente, null           )


select   
@w_path_destino = isnull(pp_path_destino, 'C:/Cobis/vbatch/ahorros/listados/'),
@w_path_fuente = isnull(pp_path_fuente, 'C:/Cobis/vbatch/ahorros/objetos/')
from ba_path_pro where pp_producto = 4

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4053, 'CREACION TABLAS TEMPORALES DE PERSONALIZACION', 'CREACION TABLAS TEMPORALES DE PERSONALIZACION', 'SP', getdate(), 4, 'P', 1, 'TABLAS TEMPORALES', 'person.lis', 'cob_ahorros..sp_crea_tem_person', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (3363, 'TRASLADO NETO BANREPUBLICA',                                   'TRASLADO NETO BANREPUBLICA',                                   'SP', getdate(), 4, 'P', 1, 'CAMARA',                              null,                   'cob_remesas..sp_tras_neto_br',                1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4133, 'INICIALIZACION DE TABLAS TEMPORALES',                          'INICIALIZACION DE TABLAS TEMPORALES',                          'SP', getdate(), 4, 'P', 1, 'TABLAS DE INICIO DEL PROCESO DIARIO', null,                    'cob_ahorros..sp_ah_ahinitbl',                1000, null, @w_servidor, 'N', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4237, 'EFECTIVIZACION CANJE CUENTAS DE AHORRO', 'EFECTIVIZACION CANJE CUENTAS DE AHORRO',                                             'SP', getdate(), 4, 'P', 1, 'CUENTA',                              null,          'cob_ahorros..sp_update_efectiah_batch',                         100, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4236, 'INMOVILIZACION DE CUENTAS DE AHORRO', 'INMOVILIZAICON DE CUENTAS DE AHORRO(180)',                                              'SP', getdate(), 4, 'P', 1, 'CUENTAS',                             null,                  'cob_ahorros..sp_ah_inmoviliza',                                1000, null, @w_servidor, 'S', @w_path_fuente, null)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4257, 'CIERRE AUTOMATICO DE CUENTAS DE AHORROS SIN DEPOSITO INICIAL', 'CIERRE AUTOMATICO DE CUENTAS DE AHORROS SIN DEPOSITO INICIAL', 'SP', getdate(), 4, 'P', 1, 'MAESTRO DE CUENTAS DE AHORRO',        null,           'cob_ahorros..sp_valida_tiempo_activa',       1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4161, 'VALIDACION ANTES DEL CALCULO DE INTERESES AHORROS',            'VALIDACION ANTES DEL CALCULO DE INTERESES AHORROS',            'SP', getdate(), 4, 'P', 1, '',                          'ahvaltmp.lis',                       'cob_ahorros..sp_ahvaltmp',                   1000, null, @w_servidor, 'N', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4130, 'PROVISION INTERES',                                            'PROVISION INTERES',                                            'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS',                  null,                      'cob_ahorros..sp_ahmensual',                  1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4150, 'GENERACION DE SALDOS DIARIOS',                                 'GENERACION DE SALDOS DIARIOS',                                 'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS',                  null,                'cob_ahorros..sp_ah_saldo_diario',            1000, null, @w_servidor, 'N', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4256, 'CUMPLIMIENTO CUENTAS ESPECIALES',                              'CUMPLIMIENTO CUENTAS ESPECIALES CC_286',                       'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS',        'reportes.lis',                'cob_ahorros..sp_mto_ahorro_plan',            1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4255, 'REPORTE SEGUIMIENTO CUENTAS CON CUMPLIMIENTO',                 'REPORTE SEGUIMIENTO CUENTAS CON CUMPLIMIENTO CC_286',          'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORROS','cumplimientos_aammdd',             'cob_ahorros..sp_reporte_seguimiento',        1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4240, 'REPORTE ERRORES BATCH',                                        'REPORTE ERRORES BATCH',                                        'SP', getdate(), 4, 'P', 1, 'AH_ERRORLOG',                         'aherrbatch.lis',       'cob_ahorros..sp_aherrbatch',                              1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4135, 'PASO DE DATOS A TABLAS TEMPORALES',                            'PASO DE DATOS A TABLAS TEMPORALES',                            'SP', getdate(), 4, 'P', 1, 'CUENTAS Y MOVIMIENTOS',               null,                   'cob_ahorros..sp_tablas_temp',                  10, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4012, 'PASO A HISTORICO DE TRANSACCIONES MONETARIAS (AHORROS)',       'PASO A HISTORICO DE TRANSACCIONES MONETARIAS (AHORROS)',       'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES MONETARIAS',            null,                   'cob_ahorros..sp_ah_his_mon',                1000, null, @w_servidor, 'N', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4013, 'PASO A HISTORICO DE TRANSACCIONES DE SERVICIO (AHORROS)',      'PASO A HISTORICO DE TRANSACCIONES DE SERVICIO (AHORROS)',      'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES DE SERVICIO',           null,                   'cob_ahorros..sp_ahhisser',                1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4222, 'TOTALIZADOR TRANSACCIONES MONETARIAS AHORROS',                 'TOTALIZADOR TRANSACCIONES MONETARIAS AHORROS',                 'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES MONETARIAS',            null,                   'cob_ahorros..sp_totaliza_tran_mon_ah',       1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4223, 'TOTALIZADOR TRANSACCIONES DE SERVICIO AHORROS',                'TOTALIZADOR TRANSACCIONES DE SERVICIO AHORROS',                'SP', getdate(), 4, 'P', 1, 'TRANSACCIONES DE SERVICIO',           null,                   'cob_ahorros..sp_totaliza_tran_serv_ah',      1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4217, 'GENERACION DE DATA SALDOS PARA REC - COB_EXTERNOS',            'GENERACION DE DATA SALDOS PARA REC - COB_EXTERNOS',            'SP', getdate(), 4, 'P', 1, 'CUENTAS MOVIMIENTOS Y BLOQUEOS',      null,                   'cob_ahorros..sp_datos_pasivas_rec',            10, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4219, 'GENERACION DE DATA MOVIMIENTOS PARA REC - COB_EXTERNOS',       'GENERACION DE DATA MOVIMIENTOS PARA REC - COB_EXTERNOS',       'SP', getdate(), 4, 'P', 1, 'MOVIMIENTOS',                         null,                   'cob_ahorros..sp_datos_mov_rec',                10, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4220, 'GENERACION DE DATA BLOQUEOS PARA REC - COB_EXTERNOS',          'GENERACION DE DATA BLOQUEOS PARA REC - COB_EXTERNOS',          'SP', getdate(), 4, 'P', 1, 'BLOQUEOS',                            null,                   'cob_ahorros..sp_datos_bloq_rec',               10, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4221, 'GENERACION DE DATA TITULARES PARA REC - COB_EXTERNOS',         'GENERACION DE DATA TITULARES PARA REC - COB_EXTERNOS',         'SP', getdate(), 4, 'P', 1, 'CLIENTES',                            null,                   'cob_ahorros..sp_datos_deudores_rec',           10, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4224, 'GENERADOR DE COMPROBANTES AHORROS',                            'GENERADOR DE COMPROBANTES AHORROS',                            'SP', getdate(), 4, 'P', 1, 'COMPROBANTES',                        null,                   'cob_ahorros..sp_conta',                      1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4225, 'VALIDA COMPROBANTES AHORROS',                                  'VALIDA COMPROBANTES AHORROS',                                  'SP', getdate(), 4, 'P', 1, 'COMPROBANTES',                        null,                   'cob_ahorros..sp_ah_generacion_contabilidad',   10, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4249, 'ARCHIVO PLANO DE SALDOS DE CUENTAS DE AHORROS',                'ARCHIVO PLANO DE SALDOS DE CUENTAS DE AHORROS',                'SP', getdate(), 4, 'P', 1, 'AHORROS',                             'saldoscta.lis',        'cob_ahorros..sp_saldos_plano_ah',             1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4016, 'GENERACION DE ah_consolidado',                                 'GENERACION DE ah_consolidado LLS_113',                         'SP', getdate(), 4, 'P', 1, 'CUENTAS',                             null,                   'cob_ahorros..sp_consolida',                  1000, null, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4131, 'GENERACION DE CABECERAS DE ESTADOS DE CUENTA DE AHORROS',      'GENERACION DE CABECERAS DE ESTADOS DE CUENTA DE AHORROS',      'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORRO',                   null,                   'cob_ahorros..sp_estado_cuenta_ah',           1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4132, 'GENERACION DE ESTADOS DE CUENTA MASIVOS DE AHORROS',      'GENERACION DE ESTADOS DE CUENTA MASIVOS DE AHORROS',      'SP', getdate(), 4, 'P', 1, 'CUENTAS DE AHORRO',                   null,                   'cob_ahorros..sp_est_cta_masivo_ah',           1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4260, 'ACTUALIZACION DE ESTADOS CUENTA DE AHORROS', 'ACTUALIZACION DE ESTADOS CUENTA DE AHORROS', 'SP', getdate(), 4, 'P', 1, 'jar-with-dependencies.jar', NULL, 'cob_ahorros..sp_ejecuta_jar', 1000, NULL, @w_servidor, 'S', 'C:/java/', NULL)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4234, 'TOTALIZADOR TRANSACCIONES CAUSACION AHORROS - SEMANAL', 'TOTALIZADOR TRANSACCIONES CAUSACION AHORROS - SEMANAL', 'SP', '2014-07-03', 4, 'P', 1, 'AH_HIS_SERVICIO', NULL, 'cob_ahorros..sp_totaliza_tran_serv_ah_per', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)


SELECT @w_path_fuente = isnull(pp_path_fuente,'C:/Cobis/vbatch/cartera/objetos/'),
       @w_path_destino = isnull(pp_path_destino,'C:/Cobis/vbatch/cartera/listados/')
FROM ba_path_pro WHERE pp_producto = 7

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7006, 'CONSOLIDADOR CARTERA', 'CONSOLIDADOR CARTERA', 'SP', '2009-05-16', 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_consolidador', 1, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7074, 'TRASLADO MASIVO DE CARTERA ENTRE OFICINAS', 'TRASLADO MASIVO DE CARTERA ENTRE OFICINAS', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_traslada_cartera_ext', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7003, 'CONTABILIDAD GENERAR UNIVERSO', 'CONTABILIDAD GENERAR UNIVERSO', 'SP', '2009-05-16', 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_caconta', 1, NULL, @w_servidor, 'S', @w_path_fuente, NULL)
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7004, 'CONTABILIDAD', 'CONTABILIDAD', 'SP', '2009-05-16', 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_caconta', 1, NULL, @w_servidor, 'S', @w_path_fuente, NULL)
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7063, 'CONTABILIDAD CAUSACION PRV''S', 'CONTABILIDAD CAUSACION PRV''S', 'SP', '2009-07-21', 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_caconta_prv', 1, NULL, @w_servidor, 'S', @w_path_fuente, NULL)
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7065, 'CONTABILIZADAS CON ERROR, CAMBIO DE ESTADO A ING', 'CONTABILIZADAS CON ERROR, CAMBIO DE ESTADO A ING', 'SP', '2009-08-06', 7, 'P', 1, 'CA_TRANSACCION', NULL, 'cob_cartera..sp_trn_ing_ca', 1, NULL, @w_servidor, 'S', @w_path_fuente, NULL)


SELECT @w_path_fuente = isnull(pp_path_fuente,'C:/Cobis/vbatch/credito/objetos/'),
       @w_path_destino = isnull(pp_path_destino,'C:/Cobis/vbatch/credito/listados/')
FROM ba_path_pro WHERE pp_producto = 21

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21042, '(CRE) GENERACION DE DATOS DEL CONSOLIDADOR', '(CRE) GENERACION DE DATOS DEL CONSOLIDADOR', 'SP', getdate(), 21, 'P', 1, 'OPERACIONES (EX_DATO_TRAMITE', NULL, 'cob_credito..sp_consolidador', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21220, 'AJUSTE DE SALDOS DE FUENTE DE RECURSO', 'AJUSTE DE SALDOS DE FUENTE DE RECURSO', 'SP', getdate(), 21, 'P', 1, 'SALDOS FUENTE DE RECURSOS', NULL, 'cob_credito..sp_aju_fuente_rec', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21441, 'CONSOLIDACION DATOS ENDEUDAMIENTO', 'CONSOLIDACION DATOS ENDEUDAMIENTO', 'SP', getdate(), 21, 'P', 1, 'OPERACIONES', NULL, 'cob_credito..sp_actualiza_sb', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into dbo.ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (36008, 'GENERACION DE REPORTE CFDI-SAT', 'GENERACION DE REPORTE CFDI-SAT', 'SP', getdate(), 21, 'P', 1, null, 'CFDI_[CODCLI]_[FECHA].xml', 'cob_credito..sp_genera_estado_cta_xml', 10000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into dbo.ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (36009, 'MOVIMIENTO ARCHIVOS PARA ESTADO CTA', 'NOTIFICACION ESTADO DE CTA', 'SP', getdate(), 21, 'P', 1, null, 'CFDI_[CODCLI]_[FECHA].xml', 'cob_credito..sp_cr_ejecuta_move_jar', 10000, NULL, @w_servidor, 'S', @w_path_destino + 'estcta/', @w_path_destino + 'estctagen/')
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino) 
VALUES(21007 , '(CRE) PASO HISTORICO BURO', 'PASO HISTORICO BURO', 'SP', getdate(), 21,  'P', 1, 'BURO',           null,'cob_credito..sp_paso_buro_historico', 1,null, @w_servidor, 'S',  @w_path_fuente, null)

SELECT @w_path_fuente = isnull(pp_path_fuente,'C:/Cobis/vbatch/Regulatorios/objetos/'),
       @w_path_destino = isnull(pp_path_destino,'C:/Cobis/vbatch/Regulatorios/listados/')
FROM ba_path_pro WHERE pp_producto = 36

INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28534, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER (DT)', 'SP', getdate(), 4, 'P', 1, 'OPERACION',               null,                   'cob_conta_super..sp_datos_operacion',         1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28535, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER PY', 'SP', getdate(), 4, 'P', 1, 'OPERACION',               null,                   'cob_conta_super..sp_datos_operacion',         1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28538, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'SP', getdate(), 4, 'P', 1, 'OPERACION',                    null,                   'cob_conta_super..sp_dato_pasivas',            1000, null, @w_servidor, 'S', @w_path_fuente, null           )
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28539, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER - CLIENTES "CL"', 'SP', getdate(), 4, 'R', 1, 'OPERACIONES',  'dataope.lis',          'cob_conta_super..sp_datos_operacion',         1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28540, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER - DEUDORES "CL"', 'SP', getdate(), 4, 'R', 1, 'OPERACIONES',  'dataope.lis',          'cob_conta_super..sp_datos_operacion',         1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28536, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER DD', 'SP', getdate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_datos_operacion', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28537, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASODE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER DO', 'SP', getdate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_datos_operacion', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28541, 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS COB_EXTERNOS A TABLAS DEFINITIVAS COB_CONTA_SUPER - COBRANZA "DC"', 'SP',getdate(), 36, 'R', 1, 'OPERACIONES', 'dataope.lis', 'cob_conta_super..sp_datos_operacion', 1000, 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (19064, 'GENERACION DATOS GARANTIAS', 'GENERACION DATOS GARANTIAS', 'SP', getdate(), 19, 'P', 1, 'GARANTIAS', NULL, 'cob_custodia..sp_garantias_externo', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28790, 'PASO DE DATOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'PASO DE DATOS A TABLAS DEFINITIVAS COB_CONTA_SUPER', 'SP', getdate(), 36, 'P', 1, 'REC', NULL, 'cob_conta_super..sp_datos_operacion_mes', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28791, 'GENERACION DE ESTADOS DE CUENTA MASIVOS DE CARTERA', 'GENERACION DE ESTADOS DE CUENTA MASIVOS DE CARTERA', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_ca_ejecuta_jar', 1000, NULL, @w_servidor, 'S', @w_path_fuente, NULL)  
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28792, 'GENERACION DE ESTADOS CUENTA DE CARTERA', 'GENERACION DE ESTADOS CUENTA DE CARTERA', 'SP', getdate(), 7, 'P', 1, 'jar-with-dependencies.jar', NULL, 'cob_cartera..sp_ca_ejecuta_jar', 1000, NULL, @w_servidor, 'S', 'C:/java/', NULL) 


SELECT @w_path_fuente = isnull(pp_path_fuente,'C:/Cobis/vbatch/PFijo/objetos/'),
       @w_path_destino = isnull(pp_path_destino,'C:/Cobis/vbatch/PFijo/listados/')
FROM ba_path_pro WHERE pp_producto = 14

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (14009, 'REC', 'REC', 'SP', getdate(), '14', 'R', '1', '', 'texto.lis', 'cob_pfijo..sp_consolidador', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)

-- Sarta 21301 -------------------------------------------
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino) 
VALUES (21887, 'CALIFICACION GENERAL', 'CALIFICACION GENERAL', 'SP', getdate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_calificacion_gral', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino) 
VALUES (21888, 'PROCESO DE PROVISIONES', 'PROCESO DE PROVISIONES', 'SP', getdate(), 36, 'P', 1, 'OPERACION', NULL, 'cob_conta_super..sp_calculo_provision', 1000, NULL, @w_servidor, 'S', @w_path_fuente, @w_path_destino)


GO



---------------------------------------------
--Sarta_Batch
---------------------------------------------


DELETE ba_sarta_batch WHERE sb_sarta in (21006, 21301)

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4053, 1, NULL, 'S', 'N', 50, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 3363, 2, NULL, 'S', 'N', 950, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4133, 3, NULL, 'S', 'N', 1850, 1050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4237, 4, NULL, 'S', 'N', 2750, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4236, 5, NULL, 'S', 'N', 3650, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4257, 6, NULL, 'S', 'N', 4550, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4161, 7, NULL, 'N', 'N', 5450, 1050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4130, 8, 7, 'S', 'N', 6500, 50, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4150, 9, NULL, 'N', 'N', 7500, 1050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4256, 10, NULL, 'S', 'N', 8500, 50, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4255, 11, NULL, 'S', 'N', 9500, 50, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4240, 12, NULL, 'S', 'N', 10500, 50, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4130, 13, 7, 'S', 'N', 6500, 1050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4130, 14, 7, 'S', 'N', 6500, 2050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4130, 15, 7, 'S', 'N', 6500, 3050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4130, 16, 7, 'S', 'N', 6500, 4050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4130, 17, 7, 'S', 'N', 6500, 5050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4130, 18, 7, 'S', 'N', 6500, 6050, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4135, 19, NULL, 'S', 'N', 11500, 50, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4012, 20, NULL, 'N', 'N', 12500, 50, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4013, 21, NULL, 'S', 'N', 13500, 50, 21006, 'N')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4222, 22, NULL, 'S', 'N', 14500, 50, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4223, 23, NULL, 'S', 'N', 14500, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 2224, 24, NULL, 'S', 'N', 13500, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4217, 25, NULL, 'S', 'N', 12500, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28538, 26, NULL, 'S', 'N', 12510, 4095, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4219, 27, NULL, 'S', 'N', 11475, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4220, 28, NULL, 'S', 'N', 10470, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4221, 29, NULL, 'S', 'N', 9480, 1050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28534, 30, NULL, 'S', 'N', 8430, 4050, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28535, 31, NULL, 'S', 'N', 9480, 4035, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28539, 32, NULL, 'S', 'N', 13560, 4125, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28540, 33, NULL, 'S', 'N', 14535, 4080, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4224, 34, NULL, 'S', 'N', 8505, 1065, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4225, 35, NULL, 'S', 'N', 8550, 2040, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4249, 36, NULL, 'S', 'N', 9510, 2055, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4016, 37, NULL, 'S', 'N', 10470, 2040, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4131, 38, NULL, 'S', 'N', 12495, 2010, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4132, 39, NULL, 'S', 'N', 13485, 2025, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4260, 40, NULL, 'S', 'N', 14520, 2025, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 4234, 41, NULL, 'S', 'N', 14550, 3060, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 7006, 42, NULL, 'S', 'N', 13545, 3045, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 7074, 43, NULL, 'S', 'N', 12525, 3045, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 21042, 44, NULL, 'S', 'N', 11535, 3060, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 21220, 45, NULL, 'S', 'N', 10560, 3045, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 21441, 46, NULL, 'S', 'N', 9510, 3015, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28536, 47, NULL, 'S', 'N', 10545, 4035, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28537, 48, NULL, 'S', 'N', 11595, 4020, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28541, 49, NULL, 'S', 'N', 14580, 5040, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 19064, 50, NULL, 'S', 'N', 8490, 3000, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28790, 51, NULL, 'S', 'N', 13560, 5040, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28791, 52, NULL, 'S', 'N', 12510, 5055, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 28792, 53, NULL, 'S', 'N', 11550, 5070, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 7003, 54, NULL, 'S', 'N', 10485, 5115, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 7004, 55, NULL, 'S', 'N', 9480, 5100, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 7063, 56, NULL, 'S', 'N', 8445, 5145, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 7065, 57, NULL, 'S', 'N', 8475, 6105, 21006, 'S')

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (21006, 14009, 58, NULL, 'S', 'N', 11490, 1995, 21006, 'S')
GO
/*-- 4002 -------------------------------------------
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4053,  1,  NULL, 'S', 'N', 50,    1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 3363,  2,  NULL, 'S', 'N', 950,   1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4133,  3,  NULL, 'S', 'N', 1850,  1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4237,  4,  null, 'S', 'N', 2750,  1050, 21006, 'S')  
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4236,  5,  null, 'S', 'N', 3650,  1050, 21006, 'S')  
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4257,  6,  NULL, 'S', 'N', 4550,  1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4161,  7,  NULL, 'N', 'N', 5450,  1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4130,  8,  7,    'S', 'N', 6500,  50,   21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4130,  13, 8,    'S', 'N', 6500,  1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4130,  14, 13,   'S', 'N', 6500,  2050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4130,  15, 14,   'S', 'N', 6500,  3050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4130,  16, 15,   'S', 'N', 6500,  4050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4130,  17, 16,   'S', 'N', 6500,  5050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4130,  18, 17,   'S', 'N', 6500,  6050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4150,  9,  NULL, 'N', 'N', 7500,  1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4256,  10, NULL, 'S', 'N',  8500, 50,   21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4255,  11, NULL, 'S', 'N',  9500, 50,   21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4240,  12, NULL, 'S', 'N', 10500, 50,   21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4135,  19, NULL, 'S', 'N', 11500, 50,   21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4012,  20, NULL, 'N', 'N', 12500, 50,   21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4013,  21, NULL, 'S', 'N', 13500, 50,   21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4222,  22, NULL, 'S', 'N', 14500, 50,   21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4223,  23, NULL, 'S', 'N', 14500, 1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 2224,  24, NULL, 'S', 'N', 13500, 1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4217,  25, NULL, 'S', 'N', 12500, 1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28538, 26, NULL, 'S', 'N', 11500, 1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4219,  27, NULL, 'S', 'N', 10500, 1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4220,  28, NULL, 'S', 'N',  9500, 1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4221,  29, NULL, 'S', 'N',  8500, 1050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28534, 30, NULL, 'S', 'N',  8500, 2050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28535, 31, NULL, 'S', 'N',  9500, 2050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28539, 32, NULL, 'S', 'N', 10500, 2050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28540, 33, NULL, 'S', 'N', 11500, 2050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4224,  34, NULL, 'S', 'N', 12500, 2050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4225,  35, NULL, 'S', 'N', 13500, 2050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4249,  36, NULL, 'S', 'N', 14500, 2050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4016,  37, NULL, 'S', 'N', 14500, 3050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4131,  38, NULL, 'S', 'N', 13500, 3050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4132,  39, NULL, 'S', 'N', 12500, 3050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4260,  40, NULL, 'S', 'N', 11500, 3050, 21006, 'S')
-- super sarta -------------------------------------------
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 4234,  41, NULL, 'S', 'N',  8500, 4050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 7006,  42, NULL, 'S', 'N',  9500, 4050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 7074,  43, NULL, 'S', 'N', 10500, 4050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 21042, 44, NULL, 'S', 'N', 11500, 4050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 21220, 45, NULL, 'S', 'N', 12500, 4050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 21441, 46, NULL, 'S', 'N', 13500, 4050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28536, 47, NULL, 'S', 'N', 14500, 4050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28537, 48, NULL, 'S', 'N', 14500, 5050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28541, 49, NULL, 'S', 'N', 13500, 5050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 19064, 50, NULL, 'S', 'N', 12500, 5050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28790, 51, NULL, 'S', 'N', 11500, 5050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28791, 52, NULL, 'S', 'N', 10500, 5050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 28792, 53, NULL, 'S', 'N', 9500,  5050, 21006, 'S')
-- conta cartera -------------------------------------------
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 7003,  54, NULL, 'S', 'N',  8500, 6050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 7004,  55, NULL, 'S', 'N',  9500, 6050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 7063,  56, NULL, 'S', 'N', 10500, 6050, 21006, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21006, 7065,  57, NULL, 'S', 'N', 11500, 6050, 21006, 'S')
*/
-- sarta 21301 -------------------------------------------
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21301, 21887, 1, NULL, 'S', 'N', 500, 550, 21301, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) VALUES (21301, 21888, 2, NULL, 'S', 'N', 2000, 550, 21301, 'S')

GO 
 
 
---------------------------------------------
--Enlace
---------------------------------------------

DELETE cobis..ba_enlace WHERE en_sarta in (21006, 21301)
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4053, 1, 3363, 2, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 3363, 2, 4133, 3, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4133, 3, 4237, 4, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4237, 4, 4236, 5, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4236, 5, 4257, 6, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4257, 6, 4161, 7, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4161, 7, 4130, 8, 'D', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4161, 7, 4130, 13, 'D', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4161, 7, 4130, 14, 'D', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4161, 7, 4130, 15, 'D', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4161, 7, 4130, 16, 'D', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4161, 7, 4130, 17, 'D', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4161, 7, 4130, 18, 'D', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4130, 8, 4150, 9, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4150, 9, 4256, 10, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4256, 10, 4255, 11, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4255, 11, 4240, 12, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4240, 12, 4135, 19, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4130, 13, 4150, 9, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4130, 14, 4150, 9, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4130, 15, 4150, 9, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4130, 16, 4150, 9, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4130, 17, 4150, 9, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4130, 18, 4150, 9, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4135, 19, 4012, 20, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4012, 20, 4013, 21, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4013, 21, 4222, 22, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4222, 22, 4223, 23, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4223, 23, 2224, 24, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 2224, 24, 4217, 25, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4217, 25, 4219, 27, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28538, 26, 28539, 32, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4219, 27, 4220, 28, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4220, 28, 4221, 29, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4221, 29, 4224, 34, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28534, 30, 28535, 31, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28535, 31, 28536, 47, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28539, 32, 28540, 33, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28540, 33, 28541, 49, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4224, 34, 4225, 35, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4225, 35, 4249, 36, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4249, 36, 4016, 37, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4016, 37, 14009, 58, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4131, 38, 4132, 39, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4132, 39, 4260, 40, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4260, 40, 4234, 41, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 4234, 41, 7006, 42, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 7006, 42, 7074, 43, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 7074, 43, 21042, 44, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 21042, 44, 21220, 45, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 21220, 45, 21441, 46, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 21441, 46, 19064, 50, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28536, 47, 28537, 48, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28537, 48, 28538, 26, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28541, 49, 28790, 51, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 19064, 50, 28534, 30, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28790, 51, 28791, 52, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28791, 52, 28792, 53, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 28792, 53, 7003, 54, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 7003, 54, 7004, 55, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 7004, 55, 7063, 56, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 7063, 56, 7065, 57, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 7065, 57, 0, 0, 'S', NULL, 'N')

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (21006, 14009, 58, 4131, 38, 'S', NULL, 'N')
GO
/*
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4053,  1,  3363,  2,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 3363,  2,  4133,  3,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4133,  3,  4237,  4,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4237,  4,  4236,  5,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4236,  5,  4257,  6,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4257,  6,  4161,  7,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4161,  7,  4130,  8,  'D', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4161,  7,  4130,  13, 'D', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4161,  7,  4130,  14, 'D', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4161,  7,  4130,  15, 'D', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4161,  7,  4130,  16, 'D', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4161,  7,  4130,  17, 'D', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4161,  7,  4130,  18, 'D', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4130,  8,  4150,  9,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4130,  13, 4150,  9,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4130,  14, 4150,  9,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4130,  15, 4150,  9,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4130,  16, 4150,  9,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4130,  17, 4150,  9,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4130,  18, 4150,  9,  'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4150,  9,  4256,  10, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4256,  10, 4255,  11, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4255,  11, 4240,  12, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4240,  12, 4135,  19, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4135,  19, 4012,  20, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4012,  20, 4013,  21, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4013,  21, 4222,  22, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4222,  22, 4223,  23, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4223,  23, 2224,  24, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 2224,  24, 4217,  25, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4217,  25, 28538, 26, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 28538, 26, 4219,  27, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4219,  27, 4220,  28, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4220,  28, 4221,  29, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4221,  29, 28534, 30, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 28534, 30, 28535, 31, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 28535, 31, 28539, 32, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 28539, 32, 28540, 33, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 28540, 33, 4224,  34, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4224,  34, 4225,  35, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4225,  35, 4249,  36, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4249,  36, 4016,  37, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4016,  37, 4131,  38, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4131,  38, 4132,  39, 'S', NULL, 'N')
insert into ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) values (21006, 4132,  39, 4260,  40, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 4260,  40, 4234,  41, 'S', NULL, 'N')
--------------------------------------------- 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 4234,  41, 7006,  42, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 7006,  42, 7074,  43, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 7074,  43, 21042, 44, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 21042, 44, 21220, 45, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 21220, 45, 21441, 46, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 21441, 46, 28536, 47, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 28536, 47, 28537, 48, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 28537, 48, 28541, 49, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 28541, 49, 19064, 50, 'S', NULL, 'N') 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 19064, 50, 28790, 51, 'S', NULL, 'N') 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 28790, 51, 28791, 52, 'S', NULL, 'N') 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 28791, 52, 28792, 53, 'S', NULL, 'N') 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 28792, 53, 7003,  54, 'S', NULL, 'N') 
--------------------------------------------- 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 7003,  54, 7004,  55, 'S', NULL, 'N') 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 7004,  55, 7063,  56, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 7063,  56, 7065,  57, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21006, 7065,  57, 0,     0,  'S', NULL, 'N')
*/
-- 21301 ------------------------------------------- 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21301, 21887, 1, 21888, 2, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) VALUES (21301, 21888, 2, 0, 0, 'S', NULL, 'N')

GO

 

---------------------------------------------
--Parametros
---------------------------------------------

DELETE cobis..ba_parametro WHERE pa_batch IN (2224,   4012,   4013,   4016,   4135,
                                              4217,   4219,   4220,   4221,   4222,
                                              4223,   4234,   7006,   7010,   7074,
                                              10005,  21006,  21042,  21220,  
                                              21441,  28534,  28535,  28536,  28537,
                                              28538,  28539,  28540,  28541,  19064,    28790,   28791,   28792,
                                              4053,   3363,   4133,   4237,    4236,    4257,    4161,    4130,   4150,   4256, 
                                              4255,   4240,   4135,   4012,    4013,    4222,    4223,    2224,   4217,   28538,
                                              4219,   4220,   4221,   28534,   28535,   28539,   28540,   4224,   4225,   4249, 
                                              4016,   4131,   4132,   4260,
                                              7003,   7004,   7063,   7065)
AND pa_sarta IN (0,21006)

DELETE cobis..ba_parametro WHERE pa_batch IN (21887,  21888)
AND pa_sarta IN (0,21301)


GO

declare @w_fecha_proceso varchar(10)
select @w_fecha_proceso = convert(varchar(10), fp_fecha, 103) from cobis..ba_fecha_proceso

declare @w_path_destino  varchar(50)
select   
@w_path_destino = isnull(pp_path_destino, 'C:/Cobis/vbatch/ahorros/listados/')
from ba_path_pro
where pp_producto = 4

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 3363,  0, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4133,  0, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4133,  0, 2, 'FECHA_ PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4237,  0, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4236,  0, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4161,  0, 1, 'FILIAL ', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4161,  0, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4161,  0, 3, 'RUTA_SALIDA', 'C', @w_path_destino)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4130,  0, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4130,  0, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4130,  0, 3, 'HIJO', 'C', '0')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4130,  0, 4, 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4255,  0, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4240,  0, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4240,  0, 2, 'FECHA_INICIAL', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4240,  0, 3, 'FECHA_FINAL', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4240,  0, 4, 'DIRECTORIO_SALIDA', 'C', @w_path_destino)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4012,  0, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4012,  0, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4013,  0, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4013,  0, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4222,  0, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4223,  0, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4217,  0, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 2224,  0, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28538, 0, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4219,  0, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4221,  0, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28534, 0, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28534, 0, 2, 'OPERACION_(TO/DO/DT/PY/DD)', 'C', 'DT')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28535, 0, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28535, 0, 2, 'OPERACION_(TO/DO/DT/PY/DD)', 'C', 'PY')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28539, 0, 1, 'FECHA_OPERACION', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28539, 0, 2, 'OPERACION', 'C', 'CL')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28540, 0, 1, 'FECHA_OPERACION', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 28540, 0, 2, 'OPERACION', 'C', 'DD')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4225,  0, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4249,  0, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4016,  0, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4131,  0, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4131,  0, 2, 'FECHA', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4132,  0, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4132,  0, 2, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(0, 4260,  0, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 3363,  2,  1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4133,  3,  1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4133,  3,  2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4237,  4,  1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4236,  5,  1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4161,  7,  1, 'FILIAL ', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4161,  7,  2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4161,  7,  3, 'RUTA_SALIDA', 'C', @w_path_destino)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  8,  1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  8,  2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  8,  3, 'HIJO', 'C', '0')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  8,  4, 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  13, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  13, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  13, 3, 'HIJO', 'C', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  13, 4, 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  14, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  14, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  14, 3, 'HIJO', 'C', '2')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  14, 4, 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  15, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  15, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  15, 3, 'HIJO', 'C', '3')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  15, 4, 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  16, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  16, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  16, 3, 'HIJO', 'C', '4')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  16, 4, 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  17, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  17, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  17, 3, 'HIJO', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  17, 4, 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  18, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  18, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  18, 3, 'HIJO', 'C', '999')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4130,  18, 4, 'HIJOS', 'C', '5')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4255,  11, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4240,  12, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4240,  12, 2, 'FECHA_INICIAL', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4240,  12, 3, 'FECHA_FINAL', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4240,  12, 4, 'DIRECTORIO_SALIDA', 'C', @w_path_destino)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4012,  20, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4012,  20, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4013,  21, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4013,  21, 2, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4222,  22, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4223,  23, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 2224,  24, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4217,  25, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28538, 26, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4219,  27, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4221,  29, 1, 'CORRESPONSAL', 'C', 'N')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28534, 30, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28534, 30, 2, 'OPERACION_(TO/DO/DT/PY/DD)', 'C', 'DT')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28535, 31, 1, 'FECHA_DE_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28535, 31, 2, 'OPERACION_(TO/DO/DT/PY/DD)', 'C', 'PY')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28539, 32, 1, 'FECHA_OPERACION', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28539, 32, 2, 'OPERACION', 'C', 'CL')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28540, 33, 1, 'FECHA_OPERACION', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 28540, 33, 2, 'OPERACION', 'C', 'DD')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4225,  35, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4249,  36, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4016,  37, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4131,  38, 1, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4131,  38, 2, 'FECHA', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4132,  39, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4132,  39, 2, 'FILIAL', 'I', '1')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values(21006, 4260,  40, 1, 'FECHA_PROCESO', 'D', @w_fecha_proceso)

---------------------------------------------

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 4234,  0, 1, 'FECHA DE PROCESO', 'D', '07/03/2014')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 21042, 0, 1, 'FECHA PROCESO', 'D', '06/01/2009')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 21441, 0, 1, 'FECHA', 'D', '06/30/2009')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 21441, 0, 2, 'FIN DE MES', 'C', 'N')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28536, 0, 1, 'FECHA DE PROCESO', 'D', '01/27/2010')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28536, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DD')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28537, 0, 1, 'FECHA DE PROCESO', 'D', '05/22/2009')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28537, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DO')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28541, 0, 1, 'FECHA PROCESO', 'D', '02/22/2010')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28541, 0, 2, 'OPERACION', 'C', 'DC')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 19064, 0, 1, 'FECHA PROCESO', 'D', @w_fecha_proceso)
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28790, 0, 1, 'FECHA PROCESO', 'D', @w_fecha_proceso)
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28790, 0, 2, 'OPERACION (TO=TODO VH=HECHOS VIOLENTOS CG=GARANTIAS', 'C', 'CG')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28791, 0, 1, 'OPERACION (I=INSERCION Q=QUERY', 'C', 'I')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28791, 0, 2, 'FECHA PROCESO', 'D', @w_fecha_proceso) 
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28792, 0, 1, 'OPERACION (I=INSERCION Q=QUERY', 'C', 'Q')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28792, 0, 2, 'FECHA PROCESO', 'D', @w_fecha_proceso) 

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 4234,  41, 1, 'FECHA DE PROCESO', 'D', '02/01/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 21042, 44, 1, 'FECHA PROCESO', 'D', '06/01/2009')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 21441, 46, 1, 'FECHA', 'D', '06/30/2009')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 21441, 46, 2, 'FIN DE MES', 'C', 'N')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28536, 47, 1, 'FECHA DE PROCESO', 'D', '01/27/2010')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28536, 47, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DD')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28537, 48, 1, 'FECHA DE PROCESO', 'D', '05/22/2009')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28537, 48, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DO')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28541, 49, 1, 'FECHA PROCESO', 'D', '02/22/2010')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28541, 49, 2, 'OPERACION', 'C', 'DC')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 19064, 50, 1, 'FECHA PROCESO', 'D', @w_fecha_proceso)
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28790, 51, 1, 'FECHA PROCESO', 'D', @w_fecha_proceso)
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28790, 51, 2, 'OPERACION (TO=TODO VH=HECHOS VIOLENTOS CG=GARANTIAS', 'C', 'CG')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28791, 52, 1, 'OPERACION (I=INSERCION Q=QUERY', 'C', 'I')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28791, 52, 2, 'FECHA PROCESO', 'D', @w_fecha_proceso) 
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28792, 53, 1, 'OPERACION (I=INSERCION Q=QUERY', 'C', 'Q')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 28792, 53, 2, 'FECHA PROCESO', 'D', @w_fecha_proceso) 

---------------------------------------------

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7003, 0, 1, 'HIJO', 'C', '7003')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7003, 0, 2, 'SARTA', 'C', '21006')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7003, 0, 3, 'BATCH', 'C', '7003')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7003, 0, 4, 'OPCION', 'C', 'G')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7003, 0, 5, 'BLOQUE', 'C', '0')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7004, 0, 1, 'HIJO', 'C', '7004')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7004, 0, 2, 'SARTA', 'C', '21006')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7004, 0, 3, 'BATCH', 'C', '7004')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7004, 0, 4, 'OPCION', 'C', 'B')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7004, 0, 5, 'BLOQUE', 'C', '2000')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7003, 54, 1, 'HIJO', 'C', '7003')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7003, 54, 2, 'SARTA', 'C', '21006')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7003, 54, 3, 'BATCH', 'C', '7003')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7003, 54, 4, 'OPCION', 'C', 'G')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7003, 54, 5, 'BLOQUE', 'C', '0')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7004, 55, 1, 'HIJO', 'C', '7004')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7004, 55, 2, 'SARTA', 'C', '21006')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7004, 55, 3, 'BATCH', 'C', '7004')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7004, 55, 4, 'OPCION', 'C', 'B')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21006, 7004, 55, 5, 'BLOQUE', 'C', '2000')

-- 21301 -------------------------------------------

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 21887, 0, 1, 'FECHA DE PROCESO', 'D', @w_fecha_proceso)
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 21887, 0, 2, 'CLIENTE', 'I', '0')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 21888, 0, 1, 'FECHA DE PROCESO', 'D', @w_fecha_proceso)

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21301, 21887, 1, 1, 'FECHA DE PROCESO', 'D', @w_fecha_proceso)
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21301, 21887, 1, 2, 'CLIENTE', 'I', '0')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (21301, 21888, 2, 1, 'FECHA DE PROCESO', 'D', @w_fecha_proceso)

GO

