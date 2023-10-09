/***********************************************************************************************************/

---Fecha					: 31/08/2016 
--Descripción               : script para la Historia 81552
--Descripción de la Solución: Proceso masivo de transacciones
--Autor						: Tania Baidal
/***********************************************************************************************************/


use cob_ahorros
go

--ah_table.sql

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
    tc_causa       int         null
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
    tr_cta_cobis     cuenta      null,
    tr_cta_mig       varchar(64) null,
    tr_monto_efe     money       null,
    tr_monto_chq     money       null,
    tr_fecha_carga   datetime    null,
    tr_causa         int         null,
	tr_estado        char(1),
	tr_num_ejecucion int not null
)
GO

CREATE TABLE ah_det_cheq_cm(
    dc_nom_archivo varchar(50) not null,
	dc_secuencial  int identity,
    dc_sec_dep     int         not null,
    dc_sec_chq     int         not null,
	dc_sec_chq_aux int         not null,
    dc_cod_ban     int         not null,
    dc_cuenta_chq  varchar(64) not null,
    dc_num_chq     int         not null,
    dc_monto       money       not null,
	dc_fecha_emi   datetime    not null,
    dc_fecha_carga datetime    not null,
	dc_estado      char(1),
	dc_num_ejecucion int       not null
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


--ah_dropp.sql
if exists (select 1 from sysindexes where name = 'ah_transacciones_cm_tmp_Key')
    drop index ah_transacciones_cm_tmp.ah_transacciones_cm_tmp_Key
go

if exists (select 1 from sysindexes where name = 'ah_det_cheq_cm_tmp_Key')
    drop index ah_det_cheq_cm_tmp.ah_det_cheq_cm_tmp_Key
go
 
if exists (select 1 from sysindexes where name = 'ah_transacciones_cm_Key')
    drop index ah_transacciones_cm.ah_transacciones_cm_Key
go

if exists (select 1 from sysindexes where name = 'ah_det_cheq_cm_Key')
    drop index ah_det_cheq_cm.ah_det_cheq_cm_Key
go

if exists (select 1 from sysindexes where name = 'ah_log_cm_tran_Key')
    drop index ah_log_cm_tran.ah_log_cm_tran_Key
go

--ah_pkey.sql
CREATE UNIQUE INDEX ah_transacciones_cm_tmp_Key 
    ON ah_transacciones_cm_tmp(tc_secuencial)
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

--ah_catlgo.sql

use cobis
go
/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('ah_transaccion_masiva')
  and codigo = cp_tabla
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('ah_transaccion_masiva')
   and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
 where cl_tabla.tabla in ('ah_transaccion_masiva')
go

declare @w_codigo smallint

select @w_codigo = max(codigo) + 1
from cl_tabla

print 'Tabla Transacciones de Carga masiva'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_transaccion_masiva', 'Tabla Transacciones de Carga masiva')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'DE', 'DEPOSITOS DE AHORROS SIN LIBRETA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'RE', 'RETIROS DE AHORROS SIN LIBRETA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'ND', 'NOTAS DE DEBITO DE AHORROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'NC', 'NOTAS DE CREDITO DE AHORROS', 'V')

select @w_codigo = @w_codigo + 1

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'

go

--ah_error.sql
delete cl_errores where numero in (357027,357028,357029,357030,357031,357032,357033,357034,357035,357036,357037,357038,357039,357040)
go

insert into cl_errores (numero, severidad, mensaje) values (357027, 0, 'TRANSACCION NO VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357028, 0, 'CUENTA COBIS Y CUENTA MIGRADA TIENEN VALORES NULOS')
insert into cl_errores (numero, severidad, mensaje) values (357029, 0, 'CUENTA MIGRADA NO ESTÁ RELACIONADA CON CUENTA COBIS')
insert into cl_errores (numero, severidad, mensaje) values (357030, 0, 'CHEQUE NO CORRESPONDE A TRANSACCION VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357031, 0, 'MONTO DE LA TRANSACCION ES CERO O NULO')
insert into cl_errores (numero, severidad, mensaje) values (357032, 0, 'VALOR DE CHEQUES NO COINCIDE CON LA SUMA DEL DETALLE DE CHEQUES')
insert into cl_errores (numero, severidad, mensaje) values (357033, 0, 'CAUSA ES MANDATORIA  PARA N/D Y N/C')
insert into cl_errores (numero, severidad, mensaje) values (357034, 0, 'MONTO EN CHEQUE NO ES VALIDO PARA LAS TRANSACCIONES: RETIRO, ND Y NC')
insert into cl_errores (numero, severidad, mensaje) values (357035, 0, 'ERROR AL INSERTAR EN EL LOG DE ERRORES')
insert into cl_errores (numero, severidad, mensaje) values (357036, 0, 'ERROR AL ACTUALIZAR ESTADO DE UNO O VARIOS REGISTROS')
insert into cl_errores (numero, severidad, mensaje) values (357037, 0, 'CODIGO DEL BANCO NO ES VALIDO')
insert into cl_errores (numero, severidad, mensaje) values (357038, 0, 'ERROR AL INSERTAR EL NUMERO DE CUENTA COBIS EN EL REGISTRO')
insert into cl_errores (numero, severidad, mensaje) values (357039, 0, 'FECHA DE EMISION NO VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357040, 0, 'CHEQUE REPETIDO')

go



/***********************************************************************************************************/

---Fecha					: 31/08/2016 
--Descripción               : script para pruebas de la Historia 81552
--Descripción de la Solución: script de inserción en la tabla ah_cuenta_aux para relacionar cuentas cobis con cuentas migradas
--                            inserción solo para pruebas, las cuentas se ingresan en esta tabla con otros procesos
--Autor						: Tania Baidal
/***********************************************************************************************************/

use cob_ahorros
go

delete from ah_cuenta_aux
where ca_cuenta in (13,11,20,17)
go

INSERT INTO ah_cuenta_aux (ca_cuenta, ca_cta_banco, ca_cta_banco_rel, ca_saldo_max, ca_dias_plazo, ca_cta_banco_mig, ca_fecha_mig)
VALUES (13, '702004000056', NULL, NULL, NULL, '20020030',NULL)
GO

INSERT INTO ah_cuenta_aux (ca_cuenta, ca_cta_banco, ca_cta_banco_rel, ca_saldo_max, ca_dias_plazo, ca_cta_banco_mig, ca_fecha_mig)
VALUES (11, '702004000031', NULL, NULL, NULL, '20020031',NULL)
GO

INSERT INTO ah_cuenta_aux (ca_cuenta, ca_cta_banco, ca_cta_banco_rel, ca_saldo_max, ca_dias_plazo, ca_cta_banco_mig, ca_fecha_mig)
VALUES (20, '702005000015', NULL, NULL, NULL, '10014101',NULL)
GO

INSERT INTO ah_cuenta_aux (ca_cuenta, ca_cta_banco, ca_cta_banco_rel, ca_saldo_max, ca_dias_plazo, ca_cta_banco_mig, ca_fecha_mig)
VALUES (17, '702006000013', NULL, NULL, NULL, '20030001',NULL)
GO

