--->>>>>>>>>>>>>>>>>>>REQ#123670 Tabla para manejo de estados - solicitud modificacion datos
use cob_credito
go

print 'CREACION TABLA: cr_estados_sol_mod_dat'
if object_id ('dbo.cr_estados_sol_mod_dat') is not null
	drop table dbo.cr_estados_sol_mod_dat
go

create table dbo.cr_estados_sol_mod_dat (
    es_ente        int         null,
    es_estado_dir  char(1)     null,
	es_estado_mail char(1)     null,
	es_fecha       datetime    null
)
go

print 'CREACION INDEX: cr_estados_sol_mod_dat_Key'
if exists (select name from sysindexes where name='cr_estados_sol_mod_dat_Key')
    drop index cr_estados_sol_mod_dat.cr_estados_sol_mod_dat_Key
go
    create NONCLUSTERED index cr_estados_sol_mod_dat_Key on cob_credito..cr_estados_sol_mod_dat(es_ente)
go
