/*==============================================================*/
/* Database name:  cob_workflow                                 */
/* DBMS name:      Sybase AS Enterprise 12.0                    */
/* Created on:     24/11/2004 14:56:10                          */
/*==============================================================*/
use cob_workflow
go

print '===> Eliminando wf_actividad'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_actividad')
            and    type = 'U')
   drop table wf_actividad
go

print '===> Eliminando wf_actividad_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_actividad_proc')
            and    type = 'U')
   drop table wf_actividad_proc
go

print '===> Eliminando wf_asig_actividad'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_asig_actividad')
            and    type = 'U')
   drop table wf_asig_actividad
go

print '===> Eliminando wf_asig_man_mult'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_asig_man_mult')
            and    type = 'U')
   drop table wf_asig_man_mult
go

print '===> Eliminando wf_atri_rol_usu'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_atri_rol_usu')
            and    type = 'U')
   drop table wf_atri_rol_usu
go

print '===> Eliminando wf_atribucion'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_atribucion')
            and    type = 'U')
   drop table wf_atribucion
go

print '===> Eliminando wf_atributo'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_atributo')
            and    type = 'U')
   drop table wf_atributo
go

print '===> Eliminando wf_atributo_usuario'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_atributo_usuario')
            and    type = 'U')
   drop table wf_atributo_usuario
go

print '===> Eliminando wf_cola'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_cola')
            and    type = 'U')
   drop table wf_cola
go

print '===> Eliminando wf_cond_enlace_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_cond_enlace_proc')
            and    type = 'U')
   drop table wf_cond_enlace_proc
go

print '===> Eliminando wf_destinatario'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_destinatario')
            and    type = 'U')
   drop table wf_destinatario
go

print '===> Eliminando wf_dist_carga'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_dist_carga')
            and    type = 'U')
   drop table wf_dist_carga
go

print '===> Eliminando wf_empresa'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_empresa')
            and    type = 'U')
   drop table wf_empresa
go

print '===> Eliminando wf_enlace'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_enlace')
            and    type = 'U')
   drop table wf_enlace
go

print '===> Eliminando wf_enlace_roles'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_enlace_roles')
            and    type = 'U')
   drop table wf_enlace_roles
go

print '===> Eliminando wf_exc_inst_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_exc_inst_proc')
            and    type = 'U')
   drop table wf_exc_inst_proc
go

print '===> Eliminando wf_excepcion'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_excepcion')
            and    type = 'U')
   drop table wf_excepcion
go

print '===> Eliminando wf_excepcion_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_excepcion_proc')
            and    type = 'U')
   drop table wf_excepcion_proc
go

print '===> Eliminando wf_h_estado_actividad'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_h_estado_actividad')
            and    type = 'U')
   drop table wf_h_estado_actividad
go

print '===> Eliminando wf_h_estado_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_h_estado_proceso')
            and    type = 'U')
   drop table wf_h_estado_proceso
go

print '===> Eliminando wf_info_paso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_info_paso')
            and    type = 'U')
   drop table wf_info_paso
go

print '===> Eliminando wf_info_programa'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_info_programa')
            and    type = 'U')
   drop table wf_info_programa
go

print '===> Eliminando wf_ins_inst_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_ins_inst_proc')
            and    type = 'U')
   drop table wf_ins_inst_proc
go

print '===> Eliminando wf_inst_actividad'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_inst_actividad')
            and    type = 'U')
   drop table wf_inst_actividad
go

print '===> Eliminando wf_bloqueo_inst_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_bloqueo_inst_proceso')
            and    type = 'U')
   drop table wf_bloqueo_inst_proceso
go

print '===> Eliminando wf_inst_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_inst_proceso')
            and    type = 'U')
   drop table wf_inst_proceso
go

print '===> Eliminando wf_instruccion'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_instruccion')
            and    type = 'U')
   drop table wf_instruccion
go

