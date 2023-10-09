
/* ***********************************************/
---No Bug: 77277
---Título del Bug: 
---Fecha: 13/Jul/2016
--Descripción del Problema: Faltan tablas de cuentas
--Descripción de la Solución: Creacion de las tablas
--Autor: Walther Toledo
/* *************************************************/

use cob_cuentas
go

/* cc_ctrl_efectivo */
print '=====> cc_ctrl_efectivo'
go
if exists (select * from sysobjects where name = 'cc_ctrl_efectivo') 
 drop table cc_ctrl_efectivo
go

CREATE TABLE cc_ctrl_efectivo
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


/* cc_tsrem_ingresochq */
print '=====> cc_tsrem_ingresochq'
go
if exists (select * from sysobjects where name = 'cc_tsrem_ingresochq') 
 drop table cc_tsrem_ingresochq
go

CREATE TABLE cc_tsrem_ingresochq
	(
	secuencial INT,
	tipo_tran SMALLINT,
	oficina SMALLINT,
	fecha DATETIME,
	cta_banco_dep cuenta ,
	valor MONEY,
	cta_gir cuenta ,
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
    

/* cc_tran_servicio */
print '=====> cc_tran_servicio'
go
if exists (select * from sysobjects where name = 'cc_tran_servicio') 
 drop table cc_tran_servicio
go

CREATE TABLE cc_tran_servicio
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
	ON cc_tran_servicio (ts_tipo_transaccion, ts_clase, ts_secuencial, ts_cod_alterno)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cc_tran_servicio_tran
	ON cc_tran_servicio (ts_oficina, ts_moneda, ts_tipo_transaccion, ts_secuencial, ts_cod_alterno)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cc_tran_servicio_branch
	ON cc_tran_servicio (ts_ssn_branch, ts_oficina)
	WITH (FILLFACTOR = 80)
GO


/* cc_sobregiro */
print '=====> cc_sobregiro'
go
if exists (select * from sysobjects where name = 'cc_sobregiro') 
 drop table cc_sobregiro
go

CREATE TABLE cc_sobregiro
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
	ON cc_sobregiro (sb_cuenta, sb_secuencial)
GO

CREATE INDEX i_cta_tipo
	ON cc_sobregiro (sb_cuenta, sb_tipo, sb_fecha_ven)
GO



/* cc_tran_monet */
print '=====> cc_tran_monet'
go
if exists (select * from sysobjects where name = 'cc_tran_monet') 
 drop table cc_tran_monet
go

CREATE TABLE cc_tran_monet
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
	ON cc_tran_monet (tm_cta_banco, tm_secuencial, tm_cod_alterno)
GO

CREATE INDEX cc_tran_monet_tran
	ON cc_tran_monet (tm_oficina, tm_moneda, tm_tipo_tran, tm_secuencial, tm_cod_alterno)
GO

CREATE INDEX cc_tran_monet_branch
	ON cc_tran_monet (tm_oficina, tm_ssn_branch)
GO

CREATE INDEX cc_tran_monet_oficina_cta
	ON cc_tran_monet (tm_oficina_cta, tm_moneda, tm_cta_banco, tm_tipo_tran, tm_causa)
GO

CREATE UNIQUE INDEX cc_tran_monet_sec
	ON cc_tran_monet (tm_secuencial, tm_cod_alterno)
GO


/* cc_tsrem_ingresochq */
print '=====> cc_tsrem_ingresochq'
go
if exists (select * from sysobjects where name = 'cc_tsrem_ingresochq') 
 drop table cc_tsrem_ingresochq
go

CREATE TABLE cc_tsrem_ingresochq
	(
	secuencial    INT NULL,
	tipo_tran     SMALLINT NULL,
	oficina       SMALLINT NULL,
	fecha         DATETIME NULL,
	cta_banco_dep cuenta NULL,
	valor         MONEY NULL,
	cta_gir       cuenta NULL,
	nro_cheque    INT NULL,
	cod_banco     VARCHAR (10) NULL,
	moneda        TINYINT NULL,
	producto      TINYINT NULL,
	cheque_rec    INT NULL,
	alterno       INT NULL,
	oficina_cta   SMALLINT NULL,
	hora          DATETIME NULL,
	estado        CHAR (1) NULL,
	bco_corr      SMALLINT NULL,
	carta         INT NULL,
	suc_destino   INT NULL,
	cod_corres    VARCHAR (10) NULL
	)

GO

----------------------------------------

IF OBJECT_ID ('ts_cta_cons_bco') IS NOT NULL
                DROP VIEW ts_cta_cons_bco
go
create view ts_cta_cons_bco (
        secuencial,    tipo_tran,           oficina,         usuario,       terminal,
        origen,        nodo,                fecha,           tipo,          banco,
        referencia,    operacion
) as
select  ts_secuencial, ts_tipo_transaccion, ts_oficina,      ts_usuario,    ts_terminal,
        ts_origen,     ts_nodo,             ts_tsfecha,      ts_tipo,       ts_banco,
        ts_referencia, ts_clase
  from  cc_tran_servicio
 where  ts_tipo_transaccion in (696, 697) 