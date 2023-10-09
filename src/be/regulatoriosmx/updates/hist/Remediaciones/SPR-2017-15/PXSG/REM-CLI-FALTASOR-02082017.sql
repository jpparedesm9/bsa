/**********************************************************************************************************************/
--No Bug                     : SI
--Título de la Historia      : Bug 127626:CGS-127626 ERROR ETAPA IMPRESIÓN DE DOCUMENTOS PRUEBA INTEGRAL 2
--Fecha                      : 02/08/2017
--Descripción del Problema   : Faltas de ortografía en la descripcion de los reportes
--Descripción de la Solución : Correción de faltas de ortografía en la descripcion de los reportes
--Autor                      : Patricio Samueza
--Instalador                 : cr_imp_documento.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/
/**********************************************************************************************************************/


USE cob_credito
GO

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='SOLGRP')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Solicitud de Crédito Grupal' WHERE  id_mnemonico='SOLGRP'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='CONTGRP')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Contrato Grupal' WHERE id_mnemonico='CONTGRP'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='RGLGRP')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Reglamento Crédito Grupal' WHERE id_mnemonico='RGLGRP'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='AVIPRIV')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Aviso de Privacidad por Miembro' WHERE id_mnemonico='AVIPRIV'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='AUTPARE')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Autorización de Pago Recurrente por Miembro' WHERE id_mnemonico='AUTPARE'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='CACRGRP')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Carátula de Crédito Grupal' WHERE id_mnemonico='CACRGRP'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='PAGGRU')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Pagaré Grupal' WHERE id_mnemonico='PAGGRU'
END


IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='CREIND')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Autorización Pago Recurrente Individual' WHERE id_mnemonico='CREIND'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='CCONCRE')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Carátula de Crédito Individual' WHERE id_mnemonico='CCONCRE'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='FAUTAIND')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Formato de Autorización de Aval' WHERE id_mnemonico='FAUTAIND'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='SCREIN')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Solicitud de Crédito Individual' WHERE id_mnemonico='SCREIN'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='CININD')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Contrato de Inclusión Individual' WHERE id_mnemonico='CININD'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='APRIND')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Aviso de Privacidad Individual' WHERE id_mnemonico='APRIND'
END

IF EXISTS(SELECT 1 FROM cob_credito..cr_imp_documento WHERE  id_mnemonico='PAGIND')
BEGIN
UPDATE  cob_credito..cr_imp_documento SET id_descripcion='Pagaré de Crédito Individual' WHERE id_mnemonico='PAGIND'
END

go

