/************************************************************************/
/*      Archivo:                ad_table.sql                            */
/*      Base de datos:          cobis                                   */
/*      Producto:               Admin                                   */
/************************************************************************/
/*                                            IMPORTANTE                */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                     PROPOSITO                                        */
/*      Este script realiza la creación de las tablas del ADMIN         */
/*                   MODIFICACIONES                                     */
/*      FECHA          AUTOR              RAZON                         */
/*  5/28/2012           DVE             Cambio de tipo de dato          */
/*                                          smallint -> int en campo    */
/*                                          fu_nomina en tabla          */
/*                                          cl_funcionario              */
/* 08/20/2013           JTA       Se agrega tabla an_services_component */
/* 24/02/2013           JGU       Se agrega campos a la tabla cl_oficina*/
/* 10/04/2015           JTA       FIE: add vt_campo_rol a ad_vistas_trnser*/
/* 15/04/2015           JTA       FIE: add cl_det_oficina            */
/* 12/04/2016           BBO       Migración Sybase-SQLServer FAL        */
/* 06/06/2016           RAL       Cambios para oficina version BMI      */
/* 24/06/2016           J.Hdez    Ajuste Vesion Falabella  cambio tipo  */
/*                                 tipo de  dato nodo                   */
/************************************************************************/

use cobis
go


/* ad_base_datos */
print '=====> ad_base_datos'
go
CREATE TABLE ad_base_datos (
        bd_filial                       tinyint NOT NULL,
        bd_oficina                      smallint NOT NULL,
        bd_nodo                         smallint NOT NULL,
        bd_base                         char (30) NOT NULL,
        bd_tamanio                      smallint NULL,
        bd_fecha_reg                    datetime NOT NULL,
        bd_registrador                  smallint NOT NULL,
        bd_estado                       estado NULL,
        bd_fecha_ult_mod                datetime NULL
)
go

/* ad_horario */
print '=====> ad_horario'
go
CREATE TABLE ad_horario (
        ho_tipo_horario                 tinyint NOT NULL,
        ho_secuencial                   tinyint NOT NULL,
        ho_dia                          char (2) NOT NULL,
        ho_hr_inicio                    datetime NOT NULL,
        ho_hr_fin                       datetime NOT NULL,
        ho_fecha_crea                   datetime NOT NULL,
        ho_creador                      smallint NOT NULL,
        ho_estado                       estado NULL,
        ho_fecha_ult_mod                datetime NULL
)
go


/* ad_horario_tmp */
print '=====> ad_horario_tmp'
go
CREATE TABLE ad_horario_tmp (
        hot_tipo_horario                tinyint  NULL,
        hot_secuencial                  tinyint  NULL,
        hot_dia                         char (2) NOT NULL,
        hot_hr_inicio                   datetime NOT NULL,
        hot_hr_fin                      datetime NOT NULL,
        hot_fecha_crea                  datetime NOT NULL,
        hot_creador                     smallint NOT NULL,
        hot_estado                      estado NULL,
        hot_fecha_ult_mod               datetime NULL,
        hot_conexion                    smallint NOT NULL
)
go

/* ad_interface */
print '=====> ad_interface'
go
CREATE TABLE ad_interface (
        in_filial                       tinyint NOT NULL,
        in_oficina                      smallint NOT NULL,
        in_nodo                         smallint NOT NULL,
        in_protocolo                    char (1) NOT NULL,
        in_tlink                        char (1) NOT NULL,
        in_link                         tinyint NOT NULL,
        in_estado                       estado NULL,
        in_fecha_ult_mod                datetime NULL
)
go

/* cl_ttransaccion */
print '=====> cl_ttransaccion'
go
create table cl_ttransaccion (
    tn_trn_code             int             not null,
    tn_descripcion          descripcion     not null,
    tn_nemonico             char(6)         null,
    tn_desc_larga           varchar(254)    null
)
go

/* cl_trn_atrib */
print '=====> cl_trn_atrib'
go
create table cl_trn_atrib (
    ta_transaccion          int             not null,
    ta_tipo_ejec            catalogo        not null,
    ta_graba_log            char(1)         not null,
    ta_off_line             char(1)         not null,
    ta_tipo                 catalogo        null        --ADU: 2001-06-11
)
go

/* ad_tipo_horario */
print '=====> ad_tipo_horario'
go
CREATE TABLE ad_tipo_horario (
        th_tipo                         tinyint NOT NULL,
        th_descripcion                  descripcion NOT NULL,
        th_ult_secuencial               tinyint NOT NULL,
        th_fecha_ult_mod                datetime  NULL,
        th_creador                      smallint NOT NULL,
        th_estado                       char(1) NULL
)
go


/* ad_tipo_horario_tmp */
print '=====> ad_tipo_horario_tmp'
go
CREATE TABLE ad_tipo_horario_tmp (
        tht_tipo                        tinyint NULL,
        tht_descripcion                 descripcion NOT NULL,
        tht_ult_secuencial              tinyint NOT NULL,
        tht_fecha_ult_mod               datetime  NULL,
        tht_creador                     smallint NOT NULL,
        tht_estado                      char(1) NULL,
        tht_conexion                    smallint NOT NULL
)
go


/* ad_x25 */
print '=====> ad_x25'
go
CREATE  VIEW ad_x25 (
        x_filial,
        x_oficina,
        x_nodo,
        x_25,
        x_tlink,
        x_link,
        x_estado,
        x_fecha_ult_mod
)as
select in_filial,
        in_oficina,
        in_nodo,
        in_protocolo,
        in_tlink,
        in_link,
        in_estado,
        in_fecha_ult_mod
from ad_interface
where in_protocolo = 'X'
go

/* ad_tcpip */
print '=====> ad_tcpip'
go
CREATE  VIEW ad_tcpip (
        tc_filial,
        tc_oficina,
        tc_nodo,
        tc_tcpip,
        tc_tlink,
        tc_link,
        tc_estado,
        tc_fecha_ult_mod
)as
select  in_filial,
        in_oficina,
        in_nodo,
        in_protocolo,
        in_tlink,
        in_link,
        in_estado,
        in_fecha_ult_mod
from ad_interface
where in_protocolo = 'T'
go

/* ad_link */
print '=====> ad_link'
go
CREATE TABLE ad_link (
        li_filial                       tinyint NOT NULL,
        li_oficina                      smallint NOT NULL,
        li_nodo                         smallint NOT NULL,
        li_tipo                         char (1) NOT NULL,
        li_link                         tinyint NOT NULL,
        li_descripcion                  descripcion NOT NULL,
        li_estado                       estado NULL,
        li_fecha_ult_mod                datetime NULL
)
go



/* ad_nodo */
print '=====> ad_nodo'
go
CREATE TABLE ad_nodo (
        no_nodo                         smallint NOT NULL,
        no_marca                        varchar (20) NOT NULL,
        no_modelo                       varchar (20) NOT NULL,
        no_tipo                         varchar (5) NULL,
        no_num_serie                    varchar (20) NOT NULL,
        no_fecha_reg                    datetime NOT NULL,
        no_fecha_habil                  datetime NULL,
        no_registrador                  smallint NOT NULL,
        no_habilitante                  smallint NULL,
        no_estado                       estado NULL,
        no_fecha_ult_mod                datetime NULL
)
go


/* ad_nodo_oficina */
print '=====> ad_nodo_oficina'
go
CREATE TABLE ad_nodo_oficina (
        nl_filial                       tinyint NOT NULL,
        nl_oficina                      smallint NOT NULL,
        nl_nodo                         smallint NOT NULL,
        nl_sis_operativo                tinyint NOT NULL,
        nl_nombre                       descripcion NULL,
        nl_fecha_reg                    datetime NULL,
        nl_registrador                  smallint NOT NULL,
        nl_fecha_habil                  datetime NULL,
        nl_habilitante                  smallint NULL,
        nl_terminal                     smallint NULL,
        nl_estado                       estado NULL,
        nl_secuencial                   smallint NOT NULL,
        nl_fecha_ult_mod                datetime NULL,
        nl_x                            smallint NULL,
        nl_y                            smallint NULL
)
go


