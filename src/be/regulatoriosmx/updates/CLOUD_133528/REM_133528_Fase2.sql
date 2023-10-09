use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_rep_oper_mc_collect') IS NOT NULL
	DROP table dbo.sb_rep_oper_mc_collect
go
create table dbo.sb_rep_oper_mc_collect
	(
	secuencial_mc                        int identity not null,
	OFICINA                              varchar (64) not null,   --1
	REGION                               varchar (64) not null,   --2
	CC                                   varchar (40) not null,   --3
	CONTRATO                             varchar (24) not null,   --4
	[ID GRUPO]                           varchar (40) not null,	  --5
	[NOMBRE GRUPO]                       varchar (64) not null,   --6
	[CICLO GRUPAL]                       varchar (20)  not null,  --7
	[NUMERO DE INTEGRANTES]              varchar (30)  not null,  --8
	RFC                                  varchar (24) not null,   --9
	CURP                                 varchar (255) not null,  --10
	[CLIENTE COBIS]                      varchar (40) not null,	  --11
	[APELLIDO PATERNO]                   varchar (64) not null,   --12
	[APELLIDO MATERNO]                   varchar (64) not null,   --13
	NOMBRE1                              varchar (64) not null,   --14
	NOMBRE2                              varchar (64) not null,   --15
	[CICLO INDIVIDUAL]                   varchar (20)  not null,  --16
	GENERO                               varchar (10) not null,   --17
	EDAD                                 varchar (4)  not null,   --18
	DOM_TELEFONO                         varchar (16) not null,   --19
	DOM_DIRECCION                        varchar (254) not null,  --20
	ESTADO                               varchar (64) not null,   --21
	MUNICIPIO                            varchar (64) not null,   --22
	LOCALIDAD                            varchar (64) not null,   --23
	[C.P.]                               varchar (30)  not null,  --24
   [COORDENADAS DOMICILIO]              varchar (100) not null,   --25	
	NEG_TELEFONO                         varchar (16) not null,   --26
	NEG_DIRECCION                        varchar (254) not null,  --27
	NEG_ESTADO                           varchar (64) not null,   --28
	NEG_MUNICIPIO                        varchar (64) not null,   --29
	NEG_LOCALIDAD                        varchar (64) not null,   --30
	NEG_CP                               varchar (30) not null,	  --31
	[NEG_TIPO DE LOCAL]                  varchar (64) not null,   --32
	[ACTIVIDAD ECONOMICA]                varchar (200) not null,  --33
	[CORREO ELECTRONICO DEL CLIENTE]     varchar (254) not null,  --34
	[NOMBRE GERENTE]                     varchar (64) not null,   --35
	[NOMBRE COORDINADOR]                 varchar (64) not null,   --36
	[NOMBRE DEL ASESOR]                  varchar (64) not null,   --37
	[CORREO ELECTRONICO ASESOR]          varchar (64) not null,   --38
	[TELEFONO DEL ASESOR]                varchar (64) not null,   --39
	[ESTATUS ASESOR]                     varchar (64) not null,   --40
	[PRODUCTO DE PRESTAMOS]              varchar (40) not null,   --41
	[SUBPRODUCTO PRESTAMO]               varchar (64) not null,   --42
	[MONTO CREDITO]                      varchar (40) not null,	  --43
	[FECHA SOLICITUD]                    varchar (30) not null,   --44
	[FECHA APROBACION MONTOS]            varchar (30) not null,   --45
	[FECHA VENCIMIENTO PRESTAMO]         varchar (30) not null,   --46
	[NUMERO DE CONTRATO]                 varchar (24) not null,   --47
	PLAZO                                varchar (64) not null,   --48
	[NUMERO CUOTAS]                      varchar (40) not null,	  --49
	[DIA DE PAGO]                        varchar (20) not null,   --50
	[PLAZO DIAS]                         varchar (40) not null,	  --51
	[PLAZO MES]                          varchar (40) not null,   --52
	[VALOR CUOTA]                        varchar (40) not null,	  --53
	[CAPITAL DE LA CUOTA]                varchar (40) not null,	  --54
	[INTERESES DE LA CUOTA]              varchar (40) not null,	  --55
	[IVA DE LA CUOTA]                    varchar (40) not null,   --56
	[TASA INTERES (ANUAL)]               varchar (40) not null,   --57
	[CUOTAS PENDIENTES]                  varchar (40) not null,   --58
	[CUOTAS VENCIDAS]                    varchar (40) not null,   --59
	[CAPITAL VIGENTE EXIGIBLE]           varchar (40) not null,	  --60
	[CAPITAL VENCIDO EXIGIBLE]           varchar (40) not null,	  --61
	[SALDO CAP]                          varchar (40) not null,	  --62
	[INTERES VIGENTE EXIGIBLE]           varchar (40) not null,	  --63
	[INTERES SUSPENDIDO]                 varchar (40) not null,	  --64
	[IVA INTERES EXIGIBLE]               varchar (40) not null,	  --65
	[IVA INTERES NO EXIGIBLE]            varchar (40) not null,	  --66
	COMISIONES                           varchar (40) not null,	  --67
	[IVA COMISION]                       varchar (40) not null,	  --68
	[SALDO INTERESES]                    varchar (40) not null,	  --69
	[SALDO REAL EXIGIBLE]                varchar (40) not null,	  --70
	[SALDO TOTAL]                        varchar (40) not null,	  --71
	[SALDO TOTAL EN MORA]                varchar (40) not null,	  --72
	[IMPORTE LIQUIDA CON]                varchar (40) not null,	  --73
	[DIAS MAX ATRASO ACT]                varchar (40) not null,   --74
	[SEMANAS DE ATRASO]                  varchar (40) not null,	  --75
	[DIAS MORA]                          varchar (40) not null,   --76
	[FECHA RECIBO ANTIGUO IMP]           varchar (30) not null,   --77
	[FECHA ULTIMA SITUACION DEUDA]       varchar (30) not null,   --78
	[PORCENTAJE RESERVA]                 varchar (40) not null,   --79
	[CARTERA EN RIESGO]                  varchar (40) not null,   --80
	[NIVEL DE RIESGO]                    varchar (15) not null,	  --81
	[PUNTAJE DE RIESGO]                  varchar (20) not null,	  --82
	[ROL MESA DIRECTIVA]                 varchar (64) not null,   --83
	[INDICADOR DE REUNION]               varchar (125) not null,  --84
	[NUMERO DE EMPLEADO DEL ASESOR]      varchar (40) not null,   --85
	[NUMERO DE EMPLEADO DEL COORDINADOR] varchar (40) not null,   --86
	[NUMERO DE EMPLEADO DEL GERENTE]     varchar (40) not null,   --87
	[DIA DE REUNION SEMANAL]             varchar (40) not null,   --88
	[HORA DE REUNION SEMANAL]            varchar (30) not null,   --89
	[COORDENADAS NEGOCIO]                varchar (100) not null,  --90
	[NRO OPERACION GRUPAL]               varchar (24) not null,   --91
	[NVO DOM_DIRECCION]                  varchar (255) not null,  --92
   [NVO ESTADO]                         varchar (255) not null,  --93
   [NVO MUNICIPIO]                      varchar (255) not null,  --94
   [NVO LOCALIDAD]                      varchar (255) not null,  --95
   [NVO C.P.]                           varchar (40) not null ,  --96
   [NVAS COORDENADAS DOM]               varchar (255) not null,  --97
   [Foto del Domicilio]                 varchar (1000) not null,  --98
   [Entre calle 1 Dom]                  varchar (255) not null,  --99
   [Entre calle 2 Dom]                  varchar (255) not null,  --100
   [Entre calle 3 Dom]                  varchar (255) not null,  --101
   [Entre calle 4 Dom]                  varchar (255) not null,  --102
   [Foto del Negocio]                   varchar (1000) not null,  --103
   [Foto del Negocio 2]                 varchar (1000) not null,  --104
   [Entre calle 1 Neg]                  varchar (255) not null,  --105
   [Entre calle 2 Neg]                  varchar (255) not null,  --106
   [Entre calle 3 Neg]                  varchar (255) not null,  --107
   [Entre calle 4 Neg]                  varchar (255) not null,  --108
   [Foto del Domicilio Alterno]         varchar (1000) not null,  --109
   [Entre calle 1 Dom Alterno]          varchar (255) not null,  --110
   [Entre calle 2 Dom Alterno]          varchar (255) not null,  --111
   [Entre calle 3 Dom Alterno]          varchar (255) not null,  --112
   [Entre calle 4 Dom Alterno]          varchar (255) not null,  --113
   asesor_login_mc                      varchar (64)  not null,  --114
   asesor_cargo_mc                      varchar (64)  not null,  --115

	)
