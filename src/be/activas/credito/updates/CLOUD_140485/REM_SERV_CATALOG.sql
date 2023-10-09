use cobis
go

declare 
@w_producto              int,
@w_tn_trn_code           int,
@w_pd_procedure          int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select 
@w_tn_trn_code  = 18001,
@w_pd_procedure = 18001

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ADMINISTRADOR',
'FUNCIONARIO OFICINA',
'CONSULTA',
'ASESOR',
'GERENTE REGIONAL',
'MESA DE OPERACIONES',
'NORMATIVO',
'GERENTE OFICINA',
'AUDITORIA'
)


delete cts_serv_catalog where csc_service_id = 'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount'

insert into cts_serv_catalog values ('CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheckLCR','getCustomerAmount','',@w_tn_trn_code,null, null, null)

delete ad_servicio_autorizado  where ts_servicio = 'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount'

insert into ad_servicio_autorizado 
select 'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from @w_roles


delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code 
insert into cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values(@w_tn_trn_code, 'OBTENER CLIENTE LCR BIOMETRICO', convert(char(6), @w_tn_trn_code), 'OBTENER CLIENTE LCR BIOMETRICO')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure 
insert into cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values(@w_pd_procedure, 'sp_lcr_consulta_bio', 'cobis', 'V', getdate(), 'lcr_consbio.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
insert into cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code 
insert into cobis..ad_tr_autorizada
select @w_producto, 'R', 0, @w_tn_trn_code, rol, getdate(), 1, 'V', getdate()
from @w_roles

go