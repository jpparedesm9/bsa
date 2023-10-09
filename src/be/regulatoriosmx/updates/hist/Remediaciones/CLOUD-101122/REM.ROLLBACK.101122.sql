
--Script ROLLBACK
--Disenado : Andy Gonzalez 
--Caso 101122

use cob_cartera 
go

if  exists (select 1
		from cob_cartera..sysobjects a, cob_cartera..syscolumns b
		where a.id = b.id
		and a.name = 'ca_corresponsal_det'
		and b.name = 'cd_secuencial')
alter table ca_corresponsal_det drop column cd_secuencial
go


if exists (select 1 from sysindexes 
           where name = 'ca_corresponsal_det_2')
   drop index ca_corresponsal_det_2 on ca_corresponsal_det
go
   
