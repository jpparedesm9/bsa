USE cob_externos
GO

IF OBJECT_ID ('ex_dato_nomina_peoplenet') IS NOT NULL
	DROP TABLE ex_dato_nomina_peoplenet
GO
 
CREATE TABLE ex_dato_nomina_peoplenet
	(
	ID_ORGANIZATION    VARCHAR (4),
	DT_LAST_UPDATE     VARCHAR (10),
	STD_ID_HR          VARCHAR (10),
	ID_DMD             VARCHAR (30),
	ID_DMD_COMPONENT   VARCHAR (30),
	PROJ               INT,
	SCO_DT_ACCRUED     VARCHAR (10),
	SCO_ID_PAY_FREQUEN VARCHAR (3),
	ID_M4_TYPE         INT,
	SCO_VALUE          VARCHAR (20),
	SCO_ID_CURRENCY    VARCHAR (4),
	SCO_DT_EXCHANGE    VARCHAR (10),
	EX_TYPE            VARCHAR (10),
	SCO_ID_REA_CHANG   VARCHAR (3),
	ID_PRIORITY        INT,
	SCO_COMMENT        VARCHAR (254),
	ID_SECUSER         VARCHAR (30),
	ID_APPROLE         VARCHAR (30)
	)
GO

IF OBJECT_ID ('ex_dato_nomina_peoplenet_cifras') IS NOT NULL
	DROP TABLE ex_dato_nomina_peoplenet_cifras
GO

CREATE TABLE ex_dato_nomina_peoplenet_cifras
	(
	FECHA_DESCUENTO  VARCHAR (10),
	NUMERO_REGISTROS INT,
	TOTAL_DESCUENTOS MONEY
	)
GO


if object_id ('dbo.ex_dato_custodia') is not null
	drop table dbo.ex_dato_custodia
go

create table dbo.ex_dato_custodia
	(
	dc_fecha                smalldatetime not null,
	dc_aplicativo           tinyint not null,
	dc_garantia             varchar (64) null,
	dc_oficina              int null,
	dc_cliente              int null,
	dc_documento_tipo       varchar (2) null,
	dc_documento_numero     varchar (24) null,
	dc_categoria            varchar (1) null,
	dc_tipo                 varchar (14) null,
	dc_idonea               varchar (1) null,
	dc_moneda               int null,
	dc_fecha_avaluo         datetime null,
	dc_valor_avaluo         money null,
	dc_valor_actual         money null,
	dc_estado               varchar (1) null,
	dc_abierta              varchar (1) null,
	dc_num_reserva          varchar (13) null,
	dc_calidad_gar          varchar (10) null,
	dc_valor_uti_opera      money null,
	dc_gl_id                int ,
	dc_gl_tramite           int null,
	dc_gl_grupo             int null,
	dc_gl_monto_individual  money null,
	dc_gl_monto_garantia    money null,
	dc_gl_fecha_vencimiento datetime null,
	dc_gl_pag_estado        catalogo null,
	dc_gl_pag_fecha         datetime null,
	dc_gl_pag_valor         money null,
	dc_gl_dev_estado        catalogo null,
	dc_gl_dev_valor         money null,
	dc_gl_dev_fecha         datetime null
	)
go

create nonclustered index idx1
	on dbo.ex_dato_custodia (dc_fecha,dc_gl_id,dc_aplicativo)
go




if object_id ('ex_dato_garantia') is not null
	drop table ex_dato_garantia
go

create table ex_dato_garantia
(
	dg_fecha        smalldatetime   not null,
	dg_banco        varchar(24)     not null,
	dg_toperacion   varchar(10)     not null,
	dg_aplicativo   tinyint         not null,
	dg_garantia     varchar(64)     not null
)

create nonclustered index idx1
    on ex_dato_garantia(dg_fecha,dg_banco,dg_toperacion,dg_aplicativo,dg_garantia)
go


if object_id ('ex_dato_hechos_violentos') is not null
	drop table ex_dato_hechos_violentos
go

create table ex_dato_hechos_violentos
(
   dh_fecha                  smalldatetime   not null,
   dh_cliente                int             not null,
   dh_tramite                int             not null,
   dh_fecha_radicacion       smalldatetime   not null,
   dh_toperacion             varchar(10)     not null,
   dh_rechazado              char(1)         not null,
   dh_causa_rechazo          varchar(255)    null,
   dh_evento                 varchar(10)     not null,
   dh_fecha_evento           smalldatetime   not null,
   dh_ciudad_evento          varchar(164)    not null,
   dh_municipio_evento       varchar(164)    not null,
   dh_corregimiento_evento   varchar(164)    not null,
   dh_inspeccion             varchar(164)    not null,
   dh_vereda                 varchar(164)    not null,
   dh_sitio                  varchar(164)    not null,
   dh_destino                catalogo        null
)
go


if object_id ('ex_datos_tarifas') is not null
	drop table ex_datos_tarifas
go

create table ex_datos_tarifas
(
   dt_fecha          datetime      not null,
   dt_aplicativo     tinyint       not null,
   dt_nemonico       varchar(10)   not null,
   dt_campo1         varchar(10)   null,
   dt_campo2         varchar(10)   null,
   dt_campo3         varchar(10)   null,
   dt_campo4         varchar(10)   null,
   dt_campo5         varchar(10)   null,
   dt_campo6         varchar(10)   null,
   dt_campo7         varchar(10)   null,
   dt_campo8         varchar(10)   null,
   dt_campo9         varchar(10)   null,
   dt_campo10        varchar(10)   null,
   dt_base_calculo   varchar(65)   not null,
   dt_valor          varchar(65)   null,
   dt_estado         char(1)       null
)
go


if object_id ('ex_param_tarifas') is not null
	drop table ex_param_tarifas
go

create table ex_param_tarifas
(
	pt_fecha           datetime      not null,
	pt_aplicativo      tinyint       not null,
	pt_nemonico        varchar(10)   not null,
	pt_concepto        varchar(64)   not null,
	pt_campo1          varchar(64)   null,
	pt_campo2          varchar(64)   null,
	pt_campo3          varchar(64)   null,
	pt_campo4          varchar(64)   null,
	pt_campo5          varchar(64)   null,
	pt_campo6          varchar(64)   null,
	pt_campo7          varchar(64)   null,
	pt_campo8          varchar(64)   null,
	pt_campo9          varchar(64)   null,
	pt_campo10         varchar(64)   null,
	pt_forma_calculo   varchar(10)   not null,
	pt_estado          char(1)       not null
)
go


IF OBJECT_ID ('ex_ctas_ingresadas') IS NOT NULL
	DROP TABLE ex_ctas_ingresadas
GO

CREATE TABLE [ex_ctas_ingresadas](
	[ci_fecha] [datetime] NOT NULL,
	[ci_cuenta] [varchar](24) NOT NULL,
	[ci_aplicativo] [tinyint] NOT NULL,
	[ci_cliente] [int] NOT NULL,
	[ci_cat_producto] [varchar](10) NOT NULL,
	[ci_fecha_apertura] [datetime] NOT NULL,
	[ci_oficina] [smallint] NOT NULL,
	[ci_estado] [char](1) NOT NULL
)
GO


IF OBJECT_ID ('ex_bloqueo_operaciones') IS NOT NULL
	DROP TABLE ex_bloqueo_operaciones
GO

CREATE TABLE ex_bloqueo_operaciones
	(
	bo_fecha            DATETIME NOT NULL,
	bo_banco            VARCHAR (24) COLLATE Latin1_General_BIN NOT NULL,
	bo_aplicativo       TINYINT NOT NULL,
	bo_secuencial       INT NOT NULL,
	bo_causa_bloqueo    VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	bo_fecha_bloqueo    DATETIME NOT NULL,
	bo_fecha_desbloqueo DATETIME NULL,
	bo_estado           CHAR (1) COLLATE Latin1_General_BIN NOT NULL
	)
GO
  
   
IF OBJECT_ID ('ex_dato_transaccion_det') IS NOT NULL
	DROP TABLE ex_dato_transaccion_det
GO

