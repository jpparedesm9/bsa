USE cob_remesas
go

/**************  trn 252  *****************************/

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (103, 4, 252, NULL, NULL, 'C', 'EFECTIVO', NULL, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (104, 4, 252, NULL, NULL, 'C', 'CH_PRO', NULL, 'tm_chq_propios', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (105, 4, 252, NULL, NULL, 'C', 'CH_LOC', NULL, 'tm_chq_locales', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (106, 4, 252, NULL, NULL, 'C', 'CH_OTR', NULL, 'tm_chq_ot_plazas', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO



INSERT INTO dbo.re_concepto_contable (tp_secuencial)
VALUES (11)
GO




INSERT INTO dbo.re_concepto_contable (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NCR_AHO', 1, 'CON_CR_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.re_concepto_contable (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NCR_AHO', 2, '2120_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
GO




INSERT INTO dbo.re_concepto_contable (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'CON_CR_AHO', 'NOTAS CREDITOS AHORROS', 'sp_ah02_pf', 4)
GO




INSERT INTO dbo.re_concepto_contable (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, '2120_AHO', 'DEPOSITOS AHORROS', 'sp_ah01_pf', 4)
GO




INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CCCUPOCB', '19049500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CH_LOC', '11051000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CH_PRO', '11051000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CONCHREM', '51152000901', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVCOMREM', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVGMF', '25309500500', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVRTEFTE', '25550500016', 4, 'CTB_IMP', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.EFECTIVO', '11050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INTA', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INTI', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABNOEM', '27049500915', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABONOPAG', '25959500800', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABPAVI', '27049500910', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJ50RBM', '16879500161', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJ56RBM', '16879500161', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJTRNATM', '25959500095', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJTRNPOS', '25959500105', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCDEVCMTD', '41159500075', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCDTN', '25959500085', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCPAGOINCE', '25959500080', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRACMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCCCBP', '11150500050', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCCMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCOMCB', '27049500810', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCORDEP', '27049500908', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCTAEMP', '27049500909', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDEPCB', '19049500800', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDESPRE', '19049500934', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCREINPAGC', '19049500932', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRENTMMI', '27049500904', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRGMFCBCO', '51403500050', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRINTREC', '51020200005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRMANOPE', '27049500908', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRPAGMOV', '25959500130', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRPAGPROV', '27049500998', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRCMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRREACTA', '19909500992', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRECMOV', '25959500130', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRREFERI', '25959500130', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRETPOS', '25959500105', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRETPOSI', '25959500110', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRVAPDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRTRANS', '27049500912', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRTRSMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRWU', '16879500200', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCTRDCTOB', '27049500912', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NDAJ57RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.REVCOMCHG', '41159500064', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '1.EFECTIVO', '11050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '1.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', 'NCAJ50RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', 'NCAJ56RBM', '25959500100', 4, 'CTB_OF', 'D')
GO



INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.5.A', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.5.C', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.G', '21200500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.5.A', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.5.C', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.T', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.C', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.T', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.C', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.T', '21200801015', 4, 'CTB_OF', 'D')
GO




/********** trn 264 *****************/

-- 1

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (13, 4, 264, '1', NULL, 'D', 'NDEESTCTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (14, 4, 264, '4', NULL, 'D', 'NDECOMCHD', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (15, 4, 264, '7', NULL, 'D', 'NDECHQREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (16, 4, 264, '8', NULL, 'D', 'NDEDIFDEP', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (17, 4, 264, '8', NULL, 'D', 'NDEAJUCHP', 2, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (18, 4, 264, '8', NULL, 'D', 'NDEAJUCHL', 3, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (19, 4, 264, '8', NULL, 'D', 'NDEAJUCHR', 4, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (20, 4, 264, '9', NULL, 'D', 'NDEEMBARG', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (21, 4, 264, '10', NULL, 'D', 'NDECOMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (22, 4, 264, '11', NULL, 'D', 'NDEREFBAN', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (23, 4, 264, '12', NULL, 'D', 'NDECOMCIE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (24, 4, 264, '13', NULL, 'D', 'NDECOMECT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (25, 4, 264, '14', NULL, 'D', 'NDETRASLD', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (26, 4, 264, '16', NULL, 'D', 'NDECHQGER', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (27, 4, 264, '17', NULL, 'D', 'NDETRAEXT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (28, 4, 264, '20', NULL, 'D', 'NDETRANS', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (29, 4, 264, '23', NULL, 'D', 'NDESUSDOC', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (30, 4, 264, '24', NULL, 'D', 'NDECONDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (31, 4, 264, '25', NULL, 'D', 'NDECIECTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (32, 4, 264, '26', NULL, 'D', 'NDEPAGCAR', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (33, 4, 264, '27', NULL, 'D', 'NDEPORREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (34, 4, 264, '28', NULL, 'D', 'NDECOMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (35, 4, 264, '30', NULL, 'D', 'NDETRNNAL', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (36, 4, 264, '31', NULL, 'D', 'NDECOMRETV', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (37, 4, 264, '32', 'R', 'D', 'NDEGMF', 1, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (38, 4, 264, '33', NULL, 'D', 'NDEIVA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (39, 4, 264, '34', NULL, 'D', 'NDRVCANDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (40, 4, 264, '84', NULL, 'D', 'NDECOMCHGE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (41, 4, 264, '90', NULL, 'D', 'NDECOMOFI', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (42, 4, 264, '91', NULL, 'D', 'NDERECINT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (43, 4, 264, '92', NULL, 'D', 'NDECOMECT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (44, 4, 264, '93', NULL, 'D', 'NDEREIDESC', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (45, 4, 264, '182', 'R', 'D', 'NDERTEFTE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (46, 4, 264, '183', NULL, 'D', 'NDEPORTDEV', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (47, 4, 264, '184', NULL, 'D', 'NDERETCHGE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (48, 4, 264, '185', NULL, 'D', 'NDECOMTRF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (49, 4, 264, '205', NULL, 'D', 'NDECORDEP', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (50, 4, 264, '213', NULL, 'D', 'NDEAUMDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (51, 4, 264, '236', NULL, 'D', 'NDEMANOPE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (52, 4, 264, '237', NULL, 'D', 'NDEPROVEED', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (54, 4, 264, '244', NULL, 'D', 'NDEREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (55, 4, 264, '246', NULL, 'D', 'NDEDEVCHEX', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (167, 4, 264, NULL, 'V', 'D', 'NDEIVA', 1, 'tm_valor_comision', 'tm_valor', NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (170, 4, 264, NULL, 'R', 'D', 'NDEGMF', 1, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (194, 4, 264, '35', NULL, 'D', 'NDECOMCHGE', 1, 'tm_valor', NULL, NULL, 'N', '2012-02-09', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (196, 4, 264, '248', NULL, 'D', 'NDTRACTOB', 1, 'tm_valor', NULL, NULL, 'N', '2012-03-22', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (207, 4, 264, '36', NULL, 'D', 'NDCOMDISP', 1, 'tm_valor', NULL, NULL, 'N', '2014-01-19 08:40:20', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (210, 4, 264, '37', NULL, 'D', 'NDECOMCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-04-05 14:54:15', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (211, 4, 264, '38', NULL, 'D', 'NDERETCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-04-05 14:54:15', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (224, 4, 264, '161', NULL, 'D', 'NDEFINSU', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (225, 4, 264, '141', NULL, 'D', 'NDECOMATMN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (226, 4, 264, '142', NULL, 'D', 'NDECOMATMI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (227, 4, 264, '40', NULL, 'D', 'NDECOMPOSN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (228, 4, 264, '41', NULL, 'D', 'NDECOMPOSI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (229, 4, 264, '233', NULL, 'D', 'NDECSAATMN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (230, 4, 264, '234', NULL, 'D', 'NDECSAATMI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (231, 4, 264, '139', NULL, 'D', 'NDERETATMN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (232, 4, 264, '140', NULL, 'D', 'NDERETATMI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (233, 4, 264, '143', NULL, 'D', 'NDERETPOS', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (234, 4, 264, '75', NULL, 'D', 'NDERETPOSI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (235, 4, 264, '238', NULL, 'D', 'NDECUOMAN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (236, 4, 264, '156', NULL, 'D', 'NDEPININV', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (237, 4, 264, '159', NULL, 'D', 'NDEPDTARJ', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (238, 4, 264, '160', NULL, 'D', 'NDEROTARJ', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (241, 4, 264, '170', NULL, 'D', 'NDAJ51RBM', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:12', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (242, 4, 264, '171', NULL, 'D', 'NDAJ57RBM', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:12', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (260, 4, 264, '260', NULL, 'D', 'CCCUPOCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:31', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (262, 4, 264, '261', NULL, 'D', 'NDECCCBP', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:31', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (266, 4, 264, '50', NULL, 'D', 'NDEDICCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:45', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (275, 4, 264, '85', NULL, 'D', 'NDETRSMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (276, 4, 264, '164', NULL, 'D', 'NDERECMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (277, 4, 264, '87', NULL, 'D', 'NDECCMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (278, 4, 264, '163', NULL, 'D', 'NDEPAGMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (279, 4, 264, '86', NULL, 'D', 'NDERCMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (280, 4, 264, '88', NULL, 'D', 'NDEACMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (281, 4, 264, '39', NULL, 'D', 'NDECMRMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (282, 4, 264, '46', NULL, 'D', 'NDECMUMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (283, 4, 264, '152', NULL, 'D', 'NDECCSMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (284, 4, 264, '162', NULL, 'D', 'NDECMOMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (296, 4, 264, '44', NULL, 'D', 'NDEPCARMAS', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-26', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (300, 4, 264, '165', NULL, 'D', 'NDAJTRNATM', 1, 'tm_valor', NULL, NULL, 'N', '2015-09-24', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (301, 4, 264, '166', NULL, 'D', 'NDAJTRNPOS', 1, 'tm_valor', NULL, NULL, 'N', '2015-09-24', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (302, 4, 264, '167', NULL, 'D', 'CXCEXCMONT', 1, 'tm_valor', NULL, NULL, 'N', '2015-10-02', 'M', 'V')
GO

INSERT INTO dbo.re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
VALUES (303, 4, 264, '168', NULL, 'D', 'CXCEXCNUMU', 1, 'tm_valor', NULL, NULL, 'N', '2015-10-02', 'M', 'V')
GO


---2


INSERT INTO dbo.re_concepto_contable (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (7, 4, 264, 'NDB_AHO', 'NDE')
GO


--3


INSERT INTO dbo.re_concepto_contable (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NDB_AHO', 1, 'CON_DB_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
GO

INSERT INTO dbo.re_concepto_contable (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 4, 'NDB_AHO', 3, '2120_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
GO

--4


INSERT INTO dbo.re_concepto_contable (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, '2120_AHO', 'DEPOSITOS AHORROS', 'sp_ah01_pf', 4)
GO


--5


INSERT INTO dbo.re_concepto_contable (pa_empresa)
VALUES (1)
GO


--6



INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.5.A', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.5.C', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.G', '21200500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.5.A', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.5.C', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.T', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.C', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.T', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.C', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.T', '21200801015', 4, 'CTB_OF', 'D')
GO

--7


INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.AUTRETINE', '27049500904', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CCCUPOCB', '19049500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CXCEXCMONT', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CXCEXCNUMU', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.EFECTIVO', '11050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDAJ51RBM', '25959500125', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDCOMDISP', '41159500055', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEACMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAJUCHL', '11051000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAUMDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAUTFLI', '27049500906', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECANCIN', '27702000010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCCBP', '11150500050', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCSMOV', '25959500130', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECHQGER', '27049500902', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECHQREM', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECHG', '21651500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECON', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECTA', '19909500992', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIEEFE', '27049500905', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMOMOV', '25959500130', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMRMOV', '25959500130', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMUMOV', '41159500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMATMI', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMATMN', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCB', '41159500061', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCHD', '42259500011', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCHGE', '41159500064', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMECT', '41159500060', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMOFI', '41152500011', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMREM', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMRETV', '41159500066', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMTRF', '41152500060', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECONCTA', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECONDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECORDEP', '27049500908', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECSAATMI', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECSAATMN', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECUOMAN', '41159500075', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEDEVEFE', '19049500931', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEDEVLOC', '19049500931', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEEMBARG', '27049500901', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEESTCTA', '41159500060', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEFINSU', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEGMF', '25301000005', 4, 'CTB_IMP', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEIVA', '25350000015', 4, 'CTB_IMP', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEMANOPE', '27049500908', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPAGCAR', '19049500932', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPAGMOV', '19049500932', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPCARMAS', '19049500932', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPDTARJ', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPININV', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPORREM', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPORTDEV', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPROVEED', '19909500991', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERCMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERECINT', '51020200005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERECMOV', '25959500130', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREFBAN', '41159500062', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREIDESC', '19049500934', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREM', '19909500996', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETATMI', '25959500100', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETATMN', '25959500095', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETCB', '19049500800', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETCHGE', '21651500010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETPOS', '25959500105', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETPOSI', '25959500110', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEROTARJ', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERTEFTE', '25550500016', 4, 'CTB_IMP', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERTEICA', '25550500420', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRANS', '27049500912', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRASLD', '27049500907', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRNNAL', '25959500125', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRSMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDRVCANDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDTRACTOB', '27049500912', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.RET', '11050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '1.EFECTIVO', '11050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', 'NDAJ51RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.re_concepto_contable (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', 'NDAJ57RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

