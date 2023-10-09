/************************************************************************/
/*      Archivo:            ah_param.sql                                */
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
/*      Este programa realiza la creacion de los parametros generales   */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cobis
go

print 'Parametros Generales de Ahorros'
go

delete cl_parametro
where pa_producto = 'AHO'
go


INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('AREA CONTABLE PARA AHORROS', 'ACA', 'S', NULL, NULL, 31, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MINIMO RETIRO VENTANILLA AHO', 'AHMCRV', 'M', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BASE DIARIA INTERES PARA CALCULO DE RETENCION', 'BINCR', 'M', NULL, NULL, NULL, NULL, 1400.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO BANCAMIA ANTE LA SUPERFINANCIERA', 'BMIASF', 'T', NULL, 52, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CANTIDAD DE CUENTAS PRODUCTO AHORRA MAS', 'CAAHMA', 'I', NULL, NULL, NULL, 2, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO AHORRAMIA', 'CAHO', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CAMBIO CATEGORIA CONTRACTUAL', 'CAMCAT', 'C', 'P', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CANTIDAD DE MOVIMIENTOS', 'CANMOV', 'I', NULL, NULL, NULL, 5, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CANTIDAD DE CUENTAS PRODUCTO SUPER CASH', 'CASUCA', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CANTIDAD DE CUENTAS PRODUCTO SUPER PLUS', 'CASUPL', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CAUSAL CIERRE CTAHO PROCESO AUTOMATICO SALDAR CUENTAS INACTIVAS', 'CAUT', 'C', 12, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PARAMETRO DE COBRO DE COMISION BANCA MOVIL', 'CCBM', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CAUSAL CIERRE DECISION CLIENTE', 'CLI', 'C', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DE CLIENTE GENERICO CTA AHO DE NAVIDAD', 'CLINAV', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CONTROL LINEAS PENDIENTES AHORROS', 'CLPA', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('COMISION POR NO USO DEL CANAL BANCA MOVIL', 'CNUCBM', 'M', NULL, NULL, NULL, NULL, 5000.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE ANOS BACKUP INFORMACION', 'COEX', 'T', NULL, 12, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('INCUMPLIMIENTO POR SALDO', 'CUMSAL', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO CUOTAS PENALIZACION CTA AHO DE NAVIDAD', 'CUOPEN', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO CUOTAS PREMIO CTA AHO DE NAVIDAD', 'CUOPRE', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CANTIDAD DE UVR TRASLADO A LA DTN', 'CUVRT', 'I', NULL, NULL, NULL, 322, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE DECIMALES (AHO)', 'DCI', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIA EJECUCION PROCESO CONTA SEMANAL AHORROS', 'DCP', 'T', NULL, 5, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PARA TRASLADO A LA DTN', 'DDTN', 'I', NULL, NULL, NULL, 360, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DEBUG PARA GENERA COSTOS', 'DEBUG', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DEVOLUCION DE FONDOS DE CUENTAS CERRADAS', 'DFCC', 'C', '046', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE DIAS LIMITE DE CONSULTA FRONTEND', 'DICO', 'T', NULL, 30, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE DECIMALES IMPUESTOS(AHO)', 'DIM', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS GRACIA COMISION INACTIVIDAD', 'DINA', 'I', NULL, NULL, NULL, 30, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS DE RETENCION', 'DIRE', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PARA ENVIO DE CUENTAS AL TESORO NACIONAL', 'DPETN', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PARA INACTIVACION DE CUENTAS POR NO MOVIMIENTO MONETARIO', 'DPINA', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS GRACIA CIERRE MASIVO SALDO CERO', 'DSL0', 'I', NULL, NULL, NULL, 90, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS GRACIA COMISION SALDO MINIMO', 'DSLM', 'I', NULL, NULL, NULL, 31, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PARA REGISTRO DE FECHA DE ENVIAR A DTN', 'ENVDTN', 'I', NULL, NULL, NULL, 5, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO EMISION RETIRO EN CHEQUE', 'ERCHQ', 'C', '049', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PERIODO FINAL PARA APERTURA DE CUENTAS DE NAVIDAD', 'FEFACN', 'D', NULL, NULL, NULL, NULL, NULL, 'Feb 15 2005 12:00AM', NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PERIODO INICIAL PARA APERTURA DE CUENTAS DE NAVIDAD', 'FEIACN', 'D', NULL, NULL, NULL, NULL, NULL, 'Nov 15 2004 12:00AM', NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FECHA PAGO DE CUOTAS GRATIS EN CUENTAS DE NAVIDAD', 'FEPACN', 'D', NULL, NULL, NULL, NULL, NULL, 'Nov 30 2005 12:00AM', NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('GENERACION OTP BANCA MOVIL', 'GOTP', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE GRUPOS DE TOTALES', 'GTO', 'T', NULL, 13, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('HABILITA CANAL CB RED POSICIONADA', 'HCBRPO', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TASA GMF', 'IGMF', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.004, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PERIODO EN MESES ANTES DE PASAR A INACTIVIDAD', 'INAA', 'S', NULL, NULL, 3, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('REPORTE NRO. DIAS MINIMO DE INACTIVIDAD CUENTAS AH', 'INACAH', 'I', NULL, NULL, NULL, 540, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MASCARA PARA CUENTAS DE AHORROS', 'KOP', 'C', '####-##-#####-#', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('LONGITUD PARA CUENTAS DE AHORROS', 'LOP', 'T', NULL, 12, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE DIAS PARA MULTA POR CIERRE', 'MCI', 'S', NULL, NULL, 365, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MINIMO PENSIONADO', 'MMEP', 'M', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MAXIMO DE INGRESO DE EFECTIVO MONEDA 0', 'MMI0', 'M', NULL, NULL, NULL, NULL, 5000000.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MAXIMO DE SALIDA DE EFECTIVO MONEDA 0', 'MMS0', 'M', NULL, NULL, NULL, NULL, 999999999.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MAXIMO DE SALIDA DE EFECTIVO MONEDA 1', 'MMS1', 'M', NULL, NULL, NULL, NULL, 5000.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO PARA EXCLUSIVIDAD DEL PASIVO', 'MOEXPA', 'M', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MODULO PARA CUENTAS DE AHORROS', 'MOP', 'T', NULL, 11, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MANEJO CHEQUES PROPIOS', 'MPROP', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MANEJO CHEQUES REMESAS', 'MREM', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MINIMO PARA RETENCION EN', 'MRTF', 'M', NULL, NULL, NULL, NULL, 1400.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE ANOS CONSULTA', 'NANOS', 'T', NULL, 4, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CAUSA ND POR EMBARGOS', 'NDAHO', 'C', 9, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CAUSAL ND NO USO DEL CANAL BANCA MOVIL', 'NDNUBM', 'C', 46, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CAUSAL ND COBRO RECARGA BANCAMOVIL', 'NDREC', 'C', 39, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO MINIMO DE LINEAS PENDIENTES PARA CONSOLIDAR', 'NMLP', 'S', NULL, NULL, 2, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO PUBLICACIONES ANULACION LIBRETA', 'NPA', 'T', NULL, 0, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE TRANSACCIONES DE ESTADO DE CUENTA', 'NTEA', 'S', NULL, NULL, 60, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICINA OPERACION CENTRALIZADA', 'OCCAH', 'S', NULL, NULL, 1, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CONSECUTIVO PARA TRASLADO A LA DTN', 'ODTN', 'I', NULL, NULL, NULL, 13, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICINA MATRIZ', 'OMAT', 'S', NULL, NULL, 1, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO BANCARIO CONTRACTUAL', 'PAHCT', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO BANCARIO PROGRESIVO', 'PAHPR', 'I', NULL, NULL, NULL, 3, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO PRODUCTO AHORRO PROGRESIVO', 'PAP', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RUTA GENERACION PLANO EXTRACTOS AHORROS', 'PATHEA', 'C', 'F:\vbatch\ahorros\listados\', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DE PRODUCTO BANCARIO AGROBENEFICIO', 'PBAB', 'S', NULL, NULL, 1, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO BANCARIO AHORRA MAS', 'PBAHMA', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO BANCARIO PARA LAS REDES', 'PBCB', 'S', NULL, NULL, 5, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTOS BANCARIOS DE NAVIDAD', 'PBNA', 'C', '8,9', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO BANCARIO PLANILLA', 'PBPGB', 'I', NULL, NULL, NULL, 6, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO BANCARIO SUPER CASH', 'PBSC', 'I', NULL, NULL, NULL, 11, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO BANCARIO SUPER PLUS', 'PBSP', 'I', NULL, NULL, NULL, 10, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PERFIL CAUSACION AHORROS', 'PCAU', 'C', 'CAU_AHO', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PERIODO DE ENVIO DTN', 'PERDTN', 'S', NULL, NULL, 3, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CAUSAL PROCESO MASIVO ABONO CARTERA DESDE CTAS INACTIVAS', 'PMASA', 'C', 44, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PESOS PARA CUENTAS DE AHORROS', 'POP', 'C', '76543276543', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CONSECUTIVO PARA REINTEGRO A LA DTN', 'RCDTN', 'I', NULL, NULL, NULL, 7, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PARA RETROCEDER PROYECCION REINTEGRO DTN', 'RETDTN', 'T', NULL, 11, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PROYECTADOS PARA REINTEGRO DTN', 'RTODTN', 'I', NULL, NULL, NULL, 6, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RUTA ARCHIVOS RBM', 'RUTRBM', 'C', 'F:\Vbatch\Ahorros\RBM\', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SEMANAS REQUERIDAS PARA PAGO CUENTAS DE NAVIDAD', 'SECOCN', 'T', NULL, 48, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CUOTAS GRATIS CUENTAS DE NAVIDAD C/COMPLETAS', 'SEMGCN', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SALDO MINIMO COBRO SUSPENSOS', 'SMCSU', 'M', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SALDO MINIMO DE EMBARGO CUENTAS DE AHORROS', 'SMEAH', 'M', NULL, NULL, NULL, NULL, 1000.00, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TASA DE BONIFICACION DE AHORRO INFANTIL 30 DIAS', 'TBAIN1', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.25, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TASA DE BONIFICACION DE AHORRO INFANTIL 60 DIAS', 'TBAIN2', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.5, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TASA DE BONIFICACION DE AHORRO INFANTIL 90 DIAS', 'TBAIN3', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TASA DE BONIFICACION ESPECIAL DE AHORRO INFANTIL 30 DIAS', 'TBEAI1', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.15, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TASA DE BONIFICACION ESPECIAL DE AHORRO INFANTIL 60 DIAS', 'TBEAI2', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.25, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TASA DE BONIFICACION ESPECIAL DE AHORRO INFANTIL 90 DIAS', 'TBEAI3', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.4, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TRANSACCION COBRO GMF BANCO', 'TGMFBA', 'I', NULL, NULL, NULL, 373, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIEMPO PARA INMOVILIZACION (MESES)', 'TIN', 'T', NULL, 6, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIEMPO MAXIMO ACTIVACION CUENTA', 'TMAC', 'I', NULL, NULL, NULL, 15, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CUENTAS PLANILLA ACH', 'TPL', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO PROCESO MASIVO. C->CANCELA D->DEBITA', 'TPROM', 'C', 'D', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
GO

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VALOR PROMEDIO CONSULTA DE OPERACIONES SUPERIORES A UN MONTO', 'VPSA', 'M', NULL, NULL, NULL, NULL, 400000.00, NULL, NULL, 'AHO')
GO

-- ------------
delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CEDU'
GO
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DOC. CEDULA EXTRANJERO', 'CEDU', 'C', 'XX', NULL, NULL, NULL, NULL, NULL, NULL, 'CTE')
GO
delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CEMP'
GO
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DOC. SOCIEDAD EXTRANJERA', 'CEMP', 'C', 'XX', NULL, NULL, NULL, NULL, NULL, NULL, 'CTE')
GO
delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='OMAT'
GO
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICINA MATRIZ ', 'OMAT', 'T', NULL,1, NULL, NULL, NULL, NULL, NULL, 'CTE')
GO
delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CCBA'
GO
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DE CLIENTE DEL BANCO', 'CCBA', 'I', NULL, NULL, NULL, 345785, NULL, NULL, NULL, 'CTE')
GO
