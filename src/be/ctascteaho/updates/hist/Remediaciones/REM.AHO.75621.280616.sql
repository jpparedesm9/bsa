/*************************************************/
---No Bug: 73517
---Título del Bug: MAN - Parametrización Contable
---Fecha: 28/06/2016
--Descripción del Problema: Cuando se coloca la Transaccion 253, se cae CEN.
--Descripción de la Solución: Se agregan catalogos y se envia script con trn autorizada
--Autor: Juan Tagle
/*************************************************/


------------------------------------------------------------------------
use cobis
go
------------------------------------------------------------------------
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint

select @w_producto = 4

select @w_rol = ro_rol
  from ad_rol
--where ro_descripcion like 'ADMINISTRADOR'
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

------------------CL_TTRANSACCION----------------------------
delete from cl_ttransaccion where tn_trn_code = 708
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (708, 'INGRESO CONCEPTO CONTABLE', 'IPCC', 'INGRESO CONCEPTO CONTABLE')

-------------------AD_PRO_TRANSACCION----------------------------
DELETE FROM ad_pro_transaccion where pt_transaccion=708 and pt_producto=4 and pt_procedure=708
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', @w_moneda,	708, 'V', getdate(), 708, NULL)

----------------------AD_PROCEDURE------------------------------
DELETE FROM ad_procedure WHERE pd_procedure = 708
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (708, 'sp_rem_parctocble', 'cob_remesas', 'V',  getdate(), 'reparcpto.sp')

------------------AD_TR_AUTORIZADA----------------------------
delete from ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_transaccion in (708)
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 708, @w_rol, getdate(), 1, 'V', getdate())

GO
