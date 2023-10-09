/******************************************************/
--Fecha Creación del Script: 2016/07/06               */
--Insertar Transacciones autorizadas 16,2733,2796     */
--Modulo :CUENTAS                                     */
/******************************************************/


/* *****************************************************/
--ad_procedure
/*******************************************************/
use cobis
go


Delete from ad_procedure
where pd_procedure in (75,2669,2597)

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (75, 'sp_tr_query_nom_ctacte', 'cob_cuentas', 'V', getdate(), 'ccpconom.sp')
GO

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2669, 'sp_control_efectivo', 'cob_cuentas', 'V', getdate(), 'conefect.sp')
GO


INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2597, 'sp_query_excep_sipla', 'cob_cuentas', 'V', getdate(), 'ccqryexs.sp')
GO

/* *****************************************************/
--ad_tr_autorizada
/*******************************************************/


-----------------------------------------------------------------------------------------------------------------

declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

select @w_producto = 3 --->PRODUCTO 10 - REMESAS Y CAMARA

delete FROM ad_tr_autorizada 
 WHERE ta_transaccion in (16,2733,2796) 
   and ta_producto = @w_producto  -- CUENTA CORRIENTE
   and ta_rol = @w_rol
   
   
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 16, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 2733, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 2796, @w_rol, getdate(), 1, 'V', getdate())

GO

/* *****************************************************/
--ad_pro_transaccion
/*******************************************************/
---------------------------------------------------------------------------------------------------------
declare @w_moneda  tinyint,
        @w_producto tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'
 select @w_producto =3
-- -----------------------------------
delete cobis..ad_pro_transaccion
where  pt_producto = 3 -- CUENTA CORRIENTES
 AND pt_transaccion in ( 16,2733,2796)
-- -----------------------------------
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 16, 'V', getdate(), 75, NULL)

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 2733, 'V', getdate(), 2597, NULL)
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 2796, 'V', getdate(), 2669, NULL)

GO

