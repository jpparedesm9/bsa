Use cob_conta
go

declare  @w_empresa  int,
         @w_modulo   int

if exists (select 1 from cob_conta..sysobjects where name = 'cb_det_perfil')
begin
   select @w_modulo = 7
   select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

   delete from cob_conta..cb_det_perfil where dp_empresa = @w_empresa and dp_producto = @w_modulo
 
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_DES',1,'CAP_1311NE','CTB_OF','1',10010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_DES',2,'11020204','CTB_OF','2',128,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_DES',3,'11020204','CTB_OF','2',129,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_DES',4,'F_PAGO','CTB_OF','2',110,'N','O', NULL, 'L')



INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PRV',1,'INT_1311NE','CTB_OF','1',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PRV',2,'INT_5105NE','CTB_OF','2',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PRV',3,'INT_7711','CTB_OF','1',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PRV',4,'8701','CTB_OF','2',11090,'N','D', NULL, 'L')




INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',1,'F_PAGO','CTB_OF','1',129,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',2,'F_PAGO','CTB_OF','1',137,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',3,'F_PAGO','CTB_OF','1',131,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',4,'F_PAGO','CTB_OF','1',110,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',5,'F_PAGO','CTB_OF','1',132,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',6,'F_PAGO','CTB_OF','1',128,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',7,'14019004','CTB_OF','2',100,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',8,'F_PAGO','CTB_OF','1',138,'N','O', NULL, 'L')	
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',9,'F_PAGO','CTB_OF','1',139,'N','D', NULL, 'L')
insert into cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)values ( @w_empresa, @w_modulo, 'CCA_RPA',10, 'F_PAGO', 'CTB_OF', '1', 142, 'N', 'O', NULL, 'L')
insert into cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)values ( @w_empresa, @w_modulo, 'CCA_RPA',11, 'F_PAGO', 'CTB_OF', '1', 143, 'N', 'O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_RPA',12,'F_PAGO','CTB_OF','1',144,'N','O', NULL, 'L')	



INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',1,'CAP_1311NE','CTB_OF','2',10010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',2,'CAP_1311EX','CTB_OF','2',10011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',3,'CAP_1361NE','CTB_OF','2',10020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',4,'CAP_1361EX','CTB_OF','2',10021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',5,'CAS_5050','CTB_OF','2',10040,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',6,'CAS_5050','CTB_OF','2',10041,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',7,'QUI_1391','CTB_OF','1',10017,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',8,'QUI_1391','CTB_OF','1',10027,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',9,'CAS_5050','CTB_OF','1',10047,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',10,'INT_1311NE','CTB_OF','2',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',11,'INT_1311EX','CTB_OF','2',11011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',12,'INT_1361','CTB_OF','2',11020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',13,'INT_1361','CTB_OF','2',11021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',14,'INT_7711','CTB_OF','2',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',15,'8701','CTB_OF','1',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',16,'INT_5102','CTB_OF','2',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',17,'INT_7711','CTB_OF','2',11091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',18,'8701','CTB_OF','1',11091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',19,'INT_5102','CTB_OF','2',11091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',20,'CAS_5050','CTB_OF','2',11040,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',21,'CAS_5050','CTB_OF','2',11041,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',22,'QUI_1391','CTB_OF','1',11017,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',23,'QUI_1391','CTB_OF','1',11027,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',24,'INT_5102','CTB_OF','1',11097,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',25,'INT_5102','CTB_OF','1',11047,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',26,'24010702','CTB_OF','2',12010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',27,'24010702','CTB_OF','2',12011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',28,'24010702','CTB_OF','2',12020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',29,'24010702','CTB_OF','2',12021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',30,'24010702','CTB_OF','2',12090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',31,'24010702','CTB_OF','2',12091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',32,'24010702','CTB_OF','2',12040,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',33,'24010702','CTB_OF','2',12041,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',34,'24010702','CTB_OF','1',12017,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',35,'24010702','CTB_OF','1',12027,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',36,'24010702','CTB_OF','1',12097,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',37,'24010702','CTB_OF','1',12047,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',38,'COM_5321','CTB_OF','2',15010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',39,'COM_5321','CTB_OF','2',15011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',40,'COM_5321','CTB_OF','2',15020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',41,'COM_5321','CTB_OF','2',15021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',42,'COM_5321','CTB_OF','2',15090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',43,'COM_5321','CTB_OF','2',15091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',44,'CAS_5050','CTB_OF','2',15040,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',45,'CAS_5050','CTB_OF','2',15041,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',46,'COM_5321','CTB_OF','1',15017,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',47,'COM_5321','CTB_OF','1',15027,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',48,'COM_5321','CTB_OF','1',15097,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',49,'CAS_5050','CTB_OF','1',15047,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',50,'24010702','CTB_OF','2',16010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',51,'24010702','CTB_OF','2',16011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',52,'24010702','CTB_OF','2',16020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',53,'24010702','CTB_OF','2',16021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',54,'24010702','CTB_OF','2',16090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',55,'24010702','CTB_OF','2',16091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',56,'24010702','CTB_OF','2',16040,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',57,'24010702','CTB_OF','2',16041,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',58,'24010702','CTB_OF','1',16017,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',59,'24010702','CTB_OF','1',16027,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',60,'24010702','CTB_OF','1',16097,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',61,'24010702','CTB_OF','1',16047,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',62,'COM_5321','CTB_OF','2',17010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',63,'COM_5321','CTB_OF','2',17011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',64,'COM_5321','CTB_OF','2',17020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',65,'COM_5321','CTB_OF','2',17021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',66,'COM_5321','CTB_OF','2',17090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',67,'COM_5321','CTB_OF','2',17091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',68,'CAS_5050','CTB_OF','2',17040,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',69,'CAS_5050','CTB_OF','2',17041,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',70,'COM_5321','CTB_OF','1',17017,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',71,'COM_5321','CTB_OF','1',17027,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',72,'COM_5321','CTB_OF','1',17097,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',73,'CAS_5050','CTB_OF','1',17047,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',74,'24010702','CTB_OF','2',18010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',75,'24010702','CTB_OF','2',18011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',76,'24010702','CTB_OF','2',18020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',77,'24010702','CTB_OF','2',18021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',78,'24010702','CTB_OF','2',18090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',79,'24010702','CTB_OF','2',18091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',80,'24010702','CTB_OF','2',18040,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',81,'24010702','CTB_OF','2',18041,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',82,'24010702','CTB_OF','1',18017,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',83,'24010702','CTB_OF','1',18027,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',84,'24010702','CTB_OF','1',18097,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',85,'24010702','CTB_OF','1',18047,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',86,'F_PAGO'  ,'CTB_OF','2',136,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_PAG',87,'14019004','CTB_OF','1',100,'N','O', NULL, 'L')
insert into cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)values  (@w_empresa, @w_modulo, 'CCA_PAG',88,'510511900201','CTB_OF', '1', 140, 'N', 'O', NULL, 'L')




INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',1,'CAP_1311NE','CTB_OF','1',10010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',2,'CAP_1311EX','CTB_OF','1',10011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',3,'CAP_1361NE','CTB_OF','1',10020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',4,'CAP_1361EX','CTB_OF','1',10021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',7,'INT_1311NE','CTB_OF','1',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',8,'INT_5105NE','CTB_OF','2',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',9,'INT_1311EX','CTB_OF','1',11011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',10,'INT_5105EX','CTB_OF','2',11011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',11,'INT_1361','CTB_OF','1',11020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',12,'INT_5102','CTB_OF','2',11020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',13,'INT_1361','CTB_OF','1',11021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',14,'INT_5102','CTB_OF','2',11021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',15,'INT_7711','CTB_OF','1',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',16,'8701','CTB_OF','2',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',17,'INT_7711','CTB_OF','1',11091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_EST',18,'8701','CTB_OF','2',11091,'N','D', NULL, 'L')



INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',1,'CAP_1311NE','CTB_OF','1',10010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',2,'CAP_1311EX','CTB_OF','1',10011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',3,'CAP_1361NE','CTB_OF','1',10020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',4,'CAP_1361EX','CTB_OF','1',10021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',5,'INT_1311NE','CTB_OF','1',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',6,'INT_1311EX','CTB_OF','1',11011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',7,'INT_1361','CTB_OF','1',11020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',8,'INT_1361','CTB_OF','1',11021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',9,'INT_7711','CTB_OF','1',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'BOC_ACT',10,'INT_7711','CTB_OF','1',11091,'N','D', NULL, 'L')


INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_FND',1,'11020201','CTB_OF','1',10010,'N','O', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_FND',2,'230202','CTB_OF','2',10010,'N','O', NULL, 'L')


INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 1, '11020205', 'CTB_OF', '1', 131, 'N', 'O', NULL, 'L')
INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 2, '240191', 'CTB_OF', '2', 131, 'N', 'O', NULL, 'L')
INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 3, '14910101', 'CTB_OF', '1', 139, 'N', 'O', NULL, 'L')
INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 4, '240191', 'CTB_OF', '2', 139, 'N', 'O', NULL, 'L')
INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 5, '14910101', 'CTB_OF', '1', 136, 'N', 'O', NULL, 'L')
INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 6, '11020201', 'CTB_OF', '2', 136, 'N', 'O', NULL, 'L')
INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 7, '14019101', 'CTB_OF', '1', 141, 'N', 'O', NULL, 'L')
INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 7, 'CCA_GAR', 8, '240191', 'CTB_OF', '2', 141, 'N', 'O', NULL, 'L')

INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',1,'CAP_1311NE','CTB_OF','1',10010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',2,'CAS_1391','CTB_OF','2',10010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',3,'CAP_1311EX','CTB_OF','1',10011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',4,'CAS_1391','CTB_OF','2',10011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',5,'CAP_1361NE','CTB_OF','1',10020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',6,'CAS_1391','CTB_OF','2',10020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',7,'CAP_1361EX','CTB_OF','1',10021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',8,'CAS_1391','CTB_OF','2',10021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',9,'INT_1311NE','CTB_OF','1',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',10,'CAS_1391','CTB_OF','2',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',11,'INT_1311EX','CTB_OF','1',11011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',12,'CAS_1391','CTB_OF','2',11011,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',13,'INT_1361','CTB_OF','1',11020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',14,'CAS_1391','CTB_OF','2',11020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',15,'INT_1361','CTB_OF','1',11021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',16,'CAS_1391','CTB_OF','2',11021,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',17,'INT_7711','CTB_OF','1',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',18,'8701','CTB_OF','2',11090,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',19,'INT_7711','CTB_OF','1',11091,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_CAS',20,'8701','CTB_OF','2',11091,'N','D', NULL, 'L')



INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',1,'CAP_1311NE','CTB_OF','2',10010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',2,'CAP_1311EX','CTB_OF','1',10010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',3,'CAP_1361NE','CTB_OF','2',10020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',4,'CAP_1361EX','CTB_OF','1',10020,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',5,'INT_1311NE','CTB_OF','2',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',6,'INT_5105NE','CTB_OF','1',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',7,'INT_1311EX','CTB_OF','1',11010,'N','D', NULL, 'L')
INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (@w_empresa, @w_modulo, 'CCA_VEN',8,'INT_5105EX','CTB_OF','2',11010,'N','D', NULL, 'L')

end
else
   print 'NO EXISTE TABLA cb_det_perfil'

go

PRINT 'ACTUALIZACION CODIGO VALOR EN COB_CONTA'

delete cob_conta..cb_codigo_valor where cv_producto = 7
go

if OBJECT_ID('tempdb..#exigibles') is not null
 drop table tempdb..#exigibles

CREATE TABLE #exigibles(codigo int, descripcion varchar(20))
 
insert into #exigibles
values(0, 'NO EXI'),(1, 'EXI')

insert into cob_conta..cb_codigo_valor 
select 1, 7, co_codigo * 1000 + es_codigo * 10 + codigo, co_descripcion + ' - ' + es_descripcion + ' - ' + descripcion
from   cob_cartera..ca_concepto, cob_cartera..ca_estado, #exigibles

insert into cob_conta..cb_codigo_valor 
select 1, 7, cp_codvalor, cp_descripcion 
from   cob_cartera..ca_producto 

go 


use cob_conta 
go 



if  not exists (select 1 from cb_det_perfil where dp_empresa = 1 and dp_producto = 7 and dp_perfil = 'CCA_EST' and dp_asiento =19) 	begin
        
  INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
  VALUES (1, 7, 'CCA_EST', 19, '240191', 'CTB_OF', '2', 132, 'N', 'D', NULL, 'L')


end else begin 

   print 'EXISTE DETALLE DE PERFIL'


end 