-------Req.185234 - Seguros Individual 
use cob_credito
go

delete cr_imp_documento where id_mnemonico in ('CERCONIND','CEASFUIND') and id_toperacion ='INDIVIDUAL' 

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (11, 'INDIVIDUAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCONIND', 'O', 'certificadoConsentimientoZurich-SecureConsent', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (12, 'INDIVIDUAL', 'CRE', 0, 'Certificado Asistencia Funeraria', 'CEASFUIND', 'O', 'asistenciaFuneraria', 'P', NULL, NULL)
GO
