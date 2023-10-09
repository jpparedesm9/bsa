/************************************************************************/
/*      Archivo:            ah_tser.sql                                */
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
/*      Este programa realiza la creacion de transaccion de servicio    */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cob_ahorros
go
/* ah_tran_servicio */
print '=====> ah_tran_servicio'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio') 
 drop table ah_tran_servicio
go 



/* ah_tran_servicio_tmp */
print '=====> ah_tran_servicio_tmp'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio_tmp') 
 drop table ah_tran_servicio_tmp
go 



/* ah_tran_servicio1 */
print '=====> ah_tran_servicio1'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio1') 
 drop table ah_tran_servicio1
go 

/* ah_tran_servicio2 */
print '=====> ah_tran_servicio2'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio2') 
 drop table ah_tran_servicio2
go 

/* ah_tran_servicio3 */
print '=====> ah_tran_servicio3'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio3') 
 drop table ah_tran_servicio3
go 

/* ah_tran_servicio4 */
print '=====> ah_tran_servicio4'
go
if exists (select * from sysobjects where name = 'ah_tran_servicio4') 
 drop table ah_tran_servicio4
go 



CREATE TABLE ah_tran_servicio
    (
    ts_secuencial       INT NOT NULL,
    ts_ssn_branch       INT NULL,
    ts_cod_alterno      INT NULL,
    ts_tipo_transaccion INT NOT NULL,
    ts_clase            CHAR (1) NULL,
    ts_tsfecha          SMALLDATETIME NOT NULL,
    ts_tabla            TINYINT NULL,
    ts_usuario          descripcion NULL,
    ts_terminal         descripcion NULL,
    ts_correccion       CHAR (1) NULL,
    ts_ssn_corr         INT NULL,
    ts_reentry          CHAR (1) NULL,
    ts_origen           CHAR (1) NULL,
    ts_nodo             VARCHAR (30) NULL,
    ts_remoto_ssn       INT NULL,
    ts_ctacte           INT NULL,
    ts_cta_banco        cuenta NULL,
    ts_filial           TINYINT NULL,
    ts_oficina          SMALLINT NULL,
    ts_oficial          SMALLINT NULL,
    ts_fecha_aper       SMALLDATETIME NULL,
    ts_cliente          INT NULL,
    ts_ced_ruc          numero NULL,
    ts_estado           CHAR (1) NULL,
    ts_direccion_ec     TINYINT NULL,
    ts_rol_ente         CHAR (1) NULL,
    ts_descripcion_ec   descripcion NULL,
    ts_cheque_rec       INT NULL,
    ts_ciclo            CHAR (1) NULL,
    ts_categoria        CHAR (1) NULL,
    ts_producto         TINYINT NULL,
    ts_tipo             CHAR (1) NULL,
    ts_indicador        TINYINT NULL,
    ts_moneda           TINYINT NULL,
    ts_default          INT NULL,
    ts_tipo_def         CHAR (1) NULL,
    ts_tipo_promedio    CHAR (1) NULL,
    ts_capitalizacion   CHAR (1) NULL,
    ts_tipo_interes     CHAR (1) NULL,
    ts_numero           SMALLINT NULL,
    ts_fecha            SMALLDATETIME NULL,
    ts_autorizante      descripcion NULL,
    ts_valor            MONEY NULL,
    ts_accion           CHAR (1) NULL,
    ts_secuencia        INT NULL,
    ts_causa            VARCHAR (3) NULL,
    ts_orden            CHAR (1) NULL,
    ts_servicio         VARCHAR (3) NULL,
    ts_saldo            MONEY NULL,
    ts_interes          MONEY NULL,
    ts_contrato         INT NULL,
    ts_fecha_uso        SMALLDATETIME NULL,
    ts_monto            MONEY NULL,
    ts_fecha_ven        SMALLDATETIME NULL,
    ts_filial_aut       TINYINT NULL,
    ts_ofi_aut          SMALLINT NULL,
    ts_autoriz_aut      descripcion NULL,
    ts_filial_anula     TINYINT NULL,
    ts_ofi_anula        SMALLINT NULL,
    ts_autoriz_anula    descripcion NULL,
    ts_cheque_desde     INT NULL,
    ts_cheque_hasta     INT NULL,
    ts_causa_np         CHAR (1) NULL,
    ts_clase_np         CHAR (1) NULL,
    ts_departamento     SMALLINT NULL,
    ts_causa_rev        VARCHAR (3) NULL,
    ts_cta_gir          cuenta NULL,
    ts_endoso           INT NULL,
    ts_nro_cheque       INT NULL,
    ts_cod_banco        CHAR (12) NULL,
    ts_corresponsal     CHAR (12) NULL,
    ts_propietario      CHAR (8) NULL,
    ts_carta            INT NULL,
    ts_sec_correccion   INT NULL,
    ts_cheque           INT NULL,
    ts_cta_banco_dep    cuenta NULL,
    ts_oficina_pago     SMALLINT NULL,
    ts_cta_funcionario  CHAR (1) NULL,
    ts_mercantil        CHAR (1) NULL,
    ts_tipocta          CHAR (1) NULL,
    ts_numlib           INT NULL,
    ts_tasa             FLOAT NULL,
    ts_oficina_cta      SMALLINT NULL,
    ts_hora             SMALLDATETIME NULL,
    ts_prod_banc        SMALLINT NULL,
    ts_nombre1          CHAR (64) NULL,
    ts_cedruc1          CHAR (13) NULL,
    ts_observacion      VARCHAR (120) NULL,
    ts_tipocta_super    CHAR (1) NULL,
    ts_turno            SMALLINT NULL,
    ts_clase_clte       CHAR (1) NULL,
    ts_nxmil            CHAR (1) NULL,
    ts_marca_gmf        CHAR (1) NULL,
    ts_fec_marca_gmf    DATETIME NULL
    )
