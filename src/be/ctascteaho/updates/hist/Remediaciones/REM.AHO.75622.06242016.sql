/************************************************/
---No Bug: 75622
---Título del Bug: Back Office - Aumentar Días de Retención para Canje
---Fecha: 24/06/2016
--Descripción del Problema: Autorización de transacciones
--Descripción de la Solución: Se registra sp y transaccion 
--Autor: Roxana Sanchez / Tania Baidal
/**************************************************/

use cobis
go


DECLARE @w_cod_procedure int, 
        @w_rol           int, 
        @w_moneda        tinyint,
        @w_producto      tinyint,
        @w_transaccion   int

--Transaccion 710

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

SELECT @w_cod_procedure = max(pd_procedure)+1 FROM ad_procedure

if not exists (select 1 from ad_procedure where pd_stored_procedure = 'sp_addhold_locales' and pd_base_datos = 'cob_remesas')
begin
    INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
    VALUES (@w_cod_procedure, 'sp_addhold_locales', 'cob_remesas', 'V', getdate(), 're_addhold.sp')
end

if not exists (select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion)
begin
    INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
    VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_cod_procedure, NULL)
end

if not exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
    INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
    VALUES (@w_transaccion, 'ACTUALIZACION CONCEPTO CONTABLE', 'APCC', 'ACTUALIZACION CONCEPTO CONTABLE')
end

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
end

go

