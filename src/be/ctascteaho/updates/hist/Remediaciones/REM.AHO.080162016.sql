/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 08/16/2016 
--Descripción del Problema	: Bug 81325:Bug : Relación en Perfiles Contables
--Descripción de la Solución: Remediación de Historia
--Autor						: Juan Tagle
/***********************************************************************************************************/


use cobis
go

------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_producsp tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 10,
	   @w_transaccion = 721,
	   @w_descripcion = 'OPCIONES DE CONSULTA PARA PARAMETRIZACION DE PERFIL',
	   @w_nemonico    = 'CPPER',
	   @w_desc_larga  = 'EJECUTA LAS CONSULTAS DE LOS DATOS PARA LA PARAMETRIZACION DE LAS TRANSACCIONES AL PERFIL CONTABLE',
	   @w_producsp    = 10,
	   @w_procedure   = 709,
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_par_perfil',
	   @w_filesp      = 'reparperfil.sp'
-- CL_TTRANSACCION---re_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PROCEDURE---re_proc.sql------------------------------------
DELETE from cobis..ad_procedure WHERE pd_procedure = @w_procedure and pd_stored_procedure = @w_nombresp and pd_base_datos = @w_base
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
-- AD_PRO_TRANSACCION---re_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion and pt_producto = @w_producsp and pt_moneda = @w_moneda
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producsp, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---re_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go

-- cob_remesas..sp_help_trn_contabilizar  494
------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_producsp tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 10,
	   @w_transaccion = 494,
	   @w_descripcion = 'CONSULTA DE TRANSACCIONES A CONTABILIZAR',
	   @w_nemonico    = 'CCON',
	   @w_desc_larga  = 'CONSULTA DE TRANSACCIONES A CONTABILIZAR',
	   @w_producsp    = 10,
	   @w_procedure   = 459,
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_help_trn_contabilizar',
	   @w_filesp      = 'rehecont.sp'
-- CL_TTRANSACCION---re_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PROCEDURE---re_proc.sql------------------------------------
DELETE from cobis..ad_procedure WHERE pd_procedure = @w_procedure and pd_stored_procedure = @w_nombresp and pd_base_datos = @w_base
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
-- AD_PRO_TRANSACCION---re_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion and pt_producto = @w_producsp and pt_moneda = @w_moneda
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producsp, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---re_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol and ta_moneda = @w_moneda
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


