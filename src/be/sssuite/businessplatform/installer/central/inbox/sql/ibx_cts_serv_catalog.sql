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
/*   15-Abr-2015        Alex Carrillo         Emision Inicial    	  */
/**********************************************************************/


--------------------------------------------------------------------------------------------------------------------
/*================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA cts_serv_catalog  PARA LOS SERVICIOS DE INBOX          */
/*================================================================================================================*/
--------------------------------------------------------------------------------------------------------------------

use cobis
go

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Dummy.DummyClass.UpdateVariable')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Dummy.DummyClass.UpdateVariable','cobiscorp.ecobis.dummy.service.IDummyClass','updateVariable',' ',73501)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Dummy.DummyClass.GetProcessUser')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Dummy.DummyClass.GetProcessUser','cobiscorp.ecobis.dummy.service.IDummyClass','getProcessUser',' ',73500)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.UpdateRequirementByProcessWithObservation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.UpdateRequirementByProcessWithObservation','cobiscorp.ecobis.htm.api.service.IHumanTask','updateRequirementByProcessWithObservation',' ',31770)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.UpdateRequirementByProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.UpdateRequirementByProcess','cobiscorp.ecobis.htm.api.service.IHumanTask','updateRequirementByProcess',' ',31770)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.SuspendTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.SuspendTask','cobiscorp.ecobis.htm.api.service.IHumanTask','suspendTask',' ',73518)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.ResumeTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.ResumeTask','cobiscorp.ecobis.htm.api.service.IHumanTask','resumeTask',' ',73517)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.ReassignTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.ReassignTask','cobiscorp.ecobis.htm.api.service.IHumanTask','reassignTask',' ',73516)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.QueryUsersWorkflow')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.QueryUsersWorkflow','cobiscorp.ecobis.htm.api.service.IHumanTask','queryUsersWorkflow',' ',73519)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.ModifiedRequirementByProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.ModifiedRequirementByProcess','cobiscorp.ecobis.htm.api.service.IHumanTask','modifiedRequirementByProcess',' ',31770)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetVersionListByProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetVersionListByProcess','cobiscorp.ecobis.htm.api.service.IHumanTask','getVersionListByProcess',' ',73545)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetTaskListGroup')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetTaskListGroup','cobiscorp.ecobis.htm.api.service.IHumanTask','getTaskListGroup','getTaskListGroup',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetTaskListCriteria')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetTaskListCriteria','cobiscorp.ecobis.htm.api.service.IHumanTask','getTaskListCriteria',' ',73515)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetTaskList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetTaskList','cobiscorp.ecobis.htm.api.service.IHumanTask','getTaskList',' ',73515)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetSupervisorTaskList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetSupervisorTaskList','cobiscorp.ecobis.htm.api.service.IHumanTask','getSupervisorTaskList',' ',73514)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetSupervisorProcessList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetSupervisorProcessList','cobiscorp.ecobis.htm.api.service.IHumanTask','getSupervisorProcessList',' ',73513)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetSupervisorActivityStatusList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetSupervisorActivityStatusList','cobiscorp.ecobis.htm.api.service.IHumanTask','getSupervisorActivityStatusList',' ',73512)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetSupervisorActivityList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetSupervisorActivityList','cobiscorp.ecobis.htm.api.service.IHumanTask','getSupervisorActivityList',' ',73511)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetReassignUsers')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetReassignUsers','cobiscorp.ecobis.htm.api.service.IHumanTask','getReassignUsers',' ',73510)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetProcInstancesListByUserProduct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetProcInstancesListByUserProduct','cobiscorp.ecobis.htm.api.service.IHumanTask','getProcInstancesListByUserProduct','Consulta las tareas de un proceso dado el producto al que esta asociado el proceso y el usuario invo',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetProcessListByName')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetProcessListByName','cobiscorp.ecobis.htm.api.service.IHumanTask','getProcessesListByName',' ',73543)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetProcessesList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetProcessesList','cobiscorp.ecobis.htm.api.service.IHumanTask','getProcessesList',' ',73509)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetProcessByUser')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetProcessByUser','cobiscorp.ecobis.htm.api.service.IHumanTask','getProcessByUser',' ',73513)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetProcessById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetProcessById','cobiscorp.ecobis.htm.api.service.IHumanTask','getProcessById',' ',73544)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetHumanTasksByProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetHumanTasksByProcess','cobiscorp.ecobis.htm.api.service.IHumanTask','getHumanTasksByProcess',' ',73508)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetCurrentTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetCurrentTask','cobiscorp.ecobis.htm.api.service.IHumanTask','getCurrentTask',' ',73507)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetCredencials')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetCredencials','cobiscorp.ecobis.htm.api.service.IHumanTask','getCredentials',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.GetActivitiesByProcess')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.GetActivitiesByProcess','cobiscorp.ecobis.htm.api.service.IHumanTask','getActivitiesByProcess',' ',73546)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.CreateProcessInstance')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.CreateProcessInstance','cobiscorp.ecobis.htm.api.service.IHumanTask','createProcessInstance',' ',73506)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.CompleteTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.CompleteTask','cobiscorp.ecobis.htm.api.service.IHumanTask','completeTask',' ',73505)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.ClaimTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.ClaimTask','cobiscorp.ecobis.htm.api.service.IHumanTask','claimTask',' ',73504)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.CheckRequiment')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.CheckRequiment','cobiscorp.ecobis.htm.api.service.IHumanTask','checkRequiment',' ',73552)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.CancelTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.CancelTask','cobiscorp.ecobis.htm.api.service.IHumanTask','cancelTask',' ',73503)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'HTM.API.HumanTask.CancelClaimTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('HTM.API.HumanTask.CancelClaimTask','cobiscorp.ecobis.htm.api.service.IHumanTask','cancelClaimTask',' ',73502)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.UpdateUIHumanTaskInfo')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.UpdateUIHumanTaskInfo','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','updateUIHumanTaskInfo',' ',73536)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.UpdateTaskForm')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.UpdateTaskForm','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','updateTaskForm',' ',73551)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.UpdateProcessDataConfigurationByTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.UpdateProcessDataConfigurationByTask','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','updateProcessDataConfigurationByTask',' ',73535)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.UpdateInboxProcessConfigurationByProduct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.UpdateInboxProcessConfigurationByProduct','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','updateInboxProcessConfigurationByProduct',' ',73534)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.InsertUIHumanTaskInfo')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.InsertUIHumanTaskInfo','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','insertUIHumanTaskInfo',' ',73533)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.InsertProcessDataConfigurationByTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.InsertProcessDataConfigurationByTask','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','insertProcessDataConfigurationByTask',' ',73532)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.InsertInboxProcessConfigurationByProduct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.InsertInboxProcessConfigurationByProduct','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','insertInboxProcessConfigurationByProduct',' ',73531)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetUIHumanTaskInfo')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetUIHumanTaskInfo','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getUIHumanTaskInfo',' ',73530)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetTaskFormByProcessAndTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetTaskFormByProcessAndTask','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getTaskFormByProcessAndTask',' ',73550)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetTaskFlow')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetTaskFlow','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getTaskFlow',' ',73529)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetProductQueryCatalogByIndex')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetProductQueryCatalogByIndex','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getProductQueryCatalogByIndex',' ',73523)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetProcessNameByProductAndPage')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetProcessNameByProductAndPage','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getProcessNameByProductAndPage',' ',73528)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetProcessDataConfigurationByTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetProcessDataConfigurationByTask','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getProcessDataConfigurationByTask',' ',73527)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetPages')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetPages','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getPages',' ',73526)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetModuleQueryCatalogByIndex')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetModuleQueryCatalogByIndex','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getModuleQueryCatalogByIndex',' ',73521)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetInboxProcessConfigurationByProduct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetInboxProcessConfigurationByProduct','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getInboxProcessConfigurationByProduct',' ',73525)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetComponentList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetComponentList','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getComponentList',' ',73547)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetComponentDetailList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetComponentDetailList','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getComponentDetailList',' ',73548)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetComponentById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetComponentById','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getComponentById',' ',73549)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetBPMIdentifier')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetBPMIdentifier','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getBPMIdentifier',' ',73524)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetAllProductQueryCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetAllProductQueryCatalog','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getAllProductQueryCatalog',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.GetAllModuleQueryCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.GetAllModuleQueryCatalog','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','getAllModuleQueryCatalog',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.Admin.ProcessIntegrationManager.DeleteProcessDataConfigurationByTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.Admin.ProcessIntegrationManager.DeleteProcessDataConfigurationByTask','cobiscorp.ecobis.inbox.admin.service.IProcessIntegrationManager','deleteProcessDataConfigurationByTask',' ',73519)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.UpdateSchedulerTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.UpdateSchedulerTask','cobiscorp.ecobis.inbox.service.ICommentsManager','updateSchedulerTask',' ',1875052)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.QuerySchedulerTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.QuerySchedulerTask','cobiscorp.ecobis.inbox.service.ICommentsManager','querySchedulerTask',' ',1875054)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.QueryInstances')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.QueryInstances','cobiscorp.ecobis.inbox.service.ICommentsManager','getInstancesList',' ',73538)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.InsertSchedulerTask')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.InsertSchedulerTask','cobiscorp.ecobis.inbox.service.ICommentsManager','insertSchedulerTask',' ',1875051)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.InsertComments')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.InsertComments','cobiscorp.ecobis.inbox.service.ICommentsManager','insertComments',' ',73541)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.GetRecords')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.GetRecords','cobiscorp.ecobis.inbox.service.ICommentsManager','getRecords',' ',73540)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.GetObservationActivitiesList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.GetObservationActivitiesList','cobiscorp.ecobis.inbox.service.ICommentsManager','getObservationActivitiesList',' ',73554)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.GetLines')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.GetLines','cobiscorp.ecobis.inbox.service.ICommentsManager','getLines',' ',73539)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.GetInstancesList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.GetInstancesList','Inbox.CommentsManager.QueryInstances','GetInstancesList',' ',73538)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Inbox.CommentsManager.GetComments')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Inbox.CommentsManager.GetComments','cobiscorp.ecobis.inbox.service.ICommentsManager','getComments',' ',73537)


