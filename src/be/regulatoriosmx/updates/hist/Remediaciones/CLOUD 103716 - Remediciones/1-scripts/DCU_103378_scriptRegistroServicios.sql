--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : .sql

print '-- REGISTRO DE SERVICIOS'
go

use cobis
go

declare @w_sec_tn_trn_code int, @w_sec_pd_procedure int
declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
	
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	  IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IWorkloadOfficerQuery', csc_method_name = 'queryOfficeOfficer', csc_description = '', csc_trn = 21975 WHERE csc_service_id = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IWorkloadOfficerQuery', 'queryOfficeOfficer', '', 21975)    	
end
else
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ADMINISTRADOR'
	
/*InternalExternalCreditReport*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
   	IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IWorkloadOfficerQuery', csc_method_name = 'queryOfficeOfficer', csc_description = '', csc_trn = 21975 WHERE csc_service_id = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IWorkloadOfficerQuery', 'queryOfficeOfficer', '', 21975)    	
	
 		
end



select @w_sec_tn_trn_code  = 21975
select @w_sec_pd_procedure = 21975

select * from cobis..cl_ttransaccion where tn_trn_code = @w_sec_tn_trn_code and tn_descripcion = 'BUSQUEDA OFICINA OFICIAL'

delete from cobis..cl_ttransaccion where tn_trn_code = @w_sec_tn_trn_code and tn_descripcion = 'BUSQUEDA OFICINA OFICIAL'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_sec_tn_trn_code, 'BUSQUEDA OFICINA OFICIAL', @w_sec_tn_trn_code, 'BUSQUEDA OFICINA OFICIAL')

select * from cobis..ad_procedure where pd_procedure = @w_sec_pd_procedure and pd_stored_procedure ='sp_busqueda_oficina_oficial' 

delete from cobis..ad_procedure where pd_procedure = @w_sec_pd_procedure and pd_stored_procedure ='sp_busqueda_oficina_oficial' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_sec_pd_procedure, 'sp_busqueda_oficina_oficial', 'cob_credito', 'V', getdate(), 'cr_busqueda.sp')

select * from cobis..ad_pro_transaccion where pt_transaccion=@w_sec_tn_trn_code and pt_procedure = @w_sec_pd_procedure

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_sec_tn_trn_code and pt_procedure = @w_sec_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(7, 'R', 0, @w_sec_tn_trn_code, 'V', getdate(), @w_sec_pd_procedure, NULL)

select * from cobis..ad_tr_autorizada where ta_transaccion = @w_sec_tn_trn_code and ta_rol=@w_rol

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_sec_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(7, 'R', 0, @w_sec_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())
                                       
go


