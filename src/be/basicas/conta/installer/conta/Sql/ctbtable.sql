----------------- <BORRANDO TABLAS> -------------------
 
use cob_conta_tercero
go
 
set nocount on
go
 
print '--> Tabla: ct_saldo_tercero'
if exists(select 1 from sysobjects where name = 'ct_saldo_tercero')
   drop table ct_saldo_tercero
go

