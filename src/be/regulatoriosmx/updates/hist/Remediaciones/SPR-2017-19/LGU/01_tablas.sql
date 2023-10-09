
use cobis
go
IF OBJECT_ID ('dbo.cl_reporte_tmp') IS NOT NULL
	DROP TABLE dbo.cl_reporte_tmp
GO

CREATE TABLE cl_reporte_tmp (cadena1 VARCHAR(1500))





IF OBJECT_ID ('dbo.cl_ente_std') IS NOT NULL
	DROP TABLE dbo.cl_ente_std
GO

CREATE TABLE cl_ente_std    (
ens_fecha              DATETIME      NOT NULL,
ens_entidad            VARCHAR(64)   NOT NULL,
ens_ente_std           varchar(20)   not null,-- ID del cliente en STD
ens_ente_cobis         int           not null,-- ID del cliente en COBIS
ens_estado_cre         varchar(10)       null,-- estado para la creacion
ens_oficina            smallint      not null,-- Codigo de la oficina
ens_login              login         not null,-- login del oficial asignado
ens_fecha_expira       datetime          null,-- Fecha de expiracion del pasaporte del ente
ens_c_apellido         varchar(30)       null,-- Apellido casada del ente
ens_nombre             varchar(64)  not  null,-- Primer nombre del ente
ens_segnombre          varchar(50)       null,-- Segundo nombre del ente
ens_papellido          varchar(64)  not  null,-- Primer apellido del ente
ens_sapellido          varchar(64)       null,-- Segundo apellido del ente
ens_tipo_ced           char(4)      not  null,-- Tipo de identificacion del ente
ens_sexo               varchar(10)  not  null,-- Codigo del sexo del ente
ens_fecha_nac          datetime     not  null,-- Fecha de nacimiento del ente
ens_nacionalidad       int          not  null,-- Codigo del pais de la nacionalidad del cliente
ens_cod_pais           smallint     not  null,-- Pais de nacimiento
ens_ciudad_nac         SMALLINT     not  null,-- Provincia de nacimiento
ens_est_civil          varchar(10)  not  null,-- Codigo  del estado civil de la persona
ens_dir_virtual        varchar(64)  not  null,-- email
ens_pep                char(1)           null,
ens_carg_pub           varchar(10)       null,
ens_persona_pub        varchar(1)        null,--Función que desempeña o ha desempeñado
ens_rel_carg_pub       varchar(10)       null,
ens_partner            char(1)           null,
ens_nro_ciclo_oi       INT               null,
ens_nivel_estudio      varchar(10)       null,-- Nivel de estudio de la persona
ens_profesion          varchar(10)       null,-- Codigo de la profesion de la persona
ens_num_cargas         tinyint           null,-- Numero de hijos
ens_vinculacion        char(1)           null,
ens_tipo_vinculacion   varchar(10)       null,-- Codigo del tipo de vinculacion de quien presento al cliente
ens_ant_nego           int               null,
ens_total_activos      money             null,-- Total de activos
ens_mnt_pasivo         money             null,
ens_ing_SN             char(1)           null,--Tiene otros Ingresos?
ens_otringr            VARCHAR(10)       null, --Otras fuentes de Ingresos
ens_ventas             money             null,
ens_ct_ventas          money             null,
ens_ct_operativos      money             null,
ens_otros_ingresos     money             null,
ens_lista_negra        char(1)           null,
ens_ea_cta_banco       varchar(45)       null,
ens_ea_cod_risk        varchar(20)       NULL,

ens_p_calif_cliente    varchar(10)       null,
ens_calificacion       varchar(10)       NULL
 -- estado para la creacion
)
go
create        index idx_1 on cl_ente_std(ens_ente_std)
go
create        index idx_2 on cl_ente_std(ens_ente_cobis)
go

-- datos del conyuge
IF OBJECT_ID ('dbo.cl_conyuge_std') IS NOT NULL
	DROP TABLE dbo.cl_conyuge_std
GO

