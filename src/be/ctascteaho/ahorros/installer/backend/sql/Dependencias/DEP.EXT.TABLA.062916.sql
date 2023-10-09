/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    Se crea la Tabla re_consolidado_trn_cb para remesas
/***************************************************/

use cob_remesas
go



If EXISTS (SELECT 1 from sysobjects WHERE name ='re_consolidado_trn_cb')
DROP TABLE re_consolidado_trn_cb
go

CREATE TABLE re_consolidado_trn_cb
	(
	ct_fecha VARCHAR (12),
	ct_cod_red SMALLINT,
	ct_nom_red VARCHAR (64),
	ct_cant_pagos INT,
	ct_vlr_pagos MONEY,
	ct_cant_cons INT,
	ct_cant_dep INT,
	ct_vlr_dep MONEY,
	ct_cant_ret INT,
	ct_vlr_ret MONEY,
	ct_estado CHAR (1),
	ct_secuencial INT,
	ct_usuario VARCHAR (64)
	)
go

/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA cc_ctacte
/***************************************************/

USE cob_cuentas
GO

IF OBJECT_ID ('dbo.cc_ctacte') IS NOT NULL
	DROP TABLE dbo.cc_ctacte
GO

CREATE TABLE dbo.cc_ctacte
	(
	cc_ctacte               INT NOT NULL,
	cc_cta_banco            CHAR (16) NOT NULL,
	cc_filial               TINYINT NOT NULL,
	cc_oficina              SMALLINT NOT NULL,
	cc_oficial              SMALLINT NOT NULL,
	cc_nombre               CHAR (64) NOT NULL,
	cc_fecha_aper           DATETIME NOT NULL,
	cc_cliente              INT NOT NULL,
	cc_ced_ruc              CHAR (13) NOT NULL,
	cc_estado               CHAR (1) NOT NULL,
	cc_cliente_ec           INT NOT NULL,
	cc_direccion_ec         TINYINT NOT NULL,
	cc_descripcion_ec       CHAR (120) NOT NULL,
	cc_tipo_dir             CHAR (1) NOT NULL,
	cc_cobro_ec             CHAR (1) NOT NULL,
	cc_agen_ec              SMALLINT NOT NULL,
	cc_parroquia            SMALLINT NOT NULL,
	cc_zona                 CHAR (3) NOT NULL,
	cc_man_firmas           CHAR (1) NOT NULL,
	cc_ciclo                CHAR (1) NOT NULL,
	cc_categoria            CHAR (1) NOT NULL,
	cc_creditos_mes         MONEY NOT NULL,
	cc_debitos_mes          MONEY NOT NULL,
	cc_creditos_hoy         MONEY NOT NULL,
	cc_debitos_hoy          MONEY NOT NULL,
	cc_disponible           MONEY NOT NULL,
	cc_12h                  MONEY NOT NULL,
	cc_12h_dif              MONEY NOT NULL,
	cc_24h                  MONEY NOT NULL,
	cc_24h_dif              MONEY NOT NULL,
	cc_48h                  MONEY NOT NULL,
	cc_72h_diferido         MONEY NOT NULL,
	cc_remesas              MONEY NOT NULL,
	cc_rem_hoy              MONEY NOT NULL,
	cc_rem_diferido         MONEY NOT NULL,
	cc_fecha_ult_mov        DATETIME NOT NULL,
	cc_fecha_ult_mov_int    DATETIME NOT NULL,
	cc_fecha_ult_upd        DATETIME NOT NULL,
	cc_fecha_prx_corte      DATETIME NOT NULL,
	cc_cred_24h             CHAR (1) NOT NULL,
	cc_cred_rem             CHAR (1) NOT NULL,
	cc_dias_sob             SMALLINT NOT NULL,
	cc_dias_sob_cont        SMALLINT NOT NULL,
	cc_retenidos            INT NOT NULL,
	cc_retenciones          MONEY NOT NULL,
	cc_certificados         SMALLINT NOT NULL,
	cc_protestos            INT NOT NULL,
	cc_prot_justificados    SMALLINT NOT NULL,
	cc_prot_periodo_ant     SMALLINT NOT NULL,
	cc_sobregiros           TINYINT NOT NULL,
	cc_anulados             SMALLINT NOT NULL,
	cc_revocados            SMALLINT NOT NULL,
	cc_bloqueos             SMALLINT NOT NULL,
	cc_num_blqmonto         SMALLINT NOT NULL,
	cc_suspensos            SMALLINT NOT NULL,
	cc_condiciones          SMALLINT NOT NULL,
	cc_uso_sobregiro        SMALLINT NOT NULL,
	cc_uso_remesa           SMALLINT NOT NULL,
	cc_num_chq_defectos     SMALLINT NOT NULL,
	cc_producto             TINYINT NOT NULL,
	cc_tipo                 CHAR (1) NOT NULL,
	cc_moneda               TINYINT NOT NULL,
	cc_default              INT NOT NULL,
	cc_tipo_def             CHAR (1) NOT NULL,
	cc_rol_ente             CHAR (1) NOT NULL,
	cc_chequeras            INT NOT NULL,
	cc_cheque_inicial       INT NOT NULL,
	cc_tipo_promedio        CHAR (1) NOT NULL,
	cc_historico_seq        INT NOT NULL,
	cc_saldo_ult_corte      MONEY NOT NULL,
	cc_fecha_ult_corte      DATETIME NOT NULL,
	cc_fecha_ult_capi       DATETIME NOT NULL,
	cc_saldo_ayer           MONEY NOT NULL,
	cc_monto_blq            MONEY NOT NULL,
	cc_promedio1            MONEY NOT NULL,
	cc_promedio2            MONEY NOT NULL,
	cc_promedio3            MONEY NOT NULL,
	cc_promedio4            MONEY NOT NULL,
	cc_promedio5            MONEY NOT NULL,
	cc_promedio6            MONEY NOT NULL,
	cc_personalizada        CHAR (1) NOT NULL,
	cc_prom_disponible      MONEY NOT NULL,
	cc_contador_trx         INT NOT NULL,
	cc_cta_funcionario      CHAR (1) NOT NULL,
	cc_mercantil            CHAR (1) NOT NULL,
	cc_cta_ahomerc          CHAR (16) NOT NULL,
	cc_tipocta              CHAR (1) NOT NULL,
	cc_saldo_interes        MONEY NOT NULL,
	cc_num_cta_asoc         TINYINT NOT NULL,
	cc_num_chq_pag_merc     SMALLINT NOT NULL,
	cc_prod_banc            SMALLINT NOT NULL,
	cc_origen               VARCHAR (3) NOT NULL,
	cc_contador_firma       INT NOT NULL,
	cc_fecha_prx_capita     DATETIME NOT NULL,
	cc_dep_ini              TINYINT NOT NULL,
	cc_telefono             CHAR (12) NOT NULL,
	cc_int_hoy              MONEY NOT NULL,
	cc_rtefte               CHAR (1) NOT NULL,
	cc_extracto             CHAR (1) NOT NULL,
	cc_contragarantia       CHAR (12) NOT NULL,
	cc_embargada_ilim       CHAR (1) NOT NULL,
	cc_embargada_fijo       CHAR (1) NOT NULL,
	cc_deb_mes_ant          MONEY NOT NULL,
	cc_cred_mes_ant         MONEY NOT NULL,
	cc_num_deb_mes          INT NOT NULL,
	cc_num_cred_mes         INT NOT NULL,
	cc_num_deb_mes_ant      INT NOT NULL,
	cc_num_cred_mes_ant     INT NOT NULL,
	cc_marca_inusual        CHAR (1) NOT NULL,
	cc_rtefte_anio          MONEY NOT NULL,
	cc_iva_anio             MONEY NOT NULL,
	cc_baseiva_anio         MONEY NOT NULL,
	cc_interes_anio         MONEY NOT NULL,
	cc_clase_clte           CHAR (1) NOT NULL,
	cc_puntos               INT NOT NULL,
	cc_fecha_ult_canje_ptos DATETIME NOT NULL,
	cc_negociada            CHAR (1) NOT NULL,
	cc_lim_sobregiro        TINYINT NOT NULL,
	cc_saldo_rtefte         MONEY NOT NULL,
	cc_rtefte_hoy           MONEY NOT NULL,
	cc_ctitularidad         CHAR (2) NOT NULL,
	cc_int_recalc_sob       MONEY NOT NULL,
	cc_nxmil                CHAR (1) NOT NULL,
	cc_marca_suspen         CHAR (1) NOT NULL,
	cc_tctahabiente         CHAR (2) NOT NULL,
	cc_reqaut_DTN           CHAR (1),
	cc_imprimirex           CHAR (1),
	cc_paquete              INT
	)
