/*----------------------------------------------------------------------------------------------------------------*/
--Descripción del Problema   : Insercion de Datos Interfactura
--Responsable                : Patricio Samueza
/*----------------------------------------------------------------------------------------------------------------*/

print '-- REGISTRO DE TRANSACCIONES'
go

use cobis
go


PRINT '--->> Registro de sp sp_lee_inter_factura.sp'
GO

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 36008
select @w_producto = 36
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_lee_inter_factura','cob_conta_super','V',getdate(),'sp_in_fac.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'OBTENER DATOS DE INTERFACTURA', convert(varchar,@w_numero), 'OBTENER DATOS DE INTERFACTURA')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go
