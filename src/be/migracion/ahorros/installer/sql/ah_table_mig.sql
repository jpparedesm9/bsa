/************************************************************************/
/*    ARCHIVO:         ah_table_mig.sql                                 */
/*    PRODUCTO:        AHORROS                                          */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de creacion de tablas para proceso de migracion de ahorros  */
/************************************************************************/

USE cob_externos
go

--TABLAS EXT

print '*****  ah_cuenta_ext'
if not object_id('ah_cuenta_ext') is null
drop table ah_cuenta_ext
go

Create Table ah_cuenta_ext
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (30) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL,
    ah_cta_banco_rel     CHAR (16),
    ah_saldo_max         MONEY,
    ah_dias_plazo        INT
    )
go

create unique CLUSTERED index ah_cuenta_Key
    ON ah_cuenta_ext (ah_cta_banco)
go

create unique NONCLUSTERED index i_ah_cuenta
    ON ah_cuenta_ext (ah_cuenta)
go

CREATE NONCLUSTERED index i_ah_nombre
    ON ah_cuenta_ext (ah_nombre)
go


print '*****  ah_ctabloqueada_ext' 
if not object_id('ah_ctabloqueada_ext') is null
drop table ah_ctabloqueada_ext
go

Create Table ah_ctabloqueada_ext
    (
    cb_cuenta       INT NOT NULL,
    cb_secuencial   INT NOT NULL,
    cb_tipo_bloqueo VARCHAR (3) NOT NULL,
    cb_fecha        SMALLDATETIME NOT NULL,
    cb_hora         SMALLDATETIME NOT NULL,
    cb_autorizante  login NULL,
    cb_solicitante  descripcion NOT NULL,
    cb_oficina      SMALLINT NOT NULL,
    cb_estado       estado NULL,
    cb_causa        VARCHAR (3) NOT NULL,
    cb_sec_asoc     INT NULL,
    cb_observacion  VARCHAR (120) NULL
    )
go

create unique CLUSTERED index ah_ctabloqueada_Key
    ON ah_ctabloqueada_ext (cb_cuenta,cb_secuencial)
go

print '*****  ah_his_bloqueo_ext'
if not object_id('ah_his_bloqueo_ext') is null
drop table ah_his_bloqueo_ext
go

Create Table ah_his_bloqueo_ext
    (
    hb_cuenta      INT NOT NULL,
    hb_secuencial  INT NOT NULL,
    hb_valor       MONEY NOT NULL,
    hb_monto_bloq  MONEY NULL,
    hb_fecha       SMALLDATETIME NOT NULL,
    hb_fecha_ven   SMALLDATETIME NULL,
    hb_hora        SMALLDATETIME NULL,
    hb_autorizante login NOT NULL,
    hb_solicitante descripcion NULL,
    hb_oficina     SMALLINT NULL,
    hb_causa       CHAR (3) NOT NULL,
    hb_saldo       MONEY NOT NULL,
    hb_accion      CHAR (1) NOT NULL,
    hb_levantado   CHAR (2) NULL,
    hb_sec_asoc    INT NULL,
    hb_observacion CHAR (120) NULL,
    hb_ngarantia   CHAR (25) NULL,
    hb_nlinea_sob  VARCHAR (24) NULL,
    hb_numcte      VARCHAR (24) NULL
    )
go

create unique CLUSTERED index ah_his_bloqueo_Key
    ON ah_his_bloqueo_ext (hb_cuenta,hb_secuencial)
go


print '*****  ah_ciudad_deposito_ext'
if not object_id('ah_ciudad_deposito_ext') is null
drop table ah_ciudad_deposito_ext
go

Create Table ah_ciudad_deposito_ext
    (
    cd_cuenta       INT NOT NULL,
    cd_ciudad       INT NOT NULL,
    cd_fecha_depo   SMALLDATETIME NOT NULL,
    cd_fecha_efe    SMALLDATETIME NOT NULL,
    cd_valor        MONEY NOT NULL,
    cd_efectivizado CHAR (1) NULL,
    cd_valor_efe    MONEY NOT NULL
    )
go

CREATE index ah_ciudad_deposito_Alt
    ON ah_ciudad_deposito_ext (cd_cuenta, cd_fecha_efe)
go

CREATE index ah_ciudad_deposito_Alt1
    ON ah_ciudad_deposito_ext (cd_fecha_depo, cd_cuenta)
go

print '*****  ah_his_inmovilizadas_ext'
if not object_id('ah_his_inmovilizadas_ext') is null
drop table ah_his_inmovilizadas_ext
go

Create Table ah_his_inmovilizadas_ext
    (
    hi_cuenta cuenta NOT NULL,
    hi_saldo  MONEY NULL,
    hi_fecha  SMALLDATETIME NULL
    )
