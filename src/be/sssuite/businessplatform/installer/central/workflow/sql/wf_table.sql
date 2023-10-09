/*==============================================================*/
/* Database name:  cob_workflow                                 */
/* DBMS name:      Sybase AS Enterprise 12.0/12.5/15.7          */
/* Created on:     24/11/2004 14:56:10                          */
/* Modify on:      19/03/2014 16:00:10                          */
/*==============================================================*/
use cob_workflow
go

/*==============================================================*/
/* Table: wf_actividad                                          */
/*==============================================================*/
print '===> Creando wf_actividad'
create table wf_actividad (
     ac_codigo_actividad  smallint                       not null,
     ac_nombre_actividad  NOMBRE                         not null,
     ac_codigo_empresa    smallint                       not null,
     ac_desc_actividad    DESCRIPCION                    null,
     ac_tipo_actividad    varchar(10)                    not null
           constraint tipo_actividad_c1 check (ac_tipo_actividad in ('NOR', 'LAN', 'INF')),
     ac_estado            varchar(10)                    not null
           constraint tipo_actividad_c2 check (ac_estado in ('ACT', 'INA')),
     ac_color_fondo       int                            not null,
     ac_color_texto       int                            not null,
     constraint PK_WF_ACTIVIDAD primary key (ac_codigo_actividad)
)
go

