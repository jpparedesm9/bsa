use cobis
go

/************************************************************/
/*   CREACION DEL PRODUCTO BATCH                            */
/************************************************************/

print 'cl_producto ..... BATCH'
go

delete cl_producto
 where pd_producto = 8
go

insert into cl_producto
       (pd_producto, pd_tipo,         pd_descripcion, pd_abreviatura, pd_fecha_apertura,
        pd_estado,   pd_saldo_minimo, pd_costo)
values (8, 'R', 'BATCH', 'BAT', getdate(), 'V', NULL, NULL)
go

update cl_seqnos
   set siguiente = (select max(pd_producto) from cl_producto)
 where tabla = 'cl_producto'
go

print 'ad_pro_instalado ..... BATCH'
go

insert into ad_pro_instalado
       (pi_producto, pi_bdd, pi_transaccion, pi_nomfirmas, pi_qrfirmas)
values ('BAT', 'cobis', NULL, NULL, NULL)
go


/***********************************************************/
/*   Producto Moneda                                      */
/***********************************************************/
delete cl_pro_moneda
 where pm_producto = 8
   and pm_moneda   = 0
go

insert into cl_pro_moneda
       (pm_producto, pm_tipo, pm_moneda, pm_descripcion, pm_fecha_aper, pm_estado)
values (8, 'R', 0, 'BATCH', getdate(), 'V') 
go

/********************************************************/
/*       Stored Procedures                            */
/********************************************************/
print 'ad_procedure .....BATCH'       
go

delete ad_procedure where pd_procedure IN (5173, 5171)
go

delete ad_procedure where pd_procedure between 8000 and 8999
go
/* * * * *  NUEVOS PROCEDIMIENTOS MODULO SEGURIDAD    * * * * */
insert into ad_procedure values (5173, 'sp_operador_batch',       'cobis', 'V', getdate(), 'opbatch.sp')
insert into ad_procedure values (5171, 'sp_operador',             'cobis', 'V', getdate(), 'operador.sp')
go

insert into ad_procedure values (8225, 'sp_batch',                'cobis', 'V', getdate(), 'batch.sp')
insert into ad_procedure values (8226, 'sp_log',                  'cobis', 'V', getdate(), 'log.sp')
insert into ad_procedure values (8227, 'sp_parametro1',           'cobis', 'V', getdate(), 'paramet.sp')
insert into ad_procedure values (8228, 'sp_poleo',                'cobis', 'V', getdate(), 'poleo.sp')
insert into ad_procedure values (8229, 'sp_sarta_batch',          'cobis', 'V', getdate(), 'sar_bach.sp')
insert into ad_procedure values (8230, 'sp_sarta',                'cobis', 'V', getdate(), 'sarta.sp')
insert into ad_procedure values (8231, 'sp_lectura',              'cobis', 'V', getdate(), 'lectura.sp')
insert into ad_procedure values (8232, 'sp_fecha_batch',          'cobis', 'V', getdate(), 'fecha.sp')
insert into ad_procedure values (8233, 'sp_ejecucion',            'cobis', 'V', getdate(), 'ejec.sp')
insert into ad_procedure values (8234, 'sp_ls',                   'cobis', 'V', getdate(), 'ls.sp')
insert into ad_procedure values (8235, 'sp_find',                 'cobis', 'V', getdate(), 'find.sp')
insert into ad_procedure values (8236, 'sp_genreg',               'cobis', 'V', getdate(), 'genreg.sp')
insert into ad_procedure values (8237, 'sp_fecha_cierre',         'cobis', 'V', getdate(), 'fcierre.sp')
go

