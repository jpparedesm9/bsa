use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_rep_oper_mc_collect') IS NOT NULL
	DROP table dbo.sb_rep_oper_mc_collect
go
create table dbo.sb_rep_oper_mc_collect
	(
	secuencial_mc                      int identity not null,
	OFICINA                            varchar (64) not null,
	REGION                             varchar (64) not null,
	CC                                 varchar (40) not null,
	CONTRATO                           varchar (24) not null,
	[ID GRUPO]                         varchar (40) not null,
	[NOMBRE GRUPO]                     varchar (64) not null,
	[CICLO GRUPAL]                     varchar (20) not null,
	[NUMERO DE INTEGRANTES]            varchar (30) not null,
	RFC                                varchar (24) not null,
	CURP                               varchar (255) not null,
	[CLIENTE COBIS]                    varchar (40) not null,
	[APELLIDO PATERNO]                 varchar (64) not null,
	[APELLIDO MATERNO]                 varchar (64) not null,
	NOMBRE1                            varchar (64) not null,
	NOMBRE2                            varchar (64) not null,
	[CICLO INDIVIDUAL]                 varchar (20) not null,
	GENERO                             varchar (10) not null,
	EDAD                               varchar (4) not null,
	DOM_TELEFONO                       varchar (16) not null,
	DOM_DIRECCION                      varchar (254) not null,
	ESTADO                             varchar (64) not null,
	MUNICIPIO                          varchar (64) not null,
	LOCALIDAD                          varchar (64) not null,
	[C.P.]                             varchar (30) not null,
	[COORDENADAS DOMICILIO]            varchar (100) not null,
	NEG_TELEFONO                       varchar (16) not null,
	NEG_DIRECCION                      varchar (254) not null,
	NEG_ESTADO                         varchar (64) not null,
	NEG_MUNICIPIO                      varchar (64) not null,
	NEG_LOCALIDAD                      varchar (64) not null,
	NEG_CP                             varchar (30) not null,
	[NEG_TIPO DE LOCAL]                varchar (64) not null,
	[ACTIVIDAD ECONOMICA]              varchar (200) not null,
	[CORREO ELECTRONICO DEL CLIENTE]   varchar (254) not null,
	[NOMBRE GERENTE]                   varchar (64) not null,
	[NOMBRE COORDINADOR]               varchar (64) not null,
	[NOMBRE DEL ASESOR]                varchar (64) not null,
	[CORREO ELECTRONICO ASESOR]        varchar (64) not null,
	[TELEFONO DEL ASESOR]              varchar (64) not null,
	[ESTATUS ASESOR]                   varchar (64) not null,
	[PRODUCTO DE PRESTAMOS]            varchar (40) not null,
	[SUBPRODUCTO PRESTAMO]             varchar (64) not null,
	[MONTO CREDITO]                    varchar (40) not null,
	[FECHA SOLICITUD]                  varchar (30) not null,
	[FECHA APROBACION MONTOS]          varchar (30) not null,
	[FECHA VENCIMIENTO PRESTAMO]       varchar (30) not null,
	[NUMERO DE CONTRATO]               varchar (24) not null,
	PLAZO                              varchar (64) not null,
	[NUMERO CUOTAS]                    varchar (40) not null,
	[DIA DE PAGO]                      varchar (20) not null,
	[PLAZO DIAS]                       varchar (40) not null,
	[PLAZO MES]                        varchar (40) not null,
	[VALOR CUOTA]                      varchar (40) not null,
	[CAPITAL DE LA CUOTA]              varchar (40) not null,
	[INTERESES DE LA CUOTA]            varchar (40) not null,
	[IVA DE LA CUOTA]                  varchar (40) not null,
	[TASA INTERES (ANUAL)]             varchar (40) not null,
	[CUOTAS PENDIENTES]                varchar (40) not null,
	[CUOTAS VENCIDAS]                  varchar (40) not null,
	[CAPITAL VIGENTE EXIGIBLE]         varchar (40) not null,
	[CAPITAL VENCIDO EXIGIBLE]         varchar (40) not null,
	[SALDO CAP]                        varchar (40) not null,
	[INTERES VIGENTE EXIGIBLE]         varchar (40) not null,
	[INTERES SUSPENDIDO]               varchar (40) not null,
	[IVA INTERES EXIGIBLE]             varchar (40) not null,
	[IVA INTERES NO EXIGIBLE]          varchar (40) not null,
	COMISIONES                         varchar (40) not null,
	[IVA COMISION]                     varchar (40) not null,
	[SALDO INTERESES]                  varchar (40) not null,
	[SALDO REAL EXIGIBLE]              varchar (40) not null,
	[SALDO TOTAL]                      varchar (40) not null,
	[SALDO TOTAL EN MORA]              varchar (40) not null,
	[IMPORTE LIQUIDA CON]              varchar (40) not null,
	[DIAS MAX ATRASO ACT]              varchar (40) not null,
	[SEMANAS DE ATRASO]                varchar (40) not null,
	[DIAS MORA]                        varchar (40) not null,
	[FECHA RECIBO ANTIGUO IMP]         varchar (30) not null,
	[FECHA ULTIMA SITUACION DEUDA]     varchar (30) not null,
	[PORCENTAJE RESERVA]               varchar (40) not null,
	[CARTERA EN RIESGO]                varchar (40) not null,
	[NIVEL DE RIESGO]                  varchar (15) not null,
	[PUNTAJE DE RIESGO]                varchar (20) not null,
	[ROL MESA DIRECTIVA]               varchar (64) not null,
	[INDICADOR DE REUNION]             varchar (125) not null,
	[NUMERO DE EMPLEADO DEL ASESOR]    varchar (40) not null,
	[NUMERO DE EMPLEADO DEL COORDINADOR] varchar (40) not null,
	[NUMERO DE EMPLEADO DEL GERENTE]   varchar (40) not null,
	[DIA DE REUNION SEMANAL]           varchar (40) not null,
	[HORA DE REUNION SEMANAL]          varchar (30) not null,
	[COORDENADAS NEGOCIO]              varchar (100) not null,
	[NRO OPERACION GRUPAL]             varchar (24) not null,
	[NVO DOM_DIRECCION]                varchar (500) not null,
	[NVO ESTADO]                       varchar (500) not null,
	[NVO MUNICIPIO]                    varchar (500) not null,
	[NVO LOCALIDAD]                    varchar (500) not null,
	[NVO C.P.]                         varchar (100) not null,
	[NVAS COORDENADAS DOM]             varchar (500) not null,
	[Foto del Domicilio]               varchar (1024) not null,
	[Entre calle 1 Dom]                varchar (500) not null,
	[Entre calle 2 Dom]                varchar (500) not null,
	[Entre calle 3 Dom]                varchar (500) not null,
	[Entre calle 4 Dom]                varchar (500) not null,
	[Foto del Negocio]                 varchar (1024) not null,
	[Foto del Negocio 2]               varchar (1024) not null,
	[Entre calle 1 Neg]                varchar (500) not null,
	[Entre calle 2 Neg]                varchar (500) not null,
	[Entre calle 3 Neg]                varchar (500) not null,
	[Entre calle 4 Neg]                varchar (500) not null,
	[Foto del Domicilio Alterno]       varchar (1024) not null,
	[Entre calle 1 Dom Alterno]        varchar (500) not null,
	[Entre calle 2 Dom Alterno]        varchar (500) not null,
	[Entre calle 3 Dom Alterno]        varchar (500) not null,
	[Entre calle 4 Dom Alterno]        varchar (500) not null,
	asesor_login_mc                    varchar (64) not null,
	asesor_cargo_mc                    varchar (64) not null,
	fecha_prox_couta_mc                varchar (30) not null

	)