CREATE TABLE cl_conyuge_std    (
 cos_fecha_c            DATETIME      NOT NULL
,cos_entidad_c          VARCHAR(64)   NOT NULL
,cos_ente_std_c         varchar(20)   not null --- ID del cliente en STD
,cos_estado_cre_c       varchar(10)       null-- estado para la creacion
,cos_nombre_c           varchar(64)       NULL
,cos_papellido_c        varchar(64)       NULL
,cos_sapellido_c        varchar(64)       NULL
,cos_segnombre_c        varchar(50)       NULL
,cos_sexo_c             varchar(10)       NULL
,cos_est_civil_c        varchar(10)       NULL
,cos_c_apellido_c       varchar(30)       NULL
,cos_fecha_expira_c     DATETIME          NULL
,cos_fecha_nac_c        DATETIME          NULL
,cos_ciudad_nac_c       SMALLINT          NULL
,cos_ente_cobis         INT           not null
)
go
create   index idx_1 on cl_conyuge_std(cos_ente_std_c, cos_fecha_c)
go

-- datos de direccion

IF OBJECT_ID ('dbo.cl_direccion_std') IS NOT NULL
	DROP TABLE dbo.cl_direccion_std
GO

CREATE TABLE cl_direccion_std    (
 dis_fecha             DATETIME      NOT NULL
,dis_entidad           VARCHAR(64)   NOT NULL
,dis_ente_std          varchar(20)   not null --- ID del cliente en STD
,dis_estado_cre        varchar(10)       null-- estado para la creacion
,dis_d_descripcion     VARCHAR(254) not null
,dis_d_tipo            VARCHAR(10)  not null
,dis_d_parroquia       smallint     not null
,dis_d_ciudad          smallint     not null
,dis_d_principal       CHAR(1)      not null
,dis_d_provincia       smallint     not null
,dis_d_codpostal       VARCHAR(10)  not null
,dis_d_calle           varchar(70)      null
,dis_d_tiempo_reside   SMALLINT         null
,dis_d_pais            smallint         null
,dis_d_correspondencia CHAR(1)          null
,dis_d_tipo_prop       varchar(10)      null
,dis_d_nro             int              null
,dis_d_nro_residentes  int              null
,dis_d_nro_interno     int              null
,dis_d_ci_poblacion    varchar(30)      null
-- datos de GEOLOCALIZACION
,dis_g_lat_segundos    float            null
,dis_g_lon_segundos    float            null
)
go
create   index idx_1 on cl_direccion_std(dis_ente_std, dis_fecha)
go

-- datos del telefono

IF OBJECT_ID ('dbo.cl_telefono_std') IS NOT NULL
	DROP TABLE dbo.cl_telefono_std
GO

CREATE TABLE cl_telefono_std    (
 tes_fecha             DATETIME      NOT NULL
,tes_entidad           VARCHAR(64)   NOT NULL
,tes_ente_std          varchar(20)   not null --- ID del cliente en STD
,tes_estado_cre        varchar(10)       null-- estado para la creacion
,tes_t_valor           varchar(16)   not null
,tes_t_tipo_telefono   char(2)       not null
,tes_t_cod_area        varchar(10)   not null
)
go
create   index idx_1 on cl_telefono_std(tes_ente_std, tes_fecha)
go


-- negocio del cliente

IF OBJECT_ID ('dbo.cl_negocio_std') IS NOT NULL
	DROP TABLE dbo.cl_negocio_std
GO

CREATE TABLE cl_negocio_std    (
 nes_fecha             DATETIME      NOT NULL
,nes_entidad           VARCHAR(64)   NOT NULL
,nes_ente_std          varchar(20)   not null --- ID del cliente en STD
,nes_estado_cre        varchar(10)       null-- estado para la creacion
,nes_n_nombre          varchar(60)   not null
,nes_n_fecha_apertura  datetime      not null
,nes_n_actividad_ec    varchar(10)   not null
,nes_n_tiempo_activida int           not null
,nes_n_tiempo_dom_neg  int           not null
,nes_n_emprendedor     CHAR(1)       not null
,nes_n_recurso         VARCHAR(10)   not null
,nes_n_ingreso_mensual money             null
,nes_n_tipo_local      VARCHAR(10)   not null
,nes_n_destino_credito VARCHAR(10)   not null
)
go
create   index idx_1 on cl_negocio_std(nes_ente_std, nes_fecha)
go
-- DATOS DE REFRENCIAS, MIN 2

IF OBJECT_ID ('dbo.cl_referencia_std') IS NOT NULL
	DROP TABLE dbo.cl_referencia_std
GO