/*Nuevos sps para batch grafico*/
insert into ad_procedure values (8238, 'sp_lote_proceso',         'cobis', 'V', getdate(), 'loteproc.sp')
insert into ad_procedure values (8239, 'sp_aprueba',              'cobis', 'V', getdate(), 'aprueba.sp')
insert into ad_procedure values (8240, 'sp_secuencia_ejecucion',  'cobis', 'V', getdate(), 'sec_ejec.sp')
insert into ad_procedure values (8241, 'sp_sarta_batch_auxiliar', 'cobis', 'V', getdate(), 'sarbaaux.sp')
insert into ad_procedure values (8242, 'sp_enlace_auxiliar',      'cobis', 'V', getdate(), 'enlace_aux.sp')
insert into ad_procedure values (8243, 'sp_consultas',            'cobis', 'V', getdate(), 'consultas.sp')
insert into ad_procedure values (8244, 'sp_pathproc',             'cobis', 'V', getdate(), 'pathproc.sp')
insert into ad_procedure values (8245, 'sp_corrida',              'cobis', 'V', getdate(), 'corrida.sp')
insert into ad_procedure values (8246, 'sp_impresora',            'cobis', 'V', getdate(), 'impresor.sp')
-- PROGRAMA FICTICIO PARA DEFINIR SEGURIDADES DEL FRONT END MENUS
insert into ad_procedure values (8247, 'sp_front_end',            'cobis', 'V', getdate(), 'ficticio.sp')

insert into ad_procedure values(8248, 'sp_login_batch',           'cobis', 'V', getdate(), 'login_batch.sp')
insert into ad_procedure values(8249, 'sp_cons_ap_parametros',    'cobis', 'V', getdate(), 'consapar.sp')
insert into ad_procedure values(8250, 'sp_auteje_forzada',        'cobis', 'V', getdate(), 'sp_autexfor.sp')

--SSO 17/01/2011; NUeva Autorizacion de Reportes (esquema BNF)
insert into ad_procedure values(8254, 'sp_autorizacion_lectura',  'cobis', 'V', getdate(), 'autlectura.sp')
go
--------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Seguridades para esquema de almacenamiento para el registro de errores que se 
-- presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------
insert into ad_procedure values(8255, 'sp_ba_error_log',  'cobis', 'V', getdate(), 'baerrlog.sp')
go

/********************************************************/
/*       Transacciones del Producto                     */
/********************************************************/
print 'cl_ttransaccion .....BATCH'       
go

delete cl_ttransaccion
 where tn_trn_code between 8000 and 8999
go

insert into cl_ttransaccion values(8001, 'INSERCION DE PROGRAMAS', '8001', 'INSERCION DE PROGRAMAS')
insert into cl_ttransaccion values(8002, 'ACTUALIZACION DE PROGRAMAS', '8002', 'ACTUALIZACION DE PROGRAMAS')
insert into cl_ttransaccion values(8003, 'ELIMINACION DE PROGRAMAS', '8003', 'ELIMINACION DE PROGRAMAS')
insert into cl_ttransaccion values(8004, 'CONSULTA DE PROGRAMAS OPCION VALUE', '8004', 'CONSULTA DE PROGRAMAS OPCION VALUE')
insert into cl_ttransaccion values(8005, 'CONSULTA DE PROGRAMAS OPCION SEARCH', '8005', 'CONSULTA DE PROGRAMAS OPCION SEARCH')
insert into cl_ttransaccion values(8006, 'CONSULTA DE PROGRAMAS OPCION QUERY', '8006', 'CONSULTA DE PROGRAMAS OPCION QUERY')
insert into cl_ttransaccion values(8007, 'CONSULTA DE PROGRAMAS OPCION ALL', '8007', 'CONSULTA DE PROGRAMAS OPCION ALL')
insert into cl_ttransaccion values(8008, 'CONSULTA DE PROGRAMAS ACCESIBLES POR UN ROL O LOGIN', '8008', 'CONSULTA DE PROGRAMAS ACCESIBLE POR UN ROL O LOGIN')
insert into cl_ttransaccion values(8011, 'INSERCION DE LOTES', '8001', 'INSERCION DE LOTES')
go