GO

CREATE UNIQUE CLUSTERED INDEX cc_ctacte_Key
	ON dbo.cc_ctacte (cc_cta_banco)
GO

CREATE INDEX i_cc_cliente
	ON dbo.cc_ctacte (cc_cliente)
GO

CREATE UNIQUE INDEX i_cc_ctacte
	ON dbo.cc_ctacte (cc_ctacte)
GO

CREATE INDEX i_cc_servicio
	ON dbo.cc_ctacte (cc_filial, cc_oficina, cc_moneda)
GO

/****************************/
/*   Tipo de Datos login   */
/***************************/
if not exists (select * from systypes where name = 'login')
   CREATE TYPE login FROM varchar(14) NULL
   
/****************************/
/*   Tipo de Datos cuenta   */
/***************************/
if not exists (select * from systypes where name = 'cuenta')
   CREATE TYPE cuenta FROM varchar(24) NULL   
   
/****************************/
/*   Tipo de Datos numero   */
/***************************/
if not exists (select * from systypes where name = 'numero')
   CREATE TYPE numero FROM varchar(13) NULL
/****************************/
/*   Tipo de Datos descripcion   */
/***************************/
if not exists (select * from systypes where name = 'descripcion')
    CREATE TYPE descripcion FROM varchar(64) NULL