print '===> Eliminando wf_instruccion_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_instruccion_proc')
            and    type = 'U')
   drop table wf_instruccion_proc
go

print '===> Eliminando wf_jerarquia'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_jerarquia')
            and    type = 'U')
   drop table wf_jerarquia
go

print '===> Eliminando wf_mapeo_condicion'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_mapeo_condicion')
            and    type = 'U')
   drop table wf_mapeo_condicion
go

print '===> Eliminando wf_mapeo_id'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_mapeo_id')
            and    type = 'U')
   drop table wf_mapeo_id
go

print '===> Eliminando wf_mapeo_var_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_mapeo_var_proc')
            and    type = 'U')
   drop table wf_mapeo_var_proc
go

print '===> Eliminando wf_medio_receptor'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_medio_receptor')
            and    type = 'U')
   drop table wf_medio_receptor
go

print '===> Eliminando wf_mensaje'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_mensaje')
            and    type = 'U')
   drop table wf_mensaje
go

print '===> Eliminando wf_mod_variable'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_mod_variable')
            and    type = 'U')
   drop table wf_mod_variable
go

print '===> Eliminando wf_ob_lineas'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_ob_lineas')
            and    type = 'U')
   drop table wf_ob_lineas
go

print '===> Eliminando wf_observacion'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_observacion')
            and    type = 'U')
   drop table wf_observacion
go

print '===> Eliminando wf_observaciones'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_observaciones')
            and    type = 'U')
   drop table wf_observaciones
go

print '===> Eliminando wf_par_var_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_par_var_proceso')
            and    type = 'U')
   drop table wf_par_var_proceso
go

print '===> Eliminando wf_parametro_programa'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_parametro_programa')
            and    type = 'U')
   drop table wf_parametro_programa
go

print '===> Eliminando wf_politica'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_politica')
            and    type = 'U')
   drop table wf_politica
go

print '===> Eliminando wf_variable_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_variable_proceso')
            and    type = 'U')
   drop table wf_variable_proceso
go

print '===> Eliminando wf_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_proceso')
            and    type = 'U')
   drop table wf_proceso
go

print '===> Eliminando wf_r_actividades_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_r_actividades_proc')
            and    type = 'U')
   drop table wf_r_actividades_proc
go

print '===> Eliminando wf_r_asignacion_act'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_r_asignacion_act')
            and    type = 'U')
   drop table wf_r_asignacion_act
go

print '===> Eliminando wf_r_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_r_proceso')
            and    type = 'U')
   drop table wf_r_proceso
go

print '===> Eliminando wf_receptor'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_receptor')
            and    type = 'U')
   drop table wf_receptor
go

print '===> Eliminando wf_requisito_actividad'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_requisito_actividad')
            and    type = 'U')
   drop table wf_requisito_actividad
go

print '===> Eliminando wf_res_atr_usu_rol'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_res_atr_usu_rol')
            and    type = 'U')
   drop table wf_res_atr_usu_rol
go

print '===> Eliminando wf_resultado'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_resultado')
            and    type = 'U')
   drop table wf_resultado
go

print '===> Eliminando wf_resultado_actividad'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_resultado_actividad')
            and    type = 'U')
   drop table wf_resultado_actividad
go

print '===> Eliminando wf_rol'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_rol')
            and    type = 'U')
   drop table wf_rol
go

print '===> Eliminando wf_rol_jerarquia'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_rol_jerarquia')
            and    type = 'U')
   drop table wf_rol_jerarquia
go

print '===> Eliminando wf_tipo_documento'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_tipo_documento')
            and    type = 'U')
   drop table wf_tipo_documento
go

print '===> Eliminando wf_tipo_req_act'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_tipo_req_act')
            and    type = 'U')
   drop table wf_tipo_req_act
go

print '===> Eliminando wf_tmp_aprobacion'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_tmp_aprobacion')
            and    type = 'U')
   drop table wf_tmp_aprobacion