insert into cl_ttransaccion values(8012, 'ACTUALIZACION DE LOTES', '8002', 'ACTUALIZACION DE LOTES')
insert into cl_ttransaccion values(8013, 'ELIMINACION DE LOTES', '8003', 'ELIMINACION DE LOTES')
insert into cl_ttransaccion values(8014, 'CONSULTA DE LOTES OPCION VALUE', '8004', 'CONSULTA DE LOTES OPCION VALUE')
insert into cl_ttransaccion values(8015, 'CONSULTA DE LOTES OPCION SEARCH', '8005', 'CONSULTA DE LOTES OPCION SEARCH')
insert into cl_ttransaccion values(8016, 'CONSULTA DE LOTES OPCION QUERY', '8006', 'CONSULTA DE LOTES OPCION QUERY')
insert into cl_ttransaccion values(8017, 'CONSULTA DE LOTES OPCION ALL', '8007', 'CONSULTA DE LOTES OPCION ALL')
insert into cl_ttransaccion values(8021, 'INSERCION DE PROGRAMAS POR LOTE', '8021', 'INSERCION DE PROGRAMAS POR LOTE')
insert into cl_ttransaccion values(8022, 'ACTUALIZACION DE PROGRAMAS POR LOTE', '8022', 'ACTUALIZACION DE PROGRAMAS POR LOTE')
insert into cl_ttransaccion values(8023, 'ELIMINACION DE PROGRAMAS POR LOTE', '8023', 'ELIMINACION DE PROGRAMAS POR LOTE')
insert into cl_ttransaccion values(8025, 'CONSULTA DE PROGRAMAS POR LOTE OPCION SEARCH', '8025', 'CONSULTA DE PROGRAMAS POR LOTE OPCION SEARCH')
go

insert into cl_ttransaccion values(8027, 'CONSULTA DE PROGRAMAS POR LOTE OPCION ALL', '8027', 'CONSULTA DE PROGRAMAS POR LOTE OPCION ALL')
insert into cl_ttransaccion values(8031, 'INSERCION DE PARAMETROS', '8001', 'INSERCION DE PARAMETROS')
insert into cl_ttransaccion values(8032, 'ACTUALIZACION DE PARAMETROS', '8002', 'ACTUALIZACION DE PARAMETROS')
insert into cl_ttransaccion values(8033, 'ELIMINACION DE PARAMETROS', '8003', 'ELIMINACION DE PARAMETROS')
insert into cl_ttransaccion values(8035, 'CONSULTA DE PARAMETROS OPCION SEARCH', '8005', 'CONSULTA DE PARAMETROS OPCION SEARCH')
insert into cl_ttransaccion values(8036, 'CONSULTA DE PARAMETROS OPCION QUERY', '8006', 'CONSULTA DE PARAMETROS OPCION QUERY')
insert into cl_ttransaccion values(8042, 'CONSULTA DE MAXIMA CORRIDA DE LOG', '8042', 'CONSULTA DE MAXIMA CORRIDA DEL LOG')
insert into cl_ttransaccion values(8045, 'CONSULTA DEL LOG OPCION SEARCH', '8045', 'CONSULTA DEL LOG OPCION SEARCH')
insert into cl_ttransaccion values(8046, 'CONSULTA DEL LOG OPCION QUERY', '8046', 'CONSULTA DEL LOG OPCION QUERY')
insert into cl_ttransaccion values(8048, 'CONSULTA DEL ESTADO DE LA CORRIDA DEL LOG', '8048', 'CONSULTA DEL ESTADO DE LA CORRIDA DEL LOG')
go

