/************************************************/
---No Bug: 79848
---Título del Bug: Bug: Back Office - Sp 's sin autorización
---Fecha: 30/07/2016
--Descripción del Problema: Autorización de transacciones
--Descripción de la Solución: Se registra los respectivos script para Autorizar dicash TRXs
--Autor: Walther Toledo
/**************************************************/

use cobis
go
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
declare 
     @w_rol         int,
     @w_moneda      tinyint,
     @w_producto    tinyint,
     @w_trx         int,
     @w_proc         int

select @w_rol = ro_rol
  from ad_rol
--where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
select @w_trx       = 702, -- Id de la trx
       @w_proc      = 700,  -- prod asociado
       @w_producto  = 4

------------------CL_TTRANSACCION----------------------------ah_tran.sql
delete from cl_ttransaccion where tn_trn_code = @w_trx
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'CONSULTA ARCHIVO DE ALIANZAS', 'CAAC', 'CONSULTA ARCHIVO DE ALIANZAS')

-------------------AD_PRO_TRANSACCION----------------------------re_protran.sql
select @w_producto = 10 -- REMESAS

DELETE FROM ad_pro_transaccion where pt_transaccion=@w_trx and pt_producto=@w_producto and pt_procedure=@w_proc and pt_moneda=@w_moneda
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), @w_proc, NULL)

----------------------AD_PROCEDURE------------------------------re_proc.sql
DELETE FROM ad_procedure WHERE pd_procedure = @w_proc
INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_proc, 'sp_consulta_alianza', 'cob_remesas', 'V', getdate(), 'consalianza.sp')

------------------AD_TR_AUTORIZADA----------------------------re_traut.sql
delete from ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_transaccion in (@w_trx) and ta_moneda=@w_moneda
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

select @w_trx       = 722, -- Id de la trx
       @w_proc      = 710,  -- prod asociado
       @w_producto  = 10

------------------CL_TTRANSACCION----------------------------re_tran.sql
delete from cl_ttransaccion where tn_trn_code = @w_trx
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_trx, 'CONSULTA ARCHIVO DE ALIANZAS', 'CAAC', 'CONSULTA ARCHIVO DE ALIANZAS')

-------------------AD_PRO_TRANSACCION----------------------------re_protran.sql
DELETE FROM ad_pro_transaccion where pt_transaccion=@w_trx and pt_producto=@w_producto and pt_procedure=@w_proc and pt_moneda=@w_moneda
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), @w_proc, NULL)

----------------------AD_PROCEDURE------------------------------re_proc.sql
delete from ad_procedure WHERE pd_procedure = @w_proc
insert into  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (@w_proc, 'sp_mto_marca_servicio', 'cob_remesas', 'V', getdate(), 'remtomase.sp')

------------------AD_TR_AUTORIZADA----------------------------re_traut.sql
delete from ad_tr_autorizada where ta_producto = @w_producto and ta_rol = @w_rol and ta_transaccion in (@w_trx) and ta_moneda=@w_moneda
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, @w_rol, getdate(), 1, 'V', getdate())

go

