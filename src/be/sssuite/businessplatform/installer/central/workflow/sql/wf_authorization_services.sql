/**********************************************************************/
/*   Archivo:         wf_authorization_services.sql  	              */
/*   Producto:        WORKFLOW								          */	
/*   Data base:       cobis             		        	     	  */
/**********************************************************************/
/*                     IMPORTANTE                                  	  */
/*   Esta aplicacion es parte de los  paquetes bancarios      	      */
/*   propiedad de COBISCORP.                               		      */
/*   Su uso no autorizado queda  expresamente  prohibido    	      */
/*   asi como cualquier alteracion o agregado hecho  por    	      */
/*   alguno de sus usuarios sin el debido consentimiento    	      */
/*   por escrito de COBISCORP.                                 		  */
/*   Este programa esta protegido por la ley de derechos    	      */
/*   de autor y por las convenciones  internacionales de    		  */
/*   propiedad intelectual.  Su uso  no  autorizado dara    		  */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los    		  */
/*   autores de cualquier infraccion.                       		  */
/**********************************************************************/
/*                     PROPOSITO                            		  */
/*            Autorizacion de los servicios de workflow           	  */
/**********************************************************************/
/*                     MODIFICACIONES                       		  */
/*   FECHA               AUTOR                  RAZON         		  */
/*   15-Abr-2015        Die Castro         Emision Inicial    	  */
/**********************************************************************/


--------------------------------------------------------------------------------------------------------------------
/*================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA cts_serv_catalog  PARA LOS SERVICIOS DE WORKFLOW       */
/*================================================================================================================*/
--------------------------------------------------------------------------------------------------------------------
use cobis
go

delete from ad_servicio_autorizado where ts_servicio in (select csc_service_id from cts_serv_catalog where csc_class_name = 'cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin')
go

delete from cts_serv_catalog where csc_class_name = 'cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin'
go

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateUserToRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateUserToRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateUserToRol',' ',31788,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateUser')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateUser','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateUser','UpdateUser',31791,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateStepPolicy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateStepPolicy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateStepPolicy',' ',31827,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateStepActRequeriment')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateStepActRequeriment','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateStepActRequeriment','updateStepActRequeriment',31820,'T')