insert into cl_ttransaccion values(8050, 'CONSULTA CORRIDA POR FECHA', '8050', 'CONSULTA DE CORRIDA POR FECHA')
insert into cl_ttransaccion values(8061, 'INSERCION EN CATALOGO DE ACCESO A LECTURA', '8061', 'INSERCION EN CATALOGO DE ACCESO A LECTURA')
insert into cl_ttransaccion values(8062, 'ACTUALIZACION AL CATALOGO DE ACCESO A LECTURA', '8062', 'ACTUALIZACION AL CATALOGO DE ACCESO A LECTURA')
insert into cl_ttransaccion values(8063, 'ELIMINACION DEL CATALOGO DE ACCESO A LECTURA', '8063', 'ELIMINACION DEL CATALOGO DE ACCESO A LECTURA')
insert into cl_ttransaccion values(8065, 'CONSULTA AL CATALOGO DE ACCESO A LECTURA OPCION SEARCH', '8065', 'CONSULTA AL CATALOGO DE ACCESO A LECTURA OPCION SEARCH')
insert into cl_ttransaccion values(8066, 'CONSULTA AL CATALOGO DE ACCESO A LECTURA OPCION QUERY', '8066', 'CONSULTA AL CATALOGO DE ACCESO A LECTURA OPCION QUERY')
insert into cl_ttransaccion values(8067, 'CONSULTA DE ROL Y DESCRIPCION', '8067', 'CONSULTA CONSULTA DE ROL Y DESCRIPCION')
insert into cl_ttransaccion values(8068, 'CONSULTA DE USUARIOS PERTENECIENTES A UN ROL', '8068', 'CONSULTA DE USUARIOS PERTENECIENTES A UN ROL')
insert into cl_ttransaccion values(8069, 'ACTUALIZACION DE LA FECHA DE PROCESO', '8069', 'ACTUALIZACION DE LA FECHA DE PROCESO')
insert into cl_ttransaccion values(8070, 'CONSULTA DE LA FECHA DE PROCESO', '8070', 'CONSULTA DE LA FECHA DE PROCESO')
go

insert into cl_ttransaccion values(8071, 'EJECUCION DE UN SHELL', '8071', 'EJECUCION DE UN SHELL')
insert into cl_ttransaccion values(8072, 'PRODUCTO Y PROGRAMAS DE UN LOTE', '8072', 'PRODUCTO  Y PROGRAMAS DE UN LOTE')
insert into cl_ttransaccion values(8073, 'LISTAR DIRECTORIO', '8073', 'LISTAR DIRECTORIO')
insert into cl_ttransaccion values(8074, 'BUSCAR PALABRA EN ARCHIVO', '8074', 'BUSCAR PALABRA EN ARCHIVO')
insert into cl_ttransaccion values(8081, 'BUSCAR FECHAS DE CIERRE', '8081', 'BUSCAR FECHAS DE CIERRE')
insert into cl_ttransaccion values(8082, 'ACTUALIZAR FECHAS DE CIERRE', '8082', 'ACTUALIZAR FECHAS DE CIERRE')
go

/*Nuevas transacciones para batch grafico*/
insert into cl_ttransaccion values(8083, 'INGRESAR/ACTUALIZAR LOTE GRAFICAMENTE', '8083', 'INGRESAR/ACTUALIZAR LOTE Y PROCESOS GRAFICAMENTE')
insert into cl_ttransaccion values(8084, 'CONSULTA DE APROBACION DE PARAMETROS', '8084', 'CONSULTA DE APROBACION DE PARAMETROS')
insert into cl_ttransaccion values(8085, 'REGISTRO DE APROBACION DE PARAMETROS', '8085', 'REGISTRO DE APROBACION DE PARAMETROS')
insert into cl_ttransaccion values(8086, 'MODIFICACION DE APROBACION DE PARAMETROS', '8086', 'MODIFICACION DE APROBACION DE PARAMETROS')
insert into cl_ttransaccion values(8087, 'ELIMINACION DE APROBACION DE PARAMETROS', '8087', 'ELIMINACION DE APROBACION DE PARAMETROS')
insert into cl_ttransaccion values(8088, 'ACTUALIZACION DE PARAMETROS TIPO FECHA', '8088', 'ACTUALIZACION DE PARAMETROS TIPO FECHA')
insert into cl_ttransaccion values(8089, 'QUERY APROBACION DE PARAMETROS', '8089', 'QUERY APROBACION DE PARAMETROS')
insert into cl_ttransaccion values(8090, 'SECUENCIA DE EJECUCION GRAFICA', 'SECEXE', 'OPERACIONES DE LA SECUENCIA DE EJECUCION GRAFICA')
insert into cl_ttransaccion values(8091, 'COPIA DE REGISTROS DE SARTA BATCH', 'CPSABA', 'COPIA LOS REGISTROS DE LA TABLA BA_SARTA_BATCH')
insert into cl_ttransaccion values(8092, 'COPIA DE REGISTROS DE ENLACES', 'CPLINK', 'COPIA LOS REGISTROS DE LA TABLA BA_ENLACE')
go

