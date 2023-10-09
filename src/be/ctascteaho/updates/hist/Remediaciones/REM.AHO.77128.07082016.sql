/* ***********************************************/
---No Bug: 77128
---T�tulo del Bug: Back Office - Aumentar D�as de Retenci�n para Canje
---Fecha: 08/07/2016
--Descripci�n del Problema: Autorizaci�n de transacciones
--Descripci�n de la Soluci�n: Se registra sp y transaccion 
--Autor: Javier Calderon
/* *************************************************/

use cobis
go


DECLARE @w_cod_procedure int, 
        @w_rol           int, 
        @w_moneda        tinyint,
        @w_producto      tinyint,
        @w_transaccion   int

--**************** Transaccion 710 ********************

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'


select @w_producto = 10

select @w_transaccion =710

--ad_procedure
if exists (select 1 from ad_procedure where pd_stored_procedure = 'sp_addhold_locales' and pd_base_datos = 'cob_remesas')
begin
    delete from ad_procedure where pd_stored_procedure = 'sp_addhold_locales' and pd_base_datos = 'cob_remesas'
end

SELECT @w_cod_procedure = max(pd_procedure)+1 FROM ad_procedure

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_cod_procedure, 'sp_addhold_locales', 'cob_remesas', 'V', getdate(), 're_addhold.sp')

--ad_pro_transaccion
if exists (select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion)
begin
    delete from ad_pro_transaccion where pt_transaccion = @w_transaccion
end

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_cod_procedure, NULL)


--cl_ttransaccion
if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
    delete from cl_ttransaccion where tn_trn_code = @w_transaccion
end

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, 'ACTUALIZACION CONCEPTO CONTABLE', 'APCC', 'ACTUALIZACION CONCEPTO CONTABLE')

--ad_tr_autorizada
if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())

go
