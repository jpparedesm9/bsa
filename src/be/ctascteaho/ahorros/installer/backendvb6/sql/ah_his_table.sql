/************************************************************************/
/*      Archivo:            ah_table.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de tablas historicas          */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/

use cob_ahorros_his
go

/* ah_his_movimiento */
print '=====> ah_his_movimiento'
go
if exists (select * from sysobjects where name = 'ah_his_movimiento') 
 drop table ah_his_movimiento
go 


/* ah_his_re_total */
print '=====> ah_his_re_total'
go
if exists (select * from sysobjects where name = 'ah_his_re_total') 
 drop table ah_his_re_total
go 

/* ah_his_servicio */
print '=====> ah_his_servicio'
go
if exists (select * from sysobjects where name = 'ah_his_servicio') 
 drop table ah_his_servicio
go 

/* ah_saldo_diario */
print '=====> ah_saldo_diario'
go
if exists (select * from sysobjects where name = 'ah_saldo_diario') 
 drop table ah_saldo_diario
go 


CREATE TABLE ah_his_movimiento
    (
    hm_fecha              SMALLDATETIME NULL,
    hm_secuencial         INT NOT NULL,
    hm_ssn_branch         INT NULL,
    hm_cod_alterno        INT NULL,
    hm_tipo_tran          INT NOT NULL,
    hm_filial             TINYINT NULL,
    hm_oficina            SMALLINT NOT NULL,
    hm_usuario            VARCHAR (30) NOT NULL,
    hm_terminal           VARCHAR (10) NOT NULL,
    hm_correccion         CHAR (1) NULL,
    hm_sec_correccion     INT NULL,
    hm_origen             CHAR (1) NULL,
    hm_nodo               descripcion NULL,
    hm_reentry            CHAR (1) NULL,
    hm_signo              CHAR (1) NULL,
    hm_fecha_ult_mov      SMALLDATETIME NULL,
    hm_cta_banco          cuenta NULL,
    hm_valor              MONEY NULL,
    hm_chq_propios        MONEY NULL,
    hm_chq_locales        MONEY NULL,
    hm_chq_ot_plazas      MONEY NULL,
    hm_remoto_ssn         INT NULL,
    hm_moneda             TINYINT NULL,
    hm_efectivo           MONEY NULL,
    hm_indicador          TINYINT NULL,
    hm_causa              CHAR (3) NULL,
    hm_departamento       SMALLINT NULL,
    hm_saldo_lib          MONEY NULL,
    hm_saldo_contable     MONEY NULL,
    hm_saldo_disponible   MONEY NULL,
    hm_saldo_interes      MONEY NULL,
    hm_fecha_efec         SMALLDATETIME NULL,
    hm_interes            MONEY NULL,
    hm_control            INT NULL,
    hm_ctadestino         cuenta NULL,
    hm_tipo_xfer          CHAR (2) NULL,
    hm_estado             CHAR (1) NULL,
    hm_concepto           VARCHAR (40) NULL,
    hm_oficina_cta        SMALLINT NULL,
    hm_hora               SMALLDATETIME NULL,
    hm_banco              SMALLINT NULL,
    hm_valor_comision     MONEY NULL,
    hm_prod_banc          SMALLINT NOT NULL,
    hm_categoria          CHAR (1) NOT NULL,
    hm_monto_imp          MONEY NULL,
    hm_tipo_exonerado_imp VARCHAR (2) NULL,
    hm_serial             VARCHAR (30) NULL,
    hm_tipocta_super      CHAR (1) NOT NULL,
    hm_turno              SMALLINT NULL,
    hm_cheque             INT NULL,
    hm_canal              SMALLINT NULL,
    hm_stand_in           CHAR (1) NULL,
    hm_oficial            SMALLINT NULL,
    hm_clase_clte         CHAR (1) NOT NULL,
    hm_cliente            INT NULL,
    hm_base_gmf           MONEY NULL,
    hm_transaccion        NUMERIC (10) IDENTITY NOT NULL
    )
GO

CREATE TABLE ah_his_re_total
    (
    to_fecha         DATETIME NOT NULL,
    to_producto      TINYINT NOT NULL,
    to_moneda        TINYINT NOT NULL,
    to_tipo_tran     SMALLINT NOT NULL,
    to_causa         VARCHAR (12) NOT NULL,
    to_ofic_orig     SMALLINT NOT NULL,
    to_ofic_dest     SMALLINT NOT NULL,
    to_valor         MONEY NOT NULL,
    to_chq_propios   MONEY NOT NULL,
    to_chq_locales   MONEY NOT NULL,
    to_monto_imp     MONEY NOT NULL,
    to_consumo       MONEY NOT NULL,
    to_chq_ot_plazas MONEY NOT NULL,
    to_total         MONEY NOT NULL,
    to_perfil        VARCHAR (10) NOT NULL,
    to_numtran       INT NOT NULL,
    to_estado        CHAR (1) NOT NULL,
    to_tipo          CHAR (1) NOT NULL,
    to_prod_banc     SMALLINT NOT NULL,
    to_categoria     CHAR (1) NOT NULL,
    to_tipocta_super CHAR (1) NOT NULL,
    to_procesado     CHAR (1) NOT NULL
    )
GO


