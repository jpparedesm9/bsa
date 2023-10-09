use cob_workflow
go


select 'HASTA GARANTIA LIQUIDA'='HASTA GARANTIA LIQUIDA',
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
and io_campo_4 = 'GRUPAL'
--and io_version_proc <= 25
and ac_nombre_actividad in 
('INGRESAR SOLICITUD', ---
'GESTIONAR RENOVACIÓN - COORD.',---
'GESTIONAR RENOVACIÓN-GERENTE',---
'APLICAR CUESTIONARIO - GRUPAL',----
'REVISAR Y VALIDAR INFORMACIÓN',----
'AUTORIZAR SOBREPASAR LIMITE',---
'AUTORIZAR LIMITE CONCENTRACIÓN',---
'APROBAR PRÉSTAMO',----
'ESPERAR CANCELACIÓN CRÉDITO AN',---
'ESPERA AUTOMATICA GAR LIQUIDA',----
'APROBAR PRÉSTAMO REGIONAL'----**
)

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

/******Actualizacion Promo *******************/

select 
grupo = io_campo_1,  
id_solicitud,
tramite_ant = max(io_campo_3),
promocion = convert(varchar(2), null)
into #promocion
from #solicitudes,
cob_workflow..wf_inst_proceso
where io_campo_1 = [Codigo Grupo]
and   io_campo_3 <> Tramite
and  io_estado = 'TER'
group by io_campo_1, id_solicitud

update #promocion set 
promocion = tr_promocion
from cob_credito..cr_tramite
where tramite_ant = tr_tramite


select tramite = tr_tramite, id_solicitud, grupo
into #actualizar_promo
from #promocion,
cob_workflow..wf_inst_proceso,
cob_credito..cr_tramite
where io_id_inst_proc = id_solicitud
and   io_campo_3      = tr_tramite
and   promocion       = 'S' 



select *
from cob_credito..cr_tramite,
#actualizar_promo
where tramite = tr_tramite


update cob_credito..cr_tramite set
tr_promocion = 'S'
from #actualizar_promo
where tramite = tr_tramite


select *
from cob_credito..cr_tramite,
#actualizar_promo
where tramite = tr_tramite



select *
from cob_cartera..ca_operacion,
#actualizar_promo
where tramite = op_tramite


update cob_cartera..ca_operacion set
op_promocion = 'S'
from #actualizar_promo
where tramite = op_tramite


select *
from cob_cartera..ca_operacion,
#actualizar_promo
where tramite = op_tramite





drop table #actualizar_promo
drop table #promocion
drop table #solicitudes