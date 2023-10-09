/***********************************************************************************************************/
--Fecha                     : 14/Sep/2016 
--Descripción               : script para la Historia 83168
--Descripción de la Solución: Sp cascara de depositos de ahorros con cheques
--Autor                     : Tania Baidal
/***********************************************************************************************************/


use cob_ahorros
go

--ah_table
print '=====>  ah_transacciones_cm'
if exists (select * from sysobjects where name = 'ah_transacciones_cm') 
    drop table ah_transacciones_cm
go

print '=====>  ah_det_cheq_cm'
if exists (select * from sysobjects where name = 'ah_det_cheq_cm') 
drop table ah_det_cheq_cm
go


CREATE TABLE ah_transacciones_cm(
    tr_nom_archivo   varchar(50) not null,
	tr_secuencial    int         not null,
    tr_transaccion   varchar(10) not null,
    tr_cta_cobis     cuenta      null,
    tr_cta_mig       varchar(64) null,
    tr_monto_efe     money       null,
    tr_monto_chq     money       null,
    tr_fecha_carga   datetime    null,
    tr_causa         int         null,
	tr_estado        char(1),
	
    tr_num_ejecucion int         not null,
	tr_remesas       char(1)     null,
	tr_total         money       null,
	tr_ssn_branch    int,
	tr_ofi           smallint,
	tr_moneda        smallint    null,
	tr_user          varchar(30),
	tr_term          varchar(10),
	tr_corr          char(1),
	tr_ssn_corr      int,
    tr_srv           varchar(30),
    tr_date          datetime,
    tr_rol           smallint,
    tr_org           char(1),
	tr_servicio      char(1)     null
)
GO


CREATE TABLE ah_det_cheq_cm(
    dc_nom_archivo     varchar(50) not null,
	dc_secuencial      int identity,
    dc_sec_dep         int         not null,
    dc_sec_chq         int         not null,
	dc_sec_chq_aux     int         not null,
    dc_cod_ban         int         not null,
    dc_cuenta_chq      varchar(64) not null,
    dc_num_chq         int         not null,
    dc_monto           money       not null,
	dc_fecha_emi       datetime    not null,
    dc_fecha_carga     datetime    not null,
	dc_estado          char(1),
	dc_num_ejecucion   int       not null,
	
	dc_ssn_branch_dep  int,
	dc_ssn             int,
    dc_ssn_branch      int,
    dc_ofi             smallint,
    dc_user            varchar(30),
    dc_term            varchar(10),
    dc_corr            char(1),
    dc_ssn_corr        int,
    dc_srv             varchar(30),
    dc_date            datetime,
    dc_rol             smallint,
    dc_org             char(1),
	dc_servicio        char(1)
)
GO


CREATE UNIQUE INDEX ah_transacciones_cm_Key 
    ON ah_transacciones_cm(tr_nom_archivo, tr_secuencial)
GO

CREATE UNIQUE INDEX ah_det_cheq_cm_Key 
    ON ah_det_cheq_cm(dc_nom_archivo,dc_sec_dep,dc_sec_chq)
GO


use cobis
go

--ah_error.sql
delete cl_errores where numero in (357031, 357043, 357044, 357045, 357046, 357047, 357048, 357049, 357050, 357051, 357052, 357053,357054)
go


insert into cl_errores (numero, severidad, mensaje) values (357043, 0, 'ERROR AL INSERTAR DATOS DE LA TRANSACCION')
insert into cl_errores (numero, severidad, mensaje) values (357044, 0, 'PARAMETRO TOTAL DE DEPOSITO NO COINCIDE CON SUMA DE VALORES ENVIADOS')
insert into cl_errores (numero, severidad, mensaje) values (357045, 0, 'PARAMETRO FECHA ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357046, 0, 'PARAMETRO FILIAL ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357047, 0, 'PARAMETRO SECUENCIAL Y SECUENCIAL BRANCH SON MANDATORIOS')
insert into cl_errores (numero, severidad, mensaje) values (357048, 0, 'NO EXISTEN CHEQUES VALIDOS PARA ESTA TRANSACCION')
insert into cl_errores (numero, severidad, mensaje) values (357049, 0, 'PARAMETRO SECUENCIAL DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357050, 0, 'PARAMETRO CODIGO DE BANCO DEL CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357051, 0, 'PARAMETRO CUENTA DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357052, 0, 'PARAMETRO NUMERO DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357053, 0, 'PARAMETRO FECHA DE EMISION DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357054, 0, 'NO EXISTE DEPOSITO CORRESPONDIENTE AL SECUENCIAL')
insert into cl_errores (numero, severidad, mensaje) values (357031, 0, 'VALOR DE LA TRANSACCION NO VALIDO')
go
