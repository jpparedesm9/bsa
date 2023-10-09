/***********************************************************************************************************/
---No Bug					: 77114
---Título del Bug			: Back Office - Mantenimiento de Corresponsales - Sp no autorizado
---Fecha					: 13/07/2016 
--Descripción del Problema	: Transaccion autorizada en Pantalla 
--Descripción de la Solución: se crea script de remediación
--Autor						: Jorge Baque
/***********************************************************************************************************/

------------------------------------------------------------------------
use cobis
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_producsp tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 4,
	   @w_transaccion = 396,
	   @w_descripcion = 'MANTENIMIENTO CB RED PROPIA',
	   @w_nemonico    = 'MCBRP',
	   @w_desc_larga  = 'MANTENIMIENTO CB RED PROPIA',
	   @w_producsp    = 4,
	   @w_procedure   = 396,
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_mantenimiento_cb',
	   @w_filesp      = 're_mantcb.sp'
-- CL_TTRANSACCION---ah_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PROCEDURE---re_proc.sql------------------------------------
DELETE from cobis..ad_procedure WHERE pd_procedure = @w_procedure
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
-- AD_PRO_TRANSACCION---ah_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producsp, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---ah_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go
