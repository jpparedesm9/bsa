/*
** SCRIPT : REGISTRA LAS TRANSACCIONES UTILIZADAS POR LA VISTA CONSOLIDADA DE CLIENTES
**
** RANGOS UTILIZADOS
** 73500 - 73518
**
*/

use cobis
go
/***********************************************************/
/*                                                         */
/* REGISTRO DE PROCEDIMIENTOS                              */
/*                                                         */
/***********************************************************/
delete ad_procedure 
 where pd_procedure between 73500 and 73518
go
DELETE ad_procedure WHERE pd_procedure=73500
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73500, 'sp_ui_human_task_info', 'cob_pac', 'V', getdate (), 'proceso.sp')
go


DELETE ad_procedure WHERE pd_procedure=73501
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73501, 'sp_actualiza_var_wf', 'cob_workflow', 'V', getdate (), 'actualiza.sp')
go
DELETE ad_procedure WHERE pd_procedure=73502
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73502, 'sp_claim_task_wf', 'cob_workflow', 'V', getdate (), 'wf_claim.sp')

DELETE ad_procedure WHERE pd_procedure=73503
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73503, 'sp_cons_act_proceso_wf', 'cob_workflow', 'V', getdate (), 'wf_cons_act.sp')
go
DELETE ad_procedure WHERE pd_procedure=73504
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73504, 'sp_cons_act_sup_wf', 'cob_workflow', 'V', getdate (), 'wf_cons_act.sp')
go
DELETE ad_procedure WHERE pd_procedure=73505
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73505, 'sp_cons_act_usr_wf', 'cob_workflow', 'V', getdate (), 'wf_cons.sp')
go
DELETE ad_procedure WHERE pd_procedure=73506
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73506, 'sp_cons_proceso_wf', 'cob_workflow', 'V', getdate (), 'wf_proceso.sp')
go
DELETE ad_procedure WHERE pd_procedure=73507
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73507, 'sp_cons_usr_reasig_wf', 'cob_workflow', 'V', getdate (), 'consreasig.sp')
go
DELETE ad_procedure WHERE pd_procedure=73508
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73508, 'sp_cons_usuario_wf', 'cob_workflow', 'V', getdate (), 'cons_usu.sp')
go
DELETE ad_procedure WHERE pd_procedure=73509
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73509, 'sp_cons_var_wf', 'cob_workflow', 'V', getdate (), 'wf_cons_var.sp')
go
DELETE ad_procedure WHERE pd_procedure=73510
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73510, 'sp_grafico_wf', 'cob_workflow', 'V', getdate (), 'wf_grafico.sp')
go
DELETE ad_procedure WHERE pd_procedure=73511
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73511, 'sp_info_proceso_wf', 'cob_workflow', 'V', getdate (), 'wf_proceso.sp')
go
DELETE ad_procedure WHERE pd_procedure=73512
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73512, 'sp_inicia_proceso_wf', 'cob_workflow', 'V', getdate (), 'wfproceso.sp')
go
DELETE ad_procedure WHERE pd_procedure=73513
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73513, 'sp_m_inst_proceso_wf', 'cob_workflow', 'V', getdate (), 'proceso.sp')
go
DELETE ad_procedure WHERE pd_procedure=73514
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73514, 'sp_observacion_asig_wf', 'cob_workflow', 'V', getdate (), 'observacion.sp')
go
DELETE ad_procedure WHERE pd_procedure=73515
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73515, 'sp_reasigna_actividad_wf', 'cob_workflow', 'V', getdate (), 'wf_rea_act.sp')
go
DELETE ad_procedure WHERE pd_procedure=73516
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73516, 'sp_res_usu_req_wf', 'cob_workflow', 'V', getdate (), 'wf_res.sp')
go
DELETE ad_procedure WHERE pd_procedure=73517
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73517, 'sp_resp_actividad_wf', 'cob_workflow', 'V', getdate (), 'resp_act.sp')
go
DELETE ad_procedure WHERE pd_procedure=73518
insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73518, 'sp_m_rule_dependence', 'cob_pac', 'V', getdate (), 'rule_depesp')
go

/****************************************************/
/*                                                  */
/* REGISTRO DE TRANSACCIONES                        */
/*                                                  */
/****************************************************/
delete cl_ttransaccion
  where tn_trn_code between 73500 and 73544
go