go

print '*****  ah_val_suspenso_ext'
if not object_id('ah_val_suspenso_ext') is null
drop table ah_val_suspenso_ext
go

Create Table ah_val_suspenso_ext
    (
    vs_cuenta     INT NOT NULL,
    vs_secuencial INT NOT NULL,
    vs_servicio   CHAR (3) NOT NULL,
    vs_valor      MONEY NOT NULL,
    vs_oficina    SMALLINT NOT NULL,
    vs_fecha      SMALLDATETIME NOT NULL,
    vs_hora       SMALLDATETIME NOT NULL,
    vs_ssn        INT NOT NULL,
    vs_estado     CHAR (1) NOT NULL,
    vs_procesada  CHAR (1) NOT NULL,
    vs_clave      INT NOT NULL,
    vs_impuesto   CHAR (1) NOT NULL
    )
go

create unique CLUSTERED index ah_val_suspenso_Key
    ON ah_val_suspenso_ext (vs_cuenta,vs_secuencial)
go


print '*****  ah_tran_monet_ext'
if not object_id('ah_tran_monet_ext') is null
drop table ah_tran_monet_ext
go

Create Table ah_tran_monet_ext
    (
    tm_fecha              SMALLDATETIME,
    tm_secuencial         INT NOT NULL,
    tm_ssn_branch         INT,
    tm_cod_alterno        INT,
    tm_tipo_tran          INT NOT NULL,
    tm_filial             TINYINT,
    tm_oficina            SMALLINT NOT NULL,
    tm_usuario            VARCHAR (30) NOT NULL,
    tm_terminal           VARCHAR (10) NOT NULL,
    tm_correccion         CHAR (1),
    tm_sec_correccion     INT,
    tm_origen             CHAR (1),
    tm_nodo               descripcion,
    tm_reentry            CHAR (1),
    tm_signo              CHAR (1),
    tm_fecha_ult_mov      SMALLDATETIME,
    tm_cta_banco          cuenta,
    tm_valor              MONEY,
    tm_chq_propios        MONEY,
    tm_chq_locales        MONEY,
    tm_chq_ot_plazas      MONEY,
    tm_remoto_ssn         INT,
    tm_moneda             TINYINT,
    tm_efectivo           MONEY,
    tm_indicador          TINYINT,
    tm_causa              CHAR (3),
    tm_departamento       SMALLINT,
    tm_saldo_lib          MONEY,
    tm_saldo_contable     MONEY,
    tm_saldo_disponible   MONEY,
    tm_saldo_interes      MONEY,
    tm_fecha_efec         SMALLDATETIME,
    tm_interes            MONEY,
    tm_control            INT,
    tm_ctadestino         cuenta,
    tm_tipo_xfer          CHAR (2),
    tm_estado             CHAR (1),
    tm_concepto           VARCHAR (40),
    tm_oficina_cta        SMALLINT,
    tm_hora               SMALLDATETIME,
    tm_banco              SMALLINT,
    tm_valor_comision     MONEY,
    tm_prod_banc          SMALLINT NOT NULL,
    tm_categoria          CHAR (1) NOT NULL,
    tm_monto_imp          MONEY,
    tm_tipo_exonerado_imp VARCHAR (2),
    tm_serial             VARCHAR (30),
    tm_tipocta_super      CHAR (1) NOT NULL,
    tm_turno              SMALLINT,
    tm_cheque             INT,
    tm_forma_pg           CHAR (4),
    tm_canal              SMALLINT,
    tm_stand_in           CHAR (1),
    tm_oficial            SMALLINT,
    tm_clase_clte         CHAR (1),
    tm_cliente            INT,
    tm_base_gmf           MONEY
    )
go

create unique CLUSTERED index ah_tran_monet_Key
    ON ah_tran_monet_ext (tm_cta_banco, tm_secuencial, tm_cod_alterno)
go

CREATE index ah_tran_monet_sec
    ON ah_tran_monet_ext (tm_secuencial, tm_cod_alterno)
go

create unique index ah_tran_monet_branch
    ON ah_tran_monet_ext (tm_ssn_branch, tm_oficina, tm_cod_alterno)
go

CREATE index ah_tran_monet_tran
    ON ah_tran_monet_ext (tm_oficina, tm_moneda, tm_tipo_tran, tm_secuencial, tm_cod_alterno)
go

print '*****  ah_his_movimiento_ext'
if not object_id('ah_his_movimiento_ext') is null
drop table ah_his_movimiento_ext
go