insert into cl_ttransaccion values(8093, 'INSERCION DE PROCESOS EN BA_SARTA_BATCH_EXEC', 'ISABAX', 'INSERCION DE UN REGISTRO EN BA_SARTA_BATCH_EXEC')
insert into cl_ttransaccion values(8094, 'INSERCION DE ENLACES EN BA_ENLACE_EXEC', 'ILNKX', 'INSERCION DE UN REGISTRO EN BA_ENLACE_EXEC')
insert into cl_ttransaccion values(8095, 'ACTUALIZACION DE PROCESOS EN BA_SARTA_BATCH_EXEC', 'USABAX', 'ACTUALIZACION DE UN REGISTRO EN BA_SARTA_BATCH_EXEC')
insert into cl_ttransaccion values(8096, 'ACTUALIZACION DE ENLACES EN BA_ENLACE_EXEC', 'ULNKX', 'ACTUALIZACION DE UN REGISTRO EN BA_ENLACE_EXEC')
insert into cl_ttransaccion values(8097, 'ELIMINACION DE PROCESOS EN BA_SARTA_BATCH_EXEC', 'DSABAX', 'ELIMINACION DE UN REGISTRO EN BA_SARTA_BATCH_EXEC')
insert into cl_ttransaccion values(8098, 'ELIMINACION DE ENLACES EN BA_ENLACE_EXEC', 'DLNKX', 'ELIMINACION DE UN REGISTRO EN BA_ENLACE_EXEC')
insert into cl_ttransaccion values(8099, 'CONSULTAS GENERALES DE LOTES', '8099', 'CONSULTAS GENERALES DE LOTES Y PROCESOS')
insert into cl_ttransaccion values(8100, 'ELIMINAR LOTES', '8100', 'ELIMINAR LOTES')
insert into cl_ttransaccion values(8101, 'CONSULTA DE PATH POR PRODUCTO', '8101', 'CONSULTA DE PATH POR PRODUCTO')
insert into cl_ttransaccion values(8102, 'ACTUALIZACION DE UN PATH POR PRODUCTO', '8102', 'ACTUALIZACION DE UN PATH POR PRODUCTO')
insert into cl_ttransaccion values(8103, 'CAMBIOS DE ESTADO MANUALES', '8103', 'CAMBIOS DE ESTADO MANUALES EN ROW DE CORRIDA')
insert into cl_ttransaccion values(8104, 'CAMBIOS DE ESTADO ADMINISTRATIVOS', '8104', 'CAMBIOS DE ESTADO ADMINISTRATIVOS EN ROW DE CORRIDA')
insert into cl_ttransaccion values(8105, 'CAMBIOS DE ESTADO AUTOMATICOS', '8105', 'CAMBIOS DE ESTADO AUTOMATICOS EN ROW DE CORRIDA')
insert into cl_ttransaccion values(8106,'INGRESAR IMPRESORA','8106','INGRESAR IMPRESORA') 
insert into cl_ttransaccion values(8107,'ELIMINAR IMPRESORA','8107','ELIMINAR IMPRESORA') 
insert into cl_ttransaccion values(8108,'MODIFICAR IMPRESORA','8108','MODIFICAR IMPRESORA') 
insert into cl_ttransaccion values(8109,'EJECUTAR IMPRESION','8109','EJECUTAR IMPRESION') 
insert into cl_ttransaccion values(8110,'BUSCAR IMPRESORAS','8110','BUSCAR IMPRESORAS') 
insert into cl_ttransaccion values(8111, 'MANTENIMIENTO AUTORIZACION PROCESOS-LOGIN', '8111', 'MANTENIMIENTO AUTORIZACION PROCESOS-LOGIN')
insert into cl_ttransaccion values(8112, 'CONSULTAS AUTORIZACION PROCESOS-LOGIN', '8112', 'CONSULTAS AUTORIZACION PROCESOS-LOGIN')
insert into cl_ttransaccion values(8113, 'IMRESION DE PARAMETROS POR PROCESO', '8113', 'IMRESION DE PARAMETROS POR PROCESO') 
insert into cl_ttransaccion values(8114, 'CONSULTA DE PERMISOS COMO SUPERVISOR BATCH', '8114', 'CONSULTA DE PERMISOS COMO SUPERVISOR BATCH')
insert into cl_ttransaccion values(8118, 'AUTORIZACION LECTURA REPORTES', '8118', 'AUTORIZACION LECTURA REPORTES')
go  

