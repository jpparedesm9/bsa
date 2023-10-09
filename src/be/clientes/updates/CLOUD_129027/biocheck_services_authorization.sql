use cobis
go


-----------------
--BORRANDO DATA
-----------------
delete cts_serv_catalog where csc_service_id in 
('CustomerBiocheck.CustomerBiocheck.SaveRegistry',
'CustomerBiocheck.CustomerBiocheck.QueryRegistry',
'CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint',
'CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken')
delete ad_servicio_autorizado where ts_servicio in 
('CustomerBiocheck.CustomerBiocheck.SaveRegistry',
'CustomerBiocheck.CustomerBiocheck.QueryRegistry',
'CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint',
'CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken')

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR'

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

-------------------------
--SERVICIO SaveRegistry
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerBiocheck.CustomerBiocheck.SaveRegistry', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'saveRegistry', '', 18000)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
 select 'CustomerBiocheck.CustomerBiocheck.SaveRegistry',ro_rol,@w_producto,'R',0,getdate(),'V',getdate()
 from ad_rol 
 where ro_descripcion in('ADMINISTRADOR',
						'FUNCIONARIO OFICINA',
						'CONSULTA',
						'ASESOR',
						'GERENTE REGIONAL',
						'MESA DE OPERACIONES',
						'NORMATIVO',
						'GERENTE OFICINA',
						'AUDITORIA')
-------------------------
--SERVICIO QueryRegistry
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerBiocheck.CustomerBiocheck.QueryRegistry', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'queryRegistry', '', 18000)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
 select 'CustomerBiocheck.CustomerBiocheck.QueryRegistry',ro_rol,@w_producto,'R',0,getdate(),'V',getdate()
 from ad_rol 
 where ro_descripcion in('ADMINISTRADOR',
						'FUNCIONARIO OFICINA',
						'CONSULTA',
						'ASESOR',
						'GERENTE REGIONAL',
						'MESA DE OPERACIONES',
						'NORMATIVO',
						'GERENTE OFICINA',
						'AUDITORIA')

-------------------------
--SERVICIO GetWithoutFingerprint
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'getWithoutFingerprint', '', 18000)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
 select 'CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint',ro_rol,@w_producto,'R',0,getdate(),'V',getdate()
 from ad_rol 
 where ro_descripcion in('ADMINISTRADOR',
						'FUNCIONARIO OFICINA',
						'CONSULTA',
						'ASESOR',
						'GERENTE REGIONAL',
						'MESA DE OPERACIONES',
						'NORMATIVO',
						'GERENTE OFICINA',
						'AUDITORIA')

-------------------------
--SERVICIO GetDataToOpaqueToken
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'getDataToOpaqueToken', '', 18000)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
 select 'CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken',ro_rol,@w_producto,'R',0,getdate(),'V',getdate()
 from ad_rol 
 where ro_descripcion in('ADMINISTRADOR',
						'FUNCIONARIO OFICINA',
						'CONSULTA',
						'ASESOR',
						'GERENTE REGIONAL',
						'MESA DE OPERACIONES',
						'NORMATIVO',
						'GERENTE OFICINA',
						'AUDITORIA')
go
