/*----------------------------------------------------------------------------------------------------------------*/
--Descripción del Problema   : Consulta de estado de cuenta
--Responsable                : Darío Cumbal
/*----------------------------------------------------------------------------------------------------------------*/


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

