/*
*  Inserta documento solicitudCreditoIndividualRevolvente REQ#147999
*  Johan castro 08/01/2021
*/
use cob_credito
go 

delete cr_imp_documento where id_toperacion = 'RENOVACION'

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (1 ,'RENOVACION','CRE',0,'Carátula de Crédito Grupal Renovacion','CACRREN','O','caratulaCreditoGrupalRenov','P',NULL,NULL)

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (2 ,'RENOVACION','CRE',0,'Contrato Grupal Renovacion','CONTREN','O','contratoCreditoGrupalRenovacion','P',NULL,NULL)

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (3 ,'RENOVACION','CRE',0,'Solicitud de Crédito Grupal','SOLGRP','O',	'solicitudCreditoGrupal','P',NULL,NULL)

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (4 ,'RENOVACION','CRE',0,'Tabla Amortización Renovacion','TABREN','O','tablaAmortizacionRenov','P',NULL,NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'RENOVACION', 'CRE', 0, 'Certificado Asistencia Funeraria', 'CEASFU', 'O', 'asistenciaFuneraria', 'P', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'RENOVACION', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimientoZurich-SecureConsent', 'P', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (7, 'RENOVACION', 'CRE', 0, 'Formulario KYC', 'KYCGRU', 'O', 'kYCSimplificado', 'P', NULL, NULL)

INSERT INTO cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (8, 'RENOVACION', 'CRE', 0, 'Solicitud Individual Complementaria', 'SICGRU', 'O', 'solicitudCreditoIndividualLarga', 'P', NULL, NULL)

select * from cr_imp_documento where id_toperacion = 'RENOVACION'

-- Documento encontrado en pruebas de humo caso 147999

update cr_imp_documento
set    id_estado     = 'C'
where  id_toperacion = 'GRUPAL'
and    id_producto   = 'CRE'
and    id_mnemonico  = 'CERCON2'


delete cobis..cl_catalogo where tabla = 682 and codigo = 'CRRENGR'
delete cobis..cl_catalogo where tabla = 691 and codigo = 'RENOVACION'

insert into cobis..cl_catalogo values (682,'CRRENGR','CREDITO GRUPAL RENOVACION','V',null,null,null)       
insert into cobis..cl_catalogo values (691,'RENOVACION','CREDITO GRUPAL RENOVACION','V',null,null,null)

go 