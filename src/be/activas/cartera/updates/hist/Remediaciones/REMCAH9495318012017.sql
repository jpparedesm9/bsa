
USE cobis
GO

/* CREAR CATALOGO PARA OPERACIONES DE RENOVACION */
declare @w_codigo SMALLINT

select @w_codigo = max(codigo) + 1 from cl_tabla

print 'Tabla de operaciones para renovacion'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ca_toper_ren', 'Tipo de operaciones para renovacion')
insert into cl_catalogo_pro values ('CCA', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'CREDVEHI', 'CREDVEHI', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'SINCO'   , 'SINCO'   , 'V')

select @w_codigo = @w_codigo + 1

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'
GO


/* REGISTRAR Y AUTORIZAR SPs sp_qr_renova_opera Y sp_estado_renreest */
declare @w_rol integer

select @w_rol = ro_rol 
from ad_rol
where ro_descripcion='MENU POR PROCESOS'

--Busqueda de operaciones para renovacion
delete cobis..ad_procedure       where pd_procedure   = 7207
delete cobis..cl_ttransaccion    where tn_trn_code    = 7274
delete cobis..ad_pro_transaccion where pt_transaccion = 7274 and pt_procedure = 7207
delete cobis..ad_tr_autorizada   where ta_transaccion = 7274 and ta_rol = @w_rol

INSERT INTO cobis..ad_procedure       VALUES (7207, 'sp_qr_renova_opera', 'cob_cartera', 'V', getdate(), 'qrrenope.sp')
INSERT INTO cobis..cl_ttransaccion    VALUES (7274, 'BUSQUEDA DE OPERACIONES PARA RENOVACION', 'BOPR', 'BUSQUEDA DE OPERACIONES PARA RENOVACION')
INSERT INTO cobis..ad_pro_transaccion VALUES (7,'R', 0, 7274, 'V', getdate(), 7207, NULL )
INSERT INTO cobis..ad_tr_autorizada   VALUES (7,'R', 0, 7274, @w_rol, getdate(), 1, 'V', getdate())

--Estado para renovacion reestruturacion
delete cobis..ad_procedure       where pd_procedure   = 7208
delete cobis..cl_ttransaccion    where tn_trn_code    = 7277
delete cobis..ad_pro_transaccion where pt_transaccion = 7277 and pt_procedure = 7208
delete cobis..ad_tr_autorizada   where ta_transaccion = 7277 and ta_rol = @w_rol

INSERT INTO cobis..ad_procedure       VALUES (7208, 'sp_estado_renreest', 'cob_cartera', 'V', getdate(), 'estado_renreest.sp')
INSERT INTO cobis..cl_ttransaccion    VALUES (7277, 'ESTADO PARA RENOVACION REESTRUCTURACION', 'EPRR', 'ESTADO PARA RENOVACION REESTRUCTURACION')
INSERT INTO cobis..ad_pro_transaccion VALUES (7,'R', 0, 7277, 'V', getdate(), 7208, NULL )
INSERT INTO cobis..ad_tr_autorizada   VALUES (7,'R', 0, 7277, @w_rol, getdate(), 1, 'V', getdate())
GO


/* REGISTRO Y AUTORIZACION DE SERVICIOS */
use cobis
go

declare @w_rol integer

select @w_rol = ro_rol from ad_rol
where ro_descripcion='MENU POR PROCESOS'

--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.LoansQueries.RefinanceOperationTypes'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoansQueries.RefinanceOperationTypes','cobiscorp.ecobis.assets.cloud.service.ILoansQueries','refinanceOperationTypes','refinanceOperationTypes',7027)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.LoansQueries.RefinanceOperationTypes'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.LoansQueries.RefinanceOperationTypes',7,'R',0,getdate(),@w_rol ,'V',getdate())

--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.LoansQueries.SearchRefinancingOperations'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoansQueries.SearchRefinancingOperations','cobiscorp.ecobis.assets.cloud.service.ILoansQueries','searchRefinancingOperations','searchRefinancingOperations',7274)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.LoansQueries.SearchRefinancingOperations'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.LoansQueries.SearchRefinancingOperations',7,'R',0,getdate(),@w_rol ,'V',getdate())

--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.LoansQueries.ReadOperationType'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoansQueries.ReadOperationType','cobiscorp.ecobis.assets.cloud.service.ILoansQueries','readOperationType','readOperationType',7027)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.LoansQueries.ReadOperationType'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.LoansQueries.ReadOperationType',7,'R',0,getdate(),@w_rol ,'V',getdate())

--Inserta en la tabla el servicio realizado
delete from cobis..cts_serv_catalog where csc_service_id='Loan.LoansQueries.GetRefinancingStatus'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoansQueries.GetRefinancingStatus','cobiscorp.ecobis.assets.cloud.service.ILoansQueries','getRefinancingStatus','getRefinancingStatus',7306)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.LoansQueries.GetRefinancingStatus'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.LoansQueries.GetRefinancingStatus',7,'R',0,getdate(),@w_rol ,'V',getdate())
go


/* ACTUALIZACION DEL MENU  DE PAGOS DE PRESTAMOS */
update cobis..cew_menu 
set    me_url   = 'views/ASSTS/TRNSC/T_REFINANCELISS_781/1.0.0/VC_REFINANCSL_902781_TASK.html?menu=9'
where  me_name  = 'MNU_ASSETS_PAYMENTS'
go





