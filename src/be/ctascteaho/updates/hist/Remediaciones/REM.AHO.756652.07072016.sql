use cob_cuentas
go

if not exists (select * from systypes where name = 'cuenta')
   CREATE TYPE cuenta FROM varchar(24) NULL

go