go


use cob_conta_super
go
if object_id ('dbo.sb_rep_ini_cobis_collect') is not null
	drop table dbo.sb_rep_ini_cobis_collect
go
create table dbo.sb_rep_ini_cobis_collect
	(
	mc_secuencial                     int identity not null,
	oficina                           varchar (64) not null,   --1
	region                            varchar (64) not null,   --2
	cc                                varchar (40) not null,   --3
	contrato                          varchar (24) not null,   --4
	id_grupo                          varchar (40) not null,   --5
	nombre_grupo                      varchar (64) not null,   --6
	ciclo_grupal                      varchar (20)  not null,  --7
	numero_integrantes                varchar (30)  not null,  --8
	rfc                               varchar (24) not null,   --9
	curp                              varchar (255) not null,  --10
	cliente_cobis                     varchar (40) not null,   --11
	apellido_paterno                  varchar (64) not null,   --12
	apellido_materno                  varchar (64) not null,   --13
	nombre1                           varchar (64) not null,   --14
	nombre2                           varchar (64) not null,   --15
	ciclo_individual                  varchar (20)  not null,  --16
	genero                            varchar (10) not null,   --17
	edad                              varchar (4)  not null,   --18
	dom_telefono                      varchar (16) not null,   --19
	dom_direccion                     varchar (254) not null,  --20
	estado                            varchar (64) not null,   --21
	municipio                         varchar (64) not null,   --22
	localidad                         varchar (64) not null,   --23
	c_p                               varchar (30)  not null,  --24
   coordenadas_domicilio             varchar (100) not null,   --25	
	neg_telefono                      varchar (16) not null,   --26
	neg_direccion                     varchar (254) not null,  --27
	neg_estado                        varchar (64) not null,   --28
	neg_municipio                     varchar (64) not null,   --29
	neg_localidad                     varchar (64) not null,   --30
	neg_cp                            varchar (30) not null,   --31
	neg_tipo_local                    varchar (64) not null,   --32
	actividad_economica               varchar (200) not null,  --33
	correo_electronico_cliente        varchar (254) not null,  --34
	nombre_gerente                    varchar (64) not null,   --35
	nombre_coordinador                varchar (64) not null,   --36
	nombre_asesor                     varchar (64) not null,   --37
	correo_electronico_asesor         varchar (64) not null,   --38
	telefono_asesor                   varchar (64) not null,   --39
	estatus_asesor                    varchar (64) not null,   --40
	producto_prestamos                varchar (40) not null,   --41
	subproducto_prestamo              varchar (64) not null,   --42
	monto_credito                     varchar (40) not null,   --43
	fecha_solicitud                   varchar (30) not null,   --44
	fecha_aprobacion_montos           varchar (30) not null,   --45
	fecha_vencimiento_prestamo        varchar (30) not null,   --46
	numero_contrato                   varchar (24) not null,   --47
	plazo                             varchar (64) not null,   --48
	numero_cuotas                     varchar (40) not null,	  --49
	dia_pago                          varchar (20) not null,   --50
	plazo_dias                        varchar (40) not null,	  --51
	plazo_mes                         varchar (40) not null,   --52
	valor_cuota                       varchar (40) not null,	  --53
	capital_cuota                     varchar (40) not null,	  --54
	intereses_cuota                   varchar (40) not null,	  --55
	iva_cuota                         varchar (40) not null,   --56
	tasa_interes_anual                varchar (40) not null,   --57
	cuotas_pendientes                 varchar (40) not null,   --58
	cuotas_vencidas                   varchar (40) not null,   --59
	capital_vigente_exigible          varchar (40) not null,	  --60
	capital_vencido_exigible          varchar (40) not null,	  --61
	saldo_cap                         varchar (40) not null,	  --62
	interes_vigente_exigible          varchar (40) not null,	  --63
	interes_suspendido                varchar (40) not null,	  --64
	iva_interes_exigible              varchar (40) not null,	  --65
	iva_interes_no_exigible           varchar (40) not null,	  --66
	comisiones                        varchar (40) not null,	  --67
	iva_comision                      varchar (40) not null,	  --68
	saldo_intereses                   varchar (40) not null,	  --69
	saldo_real_exigible               varchar (40) not null,	  --70
	saldo_total                       varchar (40) not null,	  --71
	saldo_total_mora                  varchar (40) not null,	  --72
	importe_liquida_con               varchar (40) not null,	  --73
	dias_max_atraso_act               varchar (40) not null,   --74
	semanas_atraso                    varchar (40) not null,	  --75
	dias_mora                         varchar (40) not null,   --76
	fecha_recibo_antiguo_imp          varchar (30) not null,   --77
	fecha_ultima_situacion_deuda      varchar (30) not null,   --78
	porcentaje_reserva                varchar (40) not null,   --79
	cartera_riesgo                    varchar (40) not null,   --80
	nivel_riesgo                      varchar (15) not null,	  --81
	puntaje_riesgo                    varchar (20) not null,	  --82
	rol_mesa_directiva                varchar (64) not null,   --83
	indicador_reunion                 varchar (125) not null,  --84
	numero_empleado_asesor            varchar (40) not null,   --85
	numero_empleado_coordinador       varchar (40) not null,   --86
	numero_empleado_gerente           varchar (40) not null,   --87
	dia_reunion_semanal               varchar (40) not null,   --88
	hora_reunion_semanal              varchar (30) not null,   --89
	coordenadas_negocio               varchar (100) not null,  --90
	nro_operacion_grupal              varchar (24) not null,   --91
	nvo_dom_direccion                 varchar (255) not null,  --92
   nvo_estado                         varchar (255) not null, --93
   nvo_municipio                      varchar (255) not null, --94
   nvo_localidad                      varchar (255) not null, --95
   nvo_c_p                            varchar (40) not null , --96
   nvas_coordenadas_dom               varchar (255) not null, --97
   foto_domicilio                     varchar (1000) not null, --98
   entre_calle_1_dom                  varchar (255) not null, --99
   entre_calle_2_dom                  varchar (255) not null, --100
   entre_calle_3_dom                  varchar (255) not null, --101
   entre_calle_4_dom                  varchar (255) not null, --102
   foto_negocio                       varchar (1000) not null, --103
   foto_negocio_2                     varchar (1000) not null, --104
   entre_calle_1_neg                  varchar (255) not null, --105
   entre_calle_2_neg                  varchar (255) not null, --106
   entre_calle_3_neg                  varchar (255) not null, --107
   entre_calle_4_neg                  varchar (255) not null, --108
   foto_domicilio_alterno             varchar (1000) not null, --109
   entre_calle_1_dom_alterno          varchar (255) not null, --110
   entre_calle_2_dom_alterno          varchar (255) not null, --111
   entre_calle_3_dom_alterno          varchar (255) not null, --112
   entre_calle_4_dom_alterno          varchar (255) not null, --113
   fecha_carga_real                   datetime,               --114
   fecha_carga_proceso                datetime,               --115
   nombre_archivo                     varchar (300),          --116,
   estado_nombre_archivo              char(1) null default 'N',--117
   estado_reporte                     char(1) null default 'N',--118
   fecha_gen_rep_cob                  datetime,                --119
   asesor_login                       varchar (64) ,           --120
   asesor_cargo                       varchar (64)             --121
	)
