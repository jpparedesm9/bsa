use cob_cartera 
go 

if exists (select 1 from sysindexes  where name = 'ca_transaccion_idx8')
   drop index ca_transaccion_idx8 on ca_transaccion
go