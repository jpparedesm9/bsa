use cobis
go

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar -: 452
-----------------------------------------------------------------------------------------
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint,
     @w_trx      smallint
select @w_producto = 10
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
select @w_trx = 452
---------------------------------------------------------ah_tran.sql
delete cl_ttransaccion where tn_trn_code=@w_trx
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'CONSULTA DE BANCOS PARA CAMARA', 'CBPC', 'CONSULTA DE LOS BANCOS EXISTENTES PARA CAMARA')
-------re_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = @w_trx  and pt_producto=@w_producto and pt_moneda=@w_moneda
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, @w_trx, 'V', getdate(), 440, NULL)
-------ah_traut.sql 
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = @w_trx 
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())
-------re_proc.sql
delete from ad_procedure where pd_procedure=440
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (440, 'sp_cat_bancos', 'cob_remesas', 'V', getdate(), 'cmcatban.sp')
go

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar : 672
-----------------------------------------------------------------------------------------
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint,
     @w_trx      smallint
select @w_producto = 10
select @w_rol = ro_rol  from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cl_parametro where pa_nemonico = 'CMNAC'   and pa_producto = 'ADM'
select @w_trx = 672
---------------------------------------------------------ah_tran.sql
delete cl_ttransaccion where tn_trn_code=@w_trx 
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'INGRESO TIPO CANJE POR OFICINA', 'TDCO', 'INGRESO TIPO CANJE POR OFICINA')
-------re_protran.sql
delete from ad_pro_transaccion WHERE pt_transaccion = @w_trx  and pt_producto=@w_producto and pt_moneda=@w_moneda
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, @w_trx, 'V', getdate(), 414, NULL)
-------re_traut.sql 
delete ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda and ta_transaccion = @w_trx 
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())
-------re_proc.sql
delete from ad_procedure where pd_procedure=414
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (414, 'sp_oficina_tipo_canje', 'cob_remesas', 'V', getdate(), 'reofican.sp')

go


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--•   Usted no ha sido autorizado para ejecutar sp_causal_ndc_oficina-cob_remesas: 717
-----------------------------------------------------------------------------------------
-- re_proc.sql
delete from ad_procedure where pd_procedure=717
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (717, 'sp_causal_ndc_oficina', 'cob_remesas', 'V', getdate(), 'causndcofi.sp')
GO