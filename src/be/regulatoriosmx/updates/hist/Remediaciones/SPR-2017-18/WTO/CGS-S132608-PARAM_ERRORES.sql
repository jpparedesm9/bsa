/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S132608 Reporte de Buró. Parte II - Actualizaciones
--Descripción del Problema   : creacion de objetos, errores, parametros para la historia
--Responsable                : Walther Toledo
--Ruta TFS                   : En cada Seccion
--Nombre Archivo             : En cada Seccion
/*----------------------------------------------------------------------------------------------------------------*/
use cobis
go
-- ---------------------------------------PARAMETROS----------------------------------------
-- TFS: $/COB/Desarrollos/DEV_SaaSMX/RegulatoriosMX/BackEnd/sql/reg_parametria.sql
-- -----------------------------------------------------------------------------------------
delete from cl_parametro where pa_nemonico IN ('EXFCAP','RIEMIS','MNBRCD','NUBRCD') and pa_producto = 'REC'
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('EXTENSION FORMATO CORTO ACTUALIZACIONES PARCIALES','EXFCAP','C','ext','REC')
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('RPT CFDI ESTADO DE CUENTA - CAMPO RI EMISOR','RIEMIS','C','000000000000','REC')
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('RPT BURO CREDITO - MEMBER CODE','MNBRCD','C','SS10340001','REC')
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('RPT BURO CREDITO - NOMBRE USUARIO','NUBRCD','C','PRUEBA','REC')
go

-- ------------------------------------- ERRORES -----------------------------------------
-- $/COB/Desarrollos/DEV_SaaSMX/RegulatoriosMX/BackEnd/sql/reg_errores.sql
-- ---------------------------------------------------------------------------------------
delete cl_errores where numero = 70011015
insert into cl_errores values(70011015, 0, 'ERROR AL INSERTAR DE LA FECHA PROCESO EN LA TABLA SB_BURO_FC_FECHA_ULT_PROC- INTF FORMATO CORTO')

update cobis..ba_batch set ba_nombre = 'REPORTE ESTADO DE CUENTA CFDI' where ba_batch = 36008
-- ---------------------------------- SCRIPTS CREACION TABLAS --------------------------------------
-- $/COB/Desarrollos/DEV_SaaSMX/RegulatoriosMX/BackEnd/sql/reg_tabla.sql
-- -------------------------------------------------------------------------------------------------
use cob_conta_super
go
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
   rf_limit_cred  varchar(2)   NULL,
   rf_saldo_venc  bigint       NULL,
   rf_num_pa_venc varchar(255) NULL,
   rf_for_pag_act varchar(255) NULL,
   rf_clave_obsr  varchar(1)   NULL   
)
go

-- sb_reporte_buro_cuentas
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
    [23] varchar(2)    NULL,
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

-- SB_REPORTE_BURO_FINAL
if exists (select 1 from sysobjects where name = 'sb_reporte_buro_final' and type = 'U')
   drop table sb_reporte_buro_final
 go
CREATE TABLE sb_reporte_buro_final
(
   rb_id int IDENTITY (1, 1) NOT NULL,
   rb_cadena varchar(max) null --COLLATE Latin1_General_BIN NULL
)
go

-- ---------------------------------- SCRIPTS CREACION TABLAS --------------------------------------
-- -------------------------------------------------------------------------------------------------
use cob_credito
go
-- -------------
delete from cr_corresp_sib where tabla = 'ca_forma_pago_mop'
go
insert into cr_corresp_sib values('UR','ca_forma_pago_mop','UR','Cuenta si informacion',null,null,null,null)
insert into cr_corresp_sib values('00','ca_forma_pago_mop','00','Muy reciente para ser calificada',-1,-1,null,null)
insert into cr_corresp_sib values('01','ca_forma_pago_mop','01','Cuenta al corriente',0,0,null,null)
insert into cr_corresp_sib values('02','ca_forma_pago_mop','02','Cuenta con atraso de 1 a 29',1,29,null,null)
insert into cr_corresp_sib values('03','ca_forma_pago_mop','03','Cuenta con atraso de 30 a 59',30,59,null,null)
insert into cr_corresp_sib values('04','ca_forma_pago_mop','04','Cuenta con atraso de 60 a 89',60,89,null,null)
insert into cr_corresp_sib values('05','ca_forma_pago_mop','05','Cuenta con atraso de 90 a 119',90,119,null,null)
insert into cr_corresp_sib values('06','ca_forma_pago_mop','06','Cuenta con atraso de 120 a 149',120,149,null,null)
insert into cr_corresp_sib values('07','ca_forma_pago_mop','07','Cuenta con atraso de 150 días hasta 12 meses',150,360,null,null)
insert into cr_corresp_sib values('96','ca_forma_pago_mop','96','Cuenta con atraso de más de 12 meses',361,1000,null,null)
insert into cr_corresp_sib values('97','ca_forma_pago_mop','97','Cuenta con deuda parcial o total sin recuperar',1001,2000,null,null)
insert into cr_corresp_sib values('98','ca_forma_pago_mop','97','Fraude cometido por el Cliente',2001,10000,null,null)
go

-- --------------------------------------------------------
use cob_credito
go

exec('drop table cr_resultado_xml')
create table cr_resultado_xml(linea xml)