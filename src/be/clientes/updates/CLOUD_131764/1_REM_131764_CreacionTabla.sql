use cobis
go


--CREACION DE TABLA
IF OBJECT_ID ('dbo.cl_lista_exclusion') IS NOT NULL
	DROP TABLE dbo.cl_lista_exclusion
GO

CREATE TABLE dbo.cl_lista_exclusion
	(
	le_secuencial          int IDENTITY not null,
	le_ente                INT NOT NULL,
	le_accion              CHAR(1) NULL,
	le_calif               CHAR(1) NULL,
	le_fecha               DATETIME NULL,
	le_login               catalogo NULL	
	)
GO
	

--CREACION DE TRANSACCION PARA SP
if exists (select 1 from ad_procedure 
           where pd_procedure = 2173 )
	delete ad_procedure where pd_procedure = 2173
go

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2173,'sp_lista_exclusion_dml','cobis','V',getdate(),'cl_listexc.sp')

--CREACION DE CODIGO DE TRANSACCION PROCEDIMIENTO AUTORIZADO
if exists (select 1 from ad_pro_transaccion where pt_producto = 2 and pt_procedure = 2173 )
	delete ad_pro_transaccion where pt_producto = 2 and pt_procedure = 2173
go

declare @w_moneda int
select @w_moneda = pa_tinyint
  from cl_parametro
 where pa_nemonico = 'MLO'
   and pa_producto = 'ADM'

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (2,'R',@w_moneda,610,'V',getdate(),2173)--insertar


insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (2,'R',@w_moneda,611,'V',getdate(),2173)--eliminar


insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (2,'R',@w_moneda,612,'V',getdate(),2173)--consultar

--CREACION DE TRANSACCION
if exists (select 1 from cl_ttransaccion where tn_trn_code in (610,611,612))
	delete cl_ttransaccion where tn_trn_code in (610,611,612)
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,	tn_desc_larga)
values(610,'INSERCION DE CLIENTE EN LISTA DE EXCLUSION','ICLE','INSERTAR')
GO

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,	tn_desc_larga)
values(611,'ELIMINACION DE CLIENTE EN LISTA DE EXCLUSION','ECLE','ELIMINAR')
GO

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,	tn_desc_larga)
values(612,'CONSULTA DE CLIENTES EN LISTA DE EXCLUSION','CCLE','CONSULTAR')
GO

--CREACION DE TRANSACCION AUTORIZADA
declare @codigo int, 
        @w_moneda int
select @codigo = ro_rol from ad_rol where ro_descripcion = 'MESA DE OPERACIONES'

select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'
 
if exists (select 1 from ad_tr_autorizada where ta_producto = 2 and ta_rol = @codigo and ta_transaccion in(610,611,612))
	delete ad_tr_autorizada where ta_producto = 2 and ta_rol = @codigo and ta_transaccion in(610,611,612)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', @w_moneda, 610, @codigo, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', @w_moneda, 611, @codigo, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', @w_moneda, 612, @codigo, getdate(), 1, 'V', getdate())

go


--CREACION DE ERRORES
if exists(select 1 from cl_errores where numero IN (201050, 201051, 201052, 201053, 201054))
   delete cl_errores where numero in(201050, 201051, 201052, 201053, 201054)
   
insert into cl_errores (numero, severidad, mensaje)
values(201050, 0, 'ERROR AL INSERTAR EL CLIENTE EN LA LISTA DE EXCLUSION')   
go

insert into cl_errores (numero, severidad, mensaje)
values(201051, 0, 'ERROR AL BUSCAR DATOS DEL CLIENTE EN LA LISTA DE EXCLUSION')   
GO

insert into cl_errores (numero, severidad, mensaje)
values(201052, 0, 'ERROR AL ELIMINAR DEL CLIENTE EN LA LISTA DE EXCLUSION')   
go

insert into cl_errores (numero, severidad, mensaje)
values(201053, 0, 'ERROR YA EXISTE EL CLIENTE EN LA LISTA DE EXCLUSION')   
go


---------------------------
--REGISTRAR LOS SERVICIOS
---------------------------
USE cobis
GO

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_trn IN (610,611,612))
BEGIN
   DELETE cts_serv_catalog WHERE csc_trn IN (610,611,612)
END


INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateExclusionList', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createExclusionList', 'createExclusionList', 610, NULL, NULL, NULL)
GO

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.DeleteExclusionList', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteExclusionList', 'deleteExclusionList', 611, NULL, NULL, NULL)
GO

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.QueryExclusionList', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'queryExclusionList', 'queryExclusionList', 613, NULL, NULL, NULL)
GO

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.SearchExclusionList', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'queryExclusionList', 'searchExclusionList', 612, NULL, NULL, NULL)
GO

SELECT * FROM cts_serv_catalog WHERE csc_trn IN (610,611,612)



IF EXISTS (SELECT 1 FROM cobis..ad_servicio_autorizado WHERE ts_servicio IN (
			'CustomerDataManagementService.CustomerManagement.CreateExclusionList',
			'CustomerDataManagementService.CustomerManagement.DeleteExclusionList',
			'CustomerDataManagementService.CustomerManagement.QueryExclusionList', 
			'CustomerDataManagementService.CustomerManagement.SearchExclusionList'))
BEGIN
   DELETE cobis..ad_servicio_autorizado WHERE ts_servicio IN (
			'CustomerDataManagementService.CustomerManagement.CreateExclusionList',
			'CustomerDataManagementService.CustomerManagement.DeleteExclusionList',
			'CustomerDataManagementService.CustomerManagement.QueryExclusionList', 
			'CustomerDataManagementService.CustomerManagement.SearchExclusionList')
end			

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateExclusionList', 29, 2, 'R', 0, getdate(), 'V', getdate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.DeleteExclusionList', 29, 2, 'R', 0, getdate(), 'V', getdate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.QueryExclusionList', 29, 2, 'R', 0, getdate(), 'V', getdate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.SearchExclusionList', 29, 2, 'R', 0, getdate(), 'V', getdate())
GO

SELECT * FROM cobis..ad_servicio_autorizado WHERE ts_servicio IN (
			'CustomerDataManagementService.CustomerManagement.CreateExclusionList',
			'CustomerDataManagementService.CustomerManagement.DeleteExclusionList',
			'CustomerDataManagementService.CustomerManagement.QueryExclusionList', 
			'CustomerDataManagementService.CustomerManagement.SearchExclusionList')