/****************************/
/*   Tipo de Datos direccion   */
/***************************/
if not exists (select * from systypes where name = 'direccion')
    CREATE TYPE direccion FROM varchar(120) NULL
  
/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA cc_ctrl_efectivo
/***************************************************/  

IF OBJECT_ID ('dbo.cc_ctrl_efectivo') IS NOT NULL
	DROP TABLE dbo.cc_ctrl_efectivo
GO

CREATE TABLE dbo.cc_ctrl_efectivo
	(
	ce_consecutivo         INT NOT NULL,
	ce_fecha               DATETIME NOT NULL,
	ce_oficina             INT,
	ce_oficial             SMALLINT,
	ce_usuario             login NOT NULL,
	ce_ciudad              VARCHAR (7) NOT NULL,
	ce_oficina_recep       SMALLINT NOT NULL,
	ce_producto            SMALLINT NOT NULL,
	ce_numcta              cuenta NOT NULL,
	ce_nom_cta             VARCHAR (50),
	ce_iden                numero NOT NULL,
	ce_transaccion         CHAR (1) NOT NULL,
	ce_moneda              CHAR (1) NOT NULL,
	ce_valor               MONEY NOT NULL,
	ce_apellido1_e         VARCHAR (30) NOT NULL,
	ce_apellido2_e         VARCHAR (30) NOT NULL,
	ce_nombre_e            VARCHAR (30) NOT NULL,
	ce_tipo_doc_e          CHAR (2) NOT NULL,
	ce_cedula_e            numero NOT NULL,
	ce_direccion_e         VARCHAR (40) NOT NULL,
	ce_titular             CHAR (1) NOT NULL,
	ce_apellido1_t         VARCHAR (30),
	ce_apellido2_t         VARCHAR (30),
	ce_nombre_t            VARCHAR (30),
	ce_tipo_doc_t          CHAR (2),
	ce_cedula_t            numero,
	ce_direccion_t         VARCHAR (40),
	ce_activ_econom_t      VARCHAR (30),
	ce_origen_tran         VARCHAR (5),
	ce_hora                VARCHAR (10),
	ce_telefono            VARCHAR (30),
	ce_telefono_e          VARCHAR (30),
	ce_telefono_t          VARCHAR (30),
	ce_titular_t           VARCHAR (2),
	ce_nom_benef           VARCHAR (30),
	ce_papp_benef          VARCHAR (30),
	ce_sapp_benef          VARCHAR (30),
	ce_tipo_doc_benef      VARCHAR (2),
	ce_num_doc_benef       VARCHAR (13),
	ce_titular_benef       VARCHAR (2),
	ce_tipoid_iden         VARCHAR (2),
	ce_declaracion_ah      CHAR (1),
	ce_declaracion_cc      CHAR (1),
	ce_declaracion_ho      CHAR (1),
	ce_declaracion_ot      CHAR (1),
	ce_declaracion_cd      CHAR (1),
	ce_declaracion_sa      CHAR (1),
	ce_declaracion_ve      CHAR (1),
	ce_cod_transaccion     INT NOT NULL,
	ce_origen_bines_fondos VARCHAR (100),
	ce_sec_giro            VARCHAR (15)
	)
GO

/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA cc_tsrem_ingresochq
/***************************************************/  

IF OBJECT_ID ('dbo.cc_tsrem_ingresochq') IS NOT NULL
	DROP TABLE dbo.cc_tsrem_ingresochq
GO
CREATE TABLE cc_tsrem_ingresochq
	(
	secuencial INT,
	tipo_tran SMALLINT,
	oficina SMALLINT,
	fecha DATETIME,
	cta_banco_dep CUENTA ,
	valor MONEY,
	cta_gir CUENTA ,
	nro_cheque INT,
	cod_banco VARCHAR (10),
	moneda TINYINT,
	producto TINYINT,
	cheque_rec INT,
	alterno INT,
	oficina_cta SMALLINT,
	hora DATETIME,
	estado CHAR (1),
	bco_corr SMALLINT,
	carta INT,
	suc_destino INT,
	cod_corres VARCHAR (10)
	)
	go
