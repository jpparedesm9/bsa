/*	
**	Script de inicializacion de las instancias de proceso y actualizacion de sewnos
*/
delete from cob_workflow..wf_asig_actividad

delete from cob_workflow..wf_exc_inst_proc

delete from cob_workflow..wf_h_estado_actividad

delete from cob_workflow..wf_h_estado_proceso

delete from cob_workflow..wf_ins_inst_proc

delete from cob_workflow..wf_inst_actividad

delete from cob_workflow..wf_inst_proceso

delete from cob_workflow..wf_doc_inst_proc

delete from cob_workflow..wf_mod_variable

delete from cob_workflow..wf_ob_lineas

delete from cob_workflow..wf_mensaje

delete from cob_workflow..wf_ob_lineas_temp

delete from cob_workflow..wf_observaciones

delete from cob_workflow..wf_observaciones_temp

delete from cob_workflow..wf_r_actividades_proc

delete from cob_workflow..wf_r_actividades_proc_his

delete from cob_workflow..wf_r_asignacion_act

delete from cob_workflow..wf_r_asignacion_act_his

delete from cob_workflow..wf_r_proceso

delete from cob_workflow..wf_r_proceso_his

delete from cob_workflow..wf_req_inst

delete from cob_workflow..wf_requisito_actividad

delete from cob_workflow..wf_requisito_actividad_tmp

delete from cob_workflow..wf_variable_actual


truncate table cob_pac..bpl_rule_process_his
truncate table cob_pac..bpl_variable_process
truncate table cob_pac..bpl_rule_process


go

update cobis..cl_seqnos set siguiente = (select isnull(max(ac_codigo_actividad),0) from cob_workflow..wf_actividad) + 1where tabla = 'wf_actividad' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(aa_id_asig_act),0) from cob_workflow..wf_asig_actividad) + 1where tabla = 'wf_asig_actividad' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(an_id_atribucion),0) from cob_workflow..wf_atribucion) + 1where tabla = 'wf_atribucion' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ao_codigo_atributo),0) from cob_workflow..wf_atributo) + 1where tabla = 'wf_atributo' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(co_id_cola),0) from cob_workflow..wf_cola) + 1where tabla = 'wf_cola' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(dc_cod_dist_car),0) from cob_workflow..wf_dist_carga) + 1where tabla = 'wf_dist_carga' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(dm_codigo_doc),0) from cob_workflow..wf_documento) + 1where tabla = 'wf_documento' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(en_id_enlace),0) from cob_workflow..wf_enlace) + 1where tabla = 'wf_enlace' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ej_enlace_rol),0) from cob_workflow..wf_enlace_roles) + 1where tabla = 'wf_enlace_roles' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ei_id_exc_inst_proc),0) from cob_workflow..wf_exc_inst_proc) + 1where tabla = 'wf_exc_inst_proc' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ex_codigo_excepcion),0) from cob_workflow..wf_excepcion) + 1where tabla = 'wf_excepcion' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ea_id_h_estado),0) from cob_workflow..wf_h_estado_actividad) + 1where tabla = 'wf_h_estado_actividad' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ep_id_h_estado),0) from cob_workflow..wf_h_estado_proceso) + 1where tabla = 'wf_h_estado_proceso' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ip_id_programa),0) from cob_workflow..wf_info_programa) + 1where tabla = 'wf_info_programa' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ii_id_ins_inst_proc),0) from cob_workflow..wf_ins_inst_proc) + 1where tabla = 'wf_ins_inst_proc' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ia_id_inst_act),0) from cob_workflow..wf_inst_actividad) + 1where tabla = 'wf_inst_actividad' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(io_id_inst_proc),0) from cob_workflow..wf_inst_proceso) + 1where tabla = 'wf_inst_proceso' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(in_codigo_instruccion),0) from cob_workflow..wf_instruccion) + 1where tabla = 'wf_instruccion' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(je_id_jerarquia),0) from cob_workflow..wf_jerarquia) + 1where tabla = 'wf_jerarquia' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(me_id_mensaje),0) from cob_workflow..wf_mensaje) + 1where tabla = 'wf_mensaje' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(pa_id_paso),0) from cob_workflow..wf_paso) + 1where tabla = 'wf_paso' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(po_id_politica),0) from cob_workflow..wf_politica) + 1where tabla = 'wf_politica' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(pr_codigo_proceso),0) from cob_workflow..wf_proceso) + 1where tabla = 'wf_proceso' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(rs_codigo_resultado),0) from cob_workflow..wf_resultado) + 1where tabla = 'wf_resultado' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(ro_id_rol),0) from cob_workflow..wf_rol) + 1where tabla = 'wf_rol' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(td_codigo_tipo_doc),0) from cob_workflow..wf_tipo_documento) + 1where tabla = 'wf_tipo_documento' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(us_id_usuario),0) from cob_workflow..wf_usuario) + 1where tabla = 'wf_usuario' and bdatos = 'cob_workflow'

update cobis..cl_seqnos set siguiente = (select isnull(max(vb_codigo_variable),0) from cob_workflow..wf_variable) + 1where tabla = 'wf_variable' and bdatos = 'cob_workflow'

go

update cob_workflow..wf_cseqnos_proceso
set sp_siguiente = 0
go
