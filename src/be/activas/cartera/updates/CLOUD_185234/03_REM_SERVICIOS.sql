use cobis
go

declare @w_producto int
select @w_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

delete from cts_serv_catalog where csc_service_id in ('LoansBusiness.Insurance.GetClientInsurance', 'LoansBusiness.Insurance.MaintainInsurance')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoansBusiness.Insurance.GetClientInsurance', 'cobiscorp.ecobis.loansbusiness.service.IInsurance', 'getClientInsurance', '', 74011, NULL, NULL, 'N')

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoansBusiness.Insurance.MaintainInsurance', 'cobiscorp.ecobis.loansbusiness.service.IInsurance', 'maintainInsurance', '', 74012, NULL, NULL, 'N')

delete from ad_servicio_autorizado where ts_servicio in ('LoansBusiness.Insurance.GetClientInsurance', 'LoansBusiness.Insurance.MaintainInsurance')
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
select 'LoansBusiness.Insurance.GetClientInsurance', ro_rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from cobis..ad_rol 
where ro_descripcion in (
'ADMINISTRADOR',
'OPERADOR DE BATCH COBIS',
'FUNCIONARIO OFICINA',
'CONSULTA',
'ASESOR',
'OPERADOR SOFOME',
'ASESOR MOVIL',
'PERFIL DE OPERACIONES',
'MESA DE OPERACIONES')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
select 'LoansBusiness.Insurance.MaintainInsurance', ro_rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from cobis..ad_rol 
where ro_descripcion in (
'ADMINISTRADOR',
'OPERADOR DE BATCH COBIS',
'FUNCIONARIO OFICINA',
'CONSULTA',
'ASESOR',
'OPERADOR SOFOME',
'ASESOR MOVIL',
'PERFIL DE OPERACIONES',
'MESA DE OPERACIONES')

go



declare 
@w_trn      int   = 74011,
@w_producto int

select @w_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = @w_trn ) 
	delete from cobis..ad_pro_transaccion where pt_transaccion = @w_trn  

insert into cobis..ad_pro_transaccion values(@w_producto,'R',0,@w_trn ,'V',getDate(),@w_trn ,null) 

if  exists (select 1 from cobis..cl_ttransaccion where tn_trn_code = @w_trn ) 
	delete from cobis..cl_ttransaccion where tn_trn_code = @w_trn  

insert into cobis..cl_ttransaccion values(@w_trn ,'Obtener Seguro de Cliente',convert(varchar(10),@w_trn),'Obtener Seguro de Cliente') 

if  exists (select 1 from cobis..ad_tr_autorizada where ta_transaccion = @w_trn) 
	delete from cobis..ad_tr_autorizada where ta_transaccion = @w_trn 

insert into cobis..ad_tr_autorizada 
select @w_producto,'R',0,@w_trn, ro_rol,getdate(),1,'V',getdate()
from cobis..ad_rol 
where ro_descripcion in (
'ADMINISTRADOR',
'OPERADOR DE BATCH COBIS',
'FUNCIONARIO OFICINA',
'CONSULTA',
'ASESOR',
'OPERADOR SOFOME',
'ASESOR MOVIL',
'PERFIL DE OPERACIONES',
'MESA DE OPERACIONES') 

if  exists (select 1 from cobis..ad_procedure where pd_stored_procedure = 'sp_mantenimiento_seguros' and pd_procedure = @w_trn) 
   delete from cobis..ad_procedure where pd_stored_procedure = 'sp_mantenimiento_seguros' 

insert into cobis..ad_procedure values(@w_trn,'sp_mantenimiento_seguros','cob_cartera','V',getdate(),'sp_mant_seg') 


select  @w_trn  = 74012
if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = @w_trn ) 
	delete from cobis..ad_pro_transaccion where pt_transaccion = @w_trn  

insert into cobis..ad_pro_transaccion values(@w_producto,'R',0,@w_trn ,'V',getDate(),@w_trn ,null) 

if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = @w_trn ) 
	delete from cobis..cl_ttransaccion where tn_trn_code = @w_trn  

insert into cobis..cl_ttransaccion values(@w_trn ,'Mantenimiento de Seguros',convert(varchar(10),@w_trn),'Mantenimiento de Seguros') 

if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = @w_trn) 
	delete from cobis..ad_tr_autorizada where ta_transaccion = @w_trn 
	
insert into cobis..ad_tr_autorizada 
select @w_producto,'R',0,@w_trn, ro_rol,getdate(),1,'V',getdate()
from cobis..ad_rol 
where ro_descripcion in (
'ADMINISTRADOR',
'OPERADOR DE BATCH COBIS',
'FUNCIONARIO OFICINA',
'CONSULTA',
'ASESOR',
'OPERADOR SOFOME',
'ASESOR MOVIL',
'PERFIL DE OPERACIONES',
'MESA DE OPERACIONES') 

if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_mantenimiento_seguros' and pd_procedure = @w_trn) 
	delete from cobis..ad_procedure where pd_stored_procedure = 'sp_mantenimiento_seguros' 

insert into cobis..ad_procedure values(@w_trn,'sp_mantenimiento_seguros','cob_cartera','V',getdate(),'sp_mant_seg') 

go