/********************************************************************/
/* Fecha:   31-MAYO-2015                                            */
/* Objeto:  Script de creacion de vistas                            */
/* Database name:  cob_workflow                                     */
/* Modulo:  Workflow                                                */
/********************************************************************/
use cob_workflow
go

-- Creacion de vista: nt_detalle_desviacion_ind
if exists(select 1 from sysobjects where name = 'nt_detalle_desviacion_ind' and type = 'V')
   drop view nt_detalle_desviacion_ind
go

create view nt_detalle_desviacion_ind as
    select 'pro'  = dd_nombre_proceso,
           'act'  = dd_nombre_actividad,
           'des'  = dd_nombre_destinatario,
           'tEs'  = dd_tiempo_estandar,
           'tEj'  = dd_tiempo_ejecucion,
           'dif'  = (dd_tiempo_ejecucion - dd_tiempo_estandar),
           'sId'  = uj.uj_id_usuario_padre
    from wf_detalle_desviacion_ind dd   
    inner join cob_workflow..wf_usuario_jerarquia_tpl uj on dd.dd_id_destinatario = uj.us_id_usuario
    inner join cob_workflow..wf_usuario_email ue on uj.uj_id_usuario_padre = ue.ue_id_usuario
go        

if exists (select 1 from sysobjects a where a.name = 'nt_cabecera_desviacion_ind' AND a.type='V')
    drop view nt_cabecera_desviacion_ind
go

create view nt_cabecera_desviacion_ind as
    SELECT DISTINCT 'sId' =  uj.uj_id_usuario_padre,
                    'sup' = ue_nombre_func
    from wf_detalle_desviacion_ind dd
    inner join cob_workflow..wf_usuario_jerarquia_tpl uj on dd.dd_id_destinatario = uj.us_id_usuario
    inner join cob_workflow..wf_usuario_email ue on uj.uj_id_usuario_padre = ue.ue_id_usuario

go       
