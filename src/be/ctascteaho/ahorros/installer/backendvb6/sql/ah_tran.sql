/************************************************************************/
/*  Archivo:            ah_tran.sql                                     */
/*  Base de datos:      cobis                                           */
/*  Producto:           Cuentas Ahorros                                 */
/*  Disenado por:       Carlos Munoz                                    */
/*  Fecha de escritura: 22 - ene - 2010                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Script de instalación de creación de transacciones                  */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
/************************************************************************/

use cobis
go

print '===> ah_tran.sql'
go

set nocount on
go

delete cobis..cl_ttransaccion
where tn_trn_code >= 200
and   tn_trn_code <= 400 
go


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (201, 'APERTURA DE CUENTA DE AHORROS', 'ACAH', 'APERTURA DE CUENTA DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (202, 'ACTUALIZACION DE CUENTA DE AHORROS', 'AAHO', 'ACTUALIZACION DE CUENTA DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (203, 'REACTIVACION DE CUENTAS DE AHORROS', 'RCAH', 'REACTIVACION DE CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (204, 'REAPERTURA DE CUENTAS DE AHORROS', 'RACA', 'REAPERTURA DE CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (205, 'ACTUALIZACION DE CUENTA DE AHORROS GENERAL', 'AAGN', 'ACTUALIZACION DE CUENTA DE AHORROS GENERAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (206, 'CONSULTA DEL NOMBRE DE LA CUENTA DE AHORROS', 'CONO', 'ESTA TRANSACCION CONSUTA EL NOMBRE DE LA CUENTA DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (207, 'DEPOSITO COMPLETO DIFERIDO CL AH', 'DDCL', 'DEPOSITO COMPLETO DIFERIDO CL AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (208, 'CONSULTA DE DETALLE DE PRODUCTO AH', 'CPAH', 'CONSULTA DE DETALLE DE PRODUCTO AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (209, 'CERTIFICACION DE CHEQUES AH', 'CCHQ', 'CERTIFICACION DE CHEQUES AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (210, 'CONSULTA DE AGENCIA POR F5 AH', 'AGAH', 'CONSULTA DE AGENCIA POR F5 AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (211, 'BLOQUEO DE MOVIMIENTOS DE AHORROS', 'BMAH', 'BLOQUEO DE MOVIMIENTOS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (212, 'LEVANTAMIENTO DE MOVIMIENTOS AH', 'LMAH', 'LEVANTAMIENTO DE MOVIMIENTOS AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (213, 'CIERRE DE CUENTA AH', 'CIAH', 'CIERRE DE CUENTA AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (214, 'CONSULTA DE CIERRE DE CUENTA', 'CCCA', 'CONSULTA DE CIERRE DE CUENTA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (215, 'APERTURA DE CAJA AH', 'ACAA', 'APERTURA DE CAJA AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (216, 'CONSULTA DE BLOQUEOS DE VALORES PARA LEVANTAMIENTO AH', 'CBVL', 'CONSULTA DE BLOQUEO DE VALORES PARA LEVANTAMIENTO AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (217, 'BLOQUEO DE VALORES AH', 'BVAH', 'BLOQUEO DE VALORES DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (218, 'LEVANTAMIENTO DE BLOQUEO DE VALORES AH', 'SFS', 'LEVANTAMIENTO DE BLOQUEO DE VALORES AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (219, 'EFECTIVIZACION RETENCION CHQS LOCALES', 'ER12', 'EFECTIVIZACION RETENCION CHQS LOCALES')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (220, 'CONSULTA DE AHORROS MONETARIA', 'CNMA', 'CONSULTA DE AHORROS MONETARIA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (221, 'N/C INTERESES/RENDIMIENTOS AH', 'CAAH', 'N/C INTERESES/RENDIMIENTOS AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (222, 'AUMENTO O DIMINUCION DE EFECTTIVO AH', 'ADAH', 'AUMENTO O DISMINUCION DE EFECTIVO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (223, 'SOLICITUD DE ESTADO DE CUENTA SIN COSTO AH', 'SECS', 'SOLICITUD DE ESTADO DE CUENTA SIN COSTO AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (224, 'ND POR CHEQUE DEVUELTO REMESAS', 'NDCR', 'NOTA DE DEBITO POR CHEQUE DEVUELTO REMESAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (225, 'CONTABILIZACION DE DEPOSITOS EN CHQS LOCALES', 'CCLA', 'CONTABILIZACION DE DEPOSITOS EN CHEQUES LOCALES')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (226, 'CONTABILIZACION DE CONFIRMACION DE DEPOSITOS CHQS LOCALES', 'CCCA', 'CONTABILIZACION DE CONFIRMACION DE DEPOSITOS EN CHQS LOCALES')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (227, 'CONSULTA DE TRANSACCION AHORROS ESPECIFICA POR CAJERO', 'CEAC', 'PERMITE REALIZAR LA CONSULTA DE LAS TRANSACCIONES DE AHORROS DE UN CODIGO ESPECIFICO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (228, 'NOTA DE DEBITO SIN LIBRETA DE CARTERA', 'NCSC', 'NOTA DE DEBITO SIN LIBRETA DE CARTERA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (229, 'NOTA DE CREDITO SIN LIBRETA DE CARTERA', 'NDSC', 'NOTA DE DEBITO SIN LIBRETA DE CARTERA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (230, 'CONSULTA DE SALDOS DE CUENTAS DE AHORROS', 'CSAH', 'CONSULTA DE SALDOS DE CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (231, 'CONSULTA DE BLOQUEOS DE VALORES AH', 'CBVA', 'CONSULTA DE BLOQUEOS DE VALORES AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (232, 'CONSULTA DE ESTADO DE CUENTA DE AHORROS', 'CECA', 'CONSULTA DE ESTADO DE CUENTA DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (233, 'CONSULTA DE LINEAS PENDIENTES', 'CLPE', 'CONSULTA DE LINEAS PENDIENTES')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (234, 'COBRO DE SOLICITUD DE ESTADO DE CUENTA AH', 'CSEC', 'SOLICITUD DE ESTADO DE CUENTA AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (235, 'CONSULTA NO MONETARIA DE AHORROS', 'CMAH', 'CONSULTA NO MONETARIA DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (236, 'SOLICITUD DE ESTADO DE CUENTA DE AH', 'SECA', 'SOLICITUD DE ESTADO DE CUENTA AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (237, 'DEBITO TRANSFERENCIA AHO A AHO', 'XACC', 'DEBITO TRANSF. DE AH A AA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (238, 'RETIRO CTA AHO ATM NACIONAL', 'RATA', 'RETIRO CTA AHO ATM NACIONAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (239, 'DEBITO TRANSF. DE AH A CC', 'XAAH', 'DEBITO TRANSF. DE AH A CC')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (240, 'ND POR CHQ DEVUELTO AH', 'NDCH', 'NOTA DE DEBITO POR CHEQUE DEVUELTO AH (CHQ PROPIO)')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (241, 'DESMARCAR LINEAS PENDIENTES', 'DLPE', 'DESMARCAR LINEA PENDIENTE')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (242, 'INACTIVACION DE CUENTAS AH', 'ICTA', 'INACTIVACION DE CUENTAS AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (243, 'DEBITO OVERNIGHT DE AH', 'DOAH', 'DEBITO OVERNIGHT DE AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (244, 'CREDITO OVERNIGHT DE AH', 'COAH', 'CREDITO OVERNIGHT DE AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (245, 'CONSULTA DE BLOQUEO DE MOVIMIENTOS', 'CBMO', 'CONSULTA DE BLOQUEO DE MOVIMIENTOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (246, 'DEPOSITO COMPLETO DIFERIDO SL AH', 'DDSL', 'DEPOSITO COMPLETO DIFERIDO SL AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (247, 'CONSULTA DE VALORES EN SUSPENSO', 'CVAS', 'CONSULTA DE VALORES EN SUSPENSO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (248, 'DEPOSITO INICIAL CTA AHORROS', 'DEPI', 'DEPOSITO INICIAL EN CUENTA CORRIENTE')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (249, 'MANTENIMIENTO RELACIONES NAVIDAD', 'MRNV', 'CREA Y MANTIENE LAS RELACIONES ACH DE LAS CUENTAS DE NAVIDAD')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (250, 'CREACION CUENTA NAVIDAD', 'ACTN', 'CREA LAS CUENTAS DE NAVIDAD CON LOS PARAMETROS NECESARIOS Y MINIMOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (251, 'DEPOSITO AHORROS C/L', 'DPCL', 'ESTA TRANSACCION PROCESA LOS DEPSITOS DE AHORROS CON LIBRETA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (252, 'DEPOSITO AHORROS', '26319', 'ESTA TRANSACCION PROCESA LOS DEPOSITOS DE AHORROS SIN LIBRETA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (253, 'N/C', 'NCSL', 'ESTA TRANSACCION PROCESA LAS NOTAS DE CREDITO DE AHORROS SIN LIBRETA Y SI HAY VALORES EN SUSPENSO LOS COBRA.')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (254, 'DEPOSITO CON FECHA EFECTIVA', 'DPFE', 'ESTA TRANSACCION PROCESA LOS DEPOSITO CON FECHA EFECTIVA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (255, 'NOTA CREDITO', 'NCCL', 'ESTA TRANSACCION PROCESA LOS NOTAS DE CREDITO CON LIBRETA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (256, 'PERSONIFICACION LIBRETA', 'PELI', 'LA TRANSACCION PERSONIFICA LAS LIBRETAS DE AHORRO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (257, 'NOTA DE CREDITO CON FECHA EFECTIVA', 'NCFE', 'ESTA TRANSACCION PROCESA LAS NOTAS DE CREDITO CON FECHA EFECTIVA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (258, 'GENERACION DE VALOR EN SUSPENSO POR N/D', 'GVS1', 'GENERACION DE VALOR EN SUSPESO POR N/D PRIMERA VEZ')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (259, 'GENERACION DE VALOR EN SUSPENSO SEGUNDA VEZ', 'GVS2', 'GENERACION DE VALOR EN SUSPESO POR N/D SEGUNDA VEZ')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (260, 'CANCELACION DE PAGOS DE CUOTAS DE NAVIDAD', 'BPNA', 'CANCELA Y ANULA LA CANCELACION DE PAGOS DE CUOTAS EN CTAS NAVIDAD')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (261, 'RETIRO AHORROS C/L', 'RECL', 'ESTA TRANSACCION PROCESA LOS RETIROS DE AHORROS CON LIBRETA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (262, 'NOTA DE DEBITO AHORROS C/L', 'NDCL', 'ESTA TRANSACCION PROCESA LAS NOTAS DE DEBITO DE AHORROS CON LIBRETA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (263, 'RETIRO AHORROS', '26333', 'ESTA TRANSACCION PROCESA LOS RETIROS DE AHORROS SIN LIBRETA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (264, 'N/D', 'NDSL', 'ESTA TRANSACCION PROCESA LAS NOTAS DE DEBITO DE AHORROS SIN LIBRETA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (265, 'ACTUALIZACION DE LIBRETA', 'ACLB', 'ESTA TRANSACCION PROCESA LAS ACTUALIZACIONES DE LIBRETA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (266, 'NOTA DE DEBITO AHORROS FECHA EFECTIVA', 'NDFE', 'ESTA TRANSACCION PROCESA LAS NOTAS DE DEBITO DE AHORROS CON FECHA EFECTIVA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (267, 'CONSULTA MOVIMIENTOS BANRED', 'CSMB', 'CONSULTA DE 5 ULTIMOS MOVIMIENTOS CAJEROS BANRED')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (268, 'TRANSFERENCIA AH/CC NACIONAL', 'TCCB', 'TRANFERENCIA DE FONDOS ENTRE CC/CC CAJEROS TELERED')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (269, 'TRANSFERENCIA AH/AH NACIONAL', 'TCHB', 'TRANFERENCIA DE FONDOS ENTRE AH/AH CAJEROS TELERED')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (270, 'CONSULTA DE TOTALES POR OFICINA AH', 'CTOA', 'CONSULTA DE TOTALES POR OFICINA AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (271, 'ACUMULACION DE INTERESES EN AH', 'AIAH', 'ACUMULACION DE INTERESES EN AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (272, 'RETIROS OFF LINE ATM PROPIOS', 'ROFP', 'RETIROS OFF LINE ATM PROPIOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (273, 'CONSULTA SALDOS CTA AHO ATM INTERNACIONAL', 'CSNP', 'CONSULTA SALDOS CTA AHO ATM INTERNACIONAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (274, 'CONSULTA MOVIMIENTOS ATM PROPIOS', 'CSMP', 'CONSULTA DE 5 ULTIMOS MOVIMIENTOS ATM PROPIOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (275, 'TRANSFERENCIAS AH/CC TELETON', 'TCCP', 'TRANFERENCIA DE FONDOS ENTRE CC/CC TELETON')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (276, 'TRANSFERENCIAS AH/AH TELETON', 'TCHP', 'TRANFERENCIA DE FONDOS ENTRE CC/CC TELETON')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (277, 'RETIRO CTA CTE VISA - ATM', 'RCVI', 'RETIRO CTA CTE VISA - ATM')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (278, 'AVANCE CTA CTE VISA - POS', 'ACVI', 'AVANCE CTA CTE VISA - POS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (279, 'CONSULTA SALDOS CAJEROS BANRED', 'CSNB', 'CONSULTA DE SALDOS CAJEROS BANRED')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (280, 'ANULACION LIBRETAS AH', 'ALAH', 'ANULACION LIBRETAS AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (281, 'CONSULTA HISTORICO TRN MONETARIAS AHO', 'CHTM', 'CONSULTA HISTORICO TRANSACCIONES MONETARIAS AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (282, 'CONSULTA TRANSACCIONES DE SERVICIO AHO', 'CTRS', 'CONSULTA TRANSACCIONES DE SERVICIO AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (283, 'CONSULTA HISTORICO TRN SERVICIOS AHO', 'CHTS', 'CONSULTA HISTORICO TRANSACCIONES DE SERVICIOS AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (284, 'RETIRO CTA AHO ATM INTERNACIONAL', 'RAVI', 'RETIRO CTA AHO ATM INTERNACIONAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (285, 'AVANCE CTA AHO VISA - ATM', 'AAVI', 'AVANCE CTA AHO VISA - ATM')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (286, 'CONSUMOS ON LINE MAESTRO', 'CONM', 'CONSUMOS ON LINE MAESTRO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (287, 'CONSUMOS OFF LINE MAESTRO', 'COFM', 'CONSUMOS OFF LINE MAESTRO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (288, 'CONSULTA DE SALDOS MAESTRO', 'COSM', 'CONSULTA DE SALDOS MAESTRO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (289, 'RETIROS ON LINE ATM PROPIOS', 'RONP', 'RETIROS ON LINE ATM PROPIOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (290, 'NOTAS DB/DC LIBRETAS AH', 'NDAH', 'NOTAS DE DEBITO Y CREDITO LIBRETAS AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (291, 'CONSULTA DE TOTALES POR OPERADOR AH', 'TOPA', 'CONSULTA DE TOTALES POR OPERADOR AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (292, 'CONSULTA DE TOTALES DEVUELTOS AH', 'CTDA', 'CONSULTA DE TOTALES DEVUELTOS AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (293, 'CONSULTA SALDO CAJERO CIRRUS AH', 'CSCA', 'CONSULTA DE SALDOS POR CAJERO CIRRUS AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (294, 'CREDITO TRANSF. DE CC A AH', 'CTCA', 'CREDITO POR TRANSFERENCIAS DE CC A AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (295, 'ELIMINACION DE CLIENTE DE CUENTA DE AHORROS', 'ELAH', 'ELIMINACION DE CLIENTE DE CUENTA DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (296, 'INSERSION DE CLIENTE A CUENTA DE AHORROS', 'ICLA', 'INSERSION DE CLIENTE A CUENTA DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (297, 'CONSULTA PARA ACTUALIZACION GENERAL AH', 'CGRA', 'CONSULTA PARA ACTUALIZACION GENERAL DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (298, 'CONSULTA DE CLIENTES DE UNA CUENTA AH', 'CLIA', 'CONSULTA DE CLIENTES DE UNA CUENTA DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (299, 'CONSULTA DE ACTUALIZACION CRITICA', 'CCRA', 'CONSULTA DE DATOS DE CUENTA DE AHORROS PARA SU ACTUALIZACION CRITICA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (300, 'CREDITO TRANSFERENCIA AHO A AHO', 'CTAH', 'CREDITO POR TRANSFERECIAS AH A AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (301, 'CONSULTA PARA REFERENCIAS BANCARIAS', 'CRAH', 'CONSULTA PARA REFERENCIAS BANCARIAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (302, 'OPERACIONES SUPERIORES A UN MONTO', 'OSPA', 'OPERACIONES SUPERIORES A UN MONTO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (303, 'COBRO DE VALORES EN SUSPENSO EN LINEA PARA AHO', 'CVSA', 'COBRO DE VALORES EN SUSPENSO EN LINEA PARA AHO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (304, 'N/C INTERESES/RENDIMIENTOS CTAS INACT AH', 'CAPI', 'N/C INTERESES/RENDIMIENTOS CTAS INACT AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (305, 'BLOQUEO POR CONSUMO ATM AHORROS', 'BCAA', 'BLOQUEO POR CONSUMO ATM AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (306, 'LEVANTAMIENTO MANUAL DE CONSUMO ATM AHORROS ', 'LMCA', 'LEVANTAMIENTO MANUAL DE CONSUMO ATM AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (307, 'CONSULTA SALDOS CTA AHO ATM NACIONAL', 'CATM', 'CONSULTA SALDOS CTA AHO ATM NACIONAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (308, 'RET IMP PAGO INT/REND AH', 'IRCI', 'RET IMP PAGO INT/REND AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (309, 'RET IMP PAGO INT/REND CTAS INACT AH', 'IRCT', 'RET IMP PAGO INT/REND CTAS INACT AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (310, 'DEVOLUCION DE IDB POR CIERRE DE CUENTA', 'DICA', 'DEVOLUCION DE IDB POR CIERRE DE CUENTA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (311, 'ND POR CHQ DEVUELTO AH (CHQ LOCAL)', 'NDDA', 'NOTA DE DEBITO POR CHEQUE DEVUELTO AH (CHQ LOCAL)')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (312, 'SALDO TRANSF. CONV. TECNOLOGICA', 'STCT', 'SALDO TRANSF. CONV. TECNOLOGICA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (313, 'ND POR CHQ DEVUELTO AH OTROS BANCOS', 'NDOA', 'ND POR CHEQUE DEVUELTO AH OTROS BANCOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (314, 'CONSULTA DE EDO DE CTA POR CONEXION BANCARIBE AH', 'CCBA', 'CONSULTA DE EDO DE CTA POR CONEXION BANCARIBE AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (315, 'N/C FCH EFECTIVA', '26428', 'NOTA DE CREDITO FECHA EFECTIVA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (316, 'N/D FCH EFECTIVA', '26429', 'NOTA DE DEBITO FECHA EFECTIVA AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (317, 'NOTA DE DEBITO ESPECIAL AH C/L', 'DEAH', 'NOTA DE DEBITO ESPECIAL DE AHORROS C/LIBRETA CON CAUSAS PARA DESBALANCEO DE CAJA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (318, 'NOTA DE DEBITO ESPECIAL AH S/L', 'DEAS', 'NOTA DE DEBITO ESPECIAL DE AHORROS S/LIBRETA CON CAUSAS PARA DESBALANCEO DE CAJA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (319, 'OFICINAS AUTORIZADAS PARA TRANSACCIONES EN CUENTAS CIFRADAS', 'OACI', 'OFICINAS AUTORIZADAS PARA TRANSACCIONES EN CUENTAS CIFRADAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (320, 'APERTURA DE CUENTAS CIFRADAS', 'APCI', 'APERTURA DE CUENTAS CIFRADAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (321, 'CHEQUES REINGRESADOS EN CUENTAS DE AHORROS', 'CHRA', 'CHEQUES REINGRESADOS EN CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (322, 'CONSULTA DE COMISIONES POR TRANSACCION', 'CCPT', 'CONSULTA DE COMISIONES POR TRANSACCION')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (323, 'REVERSO DE INTERESES ACUMULADOS', 'RIAH', 'REVERSO DE INTERESES ACUMULADOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (324, 'AJUSTE DE INTERESES DE AHORROS - CONSULTA', 'CINA', 'AJUSTE DE INTERESES DE AHORROS - CONSULTA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (325, 'AJUSTE DE INTERESES DE AHORROS - AUMENTO', 'AINA', 'AJUSTE DE INTERESES DE AHORROS - AUMENTO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (326, 'AJUSTE DE INTERESES DE AHORROS - DISMINUCION', 'DINA', 'AJUSTE DE INTERESES DE AHORROS - DISMINUCION')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (327, 'INSERCION DE UN EMBARGO - CUENTAS DE AHORROS', 'IEMA', 'INSERCION DE UN EMBARGO - CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (328, 'LEVANTAMIENTO DE UN EMBARGO - CUENTAS DE AHORROS', 'LEMA', 'LEVANTAMIENTO DE UN EMBARGO - CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (329, 'CONSULTA DE EMBARGOS - CUENTAS DE AHORROS', 'CEMA', 'CONSULTA DE EMBARGOS - CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (330, 'CONSULTA HISTORICA DE TASAS PONDERADAS ', 'CHTP', 'CONSULTA HISTORICA DE TASAS PONDERADAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (331, 'CONSULTA DE RETENCIONES LOCALES DE AHORROS', 'CRLA', 'CONSULTA DE RETENCIONES LOCALES DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (332, 'LIBERACION ANTICIPADA DE FONDOS', 'LARA', 'LIBERACION ANTICIPADA DE FONDOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (333, 'CONSULTA Y MANTENIMIENTO DE BENEFICIARIOS CUENTAS DE AHORROS', 'CMBA', 'CONSULTA Y MANTENIMIENTO DE BENEFICIARIOS CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (334, 'ACUMULACION DE MANT.VALOR EN AH', 'AMVA', 'ACUMULACION DE MANT.VALOR EN AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (335, 'N/C CAPITALIZACION MANT.VALOR AH', 'CMVA', 'N/C CAPITALIZACION MANT.VALOR AH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (336, 'CONSULTA DE CAUSALES DE ND PARA CTA DE AHORRO', 'CNDA', 'CONSULTA DE CAUSALES DE ND PARA CTA DE AHORRO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (337, 'CONSULTA DE CAUSALES DE NC PARA CTA DE AHORRO', 'CNCA', 'CONSULTA DE CAUSALES DE NC PARA CTA DE AHORRO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (338, 'APERTURA DE CUENTA DE AHORROS NAVIDAD', 'ACANV', 'APERTURA DE CUENTA DE AHORROS NAVIDAD')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (339, 'CIERRE DE CUENTA DE AHORROS NAVIDAD', 'CCANV', 'CIERRE DE CUENTA DE AHORROS NAVIDAD')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (340, 'CONSULTA DE CUENTAS DE AHORROS (HELP)', 'CCAHO', 'CONSULTA DE CUENTAS DE AHORROS (HELP)')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (341, 'INGRESOS NO TRIBUTARIOS', 'INGNOT', 'INGRESOS NO TRIBUTARIOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (342, 'DEPOSITOS EN BATCH', '342', 'DEPOSITOS EN BATCH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (343, 'CONSULTA DE DETALLE DE INTERES', '343', 'CONSULTA DE DETALLE DE INTERES')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (344, 'VALIDACION EXISTENCIA PROD BAN SPLUS Y SCASH', '344', 'VALIDACION EXISTENCIA PROD BAN SPLUS Y SCASH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (345, 'INSERCION DE INFORMACION ADICIONAL A CUENTAS', '345', 'INSERCION DE INFORMACION ADICIONAL A CUENTAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (346, 'MODIFICACION DE INFORMACION ADICIONAL A CUENTAS', '346', 'MODIFICACION DE INFORMACION ADICIONAL A CUENTAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (347, 'CONSULTA DE INFORMACION ADICIONAL A CUENTAS', '347', 'CONSULTA DE INFORMACION ADICIONAL A CUENTAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (348, 'SEARCH DE INFORMACION ADICIONAL A CUENTAS', '348', 'SEARCH DE INFORMACION ADICIONAL A CUENTAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (349, 'DEPOSITO CHQ CONVENIENCIA VISA AHO.', 'DCCV', 'DEPOSITO DE CHEQUE DE CONVENIENCIA VISA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (350, 'VALIDACION EXISTENCIA MENOR EDAD', '350', 'VALIDACION EXISTENCIA MENOR EDAD')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (351, 'SOLICITUD APERTURA AHORROS', '351', 'SOLICITUD APERTURA AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (352, 'INSERCION DE SOLICITUD DE CTA.', '352', 'INSERCION DE SOLICITUD PARA UNA APERTURA DE CTA. AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (353, 'INSERCION DE SOL.TITULAR Y ALTERNANTE.', '353', 'INSERCION DE SOLICITUD PARA UNA APERTURA DE CTA. TITULAR Y ALTERNANTE')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (354, 'ACTUALIZACION DE SOLICITUD DE CTA.', '354', 'ACTUALIZACION DE SOLICITUD PARA UNA APERTURA DE CTA. AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (355, 'QUERY DE SOLICITUD DE CTA.', '355', 'QUERY DE SOLICITUD PARA UNA APERTURA DE CTA. DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (356, 'SEARCH DE SOLICITUD DE CTA.', '356', 'SEARCH DE SOLICITUD PARA UNA APERTURA DE CTA. DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (357, 'PANTALLA DE SOLICITUD DE CTA.', '357', 'PANTALLA DE CONSULTA DE SOLICITUD DE CTA. DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (358, 'HABILITACI+N DEL MENU DE BLOQUEOS LEGALES AHORROS', '358', 'HABILITACI+N DEL MENU DE BLOQUEOS LEGALES AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (359, 'HABILITACI+N DEL MENU DE LEV. BLOQUEOS LEGALES AHORROS', '359', 'HABILITACI+N DEL MENU DE LEV. BLOQUEOS LEGALES AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (360, 'CONSULTA DE OFICINAS PARA EMISION REPORTE DE CUENTAS DE NAVIDAD', '360', 'CONSULTA DE OFICINAS PARA EMISION DE REPORTE DE CUENTAS DE NAVIDAD')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (361, 'CONSULTA DE RELACIONES EXISTENTES - CTAS. NAVIDAD', '361', 'CONSULTA DE RELACIONES EXISTENTES - CTAS. NAVIDAD')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (362, 'A-ADIR CUENTA DE NAVIDAD A UNA RELACION', '362', 'A-ADIR CUENTA DE NAVIDAD A UNA RELACION')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (363, 'ELIMINAR CUENTA DE NAVIDAD DE UNA RELACION', '363', 'ELIMINAR CUENTA DE NAVIDAD DE UNA RELACION')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (364, 'MARCAR CUENTA DE NAVIDAD PARA PAGO', '364', 'MARCAR CUENTA DE NAVIDAD PARA PAGO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (365, 'PAGO A TERCERO POR ATM', '365', 'PAGO A TERCERO POR ATM')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (366, 'PAGO DE TERCERO POR ATM', '366', 'PAGO DE TERCERO POR ATM')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (367, 'INACTIVACION DE CUENTAS DE AHORROS', '367', 'INACTIVACION DE CUENTAS DE AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (368, 'SEGURIDAD SOBRE CAMPO DE OFICIAL DE LA CUENTA', '368', 'SEGURIDAD SOBRE CAMPO DE OFICIAL DE LA CUENTA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (369, 'SEGURIDAD SOBRE TITULARIDAD DE LA CUENTA', '369', 'SEGURIDAD SOBRE CAMPO TITULARIDAD DE LA CUENTA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (370, 'IMPRESION MASIVA ESTADOS DE CUENTA', 'IMEC', 'IMPRESION MASIVA ESTADOS DE CUENTA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (371, 'RETIRO AUTORIZADO EN FUERA DE LINEA', 'RAOF', 'RETIRO EN CALL CENTER')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (372, 'CONSULTA NOMBRE CUENTA POR BRANCH', 'CONN', 'CONSULTA NOMBRE CUENTA POR BRANCH')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (373, 'COBRO DE GMF A CARGO DEL BANCO', '373', 'COBRO DE GMF A CARGO DEL BANCO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (374, 'TRANSLADO DE CUENTAS ENTRE OFICINAS', '374', 'TRANSLADO DE CUENTAS ENTRE OFICINAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (375, 'ENVIO DE CUENTAS A LA DTN', 'ECDTN', 'ENVIO DE CUENTAS A LA DTN')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (376, 'REINTEGRO DE CUENTAS DE LA DTN', 'RCDTN', 'REINTEGRO DE CUENTAS DE LA DTN')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (377, 'SOLICITUD DE REINTEGRO A LA DTN', 'SRDTN', 'SOLICITUD DE REINTEGRO A LA DTN')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (378, 'SOLICITUD DE REINTEGRO A LA DTN CUENTAS CANCELADAS', 'SRDCC', 'SOLICITUD DE REINTEGRO A LA DTN CUENTAS CANCELADAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (379, 'GMF SOBRE RENDIMIENTOS A CARGO DEL BANCO', 'GMFBC', 'GMF SOBRE RENDIMIENTOS A CARGO DEL BANCO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (380, 'RETIRO AHORROS EN CHEQUE', 'RACC', 'RETIRO AHORROS EN CHEQUE')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (381, 'LIBERACION DE CUPO CB POSICIONADO', 'LCCB', 'LIBERACION DE CUPO CB POSICIONADO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (382, 'NOVEDAD DE REMESAS AHO', 'NREA', 'NOVEDAD DE REMESAS AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (383, 'DESBLOQUEO DE CHEQUE REMESA AHO', 'DSBA', 'DESBLOQUEO DE CHEQUE REMESA AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (384, 'ACUSE DE BLOQUEO DE CHEQUE REMESA AHO', 'ABRA', 'ACUSE BLOQUEO DE CHEQUE REMESA AHORROS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (385, 'INSERCION CODIGO DTN POR CATEGORIA Y PROFINAL', '385', 'INSERCION CODIGO DTN POR CATEGORIA Y PROFINAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (386, 'ACTUALIZACION CODIGO DTN POR CATEGORIA Y PROFINAL', '386', 'ACTUALIZACION CODIGO DTN POR CATEGORIA Y PROFINAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (387, 'ELIMINACION CODIGO DTN POR CATEGORIA Y PROFINAL', '387', 'ELIMINACION CODIGO DTN POR CATEGORIA Y PROFINAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (388, 'SEARCH CODIGO DTN POR CATEGORIA Y PROFINAL', '388', 'SEARCH CODIGO DTN POR CATEGORIA Y PROFINAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (389, 'QUERY CODIGO DTN POR CATEGORIA Y PROFINAL', '389', 'QUERY CODIGO DTN POR CATEGORIA Y PROFINAL')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (390, 'Tadmin/Administracion/Mantenimiento Codigos DTN', '390', 'Tadmin/Administracion/Mantenimiento Codigos DTN')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (391, 'ABONO DE REMESAS', 'ABRE', 'ABONO DE REMESAS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (392, 'AUTORIZACION RETIRO MONTO INEMBARGABILIDAD', 'RMMI', 'AUTORIZACION RETIRO MONTO INEMBARGABILIDAD')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (393, 'IMPRESION PLAN DE PAGO CUENTAS ESPECIALES', 'IMPL', 'IMPRESION PLAN DE PAGO CUENTAS ESPECIALES')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (394, 'CANCELACION CUENTA CB POSICIONADO', 'CCCB', 'CANCELACION CUENTA CB POSICIONADO')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (395, 'CONSULTA SEGUIMIENTO PLAN', 'COSE', 'CONSULTA SEGUIMIENTO PLAN')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (396, 'MANTENIMIENTO CB RED PROPIA', 'MCBRP', 'MANTENIMIENTO CB RED PROPIA')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (397, 'MANTENIMIENTO CB PUNTOS', 'MCBPU', 'MANTENIMIENTO CB PUNTOS')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (398, 'MANTENIMIENTO CUPO CB', 'MCUCB', 'MANTENIMIENTO CUPO CB')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (399, 'CONSULTA MOVIMIENTOS CB', 'CMOVCB', 'CONSULTA MOVIMIENTOS CB')
GO

INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (400, 'CORRESPONSAL BANCARIO RED POSICIONADO', 'CBRP', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO




delete cobis..cl_ttransaccion
where tn_trn_code in (1181,1182,6030)
go



INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1181, 'CONSULTA DE CEDULA O RUC', '1181', 'CONSULTA DE CEDULA O RUC')
GO

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1182, 'CONSULTA CLIENTES', 'COCLI', 'CONSULTA DE CLIENTES')
GO

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (6030, 'CONSULTA DE EMPRESA Y MASCARA PARA CUENTAS', '6030', 'CONSULTA DE EMPRESA Y MASCARA PARA CUENTAS')
GO

/********************************************************

POR FAVOR NO SOBREPASA DE 400 PARA LOS CODIGOS DE TRANSACCION 
DE AHORROS PUES LOS CODIGOS MAYORES A 400 PERTENECEN A OTRO PRODUCTO
SI ES NECESARIO CONSULTAR CON EL ADMINISTRADOR DEL MODULO

 *********************************************************/
