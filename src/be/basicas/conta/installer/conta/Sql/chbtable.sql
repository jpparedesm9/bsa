----------------- <BORRANDO TABLAS> -------------------
 
use cob_conta_his
go
 
set nocount on
go
 
print '--> Tabla: cb_hist_saldo'
if exists(select 1 from sysobjects where name = 'cb_hist_saldo')
   drop table cb_hist_saldo
go