-- TRANSACCIONES FICTICIAS PARA MENUS DEL FRONT END
insert into cl_ttransaccion values(8201, 'Consulta de Tiempos por Lotes', '8201', 'Consulta de Tiempos por Lotes') 
insert into cl_ttransaccion values(8202, 'Consulta de Tiempos Excedentes', '8202', 'Consulta de Tiempos Excedentes') 
insert into cl_ttransaccion values(8203, 'Consulta de Errores de Ejecución', '8203', 'Consulta de Errores de Ejecución') 
insert into cl_ttransaccion values(8204, 'Consulta de Ejecución', '8204', 'Consulta de Ejecución') 
go

--------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Seguridades para esquema de almacenamiento para el registro de errores que se 
-- presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------
insert into cl_ttransaccion values(8205, 'Consulta de Errores de Procesamiento', '8205', 'Consulta de Errores de Procesamiento') 
go

/** * * * * *    NUEVAS TRANSACCIONES PARA EL MODULO DE SEGURIDAD   * * * * * **/

delete cl_ttransaccion where tn_trn_code between 15289 and 15294
go 

insert into cl_ttransaccion values (15289,'CONSULTA DE OPERADORES DE BATCH','COPBA','CONSULTA DE OPERADORES DE BATCH')
insert into cl_ttransaccion values (15290,'QUERY DE OPERADOR BATCH','QOPBA','QUERY DE OPERADOR BATCH')
insert into cl_ttransaccion values (15291,'INSERCION DE OPERADOR BATCH','IOPBA','INSERCION DE OPERADOR BATCH')
insert into cl_ttransaccion values (15292,'ACTUALIZACION DE OPERADOR BATCH','AOPBA','ACTUALIZACION DE OPERADOR BATCH')
insert into cl_ttransaccion values (15293,'ELIMINACION DE OPERADOR BATCH','EOPBA','ELIMINACION DE OPERADOR BATCH')
insert into cl_ttransaccion values (15294,'VALIDACION DE USUARIO DE OPERADOR BATCH','VALOPB','VALIDACION DE USUARIO DE OPERADOR BATCH')
print 'TRANSACCIONES POR SP'
go
/********************************************************/
/*       Transacciones por Stored Procedures               */
/********************************************************/
delete ad_pro_transaccion
 where pt_producto = 8
go

insert into ad_pro_transaccion values (8, 'R', 0, 1502, 'V', getdate(), 5101, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8001, 'V', getdate(), 8225, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8002, 'V', getdate(), 8225, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8003, 'V', getdate(), 8225, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8004, 'V', getdate(), 8225, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8005, 'V', getdate(), 8225, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8006, 'V', getdate(), 8225, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8007, 'V', getdate(), 8225, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8008, 'V', getdate(), 8225, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8045, 'V', getdate(), 8226, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8046, 'V', getdate(), 8226, null)
go