go


use cob_conta_super
go
if object_id ('dbo.sb_rep_ini_cobis_collect') is not null
	drop table dbo.sb_rep_ini_cobis_collect
go
create table dbo.sb_rep_ini_cobis_collect
	(
		mc_secuencial                int identity ,
	oficina                      varchar (64) ,
	region                       varchar (64) ,
	cc                           varchar (40) ,
	contrato                     varchar (24) ,
	id_grupo                     varchar (40) ,
	nombre_grupo                 varchar (64) ,
	ciclo_grupal                 varchar (20) ,
	numero_integrantes           varchar (30) ,
	rfc                          varchar (24) ,
	curp                         varchar (255),
	cliente_cobis                varchar (40) ,
	apellido_paterno             varchar (64) ,
	apellido_materno             varchar (64) ,
	nombre1                      varchar (64) ,
	nombre2                      varchar (64) ,
	ciclo_individual             varchar (20) ,
	genero                       varchar (10) ,
	edad                         varchar (4) ,
	dom_telefono                 varchar (16) ,
	dom_direccion                varchar (254),
	estado                       varchar (64) ,
	municipio                    varchar (64) ,
	localidad                    varchar (64) ,
	c_p                          varchar (30) ,
	coordenadas_domicilio        varchar (100),
	neg_telefono                 varchar (16) ,
	neg_direccion                varchar (254),
	neg_estado                   varchar (64) ,
	neg_municipio                varchar (64) ,
	neg_localidad                varchar (64) ,
	neg_cp                       varchar (30) ,
	neg_tipo_local               varchar (64) ,
	actividad_economica          varchar (200),
	correo_electronico_cliente   varchar (254),
	nombre_gerente               varchar (64) ,
	nombre_coordinador           varchar (64) ,
	nombre_asesor                varchar (64) ,
	correo_electronico_asesor    varchar (64) ,
	telefono_asesor              varchar (64) ,
	estatus_asesor               varchar (64) ,
	producto_prestamos           varchar (40) ,
	subproducto_prestamo         varchar (64) ,
	monto_credito                varchar (40) ,
	fecha_solicitud              varchar (30) ,
	fecha_aprobacion_montos      varchar (30) ,
	fecha_vencimiento_prestamo   varchar (30) ,
	numero_contrato              varchar (24) ,
	plazo                        varchar (64) ,
	numero_cuotas                varchar (40) ,
	dia_pago                     varchar (20) ,
	plazo_dias                   varchar (40) ,
	plazo_mes                    varchar (40) ,
	valor_cuota                  varchar (40) ,
	capital_cuota                varchar (40) ,
	intereses_cuota              varchar (40) ,
	iva_cuota                    varchar (40) ,
	tasa_interes_anual           varchar (40) ,
	cuotas_pendientes            varchar (40) ,
	cuotas_vencidas              varchar (40) ,
	capital_vigente_exigible     varchar (40) ,
	capital_vencido_exigible     varchar (40) ,
	saldo_cap                    varchar (40) ,
	interes_vigente_exigible     varchar (40) ,
	interes_suspendido           varchar (40) ,
	iva_interes_exigible         varchar (40) ,
	iva_interes_no_exigible      varchar (40) ,
	comisiones                   varchar (40) ,
	iva_comision                 varchar (40) ,
	saldo_intereses              varchar (40) ,
	saldo_real_exigible          varchar (40) ,
	saldo_total                  varchar (40) ,
	saldo_total_mora             varchar (40) ,
	importe_liquida_con          varchar (40) ,
	dias_max_atraso_act          varchar (40) ,
	semanas_atraso               varchar (40) ,
	dias_mora                    varchar (40) ,
	fecha_recibo_antiguo_imp     varchar (30) ,
	fecha_ultima_situacion_deuda varchar (30) ,
	porcentaje_reserva           varchar (40) ,
	cartera_riesgo               varchar (40) ,
	nivel_riesgo                 varchar (15) ,
	puntaje_riesgo               varchar (20) ,
	rol_mesa_directiva           varchar (64) ,
	indicador_reunion            varchar (255) ,
	numero_empleado_asesor       varchar (40) ,
	numero_empleado_coordinador  varchar (40) ,
	numero_empleado_gerente      varchar (40) ,
	dia_reunion_semanal          varchar (40) ,
	hora_reunion_semanal         varchar (30) ,
	coordenadas_negocio          varchar (100) ,
	nro_operacion_grupal         varchar (24) ,
	nvo_dom_direccion            varchar (500)  null ,
	nvo_estado                   varchar (500)  null,
	nvo_municipio                varchar (500)  null,
	nvo_localidad                varchar (500)  null,
	nvo_c_p                      varchar (100)  null,
	nvas_coordenadas_dom         varchar (500)  null,
	foto_domicilio               varchar (1024) null,
	entre_calle_1_dom            varchar (500)  null,
	entre_calle_2_dom            varchar (500)  null,
	entre_calle_3_dom            varchar (500)  null,
	entre_calle_4_dom            varchar (500)  null,
	foto_negocio                 varchar (1024) null,
	foto_negocio_2               varchar (1024) null,
	entre_calle_1_neg            varchar (500)  null,
	entre_calle_2_neg            varchar (500)  null,
	entre_calle_3_neg            varchar (500) null,
	entre_calle_4_neg            varchar (500) null,
	foto_domicilio_alterno       varchar (1024) null,
	entre_calle_1_dom_alterno    varchar (500) null,
	entre_calle_2_dom_alterno    varchar (500) null,
	entre_calle_3_dom_alterno    varchar (500) null,
	entre_calle_4_dom_alterno    varchar (500) null,
	fecha_carga_real             datetime null,
	fecha_carga_proceso          datetime null,
	nombre_archivo               varchar (300) null,
	estado_nombre_archivo        char (1) default ('N'),
	estado_reporte               char (1) default ('N'),
	fecha_gen_rep_cob            datetime null,
	asesor_login                 varchar (64) null,
	asesor_cargo                 varchar (64) null,
	fecha_prox_couta             varchar (30) null
	)
