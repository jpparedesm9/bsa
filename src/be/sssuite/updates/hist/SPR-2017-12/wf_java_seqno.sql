--CL_SEQNOS_JAVA
delete from cobis..CL_SEQNOS_JAVA where BDATOS = 'cob_workflow'
go
insert into cobis..CL_SEQNOS_JAVA (BDATOS,TABLA,SIGUIENTE,PKEY) values ('cob_workflow', 'wf_dist_carga', 0,  'dc_cod_dist_car')
go
insert into cobis..CL_SEQNOS_JAVA (BDATOS,TABLA,SIGUIENTE,PKEY) values('cob_workflow','wf_resultado',0,'rs_codigo_resultado')
go
insert into cobis..CL_SEQNOS_JAVA (BDATOS,TABLA,SIGUIENTE,PKEY) values('cob_workflow','wf_tipo_documento',0,'td_codigo_tipo_doc')
go

update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(dc_cod_dist_car),0) from cob_workflow..wf_dist_carga) + 1 where TABLA = 'wf_dist_carga' and BDATOS = 'cob_workflow'

update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(rs_codigo_resultado),0) from cob_workflow..wf_resultado) + 1 where TABLA = 'wf_resultado' and BDATOS = 'cob_workflow'

update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(td_codigo_tipo_doc),0) from cob_workflow..wf_tipo_documento) + 1 where TABLA = 'wf_tipo_documento' and BDATOS = 'cob_workflow'
go