
--Script para crear un campo adicional en la ca_corresponsal_det
--Disenado : Andy Gonzalez 
--Caso 101122

use cob_cartera 
go

if not exists (select 1
		from cob_cartera..sysobjects a, cob_cartera..syscolumns b
		where a.id = b.id
		and a.name = 'ca_corresponsal_det'
		and b.name = 'cd_secuencial')
	alter table ca_corresponsal_det add cd_secuencial int
go


if exists (select 1 from sysindexes  where name = 'ca_corresponsal_det_2')
   drop index ca_corresponsal_det_2 on ca_corresponsal_det
go
   
create index ca_corresponsal_det_2 on ca_corresponsal_det (cd_secuencial)
go

update statistics ca_corresponsal_det
go