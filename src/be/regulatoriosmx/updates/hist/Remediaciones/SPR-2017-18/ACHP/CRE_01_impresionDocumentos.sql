
--Mantenimiento tabla cr_imp_documento
--Se toma de la ruta: $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/cr_imp_documento.sql
--Porque no se encuentra en sustainig completo

use cob_credito 
go 


IF OBJECT_ID ('dbo.cr_imp_documento') IS NOT NULL
	DROP TABLE dbo.cr_imp_documento
GO

CREATE TABLE dbo.cr_imp_documento
	(
	id_documento    SMALLINT 	NOT NULL,
	id_toperacion   catalogo 	NOT NULL,
	id_producto     catalogo 	NOT NULL,
	id_moneda       TINYINT  	NULL,
	id_descripcion  descripcion NOT NULL,
	id_mnemonico    catalogo 	NOT NULL,
	id_tipo_tramite CHAR (4) 	NULL,
	id_template     descripcion NULL,
	id_estado       CHAR (4) 	NULL,
	id_dato         VARCHAR(64) NULL,
	id_medio        CHAR (4) 	NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_imp_documento_Key
	ON dbo.cr_imp_documento (id_documento, id_toperacion)
GO

use cob_credito 
go 

delete cr_imp_documento
GO

use cob_credito 
go
--PRODUCTO GRUPAL

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'GRUPAL', 'CRE', 0, 'Solicitud de Crédito Grupal', 'SOLGRP', 'O', 'solicitudCreditoGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'GRUPAL', 'CRE', 0, 'Contrato Grupal', 'CONTGRP', 'O', 'contratoInclusion', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'GRUPAL', 'CRE', 0, 'Reglamento Crédito Grupal', 'RGLGRP', 'O', 'reglamentoInterno', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (4, 'GRUPAL', 'CRE', 0, 'Aviso de Privacidad por Miembro', 'AVIPRIV', 'O', 'avisoAdvertenciaGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'GRUPAL', 'CRE', 0, 'Autorización de Pago Recurrente por Miembro', 'AUTPARE', 'O', 'cargoRecurrenteGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'GRUPAL', 'CRE', 0, 'Carátula de Crédito Grupal', 'CACRGRP', 'O', 'caratulaCreditoGrupal', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (7, 'GRUPAL', 'CRE', 0, 'Pagaré Grupal', 'PAGGRU', 'O', 'pagare', 'P', NULL, NULL)
GO
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (8, 'GRUPAL', 'CRE', 0, 'Tabla Amortización', 'TABGRU', 'O', 'tablaAmortizacion', 'P', NULL, NULL)
GO

--Individual
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'INDIVIDUAL', 'CRE', 0, 'Autorización Pago Recurrente Individual', 'CREIND', 'O', 'cargoRecurrenteIndiv', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'INDIVIDUAL', 'CRE', 0, 'Carátula de Crédito Individual', 'CCONCRE', 'O', 'caratulaContratoCredito', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'INDIVIDUAL', 'CRE', 0, 'Formato de Autorización de Aval', 'FAUTAIND', 'O', 'formatAutorizacionAvalInd', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (4, 'INDIVIDUAL', 'CRE', 0, 'Solicitud de Crédito Individual', 'SCREIN', 'O', 'solicitudCreditoIndividual', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (5, 'INDIVIDUAL', 'CRE', 0, 'Contrato de Inclusión Individual', 'CININD', 'O', 'contratoInclusionIndividual', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (6, 'INDIVIDUAL', 'CRE', 0, 'Aviso de Privacidad Individual', 'APRIND', 'O', 'avisoPrivacidadIndividual', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (7, 'INDIVIDUAL', 'CRE', 0, 'Pagaré de Crédito Individual', 'PAGIND', 'O', 'pagare', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (8, 'INDIVIDUAL', 'CRE', 0, 'Tabla Amortización', 'TABIND', 'O', 'tablaAmortizacion', 'P', NULL, NULL)
GO
