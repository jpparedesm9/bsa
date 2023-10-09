/*************************************************************************/
/*  Extracción tablas Personalización                                    */
/*                                                                       */
/*************************************************************************/

use cob_remesas
go

----pe_servicio_dis 
PRINT 'Insercion pe_servicio_dis'
IF exists (SELECT 1 FROM sysobjects WHERE name = 'pe_servicio_dis' )
  DELETE FROM pe_servicio_dis 
go

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (1, 'PAGO DE INTERESES', 'PINT', 'V', 4.00, 3, 'N')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (2, 'SOLICITUD DE CHEQUERA', 'SCHQ', 'V', 10.00, 1, 'N')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (6, 'CHEQUES PAGADOS EXTRAS', 'CPEX', 'V', 0, 1, 'N')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (7, 'CHEQUES DEVUELTOS', 'CDEV', 'V', 0, 1, NULL)
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (10, 'SOLICITUD DE ESTADO DE CUENTA', 'SECU', 'V', 0, 1, 'N')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (13, 'ENVIO DE ESTADO DE CUENTA', 'EECT', 'V', 0, 2, NULL)
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (14, 'CIERRE DE CUENTAS', 'CCTA', 'V', 0, 3, 'N')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (15, 'MANTENIMIENTO DE CUENTAS', 'MCTA', 'V', 0, 1, 'N')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (25, 'COMISION ENVIO AL COBRO DE CHEQUE REMESA', 'CREM', 'V', 0, 6, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (28, 'MONTO MINIMO APERTURA', 'MMAP', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (29, 'REIMPRESION DE NOTAS', 'RIMN', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (31, 'TRANSACCION NACIONAL', 'TRNA', 'V', 0, 8, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (50, 'SALDO MINIMO/MAXIMO', 'SMC ', 'V', 0, 2, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (52, 'COMISION  CENTRO  DE EFECTIVO', 'CCE ', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (54, 'SALDO MINIMO', 'CSLM', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (55, 'INACTIVIDAD', 'INAC', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (56, 'LIBERACION DE CANJE', 'LIRE', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (57, 'COMISION EN OFICINA', 'COCO', 'V', 0, 31, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (58, 'RETIRO POR VENTANILLA', 'REVE', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (59, 'CERTIFICACIONES Y REFERENCIAS', 'CCER', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (60, 'RETIRO CHEQUE GERENCIA', 'CHQG', 'V', 1000, 1, 'N')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (61, 'COMISION POR TRANSFERENCIA DE ALIANZA CO', 'TRAL', 'V', 0, 1, 'N')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (62, 'RETIRO CORRESPONSAL BANCARIO', 'RTCB', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (63, 'CONSULTA CORRESPONSAL BANCARIO', 'CNCB', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (64, 'DEPOSITO CORRESPONSAL BANCARIO', 'DPCB', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (65, 'COMISION TRANSACCION ATM NACIONAL', 'W264141', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (66, 'COMISION TRANSACCION ATM INTERNACIONAL', 'W264142', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (67, 'COMISION CONSULTA ATM NACIONAL', 'W264233', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (68, 'COMISION CONSULTA ATM INTERNACIONAL', 'W264234', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (69, 'COMISION CUOTA DE MANEJO', 'W264238', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (70, 'COMISION POR PIN INVALIDO', 'W264156', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (71, 'COMISION PERDIDA DETERIORO TARJE DEBITO', 'W264159', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (72, 'COMISION FONDOS INSUFICIENTES', 'W264161', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (73, 'COMISION RETIRO OF TARJETA DEBITO', 'CNTD', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (74, 'CONSULTA CB POSICIONADO', 'CNCBP', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (75, 'CONSULTA COSTO CB POSICIONADO', 'CCCBP', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (76, 'PAGO CB POSICIONADO', 'PACBP', 'V', 0, 0, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (77, 'RETIRO CB POSICIONADO', 'RTCBP', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (78, 'DEPOSITO CB POSICIONADO', 'DPCBP', 'V', 0, 1, 'S')
GO

INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
VALUES (79, 'COMISION CONSULTA SALDO OFICINA CTA TD', 'CSTD', 'V', 0, 1, 'S')
GO

--Actualización de cl_seqnos para tabla pe_servicio_dis

declare @w_codigo int

SELECT @w_codigo = max(sd_servicio_dis) 
FROM pe_servicio_dis

update cobis..cl_seqnos set siguiente = @w_codigo
    WHERE tabla='pe_servicio_dis'
go

---pe_var_servicio   
PRINT 'Insercion pe_var_servicio'
IF exists (SELECT 1 FROM sysobjects WHERE name = 'pe_var_servicio' )
  DELETE FROM pe_var_servicio 
go

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (1, '18', 'PAGO INT. SOBRE DISPONIBLE', 'V', '+', 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (1, '2', 'RETENCION DE IMP SOBRE INTERESES PAGADOS', 'V', NULL, 'P')
GO
--Historia: 79806
INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (1, '23', 'PAGO INT. POR CIERRE', 'B', '+', 'M')
GO
--Historia: 79806
INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (2, '2', 'IMPUESTO TIMBRE CHEQUERA', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (6, '10', 'MULTA POR CHQ ADICIONAL PAGADO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (7, '11', 'COMISION POR CHQ DEVUELTO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (10, '15', 'COSTO POR SOLCITUD DE EST.CTA.', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (13, '21', 'COSTO POR ENVIO DE ESTADO DE CTA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (13, '29', 'COSTO POR EMISION DE ESTADO DE CUENTA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (14, '22', 'MULTA CIERRE ANTES DE TIEMPO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (14, '3', 'DEDUCCION DE INTERES CIERRE ANTICIPADO', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (14, '41', 'MULTA CIERRE ANTES DE TIEMPO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (15, '24', 'COSTO POR MANT. DE CUENTA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '34', 'COMISION CHEQUE REMESAS-VIA INTERNA', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '38', 'PORTES SOBRE REMESAS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '43', 'COMISION CHEQUE REMESAS.CORRESPONSAL', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '44', 'COMISION CHEQUE REMESAS-BCO AGRARIO', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '45', 'PORTES DEVOLUCION CHEQUE REMESA', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (25, '48', 'PORTES CHEQUES REMESAS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (28, '39', 'MONTO MINIMO APERTURA CUENTA DE AHORROS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (29, '3', 'COMISION REIMPRESION DE NOTAS', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '310', 'COM TRNA RETIRO CHQ GERENCIA', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '311', 'COM TRNA CONSULTA SALDO CAJA', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '312', 'COM TRNA DEPOSITO CTA AHORROS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '313', 'COM TRNA RETIRO CTA AHORROS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '314', 'COM TRNA CRE TRANSFERENCIA ENTRE CUENTAS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '315', 'COM TRNA TRANSFERENCIA ENTRE CUENTAS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '316', 'COM TRNA NOTA CR AHORROS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (31, '317', 'COM TRNA NOTA DB AHORROS', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (50, 'SMA', 'SERVICIO SALDO MAXIMO DE LA CUENTA', 'V', '', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (50, 'SMI', 'SERVICIO SALDO MINIMO DE LA CUENTA', 'V', '', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (52, '3', 'COMISION  CENTRO  DE EFECTIVO', 'V', '', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (54, '3', 'COMISION POR SALDO MINIMO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (55, '3', 'COMISION POR INACTIVIDAD DE CUENTA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (56, '46', 'COMISION POR LIBERACION DE CANJE', 'V', '', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, '3', 'COBRO DE COMISION TRANSACCIONES EN OFICINA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C230', 'COMIS. TIPO C CONSULTA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C237', 'COMIS. TIPO D TRANSFERENCIA AA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C239', 'COMIS. TIPO D TRANSFERENCIA AC', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C2519', 'COMIS. TIPO D TRANSFERENCIA CC', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C252', 'COMIS. TIPO C DEPOSITO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C2520', 'COMIS. TIPO D TRANSFERENCIA CA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C253', 'COMIS. TIPO C N. CREDITO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C2626', 'COMIS. TIPO C TRANSFERENCIA CC', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C2627', 'COMIS. TIPO C TRANSFERENCIA AC', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C263', 'COMIS. TIPO C RETIRO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C264', 'COMIS. TIPO C N. DEBITO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C294', 'COMIS. TIPO C TRANSFERENCIA CA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C300', 'COMIS. TIPO C TRANSFERENCIA AA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'C380', 'COMIS. TIPO C RET. CHQ. GERENCIA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'M', 'COMISION TIPO COBRO MENSUAL', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'T', 'COMISION TIPO COBRO CONTADOR GENERAL', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W230', 'COMIS. TIPO W CONSULTA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W237', 'COMIS. TIPO W TRANSFERENCIA DEB AA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W239', 'COMIS. TIPO W TRANSFERENCIA AC', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W2519', 'COMIS. TIPO W TRANSFERENCIA CC', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W252', 'COMIS. TIPO W DEPOSITO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W2520', 'COMIS. TIPO W TRANSFERENCIA CA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W253', 'COMIS. TIPO W N. CREDITO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W2626', 'COMIS. TIPO W TRANSFERENCIA CC', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W2627', 'COMIS. TIPO W TRANSFERENCIA AC', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W263', 'COMIS. TIPO W RETIRO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W264', 'COMIS. TIPO W N. DEBITO', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W294', 'COMIS. TIPO W TRANSFERENCIA CA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W300', 'COMIS. TIPO W TRANSFERENCIA CRE AA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (57, 'W380', 'COMIS. TIPO W RET. CHQ. GERENCIA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (58, '3', 'RETIRO POR VENTANILLA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (59, '3', 'COMISION POR CERTIFICACIONES Y REFERENCIAS', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (60, '3', 'RETIRO CHEQUE GERENCIA', 'V', '+', 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (61, 'CMTR', 'MONTO COMISION POR TRANSFERENCIA ALIANZA', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (62, '3', 'COMISION RETIRO CORRESPONSAL BANCARIO', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (63, '3', 'COMISION CONSULTA CORRESPONSAL BANCARIO', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (64, '3', 'COMISION DEPOSITO CORRESPONSAL BANCARIO', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (65, '3', 'COMISION TRANSACCION ATM NACIONAL', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (66, '3', 'COMISION TRANSACCION ATM  INTERNACIONAL', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (67, '3', 'COMISION CONSULTA ATM NACIONAL', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (68, '3', 'COMISION CONSULTA ATM INTERNACIONAL', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (69, '3', 'COMISION CUOTA DE MANEJO', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (70, '3', 'COMISION POR PIN INVALIDO', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (71, '3', 'COMISION PERDIDA DETERIORO TARJE DEBITO', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (72, '3', 'COMISION FONDOS INSUFICIENTES', 'V', NULL, 'P')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (73, '3', 'COMISION RETIRO OF TARJETA DEBITO', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (74, '3', 'Consulta de Saldo CB Posicionado', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (75, '3', 'Consulta Costo CB Posicionado', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (77, '3', 'Retiro CB Posicionado', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (78, '3', 'Deposito CB Posicionado', 'V', NULL, 'M')
GO

INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (79, '3', 'COMISION CONSULTA SALDO OFICINA CTA AH T', 'V', NULL, 'M')
GO


--data inicial rango edades
IF exists (SELECT 1 FROM sysobjects WHERE name = 'pe_pro_rango_edad' )
begin
    DELETE FROM cob_remesas..pe_pro_rango_edad

    INSERT INTO cob_remesas..pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
    VALUES (1, 'MENOR DE EDAD', 0, 17, 'V')

    INSERT INTO cob_remesas..pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
    VALUES (2, 'MAYOR DE EDAD', 18, 100, 'V')

    INSERT INTO cob_remesas..pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
    VALUES (3, 'TODOS', 0, 100, 'V')
end
go


-- pe_tipo_rango
print 'insercion pe_tipo_rango'
if exists (select 1 from sysobjects where name = 'pe_tipo_rango' )
  delete pe_tipo_rango 
go

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (1, 'RUBRO SOBRE SALDO DISPONIBLE', 'A', 0, 'V')

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (2, 'SOBRE PROMEDIO DISPONIBLE', 'E', 0, 'V')

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (3, 'SALDO PROMEDIO', 'B', 0, 'V')

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (4, 'SALDO CONTABLE', 'C', 0, 'V')

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (5, 'SALDO MINIMO MENSUAL', 'D', 0, 'V')
GO


UPDATE cobis..cl_seqnos 
SET siguiente = 5
WHERE tabla = 'pe_tipo_rango'
GO 		