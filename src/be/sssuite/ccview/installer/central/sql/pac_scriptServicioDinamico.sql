use cob_pac 
go

--==============ELIMINA DATOS DE LAS TABLAS===========

if exists (SELECT 1
           FROM  INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'fk_vcc_prod_reference_vcc_pro_')
    alter table  vcc_product_admin
       drop constraint fk_vcc_prod_reference_vcc_pro_
go       
       
       
delete from vcc_properties
delete from vcc_pro_admin_default
delete from vcc_dtos
delete from vcc_services

go

--ALTER TABLE vcc_pro_admin_default ALTER COLUMN  prd_mnemonic VARCHAR(7)

alter table vcc_product_admin
    add constraint fk_vcc_prod_reference_vcc_pro_  foreign key (prd_id)
    references vcc_pro_admin_default (prd_id)

go

--===============SERVICIOS============================

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('Contingentes', 'servicesContingentes')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('Deudas', 'servicesDeudas')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('Garantias', 'servicesGarantias')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('OtrosProductos', 'servicesOtrosProductos')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('Pasivas', 'servicesPasivas')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('RiessIndirectos', 'servicesRiessIndirectos')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('clientviewer/ProductsService/getOperationGuarantees', 'ServicioOperacionGarantias')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('InformacionCliente', 'InformacionCliente')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('PhoneTxService/executeGetPhoneAddress', 'Servicio Teléfonos')

INSERT INTO vcc_services (ser_id, ser_description)
VALUES ('PasivasHis', 'servicesPasivasHis')

GO

--================DTOS==================================


INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (1, 'Deudas', 'debtsLoans', 'CLIENTVIEWER.LABELS.LBL_OPTION_PAYABLES', 'Deudas', NULL, 1, 'DEUD', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (2, 'Deudas', 'debtsSource', 'CLIENTVIEWER.LABELS.LBL_OPTION_PAYABLES', 'Deudas', NULL, 1, NULL, 1)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (3, 'Garantias', 'warranties', 'CLIENTVIEWER.LABELS.LBL_OPTION_GUARANTEES', 'Garantías', NULL, 1, 'GARA', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (4, 'Pasivas', 'currentAccounts', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_CHECKINGACCOUNTS', 'Pasivas', NULL, 1, NULL, 2)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (5, 'Garantias', 'productsPromissoryNotePending', 'CLIENTVIEWER.LABELS.LBL_PROMISSORY_NOTES', 'PromissoryNotes', NULL, 1, 'GARA', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (6, 'Pasivas', 'savingAccounts', 'CLIENTVIEWER.LABELS.LBL_SAVING_ACCOUNT', 'Pasivas', NULL, 1, NULL, 1)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (7, 'Pasivas', 'fixedTerms', 'CLIENTVIEWER.LABELS.LBL_FIXED_TERMS_', 'Pasivas', NULL, 1, NULL, 3)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (8, 'Contingentes', 'credits', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Contingentes Lineas de Credito', NULL, 1, 'CONT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (9, 'Contingentes', 'contingencies', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Contingentes', NULL, 1, 'CONT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (10, 'RiessIndirectos', 'indirectPortfolio', 'CLIENTVIEWER.LABELS.LBL_INDIRECT_RIESS', 'RiessIndirectos', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (11, 'OtrosProductos', 'productsOtherComext', 'CLIENTVIEWER.LABELS.LBL_OTHER_PRODUCTS_COMEX', 'Otros Productos COMEX', NULL, 1, 'CONT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (12, 'OtrosProductos', 'productsApplicationLoans', 'CLIENTVIEWER.LABELS.LBL_OTHER_PRODUCTS_CREDITS', 'Otros Productos Créditos', NULL, 1, 'OPSE', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (13, 'OtrosProductos', 'productsCreditsPendings', 'CLIENTVIEWER.LABELS.LBL_PENDING_CREDITS', 'Creditos Pendientes', NULL, 1, 'OPSE', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (14, 'OtrosProductos', 'productsPendingGuaranties', 'CLIENTVIEWER.LABELS.LBL_PENDING_WARRANTIES', 'Garantías Pendientes', NULL, 1, 'OPSE', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (15, 'OtrosProductos', 'productsPromissoryNotePending', 'CLIENTVIEWER.LABELS.LBL_SIGHTED_PENDING_NOTES', 'Notas Previsorias Pendientes', NULL, 1, 'OPSE', 5)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (16, 'Pasivas', 'liabilitiesSource', 'CLIENTVIEWER.LABELS.LBL_OPTION_LIABILITIES', 'Pasivas', NULL, 1, NULL, 4)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (17, 'Garantias', 'guaranteesSource', 'CLIENTVIEWER.LABELS.LBL_OPTION_GUARANTEES', 'Garantias', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (18, 'Contingentes', 'contingentsSource', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Contingentes', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (19, 'RiessIndirectos', 'IndirectPortfolioSource', 'CLIENTVIEWER.LABELS.LBL_INDIRECTS', 'Indirectos', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (20, 'clientviewer/ProductsService/getOperationGuarantees', 'returnOperationGuaranteesResponse', 'CLIENTVIEWER.LABELS.LBL_WARRANTIES_OPERATION', 'Operacion por Garantias', 3, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (21, 'Contingentes', 'creditCardData', 'CLIENTVIEWER.LABELS.LBL_CREDIT_CARD', 'Tarjeta de Crédito', NULL, 1, 'CRDCARD', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (22, 'OtrosProductos', 'debitCardData', 'CLIENTVIEWER.LABELS.LBL_DEBIT_CARD', 'Tarjeta de Débito', NULL, 1, 'CONT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (23, 'InformacionCliente', 'clientGeneralData', 'CLIENTVIEWER.LABELS.LBL_PERSONAL_DATA', 'Datos Personales Cliente', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (24, 'InformacionCliente', 'clientAdditionalData', 'CLIENTVIEWER.LABELS.LBL_OTHER_INFORMATION', 'Información Adicional Empresar', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (25, 'InformacionCliente', 'clientAcademicData', 'CLIENTVIEWER.LABELS.LBL_ACADEMIC_DATA', 'Datos Academicos Cliente', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (26, 'InformacionCliente', 'maxDebtRequest', 'CLIENTVIEWER.LABELS.LBL_TAB_MAXIMUN_DEBTS', 'Información Maximo Endeudamiento', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (27, 'InformacionCliente', 'clientCompanyData', 'CLIENTVIEWER.LABELS.LBL_COMPANY_DATA', 'Información Empresar', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (28, 'InformacionCliente', 'clientOtherInformation', 'CLIENTVIEWER.LABELS.LBL_OTHER_INFORMATION', 'Otra Información', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (29, 'InformacionCliente', 'economicActivityDataSource', 'CLIENTVIEWER.LABELS.LBL_ACTIVITY', 'Actividad Económica', NULL, 0, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (30, 'InformacionCliente', 'dataSourceGroup', 'CLIENTVIEWER.LABELS.LBL_MEMBERS', 'Miembros del Grupo', NULL, 0, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (31, 'PhoneTxService/executeGetPhoneAddress', 'seriesPhone', 'CLIENTVIEWER.LABELS.LBL_PHONES', 'Teléfonos Direcciones', 33, 0, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (32, 'OtrosProductos', 'customerLinked', 'CLIENTVIEWER.LABELS.LBL_FIENET', 'FIENET', NULL, NULL, 'CUSTLK', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (33, 'InformacionCliente', 'seriesDirections', 'ADDRESS.LABELS.LBL_ADDRESS', 'Direcciónes Cliente', NULL, 0, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (34, 'InformacionCliente', 'seriesEmails', 'ADDRESS.LABELS.LBL_EMAILS', 'Correos Electrónicos', NULL, 0, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (35, 'InformacionCliente', 'seriesContact', 'ADDRESS.LABELS.LBL_CONTACTS', 'Contactos', NULL, 0, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (36, 'InformacionCliente', 'otherInformationCompany', 'CLIENTVIEWER.LABELS.LBL_OTHER_INFORMATION', 'Otra información Empresas', NULL, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (37, 'OtrosProductos', 'affiliations', 'CLIENTVIEWER.LABELS.LBL_AFFILIATION', 'Afiliaciones', NULL, 1, 'OPSE', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (38, 'OtrosProductos', 'drafts', 'CLIENTVIEWER.LABELS.LBL_DRAFTS', 'Giros Enviados', NULL, 1, 'DRAFT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (39, 'OtrosProductos', 'transfers', 'CLIENTVIEWER.LABELS.LBL_TRANSFERS', 'Transferencias', NULL, 1, 'TRANSF', NULL)

INSERT INTO vcc_dtos ( dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order ) 
VALUES (40, 'PasivasHis', 'savingAccountsHis', 'CLIENTVIEWER.LABELS.LBL_SAVING_ACCOUNT', 'Cuentas de Ahorro', NULL, 1, 'AHO', 1 ) 

INSERT INTO vcc_dtos ( dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order ) 
VALUES (41, 'PasivasHis', 'currentAccountsHis', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_CHECKINGACCOUNTS', 'Cuentas Corrientes', NULL, 1, 'CTE', 2 ) 

INSERT INTO vcc_dtos ( dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order ) 
VALUES (42, 'PasivasHis', 'fixedTermsHis', 'CLIENTVIEWER.LABELS.LBL_FIXED_TERMS_', 'Plazo Fijo', NULL, 1, 'PFI', 3 ) 

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (43, 'OtrosProductos', 'debitCardDataHis', 'CLIENTVIEWER.LABELS.LBL_DEBIT_CARD', 'Tarjeta de Débito', NULL, 1, 'DEBCARD', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (44, 'OtrosProductos', 'customerLinkedHis', 'CLIENTVIEWER.LABELS.LBL_FIENET', 'FIENET', NULL, NULL, 'CUSTLK', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (45, 'OtrosProductos', 'debtsLoansHist', 'CLIENTVIEWER.LABELS.LBL_OPTION_PAYABLES', 'Histórico Deudas', NULL, NULL, 'DEUHIS', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (46, 'Contingentes', 'creditsHist', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Contingentes Lineas de Credito', NULL, 1, 'CONT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (47, 'Contingentes', 'contingenciesHist', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Contingentes', NULL, 1, 'CONT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (48, 'Contingentes', 'productsOtherComextHist', 'CLIENTVIEWER.LABELS.LBL_OTHER_PRODUCTS_COMEX', 'Otros Productos COMEX', NULL, 1, 'CONT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (49, 'RiessIndirectos', 'indirectPortfolioHis', 'CLIENTVIEWER.LABELS.LBL_INDIRECT_RIESS', 'Indirectos', NULL, 1, 'INDHIS', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (50, 'Garantias', 'warrantiesHis', 'CLIENTVIEWER.LABELS.LBL_OPTION_GUARANTEES', 'Garantías', NULL, 1, 'GARAH', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (51, 'Garantias', 'promissoryNotesHis', 'CLIENTVIEWER.LABELS.LBL_PROMISSORY_NOTES', 'PromissoryNotes', NULL, 1, 'GARAH', NULL)

INSERT INTO cob_pac..vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (52, 'clientviewer/ProductsService/getOperationGuarantees', 'returnOperationGuaranteesResponse', 'CLIENTVIEWER.LABELS.LBL_WARRANTIES_OPERATION', 'Operacion por Garantias Histórico', 50, 1, NULL, NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (53, 'OtrosProductos', 'inProgresRequest', 'CLIENTVIEWER.LABELS.LBL_IN_PROGRESS_REQUEST', 'Solicitudes en Curso', NULL, 1, 'OPSE', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (54, 'OtrosProductos', 'remittances', 'CLIENTVIEWER.LABELS.LBL_REMITTANCES', 'Remesas', NULL, 1, 'REMT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (55, 'OtrosProductos', 'requestRejected', 'CLIENTVIEWER.LABELS.LBL_REJECTED_REQUEST', 'Solicitudes Rechazadas', null, null, 'DEUHIS', null)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (56, 'Contingentes', 'otherComext', 'CLIENTVIEWER.LABELS.LBL_OTHERS', 'others', NULL, 1, 'CONT', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (57, 'Deudas', 'creditCardDataDeudas',  'CLIENTVIEWER.LABELS.LBL_CREDIT_CARD', 'Tarjeta de Crédito', NULL, 1,  'DEUDCARD', NULL)

INSERT INTO vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (58,'InformacionCliente','seriesDirectionsMain','ADDRESS.LABELS.LBL_ADDRESS_PRINCIPAL_MAIN','Direcciones del miembro principal GE',null,0,null,null)

INSERT INTO cob_pac..vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (59, 'PhoneTxService/executeGetPhoneAddress', 'seriesPhone', 'CLIENTVIEWER.LABELS.LBL_PHONES', 'Teléfonos Direcciones miembro principal GE', 58, 0, NULL, NULL)

INSERT INTO cob_pac..vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (60, 'OtrosProductos', 'draftsIn', 'CLIENTVIEWER.LABELS.LBL_DRAFTS_IN', 'Giros Recibidos', NULL, 1, 'DRAFTIN', NULL)


GO

--================VCC_PRO_ADMIN_DEFAULT=================


INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (0, NULL, 'ROOT', 'VCC ADMIN', 'Administrador de Secciones', -1, 'PR', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (1, 2, 'DEUD', 'CLIENTVIEWER.LABELS.LBL_OPTION_PAYABLES', 'Operaciones de los productos que generan deuda/ries para el cliente', 0, NULL, 1)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (2, 16, 'PASI', 'CLIENTVIEWER.LABELS.LBL_OPTION_LIABILITIES', 'Operaciones pasivas del cliente', 0, NULL, 2)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (3, 17, 'GARA', 'CLIENTVIEWER.LABELS.LBL_OPTION_GUARANTEES', 'Garantías', 0, NULL, 3)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (4, 18, 'CONT', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Operaciones que a corto plazo implican una posible deuda con la Institución', 0, NULL, 4)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (5, 19, 'INDI', 'CLIENTVIEWER.LABELS.LBL_OPTION_INDIRECT', 'Operaciones donde el cliente es garante personal o fiador de otro cliente', 0, NULL, 5)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (6, NULL, 'OPSE', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_SERVICES_PRODUCTS', 'Operaciones o servicios del cliente que no dignifican una deuda o ries', 0, NULL, 6)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (7, NULL, 'SOB', 'CLIENTVIEWER.LABELS.LBL_OVERDRAFT_USED', 'Vigentes y Vencidos', 1, NULL, 1)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (8, 1, 'CCA', 'CLIENTVIEWER.LABELS.LBL_OPTION_LOANS', 'Vigentes y Vencidos', 1, NULL, 2)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (9, 4, 'CTE', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_CHECKINGACCOUNTS', 'Cuentas Corrientes', 2, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (10, 6, 'AHO', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_SAVINGACOUNT', 'Cuentas de Ahorro', 2, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (11, 7, 'PFI', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_FIXTERM', 'Depósitos a Plazo Fijo', 2, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (12, 5, 'GAR', 'CLIENTVIEWER.LABELS.LBL_OPTION_COLLATERAL_ASSOCIATED_LOANS', 'Garantías Asociadas a Préstamos', 3, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (13, 3, 'GARC', 'CLIENTVIEWER.LABELS.LBL_OPTION_CLIENT_COLLATERAL', 'Garantías del Cliente', 3, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (14, 8, 'CRE', 'CLIENTVIEWER.LABELS.LBL_OPTION_CREDIT_LINES', 'Líneas de Crédito', 4, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (15, 9, 'CEX', 'CLIENTVIEWER.LABELS.LBL_TRADE_FINANCE_CREDITS', 'Contingentes de Comercio Exterior', 4, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (16, 10, 'ICCA', 'CLIENTVIEWER.LABELS.LBL_TRADE_INDIRECT_LOANS', 'Préstamos donde el cliente es garante', 5, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (17, 37, 'GLOB', 'GlobalNet', 'GlobalNet', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (18, NULL, 'CEXA', 'CLIENTVIEWER.LABELS.LBL_APPROVAL_TRADE_FINANCE', 'Contingentes de CEX en Aprobación', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (19, 12, 'PRAP', 'CLIENTVIEWER.LABELS.LBL_APPROVAL_LOANS', 'Préstamos en Aprobación', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (20, 13, 'LCAP', 'CLIENTVIEWER.LABELS.LBL_APPROVAL_CREDIT_LINE', 'Líneas de Crédito en Aprobación', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (21, 14, 'GAPP', 'CLIENTVIEWER.LABELS.LBL_GUARRANTEES_LOANS', 'Garantías Asociadas a Préstamos Pendientes', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (22, 15, 'GDCP', 'CLIENTVIEWER.LABELS.LBL_GUARRANTEES_PENDINS', 'Garantías del Cliente Pendientes', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (23, 11, 'SCEX', 'CLIENTVIEWER.LABELS.LBL_CEX_SERVICE', 'Servicios de CEX', 4, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (24, 21, 'TCRE', 'CLIENTVIEWER.LABELS.LBL_CREDIT_CARD', 'Tarjetas de Crédito', 4, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (25, 22, 'TDEB', 'CLIENTVIEWER.LABELS.LBL_DEBIT_CARD', 'Tarjetas de Débito', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (26, NULL, 'ROOT', 'VCC CLIENT', 'Administrador de Clientes', -1, 'CL', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (27, NULL, 'DATPE', 'CLIENTVIEWER.LABELS.LBL_PERSONAL_DATA', 'Datos Personales', 26, 'P', 4)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (28, 23, 'DATIN', 'CLIENTVIEWER.LABELS.LBL_OPTION_PERSONAL_DATA', 'Datos Personales', 27, 'P', 1)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (29, 25, 'DATAC', 'CLIENTVIEWER.LABELS.LBL_OPTION_ACADEMIC_DATA', 'Datos Academicos', 27, 'P', 2)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (30, NULL, 'OTR', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHER_INFORMATION', 'Otra Información', 26, 'P', 3)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (31, 28, 'OTRDA', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHER_INFORMATION', 'Otra Información', 27, 'P', 3)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (32, 26, 'MAXEN', 'CLIENTVIEWER.LABELS.LBL_TAB_MAXIMUN_DEBTS', 'Máximo Endeudamiento', 30, 'P', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (33, NULL, 'COMPD', 'CLIENTVIEWER.LABELS.LBL_OPTION_COMPANY', 'Información Empresa', 26, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (34, 27, 'DATEM', 'CLIENTVIEWER.LABELS.LBL_OPTION_COMPANY_DATA', 'Datos de empresa', 33, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (35, 24, 'OTROD', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHER_INFORMATION', 'otra Información de Empresa', 33, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (36, 33, 'DIREC', 'ADDRESS.LABELS.LBL_ADDRESS', 'Direccion Clientes', 30, 'P', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (37, 24, 'OTROI', 'CLIENTVIEWER.LABELS.LBL_OPTION_COMPANY_INFO', 'otra Información de Empresa', 35, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (38, 30, 'ACTIV', 'CLIENTVIEWER.LABELS.LBL_ACTIVITY', 'Actividad', 30, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (39, NULL, 'GRPEC', 'CLIENTVIEWER.LABELS.LBL_TAB_MAXIMUN_DEBTS', 'Endeudamiento Máximo Grupo Económico', 26, 'G', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (40, 26, 'GRPEM', 'CLIENTVIEWER.LABELS.LBL_TAB_MAXIMUN_DEBTS', 'Endeudamiento Máximo Grupo Económico', 39, 'G', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (41, NULL, 'GRPAC', 'CLIENTVIEWER.LABELS.LBL_MEMBERS', 'Miembros de Grupo', 26, 'G', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (42, 32, 'FIEN', 'CLIENTVIEWER.LABELS.LBL_FIENET', 'FIENET', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (43, NULL, 'GRPMB', 'CLIENTVIEWER.LABELS.LBL_MEMBERS', 'Miembros', 39, 'G', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (44, 30, 'GRPMD', 'CLIENTVIEWER.LABELS.LBL_MEMBERS', 'Miembros de Grupo', 41, 'G', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (45, 29, 'ACTEC', 'CLIENTVIEWER.LABELS.LBL_SECTOR_ACTIVITY', 'Actividad Económica', 55, 'P', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (46, 34, 'EMAIL', 'ADDRESS.LABELS.LBL_EMAILS', 'Correos Electrónicos', 30, 'P', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (47, 35, 'CONTA', 'ADDRESS.LABELS.LBL_CONTACTS', 'Contáctos', 30, 'P', 5)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (48, 30, 'ACTIV', 'CLIENTVIEWER.LABELS.LBL_SECTOR_ACTIVITY', 'Actividad', 54, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (49, 33, 'DIRC', 'ADDRESS.LABELS.LBL_ADDRESS', 'Direccion Clientes', 54, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (50, 34, 'EMAIL', 'ADDRESS.LABELS.LBL_EMAILS', 'Correos Electrónicos', 54, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (51, 35, 'CONTA', 'ADDRESS.LABELS.LBL_CONTACTS', 'Contáctos', 54, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (52, 38, 'DRAFT', 'CLIENTVIEWER.LABELS.LBL_DRAFTS', 'Giros', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (53, 39, 'TRNSF', 'CLIENTVIEWER.LABELS.LBL_TRANSFERS', 'Transferencias', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (54, NULL, 'OTRDA', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHER_INFORMATION', 'Otra Información', 26, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (55, NULL, 'ACT', 'CLIENTVIEWER.LABELS.LBL_ECONOMIC_ACTIVITY', 'Actividad Económica', 26, 'P', 2)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (56, 29, 'FDBT', 'FDBT', 'PRUEBA', 39, 'G', 12)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (57, NULL, 'ROOT', 'VCC HISTORY', 'Administrador de Clientes', -1, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (58, NULL, 'PAS_H', 'CLIENTVIEWER.LABELS.LBL_OPTION_LIABILITIES', 'Operaciones pasivas del cliente', 57, NULL, 2)

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (59, 40, 'CTE_H', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_CHECKINGACCOUNTS', 'Cuentas Corrientes', 58, NULL, NULL ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (60, 41, 'AHO_H', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_SAVINGACOUNT', 'Cuentas de Ahorro', 58, NULL, NULL ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (61, 42, 'PFI_H', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_FIXTERM', 'Depósitos a Plazo Fijo', 58, NULL, NULL ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (62, NULL, 'OPSEH', 'CLIENTVIEWER.LABELS.LBL_OPTION_OTHERS_SERVICES_PRODUCTS', 'Operaciones o servicios del cliente que no significan una deuda o ries', 57, NULL, 6 )

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (63, 43, 'TDEBH', 'CLIENTVIEWER.LABELS.LBL_DEBIT_CARD', 'Tarjetas de Débito', 62, NULL, 1 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (64, 44, 'FIENH', 'CLIENTVIEWER.LABELS.LBL_FIENET', 'FIENET', 62, NULL, 2 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (65, NULL, 'DEUDH', 'CLIENTVIEWER.LABELS.LBL_OPTION_PAYABLES', 'Histórico Deudas', 57, NULL, 1 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (66, 45, 'DHIST', 'CLIENTVIEWER.LABELS.LBL_OPTION_PAYABLES', 'Histórico Deudas', 65, NULL, 1 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (67, NULL, 'CONTH', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Histórico Contingentes', 57, NULL, 3 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (68, 46, 'CRHIST', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Histórico Contingentes', 67, NULL, 1 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (69, 47, 'CHIST', 'CLIENTVIEWER.LABELS.LBL_OPTION_CONTINGENCY', 'Histórico Contingentes', 67, NULL, 1 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (70, 48, 'OPHIST', 'CLIENTVIEWER.LABELS.LBL_OTHER_PRODUCTS_COMEX', 'Histórico Contingentes', 67, NULL, 1 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (71, NULL, 'INDH', 'CLIENTVIEWER.LABELS.LBL_OPTION_INDIRECT', 'Histórico Indirectos', 57, NULL, 5 ) 

INSERT INTO vcc_pro_admin_default ( prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order ) 
VALUES (72, 49, 'INDPRH', 'CLIENTVIEWER.LABELS.LBL_TRADE_INDIRECT_LOANS', 'Préstamos donde el cliente es garante', 71, NULL, 1 ) 

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (73, NULL, 'GARAH', 'CLIENTVIEWER.LABELS.LBL_OPTION_GUARANTEES', 'Garantías', 57, NULL, 4)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (74, 50, 'GAR', 'CLIENTVIEWER.LABELS.LBL_OPTION_COLLATERAL_ASSOCIATED_LOANS', 'Garantías Asociadas a Préstamos', 73, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (75, 51, 'GARC', 'CLIENTVIEWER.LABELS.LBL_OPTION_CLIENT_COLLATERAL', 'Garantías del Cliente', 73, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (76, 53, 'SOLC', 'CLIENTVIEWER.LABELS.LBL_IN_PROGRESS_REQUEST', 'Solicitudes en Curso', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (77, 54, 'REMT', 'CLIENTVIEWER.LABELS.LBL_REMITTANCE', 'Remesas', 6, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (78, 55, 'REJEC', 'CLIENTVIEWER.LABELS.LBL_REJECTED_REQUEST', 'Solicitudes Rechazadas', 65, NULL, 2)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (79, 56, 'OTHERS', 'CLIENTVIEWER.LABELS.LBL_OTHER_COMEXT', 'Otros Comext', 4, NULL, NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
VALUES (80, 26, 'PJXEN', 'CLIENTVIEWER.LABELS.LBL_TAB_MAXIMUN_DEBTS', 'Máximo Endeudamiento Juridica', 54, 'C', NULL)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
values (81,  57,  'TARJ',  'CLIENTVIEWER.LABELS.LBL_OPTION_TARJETAS',  'Información de Tarjetas', 1.0,  null,  3)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
values (82,  null ,  'OTRGE',  'CLIENTVIEWER.LABELS.LBL_OPTION_OTHER_INFORMATION',  'Otra Información', 26,  'G',  3)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
values (83,  58 ,  'DIRGE',  'ADDRESS.LABELS.LBL_ADDRESS_PRINCIPAL_MAIN',  'Direcciones Representante Principal Grupo Económico', 82,  'G',  1)

INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
values (84,  60 ,  'DRFIN',  'CLIENTVIEWER.LABELS.LBL_DRAFTS_IN',  'Giros Recibidos', 6,  null,  null)


GO


--=====================PROPERTIES============================================================

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (1, 1, 'operationType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 1, 1, 0, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (2, 1, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (3, 1, 'descriptionType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_DESCRIPTION', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (4, 1, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_CREDIT_NUMBER', 1, 1, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (5, 1, 'originalAmount', 'CLIENTVIEWER.LABELS.LBL_ORIGINAL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (6, 1, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (7, 1, 'daysOverdue', 'CLIENTVIEWER.LABELS.LBL_DELAY_DAYS', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (8, 1, 'role', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '90px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (9, 1, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (10, 1, 'expirationDate', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (11, 1, 'rate', 'CLIENTVIEWER.LABELS.LBL_RATE', 0, 0, 1, 0, 0, 0, '90px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (12, 1, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (13, 1, 'termType', 'CLIENTVIEWER.LABELS.LBL_TERM_TYPE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (14, 1, 'term', 'CLIENTVIEWER.LABELS.LBL_TERM', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (15, 1, 'reasonCredit', 'CLIENTVIEWER.LABELS.LBL_CREDIT_REASON', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (16, 1, 'amounLocalMoney', 'CLIENTVIEWER.LABELS.LBL_RIES', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (17, 1, 'currentContract', 'CLIENTVIEWER.LABELS.LBL_AMOUNT_TOTAL', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (18, 1, 'totalCharges', 'CLIENTVIEWER.LABELS.LBL_CAPITAL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (19, 2, 'totalDebts', 'CLIENTVIEWER.LABELS.LBL_TOTAL', 0, 0, 0, 0, 0, 0, ' ', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (20, 2, '0', 'CLIENTVIEWER.LABELS.LBL_COUNTER', 0, 0, 0, 0, 0, 0, ' ', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (21, 3, 'module', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 0, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (22, 3, 'warrantyType', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (23, 3, 'code', 'CLIENTVIEWER.LABELS.LBL_WARRANTY_NUMBER', 1, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (24, 3, 'warrantyDescription', 'COMMONS.LABELS.LBL_DESCRIPTION_PS', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (25, 3, 'currency', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (26, 3, 'actualValue', 'CLIENTVIEWER.LABELS.LBL_COMERTIAL_VALUE', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (28, 3, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (29, 3, 'guarantor', 'CLIENTVIEWER.LABELS.LBL_GUARANTOR', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (31, 4, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (32, 4, 'typeDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (33, 4, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (34, 4, 'balance', 'CLIENTVIEWER.LABELS.LBL_BALANCE_CONT', 0, 0, 0, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (35, 4, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (36, 4, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (37, 4, 'rol', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (38, 4, 'pledgedAmount', 'CLIENTVIEWER.LABELS.LBL_AMOUNTH_PIG', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (39, 4, 'retentions', 'CLIENTVIEWER.LABELS.LBL_RETENTION', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (40, 4, 'blockades', 'CLIENTVIEWER.LABELS.LBL_BLOCKS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (41, 4, 'overdraftLimit', 'CLIENTVIEWER.LABELS.LBL_OD_LIMIT', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (42, 4, 'protests', 'CLIENTVIEWER.LABELS.LBL_PROTEST', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (43, 4, 'statusDescription', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (44, 4, 'rate', 'CLIENTVIEWER.LABELS.LBL_RATE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (45, 4, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (46, 5, 'module', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 0, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (47, 5, 'warrantyDescription', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (48, 5, 'warrantyType', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (49, 5, 'code', 'CLIENTVIEWER.LABELS.LBL_WARRANTY_NUMBER', 1, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (50, 5, 'currency', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (51, 5, 'actualValue', 'CLIENTVIEWER.LABELS.LBL_COMERTIAL_VALUE', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (53, 5, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (54, 5, 'guarantor', 'CLIENTVIEWER.LABELS.LBL_GUARANTOR', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (55, 5, 'percet', 'CLIENTVIEWER.LABELS.LBL_PERCENTAGE', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (56, 6, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (57, 6, 'typeDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (58, 6, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (59, 6, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (60, 6, 'balance', 'CLIENTVIEWER.LABELS.LBL_BALANCE_CONT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (61, 6, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (62, 6, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (63, 6, 'rol', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (64, 6, 'pledgedAmount', 'CLIENTVIEWER.LABELS.LBL_AMOUNTH_PIG', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (65, 6, 'retentions', 'CLIENTVIEWER.LABELS.LBL_RETENTION', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (66, 6, 'blockades', 'CLIENTVIEWER.LABELS.LBL_BLOCKS', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (67, 6, 'statusDescription', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (68, 6, 'rate', 'CLIENTVIEWER.LABELS.LBL_RATE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (69, 7, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (70, 7, 'typeDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (71, 7, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (72, 7, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (73, 7, 'balance', 'CLIENTVIEWER.LABELS.LBL_BALANCE_CONT', 0, 0, 0, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (74, 7, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (75, 7, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (76, 7, 'rol', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (77, 7, 'pledgedAmount', 'CLIENTVIEWER.LABELS.LBL_AMOUNTH_PIG', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (78, 7, 'statusDescription', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (79, 7, 'rate', 'CLIENTVIEWER.LABELS.LBL_RATE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (80, 8, 'product', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 0, 0, 0, 1, 1, NULL, NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (81, 8, 'lineNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (82, 8, 'opTypeDescription', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 1, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (83, 8, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (84, 8, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (85, 8, 'expirationDate', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (86, 8, 'limitApproved', 'CLIENTVIEWER.LABELS.LBL_AMOUNT_APPROVED', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (87, 8, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (88, 8, 'usedAmount', 'CLIENTVIEWER.LABELS.LBL_USED_AMOUNT', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (89, 9, 'opTypeDescription', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 1, 1, 0, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (90, 9, 'lineNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (91, 9, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (92, 9, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (93, 9, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (94, 9, 'usedAmount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (95, 9, 'riskAmount', 'CLIENTVIEWER.LABELS.LBL_RIES', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (96, 11, 'operationType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 0, 1, 0, 1, 1, '180px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (97, 11, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_OPERATION', 1, 0, 1, 1, 0, 0, '120px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (98, 11, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (99, 11, 'amount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '100px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (100, 11, 'dateVTCRegistry', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 1, 0, 0, '150px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (101, 11, 'beneficiary', 'CLIENTVIEWER.LABELS.LBL_BENEFICIARY', 0, 0, 1, 0, 0, 0, '150px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (102, 11, 'subType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_SUBTYPE', 0, 0, 1, 0, 0, 0, '140px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (103, 11, 'warrantyClass', 'CLIENTVIEWER.LABELS.LBL_WARRANTY_CLASS', 0, 0, 1, 0, 0, 0, '200px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (104, 12, 'product', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (105, 12, 'operationTypeDesc', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 1, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (106, 12, 'operation', 'CLIENTVIEWER.LABELS.LBL_OPERATION', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (107, 12, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (108, 12, 'stateConta', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (109, 12, 'amountCapital', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (110, 13, 'opTypeDescription', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 1, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (111, 13, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (112, 13, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (113, 13, 'status', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (114, 13, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (115, 13, 'limitApproved', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (116, 13, 'riskAmount', 'CLIENTVIEWER.LABELS.LBL_RIES', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (117, 14, 'module', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (118, 14, 'warrantyDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (119, 14, 'warrantyType', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 0, 0, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (120, 14, 'code', 'CLIENTVIEWER.LABELS.LBL_OPERATION', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (121, 14, 'currency', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (122, 14, 'actualValue', 'CLIENTVIEWER.LABELS.LBL_COMERTIAL_VALUE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (124, 15, 'product', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (125, 15, 'operationTypeDesc', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 1, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (126, 15, 'operationType', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (127, 15, 'operation', 'CLIENTVIEWER.LABELS.LBL_TRAMIT', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (128, 15, 'dateApt', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (129, 15, 'dateVto', 'CLIENTVIEWER.LABELS.LBL_EXPIRED_DATE WHERE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (130, 15, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (131, 15, 'amountCapital', 'CLIENTVIEWER.LABELS.LBL_ORIGINAL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (132, 15, 'balance_due', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DUE', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (133, 16, 'totalLiabilities', 'CLIENTVIEWER.LABELS.LBL_TOTAL', 0, 0, 0, 0, 0, 0, ' ', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (134, 16, '1', 'CLIENTVIEWER.LABELS.LBL_COUNTER', 0, 0, 0, 0, 0, 0, ' ', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (135, 17, 'totalWarranties', 'CLIENTVIEWER.LABELS.LBL_TOTAL', 0, 0, 0, 0, 0, 0, ' ', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (136, 17, '2', 'CLIENTVIEWER.LABELS.LBL_COUNTER', 0, 0, 0, 0, 0, 0, ' ', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (137, 18, 'totalContingencies', 'CLIENTVIEWER.LABELS.LBL_TOTAL', 0, 0, 0, 0, 0, 0, ' ', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (138, 18, '3', 'CLIENTVIEWER.LABELS.LBL_COUNTER', 0, 0, 0, 0, 0, 0, ' ', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (139, 19, 'totalIndirect', 'CLIENTVIEWER.LABELS.LBL_TOTAL', 0, 0, 0, 0, 0, 0, ' ', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (140, 19, '4', 'CLIENTVIEWER.LABELS.LBL_COUNTER', 0, 0, 0, 0, 0, 0, ' ', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (141, 20, 'guarantee', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (142, 20, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (143, 20, 'initialDate', 'CLIENTVIEWER.LABELS.LBL_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (144, 20, 'states', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (145, 21, 'numberOperation', 'STANDBY.LABELS.LBL_CREDITLINE', 1, 1, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (146, 21, 'typeCon', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 0, 0, 0, 0, 0, 0, '145px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (147, 21, 'tradeMark', 'CLIENTVIEWER.LABELS.LBL_BRAND', 0, 0, 0, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (148, 21, 'operationType', 'CLIENTVIEWER.LABELS.LBL_CARD_TYPE', 0, 0, 1, 0, 1, 0, '160px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (149, 21, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 0, 0, 0, '70px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (150, 21, 'amount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT_APPROVED', 0, 0, 1, 1, 0, 0, '100px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (151, 21, 'available', 'CLIENTVIEWER.LABELS.LBL_QUOTA_DISP', 0, 0, 1, 1, 0, 0, '100px', '{0:n}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (152, 21, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '160px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (153, 21, 'expirationDate', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (154, 22, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_CODE', 1, 0, 0, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (155, 22, 'subTypeId', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '145px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (156, 22, 'product', 'CLIENTVIEWER.LABELS.LBL_BRAND', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (157, 22, 'subType', 'CLIENTVIEWER.LABELS.LBL_CARD_TYPE', 0, 1, 1, 0, 1, 0, '160px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (159, 22, 'warrantyClass', 'COMMONS.HEADERS.HDR_STATUS', 0, 0, 1, 1, 0, 0, '160px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (160, 22, 'insurance', 'CLIENTVIEWER.LABELS.LBL_HAVE_INSURANCE', 0, 0, 1, 0, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (161, 22, 'dateVTCRegistry', 'CLIENTVIEWER.LABELS.LBL_ACTIVATION_DATE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (162, 23, 'documentTypeDescription', 'CLIENTVIEWER.LABELS.LBL_DOCUMENT_TYPE', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (163, 23, 'onlyDocumentId', 'CLIENTVIEWER.LABELS.LBL_CUSTOMER_IDENTIFICATION', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (164, 23, 'expirationDate', 'CLIENTVIEWER.LABELS.LBL_EXPIRED_DATE', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (165, 23, 'gender', 'CLIENTVIEWER.LABELS.LBL_GENDER', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (166, 23, 'birthDate', 'CLIENTVIEWER.LABELS.LBL_BIRTH_DATE', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (167, 23, 'age', 'CLIENTVIEWER.LABELS.LBL_AGE', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (168, 23, 'fullNameCouple', 'CLIENTVIEWER.LABELS.LBL_COUPLE', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (169, 25, 'studyLevel', 'CLIENTVIEWER.LABELS.LBL_STUDY_LEVEL', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (170, 25, 'profesion', 'CLIENTVIEWER.LABELS.LBL_PROFESSION', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (171, 28, 'officeName', 'CLIENTVIEWER.LABELS.LBL_MANAGEMENT_OFFICE', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (172, 28, 'nit', 'CLIENTVIEWER.LABELS.LBL_NIT', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (173, 28, 'economicGroup', 'CLIENTVIEWER.LABELS.LBL_ECONOMIC_GROUP', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (174, 28, 'activity', 'CLIENTVIEWER.LABELS.LBL_ACTIVITY', 0, 1, 0, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (175, 28, 'reportSBS', 'CLIENTVIEWER.LABELS.LBL_RELATIONSHIP_BANK', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (176, 28, 'maxIDeb', 'CLIENTVIEWER.LABELS.LBL_MAX_DEBT', 0, 1, 0, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (177, 26, 'limitDebt', 'CLIENTVIEWER.LABELS.LBL_LIMIT_DEBT', 0, 1, 0, 1, 0, 0, '130px', '{0:n}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (178, 26, 'debtAmount', 'CLIENTVIEWER.LABELS.LBL_DEBT_AMOUNT', 0, 1, 0, 1, 0, 0, '130px', '{0:n}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (179, 26, 'available', 'CLIENTVIEWER.LABELS.LBL_AVAILABLE', 0, 1, 0, 1, 0, 0, '130px', '{0:n}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (180, 27, 'companyType', 'CLIENTVIEWER.LABELS.LBL_CORPORATION_TYPE', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (181, 27, 'descriptionSegment', 'CLIENTVIEWER.LABELS.LBL_LEGAL_ENTITY', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (182, 27, 'numberEmployees', 'CLIENTVIEWER.LABELS.LBL_EMPLOYEES_NUMBER', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (183, 27, 'legalRepresentative', 'CLIENTVIEWER.LABELS.LBL_REPRESENTATIVE_NAME', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (184, 27, 'groupName', 'CLIENTVIEWER.LABELS.LBL_ECONOMIC_GROUP', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (185, 27, 'entailment', 'CLIENTVIEWER.LABELS.LBL_LINKED', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (186, 27, 'linkUpTypeDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_ENTAILMENT', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (187, 27, 'descState', 'CLIENTVIEWER.LABELS.LBL_STATE', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (188, 24, 'office', 'CLIENTVIEWER.LABELS.LBL_MANAGEMENT_OFFICE', 0, 0, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (189, 24, 'descriptionCoverage', 'CLIENTVIEWER.LABELS.LBL_COVERAGE', 0, 0, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (190, 24, 'nationality', 'CLIENTVIEWER.LABELS.LBL_NATIONALITY', 0, 0, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (191, 24, 'totalAssets', 'CLIENTVIEWER.LABELS.LBL_ASSETS_AMOUNT', 0, 0, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (192, 24, 'heritage', 'CLIENTVIEWER.LABELS.LBL_HERITAGE', 0, 0, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (193, 24, 'dateHeritage', 'CLIENTVIEWER.LABELS.LBL_DATE_HERITAGE', 0, 0, 0, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (194, 33, 'addressId', 'N°', 1, 0, 1, 0, 0, 0, '50px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (195, 33, 'isMainAddress', 'COMMONS.HEADERS.HDR_MAIN_SECTOR', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (196, 33, 'type', 'COMMONS.HEADERS.HDR_TYPE_DIRECTION', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (197, 33, 'description', 'ADDRESS.LABELS.LBL_ADDRESS', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (198, 33, 'country', 'COMMONS.HEADERS.HDR_COUNTRY_NAME', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (199, 33, 'department', 'COMMONS.HEADERS.HDR_DEPARTMENT', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (200, 33, 'province', 'COMMONS.HEADERS.HDR_PROVINCE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (201, 33, 'city', 'COMMONS.HEADERS.HDR_TOWN_SHIP_NAME', 0, 0, 1, 0, 0, 0, '140px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (202, 33, 'street', 'COMMONS.HEADERS.HDR_STREET', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (203, 33, 'code', 'CLIENTVIEWER.LABELS.LBL_CODE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (204, 30, 'identificationType', 'COMMONS.LABELS.LBL_TYPE_IDENTIFICATION', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (205, 30, 'code', 'CLIENTVIEWER.LABELS.LBL_CODE', 1, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (206, 30, 'composedName', 'COMMONS.HEADERS.HDR_NAME', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (207, 30, 'documentId', 'COMMONS.HEADERS.HDR_DOCUMENT_NUMBER', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (208, 30, 'subtype', 'CLIENTVIEWER.LABELS.LBL_OPERATION_SUBTYPE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (209, 30, 'passport', 'COMMONS.HEADERS.HDR_PASSPORT', 0, 0, 0, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (210, 30, 'linkUpTypeDescription', 'COMMONS.HEADERS.HDR_LINKED', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (211, 31, 'typePhone', 'COMMONS.HEADERS.HDR_TYPE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (212, 31, 'value', 'COMMONS.HEADERS.HDR_PHONE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (213, 32, 'operationTypeDescription', 'FIENET', 0, 0, 0, 0, 0, 0, '150px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (214, 32, 'operationType', 'COMMONS.HEADERS.HDR_STATUS', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (215, 32, 'dateAPRRegistry', 'CLIENTVIEWER.LABELS.LBL_ACTIVATION_DATE', 0, 0, 1, 1, 0, 0, '200px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (216, 29, 'sequential', 'CLIENTVIEWER.LABELS.LBL_SECUENTIAL', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (217, 29, 'sector', 'CLIENTVIEWER.LABELS.LBL_SECTOR', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (218, 29, 'subSector', 'CLIENTVIEWER.LABELS.LBL_SUB_SECTOR', 0, 0, 1, 1, 0, 0, '125px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (219, 29, 'activity', 'CLIENTVIEWER.LABELS.LBL_ACTIVITY_OCCUPATION', 0, 0, 1, 1, 0, 0, '125px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (220, 29, 'main', 'COMMONS.HEADERS.HDR_MAIN_SECTOR', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (221, 34, 'entity', 'CLIENTVIEWER.LABELS.LBL_CLIENT', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (222, 34, 'contact', 'ADDRESS.LABELS.LBL_CONTACTS', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (223, 34, 'name', 'CLIENTVIEWER.LABELS.LBL_CLIENT', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (224, 34, 'address', 'ADDRESS.LABELS.LBL_ADDRESS', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (225, 34, 'email', 'ADDRESS.LABELS.LBL_EMAILS', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (226, 35, 'entity', 'CLIENTVIEWER.LABELS.LBL_CLIENT', 0, 0, 0, 0, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (227, 35, 'contact', 'N°', 0, 0, 1, 1, 1, 0, '50px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (228, 35, 'name', 'COMMONS.HEADERS.HDR_NAME', 0, 0, 1, 1, 1, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (229, 35, 'address', 'ADDRESS.LABELS.LBL_ADDRESS', 0, 0, 1, 1, 1, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (230, 35, 'email', 'ADDRESS.LABELS.LBL_EMAILS', 0, 0, 1, 1, 1, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (231, 38, 'amount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 3)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (232, 38, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_COUNTER', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 2)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (233, 38, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 1)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (234, 39, 'amount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (235, 39, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_COUNTER', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (236, 39, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (237, 39, 'operationType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (238, 23, 'civilStatusDescription', 'CLIENTVIEWER.LABELS.LBL_MARITAL_STATUS', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (239, 30, 'image', 'CLIENTVIEWER.LABELS.LBL_BLANK', 0, 0, 1, 0, 0, 0, '110px', 'glyphicon glyphicon-search', 'BUTTON', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (240, 29, 'subActivity', 'CLIENTVIEWER.LABELS.LBL_ACTIVITY_FIE', 0, 0, 1, 1, 0, 0, '125px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (241, 29, 'description', 'COMMONS.LABELS.LBL_DESCRIPTION_PS', 0, 0, 1, 1, 0, 0, '125px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (242, 40, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (243, 40, 'typeDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (244, 40, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (245, 40, 'rol', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (246, 40, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (247, 40, 'cancellationDate', 'CLIENTVIEWER.LABELS.LBL_CANCELATION_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (248, 40, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (249, 40, 'statusDescription', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (250, 40, 'officeDescription', 'CLIENTVIEWER.LABELS.LBL_SUBSIDIARY', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (251, 41, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (252, 41, 'typeDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (253, 41, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (254, 41, 'rol', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (255, 41, 'statusDescription', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (256, 41, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (257, 41, 'cancellationDate', 'CLIENTVIEWER.LABELS.LBL_CANCELATION_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (258, 41, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (259, 41, 'officeDescription', 'CLIENTVIEWER.LABELS.LBL_SUBSIDIARY', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (260, 42, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (261, 42, 'typeDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (262, 42, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (263, 42, 'rol', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (264, 42, 'statusDescription', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (265, 42, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (266, 42, 'cancellationDate', 'CLIENTVIEWER.LABELS.LBL_CANCELATION_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (267, 42, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (268, 42, 'balance', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (269, 42, 'rate', 'CLIENTVIEWER.LABELS.LBL_RATE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (270, 42, 'term', 'CLIENTVIEWER.LABELS.LBL_TERM', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (271, 43, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_CODE', 1, 0, 0, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (272, 43, 'subTypeId', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '145px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (273, 43, 'product', 'CLIENTVIEWER.LABELS.LBL_BRAND', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (274, 43, 'subType', 'CLIENTVIEWER.LABELS.LBL_CARD_TYPE', 0, 1, 1, 0, 1, 0, '160px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (276, 43, 'warrantyClass', 'COMMONS.HEADERS.HDR_STATUS', 0, 0, 1, 1, 0, 0, '160px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (277, 43, 'insurance', 'CLIENTVIEWER.LABELS.LBL_HAVE_INSURANCE', 0, 0, 1, 0, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (278, 43, 'dateVTCRegistry', 'CLIENTVIEWER.LABELS.LBL_ACTIVATION_DATE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (279, 43, 'office', 'CLIENTVIEWER.LABELS.LBL_SUBSIDIARY', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (280, 43, 'cancellationDate', 'CLIENTVIEWER.LABELS.LBL_CANCELATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (281, 44, 'operationTypeDescription', 'FIENET', 0, 0, 0, 0, 0, 0, '150px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (282, 44, 'operationType', 'COMMONS.HEADERS.HDR_STATUS', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (283, 44, 'dateAPRRegistry', 'CLIENTVIEWER.LABELS.LBL_ACTIVATION_DATE', 0, 0, 1, 1, 0, 0, '200px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (284, 44, 'office', 'CLIENTVIEWER.LABELS.LBL_SUBSIDIARY', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (285, 45, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, 1)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (286, 45, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_CREDIT_NUMBER', 1, 1, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, 2)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (287, 45, 'role', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '90px', NULL, 'LABEL', NULL, 3)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (288, 45, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_DATE_START_LOAN', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 4)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (289, 45, 'expirationDate', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 5)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (290, 45, 'dateCancellation', 'CLIENTVIEWER.LABELS.LBL_CANCELATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 6)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (291, 45, 'originalAmount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 7)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (292, 45, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_CAP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 8)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (293, 45, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 9)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (294, 45, 'term', 'CLIENTVIEWER.LABELS.LBL_TERM', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 10)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (295, 45, 'termType', 'CLIENTVIEWER.LABELS.LBL_FRECUENCY_TYPE', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 11)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (296, 45, 'rate', 'CLIENTVIEWER.LABELS.LBL_RATE', 0, 0, 1, 0, 0, 0, '90px', NULL, 'LABEL', NULL, 12)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (297, 45, 'rating', 'CLIENTVIEWER.LABELS.LBL_CALIFICATION', 0, 0, 1, 0, 0, 0, '90px', NULL, 'LABEL', NULL, 13)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (298, 45, 'daysOverdue', 'CLIENTVIEWER.LABELS.LBL_DAY_OVERDUE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, 14)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (299, 45, 'reasonCredit', 'CLIENTVIEWER.LABELS.LBL_CREDIT_REASON', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, 15)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (300, 45, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '100px', NULL, 'LABEL', NULL, 16)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (301, 45, 'refinancing', 'CLIENTVIEWER.LABELS.LBL_CANCELLED_REF', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, 17)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (478, 45, 'reprogramming', 'CLIENTVIEWER.LABELS.LBL_REPROGRAMING', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, 18)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (302, 46, 'lineNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (303, 46, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (304, 46, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (305, 46, 'expirationDate', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (306, 46, 'limitApproved', 'CLIENTVIEWER.LABELS.LBL_AMOUNT_APPROVED', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (307, 46, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (308, 46, 'usedAmount', 'CLIENTVIEWER.LABELS.LBL_USED_AMOUNT', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (309, 46, 'status', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (310, 46, 'role', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (311, 46, 'rotaryType', 'CLIENTVIEWER.LABELS.LBL_ROTARY_TYPE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (479, 46, 'term', 'CLIENTVIEWER.LABELS.LBL_TERM', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (480, 46, 'termType', 'CLIENTVIEWER.LABELS.LBL_FRECUENCY', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (312, 47, 'opTypeDescription', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 1, 1, 0, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (313, 47, 'lineNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (314, 47, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (315, 47, 'openingDate', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (316, 47, 'available', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (317, 47, 'usedAmount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (318, 47, 'riskAmount', 'CLIENTVIEWER.LABELS.LBL_RIES', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (319, 48, 'operationType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 0, 1, 0, 1, 1, '180px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (320, 48, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_OPERATION', 1, 0, 1, 1, 0, 0, '120px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (321, 48, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (322, 48, 'amount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '100px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (323, 48, 'dateVTCRegistry', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 1, 0, 0, '150px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (324, 48, 'beneficiary', 'CLIENTVIEWER.LABELS.LBL_BENEFICIARY', 0, 0, 1, 0, 0, 0, '150px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (325, 48, 'subType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_SUBTYPE', 0, 0, 1, 0, 0, 0, '140px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (326, 48, 'warrantyClass', 'CLIENTVIEWER.LABELS.LBL_WARRANTY_CLASS', 0, 0, 1, 0, 0, 0, '200px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (327, 50, 'warrantyDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (328, 50, 'warrantyType', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (329, 50, 'code', 'CLIENTVIEWER.LABELS.LBL_WARRANTY_NUMBER', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (330, 50, 'currency', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (331, 50, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (332, 50, 'guarantor', 'CLIENTVIEWER.LABELS.LBL_GUARANTOR', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (334, 50, 'cancelationDate', 'CLIENTVIEWER.LABELS.LBL_CANCELATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (335, 50, 'activationDate', 'CLIENTVIEWER.LABELS.LBL_ACTIVATION_DATE', 0, 0, 1, 1, 0, 0, '200px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (336, 51, 'warrantyDescription', 'CLIENTVIEWER.LABELS.LBL_GROUP', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (337, 51, 'warrantyType', 'CLIENTVIEWER.LABELS.LBL_TYPE_', 0, 1, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (338, 51, 'code', 'CLIENTVIEWER.LABELS.LBL_WARRANTY_NUMBER', 1, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (339, 51, 'currency', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (341, 51, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (342, 51, 'guarantor', 'CLIENTVIEWER.LABELS.LBL_GUARANTOR', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (343, 51, 'percet', 'CLIENTVIEWER.LABELS.LBL_PERCENTAGE', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (344, 51, 'cancelationDate', 'CLIENTVIEWER.LABELS.LBL_CANCELATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (345, 51, 'activationDate', 'CLIENTVIEWER.LABELS.LBL_ACTIVATION_DATE', 0, 0, 1, 1, 0, 0, '200px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (346, 10, 'operationType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 1, 1, 0, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (347, 10, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (348, 10, 'operationTypeDesc', 'CLIENTVIEWER.LABELS.LBL_OPERATION_DESCRIPTION', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (349, 10, 'operation', 'CLIENTVIEWER.LABELS.LBL_CREDIT_NUMBER', 1, 1, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (350, 10, 'contractValue', 'CLIENTVIEWER.LABELS.LBL_ORIGINAL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (351, 10, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (352, 10, 'daysLate', 'CLIENTVIEWER.LABELS.LBL_DELAY_DAYS', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (353, 10, 'role', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '90px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (354, 10, 'dateApt', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: left', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (355, 10, 'dateVto', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: left', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (356, 10, 'rate', 'CLIENTVIEWER.LABELS.LBL_RATE', 0, 0, 1, 0, 0, 0, '90px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (357, 10, 'stateConta', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (358, 10, 'typeTerm', 'CLIENTVIEWER.LABELS.LBL_TERM_TYPE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (359, 10, 'term', 'CLIENTVIEWER.LABELS.LBL_TERM', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (360, 10, 'reason', 'CLIENTVIEWER.LABELS.LBL_CREDIT_REASON', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (361, 10, 'amountLosing', 'CLIENTVIEWER.LABELS.LBL_RIES', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (362, 10, 'amountTotal', 'CLIENTVIEWER.LABELS.LBL_AMOUNT_TOTAL', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (363, 49, 'operationType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 1, 1, 0, 0, 1, '130px', NULL, 'LABEL', NULL, 1)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (364, 49, 'operation', 'CLIENTVIEWER.LABELS.LBL_CREDIT_NUMBER', 1, 1, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, 2)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (365, 49, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 3)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (366, 49, 'clientName', 'CLIENTVIEWER.LABELS.LBL_DEBTOR_ASSURANCE', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 4)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (367, 49, 'dateApt', 'CLIENTVIEWER.LABELS.LBL_DATE_START_LOAN', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 5)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (368, 49, 'cancellationDate', 'CLIENTVIEWER.LABELS.LBL_CANCELATION_DATE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 6)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (369, 49, 'operationTypeDesc', 'CLIENTVIEWER.LABELS.LBL_OPERATION_DESCRIPTION', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, 7)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (370, 49, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, 8)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (371, 49, 'amountOrigin', 'CLIENTVIEWER.LABELS.LBL_AMOUNT_DISBURSED', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 10)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (372, 49, 'amountCapital', 'CLIENTVIEWER.LABELS.LBL_CAP_BALANCE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 11)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (373, 49, 'amountPaid', 'CLIENTVIEWER.LABELS.LBL_AMOUNTPAID', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 12)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (374, 49, 'calification', 'CLIENTVIEWER.LABELS.LBL_RATING', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, 13)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (375, 49,'restructuring', 'CLIENTVIEWER.LABELS.LBL_REPROGRAMING', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, 14)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (377, 50, 'actualValue', 'CLIENTVIEWER.LABELS.LBL_COMERTIAL_VALUE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (378, 50, 'realizationValue', 'CLIENTVIEWER.LABELS.LBL_NET_VALUE_REALITATION', 0, 0, 1, 1, 0, 0, '200px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (379, 52, 'guarantee', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (380, 52, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (381, 52, 'initialDate', 'CLIENTVIEWER.LABELS.LBL_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (382, 52, 'states', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (383, 53, 'operationType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 1, 1, 0, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (384, 53, 'product', 'CLIENTVIEWER.LABELS.LBL_PRODUCT', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (385, 53, 'operationTypeDesc', 'CLIENTVIEWER.LABELS.LBL_OPERATION_DESCRIPTION', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (386, 53, 'alternateCode', 'CLIENTVIEWER.LABELS.LBL_ALTERNAL_CODE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (387, 53, 'stage', 'CLIENTVIEWER.LABELS.LBL_STAGE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (388, 53, 'processed', 'CLIENTVIEWER.LABELS.LBL_TRAMIT', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (389, 53, 'dateApt', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (390, 53, 'dateVto', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (391, 53, 'amountOrigin', 'CLIENTVIEWER.LABELS.LBL_ORIGINAL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (392, 53, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (393, 53, 'amountCapital', 'CLIENTVIEWER.LABELS.LBL_CAPITAL_AMOUNT', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (394, 53, 'amountLosing', 'COMMONS.HEADERS.HDR_EXPIRED_DEBT_BALANCE', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (395, 53, 'rate', 'CLIENTVIEWER.LABELS.LBL_RATE', 0, 0, 1, 0, 0, 0, '90px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (396, 54, 'balance', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 2)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (397, 54, 'operation', 'CLIENTVIEWER.LABELS.LBL_NUMBER', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 3)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (398, 54, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 1)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (399, 55, 'numberIdentifier', 'CLIENTVIEWER.LABELS.LBL_NUMBER_IDENTIFIER', 0, 0, 1, 1, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (400, 55, 'operationNumber', 'CLIENTVIEWER.LABELS.LBL_OPERATION_NUMBER', 0, 0, 1, 1, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (401, 55, 'dateLoad', 'CLIENTVIEWER.LABELS.LBL_DATE_LOAD', 0, 0, 1, 1, 0, 1, '130px', '{0:dd-MMM-yyyy}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (402, 55, 'dateRejected', 'CLIENTVIEWER.LABELS.LBL_DATE_REJECTED', 0, 0, 1, 1, 0, 1, '130px', '{0:dd-MMM-yyyy}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (403, 55, 'reason', 'CLIENTVIEWER.LABELS.LBL_REASON', 0, 0, 1, 1, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (404, 55, 'user', 'CLIENTVIEWER.LABELS.LBL_USER', 0, 0, 1, 1, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (405, 55, 'module', 'CLIENTVIEWER.LABELS.LBL_MODULE', 0, 1, 1, 1, 0, 1, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (406, 3, 'realizationValue', 'CLIENTVIEWER.LABELS.LBL_COMERTIAL_VALUE_REFERENCE', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (407, 37, 'affiliateDate', 'CLIENTVIEWER.LABELS.LBL_AFFILIATE_DATE', 0, 0, 1, 1, 0, 0, '130px', '{0:dd-MMM-yyyy}', 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (408, 37, 'alternateProfile', 'CLIENTVIEWER.LABELS.LBL_ALTERNATE_PROFILE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (409, 37, 'channel', 'CLIENTVIEWER.LABELS.LBL_CHANNEL', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (410, 37, 'entityMIS', 'CLIENTVIEWER.LABELS.LBL_ENTITY_MIS', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (411, 37, 'profile', 'CLIENTVIEWER.LABELS.LBL_PROFILE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (412, 37, 'state', 'CLIENTVIEWER.LABELS.LBL_STATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (413, 56, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (414, 56, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (415, 56, 'dateAPRRegistry', 'CLIENTVIEWER.LABELS.LBL_OPENING_DATE', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (416, 56, 'balance', 'CLIENTVIEWER.LABELS.LBL_BALANCE_DISP', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (417, 56, 'operationType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_TYPE', 0, 1, 1, 0, 1, 1, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (418, 35, 'phone', 'COMMONS.HEADERS.HDR_PHONE', 0, 0, 1, 1, 1, 0, '100px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (419, 27, 'activity', 'CLIENTVIEWER.LABELS.LBL_ACTIVITY', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (420, 27, 'sector', 'CLIENTVIEWER.LABELS.LBL_SECTOR_ACTIVITY', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (421, 27, 'main', 'CLIENTVIEWER.LABELS.LBL_PAYROLL_COMPANY', 0, 1, 0, 1, 0, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (422, 8, 'riskAmount', 'CLIENTVIEWER.LABELS.LBL_RIES', 0, 0, 1, 0, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (423, 8, 'status', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 0, 0, 0, NULL, NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (424, 3, 'activationDate', 'CLIENTVIEWER.LABELS.LBL_ACTIVATION_DATE', 0, 0, 1, 1, 0, 0, '130px', '{0:dd-MMM-yyyy}', 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
values (425, 57, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_CREDITLINE', 1, 1, 1, 1, 0, 0, '130px', null, 'LABEL', null, null)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
values (426, 57, 'typeCon', 'CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION', 1, 0, 1, 1, 0, 0, '145px', null, 'LABEL', null, null)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
values (427, 57, 'tradeMark', 'CLIENTVIEWER.LABELS.LBL_BRAND', 0, 0, 0, 0, 1, 0, '110px', null, 'LABEL', 'text-align: right', null)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
values (428, 57, 'operationType', 'CLIENTVIEWER.LABELS.LBL_CARD_TYPE', 0, 0, 1, 0, 1, 0, '160px', null, 'LABEL', null, null)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (429, 57, 'descriptionType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_DESCRIPTION', 0, 0, 1, 0, 1, 0, '130px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
values (430, 57, 'currencyDescription', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 0, 0, 0, '70px', null, 'LABEL', null, null)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
values (431, 57, 'available', 'CLIENTVIEWER.LABELS.LBL_QUOTA_USED', 0, 0, 1, 1, 0, 0, '100px', '{0:n}', 'LABEL', null, null)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
values (432, 57, 'state', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '160px', null, 'LABEL', null, null)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
values (433, 57, 'expirationDate', 'CLIENTVIEWER.LABELS.LBL_EXPIRATION_DATE', 0, 0, 0, 1, 0, 0, '110px', null, 'LABEL', 'text-align: right', null)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (434, 57, 'amount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT_APPROVED', 0, 0, 1, 1, 0, 0, '100px', '{0:n}', 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (435, 21, 'descriptionType', 'CLIENTVIEWER.LABELS.LBL_OPERATION_DESCRIPTION', 0, 0, 1, 0, 1, 0, '160px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (436, 4, 'balanceLocalCurrency', 'CLIENTVIEWER.LABELS.LBL_BALANCE_CONT_LOCAL', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (437, 6, 'balanceLocalCurrency', 'CLIENTVIEWER.LABELS.LBL_BALANCE_CONT_LOCAL', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (438, 7, 'balanceLocalCurrency', 'CLIENTVIEWER.LABELS.LBL_BALANCE_CONT_LOCAL', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (439, 16, 'balanceLocalCurrency', 'CLIENTVIEWER.LABELS.LBL_BALANCE_CONT_LOCAL', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (440, 3, 'actualMLValue', 'CLIENTVIEWER.LABELS.LBL_COMERTIAL_VALUE_LOCAL_CURR', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (441, 11, 'amountML', 'CLIENTVIEWER.LABELS.LBL_AMOUNT_CONT_ML', 0, 0, 1, 1, 0, 0, '200px', '{0:n}', 'LABEL', NULL, NULL)

INSERT INTO vcc_properties(pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (442, 7, 'expirationDate', 'CLIENTVIEWER.LABELS.LBL_EXPIRED_DATE', 0, 0, 1, 1, 0, 0, '150px', '{0:dd-MMM-yyyy}', 'LABEL', 'text-align: left', 0)

INSERT INTO vcc_properties(pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (443, 7, 'balance', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '150px', '{0:n}', 'LABEL', 'text-align: left', 0)

INSERT INTO vcc_properties(pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (444, 7, 'term', 'CLIENTVIEWER.LABELS.LBL_TERM', 0, 0, 1, 1, 0, 0, '150px', '{0}', 'LABEL', 'text-align: right', 0)

INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (445, 58, 'addressId', 'N°', 1, 0, 1, 0, 0, 0, '50px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (446, 58, 'isMainAddress', 'COMMONS.HEADERS.HDR_MAIN_SECTOR', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (447, 58, 'type', 'COMMONS.HEADERS.HDR_TYPE_DIRECTION', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (448, 58, 'description', 'ADDRESS.LABELS.LBL_ADDRESS', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (449, 58, 'country', 'COMMONS.HEADERS.HDR_COUNTRY_NAME', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (450, 58, 'department', 'COMMONS.HEADERS.HDR_DEPARTMENT', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (451, 58, 'province', 'COMMONS.HEADERS.HDR_PROVINCE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (452, 58, 'city', 'COMMONS.HEADERS.HDR_TOWN_SHIP_NAME', 0, 0, 1, 0, 0, 0, '140px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (453, 58, 'street', 'COMMONS.HEADERS.HDR_STREET', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (454, 58, 'code', 'CLIENTVIEWER.LABELS.LBL_CODE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (455, 59, 'typePhone', 'COMMONS.HEADERS.HDR_TYPE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (456, 59, 'value', 'COMMONS.HEADERS.HDR_PHONE', 0, 0, 1, 0, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (457, 23, 'typeDescription', 'CLIENTVIEWER.LABELS.LBL_TYPE', 0, 1, 0, 1, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (458, 23, 'nationalityDescription', 'CLIENTVIEWER.LABELS.LBL_NATIONALITY', 0, 1, 0, 1, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (459, 28, 'economicSector', 'CLIENTVIEWER.LABELS.LBL_ECONOMIC_SECTOR', 0, 1, 0, 1, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (460, 38, 'status', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 1) 


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (461, 28, 'activity', 'CLIENTVIEWER.LABELS.LBL_ACTIVITY', 0, 1, 0, 1, 0, 0, '110px', NULL, 'LABEL', NULL, NULL)


INSERT INTO cob_pac..vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (462, 1, 'rating', 'CLIENTVIEWER.LABELS.LBL_RATING', 0, 0, 1, 0, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (466, 21, 'currencyDescription', 'COMMONS.HEADERS.HDR_MONEY_DESC', 0, 0, 1, 1, 0, 0, '180px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (467, 21, 'currencyMnemonic', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '180px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (468, 21, 'currencyMnemonic', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '180px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (469, 57, 'currencyDescription', 'COMMONS.HEADERS.HDR_MONEY_DESC', 0, 0, 1, 1, 0, 0, '180px', NULL, 'LABEL', 'text-align: right', NULL)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (470, 22, 'associateAcount', 'CLIENTVIEWER.LABELS.LBL_ASSOCIATE_ACCOUNT', 0, 0, 1, 1, 0, 0, '100px', NULL, 'LABEL', NULL, NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (471, 60, 'amount', 'CLIENTVIEWER.LABELS.LBL_AMOUNT', 0, 0, 1, 1, 0, 0, '130px', '{0:n}', 'LABEL', 'text-align: right', 3)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (472, 60, 'numberOperation', 'CLIENTVIEWER.LABELS.LBL_COUNTER', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 2)


INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (473, 60, 'currencyDesc', 'CLIENTVIEWER.LABELS.LBL_CURRENCY', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 1)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (474, 60, 'status', 'CLIENTVIEWER.LABELS.LBL_STATUS', 0, 0, 1, 1, 0, 0, '130px', NULL, 'LABEL', 'text-align: right', 1) 

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (475, 21, 'productType', 'CLIENTVIEWER.LABELS.PRODUCT', 0, 0, 0, 0, 0, 1, '180px', NULL, 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (476, 26, 'rotaryType', 'CLIENTVIEWER.LABELS.LBL_ROTARY_TYPE', 0, 0, 1, 1, 0, 0, '180px', NULL, 'LABEL', 'text-align: right', NULL)

INSERT INTO vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_type, pr_style, pr_order)
VALUES (477, 26, 'role', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 1, 0, 0, '180px', NULL, 'LABEL', 'text-align: right', NULL)

GO

-- ACTUALIZACION DE SECUENCIALES

update cobis..cl_seqnos set siguiente = (select max(dto_id)+1 from vcc_dtos) where bdatos = 'cob_pac' and tabla = 'vcc_dtos'
update cobis..cl_seqnos set siguiente = (select max(pr_id)+1 from vcc_properties) where bdatos = 'cob_pac' and tabla = 'vcc_properties'
update cobis..cl_seqnos set siguiente = (select max(prd_id)+1 from vcc_pro_admin_default) where bdatos = 'cob_pac' and tabla = 'vcc_pro_admin_default'
GO
