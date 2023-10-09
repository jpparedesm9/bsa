/**********************************************************************/
/*   Archivo:         bpl_authorization_services.sql  	              */
/*   Producto:        BUSINESS RULE								      */	
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
/*          Autorizacion de los servicios de business rules       	  */
/**********************************************************************/
/*                     MODIFICACIONES                       		  */
/*   FECHA               AUTOR                  RAZON         		  */
/*   15-Abr-2015        Diego Castro         Emision Inicial    	  */
/**********************************************************************/
use cobis
go

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*===========================================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA cts_serv_catalog  PARA LOS SERVICIOS DE BUSINESS RULES                                            */
/*===========================================================================================================================================================*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Commons.Security.RuleRole.DeleteRuleRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Commons.Security.RuleRole.DeleteRuleRole','com.cobiscorp.ecobis.bpl.security.services.IRuleRole','deleteRuleRole','Borra un rol en Reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Commons.Security.RuleRole.FindAllRoles')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Commons.Security.RuleRole.FindAllRoles','com.cobiscorp.ecobis.bpl.security.services.IRuleRole','queryRolesDescription','Obtener todos los roles')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Commons.Security.RuleRole.InsertRuleRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Commons.Security.RuleRole.InsertRuleRole','com.cobiscorp.ecobis.bpl.security.services.IRuleRole','insertRuleRole','Inserta un rol en Reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Commons.Security.RuleRole.UpdateRuleRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Commons.Security.RuleRole.UpdateRuleRole','com.cobiscorp.ecobis.bpl.security.services.IRuleRole','updateRuleRole','Actualiza un rol en Reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Commons.Security.RuleRoleDet.DeleteRuleRoleDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Commons.Security.RuleRoleDet.DeleteRuleRoleDetail','com.cobiscorp.ecobis.bpl.security.services.IRuleRoleDetail','deleteRuleRoleDetail','Borra las reglas y roles en el arbol')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Commons.Security.RuleRoleDet.InsertRuleRoleDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Commons.Security.RuleRoleDet.InsertRuleRoleDetail','com.cobiscorp.ecobis.bpl.security.services.IRuleRoleDetail','insertRuleRoleDetail','Inserta las reglas y roles para el arbol')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription','com.cobiscorp.ecobis.bpl.security.services.IRuleRoleDetail','queryRuleRolDescription','Consulta roles para el arbol')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription1')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription1','com.cobiscorp.ecobis.bpl.security.services.IRuleRoleDetail','queryRuleRolDescription','Consulta roles para el arbol')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.CatalogAdmManager.FindSystemsByType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.CatalogAdmManager.FindSystemsByType','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','querySystemByType','Consulta los sistemas por tipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Delete')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Delete','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IConditionRuleAdmManager','delete','elimina una condicion')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.DeleteList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.DeleteList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IConditionRuleAdmManager','deleteList','elimina una lista de condiciones')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Save')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Save','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IConditionRuleAdmManager','save','graba una condicion')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.SaveList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.SaveList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IConditionRuleAdmManager','saveList','graba una lista de condiciones')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Exceptions.Services.DeleteExceptionById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.DeleteExceptionById','com.cobiscorp.ecobis.bpl.rules.engine.adm.exceptions.services.IRuleExceptionAdmManager','remove','elimina una excepcion por id')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Exceptions.Services.FindAllExceptions')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.FindAllExceptions','com.cobiscorp.ecobis.bpl.rules.engine.adm.exceptions.services.IRuleExceptionAdmManager','findAll','actualiza una excepcion')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Exceptions.Services.GetExceptionById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.GetExceptionById','com.cobiscorp.ecobis.bpl.rules.engine.adm.exceptions.services.IRuleExceptionAdmManager','find','realiza la consulta de excepcion por id')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Exceptions.Services.InsertException')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.InsertException','com.cobiscorp.ecobis.bpl.rules.engine.adm.exceptions.services.IRuleExceptionAdmManager','insert','inserta una exepcion')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Exceptions.Services.UpdateException')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.UpdateException','com.cobiscorp.ecobis.bpl.rules.engine.adm.exceptions.services.IRuleExceptionAdmManager','update','actualiza una exepcion')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindAllSubTypeRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindAllSubTypeRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISubTypeRuleAdmManager','findAll','consulta todos los suptipos dependiendo de un sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISubTypeRuleAdmManager','find','conuslta un subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISystemRuleAdmManager','find','inserta un sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSubTypeRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSubTypeRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISubTypeRuleAdmManager','insert','inserta un subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSystemRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSystemRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISystemRuleAdmManager','insert','inserta un sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISubTypeRuleAdmManager','findAll','Consulta todos los subtipos segun el sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISystemRuleAdmManager','queryAllSystems','Consulta todos los sistemas en Reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSubTypeRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSubTypeRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISubTypeRuleAdmManager','remove','elimina un subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSystemRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSystemRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISystemRuleAdmManager','remove','elimina un sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSubTypeRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSubTypeRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISubTypeRuleAdmManager','update','actualiza un subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSystemRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSystemRule','com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISystemRuleAdmManager','update','actualiza un sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Create')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.Create','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IProgramaAdmManager','create','crea un programa')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Delete')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.Delete','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IProgramaAdmManager','delete','elimina un programa')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.DeleteList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.DeleteList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IProgramaAdmManager','deleteList','elimina una lista programa')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Save')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.Save','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IProgramaAdmManager','save','graba un programa')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.SaveList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.SaveList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IProgramaAdmManager','saveList','graba una lista de programas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Result.Policies.Services.FindResultPolicies')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Result.Policies.Services.FindResultPolicies','com.cobiscorp.ecobis.bpl.rules.engine.adm.result.policies.services.IResultPoliciesAdmManager','find','encuentra un resultado de politicas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Result.Policies.Services.InsertResultPolicies')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Result.Policies.Services.InsertResultPolicies','com.cobiscorp.ecobis.bpl.rules.engine.adm.result.policies.services.IResultPoliciesAdmManager','insert','inserta un resultado de politicas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Result.Policies.Services.RemoveResultPolicies')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Result.Policies.Services.RemoveResultPolicies','com.cobiscorp.ecobis.bpl.rules.engine.adm.result.policies.services.IResultPoliciesAdmManager','remove','elimina un resultado de politicas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Result.Policies.Services.UpdateResultPolicies')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.Result.Policies.Services.UpdateResultPolicies','com.cobiscorp.ecobis.bpl.rules.engine.adm.result.policies.services.IResultPoliciesAdmManager','update','actualiza un resultado de politicas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleAdmManager.Create')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.Create','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleAdmManager','create','crea una regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleAdmManager.Delete')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.Delete','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleAdmManager','delete','elimina una regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleAdmManager.DeleteList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.DeleteList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleAdmManager','deleteList','elimina una lista de reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleAdmManager.Save')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.Save','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleAdmManager','save','graba una regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleAdmManager.SaveList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.SaveList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleAdmManager','saveList','graba una lista de reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Create')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Create','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleVersionAdmManager','create','crea una version')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Delete')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Delete','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleVersionAdmManager','delete','elimina una version')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.DeleteList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.DeleteList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleVersionAdmManager','deleteList','elimina una lista de versiones')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Save')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Save','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleVersionAdmManager','save','graba una version')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.SaveList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.SaveList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IRuleVersionAdmManager','saveList','graba una lista de versiones')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.VariableAdmManager.Create')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.Create','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IVariableAdmManager','create','crea una variable')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.VariableAdmManager.Delete')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.Delete','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IVariableAdmManager','delete','elimina una variable')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.VariableAdmManager.DeleteList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.DeleteList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IVariableAdmManager','deleteList','elimina una lista de variables')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.VariableAdmManager.Save')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.Save','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IVariableAdmManager','save','graba una variable')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.VariableAdmManager.SaveList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.SaveList','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IVariableAdmManager','saveList','graba una lista de variables')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionActiveByRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionActiveByRule','com.cobiscorp.ecobis.bpl.rules.engine.services.IConditionRuleManager','queryAllConditionActiveByRule','Consulta de todas las condiciones por regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionByRulesVersion')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionByRulesVersion','com.cobiscorp.ecobis.bpl.rules.engine.services.IConditionRuleManager','queryAllConditionByRulesVersion','Consulta de todas las condiciones por version')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryById','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IConditionRuleQueryManager','queryById','consulta una condicion por ID')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryByRuleVersion')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryByRuleVersion','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IConditionRuleQueryManager','queryByRuleVersion','consulta condiciones por la version')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryConditionRuleTree')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryConditionRuleTree','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IConditionRuleQueryManager','queryConditionRuleTree','consulta el arbol de condiciones')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetList','com.cobiscorp.ecobis.bpl.rules.engine.adm.exceptions.services.IRuleExceptionAdmManager','getRuleRoleDetList','consulta las reglas segun el rol')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetListRight')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetListRight','com.cobiscorp.ecobis.bpl.rules.engine.adm.exceptions.services.IRuleExceptionAdmManager','getRuleRoleDetListRight','consulta las reglas segun el rol para el arbol')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRules')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRules','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryActiveRules','consulta la regla por ID')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryAllActiveRules','consulta la regla por ID')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryAll')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryAll','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryAll','Consulta todas las reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryById','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryById','consulta la regla por ID')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryByType','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryByType','consulta las reglas por tipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtype')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtype','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryByTypeAndSubtype','consulta las reglas por tipo y subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtypeBySystem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtypeBySystem','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryByTypeAndSubtype','consulta las reglas por sistema, tipo y subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryOtherRuleByStatus')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryOtherRuleByStatus','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryOtherRuleByStatus','consulta las reglas por tipo y subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryRulesByTypeAndSubType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryRulesByTypeAndSubType','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryRulesByTypeAndSubType','consulta las reglas por tipo y subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','querySubTypeBySystem','consulta los subtipos por sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRule','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','querySubTypesInRule','consulta los subtipos que contienen regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','querySubTypesInRule','consulta los subtipos que contienen regla y sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySystems')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QuerySystems','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','querySystems','consulta los sistemas de reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRule','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryTypesInRule','consulta los tipos que contienen regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRuleByRol')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRuleByRol','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryTypesInRuleAndRole','Selecciona los tipos de reglas de acuerdo al rol')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.UpdateRuleRolDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.UpdateRuleRolDetail','com.cobiscorp.ecobis.bpl.security.services.IRuleRoleDetail','updateRuleRoleDetail','Actualiza los permisos para la tabla de roles y reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryById','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleVersionQueryManager','queryById','consulta una version por ID')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRule')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRule','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleVersionQueryManager','queryByRule','consulta las versiones de una regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatus')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatus','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleVersionQueryManager','queryByRuleAndStatus','consulta las versiones de una regla y por estado')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatusList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatusList','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleVersionQueryManager','queryByRuleAndStatusList','consulta las versiones de una regla y por estado')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatus')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatus','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleVersionQueryManager','queryByStatus','consulta las versiones por estado')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatusList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatusList','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleVersionQueryManager','queryByStatusList','consulta las versiones por una lista de estados')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryRuleVersionActive')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryRuleVersionActive','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleVersionQueryManager','queryRuleVersionActive','consulta la version activa')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.TablaQueryManager.Count')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.TablaQueryManager.Count','com.cobiscorp.ecobis.bpl.rules.engine.query.services.ITablaQueryManager','count','realiza la consulta del total de registros')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAll')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryAll','com.cobiscorp.ecobis.bpl.rules.engine.query.services.ITablaQueryManager','queryAll','consulta todas las tablas de COBIS')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAllByPage')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryAllByPage','com.cobiscorp.ecobis.bpl.rules.engine.query.services.ITablaQueryManager','queryAllByPage','consulta todas las tablas de COBIS con paginación')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryByCodigo')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryByCodigo','com.cobiscorp.ecobis.bpl.rules.engine.query.services.ITablaQueryManager','queryByCodigo','realiza la consulta de un registro por codigo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTabla')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTabla','com.cobiscorp.ecobis.bpl.rules.engine.query.services.ITablaQueryManager','queryBynombreTabla','consulta por el nombre de tabla todas las tablas de COBIS')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTablaPage')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTablaPage','com.cobiscorp.ecobis.bpl.rules.engine.query.services.ITablaQueryManager','queryBynombreTablaPage','consulta por el nombre de tabla todas las tablas de COBIS con paginación')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryAll')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryAll','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IVariableQueryManager','queryAll','consulta todas las variables')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryAllProgram')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryAllProgram','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IVariableQueryManager','queryAllProgram','consulta todas los programas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryById','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IVariableQueryManager','queryById','consulta una variable por ID')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryByIdProgram')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryByIdProgram','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IVariableQueryManager','queryByIdProgram','consulta un programa por ID')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryOtherVariables')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryOtherVariables','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IVariableQueryManager','queryOtherVariables','consulta las variables que no estan en la regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableByTypeAndSubType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableByTypeAndSubType','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IVariableQueryManager','queryVariableByTypeAndSubType','consulta las variables por tipo y subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableSubTypes')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableSubTypes','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IVariableQueryManager','queryVariableSubTypes','consulta las variables por subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableTypes')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableTypes','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IVariableQueryManager','queryVariableTypes','consulta las variables por tipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.Generate')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RuleManager.Generate','com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager','generate','Genera una evaluacion de una regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.List<Rule> queryByType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RuleManager.List<Rule> queryByType','com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager','queryByType','consulta las reglas por tipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.QueryAllRules')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RuleManager.QueryAllRules','com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager','queryAllRules','Consulta de todas las reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtype')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtype','com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager','queryByTypeAndSubtype','consulta las reglas por tipo y subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtypeAndSystem')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtypeAndSystem','com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager','queryByTypeAndSubtypeAndSystem','consulta reglas por tipo, subtipo y sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.Simulate')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RuleManager.Simulate','com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager','simulate','realiza la simulacion de una regla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RulesVerionManager.QueryAllRules')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RulesVerionManager.QueryAllRules','com.cobiscorp.ecobis.bpl.rules.engine.services.IRulesVerionManager','queryAllRules','Consulta de todas las reglas')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.QueryPoliciesInRules') 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Bpl.Rules.Engine.RuleManager.QueryPoliciesInRules','com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager','queryPoliciesInRules',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.QueryBySystemToDelete')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RuleManager.QueryBySystemToDelete','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryBySystemDelete','Consulta todas las reglas de acuerdo a un sistema')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.RuleManager.QueryBySubtypeToDelete')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.RuleManager.QueryBySubtypeToDelete','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','queryBySubtypeDelete','Consulta todas las reglas de acuerdo a un subtipo')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.ProgramaAdmManager.FindById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.ProgramaAdmManager.FindById','com.cobiscorp.ecobis.bpl.rules.engine.adm.services.IProgramaAdmManager','findById','Consulta el Programa por el id')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.FindByIdAndATable')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values('Bpl.Rules.Engine.Query.RuleQueryManager.FindByIdAndATable','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','findByIdAndATable','Consulta el Catalogo por el id y tabla')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.FindByProductAndActive')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Bpl.Rules.Engine.Query.RuleQueryManager.FindByProductAndActive','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','findByProductAndActive',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym','com.cobiscorp.ecobis.bpl.rules.engine.query.services.IRuleQueryManager','findRuleActiveByAcronym',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Rules.Admin.RulesAdmin.QueryRuleDependence')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Rules.Admin.RulesAdmin.QueryRuleDependence', 'cobiscorp.ecobis.rules.admin.service.IRulesAdmin', 'queryRuleDependence', '', 73544)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Cobis.Commons.Services.CountTotalCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Cobis.Commons.Services.CountTotalCatalog','com.cobiscorp.ecobis.cobis.commons.services.IQueryCatalog','countTotalCatalog','realiza la consulta del total de registros',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Cobis.Commons.Services.CountTotalCatalogWithParam')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Cobis.Commons.Services.CountTotalCatalogWithParam','com.cobiscorp.ecobis.cobis.commons.services.IQueryCatalog','countTotalCatalogWithParam','realiza la consulta del total de registros',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Cobis.Commons.Services.QueryCatalog')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Cobis.Commons.Services.QueryCatalog','com.cobiscorp.ecobis.cobis.commons.services.IQueryCatalog','queryCatalog','realiza la consulta los catalogos por la descripcion',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Cobis.Commons.Services.QueryCatalogByCode')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Cobis.Commons.Services.QueryCatalogByCode','com.cobiscorp.ecobis.cobis.commons.services.IQueryCatalog','queryCatalogByCode','realiza la consulta de todos los catalogos',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Cobis.Commons.Services.QueryCatalogByCodeWithParam')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Cobis.Commons.Services.QueryCatalogByCodeWithParam','com.cobiscorp.ecobis.cobis.commons.services.IQueryCatalog','queryCatalogByCodeWithParam','realiza la consulta de todos los catalogos',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Cobis.Commons.Services.QueryCatalogByDescription')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Cobis.Commons.Services.QueryCatalogByDescription','com.cobiscorp.ecobis.cobis.commons.services.IQueryCatalog','queryCatalogByDescription','realiza la consulta de un registro por codigo',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Cobis.Commons.Services.QueryCatalogByDescriptionWithParam')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Cobis.Commons.Services.QueryCatalogByDescriptionWithParam','com.cobiscorp.ecobis.cobis.commons.services.IQueryCatalog','queryCatalogByDescriptionWithParam','realiza la consulta de un registro por codigo',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Cobis.Commons.Services.QueryCatalogWithParam')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Cobis.Commons.Services.QueryCatalogWithParam','com.cobiscorp.ecobis.cobis.commons.services.IQueryCatalog','queryCatalogWithParam','realiza la consulta de todos los catalogos con parametros',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'AddressTxService.getAddressesbyCustomer')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('AddressTxService.getAddressesbyCustomer', 'com.cobiscorp.ecobis.customer.services.AddressTxService', 'getAddressesbyCustomer', 'getAddressesbyCustomer', null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemByAcronym')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemByAcronym', 'com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISystemRuleAdmManager', 'findByAcronym', 'findByAcronym', null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeByAcronym')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeByAcronym', 'com.cobiscorp.ecobis.bpl.rules.engine.adm.groupingrules.services.ISubTypeRuleAdmManager', 'findByAcronym', 'findByAcronym', null)
 
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.updateRuleRoleDetailBySystemAndOrSubtype')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Bpl.Rules.Engine.Query.RuleQueryManager.updateRuleRoleDetailBySystemAndOrSubtype','com.cobiscorp.ecobis.bpl.security.services.IRuleRoleDetail','updateRuleRoleDetailBySystemAndOrSubtype','',null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.SearchLoanItems.GetLoanItemsDetails')
insert into dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.SearchLoanItems.GetLoanItemsDetails', 'cobiscorp.ecobis.loan.service.ISearchLoanItems', 'getLoanItemsDetails', ' ', 7095, NULL, NULL, NULL) 
go

------------------------------------------------------------------------------------------------------------------------------------------------------------
/*=========================================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_servicio_autorizado  PARA AUTORIZAR LOS SERVICIOS DE BUSINESS RULES                          */
/*=========================================================================================================================================================*/
------------------------------------------------------------------------------------------------------------------------------------------------------------

