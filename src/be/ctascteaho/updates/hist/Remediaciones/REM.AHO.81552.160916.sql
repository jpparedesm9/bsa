/***********************************************************************************************************/
---No historia  			: 81552
---Título del Bug			: Tablas creadas en base historica
---Fecha					: 16/Sep/2016 
--Descripción del Problema	: Las tablas de carga masiva fueron agregadas en la base cob_ahorros_his en el instalador
--Descripción de la Solución: se actualiza script de instalación y se envía a borrar las tablas de la base histórica y a crearlas en la base cob_ahorros
--Autor						: Tania Baidal
/***********************************************************************************************************/

--ah_table.sql
use cob_ahorros_his
go

print '=====> ah_transacciones_cm_tmp'
if exists (select * from sysobjects where name = 'ah_transacciones_cm_tmp') 
    drop table ah_transacciones_cm_tmp
go

print '=====>  ah_det_cheq_cm_tmp'
if exists (select * from sysobjects where name = 'ah_det_cheq_cm_tmp') 
    drop table ah_det_cheq_cm_tmp
go

print '=====>  ah_transacciones_cm'
if exists (select * from sysobjects where name = 'ah_transacciones_cm') 
    drop table ah_transacciones_cm
go

print '=====>  ah_det_cheq_cm'
if exists (select * from sysobjects where name = 'ah_det_cheq_cm') 
drop table ah_det_cheq_cm
go

print '=====>  ah_log_cm_tran'
if exists (select * from sysobjects where name = 'ah_log_cm_tran') 
drop table ah_log_cm_tran
go


use cob_ahorros
go

print '=====> ah_transacciones_cm_tmp'
if exists (select * from sysobjects where name = 'ah_transacciones_cm_tmp') 
    drop table ah_transacciones_cm_tmp
go

print '=====>  ah_det_cheq_cm_tmp'
if exists (select * from sysobjects where name = 'ah_det_cheq_cm_tmp') 
    drop table ah_det_cheq_cm_tmp
go

print '=====>  ah_transacciones_cm'
if exists (select * from sysobjects where name = 'ah_transacciones_cm') 
    drop table ah_transacciones_cm
go

print '=====>  ah_det_cheq_cm'
if exists (select * from sysobjects where name = 'ah_det_cheq_cm') 
drop table ah_det_cheq_cm
go

print '=====>  ah_log_cm_tran'
if exists (select * from sysobjects where name = 'ah_log_cm_tran') 
drop table ah_log_cm_tran
go

CREATE TABLE ah_transacciones_cm_tmp(
    tc_secuencial  int         not null,
    tc_transaccion varchar(10) not null,
    tc_cta_cobis   cuenta      null,
    tc_cta_mig     varchar(64) null,
    tc_monto_efe   money       null,
    tc_monto_chq   money       null,
    tc_fecha_carga datetime    null,
    tc_causa       int         null,
	tc_remesas     char(1)     null
)
GO

CREATE TABLE ah_det_cheq_cm_tmp(
    dc_sec_dep     int         not null,
    dc_sec_chq     int         not null,
    dc_cod_ban     int         not null,
    dc_cuenta_chq  varchar(64) not null,
    dc_num_chq     int         not null,
    dc_monto       money       not null,
	dc_fecha_emi   datetime    not null,
    dc_fecha_carga datetime    not null
)
GO

CREATE TABLE ah_transacciones_cm(
    tr_nom_archivo   varchar(50) not null,
	tr_secuencial    int         not null,
    tr_transaccion   varchar(10) not null,
    tr_cta_cobis     cuenta,
    tr_cta_mig       varchar(64),
    tr_monto_efe     money,
    tr_monto_chq     money,
    tr_fecha_carga   datetime,
    tr_causa         int,
	tr_estado        char(1),
	tr_num_ejecucion int         not null,
	tr_remesas       char(1),
	tr_total         money,
	tr_ssn_branch    int,
	tr_ofi           smallint,
	tr_moneda        smallint,
	tr_user          varchar(30),
	tr_term          varchar(10),
	tr_corr          char(1),
	tr_ssn_corr      int,
    tr_srv           varchar(30),
    tr_date          datetime,
    tr_rol           smallint,
    tr_org           char(1),
	tr_servicio      char(1)
)
GO

CREATE TABLE ah_det_cheq_cm(
    dc_nom_archivo    varchar(50)  not null,
	dc_secuencial     int identity,
    dc_sec_dep        int          not null,
    dc_sec_chq        int          not null,
	dc_sec_chq_aux    int          not null,
    dc_cod_ban        int          not null,
    dc_cuenta_chq     varchar(64)  not null,
    dc_num_chq        int          not null,
    dc_monto          money        not null,
	dc_fecha_emi      datetime     not null,
    dc_fecha_carga    datetime     not null,
	dc_estado         char(1),
	dc_num_ejecucion  int          not null,
	dc_ssn_branch_dep int,
	dc_ssn            int,
    dc_ssn_branch     int,
    dc_ofi            smallint,
    dc_user           varchar(30),
    dc_term           varchar(10),
    dc_corr           char(1),
    dc_ssn_corr       int,
    dc_srv            varchar(30),
    dc_date           datetime,
    dc_rol            smallint,
    dc_org            char(1),
	dc_servicio       char(1)
)
GO

CREATE TABLE ah_log_cm_tran(
    lc_nom_archivo   varchar(100) not null,   
	lc_ejecucion     int not null,
    lc_sec_tran      int not null,
	lc_sec_chq       int null,
	lc_ssn           int null,
    lc_num_error     int not null,
    lc_mensaje_error varchar(100) not null,
	lc_fecha         datetime
)
GO

CREATE UNIQUE INDEX ah_det_cheq_cm_tmp_Key 
    ON ah_det_cheq_cm_tmp(dc_sec_dep, dc_sec_chq)
GO

CREATE UNIQUE INDEX ah_transacciones_cm_Key 
    ON ah_transacciones_cm(tr_nom_archivo, tr_secuencial)
GO

CREATE UNIQUE INDEX ah_det_cheq_cm_Key 
    ON ah_det_cheq_cm(dc_nom_archivo,dc_sec_dep,dc_sec_chq)
GO

CREATE UNIQUE INDEX ah_log_cm_tran_Key 
    ON ah_log_cm_tran(lc_nom_archivo,lc_ejecucion,lc_sec_tran,lc_sec_chq, lc_num_error)
GO

