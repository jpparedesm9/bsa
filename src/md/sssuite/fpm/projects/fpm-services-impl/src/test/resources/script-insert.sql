delete from fp_nodetypeproduct
insert into fp_nodetypeproduct values (1,null,'Grupo Financiero','Corresponde al banco matriz','N','N')
insert into fp_nodetypeproduct values (2,1,'Familia de Productos','Catería de productos en base al tipo contable (Activos Pasivos)','N','N')
insert into fp_nodetypeproduct values (3,2,'Grupo de Productos','Productos que pertenecen a una catería (Prestamos, A la vista)','S','N')
insert into fp_nodetypeproduct values (4,3,'Tipo de Productos','Agrupadores (Hipotecarios, Cuentas de Cheques)','N','N')
insert into fp_nodetypeproduct values (5,4,'Productos Finales','Productos ofertados a los clientes','N','S')


delete from fp_functionalities
insert into fp_functionalities values ('PAR_GEN','Parámetros Generales','Parámetros Generales', 'S')
insert into fp_functionalities values ('PROD_BANC','Producto Bancario','Crea un nuevo Producto Bancario', 'S')
insert into fp_functionalities values ('EDIT_PROD','Editar Producto Bancario','Edita el producto bancario', 'S')
insert into fp_functionalities values ('ITEM_PROD','Rubros por Producto','Rubros por Producto', 'S')
insert into fp_functionalities values ('CURR_PROD','Monedas y Politicas','Asocia monedas y politicas a un producto bancario', 'S')


delete from fp_nodetypefunctionalities
insert into fp_nodetypefunctionalities values (1,'PROD_BANC',1)
insert into fp_nodetypefunctionalities values (2,'EDIT_PROD',1)
insert into fp_nodetypefunctionalities values (1,'PROD_BANC',2)
insert into fp_nodetypefunctionalities values (2,'EDIT_PROD',2)
insert into fp_nodetypefunctionalities values (1,'PROD_BANC',3)
insert into fp_nodetypefunctionalities values (2,'EDIT_PROD',3)
insert into fp_nodetypefunctionalities values (3,'CURR_PROD',3)
insert into fp_nodetypefunctionalities values (4,'PAR_GEN',3)
insert into fp_nodetypefunctionalities values (4,'ITEM_PROD',3)
insert into fp_nodetypefunctionalities values (1,'PROD_BANC',4)
insert into fp_nodetypefunctionalities values (2,'EDIT_PROD',4)
insert into fp_nodetypefunctionalities values (3,'CURR_PROD',4)
insert into fp_nodetypefunctionalities values (4,'PAR_GEN',4)
insert into fp_nodetypefunctionalities values (5,'ITEM_PROD',4)
insert into fp_nodetypefunctionalities values (1,'EDIT_PROD',5)
insert into fp_nodetypefunctionalities values (2,'CURR_PROD',5)
insert into fp_nodetypefunctionalities values (3,'PAR_GEN',5)
insert into fp_nodetypefunctionalities values (4,'ITEM_PROD',5)

/*Seccion de insercioón Modulos */
delete from fp_module
insert into fp_modulegroup values (1,'Activas')
insert into fp_module values (1,1, 'Cartera','CCA')

delete from fp_processbymodule
insert into fp_processbymodule values (1,1,'ORI')
insert into fp_processbymodule values (1,1,'REF')
insert into fp_processbymodule values (1,1,'RES')

