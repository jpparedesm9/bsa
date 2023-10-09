/************************************************************************/
/*      Archivo:            ah_error.sql                                */
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
/*      Este programa realiza la creacion de errores                    */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cobis
go


print 'cl_errores'
/**************************/
/*   CUENTAS DE AHORROS   */
/**************************/

delete cl_errores where numero in (
201271,251000,251001,251002,251003,251004,251005,251006,251007,251008,251009,251010,251011,251012,251013,251014,251015,251016,251017,251018,
251019,251020,251021,251022,251023,251024,251025,251026,251027,251028,251029,251030,251031,251032,251033,251034,251035,251036,251037,251038,
251039,251040,251041,251042,251043,251044,251045,251046,251047,251048,251049,251050,251051,251052,251053,251054,251055,251056,251057,251058,
251059,251060,251061,251062,251063,251064,251065,251066,251067,251068,251069,251070,251071,251072,251073,251074,251075,251076,251077,251078,
251079,251080,251081,251082,251083,251084,251085,251086,251087,251088,251089,251090,251091,251092,251093,251094,251095,251096,251097,251098,
251099,251100,251101,251102,251103,251104,251105,251106,251107,251108,251109,251110,251111,251112,251113,251114,251115,251116,251122,251123,
251124,251125,251126,251127,251128,251129,251130,251131,251132,251133,251134,251135,251136,251137,251138,251139,251141,251142,251143,251144,
251145,251146,251147,251148,251149,252070,252071,252072,252073,252074,252075,252076,252077,252078,252079,252080,252081,252082,252090,252091,
252092,252093,252094,253000,253001,253002,253003,253004,253005,253006,253007,253008,253009,253010,253011,253012,253013,253014,253015,253070,
253071,255001,255002,255003,255004,255005,255006,255007,255008,255009,255010,255011,255012,255070,255071,257001,257002,257003,257004,257005,
257006,257070,257071,257072,257073,257074,257075,257076,257077,258001,258002,263500,263501,263502,276000,276001,276002,276003,276004,276005,
288500,288501,288502,288503,288504,201196,258003,141195,201048,201327,201328,203082,203083,203091,207037,207038,207044,208047,101010,201329,
203005,355039,201004,201030,201330,201332,205000,351088,353035,357015,357020,357021,357022,357023,357024,357025,161724,357027,357028,
357029,357030,357031,357032,357033,357034,357035,357036,357037,357038,357039,357040,111020,111021,111022,111023,111024,357041,357042,357043,
357044,357045,357046,357047,357048,357049,357050,357051,357052,357053,357054,357055,357056,357567,357573,357560
)

go

/*  Errores de existencia  */
print 'Errores de existencia'
go

INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111020, 1, 'ERROR EN PARAMETRO DE MAYORIA DE EDAD')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111021, 1, 'ERROR EN PARAMETRO DE PROXIMIDAD MAYORIA DE EDAD')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111022, 1, 'ERROR EN PARAMETRO PRODUCTO BANCARIO MAYORIA DE EDAD')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111023, 1, 'ERROR EN PARAMETRO CONVERSION UDIs')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111024, 1, 'ERROR EN PARAMETRO SALDO MAXIMO DISPONIBLE EN UDIs')
go

INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (201271, 1, 'YA EXISTE UN MENSAJE PARA ESE RANGO DE FECHAS')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251000, 1, 'ERROR EN ESTADO DE TRANSACCION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251001, 1, 'NO EXISTE CUENTA DE AHORROS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251002, 1, 'CUENTA DE AHORROS NO ESTA VIGENTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251003, 1, 'NO EXISTE DEFAULT PARA OFICINA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251004, 1, 'NUMERO DE CONTROL ERRADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251005, 1, 'SALDO DE LIBRETA NO COINCIDE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251006, 1, 'CUENTA NO TIENE LINEAS PENDIENTES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251007, 1, 'CUENTA BLOQUEADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251008, 1, 'CUENTA TIENE LINEAS PENDIENTES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251009, 1, 'NO EXISTE PERIODO DE CAPITALIZACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251010, 1, 'ERROR EN TABLA DE PERIODOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251011, 1, 'NO EXISTE TASA DE INTERES PARA FECHA DADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251012, 1, 'ERROR EN TABLA DE ALICUOTAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251013, 1, 'ERROR EN TABLA DE FECHA PROMEDIO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251014, 1, 'NO EXISTE PERIODO DE CAPITALIZACION MENSUAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251015, 1, 'NO EXISTE PERIODO DE CAPITALIZACION BIMENSUAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251016, 1, 'NO EXISTE PERIODO DE CAPITALIZACION TRIMESTRAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251017, 1, 'NO EXISTE PERIODO DE CAPITALIZACION SEMESTRAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251018, 1, 'NO EXISTE TIPO DE INTERES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251019, 1, 'NO EXISTE TIPO DE ACCION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251020, 1, 'FECHA MAYOR A HOY')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251021, 1, 'FECHA MUY ANTERIOR A HOY')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251022, 1, 'DATOS INCONSISTENTES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251023, 1, 'SALDO CONTABLE NO COINCIDE CON DISPONIBLE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251024, 1, 'NO EXISTE SERVICIO/CAUSA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251025, 1, 'NO EXISTE TIPO DE BLOQUEO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251026, 1, 'CODIGO DE MONEDA ERRADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251027, 1, 'CUENTA SIN FONDOS DISPONIBLES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251028, 1, 'VALOR MAYOR A RETENCIONES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251029, 1, 'MONEDA NO CORRESPONDE A CUENTA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251030, 1, 'ERROR EN TABLA DE CUENTAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251031, 1, 'VALOR MAYOR A RETENCION REMESAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251032, 1, 'VALOR MAYOR A RETENCION REMESAS HOY')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251033, 1, 'FONDOS INSUFICIENTES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251034, 1, 'NO EXISTE TIPO DE TRANSACCION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251035, 1, 'ERROR EN TABLA DE LINEAS PENDIENTES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251036, 1, 'ERROR EN APERTURA DE CAJERO LOCAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251037, 1, 'PRODUCTO NO REQUIERE REGISTRO DE CAJERO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251038, 1, 'NO EXISTE SERVICIO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251039, 1, 'NO EXISTEN LINEAS PENDIENTES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251040, 1, 'CUENTA NO SE ENCUENTRA INACTIVA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251041, 1, 'CUENTA NO SE ENCUENTRA CANCELADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251042, 1, 'NO EXISTEN VALORES BLOQUEADOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251043, 1, 'VALOR NO COINCIDE CON SALDO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251044, 1, 'SALDO CONTABLE DEBE QUEDAR EN CERO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251045, 1, 'CUENTA SIN FONDOS PARA BLOQUEAR')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251046, 1, 'MONTO BLOQUEADO MENOR AL VALOR A LEVANTAR')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251047, 1, 'NO ESTA INSTALADO PRODUCTO CUENTAS DE AHORROS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251048, 1, 'DEPOSITO MONETARIO ASOCIADO NO PERTENECE AL MISMO CLIENTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251049, 1, 'CUENTA DE AHORROS ASOCIADA NO EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251050, 1, 'NO SE HA APERTURADO CAJA EN AHORROS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251051, 1, 'VALOR EXCEDE AL DISPONIBLE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251052, 1, 'OFICIAL NO AUTORIZADO PARA CUENTAS DE FUNCIONARIOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251053, 1, 'DISPONIBLE MENOR QUE EL AJUSTE DE CAPITAL EL CUAL ES NEGATIVO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251054, 1, 'FECHA EFECTIVA MENOR A FECHA DE APERTURA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251055, 1, 'VALOR DE CIERRE NO COINCIDE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251056, 1, 'SALDOS DEBEN QUEDAR EN CERO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251057, 1, 'CUENTA DE AHORROS CERRADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251058, 1, 'CUENTA DE AHORROS INACTIVA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251059, 1, 'CUENTA CON RETENCIONES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251060, 1, 'TRANSACCION NO PERMITIDA EL ROL DEBE SER DE HORARIO DIFERIDO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251061, 1, 'ERROR EN SECUENCIAL DE HISTORICO DE MOVIMIENTOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251062, 1, 'ERROR EN LECTURA DE TRANSACCIONES MONETARIAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251063, 1, 'ERROR EN SECUENCIAL DE HISTORICO DE SERVICIOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251064, 1, 'ERROR EN LECTURA DE TRANSACCIONES DE SERVICIOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251065, 1, 'ERROR EN CURSOR ah_val_suspenso')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251066, 1, 'RUTA Y TRANSITO NO EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251067, 1, 'TRANSACCION ORIGEN DEL REVERSO NO COINCIDE O TRANSACCION YA REVERSADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251068, 1, 'VALOR DE LA TRANSACCION NO PUEDE SER CERO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251069, 1, 'COMBINACION NO VALIDA PARA LA APERTURA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251070, 0, 'Error creando registro de rechazo de comision')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251071, 1, 'VALOR EN SUSPENSO NO FUE ENCONTRADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251072, 1, 'MONTO MAXIMO DE EFECTIVO SUPERADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251073, 1, 'VALOR EN SUSPENSO SOBREPASA DISPONIBLE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251074, 1, 'CUENTA CON VALORES EN SUSPENSO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251075, 1, 'NO EXISTE REGISTRO DE REGULARIZACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251076, 1, 'CUENTA CON FONDOS BLOQUEADOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251077, 1, 'SALDO DISPONIBLE O SALDO PROMEDIO SEMESTRAL MENOR A CERO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251078, 1, 'CAUSA DE USO EXCLUSIVO DEL SISTEMA CONEXION BANCARIBE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251079, 1, 'CAUSA NO COINCIDE CON LA DEL BLOQUEO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251080, 1, 'NO EXISTEN OFICINAS AUTORIZADAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251081, 1, 'OFICINA NO AUTORIZADA PARA CTAS. CIFRADAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251082, 1, 'NO SE PUEDE LEVANTAR UN BLOQUEO POR TRASLADO AUTOMATICO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251083, 1, 'CUENTA REQUIERE POSTEO. TIENE MAS DE 10 LINEAS PENDIENTES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251084, 1, 'ESTA OFICINA NO PUEDE APERTURAR O ACTUALIZAR CTAS DE SERVICIO SOCIAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251085, 1, 'LA  CUENTA ES DE MENOR DE EDAD Y NO SE PUEDE PIGNORAR O EMBARGAR')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251086, 0, 'EL CLIENTE YA POSEE AL MENOS UN CUENTA DEL PRODUCTO BANCARIO DEFINIDO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251087, 0, 'NO SE PUEDEN APERTURAR CUENTAS DE TARJETAS DE PLANILLA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251088, 0, 'LA CUENTA NO ES DE TARJETAS DE PLANILLA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251089, 0, 'LA CUENTA DE TARJETA DE PLANILLA NO TIENE SALDO CERO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251090, 1, 'ERROR, NO SE PERMITE CERRAR CUENTA ASOCIADA A CONVENIO ACTIVO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251091, 0, 'NO ESTA DEFINIDA EL AREA CONTABLE PARA AHORROS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251092, 0, 'NO ESTA DEFINIDA EL PRODUCTO DE AHORROS EN CONTABILIDAD')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251093, 0, 'NO EXISTEN PERIODOS DE CORTE ABIERTOS EN CONTABILIDAD')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251094, 0, 'CLIENTE NO TIENE CUENTAS O ESTAN INACTIVAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251095, 0, 'RETIRO FUERA DE LINEA NO AUTORIZADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251096, 0, 'EL TIEMPO PARA EL PRIMER DEPOSITO HA CONCLUIDO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251097, 0, 'NO EXISTE MONTO MINIMO PARA EL PRIMER DEPOSITO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251098, 0, 'MONTO A DEPOSITAR ES INFERIOR AL MONTO MINIMO PARA PRIMER DEPOSITO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251099, 0, 'CUENTA NO VIGENTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251100, 0, 'TRANSACCION NO PARAMETRIZADA PARA VALIDACION DE DEPOSITO INICIAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251101, 0, 'ERROR EN VALIDACION DE DEPOSITO INICIAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251102, 0, 'CUENTA DE AHORROS NO PERFECCIONADA. NO SE PUEDE ACTIVAR')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251103, 0, 'CUENTA DE AHORROS YA SE ENCUENTRA ACTIVA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251104, 0, 'ERROR, CUENTA ORIGEN IGUAL A CUENTA DE DESTINO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251105, 0, 'Error actualizando tabla de transacciones mensuales')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251106, 0, 'Error eliminando transacciones mensuales')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251107, 0, 'CODIGO PARA DTN NO EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251108, 0, 'CODIGO PARA DTN EN USO PARA TRASLADO DE CUENTAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251109, 0, 'EL PROCESO BATCH YA FUE EJECUTADO COMO DEFINITIVO Y NO PUEDE REPROCESARSE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251110, 0, 'Codigo de transaccion para registro de cobro de gmf no definida')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251111, 0, 'Ente de Bancamia no parametrizado')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251112, 0, 'Error en insercion transaccion de servicio cobro gmf banco')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251113, 1, 'VALOR COBIS NO SE ENCUENTRA EN EL CATALOGO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251114, 1, 'NO EXISTE HOMOLOGACION PARA EL CODIGO INGRESADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251115, 1, 'LA TABLA EQUIVALENCIA YA TIENE ESE CODIGO COBIS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251116, 1, 'LA TABLA EQUIVALENCIA YA TIENE ESE CODIGO EXTERNO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251122, 0, 'ERROR ESTRUCTURA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251123, 0, 'FECHA DE PROCESO DIFERENTE A')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251124, 0, 'FECHA DE APLICACIËN')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251125, 0, 'NO EXISTE CAUSAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251126, 0, 'IDENTIFICACIËN NO EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251127, 0, 'CUENTA NO EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251128, 0, 'CUENTA NO PERTENECE A CLIENTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251129, 0, 'CUENTA NO VIGENTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251130, 0, 'CUENTA BLOQUEADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251131, 1, 'ESTADO DE LA CUENTA NO PERMITE MARCACION GMF')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251132, 1, 'ESTADO DE LA CUENTA NO PERMITE DESMARCACION GMF')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251133, 0, 'FECHA DE PROCESO NO CORRESPONDE A LA DEL NOMBRE DEL ARCHIVO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251134, 0, 'FECHA DE PROCESO NO CORRESPONDE A LA FECHA DEL CONTROL GENERAL DEL ARCHIVO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251135, 0, 'FECHA DE PROCESO NO CORRESPONDE A LA FECHA DEL ENCABEZADO DEL ARCHIVO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251136, 0, 'NO EXISTE REGISTRO DE CONTROL GENERAL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251137, 0, 'NO EXISTE REGISTRO DE ENCABEZADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251138, 0, 'EL NUMERO DE REGISTROS DEL ENCABEZADO NO COINCIDE CON EL DEL DETALLE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251139, 0, 'EL NUMERO DE REGISTROS DEL ENCABEZADO GENERAL NO COINCIDE CON EL DEL DETALLE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251141, 0, 'ERROR CARGANDO TABLA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251142, 0, 'ERROR CARGANDO PARAMETRO BCP')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251143, 0, 'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251144, 0, 'NO EXISTE PRODUCTO BANCARIO CB EN CATALOGO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251145, 0, 'NO EXISEN VALORES EN SUSPENSO A CONDONAR PARA LA FECHA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251146, 0, 'NO EXISTEN REGISTROS A CONDONAR - FAVOR VALIDAR PARAMETRIZACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251147, 0, 'ERROR AL GENERAR TABLA DE CONDONACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251148, 0, 'CLIENTE PRESENTA VALORES EN SUSPENSO, DEBE PONERSE AL D-A PARA PODER ADQUIRIR UNA NUEVA TARJETA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (251149, 0, 'CLIENTE PRESENTO CONDONACION DE COMISIONES, INFORME SOBRE LOS COSTOS ASOCIADOS A LA TARJETA DEBITO Y COBRE LA ASIGNACION DE ESTA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252070, 1, 'RELACION PARA CUENTA DE NAVIDAD YA HA SIDO CREADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252071, 1, 'LA RELACION DE CUENTA DE NAVIDAD NO EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252072, 1, 'FALTA LA DIRECCION DE ESTADO DE CUENTA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252073, 1, 'FALTA LA DIRECCION DE LOS CHEQUES DEVUELTOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252074, 0, 'NO PUEDE CONSULTAR - CTA. CLASIFICADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252075, 0, 'CUENTA NO ES UNA CUENTA DE NAVIDAD VALIDA O YA FUE CANCELADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252076, 0, 'ERROR AL OBTENER FIRMANTES DE LA CUENTA DE NAVIDAD')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252077, 0, 'EL CREDITO A LA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252078, 0, 'CUENTA BLOQUEADA POR EMBARGOS, NO PUEDE REALIZARSE LEVANTAMIENTO ADMINISTRATIVO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252079, 0, 'CUENTA NO BLOQUEADA CONTRA EL TIPO DE BLOQUEO INGRESADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252080, 0, 'CUENTA NO SE ENCUENTRA EMBARGADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252081, 0, 'CUENTA EMBARGADA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252082, 1, 'NO EXISTE NUMERO DE DIAS LIMITE DE CONSULTA FRONTEND')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252090, 0, 'Error a actualizar detalle o no existe registro')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252091, 0, 'NO EXISTE ARCHIVO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252092, 0, 'ARCHIVO PROCESADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252093, 1, 'ERROR EN REINTEGRO DE GMF')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (252094, 1, 'ERROR EN REINTEGRO DE GMF CIERRE DE CUENTA ')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253000, 1, 'ERROR EN INSERCION DE TRANSACCION MONETARIA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253001, 1, 'ERROR EN INSERCION DE CUENTA DE AHORROS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253002, 1, 'ERROR EN INSERCION DE LINEA PENDIENTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253003, 1, 'ERROR EN INSERCION DE VALORES EN SUSPENSO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253004, 1, 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253005, 1, 'ERROR EN INSERCION DE TABLA ACTUALIZA CAPITALIZACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253006, 1, 'ERROR EN INSERCION DE TABLA DE SALDOS DIARIOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253007, 1, 'ERROR EN INSERCION DE DEPOSITO DIFERIDO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253008, 1, 'ERROR EN INSERCION DE HISTORICO DE MOVIMIENTOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253009, 1, 'ERROR EN INSERCION DE HISTORICO DE SERVICIOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253010, 1, 'CLIENTE PARA LA CUENTA YA EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253011, 1, 'ERROR EN INSERCION DE HISTORICO DE INMOVILIZADAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253012, 1, 'ERROR EN INSERCION DE REGISTRO DE REGULARIZACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253013, 1, 'ERROR EN GRABACION DE ARCHIVO DE ERRORES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253014, 1, 'ERROR AL INSERTAR EN TABLA AH_OFICINA_CTAS_CIFRADAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253015, 1, 'ERROR AL CARGAR OPERACIONES A PROCESAR')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253070, 1, 'ERROR AL CREAR LA RELACION DE CUENTA DE NAVIDAD, VERIFIQUE LOS DATOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (253071, 1, 'ERROR AL CREAR LA CUENTA DE AHORROS DE NAVIDAD, PARAMETROS NO VALIDOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255001, 1, 'ERROR AL ACTUALIZAR CUENTA de ahorros')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255002, 1, 'ERROR AL ACTUALIZAR lineas pendientes')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255003, 1, 'ERROR AL ACTUALIZAR cajero')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255004, 1, 'ERROR AL ACTUALIZAR TRANSACCION monetaria')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255005, 1, 'ERROR AL ALACTUALIZAR Nro.Control/Cl_seqnos')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255006, 1, 'ERROR AL ALACTUALIZAR registro en ah_lincredito')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255007, 1, 'ERROR AL ALACTUALIZAR registro en ah_act_capitalizacion')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255008, 1, 'ERROR AL ALACTUALIZAR registro en ah_his_bloqueo')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255009, 1, 'ERROR AL ACTUALIZAR SALDO DE LIBRETA Y NUMERO DE CONTROL')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255010, 1, 'ERROR EN ACTUALIZACION SECUENCIAL HISTORICO DE MOVIMIENTOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255011, 1, 'ERROR EN ACTUALIZACION SECUENCIAL HISTORICO DE SERVICIOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255012, 1, 'ERROR AL ACTUALIZAR EN TABLA AH_OFICINA_CTAS_CIFRADAS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255070, 1, 'ERROR EN ACTUALIZACION BLOQUEO DE PAGO DE CUENTA DE NAVIDAD')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (255071, 1, 'ERROR EN ACTUALIZACION FECHA DE PAGO DE RELACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257001, 1, 'ERROR AL ELIMINAR LINEA PENDIENTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257002, 1, 'ERROR AL ELIMINAR VALOR EN SUSPENSO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257003, 1, 'ERROR AL ELIMINAR REGISTRO DE REGULARIZACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257004, 1, 'VALOR DE MOVIMIENTO MAYOR AL TOPE DE LA CUENTA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257005, 1, 'ERROR AL ELIMINAR LA TABLA DE DETALLES DEL BOC')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257006, 1, 'ERROR AL ELIMINAR LA TABLA DEL BOC')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257070, 1, 'LA RELACION DE CUENTA DE NAVIDAD NO SE PUEDE ELIMINAR')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257071, 1, 'NO SE PUEDE ELIMINAR EL CLIENTE ELEGIDO, YA EXISTEN CUENTAS DE NAVIDAD CREADAS PARA DICHA RELACION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257072, 1, 'EL CLIENTE YA TIENE UNA CUENTA DE AHORROS (AHORRAMAS) EN ESTADO VIGENTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257073, 1, 'ERROR AL ACTULIZAR DATOS DE CUENTAS DE NAVIDAD EN EL MAESTRO DE CUENTAS DE AHORROS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257074, 1, 'ERROR AL ACTUALIZAR DATOS DE CUENTAS DE NAVIDAD')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257075, 1, 'NO EXISTE INFORMACION DEL PAGO DE CIERRE DE CUENTA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257076, 1, 'TRANSACCION SE DEBE REALIZAR EN LA OFICINA DE LA CUENTA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (257077, 1, 'APLICATIVO NO HABILITADO PARA LA OFICINA')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (258001, 1, 'ERROR AL  CORREGIR LA TRANSACCION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (258002, 1, 'ERROR AL CORREGIR EL DEPOSITO DIFERIDO')
GO

INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (263500, 1, 'ERROR EN INSERCION DE REGISTRO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (263501, 1, 'REGISTRO YA EXISTE PARA LOS DATOS COBIS INDICADOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (263502, 1, 'CAMPOS OBLIGATORIOS VACIOS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (276000, 0, 'ERROR AL ACTUALIZAR LOS DATOS DE IMPRESION')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (276001, 0, 'ERROR AL ACTUALIZAR ESTADO DE CUENTA DE AHORROS')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (276002, 0, 'ERROR AL ACTUALIZAR ESTADO DE CUENTA EN re_tesoro_nacional')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (276003, 0, 'ERROR AL ACTUALIZAR OFIDEST EN ORDENES DE PAGO EN CAJA PENDIENTES')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (276004, 1, 'REGISTRO A ACTUALIZAR NO EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (276005, 1, 'ERROR AL ACTUALIZAR EL REGISTRO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (288500, 1, 'ERROR EN INSERCION DE CODIGO DTN')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (288501, 1, 'ERROR EN ELIMINACION DE CODIGO DTN')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (288502, 1, 'ERROR EN ACTUALIZACION DE CODIGO DTN')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (288503, 1, 'ERROR EN ELIMINACION DE REGISTRO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (288504, 0, 'REGISTRO A ELIMINAR NO EXISTE')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (201196, 1, 'PARAMETRO NO ENCONTRADO')
GO
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (258003, 0, 'CLIENTE NO TIENE CUENTAS O ESTAN ACTIVAS')
GO
insert into cl_errores (numero, severidad, mensaje) values (141195, 0, 'No existen registros que cumplan la(s) condición(es) dada(s)')
GO

insert into cl_errores (numero, severidad, mensaje) values (201048, 1, 'ERROR EN CODIGO DE TRANSACCION')
insert into cl_errores (numero, severidad, mensaje) values (201327, 0, 'EL FUNCIONARIO AUTORIZANTE QUE SE DESEA ELIMINAR TIENE ASOCIADO FUNCIONARIOS DIGITADORES')
insert into cl_errores (numero, severidad, mensaje) values (201328, 0, 'NO EXISTEN FUNCIONARIO AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (203082, 1, 'ERROR EN CREACION DE AUTORIZANTE DE NOTAS DEBITO / CREDITO')
insert into cl_errores (numero, severidad, mensaje) values (203083, 1, 'ERROR EN CREACION DE EJECUTOR DE NOTAS DEBITO / CREDITO')
insert into cl_errores (numero, severidad, mensaje) values (203091, 0, 'YA EXISTE FUNCIONARIO AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (207037, 1, 'ERROR AL ELIMINAR REGISTRO DE FUNCIONARIO AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (207038, 1, 'ERROR AL ELIMINAR REGISTRO DE FUNCIONARIO EJECUTOR')
insert into cl_errores (numero, severidad, mensaje) values (207044, 0, 'EL USUARIO EJECUTOR YA SE ENCUENTRA INGRESADO CON EL MISMO AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (208047, 0, 'EL FUNCIONARIO EJECUTOR NO PUDE SER AUTORIZANTE DE EL MISMO')
insert into cl_errores (numero, severidad, mensaje) values (101010, 0, 'Departamento no existe')
insert into cl_errores (numero, severidad, mensaje) values (201329, 0, 'FUNCIONARIO NO ES AUTORIZANTE')
insert into cl_errores (numero, severidad, mensaje) values (203005, 1, 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO')
insert into cl_errores (numero, severidad, mensaje) values (355039, 1, 'ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR')
insert into cl_errores (numero, severidad, mensaje) values (201004, 1, 'CUENTA NO EXISTE')
insert into cl_errores (numero, severidad, mensaje) values (201030, 1, 'CAUSA NO EXISTE')
insert into cl_errores (numero, severidad, mensaje) values (201330, 0, 'FUNCIONARIO NO ESTA DEFINIDO COMO EJECUTOR DE ND/NC')
insert into cl_errores (numero, severidad, mensaje) values (201332, 1, 'CAUSA NO PERMITIDA EN ND/NC POR TERMINAL ADMINISTRATIVA')
insert into cl_errores (numero, severidad, mensaje) values (205000, 1, 'ERROR EN ACTUALIZACION DE CAJERO REMOTO')
insert into cl_errores (numero, severidad, mensaje) values (351088, 1, 'TRANSACCION DE NOTA DE DEBITO / CREDITO NO PUEDE SER REVERSADA')
insert into cl_errores (numero, severidad, mensaje) values (353035, 1, 'ERROR AL INSERTAR REGISTRO DE AUTORIZACION DE NOTA CREDITO / NOTA DEBITO')
insert into cl_errores (numero, severidad, mensaje) values (357015, 1, 'ERROR EN ELIMINACION DE REGISTRO DE AUTORIZACION DE NOTA CREDITO / NOTA DEBITO')
go

insert into cl_errores (numero, severidad, mensaje) values (357020, 1, 'ERROR AL CREAR UNA TABLA')
insert into cl_errores (numero, severidad, mensaje) values (357021, 1, 'ERROR AL ELIMINAR UNA TABLA')
insert into cl_errores (numero, severidad, mensaje) values (357022, 1, 'ERROR AL CONSULTAR EXISTENCIA DE OBJETO')
insert into cl_errores (numero, severidad, mensaje) values (357023, 1, 'ERROR AL EJECUTAR EL BCP')
insert into cl_errores (numero, severidad, mensaje) values (357024, 1, 'ESTE PROCESO SE EJECUTA TRIMESTRALMENTE')
insert into cl_errores (numero, severidad, mensaje) values (357025, 1, 'NO EXISTE SENTENCIA A EJECUTAR')
insert into cl_errores (numero, severidad, mensaje) values (161724, 0, 'FONDOS DE LA CUENTA INSUFICIENTES')
go

insert into cl_errores (numero, severidad, mensaje) values (357027, 0, 'TRANSACCION NO VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357028, 0, 'CUENTA COBIS Y CUENTA MIGRADA TIENEN VALORES NULOS')
insert into cl_errores (numero, severidad, mensaje) values (357029, 0, 'CUENTA MIGRADA NO ESTÁ RELACIONADA CON CUENTA COBIS')
insert into cl_errores (numero, severidad, mensaje) values (357030, 0, 'CHEQUE NO CORRESPONDE A TRANSACCION VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357031, 0, 'VALOR DE LA TRANSACCION NO VALIDO')
insert into cl_errores (numero, severidad, mensaje) values (357032, 0, 'VALOR DE CHEQUES NO COINCIDE CON LA SUMA DEL DETALLE DE CHEQUES')
insert into cl_errores (numero, severidad, mensaje) values (357033, 0, 'CAUSA ES MANDATORIA  PARA N/D Y N/C')
insert into cl_errores (numero, severidad, mensaje) values (357034, 0, 'MONTO EN CHEQUE NO ES VALIDO PARA LAS TRANSACCIONES: RETIRO, ND Y NC')
insert into cl_errores (numero, severidad, mensaje) values (357035, 0, 'ERROR AL INSERTAR EN EL LOG DE ERRORES')
insert into cl_errores (numero, severidad, mensaje) values (357036, 0, 'ERROR AL ACTUALIZAR ESTADO DE UNO O VARIOS REGISTROS')
insert into cl_errores (numero, severidad, mensaje) values (357037, 0, 'CODIGO DEL BANCO NO ES VALIDO')
insert into cl_errores (numero, severidad, mensaje) values (357038, 0, 'ERROR AL INSERTAR EL NUMERO DE CUENTA COBIS EN EL REGISTRO')
insert into cl_errores (numero, severidad, mensaje) values (357039, 0, 'FECHA DE EMISION NO VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357040, 0, 'CHEQUE REPETIDO')
insert into cl_errores (numero, severidad, mensaje) values (357041, 0, 'ORIGEN DE REMESAS NO ES VALIDO. VALIDAR CATALOGO')
insert into cl_errores (numero, severidad, mensaje) values (357042, 0, 'ORIGEN DE REMESAS ES VALIDO SOLO PARA DEPOSITOS EN EFECTIVO')

go

insert into cl_errores (numero, severidad, mensaje) values (357043, 0, 'ERROR AL INSERTAR DATOS DE LA TRANSACCION')
insert into cl_errores (numero, severidad, mensaje) values (357044, 0, 'PARAMETRO TOTAL DE DEPOSITO NO COINCIDE CON SUMA DE VALORES ENVIADOS')
insert into cl_errores (numero, severidad, mensaje) values (357045, 0, 'PARAMETRO FECHA ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357046, 0, 'PARAMETRO FILIAL ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357047, 0, 'PARAMETRO SECUENCIAL Y SECUENCIAL BRANCH SON MANDATORIOS')
insert into cl_errores (numero, severidad, mensaje) values (357048, 0, 'NO EXISTEN CHEQUES VALIDOS PARA ESTA TRANSACCION')
insert into cl_errores (numero, severidad, mensaje) values (357049, 0, 'PARAMETRO SECUENCIAL DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357050, 0, 'PARAMETRO CODIGO DE BANCO DEL CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357051, 0, 'PARAMETRO CUENTA DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357052, 0, 'PARAMETRO NUMERO DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357053, 0, 'PARAMETRO FECHA DE EMISION DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357054, 0, 'NO EXISTE DEPOSITO CORRESPONDIENTE AL SECUENCIAL')
insert into cl_errores (numero, severidad, mensaje) values (357055, 0, 'ERROR AL EJECUTAR INTERFASE')
insert into cl_errores (numero, severidad, mensaje) values (357056, 0, 'YA EXISTE DEPOSITO INGRESADO CON SECUENCIAL')
insert into cl_errores (numero, severidad, mensaje) values (357567, 0, 'PRODUCTO BANCARIO NO PERMITE ACTIVACION')
insert into cl_errores (numero, severidad, mensaje) values (357573, 0, 'DEPOSITO DE APORTE SOCIAL NO PUEDE SER MAYOR A MONTO APORTE SOCIAL')
insert into cl_errores (numero, severidad, mensaje) values (357560, 0, 'RANGO DE FECHAS EXCEDEN EL MAXIMO DE DIAS PERMITIDOS PARA LA CONSULTA')

go

