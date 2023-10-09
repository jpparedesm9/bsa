use cobis
go

/* CREACION DEL MENU */
DECLARE @w_mant_pago INT, @w_man INT, @num INT 

select @w_mant_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_VALUES_RATES'
delete from cobis..cew_menu_role where mro_id_menu = @w_mant_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_VALUES_RATES'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
values(@num,@w_man,'MNU_ASSETS_VALUES_RATES','views/ASSTS/MNTNN/T_VALUERATESFBO_932/1.0.0/VC_VALUERATEE_334932_TASK.html',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)
GO

/* REGISTRO Y AUTORIZACION DE LOS SERVICIOS */
use cobis
go

declare @w_rol integer

select @w_rol = ro_rol from ad_rol
where ro_descripcion='MENU POR PROCESOS'

--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.RatesManagement.SearchRates'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.RatesManagement.SearchRates','cobiscorp.ecobis.assets.cloud.service.IRatesManagement','searchRates','searchRates',7126)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.RatesManagement.SearchRates'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.RatesManagement.SearchRates',7,'R',0,getdate(),@w_rol ,'V',getdate())


--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.RatesManagement.SearchValuesRate'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.RatesManagement.SearchValuesRate','cobiscorp.ecobis.assets.cloud.service.IRatesManagement','searchValuesRate','searchValuesRate',7126)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.RatesManagement.SearchValuesRate'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.RatesManagement.SearchValuesRate',7,'R',0,getdate(),@w_rol ,'V',getdate())


--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.RatesManagement.CreateTypeRate'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.RatesManagement.CreateTypeRate','cobiscorp.ecobis.assets.cloud.service.IRatesManagement','createTypeRate','createTypeRate',7126)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.RatesManagement.CreateTypeRate'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.RatesManagement.CreateTypeRate',7,'R',0,getdate(),@w_rol ,'V',getdate())

--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.RatesManagement.ReferenceValueList'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.RatesManagement.ReferenceValueList','cobiscorp.ecobis.assets.cloud.service.IRatesManagement','referenceValueList','referenceValueList',7120)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.RatesManagement.ReferenceValueList'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.RatesManagement.ReferenceValueList',7,'R',0,getdate(),@w_rol ,'V',getdate())

--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.RatesManagement.GetReferenceValue'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.RatesManagement.GetReferenceValue','cobiscorp.ecobis.assets.cloud.service.IRatesManagement','getReferenceValue','getReferenceValue',7120)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.RatesManagement.GetReferenceValue'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.RatesManagement.GetReferenceValue',7,'R',0,getdate(),@w_rol ,'V',getdate())

--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.RatesManagement.DeleteValuesRate'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.RatesManagement.DeleteValuesRate','cobiscorp.ecobis.assets.cloud.service.IRatesManagement','deleteValuesRate','deleteValuesRate',7127)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.RatesManagement.DeleteValuesRate'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.RatesManagement.DeleteValuesRate',7,'R',0,getdate(),@w_rol ,'V',getdate())
go
--
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_ASSETS_ADM'
update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_ASSETS_VALUES_RATES'


--Remediación ROLES
delete FROM cobis..ad_rol
WHERE ro_descripcion = 'MENU POR PROCESOS'
AND ro_rol <> 3

GO