go

CREATE INDEX IDX_OP_CLI_OPI_FECHA
ON cob_conta_super..sb_rep_ini_cobis_collect (nro_operacion_grupal,cliente_cobis,contrato,fecha_carga_real)
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
     mc_contrato 		      varchar(24), 
     mc_id_cliente 			  varchar(40),
     mc_neg_telefono	      varchar(20),
     mc_neg_direccion		  varchar(255),
     mc_neg_estado 			  varchar(64),
     mc_neg_municipio 	      varchar(64),
     mc_neg_localidad         varchar(64),
     mc_neg_cp                varchar(30),
     mc_nvas_coord_neg        varchar(500),
     mc_foto1_neg             varchar(1024),
     mc_foto2_neg             varchar(1024),
     mc_entre_calle_1_neg     varchar(500),
     mc_entre_calle_2_neg     varchar(500),
     mc_entre_calle_3_neg     varchar(500),
     mc_entre_calle_4_neg     varchar(500),
     mc_nvo_telefono_dom      varchar(100),
     mc_nva_direccion_dom     varchar(500),
     mc_nvo_estado_dom        varchar(500),
     mc_nvo_municipio_dom     varchar(500),
     mc_nva_localidad_dom     varchar(500),
     mc_nvo_cp_dom            varchar(100),
     mc_nvas_coodenadas_dom   varchar(500),
     mc_foto1_dom             varchar(1024),
     mc_entre_calle_1_dom     varchar(500),
     mc_entre_calle_2_dom     varchar(500),
     mc_entre_calle_3_dom     varchar(500),
     mc_entre_calle_4_dom     varchar(500),
     mc_foto_domicilio_alt    varchar(1024),
     mc_entre_calle_1_dom_alt varchar(500),
     mc_entre_calle_2_dom_alt varchar(500),
     mc_entre_calle_3_dom_alt varchar(500),
     mc_entre_calle_4_dom_alt varchar(500)
     
	)
