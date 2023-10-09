use cob_cuentas
go

if not exists (select * from systypes where name = 'sexo')
   create type sexo from char(1) null

if not exists (select * from systypes where name = 'numero')
   create type numero from varchar(13) null

if not exists (select * from systypes where name = 'mensaje')
   create type mensaje from varchar(240) null

if not exists (select * from systypes where name = 'login')
   create type login from varchar(14) null

if not exists (select * from systypes where name = 'estado')
    create type estado from char(1) null

if not exists (select * from systypes where name = 'direccion')
    create type direccion from varchar(120) null

if not exists (select * from systypes where name = 'descripcion')
    create type descripcion from varchar(64) null

if not exists (select * from systypes where name = 'cuenta')
   create type cuenta from varchar(24) null

if not exists (select * from systypes where name = 'catalogo')
   create type catalogo from varchar(10) null
go

-----------------------------------------------------------------------------------------------------------------------

/* cc_ctacte */
print '=====> cc_ctacte'
go
if exists (select * from sysobjects where name = 'cc_ctacte') 
 drop table cc_ctacte
go

create table cc_ctacte
	(
	cc_ctacte               int not null,
	cc_cta_banco            char (16) not null,
	cc_filial               tinyint not null,
	cc_oficina              smallint not null,
	cc_oficial              smallint not null,
	cc_nombre               char (64) not null,
	cc_fecha_aper           datetime not null,
	cc_cliente              int not null,
	cc_ced_ruc              char (13) not null,
	cc_estado               char (1) not null,
	cc_cliente_ec           int not null,
	cc_direccion_ec         tinyint not null,
	cc_descripcion_ec       char (120) not null,
	cc_tipo_dir             char (1) not null,
	cc_cobro_ec             char (1) not null,
	cc_agen_ec              smallint not null,
	cc_parroquia            smallint not null,
	cc_zona                 char (3) not null,
	cc_man_firmas           char (1) not null,
	cc_ciclo                char (1) not null,
	cc_categoria            char (1) not null,
	cc_creditos_mes         money not null,
	cc_debitos_mes          money not null,
	cc_creditos_hoy         money not null,
	cc_debitos_hoy          money not null,
	cc_disponible           money not null,
	cc_12h                  money not null,
	cc_12h_dif              money not null,
	cc_24h                  money not null,
	cc_24h_dif              money not null,
	cc_48h                  money not null,
	cc_72h_diferido         money not null,
	cc_remesas              money not null,
	cc_rem_hoy              money not null,
	cc_rem_diferido         money not null,
	cc_fecha_ult_mov        datetime not null,
	cc_fecha_ult_mov_int    datetime not null,
	cc_fecha_ult_upd        datetime not null,
	cc_fecha_prx_corte      datetime not null,
	cc_cred_24h             char (1) not null,
	cc_cred_rem             char (1) not null,
	cc_dias_sob             smallint not null,
	cc_dias_sob_cont        smallint not null,
	cc_retenidos            int not null,
	cc_retenciones          money not null,
	cc_certificados         smallint not null,
	cc_protestos            int not null,
	cc_prot_justificados    smallint not null,
	cc_prot_periodo_ant     smallint not null,
	cc_sobregiros           tinyint not null,
	cc_anulados             smallint not null,
	cc_revocados            smallint not null,
	cc_bloqueos             smallint not null,
	cc_num_blqmonto         smallint not null,
	cc_suspensos            smallint not null,
	cc_condiciones          smallint not null,
	cc_uso_sobregiro        smallint not null,
	cc_uso_remesa           smallint not null,
	cc_num_chq_defectos     smallint not null,
	cc_producto             tinyint not null,
	cc_tipo                 char (1) not null,
	cc_moneda               tinyint not null,
	cc_default              int not null,
	cc_tipo_def             char (1) not null,
	cc_rol_ente             char (1) not null,
	cc_chequeras            int not null,
	cc_cheque_inicial       int not null,
	cc_tipo_promedio        char (1) not null,
	cc_historico_seq        int not null,
	cc_saldo_ult_corte      money not null,
	cc_fecha_ult_corte      datetime not null,
	cc_fecha_ult_capi       datetime not null,
	cc_saldo_ayer           money not null,
	cc_monto_blq            money not null,
	cc_promedio1            money not null,
	cc_promedio2            money not null,
	cc_promedio3            money not null,
	cc_promedio4            money not null,
	cc_promedio5            money not null,
	cc_promedio6            money not null,
	cc_personalizada        char (1) not null,
	cc_prom_disponible      money not null,
	cc_contador_trx         int not null,
	cc_cta_funcionario      char (1) not null,
	cc_mercantil            char (1) not null,
	cc_cta_ahomerc          char (16) not null,
	cc_tipocta              char (1) not null,
	cc_saldo_interes        money not null,
	cc_num_cta_asoc         tinyint not null,
	cc_num_chq_pag_merc     smallint not null,
	cc_prod_banc            smallint not null,
	cc_origen               varchar (3) not null,
	cc_contador_firma       int not null,
	cc_fecha_prx_capita     datetime not null,
	cc_dep_ini              tinyint not null,
	cc_telefono             char (12) not null,
	cc_int_hoy              money not null,
	cc_rtefte               char (1) not null,
	cc_extracto             char (1) not null,
	cc_contragarantia       char (12) not null,
	cc_embargada_ilim       char (1) not null,
	cc_embargada_fijo       char (1) not null,
	cc_deb_mes_ant          money not null,
	cc_cred_mes_ant         money not null,
	cc_num_deb_mes          int not null,
	cc_num_cred_mes         int not null,
	cc_num_deb_mes_ant      int not null,
	cc_num_cred_mes_ant     int not null,
	cc_marca_inusual        char (1) not null,
	cc_rtefte_anio          money not null,
	cc_iva_anio             money not null,
	cc_baseiva_anio         money not null,
	cc_interes_anio         money not null,
	cc_clase_clte           char (1) not null,
	cc_puntos               int not null,
	cc_fecha_ult_canje_ptos datetime not null,
	cc_negociada            char (1) not null,
	cc_lim_sobregiro        tinyint not null,
	cc_saldo_rtefte         money not null,
	cc_rtefte_hoy           money not null,
	cc_ctitularidad         char (2) not null,
	cc_int_recalc_sob       money not null,
	cc_nxmil                char (1) not null,
	cc_marca_suspen         char (1) not null,
	cc_tctahabiente         char (2) not null,
	cc_reqaut_dtn           char (1),
	cc_imprimirex           char (1),
	cc_paquete              int
	)
