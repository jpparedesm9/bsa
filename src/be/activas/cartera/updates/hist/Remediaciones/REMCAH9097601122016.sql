USE cobis
GO

declare @w_rol INTEGER

select @w_rol = ro_rol 
from cobis..ad_rol
where ro_descripcion='MENU POR PROCESOS'


delete cobis..cl_ttransaccion    where tn_trn_code    = 7202
delete cobis..ad_pro_transaccion where pt_transaccion = 7202 and pt_procedure = 7202
delete cobis..ad_tr_autorizada   where ta_transaccion = 7202 and ta_rol = @w_rol

delete cobis..ad_procedure       where pd_procedure   = 7206
delete cobis..cl_ttransaccion    where tn_trn_code    = 7204
delete cobis..ad_pro_transaccion where pt_transaccion = 7204 and pt_procedure = 7206
delete cobis..ad_tr_autorizada   where ta_transaccion = 7204 and ta_rol = @w_rol

INSERT INTO cobis..ad_procedure       VALUES (7206, 'sp_datocab_operacion', 'cob_cartera', 'V', getdate(), 'datcabop.sp')
INSERT INTO cobis..cl_ttransaccion    VALUES (7204, 'CONSULTA DATOS DE CABECERA DEL PRESTAMO', 'CDCP', 'CONSULTA DATOS DE CABECERA DEL PRESTAMO')
INSERT INTO cobis..ad_pro_transaccion VALUES (7,'R', 0, 7204, 'V', getdate(), 7206, NULL )
INSERT INTO cobis..ad_tr_autorizada   VALUES (7,'R', 0, 7204, @w_rol, getdate(), 1, 'V', getdate())