/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA cc_chq_otrdept
/***************************************************/  	
	
IF OBJECT_ID ('dbo.cc_chq_otrdept') IS NOT NULL
	DROP TABLE dbo.cc_chq_otrdept
GO

CREATE TABLE dbo.cc_chq_otrdept
	(
	cd_banco_chq    SMALLINT NOT NULL,
	cd_cta_chq      VARCHAR (15) NOT NULL,
	cd_num_chq      INT NOT NULL,
	cd_oficina      SMALLINT NOT NULL,
	cd_departamento SMALLINT NOT NULL,
	cd_fecha_ing    DATETIME NOT NULL,
	cd_secuencial   INT NOT NULL,
	cd_tipo_chq     CHAR (1) NOT NULL,
	cd_valor        MONEY NOT NULL,
	cd_moneda       TINYINT NOT NULL,
	cd_estado       CHAR (1),
	cd_causadev     CHAR (3),
	cd_fecha_ope    DATETIME,
	cd_otring       CHAR (1),
	cd_cliente      INT,
	cd_digito       TINYINT NOT NULL,
	cd_producto     TINYINT,
	cd_cta_dep      VARCHAR (24),
	cd_ssn_branch   INT,
	cd_fecha_proc   DATETIME NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cc_chq_otrdept_key
	ON dbo.cc_chq_otrdept (cd_secuencial)
GO

CREATE INDEX cc_chq_otrdept_bco_cta
	ON dbo.cc_chq_otrdept (cd_banco_chq, cd_cta_chq, cd_num_chq)
GO

CREATE INDEX cc_chq_otrdept_alt
	ON dbo.cc_chq_otrdept (cd_oficina, cd_moneda, cd_departamento, cd_estado, cd_fecha_ing)
GO
/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA cc_dias_laborables
/***************************************************/  
IF OBJECT_ID ('dbo.cc_dias_laborables') IS NOT NULL
	DROP TABLE dbo.cc_dias_laborables
GO

CREATE TABLE dbo.cc_dias_laborables
	(
	dl_ciudad   INT NOT NULL,
	dl_fecha    DATETIME NOT NULL,
	dl_num_dias SMALLINT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cc_dias_laborables_Key
	ON dbo.cc_dias_laborables (dl_ciudad, dl_fecha)
GO
/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA cc_tran_servicio
/***************************************************/  
IF OBJECT_ID ('dbo.cc_tran_servicio') IS NOT NULL
	DROP TABLE dbo.cc_tran_servicio
GO

CREATE TABLE dbo.cc_tran_servicio
	(
	ts_secuencial       INT NOT NULL,
	ts_ssn_branch       INT,
	ts_cod_alterno      INT,
	ts_tipo_transaccion SMALLINT NOT NULL,
	ts_clase            VARCHAR (3),
	ts_tsfecha          DATETIME NOT NULL,
	ts_tabla            TINYINT,
	ts_usuario          descripcion,
	ts_terminal         descripcion,
	ts_correccion       CHAR (1),
	ts_ssn_corr         INT,
	ts_reentry          CHAR (1),
	ts_origen           CHAR (1),
	ts_nodo             VARCHAR (30),
	ts_referencia       VARCHAR (15),
	ts_remoto_ssn       INT,
	ts_cheque_rec       INT,
	ts_ctacte           INT,
	ts_cta_banco        cuenta,
	ts_filial           TINYINT,
	ts_oficina          SMALLINT,
	ts_oficial          SMALLINT,
	ts_fecha_aper       DATETIME,
	ts_cliente          INT,
	ts_ced_ruc          numero,
	ts_estado           CHAR (1),
	ts_direccion_ec     TINYINT,
	ts_descripcion_ec   direccion,
	ts_ciclo            CHAR (1),
	ts_categoria        CHAR (1),
	ts_producto         TINYINT,
	ts_tipo             CHAR (1),
	ts_indicador        TINYINT,
	ts_moneda           TINYINT,
	ts_default          INT,
	ts_tipo_def         CHAR (1),
	ts_rol_ente         CHAR (1),
	ts_tipo_promedio    CHAR (1),
	ts_numero           SMALLINT,
	ts_fecha            DATETIME,
	ts_autorizante      descripcion,
	ts_causa            VARCHAR (5),
	ts_servicio         VARCHAR (3),
	ts_saldo            MONEY,
	ts_fecha_uso        DATETIME,
	ts_monto            MONEY,
	ts_fecha_ven        DATETIME,
	ts_filial_aut       TINYINT,
	ts_ofi_aut          SMALLINT,
	ts_autoriz_aut      descripcion,
	ts_filial_anula     TINYINT,
	ts_ofi_anula        SMALLINT,
	ts_autoriz_anula    descripcion,
	ts_cheque_desde     INT,
	ts_cheque_hasta     INT,
	ts_chequera         SMALLINT,
	ts_num_cheques      SMALLINT,
	ts_departamento     SMALLINT,
	ts_cta_gir          cuenta,
	ts_endoso           INT,
	ts_cod_banco        VARCHAR (10),
	ts_corresponsal     VARCHAR (10),
	ts_propietario      VARCHAR (10),
	ts_carta            INT,
	ts_sec_correccion   INT,
	ts_cheque           INT,
	ts_cta_banco_dep    cuenta,
	ts_oficina_pago     SMALLINT,
	ts_contratado       MONEY,
	ts_valor            MONEY,
	ts_ocasional        MONEY,
	ts_banco            SMALLINT,
	ts_ccontable        VARCHAR (20),
	ts_cta_funcionario  CHAR (1),
	ts_mercantil        CHAR (1),
	ts_cta_asociada     cuenta,
	ts_tipocta          CHAR (1),
	ts_fecha_eimp       DATETIME,
	ts_fecha_rimp       DATETIME,
	ts_fecha_rofi       DATETIME,
	ts_tipo_chequera    VARCHAR (5),
	ts_stick_imp        CHAR (15),
	ts_tipo_imp         CHAR (1),
	ts_tarjcred         VARCHAR (20),
	ts_aporte_iess      MONEY,
	ts_descuento_iess   MONEY,
	ts_fonres_iess      MONEY,
	ts_agente           VARCHAR (30),
	ts_nombre           direccion,
	ts_vale             CHAR (8),
	ts_autorizacion     CHAR (10),
	ts_tasa             FLOAT,
	ts_estado_eimprenta CHAR (1),
	ts_oficina_cta      SMALLINT,
	ts_hora             DATETIME,
	ts_estado_corr      CHAR (1),
	ts_contragarantia   CHAR (12),
	ts_tipo_embargo     CHAR (1),
	ts_causa1           VARCHAR (100),
	ts_fondos           CHAR (1),
	ts_liberacion       DATETIME,
	ts_nombre1          VARCHAR (64),
	ts_fecha_vigencia   DATETIME,
	ts_prx_fecha_proc   DATETIME,
	ts_error            VARCHAR (64),
	ts_producto1        CHAR (3),
	ts_convenio         INT,
	ts_codigo_cta       CHAR (5),
	ts_credito          VARCHAR (16),
	ts_deposito         MONEY,
	ts_clase_clte       CHAR (1),
	ts_prod_banc        TINYINT,
	ts_tarj_debito      VARCHAR (24),
	ts_negociada        CHAR (1),
	ts_oficio           VARCHAR (8),
	ts_oficio_lev       VARCHAR (8),
	ts_lim_sobregiro    TINYINT,
	ts_tgarantia        CHAR (1),
	ts_tipo_sobregiro   CHAR (1),
	ts_tipo_dias_sob    CHAR (2),
	ts_nxmil            CHAR (1),
	ts_efectivo         MONEY,
	ts_canal            SMALLINT,
	ts_calificacion     CHAR (1),
	ts_tctahabiente     CHAR (2)
	)
GO

CREATE UNIQUE INDEX cc_tran_servicio_Key
	ON dbo.cc_tran_servicio (ts_tipo_transaccion, ts_clase, ts_secuencial, ts_cod_alterno)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cc_tran_servicio_tran
	ON dbo.cc_tran_servicio (ts_oficina, ts_moneda, ts_tipo_transaccion, ts_secuencial, ts_cod_alterno)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cc_tran_servicio_branch
	ON dbo.cc_tran_servicio (ts_ssn_branch, ts_oficina)
	WITH (FILLFACTOR = 80)
GO
/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA cc_sobregiro
/***************************************************/  
IF OBJECT_ID ('dbo.cc_sobregiro') IS NOT NULL
	DROP TABLE dbo.cc_sobregiro
GO

CREATE TABLE dbo.cc_sobregiro
	(
	sb_cuenta           INT NOT NULL,
	sb_secuencial       INT NOT NULL,
	sb_tipo             CHAR (1) NOT NULL,
	sb_contrato         INT,
	sb_fecha_aut        DATETIME NOT NULL,
	sb_monto_aut        MONEY NOT NULL,
	sb_fecha_ven        DATETIME NOT NULL,
	sb_filial           TINYINT NOT NULL,
	sb_oficina          SMALLINT NOT NULL,
	sb_autorizante      login NOT NULL,
	sb_especial         CHAR (1),
	sb_tgarantia        CHAR (2),
	sb_garantia         INT,
	sb_calificacion     CHAR (2),
	sb_calificacion_ant CHAR (2),
	sb_dias_cubri       SMALLINT,
	sb_tsobrecanje      CHAR (1),
	sb_num_banco        VARCHAR (64),
	sb_fecha_ult_pago   DATETIME,
	sb_monto_origen     MONEY,
	sb_tgarantia_ant    CHAR (2)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cc_sobregiro_Key
	ON dbo.cc_sobregiro (sb_cuenta, sb_secuencial)
GO

CREATE INDEX i_cta_tipo
	ON dbo.cc_sobregiro (sb_cuenta, sb_tipo, sb_fecha_ven)
GO

/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA cc_tran_monet
/***************************************************/
IF OBJECT_ID ('dbo.cc_tran_monet') IS NOT NULL
	DROP TABLE dbo.cc_tran_monet
GO

CREATE TABLE dbo.cc_tran_monet
	(
	tm_fecha            DATETIME,
	tm_secuencial       INT NOT NULL,
	tm_ssn_branch       INT,
	tm_cod_alterno      INT,
	tm_tipo_tran        SMALLINT NOT NULL,
	tm_filial           TINYINT,
	tm_oficina          SMALLINT NOT NULL,
	tm_usuario          VARCHAR (30) NOT NULL,
	tm_terminal         VARCHAR (10) NOT NULL,
	tm_correccion       CHAR (1),
	tm_sec_correccion   INT,
	tm_origen           CHAR (1),
	tm_nodo             descripcion,
	tm_reentry          CHAR (1),
	tm_fecha_ult_mov    DATETIME,
	tm_oficina_pago     SMALLINT,
	tm_cta_banco        cuenta,
	tm_cheque           INT,
	tm_valor            MONEY,
	tm_chq_propios      MONEY,
	tm_chq_locales      MONEY,
	tm_chq_ot_plazas    MONEY,
	tm_remoto_ssn       INT,
	tm_moneda           TINYINT,
	tm_efectivo         MONEY,
	tm_tipo             CHAR (1),
	tm_signo            CHAR (1),
	tm_indicador        TINYINT,
	tm_causa            VARCHAR (3),
	tm_departamento     SMALLINT,
	tm_ctabanco_dep     cuenta,
	tm_prod_dep         CHAR (3),
	tm_l24h             MONEY,
	tm_remesas          MONEY,
	tm_contratado       MONEY,
	tm_ocasional        MONEY,
	tm_saldo_contable   MONEY,
	tm_saldo_disponible MONEY,
	tm_banco            SMALLINT,
	tm_ctadestino       cuenta,
	tm_tipo_xfer        CHAR (2),
	tm_tasa_interes     REAL,
	tm_tasa_impuesto    REAL,
	tm_tasa_solca       REAL,
	tm_tasa_comision    REAL,
	tm_tasa_mora        REAL,
	tm_valor_interes    MONEY,
	tm_valor_impuesto   MONEY,
	tm_valor_solca      MONEY,
	tm_valor_comision   MONEY,
	tm_valor_mora       MONEY,
	tm_tarjeta_atm      INT,
	tm_nombre_sol       VARCHAR (30),
	tm_identifi_sol     VARCHAR (13),
	tm_estado           CHAR (1),
	tm_concepto         VARCHAR (30),
	tm_oficina_cta      SMALLINT,
	tm_hora             DATETIME,
	tm_marca_inusual    CHAR (1),
	tm_fecha_efec       DATETIME,
	tm_clase_clte       CHAR (1),
	tm_prod_banc        TINYINT,
	tm_oficial          SMALLINT,
	tm_canal            TINYINT,
	tm_cliente          INT
	)
GO

CREATE INDEX cc_tran_monet_Key
	ON dbo.cc_tran_monet (tm_cta_banco, tm_secuencial, tm_cod_alterno)
GO

CREATE INDEX cc_tran_monet_tran
	ON dbo.cc_tran_monet (tm_oficina, tm_moneda, tm_tipo_tran, tm_secuencial, tm_cod_alterno)
GO

CREATE INDEX cc_tran_monet_branch
	ON dbo.cc_tran_monet (tm_oficina, tm_ssn_branch)
GO

CREATE INDEX cc_tran_monet_oficina_cta
	ON dbo.cc_tran_monet (tm_oficina_cta, tm_moneda, tm_cta_banco, tm_tipo_tran, tm_causa)
GO

CREATE UNIQUE INDEX cc_tran_monet_sec
	ON dbo.cc_tran_monet (tm_secuencial, tm_cod_alterno)
GO





	use cob_remesas
	go
/****************************/
/*   Tipo de Datos cuenta   */
/***************************/
if not exists (select * from systypes where name = 'cuenta')
   CREATE TYPE cuenta FROM varchar(24) NULL   
/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA re_det_carta
/***************************************************/
   
   IF OBJECT_ID ('dbo.re_det_carta') IS NOT NULL
	DROP TABLE dbo.re_det_carta
GO

CREATE TABLE dbo.re_det_carta
	(
	dc_banco_e        TINYINT NOT NULL,
	dc_oficina_e      SMALLINT NOT NULL,
	dc_ciudad_e       INT NOT NULL,
	dc_banco_p        SMALLINT NOT NULL,
	dc_oficina_p      SMALLINT NOT NULL,
	dc_ciudad_p       INT NOT NULL,
	dc_banco_c        SMALLINT NOT NULL,
	dc_fecha_emi      DATETIME NOT NULL,
	dc_moneda         TINYINT NOT NULL,
	dc_carta          INT NOT NULL,
	dc_cheque         INT NOT NULL,
	dc_valor          MONEY NOT NULL,
	dc_producto       TINYINT NOT NULL,
	dc_num_cheque     INT NOT NULL,
	dc_status         CHAR (1) NOT NULL,
	dc_cta_depositada VARCHAR (24) NOT NULL,
	dc_cta_girada     VARCHAR (24) NOT NULL,
	dc_causa_dev      VARCHAR (3),
	dc_fecha_efe      DATETIME,
	dc_tipo_rem       CHAR (1),
	dc_oficial        SMALLINT,
	dc_sec_cab        INT,
	dc_sec_det        INT,
	dc_comision       MONEY,
	dc_portes         MONEY,
	dc_iva            MONEY,
	dc_portes_dev     MONEY,
	dc_iva_dev        MONEY,
	dc_origen         CHAR (1),
	dc_fecha_cobro    DATETIME,
	dc_proc_conta     CHAR (1),
	dc_bcoced         TINYINT,
	dc_extraviada     CHAR (1),
	dc_acuse          CHAR (1),
	dc_causa_blo      VARCHAR (2),
	dc_sub_estado     CHAR (2)
	)
GO

CREATE UNIQUE INDEX re_det_carta_Key
	ON dbo.re_det_carta (dc_banco_e, dc_banco_p, dc_carta, dc_cheque, dc_ciudad_e, dc_ciudad_p, dc_fecha_emi, dc_moneda, dc_oficina_e, dc_oficina_p)
GO

CREATE INDEX re_det_carta_cta_Key
	ON dbo.re_det_carta (dc_carta, dc_cheque, dc_cta_depositada)
GO

/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA re_ofi_banco
/***************************************************/

IF OBJECT_ID ('dbo.re_ofi_banco') IS NOT NULL
	DROP TABLE dbo.re_ofi_banco
GO

CREATE TABLE dbo.re_ofi_banco
	(
	ob_banco          TINYINT NOT NULL,
	ob_oficina        SMALLINT NOT NULL,
	ob_ciudad         INT NOT NULL,
	ob_descripcion    VARCHAR (64) NOT NULL,
	ob_fecha          DATETIME,
	ob_direccion      VARCHAR (120),
	ob_telefono       VARCHAR (12),
	ob_ofi_cobis      SMALLINT,
	ob_identificacion VARCHAR (8)
	)
GO

CREATE UNIQUE INDEX re_ofi_banco_Key
	ON dbo.re_ofi_banco (ob_banco, ob_ciudad, ob_oficina)
GO

CREATE INDEX i_ob_ofi_cobis
	ON dbo.re_ofi_banco (ob_ofi_cobis)
GO

IF OBJECT_ID ('dbo.re_transito') IS NOT NULL
	DROP TABLE dbo.re_transito
GO

/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA re_transito
/***************************************************/

CREATE TABLE dbo.re_transito
	(
	tn_nombre       SMALLINT NOT NULL,
	tn_banco_p      TINYINT NOT NULL,
	tn_oficina_p    SMALLINT NOT NULL,
	tn_ciudad_p     INT NOT NULL,
	tn_banco_c      TINYINT,
	tn_oficina_c    SMALLINT,
	tn_ciudad_c     INT,
	tn_num_dias     TINYINT NOT NULL,
	tn_secuencial   INT NOT NULL,
	tn_causa_contab VARCHAR (3) NOT NULL
	)
GO

CREATE UNIQUE INDEX re_transito_Key
	ON dbo.re_transito (tn_banco_p, tn_ciudad_p, tn_nombre, tn_oficina_p)
GO

IF OBJECT_ID ('dbo.re_bcocedente') IS NOT NULL
	DROP TABLE dbo.re_bcocedente
GO
/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA re_bcocedente
/***************************************************/
CREATE TABLE dbo.re_bcocedente
	(
	bc_banco                 INT NOT NULL,
	bc_fecha_crea            DATETIME NOT NULL,
	bc_lugar_rec_propios     VARCHAR (10) NOT NULL,
	bc_lugar_rec_remesas     VARCHAR (10) NOT NULL,
	bc_lugar_entrega         VARCHAR (10) NOT NULL,
	bc_dias_ent_prop_central INT NOT NULL,
	bc_dias_ent_prop         INT NOT NULL,
	bc_dias_ent_rem_central  INT NOT NULL,
	bc_dias_ent_rem          INT NOT NULL,
	bc_dias_dev              INT NOT NULL,
	bc_dias_dev_central      INT NOT NULL,
	bc_dev_acumulada         CHAR (1) NOT NULL,
	bc_com_comp              FLOAT NOT NULL,
	bc_com_sin_comp          FLOAT NOT NULL,
	bc_com_minima            MONEY NOT NULL,
	bc_portes_recep          MONEY NOT NULL,
	bc_portes_dev            MONEY NOT NULL,
	bc_extracto              VARCHAR (10) NOT NULL,
	bc_estado                VARCHAR (10) NOT NULL,
	bc_usuario               VARCHAR (14) NOT NULL,
	bc_oficina               INT NOT NULL,
	bc_saldo_cedente         MONEY,
	bc_saldo_corresp         MONEY,
	bc_valor_min_cheque      MONEY
	)
GO

CREATE UNIQUE INDEX re_banco_cd_Key
	ON dbo.re_bcocedente (bc_banco)
GO

IF OBJECT_ID ('dbo.re_banco') IS NOT NULL
	DROP TABLE dbo.re_banco
GO

/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA re_banco
/***************************************************/

CREATE TABLE dbo.re_banco
	(
	ba_banco       TINYINT NOT NULL,
	ba_descripcion VARCHAR (64) NOT NULL,
	ba_estado      CHAR (1) NOT NULL,
	ba_filial      TINYINT,
	ba_nit         VARCHAR (13),
	ba_ente        INT
	)
GO


CREATE UNIQUE INDEX re_banco_Key
	ON dbo.re_banco (ba_banco)
GO


/*************************************************/
---Fecha Creación del Script: 
--KME         06/29/2016    TABLA re_carta
/***************************************************/

IF OBJECT_ID ('dbo.re_carta') IS NOT NULL
	DROP TABLE dbo.re_carta
GO



CREATE TABLE dbo.re_carta
	(
	ct_banco_e     TINYINT NOT NULL,
	ct_oficina_e   SMALLINT NOT NULL,
	ct_ciudad_e    INT NOT NULL,
	ct_banco_p     TINYINT NOT NULL,
	ct_oficina_p   SMALLINT NOT NULL,
	ct_ciudad_p    INT NOT NULL,
	ct_fecha_emi   DATETIME NOT NULL,
	ct_moneda      TINYINT NOT NULL,
	ct_carta       INT NOT NULL,
	ct_fecha_efe   DATETIME,
	ct_num_cheques TINYINT,
	ct_valor       MONEY,
	ct_oficina     SMALLINT NOT NULL,
	ct_banco_c     TINYINT NOT NULL,
	ct_oficina_c   SMALLINT NOT NULL,
	ct_ciudad_c    INT NOT NULL,
	ct_estado      CHAR (1) NOT NULL,
	ct_proceso     CHAR (1),
	ct_cob         INT,
	ct_comision    MONEY,
	ct_portes      MONEY,
	ct_iva         MONEY,
	ct_fecha_cobro DATETIME,
	ct_totalizado  CHAR (1),
	ct_tipo_rem    CHAR (1)
	)
GO

CREATE UNIQUE INDEX re_carta_Key
	ON dbo.re_carta (ct_banco_e, ct_banco_p, ct_carta, ct_ciudad_e, ct_ciudad_p, ct_fecha_emi, ct_moneda, ct_oficina_e, ct_oficina_p)
GO

CREATE INDEX re_carta_ofi_mone_Key
	ON dbo.re_carta (ct_banco_c, ct_moneda, ct_oficina)
GO










	


   

 



	