/* cl_parametro */
print '=====> Creacion:  cl_parametro'
go
create table cl_parametro (
        pa_parametro                    descripcion not null,
        pa_nemonico                     char(6) not null,
        pa_tipo                         char(1) not null,
        pa_char                         varchar(30) null,
        pa_tinyint                      tinyint null,
        pa_smallint                     smallint null,
        pa_int                          int null,
        pa_money                        money null,
        pa_datetime                     datetime null,
        pa_float                        float null,
        pa_producto                     char(3) not null
)
go


/* ad_pro_instalado */
print '=====> ad_pro_instalado'
go
CREATE TABLE ad_pro_instalado (
        pi_producto                     char(3) NOT NULL,
        pi_bdd                          descripcion NOT NULL,
        pi_transaccion                  int NULL, 
        pi_nomfirmas                    varchar(30) NULL, 
        pi_uso_firmas                   char(1) NULL,
        pi_qrfirmas                     varchar(30) NULL,
        pi_trn_nom                      int NULL,
        pi_trn_qry                      int NULL
)
go

/* ad_pro_rol */
print '=====> ad_pro_rol'
go
CREATE TABLE ad_pro_rol (
        pr_rol                          tinyint NOT NULL,
        pr_producto                     tinyint NOT NULL,
        pr_tipo                         char(1) NOT NULL,
        pr_moneda                       tinyint NOT NULL,
        pr_fecha_crea                   datetime NULL,
        pr_autorizante                  smallint NOT NULL,
        pr_estado                       estado NULL,
        pr_fecha_ult_mod                datetime NULL,
        pr_menu_inicial                 int NULL
)
go

/* ad_procedure */
print '=====> ad_procedure'
go
CREATE  TABLE ad_procedure (
        pd_procedure                    int NOT NULL,
        pd_stored_procedure             varchar(30) NOT NULL,
        pd_base_datos                   varchar(30) NOT NULL,
        pd_estado                       estado NULL,
        pd_fecha_ult_mod                datetime NULL,
        pd_archivo                      varchar(14) NULL
)
go


/* ad_protocolo */
print '=====> ad_protocolo'
go
CREATE TABLE ad_protocolo (
        pr_protocolo                    char (1) NOT NULL,
        pr_descripcion                  descripcion NOT NULL,
        pr_estado                       estado NULL,
        pr_fecha_ult_mod                datetime NULL
)
go


/* ad_pro_transaccion */
print '=====> ad_pro_transaccion'
go
CREATE TABLE ad_pro_transaccion (
        pt_producto                     tinyint  NOT NULL,
        pt_tipo                         char(1)  NOT NULL,
        pt_moneda                       tinyint  NOT NULL,
        pt_transaccion                  int NOT NULL,
        pt_estado                       estado NULL,
        pt_fecha_ult_mod                datetime NULL,
        pt_procedure                    int NULL,
        pt_especial                     char(1) NULL
)
go


/* ad_rol */
print '=====> ad_rol'
go
CREATE TABLE ad_rol (
        ro_rol                          tinyint NOT NULL,
        ro_filial                       tinyint NOT NULL,
        ro_descripcion                  descripcion NOT NULL,
        ro_fecha_crea                   datetime NOT NULL,
        ro_creador                      smallint NOT NULL,
        ro_estado                       estado NULL,
        ro_fecha_ult_mod                datetime NULL,
        ro_time_out                     smallint NULL,
        ro_admin_seg                       char(1) null,
        ro_departamento                   smallint NULL,
        ro_oficina                      smallint NULL
)
go


/* ad_ruta */
print '=====> ad_ruta'
go
CREATE TABLE ad_ruta (
        ru_filial_d                     tinyint NOT NULL,
        ru_oficina_d                    smallint NOT NULL,
        ru_nodo_d                       smallint NOT NULL,
        ru_filial_h                     tinyint NOT NULL,
        ru_oficina_h                    smallint NOT NULL,
        ru_nodo_h                       smallint NOT NULL,
        ru_subtipo                      char (1) NOT NULL,
        ru_nombre_f_d                   descripcion NOT NULL,
        ru_nombre_o_d                   descripcion NOT NULL,
        ru_nombre_n_d                   descripcion NOT NULL,
        ru_nombre_f_h                   descripcion NOT NULL,
        ru_nombre_o_h                   descripcion NOT NULL,
        ru_nombre_n_h                   descripcion NOT NULL,
        ru_estado                       estado NULL,
        ru_fecha_ult_mod                datetime NULL
)
go

/* ad_directa */
ALTER TABLE ad_ruta add
        di_protocolo                    char (1) NULL,
        di_tlink                        char (1) NULL,
        di_link                         tinyint NULL,
        di_secuencial                   tinyint NULL,
        di_prioridad                    char(1) NULL
go

print '=====> ad_directa'
go
CREATE VIEW ad_directa (
        di_filial_d,
        di_oficina_d,
        di_nodo_d,
        di_filial_h,
        di_oficina_h,
        di_nodo_h,
        di_protocolo,
        di_tlink,
        di_link,
        di_secuencial,
        di_prioridad,
        di_subtipo,
        di_nombre_f_d,
        di_nombre_o_d,
        di_nombre_n_d,
        di_nombre_f_h,
        di_nombre_o_h,
        di_nombre_n_h,
        di_estado,
        di_fecha_ult_mod
) as
select  ru_filial_d,
        ru_oficina_d,
        ru_nodo_d,
        ru_filial_h,
        ru_oficina_h,
        ru_nodo_h,
        di_protocolo,
        di_tlink,
        di_link,
        di_secuencial,
        di_prioridad,
        ru_subtipo,
        ru_nombre_f_d,
        ru_nombre_o_d,
        ru_nombre_n_d,
        ru_nombre_f_h,
        ru_nombre_o_h,
        ru_nombre_n_h,
        ru_estado,
        ru_fecha_ult_mod
from    ad_ruta
where   ru_subtipo = 'D'
go

/* ad_indirecta */
ALTER TABLE ad_ruta add
        in_filial_p             tinyint NULL,
        in_oficina_p            smallint NULL,
        in_nodo_p               smallint NULL,
        in_filial_a             tinyint NULL,
        in_oficina_a            smallint NULL,
        in_nodo_a               smallint NULL,
        in_nombre_f_p           descripcion NULL,
        in_nombre_o_p           descripcion NULL,
        in_nombre_n_p           descripcion NULL,
        in_nombre_f_a           descripcion NULL,
        in_nombre_o_a           descripcion NULL,
        in_nombre_n_a           descripcion NULL

go

print '=====> ad_indirecta'
go
CREATE VIEW ad_indirecta (
        in_filial_d,
        in_oficina_d,
        in_nodo_d,
        in_filial_h,
        in_oficina_h,
        in_nodo_h,
        in_subtipo,
        in_filial_p,
        in_oficina_p,
        in_nodo_p,
        in_filial_a,
        in_oficina_a,
        in_nodo_a,
        in_nombre_f_d,
        in_nombre_o_d,
        in_nombre_n_d,
        in_nombre_f_h,
        in_nombre_o_h,
        in_nombre_n_h,
        in_nombre_f_p,
        in_nombre_o_p,
        in_nombre_n_p,
        in_nombre_f_a,
        in_nombre_o_a,
        in_nombre_n_a,
        in_estado,
        in_fecha_ult_mod
)as
select  ru_filial_d,
        ru_oficina_d,
        ru_nodo_d,
        ru_filial_h,
        ru_oficina_h,
        ru_nodo_h,
        ru_subtipo,
        in_filial_p,
        in_oficina_p,
        in_nodo_p,
        in_filial_a,
        in_oficina_a,
        in_nodo_a,
        ru_nombre_f_d,
        ru_nombre_o_d,
        ru_nombre_n_d,
        ru_nombre_f_h,
        ru_nombre_o_h,
        ru_nombre_n_h,
        in_nombre_f_p,
        in_nombre_o_p,
        in_nombre_n_p,
        in_nombre_f_a,
        in_nombre_o_a,
        in_nombre_n_a,
        ru_estado,
        ru_fecha_ult_mod
