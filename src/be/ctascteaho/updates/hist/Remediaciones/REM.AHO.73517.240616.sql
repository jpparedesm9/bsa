/*************************************************/
---No Bug: 73517
---Título del Bug: No levanta la pantalla de canales en la apertura
---Fecha: 24/06/2016
--Descripción del Problema: Transaccion no autorizada
--Descripción de la Solución: SE envia script de remediación con autorización de trn
--Autor: Walther Toledo
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
delete from cl_ttransaccion where tn_trn_code = 1020
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1020, 'CONSULTA DATOS CLIENTE', 'CDC', 'CONSULTA DATOS CLIENTE')

-------------------AD_PRO_TRANSACCION----------------------------
DELETE FROM ad_pro_transaccion where pt_transaccion=1020 and pt_producto=2 and pt_procedure=1194
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (2, 'R', @w_moneda, 1020, 'V', getdate(), 1194, NULL)

----------------------AD_PROCEDURE------------------------------
DELETE FROM ad_procedure WHERE pd_procedure = 1194
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (1194, 'sp_datos_cliente', 'cobis', 'V',  getdate(), 'cldatcli.sp')

------------------AD_TR_AUTORIZADA----------------------------
delete from ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_transaccion in (1020)
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1020, @w_rol, getdate(), 1, 'V', getdate())

GO
