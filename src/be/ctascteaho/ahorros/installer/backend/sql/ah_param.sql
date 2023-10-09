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
/*    20/Jul/2016       Eduardo Williams AHO-H77223                     */
/*    22/Jul/2016       Jorge Salazar    AHO-H77275                     */
/*    08/Ago/2016       Jorge Salazar    AHO-H79807                     */
/*    08/Ago/2016       Juan Tagle       AHO-H79806                     */
/*    15/Sep/2016       DFu              AHO-H80488                     */
/************************************************************************/
use cobis
go

print '---------> Parametros Generales de Ahorros -- ve_version'
delete from ve_version 
 where ve_producto = 4 
   and ve_archivo  = 'Tadmin.exe' 
   and ve_oficina in (1,7020)

insert into ve_version (ve_producto, ve_archivo, ve_oficina, ve_numero1, ve_numero2, ve_numero3, ve_fecha_mod, ve_usuario, ve_proposito) 
values (4, 'Tadmin.exe', 1, 3, 6, 42, getdate(), 'admuser', 'PRU') 

insert into ve_version (ve_producto, ve_archivo, ve_oficina, ve_numero1, ve_numero2, ve_numero3, ve_fecha_mod, ve_usuario, ve_proposito)
values (4, 'Tadmin.exe', 7020, 3, 6, 42, getdate(), 'admuser', 'PRU') 

go

print '---------> Parametros Generales de Ahorros'
go

delete cl_parametro
	where pa_producto = 'AHO'
	and pa_nemonico not in ('PAHCT', 'PAHPR', 'PCANOR', 'PCAME', 'PCAASO', 'PCAASA')
go

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('IDENTIFICADOR UDIS', 'IUDI', 'C', 'UDI', 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo,  pa_int, pa_producto)
VALUES ('PROXIMIDAD MAYORIA DE EDAD(DIAS)', 'PRXMYE', 'I',  6,  'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('AREA CONTABLE PARA AHORROS', 'ACA', 'S', NULL, NULL, 31, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MINIMO RETIRO VENTANILLA AHO', 'AHMCRV', 'M', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 'AHO')


--insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
--values ('BASE DIARIA INTERES PARA CALCULO DE RETENCION', 'BINCR', 'M', NULL, NULL, NULL, NULL, 1400.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CODIGO BANCAMIA ANTE LA SUPERFINANCIERA', 'BMIASF', 'T', NULL, 52, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CANTIDAD DE CUENTAS PRODUCTO AHORRA MAS', 'CAAHMA', 'I', NULL, NULL, NULL, 2, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PRODUCTO AHORRAMIA', 'CAHO', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAMBIO CATEGORIA CONTRACTUAL', 'CAMCAT', 'C', 'P', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CANTIDAD DE MOVIMIENTOS', 'CANMOV', 'I', NULL, NULL, NULL, 5, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CANTIDAD DE CUENTAS PRODUCTO SUPER CASH', 'CASUCA', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CANTIDAD DE CUENTAS PRODUCTO SUPER PLUS', 'CASUPL', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAUSAL CIERRE CTAHO PROCESO AUTOMATICO SALDAR CUENTAS INACTIVAS', 'CAUT', 'C', 12, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PARAMETRO DE COBRO DE COMISION BANCA MOVIL', 'CCBM', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAUSAL CIERRE DECISION CLIENTE', 'CLI', 'C', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CODIGO DE CLIENTE GENERICO CTA AHO DE NAVIDAD', 'CLINAV', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CONTROL LINEAS PENDIENTES AHORROS', 'CLPA', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('COMISION POR NO USO DEL CANAL BANCA MOVIL', 'CNUCBM', 'M', NULL, NULL, NULL, NULL, 5000.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE ANOS BACKUP INFORMACION', 'COEX', 'T', NULL, 12, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('INCUMPLIMIENTO POR SALDO', 'CUMSAL', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO CUOTAS PENALIZACION CTA AHO DE NAVIDAD', 'CUOPEN', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO CUOTAS PREMIO CTA AHO DE NAVIDAD', 'CUOPRE', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CANTIDAD DE UVR TRASLADO A LA DTN', 'CUVRT', 'I', NULL, NULL, NULL, 322, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE DECIMALES (AHO)', 'DCI', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIA EJECUCION PROCESO CONTA SEMANAL AHORROS', 'DCP', 'T', NULL, 5, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS PARA TRASLADO A LA DTN', 'DDTN', 'I', NULL, NULL, NULL, 360, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DEBUG PARA GENERA COSTOS', 'DEBUG', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DEVOLUCION DE FONDOS DE CUENTAS CERRADAS', 'DFCC', 'C', '046', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE DIAS LIMITE DE CONSULTA FRONTEND', 'DICO', 'T', NULL, 30, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE DECIMALES IMPUESTOS(AHO)', 'DIM', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS GRACIA COMISION INACTIVIDAD', 'DINA', 'I', NULL, NULL, NULL, 30, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS DE RETENCION', 'DIRE', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS PARA ENVIO DE CUENTAS AL TESORO NACIONAL', 'DPETN', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS PARA INACTIVACION DE CUENTAS POR NO MOVIMIENTO MONETARIO', 'DPINA', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS GRACIA CIERRE MASIVO SALDO CERO', 'DSL0', 'I', NULL, NULL, NULL, 90, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS GRACIA COMISION SALDO MINIMO', 'DSLM', 'I', NULL, NULL, NULL, 31, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS PARA REGISTRO DE FECHA DE ENVIAR A DTN', 'ENVDTN', 'I', NULL, NULL, NULL, 5, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CODIGO EMISION RETIRO EN CHEQUE', 'ERCHQ', 'C', '049', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PERIODO FINAL PARA APERTURA DE CUENTAS DE NAVIDAD', 'FEFACN', 'D', NULL, NULL, NULL, NULL, NULL, getdate(), NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PERIODO INICIAL PARA APERTURA DE CUENTAS DE NAVIDAD', 'FEIACN', 'D', NULL, NULL, NULL, NULL, NULL, getdate(), NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('FECHA PAGO DE CUOTAS GRATIS EN CUENTAS DE NAVIDAD', 'FEPACN', 'D', NULL, NULL, NULL, NULL, NULL, getdate(), NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('GENERACION OTP BANCA MOVIL', 'GOTP', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE GRUPOS DE TOTALES', 'GTO', 'T', NULL, 13, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('HABILITA CANAL CB RED POSICIONADA', 'HCBRPO', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TASA GMF', 'IGMF', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.004, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PERIODO EN MESES ANTES DE PASAR A INACTIVIDAD', 'INAA', 'S', NULL, NULL, 3, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('REPORTE NRO. DIAS MINIMO DE INACTIVIDAD CUENTAS AH', 'INACAH', 'I', NULL, NULL, NULL, 540, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MASCARA PARA CUENTAS DE AHORROS', 'KOP', 'C', '####-##-#####-#', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LONGITUD PARA CUENTAS DE AHORROS', 'LOP', 'T', NULL, 12, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE DIAS PARA MULTA POR CIERRE', 'MCI', 'S', NULL, NULL, 365, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MINIMO PENSIONADO', 'MMEP', 'M', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MAXIMO DE INGRESO DE EFECTIVO MONEDA 0', 'MMI0', 'M', NULL, NULL, NULL, NULL, 5000000.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MAXIMO DE SALIDA DE EFECTIVO MONEDA 0', 'MMS0', 'M', NULL, NULL, NULL, NULL, 999999999.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MAXIMO DE SALIDA DE EFECTIVO MONEDA 1', 'MMS1', 'M', NULL, NULL, NULL, NULL, 5000.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO PARA EXCLUSIVIDAD DEL PASIVO', 'MOEXPA', 'M', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MODULO PARA CUENTAS DE AHORROS', 'MOP', 'T', NULL, 11, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MANEJO CHEQUES PROPIOS', 'MPROP', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MANEJO CHEQUES REMESAS', 'MREM', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MINIMO PARA RETENCION EN', 'MRTF', 'M', NULL, NULL, NULL, NULL, 1400.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE ANOS CONSULTA', 'NANOS', 'T', NULL, 4, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAUSA ND POR EMBARGOS', 'NDAHO', 'C', 9, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAUSAL ND NO USO DEL CANAL BANCA MOVIL', 'NDNUBM', 'C', 46, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAUSAL ND COBRO RECARGA BANCAMOVIL', 'NDREC', 'C', 39, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO MINIMO DE LINEAS PENDIENTES PARA CONSOLIDAR', 'NMLP', 'S', NULL, NULL, 2, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO PUBLICACIONES ANULACION LIBRETA', 'NPA', 'T', NULL, 0, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE TRANSACCIONES DE ESTADO DE CUENTA', 'NTEA', 'S', NULL, NULL, 60, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('OFICINA OPERACION CENTRALIZADA', 'OCCAH', 'S', NULL, NULL, 1, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CONSECUTIVO PARA TRASLADO A LA DTN', 'ODTN', 'I', NULL, NULL, NULL, 13, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('OFICINA MATRIZ', 'OMAT', 'S', NULL, NULL, 1, NULL, NULL, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CODIGO PRODUCTO AHORRO PROGRESIVO', 'PAP', 'T', NULL, 0, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA GENERACION PLANO EXTRACTOS AHORROS', 'PATHEA', 'C', 'F:\vbatch\ahorros\listados\', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CODIGO DE PRODUCTO BANCARIO AGROBENEFICIO', 'PBAB', 'S', NULL, NULL, 1, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PRODUCTO BANCARIO AHORRA MAS', 'PBAHMA', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PRODUCTO BANCARIO PARA LAS REDES', 'PBCB', 'S', NULL, NULL, 0, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PRODUCTOS BANCARIOS DE NAVIDAD', 'PBNA', 'C', '8,9', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PRODUCTO BANCARIO PLANILLA', 'PBPGB', 'I', NULL, NULL, NULL, 6, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PRODUCTO BANCARIO SUPER CASH', 'PBSC', 'I', NULL, NULL, NULL, 11, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PRODUCTO BANCARIO SUPER PLUS', 'PBSP', 'I', NULL, NULL, NULL, 10, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PERFIL CAUSACION AHORROS', 'PCAU', 'C', 'CAU_AHO', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PERIODO DE ENVIO DTN', 'PERDTN', 'S', NULL, NULL, 3, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAUSAL PROCESO MASIVO ABONO CARTERA DESDE CTAS INACTIVAS', 'PMASA', 'C', 44, NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PESOS PARA CUENTAS DE AHORROS', 'POP', 'C', '76543276543', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CONSECUTIVO PARA REINTEGRO A LA DTN', 'RCDTN', 'I', NULL, NULL, NULL, 7, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS PARA RETROCEDER PROYECCION REINTEGRO DTN', 'RETDTN', 'T', NULL, 11, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS PROYECTADOS PARA REINTEGRO DTN', 'RTODTN', 'I', NULL, NULL, NULL, 6, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA ARCHIVOS RBM', 'RUTRBM', 'C', 'F:\Vbatch\Ahorros\RBM\', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SEMANAS REQUERIDAS PARA PAGO CUENTAS DE NAVIDAD', 'SECOCN', 'T', NULL, 48, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CUOTAS GRATIS CUENTAS DE NAVIDAD C/COMPLETAS', 'SEMGCN', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SALDO MINIMO COBRO SUSPENSOS', 'SMCSU', 'M', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SALDO MINIMO DE EMBARGO CUENTAS DE AHORROS', 'SMEAH', 'M', NULL, NULL, NULL, NULL, 1000.00, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TASA DE BONIFICACION DE AHORRO INFANTIL 30 DIAS', 'TBAIN1', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.25, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TASA DE BONIFICACION DE AHORRO INFANTIL 60 DIAS', 'TBAIN2', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.5, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TASA DE BONIFICACION DE AHORRO INFANTIL 90 DIAS', 'TBAIN3', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TASA DE BONIFICACION ESPECIAL DE AHORRO INFANTIL 30 DIAS', 'TBEAI1', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.15, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TASA DE BONIFICACION ESPECIAL DE AHORRO INFANTIL 60 DIAS', 'TBEAI2', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.25, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TASA DE BONIFICACION ESPECIAL DE AHORRO INFANTIL 90 DIAS', 'TBEAI3', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.4, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TRANSACCION COBRO GMF BANCO', 'TGMFBA', 'I', NULL, NULL, NULL, 373, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TIEMPO PARA INMOVILIZACION (MESES)', 'TIN', 'T', NULL, 6, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TIEMPO MAXIMO ACTIVACION CUENTA', 'TMAC', 'I', NULL, NULL, NULL, 15, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CUENTAS PLANILLA ACH', 'TPL', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TIPO PROCESO MASIVO. C->CANCELA D->DEBITA', 'TPROM', 'C', 'D', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VALOR PROMEDIO CONSULTA DE OPERACIONES SUPERIORES A UN MONTO', 'VPSA', 'M', NULL, NULL, NULL, NULL, 400000.00, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Visualizar campo cheques propios en deposito de ahorros', 'VCHPRO', 'C', 'N', null, null, null, null, null, null, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Visualizar campo cheques remesas en deposito de ahorros', 'VCHREM', 'C', 'N', null, null, null, null, null, null, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VALOR CONVERSION UDIS', 'UDIS', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 1500, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('DIAS MAXIMOS CONSULTA MOVIMIENTOS', 'MVMXDD', 'T', NULL, 45, NULL, NULL, NULL, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('APLICACION DE EXCENCION ISR', 'AEXISR', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('NUMERO DE ANUALIDADES ISR', 'NAISR', 'T', NULL, 5, NULL, NULL, NULL, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('COBRO IMPUESTO A LA RENTA ISR', 'CIISR', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('PORCENTAJE ANUAL IMPUESTO A LA RENTA ISR','PANISR','F', NULL, NULL, NULL, NULL, NULL, NULL, 0.5, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('BASE DIARIA INTERES PARA CALCULO DE RETENCION','BINCR','M', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CALCULO PROVISION DIARIA', 'PRVDIA', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('PARAMETRO OCULTAR FUNCIONALIDADES VERSION COLOMBIA', 'OCUCOL', 'C', 'S', 'AHO')
  
INSERT INTO cobis..cl_parametro (pa_parametro,                pa_nemonico, pa_tipo,  pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VALIDACION MAXIMO TRANSACCIONES MONETARIAS', 'MAXVM',        'M',     NULL,        NULL,       NULL,   NULL,      10000,     NULL,       NULL,      'AHO')

INSERT INTO cobis..cl_parametro (pa_parametro          , pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EL SISTEMA TIENE CUENTAS MIGRADAS (S=SI,N=NO)', 'CTAMIG'   , 'C'    , 'S'    , NULL      , NULL       , NULL  , NULL    , NULL       , NULL    , 'AHO')

declare @w_ente_cobis int
SELECT  @w_ente_cobis = en_ente FROM cobis..cl_ente  WHERE en_nombre = 'BANCO COBIS'

delete cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico in ('ENCO', 'EMCO', 'PWCO')
    
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ENTE BANCO COBIS', 'ENCO', 'I', NULL, NULL, NULL, @w_ente_cobis, NULL, NULL, NULL, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EMAIL BANCO COBIS', 'EMCO', 'C', 'aclaracionescmv@cobiscorp.com', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PAGINA WEB BANCO COBIS', 'PWCO', 'C', 'www.cobis.com.ec', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TRANSACCION BLOQUEO CONTABILIZABLE', 'TRCBLO', 'I', NULL, NULL, NULL, 217 , NULL, NULL, NULL, 'AHO')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TRANSACCION DESBLOQUEO CONTABILIZABLE', 'TRCBDB', 'I', NULL, NULL, NULL, 218 , NULL, NULL, NULL, 'AHO')

GO


