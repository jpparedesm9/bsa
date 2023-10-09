/*----------------------------------------------------------------------------------------------------------------*/
--Descripción del Problema   : Consulta de estado de cuenta
--Responsable                : Darío Cumbal
/*----------------------------------------------------------------------------------------------------------------*/

print '-- REGISTRO DE TRANSACCIONES'
go

use cobis
go


PRINT '--->> Registro de sp consestcue.sp'
GO

use cobis
go

DECLARE @w_numero int, @w_producto int
select @w_numero = 73904
select @w_producto = 7
-- reprocesable
-- reprocesable
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete from cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete from cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete from cobis..ad_procedure where pd_procedure = @w_numero


-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_actualiza_grupal','cob_cartera','V',getdate(),'actgrp.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'ACTUALIZAR PRESTAMO GRUPAL', convert(varchar,@w_numero), 'ACTUALIZAR PRESTAMO GRUPAL')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

if exists (SELECT 1 FROM ad_rol WHERE ro_descripcion = 'MENU POR PROCESOS')
begin
         select @w_rol = ro_rol
         from cobis..ad_rol
         where ro_descripcion = 'MENU POR PROCESOS'
end
else
begin
	     select @w_rol = ro_rol
         from cobis..ad_rol
         where ro_descripcion = 'ADMINISTRADOR'
end

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go