print 'Creacion de transacciones'
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73500, 'GetProcessUser', 'GPU', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73501, 'UpdateVariable', 'UV', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73503, 'CancelTask', 'CT', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73504, 'ClaimTask', 'ClT', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73505, 'CompleteTask', 'CoT', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73506, 'CreateProcessInstance', 'CPI', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73507, 'GetCurrentTask', 'GCT', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73508, 'GetHumanTasksByProcess', 'GHT', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73509, 'GetProcessesList', 'GPL', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73510, 'GetReassignUsers', 'GRU', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73511, 'GetSupervisorActivityList', 'GSL', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73512, 'GetSupervisorActivityStatusList', 'GSS', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73513, 'GetSupervisorProcessList', 'GSP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73514, 'GetSupervisorTaskList', 'GSP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73515, 'GetTaskList', 'GTL', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73516, 'ReassignTask', 'RT', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73517, 'ResumeTask', 'ReT', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73518, 'SuspendTask', 'ST', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73519, 'DeleteProcessDataConfigurationByTask', 'DPD', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73520, 'GetAllModuleQueryCatalog', 'GAM', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73521, 'GetModuleQueryCatalogByIndex', 'GMQ', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) -- TODO: FIX
  values (73522, 'GetAllProductQueryCatalog', 'GAP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73523, 'GetProductQueryCatalogByIndex', 'GPQ', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73524, 'GetBPMIdentifier', 'GBI', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73525, 'GetInboxProcessConfigurationByProduct', 'GIP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73526, 'GetPages', 'GP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73527, 'GetProcessDataConfigurationByTask', 'GPD', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73528, 'GetProcessNameByProductAndPage', 'GPP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73529, 'GetTaskFlow', 'GTF', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73530, 'GetUIHumanTaskInfo', 'GUI', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73531, 'InsertInboxProcessConfigurationByProduct', 'IIP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73532, 'InsertProcessDataConfigurationByTask', 'IPD', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73533, 'InsertUIHumanTaskInfo', 'IUI', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73534, 'UpdateInboxProcessConfigurationByProduct', 'UIP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73535, 'UpdateProcessDataConfigurationByTask', 'UPD', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73536, 'UpdateUIHumanTaskInfo', 'UUI', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73537, 'GetComments', 'GC', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73538, 'GetInstancesList', 'GIL', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73539, 'GetLines', 'GL', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73540, 'GetRecords', 'GR', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73541, 'InsertComments', 'IC', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73542, 'InsertDependence', 'IC', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73543, 'DeleteDependence', 'DD', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73544, 'SearchDependence', 'SD', '')
go

/****************************************************/
/*                                                  */
/* REGISTRO DE PROCEDIMIENTO - TRANSACCION          */
/*                                                  */
/****************************************************/
delete ad_pro_transaccion
  where pt_producto = 73  and pt_transaccion between 73500 and 73544
go

print 'Creacion de procedimientos-transacciones'
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73501, 'V', getdate(), 73508)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73502, 'V', getdate(), 73501)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73503, 'V', getdate(), 73513)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73504, 'V', getdate(), 73502)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73505, 'V', getdate(), 73517)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73506, 'V', getdate(), 73512)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73507, 'V', getdate(), 73503)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73508, 'V', getdate(), 73503)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73509, 'V', getdate(), 73506)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73510, 'V', getdate(), 73507)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73511, 'V', getdate(), 73504)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73512, 'V', getdate(), 73504)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73513, 'V', getdate(), 73504)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73514, 'V', getdate(), 73504)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73515, 'V', getdate(), 73505)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73516, 'V', getdate(), 73515)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73517, 'V', getdate(), 73513)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73518, 'V', getdate(), 73513)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73519, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73520, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73521, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73522, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73523, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73524, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73525, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73526, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73527, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73528, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73529, 'V', getdate(), 73510)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73530, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73531, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73532, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73533, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73534, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73535, 'V', getdate(), 73500)
go
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73536, 'V', getdate(), 73500)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73537, 'V', getdate(), 73514)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73538, 'V', getdate(), 73516)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73539, 'V', getdate(), 73514)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73540, 'V', getdate(), 73511)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73541, 'V', getdate(), 73514)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73542, 'V', getdate(), 73518)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73543, 'V', getdate(), 73518)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73544, 'V', getdate(), 73518)
go
























