if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateStep')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateStep','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateStep','UpdateStep',31755,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateSchedulerTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateSchedulerTask','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateSchedulerTask',' ',1875052,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateRol','UpdateRol',31786,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateResults')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateResults','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateResults','UpdateResults',31796,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateResult')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateResult','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateResult','UpdateResult',31796,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateReqAct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateReqAct','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateReqAct','UpdateReqAct',31770,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateProcessVersion')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateProcessVersion','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateProcessVersion','UpdateProcessVersion',31761,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateProcessVariable')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateProcessVariable','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateProcessVariable',' ',31767,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateProcess','UpdateProcess',31752,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateOrInsertReceptor')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateOrInsertReceptor','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateOrInsertReceptor','UpdateOrInsertReceptor',31785,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateObservation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateObservation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateObservation','UpdateObservation',31807,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateMappingVarProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateMappingVarProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateMappingVarProcess',' ',31784,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateLoadBalance')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateLoadBalance','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateLoadBalance','UpdateLoadBalance',31804,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateLinkRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateLinkRole','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateLinkRole','UpdateLinkRole',31810,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateLink')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateLink','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateLink','UpdateLink',31756,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateLauncherAditionalInformation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateLauncherAditionalInformation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateLauncherAditionalInformation',' ',31785,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateInstanceProcess','updateInstanceProcess',32004,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchyUserTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchyUserTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateHierarchyUserTpl',' ',31825,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchyTypeTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchyTypeTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateHierarchyTypeTpl',' ',31822,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchyItemTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchyItemTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateHierarchyItemTpl',' ',31824,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchyItem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchyItem','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateHierarchyItem',' ',31826,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateHierarchy','UpdateHierarchy',31808,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateHierachyRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateHierachyRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateHierachyRol','UpdateHierachyRol',31809,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateHerarchyLevelTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateHerarchyLevelTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateHierarchyLevelTpl',' ',31823,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateDocumentType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateDocumentType','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateDocumentType','UpdateDocumentType',31800,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateActivityInfo')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateActivityInfo','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateActivityInfo','UpdateActivityInfo',31757,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateActivity')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateActivity','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateActivity','UpdateActivity',31783,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVersionGrid')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVersionGrid','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVersionGrid','QueryVersionGrid',31753,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVersion')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVersion','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVersion','QueryVersion',31753,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVariables')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVariables','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVariables',' ',31763,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVariablePseudoCatalog',' ',31763,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVariableProcessMap')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVariableProcessMap','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVariableProcessMap',' ',31784,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVariablepPseudoCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVariablepPseudoCatalog','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVariablePseudoCatalog',' ',31763,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVariableName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVariableName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVariableName','QueryVariableName',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVariableId')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVariableId','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVariableId','QueryVariableId',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVariableHierarchy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVariableHierarchy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVariableHierarchy',' ',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryVariableAvailable')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryVariableAvailable','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryVariableAvailable','QueryVariableAvailable',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryUsersRolA')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryUsersRolA','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryUsersRolA','QueryUsersRolA',31772,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryUsersRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryUsersRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryUsersRol','QueryUsersRol',31772,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryUsersPseudoCatalog',' ',31772,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryUsersDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryUsersDetail','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryUsersDetail','QueryUsersDetail',31772,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryUsersCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryUsersCatalog','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryUsersCatalog','QueryUsersCatalog',31772,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryUsers')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryUsers','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryUsers','QueryUsers',31772,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryUserName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryUserName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryUserName','QueryUserName',31772,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryTreeProcesses')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryTreeProcesses','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryTreeProcesses','QueryTreeProcesses',31750,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryStepTarget')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryStepTarget','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryStepTarget','QueryStepTarget',31777,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryStepProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryStepProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryStepProcess','QueryStepProcess',31777,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryStepPolicy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryStepPolicy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryStepPolicy',' ',31827,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryStepObservation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryStepObservation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryStepObservation','QueryStepObservation',73554,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryStepN')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryStepN','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryStep','queryStep',181111,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryStepDesc')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryStepDesc','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryStepDesc',' ',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryStepActRequirement')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryStepActRequirement','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryStepActRequirement','queryStepActRequirement',31820,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryStep')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryStep','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryStep','QueryStep',31777,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QuerySchedulerTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QuerySchedulerTask','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','querySchedulerTask',' ',1875054,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryRuleNameByTypeSubtype')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryRuleNameByTypeSubtype','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRuleNameByTypeSubtype','queryRuleNameByTypeSubtype',31820,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryRuleName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryRuleName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRuleName','queryRuleName',31820,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryRolDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryRolDetail','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRolDetail','QueryRolDetail',31773,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRolType','QueryRol',31773,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryResultTree')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryResultTree','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryResultTree','QueryResultTree',31797,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryResultsStep')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryResultsStep','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryResultsStep','QueryResultsStep',31777,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryResultsAvailable')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryResultsAvailable','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryResultsAvailable','QueryResultsAvailable',31777,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryResultName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryResultName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryResultName','QueryResultName',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryResultId')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryResultId','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryResultId','QueryResultId',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryResultDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryResultDetail','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryResultDetail','QueryResultDetail',31797,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryRequirementsActivity')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryRequirementsActivity','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRequirementsActivity','QueryRequirementsActivity',31766,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryReesultsDetails')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryReesultsDetails','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryReesultsDetails','QueryReesultsDetails',31797,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryReesults')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryReesults','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryReesults','QueryReesults',31797,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryProcessVariable')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryProcessVariable','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryProcessVariable','QueryProcessVariable',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryProcessTemplatesByType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryProcessTemplatesByType','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryProcessTemplatesByType','QueryProcessTemplatesByType',31750,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryProcessTemplates')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryProcessTemplates','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryProcessTemplates','QueryProcessTemplates',31750,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryProcessName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryProcessName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryProcessName','QueryProcessName',31750,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryProcessLink')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryProcessLink','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryProcessLink','QueryProcessLink',31754,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryProcessErrors')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryProcessErrors','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryProcessErrors',' ',32283,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryProccessVersion')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryProccessVersion','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryProccessVersion',' ',31750,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryParameterDesc')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryParameterDesc','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryParameterDesc',' ',31813,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryObservationsTree')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryObservationsTree','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryObservationsTree','QueryObservationsTree',31806,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryNotificationTemplate')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryNotificationTemplate','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryNotificationTemplate','QueryNotificationTemplate',31900,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryNameProgram')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryNameProgram','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryProgramName','QueryNameProgram',31774,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryMaintenanceRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryMaintenanceRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRolMaintenance','QueryMaintenanceRol',31773,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryLoadBalanceName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryLoadBalanceName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryLoadBalanceName','queryLoadBalanceName',31820,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryLoadBalanceDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryLoadBalanceDetail','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryLoadBalanceDetail','QueryLoadBalanceDetail',31776,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryLoadBalance')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryLoadBalance','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryLoadBalance','QueryLoadBalance',31776,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryLinkRoleDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryLinkRoleDetail','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryLinkRoleDetail',' ',31758,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryLinkRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryLinkRole','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryLinkRole','QueryLinkRole',31758,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryLinkDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryLinkDetail','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryLinkDetail','QueryLinkDetail',31758,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryLink')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryLink','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryLink','QueryLink',31778,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryLauncherAditionalInformation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryLauncherAditionalInformation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryLauncherAditionalInformation','QueryLauncherAditionalInformation',31785,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryInstructionName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryInstructionName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryInstructionName','QueryInstructionName',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryInstructionId')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryInstructionId','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryInstructionId','QueryInstructionId',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryInstruction')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryInstruction','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryInstruction','QueryInstruction',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryInformativeAditionalInformation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryInformativeAditionalInformation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryInformativeAditionalInformation','QueryInformativeAditionalInformation',31785,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyUserTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyUserTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyUserTpl',' ',31825,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyProcess',' ',31901,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyName','queryHierarchyName',31820,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyMembers')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyMembers','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyMembers','QueryHierarchyMembers',31758,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTplByHierarchy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTplByHierarchy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyItemTplByHierarchy','queryHierarchyItemTplByHierarchy',31824,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyItemTpl',' ',31824,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyItem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyItem','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyItem',' ',31826,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHerarchyTypeTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHerarchyTypeTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyTypeTpl',' ',31822,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryExceptionName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryExceptionName','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryExceptionName','QueryExceptionName',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryExceptionId')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryExceptionId','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryExceptionId','QueryExceptionId',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryException')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryException','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryException','QueryException',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryDocumentTypes')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryDocumentTypes','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryDocumentTypes','QueryDocumentTypes',31766,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryDocumentsTypeActivity')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryDocumentsTypeActivity','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryDocumentsTypeActivity','QueryDocumentsTypeActivity',31766,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryDinamicCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryDinamicCatalog','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryDinamicCatalog',' ',1875055,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryDetailProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryDetailProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryDetailProcess','QueryDetailProcess',31750,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryDetailDocumentTypes')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryDetailDocumentTypes','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryDetailDocumentTypes','QueryDetailDocumentTypes',31766,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryDestinationVersionActivity')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryDestinationVersionActivity','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryDestinationVersionActivity','QueryDestinationVersionActivity',73511,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryDescriptionSched')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryDescriptionSched','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryDescriptionSched',' ',1875055,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryConditionDesc')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryConditionDesc','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryConditionDesc',' ',31779,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryChildHierarchyItemTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryChildHierarchyItemTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryChildHierarchyItemTpl','queryChildHierarchyItemTpl',31824,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryCatalogProcessByDescription','queryCatalogProcessByDescription',99992,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryCatalogProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryCatalogProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryCatalogProcess','queryCatalogProcess',99992,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryAvailableObservation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryAvailableObservation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryAvailableObservation','QueryAvailableObservation',73554,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryAllStepPolicy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryAllStepPolicy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryAllStepPolicy',' ',31827,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryAllHierarchyTypeTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryAllHierarchyTypeTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryAllHierarchyTypeTpl',' ',31822,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryAllHierarchyItem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryAllHierarchyItem','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryAllHierarchyItem',' ',31826,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryActivityExisting')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryActivityExisting','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryActivityExisting','QueryActivityExisting',31754,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryActivityDetails')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryActivityDetails','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryActivityDetails','QueryActivityDetails',31754,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryActivity')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryActivity','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryActivity','QueryActivity',31754,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertUser')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertUser','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertUser','InsertUser',31791,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertStepPolicy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertStepPolicy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertStepPolicy',' ',31827,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertStep')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertStep','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertStep','InsertStep',31755,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertSchedulerTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertSchedulerTask','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertSchedulerTask',' ',1875051,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertRol','InsertRol',31786,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertResults')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertResults','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertResults','InsertResults',31796,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertResult')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertResult','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertResult','InsertResult',31796,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertReqAct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertReqAct','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertReqAct','InsertReqAct',31770,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertProcessVersion')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertProcessVersion','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertProcessVersion','InsertProcessVersion',31761,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertProcessVariable')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertProcessVariable','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertProcessVariable',' ',31767,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertProcess','InsertProcess',31752,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertOptAct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertOptAct','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertOptAct','insertOptAct',31820,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertObservation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertObservation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertObservation','InsertObservation',31807,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertMappingVarProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertMappingVarProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertMappingVarProcess',' ',31784,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertLoadBalance')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertLoadBalance','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertLoadBalance','InsertLoadBalance',31804,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertLinkRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertLinkRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertLinkRol','InsertLinkRol',31810,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertLink')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertLink','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertLink','InsertLink',31756,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertLauncherAditionalInformation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertLauncherAditionalInformation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertLauncherAditionalInformation','InsertLauncherAditionalInformation',31785,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertHierarchyUserTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchyUserTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertHierarchyUserTpl',' ',31825,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertHierarchyTypeTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchyTypeTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertHierarchyTypeTpl',' ',31822,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertHierarchyItemTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchyItemTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertHierarchyItemTpl',' ',31824,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertHierarchyItem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchyItem','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertHierarchyItem',' ',31826,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertHierarchy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteHierarchy','InsertHierarchy',31808,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertHierachyRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertHierachyRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertHierachyRol','InsertHierachyRol',31809,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertHierachy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertHierachy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertHierachy','InsertHierachy',31808,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertHerarchyLevelTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertHerarchyLevelTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertHierarchyLevelTpl',' ',31823,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertDocumentType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertDocumentType','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertDocumentType','InsertDocumentType',31800,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertAllHierarchyItem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertAllHierarchyItem','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertAllHierarchyItem',' ',31826,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertActivityObservation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertActivityObservation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertActivityObservation','InsertActivityObservation',73554,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertActivityInfo')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertActivityInfo','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertActivityInfo','InsertActivityInfo',31757,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertActivity')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertActivity','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertActivity','InsertActivity',31783,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.GetTaskFlow')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.GetTaskFlow','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','getTaskFlow','GetTaskFlow',73529,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DisassociateUserToRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DisassociateUserToRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','disassociateUserToRol','DisassociateUserToRol',31788,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteUser')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteUser','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteUser','DeleteUser',31791,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteStepPolicy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteStepPolicy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteStepPolicy',' ',31827,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteStep')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteStep','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteStep','DeleteStep',31755,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteSchedulerTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteSchedulerTask','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteSchedulerTask',' ',1875053,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteRol','DeleteRol',31786,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteResults')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteResults','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteResults','DeleteResults',31796,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteResult')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteResult','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteResult','DeleteResult',31796,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteReqAct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteReqAct','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteReqAct','DeleteReqAct',31770,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteReceptor')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteReceptor','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteReceptor',' ',31785,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteProcessVersion')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteProcessVersion','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteProcessVersion','deleteProcessVersion',31761,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteProcess','DeleteProcess',31752,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteOptAct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteOptAct','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteOptAct','deleteOptAct',31820,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteObservation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteObservation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteObservation','DeleteObservation',31807,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteMappingVarProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteMappingVarProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteMappingVarProcess',' ',31784,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteLoadBalance')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteLoadBalance','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteLoadBalance','DeleteLoadBalance',31804,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteLinkRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteLinkRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteLinkRol','DeleteLinkRol',31810,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteLink')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteLink','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteLink','DeleteLink',31756,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteLauncherAditionalInformation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteLauncherAditionalInformation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteLauncherAditionalInformation',' ',31785,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteHierarchyUserTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteHierarchyUserTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteHierarchyUserTpl',' ',31825,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteHierarchyItemTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteHierarchyItemTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteHierarchyItemTpl',' ',31824,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteHierarchyItem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteHierarchyItem','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteHierarchyItem',' ',31826,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteHierarchy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteHierarchy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteHierarchy','UpdateLinkRole',31808,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteHierachyRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteHierachyRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteHierachyRol','DeleteHierachyRol',31809,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteHerarchyTypeTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteHerarchyTypeTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteHierarchyTypeTpl',' ',31822,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteHerarchyLevelTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteHerarchyLevelTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteHierarchyLevelTpl',' ',31823,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteDocumentType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteDocumentType','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteDocumentType','DeleteDocumentType',31800,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteActivityObservation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteActivityObservation','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteActivityObservation','DeleteActivityObservation',73554,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteActivityLaunch')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteActivityLaunch','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteActivityLaunch',' ',31761,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteActivity')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteActivity','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteActivity','DeleteActivity',31783,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.CloneTemplate')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.CloneTemplate','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','cloneTemplate','CloneTemplate',31816,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.AssociateUserToRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.AssociateUserToRol','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','associateUserToRol','AssociateUserToRol',31788,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.ActivityInfo')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.ActivityInfo','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertActivityInfo',' ',31757,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteLinkCondition')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteLinkCondition','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteLinkCondition',' ',31759,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertLinkCondition')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertLinkCondition','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertLinkCondition',' ',31759,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateLinkCondition')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.UpdateLinkCondition','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateLinkCondition',' ',31759,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHerarchyLevelTpl')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHerarchyLevelTpl','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyLevelTpl',' ',31823,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryHierarchyLevelProcessInstance',' ',21812,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.RecoverUser')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.RecoverUser','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','recoverUser',' ',3886,'T')


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRuleProcessHistory',' ',32285,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryRuleHistory')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryRuleHistory','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRuleHistory',' ',32285,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryRuleInstanceProcess',' ',32285,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryPaletteActivities')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryPaletteActivities','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryPaletteActivities',' ',31754,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteProcessVariable')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteProcessVariable','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteProcessVariable',' ',31767,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.ObtenerResumen')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.ObtenerResumen','cobiscorp.ecobis.wfmonitor.service.IProceso','obtenerResumen',' ',73802,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.GetSummaryByProcessId')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.GetSummaryByProcessId','cobiscorp.ecobis.wfmonitor.service.IProceso','getSummaryByProcessId',' ',73801,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.GetProcessVersions')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.GetProcessVersions','cobiscorp.ecobis.wfmonitor.service.IProceso','queryProcessVersions',' ',73804,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.QueryActivities')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.QueryActivities','cobiscorp.ecobis.wfmonitor.service.IProceso','queryActivities',' ',73803,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.GetActivitySummary')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.GetActivitySummary','cobiscorp.ecobis.wfmonitor.service.IProceso','getActivitySummary',' ',73800,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.GetOfficeByUser')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.GetOfficeByUser','cobiscorp.ecobis.wfmonitor.service.IProceso','getOfficeByUser',' ',73805,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.EvaluatePolicy')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Workflow.Admin.WorkflowAdmin.EvaluatePolicy','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','evaluatePolicy',' ',31829)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.UpdateRuleHistory')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Workflow.Admin.WorkflowAdmin.UpdateRuleHistory','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','updateRuleHistory',' ',32285)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryActivitiesRequirements',' ',31770)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.ClaimTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Workflow.Admin.WorkflowAdmin.ClaimTask','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','claimTask',' ',31770)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetScalarUsers')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('HTM.API.HumanTask.GetScalarUsers','cobiscorp.ecobis.htm.api.service.IHumanTask','getScalarUsers','', 31831,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetTakeUsers')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('HTM.API.HumanTask.GetTakeUsers','cobiscorp.ecobis.htm.api.service.IHumanTask','getTakeUsers','', 31832,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryExceptionApprovedByStep')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryExceptionApprovedByStep','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryExceptionApprovedByStep','', 31830,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryExceptedReqApproved')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryExceptedReqApproved','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryExceptedReqApproved','', 31830,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertExceptedReqApproved')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertExceptedReqApproved','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertExceptedReqApproved','', 31830,'T')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteExceptedReqApproved')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteExceptedReqApproved','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteExceptedReqApproved','', 31830,'T')

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetApprovedExceptionsByProcessInstanceOrCode')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('HTM.API.HumanTask.GetApprovedExceptionsByProcessInstanceOrCode','cobiscorp.ecobis.htm.api.service.IHumanTask','getApprovedExceptionsByProcessInstanceOrCode','', 31830,'T')

