use cob_conta_super
go

if not exists (select 1 from sys.columns where Name = N'Exig_T17' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Exig_T17 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Pago_T17' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Pago_T17 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Exig_T17' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Exig_T17 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Pago_T17' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Pago_T17 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Exig_T18' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Exig_T18 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Pago_T18' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Pago_T18 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Exig_T18' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Exig_T18 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Pago_T18' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Pago_T18 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Exig_T19' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Exig_T19 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Pago_T19' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Pago_T19 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Exig_T19' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Exig_T19 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Pago_T19' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Pago_T19 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Exig_T20' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Exig_T20 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Pago_T20' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Pago_T20 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Exig_T20' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Exig_T20 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Pago_T20' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Pago_T20 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Exig_T21' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Exig_T21 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Pago_T21' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Pago_T21 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Exig_T21' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Exig_T21 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Pago_T21' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Pago_T21 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Exig_T22' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Exig_T22 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Pago_T22' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Pago_T22 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Exig_T22' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Exig_T22 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Pago_T22' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Pago_T22 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Exig_T23' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Exig_T23 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Pago_T23' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Pago_T23 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Exig_T23' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Exig_T23 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Pago_T23' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Pago_T23 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Exig_T24' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Exig_T24 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Pago_T24' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Pago_T24 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Exig_T24' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Exig_T24 varchar(20) null

if not exists (select 1 from sys.columns where Name = N'Fec_Pago_T24' and Object_ID = Object_ID(N'sb_riesgo_provision'))
alter table sb_riesgo_provision
add Fec_Pago_T24 varchar(20) null

--DROP COLUMNS
if exists (select 1 from sys.columns where Name = N'do_saldo_int_esp' and Object_ID = Object_ID(N'sb_dato_operacion_tmp'))
alter table sb_dato_operacion_tmp
drop column do_saldo_int_esp 

if exists (select 1 from sys.columns where Name = N'do_saldo_int_esp' and Object_ID = Object_ID(N'sb_dato_operacion'))
alter table sb_dato_operacion
drop column do_saldo_int_esp


if exists (select 1 from sys.columns where Name = N'saldo_int_esp' and Object_ID = Object_ID(N'sb_datos_rubros_tmp'))
alter table sb_datos_rubros_tmp
drop column saldo_int_esp 

if exists (select 1 from sys.columns where Name = N'saldo_int_esp_cas' and Object_ID = Object_ID(N'sb_datos_rubros_tmp'))
alter table sb_datos_rubros_tmp
drop column saldo_int_esp_cas 

use cob_externos
go

if exists (select 1 from sys.columns where Name = N'do_saldo_int_esp' and Object_ID = Object_ID(N'ex_dato_operacion'))
alter table ex_dato_operacion
drop column do_saldo_int_esp 

go