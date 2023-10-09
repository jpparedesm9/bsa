/*----------------------------------------------------------------------------------------------------------------*/
--Descripción del Problema   : Consulta de estado de cuenta
--Responsable                : Darío Cumbal
/*----------------------------------------------------------------------------------------------------------------*/

print '-- ROLLBACK REGISTRO DE TRANSACCIONES'
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

