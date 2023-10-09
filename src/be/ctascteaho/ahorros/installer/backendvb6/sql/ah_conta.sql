/************************************************************************/
/*      Archivo:            ah_conta.sql                                */
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
/*      Este programa realiza la creacion de parametros contables        */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cob_conta
go

delete cb_producto
where pr_empresa = 1 
and   pr_producto = 4
go

print '=====> cb_producto'

/**** Producto Contable de Cuentas de Ahorros  ****/

insert into cb_producto values (1,4,'N','V','S',getdate())
go


print ''
print ''
print '=====> cb_perfil'

delete cob_conta..cb_perfil
where  pe_producto = 4

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'AUM_CUPO', 'CUPO CORRESPONSALES POSICIONADOS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'BOC_AHO', 'BOC DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'CAU_AHO', 'CAUSACION DEPOSITOS AHORROS(AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'COB_SUS', 'COBRO CARGOS EN SUSPENSO (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'COMCRBMAHO', 'COMPENSACION CREDITO RBM')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'COMPRBMAHO', 'COMPENSACION RBM')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'COND_AHO', 'CONDONACIONA VALORES EN SUSPENSO CTAS AHORROS')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'DIS_CUPO', 'CUPO CORRESPONSALES POSICIONADOS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'EST_AHO', 'CAMBIOS DE ESTADO DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'GMFBCOCAU', 'GMF A CARGO DEL BANCO CAUSAL (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'GMFCARBCO', 'GMF A CARGO DEL BANCO (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'ING_REM', 'REMESAS DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'NCR_AHO', 'NOTAS CREDITO DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'NDB_AHO', 'NOTAS DEBITO DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'REM_AHO', 'REMESAS DEPOSITOS AHORROS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'TRAS_AHO', 'TRASLADO ENTRE OFICINAS AHORROS (AHORROS)')
GO

INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 4, 'VAL_SUS', 'CARGOS EN SUSPENSO (AHORROS)')
GO


print ''
print ''
print '=====> cb_det_perfil'


delete cob_conta..cb_det_perfil
where  dp_producto = 4
GO

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'AUM_CUPO', 1, 'CON_DB_CUP', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'AUM_CUPO', 2, 'CON_CR_CUP', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'BOC_AHO', 1, '2120_AHO', 'CTB_OF', '2', 10, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'BOC_AHO', 2, 'INTXP_AHO', 'CTB_OF', '2', 20, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'CAU_AHO', 1, 'INTXP_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'CAU_AHO', 3, 'GASTO_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COB_SUS', 1, 'CON_CR_SUS', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COB_SUS', 2, 'CON_DB_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COMCRBMAHO', 1, '25959500115', 'CTB_OF', '1', 1, 'N', 'C', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COMCRBMAHO', 2, 'AH_RBM_TRN', 'CTB_OF', '2', 1, 'N', 'O', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COMPRBMAHO', 1, '25959500115', 'CTB_OF', '2', 1, 'N', 'C', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COMPRBMAHO', 2, 'AH_RBM_TRN', 'CTB_OF', '1', 1, 'N', 'O', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COND_AHO', 1, 'COND_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COND_AHO', 2, 'COND_CXC', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'DIS_CUPO', 1, 'CON_DB_CUP', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'DIS_CUPO', 2, 'CON_CR_CUP', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'EST_AHO', 1, 'AHO_EST', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'GMFBCOCAU', 1, 'GASTO_GMF', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'GMFBCOCAU', 2, 'CON_GMFAHO', 'CTB_IMP', '2', 1, 'N', 'C', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'GMFCARBCO', 1, '51403500020', 'CTB_OF', '1', 1, 'N', 'O', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'GMFCARBCO', 2, '25301500005', 'CTB_OF', '2', 1, 'N', 'C', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'ING_REM', 3, 'CAJA_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'ING_REM', 4, 'REM_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NCR_AHO', 1, 'CON_CR_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NCR_AHO', 2, '2120_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NDB_AHO', 1, 'CON_DB_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NDB_AHO', 3, '2120_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'REM_AHO', 1, 'CAJA_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'TRAS_AHO', 1, 'AH_TRASDES', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'TRAS_AHO', 2, 'AH_TRASOR', 'CTB_OF', '1', 1, 'N', 'O', '', 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'VAL_SUS', 1, 'CON_CR_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'VAL_SUS', 2, 'CON_DB_SUS', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')
GO


