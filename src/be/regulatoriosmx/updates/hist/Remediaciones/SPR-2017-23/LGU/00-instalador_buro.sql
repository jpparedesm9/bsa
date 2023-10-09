use cob_conta_super
go


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
    [23] varchar(3)    NULL,
    [24] bigint           NULL,
    [25] varchar(255)  NULL,
    [26] varchar(255)  NULL,
    [30] varchar(6)    NULL,
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
bc_s_nombre	      varchar(31) null,
bc_fecha_nac	  varchar(13) null,
bc_en_rfc    	  varchar(18) null,
bc_pref_pers	  varchar(9)  null,
bc_suf_pers	      varchar(9)  null,
bc_nacionalidad   varchar(7)  null,
bc_tresidencia	  varchar(6)  null,
bc_lic_conducir   varchar(25) null,
bc_ecivil	      varchar(6)  null,
bc_sexo	          varchar(6)  null,
bc_seg_social	  varchar(25) null,
bc_reg_electoral  varchar(25) null,
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
   be_raz_social     varchar(104) null,
   be_pri_linea      varchar(60) null,
   be_seg_linea      varchar(60) null,
   be_colonia        varchar(60) null,
   be_delegacion     varchar(60) null,
   be_ciudad         varchar(60) null,
   be_estado         varchar(20) null,
   be_cod_postal     varchar(20) null,
   be_num_telf       varchar(30) null,
   be_ext_telf       varchar(30) null,
   be_num_fax        varchar(30) null,
   be_ocupacion      varchar(60) null,
   be_fecha_contra   varchar(20) null,
   be_moneda         varchar(20) null,
   be_sueldo         varchar(20) null,
   be_frec_pago      varchar(10) null,
   be_num_empl       varchar(20) null,
   be_ult_dia_empl   varchar(20) null,
   be_verif_empl     varchar(20) null,
   be_origen         varchar(20) null
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
   rf_limit_cred  varchar(2)   NULL,
   rf_saldo_venc  bigint       NULL,
   rf_num_pa_venc varchar(255) NULL,
   rf_for_pag_act varchar(255) NULL,
   rf_clave_obsr  varchar(2)   NULL
)

go

CREATE CLUSTERED INDEX sb_rpt_buro_frmt_act_parc_fk
	ON dbo.sb_rpt_buro_frmt_act_parc (rf_fecha_report,rf_operacion,rf_ente)
GO

---------------------------------------

USE cob_credito
GO


-- --------------------------------------------
if object_id ('dbo.cr_resultado_xml') is not null
    drop table dbo.cr_resultado_xml
go
create table cr_resultado_xml(linea xml)
go
/*
use cob_conta
go

delete cob_conta..cb_solicitud_reportes_reg
where sr_reporte IN ('BUROE','BUROM')
*/