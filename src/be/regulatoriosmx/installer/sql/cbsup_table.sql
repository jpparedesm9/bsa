use cob_conta_super
GO

if exists(select 1 from sysobjects
           where name = 'sb_estados_cuenta')
   drop table sb_estados_cuenta
go


create table sb_estados_cuenta
(
   ec_fecha                datetime,
   ec_ced_ruc              varchar(24),
   ec_banco                varchar(24), 
   ec_codigo_cliente       int,
   ec_nombres              varchar(100),
   ec_direccion            varchar(100),
   ec_fecha_prox_vto       datetime,   
   ec_pago_minimo          money,
   ec_saldo                money,
   ec_saldo_fecha          money,
   ec_clase_cartera        varchar(50),
   ec_codigo_destino       varchar(50),
   ec_monto_imp            money,
   ec_monto                money,
   ec_fecha_concesion      datetime,
   ec_plazo                int,
   ec_plazo_dias           int,
   ec_tipo_operacion       varchar(100),
   ec_fecha_vencimiento    datetime,
   ec_valor_proxima_cuota  money,
   ec_tasa                 float,
   ec_tasa_mora            float,
   ec_tasa_concep          money,
   ec_tasa_mora_concep     money,
   ec_tasa_com_concep      money,
   ec_iva_concep           money,
   ec_cat                  float,
   ec_porcentaje_cubierto  float,
   ec_saldo_cap            money,
   ec_tasa_det             money,
   ec_tasa_mora_det        money,
   ec_tasa_com_det         money,
   ec_iva_det              money,
   ec_monto_pagado         money,
   ec_fecha_pago           datetime,
   ec_capital              money,
   ec_int_ord              money,
   ec_int_mor              money,
   ec_iva_pag              money
)


if exists(select 1 from sysobjects
           where name = 'sb_dato_calificacion')
   drop table sb_dato_calificacion
go

create table sb_dato_calificacion
(
   dc_fecha           smalldatetime   not null,
   dc_aplicativo      tinyint         not null,
   dc_banco           varchar(24)     not null,
   dc_cliente         int             not null,
   dc_clase_cartera   catalogo        not null,
   dc_tip_calif       catalogo        not null,
   dc_calificacion    catalogo        not null,
   dc_usuario         login           not null,
   dc_fecha_ing       datetime        not null
)

create unique nonclustered index idx1 
    on sb_dato_calificacion(dc_cliente,dc_aplicativo,dc_tip_calif,dc_banco,dc_fecha)

create nonclustered index idx2
    on sb_dato_calificacion(dc_fecha,dc_aplicativo)
go


/**************************************************************/
/* Creacion de tabla sb_reporte_r0451 para reportes 		  */
/**************************************************************/
IF OBJECT_ID ('sb_reporte_r0451') IS NOT NULL
	DROP TABLE sb_reporte_r0451
GO

CREATE TABLE sb_reporte_r0451
	(
	PERIODO 				VARCHAR (6)     NULL,
	CLAVE_ENTIDAD			NUMERIC (6)     NULL,
	SUBREPORTE				NUMERIC (4)     NULL,
	MUNICIPIO				VARCHAR (6)     NULL,
	ESTADO					VARCHAR (3)     NULL,
	IDENTIFICADOR_ACRED		VARCHAR (20)    NULL,
	PERSONA_JURID			NUMERIC (1)     NULL,
	NOM_RAZ_SOCIAL			VARCHAR (200)   NULL,
	APELLIDO_PATERNO		VARCHAR (200)   NULL,
	APELLIDO_MATERNO		VARCHAR (200)   NULL,
	RFC_SOCIO				VARCHAR (13)    NULL,
	CURP_SOCIO				VARCHAR (18)    NULL,
	GENERO					NUMERIC (1)     NULL,
	OPE_BANCO				VARCHAR (20)    NULL,
	OFICINA					VARCHAR (200)   NULL,
	CLASIF_CRED				NUMERIC (12)    NULL,
	PRODUCT_CREDIT			VARCHAR (200)   NULL,
	FECHA_CONSE				VARCHAR (8)     NULL,
	FECHA_VENCIMIENTO		VARCHAR (8)     NULL,
	TIPO_MODALIDAD			VARCHAR (1)     NULL,
	MONTO					NUMERIC (16)    NULL,
	FREC_PAGOS_CAPITAL		NUMERIC (4)     NULL,
	FREC_PAGOS_INT			NUMERIC (4)     NULL,
	TASA					NUMERIC (7)     NULL,
	FECHA_ULT_PAGO_CAP		VARCHAR (8)     NULL,
	VALOR_ULT_PAGO_CAP		NUMERIC (16)    NULL,
	FECHA_ULT_PAGO_INT		VARCHAR (8)     NULL,
	VALOR_ULT_PAGO_INT		NUMERIC (16)    NULL,
	FEC_PRI_AMORT_NO_CUBI	VARCHAR (8)     NULL,
	MONTO_CONDO				NUMERIC (16)    NULL,
	FECHA_CONDO				VARCHAR (8)     NULL,
	DIAS_MORA				NUMERIC (6)     NULL,
	TIPO_CRED				NUMERIC (2)     NULL,
	SITUA_CONTABLE			NUMERIC (2)     NULL,
	SALDO_CAPITAL			NUMERIC (16)    NULL,
	SALDO_INTERES			NUMERIC (16)    NULL,
	INTERES_MORA			NUMERIC (16)    NULL,
	INTE_ORDIN_VENC			NUMERIC (16)    NULL,
    INTE_MORA_FUE_BALANCE   NUMERIC (16)    NULL,
	INTE_REFINAN			NUMERIC (16)    NULL,
	SALDO_INSOLUTO		    NUMERIC (16)    NULL,
	TIPO_ACRED_REL			NUMERIC (2)     NULL,
	TIPO_CCA_CALIFICA		NUMERIC (2)     NULL,
	CALIFICA_DEUDOR			VARCHAR (2)     NULL,
	CALIFICA_CUBIERTA		VARCHAR (2)     NULL,
	CALIFICA_EXPUESTA		VARCHAR (2)     NULL,
	MONTO_CUBIERTA			NUMERIC (16)    NULL,
	MONTO_EXPUESTA			NUMERIC (16)    NULL,
	ESTIMA_PREVENT_INT		NUMERIC (16)    NULL,
	ESTIMA_PREVENT_RIESG	NUMERIC (16)    NULL,
	ESTIMA_PREVENT_ORDE		NUMERIC (16)    NULL,
	FECHA_SIC				VARCHAR (8)     NULL,
	CLAVE_PREVEN			NUMERIC (4)     NULL,
	GARANTIA_LIQUIDA		NUMERIC (16)    NULL,
	GARANTIA_HIPOTECARIA	NUMERIC (16)    NULL
	)
GO

CREATE CLUSTERED INDEX sb_reporte_r0451_key
	ON sb_reporte_r0451 (PERIODO, CLAVE_ENTIDAD, SUBREPORTE, OPE_BANCO)
GO

/**************************************************************/
/* Creacion de tabla sb_reporte_r0453 para reportes 		  */
/**************************************************************/
IF OBJECT_ID ('sb_reporte_r0453') IS NOT NULL
	DROP TABLE sb_reporte_r0453
GO

CREATE TABLE sb_reporte_r0453
	(
	PERIODO					VARCHAR (6)     NULL,
	CLAVE_ENTIDAD			NUMERIC (6)     NULL,
	SUBREPORTE				NUMERIC (4)     NULL,
	IDENTIFICADOR_ACRED		VARCHAR (20)    NULL,
	PERSONA_JURID			VARCHAR (1)     NULL,
	NOM_RAZ_SOCIAL			VARCHAR (200)   NULL,
	APELLIDO_PATERNO		VARCHAR (200)   NULL,
	APELLIDO_MATERNO		VARCHAR (200)   NULL,
	RFC_SOCIO				VARCHAR (13)    NULL,
	CURP_SOCIO				VARCHAR (18)    NULL,
	GENERO					NUMERIC (1)     NULL,
	OPE_BANCO				VARCHAR (20)    NULL,
	OFICINA					VARCHAR (200)   NULL,
	CLASIF_CRED				NUMERIC (12)    NULL,
	PRODUCT_CREDIT			VARCHAR (200)   NULL,
	FECHA_CONSE				VARCHAR (8)     NULL,
	FECHA_VENCIMIENTO		VARCHAR (8)     NULL,
	TIPO_MODALIDAD			VARCHAR (1)     NULL,
	MONTO					NUMERIC (16)    NULL,
	FECHA_ULT_PAGO_CAP		VARCHAR (8)     NULL,
	VALOR_ULT_PAGO_CAP		NUMERIC (16)    NULL,
	FECHA_ULT_PAGO_INT		VARCHAR (8)     NULL,
	VALOR_ULT_PAGO_INT		NUMERIC (16)    NULL,
	FEC_PRI_AMORT_NO_CUBI	VARCHAR (8)     NULL,
	DIAS_MORA				NUMERIC (6)     NULL,
	TIPO_CRED				NUMERIC (2)     NULL,
	SALDO_CAPITAL			NUMERIC (16)    NULL,
	SALDO_INTERES			NUMERIC (16)    NULL,
	INTERES_MORA			NUMERIC (16)    NULL,
	INTE_REFINAN			NUMERIC (16)    NULL,
	MONTO_CASTIGO			NUMERIC (16)    NULL,
	MONTO_CONDO				NUMERIC (16)    NULL,
	MONTO_BONI				NUMERIC (16)    NULL,
	FECHA_CASTIGO			VARCHAR (8)     NULL,
	TIPO_ACRED_REL			NUMERIC (2)     NULL,
	ESTIMA_PREVENT_TOTAL	NUMERIC (16)    NULL,
	CLAVE_PREVEN			NUMERIC (4)     NULL,
	FECHA_SIC				VARCHAR (8)     NULL,
	TIPO_COBRANZA			VARCHAR (1)     NULL,
	GARANTIA_LIQUIDA		NUMERIC (16)    NULL,
	GARANTIA_HIPOTECARIA	NUMERIC (16)    NULL
	)
GO

CREATE CLUSTERED INDEX sb_reporte_r0453_key
	ON sb_reporte_r0453 (PERIODO, CLAVE_ENTIDAD, SUBREPORTE, OPE_BANCO)
GO


/**************************************************************/
/* Creacion de tabla sb_dato_custodia 		                  */
/**************************************************************/
if object_id ('dbo.sb_dato_custodia') is not null
	drop table dbo.sb_dato_custodia
go

create table dbo.sb_dato_custodia
	(
	dc_fecha                smalldatetime not null,
	dc_aplicativo           tinyint not null,
	dc_garantia             varchar (64) null,
	dc_oficina              int null,
	dc_cliente              int null,
	dc_categoria            varchar (1) null,
	dc_tipo                 varchar (14) null,
	dc_idonea               varchar (1) null,
	dc_fecha_avaluo         datetime null,
	dc_moneda               int null,
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
	on dbo.sb_dato_custodia (dc_fecha,dc_garantia,dc_aplicativo)
go



/**************************************************************/
/* Creacion de tabla sb_dato_garantia 		                  */
/**************************************************************/
IF OBJECT_ID ('sb_dato_garantia') IS NOT NULL
	DROP TABLE sb_dato_garantia
GO

CREATE TABLE sb_dato_garantia
(
   dg_fecha           smalldatetime   not null,
   dg_banco           varchar(24)     not null,
   dg_toperacion      varchar(10)     not null,
   dg_aplicativo      tinyint         not null,
   dg_garantia        varchar(64)     not null,
   dg_cobertura       money           not null,
   dg_cobertura_cap   money           null,
   dg_cobertura_int   money           null
)

CREATE UNIQUE NONCLUSTERED INDEX idx1
   ON sb_dato_garantia(dg_banco,dg_garantia,dg_fecha,dg_aplicativo)

CREATE NONCLUSTERED INDEX idx2
    ON sb_dato_garantia(dg_garantia,dg_fecha,dg_aplicativo)

CREATE NONCLUSTERED INDEX idx3
    ON sb_dato_garantia(dg_fecha,dg_aplicativo)
GO


/**************************************************************/
/* Creacion de tabla sb_dato_hechos_violentos 		          */
/**************************************************************/
IF OBJECT_ID ('sb_dato_hechos_violentos') IS NOT NULL
	DROP TABLE sb_dato_hechos_violentos
GO

CREATE TABLE sb_dato_hechos_violentos
(
   dh_fecha                smalldatetime   not null,
   dh_cliente              int             not null,
   dh_tramite              int             not null,
   dh_fecha_radicacion     smalldatetime   not null,
   dh_toperacion           catalogo        not null,
   dh_rechazado            char(1)         not null,
   dh_causa_rechazo        varchar(255)    null,
   dh_evento               varchar(10)     not null,
   dh_fecha_evento         smalldatetime   not null,
   dh_ciudad_evento        varchar(164)    not null,
   dh_municipio_evento     varchar(164)    not null,
   dh_corregimiento_evento varchar(164)    not null,
   dh_inspeccion           varchar(164)    not null,
   dh_vereda               varchar(164)    not null,
   dh_sitio                varchar(164)    not null,
   dh_destino              catalogo        null
)

CREATE UNIQUE NONCLUSTERED INDEX idx1
    ON sb_dato_hechos_violentos(dh_cliente,dh_tramite,dh_fecha)

CREATE NONCLUSTERED INDEX idx2
    ON sb_dato_hechos_violentos(dh_fecha)
GO


/**************************************************************/
/* Creacion de tabla sb_datos_tarifas 		                  */
/**************************************************************/
IF OBJECT_ID ('sb_datos_tarifas') IS NOT NULL
	DROP TABLE sb_datos_tarifas
GO

CREATE TABLE sb_datos_tarifas
(
   dt_fecha        datetime      not null,
   dt_aplicativo   tinyint       not null,
   dt_nemonico     varchar(10)   not null,
   dt_campo1       varchar(10)   null,
   dt_campo2       varchar(10)   null,
   dt_campo3       varchar(10)   null,
   dt_campo4       varchar(10)   null,
   dt_campo5       varchar(10)   null,
   dt_campo6       varchar(10)   null,
   dt_campo7       varchar(10)   null,
   dt_campo8       varchar(10)   null,
   dt_campo9       varchar(10)   null,
   dt_campo10      varchar(10)   null,
   dt_base_calculo varchar(65)   not null,
   dt_valor        varchar(65)   null,
   dt_estado       char(1)       null
)


/**************************************************************/
/* Creacion de tabla sb_param_tarifas 		                  */
/**************************************************************/
IF OBJECT_ID ('sb_param_tarifas') IS NOT NULL
	DROP TABLE sb_param_tarifas
GO

CREATE TABLE sb_param_tarifas
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

CREATE NONCLUSTERED INDEX idx1
    ON sb_datos_tarifas(dt_nemonico,dt_aplicativo,dt_fecha
)

CREATE NONCLUSTERED INDEX idx2
    ON sb_datos_tarifas(dt_fecha,dt_aplicativo)

CREATE UNIQUE NONCLUSTERED INDEX idx1
    ON sb_param_tarifas(pt_nemonico,pt_aplicativo,pt_fecha)

CREATE NONCLUSTERED INDEX idx2
    ON sb_param_tarifas(pt_fecha,pt_aplicativo)
GO

/**************************************************************/
/* Creacion de tabla sb_rep_conta_gar para generar reporte    */
/**************************************************************/
if exists(select 1 from sysobjects
           where name = 'sb_rep_conta_gar')
   drop table sb_rep_conta_gar
go

create table sb_rep_conta_gar
(
   cg_categoria         char(24) null,
   cg_tipo              char(24) null,
   cg_calidad_gar       char(24) null,
   cg_garantia          char(24) null,
   cg_valor_comerc      char(24) null,
   cg_valor_util        char(24) null,
   cg_valor_uti_opera   char(24) null,
   cg_saldo_disp_cobe   char(24) null
)
go

/**************************************************************/
/* DISTRIBUCION DE GARANTIAS (MX)                             */
/**************************************************************/

if exists (select 1 from sysobjects where name = 'sb_distgar_op_tmp')
   drop table sb_distgar_op_tmp
go

create table sb_distgar_op_tmp
(
   do_banco         varchar(24)   not null,
   do_saldo_cap     money         not null,
   do_saldo_int     money         not null,
   do_dias_mora     int           not null,
   do_cap_liq       money         not null,
   do_cap_hip       money         not null,
   do_cap_des       money         not null,
   do_int_liq       money         not null,
   do_int_hip       money         not null,
   do_int_des       money         not null,
)
go


if exists (select 1 from sysobjects where name = 'sb_distgar_cu_tmp')
   drop table sb_distgar_cu_tmp
go

create table sb_distgar_cu_tmp
(
   dc_garantia         varchar(64)   not null,
   dc_tipo_gar         varchar(14)   not null,
   dc_val_cobertura    money         not null,
   dc_val_utilizado    money         not null,
   dc_val_disponible   money         not null,
   dc_orden            int           not null
)
go


if exists (select 1 from sysobjects where name = 'sb_distgar_ga_tmp')
   drop table sb_distgar_ga_tmp
go

create table sb_distgar_ga_tmp
(
   dg_garantia        varchar(64)   not null,
   dg_banco           varchar(24)   not null,
   dg_cobertura_cap   money         not null,
   dg_cobertura_int   money         not null,
   dg_dias_vcto       int           not null
)
go


IF OBJECT_ID ('sb_calendario_proyec') IS NOT NULL
	DROP TABLE sb_calendario_proyec
GO

CREATE TABLE [sb_calendario_proyec]
(
	[cp_fecha_proc] [datetime] NOT NULL,
	[cp_tipo_info] [varchar](10) NOT NULL,
	[cp_fecha_ing] [datetime] NOT NULL
)

CREATE NONCLUSTERED INDEX [idx1] ON [sb_calendario_proyec]
(
	[cp_fecha_proc]
)
GO


IF OBJECT_ID ('sb_bloqueo_operaciones') IS NOT NULL
	DROP TABLE sb_bloqueo_operaciones
GO

CREATE TABLE [sb_bloqueo_operaciones](
	[bo_fecha] [datetime] NOT NULL,
	[bo_banco] [varchar](24) NOT NULL,
	[bo_aplicativo] [tinyint] NOT NULL,
	[bo_secuencial] [int] NOT NULL,
	[bo_causa_bloqueo] [varchar](10) NOT NULL,
	[bo_fecha_bloqueo] [datetime] NOT NULL,
	[bo_fecha_modif] [datetime] NULL,
	[bo_fecha_desbloqueo] [datetime] NULL,
	[bo_estado] [char](1) NOT NULL
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_bloqueo_operaciones]
(
	[bo_secuencial],
	[bo_causa_bloqueo],
	[bo_banco],
	[bo_aplicativo],
	[bo_fecha]
)
GO
CREATE NONCLUSTERED INDEX [idx2] ON [sb_bloqueo_operaciones]
(
	[bo_fecha],
	[bo_banco],
	[bo_aplicativo]
)
GO



IF OBJECT_ID ('sb_ctas_ingresadas') IS NOT NULL
	DROP TABLE sb_ctas_ingresadas
GO

CREATE TABLE [sb_ctas_ingresadas](
	[ci_fecha] [datetime] NOT NULL,
	[ci_cuenta] [varchar](24) NOT NULL,
	[ci_aplicativo] [tinyint] NOT NULL,
	[ci_cliente] [int] NOT NULL,
	[ci_cat_producto] [varchar](10) NOT NULL,
	[ci_fecha_apertura] [datetime] NOT NULL,
	[ci_oficina] [smallint] NOT NULL,
	[ci_estado] [char](1) NOT NULL
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [sb_ctas_ingresadas_Key] ON [sb_ctas_ingresadas]
(
	[ci_fecha],
	[ci_aplicativo]
)
GO



IF OBJECT_ID ('sb_tran_mensual') IS NOT NULL
	DROP TABLE sb_tran_mensual
GO

CREATE TABLE [sb_tran_mensual](
	[tm_ano] [char](4) NOT NULL,
	[tm_mes] [char](2) NOT NULL,
	[tm_cuenta] [varchar](24) NOT NULL,
	[tm_cod_trn] [int] NOT NULL,
	[tm_cantidad] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_tran_mensual]
(
	[tm_ano],
	[tm_mes],
	[tm_cuenta],
	[tm_cod_trn]
)
GO



IF OBJECT_ID ('sb_tran_rechazos') IS NOT NULL
	DROP TABLE sb_tran_rechazos
GO

CREATE TABLE [sb_tran_rechazos](
	[tr_fecha] [datetime] NULL,
	[tr_oficina] [smallint] NULL,
	[tr_cod_cliente] [int] NULL,
	[tr_id_cliente] [varchar](30) NULL,
	[tr_nom_cliente] [varchar](255) NULL,
	[tr_cta_banco] [varchar](24) NULL,
	[tr_tipo_tran] [int] NULL,
	[tr_nom_tran] [varchar](64) NULL,
	[tr_vlr_comision] [money] NULL,
	[tr_vlr_iva] [money] NULL,
	[tr_modulo] [char](3) NULL,
	[tr_causal_rech] [int] NULL
)
GO

CREATE NONCLUSTERED INDEX [idx1] ON [sb_tran_rechazos]
(
	[tr_fecha],
	[tr_cod_cliente]
)
GO


IF OBJECT_ID ('sb_dato_pasivas') IS NOT NULL
	DROP TABLE sb_dato_pasivas
GO

CREATE TABLE [sb_dato_pasivas](
	[dp_fecha] [datetime] NOT NULL,
	[dp_banco] [varchar](24) NOT NULL,
	[dp_toperacion] [varchar](10) NOT NULL,
	[dp_aplicativo] [tinyint] NOT NULL,
	[dp_categoria_producto] [varchar](10) NOT NULL,
	[dp_naturaleza_cliente] [char](1) NOT NULL,
	[dp_cliente] [int] NOT NULL,
	[dp_oficina] [smallint] NOT NULL,
	[dp_oficial] [smallint] NOT NULL,
	[dp_moneda] [tinyint] NOT NULL,
	[dp_monto] [money] NOT NULL,
	[dp_tasa] [float] NULL,
	[dp_modalidad] [char](1) NULL,
	[dp_plazo_dias] [int] NULL,
	[dp_fecha_apertura] [datetime] NOT NULL,
	[dp_fecha_radicacion] [datetime] NOT NULL,
	[dp_fecha_vencimiento] [datetime] NULL,
	[dp_num_renovaciones] [int] NULL,
	[dp_estado] [tinyint] NOT NULL,
	[dp_razon_cancelacion] [varchar](10) NULL,
	[dp_num_cuotas] [smallint] NOT NULL,
	[dp_periodicidad_cuota] [smallint] NOT NULL,
	[dp_saldo_disponible] [money] NOT NULL,
	[dp_saldo_int] [money] NOT NULL,
	[dp_saldo_camara12h] [money] NOT NULL,
	[dp_saldo_camara24h] [money] NOT NULL,
	[dp_saldo_camara48h] [money] NOT NULL,
	[dp_saldo_remesas] [money] NOT NULL,
	[dp_condicion_manejo] [char](1) NULL,
	[dp_exen_gmf] [char](1) NULL,
	[dp_fecha_ini_exen_gmf] [datetime] NULL,
	[dp_fecha_fin_exen_gmf] [datetime] NULL,
	[dp_tesoro_nacional] [char](1) NULL,
	[dp_ley_exen] [varchar](10) NULL,
	[dp_tasa_variable] [char](1) NULL,
	[dp_referencial_tasa] [catalogo] NULL,
	[dp_signo_spread] [char](1) NULL,
	[dp_spread] [float] NULL,
	[dp_signo_puntos] [char](1) NULL,
	[dp_puntos] [float] NULL,
	[dp_signo_tasa_ref] [char](1) NULL,
	[dp_puntos_tasa_ref] [float] NULL,
	[dp_origen] [char](3) NULL,
	[dp_provisiona] [char](1) NULL,
	[dp_blqpignoracion] [char](1) NULL)
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_pasivas]
(
	[dp_banco],
	[dp_aplicativo],
	[dp_fecha]
)
GO
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_pasivas]
(
	[dp_cliente]
)
GO
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_pasivas]
(
	[dp_fecha],
	[dp_aplicativo],
	[dp_oficina]
)
GO


