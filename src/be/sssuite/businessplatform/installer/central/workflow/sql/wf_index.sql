/*==============================================================*/
/* Database name:  cob_workflow                                 */
/* DBMS name:      Microsoft SQL Server 7.x                     */
/* Created on:     18/01/2002 10:43:20                          */
/*==============================================================*/

use cob_workflow
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_asig_actividad')
            and   name  = 'asig_actividad_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_asig_actividad.asig_actividad_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_asig_actividad')
            and   name  = 'asig_actividad_i2'
            and   indid > 0
            and   indid < 255)
   drop index wf_asig_actividad.asig_actividad_i2
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_asig_actividad')
            and   name  = 'asig_actividad_i3'
            and   indid > 0
            and   indid < 255)
   drop index wf_asig_actividad.asig_actividad_i3
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_dist_carga')
            and   name  = 'dist_carga_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_dist_carga.dist_carga_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_requisito_actividad')
            and   name  = 'documento_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_requisito_actividad.documento_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_requisito_actividad')
            and   name  = 'documento_i2'
            and   indid > 0
            and   indid < 255)
   drop index wf_requisito_actividad.documento_i2
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_requisito_actividad')
            and   name  = 'documento_i3'
            and   indid > 0
            and   indid < 255)
   drop index wf_requisito_actividad.documento_i3
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_enlace')
            and   name  = 'enlace_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_enlace.enlace_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_exc_inst_proc')
            and   name  = 'exc_inst_proc_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_exc_inst_proc.exc_inst_proc_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_h_estado_actividad')
            and   name  = 'h_estado_actividad_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_h_estado_actividad.h_estado_actividad_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_h_estado_proceso')
            and   name  = 'h_estado_proceso_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_h_estado_proceso.h_estado_proceso_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_ins_inst_proc')
            and   name  = 'ins_inst_proc_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_ins_inst_proc.ins_inst_proc_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_inst_actividad')
            and   name  = 'inst_actividad_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_inst_actividad.inst_actividad_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_mapeo_condicion')
            and   name  = 'mapeo_condicion_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_mapeo_condicion.mapeo_condicion_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_mod_variable')
            and   name  = 'mod_variable_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_mod_variable.mod_variable_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_parametro_programa')
            and   name  = 'parametro_programa_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_parametro_programa.parametro_programa_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_paso')
            and   name  = 'paso_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_paso.paso_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_proceso')
            and   name  = 'proceso_i2'
            and   indid > 0
            and   indid < 255)
   drop index wf_proceso.proceso_i2
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_resultado_actividad')
            and   name  = 'resultado_actividad_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_resultado_actividad.resultado_actividad_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_rol')
            and   name  = 'rol_i2'
            and   indid > 0
            and   indid < 255)
   drop index wf_rol.rol_i2
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_tipo_documento')
            and   name  = 'tipo_documento_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_tipo_documento.tipo_documento_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_usuario')
            and   name  = 'usuario_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_usuario.usuario_i1
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_usuario')
            and   name  = 'usuario_i2'
            and   indid > 0
            and   indid < 255)
   drop index wf_usuario.usuario_i2
go


if exists (select 1
            from  sysindexes
           where  id    = object_id('wf_variable_actual')
            and   name  = 'variable_actual_i1'
            and   indid > 0
            and   indid < 255)
   drop index wf_variable_actual.variable_actual_i1
go


/*==============================================================*/
/* Index: asig_actividad_i1                                     */
/*==============================================================*/
create   index asig_actividad_i1 on wf_asig_actividad (aa_id_inst_act)
go


/*==============================================================*/
/* Index: asig_actividad_i2                                     */
/*==============================================================*/
CREATE NONCLUSTERED INDEX asig_actividad_i2
    ON dbo.wf_asig_actividad(aa_id_destinatario)
go

/*==============================================================*/
/* Index: asig_actividad_i3                                     */
/*==============================================================*/
CREATE NONCLUSTERED INDEX asig_actividad_i3
    ON dbo.wf_asig_actividad(aa_id_rol)
go


/*==============================================================*/
/* Index: dist_carga_i1                                         */
/*==============================================================*/
create unique  index dist_carga_i1 on wf_dist_carga (dc_nom_dist_car)
go


/*==============================================================*/
/* Index: documento_i1                                          */
/*==============================================================*/
create   index documento_i1 on wf_requisito_actividad (rc_id_asig_act)
go

/*==============================================================*/
/* Index: documento_i2                                          */
/*==============================================================*/
create   index documento_i2 on wf_requisito_actividad (rc_inst_actividad)
go

/*==============================================================*/
/* Index: documento_i3                                          */
/*==============================================================*/
create   index documento_i3 on wf_requisito_actividad (
rc_codigo_tipo_doc,
rc_id_paso
)
go

/*==============================================================*/
/* Index: enlace_i1                                             */
/*==============================================================*/
create   index enlace_i1 on wf_enlace (
en_id_paso_ini,
en_codigo_proceso,
en_version_proceso
)
go


/*==============================================================*/
/* Index: exc_inst_proc_i1                                      */
/*==============================================================*/
create   index exc_inst_proc_i1 on wf_exc_inst_proc (ei_id_inst_proc)
go


