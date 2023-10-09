--Remediacion caso 108967
--Grupo 268

------------------------------
--ACTUALIZAR TRAMITE ANTERIOR
------------------------------
PRINT 'Antes de Actualizar'
select *
from cob_workflow..wf_inst_proceso
where io_campo_1      = 268
and   io_id_inst_proc = 3127

PRINT 'Actualizando'
update cob_workflow..wf_inst_proceso
set   io_campo_5      = 9678
where io_campo_1      = 268
and   io_id_inst_proc = 3127

PRINT 'Despues de Actualizar'
select *
from cob_workflow..wf_inst_proceso
where io_campo_1      = 268
and   io_id_inst_proc = 3127


GO
------------------
--PASAR DE ETAPA
------------------
declare @w_actividad varchar(100), 
        @w_inst_proceso int, 
        @w_inst_actividad int 
print 'Cambiar de etapa a Aprobar Prestamo'
select @w_actividad = 'APROBAR PRÉSTAMO' 
select @w_inst_proceso = 3127 

select @w_inst_actividad = max(ia_id_inst_act) 
from cob_workflow..wf_inst_actividad 
where ia_id_inst_proc = @w_inst_proceso 
and ia_nombre_act = @w_actividad 

delete cob_workflow..wf_asig_actividad 
where aa_id_inst_act in (select ia_id_inst_act 
						from cob_workflow..wf_inst_actividad 
						where ia_id_inst_proc = @w_inst_proceso 
						and ia_id_inst_act > @w_inst_actividad) 
						
update cob_workflow..wf_asig_actividad 
set aa_estado = 'PEN' 
where aa_id_inst_act = @w_inst_actividad 

delete cob_workflow..wf_inst_actividad 
where ia_id_inst_act > @w_inst_actividad 
and ia_id_inst_proc = @w_inst_proceso 

update cob_workflow..wf_inst_actividad 
set ia_estado = 'ACT' 
where ia_id_inst_act = @w_inst_actividad

go


