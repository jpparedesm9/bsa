--Mantenimiento tabla cr_imp_documento


use cob_credito 
go 


truncate table cr_imp_documento
go

--PRODUCTO GRUPAL

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'GRUPAL', 'CRE', 0, 'Solicitud de Crédito Grupal', 'SOLGRP', 'O', 'solicitudCreditoGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'GRUPAL', 'CRE', 0, 'Contrato Grupal', 'CONTGRP', 'O', 'contratoInclusion', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'GRUPAL', 'CRE', 0, 'Reglamento crédito grupal', 'RGLGRP', 'O', 'reglamentoInterno', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (4, 'GRUPAL', 'CRE', 0, 'Aviso de privacidad por Miembro', 'AVIPRIV', 'O', 'avisoAdvertenciaGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'GRUPAL', 'CRE', 0, 'Autorizacion de pago Recurrente por Miembro', 'AUTPARE', 'O', 'cargoRecurrenteGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'GRUPAL', 'CRE', 0, 'Carátula de Crédito Grupal', 'CACRGRP', 'O', 'caratulaCreditoGrupal', 'P', NULL, NULL)
GO