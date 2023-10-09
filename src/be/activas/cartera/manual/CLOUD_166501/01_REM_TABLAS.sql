use cob_cartera
go


--borrado de tabla
if object_id ('dbo.ca_lcr_socio_comercial_log') is not null
    drop table dbo.ca_lcr_socio_comercial_log
go

if exists (select name from sysindexes where name='idx_ca_lcr_socio_comercial_log_1')
    drop index ca_lcr_socio_comercial_log.idx_ca_lcr_socio_comercial_log_1
go

--tabla por borrar despues de ejecucion 
--select * from cob_cartera..ca_lcr_socio_comercial_log

go 
