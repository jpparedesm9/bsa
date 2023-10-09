use cob_conta
go
-----Creacion de empresa
delete from cb_empresa where em_empresa=1
GO
INSERT INTO dbo.cb_empresa (em_empresa, em_ruc, em_descripcion, em_replegal, em_contgen, em_moneda_base, em_abreviatura, em_direccion, em_matcontgen, em_revisor, em_matrevisor, em_emp_revisor, em_nit_emprev, em_mat_revisor)
VALUES (1, '9002150711', 'BANCO DE LAS MICROFINANZAS BANCAMIA S.A', 'MARGARITA HELENA CORREA HENAO', 'RAFAEL OROZCO', 0, 'BANCAMIA', 'CARRERA 9 Nro 66-25', '22016 -T', 'ANDREA CHAVARRO', '88877-T', 'DELLOITE & TOUCHE', '8600005813', '2340')
go

delete from cb_perfil where pe_producto=4
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

-----DETALLE


delete from cb_det_perfil where dp_producto=4
GO
INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'AUM_CUPO', 1, 'CON_DB_CUP', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'AUM_CUPO', 2, 'CON_CR_CUP', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'BOC_AHO', 1, '2120_AHO', 'CTB_OF', '2', 10, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'BOC_AHO', 2, 'INTXP_AHO', 'CTB_OF', '2', 20, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'CAU_AHO', 1, 'INTXP_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'CAU_AHO', 3, 'GASTO_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COB_SUS', 1, 'CON_CR_SUS', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COB_SUS', 2, 'CON_DB_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COMCRBMAHO', 1, '25959500115', 'CTB_OF', '1', 1, 'N', 'C', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COMCRBMAHO', 2, 'AH_RBM_TRN', 'CTB_OF', '2', 1, 'N', 'O', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COMPRBMAHO', 1, '25959500115', 'CTB_OF', '2', 1, 'N', 'C', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COMPRBMAHO', 2, 'AH_RBM_TRN', 'CTB_OF', '1', 1, 'N', 'O', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COND_AHO', 1, 'COND_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'COND_AHO', 2, 'COND_CXC', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'DIS_CUPO', 1, 'CON_DB_CUP', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'DIS_CUPO', 2, 'CON_CR_CUP', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'EST_AHO', 1, 'AHO_EST', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'GMFBCOCAU', 1, 'GASTO_GMF', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'GMFBCOCAU', 2, 'CON_GMFAHO', 'CTB_IMP', '2', 1, 'N', 'C', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'GMFCARBCO', 1, '51403500020', 'CTB_OF', '1', 1, 'N', 'O', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'GMFCARBCO', 2, '25301500005', 'CTB_OF', '2', 1, 'N', 'C', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'ING_REM', 3, 'CAJA_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'ING_REM', 4, 'REM_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NCR_AHO', 1, 'CON_CR_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NCR_AHO', 2, '2120_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NDB_AHO', 1, 'CON_DB_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NDB_AHO', 3, '2120_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'REM_AHO', 1, 'CAJA_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'TRAS_AHO', 1, 'AH_TRASDES', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'TRAS_AHO', 2, 'AH_TRASOR', 'CTB_OF', '1', 1, 'N', 'O', '', 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'VAL_SUS', 1, 'CON_CR_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')
GO

INSERT INTO dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'VAL_SUS', 2, 'CON_DB_SUS', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')
GO