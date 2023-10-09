use cobis
go

/******************************************************/
--Fecha Creación del Script: 2016/07/06               */
--Historial  Dependencias:                            */
--Insertar Transacciones autorizadas 429              */
--Modulo :MIS CTA_AHO                                 */
/******************************************************/

--******** Pantalla FTRAN2700 ********

DECLARE @w_cod_procedure int, 
        @w_rol           int, 
        @w_moneda        tinyint,
        @w_producto      tinyint,
		@w_transaccion   int

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'



--Transaccion 429
select @w_producto = 3
select @w_transaccion = 429

--ad_procedure
if exists (select 1 from ad_procedure where pd_stored_procedure = 'sp_rem_chequexofi' and pd_base_datos = 'cob_remesas')
begin
    delete from ad_procedure where pd_stored_procedure = 'sp_rem_chequexofi' and pd_base_datos = 'cob_remesas'
end

SELECT @w_cod_procedure = max(pd_procedure) + 1 from ad_procedure

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_cod_procedure, 'sp_rem_chequexofi', 'cob_remesas', 'V', getdate(), 'rechqofi.sp')

--cl_ttransaccion
if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
    delete from cl_ttransaccion where tn_trn_code = @w_transaccion
end

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, 'CONSULTA DE CHEQUES REMESA POR OFICINA', 'CRPO', 'CONSULTA DE CHEQUES REMESA POR OFICINA')

--ad_pro_transaccion

if exists (select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion)
begin
    delete from ad_pro_transaccion where pt_transaccion = @w_transaccion
end

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_cod_procedure, NULL)

--ad_tr_autorizada
if exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    delete from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol
end

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())

GO

