/*************************************************************************/
/*  Creacion del catalogo de referencia para la bSEQNOSase de datos      */
/*  COBIS:  -  CLIENTES                                                  */
/*************************************************************************/
use cobis
go


/****************************************************************/
/*                          PARAMETRO                           */
/****************************************************************/




/*******************CLI********************/
if exists (select 1 from cl_parametro where pa_producto='CLI' AND pa_nemonico='ICE')
  DELETE cl_parametro where pa_producto='CLI' AND pa_nemonico='ICE'

INSERT INTO cobis.dbo.cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('GRUPO ICE', 'ICE   ', 'I', NULL, NULL, NULL, 356, NULL, NULL, NULL, 'CLI')
GO


if exists (select 1 from cl_parametro where pa_producto='CLI' AND pa_nemonico='ICE')
  DELETE cl_parametro where pa_producto='CLI' AND pa_nemonico='GRPICE'

INSERT INTO cobis.dbo.cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('GRUPO INSTITUTO DE ELECTRICIDAD', 'GRPICE', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'CLI')
GO


/*******************MIS********************/
if exists (select 1 from cl_parametro where pa_producto='MIS')
  delete cl_parametro where pa_producto = 'MIS'
go



INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE GENERAL PEQUEÑOS PRODUCTORES', '001', 'C', '001', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE GENERAL PEQUEÑOS PRODUCTORES', '0017', 'C', '001', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO DE RESULTADOS PEQUEÑOS PRODUCTORES', '002', 'C', '002', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE GENERAL OTROS PRODUCTORES PERSONA NATURAL', '003', 'C', '003', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE GENERAL OTROS PRODUCTORES PERSONA JURIDICA', '004', 'C', '004', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO DE RESULTADOS OTROS PRODUCTORES PERSONA JURIDICA', '005', 'C', '005', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO DE RESULTADOS OTROS PRODUCTORES PERSONA NATURAL', '006', 'C', '006', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE GENERAL ENTES TERRITORIALES', '008', 'C', '008', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO DE ACTIVIDAD FINANC ECONOM Y SOCIAL ENTES TERRITORIALES', '009', 'C', '009', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE GENERAL PERSONAS NATURALES SECTOR NO AGROPECUARIO', '011', 'C', '011', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO DE RESULTADOS PERSONAS NATURALES SECTOR NO AGROPECUARIO', '012', 'C', '012', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FACTOR PARA CALCULO DEL 3X1000', '3XM', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.99700897300000002, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ANTIGUEDAD MINIMA DEL NEGOCIO PARA ACCEDER A CREDITO (MESES)', 'ANN', 'T', NULL, 10, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ACCION PROSPECTOS PARA CREDITO', 'APC', 'C', 'CPC', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE ACTIVOS Y PASIVOS DEUDOR', 'AYPD', 'C', '001', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE ACTIVOS CLIENTE PASIVAS ', 'BPACT', 'C', '005', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE INGRESOS CLIENTE PASIVAS ', 'BPING', 'C', '006', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CARGO RESPONSABLE DE REFERENCIACION', 'CARREF', 'S', NULL, NULL, 1611, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO CARGO PROMOTOR', 'CCP', 'I', NULL, NULL, NULL, 2071, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CIUDAD EMISION DOCUMENTO CLIENTE - MIG', 'CEM', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CONTROL FECHA REAL CB', 'CFRCB', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO ENTE RBM', 'CLRBM', 'I', NULL, NULL, NULL, 1717651, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CIUDAD NACIMIENTO CLIENTE - MIG', 'CNM', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DE PORCENTAJE DE PARTICIPACION ACCIONARIA', 'CPPAAC', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO RELACION DE CB', 'CRCNB', 'I', NULL, NULL, NULL, 207, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DEBUG WS', 'DEBWS', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DPTO EMISION DOCUMENTO CLIENTE - MIG', 'DEM', 'S', NULL, NULL, 0, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DESTINO DE REFERENCIACION', 'DESREF', 'C', 'OFICINA', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS RECALCITRANTE FATCA PER JURIDICA', 'DFTCAJ', 'I', NULL, NULL, NULL, 30, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS RECALCITRANTE FATCA PER NATURAL', 'DFTCAP', 'I', NULL, NULL, NULL, 90, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PARA ELIMIANAR ARCHIVOS .OUT DE PROCESOS MASIVOS.', 'DIABOU', 'I', NULL, NULL, NULL, 30, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DPTO NACIMIENTO CLIENTE - MIG', 'DNM', 'S', NULL, NULL, 0, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CARGO DIRECTOR DE OFICINA', 'DOF', 'S', NULL, NULL, 1608, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS VALIDACION PRODUCTOS REFERIDOS', 'DVPRD', 'I', NULL, NULL, NULL, 3, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO CIVIL CASADO', 'ECC', 'C', 'CA', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EJECUTIVO DE MICROFINANZAS', 'EJEMI', 'S', NULL, NULL, 1609, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('HABILITAR FUNCIONALIDAD FATCA JURIDICA', 'FATPJ', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('HABILITAR FUNCIONALIDAD FATCA NATURAL', 'FATPN', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FECHA ULTIMA ELIMINACIONDE ARCHIVOS .OUT DE PROCESOS MASIVOS.', 'FECELM', 'F', NULL, NULL, NULL, NULL, NULL, '2014-10-22 09:38:26.033', NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FECHA PARA REPROCESO MIR OPBATCH', 'FECMIR', 'D', NULL, NULL, NULL, NULL, NULL, '2012-05-02', NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FECHA ORIGEN PARA REPROCESO MIR OPBATCH', 'FEMIRB', 'D', NULL, NULL, NULL, NULL, NULL, '2012-04-28', NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NOTIFICADOR CORREO', 'FTPSRV', 'C', '172.16.11.114', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DE DIRECCION PARA CONSULTAS GEOGRAFICAS', 'GEO', 'C', '005', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('HORA FINALIZACION PROCESOS MASIVOS', 'HFINMS', 'C', '18:00', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('BALANCE INGRESOS Y EGRESOS DEUDOR', 'IYED', 'C', '002', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SARLAFT - LISTAS NO RESTRICTIVAS', 'LNRES', 'C', '002', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SARLAFT - LISTAS RESTRICTIVAS', 'LRES', 'C', '001', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO CDTS REFERIDOS', 'MCDTRD', 'M', NULL, NULL, NULL, NULL, 500000, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MINIMO DIARIO MONEDA DOLAR PARA REPORTE SIPLA', 'MDD', 'M', NULL, NULL, NULL, NULL, 10000, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO EN SMMLV QUE DEFINE CENTRAL DE RIESGO A CONSULTAR', 'MDEFCO', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 4, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MINIMO DIARIO MONEDA LOCAL PARA REPORTE SIPLA', 'MDL', 'M', NULL, NULL, NULL, NULL, 10000000, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FLAG INICIO MIGRACION', 'MIG', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MINIMO MENSUAL MONEDA DOLAR PARA REPORTE SIPLA', 'MMD', 'M', NULL, NULL, NULL, NULL, 50000, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MMI DIAN LEY 1066', 'MMIDIA', 'M', NULL, NULL, NULL, NULL, 16108750, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MMI NO APLICA', 'MMINAP', 'M', 'null', NULL, NULL, NULL, 0, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MMI SUPERINTENDENCIA', 'MMISUP', 'M', NULL, NULL, NULL, NULL, 31298237, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO MINIMO MENSUAL MONEDA LOCAL PARA REPORTE SIPLA', 'MML', 'M', NULL, NULL, NULL, NULL, 50000000, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONEDA BASE 1', 'MON1', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONEDA BASE 2', 'MON2', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MERCADO OBJETIVO PARA ACTIVIDADES FINAGRO', 'MOPAF', 'C', 'R', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIRECTORIO SALIDA DE OUTDIR DE PROCESOS MSV.', 'MSVDIR', 'C', 'MASIVO', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MIGRACION TIPO CATEGORIA', 'MTC', 'C', '000', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DIRECCION - MIG', 'MTD', 'C', '009', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO MAXIMO DE INTENTOS DE CONSULTA A CIFIN', 'MXINCF', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO MAXIMO DE INTENTOS DE CONSULTA A DATACREDITO', 'MXINDC', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MAXIMO NUMERO DE SOCIOS A VALIDAR', 'MXSOVA', 'S', NULL, NULL, 20, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DIAS INACTIVIDAD REFERIDO', 'NDIRFD', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DIAS INACTIVIDAD REFERENTE', 'NDIRFT', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE DOCUMENTO POR DEFECTO PARA LAS REF. INHIBITORIAS', 'NDRI', 'C', '9991', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE DIAS DE MORA - CARTERA VIGENTE', 'NDSM', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NOMBRE DEL ARCHIVO DE ENVIO DE CORREO', 'NOMCOE', 'C', 'sql_mail', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('GENERAR NOTIFICACIONES FINAGRO', 'NOTFIN', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('GENERAR NOTIFICACIONES DE CARGAS MASIVAS', 'NOTMAS', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SERVIDOR DE NOTIFICATION SERVER', 'NOTSRV', 'C', 'F:', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE SALARIOS MINIMOS', 'NSMV', 'I', NULL, NULL, NULL, 50000, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OCUPACION EMPLEADO', 'OCE', 'C', '001', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICINA DEFAULT BONOS', 'ODB', 'I', NULL, NULL, NULL, 28, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICINA ASOCIADA AL CALL CENTER', 'OFCACE', 'S', NULL, NULL, 4069, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICIAL SARLAFT DEFAULT', 'OFDEF', 'S', NULL, NULL, 2, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICINA-FUNCIONARIO', 'OFIFUN', 'I', NULL, NULL, NULL, 107, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OCUPACION INDEPENDIENTE', 'OIND', 'C', '004', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICIAL POR DEFAULT', 'OPD', 'S', NULL, NULL, 4, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DEL PAIS LOCAL', 'PALOC', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PATH ARCHIVO DE CORREOS FUNCIONARIOS', 'PATCOR', 'C', 'F:\VBATCH\CLIENTES\ARCHIVOS\', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RUTA DE PUBLICACION PLANO EXTRACTOS IMPRESION', 'PATHEC', 'C', '\vbatch\clientes\listados\', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RUTA DE PUBLICACION PLANO EXTRACTOS IMPRESION', 'PATHEI', 'C', '\VBatch\Clientes\Listados\', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PATH FUENTE Marca_C12', 'PATHMA', 'C', '\VBatch\Clientes\Listados\', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE PRODUCTOS DEL BANCO', 'PBAN', 'I', NULL, NULL, NULL, 5, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PLAZO DIAS CDTS REFERIDOS', 'PCDTRD', 'I', NULL, NULL, NULL, 90, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PAIS EMISION DOCUMENTO CLIENTE - MIG', 'PEM', 'S', NULL, NULL, 0, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PAIS NACIMIENTO CLIENTE - MIG', 'PNM', 'S', NULL, NULL, 0, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EMAIL POR DEFECTO PARA REDEBAN', 'RBMCE', 'C', 'cliente@bancamia.com.co', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('REFERIDO AMIGO', 'REFA', 'C', 'REA', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('REFERIDO EMPLEADO', 'REFE', 'C', 'RE', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('REFERIDO FAMILIAR', 'REFF', 'C', 'REF', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION APODEDADO TUTOR', 'RELAT', 'I', NULL, NULL, NULL, 206, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RESPUESTA SIMULADA DE HOMINI', 'RESHOM', 'C', '1', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE LINEAS DE ALIANZA', 'RESLIA', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION ACCIONISTA NATURAL', 'RL1', 'S', NULL, NULL, 201, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION ACCIONISTA JURIDICO', 'RL2', 'S', NULL, NULL, 202, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION JUNTA DIRECTIVA PRINCIPAL', 'RL3', 'S', NULL, NULL, 203, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION JUNTA DIRECTIVA SUPLENTE', 'RL4', 'S', NULL, NULL, 204, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION REPRESENTANTE LEGAL', 'RL5', 'S', NULL, NULL, 205, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ROL PARA USUARIOS DE SINCRONIZACION', 'RUUSP', 'T', NULL, 71, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SEGIMIENTO MASIVO CREACION CLIENTES', 'SEGMSV', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SALARIO MINIMO LEGAL VIGENTE', 'SMLV', 'M', NULL, NULL, NULL, NULL, 644350, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SP GENERICO COBIS', 'SPGENE', 'C', 'cob_cartera..sp_sec_aseg_univ', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SERVIDOR PARA EXTRACTOS IMPRESOS', 'SRVEXT', 'C', 'F:', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SERVIDOR Marca_C12', 'SRVMAR', 'C', 'F:', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIEMPO EN MINUTOS PARA PRESENTAR ALERTA DE TAREAS PENDIENTES', 'TALERT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 5, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO CLIENTE CORRESPONSAL BANCARIO POSICIONADO', 'TCCBP', 'C', '006', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE CLIENTE CB', 'TCCNB', 'C', '005', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TRIMESTRE ACTUAL CIFIN', 'TCIF', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIEMPO CANCELACION MESES REFERIDOS', 'TCMRD', 'I', NULL, NULL, NULL, 12, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO CLIENTE PASIVAS ', 'TCPAS', 'C', '010', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DIRECCION APARTADO AEREO-CORRESPONDENCIA', 'TDA', 'C', '004', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DIRECCION EMPRESA-LABORAL', 'TDE', 'C', '003', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DIRECCION EMPRESA', 'TDEM', 'C', '003', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DIRECCION NEGOCIO', 'TDN', 'C', '011', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DIRECCION RESIDENCIA', 'TDR', 'C', '002', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DIRECCION ELECTRONICA-EMAIL', 'TDW', 'C', '001', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO-FUNCIONARIO', 'TIPFUN', 'C', '002', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIEMPO MAXIMO DE ESPERA EN PROCESAMIENTO DE ORDEN (MIN)', 'TMXPOR', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO PERSONA PARA BONOS', 'TPB', 'C', '007', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE PERSONA CLIENTE', 'TPC', 'C', '001', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO PERSONA FALLECIDA', 'TPF', 'C', 'FDO', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO TIPO DE REFERENCIA ARRENDADOR', 'TRA', 'C', 'AR', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO TELEFONO CELULAR', 'TTC', 'C', 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO TELEFONO - MIG', 'TTM', 'C', 'M', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO TIPO DE VIVIENDA ARRENDADA', 'TVA', 'C', '002', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO VIVIENDA ARRENDADA', 'TVAR', 'C', '002', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('USUARIO Y ROL CTS WS GEORREFERENCIADOR', 'URGEO', 'I', 'usuariocnb', 147, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ACTIVAR VALIDACION HOMINI', 'VALHOM', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VALIDACION OFICINA - ROLLOUT', 'VALOFI', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE VIVIENDA ARRENDADA', 'VAR', 'C', '002', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VIGENCIA DATOS FINANCIEROS CIFIN', 'VIDFCF', 'S', NULL, NULL, 30, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VIGENCIA DATOS FINANCIEROS DATACREDITO', 'VIDFDC', 'S', NULL, NULL, 30, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VIGENCIA DATOS PERSONALES CIFIN', 'VIDPCF', 'S', NULL, NULL, 90, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VIGENCIA DATOS PERSONALES DATACREDITO', 'VIDPDC', 'S', NULL, NULL, 90, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS DE VIGENCIA DE REGISTROS ERROR PARA CARGUE MASIVO', 'VIGERR', 'I', NULL, NULL, NULL, 30, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MESES DE VIGENCIA DE LA REFERENCIACION', 'VIGREF', 'S', NULL, NULL, 12, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PARA VALIDAR DATOS DE SOSTENIBILIDAD', 'VVIS', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VERSION XML CIFIN', 'VXMLCF', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VERSION XML DATACREDITO', 'VXMLDC', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'MIS')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE MESES PARA SER EMPRENDEDOR', 'NDEP', 'S', NULL, NULL, 6, NULL, NULL, NULL, NULL, 'MIS')
GO



delete cl_parametro where pa_producto = 'CEX' and pa_nemonico  = 'PAIS'

INSERT INTO [cobis].[dbo].[cl_parametro]([pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto])
VALUES('CODIGO DEL PAIS', 'PAIS', 'S', NULL, NULL, 68, NULL, NULL, NULL, NULL, 'CEX')
GO

delete cl_parametro where pa_producto = 'CRE' and pa_nemonico  = 'COU'

INSERT INTO [cobis].[dbo].[cl_parametro]([pa_parametro], [pa_nemonico], [pa_tipo], [pa_char], [pa_tinyint], [pa_smallint], [pa_int], [pa_money], [pa_datetime], [pa_float], [pa_producto])
VALUES('CONYUGE O UNION LIBRE', 'COU', 'T', NULL, 10, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO


/*****************************************************************/
/*                     SEQNOS                                    */
/*****************************************************************/
print '----- > cl_seqnos'
delete cl_seqnos 
where   tabla in ('cl_asoc_clte_serv', 'cl_atr_tbl_inf','cl_atr_valores',
                   'cl_det_producto', 'cl_ente','cl_grupo','cl_mercado',
                   'cl_refinh','cl_relacion','cl_tbl_inf', 'cl_negocio_cliente','cl_operaciones_inusuales','cl_ns_alertas_riesgo', 'cl_ente_bio', 'cl_respuesta_bio')
go
       
insert into cl_seqnos values ('cobis', 'cl_asoc_clte_serv', 0, 'ac_secuencial')
insert into cl_seqnos values ('cobis', 'cl_atr_tbl_inf',    0, 'ti_grp_atr_inf')
insert into cl_seqnos values ('cobis', 'cl_atr_valores',    0, 'ti_atr_val')
insert into cl_seqnos values ('cobis', 'cl_det_producto',   0, 'dp_det_producto')
insert into cl_seqnos values ('cobis', 'cl_ente',           0, 'en_ente')
insert into cl_seqnos values ('cobis', 'cl_grupo',          0, 'gr_grupo')
insert into cl_seqnos values ('cobis', 'cl_mercado',        0, 'me_codigo')
insert into cl_seqnos values ('cobis', 'cl_refinh',         0, 'in_codigo')
insert into cl_seqnos values ('cobis', 'cl_relacion' ,      0, 're_relacion')
insert into cl_seqnos values ('cobis', 'cl_tbl_inf',        0, 'ti_grp_inf')
insert into cl_seqnos values ('cobis', 'cl_negocio_cliente',0, 'nc_codigo')
insert into cl_seqnos values ('cobis', 'cl_notificacion_general',0, 'ng_codigo')
insert into cobis..cl_seqnos values ('cobis', 'cl_operaciones_inusuales', 0, 'oin_codigo')
insert into cobis..cl_seqnos values ('cobis', 'cl_ns_alertas_riesgo', 0, 'nar_codigo')
insert into cobis..cl_seqnos values ('cobis', 'cl_ente_bio', 0, 'eb_secuencial')
insert into cobis..cl_seqnos values ('cobis', 'cl_respuesta_bio', 0, 'rb_secuencial')
go

/************************************************************************/
--                             CREACION DEL PRODUCTO
/************************************************************************/
print '------- > cl_producto'
go
if exists (select 1 from cl_producto where pd_producto = 2)
    delete  cl_producto where pd_producto = 2
go
insert into cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura,
             pd_fecha_apertura, pd_estado, pd_saldo_minimo, 
             pd_costo)
        values  (2, 'R', 'MANAGEMENT INFORMATION SYSTEM', 'MIS',
             getdate(), 'V', null,
             null)
go

update  cl_seqnos
set siguiente = (select max(pd_producto)
               from cobis..cl_producto)
where tabla = 'cl_producto'
go

/************************************************************************/
--                                MONEDA DEL PRODUCTO
/************************************************************************/
print '--------- > cl_pro_moneda'
go
if exists (select 1 from cl_pro_moneda where pm_producto = 2)
    delete cl_pro_moneda where pm_producto = 2
go
declare @w_moneda tinyint
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'
insert into cl_pro_moneda (pm_producto, pm_tipo, pm_moneda, pm_descripcion,
             pm_fecha_aper, pm_estado)
        values  (2, 'R',@w_moneda, 'M.I.S.', getdate(), 'V')
go

/************************************************************************/
--                           PRODUCTO OFICINA
/************************************************************************/
print '-------- > cl_pro_oficina'
go
if exists (select 1 from cl_pro_oficina where pl_producto = 2)
    delete cl_pro_oficina where pl_producto = 2
go
declare @w_moneda tinyint
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'
insert into cl_pro_oficina (pl_filial, pl_oficina, pl_producto,pl_tipo,
                pl_moneda, pl_monto, pl_fecha_aper, pl_secuencial)
            values (1, 1, 2, 'R', @w_moneda, NULL, getdate(), 2)  
go

update  cl_seqnos
   set  siguiente = 2
where   tabla = 'cl_pro_oficina'
go

/************************************************************************/
--          INSTALACION DE PRODUCTO
/************************************************************************/
print '--------- > ad_pro_instalado'
go
if exists (select 1 from ad_pro_instalado where pi_producto = 'MIS')
    delete ad_pro_instalado where pi_producto = 'MIS'
go
insert into ad_pro_instalado (pi_producto, pi_bdd, pi_transaccion,
                  pi_uso_firmas)
                     values  ('MIS', 'cobis', NULL, 'S')
go

print ' ======> FIN DE EJECUCION DE cl_ins.sql '
go


/************************************************************************/
--          INSERCION DE REGISTROS DE LA TABLA cl_rango_tipo_doc
/************************************************************************/
insert into cl_rango_tipo_doc values('NI','F','1000000000','7999999999')
insert into cl_rango_tipo_doc values('NI','M','1000000000','7999999999')
insert into cl_rango_tipo_doc values('NI','F','1000000000','20000000000')
insert into cl_rango_tipo_doc values('NI','F','100000000','999999999')
insert into cl_rango_tipo_doc values('NI','M','100000000','999999999')
insert into cl_rango_tipo_doc values('RC','M','1000000000','99999999999')
insert into cl_rango_tipo_doc values('RC','F','1000000000','99999999999')
insert into cl_rango_tipo_doc values('TI','F','000000000000','999999999999')
insert into cl_rango_tipo_doc values('CE','O','1','600000')
insert into cl_rango_tipo_doc values('TI','F','1000000000','999999999999')
insert into cl_rango_tipo_doc values('CC','F','20000001','70000000')
insert into cl_rango_tipo_doc values('CC','M','1','20000000')
insert into cl_rango_tipo_doc values('CC','M','70000001','99999999')
insert into cl_rango_tipo_doc values('CC','F','1000000000','7999999999')
insert into cl_rango_tipo_doc values('CC','M','1000000000','7999999999')
insert into cl_rango_tipo_doc values('N','O','800000000','999999999')
insert into cl_rango_tipo_doc values('N','O','600000000','699999999')
insert into cl_rango_tipo_doc values('N','O','900000001','999999999')
insert into cl_rango_tipo_doc values('NU','O','1000000000','7999999999')
insert into cl_rango_tipo_doc values('NU','O','100000','7999999999')
insert into cl_rango_tipo_doc values('NI','M','1','20000000')
insert into cl_rango_tipo_doc values('NI','F','20000001','70000000')
insert into cl_rango_tipo_doc values('NI','M','70000001','99000000')
insert into cl_rango_tipo_doc values('NI','M','1000000000','20000000000')
insert into cl_rango_tipo_doc values('TI','M','000000000000','999999999999')
insert into cl_rango_tipo_doc values('TI','M','1000000000','999999999999')
insert into cl_rango_tipo_doc values('1','M','1','100')

go

/************************************************************************/
--          INSERCION DE REGISTROS DE LA TABLA cl_relacion
/************************************************************************/
use cobis
go

DELETE FROM cl_relacion WHERE re_relacion in (201,202,203,204,205,206,207,208)
/*
INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (201, 'ACCIONISTA NATURAL', 'ES ACCIONISTA DE', '', NULL, NULL, 0)
INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (202, 'ACCIONISTA JURIDICO', 'ES ACCIONISTA DE', '', NULL, NULL, 0)
INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (203, 'JUNTA DIRECTIVA PRINCIPAL', 'ES MIEMBRO PRINCIPAL JD DE', '', NULL, NULL, 0)
INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (204, 'JUNTA DIRECTIVA SUPLENTE', 'ES MIEMBRO SUPLENTE JD DE', '', NULL, NULL, 0)
INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (205, 'REPRESENTANTE LEGAL', 'REPRESENTA A', 'ES REPRESENTADO POR', NULL, NULL, 0)
INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (206, 'APODERADO O TUTOR', 'ES APODERADO DE', 'TIENE COMO APODERADO A', NULL, NULL, 0)
INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (207, 'CORRESPONSAL BANCARIO', 'TIENE COMO CB A', 'ES CB DE', NULL, NULL, 0)
INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (208, 'BONOS', 'ES EMISOR DE BONOS PARA', 'ES TENEDOR DE BONOS DE', NULL, NULL, 0)
*/

DELETE FROM cl_relacion WHERE re_relacion in (209, 210, 211, 212)
go

INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (209, 'CONYUGE', 'ES CONYUGE DE', 'ES CONYUGUE DE', NULL, NULL, 0)
GO

INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (210, 'HIJO', 'ES HIJO DE', 'ES PADRE O MADRE DE', NULL, NULL, 0)
GO

INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (211, 'PADRE', 'ES PADRE DE', 'ES HIJO(A) DE', NULL, NULL, 0)
GO

INSERT INTO cl_relacion (re_relacion, re_descripcion, re_izquierda, re_derecha, re_tabla, re_catalogo, re_atributo)
VALUES (212, 'HERMANO', 'ES HERMANO', 'ES HERMANO DE', NULL, NULL, 0)
GO

GO


/************************************************************************/
--          INSERCION DE REGISTROS DE LA TABLA cl_depart_pais
/************************************************************************/
use cobis
go

DELETE FROM cl_depart_pais WHERE dp_departamento in (1)

INSERT INTO cl_depart_pais (dp_departamento, dp_mnemonico, dp_descripcion, dp_pais, dp_estado)
VALUES ('1', 'DEP1', 'DEP1', 1, 'V')
go


/************************************************************************/
--          INSERCION DE REGISTROS DE LA TABLA cl_cat_reg_negocio
/************************************************************************/
use cobis
go
--1
INSERT INTO cl_cat_reg_negocio (reg_neg_etiqueta,reg_neg_descripcion)
VALUES ('AML_MOEXT_500','Transacciones que en lo individual realicen los 
clientes en efectivo en moneda extranjera o con cheques de viajero, por montos iguales 
o superiores a quinientos dólares de los Estados Unidos de América o su equivalente en la 
moneda extranjera de que se trate, en un mes calendario.')
--2
INSERT INTO cl_cat_reg_negocio (reg_neg_etiqueta,reg_neg_descripcion)
VALUES ('AML_MXN_300','Operaciones en efectivo con pesos de los Estados 
Unidos Mexicanos que,en lo individual,realicen los clientes,por montos
superiores a los trescientos mil pesos, cuando aquellos 
sean personas físicas en un mes calendario.')
 --3
INSERT INTO cl_cat_reg_negocio (reg_neg_etiqueta,reg_neg_descripcion)
VALUES ('AML_USD_100','los Estados Unidos de América o cualquier otra moneda 
extranjera por un monto acumulado en un mes calendario igual o superior a los 
100,000 dólares de los Estados Unidos de América.') 
--4
INSERT INTO cl_cat_reg_negocio (reg_neg_etiqueta,reg_neg_descripcion)
VALUES ('AML_MXN_1000+','Operaciones durante un mes calendario en efectivo
en moneda nacional por un monto acumulado igual o superior a 1,000,000.00 
pesos moneda nacional o bien, en efectivo en dólares de los Estados Unidos 
de América.') 
--5
INSERT INTO cl_cat_reg_negocio (reg_neg_etiqueta,reg_neg_descripcion)
VALUES ('AML_PAN_1','Cuando el cliente prepague el crédito otorgado en 
un plazo menor a 1 mes posteriores a su contratación, asumiendo el 
pago de la pena.') 
--6
INSERT INTO cl_cat_reg_negocio (reg_neg_etiqueta,reg_neg_descripcion)
VALUES ('AML_PETRA','Cuando los pagos que realice el cliente sean 
inusualmente elevados y no se tenga fundamento, de acuerdo con sus
antecedentes y actividad económica, para tal pago.') 
--7
INSERT INTO cl_cat_reg_negocio (reg_neg_etiqueta,reg_neg_descripcion)
VALUES ('TIF_MXN_100','Operaciones en efectivo con pesos de los 
Estados Unidos Mexicanos que, en lo individual, realicen los 
clientes, por un importe igual o superior a $ 7,500.00 dlls, 
cuando aquellos sean personas físicas en un mes calendario.') 
--8
INSERT INTO cobis..cl_cat_reg_negocio (reg_neg_etiqueta, reg_neg_descripcion,reg_neg_cuenta_pagos)
VALUES ('AML_PAN_1', 'No de Pagos del crédito individual/revolvente','S')
--9
INSERT INTO cobis..cl_cat_reg_negocio (reg_neg_etiqueta, reg_neg_descripcion,reg_neg_cuenta_pagos)
VALUES ('AML_PAN_1', 'Pago del crédito individual revolvente','N')

GO
