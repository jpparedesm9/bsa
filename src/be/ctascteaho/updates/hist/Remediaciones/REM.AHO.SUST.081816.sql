/*************************************************/
---No Bug: N/A
---Título de la Historia: Falta autorizacion en Susteining y Test
---Fecha: 08/08/2016
--Descripción del la Historia:  Autorizacion en Sustaining
--Descripción de la Solución: Se crea el registro de Autorizacion en Sustaining
--Autor: Walther Toledo
/*************************************************/

use cobis
go
declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'
-- -----------------------------------------------
select @w_moneda = pa_tinyint
  from cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
-- -----------------------------------------------
select @w_producto = 4 --->PRODUCTO 4 - AHORROS
-- -----------------------------------------------

-- ah_tran.sql
delete from cl_ttransaccion where tn_trn_code = 500
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (500, 'CONSULTA DE TRANSACCIONES MONETARIAS AHORROS PARA REVERSO', 'TMAHRE', 'CONSULTA DE TRANSACCIONES MONETARIAS AHORROS PARA REVERSO')

-- ah_protran.sql
delete from ad_pro_transaccion where pt_producto = @w_producto and pt_tipo='R' and pt_moneda = @w_moneda and pt_procedure = 278 and pt_transaccion = 500
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 500, 'V', getdate(), 278, NULL)

-- ah_proc.sql
delete from ad_procedure where pd_procedure = 278
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (278, 'sp_rev_tran_monet', 'cob_ahorros', 'V', getdate(), 'rev_tranmon.sp')

-- ah_traut.sql
delete from ad_tr_autorizada where ta_producto = @w_producto and ta_tipo = 'R' and ta_moneda = @w_moneda and ta_transaccion = 500
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 500, @w_rol, getdate(), 1, 'V', getdate())

GO

