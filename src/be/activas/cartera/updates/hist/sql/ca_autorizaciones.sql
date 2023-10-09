USE cobis
GO 

declare @w_rol integer

select @w_rol = ro_rol 
from ad_rol
where ro_descripcion='MENU POR PROCESOS'

delete cobis..ad_procedure       where pd_procedure   = 7202
delete cobis..cl_ttransaccion    where tn_trn_code    = 7202
delete cobis..ad_pro_transaccion where pt_transaccion = 7202 and pt_procedure = 7202
delete cobis..ad_tr_autorizada   where ta_transaccion = 7202 and ta_rol = @w_rol

INSERT INTO cobis..ad_procedure       VALUES (7202, 'sp_datocab_operacion', 'cob_cartera', 'V', getdate(), 'datcabop.sp')
INSERT INTO cobis..cl_ttransaccion    VALUES (7202, 'CONSULTA DATOS DE CABECERA DEL PRESTAMO', 'CDCP', 'CONSULTA DATOS DE CABECERA DEL PRESTAMO')
INSERT INTO cobis..ad_pro_transaccion VALUES (7,'R', 0, 7202, 'V', getdate(), 7202, NULL )
INSERT INTO cobis..ad_tr_autorizada   VALUES (7,'R', 0, 7202, @w_rol, getdate(), 1, 'V', getdate())


delete cobis..ad_procedure       where pd_procedure   = 7204
delete cobis..cl_ttransaccion    where tn_trn_code    = 7203
delete cobis..ad_pro_transaccion where pt_transaccion = 7203 and pt_procedure = 7204
delete cobis..ad_tr_autorizada   where ta_transaccion = 7203 and ta_rol = @w_rol


insert into cobis..cl_ttransaccion values (7203, 'TABLA DE AMORTIZACION','7203','TABLA DE AMORTIZACION')
insert into cobis..ad_procedure values (7204,'sp_qr_table_amortiza_web','cob_cartera','V', getdate(), 'qr_amortiza') 
insert into cobis..ad_tr_autorizada values (7,'R', 0,7203,@w_rol,getdate(), 3,'V', getdate()) 
insert into cobis..ad_pro_transaccion values (7,'R', 0,7203,'V', getdate(), 7204,null) 

go