if not exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.QueryTaskView')
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.QueryTaskView','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','queryTaskView','QueryTaskView',73550,'T')

if not exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.InsertTaskView')
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.InsertTaskView','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','insertTaskView','InsertTaskView',73551,'T')

if not exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'Workflow.Admin.WorkflowAdmin.DeleteTaskView')
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('Workflow.Admin.WorkflowAdmin.DeleteTaskView','cobiscorp.ecobis.workflow.admin.service.IWorkflowAdmin','deleteTaskView','InsertTaskView',73551,'T')

------------------------------------------------------------------------------------------------------------------------------------
/*================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_servicio_autorizado  PARA AUTORIZAR LOS SERVICIOS DE WORKFLOW       */
/*================================================================================================================================*/
------------------------------------------------------------------------------------------------------------------------------------
declare @w_rol int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.ActivityInfo')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.ActivityInfo',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.AssociateUserToRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.AssociateUserToRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.CloneTemplate')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.CloneTemplate',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteActivity')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteActivity',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteActivityLaunch')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteActivityLaunch',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteActivityObservation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteActivityObservation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteDocumentType')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteDocumentType',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteHerarchyLevelTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteHerarchyLevelTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteHerarchyTypeTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteHerarchyTypeTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteHierachyRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteHierachyRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteHierarchy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteHierarchy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteHierarchyItem')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteHierarchyItem',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteHierarchyItemTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteHierarchyItemTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteHierarchyUserTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteHierarchyUserTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteLauncherAditionalInformation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteLauncherAditionalInformation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteLink')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteLink',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteLinkCondition')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteLinkCondition',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteLinkRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteLinkRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteLoadBalance')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteLoadBalance',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteMappingVarProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteMappingVarProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteObservation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteObservation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteOptAct')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteOptAct',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteProcessVersion')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteProcessVersion',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteReceptor')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteReceptor',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteReqAct')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteReqAct',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteResult')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteResult',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteResults')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteResults',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteSchedulerTask')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteSchedulerTask',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteStep')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteStep',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteStepPolicy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteStepPolicy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteUser')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteUser',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DisassociateUserToRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DisassociateUserToRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.GetTaskFlow')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.GetTaskFlow',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertActivity')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertActivity',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertActivityInfo')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertActivityInfo',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertActivityObservation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertActivityObservation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertAllHierarchyItem')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertAllHierarchyItem',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertDocumentType')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertDocumentType',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertHerarchyLevelTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertHerarchyLevelTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertHierachy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertHierachy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertHierachyRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertHierachyRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertHierarchy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertHierarchyItem')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchyItem',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertHierarchyItemTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchyItemTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertHierarchyTypeTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchyTypeTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertHierarchyUserTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertHierarchyUserTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertLauncherAditionalInformation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertLauncherAditionalInformation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertLink')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertLink',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertLinkCondition')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertLinkCondition',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertLinkRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertLinkRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertLoadBalance')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertLoadBalance',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertMappingVarProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertMappingVarProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertObservation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertObservation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertOptAct')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertOptAct',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertProcessVariable')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertProcessVariable',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertProcessVersion')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertProcessVersion',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertReqAct')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertReqAct',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertResult')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertResult',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertResults')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertResults',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertSchedulerTask')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertSchedulerTask',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertStep')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertStep',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertStepPolicy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertStepPolicy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertUser')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertUser',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryActivity')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryActivity',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryActivityDetails')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryActivityDetails',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryActivityExisting')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryActivityExisting',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryAllHierarchyItem')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryAllHierarchyItem',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryAllHierarchyTypeTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryAllHierarchyTypeTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryAllStepPolicy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryAllStepPolicy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryAvailableObservation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryAvailableObservation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryCatalogProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryCatalogProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryChildHierarchyItemTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryChildHierarchyItemTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryConditionDesc')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryConditionDesc',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryDescriptionSched')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryDescriptionSched',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryDestinationVersionActivity')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryDestinationVersionActivity',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryDetailDocumentTypes')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryDetailDocumentTypes',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryDetailProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryDetailProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryDinamicCatalog')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryDinamicCatalog',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryDocumentTypes')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryDocumentTypes',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryDocumentsTypeActivity')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryDocumentsTypeActivity',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryException')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryException',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryExceptionId')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryExceptionId',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryExceptionName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryExceptionName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHerarchyTypeTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHerarchyTypeTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyItem')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyItem',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTplByHierarchy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTplByHierarchy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyMembers')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyMembers',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHierarchyUserTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHierarchyUserTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryInformativeAditionalInformation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryInformativeAditionalInformation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryInstruction')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryInstruction',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryInstructionId')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryInstructionId',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryInstructionName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryInstructionName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryLauncherAditionalInformation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryLauncherAditionalInformation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryLink')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryLink',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryLinkDetail')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryLinkDetail',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryLinkRole')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryLinkRole',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryLinkRoleDetail')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryLinkRoleDetail',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryLoadBalance')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryLoadBalance',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryLoadBalanceDetail')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryLoadBalanceDetail',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryLoadBalanceName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryLoadBalanceName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryMaintenanceRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryMaintenanceRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryNameProgram')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryNameProgram',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryNotificationTemplate')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryNotificationTemplate',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryObservationsTree')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryObservationsTree',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryParameterDesc')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryParameterDesc',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryProccessVersion')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryProccessVersion',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryProcessErrors')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryProcessErrors',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryProcessLink')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryProcessLink',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryProcessName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryProcessName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryProcessTemplates')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryProcessTemplates',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryProcessTemplatesByType')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryProcessTemplatesByType',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryProcessVariable')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryProcessVariable',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryReesults')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryReesults',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryReesultsDetails')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryReesultsDetails',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryRequirementsActivity')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryRequirementsActivity',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryResultDetail')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryResultDetail',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryResultId')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryResultId',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryResultName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryResultName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryResultTree')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryResultTree',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryResultsAvailable')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryResultsAvailable',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryResultsStep')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryResultsStep',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryRolDetail')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryRolDetail',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryRuleName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryRuleName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryRuleNameByTypeSubtype')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryRuleNameByTypeSubtype',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QuerySchedulerTask')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QuerySchedulerTask',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryStep')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryStep',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryStepActRequirement')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryStepActRequirement',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryStepDesc')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryStepDesc',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryStepN')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryStepN',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryStepObservation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryStepObservation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryStepPolicy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryStepPolicy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryStepProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryStepProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryStepTarget')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryStepTarget',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryTreeProcesses')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryTreeProcesses',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryUserName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryUserName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryUsers')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryUsers',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryUsersCatalog')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryUsersCatalog',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryUsersDetail')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryUsersDetail',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryUsersRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryUsersRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryUsersRolA')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryUsersRolA',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVariableAvailable')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVariableAvailable',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVariableHierarchy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVariableHierarchy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVariableId')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVariableId',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVariableName')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVariableName',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVariableProcessMap')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVariableProcessMap',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVariablepPseudoCatalog')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVariablepPseudoCatalog',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVariables')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVariables',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVersion')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVersion',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryVersionGrid')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryVersionGrid',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateActivity')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateActivity',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateActivityInfo')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateActivityInfo',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateDocumentType')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateDocumentType',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateHerarchyLevelTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateHerarchyLevelTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateHierachyRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateHierachyRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchyItem')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchyItem',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchyItemTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchyItemTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchyTypeTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchyTypeTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateHierarchyUserTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateHierarchyUserTpl',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateLauncherAditionalInformation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateLauncherAditionalInformation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateLink')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateLink',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateLinkCondition')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateLinkCondition',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateLinkRole')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateLinkRole',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateLoadBalance')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateLoadBalance',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateMappingVarProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateMappingVarProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateObservation')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateObservation',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateOrInsertReceptor')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateOrInsertReceptor',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateProcess',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateProcessVariable')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateProcessVariable',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateProcessVersion')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateProcessVersion',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateReqAct')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateReqAct',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateResult')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateResult',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateResults')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateResults',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateSchedulerTask')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateSchedulerTask',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateStep')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateStep',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateStepActRequeriment')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateStepActRequeriment',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateStepPolicy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateStepPolicy',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateUser')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateUser',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateUserToRol')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateUserToRol',@w_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryHerarchyLevelTpl')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryHerarchyLevelTpl',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.RecoverUser')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.RecoverUser',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryRuleHistory')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryRuleHistory',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryPaletteActivities')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryPaletteActivities',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteProcessVariable')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteProcessVariable',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.ObtenerResumen')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.ObtenerResumen',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.GetSummaryByProcessId')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.GetSummaryByProcessId',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.GetProcessVersions')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.GetProcessVersions',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.QueryActivities')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.QueryActivities',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.GetActivitySummary')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.GetActivitySummary',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.GetOfficeByUser')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.GetOfficeByUser',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.EvaluatePolicy')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.EvaluatePolicy',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.UpdateRuleHistory')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.UpdateRuleHistory',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.ClaimTask')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.ClaimTask',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetScalarUsers')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetScalarUsers',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetTakeUsers')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetTakeUsers',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryExceptionApprovedByStep')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryExceptionApprovedByStep',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryExceptedReqApproved')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryExceptedReqApproved',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertExceptedReqApproved')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertExceptedReqApproved',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteExceptedReqApproved')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteExceptedReqApproved',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetApprovedExceptionsByProcessInstanceOrCode')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetApprovedExceptionsByProcessInstanceOrCode',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.QueryTaskView')
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.QueryTaskView',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.InsertTaskView')
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.InsertTaskView',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'Workflow.Admin.WorkflowAdmin.DeleteTaskView')
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Workflow.Admin.WorkflowAdmin.DeleteTaskView',@w_rol,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
select ts_servicio, @w_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod       
from cobis..ad_servicio_autorizado
where ts_servicio not in (select ts_servicio from cobis..ad_servicio_autorizado where ts_rol = @w_rol)
and   ts_rol = 1

go