CREATE TABLE cl_referencia_std    (
 rfs_fecha             DATETIME      NOT NULL
,rfs_entidad           VARCHAR(64)   NOT NULL
,rfs_ente_std          varchar(20)   not null --- ID del cliente en STD
,rfs_estado_cre        varchar(10)       null-- estado para la creacion
,rfs_r_nombre          varchar(20)   not null
,rfs_r_p_apellido      varchar(20)   not null
,rfs_r_direccion       varchar(255)  not null
,rfs_r_telefono_d      char(12)      not null
,rfs_r_telefono_e      char(12)      not null
,rfs_r_telefono_o      char(12)      not null
,rfs_r_parentesco      varchar(10)   not null
,rfs_r_descripcion     varchar(64)       null
,rfs_r_tiempo_conocido int           not null
,rfs_r_direccion_e     varchar(30)       null
)
go
create   index idx_1 on cl_referencia_std(rfs_ente_std, rfs_fecha)
go


--////////////////////////////////////////////////////////////////////////////


use cobis
go

/* cl_tran_servicio */
print '=====> cl_tran_servicio'
if exists (select * from sysobjects where name = 'cl_tran_servicio')
    DROP TABLE cl_tran_servicio
go

CREATE TABLE cl_tran_servicio
	(
	monto                        MONEY NULL,
	ts_abreviatura               catalogo NULL,
	ts_actividad                 catalogo NULL,
	ts_activo                    MONEY NULL,
	ts_af                        CHAR (2) NULL,
	ts_antiguedad                INT NULL,
	ts_aplica_mora               CHAR (1) NULL,
	ts_archivo                   VARCHAR (14) NULL,
	ts_asfi                      CHAR (1) NULL,
	ts_asosciada                 catalogo NULL,
	ts_balprome                  VARCHAR (10) NULL,
	ts_barrio                    CHAR (40) NULL,
	ts_bienes                    CHAR (1) NULL,
	ts_calif_cliente             catalogo NULL,
	ts_calificacion              CHAR (15) NULL,
	ts_calificador               CHAR (40) NULL,
	ts_calle                     VARCHAR (80) NULL,
	ts_camara                    catalogo NULL,
	ts_canal_extracto            CHAR (1) NULL,
	ts_carg_pub                  CHAR (1) NULL,
	ts_cargo                     SMALLINT NULL,
	ts_casilla                   VARCHAR (24) NULL,
	ts_categoria                 catalogo NULL,
	ts_ced_discapacidad          VARCHAR (30) NULL,
	ts_cedruc                    numero NULL,
	ts_cir_comunic               VARCHAR (10) NULL,
	ts_ciudad                    INT NULL,
	ts_ciudad_bien               INT NULL,
	ts_ciudad_nac                INT NULL,
	ts_ciudad_ref                INT NULL,
	ts_clase                     CHAR (1) NOT NULL,
	ts_clase_bienes_e            VARCHAR (35) NULL,
	ts_cliente_preferencial      CHAR (1) NULL,
	ts_cobertura                 VARCHAR (30) NULL,
	ts_cod_alterno               INT NULL,
	ts_cod_atr                   TINYINT NULL,
	ts_cod_fie_asf               VARCHAR (10) NULL,
	ts_cod_otro_pais             INT NULL,
	ts_cod_tbl_inf               SMALLINT NULL,
	ts_codigo                    INT NULL,
	ts_codigo_alerta             INT NULL,
	ts_codigo_mr                 INT NULL,
	ts_codigocat                 catalogo NULL,
	ts_codpostal                 VARCHAR (30) NULL,
	ts_colonia                   VARCHAR (10) NULL,
	ts_compania                  VARCHAR (36) NULL,
	ts_costo                     MONEY NULL,
	ts_cuenta                    cuenta NULL,
	ts_cuenta_bancaria           CHAR (16) NULL,
	ts_cupo_usado                MONEY NULL,
	ts_debito_aut                CHAR (1) NULL,
	ts_depart_pais               catalogo NULL,
	ts_departamento              SMALLINT NULL,
	ts_deposini                  VARCHAR (10) NULL,
	ts_derecha                   descripcion NULL,
	ts_des_cta_afi               CHAR (1) NULL,
	ts_des_otros_ingresos        catalogo NULL,
	ts_desc_atr                  descripcion NULL,
	ts_desc_direc                descripcion NULL,
	ts_desc_ingresos             catalogo NULL,
	ts_desc_larga                VARCHAR (255) NULL,
	ts_desc_oingreso             descripcion NULL,
	ts_desc_seguro               VARCHAR (64) NULL,
	ts_desc_tbl_inf              descripcion NULL,
	ts_descmoneda                descripcion NULL,
	ts_descrip_ref_per           VARCHAR (64) NULL,
	ts_descripcion               descripcion NULL,
	ts_dia_pago                  TINYINT NULL,
	ts_dias_gracia               TINYINT NULL,
	ts_digito                    CHAR (1) NULL,
	ts_dinero                    CHAR (1) NULL,
	ts_direc                     direccion NULL,
	ts_direccion                 INT NULL,
	ts_direccion_hip             VARCHAR (60) NULL,
	ts_discapacidad              CHAR (1) NULL,
	ts_dispersion_fondos         CHAR (1) NULL,
	ts_doc_validado              CHAR (1) NULL,
	ts_documento                 INT NULL,
	ts_egresos                   MONEY NULL,
	ts_emp_postal                VARCHAR (24) NULL,
	ts_empresa                   INT NULL,
	ts_ente                      INT NULL,
	ts_ente_externo              INT NULL,
	ts_escritura                 INT NULL,
	ts_estado                    estado NULL,
	ts_estado_civil              catalogo NULL,
	ts_estado_huella             catalogo NULL,
	ts_estado_ref                catalogo NULL,
	ts_estatus                   CHAR (1) NULL,
	ts_exc_por2                  CHAR (1) NULL,
	ts_exc_sipla                 CHAR (1) NULL,
	ts_exonera_estudio           CHAR (1) NULL,
	ts_fec_aut_asf               DATETIME NULL,
	ts_fec_exp_ref               DATETIME NULL,
	ts_fec_inicio                DATETIME NULL,
	ts_fec_vencimiento           DATETIME NULL,
	ts_fecha                     DATETIME NULL,
	ts_fecha_act_huella          DATETIME NULL,
	ts_fecha_constitucion        DATETIME NULL,
	ts_fecha_cov                 CHAR (10) NULL,
	ts_fecha_emision             DATETIME NULL,
	ts_fecha_escritura           DATETIME NULL,
	ts_fecha_exp                 DATETIME NULL,
	ts_fecha_expira              DATETIME NULL,
	ts_fecha_fija                CHAR (1) NULL,
	ts_fecha_hip                 DATETIME NULL,
	ts_fecha_ingreso             DATETIME NULL,
	ts_fecha_mod                 CHAR (10) NULL,
	ts_fecha_modifi              DATETIME NULL,
	ts_fecha_modificacion        DATETIME NULL,
	ts_fecha_nac                 DATETIME NULL,
	ts_fecha_nac_mer             DATETIME NULL,
	ts_fecha_nac1                DATETIME NULL,
	ts_fecha_pago                CHAR (1) NULL,
	ts_fecha_pig                 DATETIME NULL,
	ts_fecha_ref                 CHAR (10) NULL,
	ts_fecha_reg                 DATETIME NULL,
	ts_fecha_reg_huella          DATETIME NULL,
	ts_fecha_registro            DATETIME NULL,
	ts_fecha_ult_mod             DATETIME NULL,
	ts_fecha_valuo               DATETIME NULL,
	ts_fecha_vcto                DATETIME NULL,
	ts_fecha_verificacion        DATETIME NULL,
	ts_fecha_verificacion1       DATETIME NULL,
	ts_filial                    TINYINT NULL,
	ts_finca                     INT NULL,
	ts_folio                     INT NULL,
	ts_forma_des                 catalogo NULL,
	ts_forma_homologa            catalogo NULL,
	ts_fpas_finan                DATETIME NULL,
	ts_fuente_verificacion       VARCHAR (19) NULL,
	ts_funcionario               SMALLINT NULL,
	ts_garantia                  CHAR (1) NULL,
	ts_gmf_banco                 CHAR (1) NULL,
	ts_grado_soc                 catalogo NULL,
	ts_gravada                   MONEY NULL,
	ts_gravamen_afavor           CHAR (30) NULL,
	ts_grp_inf                   catalogo NULL,
	ts_grupo                     INT NULL,
	ts_hora                      DATETIME NULL,
	ts_ifi                       CHAR (1) NULL,
	ts_img_huella                VARCHAR (30) NULL,
	ts_ingre                     VARCHAR (10) NULL,
	ts_ingresos                  MONEY NULL,
	ts_inirelac                  CHAR (4) NULL,
	ts_inss                      VARCHAR (15) NULL,
	ts_izquierda                 descripcion NULL,
	ts_jefe                      SMALLINT NULL,
	ts_jefe_agenc                INT NULL,
	ts_jz                        CHAR (2) NULL,
	ts_libro                     INT NULL,
	ts_licencia                  VARCHAR (30) NULL,
	ts_localidad                 VARCHAR (10) NULL,
	ts_login                     login NULL,
	ts_lsrv                      VARCHAR (30) NULL,
	ts_lugar_doc                 INT NULL,
	ts_mandat                    CHAR (1) NULL,
	ts_mantiene_condiciones      CHAR (1) NULL,
	ts_matricula                 VARCHAR (16) NULL,
	ts_mensaje                   VARCHAR (255) NULL,
	ts_moneda                    TINYINT NULL,
	ts_monto_vencido             MONEY NULL,
	ts_motiv_term                catalogo NULL,
	ts_mpromcre                  VARCHAR (10) NULL,
	ts_mpromdeb                  VARCHAR (10) NULL,
	ts_municipio                 VARCHAR (10) NULL,
	ts_naciona                   INT NULL,
	ts_nacional                  CHAR (1) NULL,
	ts_nacionalidad              descripcion NULL,
	ts_nemdef                    CHAR (6) NULL,
	ts_nemon                     CHAR (6) NULL,
	ts_nit                       numero NULL,
	ts_nit_per                   numero NULL,
	ts_nit_venc                  DATETIME NULL,
	ts_nivel                     TINYINT NULL,
	ts_nivel_egresos             catalogo NULL,
	ts_nivel_estudio             catalogo NULL,
	ts_nom_aval                  CHAR (30) NULL,
	ts_nom_empresa               descripcion NULL,
	ts_nomb_comercial            VARCHAR (128) NULL,
	ts_nombre                    descripcion NULL,
	ts_nombre_completo           VARCHAR (255) NULL,
	ts_nombre_empresa            descripcion NULL,
	ts_nomina                    SMALLINT NULL,
	ts_notaria                   TINYINT NULL,
	ts_nro                       INT NULL,
	ts_ntrancre                  VARCHAR (10) NULL,
	ts_ntrandeb                  VARCHAR (10) NULL,
	ts_num_cargas                TINYINT NULL,
	ts_num_empleados             SMALLINT NULL,
	ts_num_hijos                 TINYINT NULL,
	ts_num_poliza                VARCHAR (36) NULL,
	ts_numero                    TINYINT NULL,
	ts_o_departamento            SMALLINT NULL,
	ts_obs_horario               VARCHAR (120) NULL,
	ts_obserprocta               VARCHAR (10) NULL,
	ts_observacion               VARCHAR (255) NULL,
	ts_observaciondir            VARCHAR (80) NULL,
	ts_observaciones             VARCHAR (255) NULL,
	ts_ofic_vinc                 SMALLINT NULL,
	ts_oficina                   SMALLINT NULL,
	ts_origen                    CHAR (40) NULL,
	ts_origen_ingresos           descripcion NULL,
	ts_otros_ingresos            MONEY NULL,
	ts_p_apellido                descripcion NULL,
	ts_pais                      SMALLINT NULL,
	ts_pais1                     VARCHAR (10) NULL,
	ts_parametro_mul             SMALLINT NULL,
	ts_parroquia                 INT NULL,
	ts_pas_finan                 MONEY NULL,
	ts_pasaporte                 VARCHAR (20) NULL,
	ts_pasivo                    MONEY NULL,
	ts_path_croquis              VARCHAR (50) NULL,
	ts_path_foto                 VARCHAR (50) NULL,
	ts_patrimonio_b              MONEY NULL,
	ts_patrimonio_tec            MONEY NULL,
	ts_periodo                   INT NULL,
	ts_porcentaje_exonera        FLOAT NULL,
	ts_porcentaje_gmfbanco       FLOAT NULL,
	ts_posicion                  catalogo NULL,
	ts_procedure                 INT NULL,
	ts_producto                  CHAR (3) NULL,
	ts_profesion                 catalogo NULL,
	ts_promedio_ventas           MONEY NULL,
	ts_promotor                  CHAR (10) NULL,
	ts_proposito                 catalogo NULL,
	ts_provincia                 SMALLINT NULL,
	ts_puesto_e                  VARCHAR (10) NULL,
	ts_rango_max                 INT NULL,
	ts_rango_min                 INT NULL,
	ts_rango_nor_max             INT NULL,
	ts_rango_nor_min             INT NULL,
	ts_razon_social              VARCHAR (254) NULL,
	ts_referido                  SMALLINT NULL,
	ts_referidor_ecu             INT NULL,
	ts_reg_nat                   catalogo NULL,
	ts_reg_ope                   catalogo NULL,
	ts_regional                  VARCHAR (10) NULL,
	ts_registro                  INT NULL,
	ts_rel_carg_pub              CHAR (1) NULL,
	ts_release                   VARCHAR (12) NULL,
	ts_rep                       descripcion NULL,
	ts_rep_legal                 INT NULL,
	ts_rep_superban              CHAR (1) NULL,
	ts_restado                   catalogo NULL,
	ts_restringue_uso            CHAR (1) NULL,
	ts_rural_urbano              CHAR (1) NULL,
	ts_s_apellido                descripcion NULL,
	ts_saldo_minimo              MONEY NULL,
	ts_sb                        CHAR (2) NULL,
	ts_sec_huella                INT NULL,
	ts_seccuenta                 INT NULL,
	ts_sector                    catalogo NULL,
	ts_secuencia                 TINYINT NULL,
	ts_secuencial                INT NOT NULL,
	ts_secuencial1               INT NULL,
	ts_segundos_lat              FLOAT NULL,
	ts_segundos_long             FLOAT NULL,
	ts_sexo                      sexo NULL,
	ts_sigla                     VARCHAR (25) NULL,
	ts_signo_spread              CHAR (1) NULL,
	ts_situacion_laboral         VARCHAR (5) NULL,
	ts_sospechoso                catalogo NULL,
	ts_srv                       VARCHAR (30) NULL,
	ts_sub_cargo                 descripcion NULL,
	ts_subemp                    CHAR (10) NULL,
	ts_subemp1                   CHAR (10) NULL,
	ts_subemp2                   CHAR (10) NULL,
	ts_sucursal                  SMALLINT NULL,
	ts_sucursal_ref              VARCHAR (20) NULL,
	ts_suplidores                descripcion NULL,
	ts_tabla                     SMALLINT NULL,
	ts_table                     CHAR (30) NULL,
	ts_tasa_mora                 catalogo NULL,
	ts_tbien                     catalogo NULL,
	ts_tclase                    descripcion NULL,
	ts_telefono                  VARCHAR (14) NULL,
	ts_telefono_1                CHAR (12) NULL,
	ts_telefono_2                CHAR (12) NULL,
	ts_telefono_3                CHAR (12) NULL,
	ts_telefono_ref              VARCHAR (16) NULL,
	ts_term                      VARCHAR (32) NULL,
	ts_terminal                  descripcion NULL,
	ts_tgarantia                 catalogo NULL,
	ts_tiempo_conocido           INT NULL,
	ts_tiempo_reside             INT NULL,
	ts_tip_punt_at               VARCHAR (10) NULL,
	ts_tipo                      catalogo NULL,
	ts_tipo_alerta               catalogo NULL,
	ts_tipo_ced                  CHAR (4) NULL,
	ts_tipo_credito              CHAR (1) NULL,
	ts_tipo_discapacidad         catalogo NULL,
	ts_tipo_dp                   CHAR (1) NULL,
	ts_tipo_empleo               catalogo NULL,
	ts_tipo_horar                VARCHAR (10) NULL,
	ts_tipo_huella               catalogo NULL,
	ts_tipo_link                 CHAR (1) NULL,
	ts_tipo_nit                  CHAR (2) NULL,
	ts_tipo_operador             VARCHAR (10) NULL,
	ts_tipo_producto             TINYINT NULL,
	ts_tipo_recaudador           CHAR (1) NULL,
	ts_tipo_soc                  catalogo NULL,
	ts_tipo_transaccion          SMALLINT NOT NULL,
	ts_tipo_transaccion_producto INT NULL,
	ts_tipo_vinculacion          catalogo NULL,
	ts_tipo_vivienda             catalogo NULL,
	ts_toperacion                CHAR (1) NULL,
	ts_total_activos             MONEY NULL,
	ts_totaliza                  CHAR (1) NULL,
	ts_updlogin                  login NULL,
	ts_user                      login NULL,
	ts_usuario                   login NULL,
	ts_val_aval                  MONEY NULL,
	ts_valor                     descripcion NULL,
	ts_valor_spread              TINYINT NULL,
	ts_verificado                CHAR (1) NULL,
	ts_vinculacion               CHAR (1) NULL,
	ts_zona                      catalogo NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.cl_tran_servicio (ts_fecha,ts_ente)
go

