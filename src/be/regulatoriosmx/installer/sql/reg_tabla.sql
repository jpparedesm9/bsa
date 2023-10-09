
/************************************************************************/
/*    ARCHIVO:         reg_tabla.sql                                    */
/*    NOMBRE LOGICO:   reg_tabla.sql                                    */
/*    PRODUCTO:        REGULATORIOS                                     */
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
/*   Script de creacion de tabla para carga de clientes inhibitorios    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/*      31/08/2016      Jorge Salazar           AHO-H81321-Reporte R08  */
/************************************************************************/

use cob_conta_super
go

print '*****  sb_consulta_transacciones'
if not object_id('sb_consulta_transacciones') is null
drop table sb_consulta_transacciones
go

create table sb_consulta_transacciones (
        ct_secuencial          int null,
        ct_ente                int null,          
		ct_nombre              varchar(35) null,    
	    ct_apellido            varchar(35) null,    
		ct_cuenta              varchar(16) null,    
        ct_saldo               money null,    
	    ct_fecha               datetime null,    
		ct_causa               varchar(10)  null,   
		ct_monto_transaccion   money null,
        ct_estado              char(1) null,
        ct_usuario             login null,
        ct_descripcion         varchar(255) null,
        ct_24h                 char(1) null,--valida si es operacion 24H        
        ct_funcionario         varchar(64) null,
        ct_origen              catalogo null,
        ct_aplicativo          smallint null,
		ct_secuencial_det      int null
		)

CREATE UNIQUE CLUSTERED INDEX sb_consulta_transacciones_Key
    ON sb_consulta_transacciones (ct_secuencial)
GO
        
CREATE INDEX sb_consulta_transacciones_x1
    ON sb_consulta_transacciones (ct_ente,ct_cuenta,ct_estado)
GO


print '*****  sb_reporte_r08'
if not object_id('sb_reporte_r08') is null
drop table sb_reporte_r08
go

create table sb_reporte_r08
(
   PERIODO             varchar(6)      not null,
   CLAVE_ENTIDAD       numeric(6)      not null,
   SUBREPORTE          numeric(4)      not null,
   IDENTIFICACION      varchar(12)     not null,
   TIPO_SOCIO          numeric(3)      not null,
   NOM_RAZ_SOCIAL      varchar(150)    not null,
   APELLIDO_MATERNO    varchar(150)    not null,
   APELLIDO_PATERNO    varchar(150)    not null,
   RFC_SOCIO           varchar(13)     not null,
   CURP_SOCIO          varchar(18)     not null,
   GENERO              numeric(3)      not null,
   FECHA_NAC_CONS      varchar(8)      not null,
   POSTAL_DOMICILIO    numeric(25)     not null,
   LOCAL_DOMICILIO     numeric(12)     not null,
   ESTADO_DOMICILIO    numeric(4)      not null,
   PAIS_DOMICILIO      numeric(4)      not null,
   NUM_CERTI_APO       numeric(21)     not null,
   MONTO_CERTI_APO     numeric(21)     not null,
   NUM_CERTI_EXCED     numeric(21)     not null,
   MONTO_CERTI_EXCED   numeric(21)     not null,
   NUMERO_CONTRATO     varchar(12)     not null,
   NUMERO_CUENTA       varchar(24)     not null,
   NOMBRE_SUCURSAL     varchar(150)    not null,
   FECHA_CONTRATO      varchar(8)      not null,
   TIPO_PRODUCTO       numeric(3)      not null,
   TIPO_MODALIDAD      numeric(3)      not null,
   TASA_ANUAL_REND     numeric(6)      not null,
   MONEDA              numeric(3)      not null,
   PLAZO               numeric(4)      not null,
   FECHA_VENCIMIENTO   varchar(8)      not null,
   SALDO_PERIODO_INI   numeric(21)     not null,
   MONTO_DEPOSITO      numeric(21)     not null,
   MONTO_RETIRO        numeric(21)     not null,
   INTERES_DEVENGADO   numeric(18,2)   not null,
   SALDO_PERIODO_FIN   numeric(21)     not null,
   FECHA_ULT_MOV       varchar(8)      not null,
   TIPO_APERTURA_CTA   numeric(3)      not null
)
go

print '*****  sb_reporte_r08_key'
create clustered index sb_reporte_r08_key
    on sb_reporte_r08 (PERIODO,CLAVE_ENTIDAD,SUBREPORTE,NUMERO_CUENTA)
go
print '*****  sb_reporte_operacrelev'
if exists (select 1 from sysobjects where name = 'sb_reporte_operacrelev' and type = 'U')
   drop table sb_reporte_operacrelev
   
 create table   sb_reporte_operacrelev (
 Tipo_reporte               int   null,
 Periodo_reporte            varchar(12)  null,
 Folio                      char(12) ,
 Organo_supervisor          varchar(20)null,
 Clave_sujobl               varchar(20)null,
 Localidad                  varchar(20)null,
 Sucursal                   varchar(20)null,
 Tipo_operacion             char(6)null,
 Inst_monetario             char(6)null,
 Numero_cuenta              varchar(20)null,
 Monto                      money null,
 Moneda                     int null,
 Fecha_operacion            varchar(12) null,
 Fecha_det_operacion        varchar(12) null,
 Nacionalidad               char (10) null,
 Tipo_persona               char(3) null,
 Razon_social               varchar(100)null,
 Nombre                     varchar(30)null,
 Apellido_materno           varchar(30)null,
 Apellido_paterno           varchar(30)null,
 RFC                        varchar(30)null,
 CURP                       varchar(30)null,
 Fecha_nacm                 varchar(12) null,
 Domicilio                  varchar(255) null,
 Colonia                    varchar(30)null, 
 Ciudad                     varchar (20)null,
 Telefono                   varchar (20)null,
 Actividad_economica        varchar (16)null,
 Nombre_agente              varchar(30)null,
 Apellidop_agente           varchar(30)null,
 Apellidom_agente           varchar(30)null,
 RFC_agente                 varchar(30)null,
 CURP_agente                varchar(30)null,
 Consecutivo_cuentas        varchar(16)null,
 Num_cuenta                 varchar(20)null,
 clave_sujeto               int null,
 Nombre_titular             varchar(30)null,
 Apellidop_titular          varchar(30)null,
 Apellidom_titular          varchar(30)null,
 Descrip_operacion          varchar(255)null,
 Razon                      varchar(255)null
 
 )
 
 CREATE CLUSTERED INDEX sb_reporte_operacrelev_Key
	ON sb_reporte_operacrelev (Folio,Num_cuenta)
GO

if object_id ('sb_reporte_buro_cuentas') is not null
    drop table dbo.sb_reporte_buro_cuentas
go
CREATE TABLE dbo.sb_reporte_buro_cuentas
(	
	rb_fecha_report datetime NOT NULL,
	rb_operacion	int NOT NULL,
	rb_ente			int NOT NULL,
    [04] varchar(255)  NOT NULL,
    [05] varchar(255)  NULL,
    [06] varchar(255)  NULL,
    [07] varchar(255)  NULL,
    [08] varchar(255)  NULL,
    [09] bigint		   NULL,
    [10] varchar(255)  NULL,
    [11] varchar(255)  NULL,
    [12] varchar(255)  NULL,
    [13] varchar(255)  NULL,
    [14] varchar(255)  NULL,
    [15] varchar(255)  NULL,
    [16] varchar(255)  NULL,
    [17] varchar(255)  NULL,
    [20] varchar(1)    NULL,
    [21] varchar(255)  NULL,
    [22] bigint  		   NULL,
    [23] varchar(20)    NULL,
    [24] bigint           NULL,
    [25] varchar(255)  NULL,
    [26] varchar(255)  NULL,
    [30] varchar(4)    NULL,
    [39] varchar(1)    NULL,
    [40] varchar(1)    NULL,
    [41] varchar(1)    NULL,
    [43] varchar(255)  NULL,
    [44] varchar(255)  NULL,
    [45] varchar(255)  NULL,
    [46] varchar(1)    NULL,
    [47] varchar(255)  NULL,
    [48] varchar(255)  NULL,
    [49] varchar(255)  NULL,
    [50] varchar(255)  NULL,
    [51] varchar(255)  NULL,
    [52] varchar(255)  NULL
)
go
CREATE CLUSTERED INDEX sb_reporte_buro_cuentas_fk
	ON dbo.sb_reporte_buro_cuentas (rb_fecha_report,rb_operacion,rb_ente)
GO


if object_id ('sb_buro_cliente') is not null
    drop table sb_buro_cliente
go
create table sb_buro_cliente(
bc_en_ente	     int,
bc_p_apellido	  varchar(31) null,
bc_s_apellido	  varchar(31) null,
bc_ad_apellido	  varchar(31) null,
bc_en_nombre	  varchar(31) null,
bc_s_nombre	     varchar(31) null,
bc_fecha_nac	  varchar(13) null,
bc_en_rfc    	  varchar(18) null,
bc_pref_pers	  varchar(9)  null,
bc_suf_pers	     varchar(9)  null,
bc_nacionalidad  varchar(7)  null,
bc_tresidencia	  varchar(6)  null,
bc_lic_conducir  varchar(25) null,
bc_ecivil	     varchar(6)  null,
bc_sexo	        varchar(6)  null,
bc_seg_social	  varchar(25) null,
bc_reg_electoral varchar(25) null,
bc_iden_unica	  varchar(25) null,
bc_clave_pais	  varchar(7) null,
bc_num_depend	  varchar(7) null,
bc_edades_dep	  varchar(35) null,
bc_fec_defuncion varchar(13) null,
bc_ind_defuncion varchar(6) null
)
CREATE CLUSTERED INDEX sb_buro_cliente_fk
	ON dbo.sb_buro_cliente (bc_en_ente)
GO


if object_id ('sb_buro_direccion') is not null
    drop table sb_buro_direccion
go
create table sb_buro_direccion(
   bd_di_ente     int null,
   bd_pri_linea   varchar(60) null,
   bd_seg_linea   varchar(60) null,
   bd_colonia     varchar(60) null,
   bd_delegacion  varchar(60) null,
   bd_ciudad      varchar(60) null,
   bd_estado      varchar(20) null, 
   bd_cod_postal  varchar(20) null,
   bd_fec_reside  varchar(23) null,
   bd_num_telf    varchar(30) null,
   bd_ext_telf    varchar(30) null,
   bd_num_fax     varchar(30) null,
   --
   bd_tdomicilio  varchar(10) null, 
   bd_ind_esp_dom varchar(10) null, 
   bd_org_dom     varchar(10) null  
)
CREATE CLUSTERED INDEX sb_buro_direccion_fk
	ON sb_buro_direccion (bd_di_ente)
GO
-- --------------------
if object_id ('sb_buro_empleo') is not null
    drop table sb_buro_empleo
go
create table sb_buro_empleo(
   be_ente           int ,
   be_raz_social     varchar(104),
   be_pri_linea      varchar(60),
   be_seg_linea      varchar(60),
   be_colonia        varchar(60),
   be_delegacion     varchar(60),
   be_ciudad         varchar(60),
   be_estado         varchar(20),
   be_cod_postal     varchar(20),
   be_num_telf       varchar(30),
   be_ext_telf       varchar(30),
   be_num_fax        varchar(30),
   be_ocupacion      varchar(60),
   be_fecha_contra   varchar(20),
   be_moneda         varchar(20),
   be_sueldo         varchar(20),
   be_frec_pago      varchar(10),
   be_num_empl       varchar(20),
   be_ult_dia_empl   varchar(20),
   be_verif_empl     varchar(20),
   be_origen         varchar(20) 
)

