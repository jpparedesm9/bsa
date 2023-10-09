/***********************************************************************************************************/
---No historia  			: 77227
---Título del Bug			: Sarta inicio de dia
---Fecha					: 30/Jul/2016 
--Descripción del Problema	: Parametrización de perfil contable
--Descripción de la Solución: se ingresa registros tomados del ambiente de referencia
--Autor						: Tania Baidal
/***********************************************************************************************************/

--Remesas/BackEnd/sql/re_datosini.sql

use cob_remesas
go

delete from re_trn_perfil
where tp_producto = 4


INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (38, 4, 213, 'NDB_AHO', 'CIE')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (2, 4, 224, 'NDB_AHO', 'NDE')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (3, 4, 237, 'NDB_AHO', 'TRS')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (4, 4, 391, 'NDB_AHO', 'DEVREM')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (37, 4, 261, 'NDB_AHO', 'RET')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (6, 4, 263, 'NDB_AHO', 'RET')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (7, 4, 264, 'NDB_AHO', 'NDE')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (8, 4, 316, 'NDB_AHO', 'NDE')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (9, 4, 221, 'NCR_AHO', 'NCR')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (10, 4, 251, 'NCR_AHO', 'DEP')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (11, 4, 252, 'NCR_AHO', 'DEP')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (12, 4, 253, 'NCR_AHO', 'NCR')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (13, 4, 300, 'NCR_AHO', 'TRS')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (14, 4, 315, 'NCR_AHO', 'NCR')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (15, 4, 271, 'CAU_AHO', 'CAU')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (16, 4, 308, 'NDB_AHO', 'NDE')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (17, 4, 309, 'NDB_AHO', 'NDE')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (18, 4, 334, 'NDB_AHO', 'NDE')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (19, 4, 304, 'NCR_AHO', 'NCR')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (20, 4, 367, 'EST_AHO', 'CES')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (21, 4, 371, 'NDB_AHO', 'RET')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (22, 4, 375, 'EST_AHO', 'CES')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (23, 4, 376, 'EST_AHO', 'CES')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (24, 4, 377, 'EST_AHO', 'CES')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (25, 4, 378, 'EST_AHO', 'CES')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (26, 4, 203, 'EST_AHO', 'CES')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (27, 4, 240, 'NDB_AHO', 'DEVLOC')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (28, 4, 392, 'NDB_AHO', 'RET')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (29, 4, 379, 'GMFCARBCO', 'RET')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (26, 4, 380, 'NDB_AHO', 'RET')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (27, 4, 373, 'GMFBCOCAU', 'RET')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (30, 4, 374, 'TRAS_AHO', 'CES')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (31, 4, 258, 'VAL_SUS', 'CXC')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (32, 4, 303, 'COB_SUS', 'CXC')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (33, 4, 750, 'COMPRBMAHO', 'CXP')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (35, 4, 753, 'COMCRBMAHO', 'CXP')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (33, 4, 751, 'AUM_CUPO', 'COR')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (34, 4, 752, 'DIS_CUPO', 'COR')
GO

INSERT INTO re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
VALUES (36, 4, 754, 'COND_AHO', 'CXC')
GO