from ad_ruta
where ru_subtipo = 'I'
go


/* ad_server_logico */
print '=====> ad_server_logico'
go
CREATE TABLE ad_server_logico (
        sg_filial_i                     tinyint NOT NULL,
        sg_oficina_i                    smallint NOT NULL,
        sg_nodo_i                       smallint NOT NULL,
        sg_filial_p                     tinyint NOT NULL,
        sg_oficina_p                    smallint NOT NULL,
        sg_producto                     tinyint NOT NULL,
        sg_tipo                         char (1) NOT NULL,
        sg_moneda                       tinyint NOT NULL,
        sg_fecha_reg                    datetime NOT NULL,
        sg_registrador                  smallint NOT NULL,      
        sg_estado                       estado NULL,
        sg_fecha_ult_mod                datetime NULL
)
go


/* ad_sis_operativo */
print '=====> ad_sis_operativo'
go
CREATE TABLE ad_sis_operativo (
        so_sis_operativo                tinyint NOT NULL,
        so_descripcion                  descripcion NOT NULL,
        so_version                      varchar (12) NOT NULL,
        so_release                      varchar (12) NULL,
        so_propietario                  descripcion NULL,
        so_estado                       estado NULL,
        so_fecha_ult_mod                datetime NULL
)
go


/* ad_terminal */
print '=====> ad_terminal'
go
CREATE TABLE ad_terminal (
        te_filial                       tinyint NOT NULL,
        te_oficina                      smallint NOT NULL,
        te_nodo                         smallint NOT NULL,
        te_terminal                     smallint NOT NULL,
        te_nombre                       varchar(32) NOT NULL,
        te_marca                        varchar (20) NOT NULL,
        te_tipo                         varchar (10) NULL,
        te_modelo                       varchar (10) NULL,
        te_fecha_reg                    datetime NOT NULL,
        te_registrador                  smallint NOT NULL,
        te_fecha_habil                  datetime NULL,
        te_habilitante                  smallint NULL,
        te_estado                       estado NULL,
        te_fecha_ult_mod                datetime NULL
)
go


/* ad_tlink */
print '=====> ad_tlink'
go
CREATE TABLE ad_tlink (
        tl_tipo_link                    char (1) NOT NULL,
        tl_descripcion                  descripcion NOT NULL,
        tl_estado                       estado NULL,
        tl_fecha_ult_mod                datetime NULL
)
go

/* ad_tr_autorizada */
print '=====> ad_tr_autorizada'
go
CREATE TABLE ad_tr_autorizada (
        ta_producto                     tinyint NOT NULL,
        ta_tipo                         char(1) NOT NULL,
        ta_moneda                       tinyint NOT NULL,
        ta_transaccion                  int NOT NULL,
        ta_rol                          tinyint NOT NULL,
        ta_fecha_aut                    datetime NOT NULL,
        ta_autorizante                  smallint NOT NULL,
        ta_estado                       estado NULL,
        ta_fecha_ult_mod                datetime NULL
)
go


/* ad_usuario */
print '=====> ad_usuario'
go
CREATE TABLE ad_usuario (
        us_filial                       tinyint NOT NULL,
        us_oficina                      smallint NOT NULL,
        us_nodo                         smallint NOT NULL,
        us_login                        varchar(30) NOT NULL,
        us_fecha_asig                   datetime NOT NULL,
        us_creador                      smallint NOT NULL,
        us_fecha_ult_mod                datetime NULL,
        us_fecha_ult_pwd                datetime NULL,
        us_estado                       estado NULL
)
go


/* ad_usuario_rol */
print '=====> ad_usuario_rol'
go
CREATE TABLE ad_usuario_rol (
        ur_login                        varchar(30) NOT NULL,
        ur_rol                          tinyint NOT NULL,
        ur_fecha_aut                    datetime NOT NULL,
        ur_autorizante                  smallint NOT NULL,
        ur_estado                       estado NULL,
        ur_fecha_ult_mod                datetime NULL,
        ur_tipo_horario                 tinyint NOT NULL,
        ur_fec_cad_rol                                  datetime NULL,
        ur_fecha_ini_rol                DATETIME null
)
go

/* ad_vigencia */
print '=====> ad_vigencia'
go
CREATE TABLE ad_vigencia (
        vi_tabla                        descripcion NOT NULL,
        vi_plazo                        smallint NOT NULL
)
go


/* ad_x25_config */
print '=====> ad_x25_config'
go
CREATE TABLE ad_x25_config (
        xc_filial                       tinyint NOT NULL,
        xc_oficina                      smallint NOT NULL,
        xc_nodo                         smallint NOT NULL,
        xc_protocolo                    char (1) NOT NULL,
        xc_tlink                        char (1) NOT NULL,
        xc_link                         tinyint NOT NULL,
        xc_secuencial                   tinyint NOT NULL,
        xc_nombre                       descripcion NULL,
        xc_direccion                    varchar (30) NOT NULL,
        xc_subdireccion                 varchar (30) NULL,
        xc_estado                       estado NULL,
        xc_fecha_ult_mod                datetime NULL
)
go

/* cl_catalogo */
print '=====> cl_catalogo'
go
CREATE TABLE cl_catalogo (
        tabla           smallint        NOT NULL,
        codigo          char(10)        NOT NULL,
        valor           descripcion     NOT NULL,
        estado          estado          NOT NULL,
        culture         varchar(10)     NULL, --Internacionalizacion COBIS
        equiv_code      varchar(10)     NULL, --Internacionalizacion COBIS
        type            char(10)        NULL  --Internacionalizacion COBIS
)
go

/* cl_catalogo_pro */
print '=====> cl_catalogo_pro'
go
CREATE TABLE cl_catalogo_pro (
        cp_producto     char (3)        not null,
        cp_tabla        smallint        not null
)
go


/* cl_ciudad */
print '=====> cl_ciudad'
go
CREATE TABLE cl_ciudad (
      ci_ciudad                       int NOT NULL, /* PES Versión Colombia */
      ci_descripcion                  descripcion NOT NULL,
      ci_estado                       estado      NULL,
      ci_provincia                    int         NULL, --HSBC cambio de smallint a int
      ci_cod_remesas                  smallint    NULL,
      ci_pais                         smallint    NULL,
      ci_canton                       int         NULL
)
go


/* cl_departamento */
print '=====> cl_departamento'
go
CREATE TABLE cl_departamento (
        de_departamento                 smallint NOT NULL,
        de_filial                       tinyint NOT NULL,
        de_oficina                      smallint NOT NULL,
        de_descripcion                  descripcion NOT NULL,
        de_o_oficina                    smallint NULL,
        de_o_departamento               smallint NULL,
        de_nivel                        tinyint NULL
)
go


/* cl_departamento_tmp */
print '=====> cl_departamento_tmp'
go
CREATE TABLE cl_departamento_tmp (
        de_departamento                 smallint NOT NULL,
        de_filial                       tinyint NOT NULL,
        de_oficina                      smallint NOT NULL,
        de_descripcion                  descripcion NOT NULL,
        de_o_oficina                    smallint NULL,
        de_o_departamento               smallint NULL,
        de_nivel                        tinyint NULL
)
go