declare @w_rol  int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Commons.Security.RuleRole.DeleteRuleRole' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Commons.Security.RuleRole.DeleteRuleRole',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Commons.Security.RuleRole.FindAllRoles' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Commons.Security.RuleRole.FindAllRoles',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Commons.Security.RuleRole.InsertRuleRole' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Commons.Security.RuleRole.InsertRuleRole',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Commons.Security.RuleRole.UpdateRuleRole' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Commons.Security.RuleRole.UpdateRuleRole',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Commons.Security.RuleRoleDet.DeleteRuleRoleDetail' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Commons.Security.RuleRoleDet.DeleteRuleRoleDetail',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Commons.Security.RuleRoleDet.InsertRuleRoleDetail' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Commons.Security.RuleRoleDet.InsertRuleRoleDetail',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription1' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Commons.Security.RuleRoleDet.queryRuleRolDescription1',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.CatalogAdmManager.FindSystemsByType' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.CatalogAdmManager.FindSystemsByType',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Delete' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Delete',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.DeleteList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.DeleteList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Save' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.Save',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.SaveList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ConditionRuleAdmManager.SaveList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Exceptions.Services.DeleteExceptionById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.DeleteExceptionById',@w_rol,73,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Exceptions.Services.FindAllExceptions' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.FindAllExceptions',@w_rol,73,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Exceptions.Services.GetExceptionById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.GetExceptionById',@w_rol,73,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Exceptions.Services.InsertException' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.InsertException',@w_rol,73,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Exceptions.Services.UpdateException' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Exceptions.Services.UpdateException',@w_rol,73,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindAllSubTypeRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindAllSubTypeRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSubTypeRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSubTypeRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSystemRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.InsertSystemRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSubTypeRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSubTypeRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSystemRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.RemoveSystemRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSubTypeRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSubTypeRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSystemRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Groupingrules.Services.UpdateSystemRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Create' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.Create',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Delete' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.Delete',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.DeleteList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.DeleteList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.Save' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.Save',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.ProgramaAdmManager.SaveList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.ProgramaAdmManager.SaveList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Result.Policies.Services.FindResultPolicies' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Result.Policies.Services.FindResultPolicies',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Result.Policies.Services.InsertResultPolicies' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Result.Policies.Services.InsertResultPolicies',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Result.Policies.Services.RemoveResultPolicies' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Result.Policies.Services.RemoveResultPolicies',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Result.Policies.Services.UpdateResultPolicies' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.Result.Policies.Services.UpdateResultPolicies',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleAdmManager.Create' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.Create',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleAdmManager.Delete' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.Delete',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleAdmManager.DeleteList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.DeleteList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleAdmManager.Save' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.Save',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleAdmManager.SaveList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleAdmManager.SaveList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Create' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Create',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Delete' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Delete',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.DeleteList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.DeleteList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Save' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.Save',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.RuleVersionAdmManager.SaveList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.RuleVersionAdmManager.SaveList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.VariableAdmManager.Create' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.Create',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.VariableAdmManager.Delete' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.Delete',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.VariableAdmManager.DeleteList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.DeleteList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.VariableAdmManager.Save' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.Save',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.VariableAdmManager.SaveList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Adm.VariableAdmManager.SaveList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionActiveByRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionActiveByRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionByRulesVersion' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.ConditionRuleManager.QueryAllConditionByRulesVersion',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryById',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryByRuleVersion' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryByRuleVersion',@w_rol,1,'R',
0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryConditionRuleTree' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryConditionRuleTree',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetListRight' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.GetRuleRoleDetListRight',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRules' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRules',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryAll' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryAll',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryById',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByType' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryByType',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtype' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtype',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtypeBySystem' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtypeBySystem',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryOtherRuleByStatus' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryOtherRuleByStatus',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryRulesByTypeAndSubType' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryRulesByTypeAndSubType',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySystems' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QuerySystems',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRuleByRol' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.QueryTypesInRuleByRol',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.UpdateRuleRolDetail' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.UpdateRuleRolDetail',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryById',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRule' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRule',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatus' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatus',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatusList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByRuleAndStatusList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatus' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatus',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatusList' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryByStatusList',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryRuleVersionActive' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleVersionQueryManager.QueryRuleVersionActive',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.TablaQueryManager.Count' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.TablaQueryManager.Count',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAll' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryAll',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryAllByPage' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryAllByPage',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryByCodigo' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryByCodigo',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTabla' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTabla',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTablaPage' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTablaPage',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryAll' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryAll',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryAllProgram' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryAllProgram',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryById',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryByIdProgram' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryByIdProgram',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryOtherVariables' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryOtherVariables',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableByTypeAndSubType' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableByTypeAndSubType',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableSubTypes' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableSubTypes',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableTypes' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.VariableQueryManager.QueryVariableTypes',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.Generate' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.RuleManager.Generate',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.List<Rule> queryByType' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.RuleManager.List<Rule> queryByType',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.QueryAllRules' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.RuleManager.QueryAllRules',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtype' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtype',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtypeAndSystem' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.RuleManager.QueryByTypeAndSubtypeAndSystem',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.Simulate' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.RuleManager.Simulate',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RulesVerionManager.QueryAllRules' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.RulesVerionManager.QueryAllRules',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.QueryPoliciesInRules' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.RuleManager.QueryPoliciesInRules',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.QueryBySystemToDelete' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('Bpl.Rules.Engine.RuleManager.QueryBySystemToDelete',@w_rol,3,'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.RuleManager.QueryBySubtypeToDelete' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('Bpl.Rules.Engine.RuleManager.QueryBySubtypeToDelete',@w_rol,3,'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.ProgramaAdmManager.FindById' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('Bpl.Rules.Engine.ProgramaAdmManager.FindById',@w_rol,3,'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.FindByIdAndATable' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('Bpl.Rules.Engine.Query.RuleQueryManager.FindByIdAndATable',@w_rol,3,'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.FindByProductAndActive' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.FindByProductAndActive',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Rules.Admin.RulesAdmin.QueryRuleDependence' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Rules.Admin.RulesAdmin.QueryRuleDependence',@w_rol,73,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Cobis.Commons.Services.CountTotalCatalog' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Cobis.Commons.Services.CountTotalCatalog',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Cobis.Commons.Services.CountTotalCatalogWithParam' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Cobis.Commons.Services.CountTotalCatalogWithParam',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Cobis.Commons.Services.QueryCatalog' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Cobis.Commons.Services.QueryCatalog',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Cobis.Commons.Services.QueryCatalogByCode' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Cobis.Commons.Services.QueryCatalogByCode',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Cobis.Commons.Services.QueryCatalogByCodeWithParam' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Cobis.Commons.Services.QueryCatalogByCodeWithParam',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Cobis.Commons.Services.QueryCatalogByDescription' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Cobis.Commons.Services.QueryCatalogByDescription',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Cobis.Commons.Services.QueryCatalogByDescriptionWithParam' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Cobis.Commons.Services.QueryCatalogByDescriptionWithParam',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Cobis.Commons.Services.QueryCatalogWithParam' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Cobis.Commons.Services.QueryCatalogWithParam',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'AddressTxService.getAddressesbyCustomer' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('AddressTxService.getAddressesbyCustomer',@w_rol,3,'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemByAcronym' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemByAcronym',@w_rol,3,'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeByAcronym' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeByAcronym',@w_rol,3,'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Bpl.Rules.Engine.Query.RuleQueryManager.updateRuleRoleDetailBySystemAndOrSubtype')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Bpl.Rules.Engine.Query.RuleQueryManager.updateRuleRoleDetailBySystemAndOrSubtype','com.cobiscorp.ecobis.bpl.security.services.IRuleRoleDetail','updateRuleRoleDetailBySystemAndOrSubtype','',null)
 
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Bpl.Rules.Engine.Query.RuleQueryManager.updateRuleRoleDetailBySystemAndOrSubtype' and ts_rol = @w_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Bpl.Rules.Engine.Query.RuleQueryManager.updateRuleRoleDetailBySystemAndOrSubtype',@w_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.SearchLoanItems.GetLoanItemsDetails' and ts_rol = @w_rol)
insert into dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('Loan.SearchLoanItems.GetLoanItemsDetails', 7, 'R', 0, getdate(), 3, 'V', getdate())
go
