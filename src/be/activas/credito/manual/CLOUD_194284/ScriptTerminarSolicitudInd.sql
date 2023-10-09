

use cob_workflow
go

select 'ANTES GARANTIA LIQUIDA'='ANTES GARANTIA LIQUIDA',
       'Codigo Grupo' = io_campo_1,
       'Nombre del Grupo'= (select gr_nombre from cobis..cl_grupo where gr_grupo=io_campo_1),
        'Tramite'     = io_campo_3,
        'Estado'      = io_estado,
        'Solicitus'   =  io_codigo_alterno,
        'Login'       = us_login,
        'Etapa'       = ac_nombre_actividad,
        'Version del Flujo'=io_version_proc,
        'Fecha Creacion' = io_fecha_crea,
        id_solicitud = io_id_inst_proc
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
and io_campo_4 = 'INDIVIDUAL'
and ac_nombre_actividad in 
('INGRESAR SOLICITUD',
'GESTIONAR RENOVACIÓN - COORD.',
'GESTIONAR RENOVACIÓN-GERENTE',
'APLICAR CUESTIONARIO - INDIVID',
'REVISAR Y VALIDAR INFORMACIÓN',
'AUTORIZAR LIMITE CONCENTRACIÓN',
'APROBAR PRÉSTAMO',
'APROBAR PRÉSTAMO REGIONAL',
'ESPERAR CANCELACIÓN CRÉDITO AN',
'ESPERA AUTOMATICA GAR LIQUIDA')


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


drop table #solicitudes