CREATE TABLE ah_his_servicio
    (
    hs_secuencial       INT NOT NULL,
    hs_cod_alterno      INT NULL,
    hs_tipo_transaccion INT NOT NULL,
    hs_clase            CHAR (1) NULL,
    hs_tsfecha          SMALLDATETIME NOT NULL,
    hs_tabla            TINYINT NULL,
    hs_usuario          descripcion NULL,
    hs_terminal         descripcion NULL,
    hs_correccion       CHAR (1) NULL,
    hs_ssn_corr         INT NULL,
    hs_reentry          CHAR (1) NULL,
    hs_origen           CHAR (1) NULL,
    hs_nodo             VARCHAR (30) NULL,
    hs_remoto_ssn       INT NULL,
    hs_ctacte           INT NULL,
    hs_cta_banco        cuenta NULL,
    hs_filial           TINYINT NULL,
    hs_oficina          SMALLINT NULL,
    hs_oficial          SMALLINT NULL,
    hs_fecha_aper       SMALLDATETIME NULL,
    hs_cliente          INT NULL,
    hs_ced_ruc          numero NULL,
    hs_estado           CHAR (1) NULL,
    hs_direccion_ec     TINYINT NULL,
    hs_rol_ente         CHAR (1) NULL,
    hs_descripcion_ec   descripcion NULL,
    hs_cheque_rec       INT NULL,
    hs_ciclo            CHAR (1) NULL,
    hs_categoria        CHAR (1) NULL,
    hs_producto         TINYINT NULL,
    hs_tipo             CHAR (1) NULL,
    hs_indicador        TINYINT NULL,
    hs_moneda           TINYINT NULL,
    hs_default          INT NULL,
    hs_tipo_def         CHAR (1) NULL,
    hs_tipo_promedio    CHAR (1) NULL,
    hs_capitalizacion   CHAR (1) NULL,
    hs_tipo_interes     CHAR (1) NULL,
    hs_numero           SMALLINT NULL,
    hs_fecha            SMALLDATETIME NULL,
    hs_autorizante      descripcion NULL,
    hs_valor            MONEY NULL,
    hs_accion           CHAR (1) NULL,
    hs_secuencia        INT NULL,
    hs_causa            VARCHAR (3) NULL,
    hs_orden            CHAR (1) NULL,
    hs_servicio         VARCHAR (3) NULL,
    hs_saldo            MONEY NULL,
    hs_interes          MONEY NULL,
    hs_contrato         INT NULL,
    hs_fecha_uso        DATETIME NULL,
    hs_monto            MONEY NULL,
    hs_fecha_ven        SMALLDATETIME NULL,
    hs_filial_aut       TINYINT NULL,
    hs_ofi_aut          SMALLINT NULL,
    hs_autoriz_aut      descripcion NULL,
    hs_filial_anula     TINYINT NULL,
    hs_ofi_anula        SMALLINT NULL,
    hs_autoriz_anula    descripcion NULL,
    hs_cheque_desde     INT NULL,
    hs_cheque_hasta     INT NULL,
    hs_causa_np         CHAR (1) NULL,
    hs_clase_np         CHAR (1) NULL,
    hs_departamento     SMALLINT NULL,
    hs_causa_rev        VARCHAR (3) NULL,
    hs_cta_gir          cuenta NULL,
    hs_endoso           INT NULL,
    hs_nro_cheque       INT NULL,
    hs_cod_banco        CHAR (8) NULL,
    hs_corresponsal     CHAR (8) NULL,
    hs_propietario      CHAR (8) NULL,
    hs_carta            INT NULL,
    hs_sec_correccion   INT NULL,
    hs_cheque           INT NULL,
    hs_cta_banco_dep    cuenta NULL,
    hs_oficina_pago     SMALLINT NULL,
    hs_cta_funcionario  CHAR (1) NULL,
    hs_mercantil        CHAR (1) NULL,
    hs_tipocta          CHAR (1) NULL,
    hs_numlib           INT NULL,
    hs_tasa             FLOAT NULL,
    hs_oficina_cta      SMALLINT NULL,
    hs_hora             SMALLDATETIME NULL,
    hs_prod_banc        SMALLINT NULL,
    hs_nombre1          CHAR (64) NULL,
    hs_cedruc1          CHAR (13) NULL,
    hs_observacion      VARCHAR (120) NULL,
    hs_tipocta_super    CHAR (1) NULL,
    hs_turno            SMALLINT NULL,
    hs_clase_clte       CHAR (1) NULL,
    hs_nxmil            CHAR (1) NULL,
    hs_marca_gmf        CHAR (1) NULL,
    hs_fec_marca_gmf    DATETIME NULL
    )
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_his_servicio_Key
    ON ah_his_servicio (hs_tsfecha,hs_oficina,hs_moneda,hs_tipo_transaccion,hs_secuencial,hs_cod_alterno)
GO

CREATE NONCLUSTERED INDEX idx1
    ON ah_his_servicio (hs_tipo_transaccion)
GO

CREATE TABLE ah_saldo_diario
    (
    sd_cuenta           INT NOT NULL,
    sd_fecha            SMALLDATETIME NOT NULL,
    sd_12h              MONEY NOT NULL,
    sd_24h              MONEY NOT NULL,
    sd_48h              MONEY NOT NULL,
    sd_remesas          MONEY NOT NULL,
    sd_saldo_contable   MONEY NOT NULL,
    sd_saldo_disponible MONEY NULL,
    sd_tasa_contable    REAL NOT NULL,
    sd_tasa_disponible  REAL NULL,
    sd_int_hoy          MONEY NOT NULL,
    sd_estado           CHAR (1) NOT NULL,
    sd_categoria        CHAR (1) NOT NULL,
    sd_prod_banc        SMALLINT NOT NULL,
    sd_dias             TINYINT NULL,
    sd_prom_disponible  MONEY NULL,
    sd_promedio1        MONEY NULL
    )
GO

CREATE UNIQUE NONCLUSTERED INDEX ah_saldo_diario_Key
    ON ah_saldo_diario (sd_cuenta,sd_fecha)
GO

CREATE NONCLUSTERED INDEX ah_saldo_diario_Key2
    ON ah_saldo_diario (sd_fecha)
GO