CREATE CLUSTERED INDEX sb_buro_direccion_fk
	ON sb_buro_empleo (be_ente)
GO

-- --------------
if exists (select 1 from sysobjects where name = 'sb_reporte_buro_final' and type = 'U')
   drop table sb_reporte_buro_final
 go
CREATE TABLE sb_reporte_buro_final
(
   rb_id int IDENTITY (1, 1) NOT NULL,
   rb_cadena varchar(max) null --COLLATE Latin1_General_BIN NULL
)
go

-- -------------------------------
-- sb_rep_buro_f_corto_final
if exists (select 1 from sysobjects where name = 'sb_rep_buro_f_corto_final' and type = 'U')
   drop table sb_rep_buro_f_corto_final
 go
CREATE TABLE sb_rep_buro_f_corto_final
(  
   rb_id int IDENTITY (1, 1) NOT NULL,
   rb_cadena varchar(max)
)
go

-- sb_buro_fc_fecha_ult_proc
if exists (select 1 from sysobjects where name = 'sb_buro_fc_fecha_ult_proc' and type = 'U')
   drop table sb_buro_fc_fecha_ult_proc
 go
CREATE TABLE sb_buro_fc_fecha_ult_proc
(  
   bf_id            int IDENTITY (1, 1) NOT NULL,
   bf_fecha_proceso datetime
   --rb_estado        char(1)--> F(finalizado), P(En proceso)
)
go

-- sb_rpt_buro_frmt_act_parc
if exists (select 1 from sysobjects where name = 'sb_rpt_buro_frmt_act_parc' and type = 'U')
   drop table sb_rpt_buro_frmt_act_parc
 go
CREATE TABLE sb_rpt_buro_frmt_act_parc
(  
   rf_fecha_report datetime NOT NULL,
	rf_operacion	int NOT NULL,
	rf_ente			int NOT NULL,
   rf_num_cta     varchar(255) NOT NULL,
   rf_tipo_re_cta varchar(255) NULL,
   rf_tipo_cta    varchar(255) NULL,
   rf_tipo_prod   varchar(255) NULL,
   rf_mon_cred    varchar(255) NULL,
   rf_num_pagos   varchar(255) NULL,
   rf_frec_pagos  varchar(255) NULL,
   rf_monto_pagar varchar(255) NULL,
   rf_fecha_apert varchar(255) NULL,
   rf_fec_ult_pag varchar(255) NULL,
   rf_fec_ult_cmp varchar(255) NULL,
   rf_fec_cierre  varchar(255) NULL,
   rf_fec_rep_inf varchar(255) NULL,   
   rf_cre_max_aut varchar(255) NULL,
   rf_saldo_act   bigint  		 NULL,
   rf_limit_cred  varchar(20)  NULL,
   rf_saldo_venc  bigint       NULL,
   rf_num_pa_venc varchar(255) NULL,
   rf_for_pag_act varchar(255) NULL,
   rf_clave_obsr  varchar(2)   NULL   
)

go

CREATE CLUSTERED INDEX sb_rpt_buro_frmt_act_parc_fk
	ON dbo.sb_rpt_buro_frmt_act_parc (rf_fecha_report,rf_operacion,rf_ente)
GO


IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sb_mov_mes_tmp')
	DROP TABLE sb_mov_mes_tmp
GO
CREATE TABLE sb_mov_mes_tmp(	
	mmt_concepto     VARCHAR(160), 
	mmt_fecha_tran   VARCHAR(10),  
	mmt_comprobante  VARCHAR(20),  
	mmt_cuenta       VARCHAR(32),   
	mmt_oficina_dest VARCHAR(20),  
	mmt_area_dest    VARCHAR(20),  
	mmt_debito       VARCHAR(20),  
	mmt_credito      VARCHAR(20),
	mmt_prestamo	 VARCHAR(20),
	mmt_grupo	 	 VARCHAR(20)
	)
	
GO


IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sb_equivalencia_cuentas')
	DROP TABLE sb_equivalencia_cuentas
GO

create table sb_equivalencia_cuentas
(
   sb_cuenta_cobis             varchar(25)      not null,
   sb_desc_cuenta_cobis        varchar(80)      not null,
   sb_tipo_cuenta_altair       varchar(2)           null,
   sb_tipo_divisa_altair       int                  null,
   sb_cls_sdo_altair           char(1)              null,
   sb_cod_estado_altair        varchar(2)           null,
   sb_cuenta_altair            varchar(25)          null,
   sb_desc_cuenta_altair       varchar(80)          null
)
go--Tabla sb_reporte_ope_inusuales
go
IF OBJECT_ID ('dbo.sb_reporte_ope_inusuales') IS NOT NULL
	DROP TABLE dbo.sb_reporte_ope_inusuales
GO

CREATE TABLE dbo.sb_reporte_ope_inusuales
	(
	oi_id     INT IDENTITY NOT NULL,
	oi_cadena VARCHAR (5000) NULL
	)
GO


use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_lcr_riesgo_provision') IS NOT NULL
	DROP TABLE dbo.sb_lcr_riesgo_provision
GO

