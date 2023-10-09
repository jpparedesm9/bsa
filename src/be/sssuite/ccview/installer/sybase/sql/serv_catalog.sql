use cobis
go

delete from ad_servicio_autorizado where ts_servicio like '%lientviewer.Administration%'
go

delete from cts_serv_catalog where csc_service_id like '%lientviewer.Administration%'
go

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Administration.DeleteConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Administration.DeleteConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deleteProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientViewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientViewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.InsertConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.InsertConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','insertProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.QueryConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.QueryConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getProductAdministratorByRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.UpdateConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.UpdateConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','updateProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.deleteManagementContentSectionById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.deleteManagementContentSectionById','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deleteManagementContentSectionById',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.deleteManagementContentSectionRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.deleteManagementContentSectionRole','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deleteManagementContentSectionRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getAllManagementContentSectionRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.getAllManagementContentSectionRole','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllManagementContentSectionRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllManagementContentSectionRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllManagementContentSectionRole','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllManagementContentSectionRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientViewer.Administration.GetAllManagementContentSectionVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientViewer.Administration.GetAllManagementContentSectionVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllManagementContentSection','Obtiene vcc_section_management_content',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllProductAdministratorDefaultVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllProductAdministratorDefaultVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllProductAdministratorDefaultDinamic','Obtiene todo los campos de deudas',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getManagementContentSectionRoleByRole','Obtiene vcc_rol_content_management por rol',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getManagementContentSectionRoleBySection','Obtiene vcc_rol_content_management por sección',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.insertManagementContentSection')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.insertManagementContentSection','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','insertManagementContentSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.insertManagementContentSectionRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.insertManagementContentSectionRole','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','insertManagementContentSectionRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.updateManagementContentSectionById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.updateManagementContentSectionById','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','updateManagementContentSectionById',' ',0)


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientViewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientViewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType')
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getAllProductAdministratorDefaultDinamicByType', '', 0, NULL, NULL, 'N')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent')
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.getProductAdministratorDefaultDinamicByParent', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getProductAdministratorDefaultDinamicByParent', '', 0, NULL, NULL, 'N')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.CustomerService.queryClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.CustomerService.queryClient','com.cobiscorp.ecobis.clientviewer.ICustomerService','getCustomer',' ',0)

go

declare @w_id_rol int
select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS' 


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Administration.DeleteConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Administration.DeleteConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllRoleConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Administration.GetAllRoleConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientViewer.Administration.GetAllRoleConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())



if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.InsertConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.InsertConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.QueryConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.QueryConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.UpdateConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.UpdateConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.deleteManagementContentSectionById')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.deleteManagementContentSectionById',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.deleteManagementContentSectionRole')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.deleteManagementContentSectionRole',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getAllManagementContentSectionRole')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.getAllManagementContentSectionRole',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllManagementContentSectionRole')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllManagementContentSectionRole',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientViewer.Administration.GetAllManagementContentSectionVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientViewer.Administration.GetAllManagementContentSectionVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllProductAdministratorDefaultVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllProductAdministratorDefaultVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.insertManagementContentSection')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.insertManagementContentSection',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.insertManagementContentSectionRole')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.insertManagementContentSectionRole',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.updateManagementContentSectionById')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.updateManagementContentSectionById',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllRoleConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientViewer.Administration.GetAllRoleConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Administration.GetAllRoleConfigurationVCC')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType')
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent')
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.getProductAdministratorDefaultDinamicByParent', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.CustomerService.queryClient')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.CustomerService.queryClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

GO

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'InternetBanking.WebApp.Customer.Service.Customer.GetContractInformation')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'InternetBanking.WebApp.Customer.Service.Customer.GetContractInformation'
END
GO

IF EXISTS (SELECT 1 FROM ad_procedure WHERE pd_procedure = 1850022)
BEGIN 
    DELETE FROM ad_procedure WHERE  pd_procedure = 1850022    
END
GO 

IF EXISTS (SELECT 1 FROM cl_ttransaccion WHERE tn_trn_code = 1850022)
BEGIN 
    DELETE FROM cl_ttransaccion WHERE  tn_trn_code = 1850022   
END
GO

IF EXISTS (SELECT 1 FROM ad_pro_transaccion WHERE pt_transaccion = 1850022 AND pt_procedure = 1850022)
BEGIN 
    DELETE FROM ad_pro_transaccion WHERE pt_transaccion = 1850022 AND pt_procedure = 1850022
END
GO

IF EXISTS (SELECT 1 FROM ad_tr_autorizada WHERE ta_transaccion = 1850022 AND ta_rol = 3)
BEGIN 
    DELETE FROM ad_tr_autorizada WHERE  ta_transaccion = 1850022 AND ta_rol = 3  
END
GO

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
VALUES ('InternetBanking.WebApp.Customer.Service.Customer.GetContractInformation', 'cobiscorp.ecobis.internetbanking.webapp.customer.service.service.ICustomer', 'getContractInformation', '', 1850022, 'Y')
GO
  
INSERT INTO ad_procedure ( pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo ) 
		 VALUES ( 1850022, 'sp_bv_valida_vinculacion', 'cob_bvirtual', 'V', getdate(), '_bv_valida_vinculacion.sp' ) 
go

INSERT INTO cl_ttransaccion ( tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga ) 
		 VALUES ( 1850022, 'CONSULTA VINCULACION DEL CLIENTE', 'CVCLI', 'CONSULTA VINCULACION DEL CLIENTE' ) 
go

INSERT INTO ad_pro_transaccion ( pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial ) 
		 VALUES ( 18, 'R', 0, 1850022, 'V', getdate(), 1850022, ' ' ) 
go

INSERT INTO ad_tr_autorizada ( ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod ) 
		 VALUES ( 18, 'R', 0, 1850022, 3, getdate(), 1, 'V', getdate() ) 
go