print ''
print ''
print '=====> cb_relparam'

delete cob_conta..cb_relparam
where  re_producto = 4



INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.A', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.C', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.I', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.T', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.A', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.C', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.I', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.T', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.A', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.C', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.I', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.T', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.5.A', '25959500811', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.5.C', '25959500811', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.A', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.C', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.G', '21200500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.I', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.T', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.A', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.C', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.I', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.T', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.A', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.C', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.I', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.T', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.5.A', '25959500811', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.5.C', '25959500811', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.A', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.C', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.I', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.T', '21200501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.A', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.C', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.I', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.T', '21200501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.A', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.C', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.I', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.T', '21200501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.A', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.C', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.I', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.T', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.A', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.C', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.I', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.T', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.A', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.C', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.I', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.T', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.A.CAP', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.I.CAP', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.T.CAP', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.A.CAP', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.I.CAP', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.T.CAP', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.A.CAP', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.I.CAP', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.T.CAP', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.A.CAP', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.I.CAP', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.T.CAP', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.A.CAP', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.I.CAP', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.T.CAP', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.A.CAP', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.I.CAP', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.T.CAP', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.A.CAP', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.I.CAP', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.T.CAP', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.A.CAP', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.I.CAP', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.T.CAP', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.A.CAP', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.C.CAP', '27702001005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.I.CAP', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.T.CAP', '21200801020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.A.CAP', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.C.CAP', '27702001005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.I.CAP', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.T.CAP', '21200801020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.A.CAP', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.C.CAP', '27702001005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.I.CAP', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.T.CAP', '21200801020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.A.CAP', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.C.CAP', '27702001005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.I.CAP', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.T.CAP', '21200801020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.A.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.C.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.I.CAP', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.T.CAP', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.A.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.C.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.I.CAP', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.T.CAP', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.A.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.C.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.I.CAP', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.T.CAP', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.A.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.C.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.I.CAP', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.T.CAP', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPANUPOSI', '25959500110', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPANUPOSN', '25959500105', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPRETATMI', '25959500100', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPRETATMN', '25959500095', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPRETPOSI', '25959500110', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPRETPOSN', '25959500105', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', 'CMPRETATMI', '25959500100', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', 'CMPRETATMN', '25959500095', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', 'CMPRETPOSI', '25959500110', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', 'CMPRETPOSN', '25959500105', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.A.CAP', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.I.CAP', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.T.CAP', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.A.CAP', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.I.CAP', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.T.CAP', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.A.CAP', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.I.CAP', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.T.CAP', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.A.CAP', '21200500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.I.CAP', '21200800010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.T.CAP', '21200800020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.A.CAP', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.I.CAP', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.T.CAP', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.A.CAP', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.I.CAP', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.T.CAP', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.A.CAP', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.I.CAP', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.T.CAP', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.A.CAP', '21200500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.A.INT', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.C.CAP', '27702000005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.I.CAP', '21200800005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.I.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.T.CAP', '21200800015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.T.INT', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.A.CAP', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.C.CAP', '27702001005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.I.CAP', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.T.CAP', '21200801020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.A.CAP', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.C.CAP', '27702001005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.I.CAP', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.T.CAP', '21200801020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.A.CAP', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.C.CAP', '27702001005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.I.CAP', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.T.CAP', '21200801020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.A.CAP', '21200501010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.C.CAP', '27702001005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.I.CAP', '21200801010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.T.CAP', '21200801020', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.A.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.C.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.I.CAP', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.T.CAP', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.A.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.C.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.I.CAP', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.T.CAP', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.A.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.C.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.I.CAP', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.T.CAP', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.A.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.A.INT', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.C.CAP', '21200501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.I.CAP', '21200801005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.I.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.T.CAP', '21200801015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.T.INT', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.A.CAP', '21200500010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.A.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.C.CAP', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.I.CAP', '21200800010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.I.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.T.CAP', '21200800020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.T.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.A.CAP', '21200500010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.A.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.C.CAP', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.I.CAP', '21200800010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.I.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.T.CAP', '21200800020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.T.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.A.CAP', '21200500010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.A.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.C.CAP', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.I.CAP', '21200800010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.I.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.T.CAP', '21200800020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.T.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.A.CAP', '21200500010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.A.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.C.CAP', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.I.CAP', '21200800010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.I.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.T.CAP', '21200800020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.T.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.A.CAP', '21200500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.A.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.C.CAP', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.I.CAP', '21200800005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.I.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.T.CAP', '21200800015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.T.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.A.CAP', '21200500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.A.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.C.CAP', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.I.CAP', '21200800005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.I.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.T.CAP', '21200800015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.T.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.A.CAP', '21200500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.A.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.C.CAP', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.I.CAP', '21200800005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.I.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.T.CAP', '21200800015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.T.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.A.CAP', '21200500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.A.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.C.CAP', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.I.CAP', '21200800005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.I.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.T.CAP', '21200800015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.T.INT', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.A.CAP', '21200501010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.A.INT', '28050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.C.CAP', '27702001005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.I.CAP', '21200801010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.I.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.T.CAP', '21200801020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.T.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.A.CAP', '21200501010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.C.CAP', '27702001005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.I.CAP', '21200801010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.I.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.T.CAP', '21200801020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.T.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.A.CAP', '21200501010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.A.INT', '28050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.C.CAP', '27702001005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.I.CAP', '21200801010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.I.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.T.CAP', '21200801020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.T.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.A.CAP', '21200501010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.A.INT', '28050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.C.CAP', '27702001005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.I.CAP', '21200801010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.I.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.T.CAP', '21200801020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.T.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.A.CAP', '21200501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.A.INT', '28050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.C.CAP', '21200501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.I.CAP', '21200801005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.I.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.T.CAP', '21200801015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.T.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.A.CAP', '21200501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.A.INT', '28050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.C.CAP', '21200501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.I.CAP', '21200801005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.I.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.T.CAP', '21200801015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.T.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.A.CAP', '21200501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.A.INT', '28050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.C.CAP', '21200501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.I.CAP', '21200801005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.I.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.T.CAP', '21200801015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.T.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.A.CAP', '21200501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.A.INT', '28050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.C.CAP', '21200501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.I.CAP', '21200801005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.T.CAP', '21200801015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.T.INT', '28050501015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAJA_AHO', '0.CH_OTR', '11051000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAJA_AHO', '1.CH_OTR', '11051000110', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCOMATMI', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCOMATMN', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCSAATMI', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCSAATMN', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCUOMAN', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDFINSU', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDPDTARJ', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDPININV', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDROTARJ', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCOMATMI', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCOMATMN', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCSAATMI', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCSAATMN', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCUOMAN', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDFINSU', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDPDTARJ', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDPININV', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDROTARJ', '52959500045', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CCCUPOCB', '19049500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CH_LOC', '11051000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CH_PRO', '11051000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CONCHREM', '51152000901', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVCOMREM', '41152500041', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVGMF', '25309500500', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVRTEFTE', '25550500016', 4, 'CTB_IMP', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.EFECTIVO', '11050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INT', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INTA', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INTI', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABNOEM', '27049500915', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABONOPAG', '25959500800', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABPAVI', '27049500910', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJ50RBM', '16879500161', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJ56RBM', '16879500161', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJTRNATM', '25959500095', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJTRNPOS', '25959500105', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCDEVCMTD', '41159500075', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCDTN', '25959500085', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCPAINCE', '25959500080', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRACMMOV', '27049500920', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCCCBP', '11150500050', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCCMMOV', '27049500920', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCOMCB', '27049500810', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCORDEP', '27049500908', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCTAEMP', '27049500909', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDEPCB', '19049500800', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDESPRE', '19049500934', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDPF', '27049500903', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCREINPAGC', '19049500932', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRENTMMI', '27049500904', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRGMFCBCO', '51403500050', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRINTREC', '51020200005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRMANOPE', '27049500908', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRPAGMOV', '25959500130', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRPAGPROV', '27049500998', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRCMMOV', '27049500920', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRREACTA', '19909500992', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRECMOV', '25959500130', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRREFERI', '25959500130', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRETPOS', '25959500105', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRETPOSI', '25959500110', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRVAPDPF', '27049500903', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRTRANS', '27049500912', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRTRSMOV', '27049500920', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRWU', '16879500200', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCTRDCTOB', '27049500912', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NDAJ57RBM', '25959500100', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.REVCOMCHG', '41159500064', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '1.EFECTIVO', '11050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '1.INT', '28050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', 'NCAJ50RBM', '25959500100', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', 'NCAJ56RBM', '25959500100', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_CUP', '0.CORAUCCB', '62250500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_CUP', '0.CORDICCB', '62250500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_CUP', '0.CORRGCCB', '62250500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCAUMCB', '19049500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCMRMOV', '25959500130', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCMUMOV', '41159500100', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCOMATMI', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCOMATMN', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCSAATMI', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCSAATMN', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCUOMAN', '41159500075', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCDICCB', '19049500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCFINSU', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCPDTARJ', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCPININV', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCROTARJ', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.AUTRETINE', '27049500904', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CCCUPOCB', '19049500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CXCEXCMONT', '41159500085', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CXCEXCNUMU', '41159500085', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.EFECTIVO', '11050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDAJ51RBM', '25959500125', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDCOMDISP', '41159500055', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEACMMOV', '27049500920', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAJUCHL', '11051000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAUMDPF', '27049500903', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAUTFLI', '27049500906', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECANCIN', '27702000010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCCBP', '11150500050', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCMMOV', '27049500920', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCSMOV', '25959500130', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECHQGER', '27049500902', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECHQREM', '41152500041', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECHG', '21651500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECON', '27702000005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECTA', '19909500992', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIEEFE', '27049500905', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMOMOV', '25959500130', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMRMOV', '25959500130', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMUMOV', '41159500100', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMATMI', '41159500085', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMATMN', '41159500085', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCB', '41159500061', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCHD', '42259500011', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCHGE', '41159500064', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMECT', '41159500060', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMOFI', '41152500011', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMREM', '41152500041', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMRETV', '41159500066', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMTRF', '41152500060', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECONCTA', '41152500041', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECONDPF', '27049500903', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECORDEP', '27049500908', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECSAATMI', '41159500085', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECSAATMN', '41159500085', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECUOMAN', '41159500075', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEDEVEFE', '19049500931', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEDEVLOC', '19049500931', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEEMBARG', '27049500901', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEESTCTA', '41159500060', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEFINSU', '41159500085', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEGMF', '25301000005', 4, 'CTB_IMP', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEIVA', '25350000015', 4, 'CTB_IMP', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEMANOPE', '27049500908', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPAGCAR', '19049500932', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPAGMOV', '19049500932', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPCARMAS', '19049500932', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPDTARJ', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPININV', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPORREM', '41152500041', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPORTDEV', '41152500041', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPROVEED', '19909500991', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERCMMOV', '27049500920', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERECINT', '51020200005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERECMOV', '25959500130', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREFBAN', '41159500062', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREIDESC', '19049500934', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREM', '19909500996', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETATMI', '25959500100', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETATMN', '25959500095', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETCB', '19049500800', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETCHGE', '21651500010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETPOS', '25959500105', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETPOSI', '25959500110', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEROTARJ', '41159500085', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERTEFTE', '25550500016', 4, 'CTB_IMP', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERTEICA', '25550500420', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRANS', '27049500912', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRASLD', '27049500907', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRNNAL', '25959500125', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRSMOV', '27049500920', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDRVCANDPF', '27049500903', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDTRACTOB', '27049500912', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.RET', '11050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '1.EFECTIVO', '11050501005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', 'NDAJ51RBM', '25959500100', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', 'NDAJ57RBM', '25959500100', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_CUP', '0.CORAUCCB', '61250500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_CUP', '0.CORDICCB', '61250500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_CUP', '0.CORRGCCB', '61250500805', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCAUMCB', '16879500810', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCMRMOV', '16879500165', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCMUMOV', '16879500165', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCOMATMI', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCOMATMN', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCSAATMI', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCSAATMN', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCUOMAN', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCDICCB', '16879500810', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCFINSU', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCPDTARJ', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCPININV', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCROTARJ', '16879500012', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCABNOEM', '25309500030', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCABONOPAG', '25301500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCABPAVI', '25309500035', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCDTN', '25309500050', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCPAINCE', '25309500045', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCRPAGPROV', '25309500040', 4, 'CTB_OF', 'C')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.O.A', '51020200010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.O.C', '51020200010', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.O.I', '51020200020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.O.T', '51020200020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.P.A', '51020200005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.P.C', '51020200005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.P.I', '51020200015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.P.T', '51020200015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCABNOEM', '51403500010', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCABONOPAG', '51403500020', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCABPAVI', '51403500035', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCDTN', '16879500130', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCPAINCE', '51403500045', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCRPAGPROV', '51403500040', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '0.A', '28050500005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '0.C', '28050500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '0.I', '28050500015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '0.T', '28050500015', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '1.A', '28050501005', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '1.I', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '1.T', '28050501015', 4, 'CTB_OF', 'D')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REM_AHO', '0.CH_OTR', '11300500005', 4, 'CTB_OF', 'O')


INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REM_AHO', '1.CH_OTR', '11301001005', 4, 'CTB_OF', 'O')
GO


print '=====>cb_parametro'

delete cb_parametro
where  pa_transaccion = 4
go

INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, '2120_AHO', 'DEPOSITOS AHORROS', 'sp_ah01_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'AHO_EST', 'CAMBIO DE ESTADO-CAPITAL E INTERESES', 'sp_ah04_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'AH_RBM_TRN', 'COMPENSACION RBM', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'AH_TRASDES', 'TRASLADO ENTRE OFICINAS-CAPITAL E INTERESES DESTINO', 'sp_ah04_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'AH_TRASOR', 'TRASLADO ENTRE OFICINAS-CAPITAL E INTERESES ORIGEN', 'sp_ah04_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CAJA_AHO', 'DEPOSITOS EN CHEQUES OTRAS PLAZAS AHORROS RECIBIDOS POR CAJA', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'COND_CXC', 'CXC CONDONACION VALORES EN SUSPENSO CTAS DE AHORROS', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'COND_SUS', 'CONDONACION VALORES EN SUSPENSO CTAS DE AHORROS', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_CR_AHO', 'NOTAS CREDITOS AHORROS', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_CR_CUP', 'MOVIMIENTO CUPO CORRESPONSAL CREDITO', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_CR_SUS', 'CONTRA SUSPENSO AHORROS', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_DB_AHO', 'NOTAS DEBITOS AHORROS', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_DB_CUP', 'MOVIMIENTO CUPO CORRESPONSAL DEBITO', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_DB_SUS', 'CARS EN SUSPENSO AHORROS', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_GMFAHO', 'GMF A CAR DEL BANCO EN NCR', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'GASTO_AHO', 'GASTOS DEPOSITOS AHORROS', 'sp_ah05_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'GASTO_GMF', 'GASTO GMF A CAR DEL BANCO EN NCR', 'sp_ah02_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'INTXP_AHO', 'PROVISION INTERESES DEPOSITOS AHORROS', 'sp_ah03_pf', 4)


INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'REM_AHO', 'DEPOSITOS EN CHEQUES OTRAS PLAZAS AHORROS RECIBIDOS POR CAJA', 'sp_ah02_pf', 4)
GO



print ''
print ''
print '=====> cb_tipo_area'
go


delete cb_tipo_area
where  ta_producto = 4


INSERT INTO cob_conta..cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 4, 'CTB_IMP', 'S', 30, 'IMPUESTOS AHORROS', 4069)


INSERT INTO cob_conta..cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 4, 'CTB_OF', 'S', 31, 'AREA DE CONTABILIZACION DE AHORROS', 4069)
GO