/* cl_dias_feriados */
print '=====> cl_dias_feriados'
go
CREATE TABLE cl_dias_feriados (
        df_ciudad                       int NOT NULL, /* PES Versión Colombia */
        df_fecha                        datetime NOT NULL,
        df_real                            char(1) NULL
)
go


/* cl_dis_seqnos */
print '=====> cl_dis_seqnos'
go
CREATE TABLE cl_dis_seqnos (
        dq_oficina                      smallint NOT NULL,
        dq_departamento                 smallint NOT NULL,
        dq_cargo                        smallint NOT NULL,
        dq_siguiente                    tinyint NOT NULL
)
go


/* cl_distributivo */
print '=====> cl_distributivo'
go
CREATE TABLE cl_distributivo (
        ds_filial                       tinyint NOT NULL,
        ds_oficina                      smallint NOT NULL,
        ds_departamento                 smallint NOT NULL,
        ds_cargo                        smallint NOT NULL,
        ds_secuencial                   tinyint NOT NULL,
        ds_fecha                        datetime NULL,
        ds_estado                       estado NULL,
        ds_numero                       tinyint NULL,
        ds_vacante                      char(1) NULL
)
go


/* cl_filial */
print '=====> cl_filial'
go
CREATE TABLE cl_filial (
        fi_filial                       tinyint NOT NULL,
        fi_nombre                       descripcion NOT NULL,
        fi_direccion                    direccion NULL,
        fi_actividad                    catalogo NOT NULL,
        fi_estado                       estado NULL,
        fi_abreviatura                  char(4) NOT NULL,
        fi_rep_nombre                   descripcion NULL,
        fi_contador                     descripcion NULL,
        fi_ruc                          numero NULL,
        fi_cont_nivel                   tinyint NULL
)
go

/* cl_funcionario */
print '=====> cl_funcionario'
go
CREATE TABLE cl_funcionario (
        fu_funcionario     smallint      NOT NULL,
        fu_nombre          descripcion   NOT NULL,
        fu_sexo            sexo          NOT NULL,
        fu_dinero          char (1)      NULL,
        fu_nomina          int           NULL, --DVE 5/28/2012
        fu_departamento    smallint      NOT NULL,
        fu_oficina         smallint      NOT NULL,
        fu_cargo           smallint      NOT NULL,
        fu_secuencial      tinyint       NOT NULL,
        fu_jefe            int           NULL,
        fu_nivel           tinyint       NULL,
        fu_fecha_ing       datetime      NULL,
        fu_login           login         NULL,
        fu_telefono        varchar(15)   NULL,
        fu_fec_inicio      datetime      NULL,
        fu_fec_final       datetime      NULL,
        fu_clave           varchar(30)   NULL,
        fu_estado          estado,
        fu_offset          varbinary(32) NULL,   -- ARO:23/01/2001       CRYPWD
        fu_cedruc          numero        NULL,
        fu_causa_bloqueo   catalogo      NULL,
        fu_fecha_cargo     datetime      NULL   --Originador
)
go

/* cl_oficina */
print '=====> cl_oficina'
go
CREATE TABLE cl_oficina (
        of_filial                       tinyint NOT NULL,
        of_oficina                      smallint NOT NULL,
        of_nombre                       descripcion NOT NULL,
        of_direccion                    direccion NOT NULL,
        of_ciudad                       int NOT NULL, /* PES Version Colombia */
        of_telefono                     tinyint NULL,
        of_subtipo                      char (1) NOT NULL,
        of_area                         char (10) NULL,
        a_sucursal                      smallint null,
        of_regional                     smallint null,        --RAL 06.06.2016 modificaciones en oficina version BMI
        of_tip_punt_at                  varchar(10) null,        
        of_cir_comunic                  varchar(20) null,
        of_nomb_encarg                  varchar(64) null,
        of_ci_encarg                    varchar(20) null,
        of_horario                      tinyint  null,
        of_tipo_horar                   varchar(10) null,
        of_jefe_agenc                   int null,
        of_cod_fie_asf                  varchar(10) null,
        of_fec_aut_asf                  datetime null,
        of_sector                       varchar(10) null,
        of_depart_pais                  catalogo null,
        of_provincia                    int null,
        of_barrio                        int null,
        of_relac_ofic                   smallint null,
        of_lat_coord                    char(1) null,
        of_lat_grad                     float null,
        of_lat_min                      float null,
        of_lat_seg                      float null,
        of_long_coord                   char(1) null,
        of_long_grad                    float null,
        of_long_min                     float null,
        of_long_seg                     float null,
        of_subregional                  char(10) null,
        of_obs_horario                  varchar(255) null,
        --RAL 06.06.2016 modificaciones en oficina version BMI
        of_sucursal                     smallint null,
        of_zona                         smallint null,
        of_cob                             smallint null,
        of_bloqueada                     char(1) null
        --RAL 06.06.2016 modificaciones en oficina version BMI
)
go


/* cl_det_oficina */
print '=====> cl_det_oficina'
go

CREATE TABLE cl_det_oficina(
        do_regional                varchar(100) NULL,
        do_cod_fie_asfi            varchar(10) NULL,
        do_cod_oficina            smallint NULL,
        do_dpto_pais            varchar(64) NULL,
        do_provincia            varchar(64) NULL,
        do_municipio            varchar(64) NULL,
        do_ciudad                varchar(64) NULL,
        do_localidad            varchar(64) NULL,
        do_direccion            varchar(255) NULL,
        do_barrio                varchar(64) NULL,
        do_dependencia            varchar(64) NULL,
        do_tipo_oficina            varchar(10) NULL,
        do_clasificacion        varchar(64) NULL,
        do_nombre_of            varchar(64) NULL,
        do_jefe_agencia            varchar(64) NULL,
        do_ci_enc_pto_reclamo    varchar(15) NULL,
        do_enc_pto_reclamo        varchar(64) NULL,
        do_tel_1                varchar(12) NULL,
        do_tel_2                varchar(12) NULL,
        do_tel_3                varchar(12) NULL,
        do_celular                varchar(12) NULL,
        do_cordenadas_lat        varchar(20) NULL,
        do_cordenadas_lon        varchar(20) NULL,
        do_tipo_horario            varchar(64) NULL,
        do_obs_horario            varchar(120) NULL,
        do_horario_lunes        varchar(63) NULL,
        do_horario_sabado        varchar(63) NULL,
        do_horario_domingo        varchar(63) NULL,
        do_servicios            varchar(200) NULL,
        do_circular_com_asfi    varchar(20) NULL,
        do_fecha_asfi            datetime NULL,
        do_sec                    integer  identity
)
go

/* cl_sucursal */
print '=====> cl_sucursal'
go
CREATE VIEW cl_sucursal (
                         filial,
                         sucursal,
                         nombre,
                         direccion,
                         ciudad,
                         telefono,
                         subtipo,
                         area
) AS SELECT 
                of_filial,
                of_oficina, 
                of_nombre,
                of_direccion,
                of_ciudad,
                of_telefono,
                of_subtipo,
                of_area
FROM       cl_oficina  
WHERE      of_subtipo in ('R', 'S')
go


print '=====> VISTA:  cl_agencia'
go
CREATE VIEW cl_agencia (
                        filial,
                        agencia,
                        nombre,
                        direccion,
                        ciudad, 
                        sucursal_dep,
                        telefono,
                        subtipo
) AS SELECT 
                of_filial,
                of_oficina, 
                of_nombre,
                of_direccion,
                of_ciudad,
                a_sucursal,
                of_telefono,
                of_subtipo