Create Table ah_his_movimiento_ext
    (
    hm_fecha              SMALLDATETIME,
    hm_secuencial         INT NOT NULL,
    hm_ssn_branch         INT,
    hm_cod_alterno        INT,
    hm_tipo_tran          INT NOT NULL,
    hm_filial             TINYINT,
    hm_oficina            SMALLINT NOT NULL,
    hm_usuario            VARCHAR (30) NOT NULL,
    hm_terminal           VARCHAR (10) NOT NULL,
    hm_correccion         CHAR (1),
    hm_sec_correccion     INT,
    hm_origen             CHAR (1),
    hm_nodo               descripcion,
    hm_reentry            CHAR (1),
    hm_signo              CHAR (1),
    hm_fecha_ult_mov      SMALLDATETIME,
    hm_cta_banco          cuenta,
    hm_valor              MONEY,
    hm_chq_propios        MONEY,
    hm_chq_locales        MONEY,
    hm_chq_ot_plazas      MONEY,
    hm_remoto_ssn         INT,
    hm_moneda             TINYINT,
    hm_efectivo           MONEY,
    hm_indicador          TINYINT,
    hm_causa              CHAR (3),
    hm_departamento       SMALLINT,
    hm_saldo_lib          MONEY,
    hm_saldo_contable     MONEY,
    hm_saldo_disponible   MONEY,
    hm_saldo_interes      MONEY,
    hm_fecha_efec         SMALLDATETIME,
    hm_interes            MONEY,
    hm_control            INT,
    hm_ctadestino         cuenta,
    hm_tipo_xfer          CHAR (2),
    hm_estado             CHAR (1),
    hm_concepto           VARCHAR (40),
    hm_oficina_cta        SMALLINT,
    hm_hora               SMALLDATETIME,
    hm_banco              SMALLINT,
    hm_valor_comision     MONEY,
    hm_prod_banc          SMALLINT NOT NULL,
    hm_categoria          CHAR (1) NOT NULL,
    hm_monto_imp          MONEY,
    hm_tipo_exonerado_imp VARCHAR (2),
    hm_serial             VARCHAR (30),
    hm_tipocta_super      CHAR (1) NOT NULL,
    hm_turno              SMALLINT,
    hm_cheque             INT,
    hm_canal              SMALLINT,
    hm_stand_in           CHAR (1),
    hm_oficial            SMALLINT,
    hm_clase_clte         CHAR (1) NOT NULL,
    hm_cliente            INT,
    hm_base_gmf           MONEY,
    hm_transaccion        NUMERIC (10) NOT NULL
    )
go

create unique index ah_his_movimiento_Key
    ON ah_his_movimiento_ext (hm_cta_banco, hm_fecha, hm_transaccion)
go

create unique index ah_his_movimiento_1
    ON ah_his_movimiento_ext (hm_fecha, hm_oficina, hm_moneda, hm_tipo_tran, hm_transaccion)
go

print '*****  re_accion_nd_ext'
if not object_id('re_accion_nd_ext') is null
drop table re_accion_nd_ext
go

Create Table re_accion_nd_ext
    (
    an_producto TINYINT NOT NULL,
    an_causa    VARCHAR (3) NOT NULL,
    an_accion   CHAR (1) NOT NULL,
    an_comision CHAR (1) NOT NULL,
    an_impuesto CHAR (1) NOT NULL,
    an_modo     CHAR (1) NOT NULL,
    an_saldomin CHAR (1)
    )
go

create unique index re_accion_nd_Key
    ON re_accion_nd_ext (an_causa, an_comision, an_modo, an_producto)
go

print '*****  re_cuenta_contractual_ext'
if not object_id('re_cuenta_contractual_ext') is null
drop table re_cuenta_contractual_ext
go

Create Table re_cuenta_contractual_ext
    (
    cc_modulo          TINYINT NOT NULL,
    cc_profinal        TINYINT NOT NULL,
    cc_cta_banco       VARCHAR (24) NOT NULL,
    cc_plazo           TINYINT NOT NULL,
    cc_cuota           MONEY NOT NULL,
    cc_periodicidad    VARCHAR (10) NOT NULL,
    cc_monto_final     MONEY,
    cc_intereses       MONEY,
    cc_ptos_premio     FLOAT,
    cc_estado          CHAR (1) NOT NULL,
    cc_categoria       CHAR (1) NOT NULL,
    cc_fecha_crea      DATETIME,
    cc_periodos_incump TINYINT,
    cc_prodbanc        TINYINT
    )
go

CREATE INDEX idx1
    ON re_cuenta_contractual_ext (cc_cta_banco, cc_estado)
go

print '*****  ah_linea_pendiente_ext'
if not object_id('ah_linea_pendiente_ext') is null
drop table ah_linea_pendiente_ext
go

