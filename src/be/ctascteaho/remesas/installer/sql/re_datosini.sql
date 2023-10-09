use cob_remesas
go

print '===> re_ofi_banco'
go
delete re_ofi_banco
go

insert into re_ofi_banco
select 59, of_oficina, 0, of_nombre, getdate(), of_direccion, of_telefono, of_oficina, null
from   cobis..cl_oficina
where  of_subtipo = 'O'
go

print '===> re_trn_perfil'
go

delete from re_trn_perfil
where tp_producto = 4
go


insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (38, 4, 213, 'NDB_AHO', 'CIE')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (2, 4, 224, 'NDB_AHO', 'NDE')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (3, 4, 237, 'NDB_AHO', 'TRS')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (4, 4, 391, 'NDB_AHO', 'DEVREM')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (37, 4, 261, 'NDB_AHO', 'RET')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (6, 4, 263, 'NDB_AHO', 'RET')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (7, 4, 264, 'NDB_AHO', 'NDE')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (8, 4, 316, 'NDB_AHO', 'NDE')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (9, 4, 221, 'NCR_AHO', 'NCR')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (10, 4, 251, 'NCR_AHO', 'DEP')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (11, 4, 252, 'NCR_AHO', 'DEP')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (12, 4, 253, 'NCR_AHO', 'NCR')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (13, 4, 300, 'NCR_AHO', 'TRS')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (14, 4, 315, 'NCR_AHO', 'NCR')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (15, 4, 271, 'CAU_AHO', 'CAU')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (16, 4, 308, 'NDB_AHO', 'NDE')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (17, 4, 309, 'NDB_AHO', 'NDE')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (18, 4, 334, 'NDB_AHO', 'NDE')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (19, 4, 304, 'NCR_AHO', 'NCR')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (20, 4, 367, 'EST_AHO', 'CES')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (21, 4, 371, 'NDB_AHO', 'RET')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (22, 4, 375, 'EST_AHO', 'CES')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (23, 4, 376, 'EST_AHO', 'CES')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (24, 4, 377, 'EST_AHO', 'CES')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (25, 4, 378, 'EST_AHO', 'CES')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (26, 4, 203, 'EST_AHO', 'CES')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (27, 4, 240, 'NDB_AHO', 'DEVLOC')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (28, 4, 392, 'NDB_AHO', 'RET')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (29, 4, 379, 'GMFCARBCO', 'RET')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (26, 4, 380, 'NDB_AHO', 'RET')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (27, 4, 373, 'GMFBCOCAU', 'RET')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (30, 4, 374, 'TRAS_AHO', 'CES')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (31, 4, 258, 'VAL_SUS', 'CXC')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (32, 4, 303, 'COB_SUS', 'CXC')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (33, 4, 750, 'COMPRBMAHO', 'CXP')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (35, 4, 753, 'COMCRBMAHO', 'CXP')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (33, 4, 751, 'AUM_CUPO', 'COR')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (34, 4, 752, 'DIS_CUPO', 'COR')
go

insert into re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo)
values (36, 4, 754, 'COND_AHO', 'CXC')
go

DECLARE @w_sec INT
SELECT @w_sec = max(tp_secuencial)+1 from cob_remesas..re_trn_perfil
UPDATE cobis..cl_seqnos
SET siguiente = @w_sec
WHERE tabla = 're_trn_perfil'
go

print '===> re_concepto_contable'
go

