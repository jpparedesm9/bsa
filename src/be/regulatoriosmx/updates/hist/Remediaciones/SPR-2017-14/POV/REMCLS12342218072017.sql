/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S123422 Cuestionario Verificación de Datos - Flujo Individual
--Fecha                      : 18/07/2017
--Descripción del Problema   : Pantalla de Cuestionario en creditos individuales
--Descripción de la Solución : Agregar Modificaciones necesarias para integrar pantalla
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

-----------------------------------------------
---    Modificación de Tipo de Dato
-----------------------------------------------
--Instalador                 : cl_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
use cobis
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'en_nac_aux' AND TABLE_NAME = 'cl_ente')
BEGIN
    ALTER TABLE cl_ente ALTER COLUMN en_nac_aux varchar(10) null
END

-----------------------------------------------
---Insertando an_component
-----------------------------------------------
--Instalador                 : an_component.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql

use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

SELECT @w_prod_name = 'WF' 
SELECT @w_mo_id = mo_id  
from   cobis..an_module 
where  mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
SELECT @w_mo_id = isnull(@w_mo_id ,1)


SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Verificación de Datos - GRUPAL')
begin
    INSERT INTO dbo.an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    VALUES (@w_co_id, @w_mo_id, 'Verificación de Datos - GRUPAL', 'VC_DATAVERITO_790838_TASK.html?SOLICITUD=GRUPAL', 'views/BUSIN/FLCRE/T_BUSINSFKMIYJN_838/1.0.0/', 'I', NULL, @w_prod_name)
end


SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component
IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Verificación de Datos - INDIVIDUAL')
begin
    INSERT INTO dbo.an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    VALUES (@w_co_id, @w_mo_id, 'Verificación de Datos - INDIVIDUAL', 'VC_DATAVERITO_790838_TASK.html?SOLICITUD=NORMAL', 'views/BUSIN/FLCRE/T_BUSINSFKMIYJN_838/1.0.0/', 'I', NULL, @w_prod_name)
end
GO



-----------------------------------------------
---AUTORIZAR SERVICIO
-----------------------------------------------
--Instalador                 : cl_services_authorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql

use cobis
go
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'LoanGroup.MemberMaintenance.SearchDebtor')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', csc_method_name = 'searchDebtor', csc_description = '', csc_trn = 810 WHERE csc_service_id = 'LoanGroup.MemberMaintenance.SearchDebtor'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('LoanGroup.MemberMaintenance.SearchDebtor', 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', 'searchDebtor', '', 810)
      go


use cobis
go
declare @w_rol int, @w_producto int
	  
      select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
      select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
	  
      
      DELETE cobis..ad_servicio_autorizado where ts_servicio = 'LoanGroup.MemberMaintenance.SearchDebtor'
      INSERT INTO cobis..ad_servicio_autorizado values('LoanGroup.MemberMaintenance.SearchDebtor', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
        print 'insert en ad_servicio_autorizado'


-----------------------------------------------
--- MODIFICAR TABLA cr_imp_documento
-----------------------------------------------
--Instalador                 : cr_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
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
		
		
		
		
		
-----------------------------------------------
---Insertar nuevos valores en la tabla
-----------------------------------------------
--Instalador                 : cl_services_authorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql


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
--Individual
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (1, 'INDIVIDUAL', 'CRE', 0, 'Autorización Pago Recurrente Individual', 'CREIND', 'O', 'cargoRecurrenteIndiv', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (2, 'INDIVIDUAL', 'CRE', 0, 'Carátula de Crédito Individual', 'CCONCRE', 'O', 'caratulaContratoCredito', 'P', NULL, NULL)
GO

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (3, 'INDIVIDUAL', 'CRE', 0, 'Formato de Autorizacion de Aval', 'FAUTAIND', 'O', 'formatAutorizacionAvalInd', 'P', NULL, NULL)
GO
