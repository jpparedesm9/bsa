/*******************************************************************/
/*                                                                 */
/*   Archivo:       Auth_serviciosOB.sql                           */
/*   Script:        Registro de Servicios OffBanking-CTS           */
/*   Base de datos: cobis                                          */
/*   Producto:      CTS                                            */
/*                                                                 */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBIS Corporation.                                           */
/* Su uso no  autorizado queda  expresamente prohibido asi como    */
/* cualquier  alteracion  o agregado  hecho por  alguno  de sus    */
/* usuarios sin el debido consentimiento por escrito de COBIS      */
/* Corp. Este programa esta protegido por la ley de derechos de    */
/* autor y por las  convenciones  internacionales de  propiedad    */
/* intelectual.  Su uso no  autorizado dara  derecho a COBIS       */
/* Corp. para obtener  ordenes de  secuestro o retencion y para    */
/* perseguir penalmente a los autores de cualquier infraccion.     */
/*******************************************************************/
/*                                                                 */
/*            PROPOSITO                                            */
/*   Script para registrar los servicios                           */
/*   que serán ejecutados desde Office                             */
/*     Banking a      COBIS TS                                     */   
/*                                                                 */
/*                                                                 */
/*******************************************************************/
/*                      MODIFICACIONES                             */
/* FECHA                   AUTOR            RAZON                  */
/* Mayo 10 2011 1:39 PM    bcuenca        Emision Inicial          */
/*******************************************************************/

use cobis
go

print 'Eliminacion de registros de servicio de Admin Seguridades'
go

delete cobis..cts_serv_catalog
where csc_service_id like '%Admin.AdmSecurity%'
go

print 'Creacion de registros de servicio de Admin Seguridades'
go

--==============================================
--= FUNCIONALIDAD ADMIN SEGURIDADES
--==============================================
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('COBISCorp.eCOBIS.Admin.AdmSecurity.Service.SearchSecurityManagement',
        'cobiscorp.ecobis.admin.admsecurity.service.ISecurityManagement',
        'searchSecurityManagement',
        'Obtiene todas las páginas, módulos, componentes por rol ',
        15375, null, null, 'Y')              

insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('COBISCorp.eCOBIS.Admin.AdmSecurity.Service.InsertSecurityManagement',      
        'cobiscorp.ecobis.admin.admsecurity.service.ISecurityManagement', 
        'insertSecurityManagement',                
        'Inserta las páginas, módulos, componentes por rol ',
        15373, null, null, 'Y')

insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('COBISCorp.eCOBIS.Admin.AdmSecurity.Service.DeleteSecurityManagement',      
        'cobiscorp.ecobis.admin.admsecurity.service.ISecurityManagement', 
        'deleteSecurityManagement',                
        'Elimina las páginas, módulos, componentes por rol ',
        15374, null, null, 'Y')
   
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('COBISCorp.eCOBIS.Admin.AdmSecurity.Service.UpdateLabel',      
        'cobiscorp.ecobis.admin.admsecurity.service.ISecurityManagement', 
        'updateLabel',                
        'Actualiza el label',
        15386, null, null, 'Y')
   
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('COBISCorp.eCOBIS.Admin.AdmSecurity.Service.HelpSecurityManagement',      
        'cobiscorp.ecobis.admin.admsecurity.service.ISecurityManagement', 
        'helpSecurityManagement',                
        'Obtiene los componentes asociados a rol en todos los productos',
        15375, null, null, 'Y')
   
--==================================================
--= ROLES
--==================================================
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('COBISCorp.eCOBIS.Admin.AdmSecurity.Service.CopyRole',                 
        'cobiscorp.ecobis.admin.admsecurity.service.IRoleConfig', 
        'copyRole',            
        'Copia de rol',
        15106, null, null, 'Y')
   
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('COBISCorp.eCOBIS.Admin.AdmSecurity.Service.SearchAllRole',                  
        'cobiscorp.ecobis.admin.admsecurity.service.IRoleConfig', 
        'searchAllRole',                                        
        'Busqueda de todos los Roles',
        15041, null, null, 'Y')
   
--==================================================
--= CATALOG
--==================================================
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('Admin.AdmSecurity.CatalogManagement.SearchAllCatalog',                                   
        'cobiscorp.ecobis.admin.admsecurity.service.ICatalogManagement', 
        'searchAllCatalog',                
        'Busqueda de todos los catalogos',
        1564, null, null, 'Y')   
go

--==================================================
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('Admin.AdmSecurity.AgentManagement.ListAgent',                                   
        'cobiscorp.ecobis.admin.admsecurity.service.IAgentManagement',
        'listAgent',                
        '',
        15375, null, null, 'Y')   
go


insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('Admin.AdmSecurity.AgentManagement.UpdateAuthorization',                                   
        'cobiscorp.ecobis.admin.admsecurity.service.IAgentManagement', 
        'updateAuthorization',                
        '',
        15387, null, null, 'Y')   

go
