/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S119678 Impresión de documentos- Pantalla  - Flujo Grupal
--Fecha                      : 07/07/2017
--Descripción del Problema   : Pasando numero de trámite para reportes
--Descripción de la Solución : Agregar el campo
--Autor                      : Patricio Samueza
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/
-----------------------------------
--Insertando campos en la cr_imp_documento

-----------------------------------
use cob_credito
GO

DECLARE

@w_num_maximo INT

truncate table cob_credito..cr_imp_documento

SELECT @w_num_maximo=max(id_documento+1) FROM cob_credito..cr_imp_documento

SELECT @w_num_maximo =  isnull(@w_num_maximo,1)
---

----
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (@w_num_maximo, 'GRUPAL', 'CRE', 0, 'Solicitud de Crédito Grupal', 'SOLGRP', 'O', 'solicitudCreditoGrupal', 'P', NULL, NULL)

SELECT @w_num_maximo=max(id_documento+1) FROM cob_credito..cr_imp_documento

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (@w_num_maximo, 'GRUPAL', 'CRE', 0, 'Contrato Grupal', 'CONTGRP', 'O', 'contratoInclusion', 'P', NULL, NULL)

SELECT @w_num_maximo=max(id_documento+1) FROM cob_credito..cr_imp_documento

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (@w_num_maximo, 'GRUPAL', 'CRE', 0, 'Reglamento crédito grupal', 'RGLGRP', 'O', 'reglamentoInterno', 'P', NULL, NULL)
----
SELECT @w_num_maximo=max(id_documento+1) FROM cob_credito..cr_imp_documento

INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (@w_num_maximo, 'GRUPAL', 'CRE', 0, 'Aviso de privacidad por Miembro', 'AVIPRIV', 'O', 'avisoAdvertenciaGrupal', 'P', NULL, NULL)

SELECT @w_num_maximo=max(id_documento+1) FROM cob_credito..cr_imp_documento
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (@w_num_maximo, 'GRUPAL', 'CRE', 0, 'Autorizacion de pago Recurrente por Miembro', 'AUTPARE', 'O', 'cargoRecurrenteGrupal', 'P', NULL, NULL)

SELECT @w_num_maximo=max(id_documento+1) FROM cob_credito..cr_imp_documento
INSERT INTO cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (@w_num_maximo, 'GRUPAL', 'CRE', 0, 'Carátula de Crédito Grupal', 'CACRGRP', 'O', 'caratulaCreditoGrupal', 'P', NULL, NULL)
GO

-----------------------------------
--SERVICIO SearchDocuments
-----------------------------------

use cobis
GO

delete cts_serv_catalog
where csc_service_id in ('Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments')
delete ad_servicio_autorizado
where ts_servicio in ('Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments')


INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDocumentsApplicationQuery', 'searchDocuments', '', 21433, NULL, NULL, NULL)

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments', 3, 21, 'R', 0, '10/25/2016 10:09:32', 'V', '10/25/2016 10:09:32')

delete cts_serv_catalog
where csc_service_id in ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication')
delete ad_servicio_autorizado
where ts_servicio in ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication')

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDocumentsApplicationManagment', 'searchDocumentsApplication', '', 21434, NULL, NULL, NULL)


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication', 3, 21, 'R', 0, '10/25/2016 10:09:32', 'V', '10/25/2016 10:09:32')

delete cts_serv_catalog
where csc_service_id in ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication')
delete ad_servicio_autorizado
where ts_servicio in ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication')


INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDocumentsApplicationManagment', 'createDocumentsApplication', '', 21034, NULL, NULL, NULL)


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication', 3, 21, 'R', 0, '10/25/2016 10:09:32', 'V', '10/25/2016 10:09:32')


go

-----------------------------------
--creacion del catalogo ca_tdividendo
-----------------------------------
use cobis
GO
delete cl_catalogo
  from cl_tabla
 where cl_tabla.codigo = cl_catalogo.tabla
  and cl_tabla.tabla in  ('ca_tdividendo')
  
delete cl_tabla
 where cl_tabla.tabla in
   ('ca_tdividendo')     
   
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla,descripcion) values (@w_tabla, 'ca_tdividendo', 'Tipo de Cuota' )

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SO', 'SOLTERO', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CA', 'CASADO', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'DI', 'DIVORCIADO', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'VI', 'VIUDO', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'UN', 'UNION LIBRE', 'V', NULL, NULL, NULL)
GO
-----------------------------------
--ant component
-----------------------------------
use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

select @w_prod_name = 'WF' 
select @w_mo_id = mo_id  
  from cobis..an_module 
 where mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
select @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_name = 'Impresion de Documentos Modal')
begin
	INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, 86070, 'Impresion de Documentos Modal', 'VC_ITCII49_TNYFM_899_TASK.html', 'views/BUSIN/FLCRE/T_FLCRE_68_ITCII49/1.0.0/', 'I', NULL, @w_prod_name) 
end 

GO

---