CREATE TABLE ex_dato_transaccion_det
	(
	dd_fecha      SMALLDATETIME NOT NULL,
	dd_secuencial INT NOT NULL,
	dd_banco      VARCHAR (24) COLLATE Latin1_General_BIN NOT NULL,
	dd_toperacion VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	dd_aplicativo TINYINT NOT NULL,
	dd_concepto   VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	dd_moneda     INT NOT NULL,
	dd_cotizacion FLOAT NOT NULL,
	dd_monto      MONEY NOT NULL,
    dd_codigo_valor cuenta NULL,
	dd_origen_efectivo char(1) NULL,
	dd_moneda     INT NOT NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON ex_dato_transaccion_det (dd_fecha,dd_aplicativo)
GO

   
IF OBJECT_ID ('ex_condonacion_aho') IS NOT NULL
	DROP TABLE ex_condonacion_aho
GO

CREATE TABLE ex_condonacion_aho
	(
	ca_ente       INT NOT NULL,
	ca_celular    VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	ca_tarjeta    VARCHAR (20) COLLATE Latin1_General_BIN NOT NULL,
	ca_cta_banco  VARCHAR (16) COLLATE Latin1_General_BIN NOT NULL,
	ca_estado_tar CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	ca_oficina    INT NOT NULL,
	ca_causa      VARCHAR (4) COLLATE Latin1_General_BIN NOT NULL,
	ca_valor      MONEY NOT NULL,
	ca_dias       INT NOT NULL,
	ca_fecha      DATETIME NOT NULL,
	ca_aplicativo TINYINT NOT NULL
	)
GO

CREATE NONCLUSTERED INDEX i_idx_ex_condonacion_aho
	ON ex_condonacion_aho (ca_cta_banco,ca_causa,ca_fecha)
GO

CREATE NONCLUSTERED INDEX i_idx_ah_condonacion_ente
	ON ex_condonacion_aho (ca_ente,ca_fecha)
GO


IF OBJECT_ID ('ex_traslado_ctas_ca_ah') IS NOT NULL
	DROP TABLE ex_traslado_ctas_ca_ah
GO

CREATE TABLE ex_traslado_ctas_ca_ah
	(
	tc_fecha_corte DATETIME NULL,
	tc_cliente     INT NULL,
	tc_oficina_ini INT NULL,
	tc_oficina_fin INT NULL,
	tc_tipo_prod   CHAR (1) COLLATE Latin1_General_BIN NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON ex_traslado_ctas_ca_ah (tc_fecha_corte,tc_cliente)
GO

   
IF OBJECT_ID ('ex_carga_archivo_ctas') IS NOT NULL
	DROP TABLE ex_carga_archivo_ctas
GO

CREATE TABLE ex_carga_archivo_ctas
	(
	ca_tipo_reg   CHAR (2) COLLATE Latin1_General_BIN NULL,
	ca_secuencia  INT NULL,
	ca_tipo_carga CHAR (1) COLLATE Latin1_General_BIN NULL,
	ca_tipo_ced   CHAR (2) COLLATE Latin1_General_BIN NULL,
	ca_ced_ruc    BIGINT NULL,
	ca_nomb_arch  VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ca_ente       INT NULL,
	ca_cta_banco  CHAR (16) COLLATE Latin1_General_BIN NULL,
	ca_tipo_prod  TINYINT NULL,
	ca_fecha_reg  DATETIME NULL,
	ca_cant_reg   INT NULL,
	ca_valor      MONEY NULL,
	ca_tipo_mov   CHAR (1) COLLATE Latin1_General_BIN NULL,
	ca_causal     CHAR (3) COLLATE Latin1_General_BIN NULL,
	ca_fecha_proc DATETIME NULL,
	ca_tipo_oper  CHAR (1) COLLATE Latin1_General_BIN NULL,
	ca_estado     CHAR (1) COLLATE Latin1_General_BIN NULL,
	ca_error      VARCHAR (250) COLLATE Latin1_General_BIN NULL
	)
GO


IF OBJECT_ID ('ex_tran_rechazos') IS NOT NULL
	DROP TABLE ex_tran_rechazos
GO

CREATE TABLE ex_tran_rechazos
	(
	tr_fecha        DATETIME NULL,
	tr_oficina      SMALLINT NULL,
	tr_cod_cliente  INT NULL,
	tr_id_cliente   VARCHAR (30) COLLATE Latin1_General_BIN NULL,
	tr_nom_cliente  VARCHAR (255) COLLATE Latin1_General_BIN NULL,
	tr_cta_banco    VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	tr_tipo_tran    INT NULL,
	tr_nom_tran     VARCHAR (64) COLLATE Latin1_General_BIN NULL,
	tr_vlr_comision MONEY NULL,
	tr_vlr_iva      MONEY NULL,
	tr_modulo       CHAR (3) COLLATE Latin1_General_BIN NULL,
	tr_causal_rech  INT NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON ex_tran_rechazos (tr_fecha,tr_cod_cliente)
GO


IF OBJECT_ID ('ex_tran_mensual') IS NOT NULL
	DROP TABLE ex_tran_mensual
GO

CREATE TABLE ex_tran_mensual
	(
	tm_ano      CHAR (4) COLLATE Latin1_General_BIN NOT NULL,
	tm_mes      CHAR (2) COLLATE Latin1_General_BIN NOT NULL,
	tm_cuenta   VARCHAR (24) COLLATE Latin1_General_BIN NOT NULL,
	tm_cod_trn  INT NOT NULL,
	tm_cantidad INT NOT NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX idx1
	ON ex_tran_mensual (tm_ano,tm_mes,tm_cuenta,tm_cod_trn)
GO

   
IF OBJECT_ID ('ex_dato_transaccion') IS NOT NULL
	DROP TABLE ex_dato_transaccion
GO

CREATE TABLE ex_dato_transaccion
	(
	dt_fecha           SMALLDATETIME NOT NULL,
	dt_secuencial      INT NOT NULL,
	dt_banco           VARCHAR (24) COLLATE Latin1_General_BIN NOT NULL,
	dt_toperacion      VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	dt_aplicativo      TINYINT NOT NULL,
	dt_fecha_trans     SMALLDATETIME NOT NULL,
	dt_tipo_trans      VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	dt_reversa         VARCHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	dt_naturaleza      VARCHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	dt_canal           VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	dt_oficina         SMALLINT NULL,
	dt_secuencial_caja INT NULL,
    dt_usuario         login NULL,
	dt_terminal        VARCHAR (20) COLLATE Latin1_General_BIN NULL,
	dt_fecha_hora      DATETIME NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON ex_dato_transaccion (dt_fecha,dt_aplicativo)
GO
      

IF OBJECT_ID ('ex_relacion_canal') IS NOT NULL
	DROP TABLE ex_relacion_canal
GO

CREATE TABLE ex_relacion_canal
	(
	rc_cuenta        CHAR (16) COLLATE Latin1_General_BIN NULL,
	rc_cliente       INT NULL,
	rc_tel_celular   VARCHAR (15) COLLATE Latin1_General_BIN NULL,
	rc_tarj_debito   VARCHAR (20) COLLATE Latin1_General_BIN NULL,
	rc_canal         VARCHAR (6) COLLATE Latin1_General_BIN NULL,
	rc_motivo        VARCHAR (50) COLLATE Latin1_General_BIN NULL,
	rc_estado        CHAR (1) COLLATE Latin1_General_BIN NULL,
	rc_fecha         DATETIME NULL,
	rc_fecha_mod     DATETIME NULL,
	rc_usuario       VARCHAR (14) COLLATE Latin1_General_BIN NULL,
	rc_subtipo       CHAR (3) COLLATE Latin1_General_BIN NULL,
	rc_tipo_operador VARCHAR (10) COLLATE Latin1_General_BIN NULL,
	rc_aplicativo    INT NULL,
	rc_fecha_proceso DATETIME NULL,
	rc_oficina       INT NULL
	)
GO

CREATE NONCLUSTERED INDEX i_idx_ex_relacion_canal
	ON ex_relacion_canal (rc_cuenta,rc_canal,rc_aplicativo,rc_fecha_proceso,rc_tel_celular,rc_tarj_debito,rc_tipo_operador,rc_estado)
GO


IF OBJECT_ID ('ex_dato_pasivas') IS NOT NULL
	DROP TABLE ex_dato_pasivas
GO

CREATE TABLE ex_dato_pasivas
	(
	dp_fecha              DATETIME NOT NULL,
	dp_banco              VARCHAR (24) COLLATE Latin1_General_BIN NOT NULL,
	dp_toperacion         VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	dp_aplicativo         TINYINT NOT NULL,
	dp_categoria_producto VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	dp_naturaleza_cliente CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	dp_cliente            INT NOT NULL,
	dp_documento_tipo     CHAR (2) COLLATE Latin1_General_BIN NULL,
	dp_documento_numero   VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	dp_oficina            SMALLINT NOT NULL,
	dp_oficial            SMALLINT NOT NULL,
	dp_moneda             TINYINT NOT NULL,
	dp_monto              MONEY NOT NULL,
	dp_tasa               FLOAT NULL,
	dp_modalidad          CHAR (1) COLLATE Latin1_General_BIN NULL,
	dp_plazo_dias         INT NULL,
	dp_fecha_apertura     DATETIME NOT NULL,
	dp_fecha_radicacion   DATETIME NOT NULL,
	dp_fecha_vencimiento  DATETIME NULL,
	dp_num_renovaciones   INT NULL,
	dp_estado             TINYINT NOT NULL,
	dp_razon_cancelacion  VARCHAR (10) COLLATE Latin1_General_BIN NULL,
	dp_num_cuotas         SMALLINT NOT NULL,
	dp_periodicidad_cuota SMALLINT NOT NULL,
	dp_saldo_disponible   MONEY NOT NULL,
	dp_saldo_int          MONEY NOT NULL,
	dp_saldo_camara12h    MONEY NOT NULL,
	dp_saldo_camara24h    MONEY NOT NULL,
	dp_saldo_camara48h    MONEY NOT NULL,
	dp_saldo_remesas      MONEY NOT NULL,
	dp_condicion_manejo   CHAR (1) COLLATE Latin1_General_BIN NULL,
	dp_exen_gmf           CHAR (1) COLLATE Latin1_General_BIN NULL,
	dp_fecha_ini_exen_gmf DATETIME NULL,
	dp_fecha_fin_exen_gmf DATETIME NULL,
	dp_tesoro_nacional    CHAR (1) COLLATE Latin1_General_BIN NULL,
	dp_ley_exen           VARCHAR (10) COLLATE Latin1_General_BIN NULL,
	dp_tasa_variable      CHAR (1) COLLATE Latin1_General_BIN NULL,
	dp_referencial_tasa   catalogo NULL,
	dp_signo_spread       CHAR (1) COLLATE Latin1_General_BIN NULL,
	dp_spread             FLOAT NULL,
	dp_signo_puntos       CHAR (1) COLLATE Latin1_General_BIN NULL,
	dp_puntos             FLOAT NULL,
	dp_signo_tasa_ref     CHAR (1) COLLATE Latin1_General_BIN NULL,
	dp_puntos_tasa_ref    FLOAT NULL,
	dp_origen             CHAR (3) NULL,
	dp_provisiona         CHAR (1) NULL,
	dp_blqpignoracion     CHAR (1) NULL
	)
GO


IF OBJECT_ID ('ex_dato_deudores') IS NOT NULL
	DROP TABLE ex_dato_deudores
GO

CREATE TABLE ex_dato_deudores(
	de_fecha       smalldatetime NOT NULL,
	de_banco       varchar(24) NOT NULL,
	de_toperacion  varchar(10) NOT NULL,
	de_aplicativo  tinyint NOT NULL,
	de_cliente     int NOT NULL,
	de_rol         char(1) NOT NULL
)

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [ex_dato_deudores]
(
	[de_banco],
	[de_cliente],
	[de_fecha],
	[de_aplicativo]
)
GO


/****** Object:  Table [ex_abonos_referidos]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_abonos_referidos') IS NOT NULL
	DROP TABLE ex_abonos_referidos
GO

CREATE TABLE [ex_abonos_referidos](
	[ar_cuenta] [varchar](24) NULL,
	[ar_tipo_id] [varchar](2) NULL,
	[ar_numero_id] [varchar](20) NULL,
	[ar_causa] [varchar](4) NULL,
	[ar_valor_ref] [money] NULL,
	[ar_fecha_ref] [datetime] NULL,
	[ar_cod_aut_ref] [varchar](20) NULL,
	[ar_estado] [varchar](20) NULL,
	[ar_cod_aut_cobis] [varchar](10) NULL,
	[ar_fecha_cobis] [datetime] NULL,
	[ar_valor_cobis] [money] NULL,
	[ar_fecha_corte] [datetime] NULL,
	[ar_referencia] [varchar](36) NULL
)

GO


IF OBJECT_ID ('ex_alianza') IS NOT NULL
	DROP TABLE ex_alianza
GO
CREATE TABLE [ex_alianza](
	[al_fecha] [datetime] NULL,
	[al_aplicativo] [smallint] NULL,
	[al_alianza] [int] NULL,
	[al_ente] [int] NULL,
	[al_nemonico] [catalogo] NULL,
	[al_nom_alianza] [varchar](255) NULL,
	[al_tipo] [catalogo] NULL,
	[al_fecha_creacion] [datetime] NULL,
	[al_fecha_fija] [char](1) NULL,
	[al_fecha_inicio] [datetime] NULL,
	[al_fecha_fin] [datetime] NULL,
	[al_estado] [char](1) NULL,
	[al_tipo_credito] [char](1) NULL,
	[al_restringue_uso] [char](1) NULL,
	[al_num_uso] [tinyint] NULL,
	[al_monto_promedio] [money] NULL,
	[al_tipo_recaudador] [char](1) NULL,
	[al_aplica_mora] [char](1) NULL,
	[al_dias_gracia] [tinyint] NULL,
	[al_tasa_mora] [catalogo] NULL,
	[al_signo_spread] [char](1) NULL,
	[al_valor_spread] [tinyint] NULL,
	[al_cuenta_bancaria] [char](16) NULL,
	[al_debito_aut] [char](1) NULL,
	[al_dispersion_fondos] [char](1) NULL,
	[al_forma_des] [catalogo] NULL,
	[al_des_cta_afi] [char](1) NULL,
	[al_gmf_banco] [char](1) NULL,
	[al_porcentaje_gmfbanco] [float] NULL,
	[al_fecha_pago] [char](1) NULL,
	[al_dia_pago] [tinyint] NULL,
	[al_exonera_estudio] [char](1) NULL,
	[al_porcentaje_exonera] [float] NULL,
	[al_mantiene_condiciones] [char](1) NULL,
	[al_observaciones] [varchar](255) NULL,
	[al_fecha_cancelacion] [datetime] NULL
)

GO


/****** Object:  Table [ex_alianza_banco]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_alianza_banco') IS NOT NULL
	DROP TABLE ex_alianza_banco
GO

CREATE TABLE [ex_alianza_banco](
	[ab_fecha] [datetime] NULL,
	[ab_aplicativo] [smallint] NULL,
	[ab_alianza] [int] NULL,
	[ab_banco] [catalogo] NULL,
	[ab_cuenta] [char](1) NULL,
	[ab_estado] [char](1) NULL
)
GO

/****** Object:  Table [ex_alianza_cliente]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_alianza_cliente') IS NOT NULL
	DROP TABLE ex_alianza_cliente
GO

CREATE TABLE [ex_alianza_cliente](
	[ac_fecha] [datetime] NULL,
	[ac_aplicativo] [smallint] NULL,
	[ac_alianza] [int] NULL,
	[ac_ente] [int] NULL,
	[ac_estado] [char](1) NULL,
	[ac_fecha_asociacion] [datetime] NULL,
	[ac_fecha_desasociacion] [datetime] NULL,
	[ac_fecha_creacion] [datetime] NULL,
	[ac_usuario_creador] [catalogo] NULL,
	[ac_usuario_modifica] [catalogo] NULL
)
GO


/****** Object:  Table [ex_alianza_linea]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_alianza_linea') IS NOT NULL
	DROP TABLE ex_alianza_linea
GO

CREATE TABLE [ex_alianza_linea](
	[al_fecha] [datetime] NULL,
	[al_aplicativo] [smallint] NULL,
	[al_alianza] [int] NULL,
	[al_linea] [catalogo] NULL
)
GO


/****** Object:  Table [ex_aseg_microseguro]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_aseg_microseguro') IS NOT NULL
	DROP TABLE ex_aseg_microseguro
GO

CREATE TABLE [ex_aseg_microseguro](
	[am_fecha] [datetime] NOT NULL,
	[am_microseg] [int] NOT NULL,
	[am_secuencial] [int] NOT NULL,
	[am_tipo_iden] [varchar](10) NOT NULL,
	[am_tipo_aseg] [varchar](10) NOT NULL,
	[am_lugar_exp] [int] NOT NULL,
	[am_identificacion] [numero] NOT NULL,
	[am_nombre_comp] [descripcion] NOT NULL,
	[am_fecha_exp] [datetime] NOT NULL,
	[am_fecha_nac] [datetime] NOT NULL,
	[am_genero] [varchar](10) NOT NULL,
	[am_lugar_nac] [int] NOT NULL,
	[am_estado_civ] [varchar](10) NOT NULL,
	[am_ocupacion] [varchar](10) NOT NULL,
	[am_parentesco] [varchar](10) NULL,
	[am_direccion] [descripcion] NOT NULL,
	[am_derecho_acrec] [char](1) NOT NULL,
	[am_plan] [int] NOT NULL,
	[am_valor_plan] [money] NOT NULL,
	[am_telefono] [numero] NOT NULL,
	[am_observaciones] [descripcion] NULL,
	[am_principal] [char](1) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_aseg_microseguro]
(
	[am_fecha],
	[am_microseg]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_aseg_microseguro]
(
	[am_microseg]
)
GO


/****** Object:  Table [ex_asegurados]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_asegurados') IS NOT NULL
	DROP TABLE ex_asegurados
GO

CREATE TABLE [ex_asegurados](
	[as_fecha] [datetime] NULL,
	[as_aplicativo] [int] NULL,
	[as_secuencial_seguro] [int] NULL,
	[as_sec_asegurado] [int] NULL,
	[as_tipo_aseg] [int] NULL,
	[as_apellidos] [varchar](255) NULL,
	[as_nombres] [varchar](255) NULL,
	[as_tipo_ced] [catalogo] NULL,
	[as_ced_ruc] [varchar](30) NULL,
	[as_lugar_exp] [int] NULL,
	[as_fecha_exp] [datetime] NULL,
	[as_ciudad_nac] [int] NULL,
	[as_fecha_nac] [datetime] NULL,
	[as_sexo] [varchar](1) NULL,
	[as_estado_civil] [catalogo] NULL,
	[as_parentesco] [catalogo] NULL,
	[as_ocupacion] [catalogo] NULL,
	[as_direccion] [varchar](255) NULL,
	[as_telefono] [varchar](16) NULL,
	[as_ciudad] [int] NULL,
	[as_correo_elec] [varchar](255) NULL,
	[as_celular] [varchar](16) NULL,
	[as_correspondencia] [varchar](255) NULL,
	[as_plan] [int] NULL,
	[as_fecha_modif] [datetime] NULL,
	[as_usuario_modif] [login] NULL,
	[as_observaciones] [varchar](255) NULL,
	[as_act_economica] [catalogo] NULL,
	[as_ente] [char](1) NULL,
	[as_fecha_ini_cobertura] [datetime] NULL,
	[as_fecha_fin_cobertura] [datetime] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE UNIQUE CLUSTERED INDEX [idx1] ON [ex_asegurados]
(
	[as_fecha],
	[as_aplicativo],
	[as_secuencial_seguro],
	[as_sec_asegurado]
)
GO


/****** Object:  Table [ex_asegurados_estadistica]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_asegurados_estadistica') IS NOT NULL
	DROP TABLE ex_asegurados_estadistica
GO

CREATE TABLE [ex_asegurados_estadistica](
	[ae_fecha] [datetime] NULL,
	[ae_certificado] [varchar](20) NULL,
	[ae_tipo_doc] [varchar](10) NULL,
	[ae_identif] [varchar](30) NULL,
	[ae_nombre] [varchar](200) NULL,
	[ae_genero] [char](1) NULL,
	[ae_fecha_nac] [datetime] NULL,
	[ae_fecha_venta] [datetime] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_asegurados_estadistica]
(
	[ae_fecha],
	[ae_certificado]
)
GO


/****** Object:  Table [ex_benefic_micro_aseg]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_benefic_micro_aseg') IS NOT NULL
	DROP TABLE ex_benefic_micro_aseg
GO

CREATE TABLE [ex_benefic_micro_aseg](
	[bm_fecha] [datetime] NOT NULL,
	[bm_microseg] [int] NOT NULL,
	[bm_asegurado] [int] NOT NULL,
	[bm_secuencial] [int] NOT NULL,
	[bm_tipo_iden] [varchar](10) NOT NULL,
	[bm_identificacion] [numero] NOT NULL,
	[bm_nombre_comp] [descripcion] NOT NULL,
	[bm_fecha_nac] [datetime] NOT NULL,
	[bm_genero] [varchar](10) NULL,
	[bm_lugar_nac] [int] NULL,
	[bm_estado_civ] [varchar](10) NULL,
	[bm_ocupacion] [varchar](10) NULL,
	[bm_parentesco] [varchar](10) NULL,
	[bm_direccion] [descripcion] NULL,
	[bm_telefono] [numero] NULL,
	[bm_porcentaje] [float] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_benefic_micro_aseg]
(
	[bm_fecha],
	[bm_microseg]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_benefic_micro_aseg]
(
	[bm_microseg]
)
GO


/****** Object:  Table [ex_beneficiarios]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_beneficiarios') IS NOT NULL
	DROP TABLE ex_beneficiarios
GO

CREATE TABLE [ex_beneficiarios](
	[be_fecha] [datetime] NULL,
	[be_aplicativo] [int] NULL,
	[be_secuencial_seguro] [int] NULL,
	[be_sec_asegurado] [int] NULL,
	[be_sec_benefic] [int] NULL,
	[be_apellidos] [varchar](255) NULL,
	[be_nombres] [varchar](255) NULL,
	[be_tipo_ced] [catalogo] NULL,
	[be_ced_ruc] [varchar](30) NULL,
	[be_lugar_exp] [int] NULL,
	[be_fecha_exp] [datetime] NULL,
	[be_ciudad_nac] [int] NULL,
	[be_fecha_nac] [datetime] NULL,
	[be_sexo] [varchar](1) NULL,
	[be_estado_civil] [catalogo] NULL,
	[be_parentesco] [catalogo] NULL,
	[be_ocupacion] [catalogo] NULL,
	[be_direccion] [varchar](255) NULL,
	[be_telefono] [varchar](16) NULL,
	[be_ciudad] [int] NULL,
	[be_correo_elec] [varchar](255) NULL,
	[be_celular] [varchar](16) NULL,
	[be_correspondencia] [varchar](255) NULL,
	[be_fecha_modif] [datetime] NULL,
	[be_usuario_modif] [login] NULL,
	[be_porcentaje] [float] NULL,
	[be_ente] [char](1) NULL
)
GO

CREATE UNIQUE CLUSTERED INDEX [idx1] ON [ex_beneficiarios]
(
	[be_fecha],
	[be_aplicativo],
	[be_secuencial_seguro],
	[be_sec_asegurado],
	[be_sec_benefic]
)
GO


/****** Object:  Table [ex_calificacion_orig]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_calificacion_orig') IS NOT NULL
	DROP TABLE ex_calificacion_orig
GO

CREATE TABLE [ex_calificacion_orig](
	[cm_fecha] [datetime] NOT NULL,
	[cm_aplicativo] [int] NOT NULL,
	[cm_tramite] [int] NOT NULL,
	[cm_fecha_resp] [datetime] NULL,
	[cm_calificacion] [char](1) NULL,
	[cm_modo_calif] [varchar](10) NULL,
	[cm_valor] [float] NULL,
	[cm_usuario] [login] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_calificacion_orig]
(
	[cm_fecha],
	[cm_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_calificacion_orig]
(
	[cm_tramite]
)
GO


/****** Object:  Table [ex_cartera_trasladada_canc]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_cartera_trasladada_canc') IS NOT NULL
	DROP TABLE ex_cartera_trasladada_canc
GO

CREATE TABLE [ex_cartera_trasladada_canc](
	[et_fecha] [smalldatetime] NOT NULL,
	[et_aplicativo] [int] NOT NULL,
	[et_nro_tramite] [int] NULL,
	[et_cod_operacion] [varchar](30) NULL,
	[et_eje_origen] [varchar](30) NULL,
	[et_ofc_origen] [smallint] NULL,
	[et_eje_destino] [smallint] NULL,
	[et_ofc_destino] [smallint] NULL,
	[et_cod_cliente] [int] NULL,
	[et_fec_cancelacion] [datetime] NULL,
	[et_nota_del_credito] [tinyint] NULL
)
GO

/****** Object:  Index [ex_trasladada_canc_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [ex_trasladada_canc_Key] ON [ex_cartera_trasladada_canc]
(
	[et_fecha],
	[et_aplicativo],
	[et_nro_tramite]
)
GO


/****** Object:  Table [ex_condonacion]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_condonacion') IS NOT NULL
	DROP TABLE ex_condonacion
GO

CREATE TABLE [ex_condonacion](
	[co_fecha] [datetime] NOT NULL,
	[co_aplicativo] [tinyint] NOT NULL,
	[co_secuencial] [int] NULL,
	[co_banco] [cuenta] NULL,
	[co_cliente] [int] NOT NULL,
	[co_fecha_aplica] [datetime] NULL,
	[co_valor] [money] NULL,
	[co_porcentaje] [float] NULL,
	[co_concepto] [catalogo] NULL,
	[co_estado_concepto] [tinyint] NULL,
	[co_usuario] [login] NULL,
	[co_rol_condona] [tinyint] NULL,
	[co_autoriza] [tinyint] NULL,
	[co_estado] [char](1) NULL
)
GO

/****** Object:  Index [ex_condonacion_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_condonacion_Key] ON [ex_condonacion]
(
	[co_fecha],
	[co_aplicativo],
	[co_banco]
)
GO


/****** Object:  Table [ex_dato_acciones_cobranza]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_acciones_cobranza') IS NOT NULL
	DROP TABLE ex_dato_acciones_cobranza
GO

CREATE TABLE [ex_dato_acciones_cobranza](
	[ac_fecha] [datetime] NOT NULL,
	[ac_aplicativo] [tinyint] NOT NULL,
	[ac_banco] [varchar](24) NOT NULL,
	[ac_cliente] [int] NOT NULL,
	[ac_cobranza] [catalogo] NOT NULL,
	[ac_taccion] [catalogo] NOT NULL,
	[ac_numero_acc] [int] NOT NULL,
	[ac_abogado] [varchar](20) NULL,
	[ac_valor] [money] NULL,
	[ac_descripcion] [varchar](255) NULL
)
GO


/****** Object:  Table [ex_dato_bal_fnciero]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_bal_fnciero') IS NOT NULL
	DROP TABLE ex_dato_bal_fnciero
GO

CREATE TABLE [ex_dato_bal_fnciero](
	[bf_fecha] [datetime] NOT NULL,
	[bf_aplicativo] [tinyint] NOT NULL,
	[bf_id_microempresa] [numero] NOT NULL,
	[bf_microempresa] [int] NOT NULL,
	[bf_tramite] [int] NOT NULL,
	[bf_sec_balance] [int] NOT NULL,
	[bf_nivel1] [varchar](16) NOT NULL,
	[bf_nivel2] [varchar](16) NULL,
	[bf_nivel3] [varchar](16) NULL,
	[bf_nivel4] [varchar](16) NULL,
	[bf_sumatoria] [char](1) NULL,
	[bf_total] [money] NULL,
	[bf_descripcion] [descripcion] NULL,
	[bf_nivel] [tinyint] NULL,
	[bf_actualizado] [char](1) NOT NULL
)
GO


/****** Object:  Table [ex_dato_bal_fnciero_det]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_bal_fnciero_det') IS NOT NULL
	DROP TABLE ex_dato_bal_fnciero_det
GO

CREATE TABLE [ex_dato_bal_fnciero_det](
	[bd_fecha] [datetime] NOT NULL,
	[bd_aplicativo] [tinyint] NOT NULL,
	[bd_id_microempresa] [numero] NOT NULL,
	[bd_microempresa] [int] NOT NULL,
	[bd_tramite] [int] NOT NULL,
	[bd_sec_balance] [int] NOT NULL,
	[bd_codigo_var] [int] NOT NULL,
	[bd_secuencial] [int] NOT NULL,
	[bd_tipo] [char](1) NULL,
	[bd_valor] [varchar](255) NULL,
	[bd_decl_jur] [char](1) NULL
)
GO


/****** Object:  Table [ex_dato_bal_resultado]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_bal_resultado') IS NOT NULL
	DROP TABLE ex_dato_bal_resultado
GO

CREATE TABLE [ex_dato_bal_resultado](
	[br_fecha] [datetime] NOT NULL,
	[br_aplicativo] [tinyint] NOT NULL,
	[br_secuencial] [int] NOT NULL,
	[br_costo_mercancia] [int] NOT NULL,
	[br_id_microempresa] [numero] NOT NULL,
	[br_microempresa] [int] NOT NULL,
	[br_tramite] [int] NOT NULL,
	[br_producto] [descripcion] NOT NULL,
	[br_ventas] [money] NULL,
	[br_part_ventas] [float] NULL,
	[br_costo] [money] NULL,
	[br_costo_pond] [float] NULL,
	[br_precio_unidad] [money] NULL,
	[br_unidad_prod] [int] NULL,
	[br_precio_venta] [money] NULL,
	[br_costo_var] [money] NULL,
	[br_tipo_costo] [char](1) NULL
)
GO


/****** Object:  Table [ex_dato_castigos]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_castigos') IS NOT NULL
	DROP TABLE ex_dato_castigos
GO

CREATE TABLE [ex_dato_castigos](
	[dt_fecha] [smalldatetime] NULL,
	[dt_secuencial] [int] NULL,
	[dt_banco] [varchar](24) NULL,
	[dt_toperacion] [varchar](10) NULL,
	[dt_aplicativo] [tinyint] NULL,
	[dt_fecha_trans] [smalldatetime] NULL,
	[dt_tipo_trans] [varchar](10) NULL,
	[dt_reversa] [varchar](1) NULL,
	[dt_naturaleza] [varchar](1) NULL,
	[dt_canal] [varchar](10) NULL,
	[dt_oficina] [smallint] NULL,
	[dt_secuencial_caja] [int] NULL,
	[dt_usuario] [varchar](14) NULL,
	[dt_terminal] [varchar](20) NULL,
	[dt_fecha_hora] [datetime] NULL
)
GO


/****** Object:  Table [ex_dato_castigos_det]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_castigos_det') IS NOT NULL
	DROP TABLE ex_dato_castigos_det
GO

CREATE TABLE [ex_dato_castigos_det](
	[dd_fecha] [smalldatetime] NULL,
	[dd_secuencial] [int] NULL,
	[dd_banco] [varchar](24) NULL,
	[dd_toperacion] [varchar](10) NULL,
	[dd_aplicativo] [tinyint] NULL,
	[dd_concepto] [varchar](10) NULL,
	[dd_moneda] [int] NULL,
	[dd_cotizacion] [float] NULL,
	[dd_monto] [money] NULL,
	[dd_codigo_valor] [varchar](24) NULL
)
GO


/****** Object:  Table [ex_dato_causa_rechazo]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_causa_rechazo') IS NOT NULL
	DROP TABLE ex_dato_causa_rechazo
GO

CREATE TABLE [ex_dato_causa_rechazo](
	[cr_fecha] [datetime] NOT NULL,
	[cr_aplicativo] [tinyint] NOT NULL,
	[cr_tramite] [int] NOT NULL,
	[cr_causal] [varchar](10) NOT NULL,
	[cr_tipo] [varchar](10) NOT NULL
)
GO

/****** Object:  Table [ex_dato_central_cliente]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_central_cliente') IS NOT NULL
	DROP TABLE ex_dato_central_cliente
GO

CREATE TABLE [ex_dato_central_cliente](
	[dcc_fecha_proceso] [datetime] NOT NULL,
	[dcc_orden_consulta] [int] NOT NULL,
	[dcc_central] [varchar](20) NOT NULL,
	[dcc_fecha_cons] [datetime] NULL,
	[dcc_tipo_id] [varchar](10) NOT NULL,
	[dcc_num_id] [varchar](20) NOT NULL,
	[dcc_estado_id] [varchar](20) NULL,
	[dcc_respuesta] [varchar](200) NULL,
	[dcc_aplicativo] [int] NOT NULL,
	[dcc_ente] [int] NULL
)
GO

/****** Object:  Index [ex_dato_central_cliente_key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_dato_central_cliente_key] ON [ex_dato_central_cliente]
(
	[dcc_fecha_proceso],
	[dcc_aplicativo],
	[dcc_orden_consulta]
)
GO
/****** Object:  Index [ex_dato_central_cliente_key2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [ex_dato_central_cliente_key2] ON [ex_dato_central_cliente]
(
	[dcc_tipo_id],
	[dcc_num_id]
)
GO


/****** Object:  Table [ex_dato_central_endeudamiento]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_central_endeudamiento') IS NOT NULL
	DROP TABLE ex_dato_central_endeudamiento
GO

CREATE TABLE [ex_dato_central_endeudamiento](
	[dce_fecha_proceso] [datetime] NOT NULL,
	[dce_orden_consulta] [int] NOT NULL,
	[dce_fecha_corte] [datetime] NULL,
	[dce_valor_com] [money] NULL,
	[dce_cant_com] [smallint] NULL,
	[dce_calif_com] [varchar](10) NULL,
	[dce_valor_hip] [money] NULL,
	[dce_cant_hip] [smallint] NULL,
	[dce_calif_hip] [varchar](10) NULL,
	[dce_valor_con] [money] NULL,
	[dce_cant_con] [smallint] NULL,
	[dce_calif_con] [varchar](10) NULL,
	[dce_valor_mic] [money] NULL,
	[dce_cant_mic] [smallint] NULL,
	[dce_calif_mic] [varchar](10) NULL,
	[dce_aplicativo] [int] NOT NULL
)
GO

/****** Object:  Index [ex_dato_central_endeudamiento_key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_dato_central_endeudamiento_key] ON [ex_dato_central_endeudamiento]
(
	[dce_fecha_proceso],
	[dce_aplicativo],
	[dce_orden_consulta]
)
GO


/****** Object:  Table [ex_dato_central_huella]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_central_huella') IS NOT NULL
	DROP TABLE ex_dato_central_huella
GO

CREATE TABLE [ex_dato_central_huella](
	[dch_fecha_proceso] [datetime] NOT NULL,
	[dch_orden_consulta] [int] NOT NULL,
	[dch_fecha_cons] [datetime] NULL,
	[dch_tipo_prod] [varchar](10) NULL,
	[dch_entidad] [varchar](100) NULL,
	[dch_oficina] [varchar](50) NULL,
	[dch_ciudad] [varchar](50) NULL,
	[dch_aplicativo] [int] NOT NULL
)
GO

/****** Object:  Index [ex_dato_central_huella_key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_dato_central_huella_key] ON [ex_dato_central_huella]
(
	[dch_fecha_proceso],
	[dch_aplicativo],
	[dch_orden_consulta]
)
GO


/****** Object:  Table [ex_dato_central_producto]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_central_producto') IS NOT NULL
	DROP TABLE ex_dato_central_producto
GO

CREATE TABLE [ex_dato_central_producto](
	[dcp_fecha_proceso] [datetime] NOT NULL,
	[dcp_orden_consulta] [int] NOT NULL,
	[dcp_tipo_reg] [varchar](30) NOT NULL,
	[dcp_estado] [varchar](30) NULL,
	[dcp_tipo_prod] [varchar](10) NULL,
	[dcp_entidad] [varchar](100) NULL,
	[dcp_fecha_act] [datetime] NULL,
	[dcp_numero] [varchar](20) NULL,
	[dcp_fecha_aper] [datetime] NULL,
	[dcp_fecha_ven] [datetime] NULL,
	[dcp_valor_inicial] [money] NULL,
	[dcp_saldo_act] [money] NULL,
	[dcp_saldo_mora] [money] NULL,
	[dcp_valor_cuota] [money] NULL,
	[dcp_num_cuotas] [int] NULL,
	[dcp_periodicidad] [varchar](10) NULL,
	[dcp_ciudad] [varchar](50) NULL,
	[dcp_oficina] [varchar](50) NULL,
	[dcp_calidad] [varchar](20) NULL,
	[dcp_comportamiento] [varchar](100) NULL,
	[dcp_calificacion] [varchar](10) NULL,
	[dcp_aplicativo] [int] NOT NULL
)
GO

/****** Object:  Index [ex_dato_central_producto_key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_dato_central_producto_key] ON [ex_dato_central_producto]
(
	[dcp_fecha_proceso],
	[dcp_aplicativo],
	[dcp_orden_consulta]
)
GO


/****** Object:  Table [ex_dato_central_score]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_central_score') IS NOT NULL
	DROP TABLE ex_dato_central_score
GO

CREATE TABLE [ex_dato_central_score](
	[dcs_fecha_proceso] [datetime] NOT NULL,
	[dcs_orden_consulta] [int] NOT NULL,
	[dcs_tipo] [varchar](20) NULL,
	[dcs_puntaje] [varchar](20) NULL,
	[dcs_aplicativo] [int] NOT NULL
)
GO

/****** Object:  Index [ex_dato_central_score_key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_dato_central_score_key] ON [ex_dato_central_score]
(
	[dcs_fecha_proceso],
	[dcs_aplicativo],
	[dcs_orden_consulta]
)
GO


/****** Object:  Table [ex_dato_cliente]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_cliente') IS NOT NULL
	DROP TABLE ex_dato_cliente
GO

CREATE TABLE [ex_dato_cliente](
	[dc_fecha] [datetime] NULL,
	[dc_cliente] [int] NULL,
	[dc_tipo_ced] [char](2) NULL,
	[dc_ced_ruc] [varchar](24) NULL,
	[dc_nombre] [varchar](64) NULL,
	[dc_p_apellido] [varchar](16) NULL,
	[dc_s_apellido] [varchar](16) NULL,
	[dc_subtipo] [char](1) NULL,
	[dc_oficina] [smallint] NULL,
	[dc_oficial] [smallint] NULL,
	[dc_sexo] [char](1) NULL,
	[dc_actividad] [varchar](10) NULL,
	[dc_retencion] [char](1) NULL,
	[dc_sector] [varchar](10) NULL,
	[dc_situacion_cliente] [varchar](10) NULL,
	[dc_victima] [char](1) NULL,
	[dc_exc_sipla] [char](1) NULL,
	[dc_estado_civil] [varchar](10) NULL,
	[dc_nivel_ing] [money] NULL,
	[dc_nivel_egr] [money] NULL,
	[dc_fecha_ingreso] [datetime] NULL,
	[dc_fecha_mod] [datetime] NULL,
	[dc_fecha_nac] [datetime] NULL,
	[dc_ciudad_nac] [int] NULL,
	[dc_iden_conyuge] [varchar](30) NULL,
	[dc_tipo_doc_cony] [varchar](2) NULL,
	[dc_p_apellido_cony] [varchar](16) NULL,
	[dc_s_apellido_cony] [varchar](16) NULL,
	[dc_nombre_cony] [varchar](40) NULL,
	[dc_estrato] [varchar](10) NULL,
	[dc_tipo_vivienda] [varchar](10) NULL,
	[dc_pais] [smallint] NULL,
	[dc_nivel_estudio] [varchar](10) NULL,
	[dc_num_carga] [tinyint] NULL,
	[dc_PEP] [char](10) NULL,
	[dc_fecha_vinculacion] [datetime] NULL,
	[dc_hipoteca_viv] [char](1) NULL,
	[dc_num_activas] [smallint] NULL,
	[dc_estado_cliente] [char](1) NULL,
	[dc_banca] [catalogo] NULL,
	[dc_segmento] [catalogo] NULL,
	[dc_subsegmento] [catalogo] NULL,
	[dc_actprincipal] [catalogo] NULL,
	[dc_actividad2] [catalogo] NULL,
	[dc_actividad3] [catalogo] NULL
)
ALTER TABLE [ex_dato_cliente] ADD [dc_bancarizado] [char](1) NULL
ALTER TABLE [ex_dato_cliente] ADD [dc_alto_riesgo] [varchar](1) NULL
ALTER TABLE [ex_dato_cliente] ADD [dc_fecha_riesgo] [datetime] NULL
ALTER TABLE [ex_dato_cliente] ADD [dc_perf_tran] [money] NULL
ALTER TABLE [ex_dato_cliente] ADD [dc_riesgo] [catalogo] NULL
ALTER TABLE [ex_dato_cliente] ADD [dc_nit] [numero] NULL
GO

/****** Object:  Table [ex_dato_clientes_campana]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_clientes_campana') IS NOT NULL
	DROP TABLE ex_dato_clientes_campana
GO

CREATE TABLE [ex_dato_clientes_campana](
	[cc_fecha] [datetime] NULL,
	[cc_aplicativo] [int] NULL,
	[cc_cliente] [int] NULL,
	[cc_ced_ruc] [varchar](20) NULL,
	[cc_nombre] [varchar](100) NULL,
	[cc_toperacion] [catalogo] NULL,
	[cc_tasa_ref] [float] NULL,
	[cc_tasa_neg] [float] NULL,
	[cc_ejecutivo] [varchar](100) NULL,
	[cc_op_banco] [varchar](15) NULL,
	[cc_fecha_apr] [datetime] NULL,
	[cc_tramite] [int] NULL,
	[cc_fecha_cli_cam] [datetime] NULL,
	[cc_campana] [int] NULL,
	[cc_campana_nombre] [varchar](50) NULL,
	[cc_campana_tipo] [varchar](64) NULL,
	[cc_condicion] [varchar](50) NULL,
	[cc_acepta_contraoferta] [char](1) NULL,
	[cc_encuesta] [char](1) NULL,
	[cc_fecha_ini] [datetime] NULL,
	[cc_fecha_fin] [datetime] NULL,
	[cc_asignado_a] [login] NULL,
	[cc_asignado_por] [login] NULL,
	[cc_oficina] [int] NULL,
	[cc_dir_negocio] [varchar](255) NULL,
	[cc_tel_nego] [varchar](20) NULL,
	[cc_barrio] [descripcion] NULL,
	[cc_plazo] [int] NULL,
	[cc_tplazo] [catalogo] NULL,
	[cc_oficial] [int] NULL,
	[cc_oficial_nombre] [descripcion] NULL,
	[cc_estado] [char](1) NULL
)
GO

/****** Object:  Index [ix_ex_clientes_campana_ix_1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [ix_ex_clientes_campana_ix_1] ON [ex_dato_clientes_campana]
(
	[cc_fecha]
)
GO


/****** Object:  Table [ex_dato_cobranza]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_cobranza') IS NOT NULL
	DROP TABLE ex_dato_cobranza
GO

CREATE TABLE [ex_dato_cobranza](
	[dc_fecha] [datetime] NOT NULL,
	[dc_aplicativo] [tinyint] NOT NULL,
	[dc_cobranza] [catalogo] NOT NULL,
	[dc_banco] [cuenta] NOT NULL,
	[dc_estado] [catalogo] NOT NULL,
	[dc_ente_abogado] [int] NULL,
	[dc_fecha_citacion] [datetime] NULL,
	[dc_fecha_acuerdo] [datetime] NULL
)
GO

/****** Object:  Table [ex_dato_cuota_pry]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_cuota_pry') IS NOT NULL
	DROP TABLE ex_dato_cuota_pry
GO

CREATE TABLE [ex_dato_cuota_pry](
	[dc_fecha] [smalldatetime] NOT NULL,
	[dc_banco] [varchar](24) NOT NULL,
	[dc_toperacion] [varchar](10) NOT NULL,
	[dc_aplicativo] [tinyint] NOT NULL,
	[dc_num_cuota] [int] NOT NULL,
	[dc_fecha_vto] [smalldatetime] NOT NULL,
	[dc_estado] [char](1) NOT NULL,
	[dc_valor_pry] [money] NOT NULL,
	dc_cap_cuota     MONEY NULL,
	dc_int_cuota     MONEY NULL,
	dc_imo_cuota     MONEY NULL,
	dc_pre_cuota     MONEY NULL,
	dc_iva_int_cuota MONEY NULL,
	dc_iva_imo_cuota MONEY NULL,
	dc_iva_pre_cuota MONEY NULL,
	dc_otros_cuota   MONEY NULL,
	dc_int_acum      MONEY NULL,
	dc_iva_int_acum  MONEY NULL,
	dc_cap_pag       MONEY NULL,
	dc_int_pag       MONEY NULL,
	dc_imo_pag       MONEY NULL,
	dc_pre_pag       MONEY NULL,
	dc_iva_int_pag   MONEY NULL,
	dc_iva_imo_pag   MONEY NULL,
	dc_iva_pre_pag   MONEY NULL,
	dc_otros_pag     MONEY NULL,
	dc_fecha_can     SMALLDATETIME NULL,
	dc_fecha_upago   SMALLDATETIME NULL,
	dc_fecha_ini     datetime null,
	dc_com_lcr       money null,
	dc_ivacom_lcr    money null

	)
GO

/****** Object:  Table [ex_dato_direccion]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_direccion') IS NOT NULL
	DROP TABLE ex_dato_direccion
GO

CREATE TABLE [ex_dato_direccion](
	[dd_fecha] [datetime] NULL,
	[dd_cliente] [int] NULL,
	[dd_direccion] [int] NULL,
	[dd_descripcion] [varchar](254) NULL,
	[dd_ciudad] [varchar](10) NULL,
	[dd_tipo] [varchar](10) NULL,
	[dd_fecha_ingreso] [datetime] NULL,
	[dd_fecha_modificacion] [datetime] NULL,
	[dd_principal] [char](1) NULL,
	[dd_rural_urb] [char](1) NULL,
	[dd_provincia] [int] NULL,
	[dd_parroquia] [int] NULL
)
GO

/****** Object:  Table [ex_dato_educa_hijos]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_educa_hijos') IS NOT NULL
	DROP TABLE ex_dato_educa_hijos
GO

CREATE TABLE [ex_dato_educa_hijos](
	[dt_secuencial] [int] NULL,
	[dt_cliente] [int] NULL,
	[dt_edad] [int] NULL,
	[dt_niv_edu] [int] NULL,
	[dt_hijos] [int] NULL,
	[dt_fecha_modif] [datetime] NULL
)
GO

/****** Object:  Index [ex_dato_educa_hijos_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [ex_dato_educa_hijos_Key] ON [ex_dato_educa_hijos]
(
	[dt_cliente]
)
GO


/****** Object:  Table [ex_dato_encuesta_preg]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_encuesta_preg') IS NOT NULL
	DROP TABLE ex_dato_encuesta_preg
GO

CREATE TABLE [ex_dato_encuesta_preg](
	[ep_fecha] [datetime] NOT NULL,
	[ep_aplicativo] [tinyint] NOT NULL,
	[ep_pregunta] [smallint] NOT NULL,
	[ep_texto] [varchar](255) NOT NULL,
	[ep_tipo_resp] [catalogo] NOT NULL,
	[ep_catalogo] [varchar](30) NULL,
	[ep_estado] [estado] NOT NULL,
	[ep_identificador] [varchar](32) NULL,
	[ep_tipo] [smallint] NULL,
	[ep_subtipo_m] [varchar](30) NULL
)
GO

/****** Object:  Table [ex_dato_encuesta_resp]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_encuesta_resp') IS NOT NULL
	DROP TABLE ex_dato_encuesta_resp
GO

CREATE TABLE [ex_dato_encuesta_resp](
	[er_fecha] [datetime] NOT NULL,
	[er_aplicativo] [tinyint] NOT NULL,
	[er_tramite] [int] NOT NULL,
	[er_pregunta] [int] NOT NULL,
	[er_respuesta] [varchar](255) NOT NULL
)
GO

/****** Object:  Table [ex_dato_encuestas]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_encuestas') IS NOT NULL
	DROP TABLE ex_dato_encuestas
GO

CREATE TABLE [ex_dato_encuestas](
	[re_fecha] [datetime] NOT NULL,
	[re_aplicativo] [int] NOT NULL,
	[re_cliente] [int] NOT NULL,
	[re_fecha_resp] [datetime] NOT NULL,
	[re_formulario] [int] NOT NULL,
	[re_version] [int] NOT NULL,
	[re_secuencial] [int] NOT NULL,
	[re_cod_pregunta] [int] NOT NULL,
	[re_pregunta] [varchar](64) NOT NULL,
	[re_respuesta] [varchar](30) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [ex_dato_encuestas]
(
	[re_pregunta],
	[re_secuencial]
)
GO
/****** Object:  Index [idx_re_fecha]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx_re_fecha] ON [ex_dato_encuestas]
(
	[re_fecha]
)
GO


/****** Object:  Table [ex_dato_escolaridad_log]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_escolaridad_log') IS NOT NULL
	DROP TABLE ex_dato_escolaridad_log
GO

CREATE TABLE [ex_dato_escolaridad_log](
	[dt_secuencial] [int] NULL,
	[dt_cliente] [int] NULL,
	[dt_ced_ruc] [varchar](10) NULL,
	[dt_nom_cliente] [varchar](40) NULL,
	[dt_nom_campo] [varchar](40) NULL,
	[dt_valor_anterior] [varchar](40) NULL,
	[dt_valor_actual] [varchar](40) NULL,
	[dt_fecha_actualizacion] [datetime] NULL,
	[dt_usuario] [varchar](20) NULL
)
GO

/****** Object:  Index [ex_dato_escolaridad_log_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [ex_dato_escolaridad_log_Key] ON [ex_dato_escolaridad_log]
(
	[dt_cliente]
)
GO


/****** Object:  Table [ex_dato_gestion_campana]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_gestion_campana') IS NOT NULL
	DROP TABLE ex_dato_gestion_campana
GO

CREATE TABLE [ex_dato_gestion_campana](
	[gc_fecha] [datetime] NOT NULL,
	[gc_aplicativo] [int] NOT NULL,
	[gc_campana] [int] NOT NULL,
	[gc_cliente] [int] NOT NULL,
	[gc_fecha_campana] [datetime] NOT NULL,
	[gc_secuencial] [int] NOT NULL,
	[gc_gestor] [login] NOT NULL,
	[gc_forma_gestion] [catalogo] NOT NULL,
	[gc_logro_contacto] [char](1) NOT NULL,
	[gc_contacto_con] [catalogo] NULL,
	[gc_causa_no_contacto] [catalogo] NULL,
	[gc_resp_favorable] [char](1) NULL,
	[gc_causa_rechazo] [catalogo] NULL,
	[gc_cerrar_gestion] [char](1) NOT NULL,
	[gc_causa_cierre] [catalogo] NULL,
	[gc_comentario] [varchar](254) NULL,
	[gc_fecha_gestion] [datetime] NOT NULL,
	[gc_hora_gestion] [varchar](5) NOT NULL,
	[gc_user] [login] NULL,
	[gc_hora_real] [datetime] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [ex_dato_gestion_campana]
(
	[gc_cliente],
	[gc_campana],
	[gc_fecha_campana],
	[gc_secuencial]
)
GO
/****** Object:  Index [idx_gc_fecha]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx_gc_fecha] ON [ex_dato_gestion_campana]
(
	[gc_fecha]
)
GO


/****** Object:  Table [ex_dato_lin_ope_moneda]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_lin_ope_moneda') IS NOT NULL
	DROP TABLE ex_dato_lin_ope_moneda
GO

CREATE TABLE [ex_dato_lin_ope_moneda](
	[dm_fecha] [datetime] NULL,
	[dm_aplicativo] [int] NULL,
	[dm_linea] [int] NULL,
	[dm_toperacion] [varchar](10) NULL,
	[dm_producto] [varchar](10) NULL,
	[dm_moneda] [tinyint] NULL,
	[dm_monto] [money] NULL,
	[dm_utilizado] [money] NULL,
	[dm_tplazo] [varchar](10) NULL,
	[dm_plazos] [smallint] NULL,
	[dm_reservado] [money] NULL
)
GO

/****** Object:  Table [ex_dato_linea]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_linea') IS NOT NULL
	DROP TABLE ex_dato_linea
GO

CREATE TABLE [ex_dato_linea](
	[dl_fecha] [datetime] NULL,
	[dl_aplicativo] [int] NULL,
	[dl_numero] [int] NULL,
	[dl_num_banco] [varchar](24) NULL,
	[dl_oficina] [int] NULL,
	[dl_tramite] [int] NULL,
	[dl_cliente] [int] NULL,
	[dl_original] [int] NULL,
	[dl_fecha_aprob] [datetime] NULL,
	[dl_fecha_inicio] [datetime] NULL,
	[dl_fecha_vto] [datetime] NULL,
	[dl_rotativa] [varchar](1) NULL,
	[dl_estado] [varchar](1) NULL,
	[dl_moneda] [int] NULL,
	[dl_monto] [money] NULL,
	[dl_utilizado] [money] NULL,
	[dl_reservado] [money] NULL,
	[dl_usuario_mod] [varchar](14) NULL,
	[dl_fecha_mod] [datetime] NULL,
	[dl_plazo] [int] NULL,
	[dl_tipo_plazo] [varchar](10) NULL
)
GO

/****** Object:  Table [ex_dato_microempresa]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_microempresa') IS NOT NULL
	DROP TABLE ex_dato_microempresa
GO

CREATE TABLE [ex_dato_microempresa](
	[dm_fecha] [datetime] NOT NULL,
	[dm_aplicativo] [tinyint] NOT NULL,
	[dm_id_microempresa] [numero] NOT NULL,
	[dm_nombre] [descripcion] NOT NULL,
	[dm_descripcion] [descripcion] NULL
)
GO

/****** Object:  Table [ex_dato_microempresa_sit]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_microempresa_sit') IS NOT NULL
	DROP TABLE ex_dato_microempresa_sit
GO

CREATE TABLE [ex_dato_microempresa_sit](
	[ms_fecha] [datetime] NOT NULL,
	[ms_aplicativo] [tinyint] NOT NULL,
	[ms_id_microempresa] [numero] NOT NULL,
	[ms_microempresa] [int] NOT NULL,
	[ms_tramite] [int] NOT NULL,
	[ms_actividad] [varchar](10) NULL,
	[ms_tipo_local] [varchar](10) NOT NULL,
	[ms_tipo_empresa] [varchar](10) NOT NULL,
	[ms_dias_trabajados] [int] NULL,
	[ms_num_trbjdr_remu] [int] NULL,
	[ms_num_trbjdr_no_remu] [int] NULL,
	[ms_decl_jurada] [money] NOT NULL,
	[ms_fecha_apertura] [datetime] NOT NULL,
	[ms_fini_posesion] [datetime] NOT NULL,
	[ms_fini_experiencia] [datetime] NOT NULL,
	[ms_fini_abr_econ] [datetime] NOT NULL
)
GO

/****** Object:  Table [ex_dato_operacion]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_operacion') IS NOT NULL
	DROP TABLE ex_dato_operacion
GO

CREATE TABLE [ex_dato_operacion](
	[do_fecha] [datetime] NOT NULL,
	[do_operacion] [int] NOT NULL,
	[do_banco] [varchar](24) NOT NULL,
	[do_toperacion] [varchar](10) NOT NULL,
	[do_aplicativo] [tinyint] NOT NULL,
	[do_destino_economico] [varchar](10) NOT NULL,
	[do_clase_cartera] [varchar](10) NOT NULL,
	[do_cliente] [int] NOT NULL,
	[do_documento_tipo] [varchar](2) NULL,
	[do_documento_numero] [varchar](24) NULL,
	[do_oficina] [int] NOT NULL,
	[do_moneda] [tinyint] NOT NULL,
	[do_monto] [money] NOT NULL,
	[do_tasa] [float] NULL,
	[do_modalidad] [char](1) NULL,
	[do_plazo_dias] [int] NULL,
	[do_fecha_desembolso] [datetime] NOT NULL,
	[do_fecha_vencimiento] [datetime] NOT NULL,
	[do_edad_mora] [int] NOT NULL,
	[do_reestructuracion] [char](1) NULL,
	[do_fecha_reest] [datetime] NULL,
	[do_nat_reest] [varchar](10) NULL,
	[do_num_reest] [tinyint] NULL,
	[do_num_renovaciones] [int] NULL,
	[do_estado] [tinyint] NOT NULL,
	[do_cupo_credito] [varchar](24) NULL,
	[do_num_cuotas] [smallint] NOT NULL,
	[do_periodicidad_cuota] [smallint] NOT NULL,
	[do_valor_cuota] [money] NULL,
	[do_cuotas_pag] [smallint] NULL,
	[do_cuotas_ven] [smallint] NULL,
	[do_saldo_ven] [money] NULL,
	[do_fecha_prox_vto] [datetime] NULL,
	[do_fecha_ult_pago] [datetime] NULL,
	[do_valor_ult_pago] [money] NULL,
	[do_fecha_castigo] [datetime] NULL,
	[do_num_acta] [varchar](24) NULL,
	[do_clausula] [char](1) NULL,
	[do_oficial] [smallint] NULL,
	[do_banco_padre] [cuenta] NULL
	
)
ALTER TABLE [ex_dato_operacion] ADD [do_naturaleza] [varchar](2) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_fuente_recurso] [varchar](10) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_categoria_producto] [varchar](10) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_cap_mora] [money] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_tipo_garantias] [char](1) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_op_anterior] [varchar](24) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_edad_cod] [tinyint] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_num_cuotas_reest] [tinyint] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_tramite] [int] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_nota_int] [tinyint] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_fecha_ini_mora] [datetime] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_gracia_mora] [smallint] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_estado_cobranza] [catalogo] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_tasa_mora] [float] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_tasa_com] [float] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_entidad_convenio] [varchar](10) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_fecha_cambio_linea] [datetime] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_valor_nominal] [money] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_emision] [varchar](20) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_sujcred] [varchar](10) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_cap_vencido] [money] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_valor_proxima_cuota] [money] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_saldo_total_Vencido] [money] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_saldo_otr] [money] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_saldo_cap_total] [money] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_regional] [varchar](64) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_dias_mora_365] [int] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_normalizado] [char](1) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_tipo_norm] [int] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_frec_pagos_capital]	[INT] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_frec_pagos_int]	[INT] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_fec_pri_amort_cubierta]	[DATETIME] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_monto_condo]	[MONEY] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_fecha_condo]	[DATETIME] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_monto_castigo] [MONEY] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_inte_castigo] [FLOAT] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_monto_bonifica] [MONEY] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_inte_refina]	[FLOAT] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_emproblemado] [CHAR](1) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_mod_pago] [INT] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_tipo_cartera] [varchar](10) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_subtipo_cartera] [varchar](10) NULL
ALTER TABLE [ex_dato_operacion] ADD [do_fecha_ult_pago_cap]	[DATETIME] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_valor_ult_pago_cap] [MONEY] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_fecha_ult_pago_int]	[DATETIME] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_valor_ult_pago_int] [MONEY] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_inte_vencido] [MONEY] NULL
ALTER TABLE [ex_dato_operacion] ADD [do_inte_vencido_fbalance] [MONEY] NULL
alter table cob_externos..ex_dato_operacion add do_dias_mora_ant int null
alter table cob_externos..ex_dato_operacion add do_grupal char(1) null
alter table cob_externos..ex_dato_operacion add do_cociente_pago float null
alter table cob_externos..ex_dato_operacion add do_numero_ciclos int null
alter table cob_externos..ex_dato_operacion add do_numero_integrantes int null
alter table cob_externos..ex_dato_operacion add do_grupo int null
ALTER TABLE ex_dato_operacion ADD do_valor_cat            FLOAT NULL
ALTER TABLE ex_dato_operacion ADD do_gar_liq_orig    MONEY NULL
ALTER TABLE ex_dato_operacion ADD do_gar_liq_fpago  DATETIME NULL
ALTER TABLE ex_dato_operacion ADD do_gar_liq_dev    MONEY NULL
ALTER TABLE ex_dato_operacion ADD do_gar_liq_fdev  DATETIME NULL
alter table ex_dato_operacion add do_cuota_cap money null 
alter table ex_dato_operacion add do_cuota_int money null
alter table ex_dato_operacion add do_cuota_iva money null
alter table ex_dato_operacion add do_fecha_suspenso datetime null
alter table ex_dato_operacion add do_cuenta cuenta null
alter table ex_dato_operacion add do_venc_dividendo int null
alter table ex_dato_operacion add do_plazo varchar(64) null 
alter table ex_dato_operacion add do_fecha_aprob_tramite datetime null 
alter table ex_dato_operacion add do_subtipo_producto varchar(64) null 
alter table ex_dato_operacion add do_atraso_grupal int null
alter table ex_dato_operacion add do_fecha_dividendo_ven datetime null
alter table ex_dato_operacion add do_cuota_min_vencida money null
alter table ex_dato_operacion add do_tplazo varchar(10) null
alter table ex_dato_operacion add do_subproducto varchar(10) null 
alter table ex_dato_operacion add do_respuesta_uno varchar(20) null 
alter table ex_dato_operacion add do_respuesta_dos varchar(20) null 
alter table ex_dato_operacion add do_respuesta_tres varchar(20) null 
alter table ex_dato_operacion add do_respuesta_cuatro varchar(20) null
alter table ex_dato_operacion add do_respuesta_cinco varchar(20) null  
alter table ex_dato_operacion add do_respuesta_seis varchar(20) null
alter table ex_dato_operacion add do_respuesta_siete varchar(20) null 
alter table ex_dato_operacion add do_respuesta_ocho varchar(20) null 
alter table ex_dato_operacion add do_respuesta_nueve varchar(20) null 
alter table ex_dato_operacion add do_respuesta_diez varchar(20) null 
alter table ex_dato_operacion add do_respuesta_once varchar(20) null 
alter table ex_dato_operacion add do_respuesta_doce varchar(20) null 
alter table ex_dato_operacion add do_respuesta_trece varchar(20) null 
alter table ex_dato_operacion add do_respuesta_catorce varchar(20) null 
alter table ex_dato_operacion add do_respuesta_quince varchar(20) null 
alter table ex_dato_operacion add do_respuesta_dieciseis varchar(20) null 
alter table ex_dato_operacion add do_respuesta_diecisiete varchar(20) null 
alter table ex_dato_operacion add do_respuesta_dieciocho varchar(20) null 
alter table ex_dato_operacion add do_coordinador varchar(64) null 
alter table ex_dato_operacion add do_gerente varchar(64) null
alter table ex_dato_operacion add do_cuota_max_vencida  money  null
alter table ex_dato_operacion add do_atraso_gr_ant  int  null
alter table ex_dato_operacion add do_monto_aprobado money null
alter table ex_dato_operacion add do_fecha_ult_vto datetime
alter table ex_dato_operacion add do_cuota_ult_vto int 
alter table ex_dato_operacion add do_tipo_amortizacion catalogo
alter table ex_dato_operacion add do_cupo_original    money     
alter table ex_dato_operacion add do_importe_ult_vto  money      
alter table ex_dato_operacion add do_importe_pri_vto  money      
alter table ex_dato_operacion add do_fecha_pri_vto    datetime 
alter table ex_dato_operacion add do_fecha_ven_orig   datetime  
alter table ex_dato_operacion add do_fecha_can_ant    datetime   
alter table ex_dato_operacion add do_cuota_int_esp    money
alter table ex_dato_operacion add do_cuota_iva_esp    money
alter table ex_dato_operacion add do_fecha_ini_desp   datetime
alter table ex_dato_operacion add do_fecha_fin_desp   datetime
alter table ex_dato_operacion add do_renovacion_grupal   int 
alter table ex_dato_operacion add do_renovacion_ind      int 
alter table ex_dato_operacion add do_meses_primer_op int    
alter table ex_dato_operacion add do_periodicidad int  
alter table ex_dato_operacion add do_dia_pago varchar(20) null
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [ex_dato_operacion]
(
	[do_fecha],
	[do_aplicativo],
	[do_banco]
)
GO


/****** Object:  Table [ex_dato_operacion_rubro]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_operacion_rubro') IS NOT NULL
	DROP TABLE ex_dato_operacion_rubro
GO
CREATE TABLE ex_dato_operacion_rubro(
	dr_fecha         smalldatetime NOT NULL,
	dr_banco         varchar(24) NOT NULL,
	dr_toperacion    varchar(10) NOT NULL,
	dr_aplicativo    tinyint NOT NULL,
	dr_concepto      varchar(24) NOT NULL,
	dr_estado        int NOT NULL,
	dr_exigible      int NOT NULL,
	dr_codvalor      int not null,
	dr_valor      MONEY NOT NULL,
	dr_cuota      MONEY NULL,
	dr_acumulado  MONEY NULL,
	dr_pagado     MONEY NULL,
	dr_categoria catalogo null,
	dr_rubro_aso catalogo null,
	dr_cat_rub_aso catalogo null
)
GO

 

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_dato_operacion_rubro]
(
	dr_fecha,
	dr_aplicativo,
	dr_banco,
	dr_concepto,
	dr_codvalor
)
GO

/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_dato_operacion_rubro]
(
	[dr_banco],
	[dr_concepto]
)
GO


/****** Object:  Table [ex_dato_reajuste]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_reajuste') IS NOT NULL
	DROP TABLE ex_dato_reajuste
GO

CREATE TABLE [ex_dato_reajuste](
	[dr_fecha] [datetime] NULL,
	[dr_aplicativo] [smallint] NULL,
	[dr_secuencial] [int] NOT NULL,
	[dr_operacion] [int] NOT NULL,
	[dr_fecha_crea] [datetime] NOT NULL,
	[dr_reajuste_especial] [char](1) NOT NULL,
	[dr_desagio] [char](1) NULL,
	[dr_sec_aviso] [int] NULL,
	[dr_concepto] [catalogo] NOT NULL,
	[dr_referencial] [catalogo] NULL,
	[dr_signo] [char](1) NULL,
	[dr_factor] [float] NULL,
	[dr_porcentaje] [float] NULL
)
GO

/****** Object:  Table [ex_dato_rubro_pry]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_rubro_pry') IS NOT NULL
	DROP TABLE ex_dato_rubro_pry
GO

CREATE TABLE [ex_dato_rubro_pry](
	[dr_fecha] [smalldatetime] NOT NULL,
	[dr_banco] [varchar](24) NOT NULL,
	[dr_toperacion] [varchar](10) NOT NULL,
	[dr_aplicativo] [tinyint] NOT NULL,
	[dr_num_cuota] [int] NOT NULL,
	[dr_concepto] [varchar](10) NOT NULL,
	[dr_estado] [varchar](1) NOT NULL,
	[dr_valor_pry] [money] NOT NULL
)
GO

/****** Object:  Table [ex_dato_ruta]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_ruta') IS NOT NULL
	DROP TABLE ex_dato_ruta
GO

CREATE TABLE [ex_dato_ruta](
	[dr_fecha] [datetime] NOT NULL,
	[dr_aplicativo] [tinyint] NOT NULL,
	[dr_tramite] [int] NOT NULL,
	[dr_secuencia] [smallint] NOT NULL,
	[dr_truta] [tinyint] NOT NULL,
	[dr_paso] [tinyint] NOT NULL,
	[dr_etapa] [tinyint] NOT NULL,
	[dr_estacion] [smallint] NOT NULL,
	[dr_funcionario] [smallint] NULL,
	[dr_llegada] [datetime] NOT NULL,
	[dr_estado] [int] NULL,
	[dr_prioridad] [tinyint] NOT NULL,
	[dr_comite] [char](1) NULL
)
GO

/****** Object:  Table [ex_dato_seguros]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_seguros') IS NOT NULL
	DROP TABLE ex_dato_seguros
GO

CREATE TABLE [ex_dato_seguros](
	[se_fecha] [datetime] NULL,
	[se_aplicativo] [tinyint] NULL,
	[se_sec_seguro] [int] NULL,
	[se_tipo_seguro] [int] NULL,
	[se_sec_renovacion] [int] NULL,
	[se_tramite] [int] NULL,
	[se_operacion] [int] NULL,
	[se_fec_devolucion] [datetime] NULL,
	[se_mto_devolucion] [money] NULL,
	[se_estado] [char](1) NULL
)
GO

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [ex_dato_seguros]
(
	[se_fecha],
	[se_aplicativo],
	[se_operacion]
)
GO


/****** Object:  Table [ex_dato_seguros_det]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_seguros_det') IS NOT NULL
	DROP TABLE ex_dato_seguros_det
GO

CREATE TABLE [ex_dato_seguros_det](
	[sed_fecha] [datetime] NULL,
	[sed_aplicativo] [tinyint] NULL,
	[sed_operacion] [int] NULL,
	[sed_sec_seguro] [int] NULL,
	[sed_tipo_seguro] [int] NULL,
	[sed_sec_renovacion] [int] NULL,
	[sed_tipo_asegurado] [int] NULL,
	[sed_estado] [int] NULL,
	[sed_dividendo] [int] NULL,
	[sed_cuota_cap] [money] NULL,
	[sed_pago_cap] [money] NULL,
	[sed_cuota_int] [money] NULL,
	[sed_pago_int] [money] NULL,
	[sed_cuota_mora] [money] NULL,
	[sed_pago_mora] [money] NULL,
	[sed_sec_asegurado] [int] NULL
)
GO

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [ex_dato_seguros_det]
(
	[sed_fecha],
	[sed_aplicativo],
	[sed_operacion]
)
GO


/****** Object:  Table [ex_dato_sostenibilidad]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_sostenibilidad') IS NOT NULL
	DROP TABLE ex_dato_sostenibilidad
GO

CREATE TABLE [ex_dato_sostenibilidad](
	[dt_cliente] [int] NULL,
	[dt_viv_mat] [catalogo] NULL,
	[dt_viv_comb] [catalogo] NULL,
	[dt_viv_dorm] [int] NULL,
	[dt_viv_conforman] [int] NULL,
	[dt_viv_aportan] [int] NULL,
	[dt_edu_financiera] [catalogo] NULL,
	[dt_grupo_etnico] [catalogo] NULL,
	[dt_viv_serv_pub] [varchar](10) NULL,
	[dt_viv_vias_llegar] [varchar](10) NULL,
	[dt_viv_equipo] [varchar](10) NULL,
	[dt_viv_tema_tratado] [varchar](10) NULL,
	[dt_fecha_modif] [datetime] NULL
)
GO

/****** Object:  Index [ex_dato_sostenibilidad_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [ex_dato_sostenibilidad_Key] ON [ex_dato_sostenibilidad]
(
	[dt_cliente]
)
GO


/****** Object:  Table [ex_dato_sostenibilidad_log]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_sostenibilidad_log') IS NOT NULL
	DROP TABLE ex_dato_sostenibilidad_log
GO

CREATE TABLE [ex_dato_sostenibilidad_log](
	[dt_cliente] [int] NULL,
	[dt_ced_ruc] [varchar](10) NULL,
	[dt_nom_cliente] [varchar](40) NULL,
	[dt_nom_campo] [varchar](40) NULL,
	[dt_valor_anterior] [varchar](40) NULL,
	[dt_valor_actual] [varchar](40) NULL,
	[dt_fecha_actualizacion] [datetime] NULL,
	[dt_usuario] [varchar](20) NULL
)
GO

/****** Object:  Index [ex_dato_sostenibilidad_log_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [ex_dato_sostenibilidad_log_Key] ON [ex_dato_sostenibilidad_log]
(
	[dt_cliente]
)
GO


/****** Object:  Table [ex_dato_telefono]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_telefono') IS NOT NULL
	DROP TABLE ex_dato_telefono
GO

CREATE TABLE [ex_dato_telefono](
	[dt_fecha] [datetime] NULL,
	[dt_cliente] [int] NULL,
	[dt_direccion] [int] NULL,
	[dt_secuencial] [int] NULL,
	[dt_valor] [varchar](16) NULL,
	[dt_tipo_telefono] [char](1) NULL,
	[dt_prefijo] [varchar](10) NULL,
	[dt_fecha_ingreso] [datetime] NULL,
	[dt_fecha_mod] [datetime] NULL
)
ALTER TABLE [ex_dato_telefono] ADD [dt_tipo_operador] [varchar](10) NULL
GO

/****** Object:  Table [ex_dato_tesoreria]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_tesoreria') IS NOT NULL
	DROP TABLE ex_dato_tesoreria
GO

CREATE TABLE [ex_dato_tesoreria](
	[dt_fecha] [datetime] NOT NULL,
	[dt_banco] [varchar](24) NOT NULL,
	[dt_toperacion] [varchar](10) NOT NULL,
	[dt_aplicativo] [int] NOT NULL,
	[dt_categoria_producto] [varchar](10) NOT NULL,
	[dt_cliente] [int] NOT NULL,
	[dt_documento_tipo] [varchar](2) NULL,
	[dt_documento_numero] [varchar](24) NULL,
	[dt_oficina] [int] NOT NULL,
	[dt_moneda] [tinyint] NOT NULL,
	[dt_valor_nominal] [money] NOT NULL,
	[dt_valor_inicial] [money] NOT NULL,
	[dt_valorizacion_mercado] [money] NOT NULL,
	[dt_valorizacion_interes] [money] NOT NULL,
	[dt_tipo_tasa] [char](1) NOT NULL,
	[dt_referencial] [varchar](10) NULL,
	[dt_factor] [float] NULL,
	[dt_spread] [smallint] NULL,
	[dt_tasa_orig] [float] NOT NULL,
	[dt_tasa_actual] [float] NOT NULL,
	[dt_modalidad] [char](1) NULL,
	[dt_plazo_dias] [int] NULL,
	[dt_fecha_apertura] [datetime] NOT NULL,
	[dt_fecha_vencimiento] [datetime] NOT NULL,
	[dt_estado] [tinyint] NOT NULL,
	[dt_num_cuotas] [smallint] NOT NULL,
	[dt_periodicidad_cuota] [smallint] NOT NULL,
	[dt_valor_cuota] [money] NOT NULL,
	[dt_fecha_prox_vto] [datetime] NOT NULL,
	[dt_tipo_doc_oficial] [char](2) NOT NULL,
	[dt_documento_oficial] [varchar](24) NOT NULL,
	[dt_naturaleza] [varchar](10) NOT NULL,
	[dt_tipo_inversion] [varchar](10) NOT NULL,
	[dt_ubicacion_contrato] [varchar](10) NOT NULL,
	[dt_renovado] [char](1) NULL,
	[dt_fecha_ren] [datetime] NULL
)
GO

/****** Object:  Table [ex_dato_tramite]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_tramite') IS NOT NULL
	DROP TABLE ex_dato_tramite
GO

CREATE TABLE [ex_dato_tramite](
	[dt_fecha] [datetime] NOT NULL,
	[dt_aplicativo] [tinyint] NOT NULL,
	[dt_tramite] [int] NOT NULL,
	[dt_tipo] [char](1) NOT NULL,
	[dt_truta] [tinyint] NOT NULL,
	[dt_fecha_creacion] [datetime] NOT NULL,
	[dt_mercado] [char](1) NULL,
	[dt_tipo_credito] [char](1) NULL
)
ALTER TABLE [ex_dato_tramite] ADD [dt_sujcred] [varchar](10) NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_clase] [varchar](10) NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_cliente] [int] NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_oficina] [smallint] NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_fuente_recurso] [varchar](10) NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_banco] [varchar](24) NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_campana] [int] NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_alianza] [int] NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_autoriza_central] [char](1) NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_negado_mir] [char](1) NULL
ALTER TABLE [ex_dato_tramite] ADD [dt_num_devri] [int] NULL
GO

/****** Object:  Table [ex_dato_tramite_sit]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_tramite_sit') IS NOT NULL
	DROP TABLE ex_dato_tramite_sit
GO

CREATE TABLE [ex_dato_tramite_sit](
	[ts_fecha] [datetime] NOT NULL,
	[ts_aplicativo] [tinyint] NOT NULL,
	[ts_tramite] [int] NOT NULL,
	[ts_estado] [char](1) NOT NULL,
	[ts_oficina] [smallint] NOT NULL,
	[ts_oficial] [smallint] NOT NULL,
	[ts_ciudad] [int] NOT NULL,
	[ts_cuota_aprox] [money] NOT NULL,
	[ts_cant_benef_seg] [int] NOT NULL,
	[ts_tipo_cuota] [catalogo] NULL,
	[ts_tipo_plazo] [catalogo] NULL,
	[ts_plazo] [smallint] NULL,
	[ts_monto] [money] NULL,
	[ts_tasa_op] [float] NULL,
	[ts_toperacion] [catalogo] NULL,
	[ts_fecha_concesion] [datetime] NULL,
	[ts_mercado_objetivo] [catalogo] NULL,
	[ts_sujcred] [catalogo] NULL,
	[ts_fecha_apr] [datetime] NULL,
	[ts_banco] [varchar](24) NULL
)
ALTER TABLE [ex_dato_tramite_sit] ADD [ts_funcionario] [varchar](20) NULL
GO

/****** Object:  Table [ex_dato_transaccion_efec]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_dato_transaccion_efec') IS NOT NULL
	DROP TABLE ex_dato_transaccion_efec
GO

CREATE TABLE [ex_dato_transaccion_efec](
	[di_fecha] [smalldatetime] NOT NULL,
	[di_aplicativo] [int] NOT NULL,
	[di_secuencial_caja] [int] NOT NULL,
	[di_banco] [varchar](24) NOT NULL,
	[di_nombre_tit] [varchar](64) NOT NULL,
	[di_doc_tipo_tit] [char](2) NOT NULL,
	[di_iden_tit] [varchar](24) NOT NULL,
	[di_cliente] [int] NOT NULL,
	[di_doc_tipo_pri_autor] [char](2) NOT NULL,
	[di_iden_pri_autor] [varchar](30) NOT NULL,
	[di_nombres_pri_autor] [varchar](64) NOT NULL,
	[di_p_apellido_pri_autor] [varchar](16) NOT NULL,
	[di_s_apellido_pri_autor] [varchar](16) NOT NULL,
	[di_doc_tipo_seg_autor] [char](2) NOT NULL,
	[di_iden_seg_autor] [varchar](30) NOT NULL,
	[di_nombres_seg_autor] [varchar](64) NULL,
	[di_p_apellido_seg_autor] [varchar](16) NULL,
	[di_s_apellido_seg_autor] [varchar](16) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_dato_transaccion_efec]
(
	[di_banco],
	[di_secuencial_caja],
	[di_fecha],
	[di_aplicativo]
)
GO


/****** Object:  Table [ex_def_variables_filtros]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_def_variables_filtros') IS NOT NULL
	DROP TABLE ex_def_variables_filtros
GO

CREATE TABLE [ex_def_variables_filtros](
	[df_fecha] [datetime] NOT NULL,
	[df_variable] [int] NULL,
	[df_descripcion] [varchar](64) NULL,
	[df_programa] [varchar](40) NULL,
	[df_tipo_var] [catalogo] NULL,
	[df_tipo_dato] [char](1) NULL,
	[df_estado] [catalogo] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_def_variables_filtros]
(
	[df_fecha]
)
GO


/****** Object:  Table [ex_desmarca_fng_his]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_desmarca_fng_his') IS NOT NULL
	DROP TABLE ex_desmarca_fng_his
GO

CREATE TABLE [ex_desmarca_fng_his](
	[df_fecha] [datetime] NULL,
	[df_aplicativo] [int] NULL,
	[df_banco] [varchar](24) NULL,
	[df_garantia] [varchar](64) NULL,
	[df_est_gar_ant] [varchar](1) NULL,
	[df_est_gar_nue] [varchar](1) NULL,
	[df_val_ant] [money] NULL,
	[df_val_nue] [money] NULL,
	[df_admisible_ant] [varchar](1) NULL,
	[df_admisible_nue] [varchar](1) NULL,
	[df_desmarca] [char](1) NULL,
	[df_marca] [char](1) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_desmarca_fng_his]
(
	[df_banco]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_desmarca_fng_his]
(
	[df_aplicativo]
)
GO


/****** Object:  Table [ex_enfermedades]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_enfermedades') IS NOT NULL
	DROP TABLE ex_enfermedades
GO

CREATE TABLE [ex_enfermedades](
	[en_fecha] [datetime] NOT NULL,
	[en_microseg] [int] NOT NULL,
	[en_asegurado] [int] NOT NULL,
	[en_enfermedad] [varchar](10) NOT NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_enfermedades]
(
	[en_fecha],
	[en_microseg]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_enfermedades]
(
	[en_microseg]
)
GO


/****** Object:  Table [ex_filtros]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_filtros') IS NOT NULL
	DROP TABLE ex_filtros
GO

CREATE TABLE [ex_filtros](
	[fi_fecha] [datetime] NOT NULL,
	[fi_filtro] [int] NULL,
	[fi_descripcion] [varchar](64) NULL,
	[fi_tipo_persona] [catalogo] NULL,
	[fi_etapa] [int] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_filtros]
(
	[fi_fecha]
)
GO


/****** Object:  Table [ex_forma_extractos]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_forma_extractos') IS NOT NULL
	DROP TABLE ex_forma_extractos
GO

CREATE TABLE [ex_forma_extractos](
	[fe_cliente] [int] NOT NULL,
	[fe_forma_entrega] [catalogo] NOT NULL,
	[fe_codigo] [int] NOT NULL,
	[fe_fecha] [datetime] NULL,
	[fe_fecha_real] [datetime] NULL,
	[fe_usuario] [varchar](25) NULL,
	[fe_oficina_marca] [int] NULL,
	[fe_terminal] [varchar](25) NULL
)
GO

/****** Object:  Index [ex_forma_extractos_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_forma_extractos_Key] ON [ex_forma_extractos]
(
	[fe_cliente]
)
GO


/****** Object:  Table [ex_impresion_cartas]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_impresion_cartas') IS NOT NULL
	DROP TABLE ex_impresion_cartas
GO

CREATE TABLE [ex_impresion_cartas](
	[ic_fecha_proceso] [datetime] NOT NULL,
	[ic_aplicativo] [varchar](2) NULL,
	[ic_no_operacion] [cuenta] NULL,
	[ic_nombre_cliente] [descripcion] NULL,
	[ic_zona] [int] NULL,
	[ic_oficina] [int] NULL,
	[ic_carta] [varchar](3) NULL,
	[ic_reimpresiones] [int] NULL,
	[ic_saldo_vencido] [money] NULL,
	[ic_saldo_capital] [money] NULL,
	[ic_saldo_total] [money] NULL,
	[ic_altura_mora] [int] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_impresion_cartas]
(
	[ic_fecha_proceso],
	[ic_no_operacion]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_impresion_cartas]
(
	[ic_no_operacion]
)
GO


/****** Object:  Table [ex_micro_seguro]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_micro_seguro') IS NOT NULL
	DROP TABLE ex_micro_seguro
GO

CREATE TABLE [ex_micro_seguro](
	[ms_fecha] [datetime] NOT NULL,
	[ms_secuencial] [int] NOT NULL,
	[ms_tramite] [int] NOT NULL,
	[ms_plazo] [smallint] NOT NULL,
	[ms_director_ofic] [smallint] NOT NULL,
	[ms_vendedor] [smallint] NOT NULL,
	[ms_estado] [varchar](10) NOT NULL,
	[ms_fecha_ini] [datetime] NULL,
	[ms_fecha_fin] [datetime] NULL,
	[ms_fecha_envio] [datetime] NULL,
	[ms_cliente_aseg] [char](1) NOT NULL,
	[ms_valor] [money] NULL,
	[ms_pagado] [char](1) NOT NULL,
	[ms_fecha_mod] [datetime] NULL,
	[ms_usuario_mod] [login] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_micro_seguro]
(
	[ms_fecha],
	[ms_tramite]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_micro_seguro]
(
	[ms_tramite]
)
GO


/****** Object:  Table [ex_msv_error]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_msv_error') IS NOT NULL
	DROP TABLE ex_msv_error
GO

CREATE TABLE [ex_msv_error](
	[me_fecha] [datetime] NULL,
	[me_aplicativo] [smallint] NULL,
	[me_fecha_crea] [datetime] NULL,
	[me_id_carga] [int] NULL,
	[me_id_alianza] [int] NULL,
	[me_referencia] [varchar](30) NULL,
	[me_tipo_proceso] [char](1) NULL,
	[me_procedimiento] [varchar](30) NULL,
	[me_codigo_interno] [int] NULL,
	[me_codigo_err] [int] NULL,
	[me_descripcion] [varchar](255) NULL
)
GO

/****** Object:  Table [ex_msv_proc_ca]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_msv_proc_ca') IS NOT NULL
	DROP TABLE ex_msv_proc_ca
GO

CREATE TABLE [ex_msv_proc_ca](
	[mp_fecha] [datetime] NULL,
	[mp_aplicativo] [smallint] NULL,
	[mp_id_carga] [int] NULL,
	[mp_id_alianza] [int] NULL,
	[mp_tipo_tr] [char](1) NULL,
	[mp_tramite] [int] NULL,
	[mp_tipo] [char](1) NULL,
	[mp_banco] [cuenta] NULL,
	[mp_estado] [char](1) NULL,
	[mp_monto] [money] NULL,
	[mp_toperacion] [catalogo] NULL,
	[mp_tasa] [float] NULL,
	[mp_descripcion] [varchar](124) NULL,
	[mp_fecha_proc] [datetime] NULL
)
GO

/****** Object:  Table [ex_msv_proc_cr]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_msv_proc_cr') IS NOT NULL
	DROP TABLE ex_msv_proc_cr
GO

CREATE TABLE [ex_msv_proc_cr](
	[mp_fecha] [datetime] NULL,
	[mp_aplicativo] [smallint] NULL,
	[mp_id_carga] [int] NULL,
	[mp_id_Alianza] [int] NULL,
	[mp_cedula] [numero] NULL,
	[mp_tipo_ced] [char](2) NULL,
	[mp_oficial] [smallint] NULL,
	[mp_tramite] [int] NULL,
	[mp_tipo] [char](1) NULL,
	[mp_estado] [char](1) NULL,
	[mp_ruta] [int] NULL,
	[mp_etapa] [int] NULL,
	[mp_estacion] [int] NULL,
	[mp_ejecutivo] [varchar](30) NULL,
	[mp_descripcion] [varchar](124) NULL,
	[mp_fecha_proc] [datetime] NULL
)
GO

/****** Object:  Table [ex_normalizacion]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_normalizacion') IS NOT NULL
	DROP TABLE ex_normalizacion
GO

CREATE TABLE [ex_normalizacion](
	[en_fecha] [datetime] NOT NULL,
	[en_aplicativo] [int] NOT NULL,
	[en_banco] [varchar](24) NOT NULL,
	[en_tramite] [int] NOT NULL,
	[en_banco_norm] [varchar](24) NOT NULL,
	[en_tramite_norm] [int] NOT NULL,
	[en_cliente] [int] NOT NULL,
	[en_tipo_norm] [int] NOT NULL
)
GO

/****** Object:  Table [ex_op_reest_padre_hija]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_op_reest_padre_hija') IS NOT NULL
	DROP TABLE ex_op_reest_padre_hija
GO

CREATE TABLE [ex_op_reest_padre_hija](
	[ph_fecha_proceso] [datetime] NOT NULL,
	[ph_aplicativo] [tinyint] NOT NULL,
	[ph_banco_padre] [cuenta] NOT NULL,
	[ph_banco_hija] [cuenta] NULL,
	[ph_ente] [int] NOT NULL,
	[ph_sec_reest] [int] NOT NULL,
	[ph_fecha] [datetime] NOT NULL
)
GO

/****** Object:  Index [ex_op_reest_padre_hija_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_op_reest_padre_hija_Key] ON [ex_op_reest_padre_hija]
(
	[ph_fecha_proceso],
	[ph_aplicativo],
	[ph_banco_padre]
)
GO


/****** Object:  Table [ex_pago_recono]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_pago_recono') IS NOT NULL
	DROP TABLE ex_pago_recono
GO

CREATE TABLE [ex_pago_recono](
	[pr_fecha_rep] [datetime] NOT NULL,
	[pr_aplicativo] [tinyint] NOT NULL,
	[pr_banco] [cuenta] NOT NULL,
	[pr_trn] [int] NOT NULL,
	[pr_fecha] [datetime] NOT NULL,
	[pr_fecha_ult_pago] [datetime] NOT NULL,
	[pr_vlr] [money] NOT NULL,
	[pr_vlr_amort] [money] NOT NULL,
	[pr_estado] [char](1) NOT NULL,
	[pr_tipo_gar] [varchar](30) NOT NULL,
	[pr_subtipo_gar] [varchar](30) NOT NULL,
	[pr_3nivel_gar] [varchar](255) NOT NULL,
	[pr_vlr_calc_fijo] [money] NOT NULL,
	[pr_div_pend] [smallint] NOT NULL,
	[pr_div_venc] [int] NULL
)
GO

/****** Object:  Index [ex_pago_recono_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ex_pago_recono_Key] ON [ex_pago_recono]
(
	[pr_fecha_rep],
	[pr_aplicativo],
	[pr_banco]
)
GO


/****** Object:  Table [ex_pasos_filtros]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_pasos_filtros') IS NOT NULL
	DROP TABLE ex_pasos_filtros
GO

CREATE TABLE [ex_pasos_filtros](
	[pf_fecha] [datetime] NOT NULL,
	[pf_ruta] [int] NULL,
	[pf_paso] [int] NULL,
	[pf_etapa] [int] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_pasos_filtros]
(
	[pf_fecha]
)
GO


/****** Object:  Table [ex_potenciales_cupo]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_potenciales_cupo') IS NOT NULL
	DROP TABLE ex_potenciales_cupo
GO

CREATE TABLE [ex_potenciales_cupo](
	[pt_fecha_proceso] [datetime] NOT NULL,
	[pt_aplicativo] [varchar](2) NULL,
	[pt_cliente] [int] NOT NULL,
	[pt_oficina] [int] NULL,
	[pt_oficial] [int] NULL,
	[pt_monto_credito] [float] NULL,
	[pt_tipo_cliente] [varchar](1) NULL,
	[pt_monto_aprobado] [float] NULL,
	[pt_monto_utilizado] [float] NULL,
	[pt_plazo] [smallint] NULL,
	[pt_cred_canc] [smallint] NULL,
	[pt_desc_oficial] [varchar](64) NULL,
	[pt_desc_oficina] [varchar](64) NULL,
	[pt_cedula] [varchar](30) NULL,
	[pt_nombre_clien] [varchar](225) NULL,
	[pt_des_actividad] [varchar](64) NULL,
	[pt_dir_nego] [varchar](255) NULL,
	[pt_tel_nego] [varchar](20) NULL,
	[pt_tel_domc] [varchar](20) NULL,
	[pt_tiene_micro] [char](1) NULL,
	[pt_saldo_vig] [money] NULL,
	[pt_dir_casa] [varchar](255) NULL,
	[pt_nota_ult_obl] [varchar](255) NULL,
	[pt_segmento] [varchar](10) NULL,
	[pt_desc_segmento] [varchar](64) NULL,
	[pt_celular] [varchar](20) NULL,
	[pt_fecha_corte] [datetime] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_potenciales_cupo]
(
	[pt_fecha_proceso],
	[pt_cliente]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_potenciales_cupo]
(
	[pt_cliente]
)
GO


/****** Object:  Table [ex_prospecto_contraoferta]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_prospecto_contraoferta') IS NOT NULL
	DROP TABLE ex_prospecto_contraoferta
GO

CREATE TABLE [ex_prospecto_contraoferta](
	[pr_cliente] [int] NULL,
	[pr_operacion] [int] NULL,
	[pr_fecha_proceso] [datetime] NULL
)
GO

/****** Object:  Index [ix_ex_prospecto_contraoferta_Key]    Script Date: 16/08/2016 19:13:35 ******/
CREATE CLUSTERED INDEX [ix_ex_prospecto_contraoferta_Key] ON [ex_prospecto_contraoferta]
(
	[pr_cliente],
	[pr_operacion],
	[pr_fecha_proceso]
)
GO


/****** Object:  Table [ex_recuperacion_castigo]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_recuperacion_castigo') IS NOT NULL
	DROP TABLE ex_recuperacion_castigo
GO

CREATE TABLE [ex_recuperacion_castigo](
	[ex_fecha_carga] [datetime] NULL,
	[ex_banco] [varchar](24) NULL,
	[ex_docid] [varchar](30) NULL,
	[ex_anio_cas] [char](4) NULL,
	[ex_saldo] [money] NULL,
	[ex_indicador_ges] [varchar](64) NULL,
	[ex_indicador_cont] [varchar](64) NULL
)
GO

/****** Object:  Table [ex_repuntuacion]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_repuntuacion') IS NOT NULL
	DROP TABLE ex_repuntuacion
GO

CREATE TABLE [ex_repuntuacion](
	[re_tramite] [int] NULL,
	[re_fecha_repuntuacion] [datetime] NULL,
	[re_tipo_proceso] [int] NULL
)
GO


/****** Object:  Table [ex_respuestas_variables_mir]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_respuestas_variables_mir') IS NOT NULL
	DROP TABLE ex_respuestas_variables_mir
GO

CREATE TABLE [ex_respuestas_variables_mir](
	[rv_fecha] [datetime] NOT NULL,
	[rv_tramite] [int] NOT NULL,
	[rv_variable] [varchar](255) NULL,
	[rv_valor] [varchar](8000) NULL,
	[rv_fecha_resp] [datetime] NULL,
	[rv_orden] [int] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_respuestas_variables_mir]
(
	[rv_fecha],
	[rv_tramite]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_respuestas_variables_mir]
(
	[rv_tramite]
)
GO


/****** Object:  Table [ex_ruta_filtros]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_ruta_filtros') IS NOT NULL
	DROP TABLE ex_ruta_filtros
GO

CREATE TABLE [ex_ruta_filtros](
	[rf_fecha] [datetime] NOT NULL,
	[rf_ruta] [int] NULL,
	[rf_descripcion] [varchar](64) NULL,
	[rf_estado] [catalogo] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_ruta_filtros]
(
	[rf_fecha]
)
GO


/****** Object:  Table [ex_seguros_estadistica]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_seguros_estadistica') IS NOT NULL
	DROP TABLE ex_seguros_estadistica
GO

CREATE TABLE [ex_seguros_estadistica](
	[se_fecha] [datetime] NULL,
	[se_tipo_seguro] [int] NULL,
	[se_tipo_seg_desc] [varchar](100) NULL,
	[se_codigo_plan] [int] NULL,
	[se_cod_plan_desc] [varchar](100) NULL,
	[se_certificado] [varchar](20) NULL,
	[se_antiguedad] [smallint] NULL,
	[se_oficina] [smallint] NULL,
	[se_zona] [smallint] NULL,
	[se_of_nombre] [varchar](64) NULL,
	[se_banco] [varchar](20) NULL,
	[se_identif_vend] [varchar](30) NULL,
	[se_codigo_vend] [smallint] NULL,
	[se_nombre_vend] [varchar](200) NULL,
	[se_fecha_venta] [datetime] NULL,
	[se_fecha_desde] [datetime] NULL,
	[se_fecha_hasta] [datetime] NULL,
	[se_identif_cli] [varchar](30) NULL,
	[se_tipo_doc_cli] [varchar](10) NULL,
	[se_nombre_cli] [varchar](200) NULL,
	[se_monto_aseg] [money] NULL,
	[se_prima_total] [money] NULL,
	[se_prima_mensual] [money] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_seguros_estadistica]
(
	[se_fecha],
	[se_banco]
)
GO


/****** Object:  Table [ex_seguros_tramite]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_seguros_tramite') IS NOT NULL
	DROP TABLE ex_seguros_tramite
GO

CREATE TABLE [ex_seguros_tramite](
	[st_fecha] [datetime] NULL,
	[st_aplicativo] [int] NULL,
	[st_secuencial_seguro] [int] NULL,
	[st_tipo_seguro] [int] NULL,
	[st_tramite] [int] NULL,
	[st_vendedor] [int] NULL,
	[st_cupo] [char](1) NULL,
	[st_origen] [varchar](20) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE UNIQUE CLUSTERED INDEX [idx1] ON [ex_seguros_tramite]
(
	[st_fecha],
	[st_aplicativo],
	[st_secuencial_seguro],
	[st_tipo_seguro],
	[st_tramite]
)
GO


/****** Object:  Table [ex_traslado]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_traslado') IS NOT NULL
	DROP TABLE ex_traslado
GO

CREATE TABLE [ex_traslado](
	[tr_fecha_corte] [datetime] NULL,
	[tr_solicitud] [int] NULL,
	[tr_ente] [int] NULL,
	[tr_tipo_traslado] [varchar](10) NULL,
	[tr_estado] [char](1) NULL,
	[tr_causa_rechazo] [char](3) NULL,
	[tr_fecha_sol] [datetime] NULL,
	[tr_ofi_solicitud] [int] NULL,
	[tr_usr_ingresa] [login] NULL,
	[tr_fecha_auto] [datetime] NULL,
	[tr_usr_autoriza] [login] NULL,
	[tr_ofi_autoriza] [int] NULL,
	[tr_oficina_dest] [int] NULL
)
GO

/****** Object:  Table [ex_traslado_detalle]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_traslado_detalle') IS NOT NULL
	DROP TABLE ex_traslado_detalle
GO

CREATE TABLE [ex_traslado_detalle](
	[td_fecha_corte] [datetime] NULL,
	[td_solicitud] [int] NULL,
	[td_producto] [int] NULL,
	[td_ofi_orig] [int] NULL,
	[td_ofi_dest] [int] NULL,
	[td_operacion] [varchar](60) NULL,
	[td_tipo_operacion] [varchar](60) NULL,
	[td_estado_ope] [char](3) NULL,
	[td_saldo_total] [money] NULL,
	[td_saldo_dispo] [money] NULL,
	[td_fecha_cons] [datetime] NULL,
	[td_fecha_ven] [datetime] NULL,
	[td_monto] [money] NULL,
	[td_intereses] [money] NULL,
	[td_encanje] [money] NULL,
	[td_estado_batch] [char](1) NULL,
	[td_fecha_tras] [datetime] NULL,
	[td_observacion] [varchar](255) NULL
)
GO

/****** Object:  Table [ex_val_oper_finagro]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_val_oper_finagro') IS NOT NULL
	DROP TABLE ex_val_oper_finagro
GO

CREATE TABLE [ex_val_oper_finagro](
	[vo_operacion] [varchar](25) NULL,
	[vo_ced_ruc] [numero] NULL,
	[vo_tipo_ruc] [char](2) NULL,
	[vo_oper_finagro] [varchar](30) NULL,
	[vo_num_gar] [varchar](30) NULL,
	[vo_fecha] [datetime] NULL,
	[vo_aplicativo] [int] NULL
)
GO

/****** Object:  Table [ex_valor_variables_filtros]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_valor_variables_filtros') IS NOT NULL
	DROP TABLE ex_valor_variables_filtros
GO

CREATE TABLE [ex_valor_variables_filtros](
	[vv_fecha] [datetime] NOT NULL,
	[vv_ruta] [int] NULL,
	[vv_etapa] [int] NULL,
	[vv_filtro] [int] NULL,
	[vv_ente] [int] NULL,
	[vv_tramite] [int] NULL,
	[vv_paso] [int] NULL,
	[vv_variable] [int] NULL,
	[vv_valor_obtenido] [varchar](64) NULL,
	[vv_valor_modificado] [varchar](64) NULL,
	[vv_fecha_ult_modif] [datetime] NULL,
	[vv_login] [login] NULL,
	[vv_dictamen] [char](1) NULL,
	[vv_dictamen_final] [char](1) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_valor_variables_filtros]
(
	[vv_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_valor_variables_filtros]
(
	[vv_tramite]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [ex_valor_variables_filtros]
(
	[vv_ente]
)
GO



/****** Object:  Table [ex_variables_entrada_mir]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_variables_entrada_mir') IS NOT NULL
	DROP TABLE ex_variables_entrada_mir
GO

CREATE TABLE [ex_variables_entrada_mir](
	[ve_fecha] [datetime] NOT NULL,
	[ve_fecha_cons] [datetime] NOT NULL,
	[ve_tramite] [int] NOT NULL,
	[ve_orden] [int] NOT NULL,
	[ve_tipo] [smallint] NULL,
	[ve_identificador] [varchar](255) NULL,
	[ve_valor] [varchar](255) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_variables_entrada_mir]
(
	[ve_fecha],
	[ve_tramite]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [ex_variables_entrada_mir]
(
	[ve_tramite]
)
GO


/****** Object:  Table [ex_variables_filtros]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_variables_filtros') IS NOT NULL
	DROP TABLE ex_variables_filtros
GO

CREATE TABLE [ex_variables_filtros](
	[vf_fecha] [datetime] NOT NULL,
	[vf_filtro] [int] NULL,
	[vf_variable] [int] NULL,
	[vf_condicion] [int] NULL,
	[vf_operador] [char](2) NULL,
	[vf_valor_referencial] [varchar](64) NULL,
	[vf_puntaje] [catalogo] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [ex_variables_filtros]
(
	[vf_fecha]
)
GO


/****** Object:  Table [ex_venta_universo]    Script Date: 16/08/2016 19:13:35 ******/
IF OBJECT_ID ('ex_venta_universo') IS NOT NULL
	DROP TABLE ex_venta_universo
GO

CREATE TABLE [ex_venta_universo](
	[vu_fecha] [datetime] NULL,
	[vu_aplicativo] [tinyint] NULL,
	[Id_cliente] [varchar](30) NULL,
	[Nombre_Cliente] [varchar](254) NULL,
	[Tipo_Identificacion] [char](2) NULL,
	[Segmento] [varchar](64) NULL,
	[Ciudad_Desembolso] [varchar](64) NULL,
	[Tipo_Producto] [char](10) NULL,
	[Saldo_capital] [money] NULL,
	[Intereses] [money] NULL,
	[Otros_cargos] [money] NULL,
	[Saldo_deuda_total] [money] NULL,
	[Saldo_Mora] [money] NULL,
	[Fecha_desembolso] [varchar](10) NULL,
	[Valor_desembolso] [money] NULL,
	[Plazo_credito] [smallint] NULL,
	[Fecha_Mora] [varchar](10) NULL,
	[Fecha_Castigo] [varchar](10) NULL,
	[Edad_Mora] [int] NULL,
	[Numero_Obli_o_Crd] [varchar](24) NULL,
	[Existencia_acuerdo_pag] [char](1) NULL,
	[Estado_Cobranza] [varchar](64) NULL,
	[Ciudad_Cred] [varchar](64) NULL,
	[Valor_pagado] [money] NULL,
	[Fecha_Ult_pago] [varchar](10) NULL,
	[Capital_Pagado] [money] NULL,
	[Intereses_pagados] [money] NULL,
	[Otros_concep_pag] [money] NULL,
	[Direccion_Cliente] [varchar](254) NULL,
	[Ciudad] [varchar](64) NULL,
	[Telefono] [varchar](26) NULL,
	[Fecha_Nacimiento] [varchar](10) NULL,
	[Ingresos] [money] NULL,
	[Egresos] [money] NULL,
	[Estrato] [varchar](10) NULL,
	[Nivel_Estudio] [varchar](64) NULL,
	[Profesion] [varchar](64) NULL,
	[Nota_Interna_Bmia] [tinyint] NULL,
	[Calificacion_Op] [char](1) NULL,
	[operacion_interna] [int] NULL,
	[Banca] [char](10) NULL,
	[Oficina] [smallint] NULL,
	[Cod_CIIU] [varchar](10) NULL,
	[Fecha_Venta] [datetime] NULL,
	[Secuencial_Ing_Ven] [int] NULL,
	[Secuencial_Ing_Vig] [int] NULL,
	[Secuencial_Ing_Nvig] [int] NULL,
	[Estado_Venta] [char](1) NULL,
	[Id_Comprador] [int] NULL,
	[Porc_Venta] [float] NULL
)
GO

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:13:35 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [ex_venta_universo]
(
	[vu_fecha],
	[vu_aplicativo],
	[operacion_interna]
)
GO
ALTER TABLE [ex_dato_encuesta_preg] ADD  DEFAULT ('V') FOR [ep_estado]
GO

USE cob_externos
GO
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ex_dato_operacion_abono')
	DROP TABLE ex_dato_operacion_abono
GO
CREATE TABLE ex_dato_operacion_abono (
doa_secuencial   INT IDENTITY ,
doa_aplicativo   SMALLINT,
doa_fecha        DATETIME,
doa_banco        VARCHAR(32),
doa_operacion    INT,
doa_sec_pag      INT,
doa_fecha_pag    DATETIME,
doa_di_fecha_ven DATETIME,
doa_dividendo    SMALLINT,
doa_dias_atraso  INT,
doa_fpago        VARCHAR(32),
doa_total        MONEY,
doa_capital      MONEY,
doa_int          MONEY,
doa_otro         MONEY,
doa_saldo_cap    MONEY,
doa_sec_ing      INT,
doa_oficina      SMALLINT,
doa_estado       VARCHAR(10),
doa_usuario      VARCHAR(20),
doa_moneda       SMALLINT,
doa_iva_int      MONEY,
doa_imo          MONEY,
doa_iva_imo      MONEY,
doa_disp         MONEY,
doa_iva_disp     MONEY,
doa_objetado     VARCHAR(10),
doa_sec_rpa      INT,
doa_tipo_trn     VARCHAR(10)

)

GO
CREATE CLUSTERED INDEX idx_1 ON ex_dato_operacion_abono (doa_operacion,doa_sec_pag)
GO
CREATE           INDEX idx_2 ON ex_dato_operacion_abono (doa_banco)
GO
CREATE           INDEX idx_3 ON ex_dato_operacion_abono (doa_aplicativo)
GO

go

if object_id ('dbo.ex_operacion') is not null
	drop table dbo.ex_operacion
go

create table dbo.ex_operacion
(  
eo_fecha                   datetime not null,
eo_operacion               int not null,
eo_banco                   cuenta not null,
eo_cliente                 int,
eo_toperacion              catalogo not null,
eo_monto                   money not null,
eo_estado                  tinyint not null,
eo_aplicativo              tinyint not null
)
go