insert into ad_pro_transaccion values (8, 'R', 0, 8031, 'V', getdate(), 8227, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8032, 'V', getdate(), 8227, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8033, 'V', getdate(), 8227, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8035, 'V', getdate(), 8227, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8036, 'V', getdate(), 8227, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8042, 'V', getdate(), 8228, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8048, 'V', getdate(), 8228, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8021, 'V', getdate(), 8229, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8022, 'V', getdate(), 8229, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8023, 'V', getdate(), 8229, null)
go

insert into ad_pro_transaccion values (8, 'R', 0, 8025, 'V', getdate(), 8229, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8027, 'V', getdate(), 8229, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8011, 'V', getdate(), 8230, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8012, 'V', getdate(), 8230, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8013, 'V', getdate(), 8230, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8014, 'V', getdate(), 8230, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8015, 'V', getdate(), 8230, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8016, 'V', getdate(), 8230, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8017, 'V', getdate(), 8230, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8050, 'V', getdate(), 8226, null)
go

insert into ad_pro_transaccion values (8, 'R', 0, 8061, 'V', getdate(), 8231, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8062, 'V', getdate(), 8231, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8063, 'V', getdate(), 8231, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8065, 'V', getdate(), 8231, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8066, 'V', getdate(), 8231, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8067, 'V', getdate(), 8231, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8068, 'V', getdate(), 8231, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8069, 'V', getdate(), 8232, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8070, 'V', getdate(), 8232, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8071, 'V', getdate(), 8233, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8072, 'V', getdate(), 8230, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8073, 'V', getdate(), 8234, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8074, 'V', getdate(), 8235, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8081, 'V', getdate(), 8237, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8082, 'V', getdate(), 8237, null)
go

/*Nuevas transacciones para batch grafico*/
insert into ad_pro_transaccion values (8, 'R', 0, 8083, 'V', getdate(), 8238, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8090, 'V', getdate(), 8240, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8091, 'V', getdate(), 8241, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8092, 'V', getdate(), 8242, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8093, 'V', getdate(), 8241, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8094, 'V', getdate(), 8242, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8095, 'V', getdate(), 8241, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8096, 'V', getdate(), 8242, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8097, 'V', getdate(), 8241, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8098, 'V', getdate(), 8242, null)
go

insert into ad_pro_transaccion values (8, 'R', 0, 8099, 'V', getdate(), 8243, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8084, 'V', getdate(), 8239, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8085, 'V', getdate(), 8239, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8086, 'V', getdate(), 8239, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8087, 'V', getdate(), 8239, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8088, 'V', getdate(), 8239, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8089, 'V', getdate(), 8239, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8100, 'V', getdate(), 8238, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8101, 'V', getdate(), 8244, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8102, 'V', getdate(), 8244, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8103, 'V', getdate(), 8245, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8104, 'V', getdate(), 8245, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8105, 'V', getdate(), 8245, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8106, 'V', getdate(), 8246,null)
insert into ad_pro_transaccion values (8, 'R', 0, 8107, 'V', getdate(), 8246,null)
insert into ad_pro_transaccion values (8, 'R', 0, 8108, 'V', getdate(), 8246,null)
insert into ad_pro_transaccion values (8, 'R', 0, 8109, 'V', getdate(), 8246,null)
insert into ad_pro_transaccion values (8, 'R', 0, 8110, 'V', getdate(), 8246,null)
insert into ad_pro_transaccion values (8, 'R', 0, 8111, 'V', getdate(), 8248, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8112, 'V', getdate(), 8248, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8113, 'V', getdate(), 8249, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8114, 'V', getdate(), 8250, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8118, 'V', getdate(), 8254, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8201, 'V', getdate(), 8247, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8202, 'V', getdate(), 8247, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8203, 'V', getdate(), 8247, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8204, 'V', getdate(), 8247, null)
insert into ad_pro_transaccion values (8, 'R', 0, 8206, 'V', getdate(), 8247, null)
insert into ad_pro_transaccion values (8, 'R', 0, 15294,'V', getdate(), 1500, null)
go

