-- Remediacion

declare 
@w_tn_trn_code        int,
@w_pd_producto        int,
@w_ro_rol             int,
@w_ta_autorizante     int,
@w_pd_procedure       int

select @w_tn_trn_code = 7070005 -- Se inicializa el codigo de la transacción
select @w_pd_procedure  = 7070005
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol autorizante

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'APLICACION DESEMBOLSOS LCR' 


-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_ejecuta_desembolso_lcr' 


-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure


-- AUTORIZACION DE LA TRANSACCION EN EL ROL 20 CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol

GO
