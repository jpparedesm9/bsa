use cobis 
go

delete from cobis..ad_procedure where pd_procedure = 31900
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (31900, 'sp_notification_templates', 'cob_workflow', 'V', getdate (), 'notification_templates.sp')
go


/****************************************************/
/*                                                  */
/* REGISTRO DE TRANSACCIONES                        */
/*                                                  */
/****************************************************/

delete from cobis..cl_ttransaccion where tn_trn_code = 31900
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (31900, 'GetNotificationTemplates', 'GNT', '')
go


/****************************************************/
/*                                                  */
/* REGISTRO DE PROCEDIMIENTO - TRANSACCION          */
/*                                                  */
/****************************************************/

delete from cobis..ad_pro_transaccion where pt_transaccion = 31900
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 31900, 'V', getdate(), 31900)
go


/****************************************************/
/*                                                  */
/* TRANSACCIONES AUTORIZADAS				         */
/*                                                  */
/****************************************************/

delete from cobis..ad_tr_autorizada where ta_transaccion = 31900
insert into ad_tr_autorizada 
  select 73, 'R', 0, tn_trn_code, 116, getdate(), 1, 'V', getdate()
  from cobis..cl_ttransaccion
  where tn_trn_code = 31900

go