go

create unique clustered index cc_ctacte_key
	on cc_ctacte (cc_cta_banco)
go

create index i_cc_cliente
	on cc_ctacte (cc_cliente)
go

create unique index i_cc_ctacte
	on cc_ctacte (cc_ctacte)
go

create index i_cc_servicio
	on cc_ctacte (cc_filial, cc_oficina, cc_moneda)
go

  
/*************************************************/
---fecha creación del script: 
--kme         06/29/2016    tabla cc_ctrl_efectivo
/***************************************************/  

/* cc_ctrl_efectivo */
print '=====> cc_ctrl_efectivo'
go
if exists (select * from sysobjects where name = 'cc_ctrl_efectivo') 
 drop table cc_ctrl_efectivo
go

create table cc_ctrl_efectivo
	(
	ce_consecutivo         int not null,
	ce_fecha               datetime not null,
	ce_oficina             int,
	ce_oficial             smallint,
	ce_usuario             login not null,
	ce_ciudad              varchar (7) not null,
	ce_oficina_recep       smallint not null,
	ce_producto            smallint not null,
	ce_numcta              cuenta not null,
	ce_nom_cta             varchar (50),
	ce_iden                numero not null,
	ce_transaccion         char (1) not null,
	ce_moneda              char (1) not null,
	ce_valor               money not null,
	ce_apellido1_e         varchar (30) not null,
	ce_apellido2_e         varchar (30) not null,
	ce_nombre_e            varchar (30) not null,
	ce_tipo_doc_e          char (2) not null,
	ce_cedula_e            numero not null,
	ce_direccion_e         varchar (40) not null,
	ce_titular             char (1) not null,
	ce_apellido1_t         varchar (30),
	ce_apellido2_t         varchar (30),
	ce_nombre_t            varchar (30),
	ce_tipo_doc_t          char (2),
	ce_cedula_t            numero,
	ce_direccion_t         varchar (40),
	ce_activ_econom_t      varchar (30),
	ce_origen_tran         varchar (5),
	ce_hora                varchar (10),
	ce_telefono            varchar (30),
	ce_telefono_e          varchar (30),
	ce_telefono_t          varchar (30),
	ce_titular_t           varchar (2),
	ce_nom_benef           varchar (30),
	ce_papp_benef          varchar (30),
	ce_sapp_benef          varchar (30),
	ce_tipo_doc_benef      varchar (2),
	ce_num_doc_benef       varchar (13),
	ce_titular_benef       varchar (2),
	ce_tipoid_iden         varchar (2),
	ce_declaracion_ah      char (1),
	ce_declaracion_cc      char (1),
	ce_declaracion_ho      char (1),
	ce_declaracion_ot      char (1),
	ce_declaracion_cd      char (1),
	ce_declaracion_sa      char (1),
	ce_declaracion_ve      char (1),
	ce_cod_transaccion     int not null,
	ce_origen_bines_fondos varchar (100),
	ce_sec_giro            varchar (15)
	)
