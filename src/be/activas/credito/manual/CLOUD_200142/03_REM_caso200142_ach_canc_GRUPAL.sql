--Script para terminar las solicitudes que estan hasta garantía liquida.
use cob_workflow
go

declare @w_producto varchar(30), @w_version_flujo int, @w_cod_proceso int

SELECT @w_cod_proceso = pr_codigo_proceso,
       @w_version_flujo = pr_version_prd
from cob_workflow..wf_proceso
where pr_nemonico = 'SOLCRGRSTD'

select @w_producto = 'GRUPAL'
select 'producto' = @w_producto, 'version' = @w_version_flujo, 'cod_proceso' = @w_cod_proceso

create table #etapas (
    tarea varchar(256)
)

insert into #etapas values ('INGRESAR SOLICITUD')
insert into #etapas values ('APLICAR CUESTIONARIO - GRUPAL')
--SELECT * from cob_workflow..wf_proceso

select 'GRUPALES'='GRUPALES',
       'Codigo Grupo' = io_campo_1,
       'Nombre del Grupo'= (select gr_nombre from cobis..cl_grupo where gr_grupo=io_campo_1),
       'Tramite'     = io_campo_3,
       'Estado'      = io_estado,
       'Solicitus'   =  io_codigo_alterno,
       'Login'       = us_login,
       'Etapa'       = ac_nombre_actividad,
       'Version del Flujo' = io_version_proc,
       'Fecha Creacion'    = io_fecha_crea,
       id_solicitud        = io_id_inst_proc
into #solicitudes        
FROM cob_workflow..wf_inst_proceso,
cob_workflow..wf_inst_actividad,
cob_workflow..wf_actividad,
cob_workflow..wf_asig_actividad,
cob_workflow..wf_usuario
WHERE ia_id_inst_proc = io_id_inst_proc
and ia_codigo_act = ac_codigo_actividad
and aa_id_inst_act = ia_id_inst_act
and us_id_usuario = aa_id_destinatario
and io_estado  = 'EJE'
and aa_estado  = 'PEN'
and io_campo_4 = @w_producto
and io_codigo_proc = @w_cod_proceso
and io_version_proc <= @w_version_flujo
and ac_nombre_actividad in (select tarea from #etapas)

select io_estado, *
from cob_workflow..wf_inst_proceso, #solicitudes
where io_id_inst_proc = id_solicitud

update cob_workflow..wf_inst_proceso set
io_estado = 'TER'
from #solicitudes
where io_id_inst_proc = id_solicitud

select io_estado, *
from cob_workflow..wf_inst_proceso, #solicitudes
where io_id_inst_proc = id_solicitud

select  tr_estado, *
from cob_credito..cr_tramite, #solicitudes
where Tramite = tr_tramite

update cob_credito..cr_tramite set
tr_estado = 'P'
from #solicitudes
where tr_tramite = Tramite

select  tr_estado, *
from cob_credito..cr_tramite, #solicitudes
where Tramite = tr_tramite

drop table #etapas
drop table #solicitudes
go
