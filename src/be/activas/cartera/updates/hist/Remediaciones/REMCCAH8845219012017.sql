USE cobis
GO
-----------------------------------------------------------------------------------------------------------------------
declare @w_rol integer,@w_producto integer, @num integer, @w_man integer,@w_disbur integer

select @w_rol = ro_rol,
       @w_producto = 7
 from ad_rol
where ro_descripcion='MENU POR PROCESOS'
-----------------------------------------------------------------------------------------------------------------------
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ReadDisbursementForm.ReadAccountSearch'
delete from cobis..ad_servicio_autorizado where ts_servicio= 'Loan.ReadDisbursementForm.ReadAccountSearch'

delete from cts_serv_catalog where csc_service_id in 
('Loan.ReadDisbursementForm.ReadDisbursementFormSearch','Loan.ReadDisbursementForm.ReadGlobalVariablesSearch',
'Loan.ReadDisbursementForm.InsertDetailPaymentForm',   'Loan.ReadDisbursementForm.RemoveDetailPaymentForm',
'Loan.ReadDisbursementForm.ApplyLiquidationLoan',   'Loan.ReadDisbursementForm.ValidateAccountOtherBanks',
'Loan.ReadDisbursementForm.ReadAccountsSearch',   'Loan.ReadDisbursementForm.ReadPaymentFormSearch'
)
delete from ad_servicio_autorizado where ts_servicio in 
('Loan.ReadDisbursementForm.ReadDisbursementFormSearch','Loan.ReadDisbursementForm.ReadGlobalVariablesSearch',
'Loan.ReadDisbursementForm.InsertDetailPaymentForm',    'Loan.ReadDisbursementForm.RemoveDetailPaymentForm',
'Loan.ReadDisbursementForm.ApplyLiquidationLoan',    'Loan.ReadDisbursementForm.ValidateAccountOtherBanks',
'Loan.ReadDisbursementForm.ReadAccountsSearch',   'Loan.ReadDisbursementForm.ReadPaymentFormSearch')
-- ---------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Loan.ReadDisbursementForm.ReadDisbursementFormSearch', 'cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm', 'readDisbursementFormSearch', '', 7032, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.ReadDisbursementForm.ReadDisbursementFormSearch', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-- ---------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Loan.ReadDisbursementForm.ReadGlobalVariablesSearch', 'cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm', 'readGlobalVariablesSearch', '', 7050, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.ReadDisbursementForm.ReadGlobalVariablesSearch', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-- ---------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Loan.ReadDisbursementForm.InsertDetailPaymentForm', 'cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm', 'insertDetailPaymentForm', '', 7030, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.ReadDisbursementForm.InsertDetailPaymentForm', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-- ---------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Loan.ReadDisbursementForm.RemoveDetailPaymentForm', 'cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm', 'removeDetailPaymentForm', '', 7031, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.ReadDisbursementForm.RemoveDetailPaymentForm', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-- ---------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Loan.ReadDisbursementForm.ApplyLiquidationLoan', 'cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm', 'applyLiquidationLoan', '', 7060, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.ReadDisbursementForm.ApplyLiquidationLoan', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-- ---------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Loan.ReadDisbursementForm.ValidateAccountOtherBanks', 'cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm', 'validateAccountOtherBanks', '', 29265, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.ReadDisbursementForm.ValidateAccountOtherBanks', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-- ---------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Loan.ReadDisbursementForm.ReadAccountsSearch', 'cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm', 'readAccountsSearch', '', 7003, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.ReadDisbursementForm.ReadAccountsSearch',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-- ---------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Loan.ReadDisbursementForm.ReadPaymentFormSearch', 'cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm', 'readPaymentFormSearch', '', 7076, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('Loan.ReadDisbursementForm.ReadPaymentFormSearch', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-- ---------------------------------------
select @w_disbur=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_DESEMBOLSO'
delete from cobis..cew_menu_role where mro_id_menu = @w_disbur
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_DESEMBOLSO'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_TRNSC'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
values(@num,@w_man,'MNU_ASSETS_DESEMBOLSO','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=13',@w_producto)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)