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

delete cl_ttransaccion
where tn_trn_code >= 200
and   tn_trn_code <= 400 
go


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (200, 'CIERRE DE CUENTA AHORRO SOCIAL', 'CCAS', 'CIERRE DE CUENTA AHORRO SOCIAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (201, 'APERTURA DE CUENTA DE AHORROS', 'ACAH', 'APERTURA DE CUENTA DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (202, 'ACTUALIZACION DE CUENTA DE AHORROS', 'AAHO', 'ACTUALIZACION DE CUENTA DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (203, 'REACTIVACION DE CUENTAS DE AHORROS', 'RCAH', 'REACTIVACION DE CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (204, 'REAPERTURA DE CUENTAS DE AHORROS', 'RACA', 'REAPERTURA DE CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (205, 'ACTUALIZACION DE CUENTA DE AHORROS GENERAL', 'AAGN', 'ACTUALIZACION DE CUENTA DE AHORROS GENERAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (206, 'CONSULTA DEL NOMBRE DE LA CUENTA DE AHORROS', 'CONO', 'ESTA TRANSACCION CONSUTA EL NOMBRE DE LA CUENTA DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (207, 'DEPOSITO COMPLETO DIFERIDO CL AH', 'DDCL', 'DEPOSITO COMPLETO DIFERIDO CL AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (208, 'CONSULTA DE DETALLE DE PRODUCTO AH', 'CPAH', 'CONSULTA DE DETALLE DE PRODUCTO AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (209, 'CERTIFICACION DE CHEQUES AH', 'CCHQ', 'CERTIFICACION DE CHEQUES AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (210, 'CONSULTA DE AGENCIA POR F5 AH', 'AGAH', 'CONSULTA DE AGENCIA POR F5 AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (211, 'BLOQUEO DE MOVIMIENTOS DE AHORROS', 'BMAH', 'BLOQUEO DE MOVIMIENTOS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (212, 'LEVANTAMIENTO DE MOVIMIENTOS AH', 'LMAH', 'LEVANTAMIENTO DE MOVIMIENTOS AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (213, 'CIERRE DE CUENTA AH', 'CIAH', 'CIERRE DE CUENTA AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (214, 'CONSULTA DE CIERRE DE CUENTA', 'CCCA', 'CONSULTA DE CIERRE DE CUENTA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (215, 'APERTURA DE CAJA AH', 'ACAA', 'APERTURA DE CAJA AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (216, 'CONSULTA DE BLOQUEOS DE VALORES PARA LEVANTAMIENTO AH', 'CBVL', 'CONSULTA DE BLOQUEO DE VALORES PARA LEVANTAMIENTO AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (217, 'BLOQUEO DE VALORES AH', 'BVAH', 'BLOQUEO DE VALORES DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (218, 'LEVANTAMIENTO DE BLOQUEO DE VALORES AH', 'SFS', 'LEVANTAMIENTO DE BLOQUEO DE VALORES AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (219, 'EFECTIVIZACION RETENCION CHQS LOCALES', 'ER12', 'EFECTIVIZACION RETENCION CHQS LOCALES')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (220, 'CONSULTA DE AHORROS MONETARIA', 'CNMA', 'CONSULTA DE AHORROS MONETARIA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (221, 'N/C INTERESES/RENDIMIENTOS AH', 'CAAH', 'N/C INTERESES/RENDIMIENTOS AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (222, 'AUMENTO O DIMINUCION DE EFECTTIVO AH', 'ADAH', 'AUMENTO O DISMINUCION DE EFECTIVO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (223, 'SOLICITUD DE ESTADO DE CUENTA SIN COSTO AH', 'SECS', 'SOLICITUD DE ESTADO DE CUENTA SIN COSTO AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (224, 'ND POR CHEQUE DEVUELTO REMESAS', 'NDCR', 'NOTA DE DEBITO POR CHEQUE DEVUELTO REMESAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (225, 'CONTABILIZACION DE DEPOSITOS EN CHQS LOCALES', 'CCLA', 'CONTABILIZACION DE DEPOSITOS EN CHEQUES LOCALES')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (226, 'CONTABILIZACION DE CONFIRMACION DE DEPOSITOS CHQS LOCALES', 'CCCA', 'CONTABILIZACION DE CONFIRMACION DE DEPOSITOS EN CHQS LOCALES')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (227, 'CONSULTA DE TRANSACCION AHORROS ESPECIFICA POR CAJERO', 'CEAC', 'PERMITE REALIZAR LA CONSULTA DE LAS TRANSACCIONES DE AHORROS DE UN CODIGO ESPECIFICO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (228, 'NOTA DE DEBITO SIN LIBRETA DE CARTERA', 'NCSC', 'NOTA DE DEBITO SIN LIBRETA DE CARTERA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (229, 'NOTA DE CREDITO SIN LIBRETA DE CARTERA', 'NDSC', 'NOTA DE DEBITO SIN LIBRETA DE CARTERA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (230, 'CONSULTA DE SALDOS DE CUENTAS DE AHORROS', 'CSAH', 'CONSULTA DE SALDOS DE CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (231, 'CONSULTA DE BLOQUEOS DE VALORES AH', 'CBVA', 'CONSULTA DE BLOQUEOS DE VALORES AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (232, 'CONSULTA DE ESTADO DE CUENTA DE AHORROS', 'CECA', 'CONSULTA DE ESTADO DE CUENTA DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (233, 'CONSULTA DE LINEAS PENDIENTES', 'CLPE', 'CONSULTA DE LINEAS PENDIENTES')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (234, 'COBRO DE SOLICITUD DE ESTADO DE CUENTA AH', 'CSEC', 'SOLICITUD DE ESTADO DE CUENTA AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (235, 'CONSULTA NO MONETARIA DE AHORROS', 'CMAH', 'CONSULTA NO MONETARIA DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (236, 'SOLICITUD DE ESTADO DE CUENTA DE AH', 'SECA', 'SOLICITUD DE ESTADO DE CUENTA AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (237, 'DEBITO TRANSFERENCIA AHO A AHO', 'XACC', 'DEBITO TRANSF. DE AH A AA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (238, 'RETIRO CTA AHO ATM NACIONAL', 'RATA', 'RETIRO CTA AHO ATM NACIONAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (239, 'DEBITO TRANSF. DE AH A CC', 'XAAH', 'DEBITO TRANSF. DE AH A CC')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (240, 'ND POR CHQ DEVUELTO AH', 'NDCH', 'NOTA DE DEBITO POR CHEQUE DEVUELTO AH (CHQ PROPIO)')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (241, 'DESMARCAR LINEAS PENDIENTES', 'DLPE', 'DESMARCAR LINEA PENDIENTE')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (242, 'INACTIVACION DE CUENTAS AH', 'ICTA', 'INACTIVACION DE CUENTAS AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (243, 'DEBITO OVERNIGHT DE AH', 'DOAH', 'DEBITO OVERNIGHT DE AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (244, 'CREDITO OVERNIGHT DE AH', 'COAH', 'CREDITO OVERNIGHT DE AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (245, 'CONSULTA DE BLOQUEO DE MOVIMIENTOS', 'CBMO', 'CONSULTA DE BLOQUEO DE MOVIMIENTOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (246, 'DEPOSITO COMPLETO DIFERIDO SL AH', 'DDSL', 'DEPOSITO COMPLETO DIFERIDO SL AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (247, 'CONSULTA DE VALORES EN SUSPENSO', 'CVAS', 'CONSULTA DE VALORES EN SUSPENSO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (248, 'DEPOSITO INICIAL CTA AHORROS', 'DEPI', 'DEPOSITO INICIAL EN CUENTA CORRIENTE')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (249, 'MANTENIMIENTO RELACIONES NAVIDAD', 'MRNV', 'CREA Y MANTIENE LAS RELACIONES ACH DE LAS CUENTAS DE NAVIDAD')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (250, 'CREACION CUENTA NAVIDAD', 'ACTN', 'CREA LAS CUENTAS DE NAVIDAD CON LOS PARAMETROS NECESARIOS Y MINIMOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (251, 'DEPOSITO AHORROS C/L', 'DPCL', 'ESTA TRANSACCION PROCESA LOS DEPSITOS DE AHORROS CON LIBRETA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (252, 'DEPOSITO AHORROS', '26319', 'ESTA TRANSACCION PROCESA LOS DEPOSITOS DE AHORROS SIN LIBRETA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (253, 'N/C', 'NCSL', 'ESTA TRANSACCION PROCESA LAS NOTAS DE CREDITO DE AHORROS SIN LIBRETA Y SI HAY VALORES EN SUSPENSO LOS COBRA.')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (254, 'DEPOSITO CON FECHA EFECTIVA', 'DPFE', 'ESTA TRANSACCION PROCESA LOS DEPOSITO CON FECHA EFECTIVA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (255, 'NOTA CREDITO', 'NCCL', 'ESTA TRANSACCION PROCESA LOS NOTAS DE CREDITO CON LIBRETA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (256, 'PERSONIFICACION LIBRETA', 'PELI', 'LA TRANSACCION PERSONIFICA LAS LIBRETAS DE AHORRO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (257, 'NOTA DE CREDITO CON FECHA EFECTIVA', 'NCFE', 'ESTA TRANSACCION PROCESA LAS NOTAS DE CREDITO CON FECHA EFECTIVA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (258, 'GENERACION DE VALOR EN SUSPENSO POR N/D', 'GVS1', 'GENERACION DE VALOR EN SUSPESO POR N/D PRIMERA VEZ')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (259, 'GENERACION DE VALOR EN SUSPENSO SEGUNDA VEZ', 'GVS2', 'GENERACION DE VALOR EN SUSPESO POR N/D SEGUNDA VEZ')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (260, 'CANCELACION DE PAGOS DE CUOTAS DE NAVIDAD', 'BPNA', 'CANCELA Y ANULA LA CANCELACION DE PAGOS DE CUOTAS EN CTAS NAVIDAD')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (261, 'RETIRO AHORROS C/L', 'RECL', 'ESTA TRANSACCION PROCESA LOS RETIROS DE AHORROS CON LIBRETA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (262, 'NOTA DE DEBITO AHORROS C/L', 'NDCL', 'ESTA TRANSACCION PROCESA LAS NOTAS DE DEBITO DE AHORROS CON LIBRETA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (263, 'RETIRO AHORROS', '26333', 'ESTA TRANSACCION PROCESA LOS RETIROS DE AHORROS SIN LIBRETA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (264, 'N/D', 'NDSL', 'ESTA TRANSACCION PROCESA LAS NOTAS DE DEBITO DE AHORROS SIN LIBRETA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (265, 'ACTUALIZACION DE LIBRETA', 'ACLB', 'ESTA TRANSACCION PROCESA LAS ACTUALIZACIONES DE LIBRETA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (266, 'NOTA DE DEBITO AHORROS FECHA EFECTIVA', 'NDFE', 'ESTA TRANSACCION PROCESA LAS NOTAS DE DEBITO DE AHORROS CON FECHA EFECTIVA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (267, 'CONSULTA MOVIMIENTOS BANRED', 'CSMB', 'CONSULTA DE 5 ULTIMOS MOVIMIENTOS CAJEROS BANRED')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (268, 'TRANSFERENCIA AH/CC NACIONAL', 'TCCB', 'TRANFERENCIA DE FONDOS ENTRE CC/CC CAJEROS TELERED')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (269, 'TRANSFERENCIA AH/AH NACIONAL', 'TCHB', 'TRANFERENCIA DE FONDOS ENTRE AH/AH CAJEROS TELERED')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (270, 'CONSULTA DE TOTALES POR OFICINA AH', 'CTOA', 'CONSULTA DE TOTALES POR OFICINA AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (271, 'ACUMULACION DE INTERESES EN AH', 'AIAH', 'ACUMULACION DE INTERESES EN AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (272, 'RETIROS OFF LINE ATM PROPIOS', 'ROFP', 'RETIROS OFF LINE ATM PROPIOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (273, 'CONSULTA SALDOS CTA AHO ATM INTERNACIONAL', 'CSNP', 'CONSULTA SALDOS CTA AHO ATM INTERNACIONAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (274, 'CONSULTA MOVIMIENTOS ATM PROPIOS', 'CSMP', 'CONSULTA DE 5 ULTIMOS MOVIMIENTOS ATM PROPIOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (275, 'TRANSFERENCIAS AH/CC TELETON', 'TCCP', 'TRANFERENCIA DE FONDOS ENTRE CC/CC TELETON')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (276, 'TRANSFERENCIAS AH/AH TELETON', 'TCHP', 'TRANFERENCIA DE FONDOS ENTRE CC/CC TELETON')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (277, 'RETIRO CTA CTE VISA - ATM', 'RCVI', 'RETIRO CTA CTE VISA - ATM')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (278, 'AVANCE CTA CTE VISA - POS', 'ACVI', 'AVANCE CTA CTE VISA - POS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (279, 'CONSULTA SALDOS CAJEROS BANRED', 'CSNB', 'CONSULTA DE SALDOS CAJEROS BANRED')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (280, 'ANULACION LIBRETAS AH', 'ALAH', 'ANULACION LIBRETAS AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (281, 'CONSULTA HISTORICO TRN MONETARIAS AHO', 'CHTM', 'CONSULTA HISTORICO TRANSACCIONES MONETARIAS AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (282, 'CONSULTA TRANSACCIONES DE SERVICIO AHO', 'CTRS', 'CONSULTA TRANSACCIONES DE SERVICIO AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (283, 'CONSULTA HISTORICO TRN SERVICIOS AHO', 'CHTS', 'CONSULTA HISTORICO TRANSACCIONES DE SERVICIOS AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (284, 'RETIRO CTA AHO ATM INTERNACIONAL', 'RAVI', 'RETIRO CTA AHO ATM INTERNACIONAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (285, 'AVANCE CTA AHO VISA - ATM', 'AAVI', 'AVANCE CTA AHO VISA - ATM')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (286, 'CONSUMOS ON LINE MAESTRO', 'CONM', 'CONSUMOS ON LINE MAESTRO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (287, 'CONSUMOS OFF LINE MAESTRO', 'COFM', 'CONSUMOS OFF LINE MAESTRO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (288, 'CONSULTA DE SALDOS MAESTRO', 'COSM', 'CONSULTA DE SALDOS MAESTRO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (289, 'RETIROS ON LINE ATM PROPIOS', 'RONP', 'RETIROS ON LINE ATM PROPIOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (290, 'NOTAS DB/DC LIBRETAS AH', 'NDAH', 'NOTAS DE DEBITO Y CREDITO LIBRETAS AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (291, 'CONSULTA DE TOTALES POR OPERADOR AH', 'TOPA', 'CONSULTA DE TOTALES POR OPERADOR AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (292, 'CONSULTA DE TOTALES DEVUELTOS AH', 'CTDA', 'CONSULTA DE TOTALES DEVUELTOS AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (293, 'CONSULTA SALDO CAJERO CIRRUS AH', 'CSCA', 'CONSULTA DE SALDOS POR CAJERO CIRRUS AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (294, 'CREDITO TRANSF. DE CC A AH', 'CTCA', 'CREDITO POR TRANSFERENCIAS DE CC A AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (295, 'ELIMINACION DE CLIENTE DE CUENTA DE AHORROS', 'ELAH', 'ELIMINACION DE CLIENTE DE CUENTA DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (296, 'INSERSION DE CLIENTE A CUENTA DE AHORROS', 'ICLA', 'INSERSION DE CLIENTE A CUENTA DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (297, 'CONSULTA PARA ACTUALIZACION GENERAL AH', 'CGRA', 'CONSULTA PARA ACTUALIZACION GENERAL DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (298, 'CONSULTA DE CLIENTES DE UNA CUENTA AH', 'CLIA', 'CONSULTA DE CLIENTES DE UNA CUENTA DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (299, 'CONSULTA DE ACTUALIZACION CRITICA', 'CCRA', 'CONSULTA DE DATOS DE CUENTA DE AHORROS PARA SU ACTUALIZACION CRITICA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (300, 'CREDITO TRANSFERENCIA AHO A AHO', 'CTAH', 'CREDITO POR TRANSFERECIAS AH A AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (301, 'CONSULTA PARA REFERENCIAS BANCARIAS', 'CRAH', 'CONSULTA PARA REFERENCIAS BANCARIAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (302, 'OPERACIONES SUPERIORES A UN MONTO', 'OSPA', 'OPERACIONES SUPERIORES A UN MONTO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (303, 'COBRO DE VALORES EN SUSPENSO EN LINEA PARA AHO', 'CVSA', 'COBRO DE VALORES EN SUSPENSO EN LINEA PARA AHO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (304, 'N/C INTERESES/RENDIMIENTOS CTAS INACT AH', 'CAPI', 'N/C INTERESES/RENDIMIENTOS CTAS INACT AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (305, 'BLOQUEO POR CONSUMO ATM AHORROS', 'BCAA', 'BLOQUEO POR CONSUMO ATM AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (306, 'LEVANTAMIENTO MANUAL DE CONSUMO ATM AHORROS ', 'LMCA', 'LEVANTAMIENTO MANUAL DE CONSUMO ATM AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (307, 'CONSULTA SALDOS CTA AHO ATM NACIONAL', 'CATM', 'CONSULTA SALDOS CTA AHO ATM NACIONAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (308, 'RET IMP PAGO INT/REND AH', 'IRCI', 'RET IMP PAGO INT/REND AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (309, 'RET IMP PAGO INT/REND CTAS INACT AH', 'IRCT', 'RET IMP PAGO INT/REND CTAS INACT AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (310, 'DEVOLUCION DE IDB POR CIERRE DE CUENTA', 'DICA', 'DEVOLUCION DE IDB POR CIERRE DE CUENTA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (311, 'ND POR CHQ DEVUELTO AH (CHQ LOCAL)', 'NDDA', 'NOTA DE DEBITO POR CHEQUE DEVUELTO AH (CHQ LOCAL)')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (312, 'SALDO TRANSF. CONV. TECNOLOGICA', 'STCT', 'SALDO TRANSF. CONV. TECNOLOGICA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (313, 'ND POR CHQ DEVUELTO AH OTROS BANCOS', 'NDOA', 'ND POR CHEQUE DEVUELTO AH OTROS BANCOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (314, 'CONSULTA DE EDO DE CTA POR CONEXION BANCARIBE AH', 'CCBA', 'CONSULTA DE EDO DE CTA POR CONEXION BANCARIBE AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (315, 'N/C FCH EFECTIVA', '26428', 'NOTA DE CREDITO FECHA EFECTIVA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (316, 'N/D FCH EFECTIVA', '26429', 'NOTA DE DEBITO FECHA EFECTIVA AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (317, 'NOTA DE DEBITO ESPECIAL AH C/L', 'DEAH', 'NOTA DE DEBITO ESPECIAL DE AHORROS C/LIBRETA CON CAUSAS PARA DESBALANCEO DE CAJA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (318, 'NOTA DE DEBITO ESPECIAL AH S/L', 'DEAS', 'NOTA DE DEBITO ESPECIAL DE AHORROS S/LIBRETA CON CAUSAS PARA DESBALANCEO DE CAJA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (319, 'OFICINAS AUTORIZADAS PARA TRANSACCIONES EN CUENTAS CIFRADAS', 'OACI', 'OFICINAS AUTORIZADAS PARA TRANSACCIONES EN CUENTAS CIFRADAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (320, 'APERTURA DE CUENTAS CIFRADAS', 'APCI', 'APERTURA DE CUENTAS CIFRADAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (321, 'CHEQUES REINGRESADOS EN CUENTAS DE AHORROS', 'CHRA', 'CHEQUES REINGRESADOS EN CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (322, 'CONSULTA DE COMISIONES POR TRANSACCION', 'CCPT', 'CONSULTA DE COMISIONES POR TRANSACCION')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (323, 'REVERSO DE INTERESES ACUMULADOS', 'RIAH', 'REVERSO DE INTERESES ACUMULADOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (324, 'AJUSTE DE INTERESES DE AHORROS - CONSULTA', 'CINA', 'AJUSTE DE INTERESES DE AHORROS - CONSULTA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (325, 'AJUSTE DE INTERESES DE AHORROS - AUMENTO', 'AINA', 'AJUSTE DE INTERESES DE AHORROS - AUMENTO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (326, 'AJUSTE DE INTERESES DE AHORROS - DISMINUCION', 'DINA', 'AJUSTE DE INTERESES DE AHORROS - DISMINUCION')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (327, 'INSERCION DE UN EMBARGO - CUENTAS DE AHORROS', 'IEMA', 'INSERCION DE UN EMBARGO - CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (328, 'LEVANTAMIENTO DE UN EMBARGO - CUENTAS DE AHORROS', 'LEMA', 'LEVANTAMIENTO DE UN EMBARGO - CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (329, 'CONSULTA DE EMBARGOS - CUENTAS DE AHORROS', 'CEMA', 'CONSULTA DE EMBARGOS - CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (330, 'CONSULTA HISTORICA DE TASAS PONDERADAS ', 'CHTP', 'CONSULTA HISTORICA DE TASAS PONDERADAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (331, 'CONSULTA DE RETENCIONES LOCALES DE AHORROS', 'CRLA', 'CONSULTA DE RETENCIONES LOCALES DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (332, 'LIBERACION ANTICIPADA DE FONDOS', 'LARA', 'LIBERACION ANTICIPADA DE FONDOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (333, 'CONSULTA Y MANTENIMIENTO DE BENEFICIARIOS CUENTAS DE AHORROS', 'CMBA', 'CONSULTA Y MANTENIMIENTO DE BENEFICIARIOS CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (334, 'ACUMULACION DE MANT.VALOR EN AH', 'AMVA', 'ACUMULACION DE MANT.VALOR EN AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (335, 'N/C CAPITALIZACION MANT.VALOR AH', 'CMVA', 'N/C CAPITALIZACION MANT.VALOR AH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (336, 'CONSULTA DE CAUSALES DE ND PARA CTA DE AHORRO', 'CNDA', 'CONSULTA DE CAUSALES DE ND PARA CTA DE AHORRO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (337, 'CONSULTA DE CAUSALES DE NC PARA CTA DE AHORRO', 'CNCA', 'CONSULTA DE CAUSALES DE NC PARA CTA DE AHORRO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (338, 'APERTURA DE CUENTA DE AHORROS NAVIDAD', 'ACANV', 'APERTURA DE CUENTA DE AHORROS NAVIDAD')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (339, 'CIERRE DE CUENTA DE AHORROS NAVIDAD', 'CCANV', 'CIERRE DE CUENTA DE AHORROS NAVIDAD')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (340, 'CONSULTA DE CUENTAS DE AHORROS (HELP)', 'CCAHO', 'CONSULTA DE CUENTAS DE AHORROS (HELP)')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (341, 'INGRESOS NO TRIBUTARIOS', 'INGNOT', 'INGRESOS NO TRIBUTARIOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (342, 'DEPOSITOS EN BATCH', '342', 'DEPOSITOS EN BATCH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (343, 'CONSULTA DE DETALLE DE INTERES', '343', 'CONSULTA DE DETALLE DE INTERES')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (344, 'VALIDACION EXISTENCIA PROD BAN SPLUS Y SCASH', '344', 'VALIDACION EXISTENCIA PROD BAN SPLUS Y SCASH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (345, 'INSERCION DE INFORMACION ADICIONAL A CUENTAS', '345', 'INSERCION DE INFORMACION ADICIONAL A CUENTAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (346, 'MODIFICACION DE INFORMACION ADICIONAL A CUENTAS', '346', 'MODIFICACION DE INFORMACION ADICIONAL A CUENTAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (347, 'CONSULTA DE INFORMACION ADICIONAL A CUENTAS', '347', 'CONSULTA DE INFORMACION ADICIONAL A CUENTAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (348, 'SEARCH DE INFORMACION ADICIONAL A CUENTAS', '348', 'SEARCH DE INFORMACION ADICIONAL A CUENTAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (349, 'DEPOSITO CHQ CONVENIENCIA VISA AHO.', 'DCCV', 'DEPOSITO DE CHEQUE DE CONVENIENCIA VISA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (350, 'VALIDACION EXISTENCIA MENOR EDAD', '350', 'VALIDACION EXISTENCIA MENOR EDAD')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (351, 'SOLICITUD APERTURA AHORROS', '351', 'SOLICITUD APERTURA AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (352, 'INSERCION DE SOLICITUD DE CTA.', '352', 'INSERCION DE SOLICITUD PARA UNA APERTURA DE CTA. AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (353, 'INSERCION DE SOL.TITULAR Y ALTERNANTE.', '353', 'INSERCION DE SOLICITUD PARA UNA APERTURA DE CTA. TITULAR Y ALTERNANTE')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (354, 'ACTUALIZACION DE SOLICITUD DE CTA.', '354', 'ACTUALIZACION DE SOLICITUD PARA UNA APERTURA DE CTA. AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (355, 'QUERY DE SOLICITUD DE CTA.', '355', 'QUERY DE SOLICITUD PARA UNA APERTURA DE CTA. DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (356, 'SEARCH DE SOLICITUD DE CTA.', '356', 'SEARCH DE SOLICITUD PARA UNA APERTURA DE CTA. DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (357, 'PANTALLA DE SOLICITUD DE CTA.', '357', 'PANTALLA DE CONSULTA DE SOLICITUD DE CTA. DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (358, 'HABILITACI+N DEL MENU DE BLOQUEOS LEGALES AHORROS', '358', 'HABILITACI+N DEL MENU DE BLOQUEOS LEGALES AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (359, 'HABILITACI+N DEL MENU DE LEV. BLOQUEOS LEGALES AHORROS', '359', 'HABILITACI+N DEL MENU DE LEV. BLOQUEOS LEGALES AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (360, 'CONSULTA DE OFICINAS PARA EMISION REPORTE DE CUENTAS DE NAVIDAD', '360', 'CONSULTA DE OFICINAS PARA EMISION DE REPORTE DE CUENTAS DE NAVIDAD')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (361, 'CONSULTA DE RELACIONES EXISTENTES - CTAS. NAVIDAD', '361', 'CONSULTA DE RELACIONES EXISTENTES - CTAS. NAVIDAD')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (362, 'A-ADIR CUENTA DE NAVIDAD A UNA RELACION', '362', 'A-ADIR CUENTA DE NAVIDAD A UNA RELACION')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (363, 'ELIMINAR CUENTA DE NAVIDAD DE UNA RELACION', '363', 'ELIMINAR CUENTA DE NAVIDAD DE UNA RELACION')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (364, 'MARCAR CUENTA DE NAVIDAD PARA PAGO', '364', 'MARCAR CUENTA DE NAVIDAD PARA PAGO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (365, 'PAGO A TERCERO POR ATM', '365', 'PAGO A TERCERO POR ATM')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (366, 'PAGO DE TERCERO POR ATM', '366', 'PAGO DE TERCERO POR ATM')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (367, 'INACTIVACION DE CUENTAS DE AHORROS', '367', 'INACTIVACION DE CUENTAS DE AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (368, 'SEGURIDAD SOBRE CAMPO DE OFICIAL DE LA CUENTA', '368', 'SEGURIDAD SOBRE CAMPO DE OFICIAL DE LA CUENTA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (369, 'SEGURIDAD SOBRE TITULARIDAD DE LA CUENTA', '369', 'SEGURIDAD SOBRE CAMPO TITULARIDAD DE LA CUENTA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (370, 'IMPRESION MASIVA ESTADOS DE CUENTA', 'IMEC', 'IMPRESION MASIVA ESTADOS DE CUENTA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (371, 'RETIRO AUTORIZADO EN FUERA DE LINEA', 'RAOF', 'RETIRO EN CALL CENTER')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (372, 'CONSULTA NOMBRE CUENTA POR BRANCH', 'CONN', 'CONSULTA NOMBRE CUENTA POR BRANCH')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (373, 'COBRO DE GMF A CARGO DEL BANCO', '373', 'COBRO DE GMF A CARGO DEL BANCO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (374, 'TRANSLADO DE CUENTAS ENTRE OFICINAS', '374', 'TRANSLADO DE CUENTAS ENTRE OFICINAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (375, 'ENVIO DE CUENTAS A LA DTN', 'ECDTN', 'ENVIO DE CUENTAS A LA DTN')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (376, 'REINTEGRO DE CUENTAS DE LA DTN', 'RCDTN', 'REINTEGRO DE CUENTAS DE LA DTN')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (377, 'SOLICITUD DE REINTEGRO A LA DTN', 'SRDTN', 'SOLICITUD DE REINTEGRO A LA DTN')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (378, 'SOLICITUD DE REINTEGRO A LA DTN CUENTAS CANCELADAS', 'SRDCC', 'SOLICITUD DE REINTEGRO A LA DTN CUENTAS CANCELADAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (379, 'GMF SOBRE RENDIMIENTOS A CARGO DEL BANCO', 'GMFBC', 'GMF SOBRE RENDIMIENTOS A CARGO DEL BANCO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (380, 'RETIRO AHORROS EN CHEQUE', 'RACC', 'RETIRO AHORROS EN CHEQUE')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (381, 'LIBERACION DE CUPO CB POSICIONADO', 'LCCB', 'LIBERACION DE CUPO CB POSICIONADO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (382, 'NOVEDAD DE REMESAS AHO', 'NREA', 'NOVEDAD DE REMESAS AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (383, 'DESBLOQUEO DE CHEQUE REMESA AHO', 'DSBA', 'DESBLOQUEO DE CHEQUE REMESA AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (384, 'ACUSE DE BLOQUEO DE CHEQUE REMESA AHO', 'ABRA', 'ACUSE BLOQUEO DE CHEQUE REMESA AHORROS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (385, 'INSERCION CODIGO DTN POR CATEGORIA Y PROFINAL', '385', 'INSERCION CODIGO DTN POR CATEGORIA Y PROFINAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (386, 'ACTUALIZACION CODIGO DTN POR CATEGORIA Y PROFINAL', '386', 'ACTUALIZACION CODIGO DTN POR CATEGORIA Y PROFINAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (387, 'ELIMINACION CODIGO DTN POR CATEGORIA Y PROFINAL', '387', 'ELIMINACION CODIGO DTN POR CATEGORIA Y PROFINAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (388, 'SEARCH CODIGO DTN POR CATEGORIA Y PROFINAL', '388', 'SEARCH CODIGO DTN POR CATEGORIA Y PROFINAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (389, 'QUERY CODIGO DTN POR CATEGORIA Y PROFINAL', '389', 'QUERY CODIGO DTN POR CATEGORIA Y PROFINAL')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (390, 'Tadmin/Administracion/Mantenimiento Codigos DTN', '390', 'Tadmin/Administracion/Mantenimiento Codigos DTN')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (391, 'ABONO DE REMESAS', 'ABRE', 'ABONO DE REMESAS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (392, 'AUTORIZACION RETIRO MONTO INEMBARGABILIDAD', 'RMMI', 'AUTORIZACION RETIRO MONTO INEMBARGABILIDAD')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (393, 'IMPRESION PLAN DE PAGO CUENTAS ESPECIALES', 'IMPL', 'IMPRESION PLAN DE PAGO CUENTAS ESPECIALES')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (394, 'CANCELACION CUENTA CB POSICIONADO', 'CCCB', 'CANCELACION CUENTA CB POSICIONADO')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (395, 'CONSULTA SEGUIMIENTO PLAN', 'COSE', 'CONSULTA SEGUIMIENTO PLAN')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (396, 'MANTENIMIENTO CB RED PROPIA', 'MCBRP', 'MANTENIMIENTO CB RED PROPIA')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (397, 'MANTENIMIENTO CB PUNTOS', 'MCBPU', 'MANTENIMIENTO CB PUNTOS')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (398, 'MANTENIMIENTO CUPO CB', 'MCUCB', 'MANTENIMIENTO CUPO CB')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (399, 'CONSULTA MOVIMIENTOS CB', 'CMOVCB', 'CONSULTA MOVIMIENTOS CB')


INSERT INTO  cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (400, 'CORRESPONSAL BANCARIO RED POSICIONADO', 'CBRP', 'CORRESPONSAL BANCARIO RED POSICIONADO')


GO

--------------------------------------------------------------------------------------------------------------------
delete cl_ttransaccion
 where tn_trn_code in (1181,1182,6030,709,740,2587, 4145, 
                       80,90,99,403,408,410,429,
                       494,584,537,602,603,604,606,607,672,697,702,707,708,710,714,717,
                       720,738,743,2564,2581,2582,2583,2584,2585,2586, 2588,2589,
                       2590,2591,2592,2593,2594,2595,2596,2669,2696,2700,2810,2879,
                       2913,2938,4101,4102,4103,4104,4105,4106,4107,4108,4133,4144,
                       4149,4150,4151,4152,4153,4154,4155,4163,4130,4131,4132,4134,
                       4135,4142,4146,4148,4164,4165,4166,4167,452,475,696,698,741,
                       29265,2576,424,34,6907,2812,407,601,447,721,704,6906,719,16,
                       711,92,493,747,3016,700,2916,739,2811,689,699,701,2850,50,48,
                       734,2914,2915,538,4168,4169,4170,4171)
go

INSERT cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4145, 'ACTIVACION DE CUENTAS SIN DEPOSITO INICIAL', '4145', 'ACTIVACION DE CUENTAS SIN DEPOSITO INICIAL')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1181, 'CONSULTA DE CEDULA O RUC', '1181', 'CONSULTA DE CEDULA O RUC')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1182, 'CONSULTA CLIENTES', 'COCLI', 'CONSULTA DE CLIENTES')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (6030, 'CONSULTA DE EMPRESA Y MASCARA PARA CUENTAS', '6030', 'CONSULTA DE EMPRESA Y MASCARA PARA CUENTAS')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (709, 'ELIMINACION CONCEPTO CONTABLE', 'EPCC', 'ELIMINACION CONCEPTO CONTABLE')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (740, 'MANTENIMIENTO ND/NC POR OFICINA D', 'MNDCO', 'MANTENIMIENTO ND/NC POR OFICINA')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2587, 'CONSULTA DE RUTA Y TRANSITO', 'CRYT', 'CONSULTA DE RUTA Y TRANSITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (80, 'CONSULTA DE TOTALES POR OFICINA', 'CTOF', 'CONSULTA DE TOTALES POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (90, 'CONSULTA DE TOTALES POR CAJERO ADM', 'CTCA', 'CONSULTA LOS TOTALES DE CAJERO (ADMINISTRATIVA)')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (99, 'MENSAJES DE ESTADOS DE CUENTA', 'MEEC', 'INSERTA LOS MENSAJES PARA IMPRIMIR CON EL ESTADO DE CUENTA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (403, 'CONFIRMA CARTA DE REMESAS MANUAL', 'CCMA', 'CONFIRMA CARTA DE REMESAS MANUAL')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (408, 'CONSULTA DE CHEQUES POR CUENTA', 'CHCU', 'CONSULTA DE CHEQUES POR CUENTA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (410, 'CONSULTA DE CARTA POR CORRESPONSAL', 'CACO', 'CONSULTA DE CARTA POR CORRESPONSAL')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (429, 'CONSULTA DE CHEQUES REMESA POR OFICINA', 'CRPO', 'CONSULTA DE CHEQUES REMESA POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (494, 'CONSULTA DE TRANSACCIONES A CONTABILIZAR', 'CCON', 'CONSULTA DE TRANSACCIONES A CONTABILIZAR')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (584, 'INSERCION DE CATALOGO', 'INCATA', 'DESCRIPCION')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (602, 'CONSULTA CARTAS DE REMESAS X OFICINA', 'CCRO', 'CONSULTA CARTAS DE REMESAS X OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (603, 'ACUSE DE REMESAS', 'ADRE', 'ACUSE DE REMESAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (604, 'BLOQUEO DE CHEQUES', 'BDCH', 'BLOQUEO DE CHEQUES')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (606, 'CONSULTA CHEQUES REMESAS VIA BANCOS X OFICINA', 'CCBO', 'CONSULTA CHEQUES REMESAS VIA BANCOS X OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (607, 'CONSULTA TOTAL DE CHEQUES REMESAS VIA BANCOS X OFICINAS', 'CTCR', 'CONSULTA TOTAL DE CHEQUES REMESAS VIA BANCOS X OFICINAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (672, 'INGRESO TIPO CANJE POR OFICINA', 'TDCO', 'INGRESO TIPO CANJE POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (697, 'ADMINISTRACION CUENTA DE CONSIGNACION OFICINA', 'ACCO', 'ADMINISTRACION CUENTA DE CONSIGNACION OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (702, 'CONSULTA ARCHIVO DE ALIANZAS', 'CAAC', 'CONSULTA ARCHIVO DE ALIANZAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (707, 'PERSONALIZACION DE NOTAS DE DEBITO/CREDITO', 'PNDC', 'PERSONALIZACION DE NOTAS DE DEBITO/CREDITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (708, 'INGRESO CONCEPTO CONTABLE', 'IPCC', 'INGRESO CONCEPTO CONTABLE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (710, 'ACTUALIZACION CONCEPTO CONTABLE', 'APCC', 'ACTUALIZACION CONCEPTO CONTABLE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (714, 'INGRESO DE DEFINICION TRANSFERENCIAS AUTOMATICAS', 'BETA', 'INGRESO DE DEFINICION TRANSFERENCIAS AUTOMATICAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (717, 'INGRESO DE DETALLE TRANSFERENCIAS AUTOMATICAS', 'BETA', 'INGRESO DE DETALLE TRANSFERENCIAS AUTOMATICAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (720, 'MANTENIMIENTO OPCIONES DML PARA PARAMETRIZACION DE PERFIL', 'MPPER', 'REALIZA EL MANTENIMIENTO DE LOS DATOS PARA LA PARAMETRIZACION DE LAS TRANSACCIONES AL PERFIL CONTABLE')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (738, 'MANTENIMIENTO ND/NC POR OFICINA', 'MNDCO', 'MANTENIMIENTO ND/NC POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (743, 'TADMIN/PROCESOS/RELACION CUENTA A CANALES', 'TPRCC', 'TADMIN/PROCESOS/RELACION CUENTA A CANALES')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2564, 'MANTENIMIENTO PLAZAS BANCO REPUBLICA', 'MPBR', 'MANTENIMIENTO PLAZAS BANCO REPUBLICA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2581, 'CREACION DE ACCION NOTAS DEBITO', 'CAND', 'CREACION ACCION NOTAS DEBITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2582, 'ACTUALIZACION DE ACCION DE NOTAS DEBITO', 'AAND', 'ACTUALIZACION DE ACCION NOTAS DEBITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2583, 'CONSULTA DE ACCION NOTAS DEBITO', 'CAND', 'CONSULTA DE ACCION DE NOTAS DEBITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2584, 'ELIMINACION DE ACCION NOTAS DE DEBITO', 'EAND', 'ELIMINACION DE ACCION NOTAS DE DEBITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2585, 'CREACION DE RUTA Y TRANSITO', 'CRYT', 'CREACION DE RUTA Y TRANSITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2586, 'ACTUALIZACION DE RUTA Y TRANSITO', 'ARYT', 'ACTUALIZACION DE RUTA Y TRANSITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2588, 'ELIMINACION DE RUTA Y TRANSITO', 'ERYT', 'ELIMINACION DE RUTA Y TRANSITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2589, 'CREACION DE OFICINAS DEL BANCO', 'CODB', 'CREACION DE OFICINAS DEL BANCO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2590, 'ACTUALIZACION DE OFICINAS DEL BANCO', 'AODB', 'ACTUALIZACION DE OFICINAS DEL BANCO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2591, 'CONSULTA DE OFICINAS DEL BANCO', 'CODB', 'CONSULTA DE OFICINAS DEL BANCO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2592, 'ELIMINACION DE OFICINAS DEL BANCO', 'EODB', 'ELIMINACION DE OFICINAS DEL BANCO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2593, 'CREACION DE BANCOS', 'CBAN', 'CREACION DE BANCOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2594, 'ACTUALIZACION DE BANCOS', 'ABAN', 'ACTUALIZACION DE BANCOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2595, 'CONSULTA DE BANCOS', 'CBAN', 'CONSULTA DE BANCOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2596, 'ELIMINACION DE BANCOS', 'EBAN', 'ELIMINACION DE BANCOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2669, 'INGRESO FORM. CONTROL TRAN EFECTIVO', 'IFCT', 'INGRESO FORMULARIO CONTROL TRANS. EFECTIVO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2696, 'MANTENIMIENTO DE CAUSALES DE NOTAS DEBITO Y CREDITO PARA CAJA', 'MCDC', 'MANTENIMIENTO DE CAUSALES DE NOTAS DEBITO Y CREDITO PARA CAJA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2700, 'CONSULTA NACIONAL DE CAJA', 'CNAC', 'CONSULTA NACIONAL DE CAJA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2810, 'MANTENIMIENTO CENTROS DE CANJE', 'MCDC', 'MANTENIMIENTO CENTROS DE CANJE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2879, 'CREACION DE PAQUETE DE PRODUCTOS', 'CRPA', 'CREACION DE PAQUETE DE PRODUCTOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2913, 'CREACION CAUSA ING-EGR VARIOS', 'CCIE', 'CREACION CAUSALES INGRESOS EGRESOS VARIOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2914, 'ACTUALIZAR CAUSA ING-EGR VARIOS', 'ACIE', 'ACTUALIZAR CAUSALES INGRESOS EGRESOS VARIOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2915, 'ELIMINAR CAUSA ING-EGR VARIOS', 'ECIE', 'ELIMINAR CAUSALES INGRESOS EGRESOS VARIOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2916, 'CONSULTA CAUSA ING-EGR VARIOS', 'COIE', 'CONSULTA CAUSALES INGRESOS-EGRESOS VARIOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2938, 'INSERCION ORDEN DE COBRO CERTIFICACION', 'IOCC', 'INSERCION ORDEN DE COBRO CERTIFICACION')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4101, 'CATEGORIA POR PRODUCTOS FINALES', '4101', 'CATEGORIA POR PRODUCTOS FINALES')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4102, 'INGRESO CONCEPTO GMF', 'IGMF', 'INGRESO CONCEPTO EXENCION GMF')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4103, 'ACTUALIZACION CONCEPTO GMF', 'AGMF', 'ACTUALIZACION CONCEPTO EXENCION GMF')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4104, 'ELIMINACION CONCEPTO GMF', 'EGMF', 'ELIMINACION CONCEPTO EXENCION GMF')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4105, 'CONSULTA DE CUENTAS EXENTAS', 'CCEX', 'CONSULTA DE CUENTAS EXENTAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4106, 'ACTUALIZACION DE CUENTAS EXENTAS', 'ACEX', 'ACTUALIZACION DE CUENTAS EXENTAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4107, 'MANTENIMIENTO DE CONCEPTOS PARA TRANSACCIONES', 'MCTRN', 'MANTENIMIENTO DE CONCEPTOS PARA TRANSACCIONES')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4108, 'CONSULTA CONCEPTO GMF', 'CGMF', 'CONSULTA CONCEPTO EXENCION GMF')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4133, 'CONSULTA AUTORIZACION RETIRO POR OFICINA', '4133', 'CONSULTA AUTORIZACION RETIRO POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4144, 'C. de Ahorros/Cuentas/Activacion Cuentas sin Deposito Inicial', '4144', 'C. de Ahorros/Cuentas/Activacion Cuentas sin Deposito Inicial')



INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4149, 'MENU / MANTENIMIENTO CUPO CB', '4149', 'CORRESPONSAL BANCARIO RED POSICIONADO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4150, 'MENU / CONSULTA DE CUPO', '4150', 'CORRESPONSAL BANCARIO RED POSICIONADO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4151, 'MENU / CONSULTA DE MOVIMIENTOS', '4151', 'CORRESPONSAL BANCARIO RED POSICIONADO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4152, 'MENU / DEVOLUCION DE VALORES', '4152', 'CORRESPONSAL BANCARIO RED POSICIONADO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4153, 'MENU / GESTION DE CUENTAS', '4153', 'CORRESPONSAL BANCARIO RED POSICIONADO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4154, 'MENU / CONSOLIDADO DE REDES', '4154', 'CORRESPONSAL BANCARIO RED POSICIONADO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4155, 'MENU / MANTENIMIENTO CB', '4155', 'CORRESPONSAL BANCARIO RED POSICIONADO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4163, 'MENU MANTENIMIENTO EQUIVALENCIAS', '4163', 'MENU MANTENIMIENTO EQUIVALENCIAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4130, 'CAMBIO DE CATEGORIA', '4130', 'CAMBIO DE CATEGORIA PARA UNA CUENTA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4131, 'INGRESO AUTORIZACION RETIRO POR OFICINA', '4131', 'INGRESO AUTORIZACION RETIRO POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4132, 'BLOQUEO AUTORIZACION RETIRO POR OFICINA', '4132', 'BLOQUEO AUTORIZACION RETIRO POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4134, 'QUERY AUTORIZACION RETIRO POR OFICINA', '4134', 'QUERY AUTORIZACION RETIRO POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4135, 'INCUMPLIMIENTOS AHO CONTRACTUAL', '4135', 'MARCA INCUMPLIMIENTO AHO CONTRACTUAL')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4142, 'TRANSACCION MARCACION GMF', 'MGMF', 'EJECUTA PROCESO MARCACION GMF')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4146, 'ANULACION DE CUENTAS SIN DEPOSITO INCIAL', '4146', 'ANULACION DE CUENTAS SIN DEPOSITO INCIAL')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4148, 'TRANSACCION DESMARCACION GMF', 'DGMF', 'EJECUTA PROCESO DESMARCACION GMF')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4164, 'BUSQUEDA EQUIVALENCIAS', '4164', 'BUSQUEDA EQUIVALENCIAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4165, 'INSERCION EQUIVALENCIAS', '4165', 'INSERCION EQUIVALENCIAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4166, 'MODIFICACION EQUIVALENCIAS', '4166', 'MODIFICACION EQUIVALENCIAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4167, 'ELIMINACION EQUIVALENCIAS', '4167', 'ELIMINACION EQUIVALENCIAS')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4168, 'CONSULTA DE MOVIMIENTOS DE WS', '4168', 'CONSULTA DE MOVIMIENTOS DE WS')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4169, 'CONSULTA DE SALDOS Y MOV DE WS', '4169', 'CONSULTA DE MOVIMIENTOS DE WS')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4170, 'DEPOSITO DE CUENTA DE AHORROS DE WS', '4170', 'DEPOSITO DE CUENTA DE AHORROS DE WS')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4171, 'RETIRO DE CUENTA DE AHORROS DE WS', '4171', 'RETIRO DE CUENTA DE AHORROS DE WS')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (452, 'CONSULTA DE BANCOS PARA CAMARA', 'CBPC', 'CONSULTA DE LOS BANCOS EXISTENTES PARA CAMARA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (475, 'CONSULTA DE PRODUCTOS COBIS', 'COPC', 'CONSULTA DE PRODUCTOS COBIS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (696, 'CONSULTA CUENTA DE CONSIGNACION OFICINA', 'CCCO', 'CONSULTA CUENTA DE CONSIGNACION OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (698, 'CREACION DE ACCION NOTAS DEBITO', 'CAND', 'CREACION DE ACCION NOTAS DEBITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (741, 'BUSQUEDA DE CAUSALES', 'BUCAU', 'BUSQUEDA DE CAUSALES')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (29265, 'CONSULTA DE SUBTIPOS', 'CSTID', 'CONSULTA DE SUBTIPOS DE INSTRUMENTOS DISPONIBLES')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2576, 'CONSULTA CATALOGO TRN MONET Y SERV', 'CTMS', 'CONSULTA CATALOGO DE TRANSACCIONES MONETARIAS Y DE SERVICIOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (424, 'CONSULTA DE PRODUCTOS BANCARIOS', 'COPB', 'CONSULTA DE PRODUCTOS BANCARIOS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (34, 'CONSULTA DE AGENCIAS POR F5', 'COAG', 'CONSULTA DE AGENCIAS POR F5')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (6907, 'SEARCH DE PERFIL CONTABLE', '6907', 'SEARCH DE PERFIL CONTABLE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2812, 'TRASALADO DE CAPITAL SOBREGIRO POR VIGENCIA', 'TCSV', 'TRASALADO DE CAPITAL SOBREGIRO POR VIGENCIA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (407, 'CONSULTA GENERAL DE UNA CARTA', 'CGCA', 'CONSULTA GENERAL DE UNA CARTA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (601, 'ACUSE DE NOVEDADADES', 'ADNO', 'ACUSE DE NOVEDADADES')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (447, 'CONSULTA CARTAS Y BANCOS CORRESPONSALES', 'CCBC', 'CONSULTA CARTAS Y BANCOS CORRESPONSALES')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (721, 'OPCIONES DE CONSULTA PARA PARAMETRIZACION DE PERFIL', 'CPPER', 'EJECUTA LAS CONSULTAS DE LOS DATOS PARA LA PARAMETRIZACION DE LAS TRANSACCIONES AL PERFIL CONTABLE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (704, 'CONSULTA PUNTOS RED CB', '704', 'CONSULTA PUNTOS RED CB')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (6906, 'QUERY DE PERFIL CONTABLE', '6906', 'QUERY DE PERFIL CONTABLE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (719, 'CONSULTA CONCEPTO CONTABLE', 'CPCC', 'CONSULTA CONCEPTO CONTABLE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (16, 'CONSULTA DEL NOMBRE DE LA CUENTA CORRIENTE', 'CONM', 'ESTA TRANSACCION CONSULTA DEL NOMBRE DE LA CUENTA CORRIENTE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (711, 'BUSQUEDA DE DEFINICION TRANSFERENCIAS AUTOMATICAS', 'BETA', 'BUSQUEDA DE DEFINICION TRANSFERENCIAS AUTOMATICAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (92, 'CONSULTA DE CASILLA POR F5', 'CCAS', 'CONSULTA DE CASILLA POR F5')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (734, 'MANTENIMIENTO PRODUCTO AHORRO CONTRACTUAL', 'MAAH', 'MANTENIMIENTO PRODUCTO AHORRO CONTRACTUAL')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (493, 'MANTENIMIENTO DE TRANSACCIONES A CONTABILIZAR', 'MCON', 'MANTENIMEINTO DE TRANSACCIONES A CONTABILIZAR')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (747, 'BUSQUEDA DE RELACION CUENTA A CANAL', 'BRCC', 'BUSQUEDA DE RELACION CUENTA A CANAL')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (3016, 'QUERY DE FIRMAS CANDIDATAS', 'QRFC', 'QUERY DE FIRMAS CANDIDATAS')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (700, 'CONSULTA DE ACCION NOTAS DEBITO', 'CAND', 'CONSULTA DE ACCION DE NOTAS DEBITO')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (739, 'MANTENIMIENTO ND/NC POR OFICINA I', 'MNDCO', 'MANTENIMIENTO ND/NC POR OFICINA')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2811, 'RELACION OFICINA - CENTRO DE CANJE', 'ROCC', ' RELACION OFICINA - CENTRO DE CANJE')


INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (689, 'ELIMINACION DE  TRANSACCIONES A CONTABILIZAR', 'ETCO', 'ELIMINACION DE  TRANSACCIONES A CONTABILIZAR')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (699, 'ACTUALIZACION DE ACCION DE NOTAS DEBITO', 'AAND', 'ACTUALIZACION DE ACCION DE NOTAS DEBITO')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (701, 'ELIMINACION DE ACCION NOTAS DE DEBITO', 'EAND', 'ELIMINACION DE ACCION NOTAS DE DEBITO')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2850, 'ACTUALIZACION DE CUENTAS MAL CREADAS POR OLF-SAFE', 'CAMO', 'ACTUALIZACION DE CUENTAS MAL CREADAS POR OLF-SAFE')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (48, 'NOTA CREDITO', 'NCCO', 'ESTA TRANSACCION REALIZA LAS NOTAS DE CREDITO GENERALES')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (50, 'NOTA DEBITO', 'NDCO', 'ESTA TRANSACCION REALIZA LAS NOTAS DE DEBITO PONIENDO EN VALORES EN SUSPENSO SI NO EXISTIERA DISPONIBLE')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (537, 'CONSULTA PRODUCTO MENORES DE EDAD', 'PRMNED', 'CONSULTA PRODUCTO MENORES DE EDAD')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (538, 'CONSULTA DE DATOS DE CUENTAS PARA CONTRATOS', '538', 'CONSULTA DE DATOS DE CUENTAS PARA CONTRATOS')

go
--------------------------------------------------------------------------------------------------------------------

DELETE FROM cl_ttransaccion
 WHERE tn_trn_code in (705, 706, 703,1051, 402, 404, 405,
                       411, 412, 413, 414, 415, 416, 500, 1229, 639, 640)

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (705, 'CONSULTA GESTION CUENTAS DE CORRESPONSALIA CB', '705', 'CONSULTA GESTION CUENTAS DE CORRESPONSALIA CB')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (706, 'CONSULTA PUNTOS RED POSICIONADA', '706', 'CONSULTA PUNTOS RED POSICIONADA')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (703, 'CONSULTA DEVOLUCION VALORES RECAUDADOS CB', '703', 'CONSULTA DEVOLUCION VALORES RECAUDADOS CB')

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1051, 'BUSQ. OFICINAS', 'BOCNB', 'LISTA LAS OFICINAS QUE NO HAN SIDO ASOCIADAS AUN A UNA RELACION CLIENTE - CB')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (402, 'CHEQUES DEVUELTOS DE REMESAS', 'CDEV', 'CHEQUE DEVUELTO DE REMESAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (404, 'CONFIRMA CHEQUE DE UNA CARTA DE REMESAS', 'CNCQ', 'CONFIRMA CHEQUE DE UNA CARTA DE REMESAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (405, 'POSTERGACION DE FECHA DE EFECTIVIZACION DE UNA CARTA', 'POFH', 'POSTERGACION DE FECHA DE EFECTIVIZACION DE UNA CARTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (411, 'CONSULTA DE FUNC. AUTORIZANTE NC/ND', 'CFAN', 'CONSULTA DE FUNCIONARIO AUTORIZANTE NC/ND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (412, 'INGRESO DE FUNC. AUTORIZANTE NC/ND', 'IFAN', 'INGRESO DE FUNCIONARIO AUTORIZANTE NC/ND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (413, 'ELIMINACION DE FUNC. AUTORIZANTE NC/ND', 'EFAN', 'ELIMINACION DE FUNCIONARIO AUTORIZANTE NC/ND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (414, 'CONSULTA DE FUNC. EJECUTOR NC/ND', 'CFEN', 'CONSULTA DE FUNCIONARIO EJECUTOR NC/ND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (415, 'INGRESO DE FUNC. EJECUTOR NC/ND', 'IFEN', 'INGRESO DE FUNCIONARIO EJECUTOR NC/ND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (416, 'ELIMINACION DE FUNC. EJECUTOR NC/ND', 'EFEN', 'ELIMINACION DE FUNCIONARIO EJECUTOR NC/ND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (500, 'CONSULTA DE TRANSACCIONES MONETARIAS AHORROS PARA REVERSO', 'TMAHRE', 'CONSULTA DE TRANSACCIONES MONETARIAS AHORROS PARA REVERSO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1229, 'AYUDA DE DIRECCION', 'HEDIR', 'AYUDA DE DIRECCION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (639, 'REGISTRO DE CHEQUE', 'RECH', 'REGISTRO DE CHEQUE EN LA TABLA DEFINITIVA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (640,'CONSULTA DATOS DEL BANCO PARA IMPRESION DE CONTRATOS','CDBCO','CONSULTA DATOS DEL BANCO PARA IMPRESION DE CONTRATOS')

go


/********************************************************

POR FAVOR NO SOBREPASA DE 400 PARA LOS CODIGOS DE TRANSACCION 
DE AHORROS PUES LOS CODIGOS MAYORES A 400 PERTENECEN A OTRO PRODUCTO
SI ES NECESARIO CONSULTAR CON EL ADMINISTRADOR DEL MODULO

 *********************************************************/

 