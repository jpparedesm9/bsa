use cob_conta
go

delete cob_conta..cb_det_perfil
where dp_perfil = 'CCA_RPA'
and dp_codval = 139

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) 
values (1, 7, 'CCA_RPA',9,'F_PAGO','CTB_OF','1',139,'N','O', NULL, 'L')

delete cob_conta..cb_det_perfil
where dp_perfil = 'CCA_GAR'
--and dp_codval in (131,139)

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1, 7, 'CCA_GAR',1,'11020205','CTB_OF','1',131,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1, 7, 'CCA_GAR',2,'241302',  'CTB_OF','2',131,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1, 7, 'CCA_GAR',3,'14910101','CTB_OF','1',139,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1, 7, 'CCA_GAR',4,'241302',  'CTB_OF','2',139,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1, 7, 'CCA_GAR',5,'14910101','CTB_OF','1',136,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1, 7, 'CCA_GAR',6,'11020201','CTB_OF','2',136,'N','O', NULL, 'L')

delete from cob_conta..cb_relparam 
where re_parametro = 'F_PAGO'
and re_clave in ('OXXO', 'SOBRANTE')

INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) VALUES (1, 'F_PAGO','OXXO','14910101',7, 'CTB_OF','D')
INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) VALUES (1, 'F_PAGO','SOBRANTE','11020201',7, 'CTB_OF','D')

go

