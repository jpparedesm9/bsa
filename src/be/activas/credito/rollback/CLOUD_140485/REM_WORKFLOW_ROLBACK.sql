use cob_workflow
go

delete wf_tipo_documento where td_nombre_tipo_doc = 'SOLICITUD COMPLEMENTARIA LCR'

go

use cobis
go

update an_component set 
co_class= 'VC_BIOVALIDSA_412339_TASK.html' 
where co_name = 'VALIDACION BIOMETRICO'
and co_prod_name = 'WF'

delete an_component where co_name = 'VALIDACION BIOMETRICO LCR'

--Rollback Flujo
declare
@w_version_proc    int,
@w_id_proceso      int


select 
@w_version_proc =  pr_version_prd,
@w_id_proceso   =  pr_codigo_proceso
from cob_workflow..wf_proceso 
where pr_nombre_proceso = 'SOLICITUD DE CREDITO INDIVIDUAL REVOLVENTE'

update cob_workflow..wf_version_proceso 
set    vp_estado = 'CON'
where  vp_codigo_proceso  = @w_id_proceso
and    vp_version_proceso = @w_version_proc

select @w_version_proc  = @w_version_proc  - 1

update cob_workflow..wf_version_proceso 
set    vp_estado = 'PRD'
where  vp_codigo_proceso  = @w_id_proceso
and    vp_version_proceso = @w_version_proc

update cob_workflow..wf_proceso 
set    pr_version_prd = @w_version_proc
where  pr_nombre_proceso = 'SOLICITUD DE CREDITO INDIVIDUAL REVOLVENTE'


--Rollback Regla Validación INE
declare 
@w_rule_id       int,
@w_rv_id         int,
@w_version_rule  int,
@w_fecha         datetime

select @w_rule_id = rl_id 
from cob_pac..bpl_rule
where rl_name = 'Validacion INE'

select 
@w_rv_id        = rv_id,
@w_version_rule = rv_version
@w_fecha        = rv_date_finish
from cob_pac..bpl_rule_version
where rl_id = @w_rule_id
and   rv_status = 'PRO'

update cob_pac..bpl_rule_version
set rv_status = 'DIS'
where rl_id = @w_rule_id
and   rv_status = 'PRO'

select @w_version_rule = @w_version_rule - 1

update cob_pac..bpl_rule_version
set rv_status = 'PRO'.
    rv_date_finish = @w_fecha
where rl_id = @w_rule_id
and rv_version = @w_version_rule

go