FROM       cl_oficina  
WHERE      of_subtipo = 'A'
go


/* cl_moneda */
print '=====> cl_moneda'
go
CREATE TABLE cl_moneda (
        mo_moneda                       tinyint NOT NULL,
        mo_descripcion                  descripcion NULL,
        mo_pais                         smallint NOT NULL,
        mo_estado                       estado NULL, 
        mo_decimales                    char(1) NULL,
        mo_simbolo                      varchar(10) null,
        mo_nemonico                     varchar(10) null,
        mo_cod_ctaunico                 char(1) null
)
go


/* cl_pais */
print '=====> cl_pais'
go
CREATE TABLE cl_pais (
        pa_pais                         smallint NOT NULL,
        pa_descripcion                  descripcion NOT NULL,
        pa_abreviatura                  char (3) NOT NULL,
        pa_nacionalidad                 descripcion NOT NULL,
        pa_estado                       estado NULL,
        pa_continente                   char (3) NOT NULL
)
go



print '=====> cl_parroquia'
go
CREATE TABLE cl_parroquia (
        pq_parroquia                    int NOT NULL,
        pq_descripcion                  descripcion NOT NULL,
        pq_tipo                         char (1) NOT NULL,
        pq_ciudad                       int NOT NULL, /* PES Version Colombia */
        pq_zona                                     char(3) NOT NULL,
        pq_estado                       estado NULL
)
go

CREATE NONCLUSTERED INDEX IX_pq_parroquia   
    ON cl_parroquia (pq_parroquia)
go

/* cl_pro_asociado */
print '=====> cl_pro_asociado'
go
CREATE TABLE cl_pro_asociado (
        pp_base                         tinyint NOT NULL,
        pp_btipo                        char (1) NOT NULL,
        pp_asociado                     tinyint NOT NULL,
        pp_atipo                        char (1) NOT NULL,
        pp_fecha                        datetime NOT NULL
)
go


/* cl_pro_oficina */
print '=====> cl_pro_oficina'
go
CREATE TABLE cl_pro_oficina (
        pl_filial                       tinyint NOT NULL,
        pl_oficina                      smallint NOT NULL,
        pl_producto                     tinyint NOT NULL,
        pl_tipo                         char(1) NOT NULL,
        pl_moneda                       tinyint NOT NULL,
        pl_monto                        money NULL,
        pl_fecha_aper                   datetime NULL,
        pl_secuencial                   smallint NOT NULL
)
go


/* cl_pro_moneda */
print '=====> cl_pro_moneda'
go
CREATE TABLE cl_pro_moneda (
        pm_producto                     tinyint NOT NULL,
        pm_tipo                         char(1) NOT NULL,
        pm_moneda                       tinyint NOT NULL,
        pm_descripcion                  descripcion NOT NULL,
        pm_fecha_aper                   datetime NULL,
        pm_estado                       char(1) NULL
)
go


/* cl_producto */
print '=====> cl_producto'
go
CREATE TABLE cl_producto (
        pd_producto                     tinyint NOT NULL,
        pd_tipo                         char(1) NOT NULL,
        pd_descripcion                  descripcion NOT NULL,
        pd_abreviatura                  char (3) NOT NULL,
        pd_fecha_apertura               datetime NOT NULL,
        pd_estado                       estado NULL,
        pd_saldo_minimo                 money NULL,
        pd_costo                        money NULL
)
go


/* cl_provincia */
print '=====> cl_provincia'
go
CREATE TABLE cl_provincia (
        pv_provincia                    int NOT NULL, --HSBC cambio de smallint a int
        pv_descripcion                  descripcion  NULL,
        pv_region_nat                   char (2)     NULL,
        pv_region_ope                   char(3)      NULL,
        pv_pais                         smallint     NULL,
        pv_estado                       estado       NULL,
        pv_depart_pais                  catalogo     NULL
)
go

/* cl_seqnos */
print '=====> cl_seqnos'
go
CREATE TABLE cl_seqnos (
        bdatos                          varchar (30) NULL,
        tabla                           varchar (30) NOT NULL,
        siguiente                       int NULL,
        pkey                            varchar (30) NULL        
) 
go


print '=====> cl_tabla'
CREATE TABLE cl_tabla (
        codigo          smallint        not null,
        tabla           char(30)        not null,
        descripcion     descripcion     not null
)
go


/* cl_errores */
--print '=====> cl_errores'
--go
--CREATE TABLE cl_errores (
--        numero      int             not null,
--        severidad   int             not null,
--        mensaje     varchar(132)    not null)
--go

/* cl_default */
print '=====> cl_default'
go
CREATE TABLE cl_default (
       tabla      smallint   NOT NULL,
       oficina    smallint   NOT NULL,
       codigo     char(10) NOT NULL,
       valor      char(30) NOT NULL,
       srv        varchar(30) NOT NULL
)
go
   
/* cl_default_tr */
print '=====> cl_default_tr'
go
CREATE TABLE cl_default_tr (
       df_nemonico      descripcion   NOT NULL,
       df_descripcion   descripcion   NOT NULL,
       df_tdato         descripcion   NOT NULL
)
go

/* cl_def_tran */
print '=====> cl_def_tran'
go
CREATE TABLE cl_def_tran (
        dt_producto     tinyint         NOT NULL,
        dt_tipo         char(1)         NOT NULL,
        dt_moneda       tinyint         NOT NULL,
        dt_transaccion  smallint        NOT NULL,
        dt_default      descripcion     NULL,
        dt_categoria    char(1)         NOT NULL,
        dt_int          int             NULL,
        dt_smallint     smallint        NULL,
        dt_float        float           NULL,
        dt_money        money           NULL
)
go


/* cl_dias_laborables */
print '=====> cl_dias_laborables'
go
CREATE TABLE cl_dias_laborables (
        dl_fecha                        datetime NOT NULL,
        dl_num_dias                     tinyint NOT NULL,
        dl_secuencial                   smallint NULL
)
go


/* cl_suc_correo */
print ' =====> cl_suc_correo'
go
CREATE TABLE cl_suc_correo (
        sc_provincia            smallint                NOT NULL,
        sc_sucursal             tinyint                 NOT NULL,
        sc_descripcion          descripcion             NOT NULL,
        sc_estado               char(1)                 NOT NULL
)
go


/* cl_telefono_of */
print ' =====> cl_telefono_of'
go
CREATE TABLE cl_telefono_of (
        to_oficina              smallint NOT NULL,
        to_secuencial           tinyint NOT NULL,
        to_valor                varchar(12) NOT NULL,   
        to_ttelefono            char(2) NOT NULL --JSA 11202012 INC-ADM-12918
)
go

/* ad_nivel */
print '=====> ad_nivel'
go
CREATE TABLE ad_nivel (
        ni_codigo_nivel                 tinyint NOT NULL,
        ni_nombre_nivel                 descripcion NOT NULL
)
go

/* ad_mapa */
print '=====> ad_mapa'
go
CREATE TABLE ad_mapa (
        mp_codigo_mapa                  tinyint NOT NULL,
        mp_nombre_mapa                  descripcion NOT NULL,
        mp_mapath_bmp                   descripcion NOT NULL
)
go

/* ad_nivel_mapa */
print '=====> ad_nivel_mapa'
go
CREATE TABLE ad_nivel_mapa (
        nm_codigo_nivel                 tinyint NOT NULL,
        nm_codigo_mapa                  tinyint NOT NULL
)
go

/* ad_icono */
print '=====> ad_icono'
go
CREATE TABLE ad_icono (
        ic_codigo_nivel                 tinyint NOT NULL,
        ic_codigo_mapa                  tinyint NOT NULL,
        ic_codigo_icono                 tinyint NULL,
        ic_nombre_icono                 descripcion NULL,
        ic_x                            smallint NULL,
        ic_y                            smallint NULL,
        ic_mapa_hijo                    tinyint NULL
)
go
 