CREATE TABLE ah_linea_pendiente_ext
    (
    lp_cuenta   INT NOT NULL,
    lp_linea    INT NOT NULL,
    lp_nemonico CHAR (4) NOT NULL,
    lp_valor    MONEY NOT NULL,
    lp_fecha    SMALLDATETIME NOT NULL,
    lp_control  INT NOT NULL,
    lp_signo    CHAR (1) NOT NULL,
    lp_enviada  CHAR (1) NOT NULL
    )
GO

CREATE UNIQUE CLUSTERED INDEX ah_linea_pendiente_Key
    ON ah_linea_pendiente_ext (lp_cuenta, lp_linea, lp_control)
GO


print '*****  re_detalle_cheque_ext'
if not object_id('re_detalle_cheque_ext') is null
drop table re_detalle_cheque_ext
go

CREATE TABLE re_detalle_cheque_ext
    (
    dc_filial           TINYINT NOT NULL,
    dc_oficina          SMALLINT NOT NULL,
    dc_fecha            SMALLDATETIME NOT NULL,
    dc_fecha_efe        SMALLDATETIME,
    dc_id               SMALLINT,
    dc_trn              SMALLINT,
    dc_numctrl          INT,
    dc_secuencial       SMALLINT NOT NULL,
    dc_ssn              INT,
    dc_ssn_branch       INT,
    dc_cta_banco        cuenta,
    dc_producto         TINYINT,
    dc_tipo             catalogo,
    dc_tipo_chq         catalogo,
    dc_co_banco         SMALLINT,
    dc_no_banco         VARCHAR (50),
    dc_cta_cheque       VARCHAR (50),
    dc_num_cheque       INT,
    dc_valor            MONEY,
    dc_moneda           TINYINT,
    dc_fechaemision     SMALLDATETIME,
    dc_estado           CHAR (1),
    dc_user             login,
    dc_hora             SMALLDATETIME,
    dc_detalle          VARCHAR (128),
    dc_factor           FLOAT,
    dc_cotizacion       FLOAT,
    dc_valor_convertido MONEY,
    dc_mon_destino      TINYINT
    )
GO

CREATE INDEX i_bco_cta_chq
    ON re_detalle_cheque_ext (dc_co_banco, dc_cta_cheque, dc_num_cheque)
GO

CREATE INDEX i_ofi_fech_pro_bco_cta
    ON re_detalle_cheque_ext (dc_oficina, dc_fecha_efe, dc_producto, dc_cta_banco)
GO


--TABLAS MIG

print '*****  ah_cuenta_mig'
if not object_id('ah_cuenta_mig') is null
drop table ah_cuenta_mig
go

Create Table ah_cuenta_mig
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) NOT NULL,
    ah_estado            CHAR (1) NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (30) NOT NULL,
    ah_nombre            CHAR (60) NOT NULL,
    ah_categoria         CHAR (1) NOT NULL,
    ah_tipo_promedio     CHAR (1) NOT NULL,
    ah_capitalizacion    CHAR (1) NOT NULL,
    ah_ciclo             CHAR (1) NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) NOT NULL,
    ah_cred_rem          CHAR (1) NOT NULL,
    ah_tipo_def          CHAR (1) NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) NOT NULL,
    ah_tipo_dir          CHAR (1) NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) NOT NULL,
    ah_tipocta           CHAR (1) NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) NOT NULL,
    ah_cedruc1           CHAR (13) NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) NOT NULL,
    ah_tipodir_dv        CHAR (1) NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) NOT NULL,
    ah_aplica_tasacorp   CHAR (1) NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) NOT NULL,
    ah_permite_sldcero   CHAR (1) NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) NOT NULL,
    ah_fideicomiso       VARCHAR (15) NULL,
    ah_nxmil             CHAR (1) NULL,
    ah_clase_clte        CHAR (1) NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL,
    ah_cta_banco_rel     CHAR (16),
    ah_saldo_max         MONEY,
    ah_dias_plazo        INT,
    ah_estado_mig        CHAR(2)
    )
go

create unique CLUSTERED index ah_cuenta_mig_Key
    ON ah_cuenta_mig (ah_cta_banco)
go

create unique NONCLUSTERED index i_ah_cuenta_mig
    ON ah_cuenta_mig (ah_cuenta)
go

print '*****  ah_ctabloqueada_mig' 
if not object_id('ah_ctabloqueada_mig') is null
drop table ah_ctabloqueada_mig
go

