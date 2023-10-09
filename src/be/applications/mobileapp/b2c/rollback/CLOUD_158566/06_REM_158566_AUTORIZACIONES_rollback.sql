-- Rollback

declare 
@w_tn_trn_code        int,
@w_pd_producto        int,
@w_ro_rol             int,
@w_ta_autorizante     int,
@w_pd_procedure       int

select @w_tn_trn_code = 775074 -- Se inicializa el codigo de la transacción
select @w_pd_procedure  = 775074
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'BANCA VIRTUAL' and pd_abreviatura = 'BVI' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol autorizante

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'ENVIO NOTIFICACION SMS ENROLAMIENTO' 
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_notifb2c_sms' 

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol

GO

