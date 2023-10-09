use cob_remesas
go

set nocount on
go

truncate table re_banco
go

INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (0, 'BANCO REPUBLICA', 'V', 1, '8600052167', NULL)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (1, 'BOGOTA', 'V', 1, '8001423837', 805350)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (2, 'POPULAR', 'V', 1, '8600077389', 236533)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (6, 'BANCO CORPBANCA', 'V', 1, '8909039370', 618094)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (7, 'BANCOLOMBIA S A', 'V', 1, '8909039388', 236540)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (8, 'SCOTIABANK COLOMBIA S A', 'V', 1, '8600517052', 237675)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (9, 'CITIBANK COLOMBIA', 'V', 1, '8600511354', 1229747)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (10, 'BANCO GNB COLOMBIA S A', 'V', 1, '8600509309', 1756770)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (12, 'GNB SUDAMERIS S A', 'V', 1, '8600507501', 236534)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (13, 'BBVA COLOMBIA', 'V', 1, '8600030201', 236531)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (14, 'HELM BANK S A', 'V', 1, '8600076603', 237729)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (19, 'COLPATRIA', 'V', 1, '8600345941', 236535)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (23, 'OCCIDENTE', 'V', 1, '8903002794', 236541)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (32, 'CAJA SOCIAL BCSC S A', 'V', 1, '8600073354', 236536)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (40, 'AGRARIO DE COLOMBIA S A', 'V', 1, '8000378008', 237742)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (51, 'DAVIVIENDA S A', 'V', 1, '8600343137', 358272)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (52, 'AV VILLAS', 'V', 1, '8600358275', NULL)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (53, 'BANCO WWB S A', 'V', 1, '9003782122', 1072831)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (58, 'PROCREDIT', 'V', 1, '9002009609', 898234)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (59, 'BANCAMIA', 'V', 1, '9002150711', 345785)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (60, 'INVERSORA PICHINCHA', 'V', 1, '8902007567', NULL)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (61, 'BANCOOMEVA', 'V', 1, '9001721483', NULL)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (62, 'BANCO FALABELLA S A', 'V', 1, '9000174478', 636597)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (63, 'BANCO FINANDINA S A', 'V', 1, '8600518946', 1267836)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (64, 'MULTIBANK SA', 'V', 1, '8600244141', NULL)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (65, 'BANCO SANTANDER DE NEGOCIOS COLOMBIA SA', 'V', 1, '9006281103', NULL)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (66, 'BANCO COOPERATIVO COOPCENTRAL', 'V', 1, '8902030889', 1724982)
INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
VALUES (67, 'BANCOMPARTIR S A', 'V', 1, '8600259715', 237746)
go

--------------------------------------------------------------------------------------------
truncate table re_concepto_imp
go

INSERT INTO re_concepto_imp (ci_tran, ci_causal, ci_impuesto, ci_concepto, ci_producto, ci_base1, ci_base2, ci_contabiliza, ci_fecha)
VALUES (308, '0', 'R', '0210', 4, 'tm_interes', NULL, 'tm_valor', '10/17/2010')
go

INSERT INTO re_concepto_imp (ci_tran, ci_causal, ci_impuesto, ci_concepto, ci_producto, ci_base1, ci_base2, ci_contabiliza, ci_fecha)
VALUES (334, '0', 'C', '210', 4, 'tm_interes', NULL, 'tmvalor', getdate())
go