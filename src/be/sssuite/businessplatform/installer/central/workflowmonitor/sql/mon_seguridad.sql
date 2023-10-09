use cobis
go

/* Registro de procedimientos almacenados y transacciones  */ 


/****************************************************/
/*                                                  */
/* REGISTRO DE PROCEDIMIENTOS                       */
/*                                                  */
/****************************************************/

delete from ad_procedure where pd_procedure between 73800 and 73804
go

insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73800, 'sp_activity_detail', 'cob_workflow', 'V', getdate (), 'wfm_activity_detail.sp')
go

insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73801, 'sp_process_detail', 'cob_workflow', 'V', getdate (), 'wfm_process_detail.sp')
go

insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73802, 'sp_resumen_wf', 'cob_workflow', 'V', getdate (), 'wf_resumen.sp')
go

insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73803, 'sp_activity_detail', 'cob_workflow', 'V', getdate (), 'wfm_activity_detail.sp')
go

insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73804, 'sp_process_detail', 'cob_workflow', 'V', getdate (), 'wfm_process_detail.sp')
go





/****************************************************/
/*                                                  */
/* REGISTRO DE TRANSACCIONES                        */
/*                                                  */
/****************************************************/
delete cl_ttransaccion
  where tn_trn_code between 73800 and 73804
go


insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73800, 'GetActivitySummary', 'GAS', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73801, 'GetSummaryByProcessId', 'GSP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73802, 'ObtenerResumen', 'ORS', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73803, 'QueryActivities', 'QAC', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73804, 'QueryProcessVersions', 'QPV', '')
go


/****************************************************/
/*                                                  */
/* REGISTRO DE PROCEDIMIENTO - TRANSACCION          */
/*                                                  */
/****************************************************/
delete ad_pro_transaccion
  where pt_producto = 73  and pt_transaccion between 73800 and 73804
go

print 'Creacion de procedimientos-transacciones'
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values ( 73, 'R', 0, 73800, 'V', getdate(), 73800)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73801, 'V', getdate(), 73801)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73802, 'V', getdate(), 73802)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73803, 'V', getdate(), 73803)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73804, 'V', getdate(), 73804)
go

