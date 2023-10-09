
use cobis
go


-----------------
--BORRANDO DATA
-----------------

delete cts_serv_catalog where csc_service_id in ('CustomerDataBusiness.BusinessResearch.GetFormData','CustomerDataBusiness.BusinessResearch.SaveAnswer','CustomerDataBusiness.BusinessResearch.GetAnswers','CustomerDataBusiness.CustomerResearch.getCustomerByProcess')
delete ad_servicio_autorizado where ts_servicio in ('CustomerDataBusiness.BusinessResearch.GetFormData','CustomerDataBusiness.BusinessResearch.SaveAnswer','CustomerDataBusiness.BusinessResearch.GetAnswers','CustomerDataBusiness.CustomerResearch.getCustomerByProcess')

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR'

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'



-------------------------
--SERVICIO GetFormData
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerDataBusiness.BusinessResearch.GetFormData', 'cobiscorp.ecobis.customerdatabusiness.service.IBusinessResearch', 'getFormData', '', 130500)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
 select 'CustomerDataBusiness.BusinessResearch.GetFormData',ro_rol,@w_producto,'R',0,getdate(),'V',getdate()
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
--SERVICIO SaveAnswer
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerDataBusiness.BusinessResearch.SaveAnswer', 'cobiscorp.ecobis.customerdatabusiness.service.IBusinessResearch', 'saveAnswer', '', 130500)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
select 'CustomerDataBusiness.BusinessResearch.SaveAnswer',ro_rol,@w_producto,'R',0,getdate(),'V',getdate()
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

--SERVICIO getAnswer
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('CustomerDataBusiness.BusinessResearch.GetAnswers', 'cobiscorp.ecobis.customerdatabusiness.service.IBusinessResearch', 'getAnswers', '', 130500)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
select 'CustomerDataBusiness.BusinessResearch.GetAnswers',ro_rol,@w_producto,'R',0,getdate(),'V',getdate()
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


--SERVICIO getCustomerByProcess
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
VALUES ('CustomerDataBusiness.CustomerResearch.getCustomerByProcess', 'cobiscorp.ecobis.customerdatabusiness.service.ICustomerResearch', 'getCustomerByProcess', '', 130500)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
select 'CustomerDataBusiness.CustomerResearch.getCustomerByProcess',ro_rol,@w_producto,'R',0,getdate(),'V',getdate()
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
    
GO