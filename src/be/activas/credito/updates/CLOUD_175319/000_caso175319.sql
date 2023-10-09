--Por error al querer modificar los enlaces del flujo de SOLICITUD DE CREDITO INDIVIDUAL REVOLVENTE

declare  @w_actividad int, @w_proceso int, @w_version_prd int,  @w_paso int

select @w_actividad = ac_codigo_actividad
from cob_workflow..wf_actividad
where ac_nombre_actividad = 'REVISAR Y VALIDAR INFORMACIÓN'
select @w_proceso = pr_codigo_proceso,@w_version_prd = pr_version_prd
from cob_workflow..wf_proceso, cob_workflow..wf_actividad
where pr_nombre_proceso = 'SOLICITUD DE CREDITO INDIVIDUAL REVOLVENTE'

select @w_paso = pa_id_paso from cob_workflow..wf_paso 
where pa_codigo_proceso =  @w_proceso
and pa_version_proceso = @w_version_prd
and pa_codigo_actividad =  @w_actividad

delete cob_workflow..wf_cond_enlace_proc
where ce_id_enlace in (select en_id_enlace 
from cob_workflow..wf_enlace 
where en_id_paso_ini =  @w_paso)

delete cob_workflow..wf_enlace 
where en_id_paso_ini =  @w_paso
GO