delete from re_concepto_contable
where cc_producto = 4
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (1, 4, 213, NULL, NULL, 'D', 'NDECIECON', 0, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (2, 4, 213, NULL, NULL, 'D', 'NDECIEEFE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (3, 4, 213, NULL, NULL, 'D', 'NDECIECHG', 3, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (4, 4, 213, NULL, 'R', 'D', 'NDEGMF', 0, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (5, 4, 213, NULL, 'R', 'D', 'NDEGMF', 1, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (6, 4, 213, NULL, 'R', 'D', 'NDEGMF', 3, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (7, 4, 237, NULL, NULL, 'D', 'NDETRANS', NULL, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (8, 4, 237, NULL, 'R', 'D', 'NDEGMF', NULL, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (9, 4, 240, NULL, NULL, 'D', 'NDEDEVEFE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (10, 4, 240, NULL, NULL, 'D', 'NDEDEVLOC', 2, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (11, 4, 261, NULL, NULL, 'D', 'RET', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (12, 4, 263, NULL, NULL, 'D', 'RET', NULL, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (13, 4, 264, '1', NULL, 'D', 'NDEESTCTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (14, 4, 264, '4', NULL, 'D', 'NDECOMCHD', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (15, 4, 264, '7', NULL, 'D', 'NDECHQREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (16, 4, 264, '8', NULL, 'D', 'NDEDIFDEP', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (17, 4, 264, '8', NULL, 'D', 'NDEAJUCHP', 2, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (18, 4, 264, '8', NULL, 'D', 'NDEAJUCHL', 3, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (19, 4, 264, '8', NULL, 'D', 'NDEAJUCHR', 4, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (20, 4, 264, '9', NULL, 'D', 'NDEEMBARG', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (21, 4, 264, '10', NULL, 'D', 'NDECOMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (22, 4, 264, '11', NULL, 'D', 'NDEREFBAN', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (23, 4, 264, '12', NULL, 'D', 'NDECOMCIE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (24, 4, 264, '13', NULL, 'D', 'NDECOMECT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (25, 4, 264, '14', NULL, 'D', 'NDETRASLD', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (26, 4, 264, '16', NULL, 'D', 'NDECHQGER', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (27, 4, 264, '17', NULL, 'D', 'NDETRAEXT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (28, 4, 264, '20', NULL, 'D', 'NDETRANS', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (29, 4, 264, '23', NULL, 'D', 'NDESUSDOC', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (30, 4, 264, '24', NULL, 'D', 'NDECONDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (31, 4, 264, '25', NULL, 'D', 'NDECIECTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (32, 4, 264, '26', NULL, 'D', 'NDEPAGCAR', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (33, 4, 264, '27', NULL, 'D', 'NDEPORREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (34, 4, 264, '28', NULL, 'D', 'NDECOMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (35, 4, 264, '30', NULL, 'D', 'NDETRNNAL', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (36, 4, 264, '31', NULL, 'D', 'NDECOMRETV', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (37, 4, 264, '32', 'R', 'D', 'NDEGMF', 1, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (38, 4, 264, '33', NULL, 'D', 'NDEIVA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (39, 4, 264, '34', NULL, 'D', 'NDRVCANDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (40, 4, 264, '84', NULL, 'D', 'NDECOMCHGE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (41, 4, 264, '90', NULL, 'D', 'NDECOMOFI', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (42, 4, 264, '91', NULL, 'D', 'NDERECINT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (43, 4, 264, '92', NULL, 'D', 'NDECOMECT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (44, 4, 264, '93', NULL, 'D', 'NDEREIDESC', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (45, 4, 264, '182', 'R', 'D', 'NDERTEFTE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (46, 4, 264, '183', NULL, 'D', 'NDEPORTDEV', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (47, 4, 264, '184', NULL, 'D', 'NDERETCHGE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (48, 4, 264, '185', NULL, 'D', 'NDECOMTRF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (49, 4, 264, '205', NULL, 'D', 'NDECORDEP', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (50, 4, 264, '213', NULL, 'D', 'NDEAUMDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (51, 4, 264, '236', NULL, 'D', 'NDEMANOPE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (52, 4, 264, '237', NULL, 'D', 'NDEPROVEED', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (257, 4, 752, '50', NULL, 'D', 'CORDICCB', 1, 'ts_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.623', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (54, 4, 264, '244', NULL, 'D', 'NDEREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (55, 4, 264, '246', NULL, 'D', 'NDEDEVCHEX', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (56, 4, 316, '1', NULL, 'D', 'NDEESTCTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (57, 4, 316, '4', NULL, 'D', 'NDECOMCHD', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (58, 4, 316, '7', NULL, 'D', 'NDECHQREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (59, 4, 316, '8', NULL, 'D', 'NDEDIFDEP', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (60, 4, 316, '8', NULL, 'D', 'NDEAJUCHP', 2, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (61, 4, 316, '8', NULL, 'D', 'NDEAJUCHL', 3, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (62, 4, 316, '8', NULL, 'D', 'NDEAJUCHR', 4, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (63, 4, 316, '9', NULL, 'D', 'NDEEMBARG', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (64, 4, 316, '10', NULL, 'D', 'NDECOMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (65, 4, 316, '11', NULL, 'D', 'NDEREFBAN', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (66, 4, 316, '12', NULL, 'D', 'NDECOMCIE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (67, 4, 316, '13', NULL, 'D', 'NDECOMECT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (68, 4, 316, '14', NULL, 'D', 'NDETRASLD', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (69, 4, 316, '16', NULL, 'D', 'NDECHQGER', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (70, 4, 316, '17', NULL, 'D', 'NDETRAEXT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (71, 4, 316, '20', NULL, 'D', 'NDETRANS', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (72, 4, 316, '23', NULL, 'D', 'NDESUSDOC', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (73, 4, 316, '24', NULL, 'D', 'NDECONDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (74, 4, 316, '25', NULL, 'D', 'NDECIECTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (75, 4, 316, '26', NULL, 'D', 'NDEPAGCAR', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (76, 4, 316, '27', NULL, 'D', 'NDEPORREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (77, 4, 316, '28', NULL, 'D', 'NDECOMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (78, 4, 316, '30', NULL, 'D', 'NDETRNNAL', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (79, 4, 316, '32', 'R', 'D', 'NDEGMF', 1, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (80, 4, 316, '33', NULL, 'D', 'NDEIVA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (81, 4, 316, '34', NULL, 'D', 'NDRVCANDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (82, 4, 316, '84', NULL, 'D', 'NDECOMCHGE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (83, 4, 316, '90', NULL, 'D', 'NDECOMOFI', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (84, 4, 316, '91', NULL, 'D', 'NDERECINT', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (85, 4, 316, '92', NULL, 'D', 'NDECONCTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (86, 4, 316, '182', 'R', 'D', 'NDERTEFTE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (87, 4, 316, '185', NULL, 'D', 'NDECOMTRF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (88, 4, 316, '205', NULL, 'D', 'NDECORDEP', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (89, 4, 316, '213', NULL, 'D', 'NDEAUMDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (90, 4, 316, '236', NULL, 'D', 'NDEMANOPE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (91, 4, 316, '237', NULL, 'D', 'NDEPROVEED', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (270, 4, 253, '107', 'T', 'C', 'DEVGMF', 1, 'tm_valor', 'tm_valor', 'tm_valor', 'N', '2014-11-25', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (93, 4, 316, '244', NULL, 'D', 'NDEREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (94, 4, 316, '246', NULL, 'D', 'NDEDEVCHEX', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (95, 4, 224, '59', NULL, 'D', 'DREMI', 1, 'tm_valor', NULL, NULL, 'S', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (96, 4, 308, NULL, 'R', 'D', 'NDERTEFTE', 1, 'tm_valor', 'tm_interes', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (97, 4, 309, NULL, 'R', 'D', 'NDERTEFTE', 1, 'tm_valor', 'tm_interes', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (98, 4, 334, NULL, NULL, 'D', 'NDERTEICA', 1, 'tm_valor', 'tm_interes', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (99, 4, 371, NULL, NULL, 'D', 'NDEAUTFLI', NULL, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (100, 4, 392, NULL, NULL, 'D', 'AUTRETINE', NULL, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (101, 4, 221, NULL, NULL, 'C', 'INTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (102, 4, 304, NULL, NULL, 'C', 'INTI', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (103, 4, 252, NULL, NULL, 'C', 'EFECTIVO', NULL, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (104, 4, 252, NULL, NULL, 'C', 'CH_PRO', NULL, 'tm_chq_propios', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (105, 4, 252, NULL, NULL, 'C', 'CH_LOC', NULL, 'tm_chq_locales', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (106, 4, 252, NULL, NULL, 'C', 'CH_OTR', NULL, 'tm_chq_ot_plazas', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (107, 4, 253, '4', NULL, 'C', 'DEVCOMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (108, 4, 253, '6', NULL, 'C', 'CONCHREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (109, 4, 253, '12', NULL, 'C', 'NCRDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (110, 4, 253, '14', NULL, 'C', 'NCRCONV', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (111, 4, 253, '16', NULL, 'C', 'REVPOS', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (112, 4, 253, '17', NULL, 'C', 'NCRTRNSLD', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (113, 4, 253, '21', NULL, 'C', 'NCRDESPRE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (114, 4, 253, '25', NULL, 'C', 'NCRACH', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (115, 4, 253, '26', NULL, 'C', 'REVMEMACH', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (116, 4, 253, '27', NULL, 'C', 'REVTRACH', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (117, 4, 253, '28', NULL, 'C', 'REVCOMEX', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (118, 4, 253, '30', NULL, 'C', 'NCRRVAPDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (119, 4, 253, '42', NULL, 'C', 'NCRREACTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (120, 4, 253, '43', NULL, 'C', 'REVCOMCHG', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (121, 4, 253, '47', NULL, 'C', 'NCRINTREC', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (122, 4, 253, '48', NULL, 'C', 'NCREINPAGC', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (123, 4, 253, '49', NULL, 'C', 'NCRENTMMI', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (124, 4, 253, '106', NULL, 'C', 'NCRTRANS', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (126, 4, 253, '108', 'R', 'C', 'DEVRTEFTE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (127, 4, 253, '200', NULL, 'C', 'NCRCORDEP', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (128, 4, 253, '203', NULL, 'C', 'NCRDPTCON', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (129, 4, 253, '205', NULL, 'C', 'NCRPAGPROV', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (130, 4, 253, '218', NULL, 'C', 'NCRINTMAN', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (131, 4, 253, '219', NULL, 'C', 'NCRDEPTRA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (132, 4, 253, '224', NULL, 'C', 'NCRDESEMB', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (133, 4, 253, '227', NULL, 'C', 'NCRDEPPCO', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (134, 4, 253, '229', NULL, 'C', 'NCRMANOPE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (135, 4, 253, '234', NULL, 'C', 'NCRREICHG', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (136, 4, 253, '236', NULL, 'C', 'NCRDPTTES', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (137, 4, 253, '237', NULL, 'C', 'NCRCAMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (138, 4, 300, NULL, NULL, 'D', 'NCRTRANS', NULL, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (139, 4, 315, '4', NULL, 'C', 'DEVCOMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (140, 4, 315, '6', NULL, 'C', 'CONCHREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (141, 4, 315, '12', NULL, 'C', 'NCRDPF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (142, 4, 315, '14', NULL, 'C', 'NCRCONV', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (143, 4, 315, '16', NULL, 'C', 'REVPOS', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (144, 4, 315, '17', NULL, 'C', 'NCRTRNSLD', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (145, 4, 315, '21', NULL, 'C', 'NCRDESPRE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (146, 4, 315, '25', NULL, 'C', 'NCRACH', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (147, 4, 315, '26', NULL, 'C', 'REVMEMACH', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (148, 4, 315, '27', NULL, 'C', 'REVTRACH', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (149, 4, 315, '28', NULL, 'C', 'REVCOMEX', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (150, 4, 315, '42', NULL, 'C', 'NCRREACTA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (151, 4, 315, '43', NULL, 'C', 'REVCOMCHG', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (152, 4, 315, '47', NULL, 'C', 'NCRINTREC', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (153, 4, 315, '106', NULL, 'C', 'NCRTRANS', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (154, 4, 315, '107', NULL, 'C', 'DEVGMF', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (155, 4, 315, '108', 'R', 'C', 'DEVRTEFTE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (156, 4, 315, '200', NULL, 'C', 'NCRCORDEP', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (157, 4, 315, '203', NULL, 'C', 'NCRDPTCON', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (158, 4, 315, '205', NULL, 'C', 'NCRPAGPROV', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (159, 4, 315, '218', NULL, 'C', 'NCRINTMAN', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (160, 4, 315, '219', NULL, 'C', 'NCRDEPTRA', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (161, 4, 315, '224', NULL, 'C', 'NCRDESEMB', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (162, 4, 315, '227', NULL, 'C', 'NCRDEPPCO', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (163, 4, 315, '229', NULL, 'C', 'NCRMANOPE', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (164, 4, 315, '234', NULL, 'C', 'NCRREICHG', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (165, 4, 315, '236', NULL, 'C', 'NCRDPTTES', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (166, 4, 315, '237', NULL, 'C', 'NCRCAMREM', 1, 'tm_valor', NULL, NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (167, 4, 264, NULL, 'V', 'D', 'NDEIVA', 1, 'tm_valor_comision', 'tm_valor', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (168, 4, 261, NULL, 'R', 'D', 'NDEGMF', 1, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (169, 4, 263, NULL, 'R', 'D', 'NDEGMF', NULL, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (170, 4, 264, NULL, 'R', 'D', 'NDEGMF', 1, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (171, 4, 308, NULL, 'R', 'D', 'NDEGMF', 1, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (172, 4, 309, NULL, 'R', 'D', 'NDEGMF', 1, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (173, 4, 316, NULL, 'R', 'D', 'NDEGMF', 1, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (174, 4, 334, NULL, 'R', 'D', 'NDEGMF', 1, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (175, 4, 371, NULL, 'R', 'D', 'NDEGMF', NULL, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (176, 4, 392, NULL, 'R', 'D', 'NDEGMF', NULL, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2010-10-19', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (177, 4, 367, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (178, 4, 367, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (179, 4, 375, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (180, 4, 375, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (181, 4, 376, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (182, 4, 376, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (183, 4, 377, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (184, 4, 377, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (185, 4, 378, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (186, 4, 379, NULL, 'R', 'D', 'GMFCARBCO', NULL, 'ts_valor', 'ts_interes', NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (187, 4, 203, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (188, 4, 203, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (189, 4, 271, NULL, NULL, 'C', 'INT', NULL, 'ts_valor', NULL, NULL, 'N', '2010-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (190, 4, 253, '109', NULL, 'C', 'NCRCTAEMP', 1, 'tm_valor', NULL, NULL, 'N', '2011-03-25', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (191, 4, 253, '242', NULL, 'C', 'NCRWU', 1, 'tm_valor', NULL, NULL, 'N', '2011-08-09', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (192, 4, 380, NULL, NULL, 'D', 'NDERETCHGE', 0, 'tm_valor', NULL, NULL, 'N', '2012-01-14', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (193, 4, 380, NULL, 'R', 'D', 'NDEGMF', 0, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2012-01-14', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (194, 4, 264, '35', NULL, 'D', 'NDECOMCHGE', 1, 'tm_valor', NULL, NULL, 'N', '2012-02-09', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (195, 4, 253, '110', NULL, 'C', 'NCTRDCTOB', 1, 'tm_valor', NULL, NULL, 'N', '2012-03-22', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (196, 4, 264, '248', NULL, 'D', 'NDTRACTOB', 1, 'tm_valor', NULL, NULL, 'N', '2012-03-22', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (197, 4, 213, NULL, NULL, 'D', 'NDECANCIN', 2, 'tm_valor', NULL, NULL, 'N', '2012-09-29', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (198, 4, 213, NULL, NULL, 'D', 'NDEGMF', 2, 'tm_monto_imp', 'tm_base_gmf', NULL, 'N', '2012-09-29', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (200, 4, 253, '19', NULL, 'C', 'NCABNOEM', 1, 'tm_valor', NULL, NULL, 'N', '2012-12-21', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (201, 4, 253, '23', NULL, 'C', 'NCABPAVI', 1, 'tm_valor', NULL, NULL, 'N', '2012-12-21', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (202, 4, 373, '205', 'T', 'C', 'NCRPAGPROV', 0, 'ts_valor', 'ts_interes', NULL, 'N', '2013-07-24', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (203, 4, 373, '19', 'T', 'C', 'NCABNOEM', 0, 'ts_valor', 'ts_interes', NULL, 'N', '2013-07-24', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (205, 4, 253, '50', NULL, 'C', 'NCDTN', 1, 'tm_valor', NULL, NULL, 'N', '2013-12-12 18:00:50.48', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (207, 4, 253, '20', NULL, 'C', 'NCRGMFCBCO', 1, 'tm_valor', NULL, NULL, 'N', '2014-01-19 08:40:19.92', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (207, 4, 264, '36', NULL, 'D', 'NDCOMDISP', 1, 'tm_valor', NULL, NULL, 'N', '2014-01-19 08:40:20.46', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (208, 4, 374, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'N', '2014-03-07', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (210, 4, 264, '37', NULL, 'D', 'NDECOMCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-04-05 14:54:15.257', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (211, 4, 264, '38', NULL, 'D', 'NDERETCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-04-05 14:54:15.263', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (212, 4, 253, '39', NULL, 'C', 'NCRDEPCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-04-05 14:54:15.267', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (213, 4, 253, '245', NULL, 'C', 'NCAJUSERRT', 1, 'tm_valor', NULL, NULL, 'N', '2014-04-29', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (214, 4, 253, '246', NULL, 'C', 'NCAJUSTGMF', 1, 'tm_valor', NULL, NULL, 'N', '2014-04-29', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (210, 4, 258, '141', NULL, 'D', 'CXCCOMATMN', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (211, 4, 258, '142', NULL, 'D', 'CXCCOMATMI', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (212, 4, 258, '233', NULL, 'D', 'CXCCSAATMN', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (213, 4, 258, '234', NULL, 'D', 'CXCCSAATMI', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (214, 4, 258, '238', NULL, 'D', 'CXCCUOMAN', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (215, 4, 258, '156', NULL, 'D', 'CXCPININV', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (216, 4, 258, '159', NULL, 'D', 'CXCPDTARJ', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (217, 4, 258, '160', NULL, 'D', 'CXCROTARJ', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (218, 4, 303, '141', NULL, 'D', 'CXCCOMATMN', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (219, 4, 303, '142', NULL, 'D', 'CXCCOMATMI', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (220, 4, 303, '233', NULL, 'D', 'CXCCSAATMN', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (221, 4, 303, '234', NULL, 'D', 'CXCCSAATMI', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (222, 4, 303, '156', NULL, 'D', 'CXCPININV', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (223, 4, 303, '159', NULL, 'D', 'CXCPDTARJ', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (224, 4, 303, '160', NULL, 'D', 'CXCROTARJ', 1, 'ts_valor', NULL, NULL, 'N', '2013-10-19', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (224, 4, 264, '161', NULL, 'D', 'NDEFINSU', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.347', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (224, 4, 258, '161', NULL, 'D', 'CXCFINSU', 1, 'ts_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.35', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (224, 4, 303, '161', NULL, 'D', 'CXCFINSU', 1, 'ts_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.353', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (225, 4, 264, '141', NULL, 'D', 'NDECOMATMN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.353', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (226, 4, 264, '142', NULL, 'D', 'NDECOMATMI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.353', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (227, 4, 264, '40', NULL, 'D', 'NDECOMPOSN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.357', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (228, 4, 264, '41', NULL, 'D', 'NDECOMPOSI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.357', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (229, 4, 264, '233', NULL, 'D', 'NDECSAATMN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.357', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (230, 4, 264, '234', NULL, 'D', 'NDECSAATMI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.36', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (231, 4, 264, '139', NULL, 'D', 'NDERETATMN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.36', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (232, 4, 264, '140', NULL, 'D', 'NDERETATMI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.36', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (233, 4, 264, '143', NULL, 'D', 'NDERETPOS', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.363', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (234, 4, 264, '75', NULL, 'D', 'NDERETPOSI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.363', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (235, 4, 264, '238', NULL, 'D', 'NDECUOMAN', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.363', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (236, 4, 264, '156', NULL, 'D', 'NDEPININV', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.367', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (237, 4, 264, '159', NULL, 'D', 'NDEPDTARJ', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.367', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (238, 4, 264, '160', NULL, 'D', 'NDEROTARJ', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.37', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (239, 4, 253, '243', NULL, 'C', 'NCRRETPOS', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.37', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (240, 4, 253, '244', NULL, 'C', 'NCRRETPOSI', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:11.37', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (241, 4, 264, '170', NULL, 'D', 'NDAJ51RBM', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:12.727', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (242, 4, 264, '171', NULL, 'D', 'NDAJ57RBM', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:12.727', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (243, 4, 253, '170', NULL, 'C', 'NCAJ50RBM', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:12.727', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (244, 4, 253, '171', NULL, 'C', 'NCAJ56RBM', 1, 'tm_valor', NULL, NULL, 'N', '2014-06-01 10:59:12.73', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (245, 4, 750, '139', NULL, 'D', 'CMPRETATMN', 1, 'ts_valor', NULL, NULL, 'N', '2014-06-01 10:59:12.73', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (246, 4, 750, '140', NULL, 'D', 'CMPRETATMI', 1, 'ts_valor', NULL, NULL, 'N', '2014-06-01 10:59:12.73', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (247, 4, 750, '143', NULL, 'D', 'CMPRETPOSN', 1, 'ts_valor', NULL, NULL, 'N', '2014-06-01 10:59:12.73', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (248, 4, 750, '75', NULL, 'D', 'CMPRETPOSI', 1, 'ts_valor', NULL, NULL, 'N', '2014-06-01 10:59:12.733', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (256, 4, 753, '243', NULL, 'C', 'CMPANUPOSN', 1, 'ts_valor', NULL, NULL, 'N', '2014-07-10 18:45:15.2', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (256, 4, 753, '244', NULL, 'C', 'CMPANUPOSI', 1, 'ts_valor', NULL, NULL, 'N', '2014-07-10 18:45:15.203', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (260, 4, 264, '260', NULL, 'D', 'CCCUPOCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.633', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (261, 4, 253, '260', NULL, 'C', 'CCCUPOCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.637', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (262, 4, 264, '261', NULL, 'D', 'NDECCCBP', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.637', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (263, 4, 253, '261', NULL, 'C', 'NCRCCCBP', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.637', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (199, 4, 253, '111', NULL, 'C', 'NCRCOMCB', 1, 'tm_valor', NULL, NULL, 'N', '2012-10-10', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (204, 4, 373, '23', 'T', 'C', 'NCABPAVI', 0, 'ts_valor', 'ts_interes', NULL, 'N', '2013-07-24', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (206, 4, 373, '50', 'T', 'C', 'NCDTN', 0, 'ts_valor', 'ts_interes', NULL, 'N', '2013-12-12', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (209, 4, 374, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'N', '2014-03-07', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (258, 4, 751, '51', NULL, 'C', 'CORRGCCB', 1, 'ts_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.63', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (259, 4, 751, '52', NULL, 'C', 'CORAUCCB', 1, 'ts_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.633', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (264, 4, 258, '260', NULL, 'D', 'CXCDICCB', 1, 'ts_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.64', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (265, 4, 303, '260', NULL, 'C', 'CXCAUMCB', 1, 'ts_valor', NULL, NULL, 'N', '2014-07-26 14:50:31.64', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (266, 4, 264, '50', NULL, 'D', 'NDEDICCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:45.1', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (267, 4, 253, '51', NULL, 'C', 'NCRRGCCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:45.103', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (268, 4, 253, '52', NULL, 'C', 'NCRAUCCB', 1, 'tm_valor', NULL, NULL, 'N', '2014-07-26 14:50:45.107', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (269, 4, 253, '112', NULL, 'C', 'NCDEVCMTD', 1, 'tm_valor', NULL, NULL, 'N', '2014-08-06', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (221, 4, 303, '238', NULL, 'D', 'CXCCUOMAN', 1, 'ts_valor', NULL, NULL, 'N', '2014-08-29', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (271, 4, 253, '114', NULL, 'C', 'NCABONOPAG', 1, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2015-01-26', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (272, 4, 373, '114', 'T', 'C', 'NCABONOPAG', 0, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2015-01-26', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (275, 4, 264, '85', NULL, 'D', 'NDETRSMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.503', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (274, 4, 253, '115', NULL, 'C', 'NCPAgoINCE', 1, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2015-04-07', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (276, 4, 264, '164', NULL, 'D', 'NDERECMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.503', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (277, 4, 264, '87', NULL, 'D', 'NDECCMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.503', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (278, 4, 264, '163', NULL, 'D', 'NDEPAGMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.507', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (279, 4, 264, '86', NULL, 'D', 'NDERCMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.507', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (280, 4, 264, '88', NULL, 'D', 'NDEACMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.51', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (281, 4, 264, '39', NULL, 'D', 'NDECMRMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.51', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (282, 4, 264, '46', NULL, 'D', 'NDECMUMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.51', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (283, 4, 264, '152', NULL, 'D', 'NDECCSMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.513', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (284, 4, 264, '162', NULL, 'D', 'NDECMOMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.527', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (285, 4, 253, '85', NULL, 'C', 'NCRTRSMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.543', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (286, 4, 253, '86', NULL, 'C', 'NCRRCMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.55', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (287, 4, 253, '87', NULL, 'C', 'NCRCCMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.56', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (288, 4, 253, '88', NULL, 'C', 'NCRACMMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.56', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (289, 4, 258, '39', NULL, 'D', 'CXCCMRMOV', 1, 'ts_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.56', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (290, 4, 303, '39', NULL, 'D', 'CXCCMRMOV', 1, 'ts_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.563', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (291, 4, 258, '46', NULL, 'D', 'CXCCMUMOV', 1, 'ts_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.563', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (292, 4, 303, '46', NULL, 'D', 'CXCCMUMOV', 1, 'ts_valor', NULL, NULL, 'N', '2015-06-16 19:42:52.567', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (297, 4, 253, '116', 'T', 'C', 'NCAJTRNATM', 1, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2015-07-31', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (295, 4, 253, '163', NULL, 'D', 'NCRPAGMOV', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-16 19:42:55.113', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (296, 4, 264, '44', NULL, 'D', 'NDEPCARMAS', 1, 'tm_valor', NULL, NULL, 'N', '2015-06-26', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (298, 4, 253, '117', 'T', 'C', 'NCAJTRNPOS', 1, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2015-07-31', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (299, 4, 253, '118', 'T', 'C', 'NCAJCOMATM', 1, 'tm_valor', 'tm_base_gmf', NULL, 'N', '2015-07-31', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (300, 4, 264, '165', NULL, 'D', 'NDAJTRNATM', 1, 'tm_valor', NULL, NULL, 'N', '2015-09-24', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (301, 4, 264, '166', NULL, 'D', 'NDAJTRNPOS', 1, 'tm_valor', NULL, NULL, 'N', '2015-09-24', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (302, 4, 264, '167', NULL, 'D', 'CXCEXCMONT', 1, 'tm_valor', NULL, NULL, 'N', '2015-10-02', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (303, 4, 264, '168', NULL, 'D', 'CXCEXCNUMU', 1, 'tm_valor', NULL, NULL, 'N', '2015-10-02', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (304, 4, 253, '31', NULL, 'C', 'NCRREFERI', 1, 'tm_valor', NULL, NULL, 'N', '2015-10-22 21:34:32.92', 'M', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (305, 4, 373, '31', 'T', 'C', 'NCRREFERI', 0, 'ts_valor', 'ts_interes', NULL, 'N', '2015-10-29', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (306, 4, 754, '160', NULL, 'D', 'CNDROTARJ', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (307, 4, 754, '160', NULL, 'D', 'CNDPININV', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (308, 4, 754, '159', NULL, 'D', 'CNDPDTARJ', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (309, 4, 754, '161', NULL, 'D', 'CNDFINSU', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (310, 4, 754, '233', NULL, 'D', 'CNDCSAATMN', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (311, 4, 754, '234', NULL, 'D', 'CNDCSAATMI', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (312, 4, 754, '141', NULL, 'D', 'CNDCOMATMN', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (313, 4, 754, '142', NULL, 'D', 'CNDCOMATMI', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

insert into re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)
values (314, 4, 754, '238', NULL, 'D', 'CNDCUOMAN', 1, 'ts_valor', NULL, NULL, 'N', '2015-11-09', 'S', 'V')
go

