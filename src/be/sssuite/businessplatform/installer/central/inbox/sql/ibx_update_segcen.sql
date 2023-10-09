use cobis
go

declare @w_tabla int,
        @w_co_id int

select @w_tabla = codigo
from cobis..cl_tabla
where tabla = 'an_product'

---------------------------------- INBOX DE TAREAS ---------------------------------------------------
--Eliminación de datos
print 'Iniciando Eliminación de datos existentes INBOX'
delete from cobis..cl_catalogo 
where tabla  = @w_tabla
  and codigo  = 'M-IBX'
  

delete an_service_component 
where  sc_co_id in (select co_id 
                    from   cobis..an_component 
                    where  co_name in ('IBX.Consultas', 'IBX.SupervisorInbox','IBX.InboxOficial','IBX.Inbox', 'IBX.ReimpresionDocumentos'))

delete an_transaction_component 
where  tc_co_id in (select co_id 
                    from   cobis..an_component 
                    where  co_name in ('IBX.Consultas', 'IBX.SupervisorInbox','IBX.InboxOficial','IBX.Inbox', 'IBX.ReimpresionDocumentos'))

delete an_service_component where sc_oc_nemonic = 'M-IBX'

delete an_service_component
where  sc_co_id in (73001,73002,73003)

print 'Terminando Eliminación de datos existentes INBOX'

--Inserción de datos
print 'Iniciando Inserción de datos para el control de las Funcionalidades por Rol INBOX'
insert into cobis..cl_catalogo
   (tabla,codigo ,valor,estado)
 values 
   (@w_tabla,'M-IBX','INBOX DE TAREAS','V')


update cobis..an_component
   set co_prod_name = 'M-IBX'
 where co_id in (select co_id 
                   from cobis..an_component 
                  where co_name in ('IBX.Consultas', 'IBX.SupervisorInbox','IBX.InboxOficial','IBX.Inbox','IBX.ReimpresionDocumentos'))



--Componentes de las Tareas pendientes
select @w_co_id = co_id
from   cobis..an_component
where  co_name= 'IBX.InboxOficial'


--Transacciones de las Tareas pendientes
insert into cobis..an_transaction_component
select @w_co_id, tn_trn_code, 'M-IBX'
  from cobis..cl_ttransaccion
  where tn_trn_code between 73000 and 74990