go

/*************************************************/
---fecha creación del script: 
--kme         06/29/2016    tabla cc_tsrem_ingresochq
/***************************************************/  

/* cc_tsrem_ingresochq */
print '=====> cc_tsrem_ingresochq'
go
if exists (select * from sysobjects where name = 'cc_tsrem_ingresochq') 
 drop table cc_tsrem_ingresochq
go

create table cc_tsrem_ingresochq
	(
	secuencial int,
	tipo_tran smallint,
	oficina smallint,
	fecha datetime,
	cta_banco_dep cuenta ,
	valor money,
	cta_gir cuenta ,
	nro_cheque int,
	cod_banco varchar (10),
	moneda tinyint,
	producto tinyint,
	cheque_rec int,
	alterno int,
	oficina_cta smallint,
	hora datetime,
	estado char (1),
	bco_corr smallint,
	carta int,
	suc_destino int,
	cod_corres varchar (10)
	)
	go
    

/*************************************************/
---fecha creación del script: 
--kme         06/29/2016    tabla cc_chq_otrdept
/***************************************************/  	

/* cc_chq_otrdept */
print '=====> cc_chq_otrdept'
go
if exists (select * from sysobjects where name = 'cc_chq_otrdept') 
 drop table cc_chq_otrdept
go


create table cc_chq_otrdept
	(
	cd_banco_chq    smallint not null,
	cd_cta_chq      varchar (15) not null,
	cd_num_chq      int not null,
	cd_oficina      smallint not null,
	cd_departamento smallint not null,
	cd_fecha_ing    datetime not null,
	cd_secuencial   int not null,
	cd_tipo_chq     char (1) not null,
	cd_valor        money not null,
	cd_moneda       tinyint not null,
	cd_estado       char (1),
	cd_causadev     char (3),
	cd_fecha_ope    datetime,
	cd_otring       char (1),
	cd_cliente      int,
	cd_digito       tinyint not null,
	cd_producto     tinyint,
	cd_cta_dep      varchar (24),
	cd_ssn_branch   int,
	cd_fecha_proc   datetime not null
	)
go

create unique clustered index cc_chq_otrdept_key
	on cc_chq_otrdept (cd_secuencial)
go

create index cc_chq_otrdept_bco_cta
	on cc_chq_otrdept (cd_banco_chq, cd_cta_chq, cd_num_chq)
go

create index cc_chq_otrdept_alt
	on cc_chq_otrdept (cd_oficina, cd_moneda, cd_departamento, cd_estado, cd_fecha_ing)
go


/*************************************************/
---fecha creación del script: 
--kme         06/29/2016    tabla cc_dias_laborables
/***************************************************/  

/* cc_dias_laborables */
print '=====> cc_dias_laborables'
go
if exists (select * from sysobjects where name = 'cc_dias_laborables') 
 drop table cc_dias_laborables
go


create table cc_dias_laborables
	(
	dl_ciudad   int not null,
	dl_fecha    datetime not null,
	dl_num_dias smallint not null
	)
go

create unique clustered index cc_dias_laborables_key
	on cc_dias_laborables (dl_ciudad, dl_fecha)
go


/*************************************************/
---fecha creación del script: 
--kme         06/29/2016    tabla   
/***************************************************/  

/* cc_tran_servicio */
print '=====> cc_tran_servicio'
go
if exists (select * from sysobjects where name = 'cc_tran_servicio') 
 drop table cc_tran_servicio
go