go

print '===> Eliminando wf_tmp_lineas'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_tmp_lineas')
            and    type = 'U')
   drop table wf_tmp_lineas
go

print '===> Eliminando wf_usuario_rol'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_usuario_rol')
            and    type = 'U')
   drop table wf_usuario_rol
go

print '===> Eliminando wf_variable_actual'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_variable_actual')
            and    type = 'U')
   drop table wf_variable_actual
go

print '===> Eliminando wf_version_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_version_proceso')
            and    type = 'U')
   drop table wf_version_proceso
go

print '===> Eliminando wf_voto_comite'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_voto_comite')
            and    type = 'U')
   drop table wf_voto_comite
go

print '===> Eliminando wf_documento'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_documento')
            and    type = 'U')
   drop table wf_documento
go

print '===> Eliminando wf_documento_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_documento_proc')
            and    type = 'U')
   drop table wf_documento_proc
go

print '===> Eliminando wf_doc_inst_proc'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_doc_inst_proc')
            and    type = 'U')
   drop table wf_doc_inst_proc
go

print '===> Eliminando wf_inst_proceso_his'
if exists (select 1 
            from  sysobjects 
			where id = object_id('wf_inst_proceso_his')
			and    type = 'U')
   drop table wf_inst_proceso_his
go

print '===> Eliminando wf_inst_actividad_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_inst_actividad_his')
			  and type = 'U')
   drop table wf_inst_actividad_his
go

print '===> Eliminando wf_asig_man_mult_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_asig_man_mult_his')
			  and type = 'U')
   drop table wf_asig_man_mult_his
go

print '===> Eliminando wf_exc_inst_proc_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_exc_inst_proc_his')
			  and type = 'U')
   drop table wf_exc_inst_proc_his
go

print '===> Eliminando wf_ins_inst_proc_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_ins_inst_proc_his')
			  and type = 'U')
   drop table wf_ins_inst_proc_his
go

print '===> Eliminando wf_mod_variable_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_mod_variable_his')
			  and type = 'U')
   drop table wf_mod_variable_his
go

print '===> Eliminando wf_wf_asig_man_mult_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_wf_asig_man_mult_his')
			  and type = 'U')
   drop table wf_wf_asig_man_mult_his
go

print '===> Eliminando wf_variable_actual_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_variable_actual_his')
		      and type = 'U')
   drop table wf_variable_actual_his
go

print '===> Eliminando wf_observaciones_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_observaciones_his')
			  and type = 'U')
   drop table wf_observaciones_his
go

print '===> Eliminando wf_ob_lineas_his'
if exists (select 1 
             from sysobjects 
		    where id = object_id('wf_ob_lineas_his')
			  and type = 'U')
   drop table wf_ob_lineas_his
go

print '===> Eliminando wf_r_actividades_proc_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_r_actividades_proc_his')
			  and type = 'U')
   drop table wf_r_actividades_proc_his
go

print '===> Eliminando wf_r_asignacion_act_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_r_asignacion_act_his')
			  and type = 'U')
   drop table wf_r_asignacion_act_his
go

print '===> Eliminando wf_r_proceso_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_r_proceso_his')
			  and type = 'U')
   drop table wf_r_proceso_his
go

print '===> Eliminando wf_nivel_aprobacion'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_nivel_aprobacion')
			  and type = 'U')
   drop table wf_nivel_aprobacion
go

print '===> Eliminando wf_notificaciones_despacho'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_notificaciones_despacho')
		      and type = 'U')
   drop table wf_notificaciones_despacho
go

print '===> Eliminando wf_cliente_proceso'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_cliente_proceso')
			  and type = 'U')
   drop table wf_cliente_proceso
go

print '===> Eliminando wf_cliente_proceso_his'
if exists (select 1 
             from sysobjects 
			where id = object_id('wf_cliente_proceso_his')
		      and type = 'U')
   drop table wf_cliente_proceso_his
