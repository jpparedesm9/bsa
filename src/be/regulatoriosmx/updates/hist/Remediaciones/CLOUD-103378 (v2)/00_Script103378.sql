use cob_workflow 
go

select *
into borrar_wf_r_actividades_proc_103378
from cob_workflow..wf_r_actividades_proc

select count(1) from cob_workflow..wf_r_actividades_proc
select count(1) from  borrar_wf_r_actividades_proc_103378

select *
into borrar_wf_r_asignacion_act_103378
from cob_workflow..wf_r_asignacion_act

select count(1) from cob_workflow..wf_r_asignacion_act
select count(1) from cob_workflow..borrar_wf_r_asignacion_act_103378

select *
into borrar_wf_r_proceso_103378
from cob_workflow..wf_r_proceso

select count(1) from cob_workflow..wf_r_proceso
select count(1) from cob_workflow..borrar_wf_r_proceso_103378