Create Table ah_ctabloqueada_mig
    (
    cb_cuenta         INT NOT NULL,
    cb_secuencial     INT NOT NULL,
    cb_tipo_bloqueo   VARCHAR (3) NOT NULL,
    cb_fecha          SMALLDATETIME NOT NULL,
    cb_hora           SMALLDATETIME NOT NULL,
    cb_autorizante    login NULL,
    cb_solicitante    descripcion NOT NULL,
    cb_oficina        SMALLINT NOT NULL,
    cb_estado         estado NULL,
    cb_causa          VARCHAR (3) NOT NULL,
    cb_sec_asoc       INT NULL,
    cb_observacion    VARCHAR (120) NULL,
    cb_estado_mig     CHAR(2)
    )
go

create unique CLUSTERED index ah_ctabloqueada_mig_Key
    ON ah_ctabloqueada_mig (cb_cuenta,cb_secuencial)
go

print '*****  ah_his_bloqueo_mig'
if not object_id('ah_his_bloqueo_mig') is null
drop table ah_his_bloqueo_mig
go

Create Table ah_his_bloqueo_mig
    (
    hb_cuenta         INT NOT NULL,
    hb_secuencial     INT NOT NULL,
    hb_valor          MONEY NOT NULL,
    hb_monto_bloq     MONEY NULL,
    hb_fecha          SMALLDATETIME NOT NULL,
    hb_fecha_ven      SMALLDATETIME NULL,
    hb_hora           SMALLDATETIME NULL,
    hb_autorizante    login NOT NULL,
    hb_solicitante    descripcion NULL,
    hb_oficina        SMALLINT NULL,
    hb_causa          CHAR (3) NOT NULL,
    hb_saldo          MONEY NOT NULL,
    hb_accion         CHAR (1) NOT NULL,
    hb_levantado      CHAR (2) NULL,
    hb_sec_asoc       INT NULL,
    hb_observacion    CHAR (120) NULL,
    hb_ngarantia      CHAR (25) NULL,
    hb_nlinea_sob     VARCHAR (24) NULL,
    hb_numcte         VARCHAR (24) NULL,
    hb_estado_mig     CHAR(2)
    )
go

create unique CLUSTERED index ah_his_bloqueo_mig_Key
    ON ah_his_bloqueo_mig (hb_cuenta,hb_secuencial)
go


print '*****  ah_ciudad_deposito_mig'
if not object_id('ah_ciudad_deposito_mig') is null
drop table ah_ciudad_deposito_mig
go

Create Table ah_ciudad_deposito_mig
    (
    cd_cuenta         INT NOT NULL,
    cd_ciudad         INT NOT NULL,
    cd_fecha_depo     SMALLDATETIME NOT NULL,
    cd_fecha_efe      SMALLDATETIME NOT NULL,
    cd_valor          MONEY NOT NULL,
    cd_efectivizado   CHAR (1) NULL,
    cd_valor_efe      MONEY NOT NULL,
    cd_estado_mig     CHAR(2)
    )
go

CREATE index ah_ciudad_deposito_mig_Alt
    ON ah_ciudad_deposito_mig (cd_cuenta, cd_fecha_efe)
go


print '*****  ah_his_inmovilizadas_mig'
if not object_id('ah_his_inmovilizadas_mig') is null
drop table ah_his_inmovilizadas_mig
go

Create Table ah_his_inmovilizadas_mig
    (
    hi_codigo         int IDENTITY NOT NULL,
    hi_cuenta cuenta  NOT NULL,
    hi_saldo          MONEY NULL,
    hi_fecha          SMALLDATETIME NULL,
    hi_estado_mig     CHAR(2)
    )
go

print '*****  ah_val_suspenso_mig'
if not object_id('ah_val_suspenso_mig') is null
drop table ah_val_suspenso_mig
go

Create Table ah_val_suspenso_mig
    (
    vs_cuenta         INT NOT NULL,
    vs_secuencial     INT NOT NULL,
    vs_servicio       CHAR (3) NOT NULL,
    vs_valor          MONEY NOT NULL,
    vs_oficina        SMALLINT NOT NULL,
    vs_fecha          SMALLDATETIME NOT NULL,
    vs_hora           SMALLDATETIME NOT NULL,
    vs_ssn            INT NOT NULL,
    vs_estado         CHAR (1) NOT NULL,
    vs_procesada      CHAR (1) NOT NULL,
    vs_clave          INT NOT NULL,
    vs_impuesto       CHAR (1) NOT NULL,
    vs_estado_mig     CHAR(2)
    )
go

create unique CLUSTERED index ah_val_suspenso_mig_Key
    ON ah_val_suspenso_mig (vs_cuenta,vs_secuencial)
go


print '*****  ah_tran_monet_mig'
if not object_id('ah_tran_monet_mig') is null
drop table ah_tran_monet_mig
go

