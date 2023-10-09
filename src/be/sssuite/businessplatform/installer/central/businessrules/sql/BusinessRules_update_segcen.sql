use cobis
go

declare @w_tabla int,
        @w_co_id int

select @w_tabla = codigo
from cobis..cl_tabla
where tabla = 'an_product'

---------------------------------- POLITICAS ---------------------------------------------------
--Eliminando datos
print 'Iniciando Eliminación de datos existentes POLITICAS'
delete from cobis..cl_catalogo 
where tabla  = @w_tabla
  and codigo  = 'M-POL'
print 'Terminando Eliminación de datos existentes POLITICAS'
  
--Inserción de los datos
print 'Iniciando Inserción de datos para el control de las Funcionalidades por POLITICAS'
insert into cobis..cl_catalogo 
        (tabla,codigo ,valor,estado ) 
 values (@w_tabla,'M-POL','ADMINISTRADOR DE POLITICAS','V')
print 'Terminando Inserción de datos para el control de las Funcionalidades por Rol POLITICAS'

--Autorización para los servicios relacionados con el POLITICAS
--Eliminación de datos
print 'Iniciando Eliminación de datos existentes para los servicios del POLITICAS'
delete from an_service_component
where sc_co_id in (86001,86002)
 
print 'Terminando Eliminación de datos existentes para los servicios del POLITICAS'

--Inserción de datos
print 'Iniciando inserción de registros para los servicios del Product Name POLITICAS'

delete from an_service_component where sc_oc_nemonic = 'M-POL'

SELECT @w_co_id = co_id FROM an_component WHERE co_prod_name = 'M-POL'

delete from an_service_component where sc_co_id = @w_co_id

SELECT @w_co_id = co_id FROM an_component WHERE co_prod_name = 'M-POL' AND co_name = 'POL.VariablesProgramas'
delete from an_service_component where sc_co_id = @w_co_id
print 'Terminando Eliminación de registros para los servicios relacionados con el POL.VariablesProgramas'

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcess','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTablaPage','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogByDescription','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryByIdProgram','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Save','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Create','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryById','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.Save','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.Create','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.Delete','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryAllProgram','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableTypes','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableSubTypes','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableByTypeAndSubType','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemByAcronym','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeByAcronym','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.DeleteExceptionById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.FindAllExceptions','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.GetExceptionById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.InsertException','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.UpdateException','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.FindResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.InsertResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.RemoveResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.UpdateResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Create','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionActiveByRule','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionByRulesVersion','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindByIdAndATable','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryAll','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryOtherRuleByStatus','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRule','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatusList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatus','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatusList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryRuleVersionActive','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.Count','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAll','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAllByPage','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryByCodigo','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryOtherVariables','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtype','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryPoliciesInRules','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RulesVerionManager.QueryAllRules','M-POL')

 
print 'Iniciando Inserción de registros para los servicios relacionados con el POL.VariablesProgramas'


-- dump tran cobis with no_log

SELECT @w_co_id = co_id FROM an_component WHERE co_prod_name = 'M-POL' AND co_name = 'POL.SistemasSubtipos'
delete from an_service_component where sc_co_id = @w_co_id
print 'Terminando Eliminación de registros para los servicios relacionados con el POL.SistemasSubtipos'

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcess','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTablaPage','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogByDescription','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSubTypeRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSubTypeRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSystemRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSystemRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogByCode','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryBySubtypeToDelete','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSystemRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSubTypeRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryBySystemToDelete','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.DeleteExceptionById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.FindAllExceptions','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.GetExceptionById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.InsertException','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.UpdateException','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.FindResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.InsertResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.RemoveResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.UpdateResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Create','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionActiveByRule','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionByRulesVersion','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindByIdAndATable','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryAll','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryOtherRuleByStatus','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRule','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatusList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatus','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatusList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryRuleVersionActive','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.Count','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAll','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAllByPage','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryByCodigo','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryOtherVariables','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtype','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryPoliciesInRules','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RulesVerionManager.QueryAllRules','M-POL')


print 'Iniciando Inserción de registros para los servicios relacionados con el POL.SistemasSubtipos'

--Editor de Políticas
-- dump tran cobis with no_log

SELECT @w_co_id = co_id FROM an_component WHERE co_prod_name = 'M-POL' AND co_name = 'POL.EditorPoliticas'
delete from an_service_component where sc_co_id = @w_co_id
print 'Terminando Eliminación de registros para los servicios relacionados con el POL.EditorPoliticas'
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryAll','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcess','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTablaPage','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogByDescription','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatus','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.Simulate','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Rules.Admin.RulesAdmin.QueryRuleDependence','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryConditionRuleTree','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRule','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogByCode','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.Create','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySystems','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.CatalogAdmManager.FindSystemsByType','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryById','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetList','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.DeleteExceptionById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.FindAllExceptions','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.GetExceptionById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.InsertException','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Exceptions.Services.UpdateException','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.ProgramaAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.FindResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.InsertResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.RemoveResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Result.Policies.Services.UpdateResultPolicies','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Create','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Delete','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Save','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.DeleteList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.VariableAdmManager.SaveList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionActiveByRule','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionByRulesVersion','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindByIdAndATable','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryAll','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryOtherRuleByStatus','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRule','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryById','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatusList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatus','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatusList','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryRuleVersionActive','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.Count','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAll','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAllByPage','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryByCodigo','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.VariableQueryManager.QueryOtherVariables','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtype','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryPoliciesInRules','M-POL')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RulesVerionManager.QueryAllRules','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-POL')
 
print 'Iniciando Inserción de registros para los servicios relacionados con el POL.EditorPoliticas'




-- dump tran cobis with no_log

SELECT @w_co_id = co_id FROM an_component WHERE co_prod_name = 'M-POL' AND co_name = 'POL.SegReglasPoliticas'
delete from an_service_component where sc_co_id = @w_co_id
print 'Terminando Eliminación de registros para los servicios relacionados con el POL.SegReglasPoliticas'
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcess','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTablaPage','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogByDescription','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalog','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.UpdateRuleRolDetail','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRuleByRol','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.CatalogAdmManager.FindSystemsByType','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem','M-POL')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetListRight','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Commons.Security.RuleRole.DeleteRuleRole','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Commons.Security.RuleRole.FindAllRoles','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Commons.Security.RuleRole.InsertRuleRole','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Commons.Security.RuleRole.UpdateRuleRole','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Commons.Security.RuleRoleDet.DeleteRuleRoleDetail','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Commons.Security.RuleRoleDet.InsertRuleRoleDetail','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription1','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeByAcronym','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemByAcronym','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.GetAllRoleAssociatesVCC','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.updateRuleRoleDetailBySystemAndOrSubtype','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-POL')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-POL')
 
 
print 'Iniciando Inserción de registros para los servicios relacionados con el POL.SegReglasPoliticas'

--Servicios Seguridad Reglas
-- dump tran cobis with no_log
print 'Finalizando inserción de registros para los servicios del Product Name Reglas'
go