--------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Seguridades para esquema de almacenamiento para el registro de errores que se 
-- presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------
insert into ad_pro_transaccion values (8,'R',0,8205,'V',getdate(),8255,null)
go

/* * * * * *  NUEVAS TRANSACCIONES Y PROCEDIMIENTOS DE MODULO SEGURIDAD  * * * * */
delete ad_pro_transaccion 
where 
      pt_producto = 1
and   pt_transaccion between 15289 and 15294
go
 

--insert into ad_pro_transaccion values (1,'R',0,1502,'V',getdate(),5101,null) --FOR 2014-04-01 Se comenta esto porque ya está en el Admin
insert into ad_pro_transaccion values (1,'R',0,15294,'V',getdate(),5173,null)
insert into ad_pro_transaccion values (1,'R',0,15289,'V',getdate(),5171,null)
insert into ad_pro_transaccion values (1,'R',0,15290,'V',getdate(),5171,null)
insert into ad_pro_transaccion values (1,'R',0,15291,'V',getdate(),5171,null)
insert into ad_pro_transaccion values (1,'R',0,15292,'V',getdate(),5171,null)
insert into ad_pro_transaccion values (1,'R',0,15293,'V',getdate(),5171,null)
go

print 'TRANSACCIONES AUTORIZADAS'
go
/********************************************************/
/*       Transacciones Autorizadas al Rol 1               */
/********************************************************/


declare @w_rol integer 

select @w_rol = ro_rol 
  from ad_rol
 where ro_descripcion = 'ADMINISTRADOR'
   and ro_filial      = 1


delete ad_tr_autorizada
 where ta_producto = 8
 and ta_rol = @w_rol 


insert into ad_tr_autorizada values(8, 'R', 0, 1502, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada values(8, 'R', 0, 8001, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8002, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8003, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8004, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8005, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8006, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8007, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8008, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8045, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8046, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada values(8, 'R', 0, 8050, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8031, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8032, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8033, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8035, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8036, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8042, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8048, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8021, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8022, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada values(8, 'R', 0, 8023, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8025, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8027, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8011, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8012, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8013, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8014, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8015, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8016, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8017, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada values(8, 'R', 0, 8061, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8062, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8063, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8065, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8066, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8067, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8068, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8069, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8070, @w_rol, getdate(), 1, 'V', getdate())
--insert into ad_tr_autorizada values(8, 'R', 0, 8071, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada values(8, 'R', 0, 1504, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8072, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8073, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8074, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8081, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8082, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8101, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8102, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8103, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8104, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8105, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8106, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8111, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8112, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8113, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 8114, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values(8, 'R', 0, 15294, @w_rol, getdate(), 1, 'V', getdate())
go

/* * * * * *  AUTORIZACION DE NUEVAS TRANSACCIONES PARA EL ROL ADMINISTRADOR * * * * */

if exists (select 1 from ad_tr_autorizada where ta_rol = 1 and ta_producto = 1 and ta_transaccion between 15289 and 15294)
    delete ad_tr_autorizada where ta_rol = 1 and ta_producto = 1 and ta_transaccion between 15289 and 15294
go

declare @w_rol integer 

select @w_rol = ro_rol 
  from ad_rol
 where ro_descripcion = 'ADMINISTRADOR'
   and ro_filial      = 1

insert into ad_tr_autorizada values (1, 'R', 0, 15294, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values (1, 'R', 0, 15289, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values (1, 'R', 0, 15290, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values (1, 'R', 0, 15291, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values (1, 'R', 0, 15292, @w_rol, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada values (1, 'R', 0, 15293, @w_rol, getdate(), 1, 'V', getdate())
go


truncate table ba_fecha_cierre

insert into ba_fecha_cierre
select distinct pd_producto, getdate(), null
  from cl_producto
go