Create Table ah_tran_monet_mig
    (
    tm_codigo             INT IDENTITY NOT NULL,          --codigo requerido para la migracion 
    tm_fecha              SMALLDATETIME,
    tm_secuencial         INT NOT NULL,
    tm_ssn_branch         INT,
    tm_cod_alterno        INT,
    tm_tipo_tran          INT NOT NULL,
    tm_filial             TINYINT,
    tm_oficina            SMALLINT NOT NULL,
    tm_usuario            VARCHAR (30) NOT NULL,
    tm_terminal           VARCHAR (10) NOT NULL,
    tm_correccion         CHAR (1),
    tm_sec_correccion     INT,
    tm_origen             CHAR (1),
    tm_nodo               descripcion,
    tm_reentry            CHAR (1),
    tm_signo              CHAR (1),
    tm_fecha_ult_mov      SMALLDATETIME,
    tm_cta_banco          cuenta,
    tm_valor              MONEY,
    tm_chq_propios        MONEY,
    tm_chq_locales        MONEY,
    tm_chq_ot_plazas      MONEY,
    tm_remoto_ssn         INT,
    tm_moneda             TINYINT,
    tm_efectivo           MONEY,
    tm_indicador          TINYINT,
    tm_causa              CHAR (3),
    tm_departamento       SMALLINT,
    tm_saldo_lib          MONEY,
    tm_saldo_contable     MONEY,
    tm_saldo_disponible   MONEY,
    tm_saldo_interes      MONEY,
    tm_fecha_efec         SMALLDATETIME,
    tm_interes            MONEY,
    tm_control            INT,
    tm_ctadestino         cuenta,
    tm_tipo_xfer          CHAR (2),
    tm_estado             CHAR (1),
    tm_concepto           VARCHAR (40),
    tm_oficina_cta        SMALLINT,
    tm_hora               SMALLDATETIME,
    tm_banco              SMALLINT,
    tm_valor_comision     MONEY,
    tm_prod_banc          SMALLINT NOT NULL,
    tm_categoria          CHAR (1) NOT NULL,
    tm_monto_imp          MONEY,
    tm_tipo_exonerado_imp VARCHAR (2),
    tm_serial             VARCHAR (30),
    tm_tipocta_super      CHAR (1) NOT NULL,
    tm_turno              SMALLINT,
    tm_cheque             INT,
    tm_forma_pg           CHAR (4),
    tm_canal              SMALLINT,
    tm_stand_in           CHAR (1),
    tm_oficial            SMALLINT,
    tm_clase_clte         CHAR (1),
    tm_cliente            INT,
    tm_base_gmf           MONEY,
    tm_estado_mig         CHAR(2)
    )
go

create unique CLUSTERED index ah_tran_monet_mig_Key
    ON ah_tran_monet_mig (tm_cta_banco, tm_secuencial, tm_cod_alterno)
go

CREATE index ah_tran_monet_mig_sec
    ON ah_tran_monet_mig (tm_secuencial, tm_cod_alterno)
go

create unique index ah_tran_monet_mig_branch
    ON ah_tran_monet_mig (tm_ssn_branch, tm_oficina, tm_cod_alterno)
go

CREATE index ah_tran_monet_mig_tran
    ON ah_tran_monet_mig (tm_oficina, tm_moneda, tm_tipo_tran, tm_secuencial, tm_cod_alterno)
go

print '*****  ah_his_movimiento_mig'
if not object_id('ah_his_movimiento_mig') is null
drop table ah_his_movimiento_mig
go