insert into cobis..an_transaction_component values (@w_co_id,  1182, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,   132, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,  1227, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,   136, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id, 21084, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,  1312, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,  1315, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,   150, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,  1184, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,  1235, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,  1181, 'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87000,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87001,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87002,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87003,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87004,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87006,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87007,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87008,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87009,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87010,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87021,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87014,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87015,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87019,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,87020,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,1008,'M-IBX')
 
insert into cobis..an_transaction_component values (@w_co_id,731001,'M-IBX')

insert into cobis..an_transaction_component values (@w_co_id,31829,'M-IBX')

insert into cobis..an_transaction_component values (@w_co_id,32285,'M-IBX')
 

--Componentes del Supervisor
select @w_co_id = null

select @w_co_id = co_id
from   cobis..an_component
where  co_name= 'IBX.SupervisorInbox'

--Transacciones del Supervisor
insert into cobis..an_transaction_component
select @w_co_id, tn_trn_code, 'M-IBX'
  from cobis..cl_ttransaccion
  where tn_trn_code between 73500 and 74000   

--Componentes del Consultas
select @w_co_id = null

select @w_co_id = co_id
from   cobis..an_component
where  co_name= 'IBX.Consultas'

--Transacciones del Inbox Web
insert into cobis..an_transaction_component
select @w_co_id, tn_trn_code, 'M-IBX'
  from cobis..cl_ttransaccion
  where tn_trn_code between 73500 and 74000
print 'Terminando Inserción de datos para el control de las Funcionalidades por Rol INBOX'


SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-IBX' and co_name ='IBX.InboxOficial'

--Inserción de datos
print 'Iniciando inserción de registros para los servicios del Product Name INBOX'
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CancelClaimTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CancelTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CheckRequiment','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ClaimTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CompleteTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CreateProcessInstance','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetActivitiesByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetCredencials','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetCurrentTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetHumanTasksByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcInstancesListByUserProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessByUser','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessListByName','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessesList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetReassignUsers','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorActivityList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorActivityStatusList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorProcessList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorTaskList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListCriteria','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListGroup','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetVersionListByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ModifiedRequirementByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.QueryUsersWorkflow','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ReassignTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ResumeTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.SuspendTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.UpdateRequirementByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.UpdateRequirementByProcessWithObservation','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetScalarUsers','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.DeleteProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetAllModuleQueryCatalog','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetAllProductQueryCatalog','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetBPMIdentifier','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentDetailList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetModuleQueryCatalogByIndex','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetPages','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProcessNameByProductAndPage','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProductQueryCatalogByIndex','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetTaskFlow','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetTaskFormByProcessAndTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateTaskForm','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetComments','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetLines','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetObservationActivitiesList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetRecords','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.InsertComments','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.QueryInstances','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindAllSubTypeRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ProgramaAdmManager.FindById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryByRuleVersion','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindByProductAndActive','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRules','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtype','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtypeBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryRulesByTypeAndSubType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.List<Rule> queryByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryAllRules','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateRuleHistory','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.EvaluatePolicy','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.ClaimTask','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.Generate','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.CustomerService.queryClient','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogByDescription','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogWithParam','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CreateClaimRequest','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CreateClaimSettlement','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.DeleteClaimRequest','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.DeleteClaimSettlement','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadCategoryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadClaimRequest','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadClaimSettlement','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadSubcategoryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchCategoryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchClaimDuplicates','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchClaimRequest','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchClaimSettlement','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchDescriptionSettlement','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchSubcategoryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.UpdateClaimRequest','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.UpdateClaimSettlement','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.AddDaysSkipHolidays','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CountDaysSkipHolidays','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleHistory','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocumentsByType','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalog','M-IBX')
 
-- dump tran cobis with no_log

SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-IBX' and co_name ='IBX.SupervisorInbox'

delete FROM an_service_component where sc_co_id = @w_co_id

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CancelClaimTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CancelTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CheckRequiment','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ClaimTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CompleteTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CreateProcessInstance','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetActivitiesByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetCredencials','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetCurrentTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetHumanTasksByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcInstancesListByUserProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessByUser','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessListByName','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessesList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetReassignUsers','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorActivityList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorActivityStatusList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorProcessList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorTaskList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListCriteria','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListGroup','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetVersionListByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ModifiedRequirementByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.QueryUsersWorkflow','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ReassignTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ResumeTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.SuspendTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.UpdateRequirementByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.UpdateRequirementByProcessWithObservation','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetScalarUsers','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.DeleteProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetAllModuleQueryCatalog','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetAllProductQueryCatalog','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetBPMIdentifier','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentDetailList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetModuleQueryCatalogByIndex','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetPages','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProcessNameByProductAndPage','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProductQueryCatalogByIndex','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetTaskFlow','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetTaskFormByProcessAndTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateTaskForm','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetComments','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetLines','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetObservationActivitiesList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetRecords','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.InsertComments','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.QueryInstances','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetInstancesList','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.InsertSchedulerTask','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.QuerySchedulerTask','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.UpdateSchedulerTask','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CreateCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CreateSubcate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.DeleteCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.DeleteSubcate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadSubcate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.UpdateSubcate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.UpdateCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindAllSubTypeRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ProgramaAdmManager.FindById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryByRuleVersion','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindByProductAndActive','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRules','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtype','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtypeBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryRulesByTypeAndSubType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.List<Rule> queryByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryAllRules','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateRuleHistory','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.EvaluatePolicy','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.ClaimTask','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.AddDaysSkipHolidays','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CountDaysSkipHolidays','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTakeUsers','M-IBX')

 

-- dump tran cobis with no_log

SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-IBX' and co_name ='IBX.Consultas'

delete FROM an_service_component where sc_co_id = @w_co_id

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CancelClaimTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CancelTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CheckRequiment','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ClaimTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CompleteTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CreateProcessInstance','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetActivitiesByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetCredencials','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetCurrentTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetHumanTasksByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcInstancesListByUserProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessByUser','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessListByName','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessesList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetReassignUsers','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorActivityList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorActivityStatusList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorProcessList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorTaskList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListCriteria','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListGroup','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetVersionListByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ModifiedRequirementByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.QueryUsersWorkflow','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ReassignTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ResumeTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.SuspendTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.UpdateRequirementByProcess','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.UpdateRequirementByProcessWithObservation','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetScalarUsers','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.DeleteProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetAllModuleQueryCatalog','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetAllProductQueryCatalog','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetBPMIdentifier','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentDetailList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetComponentList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetModuleQueryCatalogByIndex','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetPages','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProcessNameByProductAndPage','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetProductQueryCatalogByIndex','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetTaskFlow','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetTaskFormByProcessAndTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.GetUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.InsertUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateInboxProcessConfigurationByProduct','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateProcessDataConfigurationByTask','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateTaskForm','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.Admin.ProcessIntegrationManager.UpdateUIHumanTaskInfo','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetComments','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetLines','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetObservationActivitiesList','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetRecords','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.InsertComments','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.QueryInstances','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CreateCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CreateSubcate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.DeleteCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.DeleteSubcate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadSubcate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.UpdateSubcate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.UpdateCate ryClaim','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindAllSubTypeRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ProgramaAdmManager.FindById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryByRuleVersion','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindByProductAndActive','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRules','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryById','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtype','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtypeBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryRulesByTypeAndSubType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRule','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.List<Rule> queryByType','M-IBX')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryAllRules','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.ClaimTask','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.AddDaysSkipHolidays','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CountDaysSkipHolidays','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.Generate','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess','M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess','M-IBX')



-- dump tran cobis with no_log

select @w_co_id = co_id
from   cobis..an_component
where  co_name= 'IBX.ReimpresionDocumentos'

delete FROM an_service_component where sc_co_id = @w_co_id

insert into cobis..an_transaction_component values (@w_co_id, 21434,'M-IBX')
insert into cobis..an_transaction_component values (@w_co_id, 21433,'M-IBX')
insert into cobis..an_transaction_component values (@w_co_id, 21034,'M-IBX')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication','M-IBX')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocumentsByType','M-IBX')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication','M-IBX')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getCustomersByParameters','M-IBX')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-IBX')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-IBX')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-IBX')
-- dump tran cobis with no_log
print 'Finalizando inserción de registros para los servicios del Product Name INBOX'
go