/* ad_nodo_nivel */
print '=====> ad_nodo_nivel'
go
CREATE TABLE ad_nodo_nivel (
        nn_filial                       tinyint NOT NULL,
        nn_oficina                      smallint NOT NULL,
        nn_nodo                         smallint NOT NULL,
        nn_codigo_nivel                 tinyint NULL,
        nn_codigo_mapa                  tinyint NULL,
        nn_nombre_nodo                  descripcion NOT NULL,
        nn_x                            smallint NULL,
        nn_y                            smallint NULL,
        nn_mapa_hijo                    tinyint NULL
)
go

/* ad_catalogo_icono */
print '=====> ad_catalogo_icono'
go
CREATE TABLE ad_catalogo_icono (
        ci_nombre                       varchar(64) NOT NULL,  
        ci_codigo_icono                 tinyint NOT NULL,
        ci_icopath_bmp                  descripcion NOT NULL
)
go

/* Modificado por Alexis Rodríguez Morales */


/* cc_oficial */
print '=====> cc_oficial'
go
CREATE TABLE cc_oficial (
        oc_oficial                      smallint NOT NULL,
        oc_funcionario                  smallint NOT NULL,
        oc_sector                       catalogo NULL,
        oc_actividad                    varchar(3) NULL,
        oc_ofi_nsuperior                smallint NULL,
        oc_ofi_sustituto                smallint NULL,
        oc_tipo_oficial                 varchar(3) NULL,
        oc_nivel                        char(10) NULL,
        oc_categoria                    char(10) NULL
)
go


/* cl_medios_depar */
print '=====> cl_medios_depar'
go
create table cl_medios_depar (
md_filial       tinyint     NOT NULL,
md_oficina      smallint    NOT NULL,
md_departamento smallint    NOT NULL,
md_codigo       tinyint     NOT NULL,
md_tipo         catalogo    NOT NULL,
md_descripcion  descripcion NOT NULL,
md_estado       catalogo    NOT NULL
)
go

/* cl_medios_funcio */
print '=====> cl_medios_funcio'
go
create table cl_medios_funcio (
mf_funcionario  smallint    NOT NULL,
mf_codigo       tinyint     NOT NULL,
mf_tipo         catalogo    NOT NULL,
mf_descripcion  descripcion NOT NULL,
mf_estado       catalogo    NOT NULL
)
go


/* cl_medios_ofi */
print '=====> cl_medios_ofi'
go
create table cl_medios_ofi (
mo_filial       tinyint     NOT NULL,
mo_oficina      smallint    NOT NULL,
mo_codigo       tinyint     NOT NULL,
mo_tipo         catalogo    NOT NULL,
mo_descripcion  descripcion NOT NULL,
mo_estado       catalogo    NOT NULL
)
go

/*************** TASAS REFERENCIALES ***********/
/* ARO:  4 de Julio del 2000 */

print '=====> te_tasas_referenciales'
go
create table te_tasas_referenciales (
       tr_tasa        catalogo         NOT NULL,
       tr_descripcion descripcion      NOT NULL,
       tr_estado      char(1)          NOT NULL
)
go

print '=====> te_caracteristicas_tasa'
go
create table te_caracteristicas_tasa (
       ca_tasa        catalogo         NOT NULL,
       ca_periodo     smallint         NOT NULL,
       ca_modalidad   char(1)          NOT NULL,
       ca_estado      char(1)          NOT NULL,
       ca_rango       char(1)          NOT NULL,
       ca_nro_tasas   smallint         NULL,
       ca_num_periodo int              NOT NULL
)
go


print '=====> te_pizarra'
go
CREATE TABLE te_pizarra
       (pi_cod_pizarra     int NOT NULL,
        pi_moneda          tinyint NOT NULL,
        pi_valor           float NOT NULL,
        pi_fecha_fin       datetime NULL,
        pi_fecha_inicio    datetime NULL,
        pi_referencia      catalogo NOT NULL,
        pi_periodo         smallint NULL,
        pi_modalidad       char(1) NULL,
        pi_tipo_valor      char(1) NOT NULL,
        pi_tipo_tasa       char(1) NULL,
        pi_rango_desde     smallint NULL,
        pi_rango_hasta     smallint NULL,
                pi_revision        char(1) NULL, 
                pi_fecha_rev       datetime NULL
)
go

print '=====> te_tasa_coap'
go
CREATE TABLE te_tasa_coap
       (lc_num_tasa          int NOT NULL,
        lc_cod_tipo_servicio int NOT NULL,
        lc_moneda            tinyint NOT NULL,
        lc_monto_inicial     money NULL,
        lc_monto_final       money NULL,
        lc_tasa_nominal      float NULL,
        lc_tasa_efectiva     float NULL,
        lc_fecha_inicio      datetime NULL,
        lc_fecha_final       datetime NULL, 
        lc_rango_inicial     smallint NULL,
        lc_rango_final       smallint NULL
) 
go

print '=====> te_tasa_divisas'
go
CREATE TABLE te_tasa_divisas
       (td_num_tasa       int NOT NULL,
        td_moneda         tinyint NOT NULL,
        td_cod_mercado    tinyint NOT NULL,
        td_fecha          datetime NOT NULL,
        td_hora           datetime NOT NULL, 
        td_tasa_compra    money  NOT NULL,
        td_tasa_venta     money  NOT NULL,
        td_tasa_compra_billete money  NULL,
        td_tasa_venta_billete money  NULL,
        td_costo_interno money NOT NULL
        td_autorizado     char(1) null
)
go

print '=====> te_divisa_futura'
go
CREATE TABLE te_divisa_futura
       (df_num_registro          int NOT NULL,
        df_moneda                tinyint NOT NULL,
        df_fecha_inicio          datetime NOT NULL,
        df_fecha_fin             datetime NOT NULL,
        df_plazo                 smallint NOT NULL,
        df_tasa_compra           money NOT NULL,
        df_tasa_venta            money NOT NULL,
        df_funcionario           login NOT NULL,
        df_fecha_modificacion   datetime NOT NULL
)
go

print '=====> te_relacion_dolar'
go
CREATE TABLE te_relacion_dolar
       (rd_cod_moneda         tinyint    not null,
        rd_fecha_inicial      datetime   not null,
        rd_fecha_final        datetime   not null,
        rd_estado             char       null,
        rd_valor              float      not null,
        rd_secuencial         int        not null,
        rd_valor_v            float      not null,
        rd_operador           char       null,
        rd_cot_comp           float      null,  
        rd_cot_vent           float      null,
        rd_cod_mercado        tinyint    null
)
go

print '=====> te_control'
go
CREATE TABLE dbo.te_control 
(
    cn_login   varchar(10) NOT NULL,
    cn_grupo   catalogo    NOT NULL,
    cn_area    smallint    NOT NULL,
    cn_tipo    char(1)     NOT NULL
)
go

/************ FIN TASAS REFERENCIALES **********/


/******* MANEJO DE PASSWORDS *************/

print '=====> cl_clave_his'
go

create table cl_clave_his (
ch_login        login           not null,
ch_secuencial   int             not null,
ch_fecha        datetime        not null,
ch_clave        varchar(30)     null,
ch_offset       varbinary(32)   NULL    -- ARO:23/01/2001 CRYPWD
)
go

/******* FIN MANEJO DE PASSWORDS *************/


/********* ADMIN WEB *************/