go

use cobis
go

delete from cobis..cl_parametro
where pa_producto='REC'
and pa_nemonico='PHCMCC'

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PATH COBRANZA COBIS MC', 'PHCMCC', 'C', 'D:\WorkFolder\MCCollect\Cobis\', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
go

go
select * from cobis..cl_parametro
where pa_producto='REC'
and pa_nemonico='PHCMCC'

use cob_conta_super
go
if object_id ('dbo.sb_rep_cob_mc_cobis') is not null
	drop table dbo.sb_rep_cob_mc_cobis
go
create table dbo.sb_rep_cob_mc_cobis
	(
     mc_secuencial            int identity not null,
     mc_contrato 				   varchar(24), 
     mc_id_cliente 				varchar(40),
     mc_neg_telefono			   varchar(20),
     mc_neg_direccion			varchar(255),
     mc_neg_estado 				varchar(64),
     mc_neg_municipio 			varchar(64),
     mc_neg_localidad         varchar(64),
     mc_neg_cp                varchar(30),
     mc_nvas_coord_neg       varchar(255),
     mc_foto1_neg             varchar(1000),
     mc_foto2_neg             varchar(1000),
     mc_entre_calle_1_neg     varchar(255),
     mc_entre_calle_2_neg     varchar(255),
     mc_entre_calle_3_neg     varchar(255),
     mc_entre_calle_4_neg     varchar(255),
     mc_nvo_telefono_dom      varchar(20),
     mc_nva_direccion_dom     varchar(255),
     mc_nvo_estado_dom        varchar(255),
     mc_nvo_municipio_dom     varchar(255),
     mc_nva_localidad_dom     varchar(255),
     mc_nvo_cp_dom            varchar(40),
     mc_nvas_coodenadas_dom   varchar(255),
     mc_foto1_dom             varchar(1000),
     mc_entre_calle_1_dom     varchar(255),
     mc_entre_calle_2_dom     varchar(255),
     mc_entre_calle_3_dom     varchar(255),
     mc_entre_calle_4_dom     varchar(255),
     mc_foto_domicilio_alt    varchar(1000),
     mc_entre_calle_1_dom_alt varchar(255),
     mc_entre_calle_2_dom_alt varchar(255),
     mc_entre_calle_3_dom_alt varchar(255),
     mc_entre_calle_4_dom_alt varchar(255)
     
	)
go