go

print '===> Eliminando wf_notification_templates'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_notification_templates')
            and    type = 'U')
   drop table wf_notification_templates
go

print '===> Eliminando wf_resumen_actividad'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_resumen_actividad')
            and    type = 'U')
   drop table wf_resumen_actividad
go

print '===> Eliminando wf_requisito_actividad_tmp'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_requisito_actividad_tmp')
            and    type = 'U')
   drop table wf_requisito_actividad_tmp
go

print '===> Eliminando wf_observacion_actividad'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_observacion_actividad')
            and    type = 'U')
   drop table wf_observacion_actividad
go

print '===> Eliminando wf_observaciones_temp'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_observaciones_temp')
            and    type = 'U')
   drop table wf_observaciones_temp
go

print '===> Eliminando wf_ob_lineas_temp'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_ob_lineas_temp')
            and    type = 'U')
   drop table wf_ob_lineas_temp
go

print '===> Eliminando wf_tipo_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_tipo_proceso')
            and    type = 'U')
   drop table wf_tipo_proceso
go

print '===> Eliminando wf_producto_tipo_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_producto_tipo_proceso')
            and    type = 'U')
   drop table wf_producto_tipo_proceso
go

print '===> Eliminando wf_req_inst'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_req_inst')
            and    type = 'U')
   drop table wf_req_inst
go

print '===> Eliminando wf_req_documento_temp'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_req_documento_temp')
            and    type = 'U')
   drop table wf_req_documento_temp
go

print '===> Eliminando wf_tipo_rol'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_tipo_rol')
            and    type = 'U')
   drop table wf_tipo_rol
go

print '===> Eliminando wf_receptor_cliente'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_receptor_cliente')
            and    type = 'U')
   drop table wf_receptor_cliente
go


print '===> Eliminando wf_item_jerarquia'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_item_jerarquia')
            and    type = 'U')
   drop table wf_item_jerarquia
go

print '===> Eliminando wf_paso_pol'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_paso_pol')
            and    type = 'U')
   drop table wf_paso_pol
go

print '===> Eliminando wf_paso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_paso')
            and    type = 'U')
   drop table wf_paso
go

print '===> Eliminando wf_item_tmp'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_item_tmp')
            and    type = 'U')
   drop table wf_item_tmp
go

print '===> Eliminando wf_usuario_jerarquia_tpl'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_usuario_jerarquia_tpl')
            and    type = 'U')
   drop table wf_usuario_jerarquia_tpl
go

print '===> Eliminando wf_item_jerarquia_tpl'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_item_jerarquia_tpl')
            and    type = 'U')
   drop table wf_item_jerarquia_tpl
go

print '===> Eliminando wf_nivel_jerarquia_tpl'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_nivel_jerarquia_tpl')
            and    type = 'U')
   drop table wf_nivel_jerarquia_tpl
go

print '===> Eliminando wf_tipo_jerarquia_tpl'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_tipo_jerarquia_tpl')
            and    type = 'U')
   drop table wf_tipo_jerarquia_tpl
go

print '===> Eliminando wf_usuario'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_usuario')
            and    type = 'U')
   drop table wf_usuario
go

print '===> Eliminando wf_variable'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_variable')
            and    type = 'U')
   drop table wf_variable
go

print '===> Eliminando wf_errores_proceso'
if exists (select 1
            from  sysobjects
            where  id = object_id('wf_errores_proceso')
            and    type = 'U')
   drop table wf_errores_proceso
go

print '===> Eliminando wf_detalle_desviacion_ind'
if Object_id('wf_detalle_desviacion_ind') != null
  drop table wf_detalle_desviacion_ind
go

print '===> Eliminando wf_usuario_email'
if Object_id('wf_usuario_email') != null
  drop table wf_usuario_email
go

print '===> Eliminando carga'
if Object_id('carga') != null
  drop table carga
go
