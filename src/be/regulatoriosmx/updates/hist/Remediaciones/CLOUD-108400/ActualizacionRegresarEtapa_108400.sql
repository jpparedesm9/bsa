use cob_workflow
go

declare @w_actividad varchar(100),
        @w_inst_proceso int,
        @w_inst_actividad int
 
select @w_actividad = 'APROBAR PRÉSTAMO'
select @w_inst_proceso = 2797
select @w_inst_actividad  = max(ia_id_inst_act)
from  cob_workflow..wf_inst_actividad
where  ia_id_inst_proc = @w_inst_proceso
  and  ia_nombre_act = @w_actividad
 
delete cob_workflow..wf_asig_actividad where aa_id_inst_act in (select ia_id_inst_act from cob_workflow..wf_inst_actividad where ia_id_inst_proc = @w_inst_proceso and ia_id_inst_act > @w_inst_actividad)
 
update cob_workflow..wf_asig_actividad 
set aa_estado = 'PEN'
where aa_id_inst_act = @w_inst_actividad
 
delete cob_workflow..wf_inst_actividad where ia_id_inst_act > @w_inst_actividad and ia_id_inst_proc = @w_inst_proceso
 
update cob_workflow..wf_inst_actividad
set ia_estado = 'ACT'
where ia_id_inst_act = @w_inst_actividad--and ia_id_inst_proc = @w_inst_proceso
