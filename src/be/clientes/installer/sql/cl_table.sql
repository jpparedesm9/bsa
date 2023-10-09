/*  Script de creacion de tablas modulo clientes  */

use cobis
go


IF OBJECT_ID ('dbo.rp_consolidacion_no_cli') IS NOT NULL
	DROP TABLE dbo.rp_consolidacion_no_cli
GO

CREATE TABLE rp_consolidacion_no_cli
    (
    cn_ced_ruc    numero,
    cn_nombre     char (100) not null,
    cn_fecha_tra  datetime not null,
    cn_tipo_tra   char (64) not null,
    cn_producto   char (3) not null,
    cn_cuenta     char (30) not null,
    cn_moneda     tinyint not null,
    cn_ingreso_mn money not null,
    cn_egreso_mn  money not null,
    cn_ingreso_me money not null,
    cn_egreso_me  money not null,
    cn_cotizacion float not null
    )
go



print '=====> rp_consolidacion_no_cli_Key'
go
CREATE CLUSTERED INDEX rp_consolidacion_no_cli_Key ON rp_consolidacion_no_cli
(
    cn_nombre ,
    cn_fecha_tra
)  ON indexgroup
go

IF OBJECT_ID ('dbo.rp_consolidacion') IS NOT NULL
	DROP TABLE dbo.rp_consolidacion
GO

CREATE TABLE rp_consolidacion
    (
    co_codigo        int not null,
    co_ced_ruc       numero,
    co_nombre        char (100),
    co_fecha_tra     datetime not null,
    co_tipo_tra      char (64) not null,
    co_producto      char (3) not null,
    co_cuenta        char (30) not null,
    co_moneda        tinyint not null,
    co_ingreso_mn    money not null,
    co_egreso_mn     money not null,
    co_ingreso_me    money not null,
    co_egreso_me     money not null,
    co_cotizacion    float not null,
    co_act_economica catalogo,
    co_exceptuado    char (1)
    )
go

print '=====> rp_consolidacion_Key'
go
CREATE CLUSTERED INDEX rp_consolidacion_Key ON rp_consolidacion
(
    co_fecha_tra ,
    co_codigo ,
    co_cuenta
)  ON indexgroup
go


print '=====> ico_act_codigo'
go
CREATE NONCLUSTERED INDEX ico_act_codigo ON rp_consolidacion
(
    co_act_economica ASC,
    co_codigo ASC,
    co_cuenta ASC,
    co_fecha_tra ASC
) ON indexgroup
go


IF OBJECT_ID ('dbo.productos_tmp') IS NOT NULL
	DROP TABLE dbo.productos_tmp
GO

CREATE TABLE productos_tmp
    (
    marca       char (1) not null,
    descripcion varchar (64) not null,
    producto    char (3),
    cuenta      cuenta,
    saldo       money,
    capital     money,
    interes     money,
    montoe      money,
    capitale    money,
    interese    money,
    naturaleza  varchar (1),
    apertura    datetime,
    secuencial  int
    )
go


IF OBJECT_ID ('dbo.mig_cifin') IS NOT NULL
	DROP TABLE dbo.mig_cifin
GO

CREATE TABLE mig_cifin
    (
    tipo_doc       char (2) not null,
    numero_doc     numero,
    tipo_per       char (1) not null,
    entidad        catalogo,
    calificacion   varchar (2),
    tipo_credito   catalogo,
    tipo_garantias catalogo,
    ndeudasml      int,
    deudaml        money,
    ndeudasme      int,
    deudame        money,
    total_deudas   money
    )
go


IF OBJECT_ID ('dbo.cl_ws_ente_tmp') IS NOT NULL
	DROP TABLE dbo.cl_ws_ente_tmp
GO

CREATE TABLE cl_ws_ente_tmp
    (
    we_secuencial       int IDENTITY not null,
    we_nomlar           varchar (254),
    we_ced_ruc          varchar (30),
    we_tip_ced          char (6),
    we_procedencia      char (2),
    we_nacional         varchar (100),
    we_p_apellido       varchar (16),
    we_s_apellido       varchar (16),
    we_nombres          varchar (64),
    we_genero           char (1),
    we_ecivil           char (1),
    we_edad_min         char (2),
    we_edad_max         char (2),
    we_id_estado        char (30),
    we_id_validada      char (2),
    we_id_fecha_exp     varchar (16),
    we_id_ciudad_exp    varchar (100),
    we_id_dpto_exp      varchar (100),
    we_ente_int         int,
    we_cod_fin_consulta char (2),
    we_fecha_consulta   varchar (16),
    we_hora_consulta    varchar (20),
    we_cod_ciiu         varchar (100),
    we_rango_edad       varchar (10),
    we_nro_inf          varchar (100),
    we_cod_ciudad       varchar (100),
    we_activid_econ     varchar (254),
    we_identificalinea  varchar (100),
    we_estado_dcto      varchar (30),
    we_tipo_registro    varchar (10)
    )
go