create table cc_tran_servicio
	(
	ts_secuencial       int not null,
	ts_ssn_branch       int,
	ts_cod_alterno      int,
	ts_tipo_transaccion smallint not null,
	ts_clase            varchar (3),
	ts_tsfecha          datetime not null,
	ts_tabla            tinyint,
	ts_usuario          descripcion,
	ts_terminal         descripcion,
	ts_correccion       char (1),
	ts_ssn_corr         int,
	ts_reentry          char (1),
	ts_origen           char (1),
	ts_nodo             varchar (30),
	ts_referencia       varchar (15),
	ts_remoto_ssn       int,
	ts_cheque_rec       int,
	ts_ctacte           int,
	ts_cta_banco        cuenta,
	ts_filial           tinyint,
	ts_oficina          smallint,
	ts_oficial          smallint,
	ts_fecha_aper       datetime,
	ts_cliente          int,
	ts_ced_ruc          numero,
	ts_estado           char (1),
	ts_direccion_ec     tinyint,
	ts_descripcion_ec   direccion,
	ts_ciclo            char (1),
	ts_categoria        char (1),
	ts_producto         tinyint,
	ts_tipo             char (1),
	ts_indicador        tinyint,
	ts_moneda           tinyint,
	ts_default          int,
	ts_tipo_def         char (1),
	ts_rol_ente         char (1),
	ts_tipo_promedio    char (1),
	ts_numero           smallint,
	ts_fecha            datetime,
	ts_autorizante      descripcion,
	ts_causa            varchar (5),
	ts_servicio         varchar (3),
	ts_saldo            money,
	ts_fecha_uso        datetime,
	ts_monto            money,
	ts_fecha_ven        datetime,
	ts_filial_aut       tinyint,
	ts_ofi_aut          smallint,
	ts_autoriz_aut      descripcion,
	ts_filial_anula     tinyint,
	ts_ofi_anula        smallint,
	ts_autoriz_anula    descripcion,
	ts_cheque_desde     int,
	ts_cheque_hasta     int,
	ts_chequera         smallint,
	ts_num_cheques      smallint,
	ts_departamento     smallint,
	ts_cta_gir          cuenta,
	ts_endoso           int,
	ts_cod_banco        varchar (10),
	ts_corresponsal     varchar (10),
	ts_propietario      varchar (10),
	ts_carta            int,
	ts_sec_correccion   int,
	ts_cheque           int,
	ts_cta_banco_dep    cuenta,
	ts_oficina_pago     smallint,
	ts_contratado       money,
	ts_valor            money,
	ts_ocasional        money,
	ts_banco            smallint,
	ts_ccontable        varchar (20),
	ts_cta_funcionario  char (1),
	ts_mercantil        char (1),
	ts_cta_asociada     cuenta,
	ts_tipocta          char (1),
	ts_fecha_eimp       datetime,
	ts_fecha_rimp       datetime,
	ts_fecha_rofi       datetime,
	ts_tipo_chequera    varchar (5),
	ts_stick_imp        char (15),
	ts_tipo_imp         char (1),
	ts_tarjcred         varchar (20),
	ts_aporte_iess      money,
	ts_descuento_iess   money,
	ts_fonres_iess      money,
	ts_agente           varchar (30),
	ts_nombre           direccion,
	ts_vale             char (8),
	ts_autorizacion     char (10),
	ts_tasa             float,
	ts_estado_eimprenta char (1),
	ts_oficina_cta      smallint,
	ts_hora             datetime,
	ts_estado_corr      char (1),
	ts_contragarantia   char (12),
	ts_tipo_embargo     char (1),
	ts_causa1           varchar (100),
	ts_fondos           char (1),
	ts_liberacion       datetime,
	ts_nombre1          varchar (64),
	ts_fecha_vigencia   datetime,
	ts_prx_fecha_proc   datetime,
	ts_error            varchar (64),
	ts_producto1        char (3),
	ts_convenio         int,
	ts_codigo_cta       char (5),
	ts_credito          varchar (16),
	ts_deposito         money,
	ts_clase_clte       char (1),
	ts_prod_banc        tinyint,
	ts_tarj_debito      varchar (24),
	ts_negociada        char (1),
	ts_oficio           varchar (8),
	ts_oficio_lev       varchar (8),
	ts_lim_sobregiro    tinyint,
	ts_tgarantia        char (1),
	ts_tipo_sobregiro   char (1),
	ts_tipo_dias_sob    char (2),
	ts_nxmil            char (1),
	ts_efectivo         money,
	ts_canal            smallint,
	ts_calificacion     char (1),
	ts_tctahabiente     char (2)
	)
go

create unique index cc_tran_servicio_key
	on cc_tran_servicio (ts_tipo_transaccion, ts_clase, ts_secuencial, ts_cod_alterno)
	with (fillfactor = 80)