GO

sp_bindefault 'ah_ssn_branch_serv_def', 'ah_tran_servicio.ts_ssn_branch'
GO

sp_bindefault 'ah_alt_servicio_def', 'ah_tran_servicio.ts_cod_alterno'
GO

sp_bindefault 'ah_fil_servicio_def', 'ah_tran_servicio.ts_filial'
GO

sp_bindefault 'ah_hoy_def', 'ah_tran_servicio.ts_hora'
GO


CREATE TABLE ah_tran_servicio_tmp
    (
    ts_secuencial       INT NOT NULL,
    ts_ssn_branch       INT NULL,
    ts_cod_alterno      INT NULL,
    ts_tipo_transaccion INT NOT NULL,
    ts_clase            CHAR (1) NULL,
    ts_tsfecha          SMALLDATETIME NOT NULL,
    ts_tabla            TINYINT NULL,
    ts_usuario          descripcion NULL,
    ts_terminal         descripcion NULL,
    ts_correccion       CHAR (1) NULL,
    ts_ssn_corr         INT NULL,
    ts_reentry          CHAR (1) NULL,
    ts_origen           CHAR (1) NULL,
    ts_nodo             VARCHAR (30) NULL,
    ts_remoto_ssn       INT NULL,
    ts_ctacte           INT NULL,
    ts_cta_banco        cuenta NULL,
    ts_filial           TINYINT NULL,
    ts_oficina          SMALLINT NULL,
    ts_oficial          SMALLINT NULL,
    ts_fecha_aper       SMALLDATETIME NULL,
    ts_cliente          INT NULL,
    ts_ced_ruc          numero NULL,
    ts_estado           CHAR (1) NULL,
    ts_direccion_ec     TINYINT NULL,
    ts_rol_ente         CHAR (1) NULL,
    ts_descripcion_ec   descripcion NULL,
    ts_cheque_rec       INT NULL,
    ts_ciclo            CHAR (1) NULL,
    ts_categoria        CHAR (1) NULL,
    ts_producto         TINYINT NULL,
    ts_tipo             CHAR (1) NULL,
    ts_indicador        TINYINT NULL,
    ts_moneda           TINYINT NULL,
    ts_default          INT NULL,
    ts_tipo_def         CHAR (1) NULL,
    ts_tipo_promedio    CHAR (1) NULL,
    ts_capitalizacion   CHAR (1) NULL,
    ts_tipo_interes     CHAR (1) NULL,
    ts_numero           SMALLINT NULL,
    ts_fecha            SMALLDATETIME NULL,
    ts_autorizante      descripcion NULL,
    ts_valor            MONEY NULL,
    ts_accion           CHAR (1) NULL,
    ts_secuencia        INT NULL,
    ts_causa            VARCHAR (3) NULL,
    ts_orden            CHAR (1) NULL,
    ts_servicio         VARCHAR (3) NULL,
    ts_saldo            MONEY NULL,
    ts_interes          MONEY NULL,
    ts_contrato         INT NULL,
    ts_fecha_uso        SMALLDATETIME NULL,
    ts_monto            MONEY NULL,
    ts_fecha_ven        SMALLDATETIME NULL,
    ts_filial_aut       TINYINT NULL,
    ts_ofi_aut          SMALLINT NULL,
    ts_autoriz_aut      descripcion NULL,
    ts_filial_anula     TINYINT NULL,
    ts_ofi_anula        SMALLINT NULL,
    ts_autoriz_anula    descripcion NULL,
    ts_cheque_desde     INT NULL,
    ts_cheque_hasta     INT NULL,
    ts_causa_np         CHAR (1) NULL,
    ts_clase_np         CHAR (1) NULL,
    ts_departamento     SMALLINT NULL,
    ts_causa_rev        VARCHAR (3) NULL,
    ts_cta_gir          cuenta NULL,
    ts_endoso           INT NULL,
    ts_nro_cheque       INT NULL,
    ts_cod_banco        CHAR (8) NULL,
    ts_corresponsal     CHAR (8) NULL,
    ts_propietario      CHAR (8) NULL,
    ts_carta            INT NULL,
    ts_sec_correccion   INT NULL,
    ts_cheque           INT NULL,
    ts_cta_banco_dep    cuenta NULL,
    ts_oficina_pago     SMALLINT NULL,
    ts_cta_funcionario  CHAR (1) NULL,
    ts_mercantil        CHAR (1) NULL,
    ts_tipocta          CHAR (1) NULL,
    ts_numlib           INT NULL,
    ts_tasa             FLOAT NULL,
    ts_oficina_cta      SMALLINT NULL,
    ts_hora             SMALLDATETIME NULL,
    ts_prod_banc        SMALLINT NULL,
    ts_nombre1          CHAR (64) NULL,
    ts_cedruc1          CHAR (13) NULL,
    ts_observacion      VARCHAR (120) NULL,
    ts_tipocta_super    CHAR (1) NULL,
    ts_turno            SMALLINT NULL,
    ts_clase_clte       CHAR (1) NULL,
    ts_nxmil            CHAR (1) NULL,
    ts_marca_gmf        CHAR (1) NULL,
    ts_fec_marca_gmf    DATETIME NULL
    )
GO


/* Creacion de tablas de trabajo para el batch */
/* Transaccion de Servicio */
select *
  into ah_tran_servicio1
  from ah_tran_servicio
 where 1 = 2
go

select *
  into ah_tran_servicio2
  from ah_tran_servicio
 where 1 = 2
go

select *
  into ah_tran_servicio3
  from ah_tran_servicio
 where 1 = 2
go

select *
  into ah_tran_servicio4
  from ah_tran_servicio
 where 1 = 2
go