delete from fp_nodetypecategory 
insert into fp_nodetypecategory values (100,3,1,1,'Cartera', 'Producto de Activas', null)
insert into fp_nodetypecategory values (200,5,null,null,'Catería producto final', 'Catería asociada al producto final', null)
insert into fp_nodetypecategory values (300,3,1,1,'Catería tipo 3', 'Catería tipo 3', null)
insert into fp_nodetypecategory values (400,4,null,null,'Catería tipo 4', 'Catería tipo 4', null)
insert into fp_nodetypecategory values (500,2,1,1,'Catería tipo 2', 'Catería tipo 2', null)
INSERT INTO fp_nodetypecategory VALUES(1, 1, NULL,null, 'Grupo Financiero', 'CaterÝa asociada al producto grupo financiero', NULL)
INSERT INTO fp_nodetypecategory VALUES(2, 5, NULL,null, 'CaterÝa producto final', 'CaterÝa asociada al producto final', NULL)
INSERT INTO fp_nodetypecategory VALUES(4, 4, NULL,null, 'TEST NAME', 'TEST NAME', 'CODTEST')
INSERT INTO fp_nodetypecategory VALUES(5, 4, NULL,null, 'COMMERCIAL BANKING', 'COMMERCIAL BANKING', 'COMR')
INSERT INTO fp_nodetypecategory VALUES(6, 4, NULL,null, 'RETAIL BANKING', 'RETAIL BANKING', 'CONS')
INSERT INTO fp_nodetypecategory VALUES(7, 4, NULL,null, 'COPORATE BANKING', 'COPORATE BANKING', 'CORP')
INSERT INTO fp_nodetypecategory VALUES(8, 4, NULL,null, 'FACTORING', 'FACTORING', 'FACT')
INSERT INTO fp_nodetypecategory VALUES(9, 4, NULL,null, 'PRIVATE BANKING', 'PRIVATE BANKING', 'PRIV')
INSERT INTO fp_nodetypecategory VALUES(10, 4, NULL,null, 'Sector', 'Sector', 'Sector')
INSERT INTO fp_nodetypecategory VALUES(3, 2, 1,1, 'Activas', 'CaterÝa asociada al modulo de activas', NULL)
INSERT INTO fp_nodetypecategory VALUES(3100, 3, 1,1, 'Cartera', 'Cartera', 'LOANS')
INSERT INTO fp_nodetypecategory VALUES(5502, 3, 1,1, 'Test', 'Test', 'test')
INSERT INTO fp_nodetypecategory VALUES(5700, 3, 1,1, 'pruebas', 'pruebas apf', 'pru')

INSERT INTO fp_servicestransactions values('Dep',3100,'Depositos','Depositos Completos','T','V')
INSERT INTO fp_servicestransactions values('Dep2',5502,'Depositos2','Depositos Completos2','T','V')

delete from fp_bankingproductshistory

insert into fp_companies values (238,null,'COMPANY','COMPANY')


insert into fp_items values (1023,3100, 'CAPITAL','CAPITAL','01',1,'')

insert into fp_items values (1235,5502, 'CAPITAL-NEW','CAPITAL-NEW','10',1,'')

insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_nodetypecategory',1000,'ntc_productcatery_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_companies',1000,'com_company_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_dictionaryfields',1000,'dc_fields_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_dicfunctionalitygroup',1000,'dfg_functionality_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_bankingproductshistory',5000,'bph_codsequential')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_servicestransactionfield',1000,'stf_fields_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_transactionfieldvalues',1000,'tfv_value_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_paymenttypefields',1000,'pt_fields_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_servtranbankingproduct',1000,'sbp_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_transactionchannels',1000,'tc_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_channelpayments',1000,'cp_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_transactionchannelsbase',1000,'tcb_id')
insert into cobis.CL_SEQNOS_JAVA values ('cob_fpm','fp_channelpaymentsbase',1000,'cpb_id')