go

create index cc_tran_servicio_tran
	on cc_tran_servicio (ts_oficina, ts_moneda, ts_tipo_transaccion, ts_secuencial, ts_cod_alterno)
	with (fillfactor = 80)
go

create index cc_tran_servicio_branch
	on cc_tran_servicio (ts_ssn_branch, ts_oficina)
	with (fillfactor = 80)
go


/*************************************************/
---fecha creación del script: 
--kme         06/29/2016    tabla cc_sobregiro
/***************************************************/  

/* cc_sobregiro */
print '=====> cc_sobregiro'
go
if exists (select * from sysobjects where name = 'cc_sobregiro') 
 drop table cc_sobregiro
go

create table cc_sobregiro
	(
	sb_cuenta           int not null,
	sb_secuencial       int not null,
	sb_tipo             char (1) not null,
	sb_contrato         int,
	sb_fecha_aut        datetime not null,
	sb_monto_aut        money not null,
	sb_fecha_ven        datetime not null,
	sb_filial           tinyint not null,
	sb_oficina          smallint not null,
	sb_autorizante      login not null,
	sb_especial         char (1),
	sb_tgarantia        char (2),
	sb_garantia         int,
	sb_calificacion     char (2),
	sb_calificacion_ant char (2),
	sb_dias_cubri       smallint,
	sb_tsobrecanje      char (1),
	sb_num_banco        varchar (64),
	sb_fecha_ult_pago   datetime,
	sb_monto_origen     money,
	sb_tgarantia_ant    char (2)
	)
go

create unique clustered index cc_sobregiro_key
	on cc_sobregiro (sb_cuenta, sb_secuencial)
go

create index i_cta_tipo
	on cc_sobregiro (sb_cuenta, sb_tipo, sb_fecha_ven)
go


/*************************************************/
---fecha creación del script: 
--kme         06/29/2016    tabla cc_tran_monet
/***************************************************/

/* cc_tran_monet */
print '=====> cc_tran_monet'
go
if exists (select * from sysobjects where name = 'cc_tran_monet') 
 drop table cc_tran_monet
go

create table cc_tran_monet
	(
	tm_fecha            datetime,
	tm_secuencial       int not null,
	tm_ssn_branch       int,
	tm_cod_alterno      int,
	tm_tipo_tran        smallint not null,
	tm_filial           tinyint,
	tm_oficina          smallint not null,
	tm_usuario          varchar (30) not null,
	tm_terminal         varchar (10) not null,
	tm_correccion       char (1),
	tm_sec_correccion   int,
	tm_origen           char (1),
	tm_nodo             descripcion,
	tm_reentry          char (1),
	tm_fecha_ult_mov    datetime,
	tm_oficina_pago     smallint,
	tm_cta_banco        cuenta,
	tm_cheque           int,
	tm_valor            money,
	tm_chq_propios      money,
	tm_chq_locales      money,
	tm_chq_ot_plazas    money,
	tm_remoto_ssn       int,
	tm_moneda           tinyint,
	tm_efectivo         money,
	tm_tipo             char (1),
	tm_signo            char (1),
	tm_indicador        tinyint,
	tm_causa            varchar (3),
	tm_departamento     smallint,
	tm_ctabanco_dep     cuenta,
	tm_prod_dep         char (3),
	tm_l24h             money,
	tm_remesas          money,
	tm_contratado       money,
	tm_ocasional        money,
	tm_saldo_contable   money,
	tm_saldo_disponible money,
	tm_banco            smallint,
	tm_ctadestino       cuenta,
	tm_tipo_xfer        char (2),
	tm_tasa_interes     real,
	tm_tasa_impuesto    real,
	tm_tasa_solca       real,
	tm_tasa_comision    real,
	tm_tasa_mora        real,
	tm_valor_interes    money,
	tm_valor_impuesto   money,
	tm_valor_solca      money,
	tm_valor_comision   money,
	tm_valor_mora       money,
	tm_tarjeta_atm      int,
	tm_nombre_sol       varchar (30),
	tm_identifi_sol     varchar (13),
	tm_estado           char (1),
	tm_concepto         varchar (30),
	tm_oficina_cta      smallint,
	tm_hora             datetime,
	tm_marca_inusual    char (1),
	tm_fecha_efec       datetime,
	tm_clase_clte       char (1),
	tm_prod_banc        tinyint,
	tm_oficial          smallint,
	tm_canal            tinyint,
	tm_cliente          int
	)
