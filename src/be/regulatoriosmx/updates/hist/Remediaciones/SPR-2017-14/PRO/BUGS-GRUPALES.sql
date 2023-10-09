use cobis
go

delete from cl_parametro where pa_nemonico='NASOF'
go
insert into cl_parametro 
values ('NOMBRE APODERADO SOFOM','NASOF','C','Alberto Ruiz',null,null,null,null,null,null,'CRE')
go
use cob_credito
go
delete from cr_imp_documento where id_toperacion in ('GRUPAL','INDIVIDUAL')
go

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'GRUPAL', 'CRE', 0, 'Solicitud de Credito Grupal', 'SOLGRP', 'O', 'solicitudCreditoGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'GRUPAL', 'CRE', 0, 'Contrato Grupal', 'CONTGRP', 'O', 'contratoInclusion', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'GRUPAL', 'CRE', 0, 'Reglamento credito grupal', 'RGLGRP', 'O', 'reglamentoInterno', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (4, 'GRUPAL', 'CRE', 0, 'Aviso de privacidad por Miembro', 'AVIPRIV', 'O', 'avisoAdvertenciaGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'GRUPAL', 'CRE', 0, 'Autorizacion de pago Recurrente por Miembro', 'AUTPARE', 'O', 'cargoRecurrenteGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'GRUPAL', 'CRE', 0, 'Caratula de Credito Grupal', 'CACRGRP', 'O', 'caratulaCreditoGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (7, 'GRUPAL', 'CRE', 0, 'Pagare de Credito Grupal', 'PAGGRU', 'O', 'formatPagareMain', 'P', NULL, NULL)
GO

--Individual
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'INDIVIDUAL', 'CRE', 0, 'Autorizacion Pago Recurrente Individual', 'CREIND', 'O', 'cargoRecurrenteIndiv', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'INDIVIDUAL', 'CRE', 0, 'Caratula de Credito Individual', 'CCONCRE', 'O', 'caratulaContratoCredito', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'INDIVIDUAL', 'CRE', 0, 'Formato de Autorizacion de Aval', 'FAUTAIND', 'O', 'formatAutorizacionAvalInd', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (4, 'INDIVIDUAL', 'CRE', 0, 'Solicitud de Credito Individual', 'SCREIN', 'O', 'solicitudCreditoIndividual', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'INDIVIDUAL', 'CRE', 0, 'Contrato de Inclusion Individual', 'CININD', 'O', 'contratoInclusionIndividual', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'INDIVIDUAL', 'CRE', 0, 'Aviso de Privacidad Individual', 'APRIND', 'O', 'avisoPrivacidadIndividual', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (7, 'INDIVIDUAL', 'CRE', 0, 'Pagare de Credito Individual', 'PAGIND', 'O', 'pagareIndividual', 'P', NULL, NULL)
GO
