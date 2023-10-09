--->>>>>>>>>>>>>>>>>>>REQ#123670 Tabla para manejo de estados - solicitud modificacion datos
use cob_credito
go

print 'ELIMINACION TABLA: cr_estados_sol_mod_dat'
if object_id ('dbo.cr_estados_sol_mod_dat') is not null
	drop table dbo.cr_estados_sol_mod_dat
go

print 'ELIMINACION INDEX: cr_estados_sol_mod_dat_Key'
if exists (select name from sysindexes where name='cr_estados_sol_mod_dat_Key')
    drop index cr_estados_sol_mod_dat.cr_estados_sol_mod_dat_Key
go

go