print '======> aw_funcionalidad'
go
create table aw_funcionalidad (
fn_func         char(12)        NOT NULL,
fn_tipo         char(1)         NOT NULL,
fn_visible      char(1)         NOT NULL,
fn_padre        char(12)        NULL,
fn_ref          url             NULL,
fn_nemonico     char(10)        NULL,
fn_bold         char(1)         NULL,
fn_reload       char(1)         NULL,
fn_captura      char(1)         NULL,
fn_producto     tinyint         NULL,  --CNA:04/12/2001
fn_orden        smallint        NULL    --ADU:2002-07-12
)
go


print '======> aw_etiqueta_funcionalidad'
go
create table aw_etiqueta_funcionalidad (
ef_func         char(12)        NOT NULL,
ef_idioma       catalogo        NOT NULL,
ef_etiqueta     descripcion     NOT NULL
)
go

print '======> aw_ayuda_funcionalidad'
go
create table aw_ayuda_funcionalidad (
af_func         char(12)        NOT NULL,
af_idioma       catalogo        NOT NULL,
af_ayuda        url             NOT NULL
)
go



print '======> aw_tr_func'
go
create table aw_tr_func (
tf_func         char(12)        NOT NULL,
tf_transaccion  integer         NOT NULL
)
go


print '======> aw_func_rol'
go
create table aw_func_rol (
fr_rol          tinyint         NOT NULL,
fr_func         char(12)        NOT NULL
)
go

print '======> aw_herramienta'
go
create table aw_herramienta (
he_herramienta  catalogo        NOT NULL,
he_ref          url             NOT NULL
)
go


print '======> aw_nombre_herramienta'
go
create table aw_nombre_herramienta (
nh_herramienta  catalogo        NOT NULL,
nh_idioma       catalogo        NOT NULL,
nh_nombre       descripcion     NOT NULL
)
go


print '======> aw_ayuda_herramienta'
go
create table aw_ayuda_herramienta (
ah_herramienta  catalogo        NOT NULL,
ah_idioma       catalogo        NOT NULL,
ah_ayuda        url             NOT NULL
)
go



print '======> aw_herr_rol'
go
create table aw_herr_rol(
hr_rol          tinyint         NOT NULL,
hr_herramienta  catalogo        NOT NULL
)
go



print '======> aw_contexto'
go
create table aw_contexto (
co_contexto     catalogo        NOT NULL,
co_ref          url             NOT NULL
)
go


print '======> aw_ayuda_contexto'
go
create table aw_ayuda_contexto (
ac_contexto     catalogo        NOT NULL,
ac_idioma       catalogo        NOT NULL,
ac_ayuda        url             NOT NULL
)
go



print '======> aw_nombre_contexto'
go
create table aw_nombre_contexto (
nc_contexto     catalogo        NOT NULL,
nc_idioma       catalogo        NOT NULL,
nc_nombre       descripcion     NOT NULL
)
go


print '======> aw_contexto_func'
go
create table aw_contexto_func (
cf_func         char(12)        NOT NULL,
cf_contexto     catalogo        NOT NULL
)
go


print '======> aw_prereq_func'
go
create table aw_prereq_func (
pf_func         char(12)        NOT NULL,
pf_prereq       catalogo        NOT NULL
)
go

/********* FIN ADMIN WEB *************/
/******** NUEVO ESQUEMA BATCH *********/

print '======> ba_operador'
go
create table ba_operador (
        op_login        varchar(30)     not null,
        op_rol          tinyint         not null,
        op_osuser       varchar(16)     not null,
        op_estado       char(1)         not null,
        op_dblogin      varchar(240)    not null
)

print '======> ba_log_operador'
go
create table ba_log_operador (
        lo_sec          int             not null,
        lo_login        varchar(30)     not null,
        lo_rol          tinyint         not null,
        lo_osuser       varchar(16)     not null,
        lo_fecha        datetime        not null,
        lo_cmd          varchar(255)    not null,
        lo_archivo      varchar(50)      null
)
go
/*********FIN DE NUEVO ESQUEMA BATCH***/

-------------------------- Proyecto HSBC ------------------------
print '======> ad_error_batch'
go
CREATE TABLE ad_error_batch
(
        eb_secuencial_error INT,
        eb_fecha_proceso DATETIME,
        eb_sarta INT,
        eb_batch INT,
        eb_secuencial INT,
        eb_corrida INT,
        eb_intento INT,
        eb_fecha_error DATETIME,
        eb_msj_error varchar (255),
        eb_detalle VARCHAR (255)
)
go


print '======> ad_rango_producto'
go
CREATE TABLE ad_rango_producto
(
   rp_producto  tinyint not null,
   rp_rango_ini int not null,
   rp_rango_fin int not null
)
go


print '======> ad_vistas_trnser'
go

create table ad_vistas_trnser (
vt_producto             smallint        not null,
vt_base_datos           varchar(30) not null,
vt_tabla                        varchar(40) not null,
vt_descripcion          varchar(64) not null,
vt_tipo                         char(1)         not null,
vt_campo_fecha          char(40) not null,
vt_campo_secuencial char(40) not null,
vt_campo_clase          char(40) null,
vt_clase_ins            char(1)  null,
vt_clase_upd_previo char(1) null,
vt_clase_upd_actual char(1) null,
vt_clase_del            char(1) null,
vt_campo_login          char(40) not null,
vt_campo_terminal       char(40) null,
vt_campo_monto          char(40) null,
vt_campo_moneda         char(40) null,
vt_campo_rol            char(20) null   --FIE
)
go

print '======> ad_nodo_reentry_tmp_tbl'
go

create table ad_nodo_reentry_tmp_tbl (
                nt_nombre  varchar(60),
                nt_bandera char (1),
                spid int
        )
go

print '======> ad_nodo_reentry_tmp'
go

create view ad_nodo_reentry_tmp 
as 
        select nt_nombre, nt_bandera 
         from ad_nodo_reentry_tmp_tbl 
        --where spid=convert(int,get_appcontext('SYS_SESSION', 'spid'))
        where spid = @@SPID  --MIG. SYB-SQL 12042016
go


print '======> ad_acceso_func_cen'
create table ad_acceso_func_cen(
        af_fecha                DATETIME                NOT NULL,
        af_terminal             VARCHAR(64)     NOT NULL,
        af_usuario              login                   NOT NULL,
        af_oficina              SMALLINT                NOT NULL,
        af_rol                  SMALLINT                NOT NULL,
        af_etiqueta             VARCHAR(100)    NULL,
        af_componente   VARCHAR(255)    NULL,
        af_hora                 DATETIME                NULL
)

go


print '======> cl_barrio'
CREATE TABLE cl_barrio(
        ba_barrio              int              not null,
        ba_descripcion         descripcion      not null,       
        ba_distrito            int              not null, --Nota: los datos del campo ba_distrito hace referencia a la provincia CC-CLI-0009
        ba_canton              int              not null,
        ba_estado              estado           not null
)
go

print '======> cl_dias_feriados_bcocentral'
go

create table cl_dias_feriados_bcocentral
(
df_ciudad               int        NULL,
df_fecha                datetime   NULL,
df_real                    char(1)    NULL
)
go

-- Tabla de catálogo de tablas EX para la extracción de datos ETL
print '======> cat_ex_table'
go

create table cat_ex_table(
   et_module            int           not null,
   et_path_dst          varchar(255)  not null,
   et_base              varchar(64)   not null,
   et_table             varchar(255)   not null
)
go

-- Tabla de cuadre extracción de datos ETL
print '======> etl_cuadre_extraccion_cobis'
go

create table etl_cuadre_extraccion_cobis 
(
   cec_empresa          int         NOT NULL,
   cec_fecha_proceso    datetime    NOT NULL,
   cec_modulo           int         NOT NULL,
   cec_tabla_fuente     varchar(32) NOT NULL,
   cec_campo_criterio   int         NOT NULL,
   cec_valor_criterio   varchar(15) NOT NULL,
   cec_num_reg          int         NOT NULL,
   cec_valor            money       NOT NULL
)


