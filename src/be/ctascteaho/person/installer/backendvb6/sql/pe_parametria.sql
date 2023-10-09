/*************************************************************************/
/*  Extracción tablas Personalización                                    */
/*                                                                       */
/*************************************************************************/

use cob_remesas
go

----pe_servicio_dis 
print 'insercion pe_servicio_dis'
if exists (select 1 from sysobjects where name = 'pe_servicio_dis' )
  delete pe_servicio_dis 
go

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (1, 'PAGO DE INTERESES', 'PINT', 'V', 0, 6, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (2, 'SOLICITUD DE CHEQUERA', 'SCHQ', 'V', 1500, 10, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (3, 'SOBREGIRO CONTRATADO', 'SCON', 'C', 0, 5, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (4, 'SOBREGIRO OCASIONAL', 'SOCA', 'C', 0, 5, NULL)
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (5, 'USO DE FONDOS EN CANJE', 'UFON', 'C', 0, 5, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (6, 'CHEQUES PAGADOS EXTRAS', 'CPEX', 'V', 0, 1, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (7, 'CHEQUES DEVUELTOS', 'CDEV', 'V', 0, 2, NULL)
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (8, 'REVOCATORIA DE CHEQUES', 'RVOC', 'C', 0, 2, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (9, 'CERTIFICACION DE CHEQUES', 'CECH', 'C', 0, 2, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (10, 'SOLICITUD DE ESTADO DE CUENTA', 'SECU', 'V', 0, 1, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (11, 'REGISTRO ORDEN DE NO PAGO', 'ANCH', 'C', 0, 1, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (12, 'DEVOLUCION CHEQUE GIRADO', 'POCH', 'C', 0, 2, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (13, 'ENVIO DE ESTADO DE CUENTA', 'EECT', 'V', 0, 2, NULL)
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (14, 'CIERRE DE CUENTAS', 'CCTA', 'V', 0, 4, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (15, 'MANTENIMIENTO DE CUENTAS', 'MCTA', 'V', 0, 1, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (16, 'ANULACION DE LIBRETA DE AHORRO', 'ANUL', 'C', 0, 3, NULL)
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (17, 'TASA CERTIFICACION CHQ.', 'TCCH', 'C', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (18, 'MANTENIMIENTO DE TARJETAS', 'MTAR', 'C', 0, 6, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (19, 'EMISION DE TARJETA', 'EMIT', 'C', 0, 6, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (20, 'REPOSICION DE TARJETA', 'REPT', 'C', 0, 6, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (21, 'SERVICIOS CAJEROS BANRED', 'BANR', 'C', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (22, 'SERVICIOS ATMS', 'ATMS', 'C', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (23, 'SERVICIOS PUNTO DE VENTA MAEST', 'MAES', 'C', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (24, 'SERVICIOS CAJEROS CIRRUS', 'CIRR', 'C', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (25, 'COMISION ENVIO AL COBRO DE CHEQUE REMESA', 'CREM', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (26, 'COSTO TALONARIOS AHORROS', 'TALO', 'C', 0, 3, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (28, 'MONTO MINIMO APERTURA', 'MMAP', 'V', 0, 2, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (29, 'REIMPRESION DE NOTAS', 'RIMN', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (31, 'TRANSACCION NACIONAL', 'TRNA', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (32, 'EMISION DE TARJETA PER.', 'EMI ', 'C', 0, 2, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (33, 'REELABORACION DE TARJETA PER.', 'REL ', 'C', 0, 2, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (34, 'REPOSICION DE TARJETA PER.', 'REP ', 'C', 0, 2, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (35, 'RENOVACION SOLICITADA DE TARJETA', 'REN ', 'C', 0, 2, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (36, 'RENOVACION AUTOMATICA DE TARJETA', 'RAU ', 'C', 0, 2, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (37, 'EMISION TARJETA INMEDIATA', 'ETI ', 'C', 0, 4, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (38, 'SUSTITUCION TARJETA INMEDIATA', 'STI ', 'C', 0, 4, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (39, 'RENOVACION TARJETA INMEDIATA', 'VTI ', 'C', 0, 6, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (40, 'REPOSICION TARJETA INMEDIATA', 'RTI ', 'C', 0, 4, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (41, 'COBRO CUOTA DE MANEJO', 'MAN ', 'C', 0, 5, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (42, 'ACTUALIZACION DE DATOS', 'ADA ', 'C', 0, 4, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (43, 'ACTUALIZACION DE CUENTAS', 'ACC ', 'C', 0, 4, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (44, 'REGRABACION DE LA BANDA', 'REG ', 'C', 0, 2, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (45, 'REELABORACION DE PIN', 'PIN ', 'C', 0, 2, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (50, 'SALDO MINIMO', 'SMC ', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (51, 'COMISION POR TRANSACCIONES ACH', 'CACH', 'C', 0, 22, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (52, 'COMISION  CENTRO  DE EFECTIVO', 'CCE ', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (53, 'BLOQUEO DE MOVIMIENTO', 'BLMA', 'C', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (54, 'SALDO MINIMO', 'CSLM', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (55, 'INACTIVIDAD', 'INAC', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (56, 'LIBERACION DE CANJE', 'LIRE', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (57, 'COMISION EN OFICINA', 'COCO', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (58, 'RETIRO POR VENTANILLA', 'REVE', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (59, 'CERTIFICACIONES Y REFERENCIAS', 'CCER', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (60, 'RETIRO CHEQUE GERENCIA', 'CHQG', 'V', 1000, 3, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (61, 'COMISION POR TRANSFERENCIA DE ALIANZA CO', 'TRAL', 'V', 0, 2, 'N')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (62, 'RETIRO CORRESPONSAL BANCARIO', 'RTCB', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (63, 'CONSULTA CORRESPONSAL BANCARIO', 'CNCB', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (64, 'DEPOSITO CORRESPONSAL BANCARIO', 'DPCB', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (65, 'COMISION TRANSACCION ATM NACIONAL', 'W264141', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (66, 'COMISION TRANSACCION ATM INTERNACIONAL', 'W264142', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (67, 'COMISION CONSULTA ATM NACIONAL', 'W264233', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (68, 'COMISION CONSULTA ATM INTERNACIONAL', 'W264234', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (69, 'COMISION CUOTA DE MANEJO', 'W264238', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (70, 'COMISION POR PIN INVALIDO', 'W264156', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (71, 'COMISION PERDIDA DETERIORO TARJE DEBITO', 'W264159', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (72, 'COMISION FONDOS INSUFICIENTES', 'W264161', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (73, 'COMISION RETIRO OF TARJETA DEBITO', 'CNTD', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (74, 'CONSULTA CB POSICIONADO', 'CNCBP', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (75, 'CONSULTA COSTO CB POSICIONADO', 'CCCBP', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (76, 'PAGO CB POSICIONADO', 'PACBP', 'V', 0, 0, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (77, 'RETIRO CB POSICIONADO', 'RTCBP', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (78, 'DEPOSITO CB POSICIONADO', 'DPCBP', 'V', 0, 1, 'S')
GO

INSERT INTO cob_remesas..pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (79, 'COMISION CONSULTA SALDO OFICINA CTA TD', 'CSTD', 'V', 0, 1, 'S')
GO

---pe_var_servicio   
print 'insercion pe_var_servicio'
if exists (select 1 from sysobjects where name = 'pe_var_servicio' )
  delete pe_var_servicio 
go

INSERT INTO dbo.pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (1, '18', 'PAGO INT. SOBRE EL DISPONIBLE', 'V', '+', 'P')
GO


INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (2, '2', 'IMPUESTO TIMBRE CHEQUERA', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (6, '10', 'MULTA POR CHQ ADICIONAL PAGADO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (7, '11', 'COMISION POR CHQ DEVUELTO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (10, '15', 'COSTO POR SOLCITUD DE EST.CTA.', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (13, '21', 'COSTO POR ENVIO DE ESTADO DE CTA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (13, '29', 'COSTO POR EMISION DE ESTADO DE CUENTA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (14, '22', 'MULTA CIERRE ANTES DE TIEMPO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (14, '3', 'DEDUCCION DE INTERES CIERRE ANTICIPADO', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (14, '41', 'MULTA CIERRE ANTES DE TIEMPO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (15, '24', 'COSTO POR MANT. DE CUENTA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '34', 'COMISION CHEQUE REMESAS-VIA INTERNA', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '38', 'PORTES SOBRE REMESAS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '43', 'COMISION CHEQUE REMESAS.CORRESPONSAL', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '44', 'COMISION CHEQUE REMESAS-BCO AGRARIO', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '45', 'PORTES DEVOLUCION CHEQUE REMESA', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '48', 'PORTES CHEQUES REMESAS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (28, '39', 'MONTO MINIMO APERTURA CUENTA DE AHORROS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (29, '3', 'COMISION REIMPRESION DE NOTAS', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '310', 'COM TRNA RETIRO CHQ GERENCIA', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '311', 'COM TRNA CONSULTA SALDO CAJA', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '312', 'COM TRNA DEPOSITO CTA AHORROS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '313', 'COM TRNA RETIRO CTA AHORROS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '314', 'COM TRNA CRE TRANSFERENCIA ENTRE CUENTAS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '315', 'COM TRNA TRANSFERENCIA ENTRE CUENTAS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '316', 'COM TRNA NOTA CR AHORROS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '317', 'COM TRNA NOTA DB AHORROS', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (50, 'SMA', 'SERVICIO SALDO MAXIMO DE LA CUENTA', 'V', '', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (50, 'SMI', 'SERVICIO SALDO MINIMO DE LA CUENTA', 'V', '', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (52, '3', 'COMISION  CENTRO  DE EFECTIVO', 'V', '', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (54, '3', 'COMISION POR SALDO MINIMO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (55, '3', 'COMISION POR INACTIVIDAD DE CUENTA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (56, '46', 'COMISION POR LIBERACION DE CANJE', 'V', '', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, '3', 'COBRO DE COMISION TRANSACCIONES EN OFICINA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C230', 'COMIS. TIPO C CONSULTA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C237', 'COMIS. TIPO D TRANSFERENCIA AA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C239', 'COMIS. TIPO D TRANSFERENCIA AC', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C2519', 'COMIS. TIPO D TRANSFERENCIA CC', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C252', 'COMIS. TIPO C DEPOSITO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C2520', 'COMIS. TIPO D TRANSFERENCIA CA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C253', 'COMIS. TIPO C N. CREDITO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C2626', 'COMIS. TIPO C TRANSFERENCIA CC', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C2627', 'COMIS. TIPO C TRANSFERENCIA AC', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C263', 'COMIS. TIPO C RETIRO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C264', 'COMIS. TIPO C N. DEBITO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C294', 'COMIS. TIPO C TRANSFERENCIA CA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C300', 'COMIS. TIPO C TRANSFERENCIA AA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C380', 'COMIS. TIPO C RET. CHQ. GERENCIA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'M', 'COMISION TIPO COBRO MENSUAL', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'T', 'COMISION TIPO COBRO CONTADOR GENERAL', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W230', 'COMIS. TIPO W CONSULTA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W237', 'COMIS. TIPO W TRANSFERENCIA DEB AA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W239', 'COMIS. TIPO W TRANSFERENCIA AC', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W2519', 'COMIS. TIPO W TRANSFERENCIA CC', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W252', 'COMIS. TIPO W DEPOSITO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W2520', 'COMIS. TIPO W TRANSFERENCIA CA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W253', 'COMIS. TIPO W N. CREDITO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W2626', 'COMIS. TIPO W TRANSFERENCIA CC', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W2627', 'COMIS. TIPO W TRANSFERENCIA AC', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W263', 'COMIS. TIPO W RETIRO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W264', 'COMIS. TIPO W N. DEBITO', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W294', 'COMIS. TIPO W TRANSFERENCIA CA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W300', 'COMIS. TIPO W TRANSFERENCIA CRE AA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W380', 'COMIS. TIPO W RET. CHQ. GERENCIA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (58, '3', 'RETIRO POR VENTANILLA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (59, '3', 'COMISION POR CERTIFICACIONES Y REFERENCIAS', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (60, '3', 'RETIRO CHEQUE GERENCIA', 'V', '+', 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (61, 'CMTR', 'MONTO COMISION POR TRANSFERENCIA ALIANZA', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (62, '3', 'COMISION RETIRO CORRESPONSAL BANCARIO', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (63, '3', 'COMISION CONSULTA CORRESPONSAL BANCARIO', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (64, '3', 'COMISION DEPOSITO CORRESPONSAL BANCARIO', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (65, '3', 'COMISION TRANSACCION ATM NACIONAL', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (66, '3', 'COMISION TRANSACCION ATM  INTERNACIONAL', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (67, '3', 'COMISION CONSULTA ATM NACIONAL', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (68, '3', 'COMISION CONSULTA ATM INTERNACIONAL', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (69, '3', 'COMISION CUOTA DE MANEJO', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (70, '3', 'COMISION POR PIN INVALIDO', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (71, '3', 'COMISION PERDIDA DETERIORO TARJE DEBITO', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (72, '3', 'COMISION FONDOS INSUFICIENTES', 'V', NULL, 'P')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (73, '3', 'COMISION RETIRO OF TARJETA DEBITO', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (74, '3', 'Consulta de Saldo CB Posicionado', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (75, '3', 'Consulta Costo CB Posicionado', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (77, '3', 'Retiro CB Posicionado', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (78, '3', 'Deposito CB Posicionado', 'V', NULL, 'M')
GO

INSERT INTO cob_remesas..pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (79, '3', 'COMISION CONSULTA SALDO OFICINA CTA AH T', 'V', NULL, 'M')
GO

---insercion pe_basico 
PRINT 'INSERCION pe_basico'

PRINT '=====> FIN'
go