print '=====> idx1'
go
CREATE CLUSTERED INDEX idx1 ON cl_ws_ente_tmp
(
    we_secuencial ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_ws_alerta_tmp') IS NOT NULL
	DROP TABLE dbo.cl_ws_alerta_tmp
GO

CREATE TABLE cl_ws_alerta_tmp
    (
    wa_secuencial         int not null,
    wa_item               smallint not null,
    wa_fecha_colocacion   varchar (16),
    wa_fecha_vencimiento  varchar (16),
    wa_fecha_modificacion varchar (16),
    wa_codigo_alerta      varchar (5),
    wa_texto              varchar (400),
    wa_codifo_fuente      varchar (10),
    wa_desc_fuente        varchar (100),
    wa_tipo_registro      varchar (10),
    wa_identificalinea    varchar (100)
    )
go


print '=====> idx1'
go
CREATE NONCLUSTERED INDEX idx1 ON cl_ws_alerta_tmp
(
    wa_secuencial ASC,
    wa_tipo_registro ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_trn_bandom') IS NOT NULL
	DROP TABLE dbo.cl_trn_bandom
GO

CREATE TABLE cl_trn_bandom
    (
    tb_ente       int not null,
    tb_secuencial int not null,
    tb_fecha      datetime,
    tb_servicio   catalogo,
    tb_producto   tinyint,
    tb_cta_banco  cuenta,
    tb_moneda     tinyint,
    tb_usuario    login,
    tb_terminal   varchar (10),
    tb_filial     tinyint,
    tb_oficina    smallint
    )
go

IF OBJECT_ID ('dbo.cl_tran_servicio_conv_tel') IS NOT NULL
	DROP TABLE dbo.cl_tran_servicio_conv_tel
GO

CREATE TABLE cl_tran_servicio_conv_tel
    (
    te_ente          int not null,
    te_direccion     tinyint not null,
    te_secuencial    tinyint not null,
    te_valor         varchar (16),
    te_tipo_telefono char (1) not null,
    fecha_upd        datetime,
    archivo          varchar (50),
    operacion        char (1)
    )
go

print '=====> cl_tran_servicio_conv_tel_1'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_tel_1 ON cl_tran_servicio_conv_tel
(
    te_ente ASC,
    operacion ASC,
    fecha_upd ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_tran_servicio_conv_mer') IS NOT NULL
	DROP TABLE dbo.cl_tran_servicio_conv_mer
GO


CREATE TABLE cl_tran_servicio_conv_mer
    (
    mo_ente               int not null,
    mo_mercado_objetivo   catalogo,
    mo_subtipo_mo         catalogo,
    mo_fecha_registro     datetime,
    mo_fecha_modificacion datetime,
    mo_funcionario        login,
    fecha_upd             datetime,
    archivo               varchar (50),
    operacion             char (1)
    )
go

print '=====> cl_tran_servicio_conv_mer_1'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_mer_1 ON cl_tran_servicio_conv_mer
(
    mo_ente ASC,
    operacion ASC,
    fecha_upd ASC
) ON indexgroup
go




print '=====> cl_tran_servicio_conv_mer_2'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_mer_2 ON cl_tran_servicio_conv_mer
(
    fecha_upd ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_tran_servicio_conv_dir') IS NOT NULL
	DROP TABLE dbo.cl_tran_servicio_conv_dir
GO


CREATE TABLE cl_tran_servicio_conv_dir
    (
    di_ente               int not null,
    di_direccion          tinyint not null,
    di_descripcion        varchar (254),
    di_parroquia          smallint not null,
    di_ciudad             int not null,
    di_tipo               catalogo not null,
    di_telefono           tinyint,
    di_sector             catalogo,
    di_zona               catalogo,
    di_oficina            smallint,
    di_fecha_registro     datetime not null,
    di_fecha_modificacion datetime not null,
    di_vigencia           catalogo not null,
    di_verificado         char (1) not null,
    di_funcionario        login,
    di_fecha_ver          datetime,
    di_principal          char (1),
    di_barrio             varchar (40),
    di_provincia          smallint,
    fecha_upd             datetime,
    archivo               varchar (50),
    operacion             char (1)
    )
go


print '=====> cl_tran_servicio_conv_dir_1'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_dir_1 ON cl_tran_servicio_conv_dir
(
    di_ente ASC,
    operacion ASC,
    fecha_upd ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_tran_servicio_conv') IS NOT NULL
	DROP TABLE dbo.cl_tran_servicio_conv
GO


CREATE TABLE cl_tran_servicio_conv
    (
    en_ente              int not null,
    en_subtipo           char (1) not null,
    en_tipo_ced          char (2),
    en_ced_ruc           numero,
    c_sigla              varchar (25),
    en_nombre            descripcion not null,
    p_p_apellido         varchar (16),
    p_s_apellido         varchar (16),
    p_fecha_nac          datetime,
    p_sexo               sexo,
    en_fecha_crea        datetime,
    en_fecha_mod         datetime not null,
    en_actividad         catalogo,
    en_sector            catalogo,
    en_oficial           smallint,
    c_tipo_compania      catalogo,
    en_retencion         char (1) not null,
    en_oficina           smallint not null,
    en_filial            tinyint not null,
    en_mala_referencia   char (1) not null,
    en_direccion         tinyint,
    c_tipo_soc           catalogo,
    p_tipo_persona       catalogo,
    en_asosciada         catalogo,
    en_banca             catalogo,
    p_depa_nac           smallint,
    p_depa_emi           smallint,
    p_ciudad_nac         int,
    p_lugar_doc          int,
    en_exc_sipla         char (1),
    en_exc_por2          char (1),
    en_situacion_cliente catalogo,
    en_nomlar            varchar (254),
    en_pais              smallint,
    p_pais_emi           smallint,
    en_digito            char (1),
    fecha_upd            datetime,
    archivo              varchar (50),
    operacion            char (1)
    )
go



print '=====> cl_tran_servicio_conv_1'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_1 ON cl_tran_servicio_conv
(
    en_ente ASC,
    operacion ASC,
    fecha_upd ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_tran_bloqueada') IS NOT NULL
	DROP TABLE dbo.cl_tran_bloqueada
GO

CREATE TABLE cl_tran_bloqueada
    (
    tr_codproducto        tinyint not null,
    tr_abreviatura        char (3) not null,
    tr_descripcion        descripcion not null,
    tr_transaccion        int not null,
    tr_des_tran           descripcion not null,
    tr_estado             estado not null,
    tr_supervisor         char (1) not null,
    tr_tipo_evento        char (1) not null,
    tr_fecha_registro     datetime not null,
    tr_fecha_modificacion datetime,
    tr_funcionario        login
    )
go

print '=====> cl_tran_bloqueada_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_tran_bloqueada_Key ON cl_tran_bloqueada
(
    tr_codproducto ,
    tr_transaccion
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_trabajo') IS NOT NULL
	DROP TABLE dbo.cl_trabajo
GO

CREATE TABLE dbo.cl_trabajo
	(
	tr_persona            INT NOT NULL,
	tr_trabajo            TINYINT NOT NULL,
	tr_empresa            descripcion NOT NULL,
	tr_cargo              descripcion NOT NULL,
	tr_sueldo             MONEY NULL,
	tr_moneda             TINYINT NULL,
	tr_tipo               catalogo NULL,
	tr_fecha_registro     DATETIME NOT NULL,
	tr_fecha_modificacion DATETIME NOT NULL,
	tr_vigencia           CHAR (1) NOT NULL,
	tr_fecha_ingreso      DATETIME NULL,
	tr_fecha_salida       DATETIME NULL,
	tr_verificado         CHAR (1) NULL,
	tr_funcionario        login NULL,
	tr_fecha_verificacion DATETIME NULL,
	tr_tipo_empleo        catalogo NULL,
	tr_recpublicos        CHAR (1) NULL,
	tr_obs_verificado     VARCHAR (10) NULL,
	tr_nombre_emp         VARCHAR (64) NULL,
	tr_objeto_emp         VARCHAR (64) NULL,
	tr_direccion_emp      VARCHAR (254) NULL,
	tr_telefono           VARCHAR (20) NULL,
	tr_planilla           VARCHAR (6) NULL,
	tr_sub_cargo          descripcion NULL,
	tr_antiguedad         INT NULL,
	tr_iden_emp           VARCHAR (24) NULL,
	tr_tipo_emp           catalogo NULL,
	tr_actividad          CHAR (1) NULL,
	tr_cod_actividad      catalogo NULL,
	tr_func_public        catalogo NULL,
	tr_fuente_verif       VARCHAR (10) NULL,
	tr_actividad_ingresof INT NULL,
	tr_descripcion        VARCHAR (60) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_trabajo_Key
	ON dbo.cl_trabajo (tr_persona,tr_trabajo)
GO



IF OBJECT_ID ('dbo.cl_tplan') IS NOT NULL
	DROP TABLE dbo.cl_tplan
GO

CREATE TABLE cl_tplan
    (
    tp_tbalance   char (3) not null,
    tp_cuenta     int not null,
    tp_secuencial int not null
    )
go

print '=====> cl_tplan_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_tplan_Key ON cl_tplan
(
    tp_tbalance ,
    tp_cuenta
) ON indexgroup
go
IF OBJECT_ID ('dbo.cl_tplan_tmp') IS NOT NULL
	DROP TABLE dbo.cl_tplan_tmp
GO

CREATE TABLE cl_tplan_tmp
    (
    tpt_tbalance   char (3) not null,
    tpt_cuenta     int not null,
    tpt_usuario    login not null,
    tpt_terminal   varchar (32) not null,
    tpt_secuencial int not null
    )
go


print '=====> cl_tplan_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_tplan_tmp_Key ON cl_tplan_tmp
(
    tpt_usuario ,
    tpt_terminal ,
    tpt_tbalance ,
    tpt_cuenta
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_total_entes_log') IS NOT NULL
	DROP TABLE dbo.cl_total_entes_log
GO

CREATE TABLE cl_total_entes_log
    (
    tabla           varchar (25),
    fecha_proceso   datetime,
    nom_archivo     varchar (50),
    total_registros int,
    ejecutado       char (1)
    )
go



IF OBJECT_ID ('dbo.cl_tmp_fiduciaria') IS NOT NULL
	DROP TABLE dbo.cl_tmp_fiduciaria
GO

CREATE TABLE cl_tmp_fiduciaria
    (
    tipo          char (1),
    nombre        varchar (50),
    tipo_iden     char (3),
    nro_iden      numero not null,
    direccion     varchar (50),
    telefono      varchar (20),
    fax           varchar (10),
    naturaleza    char (1),
    grupo         int,
    nomgrupo      varchar (64),
    pais          smallint,
    dpto          smallint,
    ciudad        int,
    actividad     char (10),
    nomactividad  varchar (64),
    retefuente    char (1),
    contribuyente char (1),
    mail          varchar (50)
    )
go


IF OBJECT_ID ('dbo.cl_tipo_documento') IS NOT NULL
	DROP TABLE dbo.cl_tipo_documento
GO

CREATE TABLE cl_tipo_documento
    (
    	td_adicional	tinyint NULL,
		td_aperrapida	char(1) NULL,
		td_bloquea	char(1) NULL,
		td_codigo	char(4) NOT NULL,
		td_compuesto	char(1) NULL,
		td_creacion	char(1) NULL,
		td_desc_corta	varchar(10) NULL,
		td_descripcion	varchar(60) NOT NULL,
		td_digito	char(1) NULL,
		td_estado	char(1) NULL,
		td_habilitado_mis	char(1) NULL,
		td_habilitado_usu	char(1) NULL,
		td_mascara	varchar(20) NULL,
		td_nacionalidad	varchar(15) NULL,
		td_nro_compuesto	tinyint NULL,
		td_prefijo	varchar(10) NULL,
		td_provincia	char(1) NULL,
		td_secuencial	int NOT NULL,
		td_subfijo	varchar(10) NULL,
		td_tipoper	char(1) NULL
    )
go

IF OBJECT_ID ('dbo.cl_tiempo_mig') IS NOT NULL
	DROP TABLE dbo.cl_tiempo_mig
GO

CREATE TABLE cl_tiempo_mig
    (
    tm_archivo varchar (30) not null,
    tm_sp      varchar (30),
    tm_date    datetime,
    tm_user    login not null,
    tm_sesn    int not null
    )
go

IF OBJECT_ID ('dbo.cl_telefono_mig') IS NOT NULL
	DROP TABLE dbo.cl_telefono_mig
GO

CREATE TABLE cl_telefono_mig
    (
    tem_telefono1   varchar (16),
    tem_codigo_ente int,
    tem_direccion   tinyint,
    tem_secuencial  tinyint,
    tem_tipo        char (1),
    tem_error       smallint
    )
go


IF OBJECT_ID ('dbo.cl_telefono') IS NOT NULL
	DROP TABLE dbo.cl_telefono
GO

CREATE TABLE dbo.cl_telefono
	(
	te_ente               INT NOT NULL,
	te_direccion          TINYINT NOT NULL,
	te_secuencial         TINYINT NOT NULL,
	te_valor              VARCHAR (16) NULL,
	te_tipo_telefono      CHAR (1) NOT NULL,
	te_prefijo            VARCHAR (10) NULL,
	te_fecha_registro     DATETIME DEFAULT (getdate()) NULL,
	te_fecha_mod          DATETIME DEFAULT (getdate()) NULL,
	te_tipo_operador      VARCHAR (10) NULL,
	te_area               VARCHAR (10) NULL,
	te_telf_cobro         CHAR (1) NULL,
	te_funcionario        login NULL,
	te_verificado         CHAR (1) NULL,
	te_fecha_ver          DATETIME NULL,
	te_fecha_modificacion DATETIME NULL
	)
GO


print '=====> cl_telefono_Key'
go

CREATE UNIQUE CLUSTERED INDEX cl_telefono_Key
	ON dbo.cl_telefono (te_ente,te_direccion,te_secuencial)
GO

CREATE NONCLUSTERED INDEX i_t_tipo_telefono
	ON dbo.cl_telefono (te_ente,te_tipo_telefono)
GO

CREATE NONCLUSTERED INDEX valor_telefono
	ON dbo.cl_telefono (te_valor)
GO




IF OBJECT_ID ('dbo.cl_tbl_inf') IS NOT NULL
	DROP TABLE dbo.cl_tbl_inf
GO

CREATE TABLE cl_tbl_inf
    (
    ti_grp_inf      catalogo not null,
    ti_cod_tbl_inf  smallint not null,
    ti_desc_tbl_inf varchar (90) not null
    )
go

IF OBJECT_ID ('dbo.cl_tbalance') IS NOT NULL
	DROP TABLE dbo.cl_tbalance
GO


CREATE TABLE cl_tbalance
    (
    tb_tbalance      char (3) not null,
    tb_descripcion   descripcion not null,
    tb_estado        estado not null,
    tb_col_izquierda descripcion not null,
    tb_col_derecha   descripcion not null,
    tb_totaliza      char (1),
    tb_automatico    char (1),
    tb_tcliente      char (1)
    )
go

print '=====> cl_tbalance_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_tbalance_Key ON cl_tbalance
(
    tb_tbalance
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_soc_hecho') IS NOT NULL
	DROP TABLE dbo.cl_soc_hecho
GO

CREATE TABLE cl_soc_hecho
    (
    sh_ente               int not null,
    sh_secuencial         tinyint not null,
    sh_descripcion        varchar (254) not null,
    sh_tipo               catalogo not null,
    sh_fecha_registro     datetime not null,
    sh_fecha_modificacion datetime not null,
    sh_vigencia           catalogo not null,
    sh_verificado         char (1) not null,
    sh_funcionario        login,
    sh_fecha_ver          datetime
    )
go


print '=====> cl_soc_hecho_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_soc_hecho_Key ON cl_soc_hecho
(
    sh_ente ,
    sh_secuencial
) ON indexgroup
go


print '=====> i_sh_tipo'
go
CREATE NONCLUSTERED INDEX i_sh_tipo ON cl_soc_hecho
(
    sh_tipo ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_servicio_bandom') IS NOT NULL
	DROP TABLE dbo.cl_servicio_bandom
GO


CREATE TABLE cl_servicio_bandom
    (
    sb_codigo      catalogo not null,
    sb_descripcion descripcion not null,
    sb_producto    tinyint,
    sb_valor       money,
    sb_causal_cte  catalogo,
    sb_causal_aho  catalogo,
    sb_estado      estado
    )
go

IF OBJECT_ID ('dbo.cl_servicio') IS NOT NULL
	DROP TABLE dbo.cl_servicio
GO

CREATE TABLE cl_servicio
    (
    se_filial      tinyint not null,
    se_servicio    smallint not null,
    se_descripcion descripcion not null,
    se_estado      estado
    )
go

IF OBJECT_ID ('dbo.cl_sectoreco') IS NOT NULL
	DROP TABLE dbo.cl_sectoreco
GO


CREATE TABLE cl_sectoreco
    (
    se_sector             catalogo not null,
    se_descripcion        descripcion not null,
    se_max_riesgo         money not null,
    se_riesgo             money not null,
    se_usuario            login,
    se_fecha_registro     datetime,
    se_fecha_modificacion datetime,
    se_estado             estado,
    se_reservado          money
    )
go

print '=====> cl_sectoreco_Key'
go
CREATE CLUSTERED INDEX cl_sectoreco_Key ON cl_sectoreco
(
    se_sector
)  ON indexgroup
go

IF OBJECT_ID ('dbo.cl_rep_faltan_datos') IS NOT NULL
	DROP TABLE dbo.cl_rep_faltan_datos
GO

CREATE TABLE cl_rep_faltan_datos
    (
    rf_ente          int,
    rf_numero_error  int,
    rf_mensaje_error varchar (100)
    )
go

print '=====> i_ente_datos'
go
CREATE NONCLUSTERED INDEX i_ente_datos ON cl_rep_faltan_datos
(
    rf_ente ASC
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_relacion_inter') IS NOT NULL
	DROP TABLE dbo.cl_relacion_inter
GO

CREATE TABLE cl_relacion_inter
    (
    ri_relacion           int not null,
    ri_ente               int not null,
    ri_institucion        varchar (40),
    ri_tipo_relacion      catalogo,
    ri_num_producto       varchar (40),
    ri_moneda             varchar (10),
    ri_ciudad             varchar (65),
    ri_descripcion        descripcion,
    ri_fecha_desde        datetime,
    ri_pais               smallint,
    ri_fecha_registro     datetime,
    ri_fecha_modificacion datetime,
    ri_fecha_ver          datetime,
    ri_vigencia           char (1),
    ri_verificado         char (1),
    ri_funcionario        login,
    ri_monto              money
    )
go


print '=====> cl_relacion_inter_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_relacion_inter_Key ON cl_relacion_inter
(
    ri_ente ,
    ri_relacion
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_relacion') IS NOT NULL
	DROP TABLE dbo.cl_relacion
GO

CREATE TABLE dbo.cl_relacion
	(
	re_relacion    INT NOT NULL,
	re_descripcion descripcion NOT NULL,
	re_izquierda   descripcion NOT NULL,
	re_derecha     descripcion NOT NULL,
	re_tabla       SMALLINT NULL,
	re_catalogo    VARCHAR (10) NULL,
	re_atributo    TINYINT NOT NULL
	)
GO

print '=====> cl_relacion_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_relacion_Key
	ON dbo.cl_relacion (re_relacion)
GO



IF OBJECT_ID ('dbo.cl_refinh_tmp') IS NOT NULL
	DROP TABLE dbo.cl_refinh_tmp
GO

CREATE TABLE cl_refinh_tmp
    (
    int_codigo      int not null,
    int_documento   int not null,
    int_ced_ruc     char (13) not null,
    int_nombre      varchar (37) not null,
    int_fecha_ref   char (10) not null,
    int_origen      char (40) not null,
    int_observacion varchar (255) not null,
    int_fecha_mod   char (10) not null,
    in_subtipo      char (1) not null,
    in_p_p_apellido varchar (16),
    in_p_s_apellido varchar (16),
    in_tipo_ced     char (2),
    int_estado      catalogo
    )
go


IF OBJECT_ID ('dbo.cl_refinh') IS NOT NULL
	DROP TABLE dbo.cl_refinh
GO

CREATE TABLE cl_refinh
    (
    in_codigo       int not null,
    in_documento    int,
    in_ced_ruc      numero,
    in_nombre       varchar (64) not null,
    in_fecha_ref    datetime not null,
    in_origen       catalogo not null,
    in_observacion  varchar (255) not null,
    in_fecha_mod    datetime not null,
    in_subtipo      char (1) not null,
    in_p_p_apellido varchar (16),
    in_p_s_apellido varchar (16),
    in_tipo_ced     char (2),
    in_nomlar       char (64),
    in_estado       catalogo,
    in_sexo         char (1),
    in_usuario      login,
    in_aka          varchar (120),
    in_categoria    varchar (20),
    in_subcategoria varchar (20),
    in_fuente       varchar (20),
    in_otroid       varchar (20),
    in_pasaporte    varchar (20),
    in_concepto     varchar (100),
    in_entid        int
    )
go

print '=====> cl_refinh_Key'
go
CREATE NONCLUSTERED INDEX cl_refinh_Key ON cl_refinh
(
    in_nomlar,
    in_codigo
) ON indexgroup
go

print '=====> iin_entid'
go
CREATE CLUSTERED INDEX iin_entid ON cl_refinh
(
    in_entid ASC,
    in_codigo ASC
) ON indexgroup
go

print '=====> cl_refinh_idx1'
go
CREATE NONCLUSTERED INDEX cl_refinh_idx1 ON cl_refinh
(
    in_otroid
)
INCLUDE (   in_nombre,
    in_fecha_ref,
    in_origen,
    in_nomlar,
    in_estado)  ON indexgroup
go

print '=====> idx_categoria'
go
CREATE NONCLUSTERED INDEX idx_categoria ON cl_refinh
(
    in_categoria
) ON indexgroup
go

print '=====> iin_ced_ruc'
go
CREATE NONCLUSTERED INDEX iin_ced_ruc ON cl_refinh
(
    in_ced_ruc,
    in_origen DESC
)
INCLUDE (   in_fecha_ref,
    in_nomlar,
    in_estado)  ON indexgroup
go

print '=====> iin_fecha_mod'
go
CREATE NONCLUSTERED INDEX iin_fecha_mod ON cl_refinh
(
    in_fecha_mod
) ON indexgroup
go

print '=====> iin_in_ced_ruc'
go
CREATE NONCLUSTERED INDEX iin_in_ced_ruc ON cl_refinh
(
    in_ced_ruc ASC
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_referencia') IS NOT NULL
	DROP TABLE dbo.cl_referencia
GO

CREATE TABLE cl_referencia
    (
    re_ente               int not null,
    re_referencia         tinyint not null,
    re_tipo               char (1) not null,
    re_tipo_cifras        char (2),
    re_numero_cifras      tinyint,
    re_fecha_registro     datetime,
    re_calificacion       char (2),
    re_verificacion       char (1) not null,
    re_fecha_ver          datetime,
    re_fecha_modificacion datetime not null,
    re_vigencia           char (1) not null,
    re_observacion        varchar (254),
    re_funcionario        login,
    re_nacional           char (1),
    re_ciudad             int,
    re_sucursal           varchar (20),
    re_telefono           char (16),
    re_estado             catalogo,
    ec_tipo_cta           catalogo,
    ec_moneda             tinyint,
    ec_fec_apertura       datetime,
    ec_cuenta             varchar (20),
    ec_banco              int,
    monto                 money,
    ec_fec_exp_ref        datetime,
    fi_banco              int,
    fi_toperacion         char (1),
    fi_clase              descripcion,
    fi_fec_inicio         datetime,
    fi_fec_vencimiento    datetime,
    fi_estatus            char (1),
    fi_garantia           char (1),
    fi_cupo_usado         money,
    fi_monto_vencido      money,
    ta_banco              catalogo,
    ta_cuenta             varchar (30),
    ta_fec_apertura       datetime,
    co_institucion        descripcion,
    co_fecha_ingr_en_inst datetime,
    re_obs_verificado     varchar (10)
    )
go

print '=====> cl_referencia_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_referencia_Key ON cl_referencia
(
    re_ente ,
    re_tipo ,
    re_referencia
) ON indexgroup
go


print '=====> i_re_treferencia'
go
CREATE NONCLUSTERED INDEX i_re_treferencia ON cl_referencia
(
    re_tipo ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_ref_personal') IS NOT NULL
	DROP TABLE dbo.cl_ref_personal
GO

CREATE TABLE cl_ref_personal
    (
    rp_persona            int     not null,
    rp_referencia         tinyint not null,
    rp_nombre             varchar (60) not null,
    rp_p_apellido         varchar (32) not null,
    rp_s_apellido         varchar (20)     null,
    rp_direccion          direccion        null,
    rp_telefono_d         char (12)        null,
    rp_telefono_e         char (12)        null,
    rp_telefono_o         char (12)        null,
    rp_parentesco         catalogo not null,
    rp_fecha_registro     datetime not null,
    rp_fecha_modificacion datetime not null,
    rp_vigencia           char (1) not null,
    rp_verificacion       char (1) not null,
    rp_funcionario        login        null,
    rp_descripcion        varchar (64) null,
    rp_fecha_ver          datetime     null,
    rp_departamento       varchar (10) null,
    rp_ciudad             varchar (10) null,
    rp_barrio             varchar (10) null,
    rp_obs_verificado     varchar (10) null,
    rp_calle              varchar (80) null,
    rp_nro                int          null,
    rp_colonia            varchar (10) null,
    rp_localidad          varchar (10) null,
    rp_municipio          varchar (10) null,
    rp_estado             varchar (10) null,
    rp_codpostal          varchar (30) null,
    rp_pais               varchar (10) null,
    rp_tiempo_conocido    int          null,
    rp_direccion_e        varchar(40)  null
    )
go

print '=====> cl_ref_personal_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_ref_personal_Key ON cl_ref_personal
(
    rp_persona ,
    rp_referencia
) ON indexgroup
go

print '=====> i_rp_parentesco'
go
CREATE NONCLUSTERED INDEX i_rp_parentesco ON cl_ref_personal
(
    rp_parentesco ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_rango_empleo') IS NOT NULL
	DROP TABLE dbo.cl_rango_empleo
GO

CREATE TABLE cl_rango_empleo
    (
    re_tipo_empleo        catalogo not null,
    re_rango_min          smallint not null,
    re_rango_max          smallint not null,
    re_parametro_mul      smallint not null,
    re_rango_nor_min      smallint not null,
    re_rango_nor_max      smallint not null,
    re_fecha_registro     datetime not null,
    re_fecha_modificacion datetime,
    re_funcionario        login
    )
go

print '=====> cl_rango_empleo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_rango_empleo_Key ON cl_rango_empleo
(
    re_tipo_empleo ,
    re_rango_min ,
    re_rango_max
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_rango_actividad') IS NOT NULL
	DROP TABLE dbo.cl_rango_actividad
GO

CREATE TABLE cl_rango_actividad
    (
    ra_tipo_actividad     catalogo not null,
    ra_rango_min          int not null,
    ra_rango_max          int not null,
    ra_parametro_mul      smallint not null,
    ra_rango_nor_min      int not null,
    ra_rango_nor_max      int not null,
    ra_promedio_ventas    money,
    ra_fecha_registro     datetime not null,
    ra_fecha_modificacion datetime,
    ra_funcionario        login
    )
go

print '=====> cl_rango_actividad_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_rango_actividad_Key ON cl_rango_actividad
(
    ra_tipo_actividad ,
    ra_rango_min ,
    ra_rango_max
) ON indexgroup
go
IF OBJECT_ID ('dbo.cl_propiedad') IS NOT NULL
	DROP TABLE dbo.cl_propiedad
GO

CREATE TABLE cl_propiedad
    (
    pr_persona            int not null,
    pr_propiedad          tinyint not null,
    pr_descripcion        varchar (255) not null,
    pr_valor              money,
    pr_moneda             tinyint not null,
    pr_tgarantia          char (3),
    pr_tbien              char (3),
    pr_fecha_registro     datetime not null,
    pr_fecha_modificacion datetime not null,
    pr_vigencia           char (1) not null,
    pr_verificado         char (1) not null,
    pr_fec_avaluo         datetime,
    pr_funcionario        login,
    pr_fecha_ver          datetime,
    pr_gravada            money,
    pr_nom_aval           char (30),
    pr_gravamen_afavor    char (30),
    pr_val_aval           money,
    pr_ciudad             int,
    pr_notaria            tinyint,
    pr_matricula          char (16),
    pr_escritura          int,
    pr_fecha_escritura    datetime,
    pr_ciudad_inmueble    int,
    pr_tipo_veh           varchar (30),
    pr_placa              varchar (10),
    pr_modelo             varchar (30),
    pr_marca              varchar (30),
    pr_direccion_im       varchar (254),
    pr_area               float,
    pr_porcentaje         float,
    pr_saldo_deuda        money,
    pr_dpto_inm           varchar (10),
    pr_dpto_not           varchar (10),
    pr_afect_familiar     char (1),
    pr_obs_verificado     varchar (10)
    )
go

print '=====> cl_propiedad_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_propiedad_Key ON cl_propiedad
(
    pr_persona ,
    pr_propiedad
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_plano_ente_tmp') IS NOT NULL
	DROP TABLE dbo.cl_plano_ente_tmp
GO



CREATE TABLE cl_plano_ente_tmp
    (
    en_tipo_ced varchar (2) not null,
    en_ced_ruc  numero not null,
    en_ente     int not null
    )
go


print '=====> cl_plano_ente_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_plano_ente_tmp_Key ON cl_plano_ente_tmp
(
    en_tipo_ced ,
    en_ced_ruc ,
    en_ente
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_plano_consulta') IS NOT NULL
	DROP TABLE dbo.cl_plano_consulta
GO


CREATE TABLE cl_plano_consulta
    (
    pc_tipo_doc char (2),
    pc_num_doc  numero not null
    )
go

print '=====> cl_plano_consulta_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_plano_consulta_Key ON cl_plano_consulta
(
    pc_num_doc
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_plan_tmp') IS NOT NULL
	DROP TABLE dbo.cl_plan_tmp
GO


CREATE TABLE cl_plan_tmp
    (
    pl_cuenta int not null,
    pl_valor  money,
    pl_user   login,
    pl_term   varchar (30)
    )
go

print '=====> cl_plan_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_plan_tmp_Key ON cl_plan_tmp
(
    pl_user ,
    pl_term ,
    pl_cuenta
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_plan') IS NOT NULL
	DROP TABLE dbo.cl_plan
GO

CREATE TABLE cl_plan
    (
    pl_cliente int not null,
    pl_balance int not null,
    pl_cuenta  int not null,
    pl_valor   money
    )
go

print '=====> cl_plan_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_plan_Key ON cl_plan
(
    pl_cliente ,
    pl_balance ,
    pl_cuenta
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_perfil') IS NOT NULL
	DROP TABLE dbo.cl_perfil
GO

CREATE TABLE cl_perfil
    (
    pf_filial      tinyint not null,
    pf_servicio    smallint not null,
    pf_perfil      smallint not null,
    pf_descripcion descripcion not null,
    pf_atributos   tinyint not null,
    pf_estado      estado
    )
go

IF OBJECT_ID ('dbo.cl_otros_ingresos') IS NOT NULL
	DROP TABLE dbo.cl_otros_ingresos
GO

CREATE TABLE cl_otros_ingresos
    (
    oi_ente            int,
    oi_tipo            char (1),
    oi_valor           money,
    oi_descripcion     descripcion,
    oi_compania        descripcion,
    oi_num_poliza      varchar (14),
    oi_moneda          tinyint,
    oi_usuario         login,
    oi_fecha_ingreso   datetime,
    oi_fecha_modifi    datetime,
    oi_estado          catalogo,
    oi_cod_descripcion char (3)
    )
go

print '=====> cl_otros_ingresos_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_otros_ingresos_Key ON cl_otros_ingresos
(
    oi_ente ,
    oi_tipo ,
    oi_descripcion
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_origen_fondos') IS NOT NULL
	DROP TABLE dbo.cl_origen_fondos
GO

CREATE TABLE cl_origen_fondos
    (
    of_ente               int not null,
    of_origen_fondos      mensaje,
    of_producto           char (3),
    of_numero             cuenta,
    of_fecha_registro     datetime,
    of_fecha_modificacion datetime,
    of_funcionario        login,
    of_vigencia           varchar (10)
    )
go


print '=====> cl_origen_fondos_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_origen_fondos_Key ON cl_origen_fondos
(
    of_ente ,
    of_numero
) ON indexgroup
go


print '=====> cl_origen_fondos_Key1'
go
CREATE NONCLUSTERED INDEX cl_origen_fondos_Key1 ON cl_origen_fondos
(
    of_fecha_registro ,
    of_producto
)  ON indexgroup
go

IF OBJECT_ID ('dbo.cl_oficial_funcionario') IS NOT NULL
	DROP TABLE dbo.cl_oficial_funcionario
GO

CREATE TABLE cl_oficial_funcionario
    (
    of_nombre  descripcion,
    of_oficial smallint
    )
go

IF OBJECT_ID ('dbo.cl_objeto_tmp') IS NOT NULL
	DROP TABLE dbo.cl_objeto_tmp
GO

CREATE TABLE cl_objeto_tmp
    (
    ot_compania   int not null,
    ot_secuencial tinyint not null,
    ot_linea      varchar (255),
    ot_usuario    login not null,
    ot_terminal   varchar (32) not null
    )
go

print '=====> cl_objeto_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_objeto_tmp_Key ON cl_objeto_tmp
(
    ot_usuario ,
    ot_terminal ,
    ot_compania ,
    ot_secuencial
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_objeto_com') IS NOT NULL
	DROP TABLE dbo.cl_objeto_com
GO

CREATE TABLE cl_objeto_com
    (
    ob_compania   int not null,
    ob_secuencial tinyint not null,
    ob_linea      varchar (255)
    )
go

print '=====> cl_objeto_com_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_objeto_com_Key ON cl_objeto_com
(
    ob_compania ,
    ob_secuencial
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_nov_cli') IS NOT NULL
	DROP TABLE dbo.cl_nov_cli
GO

CREATE TABLE cl_nov_cli
    (
    nc_secuencial int,
    nc_oficina    smallint,
    nc_usuario    login,
    nc_persona    int,
    nc_tipoced    char (2),
    nc_cedula     numero,
    nc_nomlar     varchar (254),
    nc_clase      char (1),
    nc_fecha      datetime,
    nc_p_apellido descripcion,
    nc_modificado descripcion
    )
go

IF OBJECT_ID ('dbo.cl_notaria_ciudad') IS NOT NULL
	DROP TABLE dbo.cl_notaria_ciudad
GO

CREATE TABLE cl_notaria_ciudad
    (
    nc_notaria     int not null,
    nc_ciudad      int not null,
    nc_descripcion varchar (40) not null
    )
go

print '=====> cl_notaria_ciudad_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_notaria_ciudad_Key ON cl_notaria_ciudad
(
    nc_notaria ,
    nc_ciudad
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_nat_jur') IS NOT NULL
	DROP TABLE dbo.cl_nat_jur
GO

CREATE TABLE cl_nat_jur
    (
    nj_codigo      catalogo not null,
    nj_descripcion descripcion not null,
    nj_tipo        char (1) not null,
    nj_estado      estado not null
    )
go

print '=====> cl_nat_jur_Key'
go
CREATE CLUSTERED INDEX cl_nat_jur_Key ON cl_nat_jur
(
    nj_codigo ,
    nj_estado
)  ON indexgroup
go

IF OBJECT_ID ('dbo.cl_narcos_error') IS NOT NULL
	DROP TABLE dbo.cl_narcos_error
GO


CREATE TABLE cl_narcos_error
    (
    ne_codigo       int not null,
    ne_nombre       char (40) not null,
    ne_cedula       char (12) not null,
    ne_pasaporte    char (12) not null,
    ne_nacionalidad char (20) not null,
    ne_circular     char (12) not null,
    ne_fecha        char (12) not null,
    ne_provincia    char (15) not null,
    ne_juzgado      char (10) not null,
    ne_juicio       char (10) not null
    )
go

IF OBJECT_ID ('dbo.cl_mod_central_riesgo') IS NOT NULL
	DROP TABLE dbo.cl_mod_central_riesgo
GO

CREATE TABLE cl_mod_central_riesgo
    (
    cr_fec_modifi datetime not null,
    cr_secuencial int not null,
    cr_tipo_regis char (1) not null,
    cr_estado     char (1) not null,
    cr_ente       int,
    cr_tipo_docu  char (2),
    cr_num_docu   varchar (30),
    cr_tipo_per   char (1),
    cr_nombre     varchar (64),
    cr_p_apellido varchar (16),
    cr_s_apellido varchar (16),
    cr_sexo       char (1),
    cr_est_civil  varchar (10),
    cr_dpto_nac   smallint,
    cr_ciudad_nac int,
    cr_dpto_emi   smallint,
    cr_ciudad_emi int,
    cr_fec_emi    datetime
    )
go

print '=====> cl_mod_central_riesgo_Key1'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_mod_central_riesgo_Key1 ON cl_mod_central_riesgo
(
    cr_fec_modifi ,
    cr_secuencial ,
    cr_tipo_regis ,
    cr_estado ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_mobj_subtipo') IS NOT NULL
	DROP TABLE dbo.cl_mobj_subtipo
GO

CREATE TABLE cl_mobj_subtipo
    (
    ms_codigo      catalogo not null,
    ms_descripcion descripcion,
    ms_mobjetivo   catalogo,
    ms_banca       catalogo,
    ms_estado      char (1)
    )
go

print '=====> cl_mobj_subtipo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_mobj_subtipo_Key ON cl_mobj_subtipo
(
    ms_codigo ,
    ms_mobjetivo ,
    ms_banca
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_mercado_tmp') IS NOT NULL
	DROP TABLE dbo.cl_mercado_tmp
GO

CREATE TABLE cl_mercado_tmp
    (
    met_codigo       int not null,
    met_ced_ruc      char (13) not null,
    met_documento    char (13) not null,
    met_nombre       varchar (40) not null,
    met_fecha_ref    char (13) not null,
    met_calificador  char (40) not null,
    met_calificacion char (15) not null,
    met_fuente       char (40) not null,
    met_observacion  char (80) not null,
    met_estado       catalogo
    )
go

IF OBJECT_ID ('dbo.cl_mercado_objetivo_mig') IS NOT NULL
	DROP TABLE dbo.cl_mercado_objetivo_mig
GO

CREATE TABLE cl_mercado_objetivo_mig
    (
    mem_codigo_ente     int,
    mem_tipo_mercado    char (1),
    mem_subtipo_mercado char (3),
    mem_error           smallint
    )
go

IF OBJECT_ID ('dbo.cl_mercado_objetivo_cliente') IS NOT NULL
	DROP TABLE dbo.cl_mercado_objetivo_cliente
GO

CREATE TABLE cl_mercado_objetivo_cliente
    (
    mo_ente               int not null,
    mo_mercado_objetivo   catalogo,
    mo_subtipo_mo         catalogo,
    mo_fecha_registro     datetime,
    mo_fecha_modificacion datetime,
    mo_funcionario        login,
    mo_segmento           catalogo,
    mo_subsegmento        catalogo,
    mo_actprincipal       catalogo,
    mo_actividad2         catalogo,
    mo_actividad3         catalogo
    )
go

print '=====> cl_mercado_objetivo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_mercado_objetivo_Key ON cl_mercado_objetivo_cliente
(
    mo_ente
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_mercado_error') IS NOT NULL
	DROP TABLE dbo.cl_mercado_error
GO

CREATE TABLE cl_mercado_error
    (
    mer_proceso      char (1) not null,
    mer_error        int not null,
    mer_codigo       int not null,
    mer_ced_ruc      char (13) not null,
    mer_documento    char (13) not null,
    mer_nombre       varchar (40) not null,
    mer_fecha_ref    char (13) not null,
    mer_calificador  char (40) not null,
    mer_calificacion char (15) not null,
    mer_fuente       char (40) not null,
    mer_observacion  char (80) not null
    )
go

IF OBJECT_ID ('dbo.cl_mercado') IS NOT NULL
	DROP TABLE dbo.cl_mercado
GO

CREATE TABLE cl_mercado
    (
    me_codigo       int not null,
    me_ced_ruc      char (13) not null,
    me_documento    int not null,
    me_nombre       varchar (40) not null,
    me_fecha_ref    datetime not null,
    me_calificador  char (40) not null,
    me_calificacion char (15) not null,
    me_fuente       char (40) not null,
    me_observacion  char (80) not null,
    me_subtipo      char (1) not null,
    me_tipo_ced     char (2) not null,
    me_p_apellido   varchar (16),
    me_s_apellido   varchar (16),
    me_fecha_mod    datetime,
    me_estado       catalogo,
    me_nomlar       char (64),
    me_sexo         varchar (1)
    )
go

print '=====> cl_mercado_Key'
go
CREATE NONCLUSTERED INDEX cl_mercado_Key ON cl_mercado
(
    me_nomlar ,
    me_codigo
) ON indexgroup
go

print '=====> ime_ced_ruc'
go
CREATE CLUSTERED INDEX ime_ced_ruc ON cl_mercado
(
    me_ced_ruc ASC
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_mala_ref') IS NOT NULL
	DROP TABLE dbo.cl_mala_ref
GO

CREATE TABLE cl_mala_ref
    (
    mr_ente           int not null,
    mr_mala_ref       tinyint not null,
    mr_treferencia    catalogo not null,
    mr_fecha_registro datetime not null,
    mr_fecha_cov      char (12),
    mr_observacion    varchar (255),
    mr_funcionario    login
    )
go
print '=====> cl_mala_ref_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_mala_ref_Key ON cl_mala_ref
(
    mr_ente ,
    mr_treferencia
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_maestro_cliente') IS NOT NULL
	DROP TABLE dbo.cl_maestro_cliente
GO
CREATE TABLE cl_maestro_cliente
    (
    ma_subtipo           char (1),
    ma_ente              int not null,
    ma_tipo_ced          char (2),
    ma_ced_ruc           numero,
    ma_sexo              sexo,
    ma_profesion         descripcion,
    ma_estado_civil      descripcion,
    ma_actividad         descripcion,
    ma_sector            descripcion,
    ma_situacion_cliente descripcion,
    ma_tipo_vinculacion  descripcion,
    ma_nivel_estudio     descripcion,
    ma_tipo_vivienda     descripcion,
    ma_num_cargas        tinyint,
    ma_ocupacion         descripcion,
    ma_total_activos     money,
    ma_total_pasivos     money,
    ma_patrimonio_tec    money,
    ma_egresos           money,
    ma_ingresos          money,
    ma_pensionado        char (1),
    ma_categoria         descripcion,
    ma_tipo_compania     descripcion,
    ma_tipo_soc          descripcion,
    ma_num_empleados     smallint,
    ma_ciudad_dir_ppal   descripcion,
    ma_oficial           descripcion,
    ma_banca             descripcion,
    ma_mala_referencia   char (1),
    ma_cont_malas        smallint,
    ma_direccion_ppal    varchar (254),
    ma_nomlar            varchar (254),
    ma_cod_prof          catalogo,
    ma_cod_estciv        catalogo,
    ma_cod_act           catalogo,
    ma_cod_sect          catalogo,
    ma_cod_sitcl         catalogo,
    ma_cod_vinc          catalogo,
    ma_cod_estudio       catalogo,
    ma_cod_tipvi         catalogo,
    ma_cod_cat           catalogo,
    ma_cod_tcomp         catalogo,
    ma_cod_tsoc          catalogo,
    ma_cod_oficial       smallint,
    ma_cod_banca         catalogo,
    ma_cod_ciudad        int,
    ma_indicador         int
    )
go

print '=====> cl_maestro_cliente_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_maestro_cliente_Key ON cl_maestro_cliente
(
    ma_ente
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_log_homdir') IS NOT NULL
	DROP TABLE dbo.cl_log_homdir
GO

CREATE TABLE cl_log_homdir
    (
    loh_ente               int not null,
    loh_direccion          tinyint not null,
    loh_descripcion        varchar (254),
    loh_parroquia          smallint not null,
    loh_ciudad             int not null,
    loh_tipo               catalogo not null,
    loh_telefono           tinyint,
    loh_sector             catalogo,
    loh_zona               catalogo,
    loh_oficina            smallint,
    loh_fecha_registro     datetime not null,
    loh_fecha_modificacion datetime not null,
    loh_vigencia           catalogo not null,
    loh_verificado         char (1) not null,
    loh_funcionario        login,
    loh_fecha_ver          datetime,
    loh_principal          char (1),
    loh_barrio             varchar (40),
    loh_provincia          smallint
    )
go

IF OBJECT_ID ('dbo.cl_log_fiscal') IS NOT NULL
	DROP TABLE dbo.cl_log_fiscal
GO

CREATE TABLE cl_log_fiscal
    (
    lf_secuencial     int not null,
    lf_ente           int not null,
    lf_fecha_modifica datetime not null,
    lf_regimenf_ant   varchar (10),
    lf_regimenf_nue   varchar (10) not null,
    lf_usuario        varchar (14),
    lf_terminal       varchar (64)
    )
go


print '=====> cl_log_fiscal_key1'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_log_fiscal_key1 ON cl_log_fiscal
(
    lf_secuencial ASC
) ON indexgroup
go


print '=====> cl_log_fiscal_key2'
go
CREATE NONCLUSTERED INDEX cl_log_fiscal_key2 ON cl_log_fiscal
(
    lf_ente ASC,
    lf_fecha_modifica ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_log_errores_mig') IS NOT NULL
	DROP TABLE dbo.cl_log_errores_mig
GO

CREATE TABLE cl_log_errores_mig
    (
    ler_fuente     char (30) not null,
    ler_fila       int not null,
    ler_campo      char (30) not null,
    ler_dato       char (250) not null,
    ler_referencia int not null,
    ler_clave      int not null,
    ler_producto   tinyint not null
    )
go

IF OBJECT_ID ('dbo.cl_lista_clinton') IS NOT NULL
	DROP TABLE dbo.cl_lista_clinton
GO

CREATE TABLE cl_lista_clinton
    (
    lc_cod_ente int not null,
    lc_nomente  varchar (64) not null,
    lc_cod_ref  int not null,
    lc_nomref   char (64) not null,
    lc_error    varchar (64) not null
    )
go

IF OBJECT_ID ('dbo.cl_interfaz_tarjeta') IS NOT NULL
	DROP TABLE dbo.cl_interfaz_tarjeta
GO


CREATE TABLE cl_interfaz_tarjeta
    (
    en_ente        int not null,
    en_tipo_ced    varchar (2) not null,
    en_ced_ruc     numero not null,
    en_subtipo     char (1) not null,
    p_p_apellido   descripcion,
    p_s_apellido   descripcion,
    en_nombre      descripcion not null,
    p_fecha_nac    datetime,
    p_sexo         char (1),
    p_estado_civil varchar (10),
    en_oficina     smallint,
    dp_monto       money,
    dp_apartado_ec smallint,
    dp_cuenta      cuenta,
    dp_fecha       datetime,
    dp_novedad     char (1) not null
    )
go

IF OBJECT_ID ('dbo.cl_instancia') IS NOT NULL
	DROP TABLE dbo.cl_instancia
GO

CREATE TABLE cl_instancia
    (
    in_relacion smallint not null,
    in_ente_i   int not null,
    in_ente_d   int not null,
    in_lado     char (1) not null,
    in_fecha    datetime not null
    )
go

print '=====> cl_instancia_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_instancia_Key ON cl_instancia
(
    in_relacion ,
    in_ente_i ,
    in_ente_d
) ON indexgroup
go


print '=====> in_ented_Key'
go
CREATE NONCLUSTERED INDEX in_ented_Key ON cl_instancia
(
    in_ente_d ,
    in_ente_i
)  ON indexgroup
go


print '=====> in_entei_Key'
go
CREATE NONCLUSTERED INDEX in_entei_Key ON cl_instancia
(
    in_ente_i ,
    in_ente_d
)  ON indexgroup
go

IF OBJECT_ID ('dbo.cl_inh_error') IS NOT NULL
	DROP TABLE dbo.cl_inh_error
GO


CREATE TABLE cl_inh_error
    (
    ie_proceso     char (1) not null,
    ie_error       int not null,
    ie_codigo      int not null,
    ie_documento   int not null,
    ie_ced_ruc     char (13) not null,
    ie_nombre      char (37) not null,
    ie_fecha_ref   char (10) not null,
    ie_origen      char (40) not null,
    ie_observacion char (80) not null,
    ie_fecha_mod   char (10) not null
    )
go

IF OBJECT_ID ('dbo.cl_historico_vinculos') IS NOT NULL
	DROP TABLE dbo.cl_historico_vinculos
GO

CREATE TABLE cl_historico_vinculos
    (
    hv_codigo_cliente      int not null,
    hv_codigo_producto     tinyint not null,
    hv_mumero_operacion    varchar (35) not null,
    hv_fecha_terminacion   datetime not null,
    hv_fecha_inicio        datetime not null,
    hv_motivo_terminacion  catalogo not null,
    hv_tipo_vinculacion    char (1) not null,
    hv_login               login,
    hv_oficina_vinculacion smallint not null
    )
go

IF OBJECT_ID ('dbo.cl_his_relacion') IS NOT NULL
	DROP TABLE dbo.cl_his_relacion
GO

CREATE TABLE dbo.cl_his_relacion
	(
	hr_relacion   INT NOT NULL,
	hr_ente_i     INT NOT NULL,
	hr_ente_d     INT NOT NULL,
	hr_fecha_ini  DATETIME NOT NULL,
	hr_fecha_fin  DATETIME NOT NULL,
	hr_secuencial INT NULL
	)
GO

print '=====> cl_his_relacion_Key'
go
CREATE CLUSTERED INDEX cl_his_relacion_Key
	ON dbo.cl_his_relacion (hr_ente_i,hr_ente_d)
GO



IF OBJECT_ID ('dbo.cl_his_ejecutivo') IS NOT NULL
	DROP TABLE dbo.cl_his_ejecutivo
GO

CREATE TABLE cl_his_ejecutivo
    (
    ej_ente           int not null,
    ej_funcionario    int not null,
    ej_toficial       char (1) not null,
    ej_fecha_asig     datetime not null,
    ej_fecha_registro datetime not null
    )
go


print '=====> cl_his_ejecutivo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_his_ejecutivo_Key ON cl_his_ejecutivo
(
    ej_ente ,
    ej_funcionario ,
    ej_fecha_registro
) ON indexgroup
go

--cl_hijos
if not object_id('cl_hijos') is null
   drop table cl_hijos
go
print 'creacion cl_hijos'
CREATE TABLE cl_hijos  (
	hi_hijo              	int NOT NULL,
	hi_ente              	int NOT NULL,
	hi_conyuge           	int NULL,
	hi_nombre            	varchar(40) NOT NULL,
	hi_fecha_nac         	datetime NULL,
	hi_sexo              	sexo NULL,
	hi_tipo              	char(1) NULL,
	hi_papellido         	varchar(16) NULL,
	hi_sapellido         	varchar(16) NULL,
	hi_empresa           	varchar(24) NULL,
	hi_telefono          	varchar(16) NULL,
	hi_documento         	numero NULL,
	hi_tipo_doc          	char(4) NULL,
	hi_dep_doc           	int NULL,
	hi_mun_doc           	int NULL,
	hi_c_apellido        	varchar(20) NULL,
	hi_s_nombre          	varchar(20) NULL,
	hi_nit               	char(10) NULL,
	hi_fecha_expira      	datetime NULL,
	hi_lugar_doc         	int NULL,
	hi_cod_otro_pais     	char(10) NULL,
	hi_pasaporte         	varchar(20) NULL,
	hi_funcionario       	login NOT NULL,
	hi_fecha_registro    	datetime NOT NULL,
	hi_fecha_modificacion	datetime NULL,
	hi_digito            	char(2) NULL,
	hi_nacionalidad      	int NULL,
	hi_ciudad_nac        	int NULL,
	hi_area              	varchar(10) NULL
	)
GO
print '=====> cl_hijo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_hijo_Key
	ON cl_hijos(hi_ente, hi_hijo)
	ON [default]
GO

IF OBJECT_ID ('dbo.cl_grupo') IS NOT NULL
	DROP TABLE dbo.cl_grupo
GO

CREATE TABLE dbo.cl_grupo
	(
	gr_grupo               INT NOT NULL,
	gr_nombre              descripcion NOT NULL,
	gr_representante       INT NULL,
	gr_compania            INT NULL,
	gr_oficial             INT NULL,
	gr_fecha_registro      DATETIME NOT NULL,
	gr_fecha_modificacion  DATETIME NOT NULL,
	gr_ruc                 numero NULL,
	gr_vinculacion         CHAR (1) NULL,
	gr_tipo_vinculacion    catalogo NULL,
	gr_max_riesgo          MONEY NULL,
	gr_riesgo              MONEY NULL,
	gr_usuario             login NULL,
	gr_reservado           MONEY NULL,
	gr_tipo_grupo          catalogo NULL,
	gr_estado              catalogo NOT NULL,
	gr_dir_reunion         VARCHAR (125) NOT NULL,
	gr_dia_reunion         catalogo NOT NULL,
	gr_hora_reunion        DATETIME NOT NULL,
	gr_comportamiento_pago VARCHAR (10) NULL,
	gr_num_ciclo           INT NULL,
	gr_incluir             DATE NULL,
	gr_consec_tipo         VARCHAR (25) NULL,
	gr_suplente            VARCHAR (25) NULL,
	gr_tipo                CHAR (1) NULL,
	gr_cta_grupal          VARCHAR (30) NULL,
	gr_sucursal            INT NULL,
	gr_titular1            INT NULL,
	gr_titular2            INT NULL,
	gr_lugar_reunion       CHAR (10) NULL,
	gr_tiene_ctagr         CHAR (1) NULL,
	gr_tiene_ctain         CHAR (1) NULL,
	gr_gar_liquida         CHAR(1) NULL
	)
GO
print '=====> cl_grupo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_grupo_Key
	ON dbo.cl_grupo (gr_grupo)
GO





IF OBJECT_ID ('dbo.cl_garantia') IS NOT NULL
	DROP TABLE dbo.cl_garantia
GO

CREATE TABLE cl_garantia
    (
    ga_operacion int not null,
    ga_ente      int not null,
    ga_propiedad tinyint not null,
    ga_valor     money not null,
    ga_fecha     datetime,
    ga_estado    estado not null
    )
go

IF OBJECT_ID ('dbo.cl_func_correo') IS NOT NULL
	DROP TABLE dbo.cl_func_correo
GO

CREATE TABLE cl_func_correo
    (
    fc_documento varchar (30),
    fc_correo    varchar (254),
    fc_apellidos varchar (32),
    fc_nombre    varchar (64)
    )
go

IF OBJECT_ID ('dbo.cl_forma_homologa') IS NOT NULL
	DROP TABLE dbo.cl_forma_homologa
GO

CREATE TABLE cl_forma_homologa
    (
    fh_codproducto        tinyint,
    fh_abreviatura        char (3),
    fh_producto           descripcion,
    fh_forma_hom          catalogo,
    fh_descripcion        descripcion,
    fh_estado             estado,
    fh_fecha_registro     datetime,
    fh_fecha_modificacion datetime,
    fh_funcionario        login
    )
go

print '=====> cl_forma_homologa_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_forma_homologa_Key ON cl_forma_homologa
(
    fh_abreviatura ,
    fh_forma_hom ,
    fh_estado
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_estructura_tabla') IS NOT NULL
	DROP TABLE dbo.cl_estructura_tabla
GO

CREATE TABLE cl_estructura_tabla
    (
    et_tabla       varchar (60),
    et_codigo      smallint,
    et_descripcion varchar (250),
    et_tipo        varchar (60),
    et_longitud    smallint
    )
go

IF OBJECT_ID ('dbo.cl_estatuto_tmp') IS NOT NULL
	DROP TABLE dbo.cl_estatuto_tmp
GO

CREATE TABLE cl_estatuto_tmp
    (
    et_compania   int not null,
    et_secuencial tinyint not null,
    et_linea      varchar (255),
    et_usuario    login not null,
    et_terminal   varchar (32) not null
    )
go

print '=====> cl_estatuto_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_estatuto_tmp_Key ON cl_estatuto_tmp
(
    et_usuario ,
    et_terminal ,
    et_compania ,
    et_secuencial
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_estatuto_com') IS NOT NULL
	DROP TABLE dbo.cl_estatuto_com
GO


CREATE TABLE cl_estatuto_com
    (
    es_compania   int not null,
    es_secuencial tinyint not null,
    es_linea      varchar (255)
    )
go

print '=====> cl_estatuto_com_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_estatuto_com_Key ON cl_estatuto_com
(
    es_compania ,
    es_secuencial
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_est_convivencia') IS NOT NULL
	DROP TABLE dbo.cl_est_convivencia
GO

CREATE TABLE cl_est_convivencia
    (
    ec_fecha     datetime not null,
    ec_archivo   varchar (60) not null,
    ec_interfase int not null,
    ec_proceso   char (1) not null
    )
go

IF OBJECT_ID ('dbo.cl_errores_migracion') IS NOT NULL
	DROP TABLE dbo.cl_errores_migracion
GO

CREATE TABLE cl_errores_migracion
    (
    emi_error       int not null,
    emi_descripcion varchar (125) not null,
    emi_producto    tinyint not null
    )
go

IF OBJECT_ID ('dbo.cl_error_mig') IS NOT NULL
	DROP TABLE dbo.cl_error_mig
GO


CREATE TABLE cl_error_mig
    (
    er_user      login not null,
    er_sesn      int not null,
    er_date      datetime not null,
    er_num       int not null,
    er_msg       varchar (255) not null,
    er_secuencia int not null,
    er_sp        varchar (30) not null
    )
go

IF OBJECT_ID ('dbo.cl_errores_mig') IS NOT NULL
	DROP TABLE dbo.cl_errores_mig
GO

CREATE TABLE cl_errores_mig
    (
    er_referencia  int not null,
    er_descripcion varchar (255) not null
    )
go

IF OBJECT_ID ('dbo.cl_error_log') IS NOT NULL
	DROP TABLE dbo.cl_error_log
GO


CREATE TABLE cl_error_log
    (
    er_fecha_proc  datetime not null,
    er_error       int,
    er_usuario     login,
    er_tran        int,
    er_cuenta      cuenta,
    er_descripcion varchar (255)
    )
go

print '=====> cl_errorlog_1'
go
CREATE NONCLUSTERED INDEX cl_errorlog_1 ON cl_error_log
(
    er_fecha_proc ASC
) ON indexgroup
go



IF OBJECT_ID ('dbo.cl_error_elimente_log') IS NOT NULL
	DROP TABLE dbo.cl_error_elimente_log
GO

CREATE TABLE cl_error_elimente_log
    (
    ente          int not null,
    tipo_doc      varchar (2) not null,
    documento     numero not null,
    eliminado     char (1) not null,
    descripcion   varchar (64),
    fecha_proceso datetime
    )
go

IF OBJECT_ID ('dbo.cl_error_datosente') IS NOT NULL
	DROP TABLE dbo.cl_error_datosente
GO

CREATE TABLE cl_error_datosente
    (
    ed_fecha_proceso datetime,
    ed_ente          int,
    ed_tipo_ced      char (2),
    ed_ced_ruc       numero,
    ed_nombre        descripcion,
    ed_mensaje_error descripcion,
    ed_no_cta_cte    cuenta,
    ed_no_cta_aho    cuenta,
    ed_no_cdt        cuenta,
    ed_no_cartera    cuenta,
    ed_no_comex      cuenta,
    ed_no_tarjetas   cuenta
    )
go

IF OBJECT_ID ('dbo.cl_equivalencia_ws') IS NOT NULL
	DROP TABLE dbo.cl_equivalencia_ws
GO

CREATE TABLE cl_equivalencia_ws
    (
    eq_central       smallint not null,
    eq_tabla         varchar (24) not null,
    eq_codigo        varchar (50) not null,
    eq_codigo1       varchar (50),
    eq_equivalencia  varchar (10) not null,
    eq_equivalencia1 varchar (10) not null
    )
go

IF OBJECT_ID ('dbo.cl_ente_mig') IS NOT NULL
	DROP TABLE dbo.cl_ente_mig
GO

CREATE TABLE cl_ente_mig
    (
    em_user          login not null,
    em_sesn          int not null,
    em_archivo       varchar (30),
    em_secuencia     int,
    em_ente          int,
    em_nombre        varchar (64),
    em_p_p_apellido  varchar (16),
    em_p_s_apellido  varchar (16),
    em_p_fecha_nac   datetime,
    em_p_fecha_ing   datetime,
    em_p_fecha_mod   datetime,
    em_subtipo       char (1),
    em_ced_ruc       numero,
    em_sigla         varchar (25),
    em_actividad     catalogo,
    em_oficial       smallint,
    em_nat_jur       catalogo,
    em_retencion     char (1),
    em_oficina       smallint,
    em_comentario    smallint,
    em_departamento  smallint,
    em_ciudad        int,
    em_casilla       varchar (30),
    em_direccion     varchar (254),
    em_telefono1     varchar (16),
    em_telefono2     varchar (16),
    em_origen        catalogo,
    em_p_sexo        sexo,
    em_p_tipo_ced    char (2),
    em_sector        catalogo,
    em_estado_emp    catalogo,
    em_tipo_soc      catalogo,
    em_en_pais       smallint,
    em_p_pais_emi    smallint,
    em_p_depa_emi    smallint,
    em_p_depa_nac    smallint,
    em_p_ciudad_nac  int,
    em_p_lugar_doc   int,
    dm_direccion     tinyint,
    dm_descripcion   varchar (254),
    dm_parroquia     int,
    dm_ciudad        int,
    dm_tipo          catalogo,
    dm_telefono      tinyint,
    dm_sector        catalogo,
    dm_zona          catalogo,
    tm_secuencial    tinyint,
    tm_valor         varchar (12),
    tm_tipo_telefono char (1)
    )
go

IF OBJECT_ID ('dbo.cl_ente_masivo_mig') IS NOT NULL
	DROP TABLE dbo.cl_ente_masivo_mig
GO

CREATE TABLE cl_ente_masivo_mig
    (
    emm_secuencial     int,
    emm_tipo_per       char (1),
    emm_tipo_doc       char (2),
    emm_num_doc        varchar (16),
    emm_sigla          varchar (25),
    emm_nombre         varchar (64),
    emm_p_apellido     varchar (16),
    emm_s_apellido     varchar (16),
    emm_fecha_nacim    varchar (10),
    emm_sexo           char (1),
    emm_fecha_ingreso  varchar (10),
    emm_fecha_modifica varchar (10),
    emm_actividad_ciiu varchar (6),
    emm_sector         char (6),
    emm_gerente        varchar (4),
    emm_estado_emp     varchar (3),
    emm_naturaleza_ju  varchar (3),
    emm_tipo_sociedad  char (3),
    emm_retencion      char (1),
    emm_oficina        varchar (5),
    emm_origen         char (3),
    emm_regimen_fiscal char (4),
    emm_codigo_ente    int,
    emm_tipo_banca     char (1),
    emm_tipo_tran      int,
    emm_num_control    int,
    emm_cod_error      int,
    emm_msg_error      varchar (150),
    emm_posicion       int,
    emm_error          smallint
    )
go

IF OBJECT_ID ('dbo.cl_ente') IS NOT NULL
	DROP TABLE dbo.cl_ente
GO

CREATE TABLE dbo.cl_ente
	(
	en_ente                 INT NOT NULL,
	en_nombre               descripcion NOT NULL,
	en_subtipo              CHAR (1) NOT NULL,
	en_filial               TINYINT NOT NULL,
	en_oficina              SMALLINT NOT NULL,
	en_ced_ruc              numero NULL,
	en_fecha_crea           DATETIME NULL,
	en_fecha_mod            DATETIME NOT NULL,
	en_direccion            TINYINT NULL,
	en_referencia           TINYINT NULL,
	en_casilla              TINYINT NULL,
	en_casilla_def          VARCHAR (24) NULL,
	en_tipo_dp              CHAR (1) NULL,
	en_balance              SMALLINT NULL,
	en_grupo                INT NULL,
	en_pais                 SMALLINT NULL,
	en_oficial              SMALLINT NULL,
	en_actividad            catalogo NULL,
	en_retencion            CHAR (1) NOT NULL,
	en_mala_referencia      CHAR (1) NOT NULL,
	en_comentario           VARCHAR (254) NULL,
	en_cont_malas           SMALLINT NULL,
	s_tipo_soc_hecho        catalogo NULL,
	en_tipo_ced             CHAR (4) NOT NULL,
	en_sector               catalogo NULL,
	en_referido             SMALLINT NULL,
	en_nit                  numero NULL,
	en_doc_validado         CHAR (1) NULL,
	en_rep_superban         CHAR (1) NULL,
	p_p_apellido            VARCHAR (16) NULL,
	p_s_apellido            VARCHAR (16) NULL,
	p_sexo                  sexo NULL,
	p_fecha_nac             DATETIME NULL,
	p_ciudad_nac            INT NULL,
	p_lugar_doc             INT NULL,
	p_profesion             catalogo NULL,
	p_otro_profesion        VARCHAR (30) NULL,
	p_pasaporte             VARCHAR (20) NULL,
	p_estado_civil          catalogo NULL,
	p_num_cargas            TINYINT NULL,
	p_num_hijos             TINYINT NULL,
	p_nivel_ing             MONEY NULL,
	p_nivel_egr             MONEY NULL,
	p_nivel_estudio         catalogo NULL,
	p_tipo_persona          catalogo NULL,
	p_tipo_vivienda         catalogo NULL,
	p_calif_cliente         catalogo NULL,
	p_personal              TINYINT NULL,
	p_propiedad             TINYINT NULL,
	p_trabajo               TINYINT NULL,
	p_soc_hecho             TINYINT NULL,
	p_fecha_emision         DATETIME NULL,
	p_fecha_expira          DATETIME NULL,
	c_cap_suscrito          MONEY NULL,
	en_asosciada            catalogo NULL,
	c_posicion              catalogo NULL,
	c_tipo_compania         catalogo NULL,
	c_rep_legal             INT NULL,
	c_activo                MONEY NULL,
	c_pasivo                MONEY NULL,
	c_es_grupo              CHAR (1) NULL,
	c_capital_social        MONEY NULL,
	c_reserva_legal         MONEY NULL,
	c_fecha_const           DATETIME NULL,
	en_nomlar               VARCHAR (254) NULL,
	c_plazo                 TINYINT NULL,
	c_direccion_domicilio   INT NULL,
	c_fecha_inscrp          DATETIME NULL,
	c_fecha_aum_capital     DATETIME NULL,
	c_cap_pagado            MONEY NULL,
	c_tipo_nit              CHAR (1) NULL,
	c_tipo_soc              catalogo NULL,
	c_total_activos         MONEY NULL,
	c_num_empleados         SMALLINT NULL,
	c_sigla                 VARCHAR (25) NULL,
	c_escritura             INT NULL,
	c_notaria               TINYINT NULL,
	c_ciudad                INT NULL,
	c_fecha_exp             DATETIME NULL,
	c_fecha_vcto            DATETIME NULL,
	c_camara                catalogo NULL,
	c_registro              INT NULL,
	c_grado_soc             catalogo NULL,
	c_fecha_registro        DATETIME NULL,
	c_fecha_modif           DATETIME NULL,
	c_fecha_verif           DATETIME NULL,
	c_vigencia              catalogo NULL,
	c_verificado            CHAR (10) NULL,
	c_funcionario           login NULL,
	en_situacion_cliente    catalogo NULL,
	en_patrimonio_tec       MONEY NULL,
	en_fecha_patri_bruto    DATETIME NULL,
	en_gran_contribuyente   CHAR (1) NULL,
	en_calificacion         catalogo NULL,
	en_reestructurado       catalogo NULL,
	en_concurso_acreedores  catalogo NULL,
	en_concordato           catalogo NULL,
	en_vinculacion          CHAR (1) NULL,
	en_tipo_vinculacion     catalogo NULL,
	en_oficial_sup          SMALLINT NULL,
	en_cliente              CHAR (1) NULL,
	en_preferen             CHAR (1) NULL,
	c_edad_laboral_promedio FLOAT NULL,
	c_empleados_ley_50      FLOAT NULL,
	en_exc_sipla            CHAR (1) NULL,
	en_exc_por2             CHAR (1) NULL,
	en_digito               CHAR (1) NULL,
	p_depa_nac              SMALLINT NULL,
	p_pais_emi              SMALLINT NULL,
	p_depa_emi              SMALLINT NULL,
	en_categoria            catalogo NULL,
	en_emala_referencia     catalogo NULL,
	en_banca                catalogo NULL,
	c_total_pasivos         MONEY NULL,
	en_pensionado           CHAR (1) NULL,
	en_rep_sib              CHAR (1) NULL,
	en_max_riesgo           MONEY NULL,
	en_riesgo               MONEY NULL,
	en_mries_ant            MONEY NULL,
	en_fmod_ries            DATETIME NULL,
	en_user_ries            login NULL,
	en_reservado            MONEY NULL,
	en_pas_finan            MONEY NULL,
	en_fpas_finan           DATETIME NULL,
	en_fbalance             DATETIME NULL,
	en_relacint             CHAR (1) NULL,
	en_otringr              VARCHAR (10) NULL,
	en_exento_cobro         CHAR (1) NULL,
	en_doctos_carpeta       CHAR (1) NULL,
	en_oficina_prod         SMALLINT NULL,
	en_accion               VARCHAR (10) NULL,
	en_procedencia          VARCHAR (10) NULL,
	en_fecha_negocio        DATETIME NULL,
	en_estrato              VARCHAR (10) NULL,
	en_recurso_pub          CHAR (1) NULL,
	en_influencia           CHAR (1) NULL,
	en_persona_pub          CHAR (1) NULL,
	en_victima              CHAR (1) NULL,
	en_bancarizado          CHAR (1) NULL,
	en_alto_riesgo          CHAR (1) NULL,
	en_fecha_riesgo         DATETIME NULL,
	en_estado               CHAR (2) NULL,
	p_c_apellido            VARCHAR (20) NULL,
	p_s_nombre              VARCHAR (30) NULL,
	en_calif_cartera        INT NULL,
	en_cod_otro_pais        CHAR (10) NULL,
	en_ingre                VARCHAR (10) NULL,
	en_nacionalidad         INT NULL,
	p_dep_doc               INT NULL,
	p_numord                VARCHAR (4) NULL,
	c_razon_social          VARCHAR (128) NULL,
	c_segmento              CHAR (10) NULL,
	en_cem                  MONEY NULL,
	en_promotor             CHAR (10) NULL,
	en_inss                 VARCHAR (20) NULL,
	en_licencia             VARCHAR (30) NULL,
	en_id_tutor             VARCHAR (20) NULL,
	en_nom_tutor            VARCHAR (60) NULL,
	en_referidor_ecu        INT NULL,
	p_carg_pub              VARCHAR (10) NULL,
	p_rel_carg_pub          VARCHAR (10) NULL,
	p_situacion_laboral     VARCHAR (5) NULL,
	p_bienes                CHAR (1) NULL,
	en_otros_ingresos       MONEY NULL,
	en_origen_ingresos      descripcion NULL,
	c_codsuper              CHAR (10) NULL,
	en_nro_ciclo            INT NULL,
	en_emproblemado         CHAR (1) NULL,
	en_dinero_transac       MONEY NULL,
	en_manejo_doc           VARCHAR (25) NULL,
	en_persona_pep          CHAR (1) NULL,
	en_rfc                  VARCHAR (30) NULL,
	en_ing_SN               CHAR (1) NULL,
	en_nac_aux              VARCHAR (10) NULL,
	en_banco                VARCHAR (20) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_ente_Key
	ON dbo.cl_ente (en_ente)
GO

CREATE NONCLUSTERED INDEX cl_ente_idx1
	ON dbo.cl_ente (en_grupo,en_ente,en_ced_ruc,en_tipo_ced)
GO

CREATE NONCLUSTERED INDEX ien_fecha_crea
	ON dbo.cl_ente (en_oficina,en_fecha_crea,en_filial,en_cliente)
GO

CREATE NONCLUSTERED INDEX ien_nombre
	ON dbo.cl_ente (p_p_apellido,p_s_apellido,en_nombre)
GO

CREATE NONCLUSTERED INDEX ien_nomlar
	ON dbo.cl_ente (en_nomlar)
GO

CREATE NONCLUSTERED INDEX ien_subtipo
	ON dbo.cl_ente (en_subtipo)
GO

CREATE NONCLUSTERED INDEX ien_subtipo_cedruc
	ON dbo.cl_ente (en_ced_ruc)
GO

CREATE UNIQUE NONCLUSTERED INDEX idocIdentidad
	ON dbo.cl_ente (en_tipo_ced,en_ced_ruc)
GO

PRINT 'creacion del indice sobre el rfc'
go
IF EXISTS(SELECT 1 FROM sysindexes WHERE id = object_id('cl_ente')
	AND first        IS NOT NULL AND name = 'idx_rfc')
begin
	print' eliminando indice'
	DROP INDEX cl_ente.idx_rfc
end
go
	print' creando indice'
	CREATE INDEX idx_rfc ON cl_ente(en_rfc)


GO


IF OBJECT_ID ('dbo.cl_elimina_ente_log') IS NOT NULL
	DROP TABLE dbo.cl_elimina_ente_log
GO

CREATE TABLE cl_elimina_ente_log
    (
    elm_codigo_ente     int not null,
    elm_subtipo         char (1),
    elm_tipo_doc        char (2),
    elm_num_doc         varchar (30) not null,
    elm_sigla           varchar (25),
    elm_nombre          varchar (64),
    elm_p_apellido      varchar (16),
    elm_s_apellido      varchar (16),
    elm_fecha_nacim     datetime,
    elm_sexo            char (1),
    elm_fecha_ingreso   datetime,
    elm_fecha_modifica  datetime,
    elm_actividad_ciiu  varchar (6),
    elm_sector          varchar (10),
    elm_gerente         smallint,
    elm_estado_emp      varchar (10),
    elm_tipo_compania   varchar (10),
    elm_tipo_sociedad   varchar (10),
    elm_retencion       char (1),
    elm_oficina         smallint,
    elm_tipo_per        varchar (10),
    elm_regimen_fiscal  varchar (10),
    elm_tipo_banca      varchar (10),
    elm_telefono        varchar (16),
    elm_tipo            char (1),
    elm_dpto_dir        smallint,
    elm_ciudad_dir      int,
    elm_direccion       varchar (254),
    elm_tipo_mercado    varchar (10),
    elm_subtipo_mercado varchar (10),
    elm_descripcion     varchar (64),
    elm_fecha_proceso   datetime
    )
go

IF OBJECT_ID ('dbo.cl_ejecutivo') IS NOT NULL
	DROP TABLE dbo.cl_ejecutivo
GO

CREATE TABLE cl_ejecutivo
    (
    ej_ente        int not null,
    ej_funcionario int not null,
    ej_toficial    char (1) not null,
    ej_fecha_asig  datetime not null
    )
go

print '=====> cl_ejecutivo_Key'
go
CREATE NONCLUSTERED INDEX cl_ejecutivo_Key ON cl_ejecutivo
(
    ej_ente
)  ON indexgroup
go

IF OBJECT_ID ('dbo.cl_direccion_mig') IS NOT NULL
	DROP TABLE dbo.cl_direccion_mig
GO

CREATE TABLE cl_direccion_mig
    (
    dim_departamento varchar (3),
    dim_ciudad_dir   varchar (6),
    dim_direccion    varchar (254),
    dim_codigo_ente  int,
    dim_error        smallint
    )
go

IF OBJECT_ID ('dbo.cl_direccion') IS NOT NULL
	DROP TABLE dbo.cl_direccion
GO

CREATE TABLE dbo.cl_direccion
	(
	di_ente               INT NOT NULL,
	di_direccion          TINYINT NOT NULL,
	di_descripcion        VARCHAR (254) NULL,
	di_parroquia          INT NULL,
	di_ciudad             INT NULL,
	di_tipo               catalogo NOT NULL,
	di_telefono           TINYINT NULL,
	di_sector             catalogo NULL,
	di_zona               catalogo NULL,
	di_oficina            SMALLINT NULL,
	di_fecha_registro     DATETIME NOT NULL,
	di_fecha_modificacion DATETIME NOT NULL,
	di_vigencia           catalogo NOT NULL,
	di_verificado         CHAR (1) NOT NULL,
	di_funcionario        login NULL,
	di_fecha_ver          DATETIME NULL,
	di_principal          CHAR (1) NULL,
	di_barrio             VARCHAR (40) NULL,
	di_provincia          SMALLINT NULL,
	di_tienetel           CHAR (1) NULL,
	di_rural_urb          CHAR (1) NULL,
	di_observacion        VARCHAR (80) NULL,
	di_obs_verificado     VARCHAR (10) NULL,
	di_extfin             CHAR (1) NULL,
	di_pais               SMALLINT NULL,
	di_departamento       VARCHAR (10) NULL,
	di_tipo_prop          CHAR (10) NULL,
	di_rural_urbano       CHAR (1) NULL,
	di_codpostal          VARCHAR (30) NULL,
	di_casa               VARCHAR (40) NULL,
	di_calle              VARCHAR (70) NULL,
	di_codbarrio          INT NULL,
	di_correspondencia    CHAR (1) NULL,
	di_alquilada          CHAR (1) NULL,
	di_cobro              CHAR (1) NULL,
	di_otrasenas          VARCHAR (254) NULL,
	di_canton             INT NULL,
	di_distrito           INT NULL,
	di_montoalquiler      MONEY NULL,
	di_edificio           VARCHAR (40) NULL,
	di_so_igu_co          CHAR (1) NULL,
	di_fact_serv_pu       CHAR (1) NULL,
	di_nombre_agencia     VARCHAR (20) NULL,
	di_fuente_verif       VARCHAR (10) NULL,
	di_tiempo_reside      INT NULL,
	di_nro                INT NULL,
	di_nro_residentes     INT NULL,
	di_nro_interno        INT NULL,
	di_negocio            int null,
	di_poblacion          CHAR(30) NULL,
	di_referencia		  varchar(250)null
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_direccion_Key
	ON dbo.cl_direccion (di_ente,di_direccion)
GO

CREATE NONCLUSTERED INDEX cl_direccion_key3
	ON dbo.cl_direccion (di_tipo,di_ciudad,di_parroquia,di_oficina)
GO

CREATE NONCLUSTERED INDEX i_d_parroquia
	ON dbo.cl_direccion (di_ciudad,di_parroquia)
GO

create nonclustered index i_d_descripcion 
    on dbo.cl_direccion (di_descripcion,di_tipo)
end


IF OBJECT_ID ('dbo.cl_dgeografica') IS NOT NULL
	DROP TABLE dbo.cl_dgeografica
GO


CREATE TABLE cl_dgeografica
    (
    dg_pais      smallint not null,
    dg_regnat    char (2) not null,
    dg_regope    char (3) not null,
    dg_provincia smallint not null,
    dg_ciudad    int not null,
    dg_parroquia smallint not null,
    dg_zona      char (3),
    dg_numero    int not null
    )
go

IF OBJECT_ID ('dbo.cl_dgeobanca') IS NOT NULL
	DROP TABLE dbo.cl_dgeobanca
GO

CREATE TABLE cl_dgeobanca
    (
    dg_banca   catalogo not null,
    dg_oficial smallint not null,
    dg_numero  int not null
    )
go

IF OBJECT_ID ('dbo.cl_dgarantia') IS NOT NULL
	DROP TABLE dbo.cl_dgarantia
GO

CREATE TABLE cl_dgarantia
    (
    dg_documento   int not null,
    dg_tdocumento  char (3) not null,
    dg_fecha_reg   datetime not null,
    dg_funcionario login not null,
    dg_oficina     smallint not null,
    dg_ente        int not null,
    dg_propiedad   tinyint not null,
    dg_fecha_cert  datetime,
    dg_notaria     descripcion,
    dg_desc_larga  varchar (255)
    )
go

IF OBJECT_ID ('dbo.cl_detalle_maestro') IS NOT NULL
	DROP TABLE dbo.cl_detalle_maestro
GO

CREATE TABLE cl_detalle_maestro
    (
    dm_producto    tinyint,
    dm_descripcion descripcion,
    dm_cuenta      cuenta,
    dm_monto       money
    )
go

IF OBJECT_ID ('dbo.cl_det_producto_no_cobis_tmp') IS NOT NULL
	DROP TABLE dbo.cl_det_producto_no_cobis_tmp
GO

CREATE TABLE cl_det_producto_no_cobis_tmp
    (
    dp_det_producto   int not null,
    dp_filial         tinyint,
    dp_oficina        smallint not null,
    dp_producto       tinyint not null,
    dp_tipo           char (1) not null,
    dp_moneda         tinyint not null,
    dp_fecha          datetime not null,
    dp_comentario     descripcion,
    dp_monto          money,
    dp_tiempo         smallint,
    dp_cuenta         cuenta,
    dp_estado_ser     char (1) not null,
    dp_autorizante    smallint,
    dp_oficial_cta    smallint not null,
    dp_cliente_ec     int,
    dp_direccion_ec   int,
    dp_descripcion_ec direccion,
    dp_sector         char (3),
    dp_zona           char (3),
    dp_tipo_producto  char (1),
    dp_valor_inicial  money,
    dp_valor_promedio money,
    dp_fecha_prox_ven datetime,
    dp_rol_cliente    char (5),
    dp_fecha_cambio   datetime
    )
go

IF OBJECT_ID ('dbo.cl_det_producto_no_cobis') IS NOT NULL
	DROP TABLE dbo.cl_det_producto_no_cobis
GO

CREATE TABLE cl_det_producto_no_cobis
    (
    dp_det_producto           int not null,
    dp_numero_operacion       int not null,
    dp_numero_operacion_banco varchar (24) not null,
    dp_tipo_operacion         varchar (10) not null,
    dp_codigo_producto        tinyint not null,
    dp_codigo_cliente         int not null,
    dp_oficina                smallint not null,
    dp_moneda                 tinyint not null,
    dp_monto                  money not null,
    dp_tasa                   float,
    dp_periodicidad           smallint,
    dp_modalidad              varchar (1),
    dp_fecha_concesion        datetime not null,
    dp_fecha_vencimiento      datetime not null,
    dp_dias_vto_div           int,
    dp_fecha_vto_div          datetime,
    dp_reestructuracion       varchar (1),
    dp_fecha_reest            datetime,
    dp_num_cuota_reest        smallint,
    dp_no_renovacion          int not null,
    dp_codigo_destino         varchar (10) not null,
    dp_clase_cartera          varchar (10) not null,
    dp_codigo_geografico      int not null,
    dp_fecha_prox_vto         datetime,
    dp_saldo_prox_vto         money,
    dp_saldo_cap              money not null,
    dp_saldo_int              money not null,
    dp_saldo_otros            money not null,
    dp_saldo_int_contingente  money not null,
    dp_estado_contable        tinyint not null,
    dp_estado_desembolso      varchar (1),
    dp_estado_terminos        varchar (1),
    dp_calificacion           varchar (10),
    dp_linea_credito          varchar (24),
    dp_periodicidad_cuota     smallint,
    dp_edad_mora              int,
    dp_valor_mora             money,
    dp_fecha_pago             datetime,
    dp_valor_cuota            money,
    dp_cuotas_pag             smallint,
    dp_estado_cartera         tinyint,
    dp_plazo_dias             int,
    dp_fecha_reg              datetime,
    dp_gerente                smallint not null,
    dp_num_cuotaven           smallint,
    dp_saldo_cuotaven         money,
    dp_admisible              varchar (1),
    dp_num_cuotas             smallint,
    dp_tipo_tarjeta           varchar (2),
    dp_clase_tarjeta          varchar (6),
    dp_tipo_bloqueo           varchar (1),
    dp_fecha_bloqueo          datetime,
    dp_fecha_cambio           datetime,
    dp_ciclo_fact             datetime,
    dp_valor_ult_pago         money,
    dp_fecha_castigo          datetime,
    dp_tipo_reg               varchar (1),
    dp_procesado              varchar (1),
    dp_num_acta               varchar (24),
    dp_gracia_cap             smallint,
    dp_gracia_int             smallint,
    dp_bloqueo_cartera        varchar (1),
    dp_fecha_bloqueo_car      datetime,
    dp_saldo_facturacion      money
    )
go

IF OBJECT_ID ('dbo.cl_det_producto') IS NOT NULL
	DROP TABLE dbo.cl_det_producto
GO

CREATE TABLE dbo.cl_det_producto
	(
	dp_det_producto   INT NOT NULL,
	dp_filial         TINYINT NULL,
	dp_oficina        SMALLINT NOT NULL,
	dp_producto       TINYINT NOT NULL,
	dp_tipo           CHAR (1) NOT NULL,
	dp_moneda         TINYINT NOT NULL,
	dp_fecha          DATETIME NOT NULL,
	dp_comentario     descripcion NULL,
	dp_monto          MONEY NULL,
	dp_tiempo         SMALLINT NULL,
	dp_cuenta         cuenta NULL,
	dp_estado_ser     CHAR (1) NOT NULL,
	dp_autorizante    SMALLINT NULL,
	dp_oficial_cta    SMALLINT NOT NULL,
	dp_cliente_ec     INT NULL,
	dp_direccion_ec   INT NULL,
	dp_descripcion_ec direccion NULL,
	dp_sector         CHAR (3) NULL,
	dp_zona           CHAR (3) NULL,
	dp_valor_inicial  MONEY NULL,
	dp_tipo_producto  CHAR (1) NULL,
	dp_tprestamo      SMALLINT NULL,
	dp_valor_promedio MONEY NULL,
	dp_rol_cliente    CHAR (1) NULL,
	dp_iva_retenido   MONEY NULL,
	dp_base_iva       MONEY NULL,
	dp_retefuente     MONEY NULL,
	dp_base_rtefte    MONEY NULL,
	dp_saldo          MONEY NULL,
	dp_fecha_cambio   DATETIME NULL,
	dp_fecha_prox_ven DATETIME NULL,
	dp_apartado_ec    INT NULL,
	dp_sub_tipo       SMALLINT NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cl_det_producto_Key
	ON dbo.cl_det_producto (dp_det_producto)
GO

CREATE NONCLUSTERED INDEX cl_det_producto_idx4
	ON dbo.cl_det_producto (dp_estado_ser)
GO

CREATE NONCLUSTERED INDEX i_dp_cuenta
	ON dbo.cl_det_producto (dp_cuenta)
GO

CREATE NONCLUSTERED INDEX idx3
	ON dbo.cl_det_producto (dp_producto,dp_cuenta)
GO


IF OBJECT_ID ('dbo.cl_det_embargo') IS NOT NULL
	DROP TABLE dbo.cl_det_embargo
GO


CREATE TABLE cl_det_embargo
    (
    de_ente                 int not null,
    de_secuencial           int not null,
    de_sec_interno          int not null,
    de_fecha                datetime,
    de_producto             int,
    de_subproducto          int,
    de_monto                money,
    de_tipo_bloqueo         tinyint,
    de_estado_levantamiento catalogo,
    de_fecha_levantamiento  datetime,
    de_observacion          descripcion,
    de_num_cuenta           cuenta,
    de_procesa_cheque       char (1),
    de_sec_depjud           int
    )
go

print '=====> cl_det_embargo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_det_embargo_Key ON cl_det_embargo
(
    de_ente ,
    de_secuencial ,
    de_sec_interno ,
    de_num_cuenta
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_def_grupo') IS NOT NULL
	DROP TABLE dbo.cl_def_grupo
GO


CREATE TABLE cl_def_grupo
    (
    dg_grupo     varchar (10) not null,
    dg_estado    char (1) not null,
    dg_posicion  int not null,
    dg_fpresenta char (1) not null,
    dg_llave_ing varchar (30) not null
    )
go


print '=====> idg_grupo'
go
CREATE NONCLUSTERED INDEX idg_grupo ON cl_def_grupo
(
    dg_grupo ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_dat_merc_ente') IS NOT NULL
	DROP TABLE dbo.cl_dat_merc_ente
GO

CREATE TABLE cl_dat_merc_ente
    (
    dm_ente          int not null,
    dm_grp_inf       catalogo not null,
    dm_cod_tbl_inf   smallint not null,
    dm_cod_atrib_inf tinyint not null,
    dm_cod_vlr       smallint not null,
    dm_fecha         datetime not null
    )
go

IF OBJECT_ID ('dbo.cl_cuenta') IS NOT NULL
	DROP TABLE dbo.cl_cuenta
GO

CREATE TABLE cl_cuenta
    (
    ct_cuenta      int not null,
    ct_descripcion descripcion not null,
    ct_categoria   char (1) not null,
    ct_estado      estado
    )
go

print '=====> cl_cuenta_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_cuenta_Key ON cl_cuenta
(
    ct_cuenta
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_covinco') IS NOT NULL
	DROP TABLE dbo.cl_covinco
GO

CREATE TABLE cl_covinco
    (
    cv_codigo  int not null,
    cv_estado  char (1) not null,
    cv_ced_ruc char (13) not null,
    cv_nombre  char (37) not null,
    cv_af      char (2) not null,
    cv_jz      char (2) not null,
    cv_sb      char (2) not null,
    cv_fecha   char (10) not null
    )
go
print '=====> cl_covinco_Key'
go
CREATE CLUSTERED INDEX cl_covinco_Key ON cl_covinco
(
    cv_nombre ,
    cv_codigo
)  ON indexgroup
go

IF OBJECT_ID ('dbo.cl_cov_error') IS NOT NULL
	DROP TABLE dbo.cl_cov_error
GO

CREATE TABLE cl_cov_error
    (
    ce_proceso     char (1) not null,
    ce_error       int not null,
    ce_codigo      int not null,
    ce_estado      char (1) not null,
    ce_ced_ruc     char (13) not null,
    ce_nombre      char (37) not null,
    ce_af          char (2) not null,
    ce_jz          char (2) not null,
    ce_sb          char (2) not null,
    ce_fecha       char (10) not null,
    ce_fec_proceso datetime not null
    )
go

IF OBJECT_ID ('dbo.cl_contacto') IS NOT NULL
	DROP TABLE dbo.cl_contacto
GO

CREATE TABLE cl_contacto
    (
    co_ente           int not null,
    co_contacto       tinyint not null,
    co_nombre         varchar (40) not null,
    co_cargo          varchar (32) not null,
    co_telefono       varchar (12) not null,
    co_direccioi      direccion,
    co_verificado     char (1),
    co_fecha_ver      datetime,
    co_funcionario    login,
    co_direccion      direccion,
    co_email          descripcion,
    co_registrado     datetime,
    co_modificado     datetime,
    co_obs_verificado varchar (10)
    )
go

IF OBJECT_ID ('dbo.cl_consulta_masiva') IS NOT NULL
	DROP TABLE dbo.cl_consulta_masiva
GO

CREATE TABLE cl_consulta_masiva
    (
    cm_ente         int not null,
    cm_ced_ruc      numero not null,
    cm_tipo_ced     char (2),
    cm_nomlar       varchar (254),
    cm_cuenta       cuenta,
    cm_oficina      smallint,
    cm_saldo        money,
    cm_estado_ser   char (1),
    cm_fecha_cambio datetime,
    cm_fecha        datetime,
    cm_encontrado   char (1),
    cm_archivo      varchar (50)
    )
go

IF OBJECT_ID ('dbo.cl_com_liquidacion') IS NOT NULL
	DROP TABLE dbo.cl_com_liquidacion
GO

CREATE TABLE cl_com_liquidacion
    (
    cl_codigo     int not null,
    cl_nombre     descripcion not null,
    cl_tipo       char (1) not null,
    cl_problema   catalogo not null,
    cl_referencia descripcion,
    cl_ced_ruc    numero,
    cl_fecha      datetime,
    monto         money
    )
go

print '=====> cl_com_liquidacion_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_com_liquidacion_Key ON cl_com_liquidacion
(
    cl_codigo
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_cliente_no_cobis') IS NOT NULL
	DROP TABLE dbo.cl_cliente_no_cobis
GO

CREATE TABLE cl_cliente_no_cobis
    (
    cl_cliente      int not null,
    cl_det_producto int not null,
    cl_rol          char (1) not null,
    cl_ced_ruc      varchar (30) not null,
    cl_fecha_reg    datetime
    )
go

IF OBJECT_ID ('dbo.cl_cliente_grupo') IS NOT NULL
	DROP TABLE dbo.cl_cliente_grupo
GO

CREATE TABLE dbo.cl_cliente_grupo
	(
	cg_ente                INT NOT NULL,
	cg_grupo               INT NOT NULL,
	cg_usuario             login NOT NULL,
	cg_terminal            VARCHAR (32) NOT NULL,
	cg_oficial             SMALLINT NULL,
	cg_fecha_reg           DATETIME NOT NULL,
	cg_rol                 catalogo NULL,
	cg_estado              catalogo NULL,
	cg_calif_interna       catalogo NULL,
	cg_fecha_desasociacion DATETIME NULL,
	cg_tipo_relacion       catalogo NULL,
	cg_ahorro_voluntario   MONEY NULL,
	cg_lugar_reunion       VARCHAR (10) NULL,
	cg_nro_ciclo           INT NULL
	)
GO
print '=====> cl_cliente_grupo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_cliente_grupo_Key ON cl_cliente_grupo
(
    cg_grupo ,
    cg_ente
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_cliente') IS NOT NULL
	DROP TABLE dbo.cl_cliente
GO

CREATE TABLE cl_cliente
    (
    cl_cliente      int not null,
    cl_det_producto int not null,
    cl_rol          char (1) not null,
    cl_ced_ruc      numero not null,
    cl_fecha        datetime not null
    )
go

print '=====> cl_cliente_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_cliente_Key ON cl_cliente
(
    cl_cliente ,
    cl_det_producto
) ON indexgroup
go


print '=====> icl_det_producto'
go
CREATE NONCLUSTERED INDEX icl_det_producto ON cl_cliente
(
    cl_det_producto ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_cli_masiva') IS NOT NULL
	DROP TABLE dbo.cl_cli_masiva
GO

CREATE TABLE cl_cli_masiva
    (
    cm_tipo       char (1) not null,
    cm_nombre     varchar (64) not null,
    cm_p_apellido varchar (25),
    cm_s_apellido varchar (25),
    cm_c_apellido varchar (25),
    cm_cedula     varchar (25),
    cm_nit        varchar (25),
    cm_sexo       catalogo,
    cm_direccion  descripcion,
    cm_telefono   varchar (25),
    cm_proceso    char (1),
    cm_error      varchar (25)
    )
go


IF OBJECT_ID ('dbo.cl_cifin') IS NOT NULL
	DROP TABLE dbo.cl_cifin
GO

CREATE TABLE cl_cifin
    (
    ci_trimestre     int not null,
    ci_ente          int not null,
    ci_secuencial    smallint not null,
    ci_entidad       catalogo,
    ci_calificacion  char (2),
    ci_tipo_credito  catalogo,
    ci_tipo_garantia catalogo,
    ci_ndeuda_ML     int,
    ci_deuda_ML      money,
    ci_ndeuda_ME     int,
    ci_deuda_ME      money,
    ci_tot_deuda     money,
    ci_actualizable  char (1),
    ci_login         login not null,
    ci_fecha_reg     datetime,
    ci_fecha_mod     datetime
    )
go

print '=====> cl_cifin_Key'
go
CREATE NONCLUSTERED INDEX cl_cifin_Key ON cl_cifin
(
    ci_ente ,
    ci_trimestre
)  ON indexgroup
go


IF OBJECT_ID ('dbo.cl_categoria') IS NOT NULL
	DROP TABLE dbo.cl_categoria
GO

CREATE TABLE cl_categoria
    (
    ct_codigo      catalogo not null,
    ct_descripcion descripcion not null,
    ct_porcentaje  tinyint not null,
    ct_estado      estado not null
    )
go

print '=====> cl_categoria_Key'
go
CREATE NONCLUSTERED INDEX cl_categoria_Key ON cl_categoria
(
    ct_codigo ,
    ct_estado
)  ON indexgroup
go
IF OBJECT_ID ('dbo.cl_casilla') IS NOT NULL
	DROP TABLE dbo.cl_casilla
GO

CREATE TABLE cl_casilla
    (
    cs_ente               int not null,
    cs_casilla            tinyint not null,
    cs_valor              varchar (24) not null,
    cs_tipo               char (1),
    cs_ciudad             int,
    cs_provincia          smallint,
    cs_sucursal           tinyint,
    cs_fecha_registro     datetime not null,
    cs_fecha_modificacion datetime not null,
    cs_vigencia           char (1) not null,
    cs_funcionario        login,
    cs_verificado         char (1),
    cs_fecha_ver          datetime,
    cs_emp_postal         varchar (24)
    )
go

print '=====> cl_casilla_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_casilla_Key ON cl_casilla
(
    cs_ente ,
    cs_casilla
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_cab_embargo') IS NOT NULL
	DROP TABLE dbo.cl_cab_embargo
GO

CREATE TABLE cl_cab_embargo
    (
    ca_ente                   int not null,
    ca_secuencial             int not null,
    ca_fecha                  datetime not null,
    ca_fecha_ofi              datetime not null,
    ca_oficio                 varchar (16),
    ca_solicitante            descripcion,
    ca_demandante             descripcion,
    ca_monto                  money,
    ca_estado                 catalogo,
    ca_tipo_proceso           catalogo,
    ca_autorizante            login,
    ca_saldo_pdte             money,
    ca_debita_cta             char (1),
    ca_oficina                smallint,
    ca_tipo_persona           char (1),
    ca_juzgado                varchar (64),
    ca_concepto               catalogo,
    ca_oficina_destino        catalogo,
    ca_tipo_doc_demandante    catalogo,
    ca_numero_doc_demandante  varchar (13),
    ca_nombre_demandante      varchar (20),
    ca_apellido_demandante    varchar (30),
    ca_cuenta_especifica      char (1),
    ca_nro_cta_especifica     varchar (20),
    ca_reversado              char (1),
    ca_sec_depjud             int,
    ca_fecha_reversa          datetime,
    ca_usuario_rev            login,
    ca_observacion            descripcion,
    ca_tipo_doc_solicitante   catalogo,
    ca_numero_doc_solicitante varchar (13),
    ca_producto               varchar (10),
    ca_mmi                    varchar (10)
    )
go

print '=====> cl_cab_embargo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_cab_embargo_Key ON cl_cab_embargo
(
    ca_ente ,
    ca_secuencial
) ON indexgroup
go

print '=====> i_ca_ente'
go
CREATE NONCLUSTERED INDEX i_ca_ente ON cl_cab_embargo
(
    ca_ente ASC,
    ca_fecha ASC
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_bandom') IS NOT NULL
	DROP TABLE dbo.cl_bandom
GO

CREATE TABLE cl_bandom
    (
    bd_ente               int not null,
    bd_secuencial         tinyint not null,
    bd_servicio           catalogo not null,
    bd_estado             estado,
    bd_fecha_registro     datetime,
    bd_fecha_modificacion datetime,
    bd_funcionario        login
    )
go

IF OBJECT_ID ('dbo.cl_banco_rem') IS NOT NULL
	DROP TABLE dbo.cl_banco_rem
GO

CREATE TABLE cl_banco_rem
    (
    ba_banco       int not null,
    ba_descripcion descripcion not null,
    ba_estado      estado,
    ba_filial      tinyint
    )
go

print '=====> cl_banco_rem_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_banco_rem_Key ON cl_banco_rem
(
    ba_banco
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_balance_tmp') IS NOT NULL
	DROP TABLE dbo.cl_balance_tmp
GO

CREATE TABLE cl_balance_tmp
    (
    ba_tbalance    char (3) not null,
    ba_cliente     int not null,
    ba_anio        smallint,
    ba_user        login,
    ba_term        varchar (30),
    ba_clase       char (1),
    ba_fecha_corte datetime
    )
go
print '=====> cl_balance_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_balance_tmp_Key ON cl_balance_tmp
(
    ba_user ,
    ba_term ,
    ba_cliente
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_balance') IS NOT NULL
	DROP TABLE dbo.cl_balance
GO

CREATE TABLE cl_balance
    (
    ba_balance     smallint not null,
    ba_cliente     int not null,
    ba_tbalance    char (3) not null,
    ba_anio        smallint,
    ba_fecha_reg   datetime not null,
    ba_funcionario login not null,
    ba_oficina     smallint not null,
    ba_clase       char (1),
    ba_fecha_corte datetime
    )
go

print '=====> cl_balance_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_balance_Key ON cl_balance
(
    ba_cliente ,
    ba_balance
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_atributo') IS NOT NULL
	DROP TABLE dbo.cl_atributo
GO

CREATE TABLE cl_atributo
    (
    at_filial   tinyint not null,
    at_servicio smallint not null,
    at_perfil   smallint not null,
    at_atributo varchar (30) not null,
    at_minimo   descripcion,
    at_maximo   descripcion
    )
go

IF OBJECT_ID ('dbo.cl_atr_valores') IS NOT NULL
	DROP TABLE dbo.cl_atr_valores
GO

CREATE TABLE cl_atr_valores
    (
    av_grp_inf     catalogo not null,
    av_cod_tbl_inf smallint not null,
    av_cod_atrib   tinyint not null,
    av_cod_vlr     tinyint not null,
    av_desc_vlr    descripcion not null
    )
go

IF OBJECT_ID ('dbo.cl_atr_tbl_inf') IS NOT NULL
	DROP TABLE dbo.cl_atr_tbl_inf
GO

CREATE TABLE cl_atr_tbl_inf
    (
    ai_grp_inf      catalogo not null,
    ai_cod_tbl_inf  smallint not null,
    ai_cod_atrib    tinyint not null,
    ai_desc_atrib   descripcion not null,
    ai_mandat_atrib char (1) not null
    )
go

IF OBJECT_ID ('dbo.cl_at_relacion') IS NOT NULL
	DROP TABLE dbo.cl_at_relacion
GO

CREATE TABLE cl_at_relacion
    (
    ar_relacion    int not null,
    ar_atributo    tinyint not null,
    ar_descripcion descripcion not null,
    ar_tdato       varchar (30) not null
    )
go
print '=====> cl_at_relacion_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_at_relacion_Key ON cl_at_relacion
(
    ar_relacion ,
    ar_atributo
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_at_instancia') IS NOT NULL
	DROP TABLE dbo.cl_at_instancia
GO

CREATE TABLE dbo.cl_at_instancia
	(
	ai_relacion   INT NOT NULL,
	ai_ente_i     INT NOT NULL,
	ai_ente_d     INT NOT NULL,
	ai_atributo   TINYINT NOT NULL,
	ai_valor      VARCHAR (255) NOT NULL,
	ai_secuencial INT NULL
	)
GO
print '=====> cl_at_instancia_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_at_instancia_Key
	ON dbo.cl_at_instancia (ai_relacion,ai_ente_i,ai_ente_d,ai_atributo)
GO



IF OBJECT_ID ('dbo.cl_asociacion_actividad') IS NOT NULL
	DROP TABLE dbo.cl_asociacion_actividad
GO

CREATE TABLE cl_asociacion_actividad
    (
    aa_actividad   catalogo not null,
    aa_tipo_pers   char (1) not null,
    aa_descripcion varchar (255) not null,
    aa_act_general catalogo not null,
    aa_sector      catalogo not null,
    aa_banca       catalogo,
    aa_mercado     catalogo,
    aa_subtipo     catalogo
    )
go


print '=====> idx1'
go
CREATE CLUSTERED INDEX idx1 ON cl_asociacion_actividad
(
    aa_actividad ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_asoc_clte_serv') IS NOT NULL
	DROP TABLE dbo.cl_asoc_clte_serv
GO

CREATE TABLE cl_asoc_clte_serv
    (
    ac_secuencial int not null,
    ac_servicio   varchar (10) not null,
    ac_cliente    int not null,
    ac_codigo     int not null,
    ac_estado     char (1) not null,
    ac_fecha_crea datetime not null,
    ac_fecha_mod  datetime,
    ac_usuario    login,
    ac_tipo_cb    char (1) DEFAULT ('P') not null,
    PRIMARY KEY (ac_secuencial)
    WITH (FILLFACTOR = 75)
    )
go

IF OBJECT_ID ('dbo.cl_area_influencia') IS NOT NULL
	DROP TABLE dbo.cl_area_influencia
GO


CREATE TABLE cl_area_influencia
    (
    ari_cod_ciudad  int,
    ari_cod_oficina int
    )
go


print '=====> i_ciudad'
go
CREATE NONCLUSTERED INDEX i_ciudad ON cl_area_influencia
(
    ari_cod_ciudad
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_archivos_cargados_mig') IS NOT NULL
	DROP TABLE dbo.cl_archivos_cargados_mig
GO

CREATE TABLE cl_archivos_cargados_mig
    (
    ac_archivo varchar (30) not null,
    ac_user    login not null,
    ac_date    datetime not null,
    ac_sesn    int not null
    )
go

IF OBJECT_ID ('dbo.cl_aplica_tipo_persona2') IS NOT NULL
	DROP TABLE dbo.cl_aplica_tipo_persona2
GO

CREATE TABLE cl_aplica_tipo_persona2
    (
    atp_orden       int not null,
    atp_tipo        char (2) not null,
    atp_tpersona    char (3) not null,
    atp_descripcion varchar (64) not null,
    atp_t_objeto    char (1) not null,
    atp_nom_objeto  varchar (30) not null,
    atp_aplica      char (1) not null,
    atp_secuencia   smallint not null
    )
go


print '=====> cl_aplica_tipo_persona2_Key'
go
CREATE CLUSTERED INDEX cl_aplica_tipo_persona2_Key ON cl_aplica_tipo_persona2
(
    atp_tpersona ASC,
    atp_tipo ,
    atp_t_objeto ,
    atp_secuencia
)  ON indexgroup
go
IF OBJECT_ID ('dbo.cl_aplica_tipo_persona') IS NOT NULL
	DROP TABLE dbo.cl_aplica_tipo_persona
GO

CREATE TABLE dbo.cl_aplica_tipo_persona
	(
	atp_tipo           VARCHAR (2) NULL,
	atp_tpersona       VARCHAR (3) NULL,
	atp_t_objeto       VARCHAR (1) NULL,
	atp_nom_objeto     VARCHAR (30) NULL,
	atp_aplica         VARCHAR (1) NULL,
	atp_secuencia      SMALLINT NULL,
	atp_caracteristica VARCHAR (10) NULL,
	atp_car_parametro  VARCHAR (64) NULL
	)
GO
print '=====> i_tipo'
go

CREATE NONCLUSTERED INDEX i_tipo
	ON dbo.cl_aplica_tipo_persona (atp_tipo,atp_tpersona)
GO

IF OBJECT_ID ('dbo.cl_alerta') IS NOT NULL
	DROP TABLE dbo.cl_alerta
GO

CREATE TABLE cl_alerta
    (
    al_codigo          int not null,
    al_cliente         int not null,
    al_tipo_alerta     catalogo not null,
    al_sospechoso      catalogo,
    al_observacion     varchar (255),
    al_fecha_registro  datetime not null,
    al_fecha_revision  datetime,
    al_responsable_rev login,
    al_nivel           tinyint
    )
go
print '=====> cl_alerta_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_alerta_Key ON cl_alerta
(
    al_codigo
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_actualiza') IS NOT NULL
	DROP TABLE dbo.cl_actualiza
GO

CREATE TABLE cl_actualiza
    (
    ac_ente        int         not null,
    ac_fecha       datetime    not null,
    ac_tabla       descripcion     null,
    ac_campo       descripcion     null,
    ac_valor_ant   descripcion     null,
    ac_valor_nue   descripcion     null,
    ac_transaccion char (1)        null,
    ac_secuencial1 tinyint         null,
	ac_secuencial2 TINYINT         NULL,
	ac_hora        DATETIME        NULL
    )
go
print '=====> cl_actualiza_Key'
go
CREATE CLUSTERED INDEX cl_actualiza_Key ON cl_actualiza
(
    ac_fecha ,
    ac_ente ,
    ac_valor_nue
)  ON indexgroup
go

print '=====> icl_ac_campo'
go
CREATE NONCLUSTERED INDEX icl_ac_campo ON cl_actualiza
(
    ac_campo ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_actlegal_conv') IS NOT NULL
	DROP TABLE dbo.cl_actlegal_conv
GO

CREATE TABLE cl_actlegal_conv
    (
    alc_secuencial                 int not null,
    alc_tipo_documento             char (2) not null,
    alc_numero_documento           char (16) not null,
    alc_nombre                     varchar (64) not null,
    alc_fecha_vencimiento_sociedad datetime,
    alc_fecha_constitucion         datetime not null,
    alc_fecha_inscipcion           datetime not null,
    alc_objeto_social              varchar (254),
    alc_atrib_limita_modifi        varchar (254),
    alc_domicilio_legal            tinyint,
    alc_numero_escritura           int,
    alc_notaria                    tinyint,
    alc_ciudad_notaria             int,
    alc_capital_pagado             money,
    alc_numero_matricula           int,
    alc_fecha_expedicion_certifica datetime,
    alc_fecha_ultimo_aumento       datetime,
    alc_camara_comercio            varchar (10) not null,
    alc_grado_sociedad             varchar (10) not null,
    alc_tipo_transaccion           int,
    alc_numero_control             int,
    alc_error                      int,
    alc_descripcion_error          varchar (150),
    alc_posicion                   int,
    alc_leg_codigo_ente            int,
    alc_oficina                    smallint,
    alc_fecha_registro             datetime,
    alc_tipo_documento_rep         char (2) not null,
    alc_numero_documento_rep       char (16) not null
    )
go
print '=====> cl_actlegal_conv_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_actlegal_conv_Key ON cl_actlegal_conv
(
    alc_tipo_documento ,
    alc_secuencial
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_actente_conv') IS NOT NULL
	DROP TABLE dbo.cl_actente_conv
GO

CREATE TABLE cl_actente_conv
    (
    aac_secuencial                 int not null,
    aac_tipo_persona               char (1) not null,
    aac_tipo_documento             char (2) not null,
    aac_numero_documento           char (16) not null,
    aac_sigla                      varchar (25),
    aac_nombre                     varchar (64) not null,
    aac_primer_apellido            varchar (16),
    aac_segundo_apellido           varchar (16),
    aac_fecha_nacimiento           datetime,
    aac_sexo                       char (1),
    aac_fecha_ingreso              datetime not null,
    aac_fecha_modificacion         datetime not null,
    aac_actividad                  catalogo not null,
    aac_sector                     catalogo not null,
    aac_gerente                    smallint,
    aac_estado_empresa             catalogo not null,
    aac_naturaleza_juridica        catalogo not null,
    aac_tipo_sociedad              catalogo not null,
    aac_sujeto_retencion           char (1) not null,
    aac_oficina                    smallint not null,
    aac_origen                     catalogo not null,
    aac_regimen_fiscal             char (4) not null,
    aac_codigo_ente                int,
    aac_tipo_banca                 catalogo not null,
    aac_tipo_mercado_objetivo      catalogo not null,
    aac_subtipo_mercado_objetivo   char (3) not null,
    aac_fecha_emision_documento_id datetime,
    aac_pais_emision               catalogo,
    aac_departamento_emision       catalogo,
    aac_ciudad_emision             catalogo,
    aac_pais_nacimiento            catalogo,
    aac_departamento_nacimiento    catalogo,
    aac_ciudad_nacimiento          catalogo,
    aac_estado_civil               catalogo,
    aac_profesion                  catalogo,
    aac_nivel_estudios             catalogo,
    aac_tipo_vivienda              catalogo,
    aac_numero_personas_cargo      tinyint,
    aac_presentado_por             catalogo not null,
    aac_razon_social               varchar (64),
    aac_cargo_actual               varchar (64),
    acc_des_otros_ingresos         varchar (64),
    aac_otros_ingresos             money,
    aac_pasivos_sector_financiero  money,
    aac_relacion_internacional     catalogo,
    aac_banco_internacional        varchar (64),
    aac_producto_internacional     varchar (25),
    aac_moneda_intenacional        char (1),
    aac_ciudad_intenacional        varchar (64),
    aac_pais_intenacional          smallint,
    aac_fecha_ini_opera_interna    datetime,
    aac_relacion_con_institucion   catalogo not null,
    aac_tipo_transaccion           int,
    aac_numero_control             int,
    aac_error                      int,
    aac_descripcion_error          varchar (150),
    aac_posicion                   int,
    aac_rol_empleo                 catalogo,
    aac_tipo_empleo                catalogo,
    aac_sueldo                     money,
    aac_moneda_sueldo              tinyint,
    aac_fecha_ingreso_empleo       datetime,
    aac_fecha_salida_empleo        datetime,
    aac_tiene_otringr              char (1) not null,
    aac_tiene_relacint             char (1) not null,
    aac_doctos_carpeta             char (1) not null
    )
go


print '=====> cl_actente_conv_key'
go
CREATE NONCLUSTERED INDEX cl_actente_conv_key ON cl_actente_conv
(
    aac_tipo_persona ASC,
    aac_tipo_documento ASC,
    aac_numero_documento ASC,
    aac_tipo_transaccion ASC
) ON indexgroup
go

print '=====> cl_actente_conv_key2'
go
CREATE NONCLUSTERED INDEX cl_actente_conv_key2 ON cl_actente_conv
(
    aac_tipo_documento ASC,
    aac_numero_documento ASC
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_actdirpro_conv') IS NOT NULL
	DROP TABLE dbo.cl_actdirpro_conv
GO

CREATE TABLE cl_actdirpro_conv
    (
    adc_secuencial           int not null,
    adc_tipo_documento       char (2) not null,
    adc_numero_documento     char (16) not null,
    adc_tipo_producto        char (3) not null,
    adc_secuencial_direccion tinyint not null,
    adc_tipo_transaccion     int,
    adc_numero_control       int,
    adc_error                int,
    adc_descripcion_error    varchar (150),
    adc_posicion             int,
    adc_dirpro_codigo_ente   int,
    adc_oficina              smallint,
    adc_fecha_registro       datetime
    )
go

print '=====> cl_actdirpro_conv_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_actdirpro_conv_Key ON cl_actdirpro_conv
(
    adc_dirpro_codigo_ente ,
    adc_tipo_producto
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_actdir_conv') IS NOT NULL
	DROP TABLE dbo.cl_actdir_conv
GO

CREATE TABLE cl_actdir_conv
    (
    adc_secuencial           int not null,
    adc_tipo_documento       char (2) not null,
    adc_numero_documento     char (16) not null,
    adc_secuencial_direccion tinyint not null,
    adc_direccion            varchar (254) not null,
    adc_ciudad_direccion     int not null,
    adc_tipo                 catalogo not null,
    adc_departamento         smallint not null,
    adc_telefono1            char (16),
    adc_tipo_telefono1       char (1),
    adc_telefono2            char (16),
    adc_tipo_telefono2       char (1),
    adc_telefono3            char (16),
    adc_tipo_telefono3       char (1),
    adc_tipo_transaccion     int,
    adc_numero_control       int,
    adc_error                int,
    adc_descripcion_error    varchar (150),
    adc_posicion             int,
    adc_dir_codigo_ente      int,
    adc_oficina              smallint,
    adc_fecha_registro       datetime
    )
go
print '=====> cl_actdir_conv_key'
go
CREATE UNIQUE CLUSTERED INDEX cl_actdir_conv_key ON cl_actdir_conv
(
    adc_secuencial ASC,
    adc_numero_documento ASC,
    adc_tipo_documento ASC
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_actbalance_conv') IS NOT NULL
	DROP TABLE dbo.cl_actbalance_conv
GO

CREATE TABLE cl_actbalance_conv
    (
    abc_secuencial        int not null,
    abc_tipo_persona      char (1) not null,
    abc_tipo_documento    char (2) not null,
    abc_numero_documento  char (16) not null,
    abc_tipo_balance      char (3) not null,
    abc_fecha_corte       datetime not null,
    abc_auditado          char (1) not null,
    abc_cuenta            int not null,
    abc_valor             money not null,
    abc_tipo_transaccion  int,
    abc_numero_control    int,
    abc_error             int,
    abc_descripcion_error varchar (150),
    abc_posicion          int,
    abc_bal_codigo_ente   int,
    abc_oficina           smallint,
    abc_fecha_registro    datetime,
    abc_fbalance          datetime not null
    )
go
print '=====> cl_actbalance_conv_Key'
CREATE UNIQUE CLUSTERED INDEX cl_actbalance_conv_Key ON cl_actbalance_conv
(
    abc_secuencial,
    abc_tipo_balance
) ON indexgroup
go


IF OBJECT_ID ('dbo.cl_viabilidad') IS NOT NULL
	DROP TABLE dbo.cl_viabilidad
GO

CREATE TABLE cl_viabilidad
    (
    vi_secuencial  int not null,
    vi_resultado   varchar (10) not null,
    vi_viable      char (1),
    vi_estado      varchar (10),
    vi_ponderacion int not null
    )
go


IF OBJECT_ID ('dbo.cl_fecha_tipo_doc') IS NOT NULL
	DROP TABLE dbo.cl_fecha_tipo_doc
GO

CREATE TABLE cl_fecha_tipo_doc
    (
    ct_codigo catalogo not null,
    ct_sexo   sexo not null,
    ct_signo  varchar (4) not null,
    ct_valor  int
    )
go

print '=====> cl_fecha_tipo_doc_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_fecha_tipo_doc_Key ON cl_fecha_tipo_doc
(
   ct_codigo, ct_sexo, ct_signo
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_referenciacion') IS NOT NULL
	DROP TABLE dbo.cl_referenciacion
GO

CREATE TABLE cl_referenciacion
    (
    re_producto       varchar (10) not null,
    re_tipo_persona   char (1) not null,
    re_grupo_info     varchar (10) not null,
    re_viabilidad     varchar (10),
    re_estado         varchar (10),
    re_fecha_ingreso  datetime,
    re_fecha_modifica datetime
    )
go

print '=====> ix1_cl_referenciacion'
go
CREATE UNIQUE NONCLUSTERED INDEX ix1_cl_referenciacion ON cl_referenciacion
(
   re_producto, re_tipo_persona, re_grupo_info
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_alianza') IS NOT NULL
	DROP TABLE dbo.cl_alianza
GO

CREATE TABLE cl_alianza
    (
    al_alianza              int not null,
    al_ente                 int not null,
    al_nemonico             catalogo not null,
    al_nom_alianza          varchar (255) not null,
    al_tipo                 catalogo not null,
    al_fecha_creacion       datetime not null,
    al_fecha_fija           char (1) not null,
    al_fecha_inicio         datetime,
    al_fecha_fin            datetime,
    al_estado               char (1),
    al_tipo_credito         char (1) not null,
    al_restringue_uso       char (1) not null,
    al_num_uso              tinyint,
    al_monto_promedio       money not null,
    al_tipo_recaudador      char (1) not null,
    al_aplica_mora          char (1) not null,
    al_dias_gracia          tinyint,
    al_tasa_mora            catalogo,
    al_signo_spread         char (1),
    al_valor_spread         tinyint,
    al_cuenta_bancaria      char (16) not null,
    al_debito_aut           char (1) not null,
    al_dispersion_fondos    char (1) not null,
    al_forma_des            catalogo not null,
    al_des_cta_afi          char (1) not null,
    al_gmf_banco            char (1) not null,
    al_porcentaje_gmfbanco  float,
    al_fecha_pago           char (1) not null,
    al_dia_pago             tinyint,
    al_exonera_estudio      char (1) not null,
    al_porcentaje_exonera   float,
    al_mantiene_condiciones char (1) not null,
    al_observaciones        varchar (255),
    al_fecha_cancelacion    datetime,
    al_envia_mail           char (1),
    al_mail_alianza         char (1),
    al_monto_alianza        money
    )
go
print '=====> cl_alianza_key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_alianza_key ON cl_alianza
(
    al_alianza
) ON indexgroup
go



IF OBJECT_ID ('dbo.cl_alianza_cliente') IS NOT NULL
	DROP TABLE dbo.cl_alianza_cliente
GO

CREATE TABLE cl_alianza_cliente
    (
    ac_alianza             int not null,
    ac_ente                int not null,
    ac_estado              char (1) not null,
    ac_fecha_asociacion    datetime not null,
    ac_fecha_desasociacion datetime,
    ac_fecha_creacion      datetime,
    ac_usuario_creador     catalogo,
    ac_usuario_modifica    catalogo
    )
go

print '=====> cl_alianza_cliente_key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_alianza_cliente_key ON cl_alianza_cliente
(
    ac_alianza,
    ac_ente
) ON indexgroup
go
IF OBJECT_ID ('dbo.listado_tmp2') IS NOT NULL
	DROP TABLE dbo.listado_tmp2
GO

CREATE TABLE listado_tmp2
    (
    oficina    smallint not null,
    regional   varchar (1) not null,
    zona       varchar (1) not null,
    nombre     varchar (20),
    criterio   varchar (25),
    cantidad   int not null,
    valor      money not null,
    secuencial int not null
    )
go

 /* cl_temporal_datos_trn */
print 'TABLA ====> cl_temporal_datos_trn'
IF OBJECT_ID ('dbo.cl_temporal_datos_trn') IS NOT NULL
	DROP TABLE dbo.cl_temporal_datos_trn
GO
CREATE TABLE cl_temporal_datos_trn (

id             int       not null ,
oficina        int       null ,
des_oficina    varchar(40)    null ,
cliente        int       null ,
clase          varchar(1)     null ,
usuario        varchar(24)    null ,
fecha_mod      datetime       null ,
nombre         varchar(255)   null ,
p_apellido     varchar(255)   null ,
s_apellido     varchar(255)   null ,
tipo_ced       varchar(2)     null ,
ced_ruc        varchar(24)    null ,
fecha_emision  datetime       null ,
fecha_nac      datetime       null
)
go

/* cl_rango_tipo_doc */
print 'TABLA ====> cl_rango_tipo_doc'

IF OBJECT_ID ('dbo.cl_rango_tipo_doc') IS NOT NULL
	DROP TABLE dbo.cl_rango_tipo_doc
GO

CREATE TABLE cl_rango_tipo_doc (

ct_codigo      varchar(10)    not null ,
ct_sexo        char(1)   not null ,
ct_rango_ini   varchar(30)    null ,
ct_rango_fin   varchar(30)    null
)
go

/* cl_novedad_ente */
print 'TABLA ====> cl_novedad_ente'
IF OBJECT_ID ('dbo.cl_novedad_ente') IS NOT NULL
	DROP TABLE dbo.cl_novedad_ente
GO

CREATE TABLE cl_novedad_ente (

ne_central     varchar(10)    not null ,
ne_ente        int  not null ,
ne_tipo        varchar(10)    not null ,
ne_descripcion varchar(255)   not null ,
ne_cobis       varchar(50)    not null ,
ne_datac       varchar(50)    not null ,
ne_aplicado    char(1)   null ,
ne_fec_aplica  datetime  null ,
ne_user_aplica varchar(14)    null ,
ne_cod_novedad tinyint   null
)
go

print '=====> cl_novedad_ente_key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_novedad_ente_key ON cl_novedad_ente
(
    ne_central,
    ne_ente,
    ne_cod_novedad
)
go


IF OBJECT_ID ('dbo.cl_param_est_clte') IS NOT NULL
	DROP TABLE dbo.cl_param_est_clte
GO

CREATE TABLE cl_param_est_clte
    (
    pe_tcriterio varchar (10) not null,
    pe_campo     varchar (50) not null,
    pe_catalogo  varchar (30) null
    )
go

IF OBJECT_ID ('dbo.cl_autoriza_sarlaft_lista') IS NOT NULL
	DROP TABLE dbo.cl_autoriza_sarlaft_lista
GO

CREATE TABLE cl_autoriza_sarlaft_lista
    (
    as_sec_refinh    int,
    as_tipo_id       char (2),
    as_nro_id        char (13),
    as_nombrelargo   varchar (100),
    as_origen_refinh varchar (10),
    as_estado_refinh varchar (10),
    as_fecha_refinh  datetime,
    as_aut_sarlaft   char (1),
    as_obs_sarlaft   varchar (80),
    as_usr_sarlaft   login,
    as_fecha_sarlaft datetime,
    as_aut_cial      char (1),
    as_obs_cial      varchar (80),
    as_usr_cial      login,
    as_fecha_cial    datetime,
    as_valida_total  char (1),
    as_oficina       smallint
    )
go

print '=====> id1_as'
go
CREATE NONCLUSTERED INDEX id1_as ON cl_autoriza_sarlaft_lista
(
    as_nro_id,
    as_valida_total,
    as_origen_refinh
) ON indexgroup
go



print '=====> id1_asl'
go
CREATE NONCLUSTERED INDEX id1_asl ON cl_autoriza_sarlaft_lista
(
    as_sec_refinh
) ON indexgroup
go

IF OBJECT_ID ('dbo.cl_autoriza_sarlaft_lista_ors_1253') IS NOT NULL
	DROP TABLE dbo.cl_autoriza_sarlaft_lista_ors_1253
GO

CREATE TABLE cl_autoriza_sarlaft_lista_ors_1253
    (
    as_sec_refinh    int,
    as_tipo_id       char (2),
    as_nro_id        char (13),
    as_nombrelargo   varchar (100),
    as_origen_refinh varchar (10),
    as_estado_refinh varchar (10),
    as_fecha_refinh  datetime,
    as_aut_sarlaft   char (1),
    as_obs_sarlaft   varchar (80),
    as_usr_sarlaft   login,
    as_fecha_sarlaft datetime,
    as_aut_cial      char (1),
    as_obs_cial      varchar (80),
    as_usr_cial      login,
    as_fecha_cial    datetime,
    as_valida_total  char (1),
    as_oficina       smallint
    )
go


IF OBJECT_ID ('dbo.cl_autorizacion_sarlaft') IS NOT NULL
	DROP TABLE dbo.cl_autorizacion_sarlaft
GO


CREATE TABLE cl_autorizacion_sarlaft
    (
    as_cedruc      varchar (12),
    as_observacion varchar (254)
    )
go

IF OBJECT_ID ('dbo.cl_alianza_linea_tmp') IS NOT NULL
	DROP TABLE dbo.cl_alianza_linea_tmp
GO

CREATE TABLE cl_alianza_linea_tmp
    (
    al_alianza int not null,
    al_linea   catalogo not null
    )
go

IF OBJECT_ID ('dbo.cl_manejo_sarlaft') IS NOT NULL
	DROP TABLE dbo.cl_manejo_sarlaft
GO

CREATE TABLE cl_manejo_sarlaft
    (
    ms_secuencial  int not null,
    ms_restrictiva varchar (12) not null,
    ms_origen      varchar (12),
    ms_estado      varchar (12)
    )
go

IF OBJECT_ID ('dbo.cl_dato_sarlaft2') IS NOT NULL
	DROP TABLE dbo.cl_dato_sarlaft2
GO

CREATE TABLE cl_dato_sarlaft2
    (
    Descripcion varchar (180)
    )
go

IF OBJECT_ID ('dbo.cl_alianza_banco') IS NOT NULL
	DROP TABLE dbo.cl_alianza_banco
GO

CREATE TABLE cl_alianza_banco
    (
    ab_alianza int not null,
    ab_banco   catalogo not null,
    ab_cuenta  char (16) not null,
    ab_estado  char (1) not null
    )
go

print '=====> cl_alianza_banco_key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_alianza_banco_key ON cl_alianza_banco
(
    ab_alianza,
    ab_banco,
    ab_cuenta
)
go

IF OBJECT_ID ('dbo.cl_alianza_banco_tmp') IS NOT NULL
	DROP TABLE dbo.cl_alianza_banco_tmp
GO

CREATE TABLE cl_alianza_banco_tmp
    (
    ab_alianza int not null,
    ab_banco   catalogo not null,
    ab_cuenta  char (16) not null,
    ab_estado  char (1) not null
    )
go

IF OBJECT_ID ('dbo.cl_alianza_linea') IS NOT NULL
	DROP TABLE dbo.cl_alianza_linea
GO

CREATE TABLE cl_alianza_linea
    (
    al_alianza int not null,
    al_linea   catalogo not null
    )
go

IF OBJECT_ID ('dbo.cl_val_iden') IS NOT NULL
	DROP TABLE dbo.cl_val_iden
GO

CREATE TABLE cl_val_iden
    (
    vi_producto       tinyint not null,
    vi_transaccion    smallint not null,
    vi_ind_causal     char (1) not null,
    vi_causal         varchar (10),
    vi_estado         char (1) not null,
    vi_fecha_registro datetime not null,
    vi_fecha_modif    datetime
    )
go


IF OBJECT_ID ('dbo.tmp_asociacion_actividad') IS NOT NULL
	DROP TABLE dbo.tmp_asociacion_actividad
GO

CREATE TABLE tmp_asociacion_actividad
    (
    aa_actividad         varchar(10) not null,
    aa_tipo_pers         char(1)     not null,
    aa_descripcion       varchar(255)    null,
    aa_act_general       varchar(10)     null,
    aa_sector            varchar(10)     null,
    aa_banca             varchar(10)     null,
    aa_mercado           varchar(10)     null,
    aa_subtipo           varchar(10)     null,
    aa_secuencial        int
    )
go

IF OBJECT_ID ('dbo.cl_tarea') IS NOT NULL
	DROP TABLE dbo.cl_tarea
GO

CREATE TABLE cl_tarea
    (
    ta_tarea           INT NOT NULL,
    ta_tipo            catalogo NOT NULL,
    ta_login           login NOT NULL,
    ta_ente            INT,
    ta_fecha_reg       DATETIME,
    ta_fecha_real_reg  DATETIME,
    ta_creador         login,
    ta_fecha_ejec      DATETIME,
    ta_fecha_real_ejec DATETIME,
    ta_motivo_cierre   catalogo,
    ta_secuencial_prd  INT,
    ta_codigo_prd      VARCHAR (30),
    ta_resultado       catalogo,
    ta_producto        TINYINT,
    ta_canal           catalogo
    )
go

print '=====> idx1'
go
CREATE UNIQUE  INDEX idx1 ON cl_tarea
(
   ta_tarea
)
go


print '=====> idx2'
go
CREATE  INDEX idx2 ON cl_tarea
(
   ta_login
)
go
print '=====> idx3'
go
CREATE INDEX idx3
    ON cl_tarea (ta_ente)
go

IF OBJECT_ID ('dbo.cl_fatca') IS NOT NULL
	DROP TABLE dbo.cl_fatca
GO

CREATE TABLE cl_fatca
    (
    fa_tipo_id             CHAR (2),
    fa_num_id              numero,
    fa_tipo_persona        CHAR (3),
    fa_subtipo_persona     CHAR (1),
    fa_tipo_id_rep_lg      CHAR (2),
    fa_num_id_rep_lg       numero,
    fa_nom_entidad         mensaje,
    fa_pais_constitucion   VARCHAR (30),
    fa_direccion_emp       mensaje,
    fa_pais_emp            VARCHAR (30),
    fa_ciudad_emp          VARCHAR (30),
    fa_est_provi_emp       VARCHAR (30),
    fa_cod_postal_emp      INT,
    fa_nombre              VARCHAR (30),
    fa_primer_apellido     VARCHAR (30),
    fa_segundo_apellido    VARCHAR (30),
    fa_pais_nacimiento     VARCHAR (30),
    fa_ciudad_nacimiento   VARCHAR (30),
    fa_direcion_residencia mensaje,
    fa_pais_residencia     VARCHAR (30),
    fa_ciudad_residencia   VARCHAR (30),
    fa_est_provi_residen   VARCHAR (30),
    fa_cod_postal          INT,
    fa_pregunta1           VARCHAR (2),
    fa_pregunta2           VARCHAR (2),
    fa_pregunta3           VARCHAR (2),
    fa_pregunta4           VARCHAR (2),
    fa_pregunta5           VARCHAR (2),
    fa_pregunta6           VARCHAR (2),
    fa_pregunta7           VARCHAR (2),
    fa_pregunta8           VARCHAR (2),
    fa_pregunta9           VARCHAR (2),
    fa_pregunta10          VARCHAR (2),
    fa_pregunta11          VARCHAR (2),
    fa_pregunta12          VARCHAR (2),
    fa_pregunta13          VARCHAR (2),
    fa_pregunta14          VARCHAR (2),
    fa_pregunta15          VARCHAR (2),
    fa_pregunta16          VARCHAR (2),
    fa_pregunta17          VARCHAR (2),
    fa_pregunta18          VARCHAR (2),
    fa_pregunta19          VARCHAR (2),
    fa_marca_doc_comp      VARCHAR (1),
    fa_observaciones1      mensaje,
    fa_observaciones2      mensaje,
    fa_observaciones3      mensaje,
    fa_observaciones4      mensaje,
    fa_pais_efe_fiscal1    VARCHAR (30),
    fa_pais_efe_fiscal2    VARCHAR (30),
    fa_pais_efe_fiscal3    VARCHAR (30),
    fa_num_id_fiscal1      VARCHAR (15),
    fa_num_id_fiscal2      VARCHAR (15),
    fa_num_id_fiscal3      VARCHAR (15),
    fa_fec_doc_sup         DATETIME,
    fa_ein_vigen           VARCHAR (15),
    fa_giin_vigen          VARCHAR (15),
    fa_fecha_solici        DATETIME,
    fa_fec_mod             DATETIME,
    fa_calificacion        VARCHAR (2),
    fa_telefono_ppal       CHAR (11),
    fa_direccion_ppal      mensaje,
    fa_fec_impresion       DATETIME,
    fa_ciiu                VARCHAR (10),
    fa_login               login,
    fa_oficina             INT
    )
go

IF OBJECT_ID ('dbo.cl_causa_bloqueo') IS NOT NULL
	DROP TABLE dbo.cl_causa_bloqueo
GO

CREATE TABLE cl_causa_bloqueo
    (
    cb_num_causa SMALLINT NOT NULL,
    cb_causa     CHAR (64) NOT NULL
    )
go

print '=====> cl_causa_bloqueo_Key'
go
CREATE INDEX cl_causa_bloqueo_Key
    ON cl_causa_bloqueo (cb_num_causa)
go

IF OBJECT_ID ('dbo.cl_forma_extractos') IS NOT NULL
	DROP TABLE dbo.cl_forma_extractos
GO


CREATE TABLE cl_forma_extractos
    (
    fe_cliente       INT NOT NULL,
    fe_forma_entrega catalogo NOT NULL,
    fe_codigo        INT NOT NULL,
    fe_fecha         DATETIME,
    fe_fecha_real    DATETIME,
    fe_usuario       VARCHAR (25),
    fe_oficina_marca INT,
    fe_terminal      VARCHAR (25)
    )
go

print '=====> cl_forma_extractos_Key'
go
CREATE INDEX cl_forma_extractos_Key
    ON cl_forma_extractos (fe_cliente)
go

IF OBJECT_ID ('dbo.ts_fatca') IS NOT NULL
	DROP TABLE dbo.ts_fatca
GO

CREATE TABLE ts_fatca
    (
    ts_tipo_id             CHAR (2),
    ts_num_id              numero,
    ts_tipo_persona        CHAR (3),
    ts_subtipo_persona     CHAR (1),
    ts_tipo_id_rep_lg      CHAR (2),
    ts_num_id_rep_lg       numero,
    ts_nom_entidad         mensaje,
    ts_pais_constitucion   VARCHAR (30),
    ts_direccion_emp       mensaje,
    ts_pais_emp            VARCHAR (30),
    ts_ciudad_emp          VARCHAR (30),
    ts_est_provi_emp       VARCHAR (30),
    ts_cod_postal_emp      INT,
    ts_nombre              VARCHAR (30),
    ts_primer_apellido     VARCHAR (30),
    ts_segundo_apellido    VARCHAR (30),
    ts_pais_nacimiento     VARCHAR (30),
    ts_ciudad_nacimiento   VARCHAR (30),
    ts_direcion_residencia mensaje,
    ts_pais_residencia     VARCHAR (30),
    ts_ciudad_residencia   VARCHAR (30),
    ts_est_provi_residen   VARCHAR (30),
    ts_cod_postal          INT,
    ts_pregunta1           VARCHAR (2),
    ts_pregunta2           VARCHAR (2),
    ts_pregunta3           VARCHAR (2),
    ts_pregunta4           VARCHAR (2),
    ts_pregunta5           VARCHAR (2),
    ts_pregunta6           VARCHAR (2),
    ts_pregunta7           VARCHAR (2),
    ts_pregunta8           VARCHAR (2),
    ts_pregunta9           VARCHAR (2),
    ts_pregunta10          VARCHAR (2),
    ts_pregunta11          VARCHAR (2),
    ts_pregunta12          VARCHAR (2),
    ts_pregunta13          VARCHAR (2),
    ts_pregunta14          VARCHAR (2),
    ts_pregunta15          VARCHAR (2),
    ts_pregunta16          VARCHAR (2),
    ts_pregunta17          VARCHAR (2),
    ts_pregunta18          VARCHAR (2),
    ts_pregunta19          VARCHAR (2),
    ts_marca_doc_comp      VARCHAR (1),
    ts_observaciones1      mensaje,
    ts_observaciones2      mensaje,
    ts_observaciones3      mensaje,
    ts_observaciones4      mensaje,
    ts_pais_efe_fiscal1    VARCHAR (30),
    ts_pais_efe_fiscal2    VARCHAR (30),
    ts_pais_efe_fiscal3    VARCHAR (30),
    ts_num_id_fiscal1      VARCHAR (15),
    ts_num_id_fiscal2      VARCHAR (15),
    ts_num_id_fiscal3      VARCHAR (15),
    ts_fec_doc_sup         DATETIME,
    ts_ein_vigen           VARCHAR (15),
    ts_giin_vigen          VARCHAR (15),
    ts_fecha_solici        DATETIME,
    ts_fec_mod             DATETIME,
    ts_calificacion        VARCHAR (2),
    ts_telefono_ppal       CHAR (11),
    ts_direccion_ppal      mensaje,
    ts_fec_impresion       DATETIME,
    ts_ciiu                VARCHAR (10),
    ts_usuario             login,
    ts_oficina             INT,
    ts_secuencial          INT,
    ts_fecha_proceso       DATETIME,
    ts_operacion           VARCHAR (1)
    )
go


IF OBJECT_ID ('dbo.cl_sostenibilidad') IS NOT NULL
	DROP TABLE dbo.cl_sostenibilidad
GO

CREATE TABLE cl_sostenibilidad
    (
    so_cliente          INT,
    so_viv_mat          catalogo,
    so_viv_comb         catalogo,
    so_viv_dorm         INT,
    so_viv_conforman    INT,
    so_viv_aportan      INT,
    so_edu_financiera   catalogo,
    so_grupo_etnico     catalogo,
    so_viv_serv_pub     VARCHAR (10),
    so_viv_vias_llegar  VARCHAR (10),
    so_viv_equipo       VARCHAR (10),
    so_viv_tema_tratado VARCHAR (10),
    so_fecha_modif      DATETIME
    )
go

print '=====> cl_sostenibilidad_Key'
go
CREATE INDEX cl_sostenibilidad_Key
    ON cl_sostenibilidad (so_cliente)
go

IF OBJECT_ID ('dbo.cl_log_bloqueo_opt') IS NOT NULL
	DROP TABLE dbo.cl_log_bloqueo_opt
GO

CREATE TABLE cl_log_bloqueo_opt
    (
    lb_ente           int not null,
    lb_num_causa      smallint not null,
    lb_fecha_registro datetime not null
    )
go

print '=====> idx_ente'
go
CREATE UNIQUE NONCLUSTERED INDEX idx_ente ON cl_log_bloqueo_opt
(
    lb_ente
)
go


IF OBJECT_ID ('dbo.cl_estad_clte') IS NOT NULL
	DROP TABLE dbo.cl_estad_clte
GO

CREATE TABLE cl_estad_clte
	(
	ec_oficina     SMALLINT NOT NULL,
	ec_fecha_corte DATETIME NOT NULL,
	ec_tcriterio   VARCHAR (10) NOT NULL,
	ec_criterio    VARCHAR (10) NOT NULL,
	ec_cartera     CHAR (1) NOT NULL,
	ec_cantidad    INT NOT NULL,
	ec_valor       MONEY NOT NULL
	)
go

IF OBJECT_ID ('dbo.listado_tmp3') IS NOT NULL
	DROP TABLE dbo.listado_tmp3
GO

CREATE TABLE listado_tmp3
	(
	secuencial INT NOT NULL,
	ciudad     INT,
	nomciudad  descripcion NOT NULL,
	oficina    INT,
	nomoficina descripcion NOT NULL
	)
go

IF OBJECT_ID ('dbo.cl_cuentas_embargo') IS NOT NULL
	DROP TABLE dbo.cl_cuentas_embargo
GO

CREATE TABLE cl_cuentas_embargo
       (ce_cliente         int        not null,
        ce_fecha_crea      datetime   not null,
        ce_fecha_mod       datetime   not null,
        ce_fecha_cierre    datetime   null,
        ce_tipo_emb        char(1)    not null,
        ce_estado          char(1)    null,
        ce_cta_banco       cuenta     null,
        ce_num_emb         smallint   not null,
        ce_valor_ret       money      not null,
        ce_producto        tinyint    not null,
        ce_valor_emb       money      not null,
        ce_parametro_emb   varchar(6) not null)
go

IF OBJECT_ID ('dbo.cl_negocio_cliente') IS NOT NULL
	DROP TABLE dbo.cl_negocio_cliente
GO

create table cl_negocio_cliente (
        nc_codigo           int         not null,
        nc_ente             int         not null,
        nc_nombre           varchar(60) null,
        nc_giro             varchar(10) null,
        nc_fecha_apertura   datetime    null,
        nc_calle            varchar(80) null,
        nc_nro              int         null,
        nc_colonia          varchar(10) null,
        nc_localidad        varchar(10) null,
        nc_municipio        varchar(10) null,
        nc_estado           varchar(10) null,
        nc_codpostal        varchar(30) null,
        nc_pais             varchar(10) null,
        nc_telefono         varchar(20) null,
        nc_actividad_ec     varchar(10) null,
        nc_tiempo_actividad int         null,
        nc_tiempo_dom_neg   int         null,
        nc_emprendedor      char(1)     null,
        nc_recurso          varchar(10) null,
        nc_ingreso_mensual  money       null,
        nc_tipo_local       varchar(10) null,
        nc_estado_reg       varchar(10) null,
		nc_destino_credito  varchar(10) null
)
go

print '=====> ix_negocio_cliente'
go
create nonclustered index ix_negocio_cliente on cl_negocio_cliente
(
    nc_codigo,
    nc_ente
) on indexgroup
go

--TABLAS PARA VCC

IF OBJECT_ID ('dbo.bv_afiliados_bv') IS NOT NULL
	DROP TABLE dbo.bv_afiliados_bv
GO
CREATE TABLE dbo.bv_afiliados_bv  (
	af_ente            	int NOT NULL,
	af_login           	varchar(30) NOT NULL,
	af_canal           	tinyint NOT NULL,
	af_nombre_login    	varchar(64) NULL,
	af_estado          	char(1) NOT NULL,
	af_fecha_afiliacion	datetime NOT NULL,
	af_perfil          	smallint NULL,
	af_perfil_alterno  	varchar(10) NULL,
	af_oficina         	smallint NOT NULL,
	af_ente_mis        	int NULL
	)
GO

--cl_actividad_economica
IF OBJECT_ID ('dbo.cl_actividad_economica') IS NOT NULL
	DROP TABLE dbo.cl_actividad_economica
GO
CREATE TABLE cl_actividad_economica  (
	ae_secuencial         	int NOT NULL,
	ae_ente               	int NOT NULL,
	ae_actividad          	varchar(10) NOT NULL,
	ae_sector             	varchar(10) NOT NULL,
	ae_subactividad       	varchar(10) NOT NULL,
	ae_subsector          	varchar(10) NOT NULL,
	ae_fuente_ing         	varchar(10) NOT NULL,
	ae_principal          	char(1) NOT NULL,
	ae_dias_atencion      	varchar(10) NOT NULL,
	ae_horario_atencion   	varchar(20) NOT NULL,
	ae_fecha_inicio_act   	datetime NULL,
	ae_antiguedad         	int NULL,
	ae_ambiente           	varchar(10) NULL,
	ae_autorizado         	char(1) NOT NULL,
	ae_afiliado           	char(1) NOT NULL,
	ae_lugar_afiliacion   	varchar(64) NULL,
	ae_num_empleados      	int NULL,
	ae_desc_actividad     	varchar(255) NULL,
	ae_ubicacion          	varchar(10) NOT NULL,
	ae_horario_actividad  	varchar(20) NOT NULL,
	ae_desc_caedec        	varchar(255) NULL,
	ae_estado             	char(1) NULL,
	ae_verificado         	char(1) NULL,
	ae_fecha_verificacion 	datetime NULL,
	ae_fuente_verificacion	varchar(10) NULL,
	ae_funcionario        	login NULL,
	ae_fecha_modificacion 	datetime NULL
	)
ON [default]
GO
CREATE UNIQUE CLUSTERED INDEX cl_actividad_economica_Key
	ON cl_actividad_economica(ae_secuencial)
	ON [default]
GO
CREATE NONCLUSTERED INDEX icl_actividad_economica
	ON cl_actividad_economica(ae_ente)
	ON [default]
GO

IF OBJECT_ID ('dbo.cl_subsector_ec') IS NOT NULL
	DROP TABLE dbo.cl_subsector_ec
GO
CREATE TABLE dbo.cl_subsector_ec  (
	se_codigo     	catalogo NOT NULL,
	se_descripcion	descripcion NULL,
	se_estado     	estado NULL,
	se_codSector  	catalogo NULL
	)
GO

--cl_sector_economico
if not object_id('cl_sector_economico') is null
   drop table cl_sector_economico
go
CREATE TABLE cl_sector_economico  (
	se_codigo     	catalogo NOT NULL,
	se_descripcion	descripcion NULL,
	se_estado     	estado NULL,
	se_codFuentIng	char(10) NULL
	)
CREATE UNIQUE CLUSTERED INDEX cl_sector_economico_Key
	ON cl_sector_economico(se_codigo)
	ON [default]
go


if not object_id('cl_subactividad_ec') is null
   drop table cl_subactividad_ec
go
CREATE TABLE cl_subactividad_ec  (
	se_codigo        	catalogo NOT NULL,
	se_descripcion   	varchar(255) NULL,
	se_estado        	estado NULL,
	se_codActEc      	catalogo NULL,
	se_codCaedge     	varchar(255) NULL,
	se_aclaracionFie 	varchar(255) NULL,
	se_aclaracionFie2	varchar(255) NULL,
	se_aclaracionFie3	varchar(255) NULL,
	se_aclaracionFie4	varchar(255) NULL
	)
CREATE UNIQUE CLUSTERED INDEX cl_subactividad_ec_Key
	ON cl_subactividad_ec(se_codigo)
	ON [default]
go


IF OBJECT_ID ('dbo.cl_actividad_ec') IS NOT NULL
	DROP TABLE dbo.cl_actividad_ec
GO
CREATE TABLE dbo.cl_actividad_ec  (
	ac_codigo      	catalogo NOT NULL,
	ac_descripcion 	varchar(200) NULL,
	ac_sensitiva   	char(1) NULL,
	ac_industria   	catalogo NULL,
	ac_estado      	char(1) NULL,
	ac_codSubsector	catalogo NULL,
	ac_homolog_pn  	catalogo NULL,
	ac_homolog_pj  	catalogo NULL
	)
GO


IF OBJECT_ID ('dbo.cl_infocred_central') IS NOT NULL
	DROP TABLE dbo.cl_infocred_central
GO
CREATE TABLE dbo.cl_infocred_central  (
	ic_tipo_id         	catalogo NULL,
	ic_id              	numero NULL,
	ic_nomlar          	varchar(254) NULL,
	ic_fecha_nac       	datetime NULL,
	ic_entidad         	varchar(254) NULL,
	ic_tipo_obligacion 	varchar(50) NULL,
	ic_tipo_credito    	varchar(254) NULL,
	ic_estado_act      	varchar(20) NULL,
	ic_monto_act       	money NULL,
	ic_fecha_crea_deuda	datetime NULL,
	ic_fecha_act_deuda 	datetime NULL,
	ic_tipo_lista      	varchar(20) NULL
	)
GO

-- LGU instalacion tablas nuevas

/************************************/
--CREACION TABLA cobis..cl_ente_aux
/************************************/

if exists (select 1 from sysobjects where name = 'cl_ente_aux' and type = 'U')
   drop table cl_ente_aux
go

CREATE TABLE dbo.cl_ente_aux
	(
	ea_ente                INT NOT NULL,
	ea_estado              catalogo NOT NULL,
	ea_observacion_aut     VARCHAR (255) NULL,
	ea_contrato_firmado    CHAR (1) NULL,
	ea_menor_edad          CHAR (1) NULL,
	ea_conocido_como       VARCHAR (255) NULL,
	ea_cliente_planilla    CHAR (1) NULL,
	ea_cod_risk            VARCHAR (20) NULL,
	ea_sector_eco          catalogo NULL,
	ea_actividad           catalogo NULL,
	ea_lin_neg             catalogo NULL,
	ea_seg_neg             catalogo NULL,
	ea_ejecutivo_con       INT NULL,
	ea_suc_gestion         SMALLINT NULL,
	ea_constitucion        SMALLINT NULL,
	ea_remp_legal          INT NULL,
	ea_apoderado_legal     INT NULL,
	ea_no_req_kyc_comp     CHAR (1) NULL,
	ea_fuente_ing          catalogo NULL,
	ea_act_prin            catalogo NULL,
	ea_detalle             VARCHAR (255) NULL,
	ea_act_dol             MONEY NULL,
	ea_cat_aml             catalogo NULL,
	ea_fecha_vincula       DATETIME NULL,
	ea_observacion_vincula VARCHAR (255) NULL,
	ea_ced_ruc             numero NULL,
	ea_discapacidad        CHAR (1) NULL,
	ea_tipo_discapacidad   catalogo NULL,
	ea_ced_discapacidad    VARCHAR (30) NULL,
	ea_id_prefijo          catalogo NULL,
	ea_id_sufijo           catalogo NULL,
	ea_duplicado           CHAR (1) NULL,
	ea_nivel_egresos       catalogo NULL,
	ea_ifi                 CHAR (1) NULL,
	ea_asfi                CHAR (1) NULL,
	ea_path_foto           VARCHAR (50) NULL,
	ea_nit                 numero NULL,
	ea_nit_venc            DATETIME NULL,
	ea_num_testimonio      VARCHAR (10) NULL,
	ea_indefinido          CHAR (1) NULL,
	ea_fecha_vigencia      DATETIME NULL,
	ea_nombre_notaria      VARCHAR (64) NULL,
	ea_nombre_notario      VARCHAR (64) NULL,
	ea_safie               VARCHAR (20) NULL,
	ea_sigaf               VARCHAR (20) NULL,
	ea_tipo_creacion       CHAR (1) NULL,
	ea_ventas              MONEY NULL,
	ea_ot_ingresos         MONEY NULL,
	ea_ct_ventas           MONEY NULL,
	ea_ct_operativo        MONEY NULL,
	ea_ant_nego            INT NULL,
	ea_cta_banco           VARCHAR (45) NULL,
	ea_nro_ciclo_oi        INT NULL,
	ea_partner             CHAR(1) NULL,
	ea_lista_negra         CHAR(1) NULL,
	ea_tecnologico         char(10) NULL,
	ea_fiel                VARCHAR(20) NULL,
    ea_fecha_report        datetime NULL,
	ea_fecha_report_resp   datetime NULL
	ea_numero_ife          VARCHAR(13) NULL,
	ea_num_serie_firma     VARCHAR(20) NULL,
	ea_telef_recados       VARCHAR(10) NULL,
	ea_persona_recados     VARCHAR(60) NULL,
    ea_antecedente_buro    VARCHAR(2)  NULL,
    ea_act_profesional     VARCHAR(10)  NULL,
    ea_nivel_riesgo_cg     char(1) null,
    ea_puntaje_riesgo_cg   char(3) null,
    ea_fecha_evaluacion    datetime null,
    ea_sum_vencido         money null,
    ea_num_vencido         int null,
	ea_nivel_riesgo        VARCHAR(50) NULL,
	ea_puntaje_riesgo      INT NULL,
	ea_negative_file       CHAR(1) NULL,
	ea_oficina_origen      smallint NULL,
	ea_colectivo           VARCHAR(64) null,
	ea_nivel_colectivo     VARCHAR(64) null,
	ea_asesor_ext          int null,
	ea_consulto_renapo     CHAR(2) NULL,
	ea_fecha_activacion    datetime null,
	ea_onboarding          char(1) NULL,
	ea_nivel_riesgo_1      char(1) null,
	ea_nivel_riesgo_2      char(2) null,
	ea_tipo_calif_eva_cli  varchar(10) null
	)
GO
go

create nonclustered index iea_estado on cl_ente_aux (ea_ente,ea_estado)
go

create unique index cl_ente_aux_Key on cl_ente_aux (ea_ente)
go




/***************************************/
--CREACION TABLA cobis..cl_actividad_ec
/***************************************/
if exists (select 1 from sysobjects where name = 'cl_actividad_ec' and type = 'U')
   drop table cl_actividad_ec
go

create table cl_actividad_ec (
ac_codigo       catalogo        not null,
ac_descripcion  varchar(200)    null,
ac_sensitiva    char(1)         null,
ac_industria    catalogo        null,
ac_estado       char(1)         null,
ac_codSubsector catalogo        null,
ac_homolog_pn   catalogo        null,
ac_homolog_pj   catalogo        null
)
go

/***************************************/
--CREACION TABLA cobis..cl_registro_identificacion
/***************************************/
if exists (select 1 from sysobjects where name = 'cl_registro_identificacion' and type = 'U')
   drop table cl_registro_identificacion
go

create table cl_registro_identificacion(
ri_ente           int           not null,
ri_tipo_iden      char(4)       not null,
ri_identificacion numero        not null,
ri_fecha_act      datetime      not null,
ri_hora_act       datetime      not null,
ri_usuario        varchar(30)   not null,
ri_nom_usuario    varchar(80)   null
)
go

create nonclustered index icl_ente on cl_registro_identificacion (ri_ente)
go

create nonclustered index icl_ident on cl_registro_identificacion (ri_identificacion)
go

create nonclustered index icl_fec on cl_registro_identificacion (ri_fecha_act)
go



/***************************************/
--CREACION TABLA cobis..cl_tipo_documento
/***************************************/
if not object_id('cl_tipo_documento') is null
   drop table cl_tipo_documento
go
print 'creacion cl_tipo_documento'
go
CREATE TABLE cl_tipo_documento  (
	td_secuencial    	int NOT NULL,
	td_codigo        	char(4) NOT NULL,
	td_descripcion   	varchar(60) NOT NULL,
	td_mascara       	varchar(20) NULL,
	td_tipoper       	char(1) NULL,
	td_provincia     	char(1) NULL,
	td_aperrapida    	char(1) NULL,
	td_bloquea       	char(1) NULL,
	td_nacionalidad  	varchar(15) NULL,
	td_digito        	char(1) NULL,
	td_estado        	char(1) NULL,
	td_desc_corta    	varchar(10) NULL,
	td_compuesto     	char(1) NULL,
	td_nro_compuesto 	tinyint NULL,
	td_adicional     	tinyint NULL,
	td_creacion      	char(1) NULL,
	td_habilitado_mis	char(1) NULL,
	td_habilitado_usu	char(1) NULL,
	td_prefijo       	varchar(10) NULL,
	td_subfijo       	varchar(10) NULL
	)
GO
CREATE UNIQUE CLUSTERED INDEX cl_tipo_documento_Key
	ON cl_tipo_documento(td_codigo)
	ON [default]
GO
-----------

if not object_id('cl_direccion_geo') is null
   drop table cl_direccion_geo
go
print 'creacion cl_direccion_geo'
go
create table cl_direccion_geo  (
	dg_ente        	int         null,
	dg_direccion   	tinyint     null,
	dg_lat_coord   	char(1)     null,
	dg_lat_grad    	tinyint     null,
	dg_lat_min     	tinyint     null,
	dg_lat_seg     	float       null,
	dg_long_coord  	char(1)     null,
	dg_long_grad   	tinyint     null,
	dg_long_min    	tinyint     null,
	dg_long_seg    	float       null,
	dg_path_croquis	varchar(50) null,
	dg_secuencial  	int         null
	)
go
create unique CLUSTERED index cl_direccion_geo_Key
on cl_direccion_geo(dg_ente, dg_direccion, dg_secuencial)

go

--cl_homologar_cat
if not object_id('cl_homologar_cat') is null
   drop table cl_homologar_cat
go
print 'creacion cl_homologar_cat'
CREATE TABLE cl_homologar_cat  (
	hc_codigo   	catalogo NULL,
	hc_producto 	tinyint NULL,
	hc_cat_banco	catalogo NULL,
	hc_cat_cobis	catalogo NULL,
	hc_estado   	char(1) NULL
	)
--LOCK ALLPAGES
GO
CREATE UNIQUE CLUSTERED INDEX cl_homologar_cat_Key
	ON cl_homologar_cat(hc_producto, hc_cat_banco, hc_cat_cobis)
	ON [default]
GO

--cl_mod_estados
if not object_id('cl_mod_estados') is null
   drop table cl_mod_estados
go
CREATE TABLE cl_mod_estados  (
	me_sec        	int NOT NULL,
	me_ente       	int NULL,
	me_usuario    	login NULL,
	me_fecha      	datetime NULL,
	me_est_act    	catalogo NULL,
	me_est_nue    	catalogo NULL,
	me_observacion	descripcion NULL,
	me_interface  	catalogo NULL
	)
--LOCK ALLPAGES
GO
CREATE UNIQUE CLUSTERED INDEX cl_mod_estados_Key
	ON dbo.cl_mod_estados(me_sec, me_ente, me_fecha)
	ON [default]
GO

--cl_actividad_principal
if not object_id('cl_actividad_principal') is null
   drop table cl_actividad_principal
go
CREATE TABLE cl_actividad_principal  (
	ap_codigo     	catalogo NOT NULL,
	ap_descripcion	varchar(250) NULL,
	ap_activ_comer	catalogo NULL,
	ap_estado     	char(1) NULL
	)
ON [default]
GO
CREATE NONCLUSTERED INDEX cl_actividad_principal_Key
	ON dbo.cl_actividad_principal(ap_codigo)
	ON [default]
GO


--cl_isic_code
if not object_id('cl_isic_code') is null
   drop table cl_isic_code
go
CREATE TABLE cl_isic_code  (
	is_secuencial  	numeric(10,0) IDENTITY NOT NULL,
	is_codigo      	varchar(20) NOT NULL,
	is_seccionCode 	catalogo NOT NULL,
	is_seccion     	varchar(150) NOT NULL,
	is_divisionCode	catalogo NOT NULL,
	is_division    	varchar(150) NOT NULL,
	is_grupoCode   	catalogo NOT NULL,
	is_grupo       	varchar(150) NOT NULL,
	is_claseCode   	catalogo NOT NULL,
	is_clase       	varchar(150) NOT NULL,
	is_estado      	catalogo NOT NULL
	)
--LOCK ALLPAGES
GO
CREATE UNIQUE CLUSTERED INDEX cl_isic_code_Key
	ON cl_isic_code(is_codigo)
	ON [default]
GO

IF OBJECT_ID ('dbo.cl_mod_segmento') IS NOT NULL
	DROP TABLE dbo.cl_mod_segmento
GO

CREATE TABLE dbo.cl_mod_segmento
	(
	ms_ente     INT NOT NULL,
	ms_fecha    DATETIME NOT NULL,
	ms_anterior VARCHAR (24) NULL,
	ms_actual   VARCHAR (24) NULL,
	ms_login    login NULL,
	ms_oficina  INT NULL,
	ms_campo    VARCHAR (24) NULL
	)
GO

CREATE NONCLUSTERED INDEX cl_mod_segmento_Key
	ON dbo.cl_mod_segmento (ms_ente,ms_fecha)
GO

--cl_codigo_postal
IF OBJECT_ID ('dbo.cl_codigo_postal') IS NOT NULL
 DROP TABLE dbo.cl_codigo_postal
GO

create table cl_codigo_postal(
cp_codigo            varchar(10) not null,
cp_estado            int         null,
cp_municipio         int         null,
cp_colonia           int         null,
cp_pais              int         NULL,
cp_estado_h          VARCHAR(20) null,
cp_municipio_h       VARCHAR(20) null,
cp_colonia_h         VARCHAR(20) null
)
go

CREATE INDEX idx_1 ON cl_codigo_postal (cp_codigo)
GO


---------------------------------------------------------------------------------------
-------------------------- Crear tabla de  validar secciones --------------------------
---------------------------------------------------------------------------------------

use cobis
go


IF OBJECT_ID ('dbo.cl_seccion_validar') IS NOT NULL
	DROP TABLE dbo.cl_seccion_validar
GO

CREATE TABLE dbo.cl_seccion_validar
	(
	sv_ente               int not null,
	sv_seccion            catalogo null,
	sv_completado         char(1) null
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_seccion_validar_Key
	ON dbo.cl_seccion_validar (sv_ente, sv_seccion)
GO


---------------------------------------------------------------------------------------
----------------------- Crear tabla de Notificaciones Generales -----------------------
---------------------------------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_notificacion_general') IS NOT NULL
	DROP TABLE dbo.cl_notificacion_general
GO

CREATE TABLE dbo.cl_notificacion_general
	(
	ng_codigo            int not null,
	ng_mensaje          VARCHAR(1000) NOT null,
	ng_correo         	VARCHAR(60) NOT null,
	ng_asunto           VARCHAR(255) NOT null
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_notificacion_general_Key
	ON dbo.cl_notificacion_general (ng_codigo)
GO

---------------------------------------------------------------------------------------
----------------------- Crear tabla de Notificaciones Generales -----------------------
---------------------------------------------------------------------------------------

IF OBJECT_ID ('dbo.cl_ns_generales_estado') IS NOT NULL
	DROP TABLE dbo.cl_ns_generales_estado
GO

CREATE TABLE dbo.cl_ns_generales_estado
	(
	nge_codigo 	INT NOT NULL,
	nge_estado  	CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_ns_generales_estado_Key
	ON dbo.cl_ns_generales_estado (nge_codigo)
GO
--/////////////////////////////////////////////////////////////////////////

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
---------------------------------------------------------------------------
-------------------Crear tabla de Actividades Economicas-------------------
---------------------------------------------------------------------------

IF OBJECT_ID ('dbo.cl_actividad_generica') IS NOT NULL
	DROP TABLE dbo.cl_actividad_generica
GO

CREATE TABLE dbo.cl_actividad_generica
	(
	acg_codigo_generica        varchar(10) null,
	acg_actividad_generica 		varchar(15) not null, 
	acg_codigo_actividad 		varchar(10) not null, 
	acg_actividad_especifica  	varchar(150) not null, 
	acg_nombre_corto 			   varchar(40),
	acg_nivel_riesgo 			   varchar(15),
	acg_valor  					   money
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_actividad_generica_Key
	ON dbo.cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad)
GO

--////////////////////////////////////////////////////////////////////////////
---------------------------------------------------------------------------
-------------------Crear tabla temporal de los clientes en  listas negras-------------------
---------------------------------------------------------------------------

IF OBJECT_ID ('cobis..cl_listas_negras_tmp') IS NOT NULL
	DROP TABLE cobis..cl_listas_negras_tmp
GO

CREATE TABLE cobis..cl_listas_negras_tmp
	(
	fecha_proceso    DATETIME,
    nombres_completos	 	VARCHAR(300),
    fecha_nac        DATETIME,
    tipo_lista       VARCHAR(10)
	)
GO

--////////////////////////////////////////////////////////////////////////////
---------------------------------------------------------------------------
-------------------Crear tabla cl_ente_adicional -------------------
---------------------------------------------------------------------------
IF OBJECT_ID ('cobis..cl_ente_adicional') IS NOT NULL
	DROP TABLE cobis..cl_ente_adicional
GO

CREATE TABLE cobis..cl_ente_adicional
	(
	ea_ente     VARCHAR (50) NULL,
	ea_columna  VARCHAR (30) NULL,
	ea_char     VARCHAR (30) NULL,
	ea_tinyint  TINYINT NULL,
	ea_smallint SMALLINT NULL,
	ea_int      INT NULL,
	ea_money    MONEY NULL,
	ea_datetime DATETIME NULL,
	ea_float    FLOAT NULL
	)
GO

CREATE CLUSTERED INDEX ea_ente
	ON cobis..cl_ente_adicional (ea_ente,ea_columna)
GO


---------------------------------------------------------------------------
-------------------Crear tabla cl_cliente_candidato_tmp -------------------
---------------------------------------------------------------------------
IF OBJECT_ID ('dbo.cl_cliente_candidato_tmp') IS NOT null
	DROP TABLE dbo.cl_cliente_candidato_tmp
GO

create table cl_cliente_candidato_tmp (
	cc_ente				int primary key not null,
	cc_nombre   		varchar(64) null,
	cc_p_apellido		varchar(64) null,
	cc_s_apellido		varchar(64) null,
	cc_nivel_riesgo 	char(3) null,
	cc_riesgo_matriz    varchar(50) null,
	cc_gerente          varchar(64) null,
	cc_asesor           varchar(64) null
)

USE [cobis]
GO

IF OBJECT_ID ('cobis..cl_producto_santander') IS NOT NULL
	DROP TABLE cobis..cl_producto_santander
GO


/****** Object:  Table [dbo].[cl_producto_santander]    Script Date: 09/05/2018 17:53:07 ******/

CREATE TABLE [dbo].[cl_producto_santander](
	[pr_ente] [int] NOT NULL,
	[pr_buc] [varchar](8) NOT NULL,
	[pr_numero_contrato] [varchar](50) NOT NULL,
	[pr_codigo_producto] [char](2) NOT NULL,
	[pr_codigo_subproducto] [char](4) NOT NULL,
	[pr_estado] [char](1) NOT NULL,
	[pr_codigo_moneda] [char](3) NOT NULL,
	[pr_fecha_consulta] [datetime] NOT NULL,
 CONSTRAINT [PK_cl_producto_santander] PRIMARY KEY CLUSTERED 
(
	[pr_ente] ASC,
	[pr_numero_contrato] ASC
	
)
)
GO


--////////////////////////////////////////////////////////////////////////////
---------------------------------------------------------------------------
-------------------Crear tabla cl_operaciones_inusuales -------------------
---------------------------------------------------------------------------
go

IF OBJECT_ID ('dbo.cl_operaciones_inusuales') IS NOT NULL
	DROP TABLE dbo.cl_operaciones_inusuales
go

create table cl_operaciones_inusuales
	(
	oin_codigo              int not null,
	oin_tipo_op             catalogo not null,
	oin_fecha_alta          datetime,
	oin_fecha_reporte       datetime,
	oin_nombre_rep          varchar(100),
	oin_estado              char(2),
	oin_comentario          varchar(500)  
	)
go

CREATE UNIQUE CLUSTERED INDEX cl_operaciones_inusuales_Key
	ON dbo.cl_operaciones_inusuales (oin_codigo)
go

--////////////////////////////////////////////////////////////////////////////
---------------------------------------------------------------------------
-------------------Crear tabla cl_ns_alertas_riesgo -------------------
---------------------------------------------------------------------------

go

IF OBJECT_ID ('dbo.cl_ns_alertas_riesgo') IS NOT NULL
	DROP TABLE dbo.cl_ns_alertas_riesgo
go

create table cl_ns_alertas_riesgo
	(
	nar_codigo              int not null,
	nar_cliente             int not null,
	nar_nombre              varchar(255),
	nar_tipo_lista          varchar(100),
	nar_fecha_proceso       datetime not null,
	nar_correo              varchar(64),
	nar_estado              char(1)
	)
go

CREATE UNIQUE CLUSTERED INDEX cl_ns_alertas_riesgo_Key
	ON dbo.cl_ns_alertas_riesgo (nar_codigo)
go

IF OBJECT_ID ('dbo.cl_alertas_riesgo') IS NOT NULL
	DROP TABLE dbo.cl_alertas_riesgo
GO

--////////////////////////////////////////////////////////////////////////////
---------------------------------------------------------------------------
-------------------Crear tabla cl_alertas_riesgo -------------------
---------------------------------------------------------------------------

CREATE TABLE dbo.cl_alertas_riesgo
	(
	ar_id_alerta       INT IDENTITY NOT NULL,
	ar_sucursal        INT NOT NULL,
	ar_grupo           INT NULL,
	ar_ente            INT NOT NULL,
	ar_nombre_grupo    VARCHAR (64) NULL,
	ar_nombre          VARCHAR (254) NULL,
	ar_rfc             VARCHAR (30) NULL,
	ar_contrato        VARCHAR (24) NULL,
	ar_tipo_producto   VARCHAR (255) NULL,
	ar_tipo_lista      VARCHAR (2) NULL,
	ar_fecha_consulta  DATETIME NULL,
	ar_fecha_alerta    DATETIME NULL,
	ar_fecha_operacion DATETIME NULL,
	ar_fecha_dictamina DATETIME NULL,
	ar_fecha_reporte   DATETIME NULL,
	ar_observaciones   VARCHAR (255) NULL,
	ar_nivel_riesgo    VARCHAR (255) NULL,
	ar_etiqueta        VARCHAR (255) NOT NULL,
	ar_escenario       VARCHAR (300) NULL,
	ar_tipo_alerta     VARCHAR (100) NULL,
	ar_tipo_operacion  VARCHAR (255) NULL,
	ar_monto           MONEY NULL,
	ar_status          VARCHAR (100) NULL,
	ar_genera_reporte  VARCHAR (2) NULL,
	ar_codigo          int   null
	)
GO

CREATE NONCLUSTERED INDEX cl_alertas_riesgo_key
	ON dbo.cl_alertas_riesgo (ar_ente,ar_etiqueta)
GO

--////////////////////////////////////////////////////////////////////////////
---------------------------------------------------------------------------
-------------------Crear tabla cl_cat_reg_negocio -------------------
---------------------------------------------------------------------------
if exists(select 1 from sysobjects where name = 'cl_cat_reg_negocio')
    drop table cl_cat_reg_negocio
go

print 'Creacion de tabla para catalogo cl_cat_reg_negocio'
CREATE TABLE cl_cat_reg_negocio(
    reg_neg_id             INT IDENTITY,
    reg_neg_etiqueta       VARCHAR(15) NOT NULL,
    reg_neg_descripcion    VARCHAR(300) NOT NULL,
	reg_neg_cuenta_pagos   CHAR(1) null
)
go
---------------------------------------------------------------------------
-----------Crear tabla reporte_clientes_consultados_buro_tmp --------------
---------------------------------------------------------------------------

IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'reporte_clientes_consultados_buro_tmp' AND type = 'U')
	BEGIN
		DROP TABLE reporte_clientes_consultados_buro_tmp
	END
GO

CREATE TABLE reporte_clientes_consultados_buro_tmp (
	rct_region				varchar(64) null,
	rct_oficna				varchar(64) null,
	rct_cc					varchar(64) null,
	rct_gerente				varchar(64) null,
	rct_coordinador			varchar(64) null,
	rct_asesor				varchar(64) null,
	rct_email_asesor		varchar(64) null,
	rct_tel_asesor			varchar(64) null,
	rct_status_asesor		varchar(64) null,
	rct_cliente_cobis		varchar(64) null,

	rct_id_buc				varchar(64) null, 
	rct_fecha_registro		varchar(64) null,  
	rct_fecha_consulta_buro	varchar(64) null, 
	rct_folio_consulta_buro	varchar(64) null, 
	rct_app_paterno			varchar(64) null, 
	rct_app_materno			varchar(64) null, 
	rct_nombre1				varchar(64) null,
	rct_nombre2				varchar(64) null,
	rct_entidad_nac			varchar(64) null,
	rct_estado_civil		varchar(64) null,

	rct_fecha_nacimiento	varchar(64) null,
	rct_edad				varchar(64) null,
	rct_email_cliente		varchar(64) null,
	rct_calle				varchar(255) null,
	rct_numero				varchar(64) null,
	rct_numero_interior		varchar(64) null,
	rct_colonia			    varchar(64) null, 
	rct_codigo_postal		varchar(64) null,
	rct_ciudad				varchar(64) null, 
	rct_estado				varchar(64) null,

	rct_municipio			varchar(64) null,
	rct_telefono_cliente	varchar(64) null,
	rct_celular_cliente		varchar(64) null, 
	rct_dom_actual_anios	varchar(64) null, 
	rct_tipo_vivienda		varchar(64) null,
	rct_personas_viviendo	varchar(64) null,
	rct_pais_nacimiento		varchar(64) null,
	rct_genero				varchar(64) null,
	rct_nacionalidad		varchar(64) null,
	rct_escolaridad			varchar(64) null,

	rct_ocupacion			varchar(64) null,
	rct_rfc					varchar(64) null,
	rct_curp				varchar(64) null,
	rct_dependientes_econo	varchar(64) null, 
	rct_is_otros_ingresos	varchar(64) null,
	rct_ciclos_otras_inst	varchar(64) null, 
	rct_pep					varchar(64) null,
	rct_cuenta_ahorro		varchar(64) null,
	rct_nombre_negocio		varchar(64) null,
	rct_destino_credito		varchar(64) null,

	rct_tipo_local			varchar(64),
	rct_calle_neg			varchar(255),
	rct_numero_neg			varchar(64) null,
	rct_numero_neg_interior varchar(64) null,
	rct_colonia_neg			varchar(64) null,
	rct_codigo_postal_neg	varchar(64) null,
	rct_ciudad_neg			varchar(64) null,
	rct_telefono_neg		varchar(64) null,
	rct_cve_act_economica	varchar(64) null,
	rct_nombre_corto_act	varchar(64) null,

	rct_tiempo_des_act		varchar(64) null,
	rct_tiempo_arrigo		varchar(64) null,
	rct_fecha_apertura		varchar(64) null,
	rct_recursos			varchar(64) null,
	rct_ingresos_negocio	varchar(64) null, 
	rct_ingreso_mensual		varchar(64) null,
	rct_gastos_men_negocio	varchar(64) null,
	rct_gastos_men_familia  varchar(64) null,
	rct_otros_ingresos		varchar(64) null,
	rct_capacidad_pago		varchar(64) null,

	rct_exp_crediticia		varchar(64) null,
	rct_numero_ine			varchar(64) null,
	rct_pasaporte			varchar(64) null,
	rct_telefono_recados	varchar(64) null,
	rct_persona_recados		varchar(64) null, 
	rct_antecedentes_buro	varchar(64) null, 
	rct_calif_matriz_pld    varchar(64) null,
	--rct_riesgo_individual	varchar(64) null,
	rct_cve_resp_informe	varchar(255) null,
	rct_exp_cred_comprobada varchar(255) null,
	rct_tiene_credito       varchar(64) null,
	rct_motivo_rechazo		varchar(64) null
)


---------------------------------------------------------------------------
-------------------- Crear tabla cl_clientes_calif ------------------------
---------------------------------------------------------------------------

use cobis
go

IF OBJECT_ID ('dbo.cl_clientes_calif') IS NOT null
	DROP TABLE dbo.cl_clientes_calif
GO

create table cl_clientes_calif (
	cc_ente		int not null,
	cc_calif    char(1)
)

CREATE NONCLUSTERED INDEX cl_clientes_calif
	ON dbo.cl_clientes_calif (cc_ente)
GO

---------------------------------------------------------------------------
-------------------- Crear tabla cl_modificacion_curp_rfc -----------------
---------------------------------------------------------------------------
use cobis
go

IF OBJECT_ID ('dbo.cl_modificacion_curp_rfc') IS NOT NULL
	DROP table dbo.cl_modificacion_curp_rfc
go

create table dbo.cl_modificacion_curp_rfc
	(
	mcr_ente        int,
	mcr_ssn_user    login,
	mcr_ssn_oficina smallint,
	mcr_fecha       datetime,
	mcr_oficial     smallint,
	mcr_oficina     smallint,
	mcr_curp_ant    varchar(30),
	mcr_rfc_ant     varchar(30),
	mcr_curp        varchar(30),
	mcr_rfc         varchar(30),	
	mcr_operacion   varchar(10),
	mcr_sp          varchar(100)
	
	)
go

IF OBJECT_ID ('dbo.cl_lista_exclusion') IS NOT NULL
	DROP TABLE dbo.cl_lista_exclusion
GO

CREATE TABLE dbo.cl_lista_exclusion
	(
	le_secuencial          int IDENTITY not null,
	le_ente                INT NOT NULL,
	le_accion              CHAR(1) NULL,
	le_calif               CHAR(1) NULL,
	le_fecha               DATETIME NULL,
	le_login               catalogo NULL	
	)
GO
---------------------------------------------------------------------------
-------------------- Crear tabla cl_conyuge------------------------
---------------------------------------------------------------------------

use cobis 
go

if object_id('cl_conyuge') is not null 
begin
	drop table cobis..cl_conyuge
end
else
	begin
		create table cobis..cl_conyuge
		(
			co_secuencia int,
			co_ente int,
			co_nombre descripcion null,
			co_snombre varchar(50) null,
			co_p_apellido descripcion null,
			co_s_apellido descripcion null,
			co_telefono varchar(10) null,
			co_fecha_nacimiento datetime null,
			co_fecha_crea datetime null
		)
	end

CREATE INDEX IDX_CONYUGE_SECUENCIAL ON cobis..cl_conyuge(co_secuencia);
CREATE INDEX IDX_CONYUGE_ENTE ON cobis..cl_conyuge(co_ente);

--secuencia cl_conyuge
DELETE FROM cobis..cl_seqnos WHERE tabla ='cl_conyuge' AND bdatos = 'cobis';
INSERT INTO cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) VALUES ('cobis','cl_conyuge',1,'co_secuencia');

go

---Requerimiento 119655: Cambios WEB APP Auditoría
use cobis
go

IF OBJECT_ID ('dbo.cl_clientes_calif') IS NOT null
	DROP TABLE dbo.cl_clientes_calif
GO

create table cl_clientes_calif (
	cc_ente		int not null,
	cc_calif    char(1)
)
CREATE NONCLUSTERED INDEX cl_clientes_calif
	ON dbo.cl_clientes_calif (cc_ente)
GO

--------------------------------------------------------------------------------------------
-- AGREGAR PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Main/PreProd/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go

--CAMBIAR TIPO DE DATO DE PUNTAJE
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_puntaje_riesgo_cg ' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_puntaje_riesgo_cg  char(3) null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_puntaje_riesgo_cg  char(3) null
end

--FECHA EVALUACION RIESGO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_fecha_evaluacion' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_fecha_evaluacion datetime null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_fecha_evaluacion datetime null
end

--SUMA RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_sum_vencido' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_sum_vencido money null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_sum_vencido money null
end
--NUMERO RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_num_vencido' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_num_vencido int null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_num_vencido int null
end

use cob_sincroniza
go
--NUMERO RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'sid_observacion' and TABLE_NAME = 'si_sincroniza_det')
begin
    alter table cob_sincroniza..si_sincroniza_det add sid_observacion varchar(5000) null
end
else
begin
	alter table cob_sincroniza..si_sincroniza_det alter column sid_observacion varchar(5000) null
end

---	CAMPO PARA INGRESOS DE NEGOCIO MENSUAL

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_ingreso_negocio' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_ingreso_negocio money
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_ingreso_negocio money
end

--cl_ingresos_sistema
if object_id ('dbo.cl_ingresos_sistema') is not null
	drop table dbo.cl_ingresos_sistema
go

create table cl_ingresos_sistema(
is_usuario           varchar(30),
is_nombre            varchar(64),
is_medio             varchar(30),
is_fecha             varchar(10),
is_hora              varchar(30)
)

go


-----------------------------------------------------------------------------
----------TABLAS TU NEGOCIO--------------------------------------------------
-----------------------------------------------------------------------------
--- ==========================	cl_frm_negocio

if object_id('cl_frm_negocio') is not null 
	drop table cobis..cl_frm_negocio
go
	create table cobis..cl_frm_negocio
		(
			ne_id_formulario     int not null,
			ne_vers_formulario   int not null,
			ne_nombre_formulario varchar(100),
			ne_estado_version    char(1),
			ne_calif_minima      smallint,
			ne_fecha_creacion    datetime,
			ne_usuario 			 varchar(60)			
		)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_FORMULARIO')
begin	
   drop index IDX_NEGOCIO_FORMULARIO on cl_frm_negocio
end
	create unique index IDX_NEGOCIO_FORMULARIO ON cl_frm_negocio(ne_id_formulario)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_VERSION')
begin	
   drop index IDX_NEGOCIO_VERSION on cl_frm_negocio
end
	create index IDX_NEGOCIO_VERSION ON cl_frm_negocio(ne_vers_formulario)
go

--- ==========================	cl_frm_seccion

if object_id('cl_frm_seccion') is not null 
	drop table cobis..cl_frm_seccion
go
	create table cobis..cl_frm_seccion
		(
			se_id_formulario int not null,
			se_id_vers_form  int not null,
			se_id_seccion    int not null,
			se_etiqueta      varchar(100) not null,
			se_descripcion   varchar(254) null,
			se_mostrar		 varchar(64)  null		
		)
go

if exists (select 1 from sys.indexes where name = 'IDX_SECCION_FORMUL')
begin	
   drop index IDX_SECCION_FORMUL on cl_frm_seccion
end
	create index IDX_SECCION_FORMUL  ON cl_frm_seccion(se_id_formulario)
go

if exists (select 1 from sys.indexes where name = 'IDX_SECCION_VERSION')
begin	
   drop index IDX_SECCION_VERSION on cl_frm_seccion
end
	create index IDX_SECCION_VERSION ON cl_frm_seccion(se_id_vers_form)
go

if exists (select 1 from sys.indexes where name = 'IDX_SECCION')
begin	
   drop index IDX_SECCION on cl_frm_seccion
end
	create index IDX_SECCION         ON cl_frm_seccion(se_id_seccion)
go

if exists (select 1 from sys.indexes where name = 'IDX_SECCION_1')
begin	
   drop index IDX_SECCION_1 on cl_frm_seccion
end
create nonclustered index IDX_SECCION_1 on cl_frm_seccion(se_id_formulario,se_id_vers_form)
go   


--- ==========================	cl_frm_preguntas

if object_id('cl_frm_preguntas') is not null 
	drop table cobis..cl_frm_preguntas
go
	create table cobis..cl_frm_preguntas
		(
			pe_pregunta     int not null,
			pe_seccion      int not null,
			pe_formulario   int not null,
			pe_version      int not null,
			pe_etiqueta     varchar(100) not null,
			pe_descripcion  varchar(254) null,
			pe_tipo_resp    char(1),
			pe_obligatoria  char(1),
			pe_registros	tinyint,
			pe_repetidos	char(1)
		)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_PREGUNTA')
begin	
   drop index IDX_FRM_PREGUNTA on cl_frm_preguntas
end
	create unique index IDX_FRM_PREGUNTA ON cl_frm_preguntas(pe_pregunta)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_SECCIONP')
begin	
   drop index IDX_FRM_SECCIONP on cl_frm_preguntas
end
	create index IDX_FRM_SECCIONP ON cl_frm_preguntas(pe_seccion)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_FORM')
begin	
   drop index IDX_FRM_FORM on cl_frm_preguntas
end
	create index IDX_FRM_FORM ON cl_frm_preguntas(pe_formulario)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_VERSION')
begin	
   drop index IDX_FRM_VERSION on cl_frm_preguntas
end
	create index IDX_FRM_VERSION ON cl_frm_preguntas(pe_version)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_PREGUNTAS_1')
begin	
   drop index IDX_FRM_PREGUNTAS_1 on cl_frm_preguntas
end
	create nonclustered index IDX_FRM_PREGUNTAS_1 on cl_frm_preguntas (pe_formulario, pe_version,pe_pregunta)
go


--- ==========================	cl_frm_pregunta_tabla

if object_id('cl_frm_pregunta_tabla') is not null 
	drop table cobis..cl_frm_pregunta_tabla
go
	create table cobis..cl_frm_pregunta_tabla
		(
			pt_formulario     int not null,
			pt_pregunta_form  int not null,
			pt_tabla          int not null,
			pt_columna        varchar(60) not null,
			pt_tipo_dato      char(1) not null,
			pt_catalogo		  int null,
			pt_obligatoriedad char(1) not null
		)
go

if exists (select 1 from sys.indexes where name = 'IDX_PE_TAB_FORMUL')
begin	
   drop index IDX_PE_TAB_FORMUL on cl_frm_pregunta_tabla
end
	create index IDX_PE_TAB_FORMUL ON cl_frm_pregunta_tabla(pt_formulario)
go

if exists (select 1 from sys.indexes where name = 'IDX_PE_TA_PREG')
begin	
   drop index IDX_PE_TA_PREG on cl_frm_pregunta_tabla
end
	create index IDX_PE_TA_PREG    ON cl_frm_pregunta_tabla(pt_pregunta_form)
go

if exists (select 1 from sys.indexes where name = 'IDX_PE_TABLA')
begin	
   drop index IDX_PE_TABLA on cl_frm_pregunta_tabla
end
	create index IDX_PE_TABLA      ON cl_frm_pregunta_tabla(pt_tabla)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_PREGUNTA_TABLA_1')
begin	
   drop index IDX_FRM_PREGUNTA_TABLA_1 on cl_frm_preguntas
end
	create nonclustered index IDX_FRM_PREGUNTA_TABLA_1 on cl_frm_pregunta_tabla (pt_formulario, pt_pregunta_form,	pt_tabla)
go

--- ==========================	cl_frm_ente_respuesta

if object_id('cl_frm_ente_respuesta') is not null 
	drop table cobis..cl_frm_ente_respuesta
go
	create table cobis..cl_frm_ente_respuesta
		(
			en_ente           int not null,
			en_respuesta_ente int not null, -- secuencial
			en_formulario  	  int not null,
			en_version        int not null,
			en_pregunta_form  int not null,
			en_respuesta      varchar(255) null,
			en_fecha_registro datetime not null,
			en_usuario        varchar(30) not null
		)
go

if exists (select 1 from sys.indexes where name = 'IDX_ENT')
begin	
   drop index IDX_ENT on cl_frm_ente_respuesta
end
	create index IDX_ENT            ON cl_frm_ente_respuesta(en_ente)
go

if exists (select 1 from sys.indexes where name = 'IDX_ENT_RESPUESTA')
begin	
   drop index IDX_ENT_RESPUESTA on cl_frm_ente_respuesta
end
	create index IDX_ENT_RESPUESTA  ON cl_frm_ente_respuesta(en_respuesta_ente)
go

if exists (select 1 from sys.indexes where name = 'IDX_ENT_FORMULARIO')
begin	
   drop index IDX_ENT_FORMULARIO on cl_frm_ente_respuesta
end
	create index IDX_ENT_FORMULARIO ON cl_frm_ente_respuesta(en_formulario)
go

if exists (select 1 from sys.indexes where name = 'IDX_ENT_VERSION')
begin	
   drop index IDX_ENT_VERSION on cl_frm_ente_respuesta
end
	create index IDX_ENT_VERSION    ON cl_frm_ente_respuesta(en_version)
go

if exists (select 1 from sys.indexes where name = 'IDX_ENTE_PREGUNTA')
begin	
   drop index IDX_ENTE_PREGUNTA on cl_frm_ente_respuesta
end
	create index IDX_ENTE_PREGUNTA  ON cl_frm_ente_respuesta(en_pregunta_form)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_ENTE_RESPUESTA_1')
begin	
   drop index IDX_FRM_ENTE_RESPUESTA_1 on cl_frm_ente_respuesta
end
	create nonclustered index IDX_FRM_ENTE_RESPUESTA_1 on cl_frm_ente_respuesta(en_ente,en_respuesta_ente,en_formulario,en_version)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_ENTE_RESPUESTA_2')
begin	
   drop index IDX_FRM_ENTE_RESPUESTA_2 on cl_frm_ente_respuesta
end
	create nonclustered index IDX_FRM_ENTE_RESPUESTA_2 on cl_frm_ente_respuesta(en_ente,en_respuesta_ente,en_formulario,en_version,en_pregunta_form)
go

if exists (select 1 from sys.indexes where name = 'IDX_FRM_ENTE_RESPUESTA_3')
begin	
   drop index IDX_FRM_ENTE_RESPUESTA_3 on cl_frm_ente_respuesta
end
	create nonclustered index IDX_FRM_ENTE_RESPUESTA_3 on cl_frm_ente_respuesta(en_ente,en_formulario,en_version, en_pregunta_form)
go

--- ==========================	cl_frm_ente_resp_tabla

if object_id('cl_frm_ente_resp_tabla') is not null 
	drop table cobis..cl_frm_ente_resp_tabla
go
	create table cobis..cl_frm_ente_resp_tabla
		(
			rt_ente      int not null,
         rt_fila        tinyint not null,
			rt_respuesta varchar(254) null,
         rt_formulario int not null,
         rt_version int not null,	
         rt_pregunta_form int not null,
         rt_id_columna int null
		)
go

if exists (select 1 from sys.indexes where name = 'IDX_ENTE_RESP_ENTE')
begin	
   drop index IDX_ENTE_RESP_ENTE on cl_frm_ente_resp_tabla
end
	create index IDX_ENTE_RESP_ENTE ON cl_frm_ente_resp_tabla(rt_ente)
go

--- ==========================	cl_neg_cliente_prev
if object_id('cl_neg_cliente_prev') is not null 
	drop table cobis..cl_neg_cliente_prev
go
	create table cobis..cl_neg_cliente_prev
		(
			nc_negocio       	   int not null,
			nc_ente          	   int not null,
			nc_direccion     	   int not null,
			nc_fecha_investigacion datetime not null,
			nc_ingreso       	   money not null,
			nc_gasto               money not null,
			nc_utilidad            money not null,
			nc_calificacion  	   smallint not null,
			nc_estado        	   varchar(60)not null,
			nc_cap_pago      	   money not null,
			nc_formulario    	   int not null,
			nc_version       	   int not null,
			nc_inst_proc     	   int null,
			nc_investigador  	   varchar(60) not null,
			nc_verificador   	   varchar(60) null,
			CONSTRAINT AK_NEGOCIO_PREV UNIQUE (nc_negocio)
		)

go
	
if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_PREV')
begin	
   drop index IDX_NEGOCIO_PREV on cl_neg_cliente_prev
end
	create index IDX_NEGOCIO_PREV ON cl_neg_cliente_prev(nc_negocio)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_ENTE_PREV')
begin	
   drop index IDX_NEGOCIO_ENTE_PREV on cl_neg_cliente_prev
end
	create index IDX_NEGOCIO_ENTE_PREV ON cl_neg_cliente_prev(nc_ente)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_DIRE_PREV')
begin	
   drop index IDX_NEGOCIO_DIRE_PREV on cl_neg_cliente_prev
end
	create index IDX_NEGOCIO_DIRE_PREV ON cl_neg_cliente_prev(nc_direccion)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_FORM_PREV')
begin	
   drop index IDX_NEGOCIO_FORM_PREV on cl_neg_cliente_prev
end
	create index IDX_NEGOCIO_FORM_PREV ON cl_neg_cliente_prev(nc_formulario)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_VERS_PREV')
begin	
   drop index IDX_NEGOCIO_VERS_PREV on cl_neg_cliente_prev
end
	create index IDX_NEGOCIO_VERS_PREV ON cl_neg_cliente_prev(nc_version)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_INST_PREV')
begin	
   drop index IDX_NEGOCIO_INST_PREV on cl_neg_cliente_prev
end
	create index IDX_NEGOCIO_INST_PREV ON cl_neg_cliente_prev(nc_inst_proc)
go

--- ==========================	cl_neg_cliente_his

if object_id('cl_neg_cliente_his') is not null 
	drop table cobis..cl_neg_cliente_his
go
	create table cobis..cl_neg_cliente_his
		(
			nc_negocio       	   int not null,
			nc_ente          	   int not null,
			nc_direccion     	   int not null,
			nc_fecha_investigacion datetime not null,
			nc_ingreso       	   money not null,
			nc_gasto               money not null,
			nc_utilidad            money not null,
			nc_calificacion  	   smallint not null,
			nc_estado        	   varchar(60)not null,
			nc_cap_pago      	   money not null,
			nc_formulario    	   int not null,
			nc_version       	   int not null,
			nc_inst_proc     	   int null,
			nc_investigador  	   varchar(60) not null,
			nc_verificador   	   varchar(60) null,
			nc_fecha_historico	   datetime not null
			CONSTRAINT AK_NEGOCIO_HIS UNIQUE (nc_negocio)
		)

go
	
if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_HIS')
begin	
   drop index IDX_NEGOCIO_HIS on cl_neg_cliente_his
end
	create index IDX_NEGOCIO_HIS ON cl_neg_cliente_his(nc_negocio)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_ENTE_HIS')
begin	
   drop index IDX_NEGOCIO_ENTE_HIS on cl_neg_cliente_his
end
	create index IDX_NEGOCIO_ENTE_HIS ON cl_neg_cliente_his(nc_ente)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_DIRE_HIS')
begin	
   drop index IDX_NEGOCIO_DIRE_HIS on cl_neg_cliente_his
end
	create index IDX_NEGOCIO_DIRE_HIS ON cl_neg_cliente_his(nc_direccion)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_FORM_HIS')
begin	
   drop index IDX_NEGOCIO_FORM_HIS on cl_neg_cliente_his
end
	create index IDX_NEGOCIO_FORM_HIS ON cl_neg_cliente_his(nc_formulario)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_VERS_HIS')
begin	
   drop index IDX_NEGOCIO_VERS_HIS on cl_neg_cliente_his
end
	create index IDX_NEGOCIO_VERS_HIS ON cl_neg_cliente_his(nc_version)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_INST_HIS')
begin	
   drop index IDX_NEGOCIO_INST_HIS on cl_neg_cliente_his
end
	create index IDX_NEGOCIO_INST_HIS ON cl_neg_cliente_his(nc_inst_proc)
go

--- ==========================	cl_neg_cliente

if object_id('cl_neg_cliente') is not null 
	drop table cobis..cl_neg_cliente
go
	create table cobis..cl_neg_cliente
		(
			nc_negocio       	   int not null,
			nc_ente          	   int not null,
			nc_direccion     	   int not null,
			nc_fecha_investigacion datetime not null,
			nc_ingreso       	   money not null,
			nc_gasto               money not null,
			nc_utilidad            money not null,
			nc_calificacion  	   smallint not null,
			nc_estado        	   varchar(60)not null,
			nc_cap_pago      	   money not null,
			nc_formulario    	   int not null,
			nc_version       	   int not null,
			nc_inst_proc     	   int null,
			nc_investigador  	   varchar(60) not null,
			nc_verificador   	   varchar(60) null,
			CONSTRAINT AK_NEGOCIO UNIQUE (nc_negocio)
		)

go
	
if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO')
begin	
   drop index IDX_NEGOCIO on cl_neg_cliente
end
	create index IDX_NEGOCIO ON cl_neg_cliente(nc_negocio)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_ENTE')
begin	
   drop index IDX_NEGOCIO_ENTE on cl_neg_cliente
end
	create index IDX_NEGOCIO_ENTE ON cl_neg_cliente(nc_ente)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_DIRE')
begin	
   drop index IDX_NEGOCIO_DIRE on cl_neg_cliente
end
	create index IDX_NEGOCIO_DIRE ON cl_neg_cliente(nc_direccion)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_FORM')
begin	
   drop index IDX_NEGOCIO_FORM on cl_neg_cliente
end
	create index IDX_NEGOCIO_FORM ON cl_neg_cliente(nc_formulario)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_VERS')
begin	
   drop index IDX_NEGOCIO_VERS on cl_neg_cliente
end
	create index IDX_NEGOCIO_VERS ON cl_neg_cliente(nc_version)
go

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_INST')
begin	
   drop index IDX_NEGOCIO_INST on cl_neg_cliente
end
	create index IDX_NEGOCIO_INST ON cl_neg_cliente(nc_inst_proc)
go

--- ==========================	cl_frm_catalogo_pregunta

if object_id('cl_frm_catalogo_pregunta') is not null 
	drop table cobis..cl_frm_catalogo_pregunta
go
	create table cobis..cl_frm_catalogo_pregunta
		(
			cp_id_cat_resp      int not null,
			cp_id_form          int not null,
			cp_id_pregunta	    int not null,
			cp_catalogo			int not null,
			cp_codigo			varchar(64)not null,
			cp_valor			varchar(80)not null,
			cp_puntos			int	
		)

go
	
if exists (select 1 from sys.indexes where name = 'IDX_CATALOGO_PREGUNTA')
begin	
   drop index IDX_CATALOGO_PREGUNTA on cl_frm_catalogo_pregunta
end
	create index IDX_CATALOGO_PREGUNTA ON cl_frm_catalogo_pregunta(cp_id_cat_resp)
go
if exists (select 1 from sys.indexes where name = 'IDX_CATALOGO_PREGUNTA_1')
begin	
   drop index IDX_CATALOGO_PREGUNTA_1 on cl_frm_catalogo_pregunta
end
	create index IDX_CATALOGO_PREGUNTA_1 ON cl_frm_catalogo_pregunta(cp_id_form,cp_id_pregunta)
go

if exists (select 1 from sys.indexes where name = 'IDX_CATALOGO_PREGUNTA_2')
begin	
   drop index IDX_CATALOGO_PREGUNTA_2 on cl_frm_catalogo_pregunta
end
create nonclustered index IDX_CATALOGO_PREGUNTA_2 on cl_frm_catalogo_pregunta(cp_id_cat_resp, cp_id_form, cp_id_pregunta)
go   

--- ==========================	cl_frm_ente_respuesta_tmp

if object_id('cl_frm_ente_respuesta_tmp') is not null 
	drop table cobis..cl_frm_ente_respuesta_tmp
go
		
	create table cl_frm_ente_respuesta_tmp
	(
		en_ente 			int not null,
		en_respuesta_ente 	int not null,
		en_formulario 		int not null,
		en_version 			int not null,
		en_pregunta_form 	int not null,
		en_respuesta 		varchar(255) null,
		en_fecha_registro 	datetime not null,
		en_usuario 			varchar(30) not null
	)

go

if exists (select 1 from sys.indexes where name = 'TMP_ENT')
begin	
   drop index TMP_ENT on cl_frm_ente_respuesta_tmp
end
	create index TMP_ENT            ON cl_frm_ente_respuesta_tmp(en_ente)
go

if exists (select 1 from sys.indexes where name = 'TMP_ENT_RESPUESTA')
begin	
   drop index TMP_ENT_RESPUESTA on cl_frm_ente_respuesta_tmp
end
	create index TMP_ENT_RESPUESTA  ON cl_frm_ente_respuesta_tmp(en_respuesta_ente)
go

if exists (select 1 from sys.indexes where name = 'TMP_ENT_FORMULARIO')
begin	
   drop index TMP_ENT_FORMULARIO on cl_frm_ente_respuesta_tmp
end
	create index TMP_ENT_FORMULARIO ON cl_frm_ente_respuesta_tmp(en_formulario)
go

if exists (select 1 from sys.indexes where name = 'TMP_ENT_VERSION')
begin	
   drop index TMP_ENT_VERSION on cl_frm_ente_respuesta_tmp
end
	create index TMP_ENT_VERSION    ON cl_frm_ente_respuesta_tmp(en_version)
go

if exists (select 1 from sys.indexes where name = 'TMP_ENTE_PREGUNTA')
begin	
   drop index TMP_ENTE_PREGUNTA on cl_frm_ente_respuesta_tmp
end
	create index TMP_ENTE_PREGUNTA  ON cl_frm_ente_respuesta_tmp(en_pregunta_form)
go

--- ==========================	cl_frm_ente_resp_tabla_tmp

if object_id('cl_frm_ente_resp_tabla_tmp') is not null 
	drop table cobis..cl_frm_ente_resp_tabla_tmp
go
	
	create table cl_frm_ente_resp_tabla_tmp
	(	
		rt_ente 			int not null,
		rt_fila 			tinyint not null,
		rt_respuesta 		varchar(254) null,
		rt_formulario		int not null,
		rt_version 			int not null,	
		rt_pregunta_form 	int not null,
		rt_id_columna 		int null
	)

if exists (select 1 from sys.indexes where name = 'TMP_TB_ENTE')
begin	
   drop index TMP_TB_ENTE   on cl_frm_ente_resp_tabla_tmp
end
	create index TMP_TB_ENTE  ON cl_frm_ente_resp_tabla_tmp(rt_ente)
go

if exists (select 1 from sys.indexes where name = 'TMP_TB_FILA')
begin	
   drop index TMP_TB_FILA on cl_frm_ente_resp_tabla_tmp
end
	create index TMP_TB_FILA  ON cl_frm_ente_resp_tabla_tmp(rt_fila)
go

if exists (select 1 from sys.indexes where name = 'TMP_TB_FORM')
begin	
   drop index TMP_TB_FORM on cl_frm_ente_resp_tabla_tmp
end
	create index TMP_TB_FORM  ON cl_frm_ente_resp_tabla_tmp(rt_formulario)
go

if exists (select 1 from sys.indexes where name = 'TMP_TB_VERSION')
begin	
   drop index TMP_TB_VERSION on cl_frm_ente_resp_tabla_tmp
end
	create index TMP_TB_VERSION  ON cl_frm_ente_resp_tabla_tmp(rt_version)
go

if exists (select 1 from sys.indexes where name = 'TMP_TB_PREGUNTA')
begin	
   drop index TMP_TB_PREGUNTA on cl_frm_ente_resp_tabla_tmp
end
	create index TMP_TB_PREGUNTA  ON cl_frm_ente_resp_tabla_tmp(rt_pregunta_form)
go
--- ==========================	cl_frm_seccion_ctrl
if exists (select 1 from sys.indexes where name = 'cl_frm_seccion_ctrl_idx1')
begin	
   drop index cl_frm_seccion_ctrl_idx1   on cl_frm_seccion_ctrl
end
if exists (select 1 from sys.indexes where name = 'cl_frm_seccion_ctrl_idx2')
begin	
   drop index cl_frm_seccion_ctrl_idx2   on cl_frm_seccion_ctrl
end

if object_id('cl_frm_seccion_ctrl') is not null 
	drop table cobis..cl_frm_seccion_ctrl
go
		
	create table cl_frm_seccion_ctrl
	(
		sc_id	 			int not null,
		sc_frm_id		 	int not null,
		sc_seccion	 		int not null,
		sc_etapa 			varchar(64) null,
		sc_visible			char(1),
		sc_habilitado		char(1)
	)
	

	create index cl_frm_seccion_ctrl_idx1  ON cl_frm_seccion_ctrl(sc_frm_id)
go

	create index cl_frm_seccion_ctrl_idx2  ON cl_frm_seccion_ctrl(sc_frm_id,sc_seccion)
go


-----------------------------------
----   BIOMETRICOS-----------------
-----------------------------------
use cobis
go

-----------------------------------------------------
--------------- cl_ente_bio   -----------------------
-----------------------------------------------------

IF OBJECT_ID ('dbo.cl_ente_bio') IS NOT NULL
	DROP TABLE dbo.cl_ente_bio
GO


CREATE TABLE cl_ente_bio  ( 
   eb_secuencial         	int NOT NULL,
   eb_ente               	int NOT NULL,
   eb_tipo_identificacion	varchar(10) NULL,
   eb_cic                	varchar(9) NULL,
   eb_ocr                	varchar(13) NULL,
   eb_nro_emision        	varchar(2) NULL,
   eb_clave_elector      	varchar(18) NULL,
   eb_sin_huella_dactilar	char(1) NULL,
   eb_fecha_registro     	datetime NOT NULL,
   eb_fecha_vencimiento  	datetime NULL,
   eb_anio_registro      	varchar(5) NULL,
   eb_anio_emision       	varchar(5) NULL,
	CONSTRAINT cl_ente_bio_pk PRIMARY KEY CLUSTERED(eb_secuencial)
)
GO
ALTER TABLE dbo.cl_ente_bio
	ADD CONSTRAINT UQ_eb_ente
	UNIQUE (eb_ente)
GO

if exists (select 1 from sys.indexes where name = 'IDX_eb_ente')
begin	
   drop index IDX_eb_ente on cl_ente_bio
end

create index IDX_eb_ente ON cl_ente_bio(eb_ente)
go

-----------------------------------------------------
--------------- cl_ente_bio_his ---------------------
-----------------------------------------------------

IF OBJECT_ID ('dbo.cl_ente_bio_his') IS NOT NULL
	DROP TABLE dbo.cl_ente_bio_his
GO


CREATE TABLE dbo.cl_ente_bio_his  ( 
	ebh_ssn                	int NOT NULL,
	ebh_ente               	int NULL,
	ebh_tipo_identificacion	varchar(10) NULL,
	ebh_cic                	varchar(9) NULL,
	ebh_ocr                	varchar(13) NULL,
	ebh_nro_emision        	varchar(2) NULL,
	ebh_clave_elector      	varchar(18) NULL,
	ebh_sin_huella_dactilar	char(1) NULL,
	ebh_fecha_registro     	datetime NOT NULL,
	ebh_fecha_vencimiento  	datetime NULL,
	ebh_anio_registro      	varchar(5) NULL,
	ebh_anio_emision       	varchar(5) NULL,
	ebh_fecha_modificacion 	datetime NULL,
	ebh_transaccion        	char(1) NOT NULL,
	ebh_usuario            	varchar(20) NOT NULL,
	ebh_terminal           	varchar(20) NOT NULL,
	ebh_srv                	varchar(10) NULL,
	ebh_lsrv               	varchar(10) NULL 
	)
GO

if exists (select 1 from sys.indexes where name = 'IDX_ebh_ente')
begin	
   drop index IDX_ebh_ente on cl_ente_bio_his
end

create index IDX_ebh_ente ON cl_ente_bio_his(ebh_ente)
go

use cobis 
go


IF OBJECT_ID ('dbo.cl_respuesta_bio') IS NOT NULL
	DROP TABLE dbo.cl_respuesta_bio
GO
		CREATE TABLE cobis..cl_respuesta_bio
		(
			rb_secuencia int not null,
			rb_ente int not null,
			rb_fecha_registro datetime not null,
			rb_tipo_situacion_registral varchar(20),
			rb_tipo_reporte_robo_extravio varchar(20) ,
			rb_ano_registro varchar(10),
			rb_clave_elector varchar(10),
			rb_apellido_paterno varchar(10),
			rb_ano_emision varchar(10),
			rb_numero_emision_credencial varchar(10),
			rb_nombre varchar(10),
			rb_apellido_materno varchar(10),
			rb_indice_izquierdo int,
			rb_indice_derecho int,
			rb_hash	varchar(255) null,
			rb_sequential	varchar(50),
			rb_inst_proc	int not null,
			rb_resultado	varchar(20),
			rb_valida_huella char(1) null,
			rb_aprobado_por_monto char(1) null,	
			rb_aprobado_por_doc char(1) null
		)
go

if exists (select 1 from sys.indexes where name = 'IDX_RESPUESTA_BIO_SECUENCIA')
begin	
   drop index IDX_RESPUESTA_BIO_SECUENCIA on cl_respuesta_bio
end
	create unique index IDX_RESPUESTA_BIO_SECUENCIA ON cl_respuesta_bio(rb_secuencia)
go

if exists (select 1 from sys.indexes where name = 'IDX_RESPUESTA_BIO_ENTE')
begin	
   drop index IDX_RESPUESTA_BIO_ENTE on cl_respuesta_bio
end
	create index IDX_RESPUESTA_BIO_ENTE ON cl_respuesta_bio(rb_ente)
go

if exists (select 1 from sys.indexes where name = 'IDX_RESPUESTA_BIO_INST_PROC')
begin	
   drop index IDX_RESPUESTA_BIO_INST_PROC on cl_respuesta_bio
end
	create index IDX_RESPUESTA_BIO_INST_PROC ON cl_respuesta_bio(rb_inst_proc)
go

DELETE FROM cobis..cl_seqnos WHERE tabla ='cl_respuesta_bio' AND bdatos = 'cobis';
INSERT INTO cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) VALUES ('cobis','cl_respuesta_bio',1,'co_secuencia');
go

--149335. LOG DE TRANSACCIONES PARTE 2

use cobis
go

if object_id ('dbo.cl_temp_tran_servicio') is not null
	drop table dbo.cl_temp_tran_servicio
go


create table dbo.cl_temp_tran_servicio (
	tts_secuencial            varchar (75)  null,
	tts_cliente               varchar (75)  null,
	tts_buc                   varchar (75)  null,
	tts_fecha                 varchar (15)  null,
	tts_hora                  varchar (15)  null,
	tts_tipo_transaccion      varchar (75)  null,
	tts_usuario               varchar (75)  null,
	tts_campo_modificado      varchar (255) null,
	tts_canal                 varchar (75)   null
)

go

/****************************************************/
-- CREACION TABLA FORMULARIO KYC - AUTO-ONBOARDING --
/****************************************************/
use cobis
go

if object_id ('dbo.cl_auto_onboard_form_kyc') is not null
	drop table dbo.cl_auto_onboard_form_kyc
go

create table cl_auto_onboard_form_kyc(
  ko_ente                     int           not null,
  ko_act_eco_generica         varchar (10)  null,
  ko_firma_electronica        char (1)      null,
  ko_funciones_publicas       char (1)      null,
  ko_serv_transf_inter        char (1)      null,
  ko_transac_divisas          char (1)      null,
  ko_tran_nac_env_num         varchar (30)  null,
  ko_tran_nac_env_monto       varchar (30)  null,
  ko_tran_nac_rec_num         varchar (30)  null,
  ko_tran_nac_rec_monto       varchar (30)  null,
  ko_depo_efectivo_num        varchar (30)  null,
  ko_depo_efectivo_monto      varchar (30)  null,
  ko_depo_no_efectivo_num     varchar (30)  null,
  ko_depo_no_efectivo_monto   varchar (30)  null,
  ko_aceptar                  char (1)      null,
  ko_fecha_proceso            datetime      not null,
  ko_fecha_real               datetime      not null
)
go

if exists (select name from sysindexes where name='iko_ente')
    drop index cl_auto_onboard_form_kyc.iko_ente    
go
    create nonclustered index iko_ente on cl_auto_onboard_form_kyc (ko_ente)
go

use cobis
go
if (OBJECT_ID('cl_onboard_id_ext')) IS NOT NULL
    drop table cl_onboard_id_ext
create table cl_onboard_id_ext(
    oi_ente           INT NOT NULL,
    oi_id_expediente  varchar(24) null,
    oi_fecha_registro DATETIME null
)
create index idx_ente on cl_onboard_id_ext (oi_ente)
go

--172199 CONCILIADOR CONTABLE

if exists(select 1 from sysobjects
           where name = 'cl_principal_notificador')
   drop table cl_principal_notificador
go


create table cl_principal_notificador
(
	pn_nemonico 			varchar(15),
	pn_work_folder 			varchar(255),
	pn_source_folder 		varchar(255),
	pn_username 			varchar(50),
	pn_password 			varchar(50),
	pn_host 				varchar(25),
	pn_port 				int,
	pn_timeout 				int,
	pn_key_path 			varchar(255),
	pn_authentication_type 	int,
	pn_type 				varchar(15)
)
go

if exists(select 1 from sysobjects
           where name = 'cl_detalle_notificador')
   drop table cl_detalle_notificador
go


create table cl_detalle_notificador
(
	dn_nemonico 					varchar(15),
	dn_report_name	 				varchar(50),
	dn_work_folder 					varchar(255),
	dn_source_folder 				varchar(255),
	dn_destination_folder 			varchar(255),
	dn_upload_path 					varchar(255),
	dn_file_name_upload 			varchar(50),
	dn_remote_upload_path 			varchar(255),
	dn_retry_upload 				varchar(50),
	dn_to_upload_extract 			varchar(50),
	dn_download_path 				varchar(255),
	dn_download_file_pattern 		varchar(50),
	dn_remote_download_path 		varchar(255),
	dn_remote_download_history_path varchar(255),
	dn_retry_download 				varchar(50),
	dn_to_download_extract 			varchar(50)
)
go

if exists(select 1 from sysobjects
           where name = 'cl_log_notificador')
   drop table cl_log_notificador
go

create table cl_log_notificador
(
	ln_nemonico 					varchar(15),
	ln_report_name	 				varchar(50),
	ln_generation_date	 			DATETIME,
	ln_gen_process_date				DATETIME,
	ln_upload_date 					DATETIME,
	ln_copy_date 					DATETIME,
	ln_report_pattern				varchar(50),
	ln_status						varchar(10)
)
go


-- ========= REQ 153833 - Cambios Json biometricos =========
IF OBJECT_ID ('ca_log_error_biometricos') IS NOT NULL
    DROP TABLE ca_log_error_biometricos
go

CREATE TABLE ca_log_error_biometricos (
	eb_fecha_proceso datetime NULL,
	eb_usuario login NULL,
	eb_error_descripcion varchar(255) NULL,
	eb_error_code varchar(64) NULL,
	eb_cliente int NULL,
	eb_tramite int NULL
)
go
create index idx_ca_log_error_biometricos_1
	on dbo.ca_log_error_biometricos (eb_fecha_proceso, eb_cliente)
GO
create index idx_ca_log_error_biometricos_2
	on dbo.ca_log_error_biometricos (eb_fecha_proceso, eb_usuario)
go


-- ========= REQ 196073 -  Envio de documentos digitales =========
--Tabla de Canales
use cobis
go

if object_id ('dbo.cl_canal') is not null
  drop table dbo.cl_canal
go

create table cl_canal(
  ca_nombre      varchar(256),
  ca_canal       int,        
  ca_estado      char(1),
  ca_fecha_crea  datetime
)
go

insert into cl_canal (ca_nombre, ca_canal, ca_estado, ca_fecha_crea) values ('b2c_digital', 3,  'V', getdate())
insert into cl_canal (ca_nombre, ca_canal, ca_estado, ca_fecha_crea) values ('b2b',         20, 'V', getdate())
insert into cl_canal (ca_nombre, ca_canal, ca_estado, ca_fecha_crea) values ('b2c',         8,  'V', getdate())
insert into cl_canal (ca_nombre, ca_canal, ca_estado, ca_fecha_crea) values ('web',         4,  'V', getdate())

go


-- ========= REQ 193221- B2B Grupal Digital =========
--Tabla de Registro de Verificacion Correo y Telefono
use cobis
go

if object_id ('dbo.cl_verif_co_tel') is not null
  drop table dbo.cl_verif_co_tel
go

create table cl_verif_co_tel(
  ct_ente          int, 
  ct_direccion     int,
  ct_valor         varchar(254), 
  ct_tipo          varchar(10),
  ct_verificacion  char(1),
  ct_canal         int,        
  ct_fecha_proc    datetime,
  ct_fecha         datetime
)
go


--Tabla Log de Aceptacion
use cobis
go

if object_id ('dbo.cl_log_aceptacion') is not null
  drop table dbo.cl_log_aceptacion
go

create table cl_log_aceptacion(
  ta_fecha_registro     datetime,
  ta_tipo_aceptacion    varchar(10),
  ta_resultado          char(1), 
  ta_fecha_aceptacion   datetime,
  ta_canal              int,
  ta_ente               int, 
  ta_login_asesor       varchar(14),
  ta_oficina_asesor     int
)
go


-- ============== Req. 205892 - OT Reporte Riesgo individual nva evaluacion ==============
IF OBJECT_ID ('rte_eval_grp_en017') IS NOT NULL
	DROP TABLE rte_eval_grp_en017
GO
print '=====> rte_eval_grp_en017'
create table rte_eval_grp_en017(
	eg_bc_secuencial				int			, -- 1 a 10,000,000
	eg_folio_solicitud              varchar(64)	, -- 1 a 10,000,000
	eg_fecha_solicitud              datetime	, -- 01/01/2000 en adelante
	eg_bc_fecha_solicitud_num       varchar(6),	  -- 202001 en adelante
	eg_bc_fecha_solicitud_semana    varchar(6),	  -- 202001 en adelante
	eg_sucursal                     varchar(64)	, -- Catálogo Sucursales
	eg_cc                           int	,	      -- 1 al 1,000,000
	eg_regional                     varchar(64) , -- Catálogo Regionales
	eg_clave_asesor                 int	,	      -- 1 al 1,000,000
	eg_clave_gerente                int	,	      -- 1 al 1,000,000
	eg_clave_cordinador             int	,	      -- 1 al 1,000,000
	eg_ciclo_cliente                smallint,	  -- 1 a 1000
	eg_monto_solicitado             money	,	  -- 1000 a 200,000
	eg_plazo_solicitado             smallint,	  -- 1 a 350
	eg_periodicidad_solicitada      varchar(64)	, -- S,Q,M
	eg_bc_score                     int	,	      -- <ValorScore>
	eg_clave_score                  varchar(3)	, -- 17
	eg_bc_score_nombre              varchar(50)	, -- <nombreScore>
	eg_bc_score_codrazon            varchar(4),	  -- <CodigoRazon>
	eg_id_cliente_cobis             int	,	      -- 1 a 10,000,000
	eg_producto_prestamos           varchar(10),  -- Grupal, Individual, Revolvente
	eg_subprod_prestamo             char(1)	,	  -- Individual, Promo, Tradicional
	eg_bc_tiene_cuentas             smallint,	  -- 0,1
	eg_bc_saldo_vencido             money,	-- Positivos
	eg_bc_max_morosidad_hist        varchar(5),	-- En orden de menor a mayor: ' ', D,U,-,0,1,2,3,4,5,6,7,9
	eg_bc_clave_observacion         smallint,	-- Anexo 6, Manual Técnico BC xml
	eg_nivel_riesgo                 char(1)	,	-- A,B,C,D, E, F
	eg_nivel_riesgo_score           char(2),	-- MB: Muy Bajo | B: Bajo | M: Medio | A: Alto | MA: Muy Alto
	eg_semaforo                     varchar(15),	-- Amarillo, Rojo o Verde
	eg_estatus_aprobacion           smallint,		-- -1,0,1
	-- -----------------------------------
	eg_fecha_reg					datetime,
	eg_login					    varchar(30)
)                                                       
go

print '=====> rte_eval_grp_en017_Key'
go

CREATE CLUSTERED INDEX rte_eval_grp_en017_Key ON rte_eval_grp_en017 (eg_login,eg_fecha_reg)
go


-- ------------------------------------------------------------------------
IF OBJECT_ID ('rte_eval_grp_en017_hist') IS NOT NULL
	DROP TABLE rte_eval_grp_en017_hist
GO
print '=====> rte_eval_grp_en017_hist'
create table rte_eval_grp_en017_hist(
	eh_bc_secuencial				int			,
	eh_folio_solicitud              varchar(64)	,
	eh_fecha_solicitud              datetime	,
	eh_bc_fecha_solicitud_num       varchar(6),	 
	eh_bc_fecha_solicitud_semana    varchar(6),	 
	eh_sucursal                     varchar(64)	,
	eh_cc                           int	,	     
	eh_regional                     varchar(64) ,
	eh_clave_asesor                 int	,	     
	eh_clave_gerente                int	,	     
	eh_clave_cordinador             int	,	     
	eh_ciclo_cliente                smallint,	 
	eh_monto_solicitado             money	,	 
	eh_plazo_solicitado             smallint,	 
	eh_periodicidad_solicitada      varchar(64)		,
	eh_bc_score                     int	,	     
	eh_clave_score                  varchar(3)	,
	eh_bc_score_nombre              varchar(50)	,
	eh_bc_score_codrazon            varchar(4),	 
	eh_id_cliente_cobis             int	,	     
	eh_producto_prestamos           varchar(10), 
	eh_subprod_prestamo             char(1)	,	 
	eh_bc_tiene_cuentas             smallint,	 
	eh_bc_saldo_vencido             money,
	eh_bc_max_morosidad_hist        varchar(5),
	eh_bc_clave_observacion         smallint,
	eh_nivel_riesgo                 char(1)	,	
	eh_nivel_riesgo_score           char(2),	
	eh_semaforo                     varchar(15),
	eh_estatus_aprobacion           smallint,
	eh_fecha_reg					datetime,
	eh_login					    varchar(30),
	-- -----------------------------------
	eh_fecha_hist					datetime
)                                                       
go

print '=====> rte_eval_grp_en017_hist_Key'
go

CREATE CLUSTERED INDEX rte_eval_grp_en017_hist_Key ON rte_eval_grp_en017_hist (eh_fecha_hist)
go


-- ------------------------------------------------------------------------
use cobis
go

if object_id ('rte_eval_grp_en017_rpt') is not null
	drop table rte_eval_grp_en017_rpt
go

print '=====> rte_eval_grp_en017_rpt'
create table rte_eval_grp_en017_rpt(
	re_bc_secuencial				varchar(13), 
	re_folio_solicitud              varchar(64), 
	re_fecha_solicitud              varchar(15),
	re_bc_fecha_solicitud_num       varchar(22),	  
	re_bc_fecha_solicitud_semana    varchar(25),	  
	re_sucursal                     varchar(64), 
	re_cc                           varchar(8),	      
	re_regional                     varchar(64), 
	re_clave_asesor                 varchar(14),	      
	re_clave_gerente                varchar(14),	      
	re_clave_cordinador             varchar(16),	     
	re_ciclo_cliente                varchar(13),	  
	re_monto_solicitado             varchar(16),	  
	re_plazo_solicitado             varchar(16),	 
	re_periodicidad_solicitada      varchar(64), 
	re_bc_score                     varchar(8),	      
	re_clave_score                  varchar(11),
	re_bc_score_nombre              varchar(30),
	re_bc_score_codrazon            varchar(17),	  
	re_id_cliente_cobis             varchar(16),	     
	re_producto_prestamos           varchar(21),
	re_subprod_prestamo             varchar(20),	  
	re_bc_tiene_cuentas             varchar(16),
	re_bc_saldo_vencido             varchar(16),	
	re_bc_max_morosidad_hist        varchar(21),	
	re_bc_clave_observacion         varchar(20),	
	re_nivel_riesgo                 varchar(12),	
	re_nivel_riesgo_score           varchar(18),	
	re_semaforo                     varchar(10),
	re_estatus_aprobacion           varchar(18)
)                                            
go