CREATE TABLE dbo.sb_lcr_riesgo_provision
	(
	Num_cred              VARCHAR (24) NULL,
	Num_cliente           VARCHAR (20) NULL,
	Num_grupo             VARCHAR (4) NULL,
	Cod_producto          VARCHAR (2) NULL,
	Cod_subproducto       VARCHAR (4) NULL,
	Cod_periodo_capital   VARCHAR (1) NULL,
	Cod_periodo_intereses VARCHAR (1) NULL,
	Exig_T1               VARCHAR (20) NULL,
	Pago_T1               VARCHAR (20) NULL,
	Fec_Exig_T1           VARCHAR (20) NULL,
	Fec_Pago_T1           VARCHAR (20) NULL,
	Exig_T2               VARCHAR (20) NULL,
	Pago_T2               VARCHAR (20) NULL,
	Fec_Exig_T2           VARCHAR (20) NULL,
	Fec_Pago_T2           VARCHAR (20) NULL,
	Exig_T3               VARCHAR (20) NULL,
	Pago_T3               VARCHAR (20) NULL,
	Fec_Exig_T3           VARCHAR (20) NULL,
	Fec_Pago_T3           VARCHAR (20) NULL,
	Exig_T4               VARCHAR (20) NULL,
	Pago_T4               VARCHAR (20) NULL,
	Fec_Exig_T4           VARCHAR (20) NULL,
	Fec_Pago_T4           VARCHAR (20) NULL,
	Exig_T5               VARCHAR (20) NULL,
	Pago_T5               VARCHAR (20) NULL,
	Fec_Exig_T5           VARCHAR (20) NULL,
	Fec_Pago_T5           VARCHAR (20) NULL,
	Exig_T6               VARCHAR (20) NULL,
	Pago_T6               VARCHAR (20) NULL,
	Fec_Exig_T6           VARCHAR (20) NULL,
	Fec_Pago_T6           VARCHAR (20) NULL,
	Exig_T7               VARCHAR (20) NULL,
	Pago_T7               VARCHAR (20) NULL,
	Fec_Exig_T7           VARCHAR (20) NULL,
	Fec_Pago_T7           VARCHAR (20) NULL,
	Exig_T8               VARCHAR (20) NULL,
	Pago_T8               VARCHAR (20) NULL,
	Fec_Exig_T8           VARCHAR (20) NULL,
	Fec_Pago_T8           VARCHAR (20) NULL,
	Exig_T9               VARCHAR (20) NULL,
	Pago_T9               VARCHAR (20) NULL,
	Fec_Exig_T9           VARCHAR (20) NULL,
	Fec_Pago_T9           VARCHAR (20) NULL,
	Exig_T10              VARCHAR (20) NULL,
	Pago_T10              VARCHAR (20) NULL,
	Fec_Exig_T10          VARCHAR (20) NULL,
	Fec_Pago_T10          VARCHAR (20) NULL,
	Exig_T11              VARCHAR (20) NULL,
	Pago_T11              VARCHAR (20) NULL,
	Fec_Exig_T11          VARCHAR (20) NULL,
	Fec_Pago_T11          VARCHAR (20) NULL,
	Exig_T12              VARCHAR (20) NULL,
	Pago_T12              VARCHAR (20) NULL,
	Fec_Exig_T12          VARCHAR (20) NULL,
	Fec_Pago_T12          VARCHAR (20) NULL,
	Exig_T13              VARCHAR (20) NULL,
	Pago_T13              VARCHAR (20) NULL,
	Fec_Exig_T13          VARCHAR (20) NULL,
	Fec_Pago_T13          VARCHAR (20) NULL,
	Exig_T14              VARCHAR (20) NULL,
	Pago_T14              VARCHAR (20) NULL,
	Fec_Exig_T14          VARCHAR (20) NULL,
	Fec_Pago_T14          VARCHAR (20) NULL,
	Exig_T15              VARCHAR (20) NULL,
	Pago_T15              VARCHAR (20) NULL,
	Fec_Exig_T15          VARCHAR (20) NULL,
	Fec_Pago_T15          VARCHAR (20) NULL,
	Exig_T16              VARCHAR (20) NULL,
	Pago_T16              VARCHAR (20) NULL,
	Fec_Exig_T16          VARCHAR (20) NULL,
	Fec_Pago_T16          VARCHAR (20) NULL,
	Imp_total_riesgo      VARCHAR (20) NULL,
	Integrantes           VARCHAR (4) NULL,
	Ciclos                VARCHAR (4) NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.sb_lcr_riesgo_provision (Num_cred)
GO

CREATE NONCLUSTERED INDEX idx2
	ON dbo.sb_lcr_riesgo_provision (Num_cliente)
GO

--creación de tablas para Interfactura caso 117889
USE cob_conta_super
GO
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sb_dato_operacion_abono')
	DROP TABLE sb_dato_operacion_abono
GO
CREATE TABLE sb_dato_operacion_abono (
doa_secuencial   INT IDENTITY ,
doa_aplicativo   SMALLINT,
doa_fecha        DATETIME,
doa_banco        VARCHAR(32),
doa_operacion    INT,
doa_sec_pag      INT,
doa_fecha_pag    DATETIME,
doa_di_fecha_ven DATETIME,
doa_dividendo    SMALLINT,
doa_dias_atraso  INT,
doa_fpago        VARCHAR(32),
doa_total        MONEY,
doa_capital      MONEY,
doa_int          MONEY,
doa_otro         MONEY,
doa_saldo_cap    MONEY,
doa_sec_ing      INT,
doa_oficina      SMALLINT,
doa_estado       VARCHAR(10),
doa_usuario      VARCHAR(20),
doa_moneda       SMALLINT,
doa_iva_int      MONEY,
doa_imo          MONEY,
doa_iva_imo      MONEY,
doa_disp         MONEY,
doa_iva_disp     MONEY,
doa_objetado     VARCHAR(10),
doa_sec_rpa      INT,
doa_tipo_trn     VARCHAR(10

)

GO
CREATE CLUSTERED INDEX idx_1 ON sb_dato_operacion_abono (doa_operacion,doa_sec_pag)
GO
CREATE           INDEX idx_2 ON sb_dato_operacion_abono (doa_banco)
GO
CREATE           INDEX idx_3 ON sb_dato_operacion_abono (doa_aplicativo)
GO

IF OBJECT_ID ('sb_cuota_minima') IS NOT NULL
	DROP table sb_cuota_minima
go

create table sb_cuota_minima
	(
	cm_fecha         datetime,
	cm_aplicativo    smallint,
    cm_banco         varchar(24),
    cm_monto         money  null,
    cm_capital       money  null,
    cm_interes       money  null,
    cm_iva_interes   money  null,
    cm_comision      money  null,
    cm_iva_comision  money  null
	)
go

create index idx0 on sb_cuota_minima(cm_fecha,cm_banco)

IF OBJECT_ID ('sb_datos_lcr') IS NOT NULL
     DROP table sb_datos_lcr
go

create table sb_datos_lcr 
    ( 
	dl_fecha                     datetime,
	dl_aplicativo                smallint,
    dl_banco                     varchar(24),
	dl_dias_de_atraso_6_meses    int null,
    dl_dias_de_atraso_3_meses    int null,
    dl_num_de_atraso_6_meses     int null,
    dl_num_de_atraso_3_meses     int null,
    dl_num_incrementos           int null,
    dl_num_estrellas             int null,
    dl_fecha_prox_aumento        datetime null,
    dl_fecha_ult_aumento         datetime null,
    dl_bloqueado                 char(1) null,
    dl_usuario_ult_modifica      varchar(14),
    dl_num_renovacion            int,
    dl_credito_anterior          varchar(24) 
	)

create index idx0 on sb_datos_lcr(dl_fecha,dl_banco)
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_info_cre_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_info_cre_tmp_lcr
go

create table dbo.sb_info_cre_tmp_lcr
	(
	ic_secuencial          INT,
	ic_fecha_inicio        DATETIME,
	ic_fecha_fin           DATETIME,
	ic_linea_credito       MONEY,
	ic_linea_disponible    MONEY,
	ic_capital             MONEY,
	ic_interes_ordinario   MONEY,
	ic_iva_int_ortdinario  MONEY,
	ic_comision_gastos     MONEY,
	ic_iva_comision_gastos MONEY,
	ic_total               MONEY,
	ic_frecuencia_pago     VARCHAR (64),
	ic_plazo               INT,
	ic_dia_pago            VARCHAR (30),
	ic_tasa_ordinaria      FLOAT,
	ic_tasa_mensual        FLOAT,
	ic_base_calc_int       MONEY,
	ic_cat                 FLOAT,
	ic_comisiones          MONEY,
	ic_banco               VARCHAR(30)
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_info_cre_tmp_lcr (ic_secuencial, ic_banco)
GO

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_resumen_pagos_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_resumen_pagos_tmp_lcr
go

create table dbo.sb_resumen_pagos_tmp_lcr
	(
	rt_secuencial            INT,
	rt_total_pagos           MONEY,
	rt_capital               MONEY,
	rt_int_Ord               MONEY,
	rt_iva_Int_Ord           MONEY,
	rt_gastos_cobranza       MONEY,
	rt_iva_gastos_cobranza   MONEY,
	rt_num_disposiciones     INT,
	rt_importe_disposiciones MONEY,
	rt_importe_total_com     MONEY,
	rt_fecha_cobro_cobranza  VARCHAR (10),
	rt_importe_total_dispos  MONEY,
	rt_fecha_cobro_dispos    VARCHAR (10),
	rt_banco                 VARCHAR (30)
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_resumen_pagos_tmp_lcr (rt_secuencial, rt_banco)
GO

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_dato_operacion_abono_temp_lcr') IS NOT NULL
	DROP table dbo.sb_dato_operacion_abono_temp_lcr
go

create table dbo.sb_dato_operacion_abono_temp_lcr
	(
	doa_sec              INT IDENTITY NOT NULL,
	doa_fecha_ope        VARCHAR (10),
	doa_fecha_pac        VARCHAR (10),
	doa_detalle_mov      VARCHAR (100),
	doa_cap              MONEY,
	doa_inte_ord         MONEY,
	doa_iva_int          MONEY,
	doa_comision_dis     MONEY,
	doa_iva_comision_dis MONEY,
	doa_comision_cob     MONEY,
	doa_iva_comision_cob MONEY,
	doa_total            MONEY,
	doa_saldo_cap        MONEY,
	doa_banco            VARCHAR (32),
	doa_fecha            DATETIME,
	doa_num_pago         INT,
	doa_tipo_trn         VARCHAR (10),
	doa_secuencial        INT
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_dato_operacion_abono_temp_lcr (doa_secuencial, doa_banco)
GO

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_estcta_cab_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_estcta_cab_tmp_lcr
go

create table dbo.sb_estcta_cab_tmp_lcr
	(
	ec_secuencial              int,
	ec_cod_sucursal            int,
	ec_sucursal                varchar (100),
	ec_producto                varchar (100),
	ec_nombre_cliente          varchar (100),
	ec_cod_grupo               int,
	ec_nom_grupo               varchar (100),
	ec_rfc                     varchar (30),
	ec_operacion               varchar (30),
	ec_calle                   varchar (70),
	ec_numero                  int,
	ec_parroquia               varchar (100),
	ec_delegacion              varchar (100),
	ec_codigo_postal           varchar (64),
	ec_estado                  varchar (64),
	ec_fecha_inicio            varchar (10),
	ec_fecha_reporte           varchar (10),
	ec_dia_habil               varchar (10),
	ec_importes                varchar (40),
	ec_folio_fiscal            varchar (1500),
	ec_certificado             varchar (1500),
	ec_sello_digital           varchar (1500),
	ec_sello_sat               varchar (1500),
	ec_no_de_serie_certificado varchar (1500),
	ec_fecha_certificacion     varchar (20),
	ec_cadena_origial_sat      varchar (1500),
	ec_rfc_emisor               varchar(30),
	ec_monto_factura           varchar(30) 
	)

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_estcta_cab_tmp_lcr (ec_secuencial, ec_operacion)
GO

IF OBJECT_ID ('dbo.sb_ods01_tti') IS NOT NULL
	DROP TABLE dbo.sb_ods01_tti
GO
CREATE TABLE dbo.sb_ods01_tti
	(
	campo01 VARCHAR (50) NULL,
	campo02 VARCHAR (50) NULL,
	campo03 VARCHAR (50) NULL,
	campo04 VARCHAR (50) NULL,
	campo05 VARCHAR (50) NULL,
	campo06 VARCHAR (50) NULL,
	campo07 VARCHAR (50) NULL,
	campo08 VARCHAR (50) NULL,
	campo09 VARCHAR (50) NULL,
	campo10 VARCHAR (50) NULL,
	campo11 VARCHAR (50) NULL,
	campo12 VARCHAR (50) NULL,
	campo13 VARCHAR (50) NULL,
	campo14 VARCHAR (50) NULL,
	campo15 VARCHAR (50) NULL,
	campo16 VARCHAR (50) NULL,
	campo17 VARCHAR (50) NULL,
	campo18 VARCHAR (50) NULL,
	campo19 VARCHAR (50) NULL,
	campo20 VARCHAR (50) NULL,
	campo21 VARCHAR (50) NULL,
	campo22 VARCHAR (50) NULL,
	campo23 VARCHAR (50) NULL,
	campo24 VARCHAR (50) NULL,
	campo25 VARCHAR (50) NULL,
	campo26 VARCHAR (50) NULL,
	campo27 VARCHAR (50) NULL,
	campo28 VARCHAR (50) NULL,
	campo29 VARCHAR (50) NULL,
    campo30 VARCHAR (50) NULL,
	campo31 VARCHAR (50) NULL,
	campo32 VARCHAR (50) NULL,
	campo33 VARCHAR (50) NULL,
	campo34 VARCHAR (50) NULL,
	campo35 VARCHAR (50) NULL,
	campo36 VARCHAR (50) NULL,
	campo37 VARCHAR (50) NULL,
	campo38 VARCHAR (50) NULL,
	campo39 VARCHAR (50) NULL,
	campo40 VARCHAR (50) NULL,
	campo41 VARCHAR (8)  NULL
	)
GO

 IF OBJECT_ID ('dbo.sb_ods_balanactivos_tti') IS NOT NULL
	DROP TABLE dbo.sb_ods_balanactivos_tti
GO

CREATE TABLE dbo.sb_ods_balanactivos_tti
	(
	ob_num_cuenta       VARCHAR (25) NULL,
	ob_cod_cta_cont     VARCHAR (25) NULL,
	ob_cod_divisa       CHAR (3) NULL,
	ob_fec_data         VARCHAR (10) NULL,
	ob_cod_pais         TINYINT NULL,
	ob_cod_centro_cont  SMALLINT NULL,
	ob_cod_entidad      TINYINT NULL,
	ob_imp_sdo_cont_mo  MONEY NULL,
	ob_imp_sdo_cont_ml  MONEY NULL,
	ob_registro_archivo VARCHAR (1000) NULL
	)
GO



IF OBJECT_ID ('dbo.sb_ods_movresultados_tti') IS NOT NULL

	DROP TABLE dbo.sb_ods_movresultados_tti
GO

CREATE TABLE dbo.sb_ods_movresultados_tti

	(
	om_num_cuenta       VARCHAR (25) NULL,
	om_cod_cta_cont     VARCHAR (25) NULL,
	om_cod_divisa       CHAR (3) NULL,
	om_fec_data         VARCHAR (10) NULL,
	om_cod_pais         TINYINT NULL,
	om_cod_centro_cont  SMALLINT NULL,
	om_cod_entidad      TINYINT NULL,
	om_imp_ie_mo        MONEY NULL,
	om_imp_ie_ml        MONEY NULL,
	om_registro_archivo VARCHAR (1000) NULL
	)
GO


IF OBJECT_ID ('dbo.sb_reporte_operativo') IS NOT NULL
	DROP table dbo.sb_reporte_operativo
go

create table dbo.sb_reporte_operativo
	(
	OFICINA                            varchar (64) not null,
	REGION                             varchar (64) not null,
	CC                                 smallint not null,
	CONTRATO                           varchar (24) not null,
	[ID GRUPO]                         int not null,
	[NOMBRE GRUPO]                     varchar (64) not null,
	[CICLO GRUPAL ]                    varchar (3) not null,
	[NUMERO DE INTEGRANTES]            varchar (4) not null,
	RFC                                varchar (24) not null,
	CURP                               varchar (255) not null,
	[CLIENTE COBIS]                    int not null,
	BUC                                varchar (20) not null,
	[FOLIO CONSULTA BURO]              varchar (64) not null,
	[APELLIDO PATERNO]                 varchar (64) not null,
	[APELLIDO MATERNO]                 varchar (64) not null,
	NOMBRE1                            varchar (64) not null,
	NOMBRE2                            varchar (64) not null,
	[EXPERIENCIA CREDITICIA]           char (2) not null,
	[EXPERIENCIA ACT]                  varchar (10) not null,
	[SUBPRODUCTO CUENTA DEPOSITO]      varchar (10) not null,
	[CUENTA DEPOSITO]                  varchar (24) not null,
	[CICLO INDIVIDUAL]                 int not null,
	GENERO                             varchar (10) not null,
	EDAD                               int not null,
	[FECHA NACIMIENTO]                 varchar (30) not null,
	DOM_TELEFONO                       varchar (16) not null,
	DOM_DIRECCION                      varchar (254) not null,
	ESTADO                             varchar (64) not null,
	MUNICIPIO                          varchar (64) not null,
	LOCALIDAD                          varchar (64) not null,
	[C.P.]                             int not null,
	NEG_TELEFONO                       varchar (16) not null,
	NEG_DIRECCION                      varchar (254) not null,
	NEG_ESTADO                         varchar (64) not null,
	NEG_MUNICIPIO                      varchar (64) not null,
	NEG_LOCALIDAD                      varchar (64) not null,
	NEG_CP                             int not null,
	[NEG_TIPO DE LOCAL]                varchar (64) not null,
	ESCOLARIDAD                        varchar (64) not null,
	[CLAVE ACTIVIDAD ECON]             varchar (10) not null,
	[ACTIVIDAD ECONOMICA]              varchar (200) not null,
	[NOMBRE CORTO ACT]                 varchar (100) not null,
	[CORREO ELECTRONICO DEL CLIENTE]   varchar (254) not null,
	[ESTADO CIVIL]                     varchar (64) not null,
	[NOMBRE CONYUGE]                   varchar (255) not null,
	[TIPO DOC CONYUGE]                 varchar (100) not null,
	[DOCUMENTO CONYUGE]                varchar (30) not null,
	[DESTINO DEL CREDITO]              varchar (64) not null,
	[NOMBRE GERENTE]                   varchar (64) not null,
	[NOMBRE COORDINADOR]               varchar (64) not null,
	[NOMBRE DEL ASESOR]                varchar (64) not null,
	[CORREO ELECTRONICO ASESOR]        varchar (64) not null,
	[TELEFONO DEL ASESOR]              varchar (64) not null,
	[ESTATUS ASESOR]                   varchar (64) not null,
	[PRODUCTO DE PRESTAMOS]            varchar (10) not null,
	[SUBPRODUCTO PRESTAMO]             varchar (64) not null,
	[MONTO CREDITO]                    money not null,
	[FECHA SOLICITUD]                  varchar (30) not null,
	[FECHA APROBACION MONTOS]          varchar (30) not null,
	[FECHA DESEMBOLSO]                 varchar (30) not null,
	[FECHA VENCIMIENTO PRESTAMO]       varchar (30) not null,
	[NUMERO DE CONTRATO]               varchar (24) not null,
	PLAZO                              varchar (64) not null,
	[NUMERO CUOTAS]                    smallint not null,
	[DIA DE PAGO]                      varchar (9) not null,
	[PLAZO DIAS]                       int not null,
	[PLAZO MES]                        numeric (17, 6) not null,
	[VALOR CUOTA]                      money not null,
	[CAPITAL DE LA CUOTA]              money not null,
	[INTERESES DE LA CUOTA]            money not null,
	[IVA DE LA CUOTA]                  money not null,
	[FECHA PROX. CUOTA]                varchar (30) not null,
	CAT                                float not null,
	[TASA INTERES (ANUAL)]             float not null,
	[ESTATUS DEL CREDITO]              varchar (30) not null,
	[ESTADO CARTERA]                   varchar (64) not null,
	[CUOTAS PENDIENTES]                smallint not null,
	[CUOTAS VENCIDAS]                  smallint not null,
	[CAPITAL VIGENTE EXIGIBLE]         money not null,
	[CAPITAL VENCIDO EXIGIBLE]         money not null,
	[CAPITAL VENCIDO NO EXIGIBLE]      money not null,
	[CAPITAL VIGENTE NO EXIGIBLE]      money not null,
	[SALDO CAP]                        money not null,
	[INTERES VIGENTE EXIGIBLE]         money not null,
	[INTERES VIGENTE NO EXIGIBLE]      money not null,
	[INTERES VENCIDO]                  money not null,
	[INTERES SUSPENDIDO]               money not null,
	[TOTAL INTERES PROYECTADOS]        money not null,
	[TOTAL COMISIONES MORA PAGADAS]    money not null,
	[TOTAL INTERES NORMAL PAGADO]      money not null,
	[IVA INTERES EXIGIBLE]             money not null,
	[IVA INTERES NO EXIGIBLE]          money not null,
	COMISIONES                         money not null,
	[IVA COMISION]                     money not null,
	[SALDO INTERESES]                  money not null,
	[SALDO INT MORA]                   money not null,
	[SALDO REAL EXIGIBLE]              money not null,
	[SALDO SEG]                        money not null,
	[SALDO TOTAL]                      money not null,
	[SALDO TOTAL EN MORA]              money not null,
	[IMPORTE LIQUIDA CON]              money not null,
	[DIAS MAX ATRASO ANT]              int not null,
	[DIAS MAX ATRASO ACT]              int not null,
	[IMPORTE MAX ATRASO]               money not null,
	[SEMANAS DE ATRASO]                int,
	[DIAS MORA]                        int not null,
	[FECHA RECIBO ANTIGUO IMP]         varchar (30) not null,
	[FECHA ULTIMA SITUACION DEUDA]     varchar (30) not null,
	[FECHA ULT ESTATUS CREDITO]        varchar (30) not null,
	[PORCENTAJE RESERVA]               float not null,
	[CARTERA EN RIESGO]                money not null,
	[CSTN RESP1]                       varchar (64) not null,
	[CSTN RESP2]                       varchar (64) not null,
	[CSTN RESP3]                       varchar (64) not null,
	[CSTN RESP4]                       varchar (64) not null,
	[CSTN RESP5]                       varchar (64) not null,
	[CSTN RESP6]                       varchar (64) not null,
	[CSTN RESP7]                       varchar (64) not null,
	[CSTN RESP8]                       varchar (64) not null,
	[CSTN RESP9]                       varchar (64) not null,
	[CSTN RESP10]                      varchar (64) not null,
	[CSTN RESP11]                      varchar (64) not null,
	[CSTN RESP12]                      varchar (64) not null,
	[CSTN RESP13]                      varchar (64) not null,
	[CSTN RESP14]                      varchar (64) not null,
	[CSTN RESP15]                      varchar (64) not null,
	[CSTN RESP16]                      varchar (64) not null,
	[CSTN RESP17]                      varchar (64) not null,
	[ESTATUS TECNOLOGICO]              varchar (100) not null,
	[NIVEL DE RIESGO]                  char (1) not null,
	[PUNTAJE DE RIESGO]                char (3) not null,
	[ROL MESA DIRECTIVA]               varchar (64) not null,
	[COORDENADAS DOMICILIO]            varchar (100) not null,
	[INGRESO MENSUAL]                  money not null,
	[GASTOS MENSUALES NEGOCIO]         money not null,
	[GASTOS MENSUALES FAMILIARES]      money not null,
	[OTROS INGRESOS]                   money not null,
	[CAPACIDAD DE PAGO]                money not null,
	[NUMERO DE EMPLEADO DEL ASESOR]    varchar (10) not null,
	[NUMERO DE EMPLEADO DEL COORDINADOR] varchar (10) not null,
	[NUMERO DE EMPLEADO DEL GERENTE]   varchar (10) not null,
	[DIA DE REUNION SEMANAL]           varchar (10) not null,
	[HORA DE REUNION SEMANAL]          varchar (10) not null,
	[LIMITE DE CREDITO ACTUAL]         money not null,
	[SALDO DISPONIBLE]                 money not null,
	[TIPO DE MERCADO]                  varchar (30) not null,
	[NIVEL CLIENTE EN COLECTIVO]       varchar (30) not null,
	[VALOR DISPONIBLE GARANTIAS]       money not null,
	[INDICADOR DE REUNION]             varchar (125) not null,
	[COORDENADAS NEGOCIO]              varchar (100) not null,
	[NRO OPERACION GRUPAL]             varchar (24) not null
	)
go


IF OBJECT_ID ('dbo.sb_rep_oper_mc_collect') IS NOT NULL
	DROP table dbo.sb_rep_oper_mc_collect
go

create table dbo.sb_rep_oper_mc_collect
		(
	secuencial_mc                        int identity not null,
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
	fecha_prox_couta_mc                varchar (30) not null,
	[NUMERO_CUOTA]                     varchar(30),
	[MONTO_GARANTIA]                   varchar(30),
	[ESTADO_CREDITO]                   varchar(30),                  --149740
	CONSTRAINT PK_sb_rep_oper_mc_collect PRIMARY KEY NONCLUSTERED (secuencial_mc)
	)
go

create index idx_cliente_contrato on sb_rep_oper_mc_collect ([CLIENTE COBIS],[CONTRATO])
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
		sb_tasarev          varchar(24),
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
		sb_mesesic          varchar(1),
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
--Segunda Fase Mc collect
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
	fecha_prox_couta          varchar (30) not null
	)
go

CREATE INDEX IDX_OP_CLI_OPI_FECHA
ON cob_conta_super..sb_rep_ini_cobis_collect (nro_operacion_grupal,cliente_cobis,contrato,fecha_carga_real)
go

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


IF OBJECT_ID ('dbo.sb_ods01_tmp') IS NOT NULL
	DROP TABLE dbo.sb_ods01_tmp
GO
CREATE TABLE dbo.sb_ods01_tmp
	(
	campo01 VARCHAR (50) NULL,
	campo02 VARCHAR (50) NULL,
	campo03 VARCHAR (50) NULL,
	campo04 VARCHAR (50) NULL,
	campo05 VARCHAR (50) NULL,
	campo06 VARCHAR (50) NULL,
	campo07 VARCHAR (50) NULL,
	campo08 VARCHAR (50) NULL,
	campo09 VARCHAR (50) NULL,
	campo10 VARCHAR (50) NULL,
	campo11 VARCHAR (50) NULL,
	campo12 VARCHAR (50) NULL,
	campo13 VARCHAR (50) NULL,
	campo14 VARCHAR (50) NULL,
	campo15 VARCHAR (50) NULL,
	campo16 VARCHAR (50) NULL,
	campo17 VARCHAR (50) NULL,
	campo18 VARCHAR (50) NULL,
	campo19 VARCHAR (50) NULL,
	campo20 VARCHAR (50) NULL,
	campo21 VARCHAR (50) NULL,
	campo22 VARCHAR (50) NULL,
	campo23 VARCHAR (50) NULL,
	campo24 VARCHAR (50) NULL,
	campo25 VARCHAR (50) NULL,
	campo26 VARCHAR (50) NULL,
	campo27 VARCHAR (50) NULL,
	campo28 VARCHAR (50) NULL,
	campo29 VARCHAR (50) NULL,
    campo30 VARCHAR (50) NULL,
	campo31 VARCHAR (50) NULL,
	campo32 VARCHAR (50) NULL,
	campo33 VARCHAR (50) NULL,
	campo34 VARCHAR (50) NULL,
	campo35 VARCHAR (50) NULL,
	campo36 VARCHAR (50) NULL,
	campo37 VARCHAR (50) NULL,
	campo38 VARCHAR (50) NULL,
	campo39 VARCHAR (50) NULL,
	campo40 VARCHAR (50) NULL
	)
GO



IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sb_mov_mes_tmp_tti')
	DROP TABLE sb_mov_mes_tmp_tti
GO
CREATE TABLE sb_mov_mes_tmp_tti(	
	mmt_concepto     VARCHAR(160), 
	mmt_fecha_tran   VARCHAR(10),  
	mmt_comprobante  VARCHAR(20),  
	mmt_cuenta       VARCHAR(32),   
	mmt_oficina_dest VARCHAR(20),  
	mmt_area_dest    VARCHAR(20),  
	mmt_debito       VARCHAR(20),  
	mmt_credito      VARCHAR(20),
	mmt_prestamo	 VARCHAR(20),
	mmt_grupo	 	 VARCHAR(20)
	)
	
GO


IF OBJECT_ID ('sb_ods_balanactivos_ttj') IS NOT NULL
	drop table sb_ods_balanactivos_ttj
go

create table sb_ods_balanactivos_ttj
	(
	ob_num_cuenta      varchar (25),
	ob_cod_cta_cont    varchar (25),
	ob_cod_divisa      varchar (50),
	ob_fec_data        varchar (10),
	ob_cod_pais        varchar (50),
	ob_cod_centro_cont varchar (50),
	ob_cod_entidad     varchar (50),
	ob_imp_sdo_cont_mo varchar (50),
	ob_imp_sdo_cont_ml varchar (50)
	)
go


IF OBJECT_ID ('sb_ods_movresultados_ttj') IS NOT NULL
	drop table sb_ods_movresultados_ttj
go

create table sb_ods_movresultados_ttj
	(
	om_num_cuenta      varchar (25),
	om_cod_cta_cont    varchar (25),
	om_cod_divisa      varchar (50),
	om_fec_data        varchar (10),
	om_cod_pais        varchar (50),
	om_cod_centro_cont varchar (50),
	om_cod_entidad     varchar (50),
	om_imp_ie_mo       varchar (50),
	om_imp_ie_ml       varchar (50)
	)
go



IF OBJECT_ID ('sb_ods_plancuentas_ttj') IS NOT NULL
	drop table sb_ods_plancuentas_ttj
go

create table dbo.sb_ods_plancuentas_ttj
	(
	op_cod_cta_cont   varchar (25),
	op_cod_entidad    varchar (50),
	op_des_cta_cont   varchar (64),
	op_tip_cta_cont   varchar (2),
	op_tip_divisa     varchar (50),
	op_cls_sdo        varchar (50),
	op_cod_est_sdo    varchar (50),
	op_tip_acceso     varchar (50),
	op_cod_est_cuenta varchar (50),
	op_fec_alta       varchar (10),
	op_fec_baja       varchar (10),
	op_fec_data       varchar (10),
	op_cod_cargabal   varchar (64)
	)
go




IF OBJECT_ID ('sb_ods_saldos_cont_ttj') IS NOT NULL
	DROP table sb_ods_saldos_cont_ttj
go

create table sb_ods_saldos_cont_ttj
	(
	os_cod_cta_cont    varchar (24),
	os_cod_centro_cont varchar (20),
	os_cod_divisa      varchar (3),
	os_cod_entidad     varchar (20),
	os_tip_divisa      varchar (20),
	os_sdo_mo          varchar (20),
	os_sdo_ml          varchar (20),
	os_sdo_med_mo      varchar (20),
	os_sdo_med_ml      varchar (20),
	os_sdo_mes_mo      varchar (20),
	os_sdo_mes_ml      varchar (20),
	os_fec_data        varchar (10),
	os_cod_area_cont   varchar (20),
	os_des_area_cont   varchar (50)
	)
go

IF OBJECT_ID ('dbo.sb_riesgo_hrc_ttj') IS NOT NULL
	DROP table dbo.sb_riesgo_hrc_ttj
go

create table dbo.sb_riesgo_hrc_ttj
	(
	rh_fec_info                     varchar (30),
	rh_num_cred                     varchar (25),
	rh_num_cliente_operativo        varchar (64),
	rh_desc_nombre_cliente          varchar (255),
	rh_cod_entidad                  varchar (4),
	rh_desc_entidad                 varchar (30),
	rh_desc_sistema_origen          varchar (10),
	rh_num_suc_titular              varchar (20),
	rh_cod_producto                 varchar (2),
	rh_cod_subproducto              varchar (4),
	rh_desc_producto                varchar (25),
	rh_desc_subproducto             varchar (255),--caso#173628
	rh_flg_revolvente               varchar (10),
	rh_flg_tratamiento_contable     varchar (10),
	rh_cod_tipo_amortiza            varchar (10),
	rh_desc_tipo_amortiza           varchar (30),
	rh_num_cta_cheques              varchar (25),
	rh_fec_formaliza                varchar (30),
	rh_fec_vencimiento              varchar (30),
	rh_cod_tasa                     varchar (9),
	rh_desc_tasa                    varchar (15),
	rh_flg_tasa_variable            varchar (10),
	rh_fec_prox_revisa_tasa         varchar (30),
	rh_cod_periodo_revisa_tasa      varchar (1),
	rh_pct_tasa_cobr                varchar (50),
	rh_num_puntos_spread            varchar (10),
	rh_fec_ult_amort_incump_cap     varchar (30),
	rh_fec_ult_amort_incump_int     varchar (30),
	rh_num_doctos_vencidos          varchar (5),
	rh_cod_periodo_capital          varchar (10),
	rh_desc_periodo_capital         varchar (10),
	rh_cod_periodo_intereses        varchar (10),
	rh_desc_periodo_intereses       varchar (10),
	rh_cod_bloqueo                  varchar (10),
	rh_desc_bloqueo                 varchar (1),
	rh_cod_moneda                   varchar (3),
	rh_imp_concedido                varchar (30),
	rh_imp_limite_credito           varchar (30),
	rh_imp_disponible               varchar (30),
	rh_imp_total_riesgo_sistema     varchar (30),
	rh_imp_cap_noexig               varchar (30),
	rh_imp_cap_exig                 varchar (30),
	rh_imp_int_noexig               varchar (30),
	rh_imp_int_exig                 varchar (30),
	rh_imp_int_suspen               varchar (30),
	rh_imp_inversion                varchar (30),
	rh_imp_total_riesgo             varchar (30),
	rh_fec_traspaso_vencido         varchar (30),
	rh_num_linea_madre              varchar (64),
	rh_flg_mora_sistema             varchar (10),
	rh_fec_prox_corte               varchar (30),
	rh_cod_pais_origen              varchar (10),
	rh_cod_pais_residencia          varchar (10),
	rh_cod_tipo_persona             varchar (32),
	rh_cod_sector_economico         varchar (10),
	rh_cod_unidad_negocio           varchar (1),
	rh_cod_unidad_negocio_ope_ori   varchar (1),
	rh_cod_sector_contable          varchar (1),
	rh_cod_actividad_economica      varchar (10),
	rh_desc_rfc                     varchar (255),
	rh_desc_pais_origen             varchar (64),
	rh_desc_pais_residencia         varchar (64),
	rh_desc_sector_economico        varchar (200),
	rh_desc_tipo_persona            varchar (64),
	rh_desc_unidad_negocio          varchar (64),
	rh_cod_localidad_dom_primario   varchar (64),
	rh_desc_actividad_economica_esp varchar (200),
	rh_fec_prox_corte_prin          varchar (30),
	rh_fec_prox_corte_int           varchar (30),
	rh_fec_formaliza_ult_disp       varchar (30),
	rh_imp_seguro_desempleo         varchar (30),
	rh_imp_seguro_vida              varchar (30),
	rh_flg_garantia                 varchar (30),
	rh_pct_tasa_base                varchar (50),
	rh_imp_pag_adelantado           varchar (30),
	rh_num_ult_recibo_facturado     varchar (10),
	rh_cod_bloq_disposicion         varchar (1),
	rh_imp_pago_domiciliado         varchar (20),
	rh_fec_cobranza                 varchar (10),
	rh_pct_cat                      varchar (50),
	rh_desc_tipo_solicitud          varchar (15),
	rh_desc_canal                   varchar (15),
	rh_fec_vencimiento_renovacion   varchar (10),
	rh_fec_nacimiento               varchar (30),
	rh_cod_estado_civil             varchar (10),
	rh_cod_genero                   varchar (10),
	rh_imp_ingreso_dispersion       varchar (10),
	rh_flg_dispersion_ult_3m        varchar (10),
	rh_cod_tipo_interviniente       varchar (1),
	rh_cod_finalidad_credito        varchar (64),
	rh_cod_periodo_capital1         varchar (10),
	rh_cod_periodo_capital2         varchar (10),
	rh_num_dias_atraso              varchar (10),
	rh_num_plazo_remanente_dias     varchar (10),
	rh_integrantes_grupo            varchar (10),
	rh_ciclo_individual             varchar (10),
	rh_ciclo_grupal                 varchar (10)
	)
go

create clustered index idx1
	on dbo.sb_riesgo_hrc_ttj (rh_num_cred)
go

/**************************************************************/
/*  TABLA REPORTE CLIENTS MOROSIDAD                           */
/**************************************************************/

IF OBJECT_ID ('dbo.sb_reporte_morosidad') IS NOT NULL
	DROP table dbo.sb_reporte_morosidad
go

create table cob_conta_super..sb_reporte_morosidad (
[CLIENTE]                        varchar(100),
[BANCO]                          varchar(100),
[NOMBRE_CLIENTE]                 varchar(500),
[AGENCIA_ACTUAL]                 varchar(100),           
[FEC_REF_AGENCIA]                varchar(100),
[BUC]                            varchar(100),
[PAGOS_VENCIDOS]                 varchar(100),
[TOTAL_DEUDOR]                   varchar(100),                
[PAGO_MINIMO]                    varchar(100),
[MONTO_MOROSO]                   varchar(100),
[CODIGO_BLOQUEO]                 varchar(100),
[FEC_CODIGO_BLOQUEO]             varchar(100),        
[DIA_CORTE]                      varchar(100),
[DIAS_AGENCIA]                   varchar(100),
[DESC_PRODUCTO]                  varchar(100),
[CALLE_NO_CLIENTE]               varchar(100),           
[COLONIA_CLIENTE]                varchar(100),
[CIUDAD_CLIENTE]                 varchar(100),
[ESTADO]                         varchar(100),
[CODIGO_POSTAL]                  varchar(100),               
[LADA_1]                         varchar(100),
[TEL_1]                          varchar(100),
[LADA_2]                         varchar(100),
[TEL_2]                          varchar(100),                      
[LADA_3]                         varchar(100),
[TEL_3]                          varchar(100),
[AGENCIA_PREVIA]                 varchar(100),
[FEC_REF_AGENCIA_PREVIA]         varchar(100),      
[FEC_ULTIMA_COMPRA]              varchar(100),
[FEC_ULTIMA_DISPOSICION]         varchar(100),
[MONTO_ULTIMA_COMPRA]            varchar(100), 
[MONTO_ULTIMA_DISPOSICION]       varchar(100),  
[FECHA_APERTURA_CUENTA]          varchar(100),
[RFC]                            varchar(100),
[MONTO_ASIGNADO_AGENCIA]         varchar(100),
[MONTO_ASIGNADO_AGENCIA_PREV]    varchar(100),
[FECHA_LIMITE_PAGO]              varchar(100),
[LIMITE_CREDITO]                 varchar(100),
[CUENTA_CHEQUES]                 varchar(100),
[STACTECA]                       varchar(100),                   
[SALDO_VENCIDO_30_DIAS]          varchar(100),
[SALDO_VENCIDO_60_DIAS]          varchar(100),
[SALDO_VENCIDO_90_DIAS]          varchar(100),
[SALDO_VENCIDO_120_DIAS]         varchar(100),  
[SEGMENTO_ACTUAL]                varchar(100),
[SEGMENTO_POSTERIOR]             varchar(100),
[DIAS_FALTANTES]                 varchar(100),
[FECHA_CAMBIO_SEGMENTO]          varchar(100),
[CORREO]                         varchar(100),
[ID_GRUPA]                       varchar(100), --145941
[NOMBRE_GRUPO]                   varchar(100), --145941
[ROL_CLIENTE]                    varchar(100), --145941
[ATRASO_GRUPAL]                  varchar(100)  --145941
)

go



/**************************************************************/
/*  TABLA REPORTE TELEFONOS DOMICILIO                         */
/**************************************************************/

IF OBJECT_ID ('dbo.sb_reporte_telefono_domicilio') IS NOT NULL
	DROP table dbo.sb_reporte_telefono_domicilio
go

create table sb_reporte_telefono_domicilio(
[AGENCIA_ACTUAL]                varchar(20),
[BUC]                           varchar(20),
[ESTATUS]                       varchar(20),
[LADA]                          varchar(20),           
[TEL]                           varchar(20),
[EXT]                           varchar(20),
[TIPO]                          varchar(20))

go 

/**************************************************************/
/*  TABLA REPORTE ASIGNACIONES 2                              */
/**************************************************************/

IF OBJECT_ID ('dbo.sb_reporte_asigna_mora') IS NOT NULL
	DROP table dbo.sb_reporte_asigna_mora
go


create table sb_reporte_asigna_mora  (
[NO_CUENTA]                     varchar(24),
[PAGOS_VENCIDOS]                varchar(30),
[DIAS_MOROSOS]                  varchar(30),
[TOTAL_DEUDOR]                  varchar(30),           
[MONTO_MOROSO]                  varchar(30),
[PAGO_MINIMO]                   varchar(30),
[MONTO_ULTIMO_PAGO]             varchar(30),
[FECHA_ULTIMO_PAGO]             varchar(30),                
[ULTIMO_SALDO_MES_ANTERIOR]     varchar(30),
[SALDO_VENCIDO_30_DIAS]         varchar(30),
[SALDO_VENCIDO_60_DIAS]         varchar(30),
[SALDO_VENCIDO_90_DIAS]         varchar(30),          
[SALDO_VENCIDO_120_DIAS]        varchar(30),
[FECHA_PROX_VENCIMIENTO]        varchar(30),
[PLAZO_PACTADO]                 varchar(30),
[CLASIF]                        varchar(30),            
[MOTIVO]                        varchar(30),
[PV_1MES_ATRAS]                 varchar(30),
[PV_2MES_ATRAS]                 varchar(30),
[PV_3MES_ATRAS]                 varchar(30),               
[PV_4MES_ATRAS]                 varchar(30),
[PV_5MES_ATRAS]                 varchar(30),
[PV_6MES_ATRAS]                 varchar(30),
[TRASCODIFICADA]                varchar(30),
[INTERESES_ORDINARIOS]          varchar(30), --145941
[IVA_INTERESES_ORDINARIOS]      varchar(30), --145941
[COMISIONES_FALTA_PAGO]         varchar(30), --145941
[IVA_COMISIONES]                varchar(30)  --145941
) 

go

/**************************************************************/
--- INGRESAR LA DATA ref.caso150202 - 152243
/**************************************************************/
use cob_conta_super
go

if object_id ('sb_info_gen_xml_refacturacion') is not null
    drop table sb_info_gen_xml_refacturacion
go

create table sb_info_gen_xml_refacturacion (
   id int identity (1, 1) not null,
   cliente_id int,
   buc varchar (30),
   banco varchar (30),
   interes_devengado_exigible money,
   monto_iva money,
   anio_facturacion char(4),
   mes_facturacion char(2),
   nombre_archivo varchar(255),
   procesado char(1),
   fecha_generacion_archivo datetime,
   timbrado char(1),
   orden int
)
 create clustered index sb_info_gen_xml_refacturacion_key
	on sb_info_gen_xml_refacturacion (id, buc, banco, anio_facturacion, mes_facturacion)
go

/**************************************************************/
--- INGRESAR FECHA A PROCESAR ref.caso150202
/**************************************************************/
if object_id ('sb_fecha_gen_xml_refacturacion') is not null
    drop table sb_fecha_gen_xml_refacturacion
go

create table sb_fecha_gen_xml_refacturacion(
    orden int PRIMARY KEY NOT NULL,
    fecha datetime,
	ingreso char(1),
	generacion char(1)
)
/**************************************************************/
--- PARA GENERAR LOS ARCHIVOS ref.caso150202
/**************************************************************/
if object_id ('sb_gen_xml_refacturacion') is not null
    drop table sb_gen_xml_refacturacion
go

create table sb_gen_xml_refacturacion(
   trama nvarchar(max)
)
go

IF OBJECT_ID ('sb_reporte_castigados') IS NOT NULL
	DROP table sb_reporte_castigados
go

create table sb_reporte_castigados(
ENTIDAD            						varchar(30) null,
CARTERA            						varchar(32) null,
SEGMENTO            					varchar(50) null,
SUCURSAL_O_CENTRO_DE_ALTA            	varchar(4) null,
CONTRATO            					varchar(16) null,
REGION            						varchar(30) null,
MONEDA            						varchar(3) null,
VALOR_DIVISA 							tinyint	null,
MES 									varchar(8) null,
FECHA_CONTABLE 							varchar(8) null,
FECHA_DE_OPERACION 						varchar(8) null,
BUC            							varchar(8) null,
NUM_CREDITO           					varchar(16) null,
NOMBRE            						varchar(80) null,
TOTAL_QUITAS							varchar(8) null,
TOTAL_CASTIGOS							varchar(8) null,
TOTAL_RECUPERACIONES_CONTABLE			varchar(8) null,
TOTAL_RECUPERACIONES_GESTION			varchar(8) null,
TOTAL_RECUPERACIONES_SECORSE			varchar(8) null,
TOTAL_GASTOS							varchar(8) null,
TOTAL_QUITAS_MO							varchar(8) null,
TOTAL_CASTIGOS_MO 						varchar(8) null,
PRODUCTO            					varchar(2) null,
SUBPRODUCTO            					varchar(4) null,
PAN_O_CUENTA            				varchar(16) null,
ORIGEN            						varchar(11) null,
OBSERVACIONES            				varchar(50) null,
FECHA_DE_CASTIGO 						varchar(8) null,
TIPO_DE_PAGO            				varchar(34) null,
GESTION_CONTABLE            			varchar(8) null,
IDENTIFICADOR_DE_OPERACION            	varchar(14) null,
DIAS_MOROSOS							smallint null,
BANDERA_BASILEA            				varchar(1) null,
desc_segmento_loc_1            			varchar(50) null,
desc_segmento_loc_2            			varchar(50) null,
desc_segmento_loc_3            			varchar(50) null,
desc_segmento_loc_4            			varchar(50) null,
desc_segmento_loc_5            			varchar(50) null,
FECHA_VENTA								varchar(8) null,
fecha_pago								varchar(8) null
)
go

use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_est_complemento_xml') IS NOT NULL
	DROP table dbo.sb_est_complemento_xml
go
create table cob_conta_super..sb_est_complemento_xml(
se_Rfc_emisor   	     varchar (100),    	--cual es el rfc
se_Nombre  			     varchar (100),	--si es un parametro
se_RegimenFiscal 	     varchar (100),
se_Rfc_receptor	     varchar (100), --si es el rfc del cliente
se_UsoCFDI 			     varchar (100),
se_ClaveProdServ 	     varchar (100), --parametro @w_clave_sat
se_Cantidad     	     varchar (100),
se_ClaveUnidad  	     varchar (100),
se_Descripcion  	     varchar (100),
se_ValorUnitario 	     varchar (100), --si es el Punitario del doc funcional 
se_Importe 			     varchar (100),--importe del cuerpo del doc funcional
se_Version			     varchar (100),--cual este este campo
se_FechaPago             varchar (100),--pagoFechaPago del doc funcional
se_FormaDePagoP          varchar (100),--pagoFormaDePagoP del doc funcional
se_MonedaP               varchar (100),
se_Monto                 varchar (100), --pagoMonto del doc funcional
se_RfcEmisorCtaOrd       varchar (100),--si es el rfc del cliente
se_IdDocumento           varchar (100), --pagoIdDocumento del doc funcio
se_Folio                 varchar (100), --FolioReferencia del doc
se_MonedaDR              varchar (100), 
se_MetodoDePagoDR        varchar (100), 
se_NumParcialidad        varchar (100),--pagoNumParcialidad
se_ImpSaldoAnt           varchar (100),--pagoImpSaldoAnt
se_ImpPagado             varchar (100),--pagoImpPagado
se_ImpSaldoInsoluto      varchar (100),--pagoImpSaldoInsoluto
se_banco                 varchar (100),
se_fecha                 varchar (100),
se_file_name             varchar (64),
se_id_ente               int,
se_estatus               char(1),
se_rfc_ente              varchar(30),
se_insert_date           datetime,
se_rx_tipo_operacion     varchar(10),
se_cuota_ini             int,
se_cuota_hasta           int,
se_folio_ref             varchar(50),
se_deuda_pagar           money,
se_sec_id                int,
se_tipo_compl            char(1),
se_fecha_afectacion    datetime 
)
go


IF OBJECT_ID ('dbo.sb_ns_estado_cuenta') IS NOT NULL
	DROP TABLE dbo.sb_ns_estado_cuenta
GO

CREATE TABLE dbo.sb_ns_estado_cuenta
	(
	nec_codigo             int identity(1,1) ,  --AQUI REEMPLAZAR EL MAXIMO +1 QUE SE ENCUENTRE EN LA HISTORICA 
	nec_banco              VARCHAR (15) NOT NULL,
	nec_fecha              DATETIME NOT NULL,
	nec_correo             VARCHAR (64) NOT NULL,
	nec_estado             CHAR (1) NOT NULL,
	in_cliente_rfc         VARCHAR (30) NULL,
	in_cliente_buc         VARCHAR (20) NULL,
	in_folio_fiscal        VARCHAR (60) NULL,
	in_certificado         VARCHAR (30) NULL,
	in_sello_digital       VARCHAR (1500) NULL,
	in_sello_sat           VARCHAR (1500) NULL,
	in_num_se_certificado  VARCHAR (30) NULL,
	in_fecha_certificacion DATETIME NULL,
	in_cadena_cer_dig_sat  VARCHAR (1500) NULL,
	in_nombre_archivo      VARCHAR (100) NULL,
	in_observacion         VARCHAR (300) NULL,
	in_fecha_procesamiento DATETIME NULL,
	in_fecha_xml           DATETIME NULL,
	in_rfc_emisor          VARCHAR (30) NULL,
	in_estd_timb           CHAR (1) NULL,
	in_monto_fac           VARCHAR (30) NULL,
	in_toperacion          VARCHAR (10) NULL,
	in_met_fact            VARCHAR (5) NULL ,
    in_estado_pdf          char(1) null,  
    in_estado_correo       char(1) null,
    in_nombre_pdf          varchar(200) null,
    in_estd_clv_co	       char(1),
    in_grupo               int,
    in_nombre_cli          varchar(255),
	in_cuota_desde         int,
    in_cuota_hasta         int,
    in_folio_ref           varchar(50),
    in_fecha_fin_mes       datetime	
 	
	)
GO

CREATE UNIQUE CLUSTERED INDEX sb_ns_estado_cuenta_Key
	ON dbo.sb_ns_estado_cuenta (nec_codigo)
GO

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_coutas_mes'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin

create index es_cu_banco_coutas_mes
on cob_conta_super..sb_ns_estado_cuenta (nec_banco,in_cuota_desde,in_cuota_hasta,nec_fecha,in_folio_ref)
	
end

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_mes'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin

create index es_cu_banco_mes
on cob_conta_super..sb_ns_estado_cuenta (nec_banco,nec_fecha)
	
end


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_coutas_folio_mes_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin

create index es_cu_banco_coutas_folio_mes_his
on cob_conta_super..sb_ns_estado_cuenta_hist (nec_banco_hist,in_cuota_desde_hist,in_cuota_hasta_hist,nec_fecha_hist,in_folio_ref_hist)
	
end

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin

create index es_cu_banco
on cob_conta_super..sb_ns_estado_cuenta (nec_banco)
	
end

update statistics cob_conta_super..sb_ns_estado_cuenta
go


IF OBJECT_ID ('dbo.sb_ns_estado_cuenta_hist') IS NOT NULL
	DROP table dbo.sb_ns_estado_cuenta_hist
go


create table dbo.sb_ns_estado_cuenta_hist
	(
	nec_codigo_hist             int,
	nec_banco_hist              varchar (15),
	nec_fecha_hist              datetime,
	nec_correo_hist             varchar (64),
	nec_estado_hist             char (1),
	in_cliente_rfc_hist         varchar (30),
	in_cliente_buc_hist         varchar (20),
	in_folio_fiscal_hist        varchar (60),
	in_certificado_hist         varchar (30),
	in_sello_digital_hist       varchar (1500),
	in_sello_sat_hist           varchar (1500),
	in_num_se_certificado_hist  varchar (30),
	in_cadena_cer_dig_sat_hist  varchar (1500),
	in_nombre_archivo_hist      varchar (100),
	in_observacion_hist         varchar (300),
	in_fecha_procesamiento_hist datetime,
	in_fecha_certificacion_hist datetime,
	in_fecha_xml_hist           datetime,
	in_estd_timb_hist           char(1),
	in_rfc_emisor_hist          varchar(30),
	in_monto_fac_hist           varchar(30),
	in_toperacion_hist          varchar(10), 
	in_met_fact_hist            varchar(5), 
	in_estado_pdf_hist          char(1),
    in_estado_correo_hist       char(1),
    in_nombre_pdf_hist          varchar (200),
    in_estd_clv_co_hist         char (1),
    in_grupo_hist               int,
    in_nombre_cli_hist          varchar(255),
    in_cuota_desde_hist         int,
    in_cuota_hasta_hist         int,
    in_folio_ref_hist           varchar(50),
    in_fecha_fin_mes_hist       datetime   	
	)
go

create unique clustered index sb_ns_estado_cuenta_his_Key
	on dbo.sb_ns_estado_cuenta_hist (nec_codigo_hist)
go

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_mes_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin

create index es_cu_banco_mes_his
on cob_conta_super..sb_ns_estado_cuenta_hist (nec_banco_hist,nec_fecha_hist)
	
end

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin

create index es_cu_banco_his
on cob_conta_super..sb_ns_estado_cuenta_hist (nec_banco_hist)
	
end

update statistics cob_conta_super..sb_ns_estado_cuenta_hist
go

use cob_conta_super
go

if OBJECT_ID('sb_secuenciales') is not null begin
   drop table sb_secuenciales
end

create table sb_secuenciales(
	ss_operacion  cuenta not null,
	ss_secuencial int not null
) 
go

create index idx_sb_secuenciales on sb_secuenciales (ss_operacion)

use cob_conta_super
go

if OBJECT_ID('sb_dato_xml_estado_cuenta') is not null begin
   drop table sb_dato_xml_estado_cuenta
end

create table sb_dato_xml_estado_cuenta(
   dxe_metodo_pago                     varchar(10),
   dxe_forma_pago                      varchar(10),
   ---------------------- Emisor - INI --------------------
   dxe_ri                              varchar(12),
   ---------------------- Receptor - INI --------------------
   dxe_ente                            int,
   dxe_rfc                             varchar(25),
   dxe_id_externo                      varchar(25),
   dxe_nombre                          varchar(254),
   dxe_telefono                        varchar(20),
   dxe_email                           varchar(25),
   dxe_cfdi_uso_cfdi                   varchar(3),
   dxe_residencia_fiscal               varchar(3),
   -- -------------------- Domicilio - INI --------------------
   -- @Ente
   dxe_calle                           varchar(250),
   dxe_no_exterior                     varchar(200),
   dxe_no_interior                     varchar(200),
   dxe_colonia_parroquia               varchar(250),
   dxe_localidad                       varchar(250),
   dxe_municipio_ciudad                varchar(100),
   dxe_estado_provincia                varchar(100),
   dxe_cod_pais                        varchar(100),
   dxe_codigo_postal                   varchar(80),
   -- -------------------- Encabezado - INI --------------------
   dxe_tipo_documento                  varchar(50),
   dxe_lugar_expedicion                varchar(100),
   dxe_fecha                           date,
   dxe_cfdi_metodo_pago                varchar(50),
   dxe_regimen_fiscal_emisor           varchar(3),
   dxe_moneda                          varchar(3),
   dxe_sub_total                       numeric(20,2),
   dxe_total                           numeric(20,2),
   dxe_cfdi_forma_pago                 varchar(2),
   -- -------------------- Encabezado - Cuerpo - INI --------------------
   dxe_renglon                         int,
   dxe_cantidad                        decimal(10),
   dxe_u_x0020_de_x0020_m              varchar(100),
   dxe_concepto                        varchar(1000),
   dxe_punitario                       numeric(20,2),
   dxe_importe                         numeric(20,2),
   dxe_cfdi_clave_prod_serv            varchar(10),
   dxe_cfdi_clave_unidad               varchar(30),
   dxe_codigo                          varchar(100),
   -- -------------------- Encabezado - Cuerpo - Traslado - INI --------------------
   dxe_codigo_multiple                 varchar(50),
   dxe_cfdi_base                       numeric(20,2),
   cfdi_impuesto                       varchar(3),
   dxe_cfdi_tipo_factor                varchar(10),
   dxe_cfdi_tasao_cuota                varchar(20),
   dxe_cfdi_importe                    numeric(20,2),
   -- -------------------- Encabezado - Impuestos - INI --------------------
   -- dxe_codigo_multiple                 varchar(50),
   dxe_total_impuestos_trasladados     numeric(20,2)
   -- -------------------- Encabezado - Impuestos - Traslado - INI --------------------
   -- dxe_codigo_multiple                 varchar(50),
   -- cfdi_impuesto                       varchar(3),
   -- dxe_cfdi_tipo_factor                varchar(10),
   -- dxe_cfdi_tasao_cuota                varchar(20),
   -- dxe_cfdi_importe                    numeric(20,2)
)

go

if OBJECT_ID('sb_est_cuenta_xml') is not null begin
   drop table sb_est_cuenta_xml
end

create table sb_est_cuenta_xml(
   ecx_fecha                           datetime          ,
   ecx_banco                           cuenta            ,
   ecx_tipo_operacion                  varchar(10)   null,
   ecx_secuencial                      int           null,
   ecx_ente                            int               ,             
   ecx_buc                             varchar(20)   null,
   ecx_metodo_pago                     varchar(10)   null,
   ecx_forma_pago                      varchar(10)   null,
   ---------------------- Emisor - INI --------------------
   ecx_ri                              varchar(12)   null,
   ---------------------- Receptor - INI --------------------
   ecx_rfc                             varchar(25)   null,
   ecx_id_externo                      varchar(25)   null,
   ecx_nombre                          varchar(254)  null,
   ecx_telefono                        varchar(20)   null,
   ecx_email                           varchar(100)  null,
   ecx_cfdi_uso_cfdi                   varchar(3)    null,
   ecx_residencia_fiscal               varchar(3)    null,
   -- -------------------- Domicilio - INI --------------------
   -- @Ente
   ecx_calle                           varchar(250)  null,
   ecx_no_exterior                     varchar(200)  null,
   ecx_no_interior                     varchar(200)  null,
   ecx_colonia_parroquia               varchar(250)  null,
   ecx_localidad                       varchar(250)  null,
   ecx_municipio_ciudad                varchar(100)  null,
   ecx_estado_provincia                varchar(100)  null,
   ecx_cod_pais                        varchar(100)  null,
   ecx_codigo_postal                   varchar(80)   null,
   -- -------------------- Encabezado - INI --------------------
   ecx_tipo_documento                  varchar(50)   null,
   ecx_lugar_expedicion                varchar(100)  null,
   ecx_cfdi_metodo_pago                varchar(50)   null,
   ecx_regimen_fiscal_emisor           varchar(3)    null,
   ecx_moneda                          varchar(3)    null,
   ecx_sub_total                       numeric(20,2) null,
   ecx_total                           numeric(20,2) null,
   ecx_cfdi_forma_pago                 varchar(2)    null,
   -- -------------------- Encabezado - Cuerpo - INI --------------------
   ecx_u_x0020_de_x0020_m              varchar(100)  null,
   -- -------------------- Encabezado - Cuerpo - Traslado - INI --------------------
   ecx_codigo_multiple                 varchar(50)   null,
   ecx_cfdi_base                       numeric(20,2) null,
   ecx_cfdi_impuesto                   varchar(3)    null,
   ecx_cfdi_tipo_factor                varchar(10)   null,
   ecx_cfdi_tasao_cuota                varchar(20)   null,
   ecx_cfdi_importe                    numeric(20,2) null,
   -- -------------------- Encabezado - Impuestos - INI --------------------
   ecx_total_impuestos_trasladados     numeric(20,2) null,
    -------------------- Encabezado - Impuestos - Traslado - INI --------------------
   ecx_codigo_multiple_impuesto         varchar(50),
   ecx_cuota_ini                       int           null,
   ecx_cuota_fin                       int           null,
   ecx_int                             numeric(20,2) null, 
   ecx_comision                        numeric(20,2) null,
   ecx_int_anticipado                  numeric(20,2) null,
   ecx_iva                             numeric(20,2) null,
   ecx_file                            varchar(100)  null,
   ecx_pago_complemento                numeric(20,2) null,
   ecx_int_pagado                      numeric(20,2) null,
   ecx_deuda_por_pagar                 numeric(20,2) null,
   ecx_sec_id                          int           null,
   ecx_comisiones_efec_mes             money         null
   
)
go

create index idx_sb_est_cuenta_xml on sb_est_cuenta_xml (ecx_fecha,ecx_banco, ecx_ente)

go

if OBJECT_ID('sb_est_rubro_ope') is not null begin
   drop table sb_est_rubro_ope
end


create table sb_est_rubro_ope(
   ero_fecha                           datetime          ,
   ero_tipo                            varchar(10)       ,
   ero_banco                           cuenta            ,   
   ero_concepto                        varchar(100)  null,
   ero_cuota                           numeric(20,2) null,
   ero_pagado                          numeric(20,2) null,
   ero_iva                             numeric(20,2) null,
   ero_cfdiClaveProdServ               varchar(10)   null,
   ero_cfdiClaveUnidad                 varchar(30)   null
   )


create index idx_sb_est_rubro_ope on sb_est_rubro_ope (ero_fecha,ero_banco)
go



use cob_conta_super
go

if object_id ('sb_factura_paquete') IS NOT NULL
	drop table sb_factura_paquete
go

create table sb_factura_paquete(
fp_fecha_registro datetime,
fp_archivo_zip    varchar(100),
fp_factura        varchar(100)
)

create nonclustered index  sb_factura_paquete_idx on sb_factura_paquete(fp_factura)

if object_id ('sb_complemento_paquete') IS NOT NULL
	drop table sb_complemento_paquete
go

create table sb_complemento_paquete(
cp_fecha_registro datetime,
cp_archivo_zip    varchar(100),
cp_complemento    varchar(100)
)

create nonclustered index  sb_complemento_paquete_idx on sb_complemento_paquete(cp_complemento)



IF object_id ('sb_log_factuacion') IS NOT NULL
	drop table sb_log_factuacion
go

create table sb_log_factuacion(
lf_secuencial     int identity,
ff_fecha          datetime,
lf_archivo        varchar(100),
lf_estado         char(1)
)

create nonclustered index sb_log_factuacion_idx on sb_log_factuacion(ff_fecha)

IF object_id ('sb_log_complemento') IS NOT NULL
	drop table sb_log_complemento
go

create table sb_log_complemento(
lc_secuencial     int identity,
lc_fecha          datetime,
lc_archivo        varchar(100),
lc_estado         char(1)
)

create nonclustered index sb_log_complemento_idx on sb_log_complemento(lc_fecha)
if OBJECT_ID('sb_valores_anticipados') is not null begin
   drop table sb_valores_anticipados
end

create table sb_valores_anticipados(
	va_operacion            cuenta not null,
	va_valor_anticipo       money,
    va_valor_iva_anticipo   money,
    va_valor_devengado      money,
    va_valor_iva_devengado  money)
go
create index idx_sb_valores_anticipados on sb_valores_anticipados (va_operacion)


if object_id ('dbo.sb_operacion') is not null
	drop table dbo.sb_operacion
go

create table dbo.sb_operacion
(  
op_fecha                   datetime not null,
op_operacion               int not null,
op_banco                   cuenta not null,
op_cliente                 int,
op_toperacion              catalogo not null,
op_aplicativo              tinyint not null
)
go

create nonclustered index  idx_sb_operacion on dbo.sb_operacion (op_cliente)
create nonclustered index  idx_sb_operacion_2 on dbo.sb_operacion (op_operacion)
go


use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_operacion_cancelada') IS NOT NULL
	DROP table dbo.sb_operacion_cancelada
go

create table dbo.sb_operacion_cancelada
	(
	CC                       smallint not null,
	CONTRATO                 varchar (24) not null,
	[ID GRUPO]               int not null,
	[NOMBRE GRUPO]           varchar (64) not null,                                          
	[CLIENTE COBIS]          int not null,
	[APELLIDO PATERNO]       varchar (64) not null,
	[APELLIDO MATERNO]       varchar (64) not null,
	NOMBRE1                  varchar (64) not null,                                                                                              
	[CICLO INDIVIDUAL]       int not null,
	[PRODUCTO DE PRESTAMOS]  varchar (40) not null,
	[DIAS MAX ATRASO ANT]    int not null,
	[DIAS MAX ATRASO ACT]    int not null,
	[DIAS MORA]              int not null,
	[NIVEL DE RIESGO]        char (1) not null
	)
go


/**************************************************************/
--- REPORTE DATOS MODIFICADOS req.123670
/**************************************************************/
use cob_conta_super
go

print 'CREACION TABLA: sb_reporte_mod_datos'
if object_id ('dbo.sb_reporte_mod_datos') is not null
	drop table dbo.sb_reporte_mod_datos
go

create table dbo.sb_reporte_mod_datos
(
	[FECHA DE MODIFICACION]          datetime     not null,
	REGION                           varchar(64)  not null,
	SUCURSAL                         varchar(64)  not null,
	[ID CLIENTE]                     int          not null,
	[NOMBRE COMPLETO CLIENTE]        varchar(255) not null,
	[NO. DE CREDITO]                 varchar(64)  not null,
	[USUARIO QUE MODIFICO]           varchar(14)  not null,
	[CAMPO QUE FUE MODIFICADO]       varchar(64)  not null,
	[DATO ANTERIOR]                  varchar(255) not null,
	[DATO NUEVO]                     varchar(255) not null,
	[CANAL DE MODIFICACION]          varchar(32)  not null,
	[ROL DE USUARIO QUE MODIFICO]    varchar(64)  not null
)
go

print 'CREACION INDEX: idx_cliente_mod_dat'
if exists (select name from sysindexes where name='idx_cliente_mod_dat')
    drop index sb_reporte_mod_datos.idx_cliente_mod_dat
go
    create NONCLUSTERED index idx_cliente_mod_dat on cob_conta_super..sb_reporte_mod_datos([ID CLIENTE])
go
print 'CREACION INDEX: idx_fecha_mod_dat'
if exists (select name from sysindexes where name='idx_fecha_mod_dat')
    drop index sb_reporte_mod_datos.idx_fecha_mod_dat
go
    create NONCLUSTERED index idx_fecha_mod_dat on cob_conta_super..sb_reporte_mod_datos([FECHA DE MODIFICACION])
go
print 'CREACION INDEX: idx_usuario_mod_dat'
if exists (select name from sysindexes where name='idx_usuario_mod_dat')
    drop index sb_reporte_mod_datos.idx_usuario_mod_dat
go
    create NONCLUSTERED index idx_usuario_mod_dat on cob_conta_super..sb_reporte_mod_datos([USUARIO QUE MODIFICO])
go


/**************************************************************/
--- REPORTE DATOS MODIFICADOS LINEA req.123670
/**************************************************************/ 
use cob_conta_super
go

print 'CREACION TABLA: sb_reporte_mod_datos_linea'
if object_id ('dbo.sb_reporte_mod_datos_linea') is not null
	drop table dbo.sb_reporte_mod_datos_linea
go

create table dbo.sb_reporte_mod_datos_linea
	(
	rm_cadena varchar (max)
	)
go



use cob_conta_super
go

if not object_id('sb_detalle_impuesto') is null
drop table sb_detalle_impuesto
go

create table sb_detalle_impuesto 
(
di_banco      varchar(24),
di_concepto   varchar(100),
di_base       numeric(10,2),
di_porcentaje float,
di_valor      numeric(20,2)
)

create index sb_detalle_impuesto_idx on sb_detalle_impuesto(di_banco, di_concepto)


if OBJECT_ID('sb_est_cuenta_xml_venc') is not null begin
   drop table sb_est_cuenta_xml_venc
end

create table sb_est_cuenta_xml_venc(
   ecx_fecha                           datetime          ,
   ecx_banco                           cuenta            ,
   ecx_tipo_operacion                  varchar(10)   null,
   ecx_secuencial                      int           null,
   ecx_ente                            int               ,             
   ecx_buc                             varchar(20)   null,
   ecx_metodo_pago                     varchar(10)   null,
   ecx_forma_pago                      varchar(10)   null,
   ---------------------- Emisor - INI --------------------
   ecx_ri                              varchar(12)   null,
   ---------------------- Receptor - INI --------------------
   ecx_rfc                             varchar(25)   null,
   ecx_id_externo                      varchar(25)   null,
   ecx_nombre                          varchar(254)  null,
   ecx_telefono                        varchar(20)   null,
   ecx_email                           varchar(100)  null,
   ecx_cfdi_uso_cfdi                   varchar(3)    null,
   ecx_residencia_fiscal               varchar(3)    null,
   -- -------------------- Domicilio - INI --------------------
   -- @Ente
   ecx_calle                           varchar(250)  null,
   ecx_no_exterior                     varchar(200)  null,
   ecx_no_interior                     varchar(200)  null,
   ecx_colonia_parroquia               varchar(250)  null,
   ecx_localidad                       varchar(250)  null,
   ecx_municipio_ciudad                varchar(100)  null,
   ecx_estado_provincia                varchar(100)  null,
   ecx_cod_pais                        varchar(100)  null,
   ecx_codigo_postal                   varchar(80)   null,
   -- -------------------- Encabezado - INI --------------------
   ecx_tipo_documento                  varchar(50)   null,
   ecx_lugar_expedicion                varchar(100)  null,
   ecx_cfdi_metodo_pago                varchar(50)   null,
   ecx_regimen_fiscal_emisor           varchar(3)    null,
   ecx_moneda                          varchar(3)    null,
   ecx_sub_total                       numeric(20,2) null,
   ecx_total                           numeric(20,2) null,
   ecx_cfdi_forma_pago                 varchar(2)    null,
   -- -------------------- Encabezado - Cuerpo - INI --------------------
   ecx_u_x0020_de_x0020_m              varchar(100)  null,
   -- -------------------- Encabezado - Cuerpo - Traslado - INI --------------------
   ecx_codigo_multiple                 varchar(50)   null,
   ecx_cfdi_base                       numeric(20,2) null,
   ecx_cfdi_impuesto                   varchar(3)    null,
   ecx_cfdi_tipo_factor                varchar(10)   null,
   ecx_cfdi_tasao_cuota                varchar(20)   null,
   ecx_cfdi_importe                    numeric(20,2) null,
   -- -------------------- Encabezado - Impuestos - INI --------------------
   ecx_total_impuestos_trasladados     numeric(20,2) null,
    -------------------- Encabezado - Impuestos - Traslado - INI --------------------
   ecx_codigo_multiple_impuesto         varchar(50),
   ecx_cuota_ini                       int           null,
   ecx_cuota_fin                       int           null,
   ecx_int                             numeric(20,2) null, 
   ecx_comision                        numeric(20,2) null,
   ecx_int_anticipado                  numeric(20,2) null,
   ecx_iva                             numeric(20,2) null,
   ecx_file                            varchar(100)  null,
   ecx_pago_complemento                numeric(20,2) null,
   ecx_int_pagado                      numeric(20,2) null,
   ecx_deuda_por_pagar                 numeric(20,2) null,
   ecx_sec_id                          int           null,
   ecx_comisiones_efec_mes             money         null
   
)
go

create index idx_sb_est_cuenta_xml_venc on sb_est_cuenta_xml_venc (ecx_fecha,ecx_banco, ecx_ente)

if OBJECT_ID('sb_est_rubro_ope_venc') is not null begin
   drop table sb_est_rubro_ope_venc
end

create table sb_est_rubro_ope_venc(
   ero_fecha                           datetime          ,
   ero_tipo                            varchar(10)       ,
   ero_banco                           cuenta            ,   
   ero_concepto                        varchar(100)  null,
   ero_cuota                           numeric(20,2) null,
   ero_pagado                          numeric(20,2) null,
   ero_iva                             numeric(20,2) null,
   ero_cfdiClaveProdServ               varchar(10)   null,
   ero_cfdiClaveUnidad                 varchar(30)   null
   )

create index idx_sb_est_rubro_ope on sb_est_rubro_ope_venc (ero_fecha,ero_banco)
go