go

print '======> an_menu_role_page_tmp'
go
create table an_menu_role_page_tmp(
   usuario      login,
   indice       int,
   id           varchar(255),
   id_etiqueta  int, 
   etiqueta     varchar(100),
   id_sup       varchar(50),
   prod_name    varchar(10),      
   tipo         char(1),       
   id_own       varchar(20),
   id_sup_own   int            null,
   rol1         tinyint        default 1, 
   rol2         tinyint        default 1,
   rol3         tinyint        default 1, 
   rol4         tinyint        default 1,
   rol5         tinyint        default 1, 
   rol6         tinyint        default 1,
   rol7         tinyint        default 1, 
   rol8         tinyint        default 1,
   rol9         tinyint        default 1, 
   rol10        tinyint        default 1,
   rol11        tinyint        default 1, 
   rol12        tinyint        default 1,
   rol13        tinyint        default 1, 
   rol14        tinyint        default 1,
   rol15        tinyint        default 1, 
   rol16        tinyint        default 1,
   rol17        tinyint        default 1, 
   rol18        tinyint        default 1,
   rol19        tinyint        default 1, 
   rol20        tinyint        default 1
)
go

print '======> an_operation_component'
go
create table an_operation_component (
   oc_co_id         int           NOT NULL,
   oc_nemonic       varchar(20)   NOT NULL,
   oc_la_id         int           NOT NULL,
   oc_description   varchar(255)  NULL,
   oc_control_type  varchar(10)   NOT NULL
)
go

print '======> an_transaction_component'
go
create table an_transaction_component (
   tc_co_id        int          NOT NULL,
   tc_tn_trn_code  int          NOT NULL,
   tc_oc_nemonic   varchar(20)  NULL   
)
go

print '======> an_service_component'
create table an_service_component (
   sc_co_id           int            NOT NULL,
   sc_csc_service_id  varchar(255)   NOT NULL,
   sc_oc_nemonic      varchar(20)    NULL   
)
go

print '======> an_referenced_components'
go
create table an_referenced_components (
   rc_parent_co_id   int    NOT NULL,
   rc_child_co_id    int    NOT NULL,
   rc_la_id          int    NOT NULL
)
go

print '======> an_cust_referenced_components'
go
create table an_cust_referenced_components (
   cr_pa_id          int    NOT NULL,
   cr_co_id          int    NOT NULL,
   cr_child_co_id    int    NOT NULL
)
go

print '======> an_mig_role_module'
go
create table an_mig_role_module(
 mr_mo_name      varchar(64) null,
 mr_role         int null
)
go

print '======> an_mig_role_component'
go
create table an_mig_role_component(
 mr_co_name      varchar(255) null,
 mr_role         int null
)
go

print '======> an_mig_role_page'
go
create table an_mig_role_page(
 mr_pa_name       varchar(40) null,
 mr_role          int null
)
go

print '======> an_mig_role_navigation_zone'
go
create table an_mig_role_navigation_zone(
 mr_nz_name       varchar(40) null,
 mr_role          int null
)
go

print '======> an_mig_role_agent'
go
create table an_mig_role_agent(
 mr_ag_name       varchar(50) null,
 mr_role          int null,
 mr_order         int null
)
go

-- La siguiente tabla que corresponde a VBatch es necesaria crearla en este punto
-- por cuanto existe dependencia para la compilacion de Sps del Admin.


print 'ba_batch'                       
if exists (select 1 from sysobjects where name = 'ba_batch')                       
    drop table ba_batch                       
go 

Create table ba_batch(                        
       ba_batch                           int                NOT NULL,                                                                                                                                                                                          
       ba_nombre                          descripcion        NOT NULL,                                                                                                                                                                                          
       ba_descripcion                     varchar(255)       NULL,                                                                                                                                                                                              
       ba_lenguaje                        char(3)            NOT NULL,                                                                                                                                                                                          
       ba_fecha_creacion                  datetime           NOT NULL,                                                                                                                                                                                          
       ba_producto                        tinyint            NOT NULL,                                                                                                                                                                                          
       ba_tipo_batch                      char(1)            NOT NULL,                                                                                                                                                                                          
       ba_sec_corrida                     smallint           NOT NULL,                                                                                                                                                                                          
       ba_ente_procesado                  descripcion        NULL,                                                                                                                                                                                              
       ba_arch_resultado                  varchar(255)       NULL,                                                                                                                                                                                              
       ba_arch_fuente                     varchar(255)       NOT NULL,                                                                                                                                                                                          
       ba_frec_reg_proc                   int                NULL,                                                                                                                                                                                              
       ba_impresora                       varchar(255)       NULL,                                                                                                                                                                                              
       ba_serv_destino                    varchar(24)        NULL,                                                                                                                                                                                              
       ba_reproceso                       char(1)            NOT NULL,                                                                                                                                                                                          
       ba_path_fuente                     varchar(255)       NULL,                                                                                                                                                                                              
       ba_path_destino                    varchar(255)       NULL)                                                                                                                                                                                              
go 

/* cl_ofic_servicio */
print '======> cl_ofic_servicio'
go 
create table cl_ofic_servicio(
   os_oficina       smallint   not null,
   os_filial        tinyint    not null,
   os_cat_servicio  char(10)   not null)
go

/* cl_depart_pais */
print '=====> cl_depart_pais'
go
CREATE TABLE cl_depart_pais (
        dp_departamento                 catalogo NOT NULL,
        dp_mnemonico                    catalogo NOT NULL,
        dp_descripcion                  descripcion NOT NULL,
        dp_pais                         smallint NOT NULL,        
        dp_estado                       estado NULL
)
go

/*cl_ofic_func*/
print '======> cl_ofic_func'
go
 
create table cl_ofic_func(
     of_secuencial     int not null,
     of_oficina        smallint not null,
     of_filial         tinyint not null,
     of_funcionar      smallint   not null
)
go

/*cl_ofic_func_rol*/
print '======> cl_ofic_func_rol'
go
 
create table cl_ofic_func_rol(
     or_oficfunc   int not null,
     or_rol        catalogo not null
)
go


/* cl_municipio */
print '======> cl_municipio'
go
create table cl_municipio(
   mu_municipio   catalogo not null,
   mu_descripcion descripcion not null,
   mu_cod_prov    int not null,
   mu_estado      estado not null)
go

/* cl_canton */
print '=====> cl_canton'
go

CREATE TABLE cl_canton (
    ca_canton                    int NOT NULL,
    ca_descripcion               descripcion NOT NULL,
    ca_municipio                 catalogo NOT NULL,
    ca_estado                    estado NOT NULL
)
go

/*--ad_ambito--*/
print '=====> ad_ambito'
go
create table ad_ambito(
  am_secuencial        int         not null,
  am_cargo             char(10)    not null,
  am_cod_tipo_ambito   char(10)    not null,
  am_cod_ambito        char(10)    not null,
  am_estado            char(1)     not null)
go

print '=====>ad_ambito_tmp'
create table ad_ambito_tmp(
  at_secuencial        int         not null,
  at_user              login       not null,
  at_ssn               int         not null,
  at_oficina           smallint    not null,
  at_fecha             datetime    not null
)
go

print '=====>ba_error_batch'
create table ba_error_batch(
  er_secuencial_error    int         not null,
  er_fecha_proceso       datetime    not null,
  er_sarta               int         not null,
  er_batch               int         not null,
  er_secuencial          int         not null,
  er_corrida             int         not null,
  er_intento             int         not null,
  er_fecha_error         datetime    not null,
  er_error               int         not null,
  er_tran                int         null,
  er_operacion           varchar     null,
  er_detalle             varchar     not null
)
go