INSERT INTO fp_companies VALUES(6136, NULL, 'HSBC', 'GROUP FINANCIAL HSBC')
INSERT INTO fp_companies VALUES(6435, 6136, 'HSBC Costa Rica', 'descripcion')

  
INSERT INTO fp_bankingproducts VALUES('BPROOT2', 1, 6136, 'HSBC', ' ', NULL, 'N',  0,  'N', '2005-05-16 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('BPROOT2','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('ASS', 3, 6136, 'Assets', 'Product assets', 'BPROOT2', 'N',  0,  'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('ASS','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('Loans', 3100, 6136, 'Loan portfolio', 'Loan portfolio', 'ASS', 'N',  0,  'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('Loans','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('CL', 5, 6136, 'Commercial loans', 'Commercial loans', 'Loans', 'N', 0,  'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('CL','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('PL', 4, 6136, 'Personal loans', 'Personal loans', 'Loans', 'N',  0,  'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('PL','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('ML', 2, 6136, 'Mortgage loan', 'Mortgage loan', 'CL', 'N', 5, 'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('ML','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('VL', 2, 6136, 'Vehicle loan', 'Vehicle loan', 'PL', 'N',4,'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('VL','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('SL', 9, 6136, 'Student Loans', 'Student Loans', 'Loans', 'N',  0, 'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('SL','12345','N','user1','office1')

INSERT INTO fp_bankingproducts VALUES('TestAct', 3, 6136, 'Activos', 'Activos', 'BPROOT2', 'N',  0,  'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('TestAct','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('Test', 5502, 6136, 'Test', 'Test', 'Loans', 'N',  0,'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('Test','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('hipCR', 4, 6435, 'Creditos Hipotecarios', 'Hipotecarios costa rica', 'Loans', 'N', 0,  'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('hipCR','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('CORPHIP', 7, 6136, 'CREDITO HIPOTECARIO CORPORATIVO', 'Crédito hipotecario corporativo', 'Loans', 'N', 0, 'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('CORPHIP','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('pruebas1', 5700, 6136, 'pruebas', 'pruebas', 'ASS', 'N',  0, 'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('pruebas1','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('pruebas2', 5700, 6136, 'pruebas', 'pruebas', 'TestAct', 'N', 0,  'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('pruebas2','12345','N','user1','office1')
INSERT INTO fp_bankingproducts VALUES('prueba 1', 2, 6136, 'prueba 1', 'pruebas 1', 'pruebas2', 'N',  7,  'N', '2005-01-01 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
INSERT INTO fp_productauthorization VALUES ('prueba 1','12345','N','user1','office1')

insert into fp_bankingproducts  values ('CARTERA', 100, 6136, 'Cartera', 'Cartera', null, 'N',  0,  'N', '2005-05-16 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
insert into fp_productauthorization values ('CARTERA','12345','N','user1','office1')
insert into fp_bankingproducts values('CREAUTO', 2, 6136, 'CREDITO AUTOMOTRIZ', 'CREDITO AUTOMOTRIZ', 'CARTERA', 'S',  0,  'N', '2005-05-16 00:00:00.0', '2016-05-16 00:00:00.0', ' ')
insert into fp_productauthorization values ('CREAUTO','12345','N','user1','office1')

INSERT INTO fp_bankingproductshistory VALUES(1000,'2012-05-08 10:41:23.580', 'ML', '2012-02-16 00:00:00.0', 'Mortgage loan', 'Mortgage loan', 'S', '2005-01-01 10:41:23.580', '2016-05-08 10:41:23.580', ' ')
INSERT INTO fp_productauthorizationhistory VALUES (1000, '123', 'A', 'user1', 'office1','usser2', 'office2')
INSERT INTO fp_bankingproductshistory VALUES(1001,'2012-05-11 00:03:18.823', 'ML', '2012-02-16 00:00:00.0', 'Mortgage loan', 'Mortgage loan', 'S', '2005-01-01 10:41:23.580', '2016-05-08 10:41:23.580', ' ')
INSERT INTO fp_productauthorizationhistory VALUES (1001, '12345', 'A', 'user1', 'office1','usser2', 'office2')

insert into fp_bankingproductshistory VALUES(1002,'2012-05-08 10:41:23.580', 'CREAUTO', '2012-02-16 00:00:00.0', 'CREDITO AUTOMOTRIZ', 'CREDITO AUTOMOTRIZ', 'S', '2005-01-01 10:41:23.580', '2016-05-08 10:41:23.580', ' ')
insert into fp_productauthorizationhistory VALUES (1002, '123456', 'A', 'user1', 'office1','usser2', 'office2')

INSERT INTO fp_accountingprofile VALUES('ML', 'ACE', 'CCO', 1)
INSERT INTO fp_accountingprofilehistory VALUES(1001, 'ACE', 'CAMBEST', 1, '2012-02-16 00:00:00.0')
INSERT INTO fp_accountingprofilehistory VALUES(1001, 'ACE', 'PFACCOM', 2, '2012-02-16 00:00:00.0')
INSERT INTO fp_accountingprofilehistory VALUES(1001, 'DES', 'PASFAC', 1, '2012-02-16 00:00:00.0')

INSERT INTO fp_currencyproducts VALUES('0', 'Loans', 'S', 'Loans')
INSERT INTO fp_currencyproducts VALUES('0', 'CL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('0', 'PL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('0', 'ML', 'S', 'ML')
INSERT INTO fp_currencyproducts  VALUES('1', 'Loans', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('1', 'CL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('1', 'ML', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('1', 'PL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('1', 'VL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('1', 'SL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('0', 'VL', 'S', 'VL')
INSERT INTO fp_currencyproducts  VALUES('2', 'VL', 'S', 'VL')
INSERT INTO fp_currencyproducts  VALUES('4', 'Loans', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('4', 'CL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('4', 'ML', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('4', 'PL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('4', 'VL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('4', 'SL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('0123', 'SL', 'N', 'SL')
INSERT INTO fp_currencyproducts  VALUES('0', 'SL', 'S', 'SL')
INSERT INTO fp_currencyproducts  VALUES('3', 'SL', 'S', 'SL')
INSERT INTO fp_currencyproducts  VALUES('17', 'Loans', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('17', 'CL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('17', 'ML', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('17', 'PL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('17', 'VL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('17', 'SL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('23', 'Loans', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('23', 'CL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('23', 'ML', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('23', 'PL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('23', 'VL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('23', 'SL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('22', 'Loans', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('22', 'CL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('22', 'ML', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('22', 'PL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('22', 'VL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('22', 'SL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('3', 'Loans', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('3', 'CL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('3', 'ML', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('3', 'PL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('3', 'VL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('24', 'Loans', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('24', 'CL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('24', 'ML', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('24', 'PL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('24', 'VL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('24', 'SL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('5', 'ML', 'S', 'ML')
INSERT INTO fp_currencyproducts  VALUES('6', 'ML', 'S', 'ML')
INSERT INTO fp_currencyproducts  VALUES('11', 'Loans', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('11', 'CL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('11', 'ML', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('11', 'PL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('11', 'VL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('11', 'SL', 'N', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('39', 'Loans', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('39', 'CL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('39', 'ML', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('39', 'PL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('39', 'VL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('39', 'SL', 'S', 'Loans')
INSERT INTO fp_currencyproducts  VALUES('7', 'VL', 'N', 'VL')
INSERT INTO fp_currencyproductshistory VALUES(1000, '0', '2012-02-16 00:00:00.0', 'N', 'ML')
INSERT INTO fp_currencyproductshistory  VALUES(1001, '0', '2012-02-16 00:00:00.0', 'N', 'ML')
INSERT INTO fp_currencyproductshistory VALUES(1000, '1', '2012-02-16 00:00:00.0', 'S', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1001, '1', '2012-02-16 00:00:00.0', 'S', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1000, '17', '2012-02-16 00:00:00.0', 'N', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1001, '17', '2012-02-16 00:00:00.0', 'N', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1000, '22', '2012-02-16 00:00:00.0', 'N', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1001, '22', '2012-02-16 00:00:00.0', 'N', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1000, '23', '2012-02-16 00:00:00.0', 'N', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1001, '23', '2012-02-16 00:00:00.0', 'N', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1000, '24', '2012-02-16 00:00:00.0', 'S', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1001, '24', '2012-02-16 00:00:00.0', 'S', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1000, '3', '2012-02-16 00:00:00.0', 'N', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1001, '3', '2012-02-16 00:00:00.0', 'N', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1000, '4', '2012-02-16 00:00:00.0', 'S', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1001, '4', '2012-02-16 00:00:00.0', 'S', 'Loans')
INSERT INTO fp_currencyproductshistory VALUES(1001, '5', '2012-02-16 00:00:00.0', 'S', 'ML')
INSERT INTO fp_currencyproductshistory VALUES(1001, '6', '2012-02-16 00:00:00.0', 'S', 'ML')

INSERT INTO fp_policiesbyproduct VALUES(22, 'ML', '6', 'Test Unit 22', 'ML')
INSERT INTO fp_policiesbyproduct VALUES(24, 'ML', '6', 'Test Unit 24', 'ML')
INSERT INTO fp_policiesbyproduct VALUES(104, 'CL', '1', 'Test Unit 104', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(104, 'Loans', '1', 'Test Unit 104', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(104, 'ML', '1', 'Test Unit 104', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(104, 'PL', '1', 'Test Unit 104', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(104, 'SL', '1', 'Test Unit 104', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(104, 'VL', '1', 'Test Unit 104', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(106, 'CL', '1', 'Test Unit 106', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(106, 'Loans', '1', 'Test Unit 106', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(106, 'ML', '1', 'Test Unit 106', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(106, 'PL', '1', 'Test Unit 106', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(106, 'SL', '1', 'Test Unit 106', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(106, 'VL', '1', 'Test Unit 106', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(1064, 'CL', '4', 'TIPO DE DIVIDENDO', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(1064, 'Loans', '4', 'TIPO DE DIVIDENDO', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(1064, 'ML', '4', 'TIPO DE DIVIDENDO', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(1064, 'PL', '4', 'TIPO DE DIVIDENDO', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(1064, 'SL', '4', 'TIPO DE DIVIDENDO', 'Loans')
INSERT INTO fp_policiesbyproduct VALUES(1064, 'VL', '4', 'TIPO DE DIVIDENDO', 'Loans')

INSERT INTO fp_policiesbyproducthistory VALUES(22, '6', 1001, '2012-02-16 00:00:00.0', 'ML', 'Test Unit 22')
INSERT INTO fp_policiesbyproducthistory VALUES(24, '6', 1001, '2012-02-16 00:00:00.0', 'ML', 'Test Unit 24')
INSERT INTO fp_policiesbyproducthistory VALUES(104, '1', 1000, '2012-02-16 00:00:00.0', 'Loans', 'Test Unit 104')
INSERT INTO fp_policiesbyproducthistory VALUES(104, '1', 1001, '2012-02-16 00:00:00.0', 'Loans', 'Test Unit 104')
INSERT INTO fp_policiesbyproducthistory VALUES(106, '1', 1000, '2012-02-16 00:00:00.0', 'Loans', 'Test Unit 106')
INSERT INTO fp_policiesbyproducthistory VALUES(106, '1', 1001, '2012-02-16 00:00:00.0', 'Loans', 'Test Unit 106')
INSERT INTO fp_policiesbyproducthistory VALUES(1064, '4', 1000, '2012-02-16 00:00:00.0', 'Loans', 'TIPO DE DIVIDENDO')
INSERT INTO fp_policiesbyproducthistory VALUES(1064, '4', 1001, '2012-02-16 00:00:00.0', 'Loans', 'TIPO DE DIVIDENDO')

INSERT INTO fp_diccompanyproducttype VALUES(6136, 3100, 'PG', 'Loans Dictionary', 'Loans Dictionary', null)
INSERT INTO fp_diccompanyproducttype VALUES(6136, 3100, 'R ', 'Loans Items Dictionary', 'Loans Items Dictionary', null)
INSERT INTO fp_diccompanyproducttype VALUES(6136, 3100, 'R ', 'Loans Interes Dictionary', 'Loans Interes Dictionary', null)

INSERT INTO fp_dicfunctionalitygroup VALUES(4000, 6136, 3100, 'PG', 'Loans Dictionary', 'General Parameters', 'General Parameters', 'S')
INSERT INTO fp_dicfunctionalitygroup VALUES(4001, 6136, 3100, 'R ', 'Loans Items Dictionary', 'Items', 'Items', 'S')
INSERT INTO fp_dicfunctionalitygroup VALUES(4002, 6136, 3100, 'PG', 'Loans Dictionary', 'Amortization table parameters', 'amortization table parameters', 'S')
INSERT INTO fp_dicfunctionalitygroup VALUES(4100, 6136, 3100, 'PG', 'Loans Dictionary', 'Payment parameters', 'payment parameters', 'S')


INSERT INTO fp_dictionaryfields VALUES(3800, 4000, 'Class Operation', 'Class Operation', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3801, 4000, 'Allows Renovation?', 'Allows Renovation?', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3802, 4000, 'Source of funds', 'Source of funds', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3803, 4001, 'Periodicity', 'Periodicity', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3804, 4000, 'Funds', 'Funds', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3805, 4002, 'Calculation Base', 'Calculation Base', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3806, 4002, 'Days for interest calculation', 'Days for interest calculation', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3807, 4002, 'Payments to Date Set?', 'Payments to Date Set?', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3808, 4002, 'Payday', 'Payday', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3809, 4002, 'Type amortization', 'Type amortization', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3810, 4002, 'Rate change', 'Rate change', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3811, 4002, 'Period of rate change', 'Period of rate change', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3900, 4002, 'Effect rate change', 'Effect rate change', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3901, 4100, 'Payment Type', 'Payment Type', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3902, 4100, 'Effect extra payment', 'Effect extra payment', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3903, 4100, 'Method of payment', 'Method of payment', 'Integer','S', 'S','S','N','N','N')
INSERT INTO fp_dictionaryfields VALUES(3904, 4100, 'Interest payment method', 'Interest payment method', 'Integer','S', 'S','S','N','N','N')


INSERT INTO fp_generalparametershistory VALUES(1000, 3800, '2012-02-16 00:00:00.0', 'A', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3801, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3802, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3804, '2012-02-16 00:00:00.0', 'PROPIOS', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3805, '2012-02-16 00:00:00.0', 'R', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3806, '2012-02-16 00:00:00.0', '365', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3807, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3808, '2012-02-16 00:00:00.0', '15', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3809, '2012-02-16 00:00:00.0', 'FRANCESA', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3810, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3900, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3901, '2012-02-16 00:00:00.0', 'P', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3902, '2012-02-16 00:00:00.0', 'C', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3903, '2012-02-16 00:00:00.0', 'D', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1000, 3904, '2012-02-16 00:00:00.0', 'A', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3800, '2012-02-16 00:00:00.0', 'A', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3801, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3802, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3804, '2012-02-16 00:00:00.0', 'PROPIOS', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3805, '2012-02-16 00:00:00.0', 'R', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3806, '2012-02-16 00:00:00.0', '365', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3807, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3808, '2012-02-16 00:00:00.0', '15', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3809, '2012-02-16 00:00:00.0', 'FRANCESA', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3810, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3900, '2012-02-16 00:00:00.0', 'S', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3901, '2012-02-16 00:00:00.0', 'P', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3902, '2012-02-16 00:00:00.0', 'C', 'ML', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3903, '2012-02-16 00:00:00.0', 'D', 'Loans', 0, NULL, NULL)
INSERT INTO fp_generalparametershistory VALUES(1001, 3904, '2012-02-16 00:00:00.0', 'A', 'ML', 0, NULL, NULL)


INSERT INTO fp_generalparametersvalues VALUES(3800, 'ML', 'A', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3800, 'VL', 'A', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3801, 'ML', 'S', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3801, 'VL', 'S', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3802, 'ML', 'S', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3802, 'VL', 'S', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3804, 'ML', 'PROPIOS', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3804, 'VL', 'PROPIOS', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3805, 'ML', 'R', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3805, 'VL', 'R', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3806, 'ML', '365', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3806, 'VL', '365', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3807, 'ML', 'S', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3807, 'VL', 'N', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3808, 'ML', '15', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3809, 'ML', 'FRANCESA', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3809, 'VL', 'FRANCESA', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3810, 'ML', 'S', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3810, 'VL', 'S', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3811, 'VL', '2', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3900, 'ML', 'S', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3900, 'VL', 'S', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3901, 'ML', 'P', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3901, 'VL', 'A', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3902, 'ML', 'C', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3902, 'VL', 'C', 'VL', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'CL', 'D', 'Loans', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'CORPHIP', 'D', 'Loans', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'Loans', 'D', 'Loans', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'ML', 'D', 'Loans', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'PL', 'D', 'Loans', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'SL', 'D', 'Loans', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'Test', 'D', 'Loans', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'VL', 'D', 'Loans', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3903, 'hipCR', 'D', 'Loans', 0, NULL, NULL)
INSERT INTO fp_generalparametersvalues VALUES(3904, 'ML', 'A', 'ML', 0, ' ', NULL)
INSERT INTO fp_generalparametersvalues VALUES(3904, 'VL', 'A', 'VL', 0, NULL, NULL)

INSERT INTO fp_processbyproduct VALUES ('VL', 1,1, 'ORI', 'N','N','N','')
INSERT INTO fp_processbyproduct VALUES ('VL', 1,2, 'REF', 'N','N','N','')
INSERT INTO fp_processbyproduct VALUES ('VL', 1,3,'RES', 'N','N','N','')

INSERT INTO fp_operationstatus VALUES('ML', 'D', 0, 0, 0, 0)
INSERT INTO fp_operationstatus VALUES('ML', 'M', 2, 3, 0, 0)
INSERT INTO fp_operationstatus VALUES('ML', 'O', 1, 1, 0, 0)
INSERT INTO fp_operationstatus VALUES('VL', 'D', 0, 0, 0, 0)

INSERT INTO fp_operationstatushistory VALUES(1001, 'D', 0, 0, 0, 0, '2012-02-16 00:00:00.0')
INSERT INTO fp_operationstatushistory VALUES(1000, 'D', 2, 2, 30, 180, '2012-02-16 00:00:00.0')
INSERT INTO fp_operationstatushistory VALUES(1001, 'D', 2, 2, 1, 180, '2012-02-16 00:00:00.0')
INSERT INTO fp_operationstatushistory VALUES(1000, 'M', 0, 3, 0, 0, '2012-02-16 00:00:00.0')
INSERT INTO fp_operationstatushistory VALUES(1001, 'M', 0, 3, 0, 0, '2012-02-16 00:00:00.0')
INSERT INTO fp_operationstatushistory VALUES(1000, 'M', 1, 2, 0, 0, '2012-02-16 00:00:00.0')
INSERT INTO fp_operationstatushistory VALUES(1001, 'M', 1, 2, 0, 0, '2012-02-16 00:00:00.0')
INSERT INTO fp_operationstatushistory VALUES(1000, 'O', 4, 4, 360, 99999, '2012-02-16 00:00:00.0')
INSERT INTO fp_operationstatushistory VALUES(1001, 'O', 10, 10, 1, 2, '2012-02-16 00:00:00.0')

INSERT INTO fp_items VALUES(3000,3100, 'INT-1', 'INT-1', '02', 1, 'Loans Items Dictionary')
INSERT INTO fp_items VALUES(3001,3100, 'MOR', 'MORA', '02', 2, 'Mora')
INSERT INTO fp_items VALUES(3002,3100, 'OTR', 'OTROS', '02', 3, 'Otros')
  
--INSERT INTO fp_itemsbyproduct VALUES('VL', 3000, NULL)
INSERT INTO fp_itemsbyproduct VALUES('ML', 3000, 'I')
INSERT INTO fp_itemsbyproduct VALUES('Loans', 3000, NULL)
INSERT INTO fp_itemsbyproduct VALUES('CL', 3000, NULL)
INSERT INTO fp_itemsbyproduct VALUES('PL', 3000, NULL)
INSERT INTO fp_itemsbyproduct VALUES('SL', 3000, NULL)
INSERT INTO fp_itemsbyproduct VALUES('Test', 3000, NULL)
INSERT INTO fp_itemsbyproduct VALUES('hipCR', 3000, NULL)
INSERT INTO fp_itemsbyproduct VALUES('CORPHIP', 3000, NULL)

INSERT INTO fp_itemsbyproducthistory VALUES(1001, 3000, '2012-02-16 00:00:00.0', 'I')

INSERT INTO fp_itemstatus VALUES('ML', 3000, 5, 1, 10)

--INSERT INTO fp_itemstatushistory VALUES(1001, 3000, 0, 0, 0, '2012-02-19 00:00:00.0')

INSERT INTO fp_appliesto VALUES(1, 'T', 'MONTO TOTAL         ')
INSERT INTO fp_appliesto VALUES(2, 'S', 'SALDO OPERACION     ')

INSERT INTO fp_whenapplynodetype VALUES('P  ', 'AL VENCIMIENTO')
INSERT INTO fp_whenapplynodetype VALUES('A  ', 'POR ANTICIPADO')
INSERT INTO fp_whenapplynodetype VALUES('L  ', 'EN EL DESEMBOLSO')
INSERT INTO fp_whenapplynodetype VALUES('M  ', 'MULTA OTRO CARGO')
INSERT INTO fp_whenapplynodetype VALUES('B  ', 'EN EL ABONO')
INSERT INTO fp_whenapplynodetype VALUES('T  ', 'ANTICIPADO TOTAL')

INSERT INTO fp_appliestowhenapply VALUES('A  ', 1)
INSERT INTO fp_appliestowhenapply VALUES('A  ', 2)
INSERT INTO fp_appliestowhenapply VALUES('B  ', 1)
INSERT INTO fp_appliestowhenapply VALUES('B  ', 2)
INSERT INTO fp_appliestowhenapply VALUES('L  ', 1)
INSERT INTO fp_appliestowhenapply VALUES('L  ', 2)
INSERT INTO fp_appliestowhenapply VALUES('M  ', 1)
INSERT INTO fp_appliestowhenapply VALUES('M  ', 2)
INSERT INTO fp_appliestowhenapply VALUES('P  ', 1)
INSERT INTO fp_appliestowhenapply VALUES('P  ', 2)
INSERT INTO fp_appliestowhenapply VALUES('T  ', 1)
INSERT INTO fp_appliestowhenapply VALUES('T  ', 2)



INSERT INTO fp_itemappliesway VALUES(12101, 'ML', 3000, 'P  ', 1, 0, 0, NULL, 'N')

INSERT INTO fp_itemapplieswayhistory VALUES(1001, 3000, 11901, '2012-02-16 00:00:00.0', 'P  ', 1, 0, 0, NULL, 'N')

INSERT INTO fp_itemvalues VALUES(3803, 'ML', 3000, '1')

INSERT INTO fp_itemvalueshistory VALUES(1001, 3000, 3803, '2012-02-16 00:00:00.0', '1')

INSERT INTO fp_amountitemvalues VALUES('ML', 12101, '0', NULL, NULL, '0', NULL, 'ACTAS', NULL, NULL, 0, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 'N', 0, NULL, ' ', 'N', NULL, NULL, 0, NULL, 0, NULL, 0, 1067, NULL, 'TASA DE INTERES')

INSERT INTO fp_amountitemvalueshistory VALUES(1001, 3000, 11901, '0', '2012-02-16 00:00:00.0', NULL, NULL, '0', NULL, 'ACTAS', NULL, NULL, 0, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'N', NULL, NULL, 0, NULL, 0, NULL, 0, 0, NULL, NULL)

--collection and payment types
INSERT INTO fp_diccompanyproducttype VALUES(6435, 1, 'FP ', 'Collection and Payment Types', 'Collection and Payment Types', null)

INSERT INTO fp_collectionpaymenttype VALUES('NDAHO', 'NOTA DE DEBITO AHORROS', 'NOTA DE DEBITO DE AHORROS', 'C')
INSERT INTO fp_collectionpaymenttype VALUES('NDCTE', 'NOTA DE DEBITO CORRIENTES', 'NOTA DE DEBITO DE CORREINTES', 'C')
INSERT INTO fp_collectionpaymenttype VALUES('NCAHO', 'NOTA DE CREDITO AHORROS', 'NOTA DE CREDITO DE AHORROS', 'P')

INSERT INTO fp_paymenttypefields values(100, 4000, 'ECO PRUEBA', 'PRUEBA DE ECO', 'STRING', 'S', 'S', 'S')
INSERT INTO fp_paymenttypefields values(200, 4000, 'ECO PRUEBA2', 'PRUEBA DE ECO2', 'STRING', 'S', 'S', 'S')
INSERT INTO fp_paymenttypefields values(300, 4000, 'Tipo Tarjeta','Credit Card', 'STRING', 'S', 'S', 'S')

INSERT INTO fp_paymenttypefieldsvalues values(001, 100, 'NDAHO', 'A', 'PRUEBA ECO', 'PRUEBA ECO DESCRIP', 'S')
INSERT INTO fp_paymenttypefieldsvalues values(002, 200, 'NDCTE', 'B', 'PRUEBA ECO2', 'PRUEBA ECO DESCRIP2', 'S')
INSERT INTO fp_paymenttypefieldsvalues values(003, 300, 'NDAHO', 'B', 'PRUEBA ECO3', 'PRUEBA ECO DESCRIP3', 'S')
--INSERT INTO fp_paymenttypefieldsvalues values(004, 400, 'NDAHO', 'C', 'PRUEBA ECO', 'PRUEBA ECO DESCRIP', 'S')

INSERT INTO fp_servicestransactionfield VALUES(125,4000,'prueba transfld ','prueba transfld','tipoval','S','S','S')
INSERT INTO fp_servicestransactionfield VALUES(120,4000,'prueba transfld2 ','prueba transfld2','tipoval2','S','S','S')
INSERT INTO fp_servicestransactionfield VALUES(135,4000,'prueba transfld3 ','prueba transfld3','tipoval3','S','S','S')
INSERT INTO fp_servicestransactionfield VALUES(140,4000,'prueba transfld3 ','prueba transfld3','tipoval3','S','S','S')
INSERT INTO fp_transactionfieldvalues VALUES(325,125,'Dep',3100,'S','valor campo','descripc val','N')
INSERT INTO fp_transactionfieldvalues VALUES(327,125,'Dep',3100,'S','valor campo2','descripc val2','N')
INSERT INTO fp_transactionfieldvalues VALUES(329,120,'Dep',3100,'S','valor campo3','descripc val3','N')


--asociation between bankingproducts and servicetransactions

INSERT INTO fp_servtranbankingproduct VALUES(1,'Dep',3100,'pruebas1','S')
INSERT INTO fp_servtranbankingproduct VALUES(2,'Dep',3100,'pruebas2','S')
INSERT INTO fp_servtranbankingproduct VALUES(3,'Dep2',5502,'pruebas1','S')
INSERT INTO fp_servtranbankingproduct VALUES(4,'Dep2',5502,'pruebas2','S')

INSERT INTO fp_transactionchannelsbase values(1,'Dep',3100,'ATM')
INSERT INTO fp_transactionchannelsbase values(2,'Dep',3100,'BV')
INSERT INTO fp_transactionchannelsbase values(3,'Dep2',5502,'ATM')
INSERT INTO fp_transactionchannelsbase values(4,'Dep2',5502,'BV')

insert into fp_channelpaymentsbase values(1,2,'NDAHO')
insert into fp_channelpaymentsbase values(2,2,'NDCTE')
insert into fp_channelpaymentsbase values(3,2,'NCAHO')
INSERT INTO fp_channelpaymentsbase values(4,3,'NCAHO')
insert into fp_channelpaymentsbase values(5,3,'NDCTE')
insert into fp_channelpaymentsbase values(6,4,'NCAHO')

insert into fp_transactionchannels values(1,1,'ATM')
insert into fp_transactionchannels values(2,3,'IB')

INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (1,3800,'ML','TP')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (1,3801,'ML','Filial1')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (1,3802,'ML','Clase1')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (2,3800,'ML','Filial1')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (2,3801,'ML','Filial2')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (2,3802,'ML','Clase2')


INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (5,3800,'ASS','TP')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (5,3801,'ASS','Filial1')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (5,3802,'ASS','Clase1')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (6,3800,'ASS','Filial1')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (6,3801,'ASS','Filial2')
INSERT INTO fp_unitfunctionalityvalues(registryid,dc_fields_id_fk,bp_product_id_fk,uf_value) VALUES (6,3802,'ASS','Clase2')




commit
