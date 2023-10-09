--------------------
-- PAGOS OBJETADOS #108348
--------------------
use cobis
go

declare 
@w_tn_trn_code    int, 
@w_pd_procedure   int, 
@w_pd_producto    tinyint, 
@w_ro_rol		  tinyint, 
@w_ta_autorizante smallint

--------------------------------- RegularizePayments.ObjetedPayments.GetAllObjetedPayments ---------------------------------

select @w_tn_trn_code = 7070001 -- Se inicializa el codigo de la transacción
select @w_pd_procedure = isnull(max(pd_procedure), 0) +1 from ad_procedure -- Obtiene el id de maximo de la tabla cobis..ad_procedure
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol autorizante

delete from ad_procedure where pd_stored_procedure = 'sp_abono_objetado'
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) values (@w_pd_procedure, 'sp_abono_objetado', 'cob_cartera' ,'V', GETDATE(), 'abono_obj.sp')

select @w_pd_procedure = pd_procedure from ad_procedure where pd_stored_procedure = 'sp_abono_objetado'

delete from cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (@w_tn_trn_code, 'CONSULTA PAGOS OBJETADOS', @w_tn_trn_code, 'CONSULTA PAGOS OBJETADOS')

delete from ad_pro_transaccion where pt_transaccion = @w_tn_trn_code and pt_producto = @w_pd_producto
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

delete from ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_producto = @w_pd_producto
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())

--------------------------------- RegularizePayments.ObjetedPayments.InsertObjetedPayments ---------------------------------

select @w_tn_trn_code = 7070002 -- Se inicializa el codigo de la transacción
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol autorizante

delete from cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (@w_tn_trn_code, 'INSERTAR PAGOS OBJETADOS', @w_tn_trn_code, 'INSERTAR PAGOS OBJETADOS')

delete from ad_pro_transaccion where pt_transaccion = @w_tn_trn_code and pt_producto = @w_pd_producto
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

delete from ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_producto = @w_pd_producto
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())


--------------------------------- RegularizePayments.ObjetedPayments.OpRegularizePayments ---------------------------------

select @w_tn_trn_code = 7070003 -- Se inicializa el codigo de la transacción
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el codigo del rol autorizante

delete from cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values (@w_tn_trn_code, 'REGULARIZAR PAGOS OBJETADOS', @w_tn_trn_code, 'REGULARIZAR PAGOS OBJETADOS')

delete from ad_pro_transaccion where pt_transaccion = @w_tn_trn_code and pt_producto = @w_pd_producto
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

delete from ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_producto = @w_pd_producto
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) values (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
----------------------------------------------------------------------
