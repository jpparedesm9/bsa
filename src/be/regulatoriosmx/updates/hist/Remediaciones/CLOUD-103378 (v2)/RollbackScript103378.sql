use cob_workflow 
go


truncate table cob_workflow..wf_r_actividades_proc

insert into cob_workflow..wf_r_actividades_proc
select *
from borrar_wf_r_actividades_proc_103378

select count(1) from cob_workflow..wf_r_actividades_proc
select count(1) from borrar_wf_r_actividades_proc_103378


truncate table cob_workflow..wf_r_asignacion_act

insert into cob_workflow..wf_r_asignacion_act
select *
from borrar_wf_r_asignacion_act_103378

select count(1) from cob_workflow..wf_r_asignacion_act
select count(1) from borrar_wf_r_asignacion_act_103378

truncate table cob_workflow..wf_r_proceso

insert into cob_workflow..wf_r_proceso
select *
from borrar_wf_r_proceso_103378

select count(1) from cob_workflow..wf_r_proceso
select count(1) from borrar_wf_r_proceso_103378