go

use cobis
go

delete from cobis..ba_batch 
where ba_batch = 287933

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (287933, 'REPORTE COBRANZA PARA COBIS', 'REPORTE COBRANZA PARA COBIS', 'SP', '2020-01-06 17:08:08.967', 36, 'P', 1, NULL, 'MC_COBRANZACOBIS_', 'cob_conta_super..sb_rep_cob_mc_cobis', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\McCollect\')
go

use cobis
go

Update cobis..ba_batch
set ba_path_destino='C:\Cobis\VBatch\Regulatorios\listados\McCollect\',
ba_path_fuente='C:\Cobis\VBatch\Regulatorios\Objetos\'
where ba_batch in (287931,287932,287933)


use cob_cartera
go
if object_id ('dbo.ca_pago_sol_grp_tmp') is not null
	drop table dbo.ca_pago_sol_grp_tmp
go
create table dbo.ca_pago_sol_grp_tmp
	(
	id_contrato    varchar(50),
	id_cliente      int,
	pago_cliente   varchar(50),
	monto_total    varchar(50),
	canal_pago     int
	
	)

go

--Cabecera

use cob_cartera
go
IF OBJECT_ID ('dbo.ca_pag_grp_sol') IS NOT NULL
	DROP table dbo.ca_pag_grp_sol
go

create table cob_cartera..ca_pag_grp_sol
	(
	pg_id_grp_sol      int identity not null,
	pg_grp_contrato    varchar (24),
	pg_grp_monto_total money,
	pg_grp_id_pg_canal int,
	pg_fecha_proc_pago datetime,
	pg_fecha_real_pago datetime
	)
go
CREATE INDEX IDX_CAB_OP_CANAL
ON cob_cartera..ca_pag_grp_sol (pg_grp_contrato,pg_grp_id_pg_canal)
go

--Tablas para detalle de pagos de seguros solidario

use cob_cartera
go
IF OBJECT_ID ('dbo.ca_pag_grp_sol_det') IS NOT NULL
	DROP table dbo.ca_pag_grp_sol_det
go

create table cob_cartera..ca_pag_grp_sol_det
	(
	pgs_id_grp_sol_det  int identity not null,
	pgs_contrato_det    varchar (24),
	pgs_cliente_det     int,
	pgs_cliente_monto   money,
	pgs_grp_id_pg_canal int
	)
go

CREATE INDEX IDX_CAB_OP_CANAL
ON cob_cartera..ca_pag_grp_sol_det (pgs_contrato_det,pgs_grp_id_pg_canal)
go