/*==============================================================*/
/* Table: wf_actividad_proc                                     */
/*==============================================================*/
print '===> Creando wf_actividad_proc'
create table wf_actividad_proc (
     ar_codigo_actividad  smallint                       not null,
     ar_codigo_proceso    smallint                       not null,
     ar_version_proceso   smallint                       not null,
     ar_tiempo_estandar   int                            not null,
     ar_tiempo_efectivo   int                            not null,
     ar_costo_act_proc    money                          null,
     ar_suspendida        BOOLEANO                       not null,
     ar_ayuda_operativa   DESCRIPCION                    null,
     ar_func_asociada     varchar(30)                    null,
     ar_inst_exce         char(1)                        null,
	 ar_margen_tolerancia decimal(12,2)					 null,
     constraint PK_WF_ACTIVIDAD_PROC primary key (ar_codigo_actividad, ar_codigo_proceso, ar_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_asig_actividad                                     */
/*==============================================================*/
print '===> Creando wf_asig_actividad'
create table wf_asig_actividad (
     aa_id_asig_act       int                            not null,
     aa_id_inst_act       int                            not null,
     aa_codigo_res        smallint                       null,
     aa_id_destinatario   int                            not null,
     aa_id_rol            int                            null,
     aa_secuencia         smallint                       not null,
     aa_fecha_asig        datetime                       not null,
     aa_fecha_fin         datetime                       null,
     aa_estado            varchar(10)                    not null
           constraint asig_actividad_c1 check (aa_estado in ('PEN', 'ABR', 'REA', 'COM', 'REC')),
     aa_id_usr_reasigno   int                            null,
     aa_id_rol_reasigno   int                            null,
     aa_id_usr_reasignado int                            null,
     aa_id_rol_reasignado int                            null,
     aa_id_usr_sustituto  int                            null,
     aa_id_rol_sustituto  int                            null,
     aa_id_usr_sustituido int                            null,
     aa_id_rol_sustituido int                            null,
     aa_oficina_asig      smallint                       not null,
     aa_manual            tinyint                        null,
	 aa_claim             char(1)      					 null,
	 aa_act_regreso       char(1)                        null,
	 aa_id_item_jerarquia int							 null,
     constraint PK_WF_ASIG_ACTIVIDAD primary key (aa_id_asig_act)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_asig_man_mult                                      */
/*==============================================================*/
print '===> Creando wf_asig_man_mult'
create table wf_asig_man_mult (
     mm_id_inst_proc      int                            not null,
     mm_id_inst_act       int                            not null,
     mm_id_usuario        int                            not null,
     mm_id_rol            int                            not null,
     mm_cod_actividad     smallint                       not null,
     mm_id_paso           int                            not null,
     constraint PK_WF_ASIG_MAN_MULT primary key (mm_id_usuario, mm_id_rol, mm_id_inst_proc, mm_id_inst_act)
)
go

/*==============================================================*/
/* Table: wf_atri_rol_usu                                       */
/*==============================================================*/
print '===> Creando wf_atri_rol_usu'
create table wf_atri_rol_usu (
     as_id_rol            int                            not null,
     as_id_usuario        int                            not null,
     as_id_atribucion     int                            not null,
     constraint PK_WF_ATRI_ROL_USU primary key (as_id_atribucion, as_id_usuario, as_id_rol)
)
go

/*==============================================================*/
/* Table: wf_atribucion                                         */
/*==============================================================*/
print '===> Creando wf_atribucion'
create table wf_atribucion (
     an_id_atribucion     int                            not null,
     an_nombre_atribucion NOMBRE                         not null,
     an_desc_atribucion   DESCRIPCION                    null,
     an_tipo_atribucion   varchar(10)                    not null
           constraint atribucion_c1 check (an_tipo_atribucion in ('INS', 'EXC', 'REQ', 'RES')),
     an_codigo_item       smallint                       not null,
     an_condicion         DESCRIPCION                    null,
     an_operacion         varchar(10)                    not null
           constraint CKC_AN_OPERACION_WF_ATRIB check (an_operacion in ('SEL', 'CRE', 'APR', 'EJE', 'REC')),
     constraint PK_WF_ATRIBUCION primary key (an_id_atribucion)
)
go

/*==============================================================*/
/* Table: wf_atributo                                           */
/*==============================================================*/
print '===> Creando wf_atributo'
create table wf_atributo (
     ao_codigo_atributo   smallint                       not null,
     ao_nombre_atributo   NOMBRE                         not null,
     ao_valor_omision     VALOR_VARIABLE                 null,
     constraint PK_WF_ATRIBUTO primary key (ao_codigo_atributo)
)
go

/*==============================================================*/
/* Table: wf_atributo_usuario                                   */
/*==============================================================*/
print '===> Creando wf_atributo_usuario'
create table wf_atributo_usuario (
     au_id_usuario        int                            not null,
     au_codigo_atributo   smallint                       not null,
     au_codigo_proceso    smallint                       not null,
     au_valor             VALOR_VARIABLE                 null,
     constraint PK_WF_ATRIBUTO_USUARIO primary key (au_codigo_atributo, au_id_usuario, au_codigo_proceso)
)
go

/*==============================================================*/
/* Table: wf_cola                                               */
/*==============================================================*/
print '===> Creando wf_cola'
create table wf_cola (
     co_id_cola           int                            not null,
     co_nombre_cola       NOMBRE                         not null,
     co_codigo_empresa    smallint                       not null,
     constraint PK_WF_COLA primary key (co_id_cola)
)
go

/*==============================================================*/
/* Table: wf_cond_enlace_proc                                   */
/*==============================================================*/
print '===> Creando wf_cond_enlace_proc'
create table wf_cond_enlace_proc (
     ce_id_enlace         int                            not null,
     ce_codigo_proceso    smallint                       not null,
     ce_version_proceso   smallint                       not null,
     ce_condicion         CONDICION                      not null,
     ce_num_firmas        tinyint                        not null,
     ce_requisito         DESCRIPCION                    null,
     constraint PK_WF_COND_ENLACE_PROC primary key (ce_id_enlace, ce_codigo_proceso, ce_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_destinatario                                       */
/*==============================================================*/
print '===> Creando wf_destinatario'
create table wf_destinatario (
     de_codigo_actividad  smallint                       not null,
     de_codigo_proceso    smallint                       not null,
     de_version_proceso   int                            not null,
     de_id_destinatario   int                            not null,
     de_id_rol_destinatario int                          null,
     de_tipo_destinatario varchar(10)                    not null
           constraint destinatario_c1 check (de_tipo_destinatario in ('USR', 'ROL', 'PRO', 'COL', 'COM', 'SUB', 'JER', 'RUL', 'POL','JEU')),
     de_tipo_distribucion_carga varchar(10)              not null
           constraint destinatario_c2 check (de_tipo_distribucion_carga in ('MCN', 'MCT', 'NIN', 'ESP')),
     de_codigo_dist_carga smallint                       null,
     de_tipo_oficina_dist_carga varchar(10)              not null
           constraint destinatario_c3 check (de_tipo_oficina_dist_carga in ('OFI', 'OFE', 'OFN','OFU')),
     de_requiere_usr_log  BOOLEANO                       not null,
     de_version_subpr     smallint                       null,
     de_rol_cobis         int                            null,
     constraint PK_WF_DESTINATARIO primary key (de_codigo_actividad, de_codigo_proceso, de_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_dist_carga                                         */
/*==============================================================*/
print '===> Creando wf_dist_carga'
create table wf_dist_carga (
     dc_cod_dist_car      smallint                       not null,
     dc_nom_dist_car      NOMBRE                         not null,
     dc_desc_dist_car     DESCRIPCION                    null,
     dc_nombre_sp         NOMBRE                         not null,
     constraint PK_WF_DIST_CARGA primary key (dc_cod_dist_car)
)
go

/*==============================================================*/
/* Table: wf_empresa                                            */
/*==============================================================*/
print '===> Creando wf_empresa'
create table wf_empresa (
     em_codigo_empresa    smallint                       not null,
     em_nombre_empresa    NOMBRE                         not null,
     constraint PK_WF_EMPRESA primary key (em_codigo_empresa)
)
go

/*==============================================================*/
/* Table: wf_enlace                                             */
/*==============================================================*/
print '===> Creando wf_enlace'
create table wf_enlace (
     en_id_enlace         int                            not null,
     en_nombre_enlace     varchar(30)                    null,
     en_codigo_proceso    smallint                       not null,
     en_id_paso_ini       int                            not null,
     en_id_paso_fin       int                            not null,
     en_puntos_enlace     varchar(255)                   null,
     en_version_proceso   smallint                       not null,
	 en_retorno_enlace    char(1)                        null,
     constraint PK_WF_ENLACE primary key (en_id_enlace)
)
go

/*==============================================================*/
/* Table: wf_enlace_roles                                       */
/*==============================================================*/
print '===> Creando wf_enlace_roles'
create table wf_enlace_roles (
     ej_enlace_rol        int                            not null,
     ej_nombre_enlace     varchar(30)                    null,
     ej_codigo_proceso    smallint                       not null,
     ej_version_proceso   smallint                       not null,
     ej_id_jerarquia      smallint                       not null,
     ej_id_rol_ini        int                            not null,
     ej_id_rol_fin        int                            not null,
     ej_prioridad         smallint                       null,
     ej_condicion         DESCRIPCION                    null,
     ej_inst_excep        DESCRIPCION                    null,
     ej_puntos_enlace     varchar(255)                   null,
     constraint PK_WF_ENLACE_ROLES primary key (ej_enlace_rol)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_exc_inst_proc                                      */
/*==============================================================*/
print '===> Creando wf_exc_inst_proc'
create table wf_exc_inst_proc (
     ei_id_exc_inst_proc  int                            not null,
     ei_id_inst_proc      int                            not null,
     ei_codigo_exc        smallint                       not null,
     ei_id_asig_act       int                            null,
     ei_texto_exc         varchar(255)                   null,
     ei_estado            varchar(10)                    not null
           constraint exc_inst_proc_c1 check (ei_estado in ('INI', 'APR', 'REC', 'REG')),
     ei_id_aprob          int                            null,
     ei_rol_aprob         int                            null,
     ei_fecha_aprob       datetime                       null,
     ei_id_regula         int                            null,
     ei_tiempo_regula     smallint                       null,
     ei_fecha_regula      datetime                       null,
     constraint PK_WF_EXC_INST_PROC primary key (ei_id_exc_inst_proc)
)
go

/*==============================================================*/
/* Table: wf_excepcion                                          */
/*==============================================================*/
print '===> Creando wf_excepcion'
create table wf_excepcion (
     ex_codigo_excepcion  smallint                       not null,
     ex_nombre_excepcion  NOMBRE                         not null,
     ex_producto          varchar(3)                     not null,
     ex_requiere_regula   BOOLEANO                       not null,
     ex_tiempo_regula     int                            null,
     constraint PK_WF_EXCEPCION primary key (ex_codigo_excepcion)
)
go

/*==============================================================*/
/* Table: wf_excepcion_proc                                     */
/*==============================================================*/
print '===> Creando wf_excepcion_proc'
create table wf_excepcion_proc (
     er_codigo_excepcion  smallint                       not null,
     er_codigo_proceso    smallint                       not null,
     er_version_proceso   smallint                       not null,
     constraint PK_WF_EXCEPCION_PROC primary key (er_codigo_excepcion, er_codigo_proceso, er_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_h_estado_actividad                                 */
/*==============================================================*/
print '===> Creando wf_h_estado_actividad'
create table wf_h_estado_actividad (
     ea_id_h_estado       int                            not null,
     ea_id_inst_act       int                            not null,
     ea_estado            varchar(10)                    not null
           constraint h_estado_actividad_c1 check (ea_estado in ('A', 'I', 'S', 'C')),
     ea_fecha_hora        datetime                       not null,
     ea_login_usuario     varchar(30)                    null,
     ea_id_rol            int                            null,
     constraint PK_WF_H_ESTADO_ACTIVIDAD primary key (ea_id_h_estado)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_h_estado_proceso                                   */
/*==============================================================*/
print '===> Creando wf_h_estado_proceso'
create table wf_h_estado_proceso (
     ep_id_h_estado       int                            not null,
     ep_id_inst_proc      int                            not null,
     ep_estado            varchar(10)                    not null
           constraint h_estado_proceso_c1 check (ep_estado in ('INI', 'EJE', 'SUS', 'TER', 'CAN')),
     ep_fecha_hora        datetime                       not null,
     ep_login_usuario     varchar(30)                    null,
     ep_id_rol            int                            null,
     constraint PK_WF_H_ESTADO_PROCESO primary key (ep_id_h_estado)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_info_paso                                          */
/*==============================================================*/
print '===> Creando wf_info_paso'
create table wf_info_paso (
     li_id_paso           int                            not null,
     li_codigo_proceso    smallint                       not null,
     li_version_proceso   smallint                       not null,
     li_tipo_actividad    varchar(10)                    not null
           constraint info_paso_c1 check (li_tipo_actividad in ('LAN', 'INF')),
     li_cod_proc_lanzado  smallint                       null,
     li_asunto            varchar(30)                    null,
     li_mensaje           DESCRIPCION                    null,
	 li_notification_id   int         					 null,
     li_use_sms           char(1)     					 null,
     li_use_email         char(1)     					 null,
     notification_id      int         					 null,
     use_sms              char(1)     					 null,
     use_email            char(1)     					 null,
     constraint PK_WF_INFO_PASO primary key (li_id_paso)
)
go

/*==============================================================*/
/* Table: wf_info_programa                                      */
/*==============================================================*/
print '===> Creando wf_info_programa'
create table wf_info_programa (
     ip_id_programa       int                            not null,
     ip_nombre_programa   NOMBRE                         not null,
     ip_desc_programa     DESCRIPCION                    null,
     ip_tipo_programa     varchar(10)                    not null
           constraint info_programa_c1 check (ip_tipo_programa in ('EXE', 'DLL', 'PRA')),
     ip_ubicacion_programa varchar(255)                  null,
     ip_nombre_bdd        varchar(30)                    null,
     ip_nombre_servidor   varchar(30)                    null,
	 ip_id_servicio       varchar(255)                   null,
     constraint PK_WF_INFO_PROGRAMA primary key (ip_id_programa)
)
go

/* Unique index para el nombre del programa */
create unique index programa_name_index
     on wf_info_programa (ip_nombre_programa) 
go

/*==============================================================*/
/* Table: wf_ins_inst_proc                                      */
/*==============================================================*/
print '===> Creando wf_ins_inst_proc'
create table wf_ins_inst_proc (
     ii_id_ins_inst_proc  int                            not null,
     ii_id_inst_proc      int                            not null,
     ii_codigo_ins        smallint                       not null,
     ii_id_asig_act       int                            null,
     ii_texto_inst        varchar(255)                   null,
     ii_estado            varchar(10)                    not null
           constraint ins_inst_proc_c1 check (ii_estado in ('INI', 'APR', 'REC', 'EJE')),
     ii_id_aprob          int                            null,
     ii_rol_aprob         int                            null,
     ii_fecha_aprob       datetime                       null,
     ii_login_ejecuta     varchar(14)                    null,
     ii_tiempo_ejecu      int                            null,
     ii_fecha_ejecucion   datetime                       null,
     ii_tramite           int                            null,
     ii_valor             money                          null,
     ii_signo             char(2)                        null,
     ii_spread            float                          null,
     ii_fecha_reg         datetime                       null,
     ii_login_reg         varchar(14)                    null,
     ii_forma_pago        varchar(10)                    null,
     ii_cuenta            varchar(24)                    null,
     ii_tipo              char(1)                        null,
     ii_garantia          varchar(64)                    null,
     constraint PK_WF_INS_INST_PROC primary key (ii_id_ins_inst_proc)
)
go

/*==============================================================*/
/* Table: wf_inst_actividad                                     */
/*==============================================================*/
print '===> Creando wf_inst_actividad'
create table wf_inst_actividad (
     ia_id_inst_act       int                            not null,
     ia_id_inst_proc      int                            not null,
     ia_codigo_act        smallint                       not null,
     ia_nombre_act        NOMBRE                         not null,
     ia_func_asociada     varchar(30)                    null,
     ia_secuencia         smallint                       not null,
     ia_estado            varchar(10)                    not null
           constraint inst_actividad_c1 check (ia_estado in ('ACT', 'INA', 'SUS', 'COM', 'REA')),
     ia_fecha_inicio      datetime                       not null,
     ia_fecha_fin         datetime                       null,
     ia_id_paso           int                            not null,
     ia_retrasada         BOOLEANO                       not null,
     ia_mensaje           DESCRIPCION                    null,
     ia_tipo_dest         varchar(10)                    null
           constraint inst_actividad_c2 check (ia_tipo_dest is null or ( ia_tipo_dest in ('PRO', 'COL', 'SUB', 'COM') )),
     ia_id_destinatario   int                            null,
	 id_inst_act_parent   int                            null,
	 ia_error_politicas   varchar(1) 					 null,
     constraint PK_WF_INST_ACTIVIDAD primary key (ia_id_inst_act)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_inst_proceso                                       */
/*==============================================================*/
print '===> Creando wf_inst_proceso'
create table wf_inst_proceso (
     io_id_inst_proc      int                            not null,
     io_codigo_proc       smallint                       not null,
     io_version_proc      smallint                       not null,
     io_estado            varchar(10)                    not null
           constraint nst_proceso_c1 check (io_estado in ('INI', 'EJE', 'SUS', 'TER', 'CAN', 'ELI')),
     io_fecha_crea        datetime                       not null,
     io_fecha_act         datetime                       null,
     io_fecha_fin         datetime                       null,
     io_id_inst_act_padre int                            null,
     io_retrasado         BOOLEANO                       not null,
     io_oficina_inicio    smallint                       not null,
     io_oficina_entrega   smallint                       not null,
     io_comentario        DESCRIPCION                    null,
     io_campo_1           int                            null,
     io_campo_2           VALOR_VARIABLE                 null,
     io_campo_3           int                            null,
     io_campo_4           varchar(255)                   null,
     io_campo_5           int                            null,	 
     io_inst_inmediato    int                            not null,
     io_inst_padre        int                            not null,
	 io_campo_6           money     					 null,
	 io_campo_7           varchar(255) 					 null,
	 io_codigo_alterno    varchar(50)                    null,
     constraint PK_WF_INST_PROCESO primary key (io_id_inst_proc)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_instruccion                                        */
/*==============================================================*/
print '===> Creando wf_instruccion'
create table wf_instruccion (
     in_codigo_instruccion smallint                      not null,
     in_nombre_instruccion NOMBRE                        not null,
     in_tiempo_ejecu      int                            null,
     in_producto          varchar(3)                     not null,
     constraint PK_WF_INSTRUCCION primary key (in_codigo_instruccion)
)
go

/*==============================================================*/
/* Table: wf_instruccion_proc                                   */
/*==============================================================*/
print '===> Creando wf_instruccion_proc'
create table wf_instruccion_proc (
     ir_codigo_instruccion smallint                      not null,
     ir_codigo_proceso    smallint                       not null,
     ir_version_proceso   smallint                       not null,
     constraint PK_WF_INSTRUCCION_PROC primary key (ir_codigo_instruccion, ir_codigo_proceso, ir_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_jerarquia                                          */
/*==============================================================*/
print '===> Creando wf_jerarquia'
create table wf_jerarquia (
     je_id_jerarquia      smallint                       not null,
     je_nombre_jerarquia  NOMBRE                         not null,
     je_codigo_proceso    smallint                       not null,
     je_version_proceso   smallint                       not null,
     constraint PK_WF_JERARQUIA primary key (je_id_jerarquia)
)
go

/*==============================================================*/
/* Table: wf_mapeo_condicion                                    */
/*==============================================================*/
print '===> Creando wf_mapeo_condicion'
create table wf_mapeo_condicion (
     mc_codigo_item       smallint                       not null,
     mc_codigo_proceso    smallint                       not null,
     mc_version_proceso   smallint                       not null,
     mc_tipo_condicion    varchar(10)                    not null
           constraint mapeo_condicion_c1 check (mc_tipo_condicion in ('ENL', 'ATR')),
     mc_tipo_item         varchar(10)                    not null
           constraint mapeo_condicion_c2 check (mc_tipo_item in ('VAR', 'INS', 'EXC', 'RES', 'DOC')),
     mc_id                int                            not null,
     constraint PK_WF_MAPEO_CONDICION primary key (mc_tipo_condicion, mc_tipo_item, mc_version_proceso, mc_codigo_item, mc_codigo_proceso)
)
go

/*==============================================================*/
/* Table: wf_mapeo_id                                           */
/*==============================================================*/
print '===> Creando wf_mapeo_id'
create table wf_mapeo_id (
     cl_codigo_proceso    smallint                       not null,
     cl_id_antiguo        int                            not null,
     cl_id_nuevo          int                            not null,
     cl_tipo_objeto       varchar(10)                    not null
           constraint mapeo_id_c1 check (cl_tipo_objeto in ('PSO', 'ENL')),
     constraint PK_WF_MAPEO_ID primary key (cl_codigo_proceso, cl_id_antiguo, cl_tipo_objeto)
)
go

/*==============================================================*/
/* Table: wf_mapeo_var_proc                                     */
/*==============================================================*/
print '===> Creando wf_mapeo_var_proc'
create table wf_mapeo_var_proc (
     mp_codigo_proceso    smallint                       not null,
     mp_version_proceso   smallint                       not null,
     mp_codigo_variable   smallint                       not null,
     mp_cod_proc_hijo     smallint                       not null,
     mp_ver_proc_hijo     smallint                       not null,
     mp_cod_var_hijo      smallint                       not null,
     mp_tipo_mapeo_paso   varchar(10)                    not null
           constraint mapeo_var_proc_c1 check (mp_tipo_mapeo_paso in ('LAN', 'SUB')),
     mp_tipo_mapeo_var    varchar(10)                    not null
           constraint mapeo_var_proc_c2 check (mp_tipo_mapeo_var in ('ENT', 'SAL', 'ENS')),
     constraint PK_WF_MAPEO_VAR_PROC primary key (mp_codigo_proceso, mp_version_proceso, mp_codigo_variable, mp_tipo_mapeo_paso)
)
go

/*==============================================================*/
/* Table: wf_medio_receptor                                     */
/*==============================================================*/
print '===> Creando wf_medio_receptor'
create table wf_medio_receptor (
     mr_id_paso           int                            not null,
     mr_num_receptor      int                            not null,
     mr_id_medio_cobis    tinyint                        not null,
     mr_codigo_proceso    smallint                       not null,
     mr_version_proceso   smallint                       not null,
     constraint PK_WF_MEDIO_RECEPTOR primary key (mr_id_paso, mr_num_receptor, mr_id_medio_cobis)
)
go

/*==============================================================*/
/* Table: wf_mensaje                                            */
/*==============================================================*/
print '===> Creando wf_mensaje'
create table wf_mensaje (
     me_id_mensaje        int                            not null,
     me_id_inst_proc      int                            null,
     me_fecha_hora        datetime                       not null,
     me_tipo_mensaje      varchar(10)                    not null
           constraint mensaje_c1 check (me_tipo_mensaje in ('DCA', 'MOT')),
     me_tipo_prioridad    varchar(10)                    not null
           constraint mensaje_c2 check (me_tipo_prioridad in ('ALT', 'MED', 'BAJ')),
     me_estado_msj        varchar(10)                    not null
           constraint mensaje_c3 check (me_estado_msj in ('NUE', 'LEI')),
     me_mensaje           varchar(255)                   not null,
     constraint PK_WF_MENSAJE primary key (me_id_mensaje)
)
go

/*==============================================================*/
/* Table: wf_mod_variable                                       */
/*==============================================================*/
print '===> Creando wf_mod_variable'
create table wf_mod_variable (
     mv_id_inst_proc      int                            not null,
     mv_codigo_var        smallint                       not null,
     mv_id_asig_act       int                            not null,
     mv_valor_anterior    VALOR_VARIABLE                 null,
     mv_valor_nuevo       VALOR_VARIABLE                 null,
     mv_fecha_mod         datetime                       not null,
     constraint PK_WF_MOD_VARIABLE primary key (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_ob_lineas                                          */
/*==============================================================*/
print '===> Creando wf_ob_lineas'
create table wf_ob_lineas (
     ol_id_asig_act       int                            not null,
     ol_observacion       smallint                       not null,
     ol_linea             int                            not null,
     ol_texto             CONDICION                      not null,
     constraint PK_WF_OB_LINEAS primary key (ol_id_asig_act, ol_observacion, ol_linea)
)
go

/*==============================================================*/
/* Table: wf_observacion                                        */
/*==============================================================*/
print '===> Creando wf_observacion'
create table wf_observacion (
     codigo               numeric                        not null,
     valor                varchar(64)                    not null,
     constraint PK_WF_OBSERVACION primary key (codigo)
)
go

/*==============================================================*/
/* Table: wf_observaciones                                      */
/*==============================================================*/
print '===> Creando wf_observaciones'
create table wf_observaciones (
     ob_id_asig_act       int                            not null,
     ob_numero            smallint                       not null,
     ob_fecha             datetime                       not null,
     ob_categoria         varchar(10)                    null,
     ob_lineas            smallint                       not null,
     ob_oficial           char(1)                        not null,
     ob_ejecutivo         LOGIN                          null,
     constraint PK_WF_OBSERVACIONES primary key (ob_id_asig_act, ob_numero)
)
go

/*==============================================================*/
/* Table: wf_par_var_proceso                                    */
/*==============================================================*/
print '===> Creando wf_par_var_proceso'
create table wf_par_var_proceso (
     rv_id_programa       int                            not null,
     rv_secuencia         smallint                       not null,
     rv_codigo_variable   smallint                       not null,
     rv_codigo_proceso    smallint                       not null,
     rv_version_proceso   smallint                       not null,
     constraint PK_WF_PAR_VAR_PROCESO primary key (rv_id_programa, rv_secuencia, rv_codigo_variable, rv_codigo_proceso, rv_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_parametro_programa                                 */
/*==============================================================*/
print '===> Creando wf_parametro_programa'
create table wf_parametro_programa (
     pp_id_programa       int                            not null,
     pp_secuencia         smallint                       not null,
     pp_nombre_parametro  NOMBRE                         not null,
     pp_desc_parametro    varchar(30)                    null,
     pp_tipo_datos        varchar(10)                    not null
           constraint parametro_programa_c1 check (pp_tipo_datos in ('INT', 'FLT', 'CHR', 'VCH')),
     pp_tipo_parametro    varchar(10)                    not null
           constraint parametro_programa_c2 check (pp_tipo_parametro in ('ENT', 'SAL')),
     pp_es_nulo           BOOLEANO                       not null,
     constraint PK_WF_PARAMETRO_PROGRAMA primary key (pp_id_programa, pp_secuencia)
)
go

/*==============================================================*/
/* Table: wf_paso                                               */
/*==============================================================*/
print '===> Creando wf_paso'
create table wf_paso (
     pa_id_paso           				int               not null,
     pa_codigo_proceso    				smallint          not null,
     pa_version_proceso   				smallint          not null,
     pa_codigo_actividad  				smallint          null,
     pa_tipo_paso         				varchar(10)       not null
			constraint paso_c1 check (pa_tipo_paso in ('INI', 'FIN', 'ACT', 'PAR', 'CON')),
     pa_posicion_x        				float             not null,
     pa_posicion_y        				float             not null,
     pa_ancho             				float             not null,
     pa_alto              				float             not null,
			constraint PK_WF_PASO primary key (pa_id_paso),
     pa_automatico         				int               null,
	 pa_id_programa_tiempo_estandar		int				  null	
)
go

/*==============================================================*/
/* Table: wf_politica                                           */
/*==============================================================*/
print '===> Creando wf_politica'
create table wf_politica (
     po_id_politica       int                            not null,
     po_nombre_pol        NOMBRE                         not null,
     po_condicion         CONDICION                      not null,
     po_codigo_proceso    smallint                       not null,
     po_version_proceso   smallint                       not null,
     po_codigo_excepcion  smallint                       not null,
     constraint PK_WF_POLITICA primary key (po_id_politica)
)
go

/*==============================================================*/
/* Table: wf_proceso                                            */
/*==============================================================*/
print '===> Creando wf_proceso'
create table wf_proceso (
     pr_codigo_proceso       smallint                    not null,
     pr_nombre_proceso       varchar(100)                      not null,
     pr_codigo_empresa       smallint                    not null,
     pr_desc_proceso         DESCRIPCION                 null,
     pr_costo_proceso        MONTO                       not null,
     pr_tiempo_estandar      int                         not null,
     pr_tiempo_efectivo      int                         not null,
     pr_estado               varchar(10)                 not null
           constraint proceso_c1 check (pr_estado in ('ACT', 'SUS', 'INA')),
     pr_es_plantilla         BOOLEANO                    not null,
     pr_es_subproceso        BOOLEANO                    not null,
     pr_version_prd          smallint                    not null,
     pr_producto             varchar(3)                  not null,
	 pr_notificacion         varchar(1)   				 null,
     pr_sms                  varchar(1)   				 null,
     pr_email                varchar(1)   				 null,
     pr_console              varchar(1)    				 null,
     pr_modo_regreso         varchar(1)    				 null,
	 pr_programa_cancelacion int 						 null,
	 pr_programa_validacion  int                         null,
	 pr_nemonico			 varchar(10)                 null,
	 pr_tipo_email       	 varchar(1)                  null,
	 pr_mensaje_email      	 int                         null,
     constraint PK_WF_PROCESO primary key (pr_codigo_proceso)
)
go

/*==============================================================*/
/* Table: wf_r_actividades_proc                                 */
/*==============================================================*/
print '===> Creando wf_r_actividades_proc'
create table wf_r_actividades_proc (
     da_codigo_proceso    smallint                       not null,
     da_version_proceso   smallint                       not null,
     da_codigo_actividad  smallint                       not null,
     da_fecha             char(8)                        not null,
     da_num_a_tiempo      int                            not null,
     da_num_retrasadas    int                            not null,
     da_tiempo_real       int                            not null,
     da_tiempo_estandar   int                            not null,
     da_tiempo_max        int                            null,
	 da_oficina           int                            not null,
     constraint PK_WF_R_ACTIVIDADES_PROC primary key (da_codigo_proceso, da_version_proceso, da_codigo_actividad, da_fecha,da_oficina)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_r_asignacion_act                                   */
/*==============================================================*/
print '===> Creando wf_r_asignacion_act'
create table wf_r_asignacion_act (
     du_codigo_proceso    smallint                       not null,
     du_version_proceso   smallint                       not null,
     du_codigo_actividad  smallint                       not null,
     du_id_usuario        int                            not null,
     du_id_rol            int                            null,
     du_fecha             char(8)                        not null,
     du_num_a_tiempo      int                            not null,
     du_num_retrasada     int                            not null,
     du_tiempo_real       int                            not null,
     du_tiempo_estandar   int                            not null,
	 du_tiempo_max        int      				         null,
	 du_oficina	          int      				         not null,
)
go

CREATE  CLUSTERED INDEX PK_WF_R_ASIGNACION_ACT
    ON dbo.wf_r_asignacion_act
(du_codigo_proceso, du_version_proceso, du_codigo_actividad, du_id_usuario, du_id_rol,du_fecha,du_oficina)
GO

/*==============================================================*/
/* Table: wf_r_proceso                                          */
/*==============================================================*/
print '===> Creando wf_r_proceso'
create table wf_r_proceso (
     rr_codigo_proceso    smallint                       not null,
     rr_version_proceso   smallint                       not null,
     rr_fecha             char(8)                        not null,
     rr_num_a_tiempo      int                            not null,
     rr_num_retrasados    int                            not null,
     rr_tiempo_real       int                            not null,
     rr_tiempo_estandar   int                            not null,
     rr_tiempo_max        int                            null,
	 rr_oficina	          int                            not null,
     constraint PK_WF_R_PROCESO primary key (rr_codigo_proceso, rr_version_proceso, rr_fecha, rr_oficina)
)
go

/*==============================================================*/
/* Table: wf_receptor                                           */
/*==============================================================*/
print '===> Creando wf_receptor'
create table wf_receptor (
     re_id_paso           int                            not null,
     re_num_receptor      int                            not null,
     re_codigo_proceso    smallint                       not null,
     re_version_proceso   smallint                       not null,
     re_tipo_receptor     varchar(10)                    not null
           constraint CKC_RE_TIPO_RECEPTOR_WF_RECEP check (re_tipo_receptor in ('USR', 'PRO', 'CLI', 'FUN')),
     re_id_destinatario   int                            not null,
     constraint PK_WF_RECEPTOR primary key (re_id_paso, re_num_receptor)
)
go

/*==============================================================*/
/* Table: wf_requisito_actividad                                */
/*==============================================================*/
print '===> Creando wf_requisito_actividad'
create table wf_requisito_actividad (
     rc_codigo_tipo_doc   smallint                       not null,
     rc_id_paso           int                            not null,
     rc_id_inst_proceso   int                            not null,
     rc_inst_actividad    int                            not null,
     rc_id_asig_act       int                            not null,
     rc_texto             varchar(255)                   not null,
     rc_terminado         tinyint                        not null,
     rc_cliente_proc      int                            null,
	 rc_excepcionable     bit                            default 0,
     constraint PK_WF_REQUISITO_ACTIVIDAD primary key (rc_codigo_tipo_doc, rc_id_paso, rc_id_inst_proceso, rc_inst_actividad, rc_id_asig_act)
)
go

/*==============================================================*/
/* Table: wf_res_atr_usu_rol                                    */
/*==============================================================*/
print '===> Creando wf_res_atr_usu_rol'
create table wf_res_atr_usu_rol (
     ru_id_asig_act       int                            not null,
     ru_codigo_resultado  smallint                       not null,
     ru_nombre_resultado  NOMBRE                         not null,
     constraint PK_WF_RES_ATR_USU_ROL primary key (ru_id_asig_act, ru_codigo_resultado)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_resultado                                          */
/*==============================================================*/
print '===> Creando wf_resultado'
create table wf_resultado (
     rs_codigo_resultado  smallint                       not null,
     rs_nombre_resultado  NOMBRE                         not null,
	 rs_evalua_politica   char(1)						 null,
     constraint PK_WF_RESULTADO primary key (rs_codigo_resultado)
)
go

/*==============================================================*/
/* Table: wf_resultado_actividad                                */
/*==============================================================*/
print '===> Creando wf_resultado_actividad'
create table wf_resultado_actividad (
     ra_codigo_resultado  smallint                       not null,
     ra_id_paso           int                            not null,
     ra_codigo_proceso    smallint                       not null,
     ra_version_proceso   smallint                       not null,
     constraint PK_WF_RESULTADO_ACTIVIDAD primary key (ra_codigo_resultado, ra_id_paso, ra_codigo_proceso, ra_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_rol                                                */
/*==============================================================*/
print '===> Creando wf_rol'
create table wf_rol (
     ro_id_rol              int                            not null,
     ro_nombre_rol          NOMBRE                         not null,
     ro_codigo_empresa      smallint                       not null,
     ro_es_comite           BOOLEANO                       not null,
     ro_id_usuario_cabecera int                            null,
     ro_interviene          BOOLEANO                       not null,
     ro_orden               smallint                       null,
     constraint PK_WF_ROL primary key (ro_id_rol)
)
go

/*==============================================================*/
/* Table: wf_rol_jerarquia                                      */
/*==============================================================*/
print '===> Creando wf_rol_jerarquia'
create table wf_rol_jerarquia (
     rj_id_jerarquia      smallint                       not null,
     rj_id_rol            int                            not null,
     rj_codigo_proceso    smallint                       not null,
     rj_version_proceso   smallint                       not null,
     rj_pos_x             float                          not null,
     rj_pos_y             float                          not null,
     rj_asigna_manual     tinyint                        not null,
     constraint PK_WF_ROL_JERARQUIA primary key (rj_id_jerarquia, rj_id_rol)
)
go

/*==============================================================*/
/* Table: wf_tipo_documento                                     */
/*==============================================================*/
print '===> Creando wf_tipo_documento'
create table wf_tipo_documento (
     td_codigo_tipo_doc   smallint                       not null,
     td_nombre_tipo_doc   DESCRIPCION                    not null,
	 td_tipo_doc          varchar(1)                     null,
	 td_vigencia_doc      varchar(1)                     null,
	 td_categoria_doc     varchar(10)                     null,
     constraint PK_WF_TIPO_DOCUMENTO primary key (td_codigo_tipo_doc)
)
go

/*==============================================================*/
/* Table: wf_tipo_req_act                                       */
/*==============================================================*/
print '===> Creando wf_tipo_req_act'
create table wf_tipo_req_act (
     tr_codigo_tipo_doc   smallint                       not null,
     tr_id_paso           int                            not null,
     tr_texto             DESCRIPCION                    not null,
     tr_es_mandatorio     bit                            not null,
	 tr_referencia        varchar(20)                    null,
	 tr_id_regla          int                            default 0,
	 tr_desc_regla        varchar(100)                    null,
	 tr_excepcionable     bit                            not null, 
     constraint PK_WF_TIPO_REQ_ACT primary key (tr_codigo_tipo_doc, tr_id_paso)
)
go

/*==============================================================*/
/* Table: wf_tmp_aprobacion                                     */
/*==============================================================*/
print '===> Creando wf_tmp_aprobacion'
create table wf_tmp_aprobacion (
     ap_id_inst_proceso   int                            not null,
     ap_id_asig_actividad int                            not null,
     ap_tipo              varchar(10)                    not null
           constraint tmp_aprobacion_c1 check (ap_tipo in ('INS', 'EXC')),
     ap_identificador     int                            not null,
     ap_nombre            NOMBRE                         not null,
     ap_estado            varchar(10)                    not null
           constraint tmp_aprobacion_c2 check (ap_estado in ('INI', 'APR', 'REC')),
     ap_id_aprob          int                            null,
     ap_rol_aprob         int                            null,
     ap_fecha_aprob       datetime                       null,
     ap_texto             DESCRIPCION                    null,
     constraint PK_WF_TMP_APROBACION primary key (ap_id_inst_proceso, ap_id_asig_actividad, ap_tipo, ap_identificador)
)
go

/*==============================================================*/
/* Table: wf_tmp_lineas                                         */
/*==============================================================*/
print '===> Creando wf_tmp_lineas'
create table wf_tmp_lineas (
     tl_id_asig_act       int                            not null,
     tl_sesion            int                            not null,
     tl_observacion       smallint                       not null,
     tl_linea             int                            not null,
     tl_texto             CONDICION                      not null
)
go

/*==============================================================*/
/* Table: wf_usuario                                            */
/*==============================================================*/
print '===> Creando wf_usuario'
create table wf_usuario (
     us_id_usuario        int                            not null,
     us_login             NOMBRE                         not null,
     us_codigo_empresa    smallint                       not null,
     us_estado_usuario    varchar(10)                    not null
           constraint usuario_c1 check (us_estado_usuario in ('ACT', 'INA', 'ELI')),
     us_fecha_creacion_usr datetime                       not null,
     us_id_usuario_sustituto int                            null,
     us_oficina           smallint                       not null,
     us_tiempo_asignado   int                            not null,
     us_num_act_asignadas int                            not null,
     constraint PK_WF_USUARIO primary key (us_id_usuario)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_usuario_rol                                        */
/*==============================================================*/
print '===> Creando wf_usuario_rol'
create table wf_usuario_rol (
     ur_id_usuario        int                            not null,
     ur_id_rol            int                            not null,
     ur_estado_login      varchar(10)                    not null
           constraint usuario_rol_c1 check (ur_estado_login in ('LIN', 'LOU', 'PAU')),
     ur_id_usuario_sustituto int                            null,
     constraint PK_WF_USUARIO_ROL primary key (ur_id_usuario, ur_id_rol)
)
go

/*==============================================================*/
/* Table: wf_variable                                           */
/*==============================================================*/
print '===> Creando wf_variable'
create table wf_variable (
     vb_codigo_variable             smallint                       not null,
     vb_nombre_variable             varchar(45)                    not null,
	 vb_abrev_variable              char(10)                       not null,
     vb_desc_variable               DESCRIPCION                    null,
     vb_tipo_datos                  varchar(10)                    not null
        constraint variable_c1 check (vb_tipo_datos in ('INT', 'FLT', 'CHR', 'VCH')),
     vb_val_variable                VALOR_VARIABLE                 null,
     vb_id_programa                 int            				   null,
     vb_type                        char(10)       				   null,
     vb_subType                     char(10)       				   null,
	 vb_catalogo                    varchar(100)                   null,
	 vb_expresion_validacion        varchar(255)                   null, 
	 vb_seudo_catalogo              int              			   null,
	 vb_value_min        			varchar(20)                    null,
	 vb_value_operator        		varchar(20)                    null,
	 vb_value_max        			varchar(20)                    null,
     constraint PK_WF_VARIABLE primary key (vb_codigo_variable)
)
go

/* Unique index para el nombre del programa */
create unique index variable_nombre_index
     on wf_variable (vb_nombre_variable) 
go

/* Unique index para el abreviatura del programa */
create unique index variable_abrev_index
     on wf_variable (vb_abrev_variable) 
go

/*==============================================================*/
/* Table: wf_variable_actual                                    */
/*==============================================================*/
print '===> Creando wf_variable_actual'
create table wf_variable_actual (
     va_id_inst_proc      int                            not null,
     va_codigo_var        smallint                       not null,
     va_valor_actual      VALOR_VARIABLE                 null,
     constraint PK_WF_VARIABLE_ACTUAL primary key (va_id_inst_proc, va_codigo_var)
)
lock datarows
go

/*==============================================================*/
/* Table: wf_variable_proceso                                   */
/*==============================================================*/
print '===> Creando wf_variable_proceso'
create table wf_variable_proceso (
     vr_codigo_variable   smallint                       not null,
     vr_codigo_proceso    smallint                       not null,
     vr_version_proceso   smallint                       not null,
     vr_id_programa       int                            null,
     vr_valor_inicial     VALOR_VARIABLE                 null,
     vr_guardar_log       BOOLEANO                       not null,
     constraint PK_WF_VARIABLE_PROCESO primary key (vr_codigo_variable, vr_codigo_proceso, vr_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_version_proceso                                    */
/*==============================================================*/
print '===> Creando wf_version_proceso'
create table wf_version_proceso (
     vp_codigo_proceso    smallint                       not null,
     vp_version_proceso   smallint                       not null,
     vp_fecha_creacion    datetime                       not null,
     vp_fecha_activacion  datetime                       null,
     vp_info_historica    tinyint                        not null,
     vp_estado            varchar(10)                    not null
           constraint version_proceso_c1 check (vp_estado in ('CON', 'ANT', 'PRD', 'ELI')),
     constraint PK_WF_VERSION_PROCESO primary key (vp_codigo_proceso, vp_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_voto_comite                                        */
/*==============================================================*/
print '===> Creando wf_voto_comite'
create table wf_voto_comite (
     vc_id_inst_proc      int                            not null,
     vc_id_usuario        int                            not null,
     vc_id_inst_act       int                            not null,
     vc_tramite           int                            not null,
     vc_asig_actividad    int                            not null,
     vc_id_rol            int                            not null,
     vc_fecha             datetime                       not null,
     vc_voto              char(1)                        null
           constraint CKC_VC_VOTO_WF_VOTO_ check (vc_voto is null or ( vc_voto in ('A', 'Z') )),
     constraint PK_WF_VOTO_COMITE primary key (vc_id_inst_proc, vc_id_usuario,vc_asig_actividad)
)
go

/*==============================================================*/
/* Table: wf_documento                                          */
/*==============================================================*/
print '===> Creando wf_documento'
create table wf_documento (
     dm_codigo_doc        smallint                       not null,
     dm_nombre_doc        NOMBRE                         not null,
     dm_plantilla         varchar(20)                    null,
     dm_producto          varchar(3)                     not null,
     constraint PK_WF_DOCUMENTO primary key (dm_codigo_doc)
)
go

/*==============================================================*/
/* Table: wf_documento_proc                                     */
/*==============================================================*/
print '===> Creando wf_documento_proc'
create table wf_documento_proc (
     dp_codigo_doc        smallint                       not null,
     dp_codigo_proceso    smallint                       not null,
     dp_version_proceso   smallint                       not null,
     dp_orden             smallint                       not null,
     constraint PK_WF_DOCUMENTO_PROC primary key (dp_codigo_doc, dp_codigo_proceso, dp_version_proceso)
)
go

/*==============================================================*/
/* Table: wf_doc_inst_proc                                      */
/*==============================================================*/
print '===> Creando wf_doc_inst_proc'
create table wf_doc_inst_proc (
     di_codigo_doc        smallint                       not null,
     di_codigo_proceso    smallint                       not null,
     di_version_proceso   smallint                       not null,
     di_id_inst_proceso   smallint                       not null,
     di_id_cliente        int                       not null,
     di_doc_cab_id        varchar(13)                    null,
     constraint PK_WF_DOC_INST_PROC primary key (di_codigo_doc, di_codigo_proceso, di_version_proceso, di_id_inst_proceso, di_id_cliente)
)
go

/*==============================================================*/
/* Table: wf_nivel_aprobacion                                   */
/*==============================================================*/
print '===> Creando wf_nivel_aprobacion'
create table wf_nivel_aprobacion (
     na_id_inst_proc    int                not null,
     na_id_rol          int                not null,
     na_interviene      BOOLEANO           not null,
     na_orden           smallint           not null,
     na_modifica        BOOLEANO           not null,
constraint PK_WF_NIVEL_APROBACION primary key (na_id_inst_proc, na_id_rol)
)
go

/*==============================================================*/
/* Table: wf_notificaciones_despacho                            */
/*==============================================================*/
print '===> Creando wf_notificaciones_despacho'
create table wf_notificaciones_despacho (
	nd_id           int                        not null,
	nd_servicio     tinyint                    not null,
	nd_ente         int                        not null,
	nd_tipo         varchar(10)                not null,
	nd_tipo_mensaje char(1)                    not null,
	nd_prioridad    tinyint                    not null,
	nd_num_dir      varchar(64)                not null,
	nd_estado       char(1)                    not null,
	nd_num_err      int                        not null,
	nd_txt_err      varchar(64)                not null,
	nd_ret_status   int                        not null,
	nd_fecha_reg    datetime                   not null,
	nd_fecha_mod    datetime                   not null,
	nd_fecha_auto   datetime                   not null,
	nd_var1         varchar(64)                null,
	nd_var2         varchar(64)                null,
	nd_var3         varchar(64)                null,
	nd_var4         varchar(255)               null,
	nd_var5         varchar(255)               null,
	nd_var6         varchar(255)               null,
	constraint PK_WF_PROCESO primary key (nd_id)
)
go

/*** CREACION DE TABLAS HISTORICAS DE WORK FLOW  ****/

/*==============================================================*/
/* Table: wf_inst_proceso_his                                   */
/*==============================================================*/
print '===> Creando wf_inst_proceso_his'
create table wf_inst_proceso_his
       (io_id_inst_proc                int             not null,
        io_codigo_proc                 smallint        not null,
        io_version_proc                smallint        not null,
        io_estado                      varchar(10)     not null,
        io_fecha_crea                  datetime        not null,
        io_fecha_act                   datetime        null,
        io_fecha_fin                   datetime        null,
        io_id_inst_act_padre           int             null,
        io_retrasado                   BOOLEANO        not null,
        io_oficina_inicio              smallint        not null,
        io_oficina_entrega             smallint        not null,
        io_comentario                  DESCRIPCION     null,
        io_campo_1                     int             null,
        io_campo_2                     VALOR_VARIABLE  null,
        io_campo_3                     int             null
)
go

/*==============================================================*/
/* Table: wf_inst_actividad_his                                 */
/*==============================================================*/
print '===> Creando wf_inst_actividad_his'
create table wf_inst_actividad_his
       (ia_id_inst_act                 int           not null,
        ia_id_inst_proc                int           not null,
        ia_codigo_act                  smallint      not null,
        ia_nombre_act                  NOMBRE        not null,
        ia_func_asociada               varchar(30)   null,
        ia_secuencia                   smallint      null,
        ia_estado                      varchar(10)   not null,
        ia_fecha_inicio                datetime      not null,
        ia_fecha_fin                   datetime      null,
        ia_id_paso                     int           not null,
        ia_retrasada                   BOOLEANO      null,
        ia_mensaje                     DESCRIPCION   null,
        ia_tipo_dest                   varchar(10)   null,
        ia_id_destinatario             int           null
)
go

/*==============================================================*/
/* Table: wf_asig_man_mult_his                                  */
/*==============================================================*/
print '===> Creando wf_asig_man_mult_his'
create table wf_asig_man_mult_his
       (mm_id_inst_proc                int           not null,
        mm_id_inst_act                 int           not null,
        mm_id_usuario                  int           not null,
        mm_id_rol                      int           not null,
        mm_cod_actividad               smallint      not null,
        mm_id_paso                     int           not null
)
go


/*==============================================================*/
/* Table: wf_exc_inst_proc_his                                  */
/*==============================================================*/
print '===> Creando wf_exc_inst_proc_his'
create table wf_exc_inst_proc_his
      (ei_id_exc_inst_proc            int           not null,
       ei_id_inst_proc                int           not null,
       ei_codigo_exc                  smallint      not null,
       ei_id_asig_act                 int           null,
       ei_texto_exc                   varchar(255)  null,
       ei_estado                      varchar(10)   not null,
       ei_id_aprob                    int           null,
       ei_rol_aprob                   int           null,
       ei_fecha_aprob                 datetime      null,
       ei_id_regula                   int           null,
       ei_tiempo_regula               smallint      null,
       ei_fecha_regula                datetime      null
)
go

/*==============================================================*/
/* Table: wf_ins_inst_proc_his                                  */
/*==============================================================*/
print '===> Creando wf_ins_inst_proc_his'
create table wf_ins_inst_proc_his
       (ii_id_ins_inst_proc            int          not null,
        ii_id_inst_proc                int          not null,
        ii_codigo_ins                  smallint     not null,
        ii_id_asig_act                 int          null,
        ii_texto_inst                  varchar(255) null,
        ii_estado                      varchar(10)  not null,
        ii_id_aprob                    int          null,
        ii_rol_aprob                   int          null,
        ii_fecha_aprob                 datetime     null,
        ii_id_ejecuta                  varchar(14)  null,
        ii_tiempo_ejecu                int          null,
        ii_fecha_ejecucion             datetime     null
)
go

/*==============================================================*/
/* Table: wf_mod_variable_his                                   */
/*==============================================================*/
print '===> Creando wf_mod_variable_his'
create table wf_mod_variable_his
       (mv_id_inst_proc                int                 not null,
        mv_codigo_var                  smallint            not null,
        mv_id_asig_act                 int                 not null,
        mv_valor_anterior              VALOR_VARIABLE      null,
        mv_valor_nuevo                 VALOR_VARIABLE      null,
        mv_fecha_mod                   datetime            not null
)
go

/*==============================================================*/
/* Table: wf_wf_asig_man_mult_his                               */
/*==============================================================*/
print '===> Creando wf_wf_asig_man_mult_his'
create table wf_wf_asig_man_mult_his
       (mm_id_inst_proc                int         not null,
        mm_id_inst_act                 int         not null,
        mm_id_usuario                  int         not null,
        mm_id_rol                      int         not null,
        mm_cod_actividad               smallint    not null,
        mm_id_paso                     int         not null
)
go


/*==============================================================*/
/* Table: wfvariable_actual_his                                 */
/*==============================================================*/
print '===> Creando wf_variable_actual_his'
create table wf_variable_actual_his
       (va_id_inst_proc int                   not null,
        va_codigo_var   smallint              not null,
        va_valor_actual varchar(255)          null
)
go

/*==============================================================*/
/* Table: wf_observaciones_his                                  */
/*==============================================================*/
print '===> Creando wf_observaciones_his'
create table wf_observaciones_his(
       ob_id_asig_act  int             not null,
       ob_numero       smallint        not null,
       ob_fecha        datetime        not null,
       ob_categoria    varchar(10)     null,
       ob_lineas       smallint        not null,
       ob_oficial      char(1)         not null
)
go

/*==============================================================*/
/* Table: wf_ob_lineas_his                                      */
/*==============================================================*/
print '===> Creando wf_ob_lineas_his'
create table wf_ob_lineas_his(
       ol_id_asig_act  int             not null,
       ol_observacion  smallint        not null,
       ol_linea        int             not null,
       ol_texto        CONDICION       not null
)
go

/*==============================================================*/
/* Table: wf_r_actividades_proc_his                             */
/*==============================================================*/
print '===> Creando wf_r_actividades_proc_his'
create table wf_r_actividades_proc_his(
       da_codigo_proceso              smallint      not null,
       da_version_proceso             smallint      not null,
       da_codigo_actividad            smallint      not null,
       da_fecha                       char(8)       not null,
       da_num_a_tiempo                int           not null,
       da_num_retrasadas              int           not null,
       da_tiempo_real                 int           not null,
       da_tiempo_estandar             int           not null
)
go

/*==============================================================*/
/* Table: wf_r_asignacion_act_his                               */
/*==============================================================*/
print '===> Creando wf_r_asignacion_act_his'
create table wf_r_asignacion_act_his(
       du_codigo_proceso              smallint        not null,
       du_version_proceso             smallint        not null,
       du_codigo_actividad            smallint        not null,
       du_id_usuario                  int             not null,
       du_id_rol                      int             not null,
       du_fecha                       char(8)         not null,
       du_num_a_tiempo                int             not null,
       du_num_retrasada               int             not null,
       du_tiempo_real                 int             not null,
       du_tiempo_estandar             int             not null,
	   du_tiempo_max                  int             not null
)
go

/*==============================================================*/
/* Table: wf_r_proceso_his                                      */
/*==============================================================*/
print '===> Creando wf_r_proceso_his'
create table wf_r_proceso_his (
       rr_codigo_proceso              smallint        not null,
       rr_version_proceso             smallint        not null,
       rr_fecha                       char(8)         not null,
       rr_num_a_tiempo                int             not null,
       rr_num_retrasados              int             not null,
       rr_tiempo_real                 int             not null,
       rr_tiempo_estandar             int             not null
)
go

/*==============================================================*/
/* Table: wf_cliente_proceso                                    */
/*==============================================================*/
print '===> Creando wf_cliente_proceso'
create table wf_cliente_proceso (
     cp_id_inst_proc      int                         not null,
     cp_id_cliente        int                             null,
     cp_nombre_cliente    varchar(254)                    null

)
go

/*DAL 25/Jul/05*/
/*==============================================================*/
/* Table: wf_cliente_proceso_his                      */
/*==============================================================*/
print '===> Creando wf_cliente_proceso_his'
create table wf_cliente_proceso_his (
      cp_id_inst_proc     int                         not null,
      cp_id_cliente       int                         not null,
      cp_nombre_cliente   varchar(254)                not null
)
go

/*==============================================================*/
/* Table: wf_notification_templates                             */
/*==============================================================*/
print '===> Creando wf_notification_templates'
create table wf_notification_templates
(
	   nt_id              int                          not null,
	   nt_nombre          varchar(200)                 not null,
       nt_asunto          varchar(200)                 not null,
       nt_sms             varchar(255)                 not null,
       nt_email           varchar(255)                 not null,
       nt_template_id     int                          not null,
       nt_culture         varchar(10)                  not null,
       constraint PK_BV_NOTIFICATION_TEMPLATES
       primary key CLUSTERED (nt_id)
)
go

/*==============================================================*/
/* Table: wf_resumen_actividad                                  */
/*==============================================================*/
print '===> Creando wf_resumen_actividad'
create table wf_resumen_actividad
(
	ra_ssn                  int                          not null,
	ra_destinatario_id      int                          not null,
	ra_num_actividades      int                          not null,
	ra_tiempo_actividades   int                          not null,

)
go

/*==============================================================*/
/* Table: wf_requisito_actividad_tmp                            */
/*==============================================================*/
print '===> Creando wf_requisito_actividad_tmp'
create table wf_requisito_actividad_tmp (
     rc_codigo_tipo_doc   smallint                       not null,
     rc_id_paso           int                            not null,
     rc_id_inst_proceso   int                            not null,
     rc_inst_actividad    int                            not null,
     rc_id_asig_act       int                            not null,
     rc_texto             varchar(255)                   not null,
     rc_terminado         tinyint                        not null,
     rc_cliente_proc      int                            null,
	 rc_excepcionable     bit                            default 0,
     constraint PK_WF_REQUISITO_ACTIVIDAD_TMP primary key (rc_codigo_tipo_doc, rc_id_paso, rc_id_inst_proceso, rc_inst_actividad, rc_id_asig_act)
)
go

/*==============================================================*/
/* Table: wf_observacion_actividad                              */
/*==============================================================*/
print '===> Creando wf_observacion_actividad'
CREATE TABLE wf_observacion_actividad  
(
    oa_id_paso	            int                          not null,
	oa_codigo_observacion  	char(10)                     not null,
	CONSTRAINT PK_WF_OBSERVACION_ACTIVIDAD 
	PRIMARY KEY CLUSTERED(oa_id_paso, oa_codigo_observacion)
)
go

/*==============================================================*/
/* Table: wf_observaciones_temp                                 */
/*==============================================================*/
print '===> Creando wf_observaciones_temp'
CREATE TABLE wf_observaciones_temp
(
    ob_id_asig_act          int                           not null,
    ob_numero               smallint                      not null,
    ob_fecha                datetime                      not null,
    ob_categoria            varchar(10)                   null,
    ob_lineas               smallint                      not null,
    ob_oficial              char(1)                       not null,
    ob_ejecutivo            LOGIN                         null,
    CONSTRAINT PK_WF_OBSERVACIONES
    PRIMARY KEY CLUSTERED (ob_id_asig_act,ob_numero)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_req_inst                                           */
/*==============================================================*/
print '===> Creando wf_req_inst'
CREATE TABLE wf_req_inst ( 
	ri_id_inst_proc   	     int                          not null,
	ri_codigo_act     	     smallint                     not null,
	ri_codigo_tipo_doc	     smallint                     not null,
	ri_nombre_doc     	     varchar(255)                 null,
	ri_observacion     	     varchar(250)                 null,
	ri_fecha_registro     	 datetime                     null,
	ri_excepcionable         bit                          default 0
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_req_documento_temp                            			*/
/*==============================================================*/
print '===> Creando wf_req_documento_temp'
CREATE TABLE wf_req_documento_temp(
	rd_spid             smallint    NOT NULL, 
	rd_user             login       NOT NULL,
	rd_codigo_tipo_doc  smallint    NOT NULL, 
	rd_texto            descripcion NULL, 
	rd_es_mandatorio    bit,
	rd_tipo_doc         varchar(1)  NULL, 
	rd_id_regla         int         NULL, 
	rd_categoria_doc    varchar(1)  NULL,
	rd_referencia       varchar(20) NULL,
    rd_excepcionable    bit         default 0
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_ob_lineas_temp                            			*/
/*==============================================================*/
print '===> Creando wf_ob_lineas_temp'
CREATE TABLE wf_ob_lineas_temp
(
    ol_id_asig_act            int                         not null,
    ol_observacion            smallint                    not null,
    ol_linea                  int                         not null,
    ol_texto                  CONDICION                   not null,
    CONSTRAINT PK_WF_OB_LINEAS
    PRIMARY KEY CLUSTERED (ol_id_asig_act,ol_observacion,ol_linea)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_tipo_proceso                            			*/
/*==============================================================*/
print '===> Creando wf_tipo_proceso'
CREATE TABLE wf_tipo_proceso
(
    tp_codigo_proceso 	      int                         not null,
    tp_tipo_proceso 	      varchar(255)                not null,
    CONSTRAINT PK_WF_TIPO_PROCESO
    PRIMARY KEY CLUSTERED (tp_codigo_proceso,tp_tipo_proceso)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_tipo_proceso                            			*/
/*==============================================================*/
print '===> Creando wf_producto_tipo_proceso'
CREATE TABLE wf_producto_tipo_proceso
(
    pp_codigo_producto 	       varchar(16)                not null,
    pp_tipo_proceso 	       varchar(255)               not null,
    CONSTRAINT PK_WF_PRODUCTO_TIPO_PROCESO
    PRIMARY KEY CLUSTERED (pp_codigo_producto,pp_tipo_proceso)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_tipo_rol                            			    */
/*==============================================================*/
print '===> Creando wf_tipo_rol'
CREATE TABLE wf_tipo_rol
(
    tr_id_rol 	                int                       not null,
    tr_tipo_rol                 varchar(255)              not null,
    CONSTRAINT PK_WF_TIPO_ROL
    PRIMARY KEY CLUSTERED (tr_id_rol,tr_tipo_rol)
)
LOCK DATAROWS
go


/*==============================================================*/
/* Table: wf_errores_proceso                                    */
/*==============================================================*/
print '===> Creando wf_errores_proceso'
CREATE TABLE wf_errores_proceso ( 
	ep_codigo_proceso     	smallint 		not null,
	ep_version_proceso    	smallint 		not null,
	ep_codigo_error       	int 		        not null,
	ep_descripcion_error  	varchar(150) 	not null,
	ep_codigo_descripcion 	smallint 		not null,
	ep_intentos_ejecucion	int             null
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_receptor_cliente                                                                                     */
/*==============================================================*/
print '===> Creando wf_receptor_cliente'
create table wf_receptor_cliente (
     rc_cod_rec_cl                           int                 not null,
     rc_ins_proc              				 int                 not null,
     rc_proceso               				 smallint            not null,
     rc_version                				 smallint            not null,
     rc_cod_cliente          				 int                 not null,
     rc_nombre                				 varchar(255)     	 null,
     rc_telefono                			 varchar(16)     	 null,
	 rc_correo_electronico                   varchar(255)      	 null,
	 CONSTRAINT pk_rec_cli PRIMARY KEY NONCLUSTERED(rc_cod_rec_cl )
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_tipo_jerarquia_tpl                                                                                    */
/*==============================================================*/
print '===> Creando wf_tipo_jerarquia_tpl'
create table wf_tipo_jerarquia_tpl (
	tj_id_jerarquia    		INT 			NOT NULL,
	tj_nombre_jerarquia		VARCHAR(64) 	NOT NULL,	
	tj_descripcion			VARCHAR(64) 	NULL,
	tj_jerarquia_inbox		CHAR(1)         NOT NULL,
	
	CONSTRAINT PK_WF_TIPO_JERARQUIA PRIMARY KEY CLUSTERED(tj_id_jerarquia)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_nivel_jerarquia_tpl                                                                                   */
/*==============================================================*/
print '===> Creando wf_nivel_jerarquia_tpl'
create table wf_nivel_jerarquia_tpl (
	ni_id_nivel_jerarquia          	INT 				NOT NULL,
	ni_descripcion_nivel            VARCHAR(64) 		NOT NULL,
	tj_id_jerarquia    				INT 				NOT NULL,
	vb_codigo_variable 	    	    SMALLINT			NOT NULL,
	ni_orden_nivel					INT             	NOT NULL,
	
	CONSTRAINT PK_WF_NIVEL_ITEM PRIMARY KEY CLUSTERED(ni_id_nivel_jerarquia),
	CONSTRAINT FK_VARIABLE FOREIGN KEY(vb_codigo_variable)
	REFERENCES dbo.wf_variable(vb_codigo_variable), 
	CONSTRAINT FK_WF_TIPO_JER FOREIGN KEY(tj_id_jerarquia)
	REFERENCES dbo.wf_tipo_jerarquia_tpl(tj_id_jerarquia)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_item_jerarquia_tpl                                 */
/*==============================================================*/
print '===> Creando wf_item_jerarquia_tpl'
create table wf_item_jerarquia_tpl (
	ij_id_item_jerarquia		INT 				NOT NULL,
	ij_descripcion_item_jer  	VARCHAR(64) 		NOT NULL,	
	tj_id_jerarquia    			INT 				NOT NULL,
	ni_id_nivel_jerarquia		INT 				NOT NULL,
	ij_id_valor_nivel_item 		VARCHAR(255) 		NOT NULL,
	ij_id_item_padre    		INT 				NULL,
	ij_id_catalogo_nivel_item   varchar(10)         NULL,
	ij_condiciones              varchar(256)        NULL,
	
    CONSTRAINT PK_WF_ITEM_JER PRIMARY KEY CLUSTERED (ij_id_item_jerarquia),
	CONSTRAINT FK_WF_TIPO_JER_TPL FOREIGN KEY(tj_id_jerarquia)
	REFERENCES dbo.wf_tipo_jerarquia_tpl(tj_id_jerarquia),
	CONSTRAINT FK_WF_NIVEL_ITEM_JERARQUIA FOREIGN KEY(ni_id_nivel_jerarquia)
	REFERENCES dbo.wf_nivel_jerarquia_tpl(ni_id_nivel_jerarquia)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_usuario_jerarquia_tpl                              */
/*==============================================================*/
print '===> Creando wf_usuario_jerarquia_tpl'
create table wf_usuario_jerarquia_tpl (
	uj_id_usuario_jerarquia       INT    	NOT NULL,
	us_id_usuario                 INT 		NOT NULL,
	uj_id_usuario_padre	          INT 		NULL,
	ij_id_item_jerarquia       	  INT 		NOT NULL,
	
	CONSTRAINT PK_USUARIO_JERARQUIA_TPL
	PRIMARY KEY NONCLUSTERED (uj_id_usuario_jerarquia),
	CONSTRAINT FK_USUARIO FOREIGN KEY(us_id_usuario)
	REFERENCES dbo.wf_usuario(us_id_usuario), 
	CONSTRAINT FK_TIPO_JER_USUARIO FOREIGN KEY(ij_id_item_jerarquia)
	REFERENCES dbo.wf_item_jerarquia_tpl(ij_id_item_jerarquia)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_item_jerarquia                                     */
/*==============================================================*/
print '===> Creando wf_item_jerarquia '
create table wf_item_jerarquia (
	ij_id_item_jerarquia		INT 					NOT NULL,
	pa_id_paso	    			INT 					NOT NULL,
	ij_condiciones			  	VARCHAR(255) 			NULL,	
	
	CONSTRAINT FK_WF_JERARQUIA_ITEM FOREIGN KEY(ij_id_item_jerarquia)
	REFERENCES dbo.wf_item_jerarquia_tpl(ij_id_item_jerarquia),
	CONSTRAINT FK_WF_JERARQUIA_PASO FOREIGN KEY(pa_id_paso)
	REFERENCES dbo.wf_paso(pa_id_paso)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_paso_pol                                           */
/*==============================================================*/
print '===> Creando wf_paso_pol'
create table wf_paso_pol( 
	pa_id_paso	    INT				NOT NULL,
    rl_id           INT				NOT NULL,
	
	CONSTRAINT FK_WF_PASO_POL FOREIGN KEY(pa_id_paso)
	REFERENCES dbo.wf_paso(pa_id_paso)
)
LOCK DATAROWS
go

if not exists(select 1 from sysindexes where name = 'wf_paso_pol_index')
	create clustered index wf_paso_pol_index on wf_paso_pol(pa_id_paso, rl_id)
go

/*==============================================================*/
/* Table: wf_jer_user_TEMP                                       												  */
/*==============================================================*/
print '===> Creando wf_jer_user_TEMP'
create table wf_jer_user_TEMP (
     jer_user_temp            	int                        not null,
     ssn             					int                        null
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_item_tmp                                           */
/*==============================================================*/
print '===> Creando wf_item_tmp'
create table wf_item_tmp(
	ssn           int , 
	id_item_nivel int
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_scheduler_task                                       												  */
/*==============================================================*/
print '===> Creando wf_scheduler_task'
CREATE TABLE wf_scheduler_task  ( 
	st_id_scheduler_task	int NOT NULL,
	st_id_asig_act      	int NOT NULL,
	st_id_inst_act      	int NOT NULL,
	st_asunto           	varchar(100) NOT NULL,
	st_ubicacion        	varchar(100) NOT NULL,
	st_fecha_ini        	datetime NULL,
	st_fecha_fin        	datetime NULL,
	st_hora_ini         	smalldatetime NULL,
	st_hora_fin         	smalldatetime NULL,
	st_duracion         	int NULL,
	st_recordatorio     	varchar(10)  NULL,
	st_mensaje          	varchar(255) NULL,
	st_tipo_resultado   	varchar(30)  NULL,
	st_resultado        	varchar(10)  NULL,
	st_comentario       	varchar(255) NULL,
	st_fecha_resultado  	datetime NULL,
	st_estado           	varchar(10)  NULL 
	)
LOCK DATAROWS
GO

/*==============================================================*/
/* Table: wf_errores_proceso                                    */
/*==============================================================*/
print '===> Creando wf_bloqueo_inst_proceso'
CREATE TABLE wf_bloqueo_inst_proceso
 ( 
	id_inst_proceso	    	smallint 		not null,
	fecha			        datetime        not null,
    fecha_sistema       	datetime        not null,
	usuario					varchar(30)		not null,
	ep_intentos_ejecucion   int 			null
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_detalle_desviacion_ind                             */
/*==============================================================*/
print '===> Creando wf_detalle_desviacion_ind'
create table wf_detalle_desviacion_ind(
dd_id                  int identity,
dd_codigo_proceso      int,
dd_nombre_proceso      varchar(30),
dd_codigo_actividad    int,
dd_nombre_actividad    varchar(30),
dd_id_destinatario     int, 
dd_login               login,
dd_nombre_destinatario varchar (64),
dd_tiempo_estandar     int,
dd_tiempo_efectivo     int,
dd_margen_tolerancia   float,
dd_tiempo_tolerancia   float, 
dd_tiempo_ejecucion    float,
CONSTRAINT PK_WF_DET_DESVIACION_IND
PRIMARY KEY CLUSTERED (dd_id)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_usuario_email                                      */
/*==============================================================*/
print '===> Creando wf_usuario_email'
create table wf_usuario_email (
ue_id          int identity , 
ue_id_usuario  int not null, 
ue_login       login not null , 
ue_nombre_func varchar(64), 
ue_email       varchar(64),
CONSTRAINT PK_WF_USUARIO_EMAIL
PRIMARY KEY CLUSTERED (ue_id)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: wf_cseqnos_proceso                                      */
/*==============================================================*/
print '===> Creando wf_cseqnos_proceso'
create table wf_cseqnos_proceso (
sp_codigo_proceso	smallint		NOT NULL,
sp_anio           	int				NOT NULL,
sp_siguiente		int				NOT NULL,
sp_oficina			int				NOT NULL,
CONSTRAINT FK_WF_CSEQNOS_PROCESO    FOREIGN KEY(sp_codigo_proceso)
REFERENCES dbo.wf_proceso(pr_codigo_proceso)
)
LOCK DATAROWS
go

/*==============================================================*/
/* Table: carga                                      */
/*==============================================================*/
CREATE TABLE dbo.carga  ( 
	sesion  	int NOT NULL,
	usuario 	login NOT NULL,
	estacion	int NULL,
	carga   	int NULL,
	comite  	tinyint NULL 
)
LOCK ALLPAGES
GO

/*==============================================================*/
/* Table: wf_escalar_user_TEMP                                  */
/*==============================================================*/

CREATE TABLE wf_escalar_user_TEMP ( 
    eut_spid         int    NOT NULL,
    eut_id         	 int    NOT NULL,
    eut_login     	 NOMBRE NOT NULL,
    eut_nombre       DESCRIPCION NOT NULL,
    eut_rol	         NOMBRE NULL,
)
LOCK DATAROWS
GO

/*==============================================================*/
/* Table: wf_paso_variable                                      */
/*==============================================================*/

create table wf_paso_variable(
	pv_id_paso          int not null,
	pv_codigo_variable  int not null, 
)
lock datarows
go

/*==============================================================*/
/* Table: wf_paso_variable_TMP                                  */
/*==============================================================*/

create table wf_paso_variable_TMP(
	pvt_spid             int not null,
	pvt_id_paso          int not null,
	pvt_codigo_variable  int not null, 
)
lock datarows
go

/*==============================================================*/
/* Table: wf_pasos_anteriores_tmp                               */
/*==============================================================*/
IF OBJECT_ID ('dbo.wf_pasos_anteriores_tmp') IS NOT NULL
	DROP TABLE dbo.wf_pasos_anteriores_tmp
go

CREATE TABLE dbo.wf_pasos_anteriores_tmp(
	pat_id_paso_ini     INT NOT NULL,
	pat_id_paso_fin     INT NOT NULL,
	pat_spid            INT NOT NULL
)
lock datarows
go

/*==============================================================*/
/* Table: wf_aprobacion_excepcion                               */
/*==============================================================*/
IF OBJECT_ID ('dbo.wf_aprobacion_excepcion') IS NOT NULL
	DROP TABLE dbo.wf_aprobacion_excepcion
go

CREATE TABLE dbo.wf_aprobacion_excepcion
(
	ae_id_paso                     INT NOT NULL,
	ae_id_politica_o_documento     INT NOT NULL,
	ae_tipo_excepcion              VARCHAR (20),
)
LOCK datarows
go

CREATE NONCLUSTERED INDEX aprobacion_excepcion_i1
	ON dbo.wf_aprobacion_excepcion (ae_id_paso) ON 'default'
go

CREATE NONCLUSTERED INDEX aprobacion_excepcion_i2
	ON dbo.wf_aprobacion_excepcion (ae_id_politica_o_documento) ON 'default'
go

/*==============================================================*/
/* Table: wf_temp_statistics_active                             */
/*==============================================================*/
CREATE TABLE wf_temp_statistics_active  
( 
	pr_codigo_proceso	int NULL,
	pr_nombre_proceso	varchar(255) NULL,
	aTiempo	            int NULL,
	atrasados	        int NULL,
	promedio			int NULL,
	cancelados			int NULL,
	suspendidos			int NULL ,
	codigo_regional		varchar(255) NULL,
	nombre_regional		varchar(255) NULL,
	codigo_oficina		int NULL,		
	nombre_oficina		varchar(255) NULL
)
go

/*==============================================================*/
/* Table: wf_temp_statistics_inactive                           */
/*==============================================================*/
CREATE TABLE wf_temp_statistics_inactive  
( 
	codigo_proceso		int NOT NULL,
	nombre_proceso		varchar(255) NOT NULL,		
	a_tiempo			int NULL,
	restrasados			int NULL,
	tiempo_promedio		int NULL,		
	cancelados			int NOT NULL,
	suspendidos			int NOT NULL,
	codigo_regional		varchar(255) NOT NULL,
	nombre_regional		varchar(255) NOT NULL,		
	codigo_oficina		int NOT NULL,
	nombre_oficina		varchar(255) NOT NULL
)
go

/*==============================================================*/
/* Table: wf_paso_temp                                          */
/*==============================================================*/
CREATE TABLE wf_paso_temp  
( 
	pa_alto							float NOT NULL,
	pa_ancho						float NOT NULL,
	pa_automatico					int NULL,
	pa_codigo_actividad				smallint NULL,
	pa_codigo_proceso				smallint NOT NULL,
	pa_id_paso						int NOT NULL,
	pa_id_programa_tiempo_estandar	int NULL,
	pa_posicion_x					float NOT NULL,
	pa_posicion_y					float NOT NULL,
	pa_tipo_paso					varchar(10) NOT NULL,
	pa_version_proceso				smallint NOT NULL 
)
go


/*==============================================================*/
/* Indices                                                      */
/*==============================================================*/
if exists( select 1 from sysindexes where name = 'inst_actividad_i3')
   drop index wf_inst_actividad.inst_actividad_i3
go
create nonclustered index inst_actividad_i3 on 
	wf_inst_actividad (ia_codigo_act)
go

if exists( select 1 from sysindexes where name = 'wf_est_proceso_index')
   drop index  wf_inst_proceso.wf_est_proceso_index 
go
create nonclustered index  wf_est_proceso_index on 
	wf_inst_proceso (io_estado) 
go

if exists( select 1 from sysindexes where name = 'wf_nombre_actividad_index')
   drop index  wf_actividad.wf_nombre_actividad_index 
go
create index wf_nombre_actividad_index on 
	wf_actividad (ac_nombre_actividad)
go

if exists( select 1 from sysindexes where name = 'wf_version_proceso_index')
   drop index  wf_inst_proceso.wf_version_proceso_index 
go
create index wf_version_proceso_index on 
	wf_inst_proceso (io_codigo_proc, io_version_proc)
go

if exists( select 1 from sysindexes where name = 'aa_inst_actividad_index')
   drop index  wf_asig_actividad.aa_inst_actividad_index 
go
create index aa_inst_actividad_index on 
	wf_asig_actividad (aa_id_inst_act)
go

if exists( select 1 from sysindexes where name = 'wf_paso_index')
   drop index  wf_paso.wf_paso_index 
go
create index wf_paso_index on 
	wf_paso (pa_codigo_proceso, pa_version_proceso, pa_codigo_actividad, pa_id_programa_tiempo_estandar, pa_automatico)
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

--print 'Actualizacion de la tabla: bpl_condition_rule para exceptions'
if not exists(select 1 from   sysobjects obj, sysindexes idx where  obj.name = 'wf_proceso' and obj.id = idx.id and idx.name = 'idx_pr_nemonico')
begin 
     create unique nonclustered index idx_pr_nemonico on wf_proceso(pr_nemonico)
end 
go

--print 'Create Index: PK_WF_NIVEL_ITEM'
if not exists(select 1 from sysindexes where name = 'PK_WF_NIVEL_ITEM')
begin 
	create unique nonclustered index PK_WF_NIVEL_ITEM on wf_nivel_jerarquia_tpl(ni_id_nivel_jerarquia)
end
go

--Indíce de la tabla wf_paso_variable
if exists(select 1 from sysindexes where name = 'ind_pv_id_paso')
   drop index wf_paso_variable.ind_pv_id_paso
go

create index ind_pv_id_paso on wf_paso_variable (pv_id_paso)
go

--Indíce de la tabla wf_paso_variable_TMP
if exists(select 1 from sysindexes where name = 'ind_pvt_spid')
   drop index wf_paso_variable_TMP.ind_pvt_spid
go

create index ind_pvt_spid on wf_paso_variable_TMP (pvt_spid)
go

--print 'Create Index: idx_nombre_jerarquia'   FBO
if not exists(select 1 from sysindexes where name = 'idx_nombre_jerarquia')
begin 
	create unique nonclustered index idx_nombre_jerarquia on wf_tipo_jerarquia_tpl(tj_nombre_jerarquia)
end
go

--print 'Create Index: idx_resultado_nom'   FBO
if not exists(select 1 from sysindexes where name = 'idx_resultado_nom')
begin 
	create unique nonclustered index idx_resultado_nom on wf_resultado(rs_nombre_resultado)
end
go


-- MVA 2010-05-10
use cob_credito
go
print 'Creando campo tr_id_inst_proceso en cr_tramite'
if not exists (select 1 from syscolumns  
                where id = object_id('cr_tramite')
                  and name = 'tr_id_inst_proceso')
begin
   alter table cr_tramite
     add tr_id_inst_proceso int null
end

go