IF OBJECT_ID ('sb_carga_archivo_cuentas') IS NOT NULL
	DROP TABLE sb_carga_archivo_cuentas
GO

CREATE TABLE [sb_carga_archivo_cuentas](
	[ca_tipo_reg] [char](2) NULL,
	[ca_secuencia] [int] NULL,
	[ca_tipo_carga] [char](1) NULL,
	[ca_tipo_ced] [char](2) NULL,
	[ca_ced_ruc] [bigint] NULL,
	[ca_nomb_arch] [varchar](60) NULL,
	[ca_ente] [int] NULL,
	[ca_cta_banco] [char](16) NULL,
	[ca_tipo_prod] [tinyint] NULL,
	[ca_fecha_reg] [datetime] NULL,
	[ca_cant_reg] [int] NULL,
	[ca_valor] [money] NULL,
	[ca_tipo_mov] [char](1) NULL,
	[ca_causal] [char](3) NULL,
	[ca_fecha_proc] [datetime] NULL,
	[ca_tipo_oper] [char](1) NULL,
	[ca_estado] [char](1) NULL,
	[ca_error] [varchar](250) NULL
)
GO

IF OBJECT_ID ('sb_equivalencias') IS NOT NULL
	DROP TABLE sb_equivalencias
GO

CREATE TABLE sb_equivalencias
	(
	eq_catalogo    catalogo NOT NULL,
	eq_valor_cat   descripcion NOT NULL,
	eq_valor_arch  descripcion NOT NULL,
	eq_descripcion descripcion NOT NULL,
	eq_estado      estado NOT NULL
	)
GO

CREATE CLUSTERED INDEX [sb_equivalencias_Key] ON [dbo].[sb_equivalencias]
(
	[eq_catalogo] ASC,
	[eq_valor_cat] ASC,
	[eq_estado] ASC
)
GO


IF OBJECT_ID ('sb_relacion_canal') IS NOT NULL
	DROP TABLE sb_relacion_canal
GO

CREATE TABLE [sb_relacion_canal](
	[rc_cuenta] [char](16) NULL,
	[rc_cliente] [int] NULL,
	[rc_tel_celular] [varchar](15) NULL,
	[rc_tarj_debito] [varchar](20) NULL,
	[rc_canal] [varchar](6) NULL,
	[rc_motivo] [varchar](50) NULL,
	[rc_estado] [char](1) NULL,
	[rc_fecha] [datetime] NULL,
	[rc_fecha_mod] [datetime] NULL,
	[rc_usuario] [varchar](14) NULL,
	[rc_subtipo] [char](3) NULL,
	[rc_tipo_operador] [varchar](10) NULL,
	[rc_aplicativo] [int] NULL,
	[rc_fecha_proceso] [datetime] NULL,
	[rc_oficina] [int] NULL
)
GO

CREATE NONCLUSTERED INDEX [i_idx_sb_relacion_canal] ON [sb_relacion_canal]
(
	[rc_cuenta],
	[rc_canal],
	[rc_aplicativo],
	[rc_fecha_proceso],
	[rc_tel_celular],
	[rc_tarj_debito],
	[rc_tipo_operador],
	[rc_estado]
)
GO


/****** Object:  Table [sb_abonos_referidos]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_abonos_referidos') IS NOT NULL
	DROP TABLE sb_abonos_referidos
GO
CREATE TABLE [sb_abonos_referidos](
	[sar_cuenta] [varchar](24) NULL,
	[sar_tipo_id] [varchar](2) NULL,
	[sar_numero_id] [varchar](20) NULL,
	[sar_causa] [varchar](4) NULL,
	[sar_valor_ref] [money] NULL,
	[sar_fecha_ref] [datetime] NULL,
	[sar_cod_aut_ref] [varchar](20) NULL,
	[sar_estado] [varchar](20) NULL,
	[sar_cod_aut_cobis] [varchar](10) NULL,
	[sar_fecha_cobis] [datetime] NULL,
	[sar_valor_cobis] [money] NULL,
	[sar_fecha_corte] [datetime] NULL,
	[sar_referencia] [varchar](36) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_abonos_referidos]
(
	[sar_fecha_corte]
)
GO


/****** Object:  Table [sb_alianza]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_alianza') IS NOT NULL
	DROP TABLE sb_alianza
GO
CREATE TABLE [sb_alianza](
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

/****** Object:  Table [sb_alianza_banco]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_alianza_banco') IS NOT NULL
	DROP TABLE sb_alianza_banco
GO
CREATE TABLE [sb_alianza_banco](
	[ab_fecha] [datetime] NULL,
	[ab_aplicativo] [smallint] NULL,
	[ab_alianza] [int] NULL,
	[ab_banco] [catalogo] NULL,
	[ab_cuenta] [char](1) NULL,
	[ab_estado] [char](1) NULL
)

GO

/****** Object:  Table [sb_alianza_cliente]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_alianza_cliente') IS NOT NULL
	DROP TABLE sb_alianza_cliente
GO
CREATE TABLE [sb_alianza_cliente](
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

/****** Object:  Table [sb_alianza_linea]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_alianza_linea') IS NOT NULL
	DROP TABLE sb_alianza_linea
GO
CREATE TABLE [sb_alianza_linea](
	[al_fecha] [datetime] NULL,
	[al_aplicativo] [smallint] NULL,
	[al_alianza] [int] NULL,
	[al_linea] [catalogo] NULL
)

GO

/****** Object:  Table [sb_aseg_microseguro]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_aseg_microseguro') IS NOT NULL
	DROP TABLE sb_aseg_microseguro
GO
CREATE TABLE [sb_aseg_microseguro](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_aseg_microseguro]
(
	[am_fecha],
	[am_microseg]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_aseg_microseguro]
(
	[am_microseg]
)
GO


/****** Object:  Table [sb_asegurados]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_asegurados') IS NOT NULL
	DROP TABLE sb_asegurados
GO
CREATE TABLE [sb_asegurados](
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

/****** Object:  Table [sb_asegurados_estadistica]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_asegurados_estadistica') IS NOT NULL
	DROP TABLE sb_asegurados_estadistica
GO
CREATE TABLE [sb_asegurados_estadistica](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_asegurados_estadistica]
(
	[ae_fecha],
	[ae_certificado]
)
GO


/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE CLUSTERED INDEX [idx1] ON [sb_asegurados]
(
	[as_fecha],
	[as_aplicativo],
	[as_secuencial_seguro],
	[as_sec_asegurado]
)
GO


/****** Object:  Table [sb_benefic_micro_aseg]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_benefic_micro_aseg') IS NOT NULL
	DROP TABLE sb_benefic_micro_aseg
GO
CREATE TABLE [sb_benefic_micro_aseg](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_benefic_micro_aseg]
(
	[bm_fecha],
	[bm_microseg]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_benefic_micro_aseg]
(
	[bm_microseg]
)
GO


/****** Object:  Table [sb_beneficiarios]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_beneficiarios') IS NOT NULL
	DROP TABLE sb_beneficiarios
GO
CREATE TABLE [sb_beneficiarios](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE CLUSTERED INDEX [idx1] ON [sb_beneficiarios]
(
	[be_fecha],
	[be_aplicativo],
	[be_secuencial_seguro],
	[be_sec_asegurado],
	[be_sec_benefic]
)
GO


/****** Object:  Table [sb_calificacion_orig]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_calificacion_orig') IS NOT NULL
	DROP TABLE sb_calificacion_orig
GO
CREATE TABLE [sb_calificacion_orig](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_calificacion_orig]
(
	[cm_fecha],
	[cm_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_calificacion_orig]
(
	[cm_tramite]
)
GO


/****** Object:  Table [sb_cartera_trasladada_canc]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_cartera_trasladada_canc') IS NOT NULL
	DROP TABLE sb_cartera_trasladada_canc
GO
CREATE TABLE [sb_cartera_trasladada_canc](
	[ct_fecha] [smalldatetime] NOT NULL,
	[ct_aplicativo] [int] NOT NULL,
	[ct_nro_tramite] [int] NULL,
	[ct_cod_operacion] [varchar](30) NULL,
	[ct_eje_origen] [varchar](30) NULL,
	[ct_ofc_origen] [smallint] NULL,
	[ct_eje_destino] [smallint] NULL,
	[ct_ofc_destino] [smallint] NULL,
	[ct_cod_cliente] [int] NULL,
	[ct_fec_cancelacion] [datetime] NULL,
	[ct_nota_del_credito] [tinyint] NULL
)
GO

/****** Object:  Index [sb_trasladada_canc_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_trasladada_canc_Key] ON [sb_cartera_trasladada_canc]
(
	[ct_fecha],
	[ct_aplicativo],
	[ct_nro_tramite]
)
GO


/****** Object:  Table [sb_condonacion]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_condonacion') IS NOT NULL
	DROP TABLE sb_condonacion
GO
CREATE TABLE [sb_condonacion](
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

/****** Object:  Index [sb_condonacion_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [sb_condonacion_Key] ON [sb_condonacion]
(
	[co_fecha],
	[co_aplicativo],
	[co_banco]
)
GO


/****** Object:  Table [sb_dato_acciones_cobranza]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_acciones_cobranza') IS NOT NULL
	DROP TABLE sb_dato_acciones_cobranza
GO
CREATE TABLE [sb_dato_acciones_cobranza](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_dato_acciones_cobranza]
(
	[ac_fecha],
	[ac_aplicativo],
	[ac_taccion]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_acciones_cobranza]
(
	[ac_banco]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_acciones_cobranza]
(
	[ac_cliente]
)
GO
/****** Object:  Index [idx4]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx4] ON [sb_dato_acciones_cobranza]
(
	[ac_abogado]
)
GO


/****** Object:  Table [sb_dato_bal_fnciero]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_bal_fnciero') IS NOT NULL
	DROP TABLE sb_dato_bal_fnciero
GO
CREATE TABLE [sb_dato_bal_fnciero](
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

/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_bal_fnciero]
(
	[bf_fecha],
	[bf_aplicativo]
)
GO


/****** Object:  Table [sb_dato_bal_fnciero_det]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_bal_fnciero_det') IS NOT NULL
	DROP TABLE sb_dato_bal_fnciero_det
GO
CREATE TABLE [sb_dato_bal_fnciero_det](
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

/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_bal_fnciero_det]
(
	[bd_fecha],
	[bd_aplicativo]
)
GO


/****** Object:  Table [sb_dato_bal_resultado]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_bal_resultado') IS NOT NULL
	DROP TABLE sb_dato_bal_resultado
GO
CREATE TABLE [sb_dato_bal_resultado](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_bal_resultado]
(
	[br_tramite],
	[br_id_microempresa],
	[br_microempresa],
	[br_secuencial],
	[br_tipo_costo],
	[br_aplicativo],
	[br_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_bal_resultado]
(
	[br_id_microempresa]
)
GO
/****** Object:  Index [idx4]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx4] ON [sb_dato_bal_resultado]
(
	[br_fecha],
	[br_aplicativo]
)
GO


/****** Object:  Table [sb_dato_castigos]    Script Date: 16/08/2016 19:00:16 ******/
SET ANSI_PADDING ON
GO
IF OBJECT_ID ('sb_dato_castigos') IS NOT NULL
	DROP TABLE sb_dato_castigos
