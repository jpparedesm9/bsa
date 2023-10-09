---------------------------------------------------
------ CREACION CLIENTE ONBOARDING ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1721,
@w_pd_procedure = 1721


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='CREACION CLIENTE ONBOARDING'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'CREACION CLIENTE ONBOARDING', @w_tn_trn_code, 'CREACION CLIENTE ONBOARDING')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_registro_onboarding' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_b2c_registro_onboarding', 'cobis', 'V', getdate(), 'b2cregonb.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

go


---------------------------------------------------
------ ACTUALIZACION CLIENTE ONBOARDING ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1722,
@w_pd_procedure = 1722


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='ACTUALIZACION CLIENTE ONBOARDING'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'ACTUALIZACION CLIENTE ONBOARDING', @w_tn_trn_code, 'ACTUALIZACION CLIENTE ONBOARDING')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_persona' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_b2c_mantenimiento_persona', 'cobis', 'V', getdate(), 'b2cmantper.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

go

---------------------------------------------------
------ CREACION DIRECCION ONBOARDING ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1723,
@w_pd_procedure = 1723


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='CREACION DIRECCION ONBOARDING'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'CREACION DIRECCION ONBOARDING', @w_tn_trn_code, 'CREACION DIRECCION ONBOARDING')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_direccion' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_b2c_mantenimiento_direccion', 'cobis', 'V', getdate(), 'b2cmantper.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

go

---------------------------------------------------
------ BUSCAR CLIENTE ONBOARDING ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1724,
@w_pd_procedure = 1724


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='BUSCAR CLIENTE ONBOARDING'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'BUSCAR CLIENTE ONBOARDING', @w_tn_trn_code, 'BUSCAR CLIENTE ONBOARDING')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_persona' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_b2c_mantenimiento_persona', 'cobis', 'V', getdate(), 'b2cmantper.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())

go


use cobis
go

declare 
@w_producto        int,
@w_rol             int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'

delete ad_servicio_autorizado where ts_servicio in 
('BusinessToConsumer.CustomerManagement.OnboardingRegister',
 'BusinessToConsumer.CustomerManagement.UpdateProspect', 
 'BusinessToConsumer.CustomerManagement.CreateAddress', 
 'BusinessToConsumer.CustomerManagement.SearchCustomer',
 'BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm',
 'BusinessToConsumer.OnboardingCreditManagement.CreateOperation' )
delete cts_serv_catalog where csc_service_id in 
('BusinessToConsumer.CustomerManagement.OnboardingRegister',
 'BusinessToConsumer.CustomerManagement.UpdateProspect', 
 'BusinessToConsumer.CustomerManagement.CreateAddress', 
 'BusinessToConsumer.CustomerManagement.SearchCustomer',
 'BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm',
 'BusinessToConsumer.OnboardingCreditManagement.CreateOperation')

INSERT INTO cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES
('BusinessToConsumer.CustomerManagement.OnboardingRegister', 'cobiscorp.ecobis.businesstoconsumer.service.ICustomerManagement', 'onboardingRegister', '', 1721, NULL, NULL, 'Y')
INSERT INTO ad_servicio_autorizado
(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.CustomerManagement.OnboardingRegister', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


INSERT INTO cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES
('BusinessToConsumer.CustomerManagement.UpdateProspect', 'cobiscorp.ecobis.businesstoconsumer.service.ICustomerManagement', 'updateProspect', '', 1722, NULL, NULL, 'Y')
INSERT INTO ad_servicio_autorizado
(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.CustomerManagement.UpdateProspect', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


INSERT INTO cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES
('BusinessToConsumer.CustomerManagement.CreateAddress', 'cobiscorp.ecobis.businesstoconsumer.service.ICustomerManagement', 'createAddress', '', 1723, NULL, NULL, 'Y')
INSERT INTO ad_servicio_autorizado
(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.CustomerManagement.CreateAddress', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


INSERT INTO cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES
('BusinessToConsumer.CustomerManagement.SearchCustomer', 'cobiscorp.ecobis.businesstoconsumer.service.ICustomerManagement', 'searchCustomer', '', 1724, NULL, NULL, 'Y')
INSERT INTO ad_servicio_autorizado
(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.CustomerManagement.SearchCustomer', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


go

--Autorizacion seguro de vida
use cobis
GO

IF EXISTS (SELECT * FROM cobis..cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.OnBoarding.CreateLifeInsurance')
  UPDATE cobis..cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.individualloan.service.IOnBoarding', csc_method_name = 'createLifeInsurance', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'IndividualLoan.OnBoarding.CreateLifeInsurance'
ELSE
  INSERT INTO cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('IndividualLoan.OnBoarding.CreateLifeInsurance', 'cobiscorp.ecobis.individualloan.service.IOnBoarding', 'createLifeInsurance', '', 0)
GO

use cobis
go

declare
@w_producto int,
@w_rol int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS'

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'BANCA VIRTUAL'


INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToConsumer.OnboardingCreditManagement.CreateOperation', 'cobiscorp.ecobis.businesstoconsumer.service.IOnboardingCreditManagement', 'createOperation', '', 0, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.OnboardingCreditManagement.CreateOperation', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

go

-- ======================== BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm ========================
--Tomado del archivo \src\be\applications\mobileapp\b2c\installer\sql\b2c_services.sql
use cobis
go

declare @w_producto int, @w_rol int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS'

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm', 'cobiscorp.ecobis.businesstoconsumer.service.IDisbursementCreditLineManagement', 'createKycForm', '', 0)
insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	values('BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm', @w_rol, 18, 'R', 0, getdate(), 'V', getdate())
go
