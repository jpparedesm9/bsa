/************************************************************************/
/*      Archivo:            ah_tmon.sql                                */
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
/*      Este programa realiza la creacion de transacciones monetarias   */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cob_ahorros
go

/* ah_tran_monet */
print '=====> ah_tran_monet'
go
if exists (select * from sysobjects where name = 'ah_tran_monet') 
 drop table ah_tran_monet
go 

/* ah_tran_monet_tmp */
print '=====> ah_tran_monet_tmp'
go
if exists (select * from sysobjects where name = 'ah_tran_monet_tmp') 
 drop table ah_tran_monet_tmp
go 

/* ah_tran_monet_tmp1 */
print '=====> ah_tran_monet_tmp1'
go
if exists (select * from sysobjects where name = 'ah_tran_monet_tmp1') 
 drop table ah_tran_monet_tmp1
go 

CREATE TABLE ah_tran_monet
(
    tm_fecha              SMALLDATETIME NULL,
    tm_secuencial         INT NOT NULL,
    tm_ssn_branch         INT NULL,
    tm_cod_alterno        INT NULL,
    tm_tipo_tran          INT NOT NULL,
    tm_filial             TINYINT NULL,
    tm_oficina            SMALLINT NOT NULL,
    tm_usuario            VARCHAR (30) NOT NULL,
    tm_terminal           VARCHAR (10) NOT NULL,
    tm_correccion         CHAR (1) NULL,
    tm_sec_correccion     INT NULL,
    tm_origen             CHAR (1) NULL,
    tm_nodo               descripcion NULL,
    tm_reentry            CHAR (1) NULL,
    tm_signo              CHAR (1) NULL,
    tm_fecha_ult_mov      SMALLDATETIME NULL,
    tm_cta_banco          cuenta NULL,
    tm_valor              MONEY NULL,
    tm_chq_propios        MONEY NULL,
    tm_chq_locales        MONEY NULL,
    tm_chq_ot_plazas      MONEY NULL,
    tm_remoto_ssn         INT NULL,
    tm_moneda             TINYINT NULL,
    tm_efectivo           MONEY NULL,
    tm_indicador          TINYINT NULL,
    tm_causa              CHAR (3) NULL,
    tm_departamento       SMALLINT NULL,
    tm_saldo_lib          MONEY NULL,
    tm_saldo_contable     MONEY NULL,
    tm_saldo_disponible   MONEY NULL,
    tm_saldo_interes      MONEY NULL,
    tm_fecha_efec         SMALLDATETIME NULL,
    tm_interes            MONEY NULL,
    tm_control            INT NULL,
    tm_ctadestino         cuenta NULL,
    tm_tipo_xfer          CHAR (2) NULL,
    tm_estado             CHAR (1) NULL,
    tm_concepto           VARCHAR (40) NULL,
    tm_oficina_cta        SMALLINT NULL,
    tm_hora               SMALLDATETIME NULL,
    tm_banco              SMALLINT NULL,
    tm_valor_comision     MONEY NULL,
    tm_prod_banc          SMALLINT NOT NULL,
    tm_categoria          CHAR (1) NOT NULL,
    tm_monto_imp          MONEY NULL,
    tm_tipo_exonerado_imp VARCHAR (2) NULL,
    tm_serial             VARCHAR (30) NULL,
    tm_tipocta_super      CHAR (1) NOT NULL,
    tm_turno              SMALLINT NULL,
    tm_cheque             INT NULL,
    tm_forma_pg           CHAR (4) NULL,
    tm_canal              SMALLINT NULL,
    tm_stand_in           CHAR (1) NULL,
    tm_oficial            SMALLINT NULL,
    tm_clase_clte         CHAR (1) NULL,
    tm_cliente            INT NULL,
    tm_base_gmf           MONEY NULL
    )
GO



CREATE TABLE ah_tran_monet_tmp
    (
    tm_fecha              SMALLDATETIME NULL,
    tm_secuencial         INT NOT NULL,
    tm_ssn_branch         INT NULL,
    tm_cod_alterno        INT NULL,
    tm_tipo_tran          INT NOT NULL,
    tm_filial             TINYINT NULL,
    tm_oficina            SMALLINT NOT NULL,
    tm_usuario            VARCHAR (30) NOT NULL,
    tm_terminal           VARCHAR (10) NOT NULL,
    tm_correccion         CHAR (1) NULL,
    tm_sec_correccion     INT NULL,
    tm_origen             CHAR (1) NULL,
    tm_nodo               descripcion NULL,
    tm_reentry            CHAR (1) NULL,
    tm_signo              CHAR (1) NULL,
    tm_fecha_ult_mov      SMALLDATETIME NULL,
    tm_cta_banco          cuenta NULL,
    tm_valor              MONEY NULL,
    tm_chq_propios        MONEY NULL,
    tm_chq_locales        MONEY NULL,
    tm_chq_ot_plazas      MONEY NULL,
    tm_remoto_ssn         INT NULL,
    tm_moneda             TINYINT NULL,
    tm_efectivo           MONEY NULL,
    tm_indicador          TINYINT NULL,
    tm_causa              CHAR (3) NULL,
    tm_departamento       SMALLINT NULL,
    tm_saldo_lib          MONEY NULL,
    tm_saldo_contable     MONEY NULL,
    tm_saldo_disponible   MONEY NULL,
    tm_saldo_interes      MONEY NULL,
    tm_fecha_efec         SMALLDATETIME NULL,
    tm_interes            MONEY NULL,
    tm_control            INT NULL,
    tm_ctadestino         cuenta NULL,
    tm_tipo_xfer          CHAR (2) NULL,
    tm_estado             CHAR (1) NULL,
    tm_concepto           VARCHAR (40) NULL,
    tm_oficina_cta        SMALLINT NULL,
    tm_hora               SMALLDATETIME NULL,
    tm_banco              SMALLINT NULL,
    tm_valor_comision     MONEY NULL,
    tm_prod_banc          SMALLINT NOT NULL,
    tm_categoria          CHAR (1) NOT NULL,
    tm_monto_imp          MONEY NULL,
    tm_tipo_exonerado_imp VARCHAR (2) NULL,
    tm_serial             VARCHAR (30) NULL,
    tm_tipocta_super      CHAR (1) NOT NULL,
    tm_turno              SMALLINT NULL,
    tm_cheque             INT NULL,
    tm_forma_pg           CHAR (4) NULL,
    tm_stand_in           CHAR (1) NULL,
    tm_canal              SMALLINT NULL,
    tm_oficial            SMALLINT NULL,
    tm_clase_clte         CHAR (1) NULL,
    tm_cliente            INT NULL,
    tm_base_gmf           MONEY NULL
    )
GO

CREATE TABLE ah_tran_monet_tmp1
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
    hm_nodo               VARCHAR (64) NULL,
    hm_reentry            CHAR (1) NULL,
    hm_signo              CHAR (1) NULL,
    hm_fecha_ult_mov      SMALLDATETIME NULL,
    hm_cta_banco          VARCHAR (24) NULL,
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
    hm_ctadestino         VARCHAR (24) NULL,
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