Create Table ah_his_movimiento_mig
    (
    hm_codigo             INT IDENTITY NOT NULL,          --codigo requerido para la migracion 
    hm_fecha              SMALLDATETIME,
    hm_secuencial         INT NOT NULL,
    hm_ssn_branch         INT,
    hm_cod_alterno        INT,
    hm_tipo_tran          INT NOT NULL,
    hm_filial             TINYINT,
    hm_oficina            SMALLINT NOT NULL,
    hm_usuario            VARCHAR (30) NOT NULL,
    hm_terminal           VARCHAR (10) NOT NULL,
    hm_correccion         CHAR (1),
    hm_sec_correccion     INT,
    hm_origen             CHAR (1),
    hm_nodo               descripcion,
    hm_reentry            CHAR (1),
    hm_signo              CHAR (1),
    hm_fecha_ult_mov      SMALLDATETIME,
    hm_cta_banco          cuenta,
    hm_valor              MONEY,
    hm_chq_propios        MONEY,
    hm_chq_locales        MONEY,
    hm_chq_ot_plazas      MONEY,
    hm_remoto_ssn         INT,
    hm_moneda             TINYINT,
    hm_efectivo           MONEY,
    hm_indicador          TINYINT,
    hm_causa              CHAR (3),
    hm_departamento       SMALLINT,
    hm_saldo_lib          MONEY,
    hm_saldo_contable     MONEY,
    hm_saldo_disponible   MONEY,
    hm_saldo_interes      MONEY,
    hm_fecha_efec         SMALLDATETIME,
    hm_interes            MONEY,
    hm_control            INT,
    hm_ctadestino         cuenta,
    hm_tipo_xfer          CHAR (2),
    hm_estado             CHAR (1),
    hm_concepto           VARCHAR (40),
    hm_oficina_cta        SMALLINT,
    hm_hora               SMALLDATETIME,
    hm_banco              SMALLINT,
    hm_valor_comision     MONEY,
    hm_prod_banc          SMALLINT NOT NULL,
    hm_categoria          CHAR (1) NOT NULL,
    hm_monto_imp          MONEY,
    hm_tipo_exonerado_imp VARCHAR (2),
    hm_serial             VARCHAR (30),
    hm_tipocta_super      CHAR (1) NOT NULL,
    hm_turno              SMALLINT,
    hm_cheque             INT,
    hm_canal              SMALLINT,
    hm_stand_in           CHAR (1),
    hm_oficial            SMALLINT,
    hm_clase_clte         CHAR (1) NOT NULL,
    hm_cliente            INT,
    hm_base_gmf           MONEY,
    hm_transaccion        NUMERIC (10) NOT NULL,
    hm_estado_mig         CHAR(2)
    )
go

create unique index ah_his_movimiento_mig_Key
    ON ah_his_movimiento_mig (hm_cta_banco, hm_fecha, hm_transaccion)
go

create unique index ah_his_movimiento_mig_1
    ON ah_his_movimiento_mig (hm_fecha, hm_oficina, hm_moneda, hm_tipo_tran, hm_transaccion)
go

print '*****  re_accion_nd_mig'
if not object_id('re_accion_nd_mig') is null
drop table re_accion_nd_mig
go

Create Table re_accion_nd_mig
    (
    an_producto    TINYINT NOT NULL,
    an_causa       VARCHAR(3) NOT NULL,
    an_accion      CHAR(1) NOT NULL,
    an_comision    CHAR(1) NOT NULL,
    an_impuesto    CHAR(1) NOT NULL,
    an_modo        CHAR(1) NOT NULL,
    an_saldomin    CHAR(1),
    an_estado_mig  CHAR(2)
    )
go

create unique index re_accion_nd_mig_Key
    ON re_accion_nd_mig (an_causa, an_comision, an_modo, an_producto)
go

print '*****  re_cuenta_contractual_mig'
if not object_id('re_cuenta_contractual_mig') is null
drop table re_cuenta_contractual_mig
go

Create Table re_cuenta_contractual_mig
    (
    cc_modulo          TINYINT NOT NULL,
    cc_profinal        TINYINT NOT NULL,
    cc_cta_banco       VARCHAR (24) NOT NULL,
    cc_plazo           TINYINT NOT NULL,
    cc_cuota           MONEY NOT NULL,
    cc_periodicidad    VARCHAR (10) NOT NULL,
    cc_monto_final     MONEY,
    cc_intereses       MONEY,
    cc_ptos_premio     FLOAT,
    cc_estado          CHAR (1) NOT NULL,
    cc_categoria       CHAR (1) NOT NULL,
    cc_fecha_crea      DATETIME,
    cc_periodos_incump TINYINT,
    cc_prodbanc        TINYINT,
    cc_estado_mig      CHAR(2)
    )
go

CREATE index re_cuenta_contractual_mig_idx1
    ON re_cuenta_contractual_mig (cc_cta_banco, cc_estado)
go

print '*****  ah_linea_pendiente_mig'
if not object_id('ah_linea_pendiente_mig') is null
drop table ah_linea_pendiente_mig
go

CREATE TABLE ah_linea_pendiente_mig
    (
    lp_cuenta         INT NOT NULL,
    lp_linea          INT NOT NULL,
    lp_nemonico       CHAR (4) NOT NULL,
    lp_valor          MONEY NOT NULL,
    lp_fecha          SMALLDATETIME NOT NULL,
    lp_control        INT NOT NULL,
    lp_signo          CHAR (1) NOT NULL,
    lp_enviada        CHAR (1) NOT NULL,
    lp_estado_mig     CHAR(2)
    )
GO

CREATE UNIQUE CLUSTERED INDEX ah_linea_pendiente_mig_Key
    ON ah_linea_pendiente_mig (lp_cuenta, lp_linea, lp_control)
GO