/*================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_servicio_autorizado  PARA AUTORIZAR LOS SERVICIOS DE INBOX          */
/*================================================================================================================================*/
------------------------------------------------------------------------------------------------------------------------------------
declare @w_rol  int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Dummy.DummyClass.UpdateVariable' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Dummy.DummyClass.UpdateVariable',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Dummy.DummyClass.GetProcessUser' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Dummy.DummyClass.GetProcessUser',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.UpdateRequirementByProcessWithObservation' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.UpdateRequirementByProcessWithObservation',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.UpdateRequirementByProcess' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.UpdateRequirementByProcess',@w_rol,1,'R',
0,getdate(),'V',getdate())
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.SuspendTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.SuspendTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.ResumeTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.ResumeTask',@w_rol,1,'R',
0,getdate(),'V',getdate())
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.ReassignTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.ReassignTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.QueryUsersWorkflow' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.QueryUsersWorkflow',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.ModifiedRequirementByProcess' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.ModifiedRequirementByProcess',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetVersionListByProcess' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetVersionListByProcess',@w_rol,1,'R',
0,getdate(),'V',getdate())
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetTaskListGroup' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetTaskListGroup',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetTaskListCriteria' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetTaskListCriteria',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetTaskList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetTaskList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetSupervisorTaskList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetSupervisorTaskList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetSupervisorProcessList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetSupervisorProcessList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetSupervisorActivityStatusList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetSupervisorActivityStatusList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetSupervisorActivityList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetSupervisorActivityList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetReassignUsers' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetReassignUsers',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetProcInstancesListByUserProduct' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetProcInstancesListByUserProduct',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetProcessListByName' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetProcessListByName',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetProcessesList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetProcessesList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetProcessByUser' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetProcessByUser',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetProcessById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetProcessById',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetHumanTasksByProcess' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetHumanTasksByProcess',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetCurrentTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetCurrentTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetCredencials' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetCredencials',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.GetActivitiesByProcess' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.GetActivitiesByProcess',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.CreateProcessInstance' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.CreateProcessInstance',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.CompleteTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.CompleteTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.ClaimTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.ClaimTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.CheckRequiment' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.CheckRequiment',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.CancelTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.CancelTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'HTM.API.HumanTask.CancelClaimTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('HTM.API.HumanTask.CancelClaimTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.UpdateUIHumanTaskInfo' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.UpdateUIHumanTaskInfo',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.UpdateTaskForm' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.UpdateTaskForm',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.UpdateProcessDataConfigurationByTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.UpdateProcessDataConfigurationByTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.UpdateInboxProcessConfigurationByProduct' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.UpdateInboxProcessConfigurationByProduct',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.InsertUIHumanTaskInfo' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.InsertUIHumanTaskInfo',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.InsertProcessDataConfigurationByTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.InsertProcessDataConfigurationByTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.InsertInboxProcessConfigurationByProduct' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.InsertInboxProcessConfigurationByProduct',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetUIHumanTaskInfo' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetUIHumanTaskInfo',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetTaskFormByProcessAndTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetTaskFormByProcessAndTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetTaskFlow' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetTaskFlow',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetProductQueryCatalogByIndex' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetProductQueryCatalogByIndex',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetProcessNameByProductAndPage' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetProcessNameByProductAndPage',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetProcessDataConfigurationByTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetProcessDataConfigurationByTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetPages' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetPages',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetModuleQueryCatalogByIndex' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetModuleQueryCatalogByIndex',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetInboxProcessConfigurationByProduct' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetInboxProcessConfigurationByProduct',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetComponentList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetComponentList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetComponentDetailList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetComponentDetailList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetComponentById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetComponentById',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetBPMIdentifier' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetBPMIdentifier',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetAllProductQueryCatalog' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetAllProductQueryCatalog',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.GetAllModuleQueryCatalog' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.GetAllModuleQueryCatalog',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.Admin.ProcessIntegrationManager.DeleteProcessDataConfigurationByTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.Admin.ProcessIntegrationManager.DeleteProcessDataConfigurationByTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.UpdateSchedulerTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.UpdateSchedulerTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.QuerySchedulerTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.QuerySchedulerTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.QueryInstances' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.QueryInstances',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.InsertSchedulerTask' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.InsertSchedulerTask',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.InsertComments' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.InsertComments',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.GetRecords' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.GetRecords',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.GetObservationActivitiesList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.GetObservationActivitiesList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.GetLines' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.GetLines',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.GetInstancesList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.GetInstancesList',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Inbox.CommentsManager.GetComments' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Inbox.CommentsManager.GetComments',@w_rol,1,'R',
0,getdate(),'V',getdate())

go
