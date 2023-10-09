Use cob_conta
go

IF OBJECT_ID ('dbo.cb_perfil') IS NOT NULL
	DROP TABLE dbo.cb_perfil
GO

CREATE TABLE dbo.cb_perfil
	(
	pe_empresa     TINYINT NOT NULL,
	pe_producto    TINYINT NOT NULL,
	pe_perfil      VARCHAR (20) COLLATE Latin1_General_BIN NOT NULL,
	pe_descripcion descripcion NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_perfil_Key
	ON dbo.cb_perfil (pe_empresa,pe_producto,pe_perfil)
GO



INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'AUTRETINE', 'AUTORIZ RETIRO MONTO INEMBARGABLE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'BOC', 'BALANCE OPERATIVO CONTABLE CUENTAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CH-GR01', 'EMISION CHEQUES DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CH-GR01D', 'REVOCATORIA CHEQUES DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CH-GR02', 'CAUSACION TIMBRE EMISION CHEQUES DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CH-GR08', 'PAGO CHEQUE GERENCIA VENTANILLA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CH-GR09', 'REPOSICION CHEQUE DE GERENCIA (ANULACION)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-EN01', 'CANJE ENVIADO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-EN01D', 'CANJE ENVIADO DIRECTO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-RC01', 'CANJE RECIBIDO PA DE CHEQUES POR CAMARA < 6 MESES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-RC01D', 'CANJE RECIBIDO DIRECTO < 6 MESES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-RC02', 'CANJE ENVIADO PA CHEQUES POR CAMARA > 6 MESES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-RC02D', 'CANJE RECIBIDO DIRECTO > 6 MESES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-RC05', 'CANJE RECIBIDO SOBRANTE CANJE CH.REC.MAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-RC05D', 'CANJE RECIBIDO DIRECTO SOBRANTE CANJE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-RC06', 'CANJE RECIBIDO FALTANTES CANJE CH. NO RECIBIDOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CJ-RC06D', 'CANJE RECIBIDO DIRECTO FALTANTES CANJE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'CT_TRANS', 'EGRESO DE CHEQUES CANJE TRANSITORIO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'DESPRO', 'DESBLOQUEO PROCREDITO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'DES_CORONA', 'DESEMBOLSO CORONA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'DEV-ANT-CH', 'DEVOLUCION DE ANTICIPOS EN CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'DEV_CART', 'DEVOLUCION CARTERA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'DEV_DPF', 'DEVOLUCION DPF')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'DEV_SICCH', 'DEVOLUCION CH FUERA DE LINEA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EBOG000412', 'EGRESO BANCO BOGOTA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'ED_EDA_CH1', 'DEVOLUCION RECAUDO EDATEL CH1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-AGUA', 'PAGO ADMON SERVICIO AGUA Y ALCANTARILLADO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-DC', 'DESEMBOLSO EN EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-DC-FL', 'DESEMBOLSO EN EFECTIVO FUERA DE LNEA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-DC-GMF', 'GMF DESEMBOLSOS EN EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-ENE', 'PAGO ADMON SERVICIO ENERGIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-FCA', 'FALTANTE AUTOMATICO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-FCM', 'FALTANTE EN CAJA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-PAS', 'PAGO ADMON SERVICIOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-RCM', 'PAGOS ADMON CAJA MENOR')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-REMESAW', 'PAGO REMESAS WESTERN UNION')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-SOB', 'DEVOLUCION DE SOBRANTES EN CAJA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG-TEL', 'PAGO ADMON SERVICIO TELEFONO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_AGU_CH1', 'PAGO ADMON SERVICIO AGUA Y ALCANTARILLADO CHEQUE1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_AGU_GER', 'PAGOS SERVICIO AGUA Y ALCANTARILLADO CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ANTICH', 'EGRESO PAGO ANTICIPO CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ANTICH1', 'PAGOS ADMON ANTICIOPOS EN CHEQUE1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ANTICIP', 'PAGOS ANTICIPOS VIATICOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ANT_GER', 'PAGOS ANTICIPOS CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ARRENDA', 'PAGOS ADMON ARRENDAMIENTOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ARRE_CH', 'PAGOS ADMON ARRENDAMIENTOS CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ARR_CH1', 'PAGOS ADMON ARRENDAM CHEQUE1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ARR_GER', 'PAGOS ARRENDAMIENTOS CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CAJAMEN', 'REINTEGRO DE CAJA MENOR')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CAN_MAS', 'CANCELACION MASIVA CTAS DE AHORRO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CARPAGC', 'REGISTRO-REINTEGRO CARTA DE REFERENCIA CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CARPAGE', 'REGISTRO-REINTEGRO CARTA DE REFERENCIA EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CARTARE', 'REINTEGRO CARTA DE REFERENCIA PARA CLIENTES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CER_IVA', 'REINTEGRO CARTA DE REFERENCIA PARA CLIENTES IVA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CIEECCO', 'CIERRE DE CUENTA CONTABLE EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CIE_CHG', 'CIERRE DE CUENTA CHEQUE DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_CIE_EFE', 'CIERRE DE CUENTA EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_COMPAGC', 'REGISTRO-REINTEGRO COMISION ESTUDIO DE CREDITO-CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_COMPAGE', 'REGISTRO-REINTEGRO COMISION ESTUDIO DE CREDITO-EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_COMPRAS', 'PAGOS ADMON COMPRAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_COMP_CH', 'PAGOS ADMON COMPRAS CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_COMP_GE', 'PAGOS COMPRAS CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_COM_CH1', 'PAGOS ADMON COMPRAS CH1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_COM_EST', 'REINTEGRO COMISION ESTUDIO DE CREDITO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_COM_IVA', 'REINTEGRO COMISION ESTUDIO DE CREDITO IVA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_DEP_SIM', 'CANCELACION DEPOSITO SIMPLE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_EDATEL', 'DEVOLUCION RECAUDO EDATEL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_EDAT_CH', 'DEVOLUCION RECAUDO EDATEL CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_EDAT_GE', 'DEVOLUC REACUDO EDATEL CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_EDA_CH1', 'DEVOLUCION RECAUDO EDATEL CH1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ENE_CH1', 'PAGO ADMON SERVICIO ENERGIA CHEQUE1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_ENE_GER', 'PAGO SERVICIO ENERGIA CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_EXEQUIA', 'REINTEGRO SEGURO EXEQUIAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_EXEQ_CH', 'REINTEGRO SEGURO EXEQUIAL CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_EXEQ_GE', 'REINT SEGURO EXEQUIAL CH')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_EXQ_CH1', 'REINTEGRO SEGURO EXEQUIAL CH1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_GMFGENE', 'GMF GENERICO EGRESOS CAJA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_IMP_CH1', 'PAGO IMPUESTOS CHEQUE1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_IPN_CG', 'PAGO IMPUESTOS NACIONALES CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_JURIDIC', 'REINTEGRO COBRO JURIDICO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_MAYVAR', 'DEVOLUCION EN EFECTIVO DE RECAUDO MAYOR VALOR')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_MICROSE', 'REINTEGRO SEGURO DE VIDA Y MICROSEGURO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_MICR_CH', 'REINTEGRO SEGURO DE VIDA Y MICROSEGURO CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_MICR_GE', 'REINT SEGURO DE VIDA Y MICROSEG GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_MIC_CH1', 'REINTEGRO SEG DE VIDA Y MICROSEGURO CH1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_NOMINAC', 'PAGO NOMINA CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_NOMINAE', 'PAGO NOMINA EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_NOM_CH1', 'PAGO DE NOMINA CH1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_NOM_GER', 'PAGO DE NOMINA CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PAGOBFR', 'PAGO OBLIGACIONES FINANCIERAS EN CH DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PAGOIMP', 'PAGO DE IMPUESTOS PROPIOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PAIM_CH', 'PAGO DE IMPUESTOS PROPIOS CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PAIM_GE', 'PAGO IMPUESTOS PROPIOS GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PAS_CH', 'PAGOS ADMON SERVICIOS CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PAS_CH1', 'PAGO ADMON SERVICIOS PUBLICOS CHEQUE1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PAS_GER', 'PAGOS SERVICIOS PUBLICOS CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PEMPCHG', 'DESEMBOLSOS PEQUEÑA EMPRESA CHEQUE DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PREJURI', 'REINTEGRO COBRO PREJURIDICO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_PRE_IVA', 'REINTEGRO IVA COBRO PREJURIDICO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_TEL_CH1', 'PAGO ADMON SERVICIO TELEFONO CHEQUE1')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'EG_TEL_GER', 'PAGO SERVICIO TELEFONO CH GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'ENT-BCOREP', 'ENTRADA DE EFECTIVO DE OFICINA A CENTRO DE EFECTIVO - BANCO DE L')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'ENT-CE', 'ENTRADA DE EFECTIVO DE OFICINA A CENTRO DE EFECTIVO - OTROS CENT')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'ENT-OO', 'ENTRADA DE EFECTIVO DE OFICINA A CENTRO DE EFECTIVO - OTRAS OFIC')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'FNG_CHLO', 'INGRESO FNG CHEQUE LOCAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'GMF-CJ', 'GENERACION DEL GMF')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IAVV525024', 'BANCO AVVILLAS 525024113')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBANAG3132', 'BANCO AGRARIO 313200000617')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBTA00082', 'BANCO DE BOGOTA 000829390')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBTA05900', 'BANCO DE BOGOTA 059000166')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBTA06003', 'BANCO DE BOGOTA 060031903')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBTA34808', 'BANCO DE BOGOTA 348086794')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBTA44901', 'BANCO DE BOGOTA 449019272')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBTA59625', 'BANCO DE BOGOTA 596251116')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBTA61611', 'BANCO DE BOGOTA 616119566')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBVA13050', 'BANCO BBVA 13050187020001135')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBVA30900', 'BANCO BBVA AHORROS 309005569')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBBVA71600', 'BANCO BBVA PALNETA RICA 716007067')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBC0484691', 'BANCOLOMBIA 04846913136')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBC0972597', 'BANCOLOMBIA BID 9725971710')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO043056', 'BANCOLOMBIA 04305674476')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO070092', 'BANCOLOMBIA MANIZALES 07009290730')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO091444', 'BANCOLOMBIA MONTERIA 09144480711')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO097985', 'BANCOLOMBIA 09798552203')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO103326', 'BANCOLOMBIA AHORROS 10332654658')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO262354', 'BANCOLOMBIA 26235451881')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO352354', 'BANCOLOMBIA 35235451828')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO371313', 'BANCOLOMBIA CAUCASIA 37131383220')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO392239', 'BANCOLOMBIA LA DORADA 39223904719')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO645260', 'BANCOLOMBIA APARTADO 64526036103')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO706256', 'BANCOLOMBIA  CHINCHINA 70625691878')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCO744284', 'BANCOLOMBIA SANTA ROSA 74428487208')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBCSC21002', 'BANCO BCSC 21002631546')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBOCC20203', 'BANCO DE OCCIDENTE 202033171')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IBOG000412', 'INGRESO BANCO BOGOTA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'ICOLM21500', 'BANCO COLMENA 21500241120')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'ICOLP00560', 'RED MULTIBANCA COLPATRIA 005602022864')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-CER', 'CERTIFICACIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-CER-IVA', 'IVA CERTIFICACIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-CERPAGC', 'REGISTRO-CERTIFICACIONES-CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-CERPAGE', 'REGISTRO-CERTIFICACIONES-EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-CI', 'COMISIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-CI-IVA', 'IVA COMISIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-CIPAGCH', 'REGISTRO-COMISIONES-CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-CIPAGEF', 'REGISTRO-COMISIONES-EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-DEVCAJM', 'DEVOLUCION CAJA MENOR MERCADEO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-RECCB', 'RECAUDO CB EN OFICINA ')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-SEG-EXQ', 'SEGURO EXEQUIAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-SOB', 'SOBRANTES EN CAJA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-SOB-A', 'SOBRANTE AUTOMATICO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG-SOB-CH', 'SOBRANTE CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_CELEMP', 'PAGO CELULAR EMPLEADOS ')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_CHEQ_DV', 'SANCION CHEQUE DEVUELTO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_GAN_OCA', 'RECAUDO GANANCIA OCASIONAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_MSEG_CH', 'SEGURO DE VIDA - MICROSEGURO CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_PCARNT', 'PAGO PERD_REXPS NARNET EMPLEADOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_REES_CH', 'PAGO REESTRUCTURACION CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_REES_EF', 'PAGO REESTRUCTURACION EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_REINTGA', 'REINTEGRO GASTOS ADMINISTRATIVOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_REINTSP', 'REINTEGRO SERVICIOS PUBLICOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_RENNM', 'REINTEGRO CONCEPTOS DE NOMINA ')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_RINPIM', 'REINTEGRO PAGO DE IMPUESTOS ')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_SICRECH', 'PAGO PRESTAMO OFICINA EN LINEA CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_SICREDI', 'PAGO PRESTAMO OFICINA EN LINEA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_SICREFU', 'PAGO PRESTAMO OFICINA FUERA DE LINEA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_SICRFCH', 'PAGO PRESTAMO OFICINA FUERA DE LINEA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_SOBCAJM', 'INGRESOS POR SOBRANTES CAJA MENOR')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_TBR', 'INGRESOS TRASLADOS DE BANCO DE LA REPUBLICA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_TIMBRE', 'RECAUDO IMPUESTO DE TIMBRE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IG_TIMBRECH', 'RECAUDO IMPUESTO DE TIMBRE CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'ING-MSEG', 'SEGURO DE VIDA EN EFECTIVO - MICROSEGURO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'ING_RE_FNG', 'INGRESO REINTEGRO FNG')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'IPOP661243', 'BANCO POPULAR 66124397')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'MY-VR-CH', 'MAYOR VALOR PAGADO EN CHEQUE - INGRESO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'NC-02', 'N.C. SOBRANTES CANJE ENVIADO LOCAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'NC-03', 'N.C. SOBRANTES CANJE DEVOLUCION RECIBIDA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'NC-03D', 'N.C. CANJE DIRECTO SOBRANTES DEV RECIBIDA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'PAG_CA', 'PAGO CARTERA CASTIGADA EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'PAG_CAS_CHQ', 'PAGO CARTERA CASTIGADA CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'PASINIES', 'PAGO SINIESTRO FALLECIMIENTO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'PA_ITP', 'PAGO ITP')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'PG-FALT', 'PAGOS FALTANTES EN CAJA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'PG-FALTCH', 'PAGO FALTANTE CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'PG-FL', 'INGRESOS DE OTRAS AGENCIAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-HEC', 'RECAUDO HONORARIOS ABOGADO EXTERNO CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-HEC_IVA', 'RECAUDO HONORARIOS ABOGADO EXTERNO CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-HEE', 'RECAUDO HONORARIOS ABOGADO EXTERNO EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-HEE_IVA', 'RECAUDO HONORARIOS ABOGADO EXTERNO EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-HIC', 'HONORARIOS ABOGADO INTERNO CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-HIC-IVA', 'IVA HONORARIOS ABOGADO INTERNO CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-HIE', 'HONORARIOS ABOGADO INTERNO EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-HIE-IVA', 'IVA HONORARIOS ABOGADO INTERNO EFECTIVO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RC-JUR_IVA', 'REGISTRO-REINTEGRO IVA-COBRO JURIDICO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'REFE', 'REFERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RETFUERLIN', 'AUTORIZAC RETIRO FUERA DE LINEA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RETINECHG', 'RETIRO EMBARGOS MMINEMBARGABLE CH DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RM-BF', 'REMISIN DE BILLETE/MONEDA APARENTEMENTE FALSO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RT-ANT', 'REINTEGRO DE ANTICIPOS VIATICOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RT-ANT-CH', 'REINTEGRO DE ANTICIPOS CHEQUE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'RT-BF', 'REINTEGRO POR BILLETE/MONEDA APARENTEMENTE FALSO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SAVV525024', 'BANCO AVVILLAS 525024113')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBANAG3132', 'BANCO AGRARIO 313200000617')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBTA00082', 'BANCO DE BOGOTA 000829390')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBTA05900', 'BANCO DE BOGOTA 059000166')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBTA06003', 'BANCO DE BOGOTA 060031903')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBTA34808', 'BANCO DE BOGOTA 348086794')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBTA44901', 'BANCO DE BOGOTA 449019272')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBTA59625', 'BANCO DE BOGOTA 596251116')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBTA61611', 'BANCO DE BOGOTA 616119566')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBVA13050', 'BANCO BBVA 13050187020001135')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBVA30900', 'BANCO BBVA AHORROS 309005569')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBBVA71600', 'BANCO BBVA PALNETA RICA 716007067')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBC0484691', 'BANCOLOMBIA 04846913136')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBC0972597', 'BANCOLOMBIA BID 9725971710')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO043056', 'BANCOLOMBIA 04305674476')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO070092', 'BANCOLOMBIA MANIZALES 07009290730')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO091444', 'BANCOLOMBIA MONTERIA 09144480711')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO097985', 'BANCOLOMBIA 09798552203')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO103326', 'BANCOLOMBIA AHORROS 10332654658')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO262354', 'BANCOLOMBIA 26235451881')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO352354', 'BANCOLOMBIA 35235451828')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO371313', 'BANCOLOMBIA CAUCASIA 37131383220')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO392239', 'BANCOLOMBIA LA DORADA 39223904719')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO645260', 'BANCOLOMBIA APARTADO 64526036103')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO706256', 'BANCOLOMBIA  CHINCHINA 70625691878')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCO744284', 'BANCOLOMBIA SANTA ROSA 74428487208')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBCSC21002', 'BANCO BCSC 21002631546')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SBOCC20203', 'BANCO DE OCCIDENTE 202033171')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SCOLM21500', 'BANCO COLMENA 21500241120')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SCOLP00560', 'RED MULTIBANCA COLPATRIA 005602022864')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SE-BCOREP', 'SALIDA DE EFECTIVO DE OFICINA A CENTRO DE EFECTIVO - BANCO DE LA REPUBLICA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SE-CE', 'SALIDA DE EFECTIVO DE OFICINA A CENTRO DE EFECTIVO - OTROS CENTR')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SE-OO', 'SALIDA DE EFECTIVO DE OFICINA A CENTRO DE EFECTIVO - OTRAS OFICINAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 3, 'SPOP661243', 'BANCO POPULAR 66124397')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'AUM_CUPO', 'CUPO CORRESPONSALES POSICIONADOS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'BOC_AHO', 'BOC DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'CAU_AHO', 'CAUSACION DEPOSITOS AHORROS(AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'COB_SUS', 'COBRO CARGOS EN SUSPENSO (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'COMCRBMAHO', 'COMPENSACION CREDITO RBM')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'COMPRBMAHO', 'COMPENSACION RBM')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'COND_AHO', 'CONDONACIONA VALORES EN SUSPENSO CTAS AHORROS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'DIS_CUPO', 'CUPO CORRESPONSALES POSICIONADOS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'EST_AHO', 'CAMBIOS DE ESTADO DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'GMFBCOCAU', 'GMF A CARGO DEL BANCO CAUSAL (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'GMFCARBCO', 'GMF A CARGO DEL BANCO (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'ING_REM', 'REMESAS DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'NCR_AHO', 'NOTAS CREDITO DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'NDB_AHO', 'NOTAS DEBITO DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'REM_AHO', 'REMESAS DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'TRAS_AHO', 'TRASLADO ENTRE OFICINAS AHORROS (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'VAL_SUS', 'CARGOS EN SUSPENSO (AHORROS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'BOC_ACT', 'BALANCE OPERATIVO CONTABLE (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'BOC_ADM', 'BALANCE OPERATIVO CONTABLE (PRESTAMOS ADMINISTRADOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'BOC_CAJAS', 'BALANCE OPERATIVO CONTABLE (CAJAS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'BOC_PAS', 'BALANCE OPERATIVO CONTABLE (PRESTAMOS PASIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'CAS_ACT', 'CASTIGO DE OPERACIONES (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'CAS_ADM', 'CASTIGOS DE CARTERA (PRESTAMOS ADMINISTRADOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'CAU_ACT', 'CAUSACION DIARIA (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'CAU_ADM', 'CAUSACION DIARIA (PRESTAMOS ADMINISTRADOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'CAU_PAS', 'CAUSACION DIARIA (PRESTAMOS PASIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'DES_ACT', 'DESEMBOLSO DE OPERACIONES (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'DES_ADM', 'DESEMBOLSO DE OPERACIONES (PRESTAMOS ADMINISTRADOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'DES_PAS', 'DESEMBOLSO DE OPERACIONES (PRESTAMOS PASIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'EST_ACT', 'CAMBIO DE ESTADO A VENCIDO (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'IOC_ACT', 'INGRESO OTROS CARGOS (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'PAG_ACT', 'APLICACION DE UN PAGO (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'PAG_ADM', 'APLICACION DE UN PAGO (PRESTAMOS ADMINISTRADOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'PAG_PAS', 'APLICACION DE UN PAGO (PRESTAMOS PASIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'REC_ACT', 'RECONOCIMIENTO GARANTIAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'RES_ACT', 'REESTRUCTURACION CARTERA (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'RPA_ACT', 'REGISTRO DE UN PAGO (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'RPA_PAS', 'REGISTRO DE UN PAGO (PRESTAMOS PASIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'SUA_ACT', 'SUSPENSO (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'TCO_ACT', 'TRASLADO DE CARTERA (PRESTAMOS ACTIVOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'TCO_ADM', 'TRASLADO DE CARTERA (PRESTAMOS ADMINISTRADOS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 7, 'TLI_ACT', 'TRASLADO DE LINEA DE CREDITO PRESTAMOS ACTIVOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CH-GR03', 'CHEQUE GERENCIA GIRO < 6 MESES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CH-GR04', 'RECLASIFICACION CHEQUES GERENCIA DE < 6 M A > 6 M')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CH-GR05', 'CHEQUES GERENCIA GIRO > 6 MESES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CH-GR06', 'ENTRADA CHEQUES DE GERENCIA CTAS DE ORDEN')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CH-GR07', 'SALIDA CHEQUES DE GERENCIA CTAS DE ORDEN')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CJ-RC03', 'CANJE RECIBIDO RECHAZOS COMPENSACI+N')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CJ-RC03D', 'CANJE RECIBIDO DIRECTO RECHAZOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CJ-RC04', 'CANJE RECIBIDO CORRECCION DE RECHAZOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CJ-RC04D', 'CANJE RECIBIDO DIRECTO CORREC RECHAZOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CJ-RC07D', 'CHEQUES ENVIADOS POR FUERA DE CAMARA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'CJ-RC08D', 'FALTANTES EN DEVOLUCION RECIBIDA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-ENV01', 'DEVOLUCION ENVIADA CHQ.CON CAUSAS DEV. < 6')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-ENV01D', 'DEVOLUCION ENVIADA DIRECTO CAUSA DEV<6 MESES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-ENV02', 'DEVOLUCION ENVIADA CHQ.CON CAUSAS DEV. > 6')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-ENV02D', 'DEV ENVIADA DIRECTO CAUSA DEV >6 MESES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-ENV03', 'DEV ENVIADA PARA RECHAZOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-ENV03D', 'DEV ENVIADA DIRECTO PARA RECHAZOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-RC01', 'DEVOLUCION RECIBIDA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-RC01D', 'DEVOLUCION RECIBIDA CANJE DIRECTO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-RC02D', 'DEVOLUCION RECIBIDA CANJE DIRECTO-ELIMINACION')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-REC01D', 'DEV RECIBIDA CANJE DIRECTO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'DEV-REC02', 'DEV RECIBIDA CANJE DIRECTO-ELIMINACION CEDEC')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-01', 'N.C. CANJE ENVIADO LOCAL PARA BCO REP.')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-01D', 'N.C. CANJE DIRECTO ENVIADO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-02', 'N.C. SOBRANTES CANJE ENVIADO LOCAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-02D', 'N C. CANJE DIRECTO SOBRANTES CANJE ENVIADO LOCAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-03', 'N.C. SOBRANTES CANJE DEVOLUCION RECIBIDA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-03D', 'N C. CANJE DIRECTO SOBRANTES DEV RECIBIDA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-04', 'N.C. TRASLADO NETO A CAR BCO. REPUBLICA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-04D', 'N.C. CANJE DIRECTO TRASL NETO A CAR BR')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'NC-05', 'N.C. CORRESPONDIDO EN TESORERIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'ND-01', 'N.D. FALTANTES CANJE ENVIADO LOCAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'ND-02', 'N.D. RECONSIGNACION CANJE LOCAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'ND-05D', 'N DB CJ DIRECTO FALTANTE DEV REC')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'ND-06', 'N.D. TRASLADO NETO FAVOR DE BCO. REPUBLICA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 10, 'ND-07', 'N.D. CORRESPONDIDO EN TESORERIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'APE_DPF', 'APERTURA DE UNA OPERACION (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'BOC_DPF', 'BALANCE OPERATIVO CONTABLE (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'CAN_DPF', 'CANCELACION / PAGO / RENOVACION (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'CAU_DPF', 'CAUSACION DE INTERESES (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'DEV_DPF', 'DEVOLUCION DE RETENCIONES (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'END_DPF', 'ENDOSO (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'ENJ_DPF', 'ENAJENACION (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'ORD_DPF', 'ORDENES DE PAGO (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'TOP_DPF', 'TRASLADO DE OPERACION (PLAZO FIJO)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 19, 'BOC', 'HERRAMIENTA DE CUADRE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 19, 'BOC_GAR', 'BOC GARANTIAS (INVENTARIOS Y COBERTURAS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 19, 'CCG', 'CAMBIO CLASE DE GARANTIA Y DE CARTERA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 19, 'GAR', 'HERRAMIENTA DE CUADRE')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 19, 'GARANTIAS', 'GARANTIAS (INVENTARIOS Y COBERTURAS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'APC', 'APERTURAS DE CREDITO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'APG', 'AUMENTO DE PROVISION GENERAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'APR', 'CREDITOS APROBADOS NO DESEMBOLSADOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'APV', 'AUMENTO DE PROVISIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'BOC', 'HERRAMIENTA DE CUADRE CUPOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'BOC_CRE', 'BOC CREDITO (CUPOS Y OP.APROBADAS NO DESEMBOSADAS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'BOC_MOV', 'HERRAMIENTA DE CUADRE CREDITO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'BOC_PRV', 'BALANCE OPERATIVO CONTABLE (PROVISIONES)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'BOC_TEM', 'HERRAMIENTA DE CUADRE TEMPORALIDAD')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'CAS', 'CANCELACION DE PROVISIONES POR CASTIGO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'CUPOS_CRE', 'CREDITO (CUPOS Y OP.APROBADAS NO DESEMBOSADAS)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'EDADES_CAR', 'CARTERA POR EDADES (TEMPORALIDAD)')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'MOVPRO', 'MOVIMIENTO DE PROVISIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'PROVI', 'PERFIL DE PROVISIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'RCLPRO', 'RECLASIFICACION DE PROVISIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'RENPRO', 'HERENCIA DE PROVISIONES EN RENOVACION')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'RPG', 'RECUPERACION DE PROVISION GENERAL')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'RPV', 'REVERSO DE PROVISIONES')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 21, 'TEM', 'TEMPORALIDAD')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42001', 'INVENTARIO CHEQUE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42002', 'INVENTARIO TITULOS CDTS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42010', 'VENTA INSTRUMENTOS CHEQUES DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42011', 'PERFIL DE COMISIONES E IVA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42012', 'GMF A CARGO DEL BANCO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42013', 'EFECTIVO RECIBIDO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42014', 'CRUCE CONTRA PAGOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42015', 'DEBITO A CUENTA DE AHORROS POR EMISION DE CHEQUES DE GERENCIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 42, '42016', 'NC REINTEGRO CHEQUE GERENCIA CTA AHORROS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'AMORT_I_A', 'AMORTIZACION INTERESES ANTICIPADOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'BOC_OA', 'PERFIL PARA HERRAMIENTA DE CUADRE OPERACIONES ACTIVAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'CAP_INT_OA', 'CAPITALIZACION DE INTERESESS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'CAST_OA', 'CASTIGOS DE CARTERA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'CAS_SIC', 'CONSTITUCION DE CASTIGO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'CAUS_OA', 'CAUSACIONES OPERACIONES ACTIVAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'DES_CRED', 'DESEMBOLSO DE CREDITO')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'DEV_CO_CAR', 'DEVOLUCION CONCEPTOS DE CARTERA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'IO_OA', 'INGRESO OTROS CARGOS OPERACIONES ACTIVAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'PAG_OA', 'PAGOS DE CARTERA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'PAG_OTROS', 'PAGOS OTROS CONCEPTOS DE CAJA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'PGRN_OA', 'PAGOS POR RENOVACION')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'PRUEBAS', 'PRUEBAS TC')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'RPA_OA', 'REGISTRO PAGOS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'SUA_OA', 'SUSPENSION ACTIVAS')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'TRASL_GART', 'TRASLADO DE GARANTIA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'TRASL_OA', 'TRASLADO DE CARTERA')
GO

INSERT INTO dbo.cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 200, 'TRC_OA', 'TRASLADO DE CALIFICACION')
GO