go

create index cc_tran_monet_key
	on cc_tran_monet (tm_cta_banco, tm_secuencial, tm_cod_alterno)
go

create index cc_tran_monet_tran
	on cc_tran_monet (tm_oficina, tm_moneda, tm_tipo_tran, tm_secuencial, tm_cod_alterno)
go

create index cc_tran_monet_branch
	on cc_tran_monet (tm_oficina, tm_ssn_branch)
go

create index cc_tran_monet_oficina_cta
	on cc_tran_monet (tm_oficina_cta, tm_moneda, tm_cta_banco, tm_tipo_tran, tm_causa)
go

create unique index cc_tran_monet_sec
	on cc_tran_monet (tm_secuencial, tm_cod_alterno)
go

-----------------------------------------------------------------

/* cc_tsrem_ingresochq */
print '=====> cc_tsrem_ingresochq'
go
if exists (select * from sysobjects where name = 'cc_tsrem_ingresochq') 
 drop table cc_tsrem_ingresochq
go

create table cc_tsrem_ingresochq
	(
	secuencial    int null,
	tipo_tran     smallint null,
	oficina       smallint null,
	fecha         datetime null,
	cta_banco_dep cuenta null,
	valor         money null,
	cta_gir       cuenta null,
	nro_cheque    int null,
	cod_banco     varchar (10) null,
	moneda        tinyint null,
	producto      tinyint null,
	cheque_rec    int null,
	alterno       int null,
	oficina_cta   smallint null,
	hora          datetime null,
	estado        char (1) null,
	bco_corr      smallint null,
	carta         int null,
	suc_destino   int null,
	cod_corres    varchar (10) null
	)

go

/* cc_cta_gerencia */
print '=====> cc_cta_gerencia'
go
if exists (select * from sysobjects where name = 'cc_cta_gerencia') 
 drop table cc_cta_gerencia
go
create table cc_cta_gerencia
(
   cg_oficina   smallint      not null,
   cg_moneda    tinyint       not null,
   cg_cuenta    varchar(24)   not null
)
go

/* cc_centro_canje */
print '=====> cc_centro_canje'
go
if exists (select * from sysobjects where name = 'cc_centro_canje') 
 drop table cc_centro_canje
go
create table cc_centro_canje
(
   ca_sec       int            not null,
   ca_oficina   int            not null,
   ca_desc      varchar(255)   not null,
   ca_ciudad    int            not null
)
go

/* cc_ofi_centro */
print '=====> cc_ofi_centro'
go
if exists (select * from sysobjects where name = 'cc_ofi_centro') 
 drop table cc_ofi_centro
go
create table cc_ofi_centro
(
   oc_oficina   int   not null,
   oc_centro    int   not null,
   oc_ciudad    int   not null,
   oc_ruta      int   not null
)
go

/* cc_causa_ingegr */
print '=====> cc_causa_ingegr'
go
if exists (select * from sysobjects where name = 'cc_causa_ingegr') 
 drop table cc_causa_ingegr
go
create table cc_causa_ingegr (
   ci_tipo             char(1)        not null,
   ci_causal           varchar(3)     not null,
   ci_cobro_iva        char(1)        null,
   ci_costo            money          null,
   ci_gasto_banco      char(1)        null,
   ci_efectivo         char(1)        null,
   ci_chq_propio       char(1)        null,
   ci_chq_local        char(1)        null,
   ci_ndnc_cte         char(1)        null,
   ci_ndnc_aho         char(1)        null,
   ci_causa_cte        char(3)        null,
   ci_caurev_cte       char(3)        null,
   ci_causa_aho        char(3)        null,
   ci_caurev_aho       char(3)        null,
   ci_programa         varchar(40)    null,
   ci_vigencia         tinyint        null
)
go
alter table cc_causa_ingegr add constraint pk_cc_causa_ingegr primary key (ci_tipo,ci_causal) 

go


/* cc_plazas_bco_rep */
print '=====> cc_plazas_bco_rep'
go
if exists (select * from sysobjects where name = 'cc_plazas_bco_rep') 
 drop table cc_plazas_bco_rep
go

create table cc_plazas_bco_rep
	(
	pb_plaza   smallint not null,
	pb_oficina smallint not null
	)

create unique clustered index cc_plazas_bco_rep_key
	on cc_plazas_bco_rep (pb_plaza, pb_oficina)
    
go
