--Mantenimiento tabla cr_imp_documento credito *


use cob_credito 
go 


truncate table cr_imp_documento
go

--PRODUCTO GRUPAL
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'GRUPAL', 'CRE', 0, 'Solicitud de Crédito Grupal', 'SOLGRP', 'O', 'solicitudCreditoGrupal', 'C', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'GRUPAL', 'CRE', 0, 'Contrato Grupal', 'CONTGRP', 'O', 'contratoCreditoInclusion', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'GRUPAL', 'CRE', 0, 'Autorización de Pago Recurrente por Miembro', 'AUTPARE', 'O', 'cargoRecurrenteMain', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (4, 'GRUPAL', 'CRE', 0, 'Carátula de Crédito Grupal', 'CACRGRP', 'O', 'caratulaCreditoGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'GRUPAL', 'CRE', 0, 'Tabla Amortización', 'TABGRU', 'O', 'tablaAmortizacion', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'GRUPAL', 'CRE', 0, 'Formulario KYC', 'KYCGRU', 'O', 'kYCSimplificado', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (7, 'GRUPAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimientoZurich-SecureConsent', 'C', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (8, 'GRUPAL', 'CRE', 0, 'Autorización Cargo Pago de Seguro', 'AUCAPS', 'O', 'autorizacionCargo', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (9, 'GRUPAL', 'CRE', 0, 'Certificado Asistencia Funeraria', 'CEASFU', 'O', 'asistenciaFuneraria', 'C', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (10, 'GRUPAL', 'CRE', 0, 'Solicitud Individual Complementaria', 'SICGRU', 'O', 'solicitudCreditoIndividualLarga', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (11, 'GRUPAL', 'CRE', 0, 'Certificado de Consentimiento 2', 'CERCON2', 'O', 'certificadoConsentimiento', 'P', NULL, NULL)
GO
/*INSERT cob_credito..cr_imp_documento(id_documento,id_toperacion,id_producto, id_moneda, id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio)
VALUES(12,'GRUPAL','CRE', 0, 'Consentimiento de seguros TUIIO Seguro','CSTUIIS', 'O','SecureConsent-SecureConsentMedical','P','','')
GO*/
INSERT cob_credito..cr_imp_documento(id_documento,id_toperacion,id_producto, id_moneda, id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio)
VALUES(12,'GRUPAL','CRE', 0, 'Solicitud Prellenada Grupal','SOLPREGRU', 'O', 'solicitudCreditoGrupalPrellenada', 'P', null, null)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (13, 'GRUPAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimientoZurich-SecureConsentGru', 'P', NULL, NULL)
GO

--Individual
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'INDIVIDUAL', 'CRE', 0, 'Autorización Pago Recurrente Individual', 'CREIND', 'O', 'cargoRecurrenteIndiv', 'C', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'INDIVIDUAL', 'CRE', 0, 'Carátula de Crédito Individual', 'CCONCRE', 'O', 'caratulaCreditoSimpleAutoOnboard', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'INDIVIDUAL', 'CRE', 0, 'Formato de Autorización de Aval', 'FAUTAIND', 'O', 'formatAutorizacionAvalInd', 'C', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (4, 'INDIVIDUAL', 'CRE', 0, 'Solicitud de Crédito Individual', 'SCREIN', 'O', 'solicitudCreditoIndividual', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'INDIVIDUAL', 'CRE', 0, 'Contrato de Inclusión Individual', 'CININD', 'O', 'contratoCredSimpleIndividualAutoOnboard', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'INDIVIDUAL', 'CRE', 0, 'Aviso de Privacidad Individual', 'APRIND', 'O', 'avisoPrivacidadIndividual', 'C', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (7, 'INDIVIDUAL', 'CRE', 0, 'Pagaré de Crédito Individual', 'PAGIND', 'O', 'pagareIndividual', 'C', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (8, 'INDIVIDUAL', 'CRE', 0, 'Tabla Amortización', 'TABIND', 'O', 'tablaAmortizacionSimpleIndAutoOnboard', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (9, 'INDIVIDUAL', 'CRE', 0, 'Formulario KYC', 'KYCIND', 'O', 'kYCAutoOnboard', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (10, 'INDIVIDUAL', 'CRE', 0, 'Solicitud Individual Complementaria', 'SICIND', 'O', 'solicitudCreditoIndividualLarga', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (11, 'INDIVIDUAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCONIND', 'O', 'certificadoConsentimientoZurich-SecureConsent', 'C', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (12, 'INDIVIDUAL', 'CRE', 0, 'Certificado Asistencia Funeraria', 'CEASFUIND', 'O', 'asistenciaFuneraria', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (13, 'INDIVIDUAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCONIND', 'O', 'certificadoConsentimientoZurich-SecureConsentInd', 'P', NULL, NULL)
GO


INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'REVOLVENTE', 'CRE', 0, 'Carátula de Crédito Revolvente', 'CACRINLCR', 'O', 'caratulaCreditoRevolvente', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'REVOLVENTE', 'CRE', 0, 'Contrato de Crédito Revolvente', 'CONINLCR', 'O', 'contratoCreditoRevolvente', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'REVOLVENTE', 'CRE', 0, 'Solicitud de Crédito Revolvente', 'SOLINDLCR', 'O', 'solicitudCreditoRevolvente', 'P', NULL, NULL)
GO

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (4, 'REVOLVENTE', 'CRE', 0, 'Formulario KYC', 'KYCLCR', 'O', 'kYCSimplificadoLCR', 'P', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (5 ,'REVOLVENTE','CRE',0,'Solicitud Individual Complementaria','SICREV','O   ','solicitudCreditoIndividualRevolvente','C',NULL,NULL)
GO

delete cr_imp_documento where id_toperacion = 'RENOVACION'

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (1 ,'RENOVACION','CRE',0,'Carátula de Crédito Grupal Renovacion','CACRREN','O','caratulaCreditoGrupalRenov','P',NULL,NULL)

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (2 ,'RENOVACION','CRE',0,'Contrato Grupal Renovacion','CONTREN','O','contratoCreditoGrupalRenovacion','P',NULL,NULL)

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (3 ,'RENOVACION','CRE',0,'Solicitud de Crédito Grupal','SOLGRP','O',	'solicitudCreditoGrupal','C',NULL,NULL)

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (4 ,'RENOVACION','CRE',0,'Tabla Amortización Renovacion','TABREN','O','tablaAmortizacionRenov','P',NULL,NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'RENOVACION', 'CRE', 0, 'Certificado Asistencia Funeraria', 'CEASFU', 'O', 'asistenciaFuneraria', 'C', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'RENOVACION', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimientoZurich-SecureConsent', 'C', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (7, 'RENOVACION', 'CRE', 0, 'Formulario KYC', 'KYCGRU', 'O', 'kYCSimplificado', 'P', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (8, 'RENOVACION', 'CRE', 0, 'Solicitud Individual Complementaria', 'SICGRU', 'O', 'solicitudCreditoIndividualLarga', 'P', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (9, 'RENOVACION', 'CRE', 0, 'Solicitud Renovación Prellenada Financiada', 'SOPREREFI', 'O', 'solicitudCreditoRenovFinanPrellenada', 'P', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (10, 'RENOVACION', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimientoZurich-SecureConsentRen', 'P', NULL, NULL)

go