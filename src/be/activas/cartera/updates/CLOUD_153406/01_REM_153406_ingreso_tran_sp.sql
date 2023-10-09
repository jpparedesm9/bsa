-- Remediacion

declare 
@w_tn_trn_code        int,
@w_pd_producto        int,
@w_ro_rol             int,
@w_ta_autorizante     int,
@w_pd_procedure       int

select @w_tn_trn_code = 775073 -- Se inicializa el codigo de la transacción
select @w_pd_procedure  = 775073
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' and pd_abreviatura = 'CCA' -- Obtiene el codigo del producto de cartera

select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol de operaciones
select @w_ta_autorizante = ro_rol from cobis..ad_rol where ro_descripcion = 'SCHEDULER CTS' -- Obtiene el codigo del rol autorizante

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion = 'TANQUEO CORRESPONSAL PAGO GARANTIA' 
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'TANQUEO CORRESPONSAL PAGO GARANTIA', @w_tn_trn_code, 'TANQUEO CORRESPONSAL PAGO GARANTIA')

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_pagos_corresponsl_gl_batch' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_pagos_corresponsl_gl_batch', 'cob_cartera', 'V', getdate(), 'sp_pgclglbh.sp')

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

-- AUTORIZACION DE LA TRANSACCION EN EL ROL 20 CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_ro_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, getdate(), @w_ta_autorizante, 'V', getdate())

GO

