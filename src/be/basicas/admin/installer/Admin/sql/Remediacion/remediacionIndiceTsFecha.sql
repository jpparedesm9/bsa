/************************************************************************/
/*          MODIFICACIONES                                              */
/* 25/ABR/2016       ELO     Migracion SYBASE-SQLServer FAL             */

use cobis
go 

if exists (select name from sysindexes where name='its_fecha')
    DROP INDEX ad_tran_servicio.its_fecha
go


CREATE INDEX its_fecha ON ad_tran_servicio (
    ts_fecha)
go

sp_recompile ad_tran_servicio 
go

update statistics ad_tran_servicio 
go