/*==============================================================*/
/* Index: h_estado_actividad_i1                                 */
/*==============================================================*/
create   index h_estado_actividad_i1 on wf_h_estado_actividad (ea_id_inst_act)
go


/*==============================================================*/
/* Index: h_estado_proceso_i1                                   */
/*==============================================================*/
create   index h_estado_proceso_i1 on wf_h_estado_proceso (ep_id_inst_proc)
go


/*==============================================================*/
/* Index: ins_inst_proc_i1                                      */
/*==============================================================*/
create   index ins_inst_proc_i1 on wf_ins_inst_proc (ii_id_inst_proc)
go


/*==============================================================*/
/* Index: mapeo_condicion_i1                                    */
/*==============================================================*/
create   index mapeo_condicion_i1 on wf_mapeo_condicion (mc_codigo_item)
go


/*==============================================================*/
/* Index: mod_variable_i1                                       */
/*==============================================================*/
create   index mod_variable_i1 on wf_mod_variable (
mv_id_inst_proc,
mv_codigo_var
)
go


/*==============================================================*/
/* Index: parametro_programa_i1                                 */
/*==============================================================*/
create unique  index parametro_programa_i1 on wf_parametro_programa (
pp_nombre_parametro,
pp_id_programa
)
go


/*==============================================================*/
/* Index: paso_i1                                               */
/*==============================================================*/
create   index paso_i1 on wf_paso (
pa_version_proceso,
pa_codigo_proceso
)
go


/*==============================================================*/
/* Index: proceso_i2                                            */
/*==============================================================*/
create   index proceso_i2 on wf_proceso (pr_codigo_empresa)
go


/*==============================================================*/
/* Index: resultado_actividad_i1                                */
/*==============================================================*/
create   index resultado_actividad_i1 on wf_resultado_actividad (
ra_id_paso,
ra_codigo_proceso,
ra_version_proceso
)
go


/*==============================================================*/
/* Index: rol_i2                                                */
/*==============================================================*/
create   index rol_i2 on wf_rol (ro_codigo_empresa)
go


/*==============================================================*/
/* Index: tipo_documento_i1                                     */
/*==============================================================*/
create unique  index tipo_documento_i1 on wf_tipo_documento (td_nombre_tipo_doc)
go


/*==============================================================*/
/* Index: usuario_i1                                            */
/*==============================================================*/
create   index usuario_i1 on wf_usuario (us_codigo_empresa)
go


/*==============================================================*/
/* Index: usuario_i2                                            */
/*==============================================================*/
create unique  index usuario_i2 on wf_usuario (us_login)
go


/*==============================================================*/
/* Index: variable_actual_i1                                    */
/*==============================================================*/
create   index variable_actual_i1 on wf_variable_actual (va_id_inst_proc)
go


/*==============================================================*/
/* Index: inst_actividad_i1                                     */
/*==============================================================*/
create index inst_actividad_i1 on wf_inst_actividad (ia_id_inst_proc)
go

create index inst_actividad_i2 on wf_inst_actividad (ia_estado)
go

/********************************************************************/
/* Fecha:   31-MAYO-2015                                            */
/* Objeto:  Script de creacion de indices                           */
/* Database name:  cob_workflow                                     */
/* Modulo:  Workflow                                                */
/********************************************************************/
use cob_workflow
go

if exists(select 1 from sysindexes where name = 'ind_io_codigo_proc')
   drop index wf_inst_proceso.ind_io_codigo_proc
go
create index ind_io_codigo_proc on wf_inst_proceso(io_codigo_proc)
go

if exists(select 1 from sysindexes where name = 'ind_io_version_proc')
   drop index wf_inst_proceso.ind_io_version_proc
go
create index ind_io_version_proc on wf_inst_proceso(io_version_proc)
go

if exists(select 1 from sysindexes where name = 'ind_ar_tiempo_estandar')
   drop index wf_actividad_proc.ind_ar_tiempo_estandar
go
create index ind_ar_tiempo_estandar on wf_actividad_proc(ar_tiempo_estandar)
go

if exists(select 1 from sysindexes where name = 'ind_ar_margen_tolerancia')
   drop index wf_actividad_proc.ind_ar_margen_tolerancia
go
create index ind_ar_margen_tolerancia on wf_actividad_proc(ar_margen_tolerancia)
go

if exists(select 1 from sysindexes where name = 'ind_ia_codigo_act')
   drop index wf_inst_actividad.ind_ia_codigo_act
go
create index ind_ia_codigo_act on wf_inst_actividad(ia_codigo_act)
go

if exists(select 1 from sysindexes where name = 'ind_aa_estado')
   drop index wf_asig_actividad.ind_aa_estado
go
create index ind_aa_estado on wf_asig_actividad(aa_estado)
go

if exists(select 1 from sysindexes where name = 'ind_aa_fecha_fin')
   drop index wf_asig_actividad.ind_aa_fecha_fin
go
create index ind_aa_fecha_fin on wf_asig_actividad(aa_fecha_fin)
go

if exists(select 1 from sysindexes where name = 'ind_aa_fecha_asig')
   drop index wf_asig_actividad.ind_aa_fecha_asig
go
create index ind_aa_fecha_asig on wf_asig_actividad(aa_fecha_asig)
go
