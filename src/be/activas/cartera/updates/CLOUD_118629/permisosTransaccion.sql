
use cobis
go

declare @w_rol int

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'SCHEDULER CTS' 
 
--INSERCCION DE LA TRANSACCION
--cartera 7

delete from cobis..cl_ttransaccion where tn_trn_code = 77511
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(77511, 'LCR - PROCESAR RESPUESTA DESEMBOLSO', 'LCRPRD', 'LCR - PROCESAR RESPUESTA DESEMBOLSO')

-- INSERCCION DEL SP


delete from cobis..ad_procedure where pd_procedure = 77511
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(77511, 'sp_lcr_resp_desembolso', 'cob_cartera', 'V', getdate(), 'lcr_rdes.sp')


-- asociacion transaccion con sp


delete from cobis..ad_pro_transaccion where pt_transaccion = 77511 and pt_procedure = 77511
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(7, 'R', 0, 77511, 'V', getdate(), 77511, NULL)


-- autorizacion de la transaccion

delete from cobis..ad_tr_autorizada where ta_transaccion = 77511
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(7, 'R', 0, 77511, @w_rol, getdate(), 1, 'V', getdate())