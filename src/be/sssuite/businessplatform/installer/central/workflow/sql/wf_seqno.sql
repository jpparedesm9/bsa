/*********************************************************/
/* Script de generacion de secuenciales de cob_workflow. */
/*********************************************************/

set nocount on
go

use cobis
go

-- Borrar si existen.
delete from cl_seqnos
  where bdatos = 'cob_workflow'
   and tabla not in('wf_rule_process')
go

insert into cl_seqnos values ('cob_workflow', 'wf_inst_proceso', 0, 'io_id_inst_proc')
go
insert into cl_seqnos values ('cob_workflow', 'wf_inst_actividad', 0, 'ia_id_inst_act')
go
insert into cl_seqnos values ('cob_workflow', 'wf_asig_actividad', 0, 'aa_id_asig_act')
go
insert into cl_seqnos values ('cob_workflow', 'wf_proceso', 0, 'pr_codigo_proceso')
go
insert into cl_seqnos values ('cob_workflow', 'wf_paso', 0, 'pa_id_paso')
go
insert into cl_seqnos values ('cob_workflow', 'wf_actividad', 4, 'ac_codigo_actividad') --Cambio solicitado por Franklin Escudero
go
insert into cl_seqnos values ('cob_workflow', 'wf_enlace', 0, 'en_id_enlace')
go
insert into cl_seqnos values ('cob_workflow', 'wf_instruccion', 5, 'in_codigo_instruccion')
go
insert into cl_seqnos values ('cob_workflow', 'wf_excepcion', 0, 'ex_codigo_excepcion')
go
insert into cl_seqnos values ('cob_workflow', 'wf_variable', 0, 'vb_codigo_variable')
go
insert into cl_seqnos values ('cob_workflow', 'wf_resultado', 3, 'rs_codigo_resultado')
go
insert into cl_seqnos values ('cob_workflow', 'wf_atribucion', 2, 'an_id_atribucion')
go
insert into cl_seqnos values ('cob_workflow', 'wf_info_programa', 0, 'ip_id_programa')
go
insert into cl_seqnos values ('cob_workflow', 'wf_usuario', 0, 'us_id_usuario')
go
insert into cl_seqnos values ('cob_workflow', 'wf_rol', 0, 'ro_id_rol')
go
insert into cl_seqnos values ('cob_workflow', 'wf_tipo_documento', 0, 'td_codigo_tipo_doc')
go
insert into cl_seqnos values ('cob_workflow', 'wf_mensaje', 0, 'me_id_mensaje')
go
insert into cl_seqnos values ('cob_workflow', 'wf_cola', 0, 'co_id_cola')
go
insert into cl_seqnos values ('cob_workflow', 'wf_atributo', 0, 'ao_codigo_atributo')
go
insert into cl_seqnos values ('cob_workflow', 'wf_dist_carga', 0, 'dc_cod_dist_car')
go
insert into cl_seqnos values ('cob_workflow', 'wf_h_estado_proceso', 0, 'ep_id_h_estado')
go
insert into cl_seqnos values ('cob_workflow', 'wf_h_estado_actividad', 0, 'ea_id_h_estado')
go
insert into cl_seqnos values ('cob_workflow', 'wf_jerarquia', 0, 'je_id_jerarquia')
go
insert into cl_seqnos values ('cob_workflow', 'wf_enlace_roles', 0, 'ej_enlace_rol')
go
insert into cl_seqnos values ('cob_workflow', 'wf_politica', 0, 'po_id_politica')
go
insert into cl_seqnos values ('cob_workflow', 'wf_exc_inst_proc', 0, 'ei_id_exc_inst_proc')
go
insert into cl_seqnos values ('cob_workflow', 'wf_ins_inst_proc', 0, 'ii_id_ins_inst_proc')
go
insert into cl_seqnos values ('cob_workflow', 'wf_documento', 0, 'dm_codigo_doc')
go
insert into cl_seqnos values ('cob_workflow','wf_scheduler_task',0, 'st_id_scheduler_task') 
go
insert into cobis..cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_workflow', 'wf_tipo_jerarquia_tpl', 0,  'tj_id_jerarquia')
go
insert into cobis..cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_workflow', 'wf_nivel_jerarquia_tpl', 0,  'ni_id_nivel_jerarquia')
go
insert into cobis..cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_workflow', 'wf_item_jerarquia_tpl', 0,  'ij_id_item_jerarquia')
go
insert into cobis..cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_workflow', 'wf_usuario_jerarquia_tpl', 0,  'uj_id_usuario_jerarquia')
go
insert into cobis..cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_workflow', 'wf_item_jerarquia', 0,  'ij_id_item')
go
insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_workflow','wf_observacion',1,'codigo')
go

--CL_SEQNOS_JAVA
delete from CL_SEQNOS_JAVA where BDATOS = 'cob_workflow'
go
insert into cobis..CL_SEQNOS_JAVA (BDATOS,TABLA,SIGUIENTE,PKEY) values ('cob_workflow', 'wf_dist_carga', 0,  'dc_cod_dist_car')
go
insert into cobis..CL_SEQNOS_JAVA (BDATOS,TABLA,SIGUIENTE,PKEY) values('cob_workflow','wf_resultado',0,'rs_codigo_resultado')
go
insert into cobis..CL_SEQNOS_JAVA (BDATOS,TABLA,SIGUIENTE,PKEY) values('cob_workflow','wf_tipo_documento',0,'td_codigo_tipo_doc')
go
