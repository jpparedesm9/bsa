USE cobis
GO

--Menu Prospectos en el Administrador
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=69)
   INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (69, 65, 'MNU_CUSTOMER_ADM', 1, NULL, 6, 2, 0, 'Prospectos')

IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu_role WHERE mro_id_menu=69)
BEGIN
   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (69, 1)

   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (69, 3)

   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (69, 12)
END

--Mantenimiento de Direcciones
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=33 AND me_id_parent = 69)
BEGIN
   INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (33, 69, 'MNU_ADDRESS', 1, 'views/CSTMR/CSTMR/T_ADDRESSKSQYAJ_769/1.0.0/VC_ADDRESSYWA_591769_TASK.html', 2, 2, 0, 'Mantenimiento de Direcciones')
END 

IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu_role WHERE mro_id_menu=33)
BEGIN
   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (33, 1)

   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (33, 3)

   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (33, 12)
END

--Mantenimiento de Negocio
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=31)
   INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (31, 69, 'MNU_BUSINESS', 1, 'views/CSTMR/CSTMR/T_BUSINESSFMWNQ_114/1.0.0/VC_BUSINESSPR_115114_TASK.html', 4, 2, 0, '')

IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu_role WHERE mro_id_menu=31)
BEGIN
   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (31, 1)

   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (31, 3)

   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (31, 12)
END 

--Mantenimiento de Referencias
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=32)
   INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (32, 69, 'MNU_REFERENCES', 1, 'views/CSTMR/CSTMR/T_REFERENCESOWS_647/1.0.0/VC_REFERENCSS_358647_TASK.html', 3, 2, 0, '')

IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu_role WHERE mro_id_menu=32)
BEGIN
   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (32, 1)

   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (32, 3)

   INSERT INTO dbo.cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (32, 12)
END 

--Reasignacion
update cobis..cew_menu
SET me_description ='MNU_REASIGNACION'
WHERE me_id=100

--Consulta Alerta de riesgo
update cobis..cew_menu
SET me_description ='Alertas de Riesgo View'
WHERE me_id=156

--Buzon de Tareas del oficial (oficial inbox)
update cobis..cew_menu
SET me_description ='Buzón de Tareas de Oficial'
WHERE me_id=99

--Menu Maker and Checker
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=90)
   INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (90, 65, 'MNU_MAKER_CHECKER', 1, NULL, 11, 0, 0, 'Maker and Checker')

--Transacciones de Negocio (Maker and Checker)
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=104)
   INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (104, 90, 'MNU_SEARCH_TRAN_MKCHK', 1, 'views/MKCHK/ADMWS/T_ADMWS_85_NSACG04/1.0.0/VC_NSACG04_EASAD_863_TASK.html', 1, 0, 0, 'Transacciones de Negocio')

--Gestion de reclamos
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=88)
   INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (88, 65, 'MNU_MANAGEMENT_CLAIMS', 1, NULL, 11, 1, 0, 'Gestión de Reclamos')


--Consulta de Reclamos
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=103)
   INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (103, 88, 'MNU_SEARCH_CLAIMS', 1, 'views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html', 1, 43, 0, 'Consulta de Reclamos')

--Categoria y Subcategoria
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=102)
   INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (102, 88, 'MNU_CAT_SUBCAT', 1, 'views/LATFO/CLAIM/T_CLAIM_44_AGORY85/1.0.0/VC_AGORY85_CEGOR_783_TASK.html', 1, 43, 0, 'Categorías y SubCategorías')

IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu_role WHERE mro_id_menu=102)
BEGIN
   INSERT INTO cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (102, 1)

   INSERT INTO cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (102, 3)
END 


--Alertas PDL y FT
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=139)
   INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (139, NULL, 'MNU_DOC_HISTORICAL', 1, 'views/ASSTS/QERYS/T_ASSTSNMDWVMHP_252/1.0.0/VC_CREDITDOUE_237252_TASK.html?mode=2', 0, 1, 0, 'Alertas PLD y FT')

IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu_role WHERE mro_id_menu=139)
BEGIN
   INSERT INTO cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (139, 1)

   INSERT INTO cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (139, 15)
END 


--Estado de cuenta
IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu WHERE me_id=138)
   INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
   VALUES (138, 34, 'MNU_ACCOUNT_STATUS', 1, 'views/ASSTS/TRNSC/T_ASSTSFIQJZFID_726/1.0.0/VC_ACCOUNTSSA_935726_TASK.html', 137, 7, 0, '')

IF NOT EXISTS(SELECT 1 FROM cobis..cew_menu_role WHERE mro_id_menu=138)
BEGIN
   INSERT INTO cew_menu_role (mro_id_menu, mro_id_role)
   VALUES (138, 15)
END 

--QUITAR ROL NORMATIVO A LA FUNCIONALIDAD DE MATRIZ DE RIESGO
IF EXISTS  (SELECT 1 FROM cobis..cew_resource_rol WHERE rro_id_resource = 21 AND rro_id_rol = 31)
   DELETE  cobis..cew_resource_rol WHERE rro_id_resource = 21 AND rro_id_rol = 31

GO


