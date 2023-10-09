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

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_registro_onboarding' 

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol

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

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_persona' 

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol

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

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_direccion' 

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol

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

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_b2c_mantenimiento_persona' 

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol

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
 'BusinessToConsumer.OnboardingCreditManagement.CreateOperation',
 'IndividualLoan.OnBoarding.CreateLifeInsurance')
 
delete cts_serv_catalog where csc_service_id in 
('BusinessToConsumer.CustomerManagement.OnboardingRegister',
 'BusinessToConsumer.CustomerManagement.UpdateProspect', 
 'BusinessToConsumer.CustomerManagement.CreateAddress', 
 'BusinessToConsumer.CustomerManagement.SearchCustomer',
 'BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm',
 'BusinessToConsumer.OnboardingCreditManagement.CreateOperation',
 'IndividualLoan.OnBoarding.CreateLifeInsurance')

go