print '*****  re_detalle_cheque_mig'
if not object_id('re_detalle_cheque_mig') is null
drop table re_detalle_cheque_mig
go

CREATE TABLE re_detalle_cheque_mig
    (
    dc_codigo           INT IDENTITY NOT NULL,          --codigo requerido para la migracion 
    dc_filial           TINYINT NOT NULL,
    dc_oficina          SMALLINT NOT NULL,
    dc_fecha            DATE NOT NULL,
    dc_fecha_efe        DATE,
    dc_id               SMALLINT,
    dc_trn              SMALLINT,
    dc_numctrl          INT,
    dc_secuencial       SMALLINT NOT NULL,
    dc_ssn              INT,
    dc_ssn_branch       INT,
    dc_cta_banco        cuenta,
    dc_producto         TINYINT,
    dc_tipo             catalogo,
    dc_tipo_chq         catalogo,
    dc_co_banco         SMALLINT,
    dc_no_banco         VARCHAR (50),
    dc_cta_cheque       VARCHAR (50),
    dc_num_cheque       INT,
    dc_valor            MONEY,
    dc_moneda           TINYINT,
    dc_fechaemision     DATE,
    dc_estado           CHAR (1),
    dc_user             login,
    dc_hora             DATETIME,
    dc_detalle          VARCHAR (128),
    dc_factor           FLOAT,
    dc_cotizacion       FLOAT,
    dc_valor_convertido MONEY,
    dc_mon_destino      TINYINT,
    dc_estado_mig       CHAR(2)
    )
GO

CREATE INDEX i_bco_cta_chq_mig
    ON re_detalle_cheque_mig (dc_co_banco, dc_cta_cheque, dc_num_cheque)
GO

CREATE INDEX i_ofi_fech_pro_bco_cta_mig
    ON re_detalle_cheque_mig (dc_oficina, dc_fecha_efe, dc_producto, dc_cta_banco)
GO

-- Estructura que almacena el log de los errores que se han generado
print '*****  ah_log_mig'
if not object_id('ah_log_mig') is null
drop table ah_log_mig
go

create table ah_log_mig(
   lm_id_reg        varchar(50)     not null,
   lm_tabla         varchar(30)     not null,
   lm_fuente        varchar(30)     not null,
   lm_columna       varchar(30)     not null,  --nombre de la columna   
   lm_dato          varchar(255)    null,
   lm_error         int             not null,
   lm_operacion     int             null,
   lm_cta_banco_mig cuenta          null
)
go

-- Estructura que almacena los errores 
print '*****  ah_errores_mig'
if not object_id('ah_errores_mig') is null
drop table ah_errores_mig
go

create table ah_errores_mig(
   er_cod          int            not null,
   er_des          varchar(150)   null,
)
go


-- Estructura que almacena los rangos de datos a validar 
print '*****  ah_rango_mig'
if not object_id('ah_rango_mig') is null
drop table ah_rango_mig
go

create table ah_rango_mig(
   rm_tabla          varchar(30)     not null,
   rm_modulo         varchar(30)     null,
   rm_ciclos         smallint        not null,
   rm_valor_rango    int             not null,
   rm_valor_regis    int             not null,
   rm_cant_reg_val   int             null,
   rm_fec_ini_val    datetime        null,
   rm_fec_fin_val    datetime        null,
   rm_cant_reg_cobis int             null, 
   rm_total          int             not null
)

print '*****  ah_rep_logmig'
if not object_id('ah_rep_logmig') is null
drop table ah_rep_logmig
go

create table ah_rep_logmig
(
rl_id_reg    char(16), 
rl_tabla     char(21),
rl_fuente    char(31),
rl_columna   char(16),
rl_dato      char(16),
rl_operacion char(16),
rl_cta_mig   char(17),
rl_error     char(11),
rl_er_des    char(151)
)

--Estructura que almacena el numero de cuenta
/*
print '*****  ah_numero_cuenta'
if not object_id('ah_numero_cuenta') is null
drop table ah_numero_cuenta
go

create table ah_numero_cuenta(
   cta_sec            int          null,
   cta_banco          char(24)     null,
   cta_banco_dol      char(24)     null,
   cta_banco_cmv      char(24)     null,
   cta_banco_ufv      char(24)     null
   )
go
*/
--Estructura que almacena el numero de cuenta
print '*****  ah_numero_cuenta'
if not object_id('ah_numero_cuenta') is null
drop table ah_numero_cuenta
go

create table ah_numero_cuenta(
   nc_ctasec          int,
   nc_cuenta          int,
   nc_cta_banco       cuenta,
   nc_cuenta_mig      int, 
   nc_cta_banco_mig   cuenta
   )
go