GO
CREATE TABLE [sb_dato_castigos](
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

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [sb_dato_castigos]
(
	[dt_fecha],
	[dt_banco],
	[dt_secuencial]
)
GO


/****** Object:  Table [sb_dato_castigos_det]    Script Date: 16/08/2016 19:00:16 ******/
SET ANSI_PADDING ON
GO
IF OBJECT_ID ('sb_dato_castigos_det') IS NOT NULL
	DROP TABLE sb_dato_castigos_det
GO
CREATE TABLE [sb_dato_castigos_det](
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

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [sb_dato_castigos_det]
(
	[dd_fecha],
	[dd_banco],
	[dd_secuencial]
)
GO


/****** Object:  Table [sb_dato_causa_rechazo]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_causa_rechazo') IS NOT NULL
	DROP TABLE sb_dato_causa_rechazo
GO
CREATE TABLE [sb_dato_causa_rechazo](
	[cr_fecha] [datetime] NOT NULL,
	[cr_aplicativo] [tinyint] NOT NULL,
	[cr_tramite] [int] NOT NULL,
	[cr_causal] [varchar](10) NOT NULL,
	[cr_tipo] [varchar](10) NOT NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_dato_causa_rechazo]
(
	[cr_tramite],
	[cr_aplicativo],
	[cr_fecha],
	[cr_causal]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_causa_rechazo]
(
	[cr_fecha],
	[cr_aplicativo]
)
GO


/****** Object:  Table [sb_dato_central_cliente]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_central_cliente') IS NOT NULL
	DROP TABLE sb_dato_central_cliente
GO
CREATE TABLE [sb_dato_central_cliente](
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

/****** Object:  Index [sb_dato_central_cliente_key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [sb_dato_central_cliente_key] ON [sb_dato_central_cliente]
(
	[dcc_fecha_proceso],
	[dcc_aplicativo],
	[dcc_orden_consulta]
)
GO
/****** Object:  Index [sb_dato_central_cliente_key2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_dato_central_cliente_key2] ON [sb_dato_central_cliente]
(
	[dcc_tipo_id],
	[dcc_num_id]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO



/****** Object:  Table [sb_dato_central_endeudamiento]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_central_endeudamiento') IS NOT NULL
	DROP TABLE sb_dato_central_endeudamiento
GO
CREATE TABLE [sb_dato_central_endeudamiento](
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

/****** Object:  Index [sb_dato_central_endeudamiento_key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [sb_dato_central_endeudamiento_key] ON [sb_dato_central_endeudamiento]
(
	[dce_fecha_proceso],
	[dce_aplicativo],
	[dce_orden_consulta]
)
GO


/****** Object:  Table [sb_dato_central_huella]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_central_huella') IS NOT NULL
	DROP TABLE sb_dato_central_huella
GO
CREATE TABLE [sb_dato_central_huella](
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

/****** Object:  Index [sb_dato_central_huella_key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [sb_dato_central_huella_key] ON [sb_dato_central_huella]
(
	[dch_fecha_proceso],
	[dch_aplicativo],
	[dch_orden_consulta]
)
GO


/****** Object:  Table [sb_dato_central_producto]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_central_producto') IS NOT NULL
	DROP TABLE sb_dato_central_producto
GO
CREATE TABLE [sb_dato_central_producto](
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

/****** Object:  Index [sb_dato_central_producto_key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_dato_central_producto_key] ON [sb_dato_central_producto]
(
	[dcp_fecha_proceso],
	[dcp_aplicativo],
	[dcp_orden_consulta]
)
GO


/****** Object:  Table [sb_dato_central_score]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_central_score') IS NOT NULL
	DROP TABLE sb_dato_central_score
GO
CREATE TABLE [sb_dato_central_score](
	[dcs_fecha_proceso] [datetime] NOT NULL,
	[dcs_orden_consulta] [int] NOT NULL,
	[dcs_tipo] [varchar](20) NULL,
	[dcs_puntaje] [varchar](20) NULL,
	[dcs_aplicativo] [int] NOT NULL
)
GO

/****** Object:  Index [sb_dato_central_score_key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [sb_dato_central_score_key] ON [sb_dato_central_score]
(
	[dcs_fecha_proceso],
	[dcs_aplicativo],
	[dcs_orden_consulta]
)
GO


/****** Object:  Table [sb_dato_cliente]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_cliente') IS NOT NULL
	DROP TABLE sb_dato_cliente
GO
CREATE TABLE [sb_dato_cliente](
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
	[dc_actividad3] [catalogo] NULL,
	[dc_perf_tran] [money] NULL,
	[dc_riesgo] [catalogo] NULL
)
ALTER TABLE [sb_dato_cliente] ADD [dc_bancarizado] [char](1) NULL
ALTER TABLE [sb_dato_cliente] ADD [dc_alto_riesgo] [varchar](1) NULL
ALTER TABLE [sb_dato_cliente] ADD [dc_fecha_riesgo] [datetime] NULL
ALTER TABLE [sb_dato_cliente] ADD [dc_nit] [numero] NULL
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_cliente]
(
	[dc_cliente],
	[dc_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_cliente]
(
	[dc_fecha]
)
GO


/****** Object:  Table [sb_dato_clientes_campana]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_clientes_campana') IS NOT NULL
	DROP TABLE sb_dato_clientes_campana
GO
CREATE TABLE [sb_dato_clientes_campana](
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

/****** Object:  Index [ix_sb_clientes_contraoferta_ix_]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [ix_sb_clientes_contraoferta_ix_] ON [sb_dato_clientes_campana]
(
	[cc_fecha]
)
GO


/****** Object:  Table [sb_dato_cobranza]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_cobranza') IS NOT NULL
	DROP TABLE sb_dato_cobranza
GO
CREATE TABLE [sb_dato_cobranza](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_cobranza]
(
	[dc_cobranza],
	[dc_banco],
	[dc_aplicativo],
	[dc_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_cobranza]
(
	[dc_banco]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_cobranza]
(
	[dc_fecha],
	[dc_aplicativo]
)
GO


/****** Object:  Table [sb_dato_cuota_pry]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_cuota_pry') IS NOT NULL
	DROP TABLE sb_dato_cuota_pry
GO
CREATE TABLE [sb_dato_cuota_pry](
	[dc_fecha] [smalldatetime] NOT NULL,
	[dc_banco] [varchar](24) NOT NULL,
	[dc_toperacion] [varchar](10) NOT NULL,
	[dc_aplicativo] [tinyint] NOT NULL,
	[dc_num_cuota] [int] NOT NULL,
	[dc_fecha_vto] [smalldatetime] NOT NULL,
	[dc_estado] [char](1) NOT NULL,
	dc_valor_pry     MONEY NOT NULL,
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_cuota_pry]
(
	[dc_banco],
	[dc_num_cuota],
	[dc_fecha],
	[dc_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_cuota_pry]
(
	[dc_fecha],
	[dc_aplicativo],
	[dc_fecha_vto]
)
GO

CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_cuota_pry]
(
	[dc_fecha],
	[dc_aplicativo]
)
GO

CREATE NONCLUSTERED INDEX [idx4] ON [sb_dato_cuota_pry]
(
	[dc_banco],
	[dc_fecha],
	[dc_aplicativo]
)
GO


/****** Object:  Table [sb_dato_deudores]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_deudores') IS NOT NULL
	DROP TABLE sb_dato_deudores
GO
CREATE TABLE [sb_dato_deudores](
	[de_fecha] [smalldatetime] NOT NULL,
	[de_banco] [varchar](24) NOT NULL,
	[de_toperacion] [varchar](10) NOT NULL,
	[de_aplicativo] [tinyint] NOT NULL,
	[de_cliente] [int] NOT NULL,
	[de_rol] [char](1) NOT NULL
) 
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_deudores]
(
	[de_banco],
	[de_cliente],
	[de_fecha],
	[de_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_deudores]
(
	[de_cliente],
	[de_fecha],
	[de_aplicativo]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_deudores]
(
	[de_fecha],
	[de_aplicativo],
	[de_rol]
)
GO


/****** Object:  Table [sb_dato_direccion]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_direccion') IS NOT NULL
	DROP TABLE sb_dato_direccion
GO
CREATE TABLE [sb_dato_direccion](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_direccion]
(
	[dd_cliente],
	[dd_direccion],
	[dd_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_direccion]
(
	[dd_fecha]
)
GO


/****** Object:  Table [sb_dato_educa_hijos]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_educa_hijos') IS NOT NULL
	DROP TABLE sb_dato_educa_hijos
GO
CREATE TABLE [sb_dato_educa_hijos](
	[dt_secuencial] [int] NULL,
	[dt_cliente] [int] NULL,
	[dt_edad] [int] NULL,
	[dt_niv_edu] [int] NULL,
	[dt_hijos] [int] NULL,
	[dt_fecha_modif] [datetime] NULL
)
GO

/****** Object:  Index [sb_dato_educa_hijos_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_dato_educa_hijos_Key] ON [sb_dato_educa_hijos]
(
	[dt_cliente],
	[dt_fecha_modif]
)
GO


/****** Object:  Table [sb_dato_encuesta_preg]    Script Date: 16/08/2016 19:00:16 ******/
IF OBJECT_ID ('sb_dato_encuesta_preg') IS NOT NULL
	DROP TABLE sb_dato_encuesta_preg
GO
CREATE TABLE [sb_dato_encuesta_preg](
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
ALTER TABLE [sb_dato_encuesta_preg] ADD  DEFAULT ('V') FOR [ep_estado]
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_encuesta_preg]
(
	[ep_pregunta],
	[ep_fecha],
	[ep_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_encuesta_preg]
(
	[ep_fecha]
)
GO


/****** Object:  Table [sb_dato_encuesta_resp]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_encuesta_resp') IS NOT NULL
	DROP TABLE sb_dato_encuesta_resp
GO
CREATE TABLE [sb_dato_encuesta_resp](
	[er_fecha] [datetime] NOT NULL,
	[er_aplicativo] [tinyint] NOT NULL,
	[er_tramite] [int] NOT NULL,
	[er_pregunta] [int] NOT NULL,
	[er_respuesta] [varchar](255) NOT NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_encuesta_resp]
(
	[er_tramite],
	[er_pregunta],
	[er_fecha],
	[er_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_encuesta_resp]
(
	[er_pregunta]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_encuesta_resp]
(
	[er_fecha]
)
GO


/****** Object:  Table [sb_dato_encuestas]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_encuestas') IS NOT NULL
	DROP TABLE sb_dato_encuestas
GO
CREATE TABLE [sb_dato_encuestas](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_encuestas]
(
	[re_pregunta],
	[re_secuencial]
)
GO
/****** Object:  Index [idx_re_fecha]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx_re_fecha] ON [sb_dato_encuestas]
(
	[re_fecha]
)
GO


/****** Object:  Table [sb_dato_escolaridad_log]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_escolaridad_log') IS NOT NULL
	DROP TABLE sb_dato_escolaridad_log
GO
CREATE TABLE [sb_dato_escolaridad_log](
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

/****** Object:  Index [sb_dato_escolaridad_log_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_dato_escolaridad_log_Key] ON [sb_dato_escolaridad_log]
(
	[dt_fecha_actualizacion]
)
GO


/****** Object:  Table [sb_dato_gestion_campana]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_gestion_campana') IS NOT NULL
	DROP TABLE sb_dato_gestion_campana
GO
CREATE TABLE [sb_dato_gestion_campana](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_gestion_campana]
(
	[gc_cliente],
	[gc_campana],
	[gc_fecha_campana],
	[gc_secuencial]
)
GO
/****** Object:  Index [idx_gc_fecha]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx_gc_fecha] ON [sb_dato_gestion_campana]
(
	[gc_fecha]
)
GO


/****** Object:  Table [sb_dato_lin_ope_moneda]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_lin_ope_moneda') IS NOT NULL
	DROP TABLE sb_dato_lin_ope_moneda
GO
CREATE TABLE [sb_dato_lin_ope_moneda](
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

/****** Object:  Table [sb_dato_linea]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_linea') IS NOT NULL
	DROP TABLE sb_dato_linea
GO
CREATE TABLE [sb_dato_linea](
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

/****** Object:  Table [sb_dato_microempresa]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_microempresa') IS NOT NULL
	DROP TABLE sb_dato_microempresa
GO
CREATE TABLE [sb_dato_microempresa](
	[dm_fecha] [datetime] NOT NULL,
	[dm_aplicativo] [tinyint] NOT NULL,
	[dm_id_microempresa] [numero] NOT NULL,
	[dm_nombre] [descripcion] NOT NULL,
	[dm_descripcion] [descripcion] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_microempresa]
(
	[dm_id_microempresa]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_microempresa]
(
	[dm_fecha],
	[dm_aplicativo]
)
GO


/****** Object:  Table [sb_dato_microempresa_sit]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_microempresa_sit') IS NOT NULL
	DROP TABLE sb_dato_microempresa_sit
GO
CREATE TABLE [sb_dato_microempresa_sit](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_microempresa_sit]
(
	[ms_tramite],
	[ms_id_microempresa],
	[ms_microempresa],
	[ms_fecha],
	[ms_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_microempresa_sit]
(
	[ms_id_microempresa]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_microempresa_sit]
(
	[ms_fecha],
	[ms_aplicativo]
)
GO


/****** Object:  Table [sb_dato_operacion]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_operacion') IS NOT NULL
	DROP TABLE sb_dato_operacion
GO
CREATE TABLE [sb_dato_operacion](
    [do_fecha] [datetime] NOT NULL,
    [do_banco] [varchar](24) NOT NULL,
    [do_tipo_operacion] [varchar](10) NOT NULL,
    [do_aplicativo] [tinyint] NOT NULL,
    [do_codigo_cliente] [int] NOT NULL,
    [do_oficina] [smallint] NOT NULL,
    [do_moneda] [tinyint] NOT NULL,
    [do_monto] [money] NOT NULL,
    [do_tasa] [float] NULL,
    [do_modalidad] [char](1) NULL,
    [do_codigo_destino] [varchar](10) NOT NULL,
    [do_clase_cartera] [varchar](10) NOT NULL,
    [do_fecha_concesion] [datetime] NOT NULL,
    [do_fecha_vencimiento] [datetime] NOT NULL,
    [do_saldo_cap] [money] NOT NULL,
    [do_saldo_int] [money] NOT NULL,
    [do_saldo_otros] [money] NOT NULL,
    [do_saldo_int_contingente] [money] NOT NULL,
    [do_saldo] [money] NOT NULL,
    [do_linea_credito] [varchar](24) NULL,
    [do_periodicidad_cuota] [smallint] NULL,
    [do_edad_mora] [int] NULL,
    [do_estado_cartera] [tinyint] NULL,
    [do_plazo_dias] [int] NULL,
    [do_num_cuotas] [smallint] NULL,
    [do_valor_mora] [money] NULL,
    [do_valor_cuota] [money] NULL,
    [do_fecha_pago] [datetime] NULL,
    [do_cuotas_pag] [smallint] NULL,
    [do_valor_ult_pago] [money] NULL,
    [do_num_cuotaven] [smallint] NULL,
    [do_saldo_cuotaven] [money] NULL,
    [do_fecha_castigo] [datetime] NULL,
    [do_num_acta] [varchar](24) NULL,
    [do_clausula] [char](1) NULL,
    [do_moneda_op] [tinyint] NULL,
    [do_reestructuracion] [char](1) NULL,
    [do_fecha_reest] [datetime] NULL,
    [do_num_reest] [tinyint] NULL,
    [do_no_renovacion] [int] NOT NULL,
    [do_estado_contable] [tinyint] NOT NULL,
    [do_calificacion] [varchar](10) NULL,
    [do_probabilidad_default] [float] NULL,
    [do_calificacion_mr] [varchar](10) NULL,
    [do_proba_incum] [float] NULL,
    [do_perd_incum] [float] NULL,
    [do_tipo_emp_mr] [char](2) NULL,
    [do_tipo_garantias] [varchar](10) NULL,
    [do_valor_garantias] [money] NULL,
    [do_admisible] [char](1) NULL,
    [do_prov_cap] [money] NULL,
    [do_prov_int] [money] NULL,
    [do_prov_cxc] [money] NULL,
    [do_prov_con_int] [money] NULL,
    [do_prov_con_cxc] [money] NULL,
    [do_prov_con_cap] [money] NULL,
    [do_tipo_reg] [char](1) NOT NULL,
    [do_edad_cod] [tinyint] NOT NULL,
    [do_oficial] [smallint] NOT NULL,
    [do_fecha_ult_pago] [datetime] NULL,
    [do_naturaleza] [varchar](2) NULL,
    [do_fuente_recurso] [varchar](10) NULL,
    [do_categoria_producto] [varchar](10) NULL,
    [do_fecha_prox_vto] [datetime] NULL,
    [do_op_anterior] [varchar](24) NULL,
    [do_num_cuotas_reest] [int] NULL,
    [do_tramite] [int] NULL,
    [do_nota_int] [tinyint] NULL,
    [do_fecha_ini_mora] [datetime] NULL,
    [do_gracia_mora] [smallint] NULL,
    [do_saldo_otr_contingente] [money] NULL,
    [do_tasa_mora] [float] NULL,
    [do_tasa_com] [float] NULL,
    [do_entidad_convenio] [varchar](10) NULL,
    [do_fecha_cambio_linea] [datetime] NULL,
    [do_valor_nominal] [money] NULL,
    [do_emision] [varchar](20) NULL,
    [do_sujcred] [varchar](10) NULL,
    [do_cap_vencido] [money] NULL,
    [do_valor_proxima_cuota] [money] NULL,
    [do_saldo_total_Vencido] [money] NULL,
    [do_saldo_otr] [money] NULL,
    [do_saldo_cap_total] [money] NULL,
    [do_regional] [varchar](64) NULL,
    [do_dias_mora_365] [int] NULL,
    [do_normalizado] [char](1) NULL,
    [do_tipo_norm] [int] NULL,
    [do_frec_pagos_capital] [INT] NULL,
    [do_frec_pagos_int] [INT] NULL,
    [do_fec_pri_amort_cubierta] [DATETIME] NULL,
    [do_monto_condo] [MONEY] NULL,
    [do_fecha_condo] [DATETIME] NULL,
    [do_monto_castigo] [MONEY] NULL,
    [do_inte_castigo] [FLOAT] NULL,
    [do_monto_bonifica][MONEY] NULL,
    [do_inte_refina] [FLOAT] NULL,
    [do_emproblemado] [char](1) NULL,
    [do_mod_pago] [int] NULL,
    [do_cap_liq] [money] NULL,
    [do_cap_hip] [money] NULL,
    [do_cap_des] [money] NULL,
    [do_int_liq] [money] NULL,
    [do_int_hip] [money] NULL,
    [do_int_des] [money] NULL,
    [do_fecha_ult_pago_cap] [datetime] NULL,
    [do_valor_ult_pago_cap] [money] NULL,
    [do_fecha_ult_pago_int] [datetime] NULL,
    [do_valor_ult_pago_int] [money] NULL,
    [do_inte_vencido] [money] NULL,
    [do_inte_vencido_fbalance] [money] NULL,
     do_dias_mora_ant          int null,
     do_grupal                 char(1) null,
     do_cociente_pago          float null,
     do_numero_ciclos          int null,
     do_numero_integrantes     int null,
     do_unidad_atraso          float null,
     do_probabilidad_incumplimiento float null,
     do_severidad_perdida      float null,
     do_monto_expuesto         money null,
     do_provision              float null,
     do_grupo                  int null,
     do_valor_cat              FLOAT NULL,
     do_gar_liq_orig           MONEY NULL,
     do_gar_liq_fpago          DATETIME NULL,
     do_gar_liq_dev            MONEY NULL,
     do_gar_liq_fdev           DATETIME NULL,
     do_cuota_cap              MONEY NULL,
     do_cuota_int              MONEY NULL,
     do_cuota_iva              MONEY NULL,
     do_fecha_suspenso         DATETIME NULL,
     do_venc_dividendo         INT NULL,
     do_plazo                  VARCHAR(64) NULL,
     do_fecha_aprob_tramite    DATETIME NULL,
     do_subtipo_producto       VARCHAR(64) NULL, 
     do_atraso_grupal          INT NULL,
     do_fecha_dividendo_ven    DATETIME null,
     do_operacion              INT null,
     do_cuota_min_vencida      MONEY null,
     do_tplazo                 VARCHAR(10) null,
     do_fecha_proceso          datetime,
     do_subproducto            varchar (10),	 
     do_cuota_max_vencida      money null,
     do_atraso_gr_ant          int   null,
     do_monto_aprobado         money null,
     do_fecha_ult_vto          datetime null,
     do_cuota_ult_vto          int null,
     do_cupo_original          money  null,    
     do_importe_ult_vto        money  null,    
     do_importe_pri_vto        money  null,    
     do_fecha_pri_vto          datetime  null,
     do_fecha_ven_orig         datetime null,
     do_fecha_can_ant          datetime null,
     do_cuota_int_esp          money              null,
     do_cuota_iva_esp          money              null,          
     do_fecha_ini_desp         datetime           null,
     do_fecha_fin_desp         datetime           null,
     do_renovacion_grupal      int null,
     do_renovacion_ind         int null,	 
     do_meses_primer_op        int                null,
     do_periodicidad           int                null,
     do_dia_pago               varchar(20) null
) 
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [idx1] ON [sb_dato_operacion]
(
	[do_fecha],
	[do_banco],
	[do_aplicativo]
	
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_operacion]
(
	[do_codigo_cliente]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_operacion]
(
	[do_fecha],
	[do_aplicativo],
	[do_oficina]
)
GO
CREATE NONCLUSTERED INDEX [idx4] ON [sb_dato_operacion]
(
	[do_grupo]  ASC,
	[do_numero_ciclos] ASC
)
GO
CREATE NONCLUSTERED INDEX [idx5] ON [sb_dato_operacion]
(
	[do_banco],
	[do_aplicativo],
	[do_fecha]
)
GO
/****** Object:  Table [sb_dato_operacion_rubro]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_operacion_rubro') IS NOT NULL
	DROP TABLE sb_dato_operacion_rubro
GO
CREATE TABLE [sb_dato_operacion_rubro](
	[dr_fecha] [smalldatetime] NOT NULL,
	[dr_banco] [varchar](24) NOT NULL,
	[dr_toperacion] [catalogo] NULL,
	[dr_aplicativo] [tinyint] NULL,
	[dr_concepto] [varchar](24) NOT NULL,
	[dr_estado] [int] NULL,
	[dr_exigible] [int] NULL,
	dr_codvalor      int not null,
	[dr_valor] [money] NULL,
	dr_cuota  MONEY NULL,
	dr_acumulado  MONEY NULL,
	dr_pagado  MONEY NULL,
	dr_categoria catalogo null,
	dr_rubro_aso catalogo null,
	dr_cat_rub_aso catalogo null 
    ) 
GO

CREATE CLUSTERED INDEX indx_sb_dato_operacion_rubro_dr_fecha_dr_banco on sb_dato_operacion_rubro
(
   dr_fecha,
   dr_banco,
   dr_concepto, 
   dr_estado
)	
GO

CREATE NONCLUSTERED INDEX idx2 on sb_dato_operacion_rubro
(
   dr_concepto,
   dr_estado
)

GO

/****** Object:  Table [sb_dato_operacion_tmp]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_operacion_tmp') IS NOT NULL
	DROP TABLE sb_dato_operacion_tmp
GO
CREATE TABLE [sb_dato_operacion_tmp](
    [do_fecha] [datetime] NOT NULL,
    [do_banco] [varchar](24) NOT NULL,
    [do_tipo_operacion] [varchar](10) NOT NULL,
    [do_aplicativo] [tinyint] NOT NULL,
    [do_codigo_cliente] [int] NOT NULL,
    [do_oficina] [smallint] NOT NULL,
    [do_moneda] [tinyint] NOT NULL,
    [do_monto] [money] NOT NULL,
    [do_tasa] [float] NULL,
    [do_modalidad] [char](1) NULL,
    [do_codigo_destino] [varchar](10) NOT NULL,
    [do_clase_cartera] [varchar](10) NOT NULL,
    [do_fecha_concesion] [datetime] NOT NULL,
    [do_fecha_vencimiento] [datetime] NOT NULL,
    [do_saldo_cap] [money] NOT NULL,
    [do_saldo_int] [money] NOT NULL,
    [do_saldo_otros] [money] NOT NULL,
    [do_saldo_int_contingente] [money] NOT NULL,
    [do_saldo] [money] NOT NULL,
    [do_linea_credito] [varchar](24) NULL,
    [do_periodicidad_cuota] [smallint] NULL,
    [do_edad_mora] [int] NULL,
    [do_estado_cartera] [tinyint] NULL,
    [do_plazo_dias] [int] NULL,
    [do_num_cuotas] [smallint] NULL,
    [do_valor_mora] [money] NULL,
    [do_valor_cuota] [money] NULL,
    [do_fecha_pago] [datetime] NULL,
    [do_cuotas_pag] [smallint] NULL,
    [do_valor_ult_pago] [money] NULL,
    [do_num_cuotaven] [smallint] NULL,
    [do_saldo_cuotaven] [money] NULL,
    [do_fecha_castigo] [datetime] NULL,
    [do_num_acta] [varchar](24) NULL,
    [do_clausula] [char](1) NULL,
    [do_moneda_op] [tinyint] NULL,
    [do_reestructuracion] [char](1) NULL,
    [do_fecha_reest] [datetime] NULL,
    [do_num_reest] [tinyint] NULL,
    [do_no_renovacion] [int] NOT NULL,
    [do_estado_contable] [tinyint] NOT NULL,
    [do_calificacion] [varchar](10) NULL,
    [do_probabilidad_default] [float] NULL,
    [do_calificacion_mr] [varchar](10) NULL,
    [do_proba_incum] [float] NULL,
    [do_perd_incum] [float] NULL,
    [do_tipo_emp_mr] [char](2) NULL,
    [do_tipo_garantias] [varchar](10) NULL,
    [do_valor_garantias] [money] NULL,
    [do_admisible] [char](1) NULL,
    [do_prov_cap] [money] NULL,
    [do_prov_int] [money] NULL,
    [do_prov_cxc] [money] NULL,
    [do_prov_con_int] [money] NULL,
    [do_prov_con_cxc] [money] NULL,
    [do_prov_con_cap] [money] NULL,
    [do_tipo_reg] [char](1) NOT NULL,
    [do_edad_cod] [tinyint] NOT NULL,
    [do_oficial] [smallint] NOT NULL,
    [do_fecha_ult_pago] [datetime] NULL,
    [do_naturaleza] [varchar](2) NULL,
    [do_fuente_recurso] [varchar](10) NULL,
    [do_categoria_producto] [varchar](10) NULL,
    [do_fecha_prox_vto] [datetime] NULL,
    [do_op_anterior] [varchar](24) NULL,
    [do_num_cuotas_reest] [int] NULL,
    [do_tramite] [int] NULL,
    [do_nota_int] [tinyint] NULL,
    [do_fecha_ini_mora] [datetime] NULL,
    [do_gracia_mora] [smallint] NULL,
    [do_saldo_otr_contingente] [money] NULL,
    [do_tasa_mora] [float] NULL,
    [do_tasa_com] [float] NULL,
    [do_entidad_convenio] [varchar](10) NULL,
    [do_fecha_cambio_linea] [datetime] NULL,
    [do_valor_nominal] [money] NULL,
    [do_emision] [varchar](20) NULL,
    [do_sujcred] [varchar](10) NULL,
    [do_cap_vencido] [money] NULL,
    [do_valor_proxima_cuota] [money] NULL,
    [do_saldo_total_Vencido] [money] NULL,
    [do_saldo_otr] [money] NULL,
    [do_saldo_cap_total] [money] NULL,
    [do_regional] [varchar](64) NULL,
    [do_dias_mora_365] [int] NULL,
    [do_normalizado] [char](1) NULL,
    [do_tipo_norm] [int] NULL,
    [do_frec_pagos_capital] [INT] NULL,
    [do_frec_pagos_int] [INT] NULL,
    [do_fec_pri_amort_cubierta] [DATETIME] NULL,
    [do_monto_condo] [MONEY] NULL,
    [do_fecha_condo] [DATETIME] NULL,
    [do_monto_castigo] [MONEY] NULL,
    [do_inte_castigo] [FLOAT] NULL,
    [do_monto_bonifica][MONEY] NULL,
    [do_inte_refina] [FLOAT] NULL,
    [do_emproblemado] [char](1) NULL,
    [do_mod_pago] [int] NULL,
    [do_cap_liq] [money] NULL,
    [do_cap_hip] [money] NULL,
    [do_cap_des] [money] NULL,
    [do_int_liq] [money] NULL,
    [do_int_hip] [money] NULL,
    [do_int_des] [money] NULL,
    [do_fecha_ult_pago_cap] [datetime] NULL,
    [do_valor_ult_pago_cap] [money] NULL,
    [do_fecha_ult_pago_int] [datetime] NULL,
    [do_valor_ult_pago_int] [money] NULL,
    [do_inte_vencido] [money] NULL,
    [do_inte_vencido_fbalance] [money] NULL,
     do_dias_mora_ant int null,
     do_grupal char(1) null,
     do_cociente_pago float null,
     do_numero_ciclos int null,
     do_numero_integrantes int null,
     do_unidad_atraso float null,
     do_probabilidad_incumplimiento float null,
     do_severidad_perdida float null,
     do_monto_expuesto money null,
     do_provision float null,
     do_grupo                       INT NULL,
     do_valor_cat                   FLOAT NULL,
     do_gar_liq_orig                MONEY NULL,
     do_gar_liq_fpago               DATETIME NULL,
     do_gar_liq_dev                 MONEY NULL,
     do_gar_liq_fdev                DATETIME NULL,
     do_cuota_cap                   MONEY NULL,
     do_cuota_int                   MONEY NULL,
     do_cuota_iva                   MONEY NULL,
     do_fecha_suspenso              DATETIME NULL,
     do_venc_dividendo              INT NULL,
     do_plazo                       VARCHAR(64) NULL, 
     do_fecha_aprob_tramite         DATETIME NULL,
     do_subtipo_producto            VARCHAR(64) NULL, 
     do_atraso_grupal               INT NULL,
     do_fecha_dividendo_ven         DATETIME null,
     do_operacion                   INT null,
     do_cuota_min_vencida           MONEY null,
     do_tplazo                      VARCHAR(10) null,
     do_fecha_proceso               datetime,
     do_subproducto                 varchar (10),	 
     do_cuota_max_vencida           money null,
     do_atraso_gr_ant               int   null,
     do_monto_aprobado              money null,
     do_fecha_ult_vto               datetime null,
     do_cuota_ult_vto               int null,
     do_cupo_original               money  null,    
     do_importe_ult_vto             money  null,    
     do_importe_pri_vto             money  null,    
     do_fecha_pri_vto               datetime,
     do_fecha_ven_orig              datetime null,
     do_fecha_can_ant               datetime,
     do_cuota_int_esp               money              null,
     do_cuota_iva_esp               money              null,          
     do_fecha_ini_desp              datetime           null,
     do_fecha_fin_desp              datetime           null,
     do_renovacion_grupal           int                null,
     do_renovacion_ind              int                null,
     do_meses_primer_op             int                null,
     do_periodicidad                int                null,
	 do_dia_pago                    varchar(20)        null
     )
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_dato_operacion_tmp]
(
	[do_banco]
)
GO


/****** Object:  Table [sb_dato_reajuste]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_reajuste') IS NOT NULL
	DROP TABLE sb_dato_reajuste
GO
CREATE TABLE [sb_dato_reajuste](
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

/****** Object:  Table [sb_dato_rubro_pry]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_rubro_pry') IS NOT NULL
	DROP TABLE sb_dato_rubro_pry
GO
CREATE TABLE [sb_dato_rubro_pry](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_dato_rubro_pry]
(
	[dr_banco],
	[dr_num_cuota],
	[dr_fecha],
	[dr_aplicativo],
	[dr_concepto]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_rubro_pry]
(
	[dr_fecha],
	[dr_aplicativo],
	[dr_concepto]
)
GO


/****** Object:  Table [sb_dato_ruta]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_ruta') IS NOT NULL
	DROP TABLE sb_dato_ruta
GO
CREATE TABLE [sb_dato_ruta](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_ruta]
(
	[dr_tramite],
	[dr_secuencia],
	[dr_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_ruta]
(
	[dr_fecha],
	[dr_aplicativo]
)
GO


/****** Object:  Table [sb_dato_seguros]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_seguros') IS NOT NULL
	DROP TABLE sb_dato_seguros
GO
CREATE TABLE [sb_dato_seguros](
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

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [sb_dato_seguros]
(
	[se_fecha],
	[se_aplicativo],
	[se_operacion]
)
GO


/****** Object:  Table [sb_dato_seguros_det]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_seguros_det') IS NOT NULL
	DROP TABLE sb_dato_seguros_det
GO
CREATE TABLE [sb_dato_seguros_det](
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

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [sb_dato_seguros_det]
(
	[sed_fecha],
	[sed_aplicativo],
	[sed_operacion]
)
GO


/****** Object:  Table [sb_dato_sostenibilidad]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_sostenibilidad') IS NOT NULL
	DROP TABLE sb_dato_sostenibilidad
GO
CREATE TABLE [sb_dato_sostenibilidad](
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

/****** Object:  Index [sb_dato_sostenibilidadKey]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_dato_sostenibilidadKey] ON [sb_dato_sostenibilidad]
(
	[dt_cliente],
	[dt_fecha_modif]
)
GO


/****** Object:  Table [sb_dato_sostenibilidad_log]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_sostenibilidad_log') IS NOT NULL
	DROP TABLE sb_dato_sostenibilidad_log
GO
CREATE TABLE [sb_dato_sostenibilidad_log](
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

/****** Object:  Index [sb_dato_sostenibilidad_log_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_dato_sostenibilidad_log_Key] ON [sb_dato_sostenibilidad_log]
(
	[dt_fecha_actualizacion]
)
GO


/****** Object:  Table [sb_dato_telefono]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_telefono') IS NOT NULL
	DROP TABLE sb_dato_telefono
GO
CREATE TABLE [sb_dato_telefono](
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
SET ANSI_PADDING ON
ALTER TABLE [sb_dato_telefono] ADD [dt_tipo_operador] [varchar](10) NULL
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_telefono]
(
	[dt_cliente],
	[dt_fecha],
	[dt_direccion],
	[dt_secuencial]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_telefono]
(
	[dt_fecha]
)
GO


/****** Object:  Table [sb_dato_tesoreria]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_tesoreria') IS NOT NULL
	DROP TABLE sb_dato_tesoreria
GO
CREATE TABLE [sb_dato_tesoreria](
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

/****** Object:  Table [sb_dato_tramite]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_tramite') IS NOT NULL
	DROP TABLE sb_dato_tramite
GO
CREATE TABLE [sb_dato_tramite](
	[dt_fecha] [datetime] NOT NULL,
	[dt_aplicativo] [tinyint] NOT NULL,
	[dt_tramite] [int] NOT NULL,
	[dt_tipo] [char](1) NOT NULL,
	[dt_truta] [tinyint] NOT NULL,
	[dt_fecha_creacion] [datetime] NOT NULL,
	[dt_mercado] [char](1) NULL,
	[dt_tipo_credito] [char](1) NULL,
	[dt_sujcred] [varchar](10) NULL,
	[dt_clase] [varchar](10) NULL,
	[dt_cliente] [int] NULL,
	[dt_oficina] [smallint] NULL,
	[dt_fuente_recurso] [varchar](10) NULL,
	[dt_banco] [varchar](24) NULL,
	[dt_campana] [int] NULL,
	[dt_alianza] [int] NULL,
	[dt_autoriza_central] [char](1) NULL,
	[dt_negado_mir] [char](1) NULL,
	[dt_num_devri] [int] NULL	
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_tramite]
(
	[dt_tramite]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_tramite]
(
	[dt_fecha],
	[dt_aplicativo]
)
GO


/****** Object:  Table [sb_dato_tramite_sit]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_tramite_sit') IS NOT NULL
	DROP TABLE sb_dato_tramite_sit
GO
CREATE TABLE [sb_dato_tramite_sit](
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
SET ANSI_PADDING ON
ALTER TABLE [sb_dato_tramite_sit] ADD [ts_funcionario] [varchar](20) NULL
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_tramite_sit]
(
	[ts_tramite],
	[ts_aplicativo],
	[ts_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_tramite_sit]
(
	[ts_fecha],
	[ts_aplicativo]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_dato_tramite_sit]
(
	[ts_banco]
)
GO


/****** Object:  Table [sb_dato_transaccion]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_transaccion') IS NOT NULL
	DROP TABLE sb_dato_transaccion
GO
CREATE TABLE [sb_dato_transaccion](
	[dt_fecha] [smalldatetime] NOT NULL,
	[dt_secuencial] [int] NOT NULL,
	[dt_banco] [varchar](24) NOT NULL,
	[dt_toperacion] [varchar](10) NOT NULL,
	[dt_aplicativo] [tinyint] NOT NULL,
	[dt_fecha_trans] [smalldatetime] NOT NULL,
	[dt_tipo_trans] [varchar](10) NOT NULL,
	[dt_reversa] [varchar](1) NOT NULL,
	[dt_naturaleza] [varchar](1) NOT NULL,
	[dt_canal] [varchar](10) NOT NULL,
	[dt_oficina] [smallint] NOT NULL,
	[dt_secuencial_caja] [int] NULL,
	[dt_usuario] [login] NULL,
	[dt_terminal] [varchar](20) NULL,
	[dt_fecha_hora] [datetime] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_dato_transaccion]
(
	[dt_banco],
	[dt_secuencial],
	[dt_fecha],
	[dt_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_transaccion]
(
	[dt_fecha],
	[dt_aplicativo],
	[dt_tipo_trans]
)
GO


/****** Object:  Table [sb_dato_transaccion_det]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_transaccion_det') IS NOT NULL
	DROP TABLE sb_dato_transaccion_det
GO
CREATE TABLE [sb_dato_transaccion_det](
	[dd_fecha] [smalldatetime] NOT NULL,
	[dd_secuencial] [int] NOT NULL,
	[dd_banco] [varchar](24) NOT NULL,
	[dd_toperacion] [varchar](10) NOT NULL,
	[dd_aplicativo] [tinyint] NOT NULL,
	[dd_concepto] [varchar](10) NOT NULL,
	[dd_moneda] [int] NOT NULL,
	[dd_cotizacion] [float] NOT NULL,
	[dd_monto] [money] NOT NULL,
	[dd_codigo_valor] [cuenta] NULL,
	[dd_origen_efectivo] [char](1) NULL,
	[dd_dividendo] [int] NOT NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_dato_transaccion_det]
(
	[dd_banco],
	[dd_fecha],
	[dd_secuencial],
	[dd_aplicativo]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_dato_transaccion_det]
(
	[dd_fecha],
	[dd_aplicativo]
)
GO


/****** Object:  Table [sb_dato_transaccion_efec]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_transaccion_efec') IS NOT NULL
	DROP TABLE sb_dato_transaccion_efec
GO
CREATE TABLE [sb_dato_transaccion_efec](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_dato_transaccion_efec]
(
	[di_banco],
	[di_secuencial_caja],
	[di_fecha],
	[di_aplicativo]
)
GO


/****** Object:  Table [sb_datos_corte_anterior_tmp]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_datos_corte_anterior_tmp') IS NOT NULL
	DROP TABLE sb_datos_corte_anterior_tmp
GO
CREATE TABLE [sb_datos_corte_anterior_tmp](
	[aplicativo] [tinyint] NOT NULL,
	[banco] [varchar](24) NOT NULL,
	[prov_cap] [money] NULL,
	[prov_int] [money] NULL,
	[prov_cxc] [money] NULL,
	[prov_con_int] [money] NULL,
	[prov_con_cxc] [money] NULL,
	[prov_con_cap] [money] NULL,
	[calificacion] [varchar](10) NULL,
	[calificacion_mr] [varchar](10) NULL,
	[proba_incum] [float] NULL,
	[perd_incum] [float] NULL,
	[tipo_emp_mr] [char](2) NULL,
	[situacion_cli] [catalogo] NULL,
	[edad_cod] [tinyint] NOT NULL,
	[tipo_gar] [varchar](10) NULL,
	[calif_reest] [catalogo] NULL,
	[valor_gar] [money] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_datos_corte_anterior_tmp]
(
	[banco]
)
GO


/****** Object:  Table [sb_datos_rubros_tmp]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_datos_rubros_tmp') IS NOT NULL
	DROP TABLE sb_datos_rubros_tmp
GO
CREATE TABLE [sb_datos_rubros_tmp](
	[banco]             [varchar](24) NOT NULL,
	[aplicativo]        [tinyint] NOT NULL,
	[saldo_cap]         [money] NULL,
	[saldo_int]         [money] NULL,
	[saldo_int_esp]     [money] NULL,
	[saldo_otr]         [money] NULL,
	[int_cont]          [money] NULL,
	[saldo_cap_cas]     [money] NULL,
	[saldo_int_cas]     [money] NULL,
	[saldo_int_esp_cas] [money] NULL,
	[saldo_otr_cas]     [money] NULL,
	[otr_cont]          [money] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_datos_rubros_tmp]
(
	[banco]
)
GO


/****** Object:  Table [sb_def_variables_filtros]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_def_variables_filtros') IS NOT NULL
	DROP TABLE sb_def_variables_filtros
GO
CREATE TABLE [sb_def_variables_filtros](
	[df_fecha] [datetime] NOT NULL,
	[df_variable] [int] NULL,
	[df_descripcion] [varchar](64) NULL,
	[df_programa] [varchar](40) NULL,
	[df_tipo_var] [catalogo] NULL,
	[df_tipo_dato] [char](1) NULL,
	[df_estado] [catalogo] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_def_variables_filtros]
(
	[df_fecha]
)
GO


/****** Object:  Table [sb_desmarca_fng_his]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_desmarca_fng_his') IS NOT NULL
	DROP TABLE sb_desmarca_fng_his
GO
CREATE TABLE [sb_desmarca_fng_his](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_desmarca_fng_his]
(
	[df_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_desmarca_fng_his]
(
	[df_banco]
)
GO


/****** Object:  Table [sb_enfermedades]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_enfermedades') IS NOT NULL
	DROP TABLE sb_enfermedades
GO
CREATE TABLE [sb_enfermedades](
	[en_fecha] [datetime] NOT NULL,
	[en_microseg] [int] NOT NULL,
	[en_asegurado] [int] NOT NULL,
	[en_enfermedad] [varchar](10) NOT NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_enfermedades]
(
	[en_fecha],
	[en_microseg]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_enfermedades]
(
	[en_microseg]
)
GO


/****** Object:  Table [sb_errorlog]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_errorlog') IS NOT NULL
	DROP TABLE sb_errorlog
GO
CREATE TABLE [sb_errorlog](
	[er_fecha] [datetime] NOT NULL,
	[er_fecha_proc] [datetime] NOT NULL,
	[er_fuente] [descripcion] NOT NULL,
	[er_origen_error] [varchar](255) NOT NULL,
	[er_descrp_error] [varchar](255) NOT NULL
)
GO

/****** Object:  Index [sb_errorlog_1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_errorlog_1] ON [sb_errorlog]
(
	[er_fecha_proc],
	[er_fuente]
)
GO


/****** Object:  Table [sb_filtros]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_filtros') IS NOT NULL
	DROP TABLE sb_filtros
GO
CREATE TABLE [sb_filtros](
	[fi_fecha] [datetime] NOT NULL,
	[fi_filtro] [int] NULL,
	[fi_descripcion] [varchar](64) NULL,
	[fi_tipo_persona] [catalogo] NULL,
	[fi_etapa] [int] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_filtros]
(
	[fi_fecha]
)
GO


/****** Object:  Table [sb_forma_extractos]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_forma_extractos') IS NOT NULL
	DROP TABLE sb_forma_extractos
GO
CREATE TABLE [sb_forma_extractos](
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

/****** Object:  Index [sb_forma_extractos_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [sb_forma_extractos_Key] ON [sb_forma_extractos]
(
	[fe_fecha]
)
GO


/****** Object:  Table [sb_impresion_cartas]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_impresion_cartas') IS NOT NULL
	DROP TABLE sb_impresion_cartas
GO
CREATE TABLE [sb_impresion_cartas](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_impresion_cartas]
(
	[ic_fecha_proceso],
	[ic_no_operacion]
)
GO


/****** Object:  Table [sb_micro_seguro]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_micro_seguro') IS NOT NULL
	DROP TABLE sb_micro_seguro
GO
CREATE TABLE [sb_micro_seguro](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_micro_seguro]
(
	[ms_fecha],
	[ms_tramite]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_micro_seguro]
(
	[ms_tramite]
)
GO


/****** Object:  Table [sb_msv_error]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_msv_error') IS NOT NULL
	DROP TABLE sb_msv_error
GO
CREATE TABLE [sb_msv_error](
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

/****** Object:  Table [sb_msv_proc_ca]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_msv_proc_ca') IS NOT NULL
	DROP TABLE sb_msv_proc_ca
GO
CREATE TABLE [sb_msv_proc_ca](
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

/****** Object:  Table [sb_msv_proc_cr]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_msv_proc_cr') IS NOT NULL
	DROP TABLE sb_msv_proc_cr
GO
CREATE TABLE [sb_msv_proc_cr](
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

/****** Object:  Table [sb_normalizacion]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_normalizacion') IS NOT NULL
	DROP TABLE sb_normalizacion
GO
CREATE TABLE [sb_normalizacion](
	[sn_fecha] [datetime] NOT NULL,
	[sn_aplicativo] [int] NOT NULL,
	[sn_banco] [varchar](24) NOT NULL,
	[sn_tramite] [int] NOT NULL,
	[sn_banco_norm] [varchar](24) NOT NULL,
	[sn_tramite_norm] [int] NOT NULL,
	[sn_cliente] [int] NOT NULL,
	[sn_tipo_norm] [int] NOT NULL
)

GO
/****** Object:  Table [sb_op_reest_padre_hija]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_op_reest_padre_hija') IS NOT NULL
	DROP TABLE sb_op_reest_padre_hija
GO
CREATE TABLE [sb_op_reest_padre_hija](
	[ph_fecha_proceso] [datetime] NOT NULL,
	[ph_aplicativo] [tinyint] NOT NULL,
	[ph_banco_padre] [cuenta] NOT NULL,
	[ph_banco_hija] [cuenta] NOT NULL,
	[ph_ente] [int] NOT NULL,
	[ph_sec_reest] [int] NOT NULL,
	[ph_fecha] [datetime] NOT NULL
)
GO

/****** Object:  Index [sb_op_reest_padre_hija_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [sb_op_reest_padre_hija_Key] ON [sb_op_reest_padre_hija]
(
	[ph_fecha_proceso],
	[ph_aplicativo],
	[ph_banco_padre]
)
GO


/****** Object:  Table [sb_pago_recono]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_pago_recono') IS NOT NULL
	DROP TABLE sb_pago_recono
GO
CREATE TABLE [sb_pago_recono](
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

/****** Object:  Index [sb_pago_recono_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [sb_pago_recono_Key] ON [sb_pago_recono]
(
	[pr_fecha_rep],
	[pr_aplicativo],
	[pr_banco]
)
GO


/****** Object:  Table [sb_pasos_filtros]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_pasos_filtros') IS NOT NULL
	DROP TABLE sb_pasos_filtros
GO
CREATE TABLE [sb_pasos_filtros](
	[pf_fecha] [datetime] NOT NULL,
	[pf_ruta] [int] NULL,
	[pf_paso] [int] NULL,
	[pf_etapa] [int] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_pasos_filtros]
(
	[pf_fecha]
)
GO


/****** Object:  Table [sb_potenciales_cupo]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_potenciales_cupo') IS NOT NULL
	DROP TABLE sb_potenciales_cupo
GO
CREATE TABLE [sb_potenciales_cupo](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_potenciales_cupo]
(
	[pt_fecha_proceso],
	[pt_cliente]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_potenciales_cupo]
(
	[pt_cliente]
)
GO


/****** Object:  Table [sb_prospecto_contraoferta]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_prospecto_contraoferta') IS NOT NULL
	DROP TABLE sb_prospecto_contraoferta
GO
CREATE TABLE [sb_prospecto_contraoferta](
	[pr_cliente] [int] NULL,
	[pr_operacion] [int] NULL,
	[pr_fecha_proceso] [datetime] NULL
)
GO

/****** Object:  Index [ix_sb_prospecto_contraoferta_Key]    Script Date: 16/08/2016 19:00:17 ******/
CREATE CLUSTERED INDEX [ix_sb_prospecto_contraoferta_Key] ON [sb_prospecto_contraoferta]
(
	[pr_cliente],
	[pr_operacion],
	[pr_fecha_proceso]
)
GO


/****** Object:  Table [sb_recuperacion_castigo]    Script Date: 16/08/2016 19:00:17 ******/
SET ANSI_PADDING ON
GO
IF OBJECT_ID ('sb_recuperacion_castigo') IS NOT NULL
	DROP TABLE sb_recuperacion_castigo
GO
CREATE TABLE [sb_recuperacion_castigo](
	[sr_fecha_carga] [datetime] NULL,
	[sr_banco] [varchar](24) NULL,
	[sr_docid] [varchar](30) NULL,
	[sr_anio_cas] [char](4) NULL,
	[sr_saldo] [money] NULL,
	[sr_indicador_ges] [varchar](64) NULL,
	[sr_indicador_cont] [varchar](64) NULL,
	[sr_fecha_castigo] [datetime] NULL
)
GO

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [sb_recuperacion_castigo]
(
	[sr_fecha_carga],
	[sr_banco]
)
GO


/****** Object:  Table [sb_repuntuacion]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_repuntuacion') IS NOT NULL
	DROP TABLE sb_repuntuacion
GO
CREATE TABLE [sb_repuntuacion](
	[re_tramite] [int] NULL,
	[re_fecha_repuntuacion] [datetime] NULL,
	[re_tipo_proceso] [int] NULL
)

GO

/****** Object:  Table [sb_respuestas_variables_mir]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_respuestas_variables_mir') IS NOT NULL
	DROP TABLE sb_respuestas_variables_mir
GO
CREATE TABLE [sb_respuestas_variables_mir](
	[rv_fecha] [datetime] NOT NULL,
	[rv_tramite] [int] NOT NULL,
	[rv_variable] [varchar](255) NULL,
	[rv_valor] [varchar](8000) NULL,
	[rv_fecha_resp] [datetime] NULL,
	[rv_orden] [int] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_respuestas_variables_mir]
(
	[rv_fecha],
	[rv_tramite]
)
GO


/****** Object:  Table [sb_ruta_filtros]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_ruta_filtros') IS NOT NULL
	DROP TABLE sb_ruta_filtros
GO
CREATE TABLE [sb_ruta_filtros](
	[rf_fecha] [datetime] NOT NULL,
	[rf_ruta] [int] NULL,
	[rf_descripcion] [varchar](64) NULL,
	[rf_estado] [catalogo] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_ruta_filtros]
(
	[rf_fecha]
)
GO


/****** Object:  Table [sb_seguros_estadistica]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_seguros_estadistica') IS NOT NULL
	DROP TABLE sb_seguros_estadistica
GO
CREATE TABLE [sb_seguros_estadistica](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_seguros_estadistica]
(
	[se_fecha],
	[se_banco]
)
GO


/****** Object:  Table [sb_seguros_tramite]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_seguros_tramite') IS NOT NULL
	DROP TABLE sb_seguros_tramite
GO
CREATE TABLE [sb_seguros_tramite](
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

CREATE UNIQUE CLUSTERED INDEX [idx1] ON [sb_seguros_tramite]
(
	[st_fecha],
	[st_aplicativo],
	[st_secuencial_seguro],
	[st_tipo_seguro],
	[st_tramite]
)
GO


/****** Object:  Table [sb_traslado]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_traslado') IS NOT NULL
	DROP TABLE sb_traslado
GO
CREATE TABLE [sb_traslado](
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

/****** Object:  Table [sb_traslado_ctas_ca_ah]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_traslado_ctas_ca_ah') IS NOT NULL
	DROP TABLE sb_traslado_ctas_ca_ah
GO
CREATE TABLE [sb_traslado_ctas_ca_ah](
	[tc_fecha_corte] [datetime] NULL,
	[tc_cliente] [int] NULL,
	[tc_oficina_ini] [int] NULL,
	[tc_oficina_fin] [int] NULL,
	[tc_tipo_prod] [char](1) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_traslado_ctas_ca_ah]
(
	[tc_fecha_corte],
	[tc_cliente]
)
GO


/****** Object:  Table [sb_traslado_detalle]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_traslado_detalle') IS NOT NULL
	DROP TABLE sb_traslado_detalle
GO
CREATE TABLE [sb_traslado_detalle](
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

/****** Object:  Table [sb_val_oper_finagro]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_val_oper_finagro') IS NOT NULL
	DROP TABLE sb_val_oper_finagro
GO
CREATE TABLE [sb_val_oper_finagro](
	[vo_operacion] [varchar](25) NULL,
	[vo_ced_ruc] [numero] NULL,
	[vo_tipo_ruc] [char](2) NULL,
	[vo_oper_finagro] [varchar](30) NULL,
	[vo_num_gar] [varchar](30) NULL,
	[vo_fecha] [datetime] NULL,
	[vo_aplicativo] [int] NULL
)
GO

/****** Object:  Index [sb_val_oper_finagro_1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_val_oper_finagro_1] ON [sb_val_oper_finagro]
(
	[vo_fecha]
)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [sb_val_oper_finagro_2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [sb_val_oper_finagro_2] ON [sb_val_oper_finagro]
(
	[vo_operacion]
)
GO


/****** Object:  Table [sb_valor_variables_filtros]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_valor_variables_filtros') IS NOT NULL
	DROP TABLE sb_valor_variables_filtros
GO
CREATE TABLE [sb_valor_variables_filtros](
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

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_valor_variables_filtros]
(
	[vv_fecha]
)
GO
/****** Object:  Index [idx2]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [sb_valor_variables_filtros]
(
	[vv_tramite]
)
GO
/****** Object:  Index [idx3]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [sb_valor_variables_filtros]
(
	[vv_ente]
)
GO


/****** Object:  Table [sb_variables_entrada_mir]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_variables_entrada_mir') IS NOT NULL
	DROP TABLE sb_variables_entrada_mir
GO
CREATE TABLE [sb_variables_entrada_mir](
	[ve_fecha] [datetime] NOT NULL,
	[ve_fecha_cons] [datetime] NOT NULL,
	[ve_tramite] [int] NOT NULL,
	[ve_orden] [int] NOT NULL,
	[ve_tipo] [smallint] NULL,
	[ve_identificador] [varchar](255) NULL,
	[ve_valor] [varchar](255) NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_variables_entrada_mir]
(
	[ve_fecha],
	[ve_tramite]
)
GO


/****** Object:  Table [sb_variables_filtros]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_variables_filtros') IS NOT NULL
	DROP TABLE sb_variables_filtros
GO
CREATE TABLE [sb_variables_filtros](
	[vf_fecha] [datetime] NOT NULL,
	[vf_filtro] [int] NULL,
	[vf_variable] [int] NULL,
	[vf_condicion] [int] NULL,
	[vf_operador] [char](2) NULL,
	[vf_valor_referencial] [varchar](64) NULL,
	[vf_puntaje] [catalogo] NULL
)
GO

/****** Object:  Index [idx1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [sb_variables_filtros]
(
	[vf_fecha]
)
GO


/****** Object:  Table [sb_venta_universo]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_venta_universo') IS NOT NULL
	DROP TABLE sb_venta_universo
GO
CREATE TABLE [sb_venta_universo](
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

/****** Object:  Index [idx_1]    Script Date: 16/08/2016 19:00:17 ******/
CREATE NONCLUSTERED INDEX [idx_1] ON [sb_venta_universo]
(
	[vu_fecha],
	[vu_aplicativo],
	[operacion_interna]
)
GO

/****** Object:  Table [sb_dato_provision]    Script Date: 16/08/2016 19:00:17 ******/
IF OBJECT_ID ('sb_dato_provision') IS NOT NULL
	DROP TABLE sb_dato_provision
GO

CREATE TABLE [dbo].[sb_dato_provision](
	[dp_banco] [varchar](24) NULL,
	[dp_clase_cartera] [varchar](10) NULL,
	[dp_tipo_cartera] [dbo].[catalogo] NULL,
	[dp_subtipo_cartera] [dbo].[catalogo] NULL,
	[dp_calificacion] [varchar](10) NULL,
	[dp_dias_mora] [int] NULL,
	[dp_dias_mora_op_ant] [int] NULL,
	[dp_estado_cartera] [tinyint] NULL,
	[dp_saldo_cap_liq] [money] NULL,
	[dp_saldo_cap_hip] [money] NULL,
	[dp_saldo_cap_des] [money] NULL,
	[dp_saldo_int_liq] [money] NULL,
	[dp_saldo_int_hip] [money] NULL,
	[dp_saldo_int_des] [money] NULL,
	[dp_provision_cap] [money] NULL,
	[dp_provision_int] [money] NULL
) ON [PRIMARY]
GO

IF OBJECT_ID ('sb_factor_atr') IS NOT NULL
   DROP TABLE sb_factor_atr
GO

CREATE TABLE sb_factor_atr
(
   fa_periodo_cuota   int,   -- en dias: 7,10,14,15,30,60,90,180
   fa_atr             float  -- por periodo cuota: 7:0.23; 60:2.00; 90:3.00; 180:6.00
)
GO

IF OBJECT_ID ('sb_sumando_z') IS NOT NULL
   DROP TABLE sb_sumando_z
GO

CREATE TABLE sb_sumando_z
(
   sz_toperacion    catalogo,
   sz_sumando       int,
   sz_valor         float
)
GO

IF OBJECT_ID ('sb_cuota_p_pago') IS NOT NULL
   DROP TABLE sb_cuota_p_pago
GO

CREATE TABLE sb_cuota_p_pago
(
   pp_toperacion      catalogo,
   pp_periodo_cuota   int,   -- en dias: 7,10,14,15,30,60,90,180
   pp_cuotas          int
)
GO

IF OBJECT_ID ('sb_severidad_perdida') IS NOT NULL
   DROP TABLE sb_severidad_perdida
GO

CREATE TABLE sb_severidad_perdida
(
   sp_toperacion   catalogo,
   sp_atr_minimo   float,
   sp_atr_maximo   float,
   sp_severidad    float
)


CREATE NONCLUSTERED INDEX idx_1 ON sb_severidad_perdida
(
   sp_toperacion
)

CREATE NONCLUSTERED INDEX idx2 ON sb_severidad_perdida
(
   sp_atr_minimo,
   sp_atr_maximo
)


GO

IF OBJECT_ID ('sb_dato_sumando_z') IS NOT NULL
   DROP TABLE sb_dato_sumando_z
GO

CREATE TABLE sb_dato_sumando_z
(
   ds_fecha           datetime,
   ds_banco           varchar(24),
   ds_cliente         int,
   ds_toperacion      catalogo,
   ds_sumando_z0      float,
   ds_sumando_z1      float,
   ds_sumando_z2      float,
   ds_sumando_z3      float,
   ds_sumando_z4      float,
   ds_sumando_z5      float,
   ds_sumando_z6      float,
   ds_sumando_z7      float,
   ds_sumando_z8      float,
   ds_atr             float		null,
   ds_atr_max         float		null,
   ds_cociente_pago   float		null,
   ds_riesgo          catalogo	null
)

CREATE UNIQUE nonclustered INDEX idx1
ON sb_dato_sumando_z(ds_fecha,ds_banco,ds_toperacion)
GO


IF OBJECT_ID ('sb_base_A0420') IS NOT NULL
   DROP TABLE sb_base_A0420
GO

CREATE TABLE sb_base_A0420
(
    cliente                   varchar(30) not null,
    banco                     varchar(30) not null,
    toperacion                varchar(30) not null,

    sal_ini_cap_ven_nex       varchar(30) null,
    sal_ini_cap_ven_exi       varchar(30) null,
    sal_ini_int_ven_exi       varchar(30) null,

    e_vcto_cart_cap_ven_nex   varchar(30) null,
    e_comp_cart_cap_ven_nex   varchar(30) null,
    s_vcto_cuot_cap_ven_nex   varchar(30) null,
    s_regr_vige_cap_ven_nex   varchar(30) null,
    s_cast_quit_cap_ven_nex   varchar(30) null,
    s_pagos_cap_ven_nex       varchar(30) null,

    e_vcto_cart_cap_ven_exi   varchar(30) null,
    e_comp_cart_cap_ven_exi   varchar(30) null,
    s_vcto_cuot_cap_ven_exi   varchar(30) null,
    s_regr_vige_cap_ven_exi   varchar(30) null,
    s_cast_quit_cap_ven_exi   varchar(30) null,
    s_pagos_cap_ven_exi       varchar(30) null,

    e_vcto_cart_int_ven_exi   varchar(30) null,
    e_comp_cart_int_ven_exi   varchar(30) null,
    s_vcto_cuot_int_ven_exi   varchar(30) null,
    s_regr_vige_int_ven_exi   varchar(30) null,
    s_cast_quit_int_ven_exi   varchar(30) null,
    s_pagos_cap_int_exi       varchar(30) null,

    sal_fin_cap_ven_nex       varchar(30) null,
    sal_fin_cap_ven_exi       varchar(30) null,
    sal_fin_int_ven_exi       varchar(30) null
)
GO


IF OBJECT_ID ('sb_base_A0424') IS NOT NULL
   DROP TABLE sb_base_A0424
GO

CREATE TABLE sb_base_A0424
(
    cliente                      varchar(30) not null,
    banco                        varchar(30) not null,
    toperacion                   varchar(30) not null,

    sal_ini_cap_vig_nex          varchar(30) null,
    sal_ini_cap_vig_exi          varchar(30) null,
    sal_ini_int_vig_nex          varchar(30) null,
    sal_ini_int_vig_exi          varchar(30) null,

    e_otorgamiento_cap_vig_nex   varchar(30) null,
    e_comp_cart_cap_vig_nex      varchar(30) null,
    e_regr_vige_cap_vig_nex      varchar(30) null,
    s_venc_rees_ren_cap_vig_nex  varchar(30) null,
    s_pagos_cap_vig_nex          varchar(30) null,
    s_daci_pago_cap_vig_nex      varchar(30) null,
    s_vcto_cart_cap_vig_nex      varchar(30) null,
    s_vcto_cuot_cap_vig_nex      varchar(30) null,
    s_cast_quit_cap_vig_nex      varchar(30) null,

    e_vcto_cuot_cap_vig_exi      varchar(30) null,
    e_comp_cart_cap_vig_exi      varchar(30) null,
    e_regr_vige_cap_vig_exi      varchar(30) null,
    s_venc_rees_ren_cap_vig_exi  varchar(30) null,
    s_pagos_cap_vig_exi          varchar(30) null,
    s_daci_pago_cap_vig_exi      varchar(30) null,
    s_vcto_cart_cap_vig_exi      varchar(30) null,
    s_cast_quit_cap_vig_exi      varchar(30) null,

    e_deve_int_vig_nex           varchar(30) null,
    e_comp_cart_int_vig_nex      varchar(30) null,
    e_regr_vige_int_vig_nex      varchar(30) null,
    s_venc_rees_ren_int_vig_nex  varchar(30) null,
    s_pagos_cap_int_vig_nex      varchar(30) null,
    s_daci_pago_int_vig_nex      varchar(30) null,
    s_vcto_cart_int_vig_nex      varchar(30) null,
    s_vcto_cuot_int_vig_nex      varchar(30) null,
    s_cast_quit_int_vig_nex      varchar(30) null,

    e_vcto_cuot_int_vig_exi      varchar(30) null,
    e_comp_cart_int_vig_exi      varchar(30) null,
    e_regr_vige_int_vig_exi      varchar(30) null,
    s_venc_rees_ren_int_vig_exi  varchar(30) null,
    s_pagos_cap_int_vig_exi      varchar(30) null,
    s_daci_pago_int_vig_exi      varchar(30) null,
    s_vcto_cart_int_vig_exi      varchar(30) null,
    s_cast_quit_int_vig_exi      varchar(30) null,

    sal_fin_cap_vig_nex          varchar(30) null,
    sal_fin_cap_vig_exi          varchar(30) null,
    sal_fin_int_vig_nex          varchar(30) null,
    sal_fin_int_vig_exi          varchar(30) null
)
GO


if exists (select 1 from sysobjects 
		where name = 'sb_reporte_A_0411' 
		and type = 'U')
	drop table sb_reporte_A_0411
go

create table sb_reporte_A_0411
(
	cliente			varchar(25) null,
	banco			cuenta null,
	toperacion		varchar(25) null,
	cuenta1			varchar(25) null,
	cuenta2			varchar(25) null,
	cuenta3			varchar(25) null,
	cuenta4			varchar(25) null,
	cuenta5			varchar(25) null,
	cuenta6			varchar(25) null,
	cuenta7			varchar(25) null,
	cta_provision	cuenta null,
	val_provision	varchar(25) null,
	calificacion	varchar(25) null,
	porc_riesgo		varchar(40) null
)
go

if exists (select 1 from  sysobjects where name='sb_base_A04219')
    drop table sb_base_A04219
go

create table sb_base_A04219 (
    ba_cliente         varchar(25),
    ba_banco           varchar(24),
    ba_toperacion      varchar(24),
    ba_provision_ini   varchar(25),
    ba_s_quitas        varchar(25),
    ba_s_castigos      varchar(25),
    ba_s_bonificacion  varchar(25),
    ba_s_daciones      varchar(25),
    ba_s_var_provision varchar(25),
    ba_s_var_cambiaria varchar(25),
    ba_e_bonificacion  varchar(25),
    ba_e_daciones      varchar(25),
    ba_e_var_provision varchar(25),
    ba_e_var_cambiaria varchar(25),
    ba_provision_fin   varchar(25)
)
go

if exists (select 1 from  sysobjects where name='sb_conta_elect')
    drop table sb_conta_elect
go

create table sb_conta_elect (
    [ce_entidad] [varchar](4) NULL,
    [ce_rfc] [varchar](13) NULL,
    [ce_mes] [varchar](2) NULL,
    [ce_anio] [varchar](4) NULL,
    [ce_nombre] [varchar](50) NULL,
    [ce_fecha_poliza] [varchar](10) NULL,
    [ce_concepto_poliza] [varchar](300) NULL,
    [ce_cuenta] [varchar](100) NULL,
    [ce_nombre_cuenta] [varchar](100) NULL,
    [ce_concepto] [varchar](200) NULL,
    [ce_saldo_ini] [varchar](17) NULL,
    [ce_debito] [varchar](17) NULL,
    [ce_credito] [varchar](17) NULL,
    [ce_saldo_fin] [varchar](17) NULL,
    [ce_referencia] [varchar](36) NULL,
    [ce_asiento] [int] NULL
    )
go

----------------------------------------------------------------
if exists (select 1 from  sysobjects where name = 'sb_ods_insolvencias')
    drop table sb_ods_insolvencias
go

create table sb_ods_insolvencias (
 oi_idf_cto_ods			varchar(25)   null,      
 oi_idf_pers_ods		int           null,        
 oi_cod_cta_cont        varchar(25)   null, 
 oi_cod_centro_cont     smallint      null,  
 oi_tip_sdo_insolvencia varchar(10)   null, 
 oi_cod_divisa          char(3)       null,
 oi_idf_concepto        char(1)       null,     
 oi_fec_data            varchar(10)   null,            
 oi_cod_entidad         tinyint       null,
 oi_cod_centro          smallint      null,       
 oi_cod_producto        tinyint       null,        
 oi_cod_subprodu        varchar(10)   null,
 oi_num_cuenta          varchar(25)   null,
 oi_tip_divisa          tinyint       null,
 oi_cod_tip_prov_mis    char(1)       null,
 oi_cod_tip_prov_loc    varchar(10)   null, 
 oi_ind_criterio_prov   char(1)       null,    
 oi_cod_riesgo_local    varchar(10)   null, 
 oi_cod_cartera         char(1)       null, 
 oi_imp_sdo_mo          money         null,
 oi_imp_sdo_ml          money         null,
 oi_registro_archivo    varchar(1000) null
)
go

if exists (select 1 from  sysobjects where name = 'sb_ods_movresultados')
    drop table sb_ods_movresultados
go

create table sb_ods_movresultados (
 om_num_cuenta			varchar(25)   null,      
 om_cod_cta_cont        varchar(25)   null, 
 om_cod_divisa          char(3)       null,
 om_fec_data            varchar(10)   null,            
 om_cod_pais            tinyint       null,
 om_cod_centro_cont     smallint      null,  
 om_cod_entidad         tinyint       null,
 om_imp_ie_mo           money         null,
 om_imp_ie_ml           money         null,
 om_registro_archivo    varchar(1000) null
)
go

if exists (select 1 from  sysobjects where name = 'sb_ods_plancuentas')
    drop table sb_ods_plancuentas
go

create table sb_ods_plancuentas (
 op_cod_cta_cont       varchar(25)   null, 
 op_cod_entidad        tinyint       null,
 op_des_cta_cont       varchar(64)   null,
 op_tip_cta_cont       varchar(2)    null,
 op_tip_divisa         tinyint       null,
 op_cls_sdo            char(1)       null,
 op_cod_est_sdo        char(2)       null,
 op_tip_acceso         char(1)       null,
 op_cod_est_cuenta     char(1)       null,
 op_fec_alta           varchar(10)   null,
 op_fec_baja           varchar(10)   null,
 op_fec_data           varchar(10)   null,
 op_registro_archivo   varchar(1000) null,
 op_cod_cargabal varchar(20) 
)
go
----------------------------------------------------------------

if exists (select 1 from  sysobjects where name = 'sb_ods_saldos_cont')
    drop table sb_ods_saldos_cont
go
create table sb_ods_saldos_cont(
os_cod_cta_cont        varchar(24) null,  
os_cod_centro_cont     int         null,
os_cod_divisa          varchar(3)  null,      
os_cod_entidad         int         null,     
os_tip_divisa          int         null,                   
os_sdo_mo              money       null,                       
os_sdo_ml              money       null, 
os_sdo_med_mo          money       null,      
os_sdo_med_ml          money       null,    
os_sdo_mes_mo          money       null,     
os_sdo_mes_ml          money       null,
os_fecha_corte 		   varchar(10) null
)    
go 

if exists (select 1 from  sysobjects where name = 'sb_ods_ult_ejec')
    drop table sb_ods_ult_ejec
go

create table  sb_ods_ult_ejec( 
ou_archivo         varchar(100)  null,
ou_fecha           datetime      null
)
go

if exists (select 1 from sysobjects where name='sb_riesgo_mora' and type = 'U') 
   drop table sb_riesgo_mora
go

create table sb_riesgo_mora (
    rm_entidad       varchar(1)  null,
    rm_codiser       varchar(2)  null,
    rm_ofiape        varchar(4)  null,
    rm_numecta       varchar(12) null,
    rm_digicta       varchar(1)  null,
    rm_indepeco      varchar(1)  null,
    rm_numrec        varchar(4)  null,
    rm_feliq         varchar(10) null,
    rm_capinire      varchar(16) null,
    rm_intinire      varchar(16) null,
    rm_cominire      varchar(16) null,
    rm_seginire      varchar(16) null,
    rm_gasinire      varchar(16) null,
    rm_ivaintinire   varchar(16) null,
    rm_ivacominire   varchar(16) null,
    rm_ivagasinire   varchar(16) null,
    rm_ivaseginire   varchar(16) null,
    rm_caprecre      varchar(16) null,
    rm_intecre       varchar(16) null,
    rm_comrecre      varchar(16) null,
    rm_segrecre      varchar(16) null,
    rm_gasrecre      varchar(16) null,
    rm_ivaintrecre   varchar(16) null,
    rm_ivacomrecre   varchar(16) null,
    rm_ivagasrecre   varchar(16) null,
    rm_ivasegrecre   varchar(16) null,
    rm_coemora       varchar(16) null,
    rm_coemosus      varchar(8)  null,
    rm_coemopen      varchar(10) null,
    rm_fecalmor      varchar(10) null,
    rm_fereten       varchar(10) null,
    rm_securet       varchar(3)  null,
    rm_salteor       varchar(16) null,
    rm_feiniliq      varchar(10) null,
    rm_edocont       varchar(1)  null,
    rm_tasa          varchar(8)  null,
    rm_intdeven      varchar(16) null,
    rm_morapend      varchar(16) null,
    rm_intrefin      varchar(16) null,
    rm_tipcam        varchar(11) null,
    rm_intbaseiva    varchar(16) null,
    rm_timestamp     varchar(26) null,
    rm_numter        varchar(3)  null,
    rm_usuario       varchar(3)  null,
    rm_ofiulmod      varchar(4)  null,
    rm_capinirea     varchar(16) null,
    rm_intinirea     varchar(16) null,
    rm_pagogob       varchar(16) null,
    rm_pagban        varchar(16) null,
    rm_intrefina     varchar(16) null,
    rm_salteora      varchar(16) null,
    rm_intmora       varchar(16) null,
    rm_intmoran      varchar(16) null,
    rm_intmorac      varchar(16) null,
    rm_ivamora       varchar(16) null,
    rm_edocont2      varchar(1)  null,
    rm_garaejer      varchar(1)  null,
    rm_ofiape4       varchar(4)  null,
    rm_ofiulmod4     varchar(4)  null,
    rm_combcoini     varchar(16) null,
    rm_comfovini     varchar(16) null,
    rm_combcorec     varchar(16) null,
    rm_comfovrec     varchar(16) null,
    rm_sitpago       varchar(1)  null,
    rm_grupoid       varchar(16) null,
    rm_nrocliclo     varchar(4)  null,
    rm_grupoint      varchar(4)  null
)
go


if exists (select 1 from sysobjects where name = 'sb_riesgo_hrc' and type = 'U') 
   drop table sb_riesgo_hrc
go

create table sb_riesgo_hrc (
    rh_fec_info                     varchar(30)  null,
    rh_num_cred                     varchar(25)  null,
    rh_num_cliente_operativo        varchar(64)  null,
    rh_desc_nombre_cliente          varchar(255) null,
    rh_cod_entidad                  varchar(4)   null,
    rh_desc_entidad                 varchar(30)  null,
    rh_desc_sistema_origen          varchar(10)  null,
    rh_num_suc_titular              varchar(20)  null,
    rh_cod_producto                 varchar(2)   null,
    rh_cod_subproducto              varchar(4)   null,
    rh_desc_producto                varchar(25)  null,
    rh_desc_subproducto             varchar(255)  null,--caso#173628
    rh_flg_revolvente               varchar(10)  null,
    rh_flg_tratamiento_contable     varchar(10)  null,
    rh_cod_tipo_amortiza            varchar(10)  null,
    rh_desc_tipo_amortiza           varchar(30)  null,
    rh_num_cta_cheques              varchar(25)  null,
    rh_fec_formaliza                varchar(30)  null,
    rh_fec_vencimiento              varchar(30)  null,
    rh_cod_tasa                     varchar(9)   null,
    rh_desc_tasa                    varchar(15)  null,
    rh_flg_tasa_variable            varchar(10)  null,
    rh_fec_prox_revisa_tasa         varchar(30)  null,
    rh_cod_periodo_revisa_tasa      varchar(1)   null,
    rh_pct_tasa_cobr                varchar(50)  null,
    rh_num_puntos_spread            varchar(10)  null,
    rh_fec_ult_amort_incump_cap     varchar(30)  null,
    rh_fec_ult_amort_incump_int     varchar(30)  null,
    rh_num_doctos_vencidos          varchar(5)   null,
    rh_cod_periodo_capital          varchar(10)  null,
    rh_desc_periodo_capital         varchar(10)  null,
    rh_cod_periodo_intereses        varchar(10)  null,
    rh_desc_periodo_intereses       varchar(10)  null,
    rh_cod_bloqueo                  varchar(10)  null,
    rh_desc_bloqueo                 varchar(1)   null,
    rh_cod_moneda                   varchar(3)   null,
    rh_imp_concedido                varchar(30)  null,
    rh_imp_limite_credito           varchar(30)  null,
    rh_imp_disponible               varchar(30)  null,
    rh_imp_total_riesgo_sistema     varchar(30)  null,
    rh_imp_cap_noexig               varchar(30)  null,
    rh_imp_cap_exig                 varchar(30)  null,
    rh_imp_int_noexig               varchar(30)  null,
    rh_imp_int_exig                 varchar(30)  null,
    rh_imp_int_suspen               varchar(30)  null,
    rh_imp_inversion                varchar(30)  null,
    rh_imp_total_riesgo             varchar(30)  null,
    rh_fec_traspaso_vencido         varchar(30)  null,
    rh_num_linea_madre              varchar(64)  null,
    rh_flg_mora_sistema             varchar(10)  null,
    rh_fec_prox_corte               varchar(30)  null,
    rh_cod_pais_origen              varchar(10)  null,
    rh_cod_pais_residencia          varchar(10)  null,
    rh_cod_tipo_persona             varchar(32)  null,
    rh_cod_sector_economico         varchar(10)  null,
    rh_cod_unidad_negocio           varchar(1)   null,
    rh_cod_unidad_negocio_ope_ori   varchar(1)   null,
    rh_cod_sector_contable          varchar(1)   null,
    rh_cod_actividad_economica      varchar(10)  null,
    rh_desc_rfc                     varchar(255) null,
    rh_desc_pais_origen             varchar(64)  null,
    rh_desc_pais_residencia         varchar(64)  null,
    rh_desc_sector_economico        varchar(200) null,
    rh_desc_tipo_persona            varchar(64)  null,
    rh_desc_unidad_negocio          varchar(64)  null,
    rh_cod_localidad_dom_primario   varchar(64)  null,
    rh_desc_actividad_economica_esp varchar(200) null,
    rh_fec_prox_corte_prin          varchar(30)  null,
    rh_fec_prox_corte_int           varchar(30)  null,
    rh_fec_formaliza_ult_disp       varchar(30)  null,
    rh_imp_seguro_desempleo         varchar(30)  null,
    rh_imp_seguro_vida              varchar(30)  null,
    rh_flg_garantia                 varchar(30)  null,
    rh_pct_tasa_base                varchar(50)  null,
    rh_imp_pag_adelantado           varchar(30)  null,
    rh_num_ult_recibo_facturado     varchar(10)  null,
    rh_cod_bloq_disposicion         varchar(1)   null,
    rh_imp_pago_domiciliado         varchar(20)  null,
    rh_fec_cobranza                 varchar(10)  null,
    rh_pct_cat                      varchar(50)  null,
    rh_desc_tipo_solicitud          varchar(15)  null,
    rh_desc_canal                   varchar(15)  null,
    rh_fec_vencimiento_renovacion   varchar(10)  null,
    rh_fec_nacimiento               varchar(30)  null,
    rh_cod_estado_civil             varchar(10)  null,
    rh_cod_genero                   varchar(10)  null,
    rh_imp_ingreso_dispersion       varchar(10)  null,
    rh_flg_dispersion_ult_3m        varchar(10)  null,
    rh_cod_tipo_interviniente       varchar(1)   null,
    rh_cod_finalidad_credito        varchar(64)  null,
    rh_cod_periodo_capital1         varchar(10)  null,
    rh_cod_periodo_capital2         varchar(10)  null,
    rh_num_dias_atraso              varchar(10)  null,
    rh_num_plazo_remanente_dias     varchar(10)  null,
	rh_integrantes_grupo            varchar(10)  null,
	rh_ciclo_individual             varchar(10)  null,
	rh_ciclo_grupal                 varchar(10)  null
)
go

create clustered index idx1 on sb_riesgo_hrc(rh_num_cred)

/* TABLAS TEMPORALES PARA EL REPORTE DE ESTADO DE CUENTA */
if exists(select 1 from sysobjects where name = 'sb_estcta_cab_tmp ')
    drop table sb_estcta_cab_tmp
go

CREATE TABLE sb_estcta_cab_tmp (
    ec_cod_sucursal             int         ,
    ec_sucursal                 varchar(100),
    ec_producto                 varchar(100),
    ec_nombre_cliente           varchar(100),
    ec_cod_grupo                int         ,
    ec_nom_grupo                varchar(100),
    ec_rfc                      varchar(30) ,
    ec_operacion                varchar(30) ,
    ec_calle                    varchar(70)  null,
    ec_numero                   int          null,
    ec_parroquia                varchar(100) null,
    ec_delegacion               varchar(100) null,
    ec_codigo_postal            varchar(64)  null,
    ec_estado                   varchar(64)  null,
    ec_fecha_inicio             varchar(10)  null,
    ec_fecha_reporte            varchar(10)  null,
    ec_dia_habil                varchar(10)  null,
    ec_importes                 varchar(40)  null,
    ec_folio_fiscal             varchar(1500)  null,
    ec_certificado              varchar(1500)  null,
    ec_sello_digital            varchar(1500) null,
    ec_sello_sat                varchar(1500) null,
    ec_no_de_serie_certificado  varchar(1500) null,
    ec_fecha_certificacion      varchar(20)  null,
    ec_cadena_origial_sat       varchar(1500) null,
    ec_estado_op                varchar(20) null,
	ec_rfc_emisor               varchar(30),
    ec_monto_factura            varchar(30)	
)
go

    CREATE CLUSTERED INDEX idx_1
	    ON dbo.sb_estcta_cab_tmp (ec_secuencial, ec_operacion)
GO

if exists(select 1 from sysobjects where name = 'sb_info_cre_tmp ')
    drop table sb_info_cre_tmp
go

create table sb_info_cre_tmp (
	ic_secuencial        INT,
	ic_limite_credito    MONEY,
	ic_saldo_inicial     MONEY,
	ic_interes_ordinario MONEY,
	ic_total_credito     MONEY,
	ic_capital           MONEY,
	ic_interes_par       MONEY,
	ic_iva_interes       MONEY,
	ic_total_parcial     MONEY,
	ic_base_calculo      MONEY,
	ic_saldo_final_cap   MONEY,
	ic_estado            VARCHAR (64),
	ic_fecha_inicio      VARCHAR (10),
	ic_fecha_fin         VARCHAR (10),
	ic_frecuencia_pago   VARCHAR (64),
	ic_plazo             INT,
	ic_dia_pago          VARCHAR (30),
	ic_tasa_ordinaria    FLOAT,
	ic_tasa_mensual      FLOAT,
	ic_dep_garantias     MONEY,
	ic_fec_dep_garantias VARCHAR (10),
	ic_cat               FLOAT,
	ic_comisiones        MONEY,
	ic_banco             VARCHAR (30),
	)

    CREATE CLUSTERED INDEX idx_1
	    ON dbo.sb_info_cre_tmp (ic_secuencial, ic_banco)
GO

if exists(select 1 from sysobjects where name = 'sb_movimientos_tmp ')
    drop table sb_movimientos_tmp
go

create table sb_movimientos_tmp(
	mov_secuencial     INT,
	mov_numero         INT,
	mov_fecha          DATETIME,
	mov_fecha_pactada  DATETIME,
	mov_numero_pago    INT,
	mov_dias_atraso    INT,
	mov_detalle_mov    VARCHAR (100),
	mov_total          MONEY,
	mov_capital        MONEY,
	mov_interes_ordina MONEY,
	mov_interes_mora   MONEY,
	mov_iva_int_pag    MONEY,
	mov_iva_imo_pag    MONEY,
	mov_iva_pre_pag    MONEY,
	mov_comision_cob   MONEY,
	mov_otros          MONEY,
	mov_saldo_capital  MONEY,
	mov_dividendo      INT,
	mov_banco          VARCHAR(30)
	)
	
    CREATE CLUSTERED INDEX idx_1
	    ON dbo.sb_movimientos_tmp (mov_secuencial, mov_banco)
GO

if exists(select 1 from sysobjects where name = 'sb_amortizacion_tmp ')
    drop table sb_amortizacion_tmp
go
create table sb_amortizacion_tmp(
	am_secuencial     INT,
	am_numero         INT,
	am_fecha          DATETIME,
	am_capital        MONEY,
	am_interes_ordina MONEY,
	am_iva_int        MONEY,
	am_comision_cob   MONEY,
	am_iva_comision   MONEY,
	am_monto_pago     MONEY,
	am_saldo_capital  MONEY,
	am_banco          VARCHAR (30),	
	am_pago_total     MONEY,
	)

    CREATE CLUSTERED INDEX idx_1
    	ON dbo.sb_amortizacion_tmp (am_secuencial, am_banco)
GO

if exists(select 1 from sysobjects where name = 'sb_dato_operacion_abono_temp ')
    drop table sb_dato_operacion_abono_temp
go

CREATE TABLE sb_dato_operacion_abono_temp
(
	doa_sec            INT IDENTITY (0,1) NOT NULL,
	doa_fecha_ope      DATETIME,
	doa_fecha_pac      DATETIME,
	doa_num_pago       INT,
	doa_dias_atra      INT,
	doa_detalle_mov    VARCHAR (100),
	doa_total          MONEY,
	doa_cap            MONEY,
	doa_inte_ord       MONEY,
	doa_gasto_cobranza MONEY,
	doa_saldo_cap      MONEY,
	doa_banco          VARCHAR (32),
	doa_fecha          DATETIME,
	doa_secuencial     int,
	doa_fpago          varchar(32)
)

    CREATE CLUSTERED INDEX idx_1
	    ON dbo.sb_dato_operacion_abono_temp (doa_secuencial, doa_banco)
go
--///////////////////////////

/* CON OPERACIONES PARTICULARES */
if exists(select 1 from sysobjects where name = 'sb_operacion_tmp ')
    drop table sb_operacion_tmp
go

CREATE TABLE sb_operacion_tmp (
ot_banco  varchar(32)
)
go
if exists(select 1 from sysobjects where name = 'sb_riesgo_provision ')
    drop table sb_riesgo_provision
go
create table sb_riesgo_provision(
Num_cred                varchar(24) null,
Num_cliente             varchar(20) null,
Num_grupo               varchar(10) null,
Cod_producto            varchar(2)  null,
Cod_subproducto         varchar(4)  null,
Cod_periodo_capital     varchar(1)  null,
Cod_periodo_intereses   varchar(1)  null,
Exig_T1                 varchar(20) null,
Pago_T1                 varchar(20) null,
Fec_Exig_T1             varchar(20) null,
Fec_Pago_T1             varchar(20) null,
Exig_T2                 varchar(20) null,
Pago_T2                 varchar(20) null,
Fec_Exig_T2             varchar(20) null,
Fec_Pago_T2             varchar(20) null,
Exig_T3                 varchar(20) null,
Pago_T3                 varchar(20) null,
Fec_Exig_T3             varchar(20) null,
Fec_Pago_T3             varchar(20) null,
Exig_T4                 varchar(20) null,
Pago_T4                 varchar(20) null,
Fec_Exig_T4             varchar(20) null,
Fec_Pago_T4             varchar(20) null,
Exig_T5                 varchar(20) null,
Pago_T5                 varchar(20) null,
Fec_Exig_T5             varchar(20) null,
Fec_Pago_T5             varchar(20) null,
Exig_T6                 varchar(20) null,
Pago_T6                 varchar(20) null,
Fec_Exig_T6             varchar(20) null,
Fec_Pago_T6             varchar(20) null,
Exig_T7                 varchar(20) null,
Pago_T7                 varchar(20) null,
Fec_Exig_T7             varchar(20) null,
Fec_Pago_T7             varchar(20) null,
Exig_T8                 varchar(20) null,
Pago_T8                 varchar(20) null,
Fec_Exig_T8             varchar(20) null,
Fec_Pago_T8             varchar(20) null,
Exig_T9                 varchar(20) null,
Pago_T9                 varchar(20) null,
Fec_Exig_T9             varchar(20) null,
Fec_Pago_T9             varchar(20) null,
Exig_T10                varchar(20) null,
Pago_T10                varchar(20) null,
Fec_Exig_T10            varchar(20) null,
Fec_Pago_T10            varchar(20) null,
Exig_T11                varchar(20) null,
Pago_T11                varchar(20) null,
Fec_Exig_T11            varchar(20) null,
Fec_Pago_T11            varchar(20) null,
Exig_T12                varchar(20) null,
Pago_T12                varchar(20) null,
Fec_Exig_T12            varchar(20) null,
Fec_Pago_T12            varchar(20) null,
Exig_T13                varchar(20) null,
Pago_T13                varchar(20) null,
Fec_Exig_T13            varchar(20) null,
Fec_Pago_T13            varchar(20) null,
Exig_T14                varchar(20) null,
Pago_T14                varchar(20) null,
Fec_Exig_T14            varchar(20) null,
Fec_Pago_T14            varchar(20) null,
Exig_T15                varchar(20) null,
Pago_T15                varchar(20) null,
Fec_Exig_T15            varchar(20) null,
Fec_Pago_T15            varchar(20) null,
Exig_T16                varchar(20) null,
Pago_T16                varchar(20) null,
Fec_Exig_T16            varchar(20) null,
Fec_Pago_T16            varchar(20) null,
Imp_total_riesgo        varchar(20) null,
Integrantes             varchar(4)  null,
Ciclos                  varchar(4)  null,
Exig_T17             	varchar(20) null,
Pago_T17	            varchar(20) null,
Fec_Exig_T17	        varchar(20) null,
Fec_Pago_T17	        varchar(20) null,
Exig_T18	            varchar(20) null,
Pago_T18	            varchar(20) null,
Fec_Exig_T18	        varchar(20) null,
Fec_Pago_T18	        varchar(20) null,
Exig_T19	            varchar(20) null,
Pago_T19	            varchar(20) null,
Fec_Exig_T19	        varchar(20) null,
Fec_Pago_T19	        varchar(20) null,
Exig_T20	            varchar(20) null,
Pago_T20	            varchar(20) null,
Fec_Exig_T20	        varchar(20) null,
Fec_Pago_T20	        varchar(20) null,
Exig_T21	            varchar(20) null,
Pago_T21	            varchar(20) null,
Fec_Exig_T21	        varchar(20) null,
Fec_Pago_T21	        varchar(20) null,
Exig_T22	            varchar(20) null,
Pago_T22	            varchar(20) null,
Fec_Exig_T22	        varchar(20) null,
Fec_Pago_T22	        varchar(20) null,
Exig_T23	            varchar(20) null,
Pago_T23	            varchar(20) null,
Fec_Exig_T23	        varchar(20) null,
Fec_Pago_T23	        varchar(20) null,
Exig_T24	            varchar(20) null,
Pago_T24	            varchar(20) null,
Fec_Exig_T24	        varchar(20) null,
Fec_Pago_T24	        varchar(20) null, 
Folio_Consulta_Buro     varchar(64) null
)
go

IF OBJECT_ID ('dbo.sb_mov_diario_tmp') IS NOT NULL
	DROP table dbo.sb_mov_diario_tmp
go

create table dbo.sb_mov_diario_tmp
	(
	mdt_concepto     varchar (160),
	mdt_fecha_tran   varchar (10),
	mdt_comprobante  varchar (20),
	mdt_cuenta       varchar (32),
	mdt_oficina_dest varchar (20),
	mdt_area_dest    varchar (20),
	mdt_debito       varchar (20),
	mdt_credito      varchar (20),
	mdt_prestamo 	 varchar (20),
	mdt_grupo 		 varchar (20) 
	)
go


IF OBJECT_ID ('dbo.sb_riesgo_hrc_lcr') IS NOT NULL
    DROP TABLE dbo.sb_riesgo_hrc_lcr
GO

create table sb_riesgo_hrc_lcr(
   FECHA_INFO                    varchar(30)  null,
   NUM_CRED                      varchar(25)  null,
   NUM_CLIENTE_OPERATIVO         varchar(64)  null,
   DESC_NOMBRE_CLIENTE           varchar(255) null,
   COD_ENTIDAD                   varchar(4)   null,
   DESC_ENTIDAD                  varchar(30)  null,
   DESC_SISTEMA_ORIG             varchar(10)  null,
   NUM_SUC_TITULAR               varchar(20)  null,
   COD_PRODUCTO                  varchar(2)   null,
   COD_SUBPRODUCTO               varchar(4)   null,
   DESC_PRODUCTO                 varchar(25)  null,
   DESC_SUBPRODUCTO              varchar(20)  null,
   FLG_REVOLVENTE                varchar(10)  null,
   FLG_TRATAMIENTO_CONTABLE      varchar(10)  null,
   COD_TIPO_AMORTIZA             varchar(10)  null,
   DESC_TIPO_AMORTIZA            varchar(30)  null,
   NUM_CTA_CHEQUES               varchar(25)  null,
   FEC_FORMALIZA                 varchar(30)  null,
   FEC_VENCIMIENTO               varchar(30)  null,
   COD_TASA                      varchar(9)   null,
   DESC_TASA                     varchar(15)  null,
   FLG_TASA_VARIABLE             varchar(10)  null,
   FEC_PROX_REVISA_TASA          varchar(30)  null,
   COD_PERIODO_REVISA_TASA       varchar(1)   null,
   PCT_TASA_COBR                 varchar(50)  null,
   NUM_PUNTOS_SPREAD             varchar(10)  null,
   FEC_ULT_AMORT_INCUMP_CAP      varchar(30)  null,
   FEC_ULT_AMORT_INCUMP_INT      varchar(30)  null,
   NUM_DOCTOS_VENCIDOS           varchar(5)   null,
   COD_PERIODO_CAPITAL           varchar(10)  null,
   DESC_PERIODO_CAPITAL          varchar(10)  null,
   COD_PERIODO_INTERESES         varchar(10)  null,
   DESC_PERIODO_INTERESES        varchar(10)  null,
   COD_BLOQUEO                   varchar(10)  null,
   DESC_BLOQUEO                  varchar(1)   null,
   COD_MONEDA                    varchar(3)   null,
   IMP_CONCEDIDO                 varchar(30)  null,
   IMP_LIMITE_CREDITO            varchar(30)  null,
   IMP_DISPONIBLE                varchar(30)  null,
   IMP_TOTAL_RIESGO_SISTEMA      varchar(30)  null,
   IMP_CAP_NOEXIG                varchar(30)  null,
   IMP_CAP_EXIG                  varchar(30)  null,
   IMP_INT_NOEXIG                varchar(30)  null,
   IMP_INT_EXIG                  varchar(30)  null,
   IMP_INT_SUSPEN                varchar(30)  null,
   IMP_INVERSION                 varchar(30)  null,
   IMP_TOTAL_RIESGO              varchar(30)  null,
   FEC_TRASPASO_VENCIDO          varchar(30)  null,
   NUM_LINEA_MADRE               varchar(64)  null,
   FLG_MORA_SISTEMA              varchar(10)  null,
   FEC_PROX_CORTE                varchar(30)  null,
   COD_PAIS_ORIGEN               varchar(10)  null,
   COD_PAIS_RESIDENCIA           varchar(10)  null,
   COD_TIPO_PERSONA              varchar(32)  null,
   COD_SECTOR_ECONOMICO          varchar(10)  null,
   COD_UNIDAD_NEGOCIO            varchar(1)   null,
   COD_UNIDAD_NEGOCIO_OPE_ORI    varchar(1)   null,
   COD_SECTOR_CONTABLE           varchar(1)   null,
   COD_ACTIVIDAD_ECONOMICA       varchar(10)  null,
   DESC_RFC                      varchar(255) null,
   DESC_PAIS_ORIGEN              varchar(64)  null,
   DESC_PAIS_RESIDENCIA          varchar(64)  null,
   DESC_SECTOR_ECONOMICO         varchar(200) null,
   DESC_TIPO_PERSONA             varchar(64)  null,
   DESC_UNIDAD_NEGOCIO           varchar(64)  null,
   COD_LOCALIDAD_DOM_PRIMARIO    varchar(64)  null,
   DESC_ACTIVIDAD_ECONOMICA_ESP  varchar(200) null,
   FEC_PROX_CORTE_PRIN           varchar(30)  null,
   FEC_PROX_CORTE_INT            varchar(30)  null,
   FEC_FORMALIZA_ULT_DISP        varchar(30)  null,
   IMP_SEGURO_DESEMPLEO          varchar(30)  null,
   IMP_SEGURO_VIDA               varchar(30)  null,
   FLG_GARANTIA                  varchar(30)  null,
   PCT_TASA_BASE                 varchar(50)  null,
   IMP_PAG_ADELANTADO            varchar(30)  null,
   NUM_ULT_RECIBO_FACTURADO      varchar(10)  null,
   COD_BLOQ_DISPOSICION          varchar(1)   null,
   IMP_PAGO_DOMICILIADO          varchar(20)  null,
   FEC_COBRANZA                  varchar(10)  null,
   PCT_CAT                       varchar(50)  null,
   DESC_TIPO_SOLICITUD           varchar(15)  null,
   DESC_CANAL                    varchar(15)  null,
   FEC_VENCIMIENTO_RENOVACION    varchar(10)  null,
   FEC_NACIMIENTO                varchar(30)  null,
   COD_ESTADO_CIVIL              varchar(10)  null,
   COD_GENERO                    varchar(10)  null,
   IMP_INGRESO_DISPERSION        varchar(10)  null,
   FLG_DISPERSION_ULT_3M         varchar(10)  null,
   COD_TIPO_INTERVINIENTE        varchar(1)   null,
   COD_FINALIDAD_CREDITO         varchar(64)  null,
   COD_PERIODO_CAPITAL_1         varchar(10)  null,
   DESC_PERIODO_CAPITAL_1        varchar(10)  null,
   NUM_DIAS_ATRASO               varchar(10)  null,
   NUM_PLAZO_REMANENTE_DIAS      varchar(10)  null,
   INTEGRANTES_GRUPO             varchar(10)  null,
   CICLO_INDIVIDUAL              varchar(10)  null
)
go

CREATE nonclustered INDEX sb_riesgo_hrc_lcr
	ON dbo.sb_riesgo_hrc_lcr (NUM_CRED)
GO 


if exists(select 1 from sysobjects where name = 'sb_lcr_riesgo_provision ')
    drop table sb_lcr_riesgo_provision
go
create table sb_lcr_riesgo_provision(
Num_cred                varchar(24) null,
Num_cliente             varchar(20) null,	
Cod_producto            varchar(2)  null,
Cod_subproducto         varchar(4)  null,
Cod_periodo_capital     varchar(1)  null,
Cod_periodo_intereses   varchar(1)  null,
Exig_T1                 varchar(20) null,
Pago_T1                 varchar(20) null,
Fec_Exig_T1             varchar(20) null,
Fec_Pago_T1             varchar(20) null,
Exig_T2                 varchar(20) null,
Pago_T2                 varchar(20) null,
Fec_Exig_T2             varchar(20) null,
Fec_Pago_T2             varchar(20) null,
Exig_T3                 varchar(20) null,
Pago_T3                 varchar(20) null,
Fec_Exig_T3             varchar(20) null,
Fec_Pago_T3             varchar(20) null,
Exig_T4                 varchar(20) null,
Pago_T4                 varchar(20) null,
Fec_Exig_T4             varchar(20) null,
Fec_Pago_T4             varchar(20) null,
Exig_T5                 varchar(20) null,
Pago_T5                 varchar(20) null,
Fec_Exig_T5             varchar(20) null,
Fec_Pago_T5             varchar(20) null,
Exig_T6                 varchar(20) null,
Pago_T6                 varchar(20) null,
Fec_Exig_T6             varchar(20) null,
Fec_Pago_T6             varchar(20) null,
Exig_T7                 varchar(20) null,
Pago_T7                 varchar(20) null,
Fec_Exig_T7             varchar(20) null,
Fec_Pago_T7             varchar(20) null,
Exig_T8                 varchar(20) null,
Pago_T8                 varchar(20) null,
Fec_Exig_T8             varchar(20) null,
Fec_Pago_T8             varchar(20) null,
Exig_T9                 varchar(20) null,
Pago_T9                 varchar(20) null,
Fec_Exig_T9             varchar(20) null,
Fec_Pago_T9             varchar(20) null,
Exig_T10                varchar(20) null,
Pago_T10                varchar(20) null,
Fec_Exig_T10            varchar(20) null,
Fec_Pago_T10            varchar(20) null,
Exig_T11                varchar(20) null,
Pago_T11                varchar(20) null,
Fec_Exig_T11            varchar(20) null,
Fec_Pago_T11            varchar(20) null,
Exig_T12                varchar(20) null,
Pago_T12                varchar(20) null,
Fec_Exig_T12            varchar(20) null,
Fec_Pago_T12            varchar(20) null,
Exig_T13                varchar(20) null,
Pago_T13                varchar(20) null,
Fec_Exig_T13            varchar(20) null,
Fec_Pago_T13            varchar(20) null,
Exig_T14                varchar(20) null,
Pago_T14                varchar(20) null,
Fec_Exig_T14            varchar(20) null,
Fec_Pago_T14            varchar(20) null,
Exig_T15                varchar(20) null,
Pago_T15                varchar(20) null,
Fec_Exig_T15            varchar(20) null,
Fec_Pago_T15            varchar(20) null,
Exig_T16                varchar(20) null,
Pago_T16                varchar(20) null,
Fec_Exig_T16            varchar(20) null,
Fec_Pago_T16            varchar(20) null,
Exig_T17                varchar(20) null,
Pago_T17                varchar(20) null,
Fec_Exig_T17            varchar(20) null,
Fec_Pago_T17            varchar(20) null,
Exig_T18                varchar(20) null,
Pago_T18                varchar(20) null,
Fec_Exig_T18            varchar(20) null,
Fec_Pago_T18            varchar(20) null,
Exig_T19                varchar(20) null,
Pago_T19                varchar(20) null,
Fec_Exig_T19            varchar(20) null,
Fec_Pago_T19            varchar(20) null,
Exig_T20                varchar(20) null,
Pago_T20                varchar(20) null,
Fec_Exig_T20            varchar(20) null,
Fec_Pago_T20            varchar(20) null,
Exig_T21                varchar(20) null,
Pago_T21                varchar(20) null,
Fec_Exig_T21            varchar(20) null,
Fec_Pago_T21            varchar(20) null,
Exig_T22                varchar(20) null,
Pago_T22                varchar(20) null,
Fec_Exig_T22            varchar(20) null,
Fec_Pago_T22            varchar(20) null,
Exig_T23                varchar(20) null,
Pago_T23                varchar(20) null,
Fec_Exig_T23            varchar(20) null,
Fec_Pago_T23            varchar(20) null,
Exig_T24                varchar(20) null,
Pago_T24                varchar(20) null,
Fec_Exig_T24            varchar(20) null,
Fec_Pago_T24            varchar(20) null,
Exig_T25                varchar(20) null,
Pago_T25                varchar(20) null,
Fec_Exig_T25            varchar(20) null,
Fec_Pago_T25            varchar(20) null,
Exig_T26                varchar(20) null,
Pago_T26                varchar(20) null,
Fec_Exig_T26            varchar(20) null,
Fec_Pago_T26            varchar(20) null,
Exig_T27                varchar(20) null,
Pago_T27                varchar(20) null,
Fec_Exig_T27            varchar(20) null,
Fec_Pago_T27            varchar(20) null,
Exig_T28                varchar(20) null,
Pago_T28                varchar(20) null,
Fec_Exig_T28            varchar(20) null,
Fec_Pago_T28            varchar(20) null,
Exig_T29                varchar(20) null,
Pago_T29                varchar(20) null,
Fec_Exig_T29            varchar(20) null,
Fec_Pago_T29            varchar(20) null,
Exig_T30                varchar(20) null,
Pago_T30                varchar(20) null,
Fec_Exig_T30            varchar(20) null,
Fec_Pago_T30            varchar(20) null,
Exig_T31                varchar(20) null,
Pago_T31                varchar(20) null,
Fec_Exig_T31            varchar(20) null,
Fec_Pago_T31            varchar(20) null,
Exig_T32                varchar(20) null,
Pago_T32                varchar(20) null,
Fec_Exig_T32            varchar(20) null,
Fec_Pago_T32            varchar(20) null,
Exig_T33                varchar(20) null,
Pago_T33                varchar(20) null,
Fec_Exig_T33            varchar(20) null,
Fec_Pago_T33            varchar(20) null,
Exig_T34                varchar(20) null,
Pago_T34                varchar(20) null,
Fec_Exig_T34            varchar(20) null,
Fec_Pago_T34            varchar(20) null,
Exig_T35                varchar(20) null,
Pago_T35                varchar(20) null,
Fec_Exig_T35            varchar(20) null,
Fec_Pago_T35            varchar(20) null,
Exig_T36                varchar(20) null,
Pago_T36                varchar(20) null,
Fec_Exig_T36            varchar(20) null,
Fec_Pago_T36            varchar(20) null,
Exig_T37                varchar(20) null,
Pago_T37                varchar(20) null,
Fec_Exig_T37            varchar(20) null,
Fec_Pago_T37            varchar(20) null,
Exig_T38                varchar(20) null,
Pago_T38                varchar(20) null,
Fec_Exig_T38            varchar(20) null,
Fec_Pago_T38            varchar(20) null,
Exig_T39                varchar(20) null,
Pago_T39                varchar(20) null,
Fec_Exig_T39            varchar(20) null,
Fec_Pago_T39            varchar(20) null,
Exig_T40                varchar(20) null,
Pago_T40                varchar(20) null,
Fec_Exig_T40            varchar(20) null,
Fec_Pago_T40            varchar(20) null,
Exig_T41                varchar(20) null,
Pago_T41                varchar(20) null,
Fec_Exig_T41            varchar(20) null,
Fec_Pago_T41            varchar(20) null,
Exig_T42                varchar(20) null,
Pago_T42                varchar(20) null,
Fec_Exig_T42            varchar(20) null,
Fec_Pago_T42            varchar(20) null,
Exig_T43                varchar(20) null,
Pago_T43                varchar(20) null,
Fec_Exig_T43            varchar(20) null,
Fec_Pago_T43            varchar(20) null,
Exig_T44                varchar(20) null,
Pago_T44                varchar(20) null,
Fec_Exig_T44            varchar(20) null,
Fec_Pago_T44            varchar(20) null,
Exig_T45                varchar(20) null,
Pago_T45                varchar(20) null,
Fec_Exig_T45            varchar(20) null,
Fec_Pago_T45            varchar(20) null,
Exig_T46                varchar(20) null,
Pago_T46                varchar(20) null,
Fec_Exig_T46            varchar(20) null,
Fec_Pago_T46            varchar(20) null,
Exig_T47                varchar(20) null,
Pago_T47                varchar(20) null,
Fec_Exig_T47            varchar(20) null,
Fec_Pago_T47            varchar(20) null,
Exig_T48                varchar(20) null,
Pago_T48                varchar(20) null,
Fec_Exig_T48            varchar(20) null,
Fec_Pago_T48            varchar(20) null,
Exig_T49                varchar(20) null,
Pago_T49                varchar(20) null,
Fec_Exig_T49            varchar(20) null,
Fec_Pago_T49            varchar(20) null,
Exig_T50                varchar(20) null,
Pago_T50                varchar(20) null,
Fec_Exig_T50            varchar(20) null,
Fec_Pago_T50            varchar(20) null,
Exig_T51                varchar(20) null,
Pago_T51                varchar(20) null,
Fec_Exig_T51            varchar(20) null,
Fec_Pago_T51            varchar(20) null,
Exig_T52                varchar(20) null,
Pago_T52                varchar(20) null,
Fec_Exig_T52            varchar(20) null,
Fec_Pago_T52            varchar(20) null,
Imp_total_riesgo        varchar(20) null,
Saldo_T1                varchar(20) null,
Saldo_T2                varchar(20) null,
Saldo_T3                varchar(20) null,
Saldo_T4                varchar(20) null,
Saldo_T5                varchar(20) null,
Saldo_T6                varchar(20) null,
Saldo_T7                varchar(20) null,
Saldo_T8                varchar(20) null,
Pago_SIC                varchar(10) null,
Monto_SIC               varchar(10) null,
Antig_SIC               varchar(10) null,
Meses                   varchar(10) null,
Imp_limite_corte        varchar(10) null,
Imp_limite_t1           varchar(10) null,
Imp_limite_t2           varchar(10) null,
Imp_limite_t3           varchar(10) null,
Imp_limite_t4           varchar(10) null,
Imp_limite_t5           varchar(10) null,
Imp_limite_t6           varchar(10) null,
Imp_limite_t7           varchar(10) null,
Imp_limite_t8           varchar(10) null,
Imp_pago_minimo_corte   varchar(20) null,
meses_apertura          varchar(10) null,
Imp_limite_fch_calculo  varchar(20) null,
Flg_Disp                varchar(1) null,
Flg_Mora                varchar(1) null,
Flag_Buro               varchar(1) null,
Flag_Adviser            varchar(1) null,
Flag_Atr_Ins            varchar(1) null,
Monto_Pagar_Ins         varchar(20) null,
Fec_Prim_Des            varchar(20) null, 
Folio_Consulta_Buro     varchar(64) null
)

create index idx_pr_lcr on sb_lcr_riesgo_provision(Num_cred)
go


use cob_conta_super
go

if exists(select 1 from sysobjects
           where name = 'sb_cuentas_N4')
   drop table sb_cuentas_N4
go

create table sb_cuentas_N4 (
	cn_ente		 		varchar(20),
	cn_p_apellido			varchar(50),
	cn_s_apellido 			varchar(50),
	cn_nombres				varchar(50),
	cn_num_sucursal		varchar(10),
	cn_rfc					varchar(20),
	cn_sexo				varchar(10),
	cn_nacionalidad		varchar(100),
	cn_edo_civil			varchar(20),
	cn_celular				varchar(20),
	cn_correo_electronico	varchar(100),
	cn_fecha_ingreso		varchar(20),
	cn_oficina				varchar(100),
	cn_colonia				varchar(100),
	cn_cod_postal			varchar(10),
	cn_ingreso_men_neto	varchar(50),
	cn_procesado			varchar(1) default 'N',
	cn_fecha_pro          datetime,
	cn_fecha_real         datetime
)
go

create index idx_1 on sb_cuentas_N4(cn_ente)
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_cuentas_N4_tmp') IS NOT NULL
	DROP table dbo.sb_cuentas_N4_tmp
go

create table dbo.sb_cuentas_N4_tmp
	(
	cn_ente_tmp               varchar (120),
	cn_p_apellido_tmp         varchar (120),
	cn_s_apellido_tmp         varchar (120),
	cn_nombres_tmp            varchar (120),
	cn_num_sucursal_tmp       varchar (120),
	cn_rfc_tmp                varchar (120),
	cn_sexo_tmp               varchar (120),
	cn_nacionalidad_tmp       varchar (100),
	cn_edo_civil_tmp          varchar (120),
	cn_celular_tmp            varchar (120),
	cn_correo_electronico_tmp varchar (100),
	cn_fecha_ingreso_tmp      varchar (120),
	cn_oficina_tmp            varchar (100),
	cn_colonia_tmp            varchar (100),
	cn_cod_postal_tmp         varchar (120),
	cn_ingreso_men_neto_tmp   varchar (120)
	)
go

create index idx_1
	on dbo.sb_cuentas_N4_tmp (cn_ente_tmp)
go


--====================================================================
--===============banxico==============================================
--=======obtimizacion caso  optimizacion de caso 122487 a 129694   
--===================================================================
use 
cob_conta_super
go
IF EXISTS (SELECT 1 FROM sysindexes WHERE name = 'index01' AND id=OBJECT_ID('sb_banxico_lcr'))
begin
    DROP INDEX sb_banxico_lcr.index01
end 


IF OBJECT_ID ('dbo.sb_banxico_lcr') IS NOT NULL
    DROP TABLE dbo.sb_banxico_lcr
GO
	create table sb_banxico_lcr
	(
		sb_id_producto      int, 
		sb_foliocredito		varchar(24),
		sb_limcredito		varchar(24),
		sb_saldotot			varchar(24),
		sb_pagongi			varchar(24),
		sb_saldorev			varchar(24),
		sb_interesrev       varchar(24),
		sb_saldopmsi        varchar(24),
		sb_meses            int,
		sb_pagomin          varchar(24),
		sb_tasarev           varchar(24),
		sb_saldopci         varchar(24),
		sb_interespci       varchar(24),
		sb_saldopagar       varchar(24),
		sb_pagoreal         varchar(24),
		sb_limcreditoa      varchar(24),
		sb_pagoexige        varchar(24),
		sb_impagosc         int,
		sb_impagosum        int,
		sb_mesapert         varchar(24),
		sb_saldocont        varchar(24),
		sb_situacion        int,
		sb_probinc			varchar(10),
		sb_sevper			varchar(10),
		sb_expinc           varchar(10),
		sb_mreserv          varchar(10),
		sb_relacion         int,
		sb_clascont         int,						 
		sb_cvecons          varchar(64),
		sb_limcreditocalif  varchar(24),
		sb_montopagarinst   varchar(24),
		sb_montopagarsic	varchar(1),
		sb_mesantig         varchar(1),
		sb_mesesic          varchar(4),
		sb_segmento         varchar(1),
		sb_gveces           varchar(1),
		sb_garantia         varchar(1),
		sb_catcuenta        varchar(24),
		sb_indicadorcat     varchar(1),
		sb_folio_cliente    int,
		sb_CP               int,     
		sb_comtotal         varchar(24),
		sb_comtardio        varchar(24),
		sb_pagongiinicio    varchar(24),
		sb_pagoexigepsi     varchar(24)
	)

CREATE CLUSTERED INDEX index01
	ON dbo.sb_banxico_lcr (sb_foliocredito)
GO


--================ BSA ================================================
--======= Caso 158406 - Geolocalización B2C - AutoOnboarding 168293 F2 
--=====================================================================
use cob_conta_super
go

if object_id ('sb_rpt_geolocaliza_b2c') is not null
	drop table sb_rpt_geolocaliza_b2c
go

create table sb_rpt_geolocaliza_b2c(
	FECHA				         varchar(10) null, 		
	TIPO_DE_TRANSACCION          varchar(64) null,
	BUC    				         varchar(20) null,
	NUMERO_DE_OPERACION          varchar(20) null,
	CUENTA    			         varchar(24) null,
	PRODUCTO    		         varchar(15) null,
	SUBPRODUCTO    		         varchar(15) null,
	APLICATIVO    		         varchar(11) null,
	LONGITUD    		         varchar(21) null,
	LATITUD    			         varchar(21) null,
	MONTO                        varchar(8)  null,
	HORA                         varchar(8)  null,
	ID_SESION                    varchar(10) null,
	CLASIFICACION_DE_OPERACIONES varchar(29) null,
	ESTATUS_DE_OPERACION         varchar(21) null,
	ID_OPERACION                 varchar(20) null
)
go
create index idx_rpt_geolocaliza_b2c
	on sb_rpt_geolocaliza_b2c(FECHA)
go
